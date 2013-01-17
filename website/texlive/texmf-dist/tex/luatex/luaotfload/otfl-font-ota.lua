if not modules then modules = { } end modules ['font-ota'] = {
    version   = 1.001,
    comment   = "companion to font-otf.lua (analysing)",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

-- this might become scrp-*.lua

local type, tostring, match, format, concat = type, tostring, string.match, string.format, table.concat

if not trackers then trackers = { register = function() end } end

local trace_analyzing = false  trackers.register("otf.analyzing",  function(v) trace_analyzing = v end)
local trace_cjk       = false  trackers.register("cjk.injections", function(v) trace_cjk       = v end)

trackers.register("cjk.analyzing","otf.analyzing")

fonts                        = fonts                        or { }
fonts.analyzers              = fonts.analyzers              or { }
fonts.analyzers.initializers = fonts.analyzers.initializers or { node = { otf = { } } }
fonts.analyzers.methods      = fonts.analyzers.methods      or { node = { otf = { } } }

local otf = fonts.otf
local tfm = fonts.tfm

local initializers = fonts.analyzers.initializers
local methods      = fonts.analyzers.methods

local glyph   = node.id('glyph')
local glue    = node.id('glue')
local penalty = node.id('penalty')

local set_attribute      = node.set_attribute
local has_attribute      = node.has_attribute
local traverse_id        = node.traverse_id
local traverse_node_list = node.traverse

local fontdata = fonts.ids
local state    = attributes.private('state')

local fcs = (fonts.color and fonts.color.set)   or function() end
local fcr = (fonts.color and fonts.color.reset) or function() end

local a_to_script   = otf.a_to_script
local a_to_language = otf.a_to_language

-- in the future we will use language/script attributes instead of the
-- font related value, but then we also need dynamic features which is
-- somewhat slower; and .. we need a chain of them

function fonts.initializers.node.otf.analyze(tfmdata,value,attr)
    local script, language
    if attr and attr > 0 then
        script, language = a_to_script[attr], a_to_language[attr]
    else
        script, language = tfmdata.script, tfmdata.language
    end
    local action = initializers[script]
    if action then
        if type(action) == "function" then
            return action(tfmdata,value)
        else
            local action = action[language]
            if action then
                return action(tfmdata,value)
            end
        end
    end
    return nil
end

function fonts.methods.node.otf.analyze(head,font,attr)
    local tfmdata = fontdata[font]
    local script, language
    if attr and attr > 0 then
        script, language = a_to_script[attr], a_to_language[attr]
    else
        script, language = tfmdata.script, tfmdata.language
    end
    local action = methods[script]
    if action then
        if type(action) == "function" then
            return action(head,font,attr)
        else
            action = action[language]
            if action then
                return action(head,font,attr)
            end
        end
    end
    return head, false
end

otf.features.register("analyze",true)   -- we always analyze
table.insert(fonts.triggers,"analyze")  -- we need a proper function for doing this

-- latin

fonts.analyzers.methods.latn = fonts.analyzers.aux.setstate

-- this info eventually will go into char-def

local zwnj = 0x200C
local zwj  = 0x200D

local isol = {
    [0x0600] = true, [0x0601] = true, [0x0602] = true, [0x0603] = true,
    [0x0608] = true, [0x060B] = true, [0x0621] = true, [0x0674] = true,
    [0x06DD] = true, [zwnj] = true,
}

local isol_fina = {
    [0x0622] = true, [0x0623] = true, [0x0624] = true, [0x0625] = true,
    [0x0627] = true, [0x0629] = true, [0x062F] = true, [0x0630] = true,
    [0x0631] = true, [0x0632] = true, [0x0648] = true, [0x0671] = true,
    [0x0672] = true, [0x0673] = true, [0x0675] = true, [0x0676] = true,
    [0x0677] = true, [0x0688] = true, [0x0689] = true, [0x068A] = true,
    [0x068B] = true, [0x068C] = true, [0x068D] = true, [0x068E] = true,
    [0x068F] = true, [0x0690] = true, [0x0691] = true, [0x0692] = true,
    [0x0693] = true, [0x0694] = true, [0x0695] = true, [0x0696] = true,
    [0x0697] = true, [0x0698] = true, [0x0699] = true, [0x06C0] = true,
    [0x06C3] = true, [0x06C4] = true, [0x06C5] = true, [0x06C6] = true,
    [0x06C7] = true, [0x06C8] = true, [0x06C9] = true, [0x06CA] = true,
    [0x06CB] = true, [0x06CD] = true, [0x06CF] = true, [0x06D2] = true,
    [0x06D3] = true, [0x06D5] = true, [0x06EE] = true, [0x06EF] = true,
    [0x0759] = true, [0x075A] = true, [0x075B] = true, [0x076B] = true,
    [0x076C] = true, [0x0771] = true, [0x0773] = true, [0x0774] = true,
	[0x0778] = true, [0x0779] = true, [0xFEF5] = true, [0xFEF7] = true,
	[0xFEF9] = true, [0xFEFB] = true,
}

local isol_fina_medi_init = {
    [0x0626] = true, [0x0628] = true, [0x062A] = true, [0x062B] = true,
    [0x062C] = true, [0x062D] = true, [0x062E] = true, [0x0633] = true,
    [0x0634] = true, [0x0635] = true, [0x0636] = true, [0x0637] = true,
    [0x0638] = true, [0x0639] = true, [0x063A] = true, [0x063B] = true,
    [0x063C] = true, [0x063D] = true, [0x063E] = true, [0x063F] = true,
    [0x0640] = true, [0x0641] = true, [0x0642] = true, [0x0643] = true,
    [0x0644] = true, [0x0645] = true, [0x0646] = true, [0x0647] = true,
    [0x0649] = true, [0x064A] = true, [0x066E] = true, [0x066F] = true,
    [0x0678] = true, [0x0679] = true, [0x067A] = true, [0x067B] = true,
    [0x067C] = true, [0x067D] = true, [0x067E] = true, [0x067F] = true,
    [0x0680] = true, [0x0681] = true, [0x0682] = true, [0x0683] = true,
    [0x0684] = true, [0x0685] = true, [0x0686] = true, [0x0687] = true,
    [0x069A] = true, [0x069B] = true, [0x069C] = true, [0x069D] = true,
    [0x069E] = true, [0x069F] = true, [0x06A0] = true, [0x06A1] = true,
    [0x06A2] = true, [0x06A3] = true, [0x06A4] = true, [0x06A5] = true,
    [0x06A6] = true, [0x06A7] = true, [0x06A8] = true, [0x06A9] = true,
    [0x06AA] = true, [0x06AB] = true, [0x06AC] = true, [0x06AD] = true,
    [0x06AE] = true, [0x06AF] = true, [0x06B0] = true, [0x06B1] = true,
    [0x06B2] = true, [0x06B3] = true, [0x06B4] = true, [0x06B5] = true,
    [0x06B6] = true, [0x06B7] = true, [0x06B8] = true, [0x06B9] = true,
    [0x06BA] = true, [0x06BB] = true, [0x06BC] = true, [0x06BD] = true,
    [0x06BE] = true, [0x06BF] = true, [0x06C1] = true, [0x06C2] = true,
    [0x06CC] = true, [0x06CE] = true, [0x06D0] = true, [0x06D1] = true,
    [0x06FA] = true, [0x06FB] = true, [0x06FC] = true, [0x06FF] = true,
    [0x0750] = true, [0x0751] = true, [0x0752] = true, [0x0753] = true,
    [0x0754] = true, [0x0755] = true, [0x0756] = true, [0x0757] = true,
    [0x0758] = true, [0x075C] = true, [0x075D] = true, [0x075E] = true,
    [0x075F] = true, [0x0760] = true, [0x0761] = true, [0x0762] = true,
    [0x0763] = true, [0x0764] = true, [0x0765] = true, [0x0766] = true,
    [0x0767] = true, [0x0768] = true, [0x0769] = true, [0x076A] = true,
    [0x076D] = true, [0x076E] = true, [0x076F] = true, [0x0770] = true,
    [0x0772] = true, [0x0775] = true, [0x0776] = true, [0x0777] = true,
    [0x077A] = true, [0x077B] = true, [0x077C] = true, [0x077D] = true,
    [0x077E] = true, [0x077F] = true, [zwj] = true,
}

local arab_warned = { }

-- todo: gref

local function warning(current,what)
    local char = current.char
    if not arab_warned[char] then
        log.report("analyze","arab: character %s (U+%04X) has no %s class", char, char, what)
        arab_warned[char] = true
    end
end

function fonts.analyzers.methods.nocolor(head,font,attr)
    for n in traverse_node_list(head,glyph) do
        if not font or n.font == font then
            fcr(n)
        end
    end
    return head, true
end

local function finish(first,last)
    if last then
        if first == last then
            local fc = first.char
            if isol_fina_medi_init[fc] or isol_fina[fc] then
                set_attribute(first,state,4) -- isol
                if trace_analyzing then fcs(first,"font:isol") end
            else
                warning(first,"isol")
                set_attribute(first,state,0) -- error
                if trace_analyzing then fcr(first) end
            end
        else
            local lc = last.char
            if isol_fina_medi_init[lc] or isol_fina[lc] then -- why isol here ?
            -- if laststate == 1 or laststate == 2 or laststate == 4 then
                set_attribute(last,state,3) -- fina
                if trace_analyzing then fcs(last,"font:fina") end
            else
                warning(last,"fina")
                set_attribute(last,state,0) -- error
                if trace_analyzing then fcr(last) end
            end
        end
        first, last = nil, nil
    elseif first then
        -- first and last are either both set so we never com here
        local fc = first.char
        if isol_fina_medi_init[fc] or isol_fina[fc] then
            set_attribute(first,state,4) -- isol
            if trace_analyzing then fcs(first,"font:isol") end
        else
            warning(first,"isol")
            set_attribute(first,state,0) -- error
            if trace_analyzing then fcr(first) end
        end
        first = nil
    end
    return first, last
end

function fonts.analyzers.methods.arab(head,font,attr) -- maybe make a special version with no trace
    local tfmdata = fontdata[font]
    local marks = tfmdata.marks
    local first, last, current, done = nil, nil, head, false
    while current do
        if current.id == glyph and current.subtype<256 and current.font == font and not has_attribute(current,state) then
            done = true
            local char = current.char
            if marks[char] then
                set_attribute(current,state,5) -- mark
                if trace_analyzing then fcs(current,"font:mark") end
            elseif isol[char] then -- can be zwj or zwnj too
                first, last = finish(first,last)
                set_attribute(current,state,4) -- isol
                if trace_analyzing then fcs(current,"font:isol") end
                first, last = nil, nil
            elseif not first then
                if isol_fina_medi_init[char] then
                    set_attribute(current,state,1) -- init
                    if trace_analyzing then fcs(current,"font:init") end
                    first, last = first or current, current
                elseif isol_fina[char] then
                    set_attribute(current,state,4) -- isol
                    if trace_analyzing then fcs(current,"font:isol") end
                    first, last = nil, nil
                else -- no arab
                    first, last = finish(first,last)
                end
            elseif isol_fina_medi_init[char] then
                first, last = first or current, current
                set_attribute(current,state,2) -- medi
                if trace_analyzing then fcs(current,"font:medi") end
            elseif isol_fina[char] then
                if not has_attribute(last,state,1) then
                    -- tricky, we need to check what last may be !
                    set_attribute(last,state,2) -- medi
                    if trace_analyzing then fcs(last,"font:medi") end
                end
                set_attribute(current,state,3) -- fina
                if trace_analyzing then fcs(current,"font:fina") end
                first, last = nil, nil
            elseif char >= 0x0600 and char <= 0x06FF then
                if trace_analyzing then fcs(current,"font:rest") end
                first, last = finish(first,last)
            else --no
                first, last = finish(first,last)
            end
        else
            first, last = finish(first,last)
        end
        current = current.next
    end
    first, last = finish(first,last)
    return head, done
end
