if not modules then modules = { } end modules ['l-table'] = {
    version   = 1.001,
    comment   = "companion to luat-lib.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

table.join = table.concat

local concat, sort, insert, remove = table.concat, table.sort, table.insert, table.remove
local format, find, gsub, lower, dump, match = string.format, string.find, string.gsub, string.lower, string.dump, string.match
local getmetatable, setmetatable = getmetatable, setmetatable
local type, next, tostring, tonumber, ipairs = type, next, tostring, tonumber, ipairs

-- Starting with version 5.2 Lua no longer provide ipairs, which makes
-- sense. As we already used the for loop and # in most places the
-- impact on ConTeXt was not that large; the remaining ipairs already
-- have been replaced. In a similar fashio we also hardly used pairs.
--
-- Just in case, we provide the fallbacks as discussed in Programming
-- in Lua (http://www.lua.org/pil/7.3.html):

if not ipairs then

    -- for k, v in ipairs(t) do                ... end
    -- for k=1,#t            do local v = t[k] ... end

    local function iterate(a,i)
        i = i + 1
        local v = a[i]
        if v ~= nil then
            return i, v --, nil
        end
    end

    function ipairs(a)
        return iterate, a, 0
    end

end

if not pairs then

    -- for k, v in pairs(t) do ... end
    -- for k, v in next, t  do ... end

    function pairs(t)
        return next, t -- , nil
    end

end

-- Also, unpack has been moved to the table table, and for compatiility
-- reasons we provide both now.

if not table.unpack then
    table.unpack = _G.unpack
elseif not unpack then
    _G.unpack = table.unpack
end

-- extra functions, some might go (when not used)

function table.strip(tab)
    local lst = { }
    for i=1,#tab do
        local s = gsub(tab[i],"^%s*(.-)%s*$","%1")
        if s == "" then
            -- skip this one
        else
            lst[#lst+1] = s
        end
    end
    return lst
end

function table.keys(t)
    local k = { }
    for key, _ in next, t do
        k[#k+1] = key
    end
    return k
end

local function compare(a,b)
    return (tostring(a) < tostring(b))
end

local function sortedkeys(tab)
    local srt, kind = { }, 0 -- 0=unknown 1=string, 2=number 3=mixed
    for key,_ in next, tab do
        srt[#srt+1] = key
        if kind == 3 then
            -- no further check
        else
            local tkey = type(key)
            if tkey == "string" then
            --  if kind == 2 then kind = 3 else kind = 1 end
                kind = (kind == 2 and 3) or 1
            elseif tkey == "number" then
            --  if kind == 1 then kind = 3 else kind = 2 end
                kind = (kind == 1 and 3) or 2
            else
                kind = 3
            end
        end
    end
    if kind == 0 or kind == 3 then
        sort(srt,compare)
    else
        sort(srt)
    end
    return srt
end

local function sortedhashkeys(tab) -- fast one
    local srt = { }
    for key,_ in next, tab do
        srt[#srt+1] = key
    end
    sort(srt)
    return srt
end

table.sortedkeys     = sortedkeys
table.sortedhashkeys = sortedhashkeys

function table.sortedhash(t)
    local s = sortedhashkeys(t) -- maybe just sortedkeys
    local n = 0
    local function kv(s)
        n = n + 1
        local k = s[n]
        return k, t[k]
    end
    return kv, s
end

table.sortedpairs = table.sortedhash

function table.append(t, list)
    for _,v in next, list do
        insert(t,v)
    end
end

function table.prepend(t, list)
    for k,v in next, list do
        insert(t,k,v)
    end
end

function table.merge(t, ...) -- first one is target
    t = t or {}
    local lst = {...}
    for i=1,#lst do
        for k, v in next, lst[i] do
            t[k] = v
        end
    end
    return t
end

function table.merged(...)
    local tmp, lst = { }, {...}
    for i=1,#lst do
        for k, v in next, lst[i] do
            tmp[k] = v
        end
    end
    return tmp
end

function table.imerge(t, ...)
    local lst = {...}
    for i=1,#lst do
        local nst = lst[i]
        for j=1,#nst do
            t[#t+1] = nst[j]
        end
    end
    return t
end

function table.imerged(...)
    local tmp, lst = { }, {...}
    for i=1,#lst do
        local nst = lst[i]
        for j=1,#nst do
            tmp[#tmp+1] = nst[j]
        end
    end
    return tmp
end

local function fastcopy(old) -- fast one
    if old then
        local new = { }
        for k,v in next, old do
            if type(v) == "table" then
                new[k] = fastcopy(v) -- was just table.copy
            else
                new[k] = v
            end
        end
        -- optional second arg
        local mt = getmetatable(old)
        if mt then
            setmetatable(new,mt)
        end
        return new
    else
        return { }
    end
end

local function copy(t, tables) -- taken from lua wiki, slightly adapted
    tables = tables or { }
    local tcopy = {}
    if not tables[t] then
        tables[t] = tcopy
    end
    for i,v in next, t do -- brrr, what happens with sparse indexed
        if type(i) == "table" then
            if tables[i] then
                i = tables[i]
            else
                i = copy(i, tables)
            end
        end
        if type(v) ~= "table" then
            tcopy[i] = v
        elseif tables[v] then
            tcopy[i] = tables[v]
        else
            tcopy[i] = copy(v, tables)
        end
    end
    local mt = getmetatable(t)
    if mt then
        setmetatable(tcopy,mt)
    end
    return tcopy
end

table.fastcopy = fastcopy
table.copy     = copy

-- roughly: copy-loop : unpack : sub == 0.9 : 0.4 : 0.45 (so in critical apps, use unpack)

function table.sub(t,i,j)
    return { unpack(t,i,j) }
end

function table.replace(a,b)
    for k,v in next, b do
        a[k] = v
    end
end

-- slower than #t on indexed tables (#t only returns the size of the numerically indexed slice)

function table.is_empty(t) -- obolete, use inline code instead
    return not t or not next(t)
end

function table.one_entry(t) -- obolete, use inline code instead
    local n = next(t)
    return n and not next(t,n)
end

--~ function table.starts_at(t) -- obsolete, not nice anyway
--~     return ipairs(t,1)(t,0)
--~ end

function table.tohash(t,value)
    local h = { }
    if t then
        if value == nil then value = true end
        for _, v in next, t do -- no ipairs here
            h[v] = value
        end
    end
    return h
end

function table.fromhash(t)
    local h = { }
    for k, v in next, t do -- no ipairs here
        if v then h[#h+1] = k end
    end
    return h
end

--~ print(table.serialize(t), "\n")
--~ print(table.serialize(t,"name"), "\n")
--~ print(table.serialize(t,false), "\n")
--~ print(table.serialize(t,true), "\n")
--~ print(table.serialize(t,"name",true), "\n")
--~ print(table.serialize(t,"name",true,true), "\n")

table.serialize_functions = true
table.serialize_compact   = true
table.serialize_inline    = true

local noquotes, hexify, handle, reduce, compact, inline, functions

local reserved = table.tohash { -- intercept a language flaw, no reserved words as key
    'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 'function', 'if',
    'in', 'local', 'nil', 'not', 'or', 'repeat', 'return', 'then', 'true', 'until', 'while',
}

local function simple_table(t)
    if #t > 0 then
        local n = 0
        for _,v in next, t do
            n = n + 1
        end
        if n == #t then
            local tt = { }
            for i=1,#t do
                local v = t[i]
                local tv = type(v)
                if tv == "number" then
                    if hexify then
                        tt[#tt+1] = format("0x%04X",v)
                    else
                        tt[#tt+1] = tostring(v) -- tostring not needed
                    end
                elseif tv == "boolean" then
                    tt[#tt+1] = tostring(v)
                elseif tv == "string" then
                    tt[#tt+1] = format("%q",v)
                else
                    tt = nil
                    break
                end
            end
            return tt
        end
    end
    return nil
end

-- Because this is a core function of mkiv I moved some function calls
-- inline.
--
-- twice as fast in a test:
--
-- local propername = lpeg.P(lpeg.R("AZ","az","__") * lpeg.R("09","AZ","az", "__")^0 * lpeg.P(-1) )

-- problem: there no good number_to_string converter with the best resolution

local function do_serialize(root,name,depth,level,indexed)
    if level > 0 then
        depth = depth .. " "
        if indexed then
            handle(format("%s{",depth))
        elseif name then
        --~ handle(format("%s%s={",depth,key(name)))
            if type(name) == "number" then -- or find(k,"^%d+$") then
                if hexify then
                    handle(format("%s[0x%04X]={",depth,name))
                else
                    handle(format("%s[%s]={",depth,name))
                end
            elseif noquotes and not reserved[name] and find(name,"^%a[%w%_]*$") then
                handle(format("%s%s={",depth,name))
            else
                handle(format("%s[%q]={",depth,name))
            end
        else
            handle(format("%s{",depth))
        end
    end
    -- we could check for k (index) being number (cardinal)
    if root and next(root) then
        local first, last = nil, 0 -- #root cannot be trusted here (will be ok in 5.2 when ipairs is gone)
        if compact then
            -- NOT: for k=1,#root do (we need to quit at nil)
            for k,v in ipairs(root) do -- can we use next?
                if not first then first = k end
                last = last + 1
            end
        end
        local sk = sortedkeys(root)
        for i=1,#sk do
            local k = sk[i]
            local v = root[k]
            --~ if v == root then
                -- circular
            --~ else
            local t = type(v)
            if compact and first and type(k) == "number" and k >= first and k <= last then
                if t == "number" then
                    if hexify then
                        handle(format("%s 0x%04X,",depth,v))
                    else
                        handle(format("%s %s,",depth,v)) -- %.99g
                    end
                elseif t == "string" then
                    if reduce and tonumber(v) then
                        handle(format("%s %s,",depth,v))
                    else
                        handle(format("%s %q,",depth,v))
                    end
                elseif t == "table" then
                    if not next(v) then
                        handle(format("%s {},",depth))
                    elseif inline then -- and #t > 0
                        local st = simple_table(v)
                        if st then
                            handle(format("%s { %s },",depth,concat(st,", ")))
                        else
                            do_serialize(v,k,depth,level+1,true)
                        end
                    else
                        do_serialize(v,k,depth,level+1,true)
                    end
                elseif t == "boolean" then
                    handle(format("%s %s,",depth,tostring(v)))
                elseif t == "function" then
                    if functions then
                        handle(format('%s loadstring(%q),',depth,dump(v)))
                    else
                        handle(format('%s "function",',depth))
                    end
                else
                    handle(format("%s %q,",depth,tostring(v)))
                end
            elseif k == "__p__" then -- parent
                if false then
                    handle(format("%s __p__=nil,",depth))
                end
            elseif t == "number" then
            --~ if hexify then
            --~     handle(format("%s %s=0x%04X,",depth,key(k),v))
            --~ else
            --~     handle(format("%s %s=%s,",depth,key(k),v)) -- %.99g
            --~ end
                if type(k) == "number" then -- or find(k,"^%d+$") then
                    if hexify then
                        handle(format("%s [0x%04X]=0x%04X,",depth,k,v))
                    else
                        handle(format("%s [%s]=%s,",depth,k,v)) -- %.99g
                    end
                elseif noquotes and not reserved[k] and find(k,"^%a[%w%_]*$") then
                    if hexify then
                        handle(format("%s %s=0x%04X,",depth,k,v))
                    else
                        handle(format("%s %s=%s,",depth,k,v)) -- %.99g
                    end
                else
                    if hexify then
                        handle(format("%s [%q]=0x%04X,",depth,k,v))
                    else
                        handle(format("%s [%q]=%s,",depth,k,v)) -- %.99g
                    end
                end
            elseif t == "string" then
                if reduce and tonumber(v) then
                --~ handle(format("%s %s=%s,",depth,key(k),v))
                    if type(k) == "number" then -- or find(k,"^%d+$") then
                        if hexify then
                            handle(format("%s [0x%04X]=%s,",depth,k,v))
                        else
                            handle(format("%s [%s]=%s,",depth,k,v))
                        end
                    elseif noquotes and not reserved[k] and find(k,"^%a[%w%_]*$") then
                        handle(format("%s %s=%s,",depth,k,v))
                    else
                        handle(format("%s [%q]=%s,",depth,k,v))
                    end
                else
                --~ handle(format("%s %s=%q,",depth,key(k),v))
                    if type(k) == "number" then -- or find(k,"^%d+$") then
                        if hexify then
                            handle(format("%s [0x%04X]=%q,",depth,k,v))
                        else
                            handle(format("%s [%s]=%q,",depth,k,v))
                        end
                    elseif noquotes and not reserved[k] and find(k,"^%a[%w%_]*$") then
                        handle(format("%s %s=%q,",depth,k,v))
                    else
                        handle(format("%s [%q]=%q,",depth,k,v))
                    end
                end
            elseif t == "table" then
                if not next(v) then
                    --~ handle(format("%s %s={},",depth,key(k)))
                    if type(k) == "number" then -- or find(k,"^%d+$") then
                        if hexify then
                            handle(format("%s [0x%04X]={},",depth,k))
                        else
                            handle(format("%s [%s]={},",depth,k))
                        end
                    elseif noquotes and not reserved[k] and find(k,"^%a[%w%_]*$") then
                        handle(format("%s %s={},",depth,k))
                    else
                        handle(format("%s [%q]={},",depth,k))
                    end
                elseif inline then
                    local st = simple_table(v)
                    if st then
                    --~ handle(format("%s %s={ %s },",depth,key(k),concat(st,", ")))
                        if type(k) == "number" then -- or find(k,"^%d+$") then
                            if hexify then
                                handle(format("%s [0x%04X]={ %s },",depth,k,concat(st,", ")))
                            else
                                handle(format("%s [%s]={ %s },",depth,k,concat(st,", ")))
                            end
                        elseif noquotes and not reserved[k] and find(k,"^%a[%w%_]*$") then
                            handle(format("%s %s={ %s },",depth,k,concat(st,", ")))
                        else
                            handle(format("%s [%q]={ %s },",depth,k,concat(st,", ")))
                        end
                    else
                        do_serialize(v,k,depth,level+1)
                    end
                else
                    do_serialize(v,k,depth,level+1)
                end
            elseif t == "boolean" then
            --~ handle(format("%s %s=%s,",depth,key(k),tostring(v)))
                if type(k) == "number" then -- or find(k,"^%d+$") then
                    if hexify then
                        handle(format("%s [0x%04X]=%s,",depth,k,tostring(v)))
                    else
                        handle(format("%s [%s]=%s,",depth,k,tostring(v)))
                    end
                elseif noquotes and not reserved[k] and find(k,"^%a[%w%_]*$") then
                    handle(format("%s %s=%s,",depth,k,tostring(v)))
                else
                    handle(format("%s [%q]=%s,",depth,k,tostring(v)))
                end
            elseif t == "function" then
                if functions then
                    --~ handle(format('%s %s=loadstring(%q),',depth,key(k),dump(v)))
                    if type(k) == "number" then -- or find(k,"^%d+$") then
                        if hexify then
                            handle(format("%s [0x%04X]=loadstring(%q),",depth,k,dump(v)))
                        else
                            handle(format("%s [%s]=loadstring(%q),",depth,k,dump(v)))
                        end
                    elseif noquotes and not reserved[k] and find(k,"^%a[%w%_]*$") then
                        handle(format("%s %s=loadstring(%q),",depth,k,dump(v)))
                    else
                        handle(format("%s [%q]=loadstring(%q),",depth,k,dump(v)))
                    end
                end
            else
                --~ handle(format("%s %s=%q,",depth,key(k),tostring(v)))
                if type(k) == "number" then -- or find(k,"^%d+$") then
                    if hexify then
                        handle(format("%s [0x%04X]=%q,",depth,k,tostring(v)))
                    else
                        handle(format("%s [%s]=%q,",depth,k,tostring(v)))
                    end
                elseif noquotes and not reserved[k] and find(k,"^%a[%w%_]*$") then
                    handle(format("%s %s=%q,",depth,k,tostring(v)))
                else
                    handle(format("%s [%q]=%q,",depth,k,tostring(v)))
                end
            end
            --~ end
        end
    end
   if level > 0 then
        handle(format("%s},",depth))
    end
end

-- replacing handle by a direct t[#t+1] = ... (plus test) is not much
-- faster (0.03 on 1.00 for zapfino.tma)

local function serialize(root,name,_handle,_reduce,_noquotes,_hexify)
    noquotes = _noquotes
    hexify = _hexify
    handle = _handle or print
    reduce = _reduce or false
    compact = table.serialize_compact
    inline  = compact and table.serialize_inline
    functions = table.serialize_functions
    local tname = type(name)
    if tname == "string" then
        if name == "return" then
            handle("return {")
        else
            handle(name .. "={")
        end
    elseif tname == "number" then
        if hexify then
            handle(format("[0x%04X]={",name))
        else
            handle("[" .. name .. "]={")
        end
    elseif tname == "boolean" then
        if name then
            handle("return {")
        else
            handle("{")
        end
    else
        handle("t={")
    end
    if root and next(root) then
        do_serialize(root,name,"",0,indexed)
    end
    handle("}")
end

--~ name:
--~
--~ true     : return     { }
--~ false    :            { }
--~ nil      : t        = { }
--~ string   : string   = { }
--~ 'return' : return     { }
--~ number   : [number] = { }

function table.serialize(root,name,reduce,noquotes,hexify)
    local t = { }
    local function flush(s)
        t[#t+1] = s
    end
    serialize(root,name,flush,reduce,noquotes,hexify)
    return concat(t,"\n")
end

function table.tohandle(handle,root,name,reduce,noquotes,hexify)
    serialize(root,name,handle,reduce,noquotes,hexify)
end

-- sometimes tables are real use (zapfino extra pro is some 85M) in which
-- case a stepwise serialization is nice; actually, we could consider:
--
-- for line in table.serializer(root,name,reduce,noquotes) do
--    ...(line)
-- end
--
-- so this is on the todo list

table.tofile_maxtab = 2*1024

function table.tofile(filename,root,name,reduce,noquotes,hexify)
    local f = io.open(filename,'w')
    if f then
        local maxtab = table.tofile_maxtab
        if maxtab > 1 then
            local t = { }
            local function flush(s)
                t[#t+1] = s
                if #t > maxtab then
                    f:write(concat(t,"\n"),"\n") -- hm, write(sometable) should be nice
                    t = { }
                end
            end
            serialize(root,name,flush,reduce,noquotes,hexify)
            f:write(concat(t,"\n"),"\n")
        else
            local function flush(s)
                f:write(s,"\n")
            end
            serialize(root,name,flush,reduce,noquotes,hexify)
        end
        f:close()
    end
end

local function flatten(t,f,complete) -- is this used? meybe a variant with next, ...
    for i=1,#t do
        local v = t[i]
        if type(v) == "table" then
            if complete or type(v[1]) == "table" then
                flatten(v,f,complete)
            else
                f[#f+1] = v
            end
        else
            f[#f+1] = v
        end
    end
end

function table.flatten(t)
    local f = { }
    flatten(t,f,true)
    return f
end

function table.unnest(t) -- bad name
    local f = { }
    flatten(t,f,false)
    return f
end

table.flatten_one_level = table.unnest

-- a better one:

local function flattened(t,f)
    if not f then
        f = { }
    end
    for k, v in next, t do
        if type(v) == "table" then
            flattened(v,f)
        else
            f[k] = v
        end
    end
    return f
end

table.flattened = flattened

-- the next three may disappear

function table.remove_value(t,value) -- todo: n
    if value then
        for i=1,#t do
            if t[i] == value then
                remove(t,i)
                -- remove all, so no: return
            end
        end
    end
end

function table.insert_before_value(t,value,str)
    if str then
        if value then
            for i=1,#t do
                if t[i] == value then
                    insert(t,i,str)
                    return
                end
            end
        end
        insert(t,1,str)
    elseif value then
        insert(t,1,value)
    end
end

function table.insert_after_value(t,value,str)
    if str then
        if value then
            for i=1,#t do
                if t[i] == value then
                    insert(t,i+1,str)
                    return
                end
            end
        end
        t[#t+1] = str
    elseif value then
        t[#t+1] = value
    end
end

local function are_equal(a,b,n,m) -- indexed
    if a and b and #a == #b then
        n = n or 1
        m = m or #a
        for i=n,m do
            local ai, bi = a[i], b[i]
            if ai==bi then
                -- same
            elseif type(ai)=="table" and type(bi)=="table" then
                if not are_equal(ai,bi) then
                    return false
                end
            else
                return false
            end
        end
        return true
    else
        return false
    end
end

local function identical(a,b) -- assumes same structure
    for ka, va in next, a do
        local vb = b[k]
        if va == vb then
            -- same
        elseif type(va) == "table" and  type(vb) == "table" then
            if not identical(va,vb) then
                return false
            end
        else
            return false
        end
    end
    return true
end

table.are_equal = are_equal
table.identical = identical

-- maybe also make a combined one

function table.compact(t)
    if t then
        for k,v in next, t do
            if not next(v) then
                t[k] = nil
            end
        end
    end
end

function table.contains(t, v)
    if t then
        for i=1, #t do
            if t[i] == v then
                return i
            end
        end
    end
    return false
end

function table.count(t)
    local n, e = 0, next(t)
    while e do
        n, e = n + 1, next(t,e)
    end
    return n
end

function table.swapped(t)
    local s = { }
    for k, v in next, t do
        s[v] = k
    end
    return s
end

--~ function table.are_equal(a,b)
--~     return table.serialize(a) == table.serialize(b)
--~ end

function table.clone(t,p) -- t is optional or nil or table
    if not p then
        t, p = { }, t or { }
    elseif not t then
        t = { }
    end
    setmetatable(t, { __index = function(_,key) return p[key] end }) -- why not __index = p ?
    return t
end

function table.hexed(t,seperator)
    local tt = { }
    for i=1,#t do tt[i] = format("0x%04X",t[i]) end
    return concat(tt,seperator or " ")
end

function table.reverse_hash(h)
    local r = { }
    for k,v in next, h do
        r[v] = lower(gsub(k," ",""))
    end
    return r
end

function table.reverse(t)
    local tt = { }
    if #t > 0 then
        for i=#t,1,-1 do
            tt[#tt+1] = t[i]
        end
    end
    return tt
end

function table.insert_before_value(t,value,extra)
    for i=1,#t do
        if t[i] == extra then
            remove(t,i)
        end
    end
    for i=1,#t do
        if t[i] == value then
            insert(t,i,extra)
            return
        end
    end
    insert(t,1,extra)
end

function table.insert_after_value(t,value,extra)
    for i=1,#t do
        if t[i] == extra then
            remove(t,i)
        end
    end
    for i=1,#t do
        if t[i] == value then
            insert(t,i+1,extra)
            return
        end
    end
    insert(t,#t+1,extra)
end

