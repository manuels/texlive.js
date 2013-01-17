if not modules then modules = { } end modules ['l-lpeg'] = {
    version   = 1.001,
    comment   = "companion to luat-lib.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local lpeg = require("lpeg")

lpeg.patterns  = lpeg.patterns or { } -- so that we can share
local patterns = lpeg.patterns

local P, R, S, Ct, C, Cs, Cc, V = lpeg.P, lpeg.R, lpeg.S, lpeg.Ct, lpeg.C, lpeg.Cs, lpeg.Cc, lpeg.V
local match = lpeg.match

local digit, sign      = R('09'), S('+-')
local cr, lf, crlf     = P("\r"), P("\n"), P("\r\n")
local utf8byte         = R("\128\191")

patterns.utf8byte      = utf8byte
patterns.utf8one       = R("\000\127")
patterns.utf8two       = R("\194\223") * utf8byte
patterns.utf8three     = R("\224\239") * utf8byte * utf8byte
patterns.utf8four      = R("\240\244") * utf8byte * utf8byte * utf8byte

patterns.digit         = digit
patterns.sign          = sign
patterns.cardinal      = sign^0 * digit^1
patterns.integer       = sign^0 * digit^1
patterns.float         = sign^0 * digit^0 * P('.') * digit^1
patterns.number        = patterns.float + patterns.integer
patterns.oct           = P("0") * R("07")^1
patterns.octal         = patterns.oct
patterns.HEX           = P("0x") * R("09","AF")^1
patterns.hex           = P("0x") * R("09","af")^1
patterns.hexadecimal   = P("0x") * R("09","AF","af")^1
patterns.lowercase     = R("az")
patterns.uppercase     = R("AZ")
patterns.letter        = patterns.lowercase + patterns.uppercase
patterns.space         = S(" ")
patterns.eol           = S("\n\r")
patterns.spacer        = S(" \t\f\v")  -- + string.char(0xc2, 0xa0) if we want utf (cf mail roberto)
patterns.newline       = crlf + cr + lf
patterns.nonspace      = 1 - patterns.space
patterns.nonspacer     = 1 - patterns.spacer
patterns.whitespace    = patterns.eol + patterns.spacer
patterns.nonwhitespace = 1 - patterns.whitespace
patterns.utf8          = patterns.utf8one + patterns.utf8two + patterns.utf8three + patterns.utf8four
patterns.utfbom        = P('\000\000\254\255') + P('\255\254\000\000') + P('\255\254') + P('\254\255') + P('\239\187\191')

function lpeg.anywhere(pattern) --slightly adapted from website
    return P { P(pattern) + 1 * V(1) } -- why so complex?
end

function lpeg.splitter(pattern, action)
    return (((1-P(pattern))^1)/action+1)^0
end

local spacing  = patterns.spacer^0 * patterns.newline -- sort of strip
local empty    = spacing * Cc("")
local nonempty = Cs((1-spacing)^1) * spacing^-1
local content  = (empty + nonempty)^1

local capture = Ct(content^0)

function string:splitlines()
    return match(capture,self)
end

patterns.textline = content

--~ local p = lpeg.splitat("->",false)  print(match(p,"oeps->what->more"))  -- oeps what more
--~ local p = lpeg.splitat("->",true)   print(match(p,"oeps->what->more"))  -- oeps what->more
--~ local p = lpeg.splitat("->",false)  print(match(p,"oeps"))              -- oeps
--~ local p = lpeg.splitat("->",true)   print(match(p,"oeps"))              -- oeps

local splitters_s, splitters_m = { }, { }

local function splitat(separator,single)
    local splitter = (single and splitters_s[separator]) or splitters_m[separator]
    if not splitter then
        separator = P(separator)
        if single then
            local other, any = C((1 - separator)^0), P(1)
            splitter = other * (separator * C(any^0) + "") -- ?
            splitters_s[separator] = splitter
        else
            local other = C((1 - separator)^0)
            splitter = other * (separator * other)^0
            splitters_m[separator] = splitter
        end
    end
    return splitter
end

lpeg.splitat = splitat

local cache = { }

function lpeg.split(separator,str)
    local c = cache[separator]
    if not c then
        c = Ct(splitat(separator))
        cache[separator] = c
    end
    return match(c,str)
end

function string:split(separator)
    local c = cache[separator]
    if not c then
        c = Ct(splitat(separator))
        cache[separator] = c
    end
    return match(c,self)
end

lpeg.splitters = cache

local cache = { }

function lpeg.checkedsplit(separator,str)
    local c = cache[separator]
    if not c then
        separator = P(separator)
        local other = C((1 - separator)^0)
        c = Ct(separator^0 * other * (separator^1 * other)^0)
        cache[separator] = c
    end
    return match(c,str)
end

function string:checkedsplit(separator)
    local c = cache[separator]
    if not c then
        separator = P(separator)
        local other = C((1 - separator)^0)
        c = Ct(separator^0 * other * (separator^1 * other)^0)
        cache[separator] = c
    end
    return match(c,self)
end

--~ function lpeg.append(list,pp)
--~     local p = pp
--~     for l=1,#list do
--~         if p then
--~             p = p + P(list[l])
--~         else
--~             p = P(list[l])
--~         end
--~     end
--~     return p
--~ end

--~ from roberto's site:

local f1 = string.byte

local function f2(s) local c1, c2         = f1(s,1,2) return   c1 * 64 + c2                       -    12416 end
local function f3(s) local c1, c2, c3     = f1(s,1,3) return  (c1 * 64 + c2) * 64 + c3            -   925824 end
local function f4(s) local c1, c2, c3, c4 = f1(s,1,4) return ((c1 * 64 + c2) * 64 + c3) * 64 + c4 - 63447168 end

patterns.utf8byte = patterns.utf8one/f1 + patterns.utf8two/f2 + patterns.utf8three/f3 + patterns.utf8four/f4
