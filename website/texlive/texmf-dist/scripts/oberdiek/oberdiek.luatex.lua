-- 
--  This is file `oberdiek.luatex.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luatex.dtx  (with options: `lua')
--  
--  This is a generated file.
--  
--  Project: luatex
--  Version: 2010/03/09 v0.4
--  
--  Copyright (C) 2007, 2009, 2010 by
--     Heiko Oberdiek <heiko.oberdiek at googlemail.com>
--  
--  This work may be distributed and/or modified under the
--  conditions of the LaTeX Project Public License, either
--  version 1.3c of this license or (at your option) any later
--  version. This version of this license is in
--     http://www.latex-project.org/lppl/lppl-1-3c.txt
--  and the latest version of this license is in
--     http://www.latex-project.org/lppl.txt
--  and version 1.3 or later is part of all distributions of
--  LaTeX version 2005/12/01 or later.
--  
--  This work has the LPPL maintenance status "maintained".
--  
--  This Current Maintainer of this work is Heiko Oberdiek.
--  
--  The Base Interpreter refers to any `TeX-Format',
--  because some files are installed in TDS:tex/generic//.
--  
--  This work consists of the main source file luatex.dtx
--  and the derived files
--     luatex.sty, luatex.pdf, luatex.ins, luatex.drv, luatex-loader.sty,
--     luatex-test1.tex, luatex-test2.tex, luatex-test3.tex,
--     luatex-test4.tex, luatex-test5.tex, oberdiek.luatex.lua.
--  
module("oberdiek.luatex", package.seeall)
function kpse_module_loader(module)
  local script = module .. ".lua"
  local file = kpse.find_file(script, "texmfscripts")
  if file then
    local loader, error = loadfile(file)
    if loader then
      texio.write_nl("(" .. file .. ")")
      return loader
    end
    return "\n\t[oberdiek.luatex.kpse_module_loader] Loading error:\n\t"
           .. error
  end
  return "\n\t[oberdiek.luatex.kpse_module_loader] Search failed"
end
table.insert(package.loaders, kpse_module_loader)
-- 
--  End of File `oberdiek.luatex.lua'.
