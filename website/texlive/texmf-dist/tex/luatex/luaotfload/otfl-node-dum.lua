if not modules then modules = { } end modules ['node-dum'] = {
    version   = 1.001,
    comment   = "companion to luatex-*.tex",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

nodes      = nodes      or { }
fonts      = fonts      or { }
attributes = attributes or { }

local traverse_id = node.traverse_id
local free_node   = node.free
local remove_node = node.remove
local new_node    = node.new

local glyph = node.id('glyph')

-- fonts

local fontdata = fonts.ids or { }

function nodes.simple_font_handler(head)
--  lang.hyphenate(head)
    head = nodes.process_characters(head)
    nodes.inject_kerns(head)
    nodes.protect_glyphs(head)
    head = node.ligaturing(head)
    head = node.kerning(head)
    return head
end

if tex.attribute[0] ~= 0 then

    texio.write_nl("log","!")
    texio.write_nl("log","! Attribute 0 is reserved for ConTeXt's font feature management and has to be")
    texio.write_nl("log","! set to zero. Also, some attributes in the range 1-255 are used for special")
    texio.write_nl("log","! purposed so setting them at the TeX end might break the font handler.")
    texio.write_nl("log","!")

    tex.attribute[0] = 0 -- else no features

end

nodes.protect_glyphs   = node.protect_glyphs
nodes.unprotect_glyphs = node.unprotect_glyphs

function nodes.process_characters(head)
    local usedfonts, done, prevfont = { }, false, nil
    for n in traverse_id(glyph,head) do
        local font = n.font
        if font ~= prevfont then
            prevfont = font
            local used = usedfonts[font]
            if not used then
                local tfmdata = fontdata[font]
                if tfmdata then
                    local shared = tfmdata.shared -- we need to check shared, only when same features
                    if shared then
                        local processors = shared.processes
                        if processors and #processors > 0 then
                            usedfonts[font] = processors
                            done = true
                        end
                    end
                end
            end
        end
    end
    if done then
        for font, processors in next, usedfonts do
            for i=1,#processors do
                local h, d = processors[i](head,font,0)
                head, done = h or head, done or d
            end
        end
    end
    return head, true
end

-- helper

function nodes.kern(k)
    local n = new_node("kern",1)
    n.kern = k
    return n
end

function nodes.remove(head, current, free_too)
   local t = current
   head, current = remove_node(head,current)
   if t then
        if free_too then
            free_node(t)
            t = nil
        else
            t.next, t.prev = nil, nil
        end
   end
   return head, current, t
end

function nodes.delete(head,current)
    return nodes.remove(head,current,true)
end

nodes.before = node.insert_before
nodes.after  = node.insert_after

-- attributes

attributes.unsetvalue = -0x7FFFFFFF

local numbers, last = { }, 127

function attributes.private(name)
    local number = numbers[name]
    if not number then
        if last < 255 then
            last = last + 1
        end
        number = last
        numbers[name] = number
    end
    return number
end
