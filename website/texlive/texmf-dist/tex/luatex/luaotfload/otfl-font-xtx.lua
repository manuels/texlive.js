if not modules then modules = { } end modules ['font-xtx'] = {
    version   = 1.001,
    comment   = "companion to font-ini.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local texsprint, count = tex.sprint, tex.count
local format, concat, gmatch, match, find, lower = string.format, table.concat, string.gmatch, string.match, string.find, string.lower
local tostring, next = tostring, next
local lpegmatch = lpeg.match

local trace_defining = false  trackers.register("fonts.defining", function(v) trace_defining = v end)

--[[ldx--
<p>Choosing a font by name and specififying its size is only part of the
game. In order to prevent complex commands, <l n='xetex'/> introduced
a method to pass feature information as part of the font name. At the
risk of introducing nasty parsing and compatinility problems, this
syntax was expanded over time.</p>

<p>For the sake of users who have defined fonts using that syntax, we
will support it, but we will provide additional methods as well.
Normally users will not use this direct way, but use a more abstract
interface.</p>

<p>The next one is the official one. However, in the plain
variant we need to support the crappy [] specification as
well and that does not work too well with the general design
of the specifier.</p>
--ldx]]--

--~ function fonts.define.specify.colonized(specification) -- xetex mode
--~     local list = { }
--~     if specification.detail and specification.detail ~= "" then
--~         for v in gmatch(specification.detail,"%s*([^;]+)%s*") do
--~             local a, b = match(v,"^(%S*)%s*=%s*(%S*)$")
--~             if a and b then
--~                 list[a] = b:is_boolean()
--~                 if type(list[a]) == "nil" then
--~                     list[a] = b
--~                 end
--~             else
--~                 local a, b = match(v,"^([%+%-]?)%s*(%S+)$")
--~                 if a and b then
--~                     list[b] = a ~= "-"
--~                 end
--~             end
--~         end
--~     end
--~     specification.features.normal = list
--~     return specification
--~ end

--~ check("oeps/BI:+a;-b;c=d")
--~ check("[oeps]/BI:+a;-b;c=d")
--~ check("file:oeps/BI:+a;-b;c=d")
--~ check("name:oeps/BI:+a;-b;c=d")

local list = { }

fonts.define.specify.colonized_default_lookup = "file"

local function isstyle(s)
    local style  = string.lower(s):split("/")
    for _,v in ipairs(style) do
        if v == "b" then
            list.style = "bold"
        elseif v == "i" then
            list.style = "italic"
        elseif v == "bi" or v == "ib" then
            list.style = "bolditalic"
        elseif v:find("^s=") then
            list.optsize = v:split("=")[2]
        elseif v == "aat" or v == "icu" or v == "gr" then
            logs.report("load font", "unsupported font option: %s", v)
        elseif not v:is_empty() then
            list.style = v:gsub("[^%a%d]", "")
        end
    end
end

fonts      = fonts      or { }
fonts.otf  = fonts.otf  or { }

local otf  = fonts.otf

otf.tables = otf.tables or { }

otf.tables.defaults = {
    dflt = {
        "ccmp", "locl", "rlig", "liga", "clig",
        "kern", "mark", "mkmk", "itlc",
    },
    arab = {
        "ccmp", "locl", "isol", "fina", "fin2",
        "fin3", "medi", "med2", "init", "rlig",
        "calt", "liga", "cswh", "mset", "curs",
        "kern", "mark", "mkmk",
    },
    deva = {
        "ccmp", "locl", "init", "nukt", "akhn",
        "rphf", "blwf", "half", "pstf", "vatu",
        "pres", "blws", "abvs", "psts", "haln",
        "calt", "blwm", "abvm", "dist", "kern",
        "mark", "mkmk",
    },
    khmr = {
        "ccmp", "locl", "pref", "blwf", "abvf",
        "pstf", "pres", "blws", "abvs", "psts",
        "clig", "calt", "blwm", "abvm", "dist",
        "kern", "mark", "mkmk",
    },
    thai = {
        "ccmp", "locl", "liga", "kern", "mark",
        "mkmk",
    },
    hang = {
        "ccmp", "ljmo", "vjmo", "tjmo",
    },
}

otf.tables.defaults.beng = otf.tables.defaults.deva
otf.tables.defaults.guru = otf.tables.defaults.deva
otf.tables.defaults.gujr = otf.tables.defaults.deva
otf.tables.defaults.orya = otf.tables.defaults.deva
otf.tables.defaults.taml = otf.tables.defaults.deva
otf.tables.defaults.telu = otf.tables.defaults.deva
otf.tables.defaults.knda = otf.tables.defaults.deva
otf.tables.defaults.mlym = otf.tables.defaults.deva
otf.tables.defaults.sinh = otf.tables.defaults.deva

otf.tables.defaults.syrc = otf.tables.defaults.arab
otf.tables.defaults.mong = otf.tables.defaults.arab
otf.tables.defaults.nko  = otf.tables.defaults.arab

otf.tables.defaults.tibt = otf.tables.defaults.khmr

otf.tables.defaults.lao  = otf.tables.defaults.thai

local function parse_script(script)
    if otf.tables.scripts[script] then
        local dflt
        if otf.tables.defaults[script] then
            logs.report("load font", "auto-selecting default features for script: %s", script)
            dflt = otf.tables.defaults[script]
        else
            logs.report("load font", "auto-selecting default features for script: dflt (was %s)", script)
            dflt = otf.tables.defaults["dflt"]
        end
        for _,v in next, dflt do
            list[v] = "yes"
        end
    else
        logs.report("load font", "unknown script: %s", script)
    end
end

local function issome ()    list.lookup = fonts.define.specify.colonized_default_lookup end
local function isfile ()    list.lookup = 'file' end
local function isname ()    list.lookup = 'name' end
local function thename(s)   list.name   = s end
local function issub  (v)   list.sub    = v end
local function iskey  (k,v)
    if k == "script" then
        parse_script(v)
    end
    list[k] = v
end

local function istrue (s)   list[s]     = true end
local function isfalse(s)   list[s]     = false end

local spaces     = lpeg.P(" ")^0
local namespec   = (1-lpeg.S("/:("))^0 -- was: (1-lpeg.S("/: ("))^0
local filespec   = (lpeg.R("az", "AZ") * lpeg.P(":"))^-1 * (1-lpeg.S(":("))^1
local crapspec   = spaces * lpeg.P("/") * (((1-lpeg.P(":"))^0)/isstyle) * spaces
local filename   = (lpeg.P("file:")/isfile * (filespec/thename)) + (lpeg.P("[") * lpeg.P(true)/isfile * (((1-lpeg.P("]"))^0)/thename) * lpeg.P("]"))
local fontname   = (lpeg.P("name:")/isname * (namespec/thename)) + lpeg.P(true)/issome * (namespec/thename)
local sometext   = (lpeg.R("az","AZ","09") + lpeg.S("+-."))^1
local truevalue  = lpeg.P("+") * spaces * (sometext/istrue)
local falsevalue = lpeg.P("-") * spaces * (sometext/isfalse)
local keyvalue   = lpeg.P("+") + (lpeg.C(sometext) * spaces * lpeg.P("=") * spaces * lpeg.C(sometext))/iskey
local somevalue  = sometext/istrue
local subvalue   = lpeg.P("(") * (lpeg.C(lpeg.P(1-lpeg.S("()"))^1)/issub) * lpeg.P(")") -- for Kim
local option     = spaces * (keyvalue + falsevalue + truevalue + somevalue) * spaces
local options    = lpeg.P(":") * spaces * (lpeg.P(";")^0  * option)^0
local pattern    = (filename + fontname) * subvalue^0 * crapspec^0 * options^0

local normalize_meanings = fonts.otf.meanings.normalize

function fonts.define.specify.colonized(specification) -- xetex mode
    list = { }
    lpegmatch(pattern,specification.specification)
    if list.style then
        specification.style = list.style
        list.style = nil
    end
    if list.optsize then
        specification.optsize = list.optsize
        list.optsize = nil
    end
    if list.name then
        if resolvers.find_file(list.name, "tfm") then
            list.lookup = "file"
            list.name   = file.addsuffix(list.name, "tfm")
        elseif resolvers.find_file(list.name, "ofm") then
            list.lookup = "file"
            list.name   = file.addsuffix(list.name, "ofm")
        end

        specification.name = list.name
        list.name = nil
    end
    if list.lookup then
        specification.lookup = list.lookup
        list.lookup = nil
    end
    if list.sub then
        specification.sub = list.sub
        list.sub = nil
    end
--  specification.features.normal = list
    specification.features.normal = normalize_meanings(list)
    return specification
end

fonts.define.register_split(":", fonts.define.specify.colonized)
