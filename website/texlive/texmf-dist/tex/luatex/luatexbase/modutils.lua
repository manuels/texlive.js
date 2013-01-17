-- 
--  This is file `modutils.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luatexbase-modutils.dtx  (with options: `luamodule')
--  
--  Written in 2009, 2010 by Manuel Pegourie-Gonnard and Elie Roux.
--  
--  This work is under the CC0 license.
--  See source file 'luatexbase-modutils.dtx' for details.
--  
module("luatexbase", package.seeall)
local modules = modules or {}
local function date_to_int(date)
    numbers = string.gsub(date, "(%d+)/(%d+)/(%d+)", "%1%2%3")
    return tonumber(numbers)
end
local function msg_format(msg_type, mod_name, ...)
  local cont = '('..mod_name..')' .. ('Module: '..msg_type):gsub('.', ' ')
  return 'Module '..mod_name..' '..msg_type..': '
    .. string.format(...):gsub('\n', '\n'..cont) .. '\n'
end
local function module_error_int(mod, ...)
  error(msg_format('error', mod, ...), 3)
end
function module_error(mod, ...)
  module_error_int(mod, ...)
end
function module_warning(mod, ...)
  for _, line in ipairs(msg_format('warning', mod, ...):explode('\n')) do
    texio.write_nl(line)
  end
end
function module_info(mod, ...)
  for _, line in ipairs(msg_format('info', mod, ...):explode('\n')) do
    texio.write_nl(line)
  end
end
function module_log(mod, msg, ...)
  texio.write_nl('log', mod..': '..msg:format(...))
end
function errwarinf(name)
  return function(...) module_error_int(name, ...) end,
    function(...) module_warning(name, ...) end,
    function(...) module_info(name, ...) end,
    function(...) module_log(name, ...) end
end
local err, warn = errwarinf('luatexbase.modutils')
function require_module(name, req_date)
    require(name)
    local info = modules[name]
    if not info then
        warn("module '%s' was not properly identified", name)
    elseif version then
        if not (info.date and date_to_int(info.date) > date_to_int(req_date))
        then
            warn("module '%s' required in version '%s'\n"
            .. "but found in version '%s'", name, req_date, info.date)
        end
    end
end
function provides_module(info)
    if not (info and info.name) then
        err('provides_module: missing information')
    end
    texio.write_nl('log', string.format("Lua module: %s %s %s %s\n",
    info.name, info.date or '', info.version or '', info.description or ''))
    modules[info.name] = info
    return errwarinf(info.name)
end
-- 
--  End of File `modutils.lua'.
