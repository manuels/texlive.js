-- 
--  This is file `luaotfload.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luaotfload.dtx  (with options: `lua')
--  This is a generated file.
--  
--  Copyright (C) 2009-2010 by by Elie Roux    <elie.roux@telecom-bretagne.eu>
--                            and Khaled Hosny <khaledhosny@eglug.org>
--                                 (Support: <lualatex-dev@tug.org>.)
--  
--  This work is under the CC0 license.
--  
--  This work consists of the main source file luaotfload.dtx
--  and the derived files
--      luaotfload.sty, luaotfload.lua
--  
module("luaotfload", package.seeall)

luaotfload.module = {
    name          = "luaotfload",
    version       = 1.27,
    date          = "2012/05/28",
    description   = "OpenType layout system.",
    author        = "Elie Roux & Hans Hagen",
    copyright     = "Elie Roux",
    license       = "CC0"
}

local error, warning, info, log = luatexbase.provides_module(luaotfload.module)
kpse.init_prog("", 600, "/")
local luatex_version = 60

if tex.luatexversion < luatex_version then
    warning("LuaTeX v%.2f is old, v%.2f is recommended.",
             tex.luatexversion/100,
             luatex_version   /100)
end
function luaotfload.loadmodule(name)
    local tofind = "otfl-"..name
    local found = kpse.find_file(tofind,"tex")
    if found then
        log("loading file %s.", found)
        dofile(found)
    else
        error("file %s not found.", tofind)
    end
end
luaotfload.loadmodule("luat-dum.lua") -- not used in context at all
luaotfload.loadmodule("luat-ovr.lua") -- override some luat-dum functions
luaotfload.loadmodule("data-con.lua") -- maybe some day we don't need this one
tex.attribute[0] = 0
luaotfload.loadmodule("font-ini.lua")
luaotfload.loadmodule("node-dum.lua")
luaotfload.loadmodule("node-inj.lua")
function attributes.private(name)
    local attr   = "otfl@" .. name
    local number = luatexbase.attributes[attr]
    if not number then
        number = luatexbase.new_attribute(attr)
    end
    return number
end
luaotfload.loadmodule("font-tfm.lua")
luaotfload.loadmodule("font-cid.lua")
luaotfload.loadmodule("font-ott.lua")
luaotfload.loadmodule("font-map.lua")
luaotfload.loadmodule("font-otf.lua")
luaotfload.loadmodule("font-otd.lua")
luaotfload.loadmodule("font-oti.lua")
luaotfload.loadmodule("font-otb.lua")
luaotfload.loadmodule("font-otn.lua")
luaotfload.loadmodule("font-ota.lua")
luaotfload.loadmodule("font-otc.lua")
luaotfload.loadmodule("font-def.lua")
luaotfload.loadmodule("font-xtx.lua")
luaotfload.loadmodule("font-dum.lua")
if fonts and fonts.tfm and fonts.tfm.readers then
    fonts.tfm.readers.ofm = fonts.tfm.readers.tfm
end
luaotfload.loadmodule("font-nms.lua")
luaotfload.loadmodule("font-clr.lua")
luatexbase.create_callback("luaotfload.patch_font", "simple", function() end)
local function def_font(...)
    local fontdata = fonts.define.read(...)
    if type(fontdata) == "table" and fontdata.shared then
        local otfdata = fontdata.shared.otfdata
        if otfdata.metadata.math then
            local mc = { }
            for k,v in next, otfdata.metadata.math do
                if k:find("Percent") then
                    -- keep percent values as is
                    mc[k] = v
                else
                    mc[k] = v / fontdata.units * fontdata.size
                end
            end
            -- for \overwithdelims
            mc.FractionDelimiterSize             = 1.01 * fontdata.size
            mc.FractionDelimiterDisplayStyleSize = 2.39 * fontdata.size

            fontdata.MathConstants = mc
        end
        luatexbase.call_callback("luaotfload.patch_font", fontdata)
    end
    return fontdata
end
fonts.mode = "node"
local register_base_sub = fonts.otf.features.register_base_substitution
local gsubs = {
    "ss01", "ss02", "ss03", "ss04", "ss05",
    "ss06", "ss07", "ss08", "ss09", "ss10",
    "ss11", "ss12", "ss13", "ss14", "ss15",
    "ss16", "ss17", "ss18", "ss19", "ss20",
}

for _,v in next, gsubs do
    register_base_sub(v)
end
luatexbase.add_to_callback("pre_linebreak_filter",
                            nodes.simple_font_handler,
                           "luaotfload.pre_linebreak_filter")
luatexbase.add_to_callback("hpack_filter",
                            nodes.simple_font_handler,
                           "luaotfload.hpack_filter")
luatexbase.reset_callback("define_font")
luatexbase.add_to_callback("define_font",
                            def_font,
                           "luaotfload.define_font", 1)
luatexbase.add_to_callback("find_vf_file",
                            fonts.vf.find,
                           "luaotfload.find_vf_file")
local function set_sscale_diments(fontdata)
    local mc = fontdata.MathConstants
    if mc then
        if mc["ScriptPercentScaleDown"] then
            fontdata.parameters[10] = mc.ScriptPercentScaleDown
        else -- resort to plain TeX default
            fontdata.parameters[10] = 70
        end
        if mc["ScriptScriptPercentScaleDown"] then
            fontdata.parameters[11] = mc.ScriptScriptPercentScaleDown
        else -- resort to plain TeX default
            fontdata.parameters[11] = 50
        end
    end
end

luatexbase.add_to_callback("luaotfload.patch_font", set_sscale_diments, "unicodemath.set_sscale_diments")
-- 
--  End of File `luaotfload.lua'.
