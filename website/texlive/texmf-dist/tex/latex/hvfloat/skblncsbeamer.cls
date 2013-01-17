%%
%% This is file `skblncsbeamer.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% skb.dtx  (with options: `skblncsbeamer')
%% 
%% 
%% skblncsbeamer.cls
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
\ProvidesClass{skblncsbeamer}[2011/06/03 The SKB LNCS Beamer class v0.52]
\providecommand{\titlepage}{}
\LoadClass[9pt,a4paper,extrafontsizes,twoside,onecolumn,openright,article,x11names]{memoir}
\RequirePackage{beamerarticle,pgf}
\RequirePackage{skb}
\RequirePackage[style=alphabetic,sorting=none,hyperref]{biblatex}
\RequirePackage[printonlyused]{acronym}
\RequirePackage{etoolbox,comment,graphicx,longtable,colortbl}
\RequirePackage{textcomp,gensymb,wasysym,units,xmpmulti}
\listfiles
\setlength{\oddsidemargin}{0cm}
\setlength{\evensidemargin}{0cm}
\setlength{\textwidth}{15cm}
\setlength{\textheight}{24.5cm}
\setlength{\topmargin}{-1.5cm}
\def\thesection{\arabic{section}}
\settocdepth{subsection}
\setsecnumdepth{subsubsection}
\headstyles{komalike}
\tightlists
\midsloppy
\raggedbottom
\parindent0pt
\setlength{\parskip}{0.2cm}
\makeindex
\AtBeginDocument{
  \resizebox{\textwidth}{!}{\includeslide{title}}
  \bigskip
  \tableofcontents*
  \bigskip
  \newpage
}
\endinput
%%
%% End of file `skblncsbeamer.cls'.
