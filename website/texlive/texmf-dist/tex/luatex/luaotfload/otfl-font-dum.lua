if not modules then modules = { } end modules ['font-dum'] = {
    version   = 1.001,
    comment   = "companion to luatex-*.tex",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

fonts = fonts or { }

-- general

fonts.otf.pack          = false
fonts.tfm.resolve_vf    = false -- no sure about this
fonts.tfm.fontname_mode = "specification" -- somehow latex needs this

-- readers

fonts.tfm.readers          = fonts.tfm.readers or { }
fonts.tfm.readers.sequence = { 'otf', 'ttf', 'tfm' }
fonts.tfm.readers.afm      = nil

-- define

fonts.define = fonts.define or { }

--~ fonts.define.method = "tfm"

fonts.define.specify.colonized_default_lookup = "name"

function fonts.define.get_specification(str)
    return "", str, "", ":", str
end

-- logger

fonts.logger = fonts.logger or { }

function fonts.logger.save()
end

-- names
--
-- Watch out, the version number is the same as the one used in
-- the mtx-fonts.lua function scripts.fonts.names as we use a
-- simplified font database in the plain solution and by using
-- a different number we're less dependent on context.

fonts.names = fonts.names or { }

fonts.names.version    = 1.001 -- not the same as in context
fonts.names.basename   = "luatex-fonts-names.lua"
fonts.names.new_to_old = { }
fonts.names.old_to_new = { }

local data, loaded = nil, false

local fileformats = { "lua", "tex", "other text files" }

function fonts.names.resolve(name,sub)
    if not loaded then
        local basename = fonts.names.basename
        if basename and basename ~= "" then
            for i=1,#fileformats do
                local format = fileformats[i]
                local foundname = resolvers.find_file(basename,format) or ""
                if foundname ~= "" then
                    data = dofile(foundname)
                    break
                end
            end
        end
        loaded = true
    end
    if type(data) == "table" and data.version == fonts.names.version then
        local condensed = string.gsub(string.lower(name),"[^%a%d]","")
        local found = data.mappings and data.mappings[condensed]
        if found then
            local fontname, filename, subfont = found[1], found[2], found[3]
            if subfont then
                return filename, fontname
            else
                return filename, false
            end
        else
            return name, false -- fallback to filename
        end
    end
end

fonts.names.resolvespec = fonts.names.resolve -- only supported in mkiv

-- For the moment we put this (adapted) pseudo feature here.

table.insert(fonts.triggers,"itlc")

local function itlc(tfmdata,value)
    if value then
        -- the magic 40 and it formula come from Dohyun Kim
        local metadata = tfmdata.shared.otfdata.metadata
        if metadata then
            local italicangle = metadata.italicangle
            if italicangle and italicangle ~= 0 then
                local uwidth = (metadata.uwidth or 40)/2
                for unicode, d in next, tfmdata.descriptions do
                    local it = d.boundingbox[3] - d.width + uwidth
                    if it ~= 0 then
                        d.italic = it
                    end
                end
                tfmdata.has_italic = true
            end
        end
    end
end

fonts.initializers.base.otf.itlc = itlc
fonts.initializers.node.otf.itlc = itlc

-- slant and extend

function fonts.initializers.common.slant(tfmdata,value)
    value = tonumber(value)
    if not value then
        value =  0
    elseif value >  1 then
        value =  1
    elseif value < -1 then
        value = -1
    end
    tfmdata.slant_factor = value
end

function fonts.initializers.common.extend(tfmdata,value)
    value = tonumber(value)
    if not value then
        value =  0
    elseif value >  10 then
        value =  10
    elseif value < -10 then
        value = -10
    end
    tfmdata.extend_factor = value
end

table.insert(fonts.triggers,"slant")
table.insert(fonts.triggers,"extend")

fonts.initializers.base.otf.slant  = fonts.initializers.common.slant
fonts.initializers.node.otf.slant  = fonts.initializers.common.slant
fonts.initializers.base.otf.extend = fonts.initializers.common.extend
fonts.initializers.node.otf.extend = fonts.initializers.common.extend

-- expansion and protrusion

fonts.protrusions        = fonts.protrusions        or { }
fonts.protrusions.setups = fonts.protrusions.setups or { }

local setups  = fonts.protrusions.setups

-- As this is experimental code, users should not depend on it. The
-- implications are still discussed on the ConTeXt Dev List and we're
-- not sure yet what exactly the spec is (the next code is tested with
-- a gyre font patched by / fea file made by Khaled Hosny). The double
-- trick should not be needed it proper hanging punctuation is used in
-- which case values < 1 can be used.
--
-- preferred (in context, usine vectors):
--
-- \definefontfeature[whatever][default][mode=node,protrusion=quality]
--
-- using lfbd and rtbd, with possibibility to enable only one side :
--
-- \definefontfeature[whocares][default][mode=node,protrusion=yes,  opbd=yes,script=latn]
-- \definefontfeature[whocares][default][mode=node,protrusion=right,opbd=yes,script=latn]
--
-- idem, using multiplier
--
-- \definefontfeature[whocares][default][mode=node,protrusion=2,opbd=yes,script=latn]
-- \definefontfeature[whocares][default][mode=node,protrusion=double,opbd=yes,script=latn]
--
-- idem, using named feature file (less frozen):
--
-- \definefontfeature[whocares][default][mode=node,protrusion=2,opbd=yes,script=latn,featurefile=texgyrepagella-regularxx.fea]

local function map_opbd_onto_protrusion(tfmdata,value,opbd)
    local characters, descriptions = tfmdata.characters, tfmdata.descriptions
    local otfdata = tfmdata.shared.otfdata
    local singles = otfdata.shared.featuredata.gpos_single
    local script, language = tfmdata.script, tfmdata.language
    local done, factor, left, right = false, 1, 1, 1
    local setup = setups[value]
    if setup then
        factor = setup.factor or 1
        left   = setup.left   or 1
        right  = setup.right  or 1
    else
        factor = tonumber(value) or 1
    end
    if opbd ~= "right" then
        local validlookups, lookuplist = fonts.otf.collect_lookups(otfdata,"lfbd",script,language)
        if validlookups then
            for i=1,#lookuplist do
                local lookup = lookuplist[i]
                local data = singles[lookup]
                if data then
                    if trace_protrusion then
                        logs.report("fonts","set left protrusion using lfbd lookup '%s'",lookup)
                    end
                    for k, v in next, data do
                    --  local p = - v[3] / descriptions[k].width-- or 1 ~= 0 too but the same
                        local p = - (v[1] / 1000) * factor * left
                        characters[k].left_protruding = p
                        if trace_protrusion then
                            logs.report("opbd","lfbd -> %s -> 0x%05X (%s) -> %0.03f (%s)",lookup,k,utfchar(k),p,concat(v," "))
                        end
                    end
                    done = true
                end
            end
        end
    end
    if opbd ~= "left" then
        local validlookups, lookuplist = fonts.otf.collect_lookups(otfdata,"rtbd",script,language)
        if validlookups then
            for i=1,#lookuplist do
                local lookup = lookuplist[i]
                local data = singles[lookup]
                if data then
                    if trace_protrusion then
                        logs.report("fonts","set right protrusion using rtbd lookup '%s'",lookup)
                    end
                    for k, v in next, data do
                    --  local p = v[3] / descriptions[k].width -- or 3
                        local p = (v[1] / 1000) * factor * right
                        characters[k].right_protruding = p
                        if trace_protrusion then
                            logs.report("opbd","rtbd -> %s -> 0x%05X (%s) -> %0.03f (%s)",lookup,k,utfchar(k),p,concat(v," "))
                        end
                    end
                end
                done = true
            end
        end
    end
    tfmdata.auto_protrude = done
end

-- The opbd test is just there because it was discussed on the
-- context development list. However, the mentioned fxlbi.otf font
-- only has some kerns for digits. So, consider this feature not
-- supported till we have a proper test font.

function fonts.initializers.common.protrusion(tfmdata,value)
    if value then
        local opbd = tfmdata.shared.features.opbd
        if opbd then
            -- possible values: left right both yes no (experimental)
            map_opbd_onto_protrusion(tfmdata,value,opbd)
        elseif value then
            local setup = setups[value]
            if setup then
                local factor, left, right = setup.factor or 1, setup.left or 1, setup.right or 1
                local emwidth = tfmdata.parameters.quad
                tfmdata.auto_protrude = true
                for i, chr in next, tfmdata.characters do
                    local v, pl, pr = setup[i], nil, nil
                    if v then
                        pl, pr = v[1], v[2]
                    end
                    if pl and pl ~= 0 then chr.left_protruding  = left *pl*factor end
                    if pr and pr ~= 0 then chr.right_protruding = right*pr*factor end
                end
            end
        end
    end
end

fonts.expansions         = fonts.expansions        or { }
fonts.expansions.setups  = fonts.expansions.setups or { }

local setups = fonts.expansions.setups

function fonts.initializers.common.expansion(tfmdata,value)
    if value then
        local setup = setups[value]
        if setup then
            local stretch, shrink, step, factor = setup.stretch or 0, setup.shrink or 0, setup.step or 0, setup.factor or 1
            tfmdata.stretch, tfmdata.shrink, tfmdata.step, tfmdata.auto_expand = stretch * 10, shrink * 10, step * 10, true
            for i, chr in next, tfmdata.characters do
                local v = setup[i]
                if v and v ~= 0 then
                    chr.expansion_factor = v*factor
                else -- can be option
                    chr.expansion_factor = factor
                end
            end
        end
    end
end

table.insert(fonts.manipulators,"protrusion")
table.insert(fonts.manipulators,"expansion")

fonts.initializers.base.otf.protrusion = fonts.initializers.common.protrusion
fonts.initializers.node.otf.protrusion = fonts.initializers.common.protrusion
fonts.initializers.base.otf.expansion  = fonts.initializers.common.expansion
fonts.initializers.node.otf.expansion  = fonts.initializers.common.expansion

-- left over

function fonts.register_message()
end

-- example vectors

local byte = string.byte

fonts.expansions.setups['default'] = {

    stretch = 2, shrink = 2, step = .5, factor = 1,

    [byte('A')] = 0.5, [byte('B')] = 0.7, [byte('C')] = 0.7, [byte('D')] = 0.5, [byte('E')] = 0.7,
    [byte('F')] = 0.7, [byte('G')] = 0.5, [byte('H')] = 0.7, [byte('K')] = 0.7, [byte('M')] = 0.7,
    [byte('N')] = 0.7, [byte('O')] = 0.5, [byte('P')] = 0.7, [byte('Q')] = 0.5, [byte('R')] = 0.7,
    [byte('S')] = 0.7, [byte('U')] = 0.7, [byte('W')] = 0.7, [byte('Z')] = 0.7,
    [byte('a')] = 0.7, [byte('b')] = 0.7, [byte('c')] = 0.7, [byte('d')] = 0.7, [byte('e')] = 0.7,
    [byte('g')] = 0.7, [byte('h')] = 0.7, [byte('k')] = 0.7, [byte('m')] = 0.7, [byte('n')] = 0.7,
    [byte('o')] = 0.7, [byte('p')] = 0.7, [byte('q')] = 0.7, [byte('s')] = 0.7, [byte('u')] = 0.7,
    [byte('w')] = 0.7, [byte('z')] = 0.7,
    [byte('2')] = 0.7, [byte('3')] = 0.7, [byte('6')] = 0.7, [byte('8')] = 0.7, [byte('9')] = 0.7,
}

fonts.protrusions.setups['default'] = {

    factor = 1, left = 1, right = 1,

    [0x002C] = { 0, 1    }, -- comma
    [0x002E] = { 0, 1    }, -- period
    [0x003A] = { 0, 1    }, -- colon
    [0x003B] = { 0, 1    }, -- semicolon
    [0x002D] = { 0, 1    }, -- hyphen
    [0x2013] = { 0, 0.50 }, -- endash
    [0x2014] = { 0, 0.33 }, -- emdash
    [0x3001] = { 0, 1    }, -- ideographic comma      、
    [0x3002] = { 0, 1    }, -- ideographic full stop  。
    [0x060C] = { 0, 1    }, -- arabic comma           ،
    [0x061B] = { 0, 1    }, -- arabic semicolon       ؛
    [0x06D4] = { 0, 1    }, -- arabic full stop       ۔

}

-- normalizer

fonts.otf.meanings = fonts.otf.meanings or { }

fonts.otf.meanings.normalize = fonts.otf.meanings.normalize or function(t)
    if t.rand then
        t.rand = "random"
    end
end

-- bonus

function fonts.otf.name_to_slot(name)
    local tfmdata = fonts.ids[font.current()]
    if tfmdata and tfmdata.shared then
        local otfdata = tfmdata.shared.otfdata
        local unicode = otfdata.luatex.unicodes[name]
        return unicode and (type(unicode) == "number" and unicode or unicode[1])
    end
end

function fonts.otf.char(n)
    if type(n) == "string" then
        n = fonts.otf.name_to_slot(n)
    end
    if type(n) == "number" then
        tex.sprint("\\char" .. n)
    end
end

-- another one:

fonts.strippables = table.tohash {
    0x000AD, 0x017B4, 0x017B5, 0x0200B, 0x0200C, 0x0200D, 0x0200E, 0x0200F, 0x0202A, 0x0202B,
    0x0202C, 0x0202D, 0x0202E, 0x02060, 0x02061, 0x02062, 0x02063, 0x0206A, 0x0206B, 0x0206C,
    0x0206D, 0x0206E, 0x0206F, 0x0FEFF, 0x1D173, 0x1D174, 0x1D175, 0x1D176, 0x1D177, 0x1D178,
    0x1D179, 0x1D17A, 0xE0001, 0xE0020, 0xE0021, 0xE0022, 0xE0023, 0xE0024, 0xE0025, 0xE0026,
    0xE0027, 0xE0028, 0xE0029, 0xE002A, 0xE002B, 0xE002C, 0xE002D, 0xE002E, 0xE002F, 0xE0030,
    0xE0031, 0xE0032, 0xE0033, 0xE0034, 0xE0035, 0xE0036, 0xE0037, 0xE0038, 0xE0039, 0xE003A,
    0xE003B, 0xE003C, 0xE003D, 0xE003E, 0xE003F, 0xE0040, 0xE0041, 0xE0042, 0xE0043, 0xE0044,
    0xE0045, 0xE0046, 0xE0047, 0xE0048, 0xE0049, 0xE004A, 0xE004B, 0xE004C, 0xE004D, 0xE004E,
    0xE004F, 0xE0050, 0xE0051, 0xE0052, 0xE0053, 0xE0054, 0xE0055, 0xE0056, 0xE0057, 0xE0058,
    0xE0059, 0xE005A, 0xE005B, 0xE005C, 0xE005D, 0xE005E, 0xE005F, 0xE0060, 0xE0061, 0xE0062,
    0xE0063, 0xE0064, 0xE0065, 0xE0066, 0xE0067, 0xE0068, 0xE0069, 0xE006A, 0xE006B, 0xE006C,
    0xE006D, 0xE006E, 0xE006F, 0xE0070, 0xE0071, 0xE0072, 0xE0073, 0xE0074, 0xE0075, 0xE0076,
    0xE0077, 0xE0078, 0xE0079, 0xE007A, 0xE007B, 0xE007C, 0xE007D, 0xE007E, 0xE007F,
}

