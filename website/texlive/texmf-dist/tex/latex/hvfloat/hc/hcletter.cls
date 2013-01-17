%%
%% This is file `hcletter.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% hc.dtx  (with options: `class,hcletter')
%% 
%% Copyright (C) 1998--2000 Christian Siefkes <error@cs.tu-berlin.de>
%%
%% Updates are available via http://tal.cs.tu-berlin.de/error/TeX/
%%
%% This file is part of the HC Bundle for LaTeX2e.
%% -----------------------------------------------
%%
%% This file is free software; you can redistribute it and/or modify
%% it under the terms of the GNU Library General Public License as
%% published by the Free Software Foundation; either version 2 of the
%% License, or (at your option) any later version.
%%
%% This document is distributed in the hope that it will be useful, but
%% WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%% General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; see the file COPYING. If not, write to
%% the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
%% Boston, MA 02111-1307, USA.
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{hcletter}%
              [2000/03/23 v1.07 LaTeX2e HC Bundle]
\newcommand{\thisclass}{hcletter}
\newcommand{\superclass}{scrlettr}
\newif\if@german
\@germanfalse
\newif\if@deflang
\@deflangtrue
\DeclareOption{german}{\@deflangfalse\@germantrue
  \PassOptionsToPackage{ngerman}{babel}
  \PassOptionsToPackage{german}{fancyref}
  \AtEndOfClass{\input{german.hld}}}
\DeclareOption{english}{\@deflangfalse
  \PassOptionsToPackage{\CurrentOption}{babel}}
\newif\if@defpaper
\@defpapertrue
\DeclareOption{a4paper}{
\PassOptionsToClass{\CurrentOption}{\superclass}
\PassOptionsToPackage{\CurrentOption}{hyperref}
\@defpaperfalse}
\DeclareOption{letterpaper}{
\PassOptionsToClass{\CurrentOption}{\superclass}
\PassOptionsToPackage{\CurrentOption}{hyperref}
\@defpaperfalse}
\newif\if@palatino
\@palatinotrue
\DeclareOption{palatino}{\@palatinotrue}
\DeclareOption{nopalatino}{\@palatinofalse}
\newif\if@ding
\@dingfalse
\DeclareOption{ding}{\@dingtrue}
\newif\if@euro
\@eurotrue
\DeclareOption{euro}{\@eurotrue}
\DeclareOption{noeuro}{\@eurofalse}
\newif\if@fancyref
\@fancyreftrue
\DeclareOption{fancyref}{\@fancyreftrue}
\DeclareOption{nofancyref}{\@fancyreffalse}
\newif\if@html
\@htmltrue
\DeclareOption{html}{\@htmltrue}
\DeclareOption{nohtml}{\@htmlfalse}
\newif\if@defsize
\@defsizetrue
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{\superclass}
\@defsizefalse}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{\superclass}
\@defsizefalse}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{\superclass}
\@defsizefalse}
\DeclareOption*{\ClassWarning{\thisclass}%
   {Unknown Option: `\CurrentOption '}%
}
\newcommand{\defaulttitle}{}
\newcommand{\defaultauthor}{}
\newcommand{\defaultaddress}{}
\newcommand{\defaultemail}{}
\newcommand{\defaulthomepage}{}
\newcommand{\currenttitle}{\defaulttitle}
\newcommand{\currentauthor}{\defaultauthor}
\newcommand{\autdiv}{\\[-0.4ex]\normalfont\Large}
\newcommand{\autinfodiv}{\\[-1ex]\normalfont\normalsize}
\ProcessOptions\relax
\PassOptionsToClass{wlocfield}{\superclass}
\if@defsize
  \PassOptionsToClass{12pt}{\superclass}
\fi
\if@deflang
  \PassOptionsToPackage{english}{babel}
\fi
\if@defpaper
  \PassOptionsToPackage{a4paper}{hyperref}
\fi
\LoadClass{\superclass}
\sloppy
\clubpenalty9999
\@clubpenalty\clubpenalty
\widowpenalty9999
\displaywidowpenalty1000
\brokenpenalty1000
\frenchspacing
\RequirePackage[T1]{fontenc}
\RequirePackage[latin1]{inputenc}
\RequirePackage{ifthen}
\RequirePackage{babel}
\RequirePackage{xspace}
\InputIfFileExists{hc.cfg}{%
  \ClassInfo{\thisclass}
    {Loading configuration file hc.cfg}}{%
  \ClassInfo{\thisclass}
    {Configuration file hc.cfg not found}}
\InputIfFileExists{\thisclass.cfg}{%
  \ClassInfo{\thisclass}
    {Loading configuration file \thisclass.cfg}}{%
  \ClassInfo{\thisclass}
    {Configuration file \thisclass.cfg not found}}
\newcommand{\nextstartq}{`}
\newcommand{\nextendq}{'}
\newcommand{\otherstartq}{``}
\newcommand{\otherendq}{''}
\newcommand{\tmpq}{}
\newcommand{\q}[1]{\nextstartq{}%
  \let\tmpq\nextstartq%
  \let\nextstartq\otherstartq%
  \let\otherstartq\tmpq%
  \let\tmpq\nextendq%
  \let\nextendq\otherendq%
  \let\otherendq\tmpq%
  #1%
  \let\tmpq\nextstartq%
  \let\nextstartq\otherstartq%
  \let\otherstartq\tmpq%
  \let\tmpq\nextendq%
  \let\nextendq\otherendq%
  \let\otherendq\tmpq%
  \nextendq{}%
}
\newcommand{\hq}[1]{``#1''}
\newcommand{\fq}[1]{`#1'}
\newcommand{\dash}[1]{---#1---}
\newenvironment{flexlist}[2][:]
    {\begin{list}{}
      {\settowidth{\labelwidth}{\sffamily\bfseries #2#1 }
       \setlength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \renewcommand{\makelabel}[1]
         {\sffamily\bfseries ##1#1 \hfill}}}
    {\end{list}}
\newenvironment{widedesc}[1][:]
  {\begin{flexlist}[#1]{00.00.0000}}
  {\end{flexlist}}
\newcommand{\pcent}[1]{#1\,\%}
\newcommand{\qdots}{\mbox{[\dots]}\xspace}
\newcommand{\phyp}[1]
  {(#1\textormath{\leavevmode\hbox{-}}{-})\hskip\z@skip}
\newcommand{\arrow}{\ensuremath{\rightarrow}\xspace}
\newcommand{\f}{\,f}
\newcommand{\ff}{\,ff}
\newcommand{\distance}{\par\bigskip\noindent}
\newcommand{\stardistance}
  {\par\bigskip{\centering *~~~*~~~*\par}\bigskip\noindent}
\newcommand{\linedistance}{%
  \begin{center}
  \begin{tabular}{p{0.33\textwidth}}
  \hrule
  \end{tabular}
  \end{center}
  \medskip\noindent%
}
\newcommand{\sig}[1]{\par{\raggedleft\emph{#1}\par}}
\newcommand{\intro}[1]{{\par\centering\textbf{#1}\par}
  \medskip\noindent\ignorespaces}
\newcommand{\hint}[1]{{\par\centering\LARGE #1\par}
  \noindent\ignorespaces}
\newcommand{\cen}[1]
  {{\par\centering #1\par}\noindent\ignorespaces}
\newcommand{\marginbox}[1]%
  {\par\small\addvspace{4.5ex plus 1ex}%
   \vskip -\parskip
   \noindent\hspace{-.75\leftmargini}%
   \begin{tabular}{|l|}\hline\ignorespaces
   #1
   \\\hline\end{tabular}\nobreak\par\nobreak
   \vspace{2.3ex}\vskip -\parskip\noindent\ignorespaces}
\newcommand{\rightaddress}[1]{%
  \par\medskip
  {\raggedleft \begin{tabular}{l}\ignorespaces
  #1
  \end{tabular}
  \medskip\par}\noindent\ignorespaces%
}
\newcounter{shortyear}
\setcounter{shortyear}{\the\year}
\addtocounter{shortyear}{-1900}
\whiledo{\theshortyear>99}{\addtocounter{shortyear}{-100}}
\newcommand{\shorttoday}
  {\two@digits{\theshortyear}/\the\month/\the\day\xspace}
\newenvironment{dialog}
  {\begin{flexlist}[\normalfont\emph{:}]{i}
     \setlength{\itemsep}{0ex}}
  {\end{flexlist}}
\makeatletter
\newcommand{\newspeaker}[2]{\newcommand{#1}[2][]
  {\item[\normalfont\emph{#2\ifthenelse{\equal{##1}{}}
     {}{ (##1)}}] ##2}}
\newcommand{\enge}[2]{#1}
\newcommand{\versiontext}{Version date:}
\newcommand{\onlinetext}{Online:}
\newcommand{\accesstext}{Access date:}
\newcommand{\cftext}{cf.}
\newcommand{\bibvoltext}{of}
\newcommand{\bvtext}{vol.}
\newcommand{\bibdir}{Director }
\newcommand{\bibmovtext}{Movie}
\newcommand{\bibactorsbefore}{With}
\newcommand{\bibactorsafter}{et~al}
\newcommand{\noyear}{n.d.}
\newcommand{\noaddress}{n.p.}
\newcommand{\otherabstractname}{Zusammenfassung}
\newcommand{\keywordsname}{Keywords}
\if@palatino
  \RequirePackage{palatino}
  \RequirePackage{mathpple}
\fi
\if@ding
   \RequirePackage{pifont}
   \newcommand{\tick}{\ding{52}}
   \newcommand{\cross}{\ding{56}}
   \newcommand{\checkbox}{\ding{114}}
   \newenvironment{ticklist}
    {\begin{dinglist}{52}}{\end{dinglist}}
   \newenvironment{crosslist}
    {\begin{dinglist}{56}}{\end{dinglist}}
   \newenvironment{checklist}
    {\begin{dinglist}{114}}{\end{dinglist}}
\fi
\if@euro
   \RequirePackage[right,notextcomp]{eurofont}
   \newcommand{\E}{\textsf{\makefakelighteuro}\xspace}
   \newcommand{\Es}[1]{\E\nobreak\,#1}
\fi
\if@fancyref
  \RequirePackage{fancyref}
\fi
\newcommand{\seetext}{see}
\newcommand{\see}[1]{\footnote{\seetext\ \fref{#1}}}
\if@html
  \newcounter{part}
  \newcounter{section}
  \newcounter{subsection}
  \newcounter{subsubsection}
  \newcounter{paragraph}
  \newcommand{\part}{}
  \newcommand{\section}{}
  \newcommand{\subsection}{}
  \newcommand{\subsubsection}{}
  \newcommand{\paragraph}{}
  \newcommand{\subparagraph}{}
  \RequirePackage{html}
  \newcommand{\htlink}[2]
    {{\htmladdnormallink{#1 \texttt{<#2>}}{#2}}}
  \newcommand{\hturl}[1]
    {{\htmladdnormallink{\texttt{#1}}{#1}}}
  \newcommand{\htmail}[1]
    {{\htmladdnormallink{\texttt{#1}}{mailto:#1}}}
\fi
\newcommand{\bibliostyle}{hc-en}
\foldmarksoff
\endinput
%%
%% End of file `hcletter.cls'.
