if not modules then modules = { } end modules ['font-nms'] = {
    version   = 1.002,
    comment   = "companion to luaotfload.lua",
    author    = "Khaled Hosny and Elie Roux",
    copyright = "Luaotfload Development Team",
    license   = "GNU GPL v2"
}

fonts                = fonts       or { }
fonts.names          = fonts.names or { }

local names          = fonts.names
local names_dir      = "luatex-cache/generic/names"
names.version        = 2.009 -- not the same as in context
names.data           = nil
names.path           = {
    basename  = "otfl-names.lua",
    localdir  = file.join(kpse.expand_var("$TEXMFVAR"), names_dir),
    systemdir = file.join(kpse.expand_var("$TEXMFSYSVAR"), names_dir),
}


local splitpath, expandpath = file.split_path, kpse.expand_path
local glob, basename        = dir.glob, file.basename
local upper, lower, format  = string.upper, string.lower, string.format
local gsub, match, rpadd    = string.gsub, string.match, string.rpadd
local gmatch, sub, find     = string.gmatch, string.sub, string.find
local utfgsub               = unicode.utf8.gsub

local trace_short    = false --tracing adapted to rebuilding of the database inside a document
local trace_search   = false --trackers.register("names.search",   function(v) trace_search   = v end)
local trace_loading  = false --trackers.register("names.loading",  function(v) trace_loading  = v end)

local function sanitize(str)
    if str then
        return utfgsub(lower(str), "[^%a%d]", "")
    else
        return str -- nil
    end
end

local function fontnames_init()
    return {
        mappings  = { },
        status    = { },
        version   = names.version,
    }
end

local function load_names()
    local localpath  = file.join(names.path.localdir, names.path.basename)
    local systempath = file.join(names.path.systemdir, names.path.basename)
    local kpsefound  = kpse.find_file(names.path.basename)
    local foundname
    local data
    if kpsefound and file.isreadable(kpsefound) then
        data = dofile(kpsefound)
	foundname = kpsefound
    elseif file.isreadable(localpath)  then
        data = dofile(localpath)
	foundname = localpath
    elseif file.isreadable(systempath) then
        data = dofile(systempath)
	foundname = systempath
    end
    if data then
        logs.info("Font names database loaded: " .. foundname)
    else
        logs.info([[Font names database not found, generating new one.
             This can take several minutes; please be patient.]])
        data = names.update(fontnames_init())
        names.save(data)
    end
    return data
end

local synonyms = {
    regular    = { "normal", "roman", "plain", "book", "medium" },
    bold       = { "boldregular", "demi", "demibold" },
    italic     = { "regularitalic", "normalitalic", "oblique", "slanted" },
    bolditalic = { "boldoblique", "boldslanted", "demiitalic", "demioblique", "demislanted", "demibolditalic" },
}

local loaded   = false
local reloaded = false

function names.resolve(specification)
    local name  = sanitize(specification.name)
    local style = sanitize(specification.style) or "regular"

    local size
    if specification.optsize then
        size = tonumber(specification.optsize)
    elseif specification.size then
        size = specification.size / 65536
    end


    if not loaded then
        names.data = names.load()
        loaded     = true
    end

    local data = names.data
    if type(data) == "table" and data.version == names.version then
        if data.mappings then
            local found = { }
            for _,face in next, data.mappings do
                local family    = sanitize(face.names.family)
                local subfamily = sanitize(face.names.subfamily)
                local fullname  = sanitize(face.names.fullname)
                local psname    = sanitize(face.names.psname)
                local fontname  = sanitize(face.fontname)
                local pfullname = sanitize(face.fullname)
                local optsize, dsnsize, maxsize, minsize
                if #face.size > 0 then
                    optsize = face.size
                    dsnsize = optsize[1] and optsize[1] / 10
                    -- can be nil
                    maxsize = optsize[2] and optsize[2] / 10 or dsnsize
                    minsize = optsize[3] and optsize[3] / 10 or dsnsize
                end
                if name == family then
                    if subfamily == style then
                        if optsize then
                            if dsnsize == size
                            or (size > minsize and size <= maxsize) then
                                found[1] = face
                                break
                            else
                                found[#found+1] = face
                            end
                        else
                            found[1] = face
                            break
                        end
                    elseif synonyms[style] and
                           table.contains(synonyms[style], subfamily) then
                        if optsize then
                            if dsnsize == size
                            or (size > minsize and size <= maxsize) then
                                found[1] = face
                                break
                            else
                                found[#found+1] = face
                            end
                        else
                            found[1] = face
                            break
                        end
                    elseif subfamily == "regular" or
                           table.contains(synonyms.regular, subfamily) then
                        found.fallback = face
                    end
                else
                    if name == fullname
                    or name == pfullname
                    or name == fontname
                    or name == psname then
                        if optsize then
                            if dsnsize == size
                            or (size > minsize and size <= maxsize) then
                                found[1] = face
                                break
                            else
                                found[#found+1] = face
                            end
                        else
                            found[1] = face
                            break
                        end
                    end
                end
            end
            if #found == 1 then
                if kpse.lookup(found[1].filename[1]) then
                    logs.report("load font",
                                "font family='%s', subfamily='%s' found: %s",
                                name, style, found[1].filename[1])
                    return found[1].filename[1], found[1].filename[2]
                end
            elseif #found > 1 then
                -- we found matching font(s) but not in the requested optical
                -- sizes, so we loop through the matches to find the one with
                -- least difference from the requested size.
                local closest
                local least = math.huge -- initial value is infinity
                for i,face in next, found do
                    local dsnsize    = face.size[1]/10
                    local difference = math.abs(dsnsize-size)
                    if difference < least then
                        closest = face
                        least   = difference
                    end
                end
                if kpse.lookup(closest.filename[1]) then
                    logs.report("load font",
                                "font family='%s', subfamily='%s' found: %s",
                                name, style, closest.filename[1])
                    return closest.filename[1], closest.filename[2]
                end
            elseif found.fallback then
                return found.fallback.filename[1], found.fallback.filename[2]
            end
            -- no font found so far
            if not reloaded then
                -- try reloading the database
                names.data = names.update(names.data)
                names.save(names.data)
                reloaded   = true
                return names.resolve(specification)
            else
                -- else, fallback to filename
                return specification.name, false
            end
        end
    else
        if not reloaded then
            names.data = names.update()
            names.save(names.data)
            reloaded   = true
            return names.resolve(specification)
        else
            return specification.name, false
        end
    end
end

names.resolvespec = names.resolve

function names.set_log_level(level)
    if level == 2 then
        trace_loading = true
    elseif level >= 3 then
        trace_loading = true
        trace_search = true
    end
end

local lastislog = 0

local function log(fmt, ...)
    lastislog = 1
    texio.write_nl(format("luaotfload | %s", format(fmt,...)))
    io.flush()
end

logs        = logs or { }
logs.report = logs.report or log
logs.info   = logs.info or log

local function font_fullinfo(filename, subfont, texmf)
    local t = { }
    local f = fontloader.open(filename, subfont)
    if not f then
	    if trace_loading then
        	logs.report("error: failed to open %s", filename)
	    end
        return
    end
    local m = fontloader.to_table(f)
    fontloader.close(f)
    collectgarbage('collect')
    -- see http://www.microsoft.com/typography/OTSPEC/features_pt.htm#size
    if m.fontstyle_name then
        for _,v in next, m.fontstyle_name do
            if v.lang == 1033 then
                t.fontstyle_name = v.name
            end
        end
    end
    if m.names then
        for _,v in next, m.names do
            if v.lang == "English (US)" then
                t.names = {
                    -- see
                    -- http://developer.apple.com/textfonts/
                    -- TTRefMan/RM06/Chap6name.html
                    fullname = v.names.compatfull     or v.names.fullname,
                    family   = v.names.preffamilyname or v.names.family,
                    subfamily= t.fontstyle_name       or v.names.prefmodifiers  or v.names.subfamily,
                    psname   = v.names.postscriptname
                }
            end
        end
    else
        -- no names table, propably a broken font
        if trace_loading then
            logs.report("broken font rejected: %s", basefile)
        end
        return
    end
    t.fontname    = m.fontname
    t.fullname    = m.fullname
    t.familyname  = m.familyname
    t.filename    = { texmf and basename(filename) or filename, subfont }
    t.weight      = m.pfminfo.weight
    t.width       = m.pfminfo.width
    t.slant       = m.italicangle
    -- don't waste the space with zero values
    t.size = {
        m.design_size         ~= 0 and m.design_size         or nil,
        m.design_range_top    ~= 0 and m.design_range_top    or nil,
        m.design_range_bottom ~= 0 and m.design_range_bottom or nil,
    }
    return t
end

local function load_font(filename, fontnames, newfontnames, texmf)
    local newmappings = newfontnames.mappings
    local newstatus   = newfontnames.status
    local mappings    = fontnames.mappings
    local status      = fontnames.status
    local basefile    = texmf and basename(filename) or filename
    if filename then
        if table.contains(names.blacklist, filename) or
           table.contains(names.blacklist, basename(filename)) then
            if trace_search then
                logs.report("ignoring font '%s'", filename)
            end
            return
        end
        local timestamp, db_timestamp
        db_timestamp        = status[basefile] and status[basefile].timestamp
        timestamp           = lfs.attributes(filename, "modification")

        local index_status = newstatus[basefile] or (not texmf and newstatus[basename(filename)])
        if index_status and index_status.timestamp == timestamp then
            -- already indexed this run
            return
        end

        newstatus[basefile] = newstatus[basefile] or { }
        newstatus[basefile].timestamp = timestamp
        newstatus[basefile].index     = newstatus[basefile].index or { }

        if db_timestamp == timestamp and not newstatus[basefile].index[1] then
            for _,v in next, status[basefile].index do
                local index = #newstatus[basefile].index
                newmappings[#newmappings+1]        = mappings[v]
                newstatus[basefile].index[index+1] = #newmappings
            end
            if trace_loading then
                logs.report("font already indexed: %s", basefile)
            end
            return
        end
        local info = fontloader.info(filename)
        if info then
            if type(info) == "table" and #info > 1 then
                for i in next, info do
                    local fullinfo = font_fullinfo(filename, i-1, texmf)
                    if not fullinfo then
                        return
                    end
                    local index = newstatus[basefile].index[i]
                    if newstatus[basefile].index[i] then
                        index = newstatus[basefile].index[i]
                    else
                        index = #newmappings+1
                    end
                    newmappings[index]           = fullinfo
                    newstatus[basefile].index[i] = index
                end
            else
                local fullinfo = font_fullinfo(filename, false, texmf)
                if not fullinfo then
                    return
                end
                local index
                if newstatus[basefile].index[1] then
                    index = newstatus[basefile].index[1]
                else
                    index = #newmappings+1
                end
                newmappings[index]           = fullinfo
                newstatus[basefile].index[1] = index
            end
        else
            if trace_loading then
               logs.report("failed to load %s", basefile)
            end
        end
    end
end

local function path_normalize(path)
    --[[
        path normalization:
        - a\b\c  -> a/b/c
        - a/../b -> b
        - /cygdrive/a/b -> a:/b
        - reading symlinks under non-Win32
        - using kpse.readable_file on Win32
    ]]
    if os.type == "windows" or os.type == "msdos" or os.name == "cygwin" then
        path = path:gsub('\\', '/')
        path = path:lower()
        path = path:gsub('^/cygdrive/(%a)/', '%1:/')
    end
    if os.type ~= "windows" and os.type ~= "msdos" then
        local dest = lfs.readlink(path)
        if dest then
            if kpse.readable_file(dest) then
                path = dest
            elseif kpse.readable_file(file.join(file.dirname(path), dest)) then
                path = file.join(file.dirname(path), dest)
            else
                -- broken symlink?
            end
        end
    end
    path = file.collapse_path(path)
    return path
end

fonts.path_normalize = path_normalize

names.blacklist = { }

local function read_blacklist()
    local files = {
        kpse.lookup("otfl-blacklist.cnf", {all=true, format="tex"})
    }
    local blacklist = names.blacklist

    if files and type(files) == "table" then
        for _,v in next, files do
            for line in io.lines(v) do
                line = line:strip() -- to get rid of lines like " % foo"
                if line:find("^%%") or line:is_empty() then
                    -- comment or empty line
                else
                    line = line:split("%")[1]
                    line = line:strip()
                    if trace_search then
                        logs.report("blacklisted file: %s", line)
                    end
                    blacklist[#blacklist+1] = line
                end
            end
        end
    end
end

local font_extensions = { "otf", "ttf", "ttc", "dfont" }

local function scan_dir(dirname, fontnames, newfontnames, texmf)
    --[[
    This function scans a directory and populates the list of fonts
    with all the fonts it finds.
    - dirname is the name of the directory to scan
    - names is the font database to fill
    - texmf is a boolean saying if we are scanning a texmf directory
    ]]
    local list, found = { }, { }
    local nbfound = 0
    if trace_search then
        logs.report("scanning '%s'", dirname)
    end
    for _,i in next, font_extensions do
        for _,ext in next, { i, upper(i) } do
            found = glob(format("%s/**.%s$", dirname, ext))
            -- note that glob fails silently on broken symlinks, which happens
            -- sometimes in TeX Live.
            if trace_search then
                logs.report("%s '%s' fonts found", #found, ext)
            end
            nbfound = nbfound + #found
            table.append(list, found)
        end
    end
    if trace_search then
        logs.report("%d fonts found in '%s'", nbfound, dirname)
    end

    for _,file in next, list do
        file = path_normalize(file)
        if trace_loading then
            logs.report("loading font: %s", file)
        end
        load_font(file, fontnames, newfontnames, texmf)
    end
end

local function scan_texmf_fonts(fontnames, newfontnames)
    --[[
    This function scans all fonts in the texmf tree, through kpathsea
    variables OPENTYPEFONTS and TTFONTS of texmf.cnf
    ]]
    if expandpath("$OSFONTDIR"):is_empty() then
        logs.info("Scanning TEXMF fonts...")
    else
        logs.info("Scanning TEXMF and OS fonts...")
    end
    local fontdirs = expandpath("$OPENTYPEFONTS"):gsub("^\.", "")
    fontdirs = fontdirs .. expandpath("$TTFONTS"):gsub("^\.", "")
    if not fontdirs:is_empty() then
        for _,d in next, splitpath(fontdirs) do
            scan_dir(d, fontnames, newfontnames, true)
        end
    end
end

--[[
  For the OS fonts, there are several options:
   - if OSFONTDIR is set (which is the case under windows by default but
     not on the other OSs), it scans it at the same time as the texmf tree,
     in the scan_texmf_fonts.
   - if not:
     - under Windows and Mac OSX, we take a look at some hardcoded directories
     - under Unix, we read /etc/fonts/fonts.conf and read the directories in it

  This means that if you have fonts in fancy directories, you need to set them
  in OSFONTDIR.
]]

local function read_fonts_conf(path, results)
    --[[
    This function parses /etc/fonts/fonts.conf and returns all the dir it finds.
    The code is minimal, please report any error it may generate.
    ]]
    local f = io.open(path)
    if not f then
        error("Cannot open the file "..path)
    end
    local incomments = false
    for line in f:lines() do
        while line and line ~= "" do
            -- spaghetti code... hmmm...
            if incomments then
                local tmp = find(line, '-->')
                if tmp then
                    incomments = false
                    line = sub(line, tmp+3)
                else
                    line = nil
                end
            else
                local tmp = find(line, '<!--')
                local newline = line
                if tmp then
                    -- for the analysis, we take everything that is before the
                    -- comment sign
                    newline = sub(line, 1, tmp-1)
                    -- and we loop again with the comment
                    incomments = true
                    line = sub(line, tmp+4)
                else
                    -- if there is no comment start, the block after that will
                    -- end the analysis, we exit the while loop
                    line = nil
                end
                for dir in gmatch(newline, '<dir>([^<]+)</dir>') do
                    -- now we need to replace ~ by kpse.expand_path('~')
                    if sub(dir, 1, 1) == '~' then
                        dir = file.join(kpse.expand_path('~'), sub(dir, 2))
                    end
                    -- we exclude paths with texmf in them, as they should be
                    -- found anyway
                    if not find(dir, 'texmf') then
                        results[#results+1] = dir
                    end
                end
                for include in gmatch(newline, '<include[^<]*>([^<]+)</include>') do
                    -- include here can be four things: a directory or a file,
                    -- in absolute or relative path.
                    if sub(include, 1, 1) == '~' then
                        include = file.join(kpse.expand_path('~'),sub(include, 2))
                        -- First if the path is relative, we make it absolute:
                    elseif not lfs.isfile(include) and not lfs.isdir(include) then
                        include = file.join(file.dirname(path), include)
                    end
                    if lfs.isfile(include) then
                        -- maybe we should prevent loops here?
                        -- we exclude path with texmf in them, as they should
                        -- be found otherwise
                        read_fonts_conf(include, results)
                    elseif lfs.isdir(include) then
                        for _,f in next, glob(file.join(include, "*.conf")) do
                            read_fonts_conf(f, results)
                        end
                    end
                end
            end
        end
    end
    f:close()
    return results
end

-- for testing purpose
names.read_fonts_conf = read_fonts_conf

local function get_os_dirs()
    if os.name == 'macosx' then
        return {
            file.join(kpse.expand_path('~'), "Library/Fonts"),
            "/Library/Fonts",
            "/System/Library/Fonts",
            "/Network/Library/Fonts",
        }
    elseif os.type == "windows" or os.type == "msdos" or os.name == "cygwin" then
        local windir = os.getenv("WINDIR")
        return { file.join(windir, 'Fonts') }
    else
        return read_fonts_conf("/etc/fonts/fonts.conf", {})
    end
end

local function scan_os_fonts(fontnames, newfontnames)
    --[[
    This function scans the OS fonts through
      - fontcache for Unix (reads the fonts.conf file and scans the directories)
      - a static set of directories for Windows and MacOSX
    ]]
    logs.info("Scanning OS fonts...")
    if trace_search then
        logs.info("Searching in static system directories...")
    end
    for _,d in next, get_os_dirs() do
        scan_dir(d, fontnames, newfontnames, false)
    end
end

local function update_names(fontnames, force)
    --[[
    The main function, scans everything
    - fontnames is the final table to return
    - force is whether we rebuild it from scratch or not
    ]]
    logs.info("Updating the font names database:")

    if force then
        fontnames = fontnames_init()
    else
        if not fontnames then
            fontnames = names.load()
        end
        if fontnames.version ~= names.version then
            fontnames = fontnames_init()
            if trace_search then
                logs.report("No font names database or old one found; "
                          .."generating new one")
            end
        end
    end
    local newfontnames = fontnames_init()
    read_blacklist()
    scan_texmf_fonts(fontnames, newfontnames)
    if expandpath("$OSFONTDIR"):is_empty() then
        scan_os_fonts(fontnames, newfontnames)
    end
    return newfontnames
end

local function save_names(fontnames)
    local savepath  = names.path.localdir
    if not lfs.isdir(savepath) then
        dir.mkdirs(savepath)
    end
    savepath = file.join(savepath, names.path.basename)
    if file.iswritable(savepath) then
        table.tofile(savepath, fontnames, true)
        logs.info("Font names database saved: %s \n", savepath)
        return savepath
    else
        logs.info("Failed to save names database\n")
        return nil
    end
end

local function scan_external_dir(dir)
    local old_names, new_names
    if loaded then
        old_names = names.data
    else
        old_names = names.load()
        loaded    = true
    end
    new_names = table.copy(old_names)
    scan_dir(dir, old_names, new_names)
    names.data = new_names
end

names.scan   = scan_external_dir
names.load   = load_names
names.update = update_names
names.save   = save_names
