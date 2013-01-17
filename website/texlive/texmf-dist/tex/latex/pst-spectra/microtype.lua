--
-- This is file `microtype.lua',
-- generated with the docstrip utility.
--
-- The original source files were:
--
-- microtype.dtx  (with options: `luafile')
-- 
-- ------------------------------------------------------------------------
-- 
--                       The `microtype' package
--        An interface to the micro-typographic extensions of pdfTeX
--           Copyright (c) 2004--2010  R Schlicht <w.m.l@gmx.net>
-- 
-- This work may be distributed and/or modified under the conditions of the
-- LaTeX Project Public License, either version 1.3c of this license or (at
-- your option) any later version. The latest version of this license is in:
-- http://www.latex-project.org/lppl.txt, and version 1.3c or later is part
-- of all distributions of LaTeX version 2005/12/01 or later.
-- 
-- This work has the LPPL maintenance status `author-maintained'.
-- 
-- This work consists of the files microtype.dtx and microtype.ins and the
-- derived files microtype.sty, microtype.lua and letterspace.sty.
-- 
-- ------------------------------------------------------------------------
--   This file contains auxiliary lua functions.
--   It was contributed by Elie Roux <elie.roux{at}telecom-bretagne.eu>.
-- ------------------------------------------------------------------------ 
--
if microtype then
  -- we simply don't load
else

microtype = {}

microtype.module = {
  name         = "microtype",
  version      = 2.4,
  date         = "2010/01/10",
  description  = "microtype module.",
  author       = "R Schlicht",
  copyright    = "R Schlicht",
  license      = "LPPL",
}

if luatextra and luatextra.provides_module then
  luatextra.provides_module(microtype.module)
end

function microtype.ifint(s)
  if string.find(s,"^-*[0-9]+ *$") then
    tex.write("@firstoftwo")
  else
    tex.write("@secondoftwo")
  end
end

function microtype.ifdimen(s)
  if (string.find(s, "^-*[0-9]+(%a*) *$") or
      string.find(s, "^-*[0-9]*[.,][0-9]+(%a*) *$")) then
    tex.write("@firstoftwo")
  else
    tex.write("@secondoftwo")
  end
end

function microtype.ifstreq(s1, s2)
  if s1 == s2 then
    tex.write("@firstoftwo")
  else
    tex.write("@secondoftwo")
  end
end

end
-- 
--
-- End of file `microtype.lua'.
