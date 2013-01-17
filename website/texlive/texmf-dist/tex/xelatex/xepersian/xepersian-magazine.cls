%%
%% This is file `xepersian-magazine.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% xepersian.dtx  (with options: `xepersian-magazine.cls')
%% 
%%   ______________________________________
%%   Copyright © 2008–2012  Vafa Khalighi
%% 
%%   License information appended.
%% 
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{xepersian-magazine}[2010/07/25 v0.2 Typesetting Persian magazines in XeLaTeX]
\RequirePackage{ifthen}
\newlength{\xepersian@imgsize}
\newlength{\xepersian@coltitsize}
\newlength{\xepersian@pageneed}
\newlength{\xepersian@pageleft}
\newlength{\xepersian@indexwidth}
\newcommand{\xepersian@ncolumns}{0}
\newlength{\columnlines}
\setlength{\columnlines}{0 pt} % no lines by default
\newboolean{xepersian@hyphenatedtitles}
\setboolean{xepersian@hyphenatedtitles}{true}
\newboolean{xepersian@ninepoints}
\setboolean{xepersian@ninepoints}{false}
\newboolean{xepersian@showgrid}
\setboolean{xepersian@showgrid}{false}
\newboolean{xepersian@a3paper}
\setboolean{xepersian@a3paper}{false}
\newboolean{xepersian@insidefrontpage}
\setboolean{xepersian@insidefrontpage}{false}
\newboolean{xepersian@insideweather}
\setboolean{xepersian@insideweather}{false}
\newboolean{xepersian@insideindex}
\setboolean{xepersian@insideindex}{false}
\newcount\xepersian@gridrows
\newcount\xepersian@gridcolumns
\xepersian@gridrows=40
\xepersian@gridcolumns=50
\newcount\minraggedcols
\minraggedcols=5
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}
\DeclareOption{twocolumn}%
{\ClassWarning{xepersian-magazine}{Option 'twocolumn' not available for xepersian-magazine.}}
\DeclareOption{notitlepage}%
{\ClassWarning{xepersian-magazine}{Option 'notitlepage' not available for xepersian-magazine.}}
\DeclareOption{twoside}%
{\ClassWarning{xepersian-magazine}{Option 'twoside' not available for xepersian-magazine.}}
\DeclareOption{9pt}{\setboolean{xepersian@ninepoints}{true}}
\DeclareOption{hyphenatedtitles}{\setboolean{xepersian@hyphenatedtitles}{false}}
\DeclareOption{columnlines}{\setlength{\columnlines}{0.1 pt}}
\DeclareOption{showgrid}{\setboolean{xepersian@showgrid}{true}}
\DeclareOption{a3paper}{\setboolean{xepersian@a3paper}{true}}
\ProcessOptions\relax
\LoadClass[10pt, onecolumn, titlepage, a4paper]{article}
\RequirePackage{ifxetex}
\RequirePackage{multido}
\RequirePackage{datetime}
\RequirePackage{multicol}
\RequirePackage{fancyhdr}
\RequirePackage{fancybox}
\ifthenelse{\boolean{xepersian@a3paper}}{%
\RequirePackage[a3paper,headsep=0.5cm,vmargin={2cm,2cm},hmargin={1.5cm,1.5cm}]{geometry}
}{
\RequirePackage[headsep=0.5cm,vmargin={2cm,2cm},hmargin={1.5cm,1.5cm}]{geometry}
}
\RequirePackage[absolute]{textpos} % absoulte positioning
\RequirePackage{hyphenat} % when hyphenate
\RequirePackage{lastpage} % to know the last page number
\RequirePackage{setspace} % set space between lines
\RequirePackage{ragged2e}
\newcommand{\raggedFormat}{\RaggedLeft}
\AtEndOfClass{\xepersianInit}
\ifthenelse{\boolean{xepersian@showgrid}}{%
\AtBeginDocument{
\grid[show]{\xepersian@gridrows}{\xepersian@gridcolumns}}
\advance\minraggedcols by -1
}{%
\AtBeginDocument{
\grid[]{\xepersian@gridrows}{\xepersian@gridcolumns}}
\advance\minraggedcols by -1
}
\ifthenelse{\boolean{xepersian@ninepoints}}{
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
\def\customwwwTxt#1{\gdef\@customwwwTxt{\lr{#1}}}
\newcommand{\xepersian@wwwFormat}{\sffamily}
\newcommand{\xepersian@www}{%
\raisebox{-3pt}{{\xepersian@wwwFormat\@customwwwTxt}}
}
\newcommand{\xepersian@edition}{ویرایش من}
\newcommand{\editionFormat}{\large\bfseries\texttt}
\newcommand{\xepersian@editionLogo}{%
\raisebox{-3pt}{%
{\editionFormat\xepersian@edition}%
}%
}
\newcommand{\indexFormat}{\large\bfseries}
\newcommand{\xepersian@indexFrameTitle}[1]
{\begin{flushright}{{\indexFormat #1}}\end{flushright}}

\newcommand{\indexEntryFormat}{\normalsize}
\newcommand{\xepersian@indexEntry}[1]{\begin{minipage}{13\TPHorizModule}%
{\indexEntryFormat\noindent\ignorespaces{#1}}%
\end{minipage}}
\newcommand{\indexEntrySeparator}{\rule{\xepersian@indexwidth}{.1pt}}
\newcommand{\indexEntryPageTxt}{صفحهٔ}
\newcommand{\indexEntryPageFormat}{\footnotesize}
\newcommand{\xepersian@indexEntryPage}[1]{%
{\indexEntryPageFormat{\indexEntryPageTxt{}~#1}}%
}
\newcommand{\headDateTimeFormat}{}
\newcommand{\xepersian@headDateTime}{%
\headDateTimeFormat\date\hspace{5pt}$\parallel$\hspace{5pt}%
\currenttime %
}
\newcommand{\weatherFormat}{\bfseries}
\newcommand{\xepersian@weather}[1]{%
\noindent{\weatherFormat #1}%
}
\newcommand{\weatherTempFormat}{\small}
\newcommand{\weatherUnits}{\textdegree{}C}
\newcommand{\xepersian@section}[0]{صفحهٔ جلو}
\newcommand{\xepersian@headleft}{%
{\small\bfseries \@custommagazinename}، \date
}
\newcommand{\xepersian@headcenter}{%
\xepersian@section{}
}
\newcommand{\xepersian@headright}{%
\small\xepersian@edition%
\hspace*{5pt}\beginL\thepage\ / \pageref{LastPage}\endL
}

\newcommand{\heading}[3]{%
\renewcommand{\xepersian@headleft}{\beginR#1\endR}%
\renewcommand{\xepersian@headcenter}{\beginR#2\endR}%
\renewcommand{\xepersian@headright}{\beginR#3\endR}%
}
\newcommand{\xepersian@footright}{%
{\footnotesize\lr{\copyright\ \@customwwwTxt{}}---تهیه‌شده توسط \lr{\XePersian}}%
}
\newcommand{\xepersian@footcenter}{%
}
\newcommand{\xepersian@footleft}{%
}

\newcommand{\foot}[3]{%
\renewcommand{\xepersian@footleft}{\beginR#1\endR}%
\renewcommand{\xepersian@footcenter}{\beginR#2\endR}%
\renewcommand{\xepersian@footright}{\beginR#3\endR}%
}
\newcommand{\firstTitleFormat}{\Huge\bfseries\flushright}
\newcommand{\xepersian@firstTitle}[1]{%
{%
\begin{spacing}{2.0}{%
\noindent\ignorespaces
\ifthenelse{\boolean{xepersian@hyphenatedtitles}}%
{\nohyphens{\firstTitleFormat #1}}%
{{\firstTitleFormat #1}}%
}%
\end{spacing}%
}%
}
\newcommand{\firstTextFormat}{}
\newcommand{\xepersian@firstText}[1]{%
{\noindent\ignorespaces\firstTextFormat #1}%
}
\newcommand{\secondTitleFormat}{\LARGE\bfseries}
\newcommand{\xepersian@secondTitle}[1]{%
\begin{spacing}{1.5}{%
\noindent\ignorespaces\flushright
\ifthenelse{\boolean{xepersian@hyphenatedtitles}}%
{\nohyphens{\secondTitleFormat #1}}%
{{\secondTitleFormat #1}}%
}\end{spacing}%
}
\newcommand{\secondSubtitleFormat}{\large}
\newcommand{\xepersian@secondSubtitle}[1]{%
{\noindent\ignorespaces{\secondSubtitleFormat #1}}%
}
\newcommand{\secondTextFormat}{}
\newcommand{\xepersian@secondText}[1]{%
\begin{multicols}{2}
{\noindent\ignorespaces\secondTextFormat #1}
\end{multicols}
}
\newcommand{\thirdTitleFormat}{\Large\bfseries}
\newcommand{\xepersian@thirdTitle}[1]{%
\begin{spacing}{1.5}{%
\noindent\ignorespaces\flushright
\ifthenelse{\boolean{xepersian@hyphenatedtitles}}%
{\nohyphens{\thirdTitleFormat #1}}%
{{\thirdTitleFormat #1}}%
}\end{spacing}%
}
\newcommand{\thirdSubtitleFormat}{\large}
\newcommand{\xepersian@thirdSubtitle}[1]%
{{\noindent\ignorespaces\thirdSubtitleFormat #1}}
\newcommand{\thirdTextFormat}{}
\newcommand{\xepersian@thirdText}[1]{{\thirdTextFormat #1}}
\newcommand{\pictureCaptionFormat}{\small\bfseries}
\newcommand{\xepersian@pictureCaption}[1]{%
{\noindent\pictureCaptionFormat #1}%
}
\newcommand{\pagesFormat}{\bfseries\footnotesize}
\newcommand{\xepersian@pages}[1]%
{\noindent{\pagesFormat\MakeUppercase{#1}}}
\newcommand{\innerTitleFormat}{\Huge}
\newcommand{\xepersian@innerTitle}[1]{%
\begin{flushright}{%
\noindent
\ifthenelse{\boolean{xepersian@hyphenatedtitles}}%
{\nohyphens{\innerTitleFormat #1}}%
{{\innerTitleFormat #1}}%
}%
\\%
\end{flushright}%
}
\newcommand{\innerSubtitleFormat}{\large}
\newcommand{\xepersian@innerSubtitle}[1]{{\innerSubtitleFormat #1}}
\newcommand{\timestampTxt}{}
\newcommand{\timestampSeparator}{|}
\newcommand{\timestampFormat}{\small}
\newcommand{\timestamp}[1]{%
{\timestampFormat%
#1~\timestampTxt{}%
}~\timestampSeparator{}%
}
\newcommand{\innerAuthorFormat}{\footnotesize}
\newcommand{\innerPlaceFormat}{\footnotesize\bfseries}
\newcommand{\innerTextFinalMark}{\rule{0.65em}{0.65em}}
\newcommand{\editorialTitleFormat}{\LARGE\textit}
\newcommand{\xepersian@editorialTitle}[1]{\editorialTitleFormat{#1}}
\newcommand{\editorialAuthorFormat}{\textsc}
\newcommand{\shortarticleTitleFormat}{\LARGE\bfseries}
\newcommand{\xepersian@shortarticleTitle}[1]{{\shortarticleTitleFormat #1}}
\newcommand{\shortarticleSubtitleFormat}{\Large}
\newcommand{\xepersian@shortarticleSubtitle}[1]{{\shortarticleSubtitleFormat #1}}
\newcommand{\shortarticleItemTitleFormat}{\large\bfseries}
\newcommand{\xepersian@shortarticleItemTitle}[1]{{\shortarticleItemTitleFormat #1}}
\renewcommand{\maketitle}{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {\LARGE \@title \par}%
    \vskip 1em%
    {\LARGE «\xepersian@edition» \par}%
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
\newcommand{\xepersian@say}[1]{\typeout{#1}}
\newsavebox{\xepersian@fmbox}
\newenvironment{xepersian@fmpage}[1]
 {\begin{lrbox}{\xepersian@fmbox}\begin{minipage}{#1}}
 {\end{minipage}\end{lrbox}\fbox{\usebox{\xepersian@fmbox}}}
\newcommand{\image}[2]{
\vspace{5pt}
\setlength{\fboxsep}{1pt}
\addtolength{\xepersian@imgsize}{\columnwidth}
\addtolength{\xepersian@imgsize}{-1\columnsep}
\ifxetex
\setlength{\xepersian@pageneed}{1.5\xepersian@imgsize}
\addtolength{\xepersian@pageneed}{50pt}
\ClassWarning{xepersian-magazine}{%
Image #1 needs: \the\xepersian@pageneed \space %
and there is left: \the\page@free\space%
}
\ifdim \xepersian@pageneed < \page@free

{\centering\fbox{%
\includegraphics[width = \xepersian@imgsize,
height = \xepersian@imgsize,
keepaspectratio ]{#1}}}
\xepersian@pictureCaption{#2}

\vspace{5pt}
\else
\ClassWarning{Image #1 needs more space!%
  It was not inserted!}
\fi
\fi
}
\textblockorigin{1cm}{1cm}
\newdimen\xepersian@dx
\newdimen\xepersian@dy
\newcount\xepersian@cx
\newcount\xepersian@cy
\newcommand{\grid}[3][]{
\xepersian@dx=\textwidth%
\xepersian@dy=\textheight%
\xepersian@cx=#3% %columns
\xepersian@cy=#2% %rows

\count1=#3%
\advance\count1 by 1

\count2=#2%
\advance\count2 by 1

\divide\xepersian@dx by #3
\divide\xepersian@dy by #2

\setlength{\TPHorizModule}{\xepersian@dx}
\setlength{\TPVertModule}{\xepersian@dy}

\ifthenelse{\equal{#1}{show}}{
\multido{\xepersian@nrow=0+1}{\count2}{
\begin{textblock}{\xepersian@cx}(0,\xepersian@nrow)
\rule[0pt]{\textwidth}{.1pt}
\end{textblock}
}

\multido{\xepersian@ncol=0+1}{\count1}{
\begin{textblock}{\xepersian@cy}(\xepersian@ncol,0)
\rule[0pt]{.1pt}{\textheight}
\end{textblock}
}
}{}
}
\newcommand{\xepersianInit}{
\setlength{\headheight}{14pt}
\renewcommand{\headrulewidth}{0.4pt}

\pagestyle{fancy}

\setlength{\columnseprule}{\columnlines}
\setlength{\fboxrule}{0.1 pt}

}

\def\customlogo#1{\gdef\@customlogo{\beginR#1\endR}}
\def\customminilogo#1{\gdef\@customminilogo{\beginR#1\endR}}
\def\custommagazinename#1{\gdef\@custommagazinename{\beginR#1\endR}}
\newcommand{\logo}[0]{
%% Heading %%
\noindent\hrulefill\hspace{10pt}\xepersian@editionLogo\hspace{5pt}\xepersian@www

\vspace*{-3pt}

{\Large\bfseries \@customlogo}
\hrulefill
\hspace{10pt}\xepersian@headDateTime

}
\newcommand{\minilogo}[0]{
{\large\bfseries \@customminilogo}

\vspace*{5pt}
}
\newcommand{\mylogo}[1]{
{\beginR#1\endR}

\noindent
\xepersian@editionLogo\hspace{5pt}
\hrulefill
\hspace{5pt}\xepersian@headDateTime
}
\newcommand{\edition}[1]{\renewcommand{\xepersian@edition}{#1}}
\newenvironment{frontpage}[0]
{
\setboolean{xepersian@insidefrontpage}{true}
\thispagestyle{empty}
\logo

}%
{
\thispagestyle{empty}
\clearpage
\newpage
\fancyhead{}
 \fancyfoot{}
\fancyhead[RO,LE]{\beginR\xepersian@headright\endR}
\fancyhead[LO,RE]{\beginR\xepersian@headleft\endR}
    \fancyhead[C]{\beginR\xepersian@headcenter\endR}
    \fancyfoot[RO,LE]{\beginR\xepersian@footright\endR}
    \fancyfoot[LO,RE]{\beginR\xepersian@footleft\endR}
\fancyfoot[C]{\beginR\xepersian@footcenter\endR}
\renewcommand{\headrulewidth}{0.4pt}
\setboolean{xepersian@insidefrontpage}{false}

}
\newcommand{\firstarticle}[3]
{
\ifthenelse{\boolean{xepersian@insidefrontpage}}{%
\ifthenelse{\boolean{xepersian@hyphenatedtitles}}{%
\begin{textblock}{24}(22,5)
}
{
\begin{textblock}{28}(22,5)
}
\vspace{-7pt}
\xepersian@firstTitle{#1}
\end{textblock}
\begin{textblock}{29}(22,10)
\vspace{5pt plus 2pt minus 2pt}

\xepersian@firstText{\timestamp{#3}~#2}

\end{textblock}

\begin{textblock}{50}(0,15)
\rule{50\TPHorizModule}{.3pt}
\end{textblock}
}{%else
\ClassError{xepersian-magazine}{%
\protect\firstarticle\space in a wrong place.\MessageBreak
\protect\firstarticle\space may only appear inside frontpage environment.
}{%
\protect\firstarticle\space may only appear inside frontpage environment.
}%
}
}
\newcommand{\secondarticle}[5]
{
\ifthenelse{\boolean{xepersian@insidefrontpage}}{%
\begin{textblock}{33}(2,16)
\xepersian@pages{#4}
\vspace{-5pt}
\xepersian@secondTitle{#1}

\vspace*{5pt}

\xepersian@secondSubtitle{#2}

\vspace*{-7pt}

\xepersian@secondText{\timestamp{#5}~#3}

\end{textblock}

\begin{textblock}{33}(2,25)
\vspace{5pt plus 2pt minus 2pt}

\noindent\ignorespaces\rule{33\TPHorizModule}{.3pt}
\end{textblock}
}{%else
\ClassError{xepersian-magazine}{%
\protect\secondarticle\space in a wrong place.\MessageBreak
\protect\secondarticle\space may only appear inside frontpage environment.
}{%
\protect\secondarticle\space may only appear inside frontpage environment.
}%
}
}
\newcommand{\thirdarticle}[6]
{
\ifthenelse{\boolean{xepersian@insidefrontpage}}{%
\begin{textblock}{32}(2,26)
\xepersian@pages{#5}
\vspace{-5pt}
\setlength{\fboxsep}{1pt}
\xepersian@thirdTitle{#1}

\vspace*{5pt}

\xepersian@thirdSubtitle{#2}

\vspace*{5pt}

{\noindent\ignorespaces %
\ifthenelse{\equal{#4}{}}{}

\xepersian@thirdText{\timestamp{#6}~#3}

}

\vspace*{5pt}

\end{textblock}
}{%else
\ClassError{xepersian-magazine}{%
\protect\thirdarticle\space in a wrong place.\MessageBreak
\protect\thirdarticle\space may only appear inside frontpage environment.
}{%
\protect\thirdarticle\space may only appear inside frontpage environment.
}%
}
}
\newcommand{\firstimage}[2]
{
\ifthenelse{\boolean{xepersian@insidefrontpage}}{%
\begin{textblock}{18}(2,5)
\setlength{\fboxsep}{1pt}
\ifxetex % only in PDF
\noindent\fbox{\includegraphics[width = 18\TPHorizModule ]{#1}}
\fi

\xepersian@pictureCaption{#2}
\end{textblock}%
}
{\ClassError{xepersian-magazine}{%
\protect\firstimage\space in a wrong place.\MessageBreak
\protect\firstimage\space may only appear inside frontpage environment.
}{%
\protect\firstimage\space may only appear inside frontpage environment.
}}
}%
\newcommand{\weatheritem}[5]{%
\ifthenelse{\boolean{xepersian@insideweather}}{
\begin{minipage}{45pt}
\ifxetex
\includegraphics[width=40pt]{#1}
\fi
\end{minipage}
\begin{minipage}{50pt}
\weatherTempFormat
#2\\
\beginL#3 $\|$ #4 \lr{\weatherUnits{}}\endL\\
#5
\end{minipage}
}{%else
\ClassError{xepersian-magazine}{%
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
\ifthenelse{\boolean{xepersian@insidefrontpage}}{%
\setboolean{xepersian@insideweather}{true}
\begin{textblock}{32}(2,38)
\vspace*{-15pt}

\xepersian@weather{\beginR#1\endR}

\vspace*{5pt}

\noindent\begin{xepersian@fmpage}{32\TPHorizModule}
\begin{minipage}{32\TPHorizModule}
\hspace{5pt}

}{%
\ClassError{xepersian-magazine}{%
weatherblock in a wrong place.\MessageBreak
weatherblock may only appear inside frontpage environment.
}{%
weatherblock may only appear inside frontpage environment.
}
}
}%
{
\end{minipage}
\end{xepersian@fmpage}
\end{textblock}
\setboolean{xepersian@insideweather}{false}
}
\newenvironment{authorblock}[0]
{
\ifthenelse{\boolean{xepersian@insidefrontpage}}{%
\begin{textblock}{15}(36,35)
\setlength{\fboxsep}{5pt}
\begin{xepersian@fmpage}{13\TPHorizModule}
\begin{minipage}{13\TPHorizModule}
\centering
\minilogo

}{%else
\ClassError{xepersian-magazine}{%
authorblock in a wrong place.\MessageBreak
authorblock may only appear inside frontpage environment.
}{%
authorblock may only appear inside frontpage environment.
}
}
}
{
\end{minipage}
\end{xepersian@fmpage}
\end{textblock}
}
\newenvironment{indexblock}[1]
{
\ifthenelse{\boolean{xepersian@insidefrontpage}}{%
\setboolean{xepersian@insideindex}{true}%let's in
\begin{textblock}{15}(36,16)
\setlength{\xepersian@indexwidth}{13\TPHorizModule}
\xepersian@indexFrameTitle{#1}

\setlength{\fboxsep}{5pt} %espacio entre el frame y la imagen
\begin{xepersian@fmpage}{\xepersian@indexwidth}
\begin{minipage}{\xepersian@indexwidth}
\vspace*{10pt}
}{%else
\ClassError{xepersian-magazine}{%
indexblock in a wrong place.\MessageBreak
indexblock may only appear inside frontpage environment.
}{%
indexblock may only appear inside frontpage environment.
}
}
}%
{
\end{minipage}
\end{xepersian@fmpage}
\end{textblock}
\setboolean{xepersian@insideindex}{false}%let's out
}
\newcommand{\indexitem}[2]
{
\ifthenelse{\boolean{xepersian@insideindex}}{
\xepersian@indexEntry{#1، \xepersian@indexEntryPage{\pageref{#2}}}

\vspace{0.5cm}

\noindent\ignorespaces\indexEntrySeparator{}
}{%else
\ClassError{xepersian-magazine}{%
\protect\indexitem\space in a wrong place.\MessageBreak
\protect\indexitem\space may only appear inside indexblock environment.
}{%
\protect\indexitem\space may only appear inside indexblock environment.\MessageBreak
indexblock environment may only appear inside frontpage environment.
}%
}
}
\newcommand{\xepersian@inexpandedtitle}[1]{
\begin{minipage}{.95\textwidth}
\begin{center}
\noindent\Large\textbf{\beginR#1\endR}
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
\xepersian@inexpandedtitle{#2}%
}%
}{}
\ifthenelse{\equal{#1}{doublebox}}{%
\doublebox{%
\xepersian@inexpandedtitle{#2}%
}%
}{}
\ifthenelse{\equal{#1}{ovalbox}}{%
\ovalbox{%
\xepersian@inexpandedtitle{#2}%
}%
}{}
\ifthenelse{\equal{#1}{Ovalbox}}{%
\Ovalbox{%
\xepersian@inexpandedtitle{#2}%
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

\begin{multicols}{\xepersian@ncolumns{}}
\ifnum \xepersian@ncolumns > \minraggedcols
\raggedFormat
\fi
}
\newcommand{\xepersian@incolumntitle}[2]{
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
\addtolength{\xepersian@coltitsize}{\columnwidth}
\addtolength{\xepersian@coltitsize}{-1\columnsep}
\addtolength{\xepersian@coltitsize}{-5pt}
\addtolength{\xepersian@coltitsize}{-1\shadowsize}
\ifthenelse{\equal{#1}{shadowbox}}{%
\shadowbox{%
\xepersian@incolumntitle{\xepersian@coltitsize}{#2}%
}%
}{}
\ifthenelse{\equal{#1}{doublebox}}{%
\doublebox{%
\xepersian@incolumntitle{\xepersian@coltitsize}{#2}%
}%
}{}
\ifthenelse{\equal{#1}{ovalbox}}{%
\ovalbox{%
\xepersian@incolumntitle{\xepersian@coltitsize}{#2}%
}%
}{}
\ifthenelse{\equal{#1}{Ovalbox}}{%
\Ovalbox{%
\xepersian@incolumntitle{\xepersian@coltitsize}{#2}%
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
\rightline{%
{\innerAuthorFormat #1},\space{}{\innerPlaceFormat #2}%
}%
\par %
}
\newcommand{\newsection}[1]{
\renewcommand{\xepersian@section}{#1}
}
\newenvironment{article}[5]
{
\xepersian@say{Adding a new piece of article}
\renewcommand{\xepersian@ncolumns}{#1}
\begin{multicols}{#1}[
\xepersian@pages{#4}
\xepersian@innerTitle{#2}%
\xepersian@innerSubtitle{#3}%
][4cm]%
\label{#5}
\ifnum #1 > \minraggedcols
\raggedFormat
\fi
}
{~\innerTextFinalMark{}
\end{multicols}
}
\newcommand{\articlesep}{%
\setlength{\xepersian@pageneed}{16000pt}
\setlength\xepersian@pageleft{\pagegoal}
\addtolength\xepersian@pageleft{-\pagetotal}

\xepersian@say{How much left \the\xepersian@pageleft}

\ifdim \xepersian@pageneed < \xepersian@pageleft
\xepersian@say{Not enough space}
\else
\xepersian@say{Adding sep line between articles}
\vspace*{10pt plus 10pt minus 5pt}
\hrule
\vspace*{10pt plus 5pt minus 5pt}
\fi

}
\newcommand{\xepersian@editorialTit}[2]{
\setlength{\arrayrulewidth}{.1pt}
\begin{center}
\begin{tabular}{c}
\noindent
\xepersian@editorialTitle{#1}
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
\xepersian@say{Adding a new editorial}
\begin{multicols}{#1}[%
\xepersian@editorialTit{#2}{#3}%
][4cm]
\label{#4}
\ifnum #1 > \minraggedcols
\raggedFormat
\fi
}
{
\end{multicols}
}
\newcommand{\xepersian@shortarticleTit}[2]{
\begin{center}
\vbox{%
\noindent
\xepersian@shortarticleTitle{#1}
\vspace{4pt plus 2pt minus 2pt}
\hrule
\vspace{4pt plus 2pt minus 2pt}
\xepersian@shortarticleSubtitle{#2}
}
\end{center}
}
\newenvironment{shortarticle}[4]
{
\xepersian@say{Adding a short article block}
\begin{multicols}{#1}[\xepersian@shortarticleTit{#2}{#3}][4cm] %
    \label{#4}
\par %
\ifnum #1 > \minraggedcols
\raggedFormat
\fi
}
{
\end{multicols}
}
\newcommand{\shortarticleitem}[2]{
\goodbreak
\vspace{5pt plus 3pt minus 3pt}
{\vbox{\noindent\xepersian@shortarticleItemTitle{#1}}}
\vspace{5pt plus 3pt minus 3pt}
{\noindent #2}\\
}
%% 
%% Copyright © 2008–2012  Vafa Khalighi <vkhalighi@me.com>
%% 
%% It may be distributed and/or modified under the LaTeX Project Public License,
%% version 1.3c or higher (your choice). The latest version of
%% this license is at: http://www.latex-project.org/lppl.txt
%% 
%% This work is “author-maintained” (as per LPPL maintenance status)
%% by Vafa Khalighi.
%% 
%% 
%% 
%%
%% End of file `xepersian-magazine.cls'.
