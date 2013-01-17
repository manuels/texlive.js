if not modules then modules = { } end modules ['luat-dum'] = {
    version   = 1.100,
    comment   = "companion to luatex-*.tex",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local dummyfunction = function() end

statistics = {
    register      = dummyfunction,
    starttiming   = dummyfunction,
    stoptiming    = dummyfunction,
}
directives = {
    register      = dummyfunction,
    enable        = dummyfunction,
    disable       = dummyfunction,
}
trackers = {
    register      = dummyfunction,
    enable        = dummyfunction,
    disable       = dummyfunction,
}
experiments = {
    register      = dummyfunction,
    enable        = dummyfunction,
    disable       = dummyfunction,
}
storage = {
    register      = dummyfunction,
    shared        = { },
}
logs = {
    report        = dummyfunction,
    simple        = dummyfunction,
}
tasks = {
    new           = dummyfunction,
    actions       = dummyfunction,
    appendaction  = dummyfunction,
    prependaction = dummyfunction,
}
callbacks = {
    register = function(n,f) return callback.register(n,f) end,
}

-- we need to cheat a bit here

texconfig.kpse_init = true

resolvers = resolvers or { } -- no fancy file helpers used

local remapper = {
    otf   = "opentype fonts",
    ttf   = "truetype fonts",
    ttc   = "truetype fonts",
    dfont = "truetype fonts",
    cid   = "cid maps",
    fea   = "font feature files",
}

function resolvers.find_file(name,kind)
    name = string.gsub(name,"\\","\/")
    kind = string.lower(kind)
    return kpse.find_file(name,(kind and kind ~= "" and (remapper[kind] or kind)) or file.extname(name,"tex"))
end

function resolvers.findbinfile(name,kind)
    if not kind or kind == "" then
        kind = file.extname(name) -- string.match(name,"%.([^%.]-)$")
    end
    return resolvers.find_file(name,(kind and remapper[kind]) or kind)
end

-- Caches ... I will make a real stupid version some day when I'm in the
-- mood. After all, the generic code does not need the more advanced
-- ConTeXt features. Cached data is not shared between ConTeXt and other
-- usage as I don't want any dependency at all. Also, ConTeXt might have
-- different needs and tricks added.

--~ containers.usecache = true

caches = { }

local writable, readables = nil, { }

if not caches.namespace or caches.namespace == "" or caches.namespace == "context" then
    caches.namespace = 'generic'
end

do

    local cachepaths

    if kpse.expand_var('$TEXMFCACHE') ~= '$TEXMFCACHE' then
        cachepaths = kpse.expand_var('$TEXMFCACHE')
    elseif kpse.expand_var('$TEXMFVAR') ~= '$TEXMFVAR' then
        cachepaths = kpse.expand_var('$TEXMFVAR')
    end

    if not cachepaths then
        cachepaths = "."
    end

    cachepaths = string.split(cachepaths,os.type == "windows" and ";" or ":")

    for i=1,#cachepaths do
        local done
        writable = file.join(cachepaths[i], "luatex-cache")
        writable = file.join(writable,caches.namespace)
        writable, done = dir.mkdirs(writable)
        if done then
            break
        end
    end

    for i=1,#cachepaths do
        if file.isreadable(cachepaths[i]) then
            readables[#readables+1] = file.join(cachepaths[i],"luatex-cache",caches.namespace)
        end
    end

    if not writable then
        texio.write_nl("quiting: fix your writable cache path\n")
        os.exit()
    elseif #readables == 0 then
        texio.write_nl("quiting: fix your readable cache path\n")
        os.exit()
    elseif #readables == 1 and readables[1] == writable then
        texio.write(string.format("(using cache: %s)",writable))
    else
        texio.write(string.format("(using write cache: %s)",writable))
        texio.write(string.format("(using read cache: %s)",table.concat(readables, " ")))
    end

end

function caches.getwritablepath(category,subcategory)
    local path = file.join(writable,category)
    lfs.mkdir(path)
    path = file.join(path,subcategory)
    lfs.mkdir(path)
    return path
end

function caches.getreadablepaths(category,subcategory)
    local t = { }
    for i=1,#readables do
        t[i] = file.join(readables[i],category,subcategory)
    end
    return t
end

local function makefullname(path,name)
    if path and path ~= "" then
        name = "temp-" .. name -- clash prevention
        return file.addsuffix(file.join(path,name),"lua")
    end
end

function caches.iswritable(path,name)
    local fullname = makefullname(path,name)
    return fullname and file.iswritable(fullname)
end

function caches.loaddata(paths,name)
    for i=1,#paths do
        local fullname = makefullname(paths[i],name)
        if fullname then
            texio.write(string.format("(load: %s)",fullname))
            local data = loadfile(fullname)
            return data and data()
        end
    end
end

function caches.savedata(path,name,data)
    local fullname = makefullname(path,name)
    if fullname then
        texio.write(string.format("(save: %s)",fullname))
        table.tofile(fullname,data,'return',false,true,false)
    end
end
