if not modules then modules = { } end modules ['l-unicode'] = {
    version   = 1.001,
    comment   = "companion to luat-lib.mkiv",
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

if not unicode then

    unicode = { utf8 = { } }

    local floor, char = math.floor, string.char

    function unicode.utf8.utfchar(n)
        if n < 0x80 then
            return char(n)
        elseif n < 0x800 then
            return char(0xC0 + floor(n/0x40))  .. char(0x80 + (n % 0x40))
        elseif n < 0x10000 then
            return char(0xE0 + floor(n/0x1000)) .. char(0x80 + (floor(n/0x40) % 0x40)) .. char(0x80 + (n % 0x40))
        elseif n < 0x40000 then
            return char(0xF0 + floor(n/0x40000)) .. char(0x80 + floor(n/0x1000)) .. char(0x80 + (floor(n/0x40) % 0x40)) .. char(0x80 + (n % 0x40))
        else -- wrong:
          -- return char(0xF1 + floor(n/0x1000000)) .. char(0x80 + floor(n/0x40000)) .. char(0x80 + floor(n/0x1000)) .. char(0x80 + (floor(n/0x40) % 0x40)) .. char(0x80 + (n % 0x40))
            return "?"
        end
    end

end

utf = utf or unicode.utf8

local concat, utfchar, utfgsub = table.concat, utf.char, utf.gsub
local char, byte, find, bytepairs = string.char, string.byte, string.find, string.bytepairs

-- 0  EF BB BF      UTF-8
-- 1  FF FE         UTF-16-little-endian
-- 2  FE FF         UTF-16-big-endian
-- 3  FF FE 00 00   UTF-32-little-endian
-- 4  00 00 FE FF   UTF-32-big-endian

unicode.utfname = {
    [0] = 'utf-8',
    [1] = 'utf-16-le',
    [2] = 'utf-16-be',
    [3] = 'utf-32-le',
    [4] = 'utf-32-be'
}

-- \000 fails in <= 5.0 but is valid in >=5.1 where %z is depricated

function unicode.utftype(f)
    local str = f:read(4)
    if not str then
        f:seek('set')
        return 0
 -- elseif find(str,"^%z%z\254\255") then            -- depricated
 -- elseif find(str,"^\000\000\254\255") then        -- not permitted and bugged
    elseif find(str,"\000\000\254\255",1,true) then  -- seems to work okay (TH)
        return 4
 -- elseif find(str,"^\255\254%z%z") then            -- depricated
 -- elseif find(str,"^\255\254\000\000") then        -- not permitted and bugged
    elseif find(str,"\255\254\000\000",1,true) then  -- seems to work okay (TH)
        return 3
    elseif find(str,"^\254\255") then
        f:seek('set',2)
        return 2
    elseif find(str,"^\255\254") then
        f:seek('set',2)
        return 1
    elseif find(str,"^\239\187\191") then
        f:seek('set',3)
        return 0
    else
        f:seek('set')
        return 0
    end
end

function unicode.utf16_to_utf8(str, endian) -- maybe a gsub is faster or an lpeg
    local result, tmp, n, m, p = { }, { }, 0, 0, 0
    -- lf | cr | crlf / (cr:13, lf:10)
    local function doit()
        if n == 10 then
            if p ~= 13 then
                result[#result+1] = concat(tmp)
                tmp = { }
                p = 0
            end
        elseif n == 13 then
            result[#result+1] = concat(tmp)
            tmp = { }
            p = n
        else
            tmp[#tmp+1] = utfchar(n)
            p = 0
        end
    end
    for l,r in bytepairs(str) do
        if r then
            if endian then
                n = l*256 + r
            else
                n = r*256 + l
            end
            if m > 0 then
                n = (m-0xD800)*0x400 + (n-0xDC00) + 0x10000
                m = 0
                doit()
            elseif n >= 0xD800 and n <= 0xDBFF then
                m = n
            else
                doit()
            end
        end
    end
    if #tmp > 0 then
        result[#result+1] = concat(tmp)
    end
    return result
end

function unicode.utf32_to_utf8(str, endian)
    local result = { }
    local tmp, n, m, p = { }, 0, -1, 0
    -- lf | cr | crlf / (cr:13, lf:10)
    local function doit()
        if n == 10 then
            if p ~= 13 then
                result[#result+1] = concat(tmp)
                tmp = { }
                p = 0
            end
        elseif n == 13 then
            result[#result+1] = concat(tmp)
            tmp = { }
            p = n
        else
            tmp[#tmp+1] = utfchar(n)
            p = 0
        end
    end
    for a,b in bytepairs(str) do
        if a and b then
            if m < 0 then
                if endian then
                    m = a*256*256*256 + b*256*256
                else
                    m = b*256 + a
                end
            else
                if endian then
                    n = m + a*256 + b
                else
                    n = m + b*256*256*256 + a*256*256
                end
                m = -1
                doit()
            end
        else
            break
        end
    end
    if #tmp > 0 then
        result[#result+1] = concat(tmp)
    end
    return result
end

local function little(c)
    local b = byte(c) -- b = c:byte()
    if b < 0x10000 then
        return char(b%256,b/256)
    else
        b = b - 0x10000
        local b1, b2 = b/1024 + 0xD800, b%1024 + 0xDC00
        return char(b1%256,b1/256,b2%256,b2/256)
    end
end

local function big(c)
    local b = byte(c)
    if b < 0x10000 then
        return char(b/256,b%256)
    else
        b = b - 0x10000
        local b1, b2 = b/1024 + 0xD800, b%1024 + 0xDC00
        return char(b1/256,b1%256,b2/256,b2%256)
    end
end

function unicode.utf8_to_utf16(str,littleendian)
    if littleendian then
        return char(255,254) .. utfgsub(str,".",little)
    else
        return char(254,255) .. utfgsub(str,".",big)
    end
end
