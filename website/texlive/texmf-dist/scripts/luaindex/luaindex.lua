---
--- This is file `luaindex.lua',
--- generated with the docstrip utility.
---
--- The original source files were:
---
--- luaindex.dtx  (with options: `lua')
---  
--- Copyright (c) 2011 by Markus Kohm <komascript(at)gmx.info>
--- 
--- This file was generated from file(s) of luaindex distribution.
--- --------------------------------------------------------------
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
--- The Current Maintainer and author of this work is Markus Kohm.
--- 
--- This file may only be distributed together with the files listed in
--- `luaindex.dtx'. You may however distribute the files listed in
--- `luaindex.dtx' without this file.
--- 
--- NOTE: THIS IS AN ALPHA-VERSION!
--- 
if luatexbase.provides_module then
   luatexbase.provides_module({
      name = "luaindex",
      date = "2011/02/18",
      version = "0.1b",
      description = "LuaTeX index processor",
      author = "Markus Kohm",
      licence = "LPPL v1.3c or later"
  })
end
module("luaindex", package.seeall)
local indexes = {}
function newindex( indexname )
   indexes[indexname]={ presortreplaces = {},
                        sortorderbychar = {} }
end
function sortorder( indexname, sortorder )
   local i, value
   local index = indexes[indexname]
   if index == nil then
      tex.error( "Unknown index `" .. indexname .. "'",
                 { "You've tried to add a new sortorder to an index, but there's no index with the",
                   "given name.",
                   "You should define the index using lua function ",
                   "  `luaindex.newindex(\"" .. indexname .. "\")'",
                   "before."
                 }
               )
   else
      if type(sortorder) == "string" then
         local value
         i = 1
         repeat
            value = unicode.utf8.sub( sortorder, i, i )
            if value then
               index.sortorderbychar[value] = i
            end
            i = i + 1
         until value == ""
      else -- should be table
         for i, value in ipairs( sortorder ) do
            index.sortorderbychar[value] = i
         end
     end
   end
end
function presortreplace( indexname, pass, pattern, replace )
   local n
   local index = indexes[indexname]
   if index == nil then
      tex.error( "Unknown index `" .. indexname .. "'",
                 { "You've tried to add a new presort-replace to an index, but there's no index",
                   "with the given name.",
                   "You should define the index using lua function ",
                   "  `luaindex.newindex(\"" .. indexname .. "\")'",
                   "before."
                 }
               )
   else
      for n = table.maxn(index.presortreplaces), pass, 1 do
         if ( index.presortreplaces[n] == nil ) then
            index.presortreplaces[n] = {}
         end
      end
      index.presortreplaces[pass][pattern]=replace
   end
end
local function getclass( utfc )
   local i
   for i in unicode.utf8.gmatch( utfc, "%n" ) do
      return 2
   end
   for i in unicode.utf8.gmatch( utfc, "%a" ) do
      return 3
   end
   return 1
end
local function do_presortreplaces( srcstr, presortreplace )
   if presortreplace then
      local pat, rep
      for pat, rep in pairs( presortreplace ) do
         srcstr = unicode.utf8.gsub( srcstr, pat, rep )
      end
   end
   return srcstr
end
local function printsubindex( level, index, presortreplace_zero )
   local i,t,n,p,l
   local group=""
   local class=-1
   local item="\\"
   for l = 1, level, 1 do
      item = item .. "sub"
   end
   item = item .. "item "
   for i,t in ipairs( index ) do
      if ( level == 0 ) then
         local sort=do_presortreplaces( t["sort"], presortreplace_zero )
         local firstchar=unicode.utf8.upper( unicode.utf8.sub( sort, 1, 1 ) )
         if ( firstchar ~= group ) then
            local newclass
            newclass=getclass( firstchar )
            if ( newclass == 1 and class ~= newclass ) then
               tex.print( "\\indexgroup{\\symbolsname}" )
            elseif ( newclass == 3 ) then
               tex.print( "\\indexgroup{" .. firstchar .. "}" )
            elseif ( newclass == 2 and class ~= newclass ) then
               tex.print( "\\indexgroup{\\numbersname}" )
            end
            group=firstchar
            class=newclass
         end
      end
      tex.sprint( item, t["value"] )
      if t["pages"] then
         tex.sprint( "\\indexpagenumbers{" )
         for n,p in ipairs( t["pages"] ) do
            tex.sprint( "\\indexpagenumber{", p, "}" )
         end
         tex.print( "}" )
      end
      if t["subindex"] then
         printsubindex( level+1, t["subindex"], presortreplaces_zero )
      end
   end
end
function printindex( indexname )
   local index=indexes[indexname]
   if index == nil then
      tex.error( "Unknown index `" .. indexname .. "'",
                 { "You've tried to print an index, but there's no index with the",
                   "given name.",
                   "You should define the index using lua function ",
                   "  `luaindex.newindex(\"" .. indexname .. "\")'",
                   "before."
                 }
               )
   else
      print( "Index: \"" .. indexname .. "\" with " .. table.maxn( index ) .. " level-0-entries" )
      tex.print( "\\begin{theindex}" )
      printsubindex(0,indexes[indexname],indexes[indexname].presortreplaces[0])
      tex.print( "\\end{theindex}" )
   end
end
local function getsubclass( utfc )
   local i
   for i in unicode.utf8.gmatch( utfc, "%l" ) do
      return 1
   end
   for i in unicode.utf8.gmatch( utfc, "%u" ) do
      return 2
   end
   for i in unicode.utf8.gmatch( utfc, "%c" ) do
      return 1
   end
   for i in unicode.utf8.gmatch( utfc, "%s" ) do
      return 2
   end
   for i in unicode.utf8.gmatch( utfc, "%p" ) do
      return 3
   end
   for i in unicode.utf8.gmatch( utfc, "%n" ) do
      return 4
   end
   return 10 -- unkown is the biggest sub class
end
local function do_strcmp( first, second, sortorderbychar )
   local secondtable = string.explode( second, "" )
   local firstutf
   local n = 1
   for firstutf in string.utfcharacters( first ) do
      local secondutf = unicode.utf8.sub( second, n, n )
      n = n + 1;
      if firstutf then
         if secondutf ~= "" then
            if firstutf ~= secondutf then
               local firstn, secondn
               if sortorderbychar then
                  firstn = sortorderbychar[firstutf]
                  secondn = sortorderbychar[secondutf]
               end
               if firstn and secondn then
                  if firstn < secondn then
                     return -1
                  elseif firstn > secondn then
                     return 1
                  end
               else
                  local firstclass = getclass( firstutf )
                  local secondclass = getclass( secondutf )
                  if firstclass < secondclass then
                     return -1
                  elseif firstclass == secondclass then
                     local firstsubclass = getsubclass( firstutf)
                     local secondsubclass = getsubclass( secondutf )
                     if firstsubclass < secondsubclass then
                        return -1
                     elseif firstsubclass == secondsubclass then
                        if firstutf < secondutf then
                           return -1
                        else
                           return 1
                        end
                     else
                        return 1
                     end
                  else
                     return 1
                  end
               end
            end
         else
            return 1
         end
      else
         if secondutf ~= "" then
            return -1
         else
            return 0 -- This should never happen!
         end
      end
   end
   if unicode.utf8.sub( second, n, n ) ~= "" then
      return -1
   else
      return 0
   end
end
local function do_indexcmp( firstsort, secondsort,
                            presortreplaces, sortorderbychar )
   local pass = 0
   local ncmp = 0
   repeat
      if presortreplaces and presortreplaces[pass] then
         firstsort = do_presortreplaces( firstsort, presortreplaces[pass] )
         secondsort = do_presortreplaces( secondsort, presortreplaces[pass] )
      end
      pass = pass + 1
      ncmp = do_strcmp( firstsort, secondsort, sortorderbychar )
   until ( ncmp ~= 0 ) or ( pass > table.maxn( presortreplaces ) )
   return ncmp
end
local function subinsert( index, presortreplaces, sortorderbychar,
                          pagestring, sortvalue, outputvalue, ... )
   local min = 1
   local max = table.maxn(index)
   local updown = 0

   local n = math.ceil(( min + max ) / 2)
   while min <= max do
      updown = do_indexcmp( sortvalue, index[n].sort,
                            presortreplaces, sortorderbychar )
      if updown == 0 then
         if outputvalue == index[n].value then
            if ( ... ) then
               if ( index[n].subindex == nil ) then
                  index[n].subindex = {}
               end
               subinsert( index[n].subindex, presortreplaces, sortorderbychar,
                          pagestring, ... )
            else
               local i, p
               for i, p in ipairs( index[n].pages ) do
                  if pagestring == p then
                     return
                  end
               end
               table.insert( index[n].pages, pagestring )
            end
            return
         else
            repeat
               n = n + 1
               if n <= max then
                  updown = do_indexcmp( sortvalue, index[min].sort,
                                        presortreplaces, sortorderbychar )
               end
            until n > max or updown ~= 0
            min = n
            max = n-1
         end
      elseif updown > 0 then
         min = n+1
      else
         max = n-1
      end
      n = math.ceil(( min + max ) / 2)
   end
   if ( ... ) then
      table.insert( index, n,
                    { sort=sortvalue, value=outputvalue, subindex={} } )
      subinsert( index[n].subindex, presortreplaces, sortorderbychar,
                 pagestring, ... )
   else
      table.insert( index, n,
                    { sort=sortvalue, value=outputvalue, pages={pagestring} } )
   end
end
function insert( indexname, pagestring, sortvalue, outputvalue, ... )
   local index=indexes[indexname]
   subinsert( index, index.presortreplaces, index.sortorderbychar,
              pagestring, sortvalue, outputvalue, ... )
end
function removeentries( indexname )
   local p = indexes[indexname].presortreplaces
   local s = indexes[indexname].sortorderbychar
   indexes[indexname]={ presortreplaces = p,
                        sortorderbychar = s }
end
