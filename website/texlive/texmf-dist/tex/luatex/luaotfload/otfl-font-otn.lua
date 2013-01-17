if not modules then modules = { } end modules ['font-otn'] = {
    version   = 1.001,
    comment   = "companion to font-ini.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

-- this is still somewhat preliminary and it will get better in due time;
-- much functionality could only be implemented thanks to the husayni font
-- of Idris Samawi Hamid to who we dedicate this module.

-- I'm in the process of cleaning up the code (which happens in another
-- file) so don't rely on things staying the same.

-- some day when we can jit this, we can use more functions

-- we can use more lpegs when lpeg is extended with function args and so
-- resolving to unicode does not gain much

-- in retrospect it always looks easy but believe it or not, it took a lot
-- of work to get proper open type support done: buggy fonts, fuzzy specs,
-- special made testfonts, many skype sessions between taco, idris and me,
-- torture tests etc etc ... unfortunately the code does not show how much
-- time it took ...

-- todo:
--
-- kerning is probably not yet ok for latin around dics nodes
-- extension infrastructure (for usage out of context)
-- sorting features according to vendors/renderers
-- alternative loop quitters
-- check cursive and r2l
-- find out where ignore-mark-classes went
-- remove unused tables
-- slide tail (always glue at the end so only needed once
-- default features (per language, script)
-- cleanup kern(class) code, remove double info
-- handle positions (we need example fonts)
-- handle gpos_single (we might want an extra width field in glyph nodes because adding kerns might interfere)

--[[ldx--
<p>This module is a bit more split up that I'd like but since we also want to test
with plain <l n='tex'/> it has to be so. This module is part of <l n='context'/>
and discussion about improvements and functionality mostly happens on the
<l n='context'/> mailing list.</p>

<p>The specification of OpenType is kind of vague. Apart from a lack of a proper
free specifications there's also the problem that Microsoft and Adobe
may have their own interpretation of how and in what order to apply features.
In general the Microsoft website has more detailed specifications and is a
better reference. There is also some information in the FontForge help files.</p>

<p>Because there is so much possible, fonts might contain bugs and/or be made to
work with certain rederers. These may evolve over time which may have the side
effect that suddenly fonts behave differently.</p>

<p>After a lot of experiments (mostly by Taco, me and Idris) we're now at yet another
implementation. Of course all errors are mine and of course the code can be
improved. There are quite some optimizations going on here and processing speed
is currently acceptable. Not all functions are implemented yet, often because I
lack the fonts for testing. Many scripts are not yet supported either, but I will
look into them as soon as <l n='context'/> users ask for it.</p>

<p>Because there are different interpretations possible, I will extend the code
with more (configureable) variants. I can also add hooks for users so that they can
write their own extensions.</p>

<p>Glyphs are indexed not by unicode but in their own way. This is because there is no
relationship with unicode at all, apart from the fact that a font might cover certain
ranges of characters. One character can have multiple shapes. However, at the
<l n='tex'/> end we use unicode so and all extra glyphs are mapped into a private
space. This is needed because we need to access them and <l n='tex'/> has to include
then in the output eventually.</p>

<p>The raw table as it coms from <l n='fontforge'/> gets reorganized in to fit out needs.
In <l n='context'/> that table is packed (similar tables are shared) and cached on disk
so that successive runs can use the optimized table (after loading the table is
unpacked). The flattening code used later is a prelude to an even more compact table
format (and as such it keeps evolving).</p>

<p>This module is sparsely documented because it is a moving target. The table format
of the reader changes and we experiment a lot with different methods for supporting
features.</p>

<p>As with the <l n='afm'/> code, we may decide to store more information in the
<l n='otf'/> table.</p>

<p>Incrementing the version number will force a re-cache. We jump the number by one
when there's a fix in the <l n='fontforge'/> library or <l n='lua'/> code that
results in different tables.</p>
--ldx]]--

-- action                    handler     chainproc             chainmore              comment
--
-- gsub_single               ok          ok                    ok
-- gsub_multiple             ok          ok                    not implemented yet
-- gsub_alternate            ok          ok                    not implemented yet
-- gsub_ligature             ok          ok                    ok
-- gsub_context              ok          --
-- gsub_contextchain         ok          --
-- gsub_reversecontextchain  ok          --
-- chainsub                  --          ok
-- reversesub                --          ok
-- gpos_mark2base            ok          ok
-- gpos_mark2ligature        ok          ok
-- gpos_mark2mark            ok          ok
-- gpos_cursive              ok          untested
-- gpos_single               ok          ok
-- gpos_pair                 ok          ok
-- gpos_context              ok          --
-- gpos_contextchain         ok          --
--
-- actions:
--
-- handler   : actions triggered by lookup
-- chainproc : actions triggered by contextual lookup
-- chainmore : multiple substitutions triggered by contextual lookup (e.g. fij -> f + ij)
--
-- remark: the 'not implemented yet' variants will be done when we have fonts that use them
-- remark: we need to check what to do with discretionaries

local concat, insert, remove = table.concat, table.insert, table.remove
local format, gmatch, gsub, find, match, lower, strip = string.format, string.gmatch, string.gsub, string.find, string.match, string.lower, string.strip
local type, next, tonumber, tostring = type, next, tonumber, tostring
local lpegmatch = lpeg.match

local otf = fonts.otf
local tfm = fonts.tfm

local trace_lookups      = false  trackers.register("otf.lookups",      function(v) trace_lookups      = v end)
local trace_singles      = false  trackers.register("otf.singles",      function(v) trace_singles      = v end)
local trace_multiples    = false  trackers.register("otf.multiples",    function(v) trace_multiples    = v end)
local trace_alternatives = false  trackers.register("otf.alternatives", function(v) trace_alternatives = v end)
local trace_ligatures    = false  trackers.register("otf.ligatures",    function(v) trace_ligatures    = v end)
local trace_contexts     = false  trackers.register("otf.contexts",     function(v) trace_contexts     = v end)
local trace_marks        = false  trackers.register("otf.marks",        function(v) trace_marks        = v end)
local trace_kerns        = false  trackers.register("otf.kerns",        function(v) trace_kerns        = v end)
local trace_cursive      = false  trackers.register("otf.cursive",      function(v) trace_cursive      = v end)
local trace_preparing    = false  trackers.register("otf.preparing",    function(v) trace_preparing    = v end)
local trace_bugs         = false  trackers.register("otf.bugs",         function(v) trace_bugs         = v end)
local trace_details      = false  trackers.register("otf.details",      function(v) trace_details      = v end)
local trace_applied      = false  trackers.register("otf.applied",      function(v) trace_applied      = v end)
local trace_steps        = false  trackers.register("otf.steps",        function(v) trace_steps        = v end)
local trace_skips        = false  trackers.register("otf.skips",        function(v) trace_skips        = v end)
local trace_directions   = false  trackers.register("otf.directions",   function(v) trace_directions   = v end)

trackers.register("otf.verbose_chain", function(v) otf.setcontextchain(v and "verbose") end)
trackers.register("otf.normal_chain",  function(v) otf.setcontextchain(v and "normal")  end)

trackers.register("otf.replacements", "otf.singles,otf.multiples,otf.alternatives,otf.ligatures")
trackers.register("otf.positions","otf.marks,otf.kerns,otf.cursive")
trackers.register("otf.actions","otf.replacements,otf.positions")
trackers.register("otf.injections","nodes.injections")

trackers.register("*otf.sample","otf.steps,otf.actions,otf.analyzing")

local insert_node_after = node.insert_after
local delete_node       = nodes.delete
local copy_node         = node.copy
local find_node_tail    = node.tail or node.slide
local set_attribute     = node.set_attribute
local has_attribute     = node.has_attribute

local zwnj     = 0x200C
local zwj      = 0x200D
local wildcard = "*"
local default  = "dflt"

local split_at_space = lpeg.splitters[" "] or lpeg.Ct(lpeg.splitat(" ")) -- no trailing or multiple spaces anyway

local glyph   = node.id('glyph')
local glue    = node.id('glue')
local kern    = node.id('kern')
local disc    = node.id('disc')
local whatsit = node.id('whatsit')

local state    = attributes.private('state')
local markbase = attributes.private('markbase')
local markmark = attributes.private('markmark')
local markdone = attributes.private('markdone')
local cursbase = attributes.private('cursbase')
local curscurs = attributes.private('curscurs')
local cursdone = attributes.private('cursdone')
local kernpair = attributes.private('kernpair')

local set_mark    = nodes.set_mark
local set_cursive = nodes.set_cursive
local set_kern    = nodes.set_kern
local set_pair    = nodes.set_pair

local markonce = true
local cursonce = true
local kernonce = true

local fontdata = fonts.ids

otf.features.process = { }

-- we share some vars here, after all, we have no nested lookups and
-- less code

local tfmdata       = false
local otfdata       = false
local characters    = false
local descriptions  = false
local marks         = false
local indices       = false
local unicodes      = false
local currentfont   = false
local lookuptable   = false
local anchorlookups = false
local handlers      = { }
local rlmode        = 0
local featurevalue  = false

-- we cheat a bit and assume that a font,attr combination are kind of ranged

local context_setups  = fonts.define.specify.context_setups
local context_numbers = fonts.define.specify.context_numbers
local context_merged  = fonts.define.specify.context_merged

-- we cannot optimize with "start = first_character(head)" because then we don't
-- know which rlmode we're in which messes up cursive handling later on
--
-- head is always a whatsit so we can safely assume that head is not changed

local special_attributes = {
    init = 1,
    medi = 2,
    fina = 3,
    isol = 4
}

-- we use this for special testing and documentation

local checkstep       = (nodes and nodes.tracers and nodes.tracers.steppers.check)    or function() end
local registerstep    = (nodes and nodes.tracers and nodes.tracers.steppers.register) or function() end
local registermessage = (nodes and nodes.tracers and nodes.tracers.steppers.message)  or function() end

local function logprocess(...)
    if trace_steps then
        registermessage(...)
    end
    logs.report("otf direct",...)
end
local function logwarning(...)
    logs.report("otf direct",...)
end

local function gref(n)
    if type(n) == "number" then
        local description = descriptions[n]
        local name = description and description.name
        if name then
            return format("U+%04X (%s)",n,name)
        else
            return format("U+%04X",n)
        end
    elseif not n then
        return "<error in tracing>"
    else
        local num, nam = { }, { }
        for i=1,#n do
            local ni = n[i]
            num[#num+1] = format("U+%04X",ni)
            local dni = descriptions[ni]
            nam[#num] = (dni and dni.name) or "?"
        end
        return format("%s (%s)",concat(num," "), concat(nam," "))
    end
end

local function cref(kind,chainname,chainlookupname,lookupname,index)
    if index then
        return format("feature %s, chain %s, sub %s, lookup %s, index %s",kind,chainname,chainlookupname,lookupname,index)
    elseif lookupname then
        return format("feature %s, chain %s, sub %s, lookup %s",kind,chainname or "?",chainlookupname or "?",lookupname)
    elseif chainlookupname then
        return format("feature %s, chain %s, sub %s",kind,chainname or "?",chainlookupname)
    elseif chainname then
        return format("feature %s, chain %s",kind,chainname)
    else
        return format("feature %s",kind)
    end
end

local function pref(kind,lookupname)
    return format("feature %s, lookup %s",kind,lookupname)
end

-- we can assume that languages that use marks are not hyphenated
-- we can also assume that at most one discretionary is present

local function markstoligature(kind,lookupname,start,stop,char)
    local n = copy_node(start)
    local keep = start
    local current
    current, start = insert_node_after(start,start,n)
    local snext = stop.next
    current.next = snext
    if snext then
        snext.prev = current
    end
    start.prev, stop.next = nil, nil
    current.char, current.subtype, current.components = char, 2, start
    return keep
end

local function toligature(kind,lookupname,start,stop,char,markflag,discfound) -- brr head
    if start ~= stop then
--~         if discfound then
--~             local lignode = copy_node(start)
--~             lignode.font = start.font
--~             lignode.char = char
--~             lignode.subtype = 2
--~             start = node.do_ligature_n(start, stop, lignode)
--~             if start.id == disc then
--~                 local prev = start.prev
--~                 start = start.next
--~             end
        if discfound then
         -- print("start->stop",nodes.tosequence(start,stop))
            local lignode = copy_node(start)
            lignode.font, lignode.char, lignode.subtype = start.font, char, 2
            local next, prev = stop.next, start.prev
            stop.next = nil
            lignode = node.do_ligature_n(start, stop, lignode)
            prev.next = lignode
            if next then
                next.prev = lignode
            end
            lignode.next, lignode.prev = next, prev
            start = lignode
         -- print("start->end",nodes.tosequence(start))
        else -- start is the ligature
            local deletemarks = markflag ~= "mark"
            local n = copy_node(start)
            local current
            current, start = insert_node_after(start,start,n)
            local snext = stop.next
            current.next = snext
            if snext then
                snext.prev = current
            end
            start.prev, stop.next = nil, nil
            current.char, current.subtype, current.components = char, 2, start
            local head = current
            if deletemarks then
                if trace_marks then
                    while start do
                        if marks[start.char] then
                            logwarning("%s: remove mark %s",pref(kind,lookupname),gref(start.char))
                        end
                        start = start.next
                    end
                end
            else
                local i = 0
                while start do
                    if marks[start.char] then
                        set_attribute(start,markdone,i)
                        if trace_marks then
                            logwarning("%s: keep mark %s, gets index %s",pref(kind,lookupname),gref(start.char),i)
                        end
                        head, current = insert_node_after(head,current,copy_node(start))
                    else
                        i = i + 1
                    end
                    start = start.next
                end
                start = current.next
                while start and start.id == glyph do
                    if marks[start.char] then
                        set_attribute(start,markdone,i)
                        if trace_marks then
                            logwarning("%s: keep mark %s, gets index %s",pref(kind,lookupname),gref(start.char),i)
                        end
                    else
                        break
                    end
                    start = start.next
                end
            end
            return head
        end
    else
        start.char = char
    end
    return start
end

function handlers.gsub_single(start,kind,lookupname,replacement)
    if trace_singles then
        logprocess("%s: replacing %s by single %s",pref(kind,lookupname),gref(start.char),gref(replacement))
    end
    start.char = replacement
    return start, true
end

local function alternative_glyph(start,alternatives,kind,chainname,chainlookupname,lookupname) -- chainname and chainlookupname optional
    local value, choice, n = featurevalue or tfmdata.shared.features[kind], nil, #alternatives -- global value, brrr
    if value == "random" then
        local r = math.random(1,n)
        value, choice = format("random, choice %s",r), alternatives[r]
    elseif value == "first" then
        value, choice = format("first, choice %s",1), alternatives[1]
    elseif value == "last" then
        value, choice = format("last, choice %s",n), alternatives[n]
    else
        value = tonumber(value)
        if type(value) ~= "number" then
            value, choice = "default, choice 1", alternatives[1]
        elseif value > n then
            value, choice = format("no %s variants, taking %s",value,n), alternatives[n]
        elseif value == 0 then
            value, choice = format("choice %s (no change)",value), start.char
        elseif value < 1 then
            value, choice = format("no %s variants, taking %s",value,1), alternatives[1]
        else
            value, choice = format("choice %s",value), alternatives[value]
        end
    end
    if not choice then
        logwarning("%s: no variant %s for %s",cref(kind,chainname,chainlookupname,lookupname),value,gref(start.char))
        choice, value = start.char, format("no replacement instead of %s",value)
    end
    return choice, value
end

function handlers.gsub_alternate(start,kind,lookupname,alternative,sequence)
    local choice, index = alternative_glyph(start,alternative,kind,lookupname)
    if trace_alternatives then
        logprocess("%s: replacing %s by alternative %s (%s)",pref(kind,lookupname),gref(start.char),gref(choice),index)
    end
    start.char = choice
    return start, true
end

function handlers.gsub_multiple(start,kind,lookupname,multiple)
    if trace_multiples then
        logprocess("%s: replacing %s by multiple %s",pref(kind,lookupname),gref(start.char),gref(multiple))
    end
    start.char = multiple[1]
    if #multiple > 1 then
        for k=2,#multiple do
            local n = copy_node(start)
            n.char = multiple[k]
            local sn = start.next
            n.next = sn
            n.prev = start
            if sn then
                sn.prev = n
            end
            start.next = n
            start = n
        end
    end
    return start, true
end

function handlers.gsub_ligature(start,kind,lookupname,ligature,sequence) --or maybe pass lookup ref
    local s, stop, discfound = start.next, nil, false
    local startchar = start.char
    if marks[startchar] then
        while s do
            local id = s.id
            if id == glyph and s.subtype<256 then
                if s.font == currentfont then
                    local char = s.char
                    local lg = ligature[1][char]
                    if not lg then
                        break
                    else
                        stop = s
                        ligature = lg
                        s = s.next
                    end
                else
                    break
                end
            else
                break
            end
        end
        if stop and ligature[2] then
            if trace_ligatures then
                local stopchar = stop.char
                start = markstoligature(kind,lookupname,start,stop,ligature[2])
                logprocess("%s: replacing %s upto %s by ligature %s",pref(kind,lookupname),gref(startchar),gref(stopchar),gref(start.char))
            else
                start = markstoligature(kind,lookupname,start,stop,ligature[2])
            end
            return start, true
        end
    else
        local skipmark = sequence.flags[1]
        while s do
            local id = s.id
            if id == glyph and s.subtype<256 then
                if s.font == currentfont then
                    local char = s.char
                    if skipmark and marks[char] then
                        s = s.next
                    else
                        local lg = ligature[1][char]
                        if not lg then
                            break
                        else
                            stop = s
                            ligature = lg
                            s = s.next
                        end
                    end
                else
                    break
                end
            elseif id == disc then
                discfound = true
                s = s.next
            else
                break
            end
        end
        if stop and ligature[2] then
            if trace_ligatures then
                local stopchar = stop.char
                start = toligature(kind,lookupname,start,stop,ligature[2],skipmark,discfound)
                logprocess("%s: replacing %s upto %s by ligature %s",pref(kind,lookupname),gref(startchar),gref(stopchar),gref(start.char))
            else
                start = toligature(kind,lookupname,start,stop,ligature[2],skipmark,discfound)
            end
            return start, true
        end
    end
    return start, false
end

--[[ldx--
<p>We get hits on a mark, but we're not sure if the it has to be applied so
we need to explicitly test for basechar, baselig and basemark entries.</p>
--ldx]]--

function handlers.gpos_mark2base(start,kind,lookupname,markanchors,sequence)
    local markchar = start.char
    if marks[markchar] then
        local base = start.prev -- [glyph] [start=mark]
        if base and base.id == glyph and base.subtype<256 and base.font == currentfont then
            local basechar = base.char
            if marks[basechar] then
                while true do
                    base = base.prev
                    if base and base.id == glyph and base.subtype<256 and base.font == currentfont then
                        basechar = base.char
                        if not marks[basechar] then
                            break
                        end
                    else
                        if trace_bugs then
                            logwarning("%s: no base for mark %s",pref(kind,lookupname),gref(markchar))
                        end
                        return start, false
                    end
                end
            end
            local baseanchors = descriptions[basechar]
            if baseanchors then
                baseanchors = baseanchors.anchors
            end
            if baseanchors then
                local baseanchors = baseanchors['basechar']
                if baseanchors then
                    local al = anchorlookups[lookupname]
                    for anchor,ba in next, baseanchors do
                        if al[anchor] then
                            local ma = markanchors[anchor]
                            if ma then
                                local dx, dy, bound = set_mark(start,base,tfmdata.factor,rlmode,ba,ma)
                                if trace_marks then
                                    logprocess("%s, anchor %s, bound %s: anchoring mark %s to basechar %s => (%s,%s)",
                                        pref(kind,lookupname),anchor,bound,gref(markchar),gref(basechar),dx,dy)
                                end
                                return start, true
                            end
                        end
                    end
                    if trace_bugs then
                        logwarning("%s, no matching anchors for mark %s and base %s",pref(kind,lookupname),gref(markchar),gref(basechar))
                    end
                end
            else -- if trace_bugs then
            --  logwarning("%s: char %s is missing in font",pref(kind,lookupname),gref(basechar))
                fonts.register_message(currentfont,basechar,"no base anchors")
            end
        elseif trace_bugs then
            logwarning("%s: prev node is no char",pref(kind,lookupname))
        end
    elseif trace_bugs then
        logwarning("%s: mark %s is no mark",pref(kind,lookupname),gref(markchar))
    end
    return start, false
end

function handlers.gpos_mark2ligature(start,kind,lookupname,markanchors,sequence)
    -- check chainpos variant
    local markchar = start.char
    if marks[markchar] then
        local base = start.prev -- [glyph] [optional marks] [start=mark]
        local index = 1
        if base and base.id == glyph and base.subtype<256 and base.font == currentfont then
            local basechar = base.char
            if marks[basechar] then
                index = index + 1
                while true do
                    base = base.prev
                    if base and base.id == glyph and base.subtype<256 and base.font == currentfont then
                        basechar = base.char
                        if marks[basechar] then
                            index = index + 1
                        else
                            break
                        end
                    else
                        if trace_bugs then
                            logwarning("%s: no base for mark %s",pref(kind,lookupname),gref(markchar))
                        end
                        return start, false
                    end
                end
            end
            local i = has_attribute(start,markdone)
            if i then index = i end
            local baseanchors = descriptions[basechar]
            if baseanchors then
                baseanchors = baseanchors.anchors
                if baseanchors then
                   local baseanchors = baseanchors['baselig']
                   if baseanchors then
                        local al = anchorlookups[lookupname]
                        for anchor,ba in next, baseanchors do
                            if al[anchor] then
                                local ma = markanchors[anchor]
                                if ma then
                                    ba = ba[index]
                                    if ba then
                                        local dx, dy, bound = set_mark(start,base,tfmdata.factor,rlmode,ba,ma,index)
                                        if trace_marks then
                                            logprocess("%s, anchor %s, index %s, bound %s: anchoring mark %s to baselig %s at index %s => (%s,%s)",
                                                pref(kind,lookupname),anchor,index,bound,gref(markchar),gref(basechar),index,dx,dy)
                                        end
                                        return start, true
                                    end
                                end
                            end
                        end
                        if trace_bugs then
                            logwarning("%s: no matching anchors for mark %s and baselig %s",pref(kind,lookupname),gref(markchar),gref(basechar))
                        end
                    end
                end
            else -- if trace_bugs then
            --  logwarning("%s: char %s is missing in font",pref(kind,lookupname),gref(basechar))
                fonts.register_message(currentfont,basechar,"no base anchors")
            end
        elseif trace_bugs then
            logwarning("%s: prev node is no char",pref(kind,lookupname))
        end
    elseif trace_bugs then
        logwarning("%s: mark %s is no mark",pref(kind,lookupname),gref(markchar))
    end
    return start, false
end

function handlers.gpos_mark2mark(start,kind,lookupname,markanchors,sequence)
    local markchar = start.char
    if marks[markchar] then
--~         local alreadydone = markonce and has_attribute(start,markmark)
--~         if not alreadydone then
            local base = start.prev -- [glyph] [basemark] [start=mark]
            if base and base.id == glyph and base.subtype<256 and base.font == currentfont then -- subtype test can go
                local basechar = base.char
                local baseanchors = descriptions[basechar]
                if baseanchors then
                    baseanchors = baseanchors.anchors
                    if baseanchors then
                        baseanchors = baseanchors['basemark']
                        if baseanchors then
                            local al = anchorlookups[lookupname]
                            for anchor,ba in next, baseanchors do
                                if al[anchor] then
                                    local ma = markanchors[anchor]
                                    if ma then
                                        local dx, dy, bound = set_mark(start,base,tfmdata.factor,rlmode,ba,ma)
                                        if trace_marks then
                                            logprocess("%s, anchor %s, bound %s: anchoring mark %s to basemark %s => (%s,%s)",
                                                pref(kind,lookupname),anchor,bound,gref(markchar),gref(basechar),dx,dy)
                                        end
                                        return start,true
                                    end
                                end
                            end
                            if trace_bugs then
                                logwarning("%s: no matching anchors for mark %s and basemark %s",pref(kind,lookupname),gref(markchar),gref(basechar))
                            end
                        end
                    end
                else -- if trace_bugs then
                --  logwarning("%s: char %s is missing in font",pref(kind,lookupname),gref(basechar))
                    fonts.register_message(currentfont,basechar,"no base anchors")
                end
            elseif trace_bugs then
                logwarning("%s: prev node is no mark",pref(kind,lookupname))
            end
--~         elseif trace_marks and trace_details then
--~             logprocess("%s, mark %s is already bound (n=%s), ignoring mark2mark",pref(kind,lookupname),gref(markchar),alreadydone)
--~         end
    elseif trace_bugs then
        logwarning("%s: mark %s is no mark",pref(kind,lookupname),gref(markchar))
    end
    return start,false
end

function handlers.gpos_cursive(start,kind,lookupname,exitanchors,sequence) -- to be checked
    local alreadydone = cursonce and has_attribute(start,cursbase)
    if not alreadydone then
        local done = false
        local startchar = start.char
        if marks[startchar] then
            if trace_cursive then
                logprocess("%s: ignoring cursive for mark %s",pref(kind,lookupname),gref(startchar))
            end
        else
            local nxt = start.next
            while not done and nxt and nxt.id == glyph and nxt.subtype<256 and nxt.font == currentfont do
                local nextchar = nxt.char
                if marks[nextchar] then
                    -- should not happen (maybe warning)
                    nxt = nxt.next
                else
                    local entryanchors = descriptions[nextchar]
                    if entryanchors then
                        entryanchors = entryanchors.anchors
                        if entryanchors then
                            entryanchors = entryanchors['centry']
                            if entryanchors then
                                local al = anchorlookups[lookupname]
                                for anchor, entry in next, entryanchors do
                                    if al[anchor] then
                                        local exit = exitanchors[anchor]
                                        if exit then
                                            local dx, dy, bound = set_cursive(start,nxt,tfmdata.factor,rlmode,exit,entry,characters[startchar],characters[nextchar])
                                            if trace_cursive then
                                                logprocess("%s: moving %s to %s cursive (%s,%s) using anchor %s and bound %s in rlmode %s",pref(kind,lookupname),gref(startchar),gref(nextchar),dx,dy,anchor,bound,rlmode)
                                            end
                                            done = true
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    else -- if trace_bugs then
                    --  logwarning("%s: char %s is missing in font",pref(kind,lookupname),gref(startchar))
                        fonts.register_message(currentfont,startchar,"no entry anchors")
                    end
                    break
                end
            end
        end
        return start, done
    else
        if trace_cursive and trace_details then
            logprocess("%s, cursive %s is already done",pref(kind,lookupname),gref(start.char),alreadydone)
        end
        return start, false
    end
end

function handlers.gpos_single(start,kind,lookupname,kerns,sequence)
    local startchar = start.char
    local dx, dy, w, h = set_pair(start,tfmdata.factor,rlmode,sequence.flags[4],kerns,characters[startchar])
    if trace_kerns then
        logprocess("%s: shifting single %s by (%s,%s) and correction (%s,%s)",pref(kind,lookupname),gref(startchar),dx,dy,w,h)
    end
    return start, false
end

function handlers.gpos_pair(start,kind,lookupname,kerns,sequence)
    -- todo: kerns in disc nodes: pre, post, replace -> loop over disc too
    -- todo: kerns in components of ligatures
    local snext = start.next
    if not snext then
        return start, false
    else
        local prev, done = start, false
        local factor = tfmdata.factor
        while snext and snext.id == glyph and snext.subtype<256 and snext.font == currentfont do
            local nextchar = snext.char
local krn = kerns[nextchar]
            if not krn and marks[nextchar] then
                prev = snext
                snext = snext.next
            else
                local krn = kerns[nextchar]
                if not krn then
                    -- skip
                elseif type(krn) == "table" then
                    if krn[1] == "pair" then
                        local a, b = krn[3], krn[4]
                        if a and #a > 0 then
                            local startchar = start.char
                            local x, y, w, h = set_pair(start,factor,rlmode,sequence.flags[4],a,characters[startchar])
                            if trace_kerns then
                                logprocess("%s: shifting first of pair %s and %s by (%s,%s) and correction (%s,%s)",pref(kind,lookupname),gref(startchar),gref(nextchar),x,y,w,h)
                            end
                        end
                        if b and #b > 0 then
                            local startchar = start.char
                            local x, y, w, h = set_pair(snext,factor,rlmode,sequence.flags[4],b,characters[nextchar])
                            if trace_kerns then
                                logprocess("%s: shifting second of pair %s and %s by (%s,%s) and correction (%s,%s)",pref(kind,lookupname),gref(startchar),gref(nextchar),x,y,w,h)
                            end
                        end
                    else
                        logs.report("%s: check this out (old kern stuff)",pref(kind,lookupname))
                        local a, b = krn[3], krn[7]
                        if a and a ~= 0 then
                            local k = set_kern(snext,factor,rlmode,a)
                            if trace_kerns then
                                logprocess("%s: inserting first kern %s between %s and %s",pref(kind,lookupname),k,gref(prev.char),gref(nextchar))
                            end
                        end
                        if b and b ~= 0 then
                            logwarning("%s: ignoring second kern xoff %s",pref(kind,lookupname),b*factor)
                        end
                    end
                    done = true
                elseif krn ~= 0 then
                    local k = set_kern(snext,factor,rlmode,krn)
                    if trace_kerns then
                        logprocess("%s: inserting kern %s between %s and %s",pref(kind,lookupname),k,gref(prev.char),gref(nextchar))
                    end
                    done = true
                end
                break
            end
        end
        return start, done
    end
end

--[[ldx--
<p>I will implement multiple chain replacements once I run into a font that uses
it. It's not that complex to handle.</p>
--ldx]]--

local chainmores = { }
local chainprocs = { }

local function logprocess(...)
    if trace_steps then
        registermessage(...)
    end
    logs.report("otf subchain",...)
end
local function logwarning(...)
    logs.report("otf subchain",...)
end

-- ['coverage']={
--     ['after']={ "r" },
--     ['before']={ "q" },
--     ['current']={ "a", "b", "c" },
-- },
-- ['lookups']={ "ls_l_1", "ls_l_1", "ls_l_1" },

function chainmores.chainsub(start,stop,kind,chainname,currentcontext,cache,lookuplist,chainlookupname,n)
    logprocess("%s: a direct call to chainsub cannot happen",cref(kind,chainname,chainlookupname))
    return start, false
end

-- handled later:
--
-- function chainmores.gsub_single(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,n)
--     return chainprocs.gsub_single(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,n)
-- end

function chainmores.gsub_multiple(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,n)
    logprocess("%s: gsub_multiple not yet supported",cref(kind,chainname,chainlookupname))
    return start, false
end
function chainmores.gsub_alternate(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,n)
    logprocess("%s: gsub_alternate not yet supported",cref(kind,chainname,chainlookupname))
    return start, false
end

-- handled later:
--
-- function chainmores.gsub_ligature(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,n)
--     return chainprocs.gsub_ligature(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,n)
-- end

local function logprocess(...)
    if trace_steps then
        registermessage(...)
    end
    logs.report("otf chain",...)
end
local function logwarning(...)
    logs.report("otf chain",...)
end

-- We could share functions but that would lead to extra function calls with many
-- arguments, redundant tests and confusing messages.

function chainprocs.chainsub(start,stop,kind,chainname,currentcontext,cache,lookuplist,chainlookupname)
    logwarning("%s: a direct call to chainsub cannot happen",cref(kind,chainname,chainlookupname))
    return start, false
end

-- The reversesub is a special case, which is why we need to store the replacements
-- in a bit weird way. There is no lookup and the replacement comes from the lookup
-- itself. It is meant mostly for dealing with Urdu.

function chainprocs.reversesub(start,stop,kind,chainname,currentcontext,cache,replacements)
    local char = start.char
    local replacement = replacements[char]
    if replacement then
        if trace_singles then
            logprocess("%s: single reverse replacement of %s by %s",cref(kind,chainname),gref(char),gref(replacement))
        end
        start.char = replacement
        return start, true
    else
        return start, false
    end
end

--[[ldx--
<p>This chain stuff is somewhat tricky since we can have a sequence of actions to be
applied: single, alternate, multiple or ligature where ligature can be an invalid
one in the sense that it will replace multiple by one but not neccessary one that
looks like the combination (i.e. it is the counterpart of multiple then). For
example, the following is valid:</p>

<typing>
<line>xxxabcdexxx [single a->A][multiple b->BCD][ligature cde->E] xxxABCDExxx</line>
</typing>

<p>Therefore we we don't really do the replacement here already unless we have the
single lookup case. The efficiency of the replacements can be improved by deleting
as less as needed but that would also mke the code even more messy.</p>
--ldx]]--

local function delete_till_stop(start,stop,ignoremarks)
    if start ~= stop then
        -- todo keep marks
        local done = false
        while not done do
            done = start == stop
            delete_node(start,start.next)
        end
    end
end

--[[ldx--
<p>Here we replace start by a single variant, First we delete the rest of the
match.</p>
--ldx]]--

function chainprocs.gsub_single(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,chainindex)
    -- todo: marks ?
    if not chainindex then
        delete_till_stop(start,stop) -- ,currentlookup.flags[1])
    end
    local current = start
    local subtables = currentlookup.subtables
    while current do
        if current.id == glyph then
            local currentchar = current.char
            local lookupname = subtables[1]
            local replacement = cache.gsub_single[lookupname]
            if not replacement then
                if trace_bugs then
                    logwarning("%s: no single hits",cref(kind,chainname,chainlookupname,lookupname,chainindex))
                end
            else
                replacement = replacement[currentchar]
                if not replacement then
                    if trace_bugs then
                        logwarning("%s: no single for %s",cref(kind,chainname,chainlookupname,lookupname,chainindex),gref(currentchar))
                    end
                else
                    if trace_singles then
                        logprocess("%s: replacing single %s by %s",cref(kind,chainname,chainlookupname,lookupname,chainindex),gref(currentchar),gref(replacement))
                    end
                    current.char = replacement
                end
            end
            return start, true
        elseif current == stop then
            break
        else
            current = current.next
        end
    end
    return start, false
end

chainmores.gsub_single = chainprocs.gsub_single

--[[ldx--
<p>Here we replace start by a sequence of new glyphs. First we delete the rest of
the match.</p>
--ldx]]--

function chainprocs.gsub_multiple(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname)
    delete_till_stop(start,stop)
    local startchar = start.char
    local subtables = currentlookup.subtables
    local lookupname = subtables[1]
    local replacements = cache.gsub_multiple[lookupname]
    if not replacements then
        if trace_bugs then
            logwarning("%s: no multiple hits",cref(kind,chainname,chainlookupname,lookupname))
        end
    else
        replacements = replacements[startchar]
        if not replacements then
            if trace_bugs then
                logwarning("%s: no multiple for %s",cref(kind,chainname,chainlookupname,lookupname),gref(startchar))
            end
        else
            if trace_multiples then
                logprocess("%s: replacing %s by multiple characters %s",cref(kind,chainname,chainlookupname,lookupname),gref(startchar),gref(replacements))
            end
            local sn = start.next
            for k=1,#replacements do
                if k == 1 then
                    start.char = replacements[k]
                else
                    local n = copy_node(start) -- maybe delete the components and such
                    n.char = replacements[k]
                    n.next, n.prev = sn, start
                    if sn then
                        sn.prev = n
                    end
                    start.next, start = n, n
                end
            end
            return start, true
        end
    end
    return start, false
end

--[[ldx--
<p>Here we replace start by new glyph. First we delete the rest of the match.</p>
--ldx]]--

function chainprocs.gsub_alternate(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname)
    -- todo: marks ?
    delete_till_stop(start,stop)
    local current = start
    local subtables = currentlookup.subtables
    while current do
        if current.id == glyph then
            local currentchar = current.char
            local lookupname = subtables[1]
            local alternatives = cache.gsub_alternate[lookupname]
            if not alternatives then
                if trace_bugs then
                    logwarning("%s: no alternative hits",cref(kind,chainname,chainlookupname,lookupname))
                end
            else
                alternatives = alternatives[currentchar]
                if not alternatives then
                    if trace_bugs then
                        logwarning("%s: no alternative for %s",cref(kind,chainname,chainlookupname,lookupname),gref(currentchar))
                    end
                else
                    local choice, index = alternative_glyph(current,alternatives,kind,chainname,chainlookupname,lookupname)
                    current.char = choice
                    if trace_alternatives then
                        logprocess("%s: replacing single %s by alternative %s (%s)",cref(kind,chainname,chainlookupname,lookupname),index,gref(currentchar),gref(choice),index)
                    end
                end
            end
            return start, true
        elseif current == stop then
            break
        else
            current = current.next
        end
    end
    return start, false
end

--[[ldx--
<p>When we replace ligatures we use a helper that handles the marks. I might change
this function (move code inline and handle the marks by a separate function). We
assume rather stupid ligatures (no complex disc nodes).</p>
--ldx]]--

function chainprocs.gsub_ligature(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,chainindex)
    local startchar = start.char
    local subtables = currentlookup.subtables
    local lookupname = subtables[1]
    local ligatures = cache.gsub_ligature[lookupname]
    if not ligatures then
        if trace_bugs then
            logwarning("%s: no ligature hits",cref(kind,chainname,chainlookupname,lookupname,chainindex))
        end
    else
        ligatures = ligatures[startchar]
        if not ligatures then
            if trace_bugs then
                logwarning("%s: no ligatures starting with %s",cref(kind,chainname,chainlookupname,lookupname,chainindex),gref(startchar))
            end
        else
            local s, discfound, last, nofreplacements = start.next, false, stop, 0
            while s do
                local id = s.id
                if id == disc then
                    s = s.next
                    discfound = true
                else
                    local schar = s.char
                    if marks[schar] then -- marks
                        s = s.next
                    else
                        local lg = ligatures[1][schar]
                        if not lg then
                            break
                        else
                            ligatures, last, nofreplacements = lg, s, nofreplacements + 1
                            if s == stop then
                                break
                            else
                                s = s.next
                            end
                        end
                    end
                end
            end
            local l2 = ligatures[2]
            if l2 then
                if chainindex then
                    stop = last
                end
                if trace_ligatures then
                    if start == stop then
                        logprocess("%s: replacing character %s by ligature %s",cref(kind,chainname,chainlookupname,lookupname,chainindex),gref(startchar),gref(l2))
                    else
                        logprocess("%s: replacing character %s upto %s by ligature %s",cref(kind,chainname,chainlookupname,lookupname,chainindex),gref(startchar),gref(stop.char),gref(l2))
                    end
                end
                start = toligature(kind,lookupname,start,stop,l2,currentlookup.flags[1],discfound)
                return start, true, nofreplacements
            elseif trace_bugs then
                if start == stop then
                    logwarning("%s: replacing character %s by ligature fails",cref(kind,chainname,chainlookupname,lookupname,chainindex),gref(startchar))
                else
                    logwarning("%s: replacing character %s upto %s by ligature fails",cref(kind,chainname,chainlookupname,lookupname,chainindex),gref(startchar),gref(stop.char))
                end
            end
        end
    end
    return start, false, 0
end

chainmores.gsub_ligature = chainprocs.gsub_ligature

function chainprocs.gpos_mark2base(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname)
    local markchar = start.char
    if marks[markchar] then
        local subtables = currentlookup.subtables
        local lookupname = subtables[1]
        local markanchors = cache.gpos_mark2base[lookupname]
        if markanchors then
            markanchors = markanchors[markchar]
        end
        if markanchors then
            local base = start.prev -- [glyph] [start=mark]
            if base and base.id == glyph and base.subtype<256 and base.font == currentfont then
                local basechar = base.char
                if marks[basechar] then
                    while true do
                        base = base.prev
                        if base and base.id == glyph and base.subtype<256 and base.font == currentfont then
                            basechar = base.char
                            if not marks[basechar] then
                                break
                            end
                        else
                            if trace_bugs then
                                logwarning("%s: no base for mark %s",pref(kind,lookupname),gref(markchar))
                            end
                            return start, false
                        end
                    end
                end
                local baseanchors = descriptions[basechar].anchors
                if baseanchors then
                    local baseanchors = baseanchors['basechar']
                    if baseanchors then
                        local al = anchorlookups[lookupname]
                        for anchor,ba in next, baseanchors do
                            if al[anchor] then
                                local ma = markanchors[anchor]
                                if ma then
                                    local dx, dy, bound = set_mark(start,base,tfmdata.factor,rlmode,ba,ma)
                                    if trace_marks then
                                        logprocess("%s, anchor %s, bound %s: anchoring mark %s to basechar %s => (%s,%s)",
                                            cref(kind,chainname,chainlookupname,lookupname),anchor,bound,gref(markchar),gref(basechar),dx,dy)
                                    end
                                    return start, true
                                end
                            end
                        end
                        if trace_bugs then
                            logwarning("%s, no matching anchors for mark %s and base %s",cref(kind,chainname,chainlookupname,lookupname),gref(markchar),gref(basechar))
                        end
                    end
                end
            elseif trace_bugs then
                logwarning("%s: prev node is no char",cref(kind,chainname,chainlookupname,lookupname))
            end
        elseif trace_bugs then
            logwarning("%s: mark %s has no anchors",cref(kind,chainname,chainlookupname,lookupname),gref(markchar))
        end
    elseif trace_bugs then
        logwarning("%s: mark %s is no mark",cref(kind,chainname,chainlookupname),gref(markchar))
    end
    return start, false
end

function chainprocs.gpos_mark2ligature(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname)
    local markchar = start.char
    if marks[markchar] then
        local subtables = currentlookup.subtables
        local lookupname = subtables[1]
        local markanchors = cache.gpos_mark2ligature[lookupname]
        if markanchors then
            markanchors = markanchors[markchar]
        end
        if markanchors then
            local base = start.prev -- [glyph] [optional marks] [start=mark]
            local index = 1
            if base and base.id == glyph and base.subtype<256 and base.font == currentfont then
                local basechar = base.char
                if marks[basechar] then
                    index = index + 1
                    while true do
                        base = base.prev
                        if base and base.id == glyph and base.subtype<256 and base.font == currentfont then
                            basechar = base.char
                            if marks[basechar] then
                                index = index + 1
                            else
                                break
                            end
                        else
                            if trace_bugs then
                                logwarning("%s: no base for mark %s",cref(kind,chainname,chainlookupname,lookupname),markchar)
                            end
                            return start, false
                        end
                    end
                end
                -- todo: like marks a ligatures hash
                local i = has_attribute(start,markdone)
                if i then index = i end
                local baseanchors = descriptions[basechar].anchors
                if baseanchors then
                   local baseanchors = baseanchors['baselig']
                   if baseanchors then
                        local al = anchorlookups[lookupname]
                        for anchor,ba in next, baseanchors do
                            if al[anchor] then
                                local ma = markanchors[anchor]
                                if ma then
                                    ba = ba[index]
                                    if ba then
                                        local dx, dy, bound = set_mark(start,base,tfmdata.factor,rlmode,ba,ma,index)
                                        if trace_marks then
                                            logprocess("%s, anchor %s, bound %s: anchoring mark %s to baselig %s at index %s => (%s,%s)",
                                                cref(kind,chainname,chainlookupname,lookupname),anchor,a or bound,gref(markchar),gref(basechar),index,dx,dy)
                                        end
                                        return start, true
                                    end
                                end
                            end
                        end
                        if trace_bugs then
                            logwarning("%s: no matching anchors for mark %s and baselig %s",cref(kind,chainname,chainlookupname,lookupname),gref(markchar),gref(basechar))
                        end
                    end
                end
            elseif trace_bugs then
                logwarning("feature %s, lookup %s: prev node is no char",kind,lookupname)
            end
        elseif trace_bugs then
            logwarning("%s: mark %s has no anchors",cref(kind,chainname,chainlookupname,lookupname),gref(markchar))
        end
    elseif trace_bugs then
        logwarning("%s: mark %s is no mark",cref(kind,chainname,chainlookupname),gref(markchar))
    end
    return start, false
end

function chainprocs.gpos_mark2mark(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname)
    local markchar = start.char
    if marks[markchar] then
--~         local alreadydone = markonce and has_attribute(start,markmark)
--~         if not alreadydone then
        --  local markanchors = descriptions[markchar].anchors markanchors = markanchors and markanchors.mark
            local subtables = currentlookup.subtables
            local lookupname = subtables[1]
            local markanchors = cache.gpos_mark2mark[lookupname]
            if markanchors then
                markanchors = markanchors[markchar]
            end
            if markanchors then
                local base = start.prev -- [glyph] [basemark] [start=mark]
                if base and base.id == glyph and base.subtype<256 and base.font == currentfont then -- subtype test can go
                    local basechar = base.char
                    local baseanchors = descriptions[basechar].anchors
                    if baseanchors then
                        baseanchors = baseanchors['basemark']
                        if baseanchors then
                            local al = anchorlookups[lookupname]
                            for anchor,ba in next, baseanchors do
                                if al[anchor] then
                                    local ma = markanchors[anchor]
                                    if ma then
                                        local dx, dy, bound = set_mark(start,base,tfmdata.factor,rlmode,ba,ma)
                                        if trace_marks then
                                            logprocess("%s, anchor %s, bound %s: anchoring mark %s to basemark %s => (%s,%s)",
                                                cref(kind,chainname,chainlookupname,lookupname),anchor,bound,gref(markchar),gref(basechar),dx,dy)
                                        end
                                        return start, true
                                    end
                                end
                            end
                            if trace_bugs then
                                logwarning("%s: no matching anchors for mark %s and basemark %s",gref(kind,chainname,chainlookupname,lookupname),gref(markchar),gref(basechar))
                            end
                        end
                    end
                elseif trace_bugs then
                    logwarning("%s: prev node is no mark",cref(kind,chainname,chainlookupname,lookupname))
                end
            elseif trace_bugs then
                logwarning("%s: mark %s has no anchors",cref(kind,chainname,chainlookupname,lookupname),gref(markchar))
            end
--~         elseif trace_marks and trace_details then
--~             logprocess("%s, mark %s is already bound (n=%s), ignoring mark2mark",pref(kind,lookupname),gref(markchar),alreadydone)
--~         end
    elseif trace_bugs then
        logwarning("%s: mark %s is no mark",cref(kind,chainname,chainlookupname),gref(markchar))
    end
    return start, false
end

-- ! ! ! untested ! ! !

function chainprocs.gpos_cursive(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname)
    local alreadydone = cursonce and has_attribute(start,cursbase)
    if not alreadydone then
        local startchar = start.char
        local subtables = currentlookup.subtables
        local lookupname = subtables[1]
        local exitanchors = cache.gpos_cursive[lookupname]
        if exitanchors then
            exitanchors = exitanchors[startchar]
        end
        if exitanchors then
            local done = false
            if marks[startchar] then
                if trace_cursive then
                    logprocess("%s: ignoring cursive for mark %s",pref(kind,lookupname),gref(startchar))
                end
            else
                local nxt = start.next
                while not done and nxt and nxt.id == glyph and nxt.subtype<256 and nxt.font == currentfont do
                    local nextchar = nxt.char
                    if marks[nextchar] then
                        -- should not happen (maybe warning)
                        nxt = nxt.next
                    else
                        local entryanchors = descriptions[nextchar]
                        if entryanchors then
                            entryanchors = entryanchors.anchors
                            if entryanchors then
                                entryanchors = entryanchors['centry']
                                if entryanchors then
                                    local al = anchorlookups[lookupname]
                                    for anchor, entry in next, entryanchors do
                                        if al[anchor] then
                                            local exit = exitanchors[anchor]
                                            if exit then
                                                local dx, dy, bound = set_cursive(start,nxt,tfmdata.factor,rlmode,exit,entry,characters[startchar],characters[nextchar])
                                                if trace_cursive then
                                                    logprocess("%s: moving %s to %s cursive (%s,%s) using anchor %s and bound %s in rlmode %s",pref(kind,lookupname),gref(startchar),gref(nextchar),dx,dy,anchor,bound,rlmode)
                                                end
                                                done = true
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        else -- if trace_bugs then
                        --  logwarning("%s: char %s is missing in font",pref(kind,lookupname),gref(startchar))
                            fonts.register_message(currentfont,startchar,"no entry anchors")
                        end
                        break
                    end
                end
            end
            return start, done
        else
            if trace_cursive and trace_details then
                logprocess("%s, cursive %s is already done",pref(kind,lookupname),gref(start.char),alreadydone)
            end
            return start, false
        end
    end
    return start, false
end

function chainprocs.gpos_single(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,chainindex,sequence)
    -- untested
    local startchar = start.char
    local subtables = currentlookup.subtables
    local lookupname = subtables[1]
    local kerns = cache.gpos_single[lookupname]
    if kerns then
        kerns = kerns[startchar]
        if kerns then
            local dx, dy, w, h = set_pair(start,tfmdata.factor,rlmode,sequence.flags[4],kerns,characters[startchar])
            if trace_kerns then
                logprocess("%s: shifting single %s by (%s,%s) and correction (%s,%s)",cref(kind,chainname,chainlookupname),gref(startchar),dx,dy,w,h)
            end
        end
    end
    return start, false
end

-- when machines become faster i will make a shared function

function chainprocs.gpos_pair(start,stop,kind,chainname,currentcontext,cache,currentlookup,chainlookupname,chainindex,sequence)
--    logwarning("%s: gpos_pair not yet supported",cref(kind,chainname,chainlookupname))
    local snext = start.next
    if snext then
        local startchar = start.char
        local subtables = currentlookup.subtables
        local lookupname = subtables[1]
        local kerns = cache.gpos_pair[lookupname]
        if kerns then
            kerns = kerns[startchar]
            if kerns then
                local prev, done = start, false
                local factor = tfmdata.factor
                while snext and snext.id == glyph and snext.subtype<256 and snext.font == currentfont do
                    local nextchar = snext.char
                    local krn = kerns[nextchar]
                    if not krn and marks[nextchar] then
                        prev = snext
                        snext = snext.next
                    else
                        if not krn then
                            -- skip
                        elseif type(krn) == "table" then
                            if krn[1] == "pair" then
                                local a, b = krn[3], krn[4]
                                if a and #a > 0 then
                                    local startchar = start.char
                                    local x, y, w, h = set_pair(start,factor,rlmode,sequence.flags[4],a,characters[startchar])
                                    if trace_kerns then
                                        logprocess("%s: shifting first of pair %s and %s by (%s,%s) and correction (%s,%s)",cref(kind,chainname,chainlookupname),gref(startchar),gref(nextchar),x,y,w,h)
                                    end
                                end
                                if b and #b > 0 then
                                    local startchar = start.char
                                    local x, y, w, h = set_pair(snext,factor,rlmode,sequence.flags[4],b,characters[nextchar])
                                    if trace_kerns then
                                        logprocess("%s: shifting second of pair %s and %s by (%s,%s) and correction (%s,%s)",cref(kind,chainname,chainlookupname),gref(startchar),gref(nextchar),x,y,w,h)
                                    end
                                end
                            else
                                logs.report("%s: check this out (old kern stuff)",cref(kind,chainname,chainlookupname))
                                local a, b = krn[3], krn[7]
                                if a and a ~= 0 then
                                    local k = set_kern(snext,factor,rlmode,a)
                                    if trace_kerns then
                                        logprocess("%s: inserting first kern %s between %s and %s",cref(kind,chainname,chainlookupname),k,gref(prev.char),gref(nextchar))
                                    end
                                end
                                if b and b ~= 0 then
                                    logwarning("%s: ignoring second kern xoff %s",cref(kind,chainname,chainlookupname),b*factor)
                                end
                            end
                            done = true
                        elseif krn ~= 0 then
                            local k = set_kern(snext,factor,rlmode,krn)
                            if trace_kerns then
                                logprocess("%s: inserting kern %s between %s and %s",cref(kind,chainname,chainlookupname),k,gref(prev.char),gref(nextchar))
                            end
                            done = true
                        end
                        break
                    end
                end
                return start, done
            end
        end
    end
    return start, false
end

-- what pointer to return, spec says stop
-- to be discussed ... is bidi changer a space?
-- elseif char == zwnj and sequence[n][32] then -- brrr

-- somehow l or f is global
-- we don't need to pass the currentcontext, saves a bit
-- make a slow variant then can be activated but with more tracing

local function show_skip(kind,chainname,char,ck,class)
    if ck[9] then
        logwarning("%s: skipping char %s (%s) in rule %s, lookuptype %s (%s=>%s)",cref(kind,chainname),gref(char),class,ck[1],ck[2],ck[9],ck[10])
    else
        logwarning("%s: skipping char %s (%s) in rule %s, lookuptype %s",cref(kind,chainname),gref(char),class,ck[1],ck[2])
    end
end

local function normal_handle_contextchain(start,kind,chainname,contexts,sequence,cache)
    --  local rule, lookuptype, sequence, f, l, lookups = ck[1], ck[2] ,ck[3], ck[4], ck[5], ck[6]
    local flags, done = sequence.flags, false
    local skipmark, skipligature, skipbase = flags[1], flags[2], flags[3]
    local someskip = skipmark or skipligature or skipbase -- could be stored in flags for a fast test (hm, flags could be false !)
    local markclass = sequence.markclass -- todo, first we need a proper test
    local skipped = false
    for k=1,#contexts do
        local match, current, last = true, start, start
        local ck = contexts[k]
        local seq = ck[3]
        local s = #seq
        -- f..l = mid string
        if s == 1 then
            -- never happens
            match = current.id == glyph and current.subtype<256 and current.font == currentfont and seq[1][current.char]
        else
            -- todo: better space check (maybe check for glue)
            local f, l = ck[4], ck[5]
            if f == l then
                -- already a hit
                match = true
            else
                -- no need to test first hit (to be optimized)
                local n = f + 1
                last = last.next
                -- we cannot optimize for n=2 because there can be disc nodes
                -- if not someskip and n == l then
                --    -- n=2 and no skips then faster loop
                --    match = last and last.id == glyph and last.subtype<256 and last.font == currentfont and seq[n][last.char]
                -- else
                    while n <= l do
                        if last then
                            local id = last.id
                            if id == glyph then
                                if last.subtype<256 and last.font == currentfont then
                                    local char = last.char
                                    local ccd = descriptions[char]
                                    if ccd then
                                        local class = ccd.class
                                        if class == skipmark or class == skipligature or class == skipbase or (markclass and class == "mark" and not markclass[char]) then
                                            skipped = true
                                            if trace_skips then
                                                show_skip(kind,chainname,char,ck,class)
                                            end
                                            last = last.next
                                        elseif seq[n][char] then
                                            if n < l then
                                                last = last.next
                                            end
                                            n = n + 1
                                        else
                                            match = false break
                                        end
                                    else
                                        match = false break
                                    end
                                else
                                    match = false break
                                end
                            elseif id == disc then -- what to do with kerns?
                                last = last.next
                            else
                                match = false break
                            end
                        else
                            match = false break
                        end
                    end
                -- end
            end
            if match and f > 1 then
                -- before
                local prev = start.prev
                if prev then
                    local n = f-1
                    while n >= 1 do
                        if prev then
                            local id = prev.id
                            if id == glyph then
                                if prev.subtype<256 and prev.font == currentfont then -- normal char
                                    local char = prev.char
                                    local ccd = descriptions[char]
                                    if ccd then
                                        local class = ccd.class
                                        if class == skipmark or class == skipligature or class == skipbase or (markclass and class == "mark" and not markclass[char]) then
                                            skipped = true
                                            if trace_skips then
                                                show_skip(kind,chainname,char,ck,class)
                                            end
                                        elseif seq[n][char] then
                                            n = n -1
                                        else
                                            match = false break
                                        end
                                    else
                                        match = false break
                                    end
                                else
                                    match = false break
                                end
                            elseif id == disc then
                                -- skip 'm
                            elseif seq[n][32] then
                                n = n -1
                            else
                                match = false break
                            end
                            prev = prev.prev
                        elseif seq[n][32] then
                            n = n -1
                        else
                            match = false break
                        end
                    end
                elseif f == 2 then
                    match = seq[1][32]
                else
                    for n=f-1,1 do
                        if not seq[n][32] then
                            match = false break
                        end
                    end
                end
            end
            if match and s > l then
                -- after
                local current = last.next
                if current then
                    -- removed optimization for s-l == 1, we have to deal with marks anyway
                    local n = l + 1
                    while n <= s do
                        if current then
                            local id = current.id
                            if id == glyph then
                                if current.subtype<256 and current.font == currentfont then -- normal char
                                    local char = current.char
                                    local ccd = descriptions[char]
                                    if ccd then
                                        local class = ccd.class
                                        if class == skipmark or class == skipligature or class == skipbase or (markclass and class == "mark" and not markclass[char]) then
                                            skipped = true
                                            if trace_skips then
                                                show_skip(kind,chainname,char,ck,class)
                                            end
                                        elseif seq[n][char] then
                                            n = n + 1
                                        else
                                            match = false break
                                        end
                                    else
                                        match = false break
                                    end
                                else
                                    match = false break
                                end
                            elseif id == disc then
                                -- skip 'm
                            elseif seq[n][32] then -- brrr
                                n = n + 1
                            else
                                match = false break
                            end
                            current = current.next
                        elseif seq[n][32] then
                            n = n + 1
                        else
                            match = false break
                        end
                    end
                elseif s-l == 1 then
                    match = seq[s][32]
                else
                    for n=l+1,s do
                        if not seq[n][32] then
                            match = false break
                        end
                    end
                end
            end
        end
        if match then
            -- ck == currentcontext
            if trace_contexts then
                local rule, lookuptype, f, l = ck[1], ck[2], ck[4], ck[5]
                local char = start.char
                if ck[9] then
                    logwarning("%s: rule %s matches at char %s for (%s,%s,%s) chars, lookuptype %s (%s=>%s)",cref(kind,chainname),rule,gref(char),f-1,l-f+1,s-l,lookuptype,ck[9],ck[10])
                else
                    logwarning("%s: rule %s matches at char %s for (%s,%s,%s) chars, lookuptype %s",cref(kind,chainname),rule,gref(char),f-1,l-f+1,s-l,lookuptype)
                end
            end
            local chainlookups = ck[6]
            if chainlookups then
                local nofchainlookups = #chainlookups
                -- we can speed this up if needed
                if nofchainlookups == 1 then
                    local chainlookupname = chainlookups[1]
                    local chainlookup = lookuptable[chainlookupname]
                    local cp = chainprocs[chainlookup.type]
                    if cp then
                        start, done = cp(start,last,kind,chainname,ck,cache,chainlookup,chainlookupname,nil,sequence)
                    else
                        logprocess("%s: %s is not yet supported",cref(kind,chainname,chainlookupname),chainlookup.type)
                    end
                 else
                    -- actually this needs a more complex treatment for which we will use chainmores
--~                     local i = 1
--~                     repeat
--~                         local chainlookupname = chainlookups[i]
--~                         local chainlookup = lookuptable[chainlookupname]
--~                         local cp = chainmores[chainlookup.type]
--~                         if cp then
--~                             local ok, n
--~                             start, ok, n = cp(start,last,kind,chainname,ck,cache,chainlookup,chainlookupname,i,sequence)
--~                             -- messy since last can be changed !
--~                             if ok then
--~                                 done = true
--~                                 start = start.next
--~                                 if n then
--~                                     -- skip next one(s) if ligature
--~                                     i = i + n - 1
--~                                 end
--~                             end
--~                         else
--~                             logprocess("%s: multiple subchains for %s are not yet supported",cref(kind,chainname,chainlookupname),chainlookup.type)
--~                         end
--~                         i = i + 1
--~                     until i > nofchainlookups

                    local i = 1
                    repeat
if skipped then
    while true do
        local char = start.char
        local ccd = descriptions[char]
        if ccd then
            local class = ccd.class
            if class == skipmark or class == skipligature or class == skipbase or (markclass and class == "mark" and not markclass[char]) then
                start = start.next
            else
                break
            end
        else
            break
        end
    end
end
                        local chainlookupname = chainlookups[i]
                        local chainlookup = lookuptable[chainlookupname]
                        local cp = chainmores[chainlookup.type]
                        if cp then
                            local ok, n
                            start, ok, n = cp(start,last,kind,chainname,ck,cache,chainlookup,chainlookupname,i,sequence)
                            -- messy since last can be changed !
                            if ok then
                                done = true
                                -- skip next one(s) if ligature
                                i = i + (n or 1)
                            else
                                i = i + 1
                            end
                        else
                            logprocess("%s: multiple subchains for %s are not yet supported",cref(kind,chainname,chainlookupname),chainlookup.type)
                            i = i + 1
                        end
                        start = start.next
                    until i > nofchainlookups

                end
            else
                local replacements = ck[7]
                if replacements then
                    start, done = chainprocs.reversesub(start,last,kind,chainname,ck,cache,replacements) -- sequence
                else
                    done = true -- can be meant to be skipped
                    if trace_contexts then
                        logprocess("%s: skipping match",cref(kind,chainname))
                    end
                end
            end
        end
    end
    return start, done
end

-- Because we want to keep this elsewhere (an because speed is less an issue) we
-- pass the font id so that the verbose variant can access the relevant helper tables.

local verbose_handle_contextchain = function(font,...)
    logwarning("no verbose handler installed, reverting to 'normal'")
    otf.setcontextchain()
    return normal_handle_contextchain(...)
end

otf.chainhandlers = {
    normal = normal_handle_contextchain,
    verbose = verbose_handle_contextchain,
}

function otf.setcontextchain(method)
    if not method or method == "normal" or not otf.chainhandlers[method] then
        if handlers.contextchain then -- no need for a message while making the format
            logwarning("installing normal contextchain handler")
        end
        handlers.contextchain = normal_handle_contextchain
    else
        logwarning("installing contextchain handler '%s'",method)
        local handler = otf.chainhandlers[method]
        handlers.contextchain = function(...)
            return handler(currentfont,...) -- hm, get rid of ...
        end
    end
    handlers.gsub_context             = handlers.contextchain
    handlers.gsub_contextchain        = handlers.contextchain
    handlers.gsub_reversecontextchain = handlers.contextchain
    handlers.gpos_contextchain        = handlers.contextchain
    handlers.gpos_context             = handlers.contextchain
end

otf.setcontextchain()

local missing = { } -- we only report once

local function logprocess(...)
    if trace_steps then
        registermessage(...)
    end
    logs.report("otf process",...)
end
local function logwarning(...)
    logs.report("otf process",...)
end

local function report_missing_cache(typ,lookup)
    local f = missing[currentfont] if not f then f = { } missing[currentfont] = f end
    local t = f[typ]               if not t then t = { } f[typ]               = t end
    if not t[lookup] then
        t[lookup] = true
        logwarning("missing cache for lookup %s of type %s in font %s (%s)",lookup,typ,currentfont,tfmdata.fullname)
    end
end

local resolved = { } -- we only resolve a font,script,language pair once

-- todo: pass all these 'locals' in a table
--
-- dynamics will be isolated some day ... for the moment we catch attribute zero
-- not being set

function fonts.methods.node.otf.features(head,font,attr)
    if trace_steps then
        checkstep(head)
    end
    tfmdata = fontdata[font]
    local shared = tfmdata.shared
    otfdata = shared.otfdata
    local luatex = otfdata.luatex
    descriptions = tfmdata.descriptions
    characters = tfmdata.characters
    indices = tfmdata.indices
    unicodes = tfmdata.unicodes
    marks = tfmdata.marks
    anchorlookups = luatex.lookup_to_anchor
    currentfont = font
    rlmode = 0
    local featuredata = otfdata.shared.featuredata -- can be made local to closure
    local sequences = luatex.sequences
    lookuptable = luatex.lookups
    local done = false
    local script, language, s_enabled, a_enabled, dyn
    local attribute_driven = attr and attr ~= 0
    if attribute_driven then
        local features = context_setups[context_numbers[attr]] -- could be a direct list
        dyn = context_merged[attr] or 0
        language, script = features.language or "dflt", features.script or "dflt"
        a_enabled = features -- shared.features -- can be made local to the resolver
        if dyn == 2 or dyn == -2 then
            -- font based
            s_enabled = shared.features
        end
    else
        language, script = tfmdata.language or "dflt", tfmdata.script or "dflt"
        s_enabled = shared.features -- can be made local to the resolver
        dyn = 0
    end
    -- we can save some runtime by caching feature tests
    local res = resolved[font]     if not res   then res = { } resolved[font]     = res end
    local rs  = res     [script]   if not rs    then rs  = { } res     [script]   = rs  end
    local rl  = rs      [language] if not rl    then rl  = { } rs      [language] = rl  end
    local ra  = rl      [attr]     if ra == nil then ra  = { } rl      [attr]     = ra  end -- attr can be false
    -- sequences always > 1 so no need for optimization
    for s=1,#sequences do
        local pardir, txtdir, success = 0, { }, false
        local sequence = sequences[s]
        local r = ra[s] -- cache
        if r == nil then
            --
            -- this bit will move to font-ctx and become a function
            ---
            local chain = sequence.chain or 0
            local features = sequence.features
            if not features then
                -- indirect lookup, part of chain (todo: make this a separate table)
                r = false -- { false, false, chain }
            else
                local valid, attribute, kind, what = false, false
                for k,v in next, features do
                    -- we can quit earlier but for the moment we want the tracing
                    local s_e = s_enabled and s_enabled[k]
                    local a_e = a_enabled and a_enabled[k]
                    if s_e or a_e then
                        local l = v[script] or v[wildcard]
                        if l then
                            -- not l[language] or l[default] or l[wildcard] because we want tracing
                            -- only first attribute match check, so we assume simple fina's
                            -- default can become a font feature itself
                            if l[language] then
                                valid, what = s_e or a_e, language
                        --  elseif l[default] then
                        --      valid, what = true, default
                            elseif l[wildcard] then
                                valid, what = s_e or a_e, wildcard
                            end
                            if valid then
                                kind, attribute = k, special_attributes[k] or false
                                if a_e and dyn < 0 then
                                    valid = false
                                end
                                if trace_applied then
                                    local typ, action = match(sequence.type,"(.*)_(.*)")
                                    logs.report("otf node mode",
                                        "%s font: %03i, dynamic: %03i, kind: %s, lookup: %3i, script: %-4s, language: %-4s (%-4s), type: %s, action: %s, name: %s",
                                        (valid and "+") or "-",font,attr or 0,kind,s,script,language,what,typ,action,sequence.name)
                                end
                                break
                            end
                        end
                    end
                end
                if valid then
                    r = { valid, attribute, chain, kind }
                else
                    r = false -- { valid, attribute, chain, "generic" } -- false anyway, could be flag instead of table
                end
            end
            ra[s] = r
        end
        featurevalue = r and r[1] -- todo: pass to function instead of using a global
        if featurevalue then
            local attribute, chain, typ, subtables = r[2], r[3], sequence.type, sequence.subtables
            if chain < 0 then
                -- this is a limited case, no special treatments like 'init' etc
                local handler = handlers[typ]
                local thecache = featuredata[typ] or { }
                -- we need to get rid of this slide !
                local start = find_node_tail(head) -- slow (we can store tail because there's always a skip at the end): todo
                while start do
                    local id = start.id
                    if id == glyph then
                        if start.subtype<256 and start.font == font then
                            local a = has_attribute(start,0)
                            if a then
                                a = a == attr
                            else
                                a = true
                            end
                            if a then
                                for i=1,#subtables do
                                    local lookupname = subtables[i]
                                    local lookupcache = thecache[lookupname]
                                    if lookupcache then
                                        local lookupmatch = lookupcache[start.char]
                                        if lookupmatch then
                                            start, success = handler(start,r[4],lookupname,lookupmatch,sequence,featuredata,i)
                                            if success then
                                                break
                                            end
                                        end
                                    else
                                        report_missing_cache(typ,lookupname)
                                    end
                                end
                                if start then start = start.prev end
                            else
                                start = start.prev
                            end
                        else
                            start = start.prev
                        end
                    else
                        start = start.prev
                    end
                end
            else
                local handler = handlers[typ]
                local ns = #subtables
                local thecache = featuredata[typ] or { }
                local start = head -- local ?
                rlmode = 0 -- to be checked ?
                if ns == 1 then
                    local lookupname = subtables[1]
                    local lookupcache = thecache[lookupname]
                    if not lookupcache then
                        report_missing_cache(typ,lookupname)
                    else
                        while start do
                            local id = start.id
                            if id == glyph then
                                if start.subtype<256 and start.font == font then
                                    local a = has_attribute(start,0)
                                    if a then
                                        a = (a == attr) and (not attribute or has_attribute(start,state,attribute))
                                    else
                                        a = not attribute or has_attribute(start,state,attribute)
                                    end
                                    if a then
                                        local lookupmatch = lookupcache[start.char]
                                        if lookupmatch then
                                            -- sequence kan weg
                                            local ok
                                            start, ok = handler(start,r[4],lookupname,lookupmatch,sequence,featuredata,1)
                                            if ok then
                                                success = true
                                            end
                                        end
                                        if start then start = start.next end
                                    else
                                        start = start.next
                                    end
                                else
                                    start = start.next
                                end
                            -- elseif id == glue then
                            --     if p[5] then -- chain
                            --         local pc = pp[32]
                            --         if pc then
                            --             start, ok = start, false -- p[1](start,kind,p[2],pc,p[3],p[4])
                            --             if ok then
                            --                 done = true
                            --             end
                            --             if start then start = start.next end
                            --         else
                            --             start = start.next
                            --         end
                            --     else
                            --         start = start.next
                            --     end
                            elseif id == whatsit then
                                local subtype = start.subtype
                                if subtype == 7 then
                                    local dir = start.dir
                                    if     dir == "+TRT" or dir == "+TLT" then
                                        insert(txtdir,dir)
                                    elseif dir == "-TRT" or dir == "-TLT" then
                                        remove(txtdir)
                                    end
                                    local d = txtdir[#txtdir]
                                    if d == "+TRT" then
                                        rlmode = -1
                                    elseif d == "+TLT" then
                                        rlmode = 1
                                    else
                                        rlmode = pardir
                                    end
                                    if trace_directions then
                                        logs.report("fonts","directions after textdir %s: pardir=%s, txtdir=%s:%s, rlmode=%s",dir,pardir,#txtdir,txtdir[#txtdir] or "unset",rlmode)
                                    end
                                elseif subtype == 6 then
                                    local dir = start.dir
                                    if dir == "TRT" then
                                        pardir = -1
                                    elseif dir == "TLT" then
                                        pardir = 1
                                    else
                                        pardir = 0
                                    end
                                    rlmode = pardir
                                --~ txtdir = { }
                                    if trace_directions then
                                        logs.report("fonts","directions after pardir %s: pardir=%s, txtdir=%s:%s, rlmode=%s",dir,pardir,#txtdir,txtdir[#txtdir] or "unset",rlmode)
                                    end
                                end
                                start = start.next
                            else
                                start = start.next
                            end
                        end
                    end
                else
                    while start do
                        local id = start.id
                        if id == glyph then
                            if start.subtype<256 and start.font == font then
                                local a = has_attribute(start,0)
                                if a then
                                    a = (a == attr) and (not attribute or has_attribute(start,state,attribute))
                                else
                                    a = not attribute or has_attribute(start,state,attribute)
                                end
                                if a then
                                    for i=1,ns do
                                        local lookupname = subtables[i]
                                        local lookupcache = thecache[lookupname]
                                        if lookupcache then
                                            local lookupmatch = lookupcache[start.char]
                                            if lookupmatch then
                                                -- we could move all code inline but that makes things even more unreadable
                                                local ok
                                                start, ok = handler(start,r[4],lookupname,lookupmatch,sequence,featuredata,i)
                                                if ok then
                                                    success = true
                                                    break
                                                end
                                            end
                                        else
                                            report_missing_cache(typ,lookupname)
                                        end
                                    end
                                    if start then start = start.next end
                                else
                                    start = start.next
                                end
                            else
                                start = start.next
                            end
                        -- elseif id == glue then
                        --     if p[5] then -- chain
                        --         local pc = pp[32]
                        --         if pc then
                        --             start, ok = start, false -- p[1](start,kind,p[2],pc,p[3],p[4])
                        --             if ok then
                        --                 done = true
                        --             end
                        --             if start then start = start.next end
                        --         else
                        --             start = start.next
                        --         end
                        --     else
                        --         start = start.next
                        --     end
                        elseif id == whatsit then
                            local subtype = start.subtype
                            if subtype == 7 then
                                local dir = start.dir
                                if     dir == "+TRT" or dir == "+TLT" then
                                    insert(txtdir,dir)
                                elseif dir == "-TRT" or dir == "-TLT" then
                                    remove(txtdir)
                                end
                                local d = txtdir[#txtdir]
                                if d == "+TRT" then
                                    rlmode = -1
                                elseif d == "+TLT" then
                                    rlmode = 1
                                else
                                    rlmode = pardir
                                end
                                if trace_directions then
                                    logs.report("fonts","directions after textdir %s: pardir=%s, txtdir=%s:%s, rlmode=%s",dir,pardir,#txtdir,txtdir[#txtdir] or "unset",rlmode)
                                end
                            elseif subtype == 6 then
                                local dir = start.dir
                                if dir == "TRT" then
                                    pardir = -1
                                elseif dir == "TLT" then
                                    pardir = 1
                                else
                                    pardir = 0
                                end
                                rlmode = pardir
                            --~ txtdir = { }
                                if trace_directions then
                                    logs.report("fonts","directions after pardir %s: pardir=%s, txtdir=%s:%s, rlmode=%s",dir,pardir,#txtdir,txtdir[#txtdir] or "unset",rlmode)
                                end
                            end
                            start = start.next
                        else
                            start = start.next
                        end
                    end
                end
            end
            if success then
                done = true
            end
            if trace_steps then -- ?
                registerstep(head)
            end
        end
    end
    return head, done
end

otf.features.prepare = { }

-- we used to share code in the following functions but that costs a lot of
-- memory due to extensive calls to functions (easily hundreds of thousands per
-- document)

local function split(replacement,original,cache,unicodes)
    -- we can cache this too, but not the same (although unicode is a unique enough hash)
    local o, t, n = { }, { }, 0
    for s in gmatch(original,"[^ ]+") do
        local us = unicodes[s]
        if type(us) == "number" then -- tonumber(us)
            o[#o+1] = us
        else
            o[#o+1] = us[1]
        end
    end
    for s in gmatch(replacement,"[^ ]+") do
        n = n + 1
        local us = unicodes[s]
        if type(us) == "number" then -- tonumber(us)
            t[o[n]] = us
        else
            t[o[n]] = us[1]
        end
    end
    return t
end

local function uncover(covers,result,cache,unicodes)
    -- lpeg hardly faster (.005 sec on mk)
    for n=1,#covers do
        local c = covers[n]
        local cc = cache[c]
        if not cc then
            local t = { }
            for s in gmatch(c,"[^ ]+") do
                local us = unicodes[s]
                if type(us) == "number" then
                    t[us] = true
                else
                    for i=1,#us do
                        t[us[i]] = true
                    end
                end
            end
            cache[c] = t
            result[#result+1] = t
        else
            result[#result+1] = cc
        end
    end
end

local function prepare_lookups(tfmdata)
    local otfdata = tfmdata.shared.otfdata
    local featuredata = otfdata.shared.featuredata
    local anchor_to_lookup = otfdata.luatex.anchor_to_lookup
    local lookup_to_anchor = otfdata.luatex.lookup_to_anchor
    --
    local multiple = featuredata.gsub_multiple
    local alternate = featuredata.gsub_alternate
    local single = featuredata.gsub_single
    local ligature = featuredata.gsub_ligature
    local pair = featuredata.gpos_pair
    local position = featuredata.gpos_single
    local kerns = featuredata.gpos_pair
    local mark = featuredata.gpos_mark2mark
    local cursive = featuredata.gpos_cursive
    --
    local unicodes = tfmdata.unicodes -- names to unicodes
    local indices = tfmdata.indices
    local descriptions = tfmdata.descriptions
    --
    -- we can change the otf table after loading but then we need to adapt base mode
    -- as well (no big deal)
    --
    local action = {
        substitution = function(p,lookup,glyph,unicode)
            local old, new = unicode, unicodes[p[2]]
            if type(new) == "table" then
                new = new[1]
            end
            local s = single[lookup]
            if not s then s = { } single[lookup] = s end
            s[old] = new
        --~ if trace_lookups then
        --~     logs.report("define otf","lookup %s: substitution %s => %s",lookup,old,new)
        --~ end
        end,
        multiple = function (p,lookup,glyph,unicode)
            local old, new = unicode, { }
            local m = multiple[lookup]
            if not m then m = { } multiple[lookup] = m end
            m[old] = new
            for pc in gmatch(p[2],"[^ ]+") do
                local upc = unicodes[pc]
                if type(upc) == "number" then
                    new[#new+1] = upc
                else
                    new[#new+1] = upc[1]
                end
            end
        --~ if trace_lookups then
        --~     logs.report("define otf","lookup %s: multiple %s => %s",lookup,old,concat(new," "))
        --~ end
        end,
        alternate = function(p,lookup,glyph,unicode)
            local old, new = unicode, { }
            local a = alternate[lookup]
            if not a then a = { } alternate[lookup] = a end
            a[old] = new
            for pc in gmatch(p[2],"[^ ]+") do
                local upc = unicodes[pc]
                if type(upc) == "number" then
                    new[#new+1] = upc
                else
                    new[#new+1] = upc[1]
                end
            end
        --~ if trace_lookups then
        --~     logs.report("define otf","lookup %s: alternate %s => %s",lookup,old,concat(new,"|"))
        --~ end
        end,
        ligature = function (p,lookup,glyph,unicode)
        --~ if trace_lookups then
        --~     logs.report("define otf","lookup %s: ligature %s => %s",lookup,p[2],glyph.name)
        --~ end
            local first = true
            local t = ligature[lookup]
            if not t then t = { } ligature[lookup] = t end
            for s in gmatch(p[2],"[^ ]+") do
                if first then
                    local u = unicodes[s]
                    if not u then
                        logs.report("define otf","lookup %s: ligature %s => %s ignored due to invalid unicode",lookup,p[2],glyph.name)
                        break
                    elseif type(u) == "number" then
                        if not t[u] then
                            t[u] = { { } }
                        end
                        t = t[u]
                    else
                        local tt = t
                        local tu
                        for i=1,#u do
                            local u = u[i]
                            if i==1 then
                                if not t[u] then
                                    t[u] = { { } }
                                end
                                tu = t[u]
                                t = tu
                            else
                                if not t[u] then
                                    tt[u] = tu
                                end
                            end
                        end
                    end
                    first = false
                else
                    s = unicodes[s]
                    local t1 = t[1]
                    if not t1[s] then
                        t1[s] = { { } }
                    end
                    t = t1[s]
                end
            end
            t[2] = unicode
        end,
        position = function(p,lookup,glyph,unicode)
            -- not used
            local s = position[lookup]
            if not s then s = { } position[lookup] = s end
            s[unicode] = p[2] -- direct pointer to kern spec
        end,
        pair = function(p,lookup,glyph,unicode)
            local s = pair[lookup]
            if not s then s = { } pair[lookup] = s end
            local others = s[unicode]
            if not others then others = { } s[unicode] = others end
            -- todo: fast check for space
            local two = p[2]
            local upc = unicodes[two]
            if not upc then
                for pc in gmatch(two,"[^ ]+") do
                    local upc = unicodes[pc]
                    if type(upc) == "number" then
                        others[upc] = p -- direct pointer to main table
                    else
                        for i=1,#upc do
                            others[upc[i]] = p -- direct pointer to main table
                        end
                    end
                end
            elseif type(upc) == "number" then
                others[upc] = p -- direct pointer to main table
            else
                for i=1,#upc do
                    others[upc[i]] = p -- direct pointer to main table
                end
            end
        --~ if trace_lookups then
        --~     logs.report("define otf","lookup %s: pair for U+%04X",lookup,unicode)
        --~ end
        end,
    }
    --
    for unicode, glyph in next, descriptions do
        local lookups = glyph.slookups
        if lookups then
            for lookup, p in next, lookups do
                action[p[1]](p,lookup,glyph,unicode)
            end
        end
        local lookups = glyph.mlookups
        if lookups then
            for lookup, whatever in next, lookups do
                for i=1,#whatever do -- normaly one
                    local p = whatever[i]
                    action[p[1]](p,lookup,glyph,unicode)
                end
            end
        end
        local list = glyph.mykerns
        if list then
            for lookup, krn in next, list do
                local k = kerns[lookup]
                if not k then k = { } kerns[lookup] = k end
                k[unicode] = krn -- ref to glyph, saves lookup
            --~ if trace_lookups then
            --~     logs.report("define otf","lookup %s: kern for U+%04X",lookup,unicode)
            --~ end
            end
        end
        local oanchor = glyph.anchors
        if oanchor then
            for typ, anchors in next, oanchor do -- types
                if typ == "mark" then
                    for name, anchor in next, anchors do
                        local lookups = anchor_to_lookup[name]
                        if lookups then
                            for lookup, _ in next, lookups do
                                local f = mark[lookup]
                                if not f then f = { } mark[lookup]  = f end
                                f[unicode] = anchors -- ref to glyph, saves lookup
                            --~ if trace_lookups then
                            --~     logs.report("define otf","lookup %s: mark anchor %s for U+%04X",lookup,name,unicode)
                            --~ end
                            end
                        end
                    end
                elseif typ == "cexit" then -- or entry?
                    for name, anchor in next, anchors do
                        local lookups = anchor_to_lookup[name]
                        if lookups then
                            for lookup, _ in next, lookups do
                                local f = cursive[lookup]
                                if not f then f = { } cursive[lookup]  = f end
                                f[unicode] = anchors -- ref to glyph, saves lookup
                            --~ if trace_lookups then
                            --~     logs.report("define otf","lookup %s: exit anchor %s for U+%04X",lookup,name,unicode)
                            --~ end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- local cache = { }
luatex = luatex or {} -- this has to change ... we need a better one

local function prepare_contextchains(tfmdata)
    local otfdata = tfmdata.shared.otfdata
    local lookups = otfdata.lookups
    if lookups then
        local featuredata = otfdata.shared.featuredata
        local contextchain = featuredata.gsub_contextchain -- shared with gpos
        local reversecontextchain = featuredata.gsub_reversecontextchain -- shared with gpos
        local characters = tfmdata.characters
        local unicodes = tfmdata.unicodes
        local indices = tfmdata.indices
        local cache = luatex.covers
        if not cache then
            cache = { }
            luatex.covers = cache
        end
        --
        for lookupname, lookupdata in next, otfdata.lookups do
            local lookuptype = lookupdata.type
            if not lookuptype then
                logs.report("otf process","missing lookuptype for %s",lookupname)
            else
                local rules = lookupdata.rules
                if rules then
                    local fmt = lookupdata.format
                    -- contextchain[lookupname][unicode]
                    if fmt == "coverage" then
                        if lookuptype ~= "chainsub" and lookuptype ~= "chainpos" then
                            logs.report("otf process","unsupported coverage %s for %s",lookuptype,lookupname)
                        else
                            local contexts = contextchain[lookupname]
                            if not contexts then
                                contexts = { }
                                contextchain[lookupname] = contexts
                            end
                            local t = { }
                            for nofrules=1,#rules do -- does #rules>1 happen often?
                                local rule = rules[nofrules]
                                local coverage = rule.coverage
                                if coverage and coverage.current then
                                    local current, before, after, sequence = coverage.current, coverage.before, coverage.after, { }
                                    if before then
                                        uncover(before,sequence,cache,unicodes)
                                    end
                                    local start = #sequence + 1
                                    uncover(current,sequence,cache,unicodes)
                                    local stop = #sequence
                                    if after then
                                        uncover(after,sequence,cache,unicodes)
                                    end
                                    if sequence[1] then
                                        t[#t+1] = { nofrules, lookuptype, sequence, start, stop, rule.lookups }
                                        for unic, _ in next, sequence[start] do
                                            local cu = contexts[unic]
                                            if not cu then
                                                contexts[unic] = t
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    elseif fmt == "reversecoverage" then
                        if lookuptype ~= "reversesub" then
                            logs.report("otf process","unsupported reverse coverage %s for %s",lookuptype,lookupname)
                        else
                            local contexts = reversecontextchain[lookupname]
                            if not contexts then
                                contexts = { }
                                reversecontextchain[lookupname] = contexts
                            end
                            local t = { }
                            for nofrules=1,#rules do
                                local rule = rules[nofrules]
                                local reversecoverage = rule.reversecoverage
                                if reversecoverage and reversecoverage.current then
                                    local current, before, after, replacements, sequence = reversecoverage.current, reversecoverage.before, reversecoverage.after, reversecoverage.replacements, { }
                                    if before then
                                        uncover(before,sequence,cache,unicodes)
                                    end
                                    local start = #sequence + 1
                                    uncover(current,sequence,cache,unicodes)
                                    local stop = #sequence
                                    if after then
                                        uncover(after,sequence,cache,unicodes)
                                    end
                                    if replacements then
                                        replacements = split(replacements,current[1],cache,unicodes)
                                    end
                                    if sequence[1] then
                                        -- this is different from normal coverage, we assume only replacements
                                        t[#t+1] = { nofrules, lookuptype, sequence, start, stop, rule.lookups, replacements }
                                        for unic, _ in next, sequence[start] do
                                            local cu = contexts[unic]
                                            if not cu then
                                                contexts[unic] = t
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    elseif fmt == "glyphs" then
                        if lookuptype ~= "chainsub" and lookuptype ~= "chainpos" then
                            logs.report("otf process","unsupported coverage %s for %s",lookuptype,lookupname)
                        else
                            local contexts = contextchain[lookupname]
                            if not contexts then
                                contexts = { }
                                contextchain[lookupname] = contexts
                            end
                            local t = { }
                            for nofrules=1,#rules do
                                -- nearly the same as coverage so we could as well rename it
                                local rule = rules[nofrules]
                                local glyphs = rule.glyphs
                                if glyphs and glyphs.names then
                                    local fore, back, names, sequence = glyphs.fore, glyphs.back, glyphs.names, { }
                                    if fore and fore ~= "" then
                                        fore = lpegmatch(split_at_space,fore)
                                        uncover(fore,sequence,cache,unicodes)
                                    end
                                    local start = #sequence + 1
                                    names = lpegmatch(split_at_space,names)
                                    uncover(names,sequence,cache,unicodes)
                                    local stop = #sequence
                                    if back and back ~= "" then
                                        back = lpegmatch(split_at_space,back)
                                        uncover(back,sequence,cache,unicodes)
                                    end
                                    if sequence[1] then
                                        t[#t+1] = { nofrules, lookuptype, sequence, start, stop, rule.lookups }
                                        for unic, _ in next, sequence[start] do
                                            local cu = contexts[unic]
                                            if not cu then
                                                contexts[unic] = t
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function fonts.initializers.node.otf.features(tfmdata,value)
    if true then -- value then
        if not tfmdata.shared.otfdata.shared.initialized then
            local t = trace_preparing and os.clock()
            local otfdata = tfmdata.shared.otfdata
            local featuredata = otfdata.shared.featuredata
            -- caches
            featuredata.gsub_multiple            = { }
            featuredata.gsub_alternate           = { }
            featuredata.gsub_single              = { }
            featuredata.gsub_ligature            = { }
            featuredata.gsub_contextchain        = { }
            featuredata.gsub_reversecontextchain = { }
            featuredata.gpos_pair                = { }
            featuredata.gpos_single              = { }
            featuredata.gpos_mark2base           = { }
            featuredata.gpos_mark2ligature       = featuredata.gpos_mark2base
            featuredata.gpos_mark2mark           = featuredata.gpos_mark2base
            featuredata.gpos_cursive             = { }
            featuredata.gpos_contextchain        = featuredata.gsub_contextchain
            featuredata.gpos_reversecontextchain = featuredata.gsub_reversecontextchain
            --
            prepare_contextchains(tfmdata)
            prepare_lookups(tfmdata)
            otfdata.shared.initialized = true
            if trace_preparing then
                logs.report("otf process","preparation time is %0.3f seconds for %s",os.clock()-t,tfmdata.fullname or "?")
            end
        end
    end
end
