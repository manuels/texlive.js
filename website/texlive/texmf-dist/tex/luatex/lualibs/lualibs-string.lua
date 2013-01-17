if not modules then modules = { } end modules ['l-string'] = {
    version   = 1.001,
    comment   = "companion to luat-lib.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

local sub, gsub, find, match, gmatch, format, char, byte, rep, lower = string.sub, string.gsub, string.find, string.match, string.gmatch, string.format, string.char, string.byte, string.rep, string.lower
local lpegmatch = lpeg.match

-- some functions may disappear as they are not used anywhere

if not string.split then

    -- this will be overloaded by a faster lpeg variant

    function string:split(pattern)
        if #self > 0 then
            local t = { }
            for s in gmatch(self..pattern,"(.-)"..pattern) do
                t[#t+1] = s
            end
            return t
        else
            return { }
        end
    end

end

local chr_to_esc = {
    ["%"] = "%%",
    ["."] = "%.",
    ["+"] = "%+", ["-"] = "%-", ["*"] = "%*",
    ["^"] = "%^", ["$"] = "%$",
    ["["] = "%[", ["]"] = "%]",
    ["("] = "%(", [")"] = "%)",
    ["{"] = "%{", ["}"] = "%}"
}

string.chr_to_esc = chr_to_esc

function string:esc() -- variant 2
    return (gsub(self,"(.)",chr_to_esc))
end

function string:unquote()
    return (gsub(self,"^([\"\'])(.*)%1$","%2"))
end

--~ function string:unquote()
--~     if find(self,"^[\'\"]") then
--~         return sub(self,2,-2)
--~     else
--~         return self
--~     end
--~ end

function string:quote() -- we could use format("%q")
    return format("%q",self)
end

function string:count(pattern) -- variant 3
    local n = 0
    for _ in gmatch(self,pattern) do
        n = n + 1
    end
    return n
end

function string:limit(n,sentinel)
    if #self > n then
        sentinel = sentinel or " ..."
        return sub(self,1,(n-#sentinel)) .. sentinel
    else
        return self
    end
end

--~ function string:strip() -- the .- is quite efficient
--~  -- return match(self,"^%s*(.-)%s*$") or ""
--~  -- return match(self,'^%s*(.*%S)') or '' -- posted on lua list
--~     return find(s,'^%s*$') and '' or match(s,'^%s*(.*%S)')
--~ end

do -- roberto's variant:
    local space    = lpeg.S(" \t\v\n")
    local nospace  = 1 - space
    local stripper = space^0 * lpeg.C((space^0 * nospace^1)^0)
    function string.strip(str)
        return lpegmatch(stripper,str) or ""
    end
end

function string:is_empty()
    return not find(self,"%S")
end

function string:enhance(pattern,action)
    local ok, n = true, 0
    while ok do
        ok = false
        self = gsub(self,pattern, function(...)
            ok, n = true, n + 1
            return action(...)
        end)
    end
    return self, n
end

local chr_to_hex, hex_to_chr = { }, { }

for i=0,255 do
    local c, h = char(i), format("%02X",i)
    chr_to_hex[c], hex_to_chr[h] = h, c
end

function string:to_hex()
    return (gsub(self or "","(.)",chr_to_hex))
end

function string:from_hex()
    return (gsub(self or "","(..)",hex_to_chr))
end

if not string.characters then

    local function nextchar(str, index)
        index = index + 1
        return (index <= #str) and index or nil, sub(str,index,index)
    end
    function string:characters()
        return nextchar, self, 0
    end
    local function nextbyte(str, index)
        index = index + 1
        return (index <= #str) and index or nil, byte(sub(str,index,index))
    end
    function string:bytes()
        return nextbyte, self, 0
    end

end

-- we can use format for this (neg n)

function string:rpadd(n,chr)
    local m = n-#self
    if m > 0 then
        return self .. rep(chr or " ",m)
    else
        return self
    end
end

function string:lpadd(n,chr)
    local m = n-#self
    if m > 0 then
        return rep(chr or " ",m) .. self
    else
        return self
    end
end

string.padd = string.rpadd

function is_number(str) -- tonumber
    return find(str,"^[%-%+]?[%d]-%.?[%d+]$") == 1
end

--~ print(is_number("1"))
--~ print(is_number("1.1"))
--~ print(is_number(".1"))
--~ print(is_number("-0.1"))
--~ print(is_number("+0.1"))
--~ print(is_number("-.1"))
--~ print(is_number("+.1"))

function string:split_settings() -- no {} handling, see l-aux for lpeg variant
    if find(self,"=") then
        local t = { }
        for k,v in gmatch(self,"(%a+)=([^%,]*)") do
            t[k] = v
        end
        return t
    else
        return nil
    end
end

local patterns_escapes = {
    ["-"] = "%-",
    ["."] = "%.",
    ["+"] = "%+",
    ["*"] = "%*",
    ["%"] = "%%",
    ["("] = "%)",
    [")"] = "%)",
    ["["] = "%[",
    ["]"] = "%]",
}

function string:pattesc()
    return (gsub(self,".",patterns_escapes))
end

local simple_escapes = {
    ["-"] = "%-",
    ["."] = "%.",
    ["?"] = ".",
    ["*"] = ".*",
}

function string:simpleesc()
    return (gsub(self,".",simple_escapes))
end

function string:tohash()
    local t = { }
    for s in gmatch(self,"([^, ]+)") do -- lpeg
        t[s] = true
    end
    return t
end

local pattern = lpeg.Ct(lpeg.C(1)^0)

function string:totable()
    return lpegmatch(pattern,self)
end

--~ local t = {
--~     "1234567123456712345671234567",
--~     "a\tb\tc",
--~     "aa\tbb\tcc",
--~     "aaa\tbbb\tccc",
--~     "aaaa\tbbbb\tcccc",
--~     "aaaaa\tbbbbb\tccccc",
--~     "aaaaaa\tbbbbbb\tcccccc",
--~ }
--~ for k,v do
--~     print(string.tabtospace(t[k]))
--~ end

function string.tabtospace(str,tab)
    -- we don't handle embedded newlines
    while true do
        local s = find(str,"\t")
        if s then
            if not tab then tab = 7 end -- only when found
            local d = tab-(s-1) % tab
            if d > 0 then
                str = gsub(str,"\t",rep(" ",d),1)
            else
                str = gsub(str,"\t","",1)
            end
        else
            break
        end
    end
    return str
end

function string:compactlong() -- strips newlines and leading spaces
    self = gsub(self,"[\n\r]+ *","")
    self = gsub(self,"^ *","")
    return self
end

function string:striplong() -- strips newlines and leading spaces
    self = gsub(self,"^%s*","")
    self = gsub(self,"[\n\r]+ *","\n")
    return self
end

function string:topattern(lowercase,strict)
    if lowercase then
        self = lower(self)
    end
    self = gsub(self,".",simple_escapes)
    if self == "" then
        self = ".*"
    elseif strict then
        self = "^" .. self .. "$"
    end
    return self
end
