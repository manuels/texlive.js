if not modules then modules = { } end modules ['font-otc'] = {
    version   = 1.001,
    comment   = "companion to font-otf.lua (context)",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local format, insert = string.format, table.insert
local type, next = type, next

-- we assume that the other otf stuff is loaded already

local trace_loading = false  trackers.register("otf.loading", function(v) trace_loading = v end)

local otf = fonts.otf
local tfm = fonts.tfm

-- instead of "script = "DFLT", langs = { 'dflt' }" we now use wildcards (we used to
-- have always); some day we can write a "force always when true" trick for other
-- features as well
--
-- we could have a tnum variant as well

local extra_lists = {
    tlig = {
        {
            endash        = "hyphen hyphen",
            emdash        = "hyphen hyphen hyphen",
            quotedblleft  = "quoteleft quoteleft",
            quotedblright = "quoteright quoteright",
            quotedblleft  = "grave grave",
            quotedblright = "quotesingle quotesingle",
            quotedblbase  = "comma comma",
            exclamdown    = "exclam grave",
            questiondown  = "question grave",
            guillemotleft = "less less",
            guillemotright= "greater greater",
        },
    },
    trep = {
        {
            [0x0022] = 0x201D,
            [0x0027] = 0x2019,
            [0x0060] = 0x2018,
        },
    },
    anum = {
        { -- arabic
            [0x0030] = 0x0660,
            [0x0031] = 0x0661,
            [0x0032] = 0x0662,
            [0x0033] = 0x0663,
            [0x0034] = 0x0664,
            [0x0035] = 0x0665,
            [0x0036] = 0x0666,
            [0x0037] = 0x0667,
            [0x0038] = 0x0668,
            [0x0039] = 0x0669,
        },
        { -- persian
            [0x0030] = 0x06F0,
            [0x0031] = 0x06F1,
            [0x0032] = 0x06F2,
            [0x0033] = 0x06F3,
            [0x0034] = 0x06F4,
            [0x0035] = 0x06F5,
            [0x0036] = 0x06F6,
            [0x0037] = 0x06F7,
            [0x0038] = 0x06F8,
            [0x0039] = 0x06F9,
        },
    },
}

local extra_features = { -- maybe just 1..n so that we prescribe order
    tlig = {
        {
            features  = { { scripts = { { script = "*", langs = { "*" }, } }, tag = "tlig", comment = "added bij mkiv" }, },
            name      = "ctx_tlig_1",
            subtables = { { name = "ctx_tlig_1_s" } },
            type      = "gsub_ligature",
            flags     = { },
        },
    },
    trep = {
        {
            features  = { { scripts = { { script = "*", langs = { "*" }, } }, tag = "trep", comment = "added bij mkiv" }, },
            name      = "ctx_trep_1",
            subtables = { { name = "ctx_trep_1_s" } },
            type      = "gsub_single",
            flags     = { },
        },
    },
    anum = {
        {
            features  = { { scripts = { { script = "arab", langs = { "dflt", "ARA" }, } }, tag = "anum", comment = "added bij mkiv" }, },
            name      = "ctx_anum_1",
            subtables = { { name = "ctx_anum_1_s" } },
            type      = "gsub_single",
            flags     = { },
        },
        {
            features  = { { scripts = { { script = "arab", langs = { "FAR" }, } }, tag = "anum", comment = "added bij mkiv" }, },
            name      = "ctx_anum_2",
            subtables = { { name = "ctx_anum_2_s" } },
            type      = "gsub_single",
            flags     = { },
        },
    },
}

fonts.otf.enhancers["add some missing characters"] = function(data,filename)
    -- todo
end

fonts.otf.enhancers["enrich with features"] = function(data,filename)
    -- could be done elsewhere (true can be #)
    local used = { }
    for i=1,#otf.glists do
        local g = data[otf.glists[i]]
        if g then
            for i=1,#g do
                local f = g[i].features
                if f then
                    for i=1,#f do
                        local t = f[i].tag
                        if t then used[t] = true end
                    end
                end
            end
        end
    end
    --
    local glyphs = data.glyphs
    local indices = data.map.map
    data.gsub = data.gsub or { }
    for kind, specifications in next, extra_features do
        if not used[kind] then
            local done = 0
            for s=1,#specifications do
                local added = false
                local specification = specifications[s]
                local list = extra_lists[kind][s]
                local name = specification.name .. "_s"
                if specification.type == "gsub_ligature" then
                    for unicode, index in next, indices do
                        local glyph = glyphs[index]
                        local ligature = list[glyph.name]
                        if ligature then
                            local o = glyph.lookups or { }
                        --  o[name] = { "ligature", ligature, glyph.name }
                            o[name] = {
                                {
                                    ["type"] = "ligature",
                                    ["specification"] = {
                                        char = glyph.name,
                                        components = ligature,
                                    }
                                }
                            }
                            glyph.lookups, done, added = o, done+1, true
                        end
                    end
                elseif specification.type == "gsub_single" then
                    for unicode, index in next, indices do
                        local glyph = glyphs[index]
                        local r = list[unicode]
                        if r then
                            local replacement = indices[r]
                            if replacement and glyphs[replacement] then
                                local o = glyph.lookups or { }
                            --  o[name] = { { "substitution", glyphs[replacement].name } }
                                o[name] = {
                                    {
                                        ["type"] = "substitution",
                                        ["specification"] = {
                                            variant = glyphs[replacement].name,
                                        }
                                    }
                                }
                                glyph.lookups, done, added = o, done+1, true
                            end
                        end
                    end
                end
                if added then
                    insert(data.gsub,s,table.fastcopy(specification)) -- right order
                end
            end
            if done > 0 then
                if trace_loading then
                    logs.report("load otf","enhance: registering %s feature (%s glyphs affected)",kind,done)
                end
            end
        end
    end
end

otf.tables.features['tlig'] = 'TeX Ligatures'
otf.tables.features['trep'] = 'TeX Replacements'
otf.tables.features['anum'] = 'Arabic Digits'

otf.features.register_base_substitution('tlig')
otf.features.register_base_substitution('trep')
otf.features.register_base_substitution('anum')

-- the functionality is defined elsewhere

fonts.initializers.base.otf.equaldigits = fonts.initializers.common.equaldigits
fonts.initializers.node.otf.equaldigits = fonts.initializers.common.equaldigits

fonts.initializers.base.otf.lineheight  = fonts.initializers.common.lineheight
fonts.initializers.node.otf.lineheight  = fonts.initializers.common.lineheight

fonts.initializers.base.otf.compose     = fonts.initializers.common.compose
fonts.initializers.node.otf.compose     = fonts.initializers.common.compose
