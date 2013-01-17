--
-- This is file `lualatex-math.lua',
-- generated with the docstrip utility.
--
-- The original source files were:
--
-- lualatex-math.dtx  (with options: `lua')
-- 
-- This is a generated file.
-- 
-- Copyright 2011 by Philipp Stephani
-- 
-- This file may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either
-- version 1.3c of this license or (at your option) any later
-- version.  The latest version of this license is in
-- 
--    http://www.latex-project.org/lppl.txt
-- 
-- and version 1.3c or later is part of all distributions of
-- LaTeX version 2009/09/24 or later.
-- 
require("luatexbase.modutils")
require("luatexbase.cctb")
local err, warn, info, log = luatexbase.provides_module({
  name = "lualatex-math",
  date = "2011/05/05",
  version = 0.1,
  description = "Patches for mathematics typesetting with LuaLaTeX",
  author = "Philipp Stephani",
  licence = "LPPL v1.3+"
})
local unpack = unpack
local string = string
local tex = tex
local cctb = luatexbase.catcodetables
module("lualatex.math")
function print_fam_slot(char)
  local code = tex.getmathcode(char)
  local class, family, slot = unpack(code)
  local result = string.format("%i %i ", family, slot)
  tex.sprint(cctb.string, result)
end
function print_class_fam_slot(char)
  local code = tex.getmathcode(char)
  local class, family, slot = unpack(code)
  local result = string.format("%i %i %i ", class, family, slot)
  tex.sprint(cctb.string, result)
end
