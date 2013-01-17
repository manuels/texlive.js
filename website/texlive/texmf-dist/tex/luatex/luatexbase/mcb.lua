-- 
--  This is file `mcb.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luatexbase-mcb.dtx  (with options: `lua')
--  
--  Copyright (C) 2009 by Elie Roux <elie.roux@telecom-bretagne.eu>
--  
--  This work is under the CC0 license.
--  See source file 'luatexbase-mcb.dtx' for details.
--  
module('luatexbase', package.seeall)
local err, warning, info = luatexbase.provides_module({
    name          = "luatexbase-mcb",
    version       = 0.2,
    date          = "2010/05/12",
    description   = "register several functions in a callback",
    author        = "Hans Hagen, Elie Roux and Manuel Pegourie-Gonnard",
    copyright     = "Hans Hagen, Elie Roux and Manuel Pegourie-Gonnard",
    license       = "CC0",
})
local callbacklist = callbacklist or { }
local list, data, first, simple = 1, 2, 3, 4
local types = {
    list   = list,
    data   = data,
    first  = first,
    simple = simple,
}
local callbacktypes = callbacktypes or {
    find_read_file     = first,
    find_write_file    = first,
    find_font_file     = data,
    find_output_file   = data,
    find_format_file   = data,
    find_vf_file       = data,
    find_ocp_file      = data,
    find_map_file      = data,
    find_enc_file      = data,
    find_sfd_file      = data,
    find_pk_file       = data,
    find_data_file     = data,
    find_opentype_file = data,
    find_truetype_file = data,
    find_type1_file    = data,
    find_image_file    = data,
    open_read_file     = first,
    read_font_file     = first,
    read_vf_file       = first,
    read_ocp_file      = first,
    read_map_file      = first,
    read_enc_file      = first,
    read_sfd_file      = first,
    read_pk_file       = first,
    read_data_file     = first,
    read_truetype_file = first,
    read_type1_file    = first,
    read_opentype_file = first,
    process_input_buffer  = data,
    process_output_buffer = data,
    token_filter          = first,
    buildpage_filter      = simple,
    pre_linebreak_filter  = list,
    linebreak_filter      = list,
    post_linebreak_filter = list,
    hpack_filter          = list,
    vpack_filter          = list,
    pre_output_filter     = list,
    hyphenate             = simple,
    ligaturing            = simple,
    kerning               = simple,
    mlist_to_hlist        = list,
    start_run         = simple,
    stop_run          = simple,
    start_page_number = simple,
    stop_page_number  = simple,
    show_error_hook   = simple,
    define_font = first,
}
local lua_callbacks_defaults = { }
local original_register = original_register or callback.register
callback.register = function ()
  err("function callback.register has been trapped,\n"
  .."please use luatexbase.add_to_callback instead.")
end
local function register_callback(...)
    return assert(original_register(...))
end
local function listhandler (name)
    return function(head,...)
        local ret
        local alltrue = true
        for _, f in ipairs(callbacklist[name]) do
            ret = f.func(head, ...)
            if ret == false then
                warn("function '%s' returned false\nin callback '%s'",
                    f.description, name)
                break
            end
            if ret ~= true then
                alltrue = false
                head = ret
            end
        end
        return alltrue and true or head
    end
end
local function datahandler (name)
    return function(data, ...)
        for _, f in ipairs(callbacklist[name]) do
            data = f.func(data, ...)
        end
        return data
    end
end
local function firsthandler (name)
    return function(...)
        return callbacklist[name][1].func(...)
    end
end
local function simplehandler (name)
    return function(...)
        for _, f in ipairs(callbacklist[name]) do
            f.func(...)
        end
    end
end
local handlers = {
  [list]   = listhandler,
  [data]   = datahandler,
  [first]  = firsthandler,
  [simple] = simplehandler,
}
function add_to_callback (name,func,description,priority)
    if type(func) ~= "function" then
        return err("unable to add function:\nno proper function passed")
    end
    if not name or name == "" then
        err("unable to add function:\nno proper callback name passed")
        return
    elseif not callbacktypes[name] then
        err("unable to add function:\n'%s' is not a valid callback", name)
        return
    end
    if not description or description == "" then
        err("unable to add function to '%s':\nno proper description passed",
          name)
        return
    end
    if priority_in_callback(name, description) then
        err("function '%s' already registered\nin callback '%s'",
          description, name)
        return
    end
    local l = callbacklist[name]
    if not l then
        l = {}
        callbacklist[name] = l
        if not lua_callbacks_defaults[name] then
            register_callback(name, handlers[callbacktypes[name]](name))
        end
    end
    local f = {
        func = func,
        description = description,
    }
    priority = tonumber(priority)
    if not priority or priority > #l then
        priority = #l+1
    elseif priority < 1 then
        priority = 1
    end
    table.insert(l,priority,f)
    if callbacktypes[name] == first and #l ~= 1 then
        warning("several functions in '%s',\n"
        .."only one will be active.", name)
    end
    info("inserting '%s'\nat position %s in '%s'",
      description, priority, name)
end
function remove_from_callback (name, description)
    if not name or name == "" then
        err("unable to remove function:\nno proper callback name passed")
        return
    elseif not callbacktypes[name] then
        err("unable to remove function:\n'%s' is not a valid callback", name)
        return
    end
    if not description or description == "" then
        err(
          "unable to remove function from '%s':\nno proper description passed",
          name)
        return
    end
    local l = callbacklist[name]
    if not l then
        err("no callback list for '%s'",name)
        return
    end
    local index = false
    for k,v in ipairs(l) do
        if v.description == description then
            index = k
            break
        end
    end
    if not index then
        err("unable to remove '%s'\nfrom '%s'", description, name)
        return
    end
    table.remove(l, index)
    info("removing '%s'\nfrom '%s'", description, name)
    if table.maxn(l) == 0 then
        callbacklist[name] = nil
        if not lua_callbacks_defaults[name] then
            register_callback(name, nil)
        end
    end
    return
end
function reset_callback (name, make_false)
    if not name or name == "" then
        err("unable to reset:\nno proper callback name passed")
        return
    elseif not callbacktypes[name] then
        err("unable to reset '%s':\nis not a valid callback", name)
        return
    end
    info("resetting callback '%s'", name)
    callbacklist[name] = nil
    if not lua_callbacks_defaults[name] then
        if make_false == true then
            info("setting '%s' to false", name)
            register_callback(name, false)
        else
            register_callback(name, nil)
        end
    end
end
function priority_in_callback (name, description)
    if not name or name == ""
            or not callbacktypes[name]
            or not description then
        return false
    end
    local l = callbacklist[name]
    if not l then return false end
    for p, f in pairs(l) do
        if f.description == description then
            return p
        end
    end
    return false
end
function create_callback(name, ctype, default)
    if not name then
        err("unable to call callback:\nno proper name passed", name)
        return nil
    end
    if not ctype or not default then
        err("unable to create callback '%s':\n"
        .."callbacktype or default function not specified", name)
        return nil
    end
    if callbacktypes[name] then
        err("unable to create callback '%s':\ncallback already exists", name)
        return nil
    end
    ctype = types[ctype]
    if not ctype then
        err("unable to create callback '%s':\ntype '%s' undefined", name, ctype)
        return nil
    end
    info("creating '%s' type %s", name, ctype)
    lua_callbacks_defaults[name] = default
    callbacktypes[name] = ctype
end
function call_callback(name, ...)
    if not name then
        err("unable to call callback:\nno proper name passed", name)
        return nil
    end
    if not lua_callbacks_defaults[name] then
        err("unable to call lua callback '%s':\nunknown callback", name)
        return nil
    end
    local l = callbacklist[name]
    local f
    if not l then
        f = lua_callbacks_defaults[name]
    else
        f = handlers[callbacktypes[name]](name)
        if not f then
            err("unknown callback type")
            return
        end
    end
    return f(...)
end
-- 
--  End of File `mcb.lua'.
