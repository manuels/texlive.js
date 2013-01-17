%%
%% This is file `skbbeamer.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% skb.dtx  (with options: `skbbeamer')
%% 
%% 
%% skbbeamer.cls
%% Copyright (c) 2011 Sven van der Meer <sven@vandermeer.de>
%%
%% This work may be distributed  and/or modified under the conditions  of the
%% LaTeX Project Public  License, either version  1.3 of this  license or (at
%% your option) any later version.
%% The latest version of this license is in
%%    <http://www.latex-project.org/lppl.txt>
%% and version 1.3  or later is  part of all  distributions of LaTeX  version
%% 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `author-maintained'.
%%
%% The Current Maintainer of this work is
%%    Sven van der Meer <sven@vandermeer.de>
%%
%% This software is  provided 'as is',  without warranty of  any kind, either
%% expressed  or  implied,  including,  but  not  limited  to,  the   implied
%% warranties of merchantability and fitness for a particular purpose.
%%
%% This work consists of all files listed in MANIFEST.TXT.
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{skbbeamer}[2011/06/03 The SKB Beamer class v0.52]
\DeclareOption{beameranim}{\PassOptionsToPackage{\CurrentOption}{skb}}
\DeclareOption{beamernoanim}{\PassOptionsToPackage{\CurrentOption}{skb}}
\ProcessOptions\relax
\RequirePackage[x11names]{xcolor}
\LoadClass[x11names]{beamer}
\RequirePackage{skb}
\RequirePackage[style=alphabetic,sorting=none,hyperref]{biblatex}
\RequirePackage[printonlyused]{acronym}
\RequirePackage{etoolbox,comment,graphicx,longtable,colortbl}
\RequirePackage{textcomp,gensymb,wasysym,units,xmpmulti,float}
\renewcommand*\DTstylecomment{\itshape\sffamily\color{blue}\scriptsize}
\setlength{\DTbaselineskip}{10pt}
\DTsetlength{0.2em}{1em}{0.2em}{0.4pt}{1.6pt}
\renewcommand*\DTstyle{\scriptsize\ttfamily\textcolor{black}}
\endinput
%%
%% End of file `skbbeamer.cls'.
