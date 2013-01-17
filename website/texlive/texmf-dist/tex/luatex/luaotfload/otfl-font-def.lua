if not modules then modules = { } end modules ['font-def'] = {
    version   = 1.001,
    comment   = "companion to font-ini.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local format, concat, gmatch, match, find, lower = string.format, table.concat, string.gmatch, string.match, string.find, string.lower
local tostring, next = tostring, next
local lpegmatch = lpeg.match

local trace_defining     = false  trackers  .register("fonts.defining", function(v) trace_defining     = v end)
local directive_embedall = false  directives.register("fonts.embedall", function(v) directive_embedall = v end)

trackers.register("fonts.loading", "fonts.defining", "otf.loading", "afm.loading", "tfm.loading")
trackers.register("fonts.all", "fonts.*", "otf.*", "afm.*", "tfm.*")

--[[ldx--
<p>Here we deal with defining fonts. We do so by intercepting the
default loader that only handles <l n='tfm'/>.</p>
--ldx]]--

fonts        = fonts        or { }
fonts.define = fonts.define or { }
fonts.tfm    = fonts.tfm    or { }
fonts.ids    = fonts.ids    or { }
fonts.vf     = fonts.vf     or { }
fonts.used   = fonts.used   or { }

local tfm    = fonts.tfm
local vf     = fonts.vf
local define = fonts.define

tfm.version = 1.01
tfm.cache   = containers.define("fonts", "tfm", tfm.version, false) -- better in font-tfm

define.method        = "afm or tfm" -- afm, tfm, afm or tfm, tfm or afm
define.specify       = fonts.define.specify or { }
define.methods       = fonts.define.methods or { }

tfm.fonts            = tfm.fonts        or { }
tfm.readers          = tfm.readers      or { }
tfm.internalized     = tfm.internalized or { } -- internal tex numbers

tfm.readers.sequence = { 'otf', 'ttf', 'afm', 'tfm' }

tfm.auto_afm = true

local readers  = tfm.readers
local sequence = readers.sequence

--[[ldx--
<p>We hardly gain anything when we cache the final (pre scaled)
<l n='tfm'/> table. But it can be handy for debugging.</p>
--ldx]]--

fonts.version = 1.05
fonts.cache   = containers.define("fonts", "def", fonts.version, false)

--[[ldx--
<p>We can prefix a font specification by <type>name:</type> or
<type>file:</type>. The first case will result in a lookup in the
synonym table.</p>

<typing>
[ name: | file: ] identifier [ separator [ specification ] ]
</typing>

<p>The following function split the font specification into components
and prepares a table that will move along as we proceed.</p>
--ldx]]--

-- beware, we discard additional specs
--
-- method:name method:name(sub) method:name(sub)*spec method:name*spec
-- name name(sub) name(sub)*spec name*spec
-- name@spec*oeps

local splitter, specifiers = nil, ""

local P, C, S, Cc = lpeg.P, lpeg.C, lpeg.S, lpeg.Cc

local left  = P("(")
local right = P(")")
local colon = P(":")
local space = P(" ")

define.defaultlookup = "file"

local prefixpattern  = P(false)

function define.add_specifier(symbol)
    specifiers = specifiers .. symbol
    local method        = S(specifiers)
    local lookup        = C(prefixpattern) * colon
    local sub           = left * C(P(1-left-right-method)^1) * right
    local specification = C(method) * C(P(1)^1)
    local name          = C((1-sub-specification)^1)
    splitter = P((lookup + Cc("")) * name * (sub + Cc("")) * (specification + Cc("")))
end

function define.add_lookup(str,default)
    prefixpattern = prefixpattern + P(str)
end

define.add_lookup("file")
define.add_lookup("name")
define.add_lookup("spec")

function define.get_specification(str)
    return lpegmatch(splitter,str)
end

function define.register_split(symbol,action)
    define.add_specifier(symbol)
    define.specify[symbol] = action
end

function define.makespecification(specification, lookup, name, sub, method, detail, size)
    size = size or 655360
    if trace_defining then
        logs.report("define font","%s -> lookup: %s, name: %s, sub: %s, method: %s, detail: %s",
            specification, (lookup ~= "" and lookup) or "[file]", (name ~= "" and name) or "-",
            (sub ~= "" and sub) or "-", (method ~= "" and method) or "-", (detail ~= "" and detail) or "-")
    end
--~     if specification.lookup then
--~         lookup = specification.lookup -- can come from xetex [] syntax
--~         specification.lookup = nil
--~     end
    if not lookup or lookup == "" then
        lookup = define.defaultlookup
    end
    local t = {
        lookup        = lookup,        -- forced type
        specification = specification, -- full specification
        size          = size,          -- size in scaled points or -1000*n
        name          = name,          -- font or filename
        sub           = sub,           -- subfont (eg in ttc)
        method        = method,        -- specification method
        detail        = detail,        -- specification
        resolved      = "",            -- resolved font name
        forced        = "",            -- forced loader
        features      = { },           -- preprocessed features
    }
    return t
end

function define.analyze(specification, size)
    -- can be optimized with locals
    local lookup, name, sub, method, detail = define.get_specification(specification or "")
    return define.makespecification(specification, lookup, name, sub, method, detail, size)
end

--[[ldx--
<p>A unique hash value is generated by:</p>
--ldx]]--

local sortedhashkeys = table.sortedhashkeys

function tfm.hash_features(specification)
    local features = specification.features
    if features then
        local t = { }
        local normal = features.normal
        if normal and next(normal) then
            local f = sortedhashkeys(normal)
            for i=1,#f do
                local v = f[i]
                if v ~= "number" and v ~= "features" then -- i need to figure this out, features
                    t[#t+1] = v .. '=' .. tostring(normal[v])
                end
            end
        end
        local vtf = features.vtf
        if vtf and next(vtf) then
            local f = sortedhashkeys(vtf)
            for i=1,#f do
                local v = f[i]
                t[#t+1] = v .. '=' .. tostring(vtf[v])
            end
        end
--~ if specification.mathsize then
--~     t[#t+1] = "mathsize=" .. specification.mathsize
--~ end
        if #t > 0 then
            return concat(t,"+")
        end
    end
    return "unknown"
end

fonts.designsizes = { }

--[[ldx--
<p>In principle we can share tfm tables when we are in node for a font, but then
we need to define a font switch as an id/attr switch which is no fun, so in that
case users can best use dynamic features ... so, we will not use that speedup. Okay,
when we get rid of base mode we can optimize even further by sharing, but then we
loose our testcases for <l n='luatex'/>.</p>
--ldx]]--

function tfm.hash_instance(specification,force)
    local hash, size, fallbacks = specification.hash, specification.size, specification.fallbacks
    if force or not hash then
        hash = tfm.hash_features(specification)
        specification.hash = hash
    end
    if size < 1000 and fonts.designsizes[hash] then
        size = math.round(tfm.scaled(size, fonts.designsizes[hash]))
        specification.size = size
    end
--~     local mathsize = specification.mathsize or 0
--~     if mathsize > 0 then
--~         local textsize = specification.textsize
--~         if fallbacks then
--~             return hash .. ' @ ' .. tostring(size) .. ' [ ' .. tostring(mathsize) .. ' : ' .. tostring(textsize) .. ' ] @ ' .. fallbacks
--~         else
--~             return hash .. ' @ ' .. tostring(size) .. ' [ ' .. tostring(mathsize) .. ' : ' .. tostring(textsize) .. ' ]'
--~         end
--~     else
        if fallbacks then
            return hash .. ' @ ' .. tostring(size) .. ' @ ' .. fallbacks
        else
            return hash .. ' @ ' .. tostring(size)
        end
--~     end
end

--[[ldx--
<p>We can resolve the filename using the next function:</p>
--ldx]]--

define.resolvers = resolvers

-- todo: reporter

function define.resolvers.file(specification)
    local suffix = file.suffix(specification.name)
    if fonts.formats[suffix] then
        specification.forced = suffix
        specification.name = file.removesuffix(specification.name)
    end
end

function define.resolvers.name(specification)
    local resolve = fonts.names.resolve
    if resolve then
        local resolved, sub = fonts.names.resolve(specification)
        specification.resolved, specification.sub = resolved, sub
        if resolved then
            local suffix = file.suffix(resolved)
            if fonts.formats[suffix] then
                specification.forced = suffix
                specification.name = file.removesuffix(resolved)
            else
                specification.name = resolved
            end
        end
    else
        define.resolvers.file(specification)
    end
end

function define.resolvers.spec(specification)
    local resolvespec = fonts.names.resolvespec
    if resolvespec then
        specification.resolved, specification.sub = fonts.names.resolvespec(specification)
        if specification.resolved then
            specification.forced = file.extname(specification.resolved)
            specification.name = file.removesuffix(specification.resolved)
        end
    else
        define.resolvers.name(specification)
    end
end

function define.resolve(specification)
    if not specification.resolved or specification.resolved == "" then -- resolved itself not per se in mapping hash
        local r = define.resolvers[specification.lookup]
        if r then
            r(specification)
        end
    end
    if specification.forced == "" then
        specification.forced = nil
    else
        specification.forced = specification.forced
    end
    specification.hash = lower(specification.name .. ' @ ' .. tfm.hash_features(specification))
    if specification.sub and specification.sub ~= "" then
        specification.hash = specification.sub .. ' @ ' .. specification.hash
    end
    return specification
end

--[[ldx--
<p>The main read function either uses a forced reader (as determined by
a lookup) or tries to resolve the name using the list of readers.</p>

<p>We need to cache when possible. We do cache raw tfm data (from <l
n='tfm'/>, <l n='afm'/> or <l n='otf'/>). After that we can cache based
on specificstion (name) and size, that is, <l n='tex'/> only needs a number
for an already loaded fonts. However, it may make sense to cache fonts
before they're scaled as well (store <l n='tfm'/>'s with applied methods
and features). However, there may be a relation between the size and
features (esp in virtual fonts) so let's not do that now.</p>

<p>Watch out, here we do load a font, but we don't prepare the
specification yet.</p>
--ldx]]--

function tfm.read(specification)
    local hash = tfm.hash_instance(specification)
    local tfmtable = tfm.fonts[hash] -- hashes by size !
    if not tfmtable then
        local forced = specification.forced or ""
        if forced ~= "" then
            tfmtable = readers[lower(forced)](specification)
            if not tfmtable then
                logs.report("define font","forced type %s of %s not found",forced,specification.name)
            end
        else
            for s=1,#sequence do -- reader sequence
                local reader = sequence[s]
                if readers[reader] then -- not really needed
                    if trace_defining then
                        logs.report("define font","trying (reader sequence driven) type %s for %s with file %s",reader,specification.name,specification.filename or "unknown")
                    end
                    tfmtable = readers[reader](specification)
                    if tfmtable then
                        break
                    else
                        specification.filename = nil
                    end
                end
            end
        end
        if tfmtable then
            if directive_embedall then
                tfmtable.embedding = "full"
            elseif tfmtable.filename and fonts.dontembed[tfmtable.filename] then
                tfmtable.embedding = "no"
            else
                tfmtable.embedding = "subset"
            end
            tfm.fonts[hash] = tfmtable
            fonts.designsizes[specification.hash] = tfmtable.designsize -- we only know this for sure after loading once
        --~ tfmtable.mode = specification.features.normal.mode or "base"
        end
    end
    if not tfmtable then
        logs.report("define font","font with name %s is not found",specification.name)
    end
    return tfmtable
end

--[[ldx--
<p>For virtual fonts we need a slightly different approach:</p>
--ldx]]--

function tfm.read_and_define(name,size) -- no id
    local specification = define.analyze(name,size)
    local method = specification.method
    if method and define.specify[method] then
        specification = define.specify[method](specification)
    end
    specification = define.resolve(specification)
    local hash = tfm.hash_instance(specification)
    local id = define.registered(hash)
    if not id then
        local fontdata = tfm.read(specification)
        if fontdata then
            fontdata.hash = hash
            id = font.define(fontdata)
            define.register(fontdata,id)
            tfm.cleanup_table(fontdata)
        else
            id = 0  -- signal
        end
    end
    return fonts.ids[id], id
end

--[[ldx--
<p>Next follow the readers. This code was written while <l n='luatex'/>
evolved. Each one has its own way of dealing with its format.</p>
--ldx]]--

local function check_tfm(specification,fullname)
    -- ofm directive blocks local path search unless set; btw, in context we
    -- don't support ofm files anyway as this format is obsolete
    local foundname = resolvers.findbinfile(fullname, 'tfm') or "" -- just to be sure
    if foundname == "" then
        foundname = resolvers.findbinfile(fullname, 'ofm') or "" -- bonus for usage outside context
    end
    if foundname ~= "" then
        specification.filename, specification.format = foundname, "ofm"
        return tfm.read_from_tfm(specification)
    end
end

local function check_afm(specification,fullname)
    local foundname = resolvers.findbinfile(fullname, 'afm') or "" -- just to be sure
    if foundname == "" and tfm.auto_afm then
        local encoding, shortname = match(fullname,"^(.-)%-(.*)$") -- context: encoding-name.*
        if encoding and shortname and fonts.enc.known[encoding] then
            shortname = resolvers.findbinfile(shortname,'afm') or "" -- just to be sure
            if shortname ~= "" then
                foundname = shortname
             -- tfm.set_normal_feature(specification,'encoding',encoding) -- will go away
                if trace_loading then
                    logs.report("load afm","stripping encoding prefix from filename %s",afmname)
                end
            end
        end
    end
    if foundname ~= "" then
        specification.filename, specification.format = foundname, "afm"
        return tfm.read_from_afm(specification)
    end
end

function readers.tfm(specification)
    local fullname, tfmtable = specification.filename or "", nil
    if fullname == "" then
        local forced = specification.forced or ""
        if forced ~= "" then
            tfmtable = check_tfm(specification,specification.name .. "." .. forced)
        end
        if not tfmtable then
            tfmtable = check_tfm(specification,specification.name)
        end
    else
        tfmtable = check_tfm(specification,fullname)
    end
    return tfmtable
end

function readers.afm(specification,method)
    local fullname, tfmtable = specification.filename or "", nil
    if fullname == "" then
        local forced = specification.forced or ""
        if forced ~= "" then
            tfmtable = check_afm(specification,specification.name .. "." .. forced)
        end
        if not tfmtable then
            method = method or define.method or "afm or tfm"
            if method == "tfm" then
                tfmtable = check_tfm(specification,specification.name)
            elseif method == "afm" then
                tfmtable = check_afm(specification,specification.name)
            elseif method == "tfm or afm" then
                tfmtable = check_tfm(specification,specification.name) or check_afm(specification,specification.name)
            else -- method == "afm or tfm" or method == "" then
                tfmtable = check_afm(specification,specification.name) or check_tfm(specification,specification.name)
            end
        end
    else
        tfmtable = check_afm(specification,fullname)
    end
    return tfmtable
end

-- maybe some day a set of names

local function check_otf(forced,specification,suffix,what)
    local name = specification.name
    if forced then
        name = file.addsuffix(name,suffix,true)
    end
    local fullname, tfmtable = resolvers.findbinfile(name,suffix) or "", nil -- one shot
    if fullname == "" then
        local fb = fonts.names.old_to_new[name]
        if fb then
            fullname = resolvers.findbinfile(fb,suffix) or ""
        end
    end
    if fullname == "" then
        local fb = fonts.names.new_to_old[name]
        if fb then
            fullname = resolvers.findbinfile(fb,suffix) or ""
        end
    end
    if fullname ~= "" then
        specification.filename, specification.format = fullname, what -- hm, so we do set the filename, then
        tfmtable = tfm.read_from_open_type(specification)             -- we need to do it for all matches / todo
    end
    return tfmtable
end

function readers.opentype(specification,suffix,what)
    local forced = specification.forced or ""
    if forced == "otf" then
        return check_otf(true,specification,forced,"opentype")
    elseif forced == "ttf" or forced == "ttc" or forced == "dfont" then
        return check_otf(true,specification,forced,"truetype")
    else
        return check_otf(false,specification,suffix,what)
    end
end

function readers.otf  (specification) return readers.opentype(specification,"otf","opentype") end
function readers.ttf  (specification) return readers.opentype(specification,"ttf","truetype") end
function readers.ttc  (specification) return readers.opentype(specification,"ttf","truetype") end -- !!
function readers.dfont(specification) return readers.opentype(specification,"ttf","truetype") end -- !!

--[[ldx--
<p>We need to check for default features. For this we provide
a helper function.</p>
--ldx]]--

function define.check(features,defaults) -- nb adapts features !
    local done = false
    if features and next(features) then
        for k,v in next, defaults do
            if features[k] == nil then
                features[k], done = v, true
            end
        end
    else
        features, done = table.fastcopy(defaults), true
    end
    return features, done -- done signals a change
end

--[[ldx--
<p>So far the specifyers. Now comes the real definer. Here we cache
based on id's. Here we also intercept the virtual font handler. Since
it evolved stepwise I may rewrite this bit (combine code).</p>

In the previously defined reader (the one resulting in a <l n='tfm'/>
table) we cached the (scaled) instances. Here we cache them again, but
this time based on id. We could combine this in one cache but this does
not gain much. By the way, passing id's back to in the callback was
introduced later in the development.</p>
--ldx]]--

define.last = nil

function define.register(fontdata,id)
    if fontdata and id then
        local hash = fontdata.hash
        if not tfm.internalized[hash] then
            if trace_defining then
                logs.report("define font","loading at 2 id %s, hash: %s",id or "?",hash or "?")
            end
            fonts.identifiers[id] = fontdata
            fonts.characters [id] = fontdata.characters
            fonts.quads      [id] = fontdata.parameters.quad
            -- todo: extra functions, e.g. setdigitwidth etc in list
            tfm.internalized[hash] = id
        end
    end
end

function define.registered(hash)
    local id = tfm.internalized[hash]
    return id, id and fonts.ids[id]
end

local cache_them = false

function tfm.make(specification)
    -- currently fonts are scaled while constructing the font, so we
    -- have to do scaling of commands in the vf at that point using
    -- e.g. "local scale = g.factor or 1" after all, we need to work
    -- with copies anyway and scaling needs to be done at some point;
    -- however, when virtual tricks are used as feature (makes more
    -- sense) we scale the commands in fonts.tfm.scale (and set the
    -- factor there)
    local fvm = define.methods[specification.features.vtf.preset]
    if fvm then
        return fvm(specification)
    else
        return nil
    end
end

function define.read(specification,size,id) -- id can be optional, name can already be table
    statistics.starttiming(fonts)
    if type(specification) == "string" then
        specification = define.analyze(specification,size)
    end
    local method = specification.method
    if method and define.specify[method] then
        specification = define.specify[method](specification)
    end
    specification = define.resolve(specification)
    local hash = tfm.hash_instance(specification)
    if cache_them then
        local fontdata = containers.read(fonts.cache,hash) -- for tracing purposes
    end
    local fontdata = define.registered(hash) -- id
    if not fontdata then
        if specification.features.vtf and specification.features.vtf.preset then
            fontdata = tfm.make(specification)
        else
            fontdata = tfm.read(specification)
            if fontdata then
                tfm.check_virtual_id(fontdata)
            end
        end
        if cache_them then
            fontdata = containers.write(fonts.cache,hash,fontdata) -- for tracing purposes
        end
        if fontdata then
            fontdata.hash = hash
            fontdata.cache = "no"
            if id then
                define.register(fontdata,id)
            end
        end
    end
    define.last = fontdata or id -- todo ! ! ! ! !
    if not fontdata then
        logs.report("define font", "unknown font %s, loading aborted",specification.name)
    elseif trace_defining and type(fontdata) == "table" then
        logs.report("define font","using %s font with id %s, name:%s size:%s bytes:%s encoding:%s fullname:%s filename:%s",
            fontdata.type          or "unknown",
            id                     or "?",
            fontdata.name          or "?",
            fontdata.size          or "default",
            fontdata.encodingbytes or "?",
            fontdata.encodingname  or "unicode",
            fontdata.fullname      or "?",
            file.basename(fontdata.filename or "?"))

    end
    statistics.stoptiming(fonts)
    return fontdata
end

function vf.find(name)
    name = file.removesuffix(file.basename(name))
    if tfm.resolve_vf then
        local format = fonts.logger.format(name)
        if format == 'tfm' or format == 'ofm' then
            if trace_defining then
                logs.report("define font","locating vf for %s",name)
            end
            return resolvers.findbinfile(name,"ovf")
        else
            if trace_defining then
                logs.report("define font","vf for %s is already taken care of",name)
            end
            return nil -- ""
        end
    else
        if trace_defining then
            logs.report("define font","locating vf for %s",name)
        end
        return resolvers.findbinfile(name,"ovf")
    end
end

--[[ldx--
<p>We overload both the <l n='tfm'/> and <l n='vf'/> readers.</p>
--ldx]]--

callbacks.register('define_font' , define.read, "definition of fonts (tfmtable preparation)")
callbacks.register('find_vf_file', vf.find    , "locating virtual fonts, insofar needed") -- not that relevant any more
