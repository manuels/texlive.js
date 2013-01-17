if not modules then modules = { } end modules ['font-map'] = {
    version   = 1.001,
    comment   = "companion to font-ini.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local utf = unicode.utf8
local match, format, find, concat, gsub, lower = string.match, string.format, string.find, table.concat, string.gsub, string.lower
local lpegmatch = lpeg.match
local utfbyte = utf.byte

local trace_loading    = false  trackers.register("otf.loading",    function(v) trace_loading    = v end)
local trace_unimapping = false  trackers.register("otf.unimapping", function(v) trace_unimapping = v end)

local ctxcatcodes = tex and tex.ctxcatcodes

--[[ldx--
<p>Eventually this code will disappear because map files are kind
of obsolete. Some code may move to runtime or auxiliary modules.</p>
<p>The name to unciode related code will stay of course.</p>
--ldx]]--

fonts     = fonts     or { }
fonts.map = fonts.map or { }

local function load_lum_table(filename) -- will move to font goodies
    local lumname = file.replacesuffix(file.basename(filename),"lum")
    local lumfile = resolvers.find_file(lumname,"map") or ""
    if lumfile ~= "" and lfs.isfile(lumfile) then
        if trace_loading or trace_unimapping then
            logs.report("load otf","enhance: loading %s ",lumfile)
        end
        lumunic = dofile(lumfile)
        return lumunic, lumfile
    end
end

local hex     = lpeg.R("AF","09")
local hexfour = (hex*hex*hex*hex) / function(s) return tonumber(s,16) end
local hexsix  = (hex^1)           / function(s) return tonumber(s,16) end
local dec     = (lpeg.R("09")^1)  / tonumber
local period  = lpeg.P(".")

local unicode = lpeg.P("uni")   * (hexfour * (period + lpeg.P(-1)) * lpeg.Cc(false) + lpeg.Ct(hexfour^1) * lpeg.Cc(true))
local ucode   = lpeg.P("u")     * (hexsix  * (period + lpeg.P(-1)) * lpeg.Cc(false) + lpeg.Ct(hexsix ^1) * lpeg.Cc(true))
local index   = lpeg.P("index") * dec * lpeg.Cc(false)

local parser  = unicode + ucode + index

local parsers = { }

local function make_name_parser(str)
    if not str or str == "" then
        return parser
    else
        local p = parsers[str]
        if not p then
            p = lpeg.P(str) * period * dec * lpeg.Cc(false)
            parsers[str] = p
        end
        return p
    end
end

--~ local parser = fonts.map.make_name_parser("Japan1")
--~ local parser = fonts.map.make_name_parser()
--~ local function test(str)
--~     local b, a = lpegmatch(parser,str)
--~     print((a and table.serialize(b)) or b)
--~ end
--~ test("a.sc")
--~ test("a")
--~ test("uni1234")
--~ test("uni1234.xx")
--~ test("uni12349876")
--~ test("index1234")
--~ test("Japan1.123")

local function tounicode16(unicode)
    if unicode < 0x10000 then
        return format("%04X",unicode)
    else
        return format("%04X%04X",unicode/1024+0xD800,unicode%1024+0xDC00)
    end
end

local function tounicode16sequence(unicodes)
    local t = { }
    for l=1,#unicodes do
        local unicode = unicodes[l]
        if unicode < 0x10000 then
            t[l] = format("%04X",unicode)
        else
            t[l] = format("%04X%04X",unicode/1024+0xD800,unicode%1024+0xDC00)
        end
    end
    return concat(t)
end

--~ This is quite a bit faster but at the cost of some memory but if we
--~ do this we will also use it elsewhere so let's not follow this route
--~ now. I might use this method in the plain variant (no caching there)
--~ but then I need a flag that distinguishes between code branches.
--~
--~ local cache = { }
--~
--~ function fonts.map.tounicode16(unicode)
--~     local s = cache[unicode]
--~     if not s then
--~         if unicode < 0x10000 then
--~             s = format("%04X",unicode)
--~         else
--~             s = format("%04X%04X",unicode/1024+0xD800,unicode%1024+0xDC00)
--~         end
--~         cache[unicode] = s
--~     end
--~     return s
--~ end

fonts.map.load_lum_table      = load_lum_table
fonts.map.make_name_parser    = make_name_parser
fonts.map.tounicode16         = tounicode16
fonts.map.tounicode16sequence = tounicode16sequence

local separator   = lpeg.S("_.")
local other       = lpeg.C((1 - separator)^1)
local ligsplitter = lpeg.Ct(other * (separator * other)^0)

--~ print(table.serialize(lpegmatch(ligsplitter,"this")))
--~ print(table.serialize(lpegmatch(ligsplitter,"this.that")))
--~ print(table.serialize(lpegmatch(ligsplitter,"japan1.123")))
--~ print(table.serialize(lpegmatch(ligsplitter,"such_so_more")))
--~ print(table.serialize(lpegmatch(ligsplitter,"such_so_more.that")))

fonts.map.add_to_unicode = function(data,filename)
    local unicodes = data.luatex and data.luatex.unicodes
    if not unicodes then
        return
    end
    -- we need to move this code
    unicodes['space']  = unicodes['space']  or 32
    unicodes['hyphen'] = unicodes['hyphen'] or 45
    unicodes['zwj']    = unicodes['zwj']    or 0x200D
    unicodes['zwnj']   = unicodes['zwnj']   or 0x200C
    -- the tounicode mapping is sparse and only needed for alternatives
    local tounicode, originals, ns, nl, private, unknown = { }, { }, 0, 0, fonts.private, format("%04X",utfbyte("?"))
    data.luatex.tounicode, data.luatex.originals = tounicode, originals
    local lumunic, uparser, oparser
    if false then -- will become an option
        lumunic = load_lum_table(filename)
        lumunic = lumunic and lumunic.tounicode
    end
    local cidinfo, cidnames, cidcodes = data.cidinfo
    local usedmap = cidinfo and cidinfo.usedname
    usedmap = usedmap and lower(usedmap)
    usedmap = usedmap and fonts.cid.map[usedmap]
    if usedmap then
        oparser = usedmap and make_name_parser(cidinfo.ordering)
        cidnames = usedmap.names
        cidcodes = usedmap.unicodes
    end
    uparser = make_name_parser()
    local aglmap = fonts.map and fonts.map.agl_to_unicode
    for index, glyph in next, data.glyphs do
        local name, unic = glyph.name, glyph.unicode or -1 -- play safe
        if unic == -1 or unic >= private or (unic >= 0xE000 and unic <= 0xF8FF) or unic == 0xFFFE or unic == 0xFFFF then
            local unicode = (lumunic and lumunic[name]) or (aglmap and aglmap[name])
            if unicode then
                originals[index], tounicode[index], ns = unicode, tounicode16(unicode), ns + 1
            end
            -- cidmap heuristics, beware, there is no guarantee for a match unless
            -- the chain resolves
            if (not unicode) and usedmap then
                local foundindex = lpegmatch(oparser,name)
                if foundindex then
                    unicode = cidcodes[foundindex] -- name to number
                    if unicode then
                        originals[index], tounicode[index], ns = unicode, tounicode16(unicode), ns + 1
                    else
                        local reference = cidnames[foundindex] -- number to name
                        if reference then
                            local foundindex = lpegmatch(oparser,reference)
                            if foundindex then
                                unicode = cidcodes[foundindex]
                                if unicode then
                                    originals[index], tounicode[index], ns = unicode, tounicode16(unicode), ns + 1
                                end
                            end
                            if not unicode then
                                local foundcodes, multiple = lpegmatch(uparser,reference)
                                if foundcodes then
                                    if multiple then
                                        originals[index], tounicode[index], nl, unicode = foundcodes, tounicode16sequence(foundcodes), nl + 1, true
                                    else
                                        originals[index], tounicode[index], ns, unicode = foundcodes, tounicode16(foundcodes), ns + 1, foundcodes
                                    end
                                end
                            end
                        end
                    end
                end
            end
            -- a.whatever or a_b_c.whatever or a_b_c (no numbers)
            if not unicode then
                local split = lpegmatch(ligsplitter,name)
                local nplit = (split and #split) or 0
                if nplit == 0 then
                    -- skip
                elseif nplit == 1 then
                    local base = split[1]
                    unicode = unicodes[base] or (aglmap and aglmap[base])
                    if unicode then
                        if type(unicode) == "table" then
                            unicode = unicode[1]
                        end
                        originals[index], tounicode[index], ns = unicode, tounicode16(unicode), ns + 1
                    end
                else
                    local t = { }
                    for l=1,nplit do
                        local base = split[l]
                        local u = unicodes[base] or (aglmap and aglmap[base])
                        if not u then
                            break
                        elseif type(u) == "table" then
                            t[#t+1] = u[1]
                        else
                            t[#t+1] = u
                        end
                    end
                    if #t > 0 then -- done then
                        originals[index], tounicode[index], nl, unicode = t, tounicode16sequence(t), nl + 1, true
                    end
                end
            end
            -- last resort
            if not unicode then
                local foundcodes, multiple = lpegmatch(uparser,name)
                if foundcodes then
                    if multiple then
                        originals[index], tounicode[index], nl, unicode = foundcodes, tounicode16sequence(foundcodes), nl + 1, true
                    else
                        originals[index], tounicode[index], ns, unicode = foundcodes, tounicode16(foundcodes), ns + 1, foundcodes
                    end
                end
            end
            if not unicode then
                originals[index], tounicode[index] = 0xFFFD, "FFFD"
            end
        end
    end
    if trace_unimapping then
        for index, glyph in table.sortedhash(data.glyphs) do
            local toun, name, unic = tounicode[index], glyph.name, glyph.unicode or -1 -- play safe
            if toun then
                logs.report("load otf","internal: 0x%05X, name: %s, unicode: 0x%05X, tounicode: %s",index,name,unic,toun)
            else
                logs.report("load otf","internal: 0x%05X, name: %s, unicode: 0x%05X",index,name,unic)
            end
        end
    end
    if trace_loading and (ns > 0 or nl > 0) then
        logs.report("load otf","enhance: %s tounicode entries added (%s ligatures)",nl+ns, ns)
    end
end

-- the following is sort of obsolete
--
-- fonts.map.data      = fonts.map.data      or { }
-- fonts.map.encodings = fonts.map.encodings or { }
-- fonts.map.loaded    = fonts.map.loaded    or { }
-- fonts.map.line      = fonts.map.line      or { }
--
-- function fonts.map.line.pdftex(e)
--     if e.name and e.fontfile then
--         local fullname = e.fullname or ""
--         if e.slant and e.slant ~= 0 then
--             if e.encoding then
--                 pdf.mapline(format('= %s %s "%g SlantFont" <%s <%s',e.name,fullname,e.slant,e.encoding,e.fontfile)))
--             else
--                 pdf.mapline(format('= %s %s "%g SlantFont" <%s',e.name,fullname,e.slant,e.fontfile)))
--             end
--         elseif e.extend and e.extend ~= 1 and e.extend ~= 0 then
--             if e.encoding then
--                 pdf.mapline(format('= %s %s "%g ExtendFont" <%s <%s',e.name,fullname,e.extend,e.encoding,e.fontfile)))
--             else
--                 pdf.mapline(format('= %s %s "%g ExtendFont" <%s',e.name,fullname,e.extend,e.fontfile)))
--             end
--         else
--             if e.encoding then
--                 pdf.mapline(format('= %s %s <%s <%s',e.name,fullname,e.encoding,e.fontfile)))
--             else
--                 pdf.mapline(format('= %s %s <%s',e.name,fullname,e.fontfile)))
--             end
--         end
--     else
--         return nil
--     end
-- end
--
-- function fonts.map.flush(backend) -- will also erase the accumulated data
--     local flushline = fonts.map.line[backend or "pdftex"] or fonts.map.line.pdftex
--     for _, e in next, fonts.map.data do
--         flushline(e)
--     end
--     fonts.map.data = { }
-- end
--
-- fonts.map.line.dvips     = fonts.map.line.pdftex
-- fonts.map.line.dvipdfmx  = function() end
--
-- function fonts.map.convert_entries(filename)
--     if not fonts.map.loaded[filename] then
--         fonts.map.data, fonts.map.encodings = fonts.map.load_file(filename,fonts.map.data, fonts.map.encodings)
--         fonts.map.loaded[filename] = true
--     end
-- end
--
-- function fonts.map.load_file(filename, entries, encodings)
--     entries   = entries   or { }
--     encodings = encodings or { }
--     local f = io.open(filename)
--     if f then
--         local data = f:read("*a")
--         if data then
--             for line in gmatch(data,"(.-)[\n\t]") do
--                 if find(line,"^[%#%%%s]") then
--                     -- print(line)
--                 else
--                     local extend, slant, name, fullname, fontfile, encoding
--                     line = gsub(line,'"(.+)"', function(s)
--                         extend = find(s,'"([^"]+) ExtendFont"')
--                         slant = find(s,'"([^"]+) SlantFont"')
--                         return ""
--                     end)
--                     if not name then
--                         -- name fullname encoding fontfile
--                         name, fullname, encoding, fontfile = match(line,"^(%S+)%s+(%S*)[%s<]+(%S*)[%s<]+(%S*)%s*$")
--                     end
--                     if not name then
--                         -- name fullname (flag) fontfile encoding
--                         name, fullname, fontfile, encoding = match(line,"^(%S+)%s+(%S*)[%d%s<]+(%S*)[%s<]+(%S*)%s*$")
--                     end
--                     if not name then
--                         -- name fontfile
--                         name, fontfile = match(line,"^(%S+)%s+[%d%s<]+(%S*)%s*$")
--                     end
--                     if name then
--                         if encoding == "" then encoding = nil end
--                         entries[name] = {
--                             name     = name, -- handy
--                             fullname = fullname,
--                             encoding = encoding,
--                             fontfile = fontfile,
--                             slant    = tonumber(slant),
--                             extend   = tonumber(extend)
--                         }
--                         encodings[name] = encoding
--                     elseif line ~= "" then
--                     --  print(line)
--                     end
--                 end
--             end
--         end
--         f:close()
--     end
--     return entries, encodings
-- end
