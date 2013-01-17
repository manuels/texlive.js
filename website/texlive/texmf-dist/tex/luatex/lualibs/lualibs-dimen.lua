if not modules then modules = { } end modules ['l-dimen'] = {
    version   = 1.001,
    comment   = "support for dimensions",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

--[[ldx--
<p>Internally <l n='luatex'/> work with scaled point, which are
represented by integers. However, in practice, at east at the
<l n='tex'/> end we work with more generic units like points (pt). Going
from scaled points (numbers) to one of those units can be
done by using the conversion factors collected in the following
table.</p>
--ldx]]--

local format, match, gsub, type, setmetatable = string.format, string.match, string.gsub, type, setmetatable
local P, S, R, Cc, lpegmatch = lpeg.P, lpeg.S, lpeg.R, lpeg.Cc, lpeg.match

number = number or { }

number.tonumberf = function(n) return match(format("%.20f",n),"(.-0?)0*$") end -- one zero too much but alas
number.tonumberg = function(n) return       format("%.20g",n)              end

local dimenfactors = {
    ["pt"] =             1/65536,
    ["in"] = (  100/ 7227)/65536,
    ["cm"] = (  254/ 7227)/65536,
    ["mm"] = ( 2540/ 7227)/65536,
    ["sp"] =                   1, -- 65536 sp in 1pt
    ["bp"] = ( 7200/ 7227)/65536,
    ["pc"] = (    1/   12)/65536,
    ["dd"] = ( 1157/ 1238)/65536,
    ["cc"] = ( 1157/14856)/65536,
    ["nd"] = (20320/21681)/65536,
    ["nc"] = ( 5080/65043)/65536
}

--~ print(table.serialize(dimenfactors))
--~
--~  %.99g:
--~
--~  t={
--~   ["bp"]=1.5201782378580324e-005,
--~   ["cc"]=1.1883696112892098e-006,
--~   ["cm"]=5.3628510057769479e-007,
--~   ["dd"]=1.4260435335470516e-005,
--~   ["em"]=0.000152587890625,
--~   ["ex"]=6.103515625e-005,
--~   ["in"]=2.1113586636917117e-007,
--~   ["mm"]=5.3628510057769473e-008,
--~   ["nc"]=1.1917446679504327e-006,
--~   ["nd"]=1.4300936015405194e-005,
--~   ["pc"]=1.2715657552083333e-006,
--~   ["pt"]=1.52587890625e-005,
--~   ["sp"]=1,
--~  }
--~
--~  patched %s and tonumber
--~
--~  t={
--~   ["bp"]=0.00001520178238,
--~   ["cc"]=0.00000118836961,
--~   ["cm"]=0.0000005362851,
--~   ["dd"]=0.00001426043534,
--~   ["em"]=0.00015258789063,
--~   ["ex"]=0.00006103515625,
--~   ["in"]=0.00000021113587,
--~   ["mm"]=0.00000005362851,
--~   ["nc"]=0.00000119174467,
--~   ["nd"]=0.00001430093602,
--~   ["pc"]=0.00000127156576,
--~   ["pt"]=0.00001525878906,
--~   ["sp"]=1,
--~  }

--[[ldx--
<p>A conversion function that takes a number, unit (string) and optional
format (string) is implemented using this table.</p>
--ldx]]--

-- was:

local function todimen(n,unit,fmt)
    if type(n) == 'string' then
        return n
    else
        unit = unit or 'pt'
        return format(fmt or "%s%s",n*dimenfactors[unit],unit)
     -- if fmt then
     --     return format(fmt,n*dimenfactors[unit],unit)
     -- else
     --     return match(format("%.20f",n*dimenfactors[unit]),"(.-0?)0*$") .. unit
     -- end
    end
end

--[[ldx--
<p>We collect a bunch of converters in the <type>number</type> namespace.</p>
--ldx]]--

number.maxdimen     = 1073741823
number.todimen      = todimen
number.dimenfactors = dimenfactors

function number.topoints      (n) return todimen(n,"pt") end
function number.toinches      (n) return todimen(n,"in") end
function number.tocentimeters (n) return todimen(n,"cm") end
function number.tomillimeters (n) return todimen(n,"mm") end
function number.toscaledpoints(n) return todimen(n,"sp") end
function number.toscaledpoints(n) return      n .. "sp"  end
function number.tobasepoints  (n) return todimen(n,"bp") end
function number.topicas       (n) return todimen(n "pc") end
function number.todidots      (n) return todimen(n,"dd") end
function number.tociceros     (n) return todimen(n,"cc") end
function number.tonewdidots   (n) return todimen(n,"nd") end
function number.tonewciceros  (n) return todimen(n,"nc") end

--[[ldx--
<p>More interesting it to implement a (sort of) dimen datatype, one
that permits calculations too. First we define a function that
converts a string to scaledpoints. We use <l n='lpeg'/>. We capture
a number and optionally a unit. When no unit is given a constant
capture takes place.</p>
--ldx]]--

local amount = (S("+-")^0 * R("09")^0 * P(".")^0 * R("09")^0) + Cc("0")
local unit   = R("az")^1

local dimenpair = amount/tonumber * (unit^1/dimenfactors + Cc(1)) -- tonumber is new

lpeg.patterns.dimenpair = dimenpair

--[[ldx--
<p>We use a metatable to intercept errors. When no key is found in
the table with factors, the metatable will be consulted for an
alternative index function.</p>
--ldx]]--

local mt = { }  setmetatable(dimenfactors,mt)

mt.__index = function(t,s)
 -- error("wrong dimension: " .. (s or "?")) -- better a message
    return false
end

function string:todimen()
    if type(self) == "number" then
        return self
    else
        local value, unit = lpegmatch(dimenpair,self)
        return value/unit
    end
end

local amount = S("+-")^0 * R("09")^0 * S(".,")^0 * R("09")^0
local unit   = P("pt") + P("cm") + P("mm") + P("sp") + P("bp") + P("in")  +
               P("pc") + P("dd") + P("cc") + P("nd") + P("nc")

local validdimen = amount * unit

lpeg.patterns.validdimen = pattern

--[[ldx--
<p>This converter accepts calls like:</p>

<typing>
string.todimen("10")
string.todimen(".10")
string.todimen("10.0")
string.todimen("10.0pt")
string.todimen("10pt")
string.todimen("10.0pt")
</typing>

<p>And of course the often more efficient:</p>

<typing>
somestring:todimen("12.3cm")
</typing>

<p>With this in place, we can now implement a proper datatype for dimensions, one
that permits us to do this:</p>

<typing>
s = dimen "10pt" + dimen "20pt" + dimen "200pt"
        - dimen "100sp" / 10 + "20pt" + "0pt"
</typing>

<p>We create a local metatable for this new type:</p>
--ldx]]--

local dimensions = { }

--[[ldx--
<p>The main (and globally) visible representation of a dimen is defined next: it is
a one-element table. The unit that is returned from the match is normally a number
(one of the previously defined factors) but we also accept functions. Later we will
see why.</p>
--ldx]]--

function dimen(a)
    if a then
        local ta= type(a)
        if ta == "string" then
            local value, unit = lpegmatch(pattern,a)
            if type(unit) == "function" then
                k = value/unit()
            else
                k = value/unit
            end
            a = k
        elseif ta == "table" then
            a = a[1]
        end
        return setmetatable({ a }, dimensions)
    else
        return setmetatable({ 0 }, dimensions)
    end
end

--[[ldx--
<p>This function return a small hash with a metatable attached. It is
through this metatable that we can do the calculations. We could have
shared some of the code but for reasons of speed we don't.</p>
--ldx]]--

function dimensions.__add(a, b)
    local ta, tb = type(a), type(b)
    if ta == "string" then a = a:todimen() elseif ta == "table" then a = a[1] end
    if tb == "string" then b = b:todimen() elseif tb == "table" then b = b[1] end
    return setmetatable({ a + b }, dimensions)
end

function dimensions.__sub(a, b)
    local ta, tb = type(a), type(b)
    if ta == "string" then a = a:todimen() elseif ta == "table" then a = a[1] end
    if tb == "string" then b = b:todimen() elseif tb == "table" then b = b[1] end
    return setmetatable({ a - b }, dimensions)
end

function dimensions.__mul(a, b)
    local ta, tb = type(a), type(b)
    if ta == "string" then a = a:todimen() elseif ta == "table" then a = a[1] end
    if tb == "string" then b = b:todimen() elseif tb == "table" then b = b[1] end
    return setmetatable({ a * b }, dimensions)
end

function dimensions.__div(a, b)
    local ta, tb = type(a), type(b)
    if ta == "string" then a = a:todimen() elseif ta == "table" then a = a[1] end
    if tb == "string" then b = b:todimen() elseif tb == "table" then b = b[1] end
    return setmetatable({ a / b }, dimensions)
end

function dimensions.__unm(a)
    local ta = type(a)
    if ta == "string" then a = a:todimen() elseif ta == "table" then a = a[1] end
    return setmetatable({ - a }, dimensions)
end

--[[ldx--
<p>It makes no sense to implement the power and modulo function but
the next two do make sense because they permits is code like:</p>

<typing>
local a, b = dimen "10pt", dimen "11pt"
...
if a > b then
    ...
end
</typing>
--ldx]]--

-- makes no sense: dimensions.__pow and dimensions.__mod

function dimensions.__lt(a, b)
    return a[1] < b[1]
end

function dimensions.__eq(a, b)
    return a[1] == b[1]
end

--[[ldx--
<p>We also need to provide a function for conversion to string (so that
we can print dimensions). We print them as points, just like <l n='tex'/>.</p>
--ldx]]--

function dimensions.__tostring(a)
    return a[1]/65536 .. "pt" -- instead of todimen(a[1])
end

--[[ldx--
<p>Since it does not take much code, we also provide a way to access
a few accessors</p>

<typing>
print(dimen().pt)
print(dimen().sp)
</typing>
--ldx]]--

function dimensions.__index(tab,key)
    local d = dimenfactors[key]
    if not d then
        error("illegal property of dimen: " .. key)
        d = 1
    end
    return 1/d
end

--[[ldx--
<p>In the converter from string to dimension we support functions as
factors. This is because in <l n='tex'/> we have a few more units:
<type>ex</type> and <type>em</type>. These are not constant factors but
depend on the current font. They are not defined by default, but need
an explicit function call. This is because at the moment that this code
is loaded, the relevant tables that hold the functions needed may not
yet be available.</p>
--ldx]]--

function dimensions.texify()  -- todo: %
    local fti, fc = fonts and fonts.ids and fonts.ids, font and font.current
    if fti and fc then
        dimenfactors["ex"] = function() return fti[fc()].ex_height end
        dimenfactors["em"] = function() return fti[fc()].quad      end
    else
        dimenfactors["ex"] = 1/65536* 4 --  4pt
        dimenfactors["em"] = 1/65536*10 -- 10pt
    end
end

--[[ldx--
<p>In order to set the defaults we call this function now. At some point
the macro package needs to make sure the function is called again.</p>
--ldx]]--

dimensions.texify()

--[[ldx--
<p>The previous code is rather efficient (also thanks to <l n='lpeg'/>) but we
can speed it up by caching converted dimensions. On my machine (2008) the following
loop takes about 25.5 seconds.</p>

<typing>
for i=1,1000000 do
    local s = dimen "10pt" + dimen "20pt" + dimen "200pt"
        - dimen "100sp" / 10 + "20pt" + "0pt"
end
</typing>

<p>When we cache converted strings this becomes 16.3 seconds. In order not
to waste too much memory on it, we tag the values of the cache as being
week which mean that the garbage collector will collect them in a next
sweep. This means that in most cases the speed up is mostly affecting the
current couple of calculations and as such the speed penalty is small.</p>

<p>We redefine two previous defined functions that can benefit from
this:</p>
--ldx]]--

local known = { } setmetatable(known, { __mode = "v" })

function dimen(a)
    if a then
        local ta= type(a)
        if ta == "string" then
            local k = known[a]
            if k then
                a = k
            else
                local value, unit = lpegmatch(dimenpair,a)
                if type(unit) == "function" then
                    k = value/unit()
                else
                    k = value/unit
                end
                known[a] = k
                a = k
            end
        elseif ta == "table" then
            a = a[1]
        end
        return setmetatable({ a }, dimensions)
    else
        return setmetatable({ 0 }, dimensions)
    end
end

function string:todimen()
    if type(self) == "number" then
        return self
    else
        local k = known[self]
        if not k then
            local value, unit = lpegmatch(dimenpair,self)
            if value and unit then
                k = value/unit
            else
                k = 0
            end
            -- print(self,value,unit)
            known[self] = k
        end
        return k
    end
end

function number.toscaled(d)
    return format("0.5f",d/2^16)
end

--[[ldx--
<p>In a similar fashion we can define a glue datatype. In that case we
probably use a hash instead of a one-element table.</p>
--ldx]]--

--[[ldx--
<p>Goodie:s</p>
--ldx]]--

function number.percent(n) -- will be cleaned up once luatex 0.30 is out
    local hsize = tex.hsize
    if type(hsize) == "string" then
        hsize = hsize:todimen()
    end
    return (n/100) * hsize
end

number["%"] = number.percent
