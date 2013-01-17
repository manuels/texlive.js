---
--- This is file `luabibentry.lua',
--- generated with the docstrip utility.
---
--- The original source files were:
---
--- luabibentry.dtx  (with options: `lua')
---  
--- Copyright (c) 2011 by Oliver Kopp <oliver.kopp.googlemail.com>
--- 
--- This file was generated from file(s) of luabibentry distribution.
--- -----------------------------------------------------------------
--- 
--- This work may be distributed and/or modified under the conditions of
--- the LaTeX Project Public License, version 1.3c of the license.
--- The latest version of this license is in
---   http://www.latex-project.org/lppl.txt
--- and version 1.3c or later is part of all distributions of LaTeX
--- version 2005/12/01 or later.
--- 
--- This work has the LPPL maintenance status "maintained".
--- 
--- The Current Maintainer and author of this work is Oliver Kopp.
--- 
--- This file may only be distributed together with the files listed in
--- `luabibentry.dtx'. You may however distribute the files listed in
--- `luabibentry.dtx' without this file.
--- 
if (luatexbase and (luatexbase.provides_module)) then
   luatexbase.provides_module({
      name = "luabibentry",
      date = "2011/06/27",
      version = "0.1",
      description = "LuaLaTeX Package to Place Bibliography Entries in Text",
      author = "Oliver Kopp",
      licence = "LPPL v1.3c or later"
  })
end
module("luabibentry", package.seeall)
require("lualibs-file")

-- stores all entries
local entries = {}

-- builds the data by reading the given filename
function builddata(filename)
  -- Parameters seem to be passed as arrays.
  -- We access the first element of the parameter to get the filename
  local file = io.open(filename[1], "r")
  if file==nil then
     texio.write_nl("luabibentry: could not open file " .. filename[1])
     return
  end
  local line = file:read("*line")
  while (line~=nil) do
    -- \bibitem is our marker for new entries
    local i = string.find(line, "\\bibitem")
    if i~=nil then
      -- we expect the key in brackets in the same line
      i = string.find(line,"{")
      local lasti = 0
      -- we jump to the last bracket
      while i~= nil do
         lasti = i
         i = string.find(line,"{",i+1)
      end
      local key = string.sub(line, lasti+1)
      -- we use the text from the last opening bracket ("{") until
      -- the end of the line minus one
      -- we expect nothing more to follow in this line
      key = string.sub(key, 1, string.len(key)-1)
      -- the next lines are the entry
      -- we expect an entry to be finished with a blank line
      -- (or the end of the file)
      line = file:read("*line")
      local entry = ""
      while (line~=nil) and (line~="") do
         entry = entry .. line
         line = file:read("*line")
      end
      -- remove the final dot (if present)
      local entryLen = string.len(entry)
      local lastChar = string.sub(entry, entryLen, entryLen)
      if lastChar == "." then
        entry = string.sub(entry, 1, entryLen-1)
      end
      entries[key]=entry
    end
    line = file:read("*line")
  end
  file:close()
end

-- looks up the given key in the entries
-- in case an entry is not found, a bold question mark is printed
function bibentry(key)
  local res = entries[key[1]]
  if res==nil then
     res = "\\textbf{?}"
  end
  tex.print(res)
end


