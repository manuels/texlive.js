-- 
--  This is file `luatexbase.loader.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luatexbase-loader.dtx  (with options: `luamodule')
--  
--  Written in 2009, 2010 by Manuel Pegourie-Gonnard and Elie Roux.
--  
--  This work is under the CC0 license.
--  See source file 'luatexbase-loader.dtx' for details.
--  
module('luatexbase', package.seeall)
local lua_suffixes = {
  ".luc", ".luctex", ".texluc", ".lua", ".luatex", ".texlua",
}
local function ends_with(suffix, name)
    return name:sub(-suffix:len()) == suffix
end
function find_file_lua_emul(name)
  local search_list = {}
  for _, suffix in ipairs(lua_suffixes) do
    if ends_with(suffix, name) then
      search_list = { name }
      break
    else
      table.insert(search_list, name..suffix)
    end
  end
  for _, search_name in ipairs(search_list) do
    local f = kpse.find_file(search_name, 'texmfscripts')
      or kpse.find_file(search_name, 'tex')
    if f and ends_with(search_name, f) then
      return f
    end
  end
end
local find_file_lua
if pcall('kpse.find_file', 'dummy', 'lua') then
  find_file_lua = function (name)
    return kpse.find_file(name, 'lua') or find_file_lua_emul(name)
  end
else
  find_file_lua = function (name)
    return find_file_lua_emul(name)
  end
end
local function find_module_file(mod)
  return find_file_lua(mod:gsub('%.', '/'), 'lua')
    or find_file_lua(mod, 'lua')
end
local package_loader_two = package.loaders[2]
local function load_module(mod)
  local file = find_module_file(mod)
  if not file then
    local msg = "\n\t[luatexbase.loader] Search failed"
    local ret = package_loader_two(mod)
    if type(ret) == 'string' then
      return msg..ret
    elseif type(ret) == 'nil' then
      return msg
    else
      return ret
    end
  end
  local loader, error = loadfile(file)
  if not loader then
    return "\n\t[luatexbase.loader] Loading error:\n\t"..error
  end
  texio.write_nl("("..file..")")
  return loader
end
package.loaders[2] = load_module
-- 
--  End of File `luatexbase.loader.lua'.
