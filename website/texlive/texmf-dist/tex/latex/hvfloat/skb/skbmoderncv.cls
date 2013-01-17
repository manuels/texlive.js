%%
%% This is file `skbmoderncv.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% skb.dtx  (with options: `skbmoderncv')
%% 
%% 
%% skbmoderncv.cls
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
\ProvidesClass{skbmoderncv}[2011/06/03 The SKB Modern CV class v0.52]
\LoadClass[11pt,a4paper]{moderncv}
\RequirePackage{skb}
\RequirePackage[style=alphabetic,sorting=ynt,bibstyle=standard,hyperref]{biblatex}
\RequirePackage{eurofont}
\RequirePackage{enumitem}
\RequirePackage[x11names]{xcolor}
\RequirePackage[colorlinks,%
                linkcolor=Brown4,%
                citecolor=SeaGreen4,%
                urlcolor=RoyalBlue3,%
                pdftex
               ]{hyperref}
\moderncvtheme{classic}
\newcommand{\up}[1]{\ensuremath{^\textrm{\scriptsize#1}}}
\renewcommand{\listitemsymbol}{\textendash}
\defbibheading{None}{}
\newcommand{\skbcvrefplain}[1]{%
  \defbibenvironment{bibliography}
    {\list{}{%
       \setlength{\parindent}{\hintscolumnwidth}
       \addtolength{\parindent}{\separatorcolumnwidth}
       \leftmargin\parindent
       \setlength{\parindent}{0pt}
       \itemindent\parindent
       \itemsep\bibitemsep
       \parsep\bibparsep
    }}
    {\endlist}
    {\item}

  \begin{refsegment}
    \nocite{#1}
    \printbibliography[heading=None,segment=\therefsegment,maxnames=20,minnames=20]
  \end{refsegment}
}
\newcommand{\skbcvrefenum}[1]{%
  \defbibenvironment{bibliography}
    {\setlength{\parindent}{\hintscolumnwidth}
     \addtolength{\parindent}{\separatorcolumnwidth}
     \addtolength{\parindent}{1pt}
     \begin{enumerate}[leftmargin=\parindent,labelsep=\separatorcolumnwidth,label*=\arabic*,noitemsep,topsep=1pt]{%
    }}
    {\end{enumerate}%
     \setlength{\parindent}{0pt}
    }
    {\item}

  \begin{refsegment}
    \nocite{#1}
    \printbibliography[heading=None,segment=\therefsegment,maxnames=20,minnames=20]
  \end{refsegment}
}
\endinput
%%
%% End of file `skbmoderncv.cls'.
