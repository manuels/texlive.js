-- 
--  This is file `cctb.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luatexbase-cctb.dtx  (with options: `luamodule')
--  
--  Written in 2009, 2010 by Manuel Pegourie-Gonnard and Elie Roux.
--  
--  This work is under the CC0 license.
--  See source file 'luatexbase-cctb.dtx' for details.
--  
module('luatexbase', package.seeall)
catcodetables = {}
function catcodetabledef_from_tex(name, number)
    catcodetables[name] = tonumber(number)
end
function catcodetable_do_shortcuts()
    local cat = catcodetables
    cat['latex']                = cat.CatcodeTableLaTeX
    cat['latex-package']        = cat.CatcodeTableLaTeXAtLetter
    cat['latex-atletter']       = cat.CatcodeTableLaTeXAtLetter
    cat['ini']                  = cat.CatcodeTableIniTeX
    cat['expl3']                = cat.CatcodeTableExpl
    cat['expl']                 = cat.CatcodeTableExpl
    cat['string']               = cat.CatcodeTableString
    cat['other']                = cat.CatcodeTableOther
end
-- 
--  End of File `cctb.lua'.
