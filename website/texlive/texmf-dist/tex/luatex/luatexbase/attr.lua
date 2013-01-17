-- 
--  This is file `attr.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luatexbase-attr.dtx  (with options: `luamodule')
--  
--  Written in 2009, 2010 by Manuel Pegourie-Gonnard and Elie Roux.
--  
--  This work is under the CC0 license.
--  See source file 'luatexbase-attr.dtx' for details.
--  
module('luatexbase', package.seeall)
attributes = {}
local last_alloc = 0
function new_attribute(name, silent)
    if last_alloc >= 65535 then
        if silent then
            return -1
        else
            error("No room for a new \\attribute", 1)
        end
    end
    last_alloc = last_alloc + 1
    attributes[name] = last_alloc
    unset_attribute(name)
    if not silent then
        texio.write_nl('log', string.format(
            'luatexbase.attributes[%q] = %d', name, last_alloc))
    end
    return last_alloc
end
local unset_value = (luatexbase.luatexversion < 37) and -1 or -2147483647
function unset_attribute(name)
    tex.setattribute(attributes[name], unset_value)
end
-- 
--  End of File `attr.lua'.
