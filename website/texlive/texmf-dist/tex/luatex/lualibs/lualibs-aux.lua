if not modules then modules = { } end modules ['l-aux'] = {
    version   = 1.001,
    comment   = "companion to luat-lib.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

-- for inline, no store split : for s in string.gmatch(str,",* *([^,]+)") do .. end

aux = aux or { }

local concat, format, gmatch = table.concat, string.format, string.gmatch
local tostring, type = tostring, type
local lpegmatch = lpeg.match

local P, R, V = lpeg.P, lpeg.R, lpeg.V

local escape, left, right = P("\\"), P('{'), P('}')

lpeg.patterns.balanced = P {
    [1] = ((escape * (left+right)) + (1 - (left+right)) + V(2))^0,
    [2] = left * V(1) * right
}

local space     = lpeg.P(' ')
local equal     = lpeg.P("=")
local comma     = lpeg.P(",")
local lbrace    = lpeg.P("{")
local rbrace    = lpeg.P("}")
local nobrace   = 1 - (lbrace+rbrace)
local nested    = lpeg.P { lbrace * (nobrace + lpeg.V(1))^0 * rbrace }
local spaces    = space^0

local value     = lpeg.P(lbrace * lpeg.C((nobrace + nested)^0) * rbrace) + lpeg.C((nested + (1-comma))^0)

local key       = lpeg.C((1-equal-comma)^1)
local pattern_a = (space+comma)^0 * (key * equal * value + key * lpeg.C(""))
local pattern_c = (space+comma)^0 * (key * equal * value)

local key       = lpeg.C((1-space-equal-comma)^1)
local pattern_b = spaces * comma^0 * spaces * (key * ((spaces * equal * spaces * value) + lpeg.C("")))

-- "a=1, b=2, c=3, d={a{b,c}d}, e=12345, f=xx{a{b,c}d}xx, g={}" : outer {} removes, leading spaces ignored

local hash = { }

local function set(key,value) -- using Carg is slower here
    hash[key] = value
end

local pattern_a_s = (pattern_a/set)^1
local pattern_b_s = (pattern_b/set)^1
local pattern_c_s = (pattern_c/set)^1

aux.settings_to_hash_pattern_a = pattern_a_s
aux.settings_to_hash_pattern_b = pattern_b_s
aux.settings_to_hash_pattern_c = pattern_c_s

function aux.make_settings_to_hash_pattern(set,how)
    if how == "strict" then
        return (pattern_c/set)^1
    elseif how == "tolerant" then
        return (pattern_b/set)^1
    else
        return (pattern_a/set)^1
    end
end

function aux.settings_to_hash(str,existing)
    if str and str ~= "" then
        hash = existing or { }
        if moretolerant then
            lpegmatch(pattern_b_s,str)
        else
            lpegmatch(pattern_a_s,str)
        end
        return hash
    else
        return { }
    end
end

function aux.settings_to_hash_tolerant(str,existing)
    if str and str ~= "" then
        hash = existing or { }
        lpegmatch(pattern_b_s,str)
        return hash
    else
        return { }
    end
end

function aux.settings_to_hash_strict(str,existing)
    if str and str ~= "" then
        hash = existing or { }
        lpegmatch(pattern_c_s,str)
        return next(hash) and hash
    else
        return nil
    end
end

local separator = comma * space^0
local value     = lpeg.P(lbrace * lpeg.C((nobrace + nested)^0) * rbrace) + lpeg.C((nested + (1-comma))^0)
local pattern   = lpeg.Ct(value*(separator*value)^0)

-- "aap, {noot}, mies" : outer {} removes, leading spaces ignored

aux.settings_to_array_pattern = pattern

-- we could use a weak table as cache

function aux.settings_to_array(str)
    if not str or str == "" then
        return { }
    else
        return lpegmatch(pattern,str)
    end
end

local function set(t,v)
    t[#t+1] = v
end

local value   = lpeg.P(lpeg.Carg(1)*value) / set
local pattern = value*(separator*value)^0 * lpeg.Carg(1)

function aux.add_settings_to_array(t,str)
    return lpegmatch(pattern,str,nil,t)
end

function aux.hash_to_string(h,separator,yes,no,strict,omit)
    if h then
        local t, s = { }, table.sortedkeys(h)
        omit = omit and table.tohash(omit)
        for i=1,#s do
            local key = s[i]
            if not omit or not omit[key] then
                local value = h[key]
                if type(value) == "boolean" then
                    if yes and no then
                        if value then
                            t[#t+1] = key .. '=' .. yes
                        elseif not strict then
                            t[#t+1] = key .. '=' .. no
                        end
                    elseif value or not strict then
                        t[#t+1] = key .. '=' .. tostring(value)
                    end
                else
                    t[#t+1] = key .. '=' .. value
                end
            end
        end
        return concat(t,separator or ",")
    else
        return ""
    end
end

function aux.array_to_string(a,separator)
    if a then
        return concat(a,separator or ",")
    else
        return ""
    end
end

function aux.settings_to_set(str,t)
    t = t or { }
    for s in gmatch(str,"%s*([^,]+)") do
        t[s] = true
    end
    return t
end

local value     = lbrace * lpeg.C((nobrace + nested)^0) * rbrace
local pattern   = lpeg.Ct((space + value)^0)

function aux.arguments_to_table(str)
    return lpegmatch(pattern,str)
end

-- temporary here

function aux.getparameters(self,class,parentclass,settings)
    local sc = self[class]
    if not sc then
        sc = table.clone(self[parent])
        self[class] = sc
    end
    aux.settings_to_hash(settings,sc)
end

-- temporary here

local digit         = lpeg.R("09")
local period        = lpeg.P(".")
local zero          = lpeg.P("0")
local trailingzeros = zero^0 * -digit -- suggested by Roberto R
local case_1        = period * trailingzeros / ""
local case_2        = period * (digit - trailingzeros)^1 * (trailingzeros / "")
local number        = digit^1 * (case_1 + case_2)
local stripper      = lpeg.Cs((number + 1)^0)

--~ local sample = "bla 11.00 bla 11 bla 0.1100 bla 1.00100 bla 0.00 bla 0.001 bla 1.1100 bla 0.100100100 bla 0.00100100100"
--~ collectgarbage("collect")
--~ str = string.rep(sample,10000)
--~ local ts = os.clock()
--~ lpegmatch(stripper,str)
--~ print(#str, os.clock()-ts, lpegmatch(stripper,sample))

lpeg.patterns.strip_zeros = stripper

function aux.strip_zeros(str)
    return lpegmatch(stripper,str)
end

function aux.definetable(target) -- defines undefined tables
    local composed, t = nil, { }
    for name in gmatch(target,"([^%.]+)") do
        if composed then
            composed = composed .. "." .. name
        else
            composed = name
        end
        t[#t+1] = format("%s = %s or { }",composed,composed)
    end
    return concat(t,"\n")
end

function aux.accesstable(target)
    local t = _G
    for name in gmatch(target,"([^%.]+)") do
        t = t[name]
    end
    return t
end

-- as we use this a lot ...

--~ function aux.cachefunction(action,weak)
--~     local cache = { }
--~     if weak then
--~         setmetatable(cache, { __mode = "kv" } )
--~     end
--~     local function reminder(str)
--~         local found = cache[str]
--~         if not found then
--~             found = action(str)
--~             cache[str] = found
--~         end
--~         return found
--~     end
--~     return reminder, cache
--~ end
