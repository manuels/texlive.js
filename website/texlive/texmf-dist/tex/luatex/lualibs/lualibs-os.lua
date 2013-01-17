if not modules then modules = { } end modules ['l-os'] = {
    version   = 1.001,
    comment   = "companion to luat-lib.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

-- maybe build io.flush in os.execute

local find, format, gsub = string.find, string.format, string.gsub
local random, ceil = math.random, math.ceil

local execute, spawn, exec, ioflush = os.execute, os.spawn or os.execute, os.exec or os.execute, io.flush

function os.execute(...) ioflush() return execute(...) end
function os.spawn  (...) ioflush() return spawn  (...) end
function os.exec   (...) ioflush() return exec   (...) end

function os.resultof(command)
    ioflush() -- else messed up logging
    local handle = io.popen(command,"r")
    if not handle then
    --  print("unknown command '".. command .. "' in os.resultof")
        return ""
    else
        return handle:read("*all") or ""
    end
end

--~ os.type     : windows | unix (new, we already guessed os.platform)
--~ os.name     : windows | msdos | linux | macosx | solaris | .. | generic (new)
--~ os.platform : extended os.name with architecture

if not io.fileseparator then
    if find(os.getenv("PATH"),";") then
        io.fileseparator, io.pathseparator, os.type = "\\", ";", os.type or "mswin"
    else
        io.fileseparator, io.pathseparator, os.type = "/" , ":", os.type or "unix"
    end
end

os.type = os.type or (io.pathseparator == ";"       and "windows") or "unix"
os.name = os.name or (os.type          == "windows" and "mswin"  ) or "linux"

if os.type == "windows" then
    os.libsuffix, os.binsuffix = 'dll', 'exe'
else
    os.libsuffix, os.binsuffix = 'so', ''
end

function os.launch(str)
    if os.type == "windows" then
        os.execute("start " .. str) -- os.spawn ?
    else
        os.execute(str .. " &")     -- os.spawn ?
    end
end

if not os.times then
    -- utime  = user time
    -- stime  = system time
    -- cutime = children user time
    -- cstime = children system time
    function os.times()
        return {
            utime  = os.gettimeofday(), -- user
            stime  = 0,                 -- system
            cutime = 0,                 -- children user
            cstime = 0,                 -- children system
        }
    end
end

os.gettimeofday = os.gettimeofday or os.clock

local startuptime = os.gettimeofday()

function os.runtime()
    return os.gettimeofday() - startuptime
end

--~ print(os.gettimeofday()-os.time())
--~ os.sleep(1.234)
--~ print (">>",os.runtime())
--~ print(os.date("%H:%M:%S",os.gettimeofday()))
--~ print(os.date("%H:%M:%S",os.time()))

-- no need for function anymore as we have more clever code and helpers now
-- this metatable trickery might as well disappear

os.resolvers = os.resolvers or { }

local resolvers = os.resolvers

local osmt = getmetatable(os) or { __index = function(t,k) t[k] = "unset" return "unset" end } -- maybe nil
local osix = osmt.__index

osmt.__index = function(t,k)
    return (resolvers[k] or osix)(t,k)
end

setmetatable(os,osmt)

if not os.setenv then

    -- we still store them but they won't be seen in
    -- child processes although we might pass them some day
    -- using command concatination

    local env, getenv = { }, os.getenv

    function os.setenv(k,v)
        env[k] = v
    end

    function os.getenv(k)
        return env[k] or getenv(k)
    end

end

-- we can use HOSTTYPE on some platforms

local name, platform = os.name or "linux", os.getenv("MTX_PLATFORM") or ""

local function guess()
    local architecture = os.resultof("uname -m") or ""
    if architecture ~= "" then
        return architecture
    end
    architecture = os.getenv("HOSTTYPE") or ""
    if architecture ~= "" then
        return architecture
    end
    return os.resultof("echo $HOSTTYPE") or ""
end

if platform ~= "" then

    os.platform = platform

elseif os.type == "windows" then

    -- we could set the variable directly, no function needed here

    function os.resolvers.platform(t,k)
        local platform, architecture = "", os.getenv("PROCESSOR_ARCHITECTURE") or ""
        if find(architecture,"AMD64") then
            platform = "mswin-64"
        else
            platform = "mswin"
        end
        os.setenv("MTX_PLATFORM",platform)
        os.platform = platform
        return platform
    end

elseif name == "linux" then

    function os.resolvers.platform(t,k)
        -- we sometims have HOSTTYPE set so let's check that first
        local platform, architecture = "", os.getenv("HOSTTYPE") or os.resultof("uname -m") or ""
        if find(architecture,"x86_64") then
            platform = "linux-64"
        elseif find(architecture,"ppc") then
            platform = "linux-ppc"
        else
            platform = "linux"
        end
        os.setenv("MTX_PLATFORM",platform)
        os.platform = platform
        return platform
    end

elseif name == "macosx" then

    --[[
        Identifying the architecture of OSX is quite a mess and this
        is the best we can come up with. For some reason $HOSTTYPE is
        a kind of pseudo environment variable, not known to the current
        environment. And yes, uname cannot be trusted either, so there
        is a change that you end up with a 32 bit run on a 64 bit system.
        Also, some proper 64 bit intel macs are too cheap (low-end) and
        therefore not permitted to run the 64 bit kernel.
      ]]--

    function os.resolvers.platform(t,k)
     -- local platform, architecture = "", os.getenv("HOSTTYPE") or ""
     -- if architecture == "" then
     --     architecture = os.resultof("echo $HOSTTYPE") or ""
     -- end
        local platform, architecture = "", os.resultof("echo $HOSTTYPE") or ""
        if architecture == "" then
         -- print("\nI have no clue what kind of OSX you're running so let's assume an 32 bit intel.\n")
            platform = "osx-intel"
        elseif find(architecture,"i386") then
            platform = "osx-intel"
        elseif find(architecture,"x86_64") then
            platform = "osx-64"
        else
            platform = "osx-ppc"
        end
        os.setenv("MTX_PLATFORM",platform)
        os.platform = platform
        return platform
    end

elseif name == "sunos" then

    function os.resolvers.platform(t,k)
        local platform, architecture = "", os.resultof("uname -m") or ""
        if find(architecture,"sparc") then
            platform = "solaris-sparc"
        else -- if architecture == 'i86pc'
            platform = "solaris-intel"
        end
        os.setenv("MTX_PLATFORM",platform)
        os.platform = platform
        return platform
    end

elseif name == "freebsd" then

    function os.resolvers.platform(t,k)
        local platform, architecture = "", os.resultof("uname -m") or ""
        if find(architecture,"amd64") then
            platform = "freebsd-amd64"
        else
            platform = "freebsd"
        end
        os.setenv("MTX_PLATFORM",platform)
        os.platform = platform
        return platform
    end

elseif name == "kfreebsd" then

    function os.resolvers.platform(t,k)
        -- we sometims have HOSTTYPE set so let's check that first
        local platform, architecture = "", os.getenv("HOSTTYPE") or os.resultof("uname -m") or ""
        if find(architecture,"x86_64") then
            platform = "kfreebsd-64"
        else
            platform = "kfreebsd-i386"
        end
        os.setenv("MTX_PLATFORM",platform)
        os.platform = platform
        return platform
    end

else

    -- platform = "linux"
    -- os.setenv("MTX_PLATFORM",platform)
    -- os.platform = platform

    function os.resolvers.platform(t,k)
        local platform = "linux"
        os.setenv("MTX_PLATFORM",platform)
        os.platform = platform
        return platform
    end

end

-- beware, we set the randomseed

-- from wikipedia: Version 4 UUIDs use a scheme relying only on random numbers. This algorithm sets the
-- version number as well as two reserved bits. All other bits are set using a random or pseudorandom
-- data source. Version 4 UUIDs have the form xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx with hexadecimal
-- digits x and hexadecimal digits 8, 9, A, or B for y. e.g. f47ac10b-58cc-4372-a567-0e02b2c3d479.
--
-- as we don't call this function too often there is not so much risk on repetition

local t = { 8, 9, "a", "b" }

function os.uuid()
    return format("%04x%04x-4%03x-%s%03x-%04x-%04x%04x%04x",
        random(0xFFFF),random(0xFFFF),
        random(0x0FFF),
        t[ceil(random(4))] or 8,random(0x0FFF),
        random(0xFFFF),
        random(0xFFFF),random(0xFFFF),random(0xFFFF)
    )
end

local d

function os.timezone(delta)
    d = d or tonumber(tonumber(os.date("%H")-os.date("!%H")))
    if delta then
        if d > 0 then
            return format("+%02i:00",d)
        else
            return format("-%02i:00",-d)
        end
    else
        return 1
    end
end
