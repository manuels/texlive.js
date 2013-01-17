if not modules then modules = { } end modules ['font-clr'] = {
    version   = 1.001,
    comment   = "companion to font-otf.lua (font color)",
    author    = "Khaled Hosny and Elie Roux",
    copyright = "Luaotfload Development Team",
    license   = "GPL"
}

fonts.triggers            = fonts.triggers            or { }
fonts.initializers        = fonts.initializers        or { }
fonts.initializers.common = fonts.initializers.common or { }

local initializers, format = fonts.initializers, string.format

table.insert(fonts.triggers,"color")

function initializers.common.color(tfmdata,value)
    local sanitized

    if value then
        value = tostring(value)
        if #value == 6 or #value == 8 then
            sanitized = value
        elseif #value == 7 then
            _, _, sanitized = value:find("(......)")
        elseif #value > 8 then
            _, _, sanitized = value:find("(........)")
        else
            -- broken color code ignored, issue a warning?
        end
    end

    if sanitized then
        tfmdata.color = sanitized
        add_color_callback()
    end
end

initializers.base.otf.color = initializers.common.color
initializers.node.otf.color = initializers.common.color

local function hex2dec(hex,one)
    if one then
        return format("%.1g", tonumber(hex, 16)/255)
    else
        return format("%.3g", tonumber(hex, 16)/255)
    end
end

local res

local function pageresources(a)
    local res2
    if not res then
       res = "/TransGs1<</ca 1/CA 1>>"
    end
    res2 = format("/TransGs%s<</ca %s/CA %s>>", a, a, a)
    res  = format("%s%s", res, res:find(res2) and "" or res2)
end

local function hex_to_rgba(hex)
    local r, g, b, a, push, pop, res3
    if hex then
        if #hex == 6 then
            _, _, r, g, b    = hex:find('(..)(..)(..)')
        elseif #hex == 8 then
            _, _, r, g, b, a = hex:find('(..)(..)(..)(..)')
            a                = hex2dec(a,true)
            pageresources(a)
        end
    else
        return nil
    end
    r = hex2dec(r)
    g = hex2dec(g)
    b = hex2dec(b)
    if a then
        push = format('/TransGs%g gs %s %s %s rg', a, r, g, b)
        pop  = '0 g /TransGs1 gs'
    else
        push = format('%s %s %s rg', r, g, b)
        pop  = '0 g'
    end
    return push, pop
end

local glyph   = node.id('glyph')
local hlist   = node.id('hlist')
local vlist   = node.id('vlist')
local whatsit = node.id('whatsit')
local pgi     = node.id('page_insert')
local sbox    = node.id('sub_box')

local function lookup_next_color(head)
    for n in node.traverse(head) do
        if n.id == glyph then
            if fonts.ids[n.font] and fonts.ids[n.font].color then
                return fonts.ids[n.font].color
            else
                return -1
            end
        elseif n.id == vlist or n.id == hlist or n.id == sbox then
            local r = lookup_next_color(n.list)
            if r == -1 then
                return -1
            elseif r then
                return r
            end
        elseif n.id == whatsit or n.id == pgi then
            return -1
        end
    end
    return nil
end

local function node_colorize(head, current_color, next_color)
    for n in node.traverse(head) do
        if n.id == hlist or n.id == vlist or n.id == sbox then
            local next_color_in = lookup_next_color(n.next) or next_color
            n.list, current_color = node_colorize(n.list, current_color, next_color_in)
        elseif n.id == glyph then
            local tfmdata = fonts.ids[n.font]
            if tfmdata and tfmdata.color then
                if tfmdata.color ~= current_color then
                    local pushcolor = hex_to_rgba(tfmdata.color)
                    local push = node.new(whatsit, 8)
                    push.mode  = 1
                    push.data  = pushcolor
                    head       = node.insert_before(head, n, push)
                    current_color = tfmdata.color
                end
                local next_color_in = lookup_next_color (n.next) or next_color
                if next_color_in ~= tfmdata.color then
                    local _, popcolor = hex_to_rgba(tfmdata.color)
                    local pop  = node.new(whatsit, 8)
                    pop.mode   = 1
                    pop.data   = popcolor
                    head       = node.insert_after(head, n, pop)
                    current_color = nil
                end
            end
        end
    end
    return head, current_color
end

local function font_colorize(head)
   -- check if our page resources existed in the previous run
   -- and remove it to avoid duplicating it later
   if res then
      local r = "/ExtGState<<"..res..">>"
      tex.pdfpageresources = tex.pdfpageresources:gsub(r, "")
   end
   local h = node_colorize(head, nil, nil)
   -- now append our page resources
   if res and res:find("%S") then -- test for non-empty string
      local r = "/ExtGState<<"..res..">>"
      tex.pdfpageresources = tex.pdfpageresources..r
   end
   return h
end

local color_callback_activated = 0

function add_color_callback()
    if color_callback_activated == 0 then
        luatexbase.add_to_callback("pre_output_filter", font_colorize, "loaotfload.colorize")
        color_callback_activated = 1
    end
end
