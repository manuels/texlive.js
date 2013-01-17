%%
%% Copyright (C) 2007-2008 by:
%% Josef Kleber
%% <josef.kleber@gmx.net>
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3 or later is part of all distributions of LaTeX version
%% 2003/12/01 or later.
%% 
%% This work has the LPPL maintenance status "author-maintained".
%% 
%% This Current Maintainer of this work is Josef Kleber.
%%
%% This work consists of all files listed in manifest.txt.
%%
\ProvidesFile{portuges.dcl}[2007/03/20 v1 (by Pedro Quaresma)]%
%
%contributed by Pedro Quaresma (pedro@mat.uc.pt)
%
\makeatletter%
\renewcommand*\dc@miss{F}%
\renewcommand*\dc@lfrname{Lista de grava\c{c}\~oes defeituosas ou em falta}%
\renewcommand*\dc@ledname{Lista de t\'{\i}tulos sem descri\c{c}\~ao}%
\renewcommand*\dc@pdf@subject{Descri\c{c}\~ao}%
\renewcommand*\dc@dvdlist{Lista de DVDs}%
\renewcommand*\dc@season{Temporada}%
\renewcommand*\dc@pdftitle{Arquivo de DVDs}%
%
%switch on and off the shorthand active character(s) within environment Dvd
\renewcommand*\dc@dvd@shorthand@off{\shorthandoff{"}}%
\renewcommand*\dc@dvd@shorthand@on{\shorthandon{"}}%
\makeatother%
%
\endinput%
%%
%% End of file <portuges.dcl>.
