%%
%% This is file `papertex.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% papertex.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2010 by Ignacio Llopis <lloptor@gmail.com>
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
\ProvidesClass{papertex}
    [2010/06/30 v1.2b paperTeX class]
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{papertex}[2006/07/06 paperTeX class]
\RequirePackage{ifthen}
\newlength{\papertex@imgsize}
\newlength{\papertex@coltitsize}
\newlength{\papertex@pageneed}
\newlength{\papertex@pageleft}
\newlength{\papertex@indexwidth}
\newcommand{\papertex@ncolumns}{0}
\newlength{\columnlines}
\setlength{\columnlines}{0 pt} % no lines by default
\newboolean{papertex@hyphenatedtitles}
\setboolean{papertex@hyphenatedtitles}{true}
\newboolean{papertex@ninepoints}
\setboolean{papertex@ninepoints}{false}
\newboolean{papertex@showgrid}
\setboolean{papertex@showgrid}{false}
\newboolean{papertex@a3paper}
\setboolean{papertex@a3paper}{false}
\newboolean{papertex@insidefrontpage}
\setboolean{papertex@insidefrontpage}{false}
\newboolean{papertex@insideweather}
\setboolean{papertex@insideweather}{false}
\newboolean{papertex@insideindex}
\setboolean{papertex@insideindex}{false}
\newcount\papertex@gridrows
\newcount\papertex@gridcolumns
\papertex@gridrows=40
\papertex@gridcolumns=50
\newcount\minraggedcols
\minraggedcols=5
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}
\DeclareOption{twocolumn}%
{\ClassWarning{paperTeX}{Option 'twocolumn' not available for paperTeX.}}
\DeclareOption{notitlepage}%
{\ClassWarning{paperTeX}{Option 'notitlepage' not available for paperTeX.}}
\DeclareOption{twoside}%
{\ClassWarning{paperTeX}{Option 'twoside' not available for paperTeX.}}
\DeclareOption{9pt}{\setboolean{papertex@ninepoints}{true}}
\DeclareOption{hyphenatedtitles}{\setboolean{papertex@hyphenatedtitles}{false}}
\DeclareOption{columnlines}{\setlength{\columnlines}{0.1 pt}}
\DeclareOption{showgrid}{\setboolean{papertex@showgrid}{true}}
\DeclareOption{a3paper}{\setboolean{papertex@a3paper}{true}}
\ProcessOptions\relax
\LoadClass[10pt, onecolumn, titlepage, a4paper]{article}
\RequirePackage{ifpdf}
\RequirePackage{multido}
\RequirePackage{datetime}
\RequirePackage{multicol}
\RequirePackage{fancyhdr}
\RequirePackage{fancybox}
\ifthenelse{\boolean{papertex@a3paper}}{%
\RequirePackage[a3paper,headsep=0.5cm,vmargin={2cm,2cm},hmargin={1.5cm,1.5cm}]{geometry}
}{
\RequirePackage[headsep=0.5cm,vmargin={2cm,2cm},hmargin={1.5cm,1.5cm}]{geometry}
}
\ifpdf
\RequirePackage[pdftex]{graphicx,color}
  \RequirePackage[pdftex]{hyperref}
\else
\RequirePackage{color}
\RequirePackage[dvips]{graphicx}
\RequirePackage[dvips]{hyperref}
\fi
\RequirePackage[absolute]{textpos} % absoulte positioning
\RequirePackage{hyphenat} % when hyphenate
\RequirePackage{wrapfig}
\RequirePackage{lastpage} % to know the last page number
\RequirePackage{setspace} % set space between lines
\RequirePackage{ragged2e}
\newcommand{\raggedFormat}{\RaggedRight}
\AtEndOfClass{\papertexInit}
\ifthenelse{\boolean{papertex@showgrid}}{%
\AtBeginDocument{
\grid[show]{\papertex@gridrows}{\papertex@gridcolumns}}
\advance\minraggedcols by -1
}{%
\AtBeginDocument{
\grid[]{\papertex@gridrows}{\papertex@gridcolumns}}
\advance\minraggedcols by -1
}
\ifthenelse{\boolean{papertex@ninepoints}}{
\renewcommand{\normalsize}{%
  \@setfontsize{\normalsize}{9pt}{10pt}%
  \setlength{\abovedisplayskip}{5pt plus 1pt minus .5pt}%
  \setlength{\belowdisplayskip}{\abovedisplayskip}%
  \setlength{\abovedisplayshortskip}{3pt plus 1pt minus 2pt}%
  \setlength{\belowdisplayshortskip}{\abovedisplayshortskip}}

\renewcommand{\tiny}{\@setfontsize{\tiny}{5pt}{6pt}}

\renewcommand{\scriptsize}{\@setfontsize{\scriptsize}{7pt}{8pt}}

\renewcommand{\small}{%
  \@setfontsize{\small}{8pt}{9pt}%
  \setlength{\abovedisplayskip}{4pt plus 1pt minus 1pt}%
  \setlength{\belowdisplayskip}{\abovedisplayskip}%
  \setlength{\abovedisplayshortskip}{2pt plus 1pt}%
  \setlength{\belowdisplayshortskip}{\abovedisplayshortskip}}

\renewcommand{\footnotesize}{%
  \@setfontsize{\footnotesize}{8pt}{9pt}%
  \setlength{\abovedisplayskip}{4pt plus 1pt minus .5pt}%
  \setlength{\belowdisplayskip}{\abovedisplayskip}%
  \setlength{\abovedisplayshortskip}{2pt plus 1pt}%
  \setlength{\belowdisplayshortskip}{\abovedisplayshortskip}}

\renewcommand{\large}{\@setfontsize{\large}{11pt}{13pt}}
\renewcommand{\Large}{\@setfontsize{\Large}{14pt}{18pt}}
\renewcommand{\LARGE}{\@setfontsize{\LARGE}{18pt}{20pt}}
\renewcommand{\huge}{\@setfontsize{\huge}{20pt}{25pt}}
\renewcommand{\Huge}{\@setfontsize{\Huge}{25pt}{30pt}}
}{}
\definecolor{color}{cmyk}{0.5, 0, 1, 0.5}
\definecolor{max}{cmyk}{0, 0.5, 0.5, 0.5}
\definecolor{min}{cmyk}{0.5, 0, 0.5, 0.5}
\newcommand{\papertex@wwwTxt}{http://nachollopis.com}
\newcommand{\papertex@wwwFormat}{\sffamily}
\newcommand{\papertex@www}{%
\raisebox{-3pt}{{\papertex@wwwFormat\papertex@wwwTxt}}
}
\newcommand{\papertex@edition}{MY EDITION}
\newcommand{\editionFormat}{\large\bfseries\texttt}
\newcommand{\papertex@editionLogo}{%
\raisebox{-3pt}{%
\textcolor{color}{{\editionFormat\papertex@edition}}%
}%
}
\newcommand{\indexFormat}{\large\bfseries\sffamily}
\newcommand{\papertex@indexFrameTitle}[1]
{\begin{flushright}{\textcolor{color}{{\indexFormat #1}}}\end{flushright}}

\newcommand{\indexEntryFormat}{\large\sffamily}
\newcommand{\papertex@indexEntry}[1]{\begin{minipage}{13\TPHorizModule}%
{\indexEntryFormat\noindent\ignorespaces{#1}}%
\end{minipage}}
\newcommand{\indexEntrySeparator}{\rule{\papertex@indexwidth}{.1pt}}
\newcommand{\indexEntryPageTxt}{p.}
\newcommand{\indexEntryPageFormat}{\footnotesize}
\newcommand{\papertex@indexEntryPage}[1]{%
{\indexEntryPageFormat\textcolor{color}{\indexEntryPageTxt{}~#1}}%
}
\newcommand{\headDateTimeFormat}{}
\newcommand{\papertex@headDateTime}{%
\headDateTimeFormat\date\hspace{5pt}$\parallel$\hspace{5pt}%
\textcolor{color}{\currenttime h}%
}
\newcommand{\weatherFormat}{\bfseries\sffamily}
\newcommand{\papertex@weather}[1]{%
\noindent\textcolor{color}{{\weatherFormat #1}}%
}
\newcommand{\weatherTempFormat}{\small}
\newcommand{\weatherUnits}{\textdegree{}C}
\newcommand{\papertex@section}[0]{FRONT PAGE}
\newcommand{\papertex@headleft}{%
{{\usefont{T1}{bch}{b}{n} \noindent\textcolor{color}{paper}}%
{\usefont{T1}{pag}{m}{n} \textcolor{black}{TeX}} , \date}%
}
\newcommand{\papertex@headcenter}{%
\papertex@section{}
}
\newcommand{\papertex@headright}{%
\textcolor{color}{\small\papertex@edition}%
\hspace*{5pt}\thepage\ / \pageref{LastPage}
}

\newcommand{\heading}[3]{%
\renewcommand{\papertex@headleft}{#1}%
\renewcommand{\papertex@headcenter}{#2}%
\renewcommand{\papertex@headright}{#3}%
}
\newcommand{\papertex@footleft}{%
{\footnotesize\copyright\ \papertex@wwwTxt{} - Created using paper\TeX{}}%
}
\newcommand{\papertex@footcenter}{%
}
\newcommand{\papertex@footright}{%
}

\newcommand{\foot}[3]{%
\renewcommand{\papertex@footleft}{#1}%
\renewcommand{\papertex@footcenter}{#2}%
\renewcommand{\papertex@footright}{#3}%
}
\newcommand{\firstTitleFormat}{\Huge\sffamily\bfseries\flushleft}
\newcommand{\papertex@firstTitle}[1]{%
{%
\begin{spacing}{2.0}{%
\noindent\ignorespaces
\ifthenelse{\boolean{papertex@hyphenatedtitles}}%
{\nohyphens{\firstTitleFormat #1}}%
{{\firstTitleFormat #1}}%
}%
\end{spacing}%
}%
}
\newcommand{\firstTextFormat}{}
\newcommand{\papertex@firstText}[1]{%
{\noindent\ignorespaces\firstTextFormat #1}%
}
\newcommand{\secondTitleFormat}{\LARGE\sffamily\bfseries}
\newcommand{\papertex@secondTitle}[1]{%
\begin{spacing}{1.5}{%
\noindent\ignorespaces\flushleft
\ifthenelse{\boolean{papertex@hyphenatedtitles}}%
{\nohyphens{\secondTitleFormat #1}}%
{{\secondTitleFormat #1}}%
}\end{spacing}%
}
\newcommand{\secondSubtitleFormat}{\large}
\newcommand{\papertex@secondSubtitle}[1]{%
{\noindent\ignorespaces{\secondSubtitleFormat #1}}%
}
\newcommand{\secondTextFormat}{}
\newcommand{\papertex@secondText}[1]{%
\begin{multicols}{2}
{\noindent\ignorespaces\secondTextFormat #1}
\end{multicols}
}
\newcommand{\thirdTitleFormat}{\Large\sffamily\bfseries}
\newcommand{\papertex@thirdTitle}[1]{%
\begin{spacing}{1.5}{%
\noindent\ignorespaces\flushleft
\ifthenelse{\boolean{papertex@hyphenatedtitles}}%
{\nohyphens{\thirdTitleFormat #1}}%
{{\thirdTitleFormat #1}}%
}\end{spacing}%
}
\newcommand{\thirdSubtitleFormat}{\large}
\newcommand{\papertex@thirdSubtitle}[1]%
{{\noindent\ignorespaces\thirdSubtitleFormat #1}}
\newcommand{\thirdTextFormat}{}
\newcommand{\papertex@thirdText}[1]{{\thirdTextFormat #1}}
\newcommand{\pictureCaptionFormat}{\small\bfseries}
\newcommand{\papertex@pictureCaption}[1]{%
{\noindent\pictureCaptionFormat #1}%
}
\newcommand{\pagesFormat}{\bfseries\footnotesize}
\newcommand{\papertex@pages}[1]%
{\noindent\textcolor{color}{\pagesFormat\MakeUppercase{#1}}}
\newcommand{\innerTitleFormat}{\Huge}
\newcommand{\papertex@innerTitle}[1]{%
\begin{flushleft}{%
\noindent
\ifthenelse{\boolean{papertex@hyphenatedtitles}}%
{\nohyphens{\innerTitleFormat #1}}%
{{\innerTitleFormat #1}}%
}%
\\%
\end{flushleft}%
}
\newcommand{\innerSubtitleFormat}{\large}
\newcommand{\papertex@innerSubtitle}[1]{{\innerSubtitleFormat #1}}
\newcommand{\timestampTxt}{h}
\newcommand{\timestampSeparator}{|}
\newcommand{\timestampFormat}{\small}
\newcommand{\timestamp}[1]{%
{\timestampFormat\textcolor{color}{%
#1~\timestampTxt{}}%
}~\timestampSeparator{}%
}
\newcommand{\innerAuthorFormat}{\footnotesize}
\newcommand{\innerPlaceFormat}{\footnotesize\bfseries}
\newcommand{\innerTextFinalMark}{\rule{0.65em}{0.65em}}
\newcommand{\editorialTitleFormat}{\LARGE\textit}
\newcommand{\papertex@editorialTitle}[1]{\editorialTitleFormat{#1}}
\newcommand{\editorialAuthorFormat}{\textsc}
\newcommand{\shortnewsTitleFormat}{\LARGE\bfseries}
\newcommand{\papertex@shortnewsTitle}[1]{{\shortnewsTitleFormat #1}}
\newcommand{\shortnewsSubtitleFormat}{\Large}
\newcommand{\papertex@shortnewsSubtitle}[1]{{\shortnewsSubtitleFormat #1}}
\newcommand{\shortnewsItemTitleFormat}{\large\bfseries}
\newcommand{\papertex@shortnewsItemTitle}[1]{{\shortnewsItemTitleFormat #1}}
\renewcommand{\maketitle}{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {\LARGE \@title \par}%
    \vskip 1em%
    {\LARGE ``\papertex@edition '' \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\newcommand{\papertex@say}[1]{\typeout{#1}}
\newsavebox{\papertex@fmbox}
\newenvironment{papertex@fmpage}[1]
 {\begin{lrbox}{\papertex@fmbox}\begin{minipage}{#1}}
 {\end{minipage}\end{lrbox}\fbox{\usebox{\papertex@fmbox}}}
\newcommand{\image}[2]{
\setlength{\papertex@imgsize}{0pt}
\vspace{5pt}
\setlength{\fboxsep}{1pt}
\addtolength{\papertex@imgsize}{\columnwidth}
\addtolength{\papertex@imgsize}{-1\columnsep}
\ifpdf
\setlength{\papertex@pageneed}{1.5\papertex@imgsize}
\addtolength{\papertex@pageneed}{50pt}
\ClassWarning{paperTeX}{%
Image #1 needs: \the\papertex@pageneed \space %
and there is left: \the\page@free\space%
}
\ifdim \papertex@pageneed < \page@free

{\centering\fbox{%
\includegraphics[width = \papertex@imgsize,
height = \papertex@imgsize,
keepaspectratio ]{#1}}}
\papertex@pictureCaption{#2}

\vspace{5pt}
\else
\ClassWarning{Image #1 needs more space!%
  It was not inserted!}
\fi
\fi
}
\textblockorigin{1cm}{1cm}
\newdimen\papertex@dx
\newdimen\papertex@dy
\newcount\papertex@cx
\newcount\papertex@cy
\newcommand{\grid}[3][]{
\papertex@dx=\textwidth%
\papertex@dy=\textheight%
\papertex@cx=#3% %columns
\papertex@cy=#2% %rows

\count1=#3%
\advance\count1 by 1

\count2=#2%
\advance\count2 by 1

\divide\papertex@dx by #3
\divide\papertex@dy by #2

\setlength{\TPHorizModule}{\papertex@dx}
\setlength{\TPVertModule}{\papertex@dy}

\ifthenelse{\equal{#1}{show}}{
\multido{\papertex@nrow=0+1}{\count2}{
\begin{textblock}{\papertex@cx}(0,\papertex@nrow)
\rule[0pt]{\textwidth}{.1pt}
\end{textblock}
}

\multido{\papertex@ncol=0+1}{\count1}{
\begin{textblock}{\papertex@cy}(\papertex@ncol,0)
\rule[0pt]{.1pt}{\textheight}
\end{textblock}
}
}{}
}
\newcommand{\papertexInit}{
\setlength{\headheight}{14pt}
\renewcommand{\headrulewidth}{0.4pt}

\pagestyle{fancy}

\setlength{\columnseprule}{\columnlines}
\setlength{\fboxrule}{0.1 pt}

}
\newcommand{\logo}[0]{
%% Heading %%
\noindent\hrulefill\hspace{10pt}\papertex@editionLogo\hspace{5pt}\papertex@www

\vspace*{-3pt}

{\fontsize{10mm}{12mm} \usefont{T1}{bch}{b}{n} \noindent\textcolor{color}{\sffamily paper}}%
{\fontsize{12mm}{14mm} \usefont{T1}{pag}{m}{n} \textcolor{black}{TeX}}
\hrulefill
\hspace{10pt}\papertex@headDateTime

}
\newcommand{\minilogo}[0]{
{\fontsize{4mm}{6mm} \usefont{T1}{bch}{b}{n} \noindent\textcolor{color}{\sffamily paper}}%
{\fontsize{7mm}{12mm} \usefont{T1}{pag}{m}{n} \textcolor{black}{TeX}}

\vspace*{5pt}
}
\newcommand{\mylogo}[1]{
{#1}

\noindent
\papertex@editionLogo\hspace{5pt}
\hrulefill
\hspace{5pt}\papertex@headDateTime
}
\newcommand{\edition}[1]{\renewcommand{\papertex@edition}{#1}}
\newenvironment{frontpage}[0]
{
\setboolean{papertex@insidefrontpage}{true}
\thispagestyle{empty}
\pdfbookmark[1]{FRONT PAGE}{\thepage}
\logo

}%
{
\thispagestyle{empty}
\clearpage
\newpage

\fancyhead{}
\fancyfoot{}
\fancyhead[R]{\papertex@headright}
\fancyhead[L]{\papertex@headleft}
    \fancyhead[C]{\papertex@headcenter}
    \fancyfoot[R]{\papertex@footright}
    \fancyfoot[L]{\papertex@footleft}
\fancyfoot[C]{\papertex@footcenter}
\renewcommand{\headrulewidth}{0.4pt}
\setboolean{papertex@insidefrontpage}{false}

}
\newcommand{\firstnews}[3]
{
\ifthenelse{\boolean{papertex@insidefrontpage}}{%
\ifthenelse{\boolean{papertex@hyphenatedtitles}}{%
\begin{textblock}{24}(22,5)
}
{
\begin{textblock}{28}(22,5)
}
\vspace{-7pt}
\papertex@firstTitle{#1}
\end{textblock}
\begin{textblock}{29}(22,10)
\vspace{5pt plus 2pt minus 2pt}

\papertex@firstText{\timestamp{#3}~#2}

\end{textblock}

\begin{textblock}{50}(0,15)
\rule{50\TPHorizModule}{.3pt}
\end{textblock}
}{%else
\ClassError{paperTeX}{%
\protect\firstnews\space in a wrong place.\MessageBreak
\protect\firstnews\space may only appear inside frontpage environment.
}{%
\protect\firstnews\space may only appear inside frontpage environment.
}%
}
}
\newcommand{\secondnews}[5]
{
\ifthenelse{\boolean{papertex@insidefrontpage}}{%
\begin{textblock}{33}(2,16)
\papertex@pages{#4}
\vspace{-5pt}
\papertex@secondTitle{#1}

\vspace*{5pt}

\papertex@secondSubtitle{#2}

\vspace*{-7pt}

\papertex@secondText{\timestamp{#5}~#3}

\end{textblock}

\begin{textblock}{33}(2,25)
\vspace{5pt plus 2pt minus 2pt}

\noindent\ignorespaces\rule{33\TPHorizModule}{.3pt}
\end{textblock}
}{%else
\ClassError{paperTeX}{%
\protect\secondnews\space in a wrong place.\MessageBreak
\protect\secondnews\space may only appear inside frontpage environment.
}{%
\protect\secondnews\space may only appear inside frontpage environment.
}%
}
}
\newcommand{\thirdnews}[6]
{
\ifthenelse{\boolean{papertex@insidefrontpage}}{%
\begin{textblock}{32}(2,26)
\papertex@pages{#5}
\vspace{-5pt}
\setlength{\fboxsep}{1pt}
\papertex@thirdTitle{#1}

\vspace*{5pt}

\papertex@thirdSubtitle{#2}

\vspace*{5pt}

{\noindent\ignorespaces %
\ifthenelse{\equal{#4}{}}{}
{\begin{wrapfigure}{r}{.3\textwidth}
\vspace*{-12pt}
\ifpdf
\noindent\fbox{\includegraphics[width=.3\textwidth]{#4}}
\fi
\end{wrapfigure}%
}%
\papertex@thirdText{\timestamp{#6}~#3}

}

\vspace*{5pt}

\end{textblock}
}{%else
\ClassError{paperTeX}{%
\protect\thirdnews\space in a wrong place.\MessageBreak
\protect\thirdnews\space may only appear inside frontpage environment.
}{%
\protect\thirdnews\space may only appear inside frontpage environment.
}%
}
}
\newcommand{\firstimage}[2]
{
\ifthenelse{\boolean{papertex@insidefrontpage}}{%
\begin{textblock}{18}(2,5)
\setlength{\fboxsep}{1pt}
\ifpdf % only in PDF
\noindent\fbox{\includegraphics[width = 18\TPHorizModule ]{#1}}
\fi

\papertex@pictureCaption{#2}
\end{textblock}%
}
{\ClassError{paperTeX}{%
\protect\firstimage\space in a wrong place.\MessageBreak
\protect\firstimage\space may only appear inside frontpage environment.
}{%
\protect\firstimage\space may only appear inside frontpage environment.
}}
}%
\newcommand{\weatheritem}[5]{%
\ifthenelse{\boolean{papertex@insideweather}}{
\begin{minipage}{45pt}
\ifpdf
\includegraphics[width=40pt]{#1}
\fi
\end{minipage}
\begin{minipage}{50pt}
\weatherTempFormat
#2\\
\textcolor{min}{#3} $\|$ \textcolor{max}{#4} \weatherUnits{}\\
#5
\end{minipage}
}{%else
\ClassError{paperTeX}{%
\protect\weatheritem\space in a wrong place.\MessageBreak
\protect\weatheritem\space may only appear inside weatherblock environment.
}{%
\protect\weatheritem\space may only appear inside weatherblock environment.\MessageBreak
weatherblock environment may only appear inside frontpage environment.
}%
}
}
\newenvironment{weatherblock}[1]
{
\ifthenelse{\boolean{papertex@insidefrontpage}}{%
\setboolean{papertex@insideweather}{true}
\begin{textblock}{32}(2,38)
\vspace*{-15pt}

\hfill\papertex@weather{#1}

\vspace*{5pt}

\noindent\begin{papertex@fmpage}{32\TPHorizModule}
\begin{minipage}{32\TPHorizModule}
\hspace{5pt}

}{%
\ClassError{paperTeX}{%
weatherblock in a wrong place.\MessageBreak
weatherblock may only appear inside frontpage environment.
}{%
weatherblock may only appear inside frontpage environment.
}
}
}%
{
\end{minipage}
\end{papertex@fmpage}
\end{textblock}
\setboolean{papertex@insideweather}{false}
}
\newenvironment{authorblock}[0]
{
\ifthenelse{\boolean{papertex@insidefrontpage}}{%
\begin{textblock}{15}(36,35)
\setlength{\fboxsep}{5pt}
\begin{papertex@fmpage}{13\TPHorizModule}
\begin{minipage}{13\TPHorizModule}
\centering
\minilogo

}{%else
\ClassError{paperTeX}{%
authorblock in a wrong place.\MessageBreak
authorblock may only appear inside frontpage environment.
}{%
authorblock may only appear inside frontpage environment.
}
}
}
{
\end{minipage}
\end{papertex@fmpage}
\end{textblock}
}
\newenvironment{indexblock}[1]
{
\ifthenelse{\boolean{papertex@insidefrontpage}}{%
\setboolean{papertex@insideindex}{true}%let's in
\begin{textblock}{15}(36,16)
\setlength{\papertex@indexwidth}{13\TPHorizModule}
\papertex@indexFrameTitle{#1}

\setlength{\fboxsep}{5pt} %espacio entre el frame y la imagen
\begin{papertex@fmpage}{\papertex@indexwidth}
\begin{minipage}{\papertex@indexwidth}
\vspace*{10pt}
}{%else
\ClassError{paperTeX}{%
indexblock in a wrong place.\MessageBreak
indexblock may only appear inside frontpage environment.
}{%
indexblock may only appear inside frontpage environment.
}
}
}%
{
\end{minipage}
\end{papertex@fmpage}
\end{textblock}
\setboolean{papertex@insideindex}{false}%let's out
}
\newcommand{\indexitem}[2]
{
\ifthenelse{\boolean{papertex@insideindex}}{
\papertex@indexEntry{#1~\papertex@indexEntryPage{\pageref{#2}}}

\vspace{0.5cm}

\noindent\ignorespaces\indexEntrySeparator{}
}{%else
\ClassError{paperTeX}{%
\protect\indexitem\space in a wrong place.\MessageBreak
\protect\indexitem\space may only appear inside indexblock environment.
}{%
\protect\indexitem\space may only appear inside indexblock environment.\MessageBreak
indexblock environment may only appear inside frontpage environment.
}%
}
}
\newcommand{\papertex@inexpandedtitle}[1]{
\begin{minipage}{.95\textwidth}
\begin{center}
\noindent\Large\textbf{#1}
\end{center}
\end{minipage}
}

\newcommand{\expandedtitle}[2]{
\end{multicols}

\begin{center}
\setlength{\fboxsep}{5pt}
\setlength{\shadowsize}{2pt}
\ifthenelse{\equal{#1}{shadowbox}}{%
\shadowbox{%
\papertex@inexpandedtitle{#2}%
}%
}{}
\ifthenelse{\equal{#1}{doublebox}}{%
\doublebox{%
\papertex@inexpandedtitle{#2}%
}%
}{}
\ifthenelse{\equal{#1}{ovalbox}}{%
\ovalbox{%
\papertex@inexpandedtitle{#2}%
}%
}{}
\ifthenelse{\equal{#1}{Ovalbox}}{%
\Ovalbox{%
\papertex@inexpandedtitle{#2}%
}%
}{}
\ifthenelse{\equal{#1}{lines}}{
\hrule
\vspace*{8pt}
\begin{center}
\noindent\Large\textbf{#2}
\end{center}
\vspace*{8pt}
\hrule
}{}
\end{center}

\begin{multicols}{\papertex@ncolumns{}}
\ifnum \papertex@ncolumns > \minraggedcols
\raggedFormat
\fi
}
\newcommand{\papertex@incolumntitle}[2]{
\begin{minipage}{#1}
\begin{center}
\noindent\normalsize\textbf{#2}
\end{center}
\end{minipage}
}

\newcommand{\columntitle}[2]{
\vspace*{5pt}
\begin{center}
\setlength{\fboxsep}{5pt}
\setlength{\shadowsize}{2pt}
\addtolength{\papertex@coltitsize}{\columnwidth}
\addtolength{\papertex@coltitsize}{-1\columnsep}
\addtolength{\papertex@coltitsize}{-5pt}
\addtolength{\papertex@coltitsize}{-1\shadowsize}
\ifthenelse{\equal{#1}{shadowbox}}{%
\shadowbox{%
\papertex@incolumntitle{\papertex@coltitsize}{#2}%
}%
}{}
\ifthenelse{\equal{#1}{doublebox}}{%
\doublebox{%
\papertex@incolumntitle{\papertex@coltitsize}{#2}%
}%
}{}
\ifthenelse{\equal{#1}{ovalbox}}{%
\ovalbox{%
\papertex@incolumntitle{\papertex@coltitsize}{#2}%
}%
}{}
\ifthenelse{\equal{#1}{Ovalbox}}{%
\Ovalbox{%
\papertex@incolumntitle{\papertex@coltitsize}{#2}%
}%
}{}
\ifthenelse{\equal{#1}{lines}}{
\hrule
\vspace*{5pt}
\begin{center}
\noindent\normalsize\textbf{#2}
\end{center}
\vspace*{5pt}
\hrule
}{}
\end{center}
}
\renewcommand{\date}{%
\longdate{\today}%
}
\newcommand{\authorandplace}[2]{%
\leftline{%
{\innerAuthorFormat #1},\space{}{\innerPlaceFormat #2}%
}%
\par %
}
\newcommand{\newsection}[1]{
\pdfbookmark[0]{#1}{\thepage} %bookmark para el pdf
\renewcommand{\papertex@section}{#1}
}
\newenvironment{news}[5]
{
\papertex@say{Adding a new piece of news}
\renewcommand{\papertex@ncolumns}{#1}
\begin{multicols}{#1}[%
\papertex@pages{#4}
\papertex@innerTitle{#2}%
\papertex@innerSubtitle{#3}%
][4cm]%
\phantomsection
\pdfbookmark[1]{#2}{\thepage}
\label{#5}
\ifnum #1 > \minraggedcols
\raggedFormat
\fi
}
{~\innerTextFinalMark{}
\end{multicols}
}
\newcommand{\newssep}{%
\setlength{\papertex@pageneed}{16000pt}
\setlength\papertex@pageleft{\pagegoal}
\addtolength\papertex@pageleft{-\pagetotal}

\papertex@say{How much left \the\papertex@pageleft}

\ifdim \papertex@pageneed < \papertex@pageleft
\papertex@say{Not enough space}
\else
\papertex@say{Adding sep line between news}
\vspace*{10pt plus 10pt minus 5pt}
\hrule
\vspace*{10pt plus 5pt minus 5pt}
\fi

}
\newcommand{\papertex@editorialTit}[2]{
\setlength{\arrayrulewidth}{.1pt}
\begin{center}
\begin{tabular}{c}
\noindent
\papertex@editorialTitle{#1}
\vspace{2pt plus 1pt minus 1pt}
\\
\hline
\vspace{2pt plus 1pt minus 1pt}
\\
\editorialAuthorFormat{#2}
\end{tabular}
\end{center}
}
\newenvironment{editorial}[4]
{
\papertex@say{Adding a new editorial}
\begin{multicols}{#1}[%
\papertex@editorialTit{#2}{#3}%
][4cm]
\phantomsection
\pdfbookmark[1]{#2}{\thepage}
\label{#4}
\ifnum #1 > \minraggedcols
\raggedFormat
\fi
}
{
\end{multicols}
}
\newcommand{\papertex@shortnewsTit}[2]{
\begin{center}
\vbox{%
\noindent
\papertex@shortnewsTitle{#1}
\vspace{4pt plus 2pt minus 2pt}
\hrule
\vspace{4pt plus 2pt minus 2pt}
\papertex@shortnewsSubtitle{#2}
}
\end{center}
}
\newenvironment{shortnews}[4]
{
\papertex@say{Adding a short news block}
\begin{multicols}{#1}[\papertex@shortnewsTit{#2}{#3}][4cm] %
\phantomsection
\pdfbookmark[1]{#2}{\thepage}
    \label{#4}
\par %
\ifnum #1 > \minraggedcols
\raggedFormat
\fi
}
{
\end{multicols}
}
\newcommand{\shortnewsitem}[2]{
\goodbreak
\vspace{5pt plus 3pt minus 3pt}
{\vbox{\noindent\papertex@shortnewsItemTitle{#1}}}
\vspace{5pt plus 3pt minus 3pt}
{\noindent #2}\\
}
\endinput
%%
%% End of file `papertex.cls'.
