if not modules then modules = { } end modules ['font-otf'] = {
    version   = 1.001,
    comment   = "companion to font-ini.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local utf = unicode.utf8

local concat, utfbyte = table.concat, utf.byte
local format, gmatch, gsub, find, match, lower, strip = string.format, string.gmatch, string.gsub, string.find, string.match, string.lower, string.strip
local type, next, tonumber, tostring = type, next, tonumber, tostring
local abs = math.abs
local getn = table.getn
local lpegmatch = lpeg.match

local trace_private    = false  trackers.register("otf.private",      function(v) trace_private      = v end)
local trace_loading    = false  trackers.register("otf.loading",      function(v) trace_loading      = v end)
local trace_features   = false  trackers.register("otf.features",     function(v) trace_features     = v end)
local trace_dynamics   = false  trackers.register("otf.dynamics",     function(v) trace_dynamics     = v end)
local trace_sequences  = false  trackers.register("otf.sequences",    function(v) trace_sequences    = v end)
local trace_math       = false  trackers.register("otf.math",         function(v) trace_math         = v end)
local trace_defining   = false  trackers.register("fonts.defining",   function(v) trace_defining     = v end)

--~ trackers.enable("otf.loading")

--[[ldx--
<p>The fontforge table has organized lookups in a certain way. A first implementation
of this code was organized featurewise: information related to features was
collected and processing boiled down to a run over the features. The current
implementation honors the order in the main feature table. Since we can reorder this
table as we want, we can eventually support several models of processing. We kept
the static as well as dynamic feature processing, because it had proved to be
rather useful. The formerly three loop variants have beem discarded but will
reapear at some time.</p>

<itemize>
<item>we loop over all lookups</item>
<item>for each lookup we do a run over the list of glyphs</item>
<item>but we only process them for features that are enabled</item>
<item>if we're dealing with a contextual lookup, we loop over all contexts</item>
<item>in that loop we quit at a match and then process the list of sublookups</item>
<item>we always continue after the match</item>
</itemize>

<p>In <l n='context'/> we do this for each font that is used in a list, so in
practice we have quite some nested loops.</p>

<p>We process the whole list and then consult the glyph nodes. An alternative approach
is to collect strings of characters using the same font including spaces (because some
lookups involve spaces). However, we then need to reconstruct the list which is no fun.
Also, we need to carry quite some information, like attributes, so eventually we don't
gain much (if we gain something at all).</p>

<p>Another consideration has been to operate on sublists (subhead, subtail) but again
this would complicate matters as we then neext to keep track of a changing subhead
and subtail. On the other hand, this might save some runtime. The number of changes
involved is not that large. This only makes sense when we have many fonts in a list
and don't change to frequently.</p>
--ldx]]--

fonts                = fonts     or { }
fonts.otf            = fonts.otf or { }
fonts.tfm            = fonts.tfm or { }

local otf            = fonts.otf
local tfm            = fonts.tfm

local fontdata       = fonts.ids

otf.tables           = otf.tables           or { } -- defined in font-ott.lua
otf.meanings         = otf.meanings         or { } -- defined in font-ott.lua
otf.tables.features  = otf.tables.features  or { } -- defined in font-ott.lua
otf.tables.languages = otf.tables.languages or { } -- defined in font-ott.lua
otf.tables.scripts   = otf.tables.scripts   or { } -- defined in font-ott.lua

otf.features         = otf.features         or { }
otf.features.list    = otf.features.list    or { }
otf.features.default = otf.features.default or { }

otf.enhancers        = otf.enhancers        or { }
otf.glists           = { "gsub", "gpos" }

otf.version          = 2.653 -- beware: also sync font-mis.lua
otf.pack             = true  -- beware: also sync font-mis.lua
otf.syncspace        = true
otf.notdef           = false
otf.cache            = containers.define("fonts", "otf", otf.version, true)
otf.cleanup_aat      = false -- only context

local wildcard = "*"
local default  = "dflt"

--[[ldx--
<p>We start with a lot of tables and related functions.</p>
--ldx]]--

otf.tables.global_fields = table.tohash {
    "lookups",
    "glyphs",
    "subfonts",
    "luatex",
    "pfminfo",
    "cidinfo",
    "tables",
    "names",
    "unicodes",
    "names",
--~     "math",
    "anchor_classes",
    "kern_classes",
    "gpos",
    "gsub"
}

otf.tables.valid_fields = {
    "anchor_classes",
    "ascent",
    "cache_version",
    "cidinfo",
    "copyright",
    "creationtime",
    "descent",
    "design_range_bottom",
    "design_range_top",
    "design_size",
    "encodingchanged",
    "extrema_bound",
    "familyname",
    "fontname",
    "fontstyle_id",
    "fontstyle_name",
    "fullname",
    "glyphs",
    "hasvmetrics",
    "head_optimized_for_cleartype",
    "horiz_base",
    "issans",
    "isserif",
    "italicangle",
    "kerns",
    "lookups",
 -- "luatex",
    "macstyle",
    "modificationtime",
    "onlybitmaps",
    "origname",
    "os2_version",
    "pfminfo",
    "private",
    "serifcheck",
    "sfd_version",
 -- "size",
    "strokedfont",
    "strokewidth",
    "subfonts",
    "table_version",
 -- "tables",
 -- "ttf_tab_saved",
    "ttf_tables",
    "uni_interp",
    "uniqueid",
    "units_per_em",
    "upos",
    "use_typo_metrics",
    "uwidth",
    "validation_state",
    "verbose",
    "version",
    "vert_base",
    "weight",
    "weight_width_slope_only",
    "xuid",
}

--[[ldx--
<p>Here we go.</p>
--ldx]]--

local function load_featurefile(ff,featurefile)
    if featurefile then
        featurefile = resolvers.find_file(file.addsuffix(featurefile,'fea'),'fea')
        if featurefile and featurefile ~= "" then
            if trace_loading then
                logs.report("load otf", "featurefile: %s", featurefile)
            end
            fontloader.apply_featurefile(ff, featurefile)
        end
    end
end

function otf.enhance(name,data,filename,verbose)
    local enhancer = otf.enhancers[name]
    if enhancer then
        if (verbose ~= nil and verbose) or trace_loading then
            logs.report("load otf","enhance: %s (%s)",name,filename)
        end
        enhancer(data,filename)
    end
end

local enhancers = {
    -- pack and unpack are handled separately; they might even be moved
    -- away from the enhancers namespace
    "patch bugs",
    "merge cid fonts", "prepare unicode", "cleanup ttf tables", "compact glyphs", "reverse coverage",
    "cleanup aat", "enrich with features", "add some missing characters",
    "reorganize mark classes",
    "reorganize kerns", -- moved here
    "flatten glyph lookups", "flatten anchor tables", "flatten feature tables",
    "simplify glyph lookups", -- some saving
    "prepare luatex tables",
    "analyse features", "rehash features",
    "analyse anchors", "analyse marks", "analyse unicodes", "analyse subtables",
    "check italic correction","check math",
    "share widths",
    "strip not needed data",
    "migrate metadata",
    "check math parameters",
}

function otf.load(filename,format,sub,featurefile)
    local name = file.basename(file.removesuffix(filename))
    local attr = lfs.attributes(filename)
    local size, time = attr.size or 0, attr.modification or 0
    if featurefile then
        local fattr = lfs.attributes(featurefile)
        local fsize, ftime = fattr and fattr.size or 0, fattr and fattr.modification or 0
        name = name .. "@" .. file.removesuffix(file.basename(featurefile)) .. ftime .. fsize
    end
    if sub == "" then sub = false end
    local hash = name
    if sub then
        hash = hash .. "-" .. sub
    end
    hash = containers.cleanname(hash)
    local data = containers.read(otf.cache,hash)
    if not data or data.verbose ~= fonts.verbose or data.size ~= size or data.time ~= time then
        logs.report("load otf","loading: %s (hash: %s)",filename,hash)
        local ff, messages
        if sub then
            ff, messages = fontloader.open(filename,sub)
        else
            ff, messages = fontloader.open(filename)
        end
        if trace_loading and messages and #messages > 0 then
            if type(messages) == "string" then
                logs.report("load otf","warning: %s",messages)
            else
                for m=1,#messages do
                    logs.report("load otf","warning: %s",tostring(messages[m]))
                end
            end
        else
            logs.report("load otf","font loaded okay")
        end
        if ff then
            load_featurefile(ff,featurefile)
            data = fontloader.to_table(ff)
            fontloader.close(ff)
            if data then
                logs.report("load otf","file size: %s", size)
                logs.report("load otf","enhancing ...")
                for e=1,#enhancers do
                    otf.enhance(enhancers[e],data,filename)
                    io.flush() -- we want instant messages
                end
                if otf.pack and not fonts.verbose then
                    otf.enhance("pack",data,filename)
                end
                data.size = size
                data.time = time
                data.verbose = fonts.verbose
                logs.report("load otf","saving in cache: %s",filename)
                data = containers.write(otf.cache, hash, data)
                collectgarbage("collect")
                data = containers.read(otf.cache, hash) -- this frees the old table and load the sparse one
                collectgarbage("collect")
            else
                logs.report("load otf","loading failed (table conversion error)")
            end
        else
            logs.report("load otf","loading failed (file read error)")
        end
    end
    if data then
        if trace_defining then
            logs.report("define font","loading from cache: %s",hash)
        end
        otf.enhance("unpack",data,filename,false) -- no message here
        otf.add_dimensions(data)
        if trace_sequences then
            otf.show_feature_order(data,filename)
        end
    end
    return data
end

function otf.add_dimensions(data)
    -- todo: forget about the width if it's the defaultwidth (saves mem)
    -- we could also build the marks hash here (instead of storing it)
    if data then
        local force = otf.notdef
        local luatex = data.luatex
        local defaultwidth  = luatex.defaultwidth  or 0
        local defaultheight = luatex.defaultheight or 0
        local defaultdepth  = luatex.defaultdepth  or 0
        for _, d in next, data.glyphs do
            local bb, wd = d.boundingbox, d.width
            if not wd then
                d.width = defaultwidth
            elseif wd ~= 0 and d.class == "mark" then
                d.width  = -wd
            end
            if force and not d.name then
                d.name = ".notdef"
            end
            if bb then
                local ht, dp = bb[4], -bb[2]
                if ht == 0 or ht < 0 then
                    -- no need to set it and no negative heights, nil == 0
                else
                    d.height = ht
                end
                if dp == 0 or dp < 0 then
                    -- no negative depths and no negative depths, nil == 0
                else
                    d.depth  = dp
                end
            end
        end
    end
end

function otf.show_feature_order(otfdata,filename)
    local sequences = otfdata.luatex.sequences
    if sequences and #sequences > 0 then
        if trace_loading then
            logs.report("otf check","font %s has %s sequences",filename,#sequences)
            logs.report("otf check"," ")
        end
        for nos=1,#sequences do
            local sequence = sequences[nos]
            local typ = sequence.type or "no-type"
            local name = sequence.name or "no-name"
            local subtables = sequence.subtables or { "no-subtables" }
            local features = sequence.features
            if trace_loading then
                logs.report("otf check","%3i  %-15s  %-20s  [%s]",nos,name,typ,concat(subtables,","))
            end
            if features then
                for feature, scripts in next, features do
                    local tt = { }
                    for script, languages in next, scripts do
                        local ttt = { }
                        for language, _ in next, languages do
                            ttt[#ttt+1] = language
                        end
                        tt[#tt+1] = format("[%s: %s]",script,concat(ttt," "))
                    end
                    if trace_loading then
                        logs.report("otf check","       %s: %s",feature,concat(tt," "))
                    end
                end
            end
        end
        if trace_loading then
            logs.report("otf check","\n")
        end
    elseif trace_loading then
        logs.report("otf check","font %s has no sequences",filename)
    end
end

-- todo: normalize, design_size => designsize

otf.enhancers["reorganize mark classes"] = function(data,filename)
    if data.mark_classes then
        local unicodes = data.luatex.unicodes
        local reverse = { }
        for name, class in next, data.mark_classes do
            local t = { }
            for s in gmatch(class,"[^ ]+") do
                local us = unicodes[s]
                if type(us) == "table" then
                    for u=1,#us do
                        t[us[u]] = true
                    end
                else
                    t[us] = true
                end
            end
            reverse[name] = t
        end
        data.luatex.markclasses = reverse
        data.mark_classes = nil
    end
end

otf.enhancers["prepare luatex tables"] = function(data,filename)
    data.luatex = data.luatex or { }
    local luatex = data.luatex
    luatex.filename = filename
    luatex.version = otf.version
    luatex.creator = "context mkiv"
end

otf.enhancers["cleanup aat"] = function(data,filename)
    if otf.cleanup_aat then
    end
end

local function analyze_features(g, features)
    if g then
        local t, done = { }, { }
        for k=1,#g do
            local f = features or g[k].features
            if f then
                for k=1,#f do
                    -- scripts and tag
                    local tag = f[k].tag
                    if not done[tag] then
                        t[#t+1] = tag
                        done[tag] = true
                    end
                end
            end
        end
        if #t > 0 then
            return t
        end
    end
    return nil
end

otf.enhancers["analyse features"] = function(data,filename)
 -- local luatex = data.luatex
 -- luatex.gposfeatures = analyze_features(data.gpos)
 -- luatex.gsubfeatures = analyze_features(data.gsub)
end

otf.enhancers["rehash features"] = function(data,filename)
    local features = { }
    data.luatex.features = features
    for k, what in next, otf.glists do
        local dw = data[what]
        if dw then
            local f = { }
            features[what] = f
            for i=1,#dw do
                local d= dw[i]
                local dfeatures = d.features
                if dfeatures then
                    for i=1,#dfeatures do
                        local df = dfeatures[i]
                        local tag = strip(lower(df.tag))
                        local ft = f[tag] if not ft then ft = {} f[tag] = ft end
                        local dscripts = df.scripts
                        for script, languages in next, dscripts do
                            script = strip(lower(script))
                            local fts = ft[script] if not fts then fts = {} ft[script] = fts end
                            for i=1,#languages do
                                fts[strip(lower(languages[i]))] = true
                            end
                        end
                    end
                end
            end
        end
    end
end

otf.enhancers["analyse anchors"] = function(data,filename)
    local classes = data.anchor_classes
    local luatex = data.luatex
    local anchor_to_lookup, lookup_to_anchor = { }, { }
    luatex.anchor_to_lookup, luatex.lookup_to_anchor = anchor_to_lookup, lookup_to_anchor
    if classes then
        for c=1,#classes do
            local class = classes[c]
            local anchor = class.name
            local lookups = class.lookup
            if type(lookups) ~= "table" then
                lookups = { lookups }
            end
            local a = anchor_to_lookup[anchor]
            if not a then a = { } anchor_to_lookup[anchor] = a end
            for l=1,#lookups do
                local lookup = lookups[l]
                local l = lookup_to_anchor[lookup]
                if not l then l = { } lookup_to_anchor[lookup] = l end
                l[anchor] = true
                a[lookup] = true
            end
        end
    end
end

otf.enhancers["analyse marks"] = function(data,filename)
    local glyphs = data.glyphs
    local marks = { }
    data.luatex.marks = marks
    for unicode, index in next, data.luatex.indices do
        local glyph = glyphs[index]
        if glyph.class == "mark" then
            marks[unicode] = true
        end
    end
end

otf.enhancers["analyse unicodes"] = fonts.map.add_to_unicode

otf.enhancers["analyse subtables"] = function(data,filename)
    data.luatex = data.luatex or { }
    local luatex = data.luatex
    local sequences = { }
    local lookups = { }
    luatex.sequences = sequences
    luatex.lookups = lookups
    for _, g in next, { data.gsub, data.gpos } do
        for k=1,#g do
            local gk = g[k]
            local typ = gk.type
            if typ == "gsub_contextchain" or typ == "gpos_contextchain" then
                gk.chain = 1
            elseif typ == "gsub_reversecontextchain" or typ == "gpos_reversecontextchain" then
                gk.chain = -1
            else
                gk.chain = 0
            end
            local features = gk.features
            if features then
                sequences[#sequences+1] = gk
                -- scripts, tag, ismac
                local t = { }
                for f=1,#features do
                    local feature = features[f]
                    local hash = { }
                    -- only script and langs matter
                    for s, languages in next, feature.scripts do
                        s = lower(s)
                        local h = hash[s]
                        if not h then h = { } hash[s] = h end
                        for l=1,#languages do
                            h[strip(lower(languages[l]))] = true
                        end
                    end
                    t[feature.tag] = hash
                end
                gk.features = t
            else
                lookups[gk.name] = gk
                gk.name = nil
            end
            local subtables = gk.subtables
            if subtables then
                local t = { }
                for s=1,#subtables do
                    local subtable = subtables[s]
                    local name = subtable.name
                    t[#t+1] = name
                end
                gk.subtables = t
            end
            local flags = gk.flags
            if flags then
                gk.flags = { -- forcing false packs nicer
                    (flags.ignorecombiningmarks and "mark")     or false,
                    (flags.ignoreligatures      and "ligature") or false,
                    (flags.ignorebaseglyphs     and "base")     or false,
                     flags.r2l                                  or false,
                }
                if flags.mark_class then
                    gk.markclass = luatex.markclasses[flags.mark_class]
                end
            end
        end
    end
end

otf.enhancers["merge cid fonts"] = function(data,filename)
    -- we can also move the names to data.luatex.names which might
    -- save us some more memory (at the cost of harder tracing)
    if data.subfonts then
        if data.glyphs and next(data.glyphs) then
            logs.report("load otf","replacing existing glyph table due to subfonts")
        end
        local cidinfo = data.cidinfo
        local verbose = fonts.verbose
        if cidinfo.registry then
            local cidmap, cidname = fonts.cid.getmap(cidinfo.registry,cidinfo.ordering,cidinfo.supplement)
            if cidmap then
                cidinfo.usedname = cidmap.usedname
                local glyphs, uni_to_int, int_to_uni, nofnames, nofunicodes = { }, { }, { }, 0, 0
                local unicodes, names = cidmap.unicodes, cidmap.names
                for n, subfont in next, data.subfonts do
                    for index, g in next, subfont.glyphs do
                        if not next(g) then
                            -- dummy entry
                        else
                            local unicode, name = unicodes[index], names[index]
                            g.cidindex = n
                            g.boundingbox = g.boundingbox -- or zerobox
                            g.name = g.name or name or "unknown"
                            if unicode then
                                uni_to_int[unicode] = index
                                int_to_uni[index] = unicode
                                nofunicodes = nofunicodes + 1
                                g.unicode = unicode
                            elseif name then
                                nofnames = nofnames + 1
                                g.unicode = -1
                            end
                            glyphs[index] = g
                        end
                    end
                    subfont.glyphs = nil
                end
                if trace_loading then
                    logs.report("load otf","cid font remapped, %s unicode points, %s symbolic names, %s glyphs",nofunicodes, nofnames, nofunicodes+nofnames)
                end
                data.glyphs = glyphs
                data.map = data.map or { }
                data.map.map = uni_to_int
                data.map.backmap = int_to_uni
            elseif trace_loading then
                logs.report("load otf","unable to remap cid font, missing cid file for %s",filename)
            end
        elseif trace_loading then
            logs.report("load otf","font %s has no glyphs",filename)
        end
    end
end

otf.enhancers["prepare unicode"] = function(data,filename)
    local luatex = data.luatex
    if not luatex then luatex = { } data.luatex = luatex end
    local indices, unicodes, multiples, internals = { }, { }, { }, { }
    local glyphs = data.glyphs
    local mapmap = data.map
    if not mapmap then
        logs.report("load otf","no map in %s",filename)
        mapmap = { }
        data.map = { map = mapmap }
    elseif not mapmap.map then
        logs.report("load otf","no unicode map in %s",filename)
        mapmap = { }
        data.map.map = mapmap
    else
        mapmap = mapmap.map
    end
    local criterium = fonts.private
    local private = fonts.private
    for index, glyph in next, glyphs do
        if index > 0 then
            local name = glyph.name
            if name then
                local unicode = glyph.unicode
                if unicode == -1 or unicode >= criterium then
                    glyph.unicode = private
                    indices[private] = index
                    unicodes[name] = private
                    internals[index] = true
                    if trace_private then
                        logs.report("load otf","enhance: glyph %s at index U+%04X is moved to private unicode slot U+%04X",name,index,private)
                    end
                    private = private + 1
                else
                    indices[unicode] = index
                    unicodes[name] = unicode
                end
            end
        end
    end
    -- beware: the indices table is used to initialize the tfm table
    for unicode, index in next, mapmap do
        if not internals[index] then
            local name = glyphs[index].name
            if name then
                local un = unicodes[name]
                if not un then
                    unicodes[name] = unicode -- or 0
                elseif type(un) == "number" then
                    if un ~= unicode then
                        multiples[#multiples+1] = name
                        unicodes[name] = { un, unicode }
                        indices[unicode] = index
                    end
                else
                    local ok = false
                    for u=1,#un do
                        if un[u] == unicode then
                            ok = true
                            break
                        end
                    end
                    if not ok then
                        multiples[#multiples+1] = name
                        un[#un+1] = unicode
                        indices[unicode] = index
                    end
                end
            end
        end
    end
    if trace_loading then
        if #multiples > 0 then
            logs.report("load otf","%s glyph are reused: %s",#multiples, concat(multiples," "))
        else
            logs.report("load otf","no glyph are reused")
        end
    end
    luatex.indices = indices
    luatex.unicodes = unicodes
    luatex.private = private
end

otf.enhancers["cleanup ttf tables"] = function(data,filename)
    local ttf_tables = data.ttf_tables
    if ttf_tables then
        for k=1,#ttf_tables do
            if ttf_tables[k].data then ttf_tables[k].data = "deleted" end
        end
    end
    data.ttf_tab_saved = nil
end

otf.enhancers["compact glyphs"] = function(data,filename)
    table.compact(data.glyphs) -- needed?
    if data.subfonts then
        for _, subfont in next, data.subfonts do
            table.compact(subfont.glyphs) -- needed?
        end
    end
end

otf.enhancers["reverse coverage"] = function(data,filename)
    -- we prefer the before lookups in a normal order
    if data.lookups then
        for _, v in next, data.lookups do
            if v.rules then
                for _, vv in next, v.rules do
                    local c = vv.coverage
                    if c and c.before then
                        c.before = table.reverse(c.before)
                    end
                end
            end
        end
    end
end

otf.enhancers["check italic correction"] = function(data,filename)
    local glyphs = data.glyphs
    local ok = false
    for index, glyph in next, glyphs do
        local ic = glyph.italic_correction
        if ic then
            if ic ~= 0 then
                glyph.italic = ic
            end
            glyph.italic_correction = nil
            ok = true
        end
    end
    -- we can use this to avoid calculations
    otf.tables.valid_fields[#otf.tables.valid_fields+1] = "has_italic"
    data.has_italic = true
end

otf.enhancers["check math"] = function(data,filename)
    if data.math then
        -- we move the math stuff into a math subtable because we then can
        -- test faster in the tfm copy
        local glyphs = data.glyphs
        local unicodes = data.luatex.unicodes
        for index, glyph in next, glyphs do
            local mk = glyph.mathkern
            local hv = glyph.horiz_variants
            local vv = glyph.vert_variants
            if mk or hv or vv then
                local math = { }
                glyph.math = math
                if mk then
                    for k, v in next, mk do
                        if not next(v) then
                            mk[k] = nil
                        end
                    end
                    math.kerns = mk
                    glyph.mathkern = nil
                end
                if hv then
                    math.horiz_variants = hv.variants
                    local p = hv.parts
                    if p and #p > 0 then
                        for i=1,#p do
                            local pi = p[i]
                            pi.glyph = unicodes[pi.component] or 0
                        end
                        math.horiz_parts = p
                    end
                    local ic = hv.italic_correction
                    if ic and ic ~= 0 then
                        math.horiz_italic_correction = ic
                    end
                    glyph.horiz_variants = nil
                end
                if vv then
                    local uc = unicodes[index]
                    math.vert_variants = vv.variants
                    local p = vv.parts
                    if p and #p > 0 then
                        for i=1,#p do
                            local pi = p[i]
                            pi.glyph = unicodes[pi.component] or 0
                        end
                        math.vert_parts = p
                    end
                    local ic = vv.italic_correction
                    if ic and ic ~= 0 then
                        math.vert_italic_correction = ic
                    end
                    glyph.vert_variants = nil
                end
                local ic = glyph.italic_correction
                if ic then
                    if ic ~= 0 then
                        math.italic_correction = ic
                    end
                    glyph.italic_correction = nil
                end
            end
        end
    end
end

otf.enhancers["share widths"] = function(data,filename)
    local glyphs = data.glyphs
    local widths = { }
    for index, glyph in next, glyphs do
        local width = glyph.width
        widths[width] = (widths[width] or 0) + 1
    end
    -- share width for cjk fonts
    local wd, most = 0, 1
    for k,v in next, widths do
        if v > most then
            wd, most = k, v
        end
    end
    if most > 1000 then
        if trace_loading then
            logs.report("load otf", "most common width: %s (%s times), sharing (cjk font)",wd,most)
        end
        for k, v in next, glyphs do
            if v.width == wd then
                v.width = nil
            end
        end
        data.luatex.defaultwidth = wd
    end
end

-- kern: ttf has a table with kerns

-- Weird, as maxfirst and maxseconds can have holes, first seems to be indexed, but
-- seconds can start at 2 .. this need to be fixed as getn as well as # are sort of
-- unpredictable alternatively we could force an [1] if not set (maybe I will do that
-- anyway).

--~ otf.enhancers["reorganize kerns"] = function(data,filename)
--~     local glyphs, mapmap, unicodes = data.glyphs, data.luatex.indices, data.luatex.unicodes
--~     local mkdone = false
--~     for index, glyph in next, glyphs do
--~         if glyph.kerns then
--~             local mykerns = { }
--~             for k,v in next, glyph.kerns do
--~                 local vc, vo, vl = v.char, v.off, v.lookup
--~                 if vc and vo and vl then -- brrr, wrong! we miss the non unicode ones
--~                     local uvc = unicodes[vc]
--~                     if not uvc then
--~                         if trace_loading then
--~                             logs.report("load otf","problems with unicode %s of kern %s at glyph %s",vc,k,index)
--~                         end
--~                     else
--~                         if type(vl) ~= "table" then
--~                             vl = { vl }
--~                         end
--~                         for l=1,#vl do
--~                             local vll = vl[l]
--~                             local mkl = mykerns[vll]
--~                             if not mkl then
--~                                 mkl = { }
--~                                 mykerns[vll] = mkl
--~                             end
--~                             if type(uvc) == "table" then
--~                                 for u=1,#uvc do
--~                                     mkl[uvc[u]] = vo
--~                                 end
--~                             else
--~                                 mkl[uvc] = vo
--~                             end
--~                         end
--~                     end
--~                 end
--~             end
--~             glyph.mykerns = mykerns
--~             glyph.kerns = nil -- saves space and time
--~             mkdone = true
--~         end
--~     end
--~     if trace_loading and mkdone then
--~         logs.report("load otf", "replacing 'kerns' tables by 'mykerns' tables")
--~     end
--~     if data.kerns then
--~         if trace_loading then
--~             logs.report("load otf", "removing global 'kern' table")
--~         end
--~         data.kerns = nil
--~     end
--~     local dgpos = data.gpos
--~     if dgpos then
--~         local separator = lpeg.P(" ")
--~         local other = ((1 - separator)^0) / unicodes
--~         local splitter = lpeg.Ct(other * (separator * other)^0)
--~         for gp=1,#dgpos do
--~             local gpos = dgpos[gp]
--~             local subtables = gpos.subtables
--~             if subtables then
--~                 for s=1,#subtables do
--~                     local subtable = subtables[s]
--~                     local kernclass = subtable.kernclass -- name is inconsistent with anchor_classes
--~                     if kernclass then -- the next one is quite slow
--~                         local split = { } -- saves time
--~                         for k=1,#kernclass do
--~                             local kcl = kernclass[k]
--~                             local firsts, seconds, offsets, lookups = kcl.firsts, kcl.seconds, kcl.offsets, kcl.lookup -- singular
--~                             if type(lookups) ~= "table" then
--~                                 lookups = { lookups }
--~                             end
--~                             local maxfirsts, maxseconds = getn(firsts), getn(seconds)
--~                             for _, s in next, firsts do
--~                                 split[s] = split[s] or lpegmatch(splitter,s)
--~                             end
--~                             for _, s in next, seconds do
--~                                 split[s] = split[s] or lpegmatch(splitter,s)
--~                             end
--~                             for l=1,#lookups do
--~                                 local lookup = lookups[l]
--~                                 local function do_it(fk,first_unicode)
--~                                     local glyph = glyphs[mapmap[first_unicode]]
--~                                     if glyph then
--~                                         local mykerns = glyph.mykerns
--~                                         if not mykerns then
--~                                             mykerns = { } -- unicode indexed !
--~                                             glyph.mykerns = mykerns
--~                                         end
--~                                         local lookupkerns = mykerns[lookup]
--~                                         if not lookupkerns then
--~                                             lookupkerns = { }
--~                                             mykerns[lookup] = lookupkerns
--~                                         end
--~                                         local baseoffset = (fk-1) * maxseconds
--~                                         for sk=2,maxseconds do -- we can avoid this loop with a table
--~                                             local sv = seconds[sk]
--~                                             local splt = split[sv]
--~                                             if splt then
--~                                                 local offset = offsets[baseoffset + sk]
--~                                                 --~ local offset = offsets[sk] -- (fk-1) * maxseconds + sk]
--~                                                 if offset then
--~                                                     for i=1,#splt do
--~                                                         local second_unicode = splt[i]
--~                                                         if tonumber(second_unicode) then
--~                                                             lookupkerns[second_unicode] = offset
--~                                                         else for s=1,#second_unicode do
--~                                                             lookupkerns[second_unicode[s]] = offset
--~                                                         end end
--~                                                     end
--~                                                 end
--~                                             end
--~                                         end
--~                                     elseif trace_loading then
--~                                         logs.report("load otf", "no glyph data for U+%04X", first_unicode)
--~                                     end
--~                                 end
--~                                 for fk=1,#firsts do
--~                                     local fv = firsts[fk]
--~                                     local splt = split[fv]
--~                                     if splt then
--~                                         for i=1,#splt do
--~                                             local first_unicode = splt[i]
--~                                             if tonumber(first_unicode) then
--~                                                 do_it(fk,first_unicode)
--~                                             else for f=1,#first_unicode do
--~                                                 do_it(fk,first_unicode[f])
--~                                             end end
--~                                         end
--~                                     end
--~                                 end
--~                             end
--~                         end
--~                         subtable.comment = "The kernclass table is merged into mykerns in the indexed glyph tables."
--~                         subtable.kernclass = { }
--~                     end
--~                 end
--~             end
--~         end
--~     end
--~ end

otf.enhancers["reorganize kerns"] = function(data,filename)
    local glyphs, mapmap, unicodes = data.glyphs, data.luatex.indices, data.luatex.unicodes
    local mkdone = false
    local function do_it(lookup,first_unicode,kerns)
        local glyph = glyphs[mapmap[first_unicode]]
        if glyph then
            local mykerns = glyph.mykerns
            if not mykerns then
                mykerns = { } -- unicode indexed !
                glyph.mykerns = mykerns
            end
            local lookupkerns = mykerns[lookup]
            if not lookupkerns then
                lookupkerns = { }
                mykerns[lookup] = lookupkerns
            end
            for second_unicode, kern in next, kerns do
                lookupkerns[second_unicode] = kern
            end
        elseif trace_loading then
            logs.report("load otf", "no glyph data for U+%04X", first_unicode)
        end
    end
    for index, glyph in next, glyphs do
        if glyph.kerns then
            local mykerns = { }
            for k,v in next, glyph.kerns do
                local vc, vo, vl = v.char, v.off, v.lookup
                if vc and vo and vl then -- brrr, wrong! we miss the non unicode ones
                    local uvc = unicodes[vc]
                    if not uvc then
                        if trace_loading then
                            logs.report("load otf","problems with unicode %s of kern %s at glyph %s",vc,k,index)
                        end
                    else
                        if type(vl) ~= "table" then
                            vl = { vl }
                        end
                        for l=1,#vl do
                            local vll = vl[l]
                            local mkl = mykerns[vll]
                            if not mkl then
                                mkl = { }
                                mykerns[vll] = mkl
                            end
                            if type(uvc) == "table" then
                                for u=1,#uvc do
                                    mkl[uvc[u]] = vo
                                end
                            else
                                mkl[uvc] = vo
                            end
                        end
                    end
                end
            end
            glyph.mykerns = mykerns
            glyph.kerns = nil -- saves space and time
            mkdone = true
        end
    end
    if trace_loading and mkdone then
        logs.report("load otf", "replacing 'kerns' tables by 'mykerns' tables")
    end
    if data.kerns then
        if trace_loading then
            logs.report("load otf", "removing global 'kern' table")
        end
        data.kerns = nil
    end
    local dgpos = data.gpos
    if dgpos then
        local separator = lpeg.P(" ")
        local other = ((1 - separator)^0) / unicodes
        local splitter = lpeg.Ct(other * (separator * other)^0)
        for gp=1,#dgpos do
            local gpos = dgpos[gp]
            local subtables = gpos.subtables
            if subtables then
                for s=1,#subtables do
                    local subtable = subtables[s]
                    local kernclass = subtable.kernclass -- name is inconsistent with anchor_classes
                    if kernclass then -- the next one is quite slow
                        local split = { } -- saves time
                        for k=1,#kernclass do
                            local kcl = kernclass[k]
                            local firsts, seconds, offsets, lookups = kcl.firsts, kcl.seconds, kcl.offsets, kcl.lookup -- singular
                            if type(lookups) ~= "table" then
                                lookups = { lookups }
                            end
                            local maxfirsts, maxseconds = getn(firsts), getn(seconds)
                            -- here we could convert split into a list of unicodes which is a bit
                            -- faster but as this is only done when caching it does not save us much
                            for _, s in next, firsts do
                                split[s] = split[s] or lpegmatch(splitter,s)
                            end
                            for _, s in next, seconds do
                                split[s] = split[s] or lpegmatch(splitter,s)
                            end
                            for l=1,#lookups do
                                local lookup = lookups[l]
                                for fk=1,#firsts do
                                    local fv = firsts[fk]
                                    local splt = split[fv]
                                    if splt then
                                        local kerns, baseoffset = { }, (fk-1) * maxseconds
                                        for sk=2,maxseconds do
                                            local sv = seconds[sk]
                                            local splt = split[sv]
                                            if splt then
                                                local offset = offsets[baseoffset + sk]
                                                if offset then
                                                    for i=1,#splt do
                                                        local second_unicode = splt[i]
                                                        if tonumber(second_unicode) then
                                                            kerns[second_unicode] = offset
                                                        else for s=1,#second_unicode do
                                                            kerns[second_unicode[s]] = offset
                                                        end end
                                                    end
                                                end
                                            end
                                        end
                                        for i=1,#splt do
                                            local first_unicode = splt[i]
                                            if tonumber(first_unicode) then
                                                do_it(lookup,first_unicode,kerns)
                                            else for f=1,#first_unicode do
                                                do_it(lookup,first_unicode[f],kerns)
                                            end end
                                        end
                                    end
                                end
                            end
                        end
                        subtable.comment = "The kernclass table is merged into mykerns in the indexed glyph tables."
                        subtable.kernclass = { }
                    end
                end
            end
        end
    end
end









otf.enhancers["strip not needed data"] = function(data,filename)
    local verbose = fonts.verbose
    local int_to_uni = data.luatex.unicodes
    for k, v in next, data.glyphs do
        local d = v.dependents
        if d then v.dependents = nil end
        local a = v.altuni
        if a then v.altuni = nil end
        if verbose then
            local code = int_to_uni[k]
            -- looks like this is done twice ... bug?
            if code then
                local vu = v.unicode
                if not vu then
                    v.unicode = code
                elseif type(vu) == "table" then
                    if vu[#vu] == code then
                        -- weird
                    else
                        vu[#vu+1] = code
                    end
                elseif vu ~= code then
                    v.unicode = { vu, code }
                end
            end
        else
            v.unicode = nil
            v.index = nil
        end
    end
    data.luatex.comment = "Glyph tables have their original index. When present, mykern tables are indexed by unicode."
    data.map = nil
    data.names = nil -- funny names for editors
    data.glyphcnt = nil
    data.glyphmax = nil
    if true then
        data.gpos = nil
        data.gsub = nil
        data.anchor_classes = nil
    end
end

otf.enhancers["migrate metadata"] = function(data,filename)
    local global_fields = otf.tables.global_fields
    local metadata = { }
    for k,v in next, data do
        if not global_fields[k] then
            metadata[k] = v
            data[k] = nil
        end
    end
    data.metadata = metadata
    -- goodies
    local pfminfo = data.pfminfo
    metadata.isfixedpitch = metadata.isfixedpitch or (pfminfo.panose and pfminfo.panose["proportion"] == "Monospaced")
    metadata.charwidth    = pfminfo and pfminfo.avgwidth
end

local private_math_parameters = {
    "FractionDelimiterSize",
    "FractionDelimiterDisplayStyleSize",
}

otf.enhancers["check math parameters"] = function(data,filename)
    local mathdata = data.metadata.math
    if mathdata then
        for m=1,#private_math_parameters do
            local pmp = private_math_parameters[m]
            if not mathdata[pmp] then
                if trace_loading then
                    logs.report("load otf", "setting math parameter '%s' to 0", pmp)
                end
                mathdata[pmp] = 0
            end
        end
    end
end

otf.enhancers["flatten glyph lookups"] = function(data,filename)
    for k, v in next, data.glyphs do
        local lookups = v.lookups
        if lookups then
            for kk, vv in next, lookups do
                for kkk=1,#vv do
                    local vvv = vv[kkk]
                    local s = vvv.specification
                    if s then
                        local t = vvv.type
                        if t == "ligature" then
                            vv[kkk] = { "ligature", s.components, s.char }
                        elseif t == "alternate" then
                            vv[kkk] = { "alternate", s.components }
                        elseif t == "substitution" then
                            vv[kkk] = { "substitution", s.variant }
                        elseif t == "multiple" then
                            vv[kkk] = { "multiple", s.components }
                        elseif t == "position" then
                            vv[kkk] = { "position", { s.x or 0, s.y or 0, s.h or 0, s.v or 0 } }
                        elseif t == "pair" then
                            local one, two, paired = s.offsets[1], s.offsets[2], s.paired or ""
                            if one then
                                if two then
                                    vv[kkk] = { "pair", paired, { one.x or 0, one.y or 0, one.h or 0, one.v or 0 }, { two.x or 0, two.y or 0, two.h or 0, two.v or 0 } }
                                else
                                    vv[kkk] = { "pair", paired, { one.x or 0, one.y or 0, one.h or 0, one.v or 0 } }
                                end
                            else
                                if two then
                                    vv[kkk] = { "pair", paired, { }, { two.x or 0, two.y or 0, two.h or 0, two.v or 0} } -- maybe nil instead of { }
                                else
                                    vv[kkk] = { "pair", paired }
                                end
                            end
                        else
                            if trace_loading then
                                logs.report("load otf", "flattening needed, report to context list")
                            end
                            for a, b in next, s do
                                if trace_loading and vvv[a] then
                                    logs.report("load otf", "flattening conflict, report to context list")
                                end
                                vvv[a] = b
                            end
                            vvv.specification = nil
                        end
                    end
                end
            end
        end
    end
end

otf.enhancers["simplify glyph lookups"] = function(data,filename)
    for k, v in next, data.glyphs do
        local lookups = v.lookups
        if lookups then
            local slookups, mlookups
            for kk, vv in next, lookups do
                if #vv == 1 then
                    if not slookups then
                        slookups = { }
                        v.slookups = slookups
                    end
                    slookups[kk] = vv[1]
                else
                    if not mlookups then
                        mlookups = { }
                        v.mlookups = mlookups
                    end
                    mlookups[kk] = vv
                end
            end
            v.lookups = nil
        end
    end
end

otf.enhancers["flatten anchor tables"] = function(data,filename)
    for k, v in next, data.glyphs do
        if v.anchors then
            for kk, vv in next, v.anchors do
                for kkk, vvv in next, vv do
                    if vvv.x or vvv.y then
                        vv[kkk] = { vvv.x or 0, vvv.y or 0 }
                    else
                        for kkkk=1,#vvv do
                            local vvvv = vvv[kkkk]
                            vvv[kkkk] = { vvvv.x or 0, vvvv.y or 0 }
                        end
                    end
                end
            end
        end
    end
end

otf.enhancers["flatten feature tables"] = function(data,filename)
    -- is this needed? do we still use them at all?
    for _, tag in next, otf.glists do
        if data[tag] then
            if trace_loading then
                logs.report("load otf", "flattening %s table", tag)
            end
            for k, v in next, data[tag] do
                local features = v.features
                if features then
                    for kk=1,#features do
                        local vv = features[kk]
                        local t = { }
                        local scripts = vv.scripts
                        for kkk=1,#scripts do
                            local vvv = scripts[kkk]
                            t[vvv.script] = vvv.langs
                        end
                        vv.scripts = t
                    end
                end
            end
        end
    end
end

otf.enhancers.patches = otf.enhancers.patches or { }

otf.enhancers["patch bugs"] = function(data,filename)
    local basename = file.basename(lower(filename))
    for pattern, action in next, otf.enhancers.patches do
        if find(basename,pattern) then
            action(data,filename)
        end
    end
end

-- tex features

fonts.otf.enhancers["enrich with features"] = function(data,filename)
    -- later, ctx only
end

function otf.features.register(name,default)
    otf.features.list[#otf.features.list+1] = name
    otf.features.default[name] = default
end

-- for context this will become a task handler

function otf.set_features(tfmdata,features)
    local processes = { }
    if features and next(features) then
        local lists = { -- why local
            fonts.triggers,
            fonts.processors,
            fonts.manipulators,
        }
        local mode = tfmdata.mode or fonts.mode -- or features.mode
        local initializers = fonts.initializers
        local fi = initializers[mode]
        if fi then
            local fiotf = fi.otf
            if fiotf then
                local done = { }
                for l=1,4 do
                    local list = lists[l]
                    if list then
                        for i=1,#list do
                            local f = list[i]
                            local value = features[f]
                            if value and fiotf[f] then -- brr
                                if not done[f] then -- so, we can move some to triggers
                                    if trace_features then
                                        logs.report("define otf","initializing feature %s to %s for mode %s for font %s",f,tostring(value),mode or 'unknown', tfmdata.fullname or 'unknown')
                                    end
                                    fiotf[f](tfmdata,value) -- can set mode (no need to pass otf)
                                    mode = tfmdata.mode or fonts.mode -- keep this, mode can be set local !
                                    local im = initializers[mode]
                                    if im then
                                        fiotf = initializers[mode].otf
                                    end
                                    done[f] = true
                                end
                            end
                        end
                    end
                end
            end
        end
        local fm = fonts.methods[mode] -- todo: zonder node/mode otf/...
        if fm then
            local fmotf = fm.otf
            if fmotf then
                for l=1,4 do
                    local list = lists[l]
                    if list then
                        for i=1,#list do
                            local f = list[i]
                            if fmotf[f] then -- brr
                                if trace_features then
                                    logs.report("define otf","installing feature handler %s for mode %s for font %s",f,mode or 'unknown', tfmdata.fullname or 'unknown')
                                end
                                processes[#processes+1] = fmotf[f]
                            end
                        end
                    end
                end
            end
        else
            -- message
        end
    end
    return processes, features
end

function otf.otf_to_tfm(specification)
    local name     = specification.name
    local sub      = specification.sub
    local filename = specification.filename
    local format   = specification.format
    local features = specification.features.normal
    local cache_id = specification.hash
    local tfmdata  = containers.read(tfm.cache,cache_id)
--~ print(cache_id)
    if not tfmdata then
        local otfdata = otf.load(filename,format,sub,features and features.featurefile)
        if otfdata and next(otfdata) then
            otfdata.shared = otfdata.shared or {
                featuredata = { },
                anchorhash  = { },
                initialized = false,
            }
            tfmdata = otf.copy_to_tfm(otfdata,cache_id)
            if tfmdata and next(tfmdata) then
                tfmdata.unique = tfmdata.unique or { }
                tfmdata.shared = tfmdata.shared or { } -- combine
                local shared = tfmdata.shared
                shared.otfdata = otfdata
                shared.features = features -- default
                shared.dynamics = { }
                shared.processes = { }
                shared.set_dynamics = otf.set_dynamics -- fast access and makes other modules independent
                -- this will be done later anyway, but it's convenient to have
                -- them already for fast access
                tfmdata.luatex = otfdata.luatex
                tfmdata.indices = otfdata.luatex.indices
                tfmdata.unicodes = otfdata.luatex.unicodes
                tfmdata.marks = otfdata.luatex.marks
                tfmdata.originals = otfdata.luatex.originals
                tfmdata.changed = { }
                tfmdata.has_italic = otfdata.metadata.has_italic
                if not tfmdata.language then tfmdata.language = 'dflt' end
                if not tfmdata.script   then tfmdata.script   = 'dflt' end
                shared.processes, shared.features = otf.set_features(tfmdata,fonts.define.check(features,otf.features.default))
            end
        end
        containers.write(tfm.cache,cache_id,tfmdata)
    end
    return tfmdata
end

--~ {
--~  ['boundingbox']={ 95, -458, 733, 1449 },
--~  ['class']="base",
--~  ['name']="braceleft",
--~  ['unicode']=123,
--~  ['vert_variants']={
--~   ['italic_correction']=0,
--~   ['parts']={
--~    { ['component']="uni23A9", ['endConnectorLength']=1000, ['fullAdvance']=2546, ['is_extender']=0, ['startConnectorLength']=0,    }, -- bot
--~    { ['component']="uni23AA", ['endConnectorLength']=2500, ['fullAdvance']=2501, ['is_extender']=1, ['startConnectorLength']=2500, }, -- rep
--~    { ['component']="uni23A8", ['endConnectorLength']=1000, ['fullAdvance']=4688, ['is_extender']=0, ['startConnectorLength']=1000, }, -- mid
--~    { ['component']="uni23AA", ['endConnectorLength']=2500, ['fullAdvance']=2501, ['is_extender']=1, ['startConnectorLength']=2500, }, -- rep
--~    { ['component']="uni23A7", ['endConnectorLength']=0,    ['fullAdvance']=2546, ['is_extender']=0, ['startConnectorLength']=1000, }, -- top
--~   },
--~   ['variants']="braceleft braceleft.vsize1 braceleft.vsize2 braceleft.vsize3 braceleft.vsize4 braceleft.vsize5 braceleft.vsize6 braceleft.vsize7",
--~  },
--~  ['width']=793,
--~ },

-- the first version made a top/mid/not extensible table, now we just pass on the variants data
-- and deal with it in the tfm scaler (there is no longer an extensible table anyway)

-- we cannot share descriptions as virtual fonts might extend them (ok, we could
-- use a cache with a hash

fonts.formats.dfont = "truetype"
fonts.formats.ttc   = "truetype"
fonts.formats.ttf   = "truetype"
fonts.formats.otf   = "opentype"

function otf.copy_to_tfm(data,cache_id) -- we can save a copy when we reorder the tma to unicode (nasty due to one->many)
    if data then
        local glyphs, pfminfo, metadata = data.glyphs or { }, data.pfminfo or { }, data.metadata or { }
        local luatex = data.luatex
        local unicodes = luatex.unicodes -- names to unicodes
        local indices = luatex.indices
        local characters, parameters, math_parameters, descriptions = { }, { }, { }, { }
        local designsize = metadata.designsize or metadata.design_size or 100
        if designsize == 0 then
            designsize = 100
        end
        local spaceunits, spacer = 500, "space"
        -- indices maps from unicodes to indices
        for u, i in next, indices do
            characters[u] = { } -- we need this because for instance we add protruding info and loop over characters
            descriptions[u] = glyphs[i]
        end
        -- math
        if metadata.math then
            -- parameters
            for name, value in next, metadata.math do
                math_parameters[name] = value
            end
            -- we could use a subset
            for u, char in next, characters do
                local d = descriptions[u]
                local m = d.math
                -- we have them shared because that packs nicer
                -- we could prepare the variants and keep 'm in descriptions
                if m then
                    local variants, parts, c, uc = m.horiz_variants, m.horiz_parts, char, u
                    if variants then
                        for n in gmatch(variants,"[^ ]+") do
                            local un = unicodes[n]
                            if un and uc ~= un then
                                c.next = un
                                c = characters[un]
				uc = un
                            end
                        end
                        c.horiz_variants = parts
                    elseif parts then
                        c.horiz_variants = parts
                    end
                    local variants, parts, c, uc = m.vert_variants, m.vert_parts, char, u
                    if variants then
                        for n in gmatch(variants,"[^ ]+") do
                            local un = unicodes[n]
                            if un and uc ~= un then
                                c.next = un
                                c = characters[un]
				uc = un
                            end
                        end -- c is now last in chain
                        c.vert_variants = parts
                    elseif parts then
                        c.vert_variants = parts
                    end
                    local italic_correction = m.vert_italic_correction
                    if italic_correction then
                        c.vert_italic_correction = italic_correction
                    end
                    local kerns = m.kerns
                    if kerns then
                        char.mathkerns = kerns
                    end
                end
            end
        end
        -- end math
        local endash, emdash, space = 0x20, 0x2014, "space" -- unicodes['space'], unicodes['emdash']
        if metadata.isfixedpitch then
            if descriptions[endash] then
                spaceunits, spacer = descriptions[endash].width, "space"
            end
            if not spaceunits and descriptions[emdash] then
                spaceunits, spacer = descriptions[emdash].width, "emdash"
            end
            if not spaceunits and metadata.charwidth then
                spaceunits, spacer = metadata.charwidth, "charwidth"
            end
        else
            if descriptions[endash] then
                spaceunits, spacer = descriptions[endash].width, "space"
            end
            if not spaceunits and descriptions[emdash] then
                spaceunits, spacer = descriptions[emdash].width/2, "emdash/2"
            end
            if not spaceunits and metadata.charwidth then
                spaceunits, spacer = metadata.charwidth, "charwidth"
            end
        end
        spaceunits = tonumber(spaceunits) or tfm.units/2 -- 500 -- brrr
        -- we need a runtime lookup because of running from cdrom or zip, brrr (shouldn't we use the basename then?)
        local filename = fonts.tfm.checked_filename(luatex)
        local fontname = metadata.fontname
        local fullname = metadata.fullname or fontname
        local cidinfo  = data.cidinfo
        local units    = metadata.units_per_em or 1000
        --
        cidinfo.registry = cidinfo and cidinfo.registry or "" -- weird here, fix upstream
        --
        parameters.slant         = 0
        parameters.space         = spaceunits          -- 3.333 (cmr10)
        parameters.space_stretch = units/2   --  500   -- 1.666 (cmr10)
        parameters.space_shrink  = 1*units/3 --  333   -- 1.111 (cmr10)
        parameters.x_height      = 2*units/5 --  400
        parameters.quad          = units     -- 1000
        if spaceunits < 2*units/5 then
            -- todo: warning
        end
        local italicangle = metadata.italicangle
        if italicangle then -- maybe also in afm _
            parameters.slant = parameters.slant - math.round(math.tan(italicangle*math.pi/180))
        end
        if metadata.isfixedpitch then
            parameters.space_stretch = 0
            parameters.space_shrink  = 0
        elseif otf.syncspace then --
            parameters.space_stretch = spaceunits/2
            parameters.space_shrink  = spaceunits/3
        end
        parameters.extra_space = parameters.space_shrink -- 1.111 (cmr10)
        if pfminfo.os2_xheight and pfminfo.os2_xheight > 0 then
            parameters.x_height = pfminfo.os2_xheight
        else
            local x = 0x78 -- unicodes['x']
            if x then
                local x = descriptions[x]
                if x then
                    parameters.x_height = x.height
                end
            end
        end
        --
        return {
            characters         = characters,
            parameters         = parameters,
            math_parameters    = math_parameters,
            descriptions       = descriptions,
            indices            = indices,
            unicodes           = unicodes,
            type               = "real",
            direction          = 0,
            boundarychar_label = 0,
            boundarychar       = 65536,
            designsize         = (designsize/10)*65536,
            spacer             = "500 units",
            encodingbytes      = 2,
            filename           = filename,
            fontname           = fontname,
            fullname           = fullname,
            psname             = fontname or fullname,
            name               = filename or fullname,
            units              = units,
            format             = fonts.fontformat(filename,"opentype"),
            cidinfo            = cidinfo,
            ascender           = abs(metadata.ascent  or 0),
            descender          = abs(metadata.descent or 0),
            spacer             = spacer,
            italicangle        = italicangle,
        }
    else
        return nil
    end
end

otf.features.register('mathsize')

function tfm.read_from_open_type(specification)
    local tfmtable = otf.otf_to_tfm(specification)
    if tfmtable then
        local otfdata = tfmtable.shared.otfdata
        tfmtable.name = specification.name
        tfmtable.sub = specification.sub
        local s = specification.size
        local m = otfdata.metadata.math
        if m then
            -- this will move to a function
            local f = specification.features
            if f then
                local f = f.normal
                if f and f.mathsize then
                    local mathsize = specification.mathsize or 0
                    if mathsize == 2 then
                        local p = m.ScriptPercentScaleDown
                        if p then
                            local ps = p * specification.textsize / 100
                            if trace_math then
                                logs.report("define font","asked script size: %s, used: %s (%2.2f %%)",s,ps,(ps/s)*100)
                            end
                            s = ps
                        end
                    elseif mathsize == 3 then
                        local p = m.ScriptScriptPercentScaleDown
                        if p then
                            local ps = p * specification.textsize / 100
                            if trace_math then
                                logs.report("define font","asked scriptscript size: %s, used: %s (%2.2f %%)",s,ps,(ps/s)*100)
                            end
                            s = ps
                        end
                    end
                end
            end
        end
        tfmtable = tfm.scale(tfmtable,s,specification.relativeid)
        if tfm.fontname_mode == "specification" then
            -- not to be used in context !
            local specname = specification.specification
            if specname then
                tfmtable.name = specname
                if trace_defining then
                    logs.report("define font","overloaded fontname: '%s'",specname)
                end
            end
        end
        fonts.logger.save(tfmtable,file.extname(specification.filename),specification)
    end
--~ print(tfmtable.fullname)
    return tfmtable
end

-- helpers

function otf.collect_lookups(otfdata,kind,script,language)
    -- maybe store this in the font
    local sequences = otfdata.luatex.sequences
    if sequences then
        local featuremap, featurelist = { }, { }
        for s=1,#sequences do
            local sequence = sequences[s]
            local features = sequence.features
            features = features and features[kind]
            features = features and (features[script]   or features[default] or features[wildcard])
            features = features and (features[language] or features[default] or features[wildcard])
            if features then
                local subtables = sequence.subtables
                if subtables then
                    for s=1,#subtables do
                        local ss = subtables[s]
                        if not featuremap[s] then
                            featuremap[ss] = true
                            featurelist[#featurelist+1] = ss
                        end
                    end
                end
            end
        end
        if #featurelist > 0 then
            return featuremap, featurelist
        end
    end
    return nil, nil
end
