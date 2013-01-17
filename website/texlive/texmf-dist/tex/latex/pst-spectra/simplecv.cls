%%
%% This is file `simplecv.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% simplecv.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2007 by Jean-Marc Lasgouttes <Jean-Marc.Lasgouttes@inria.fr>
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{simplecv}
    [2007/04/22 v1.6 simple curriculum vitae]


\newcommand{\sectionfont}[1]{\def\cv@sec@fnt{#1}}
\newcommand{\subsectionfont}[1]{\def\cv@ssec@fnt{#1}}
\newcommand{\topiclabelfont}[1]{\def\cv@tlab@fnt{#1}}
\newcommand{\topictitlefont}[1]{\def\cv@ttit@fnt{#1}}
\newcommand{\headerfont}[1]{\def\cv@hd@fnt{#1}}
\newcommand{\titlefont}[1]{\def\cv@tit@fnt{#1}}
\let\itemfont=\topiclabelfont
\DeclareOption{sf}{
  \sectionfont{\sffamily\fontseries{sbc}\selectfont}
  \subsectionfont{\sffamily\fontseries{sbc}\selectfont}
  \topiclabelfont{\sffamily\slshape}
  \topictitlefont{\sffamily\slshape}
  \headerfont{\sffamily}
  \titlefont{\sffamily\fontseries{sbc}\selectfont\LARGE}
}
\DeclareOption{plain}{
  \sectionfont{\bfseries}
  \subsectionfont{\bfseries}
  \topiclabelfont{\itshape}
  \topictitlefont{\itshape}
  \headerfont{}
  \titlefont{\bfseries\LARGE}
}
\newif\if@cv@topic@title \@cv@topic@titlefalse
\DeclareOption{topictitle}{
  \@cv@topic@titletrue
}
\newif\if@cv@topic@break \@cv@topic@breaktrue
\DeclareOption{notopicbreak}{
  \@cv@topic@breakfalse
}
\newif\if@cv@cont@bib@num \@cv@cont@bib@numfalse
\DeclareOption{contbibnum}{
  \@cv@cont@bib@numtrue
  \newcounter{cv@save@bib@num}
}
\newif\if@cv@title@above \@cv@title@abovefalse
\DeclareOption{titleabove}{
  \@cv@title@abovetrue
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{sf,letterpaper,10pt,oneside,onecolumn,final}
\ProcessOptions
\LoadClass{article}
\newif\if@rl
\newcommand{\leftheader}[2][l]{\def\cv@lh@lr{#1}\def\cv@lh{#2}}
\newcommand{\rightheader}[2][l]{\def\cv@rh@lr{#1}\def\cv@rh{#2}}
\renewcommand{\title}[1]{\def\cv@tit{#1}}
\leftheader{}\rightheader{}\title{}
\newcommand{\cv@header}[2]{%
          \if@rl%
            \begin{tabular}[t]{@{\cv@hd@fnt\beginR}#1@{\endR}}%
          \else%
            \begin{tabular}[t]{@{\cv@hd@fnt}#1@{}}%
          \fi%
              #2%
          \end{tabular}}
\newcommand{\cv@do@title}{\par\bigskip
        \begin{center} \cv@tit@fnt\cv@tit\end{center}}
\renewcommand{\maketitle}{%
        \if@cv@title@above\cv@do@title\fi
        \par\noindent%
        \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}l@{}}
        \cv@header{\cv@lh@lr}{\cv@lh}&\cv@header{\cv@rh@lr}{\cv@rh}
        \end{tabular*}
        \par
        \if@cv@title@above\else\cv@do@title\fi
        \bigskip\par}
\renewcommand{\section}{
  \@startsection{section}{1}{\z@}
       {-3.5ex \@plus -1ex \@minus -.2ex}
       {2.3ex \@plus .2ex}{\cv@sec@fnt}}
\renewcommand{\subsection}{
  \@startsection{subsection}{1}{3em}
       {-3.5ex \@plus -1ex \@minus -.2ex}
       {2.3ex \@plus .2ex}{\cv@ssec@fnt}}
\let\subsubsection=\relax
\let\paragraph=\relax  \let\subparagraph=\relax
\setcounter{secnumdepth}{0}
\newcommand{\topicmargin}{0.20\columnwidth}
\newlength{\t@picmargin}
\newcommand{\@topic@makelabel}[1]{\cv@tlab@fnt #1\hfill}
\let\@topic@old@item=\@item
\newlength{\topic@label@length}
\def\@topic@item[#1]{%
        \@topic@old@item[#1]%
        \if@cv@topic@break%
                \settowidth{\topic@label@length}{#1}%
                \ifdim\topic@label@length>\labelwidth\mbox{}\\*\fi%
        \fi%
        \if@cv@topic@title%
          \mbox{}\cv@ttit@fnt%
          \everypar\expandafter{\the\everypar \normalfont}%
        \fi%
}
\newcommand{\@topic@setup}{%
        \setlength{\t@picmargin}{\topicmargin}
        \if@rl%
          \setlength{\leftmargin}{0cm}%
          \setlength{\rightmargin}{\t@picmargin}%
        \else%
          \setlength{\leftmargin}{\t@picmargin}%
          \setlength{\rightmargin}{0cm}%
        \fi%
        \setlength{\labelwidth}{0.8\t@picmargin}%
        \let\makelabel=\@topic@makelabel%
}
\newenvironment{topic}
        {\list{}
              {\@topic@setup%
               \let\@item=\@topic@item}}
        {\endlist}
\renewenvironment{thebibliography}[1]
 {\list{\@biblabel{\theenumiv}}{%
        \@topic@setup%
        \@openbib@code%
        \usecounter{enumiv}%
        \let\p@enumiv\@empty%
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
        \if@cv@cont@bib@num%
          \setcounter{enumiv}{\value{cv@save@bib@num}}%
        \fi%
  \sloppy \clubpenalty 4000 \widowpenalty 4000 \sfcode`\.=\@m}%
 {\endlist%
  \if@cv@cont@bib@num%
    \setcounter{cv@save@bib@num}{\value{enumiv}}%
  \fi}

\endinput
%%
%% End of file `simplecv.cls'.
