#!/bin/bash
##
## This is `typeoutfileinfo.sh', a minimalist shell script for Unices.
## 
##     ./typeoutfileinfo.sh [FILENAME].[EXT]
##
## runs latex with the readprov package:
##
##     http://ctan.org/pkg/readprov
##
## in order to display [FILENAME].[TXT]'s FILE INFO (\listfile entry)
## using \typeout. This requires that [FILENAME].[EXT] contains a 
## \ProvidesFile, \ProvidesPackage, or \ProvidesClass command.
(
cat << EOM
\\RequirePackage{readprov} \\ReadFileInfos{$1}
\\typeout{^^J^^J *$1 info*: \\space \\csname ver@$1\\endcsname^^J^^J}\\stop
EOM
) | latex
##
## Copyright (C) 2012 Uwe Lueck, http://contact-ednotes.sty.de.vu/
##
## This program may be distributed and/or modified under the
## conditions of the LaTeX Project Public License, either version 1.3c
## of this license or (at your option) any later version.
## The latest version of this license is in
##   http://www.latex-project.org/lppl.txt
## and version 1.3c or later is part of all distributions of LaTeX 
## version 1999/12/01 or later.
##
## There is NO WARRANTY.
##
## This is package version v0.1a as of 2012-03-16.
##
## CREDIT: this work derived from Harald Harders' `latexfileversion' 
## as a simplification using my `readprov'. I learnt "here document" 
## from `latexfileversion' -- UL.
##
## PURPOSE/BACKGROUND: A package like this, `latexfileversion' or 
## `ltxfileinfo' when you wonder which version of a source file 
## (package, document component) is available in some directory -- 
## I typically test package changes by symbolic links in single 
## project directories before installing them globally, and then 
## sometimes don't remember ... when I get an "undefined" error, 
## I wonder whether I have installed the symbolic link or whether 
## I just forgot to define this, or whether I lost the most recent 
## version ...
