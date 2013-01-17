if not modules then modules = { } end modules ['l-md5'] = {
    version   = 1.001,
    author    = "Hans Hagen, PRAGMA-ADE, Hasselt NL",
    copyright = "PRAGMA ADE / ConTeXt Development Team",
    license   = "see context related readme files"
}

-- This also provides file checksums and checkers.

local gsub, format, byte = string.gsub, string.format, string.byte

local function convert(str,fmt)
    return (gsub(md5.sum(str),".",function(chr) return format(fmt,byte(chr)) end))
end

if not md5.HEX then function md5.HEX(str) return convert(str,"%02X") end end
if not md5.hex then function md5.hex(str) return convert(str,"%02x") end end
if not md5.dec then function md5.dec(str) return convert(str,"%03i") end end

--~ if not md5.HEX then
--~     local function remap(chr) return format("%02X",byte(chr)) end
--~     function md5.HEX(str) return (gsub(md5.sum(str),".",remap)) end
--~ end
--~ if not md5.hex then
--~     local function remap(chr) return format("%02x",byte(chr)) end
--~     function md5.hex(str) return (gsub(md5.sum(str),".",remap)) end
--~ end
--~ if not md5.dec then
--~     local function remap(chr) return format("%03i",byte(chr)) end
--~     function md5.dec(str) return (gsub(md5.sum(str),".",remap)) end
--~ end

file.needs_updating_threshold = 1

function file.needs_updating(oldname,newname) -- size modification access change
    local oldtime = lfs.attributes(oldname, modification)
    local newtime = lfs.attributes(newname, modification)
    if newtime >= oldtime then
        return false
    elseif oldtime - newtime < file.needs_updating_threshold then
        return false
    else
        return true
    end
end

function file.checksum(name)
    if md5 then
        local data = io.loaddata(name)
        if data then
            return md5.HEX(data)
        end
    end
    return nil
end

function file.loadchecksum(name)
    if md5 then
        local data = io.loaddata(name .. ".md5")
        return data and (gsub(data,"%s",""))
    end
    return nil
end

function file.savechecksum(name, checksum)
    if not checksum then checksum = file.checksum(name) end
    if checksum then
        io.savedata(name .. ".md5",checksum)
        return checksum
    end
    return nil
end
