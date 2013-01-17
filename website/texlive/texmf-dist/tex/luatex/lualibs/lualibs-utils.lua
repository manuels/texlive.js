if not modules then modules = { } end modules ['l-utils'] = {
    version   = 1.001,
    comment   = "companion to luat-lib.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

-- hm, quite unreadable

local gsub = string.gsub
local concat = table.concat
local type, next = type, next

if not utils        then utils        = { } end
if not utils.merger then utils.merger = { } end
if not utils.lua    then utils.lua    = { } end

utils.merger.m_begin = "begin library merge"
utils.merger.m_end   = "end library merge"
utils.merger.pattern =
    "%c+" ..
    "%-%-%s+" .. utils.merger.m_begin ..
    "%c+(.-)%c+" ..
    "%-%-%s+" .. utils.merger.m_end ..
    "%c+"

function utils.merger._self_fake_()
    return
        "-- " .. "created merged file" .. "\n\n" ..
        "-- " .. utils.merger.m_begin  .. "\n\n" ..
        "-- " .. utils.merger.m_end    .. "\n\n"
end

function utils.report(...)
    print(...)
end

utils.merger.strip_comment = true

function utils.merger._self_load_(name)
    local f, data = io.open(name), ""
    if f then
        utils.report("reading merge from %s",name)
        data = f:read("*all")
        f:close()
    else
        utils.report("unknown file to merge %s",name)
    end
    if data and utils.merger.strip_comment then
        -- saves some 20K
        data = gsub(data,"%-%-~[^\n\r]*[\r\n]", "")
    end
    return data or ""
end

function utils.merger._self_save_(name, data)
    if data ~= "" then
        local f = io.open(name,'w')
        if f then
            utils.report("saving merge from %s",name)
            f:write(data)
            f:close()
        end
    end
end

function utils.merger._self_swap_(data,code)
    if data ~= "" then
        return (gsub(data,utils.merger.pattern, function(s)
            return "\n\n" .. "-- "..utils.merger.m_begin .. "\n" .. code .. "\n" .. "-- "..utils.merger.m_end .. "\n\n"
        end, 1))
    else
        return ""
    end
end

--~ stripper:
--~
--~ data = gsub(data,"%-%-~[^\n]*\n","")
--~ data = gsub(data,"\n\n+","\n")

function utils.merger._self_libs_(libs,list)
    local result, f, frozen = { }, nil, false
    result[#result+1] = "\n"
    if type(libs) == 'string' then libs = { libs } end
    if type(list) == 'string' then list = { list } end
    local foundpath = nil
    for i=1,#libs do
        local lib = libs[i]
        for j=1,#list do
            local pth = gsub(list[j],"\\","/") -- file.clean_path
            utils.report("checking library path %s",pth)
            local name = pth .. "/" .. lib
            if lfs.isfile(name) then
                foundpath = pth
            end
        end
        if foundpath then break end
    end
    if foundpath then
        utils.report("using library path %s",foundpath)
        local right, wrong = { }, { }
        for i=1,#libs do
            local lib = libs[i]
            local fullname = foundpath .. "/" .. lib
            if lfs.isfile(fullname) then
            --  right[#right+1] = lib
                utils.report("merging library %s",fullname)
                result[#result+1] = "do -- create closure to overcome 200 locals limit"
                result[#result+1] = io.loaddata(fullname,true)
                result[#result+1] = "end -- of closure"
            else
            --  wrong[#wrong+1] = lib
                utils.report("no library %s",fullname)
            end
        end
        if #right > 0 then
            utils.report("merged libraries: %s",concat(right," "))
        end
        if #wrong > 0 then
            utils.report("skipped libraries: %s",concat(wrong," "))
        end
    else
        utils.report("no valid library path found")
    end
    return concat(result, "\n\n")
end

function utils.merger.selfcreate(libs,list,target)
    if target then
        utils.merger._self_save_(
            target,
            utils.merger._self_swap_(
                utils.merger._self_fake_(),
                utils.merger._self_libs_(libs,list)
            )
        )
    end
end

function utils.merger.selfmerge(name,libs,list,target)
    utils.merger._self_save_(
        target or name,
        utils.merger._self_swap_(
            utils.merger._self_load_(name),
            utils.merger._self_libs_(libs,list)
        )
    )
end

function utils.merger.selfclean(name)
    utils.merger._self_save_(
        name,
        utils.merger._self_swap_(
            utils.merger._self_load_(name),
            ""
        )
    )
end

function utils.lua.compile(luafile, lucfile, cleanup, strip) -- defaults: cleanup=false strip=true
 -- utils.report("compiling",luafile,"into",lucfile)
    os.remove(lucfile)
    local command = "-o " .. string.quote(lucfile) .. " " .. string.quote(luafile)
    if strip ~= false then
        command = "-s " .. command
    end
    local done = (os.spawn("texluac " .. command) == 0) or (os.spawn("luac " .. command) == 0)
    if done and cleanup == true and lfs.isfile(lucfile) and lfs.isfile(luafile) then
     -- utils.report("removing",luafile)
        os.remove(luafile)
    end
    return done
end

