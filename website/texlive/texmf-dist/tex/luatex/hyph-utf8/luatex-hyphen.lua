-- 
--  This is file `luatex-hyphen.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luatex-hyphen.dtx  (with options: `lua')
--  
--  This is a generated file (source: luatex-hyphen.dtx).
--  
--  Copyright (C) 2012 by The LuaLaTeX development team.
--  
--  This work is under the CC0 license.
--  
local error, dofile, pairs, ipairs = error, dofile, pairs, ipairs
local io, texio, lang, kpse = io, texio, lang, kpse
module('luatexhyphen')
local function wlog(msg, ...)
    texio.write_nl('log', 'luatex-hyphen: '..msg:format(...))
end
local function err(msg, ...)
    error('luatex-hyphen: '..msg:format(...), 2)
end
local dbname = "language.dat.lua"
local language_dat
local dbfile = kpse.find_file(dbname)
if not dbfile then
    err("file not found: "..dbname)
else
    wlog('using data file: %s', dbfile)
    language_dat = dofile(dbfile)
end
function lookupname(name)
    if language_dat[name] then
        return language_dat[name], name
    else
        for canon, data in pairs(language_dat) do
            for _,syn in ipairs(data.synonyms) do
                if syn == name then
                    return data, canon
                end
            end
        end
    end
end
function loadlanguage(lname, id)
    if id == 0 then
        return
    end
    local msg = "loading%s patterns and exceptions for: %s (\\language%d)"
    local ldata, cname = lookupname(lname)
    if not ldata then
        err("no entry in %s for this language: %s", dbname, lname)
    end
    if ldata.special then
        if ldata.special:find('^disabled:') then
            err("language disabled by %s: %s (%s)", dbname, cname,
                ldata.special:gsub('^disabled:', ''))
        elseif ldata.special == 'language0' then
            err("\\language0 should be dumped in the format")
        else
            err("bad entry in %s for language %s")
        end
    end
    wlog(msg, '', cname, id)
    for _, item in ipairs{'patterns', 'hyphenation'} do
        local filelist = ldata[item]
        if filelist ~= nil and filelist ~= '' then
          for _, file in ipairs(filelist:explode(',')) do
            local file = kpse.find_file(file) or err("file not found: %s", file)
            local fh = io.open(file, 'r')
            local data = fh:read('*a') or err("file not readable: %s", f)
            fh:close()
            lang[item](lang.new(id), data)
          end
        else
            if item == 'hyphenation' then item = item..' exceptions' end
            wlog("info: no %s for this language", item)
        end
    end
end
function adddialect(dialect, language)
    if dialect ~= '0' then
        dialect = dialect:gsub('l@', '')
        language = language:gsub('l@', '')
        data = language_dat[language]
        if data then
            data.synonyms[#data.synonyms+1] = dialect
        end
    end
end
-- 
--  End of File `luatex-hyphen.lua'.
