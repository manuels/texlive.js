%%
%% This is file `paper.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% paper.dtx  (with options: `paper')
%% 
%% Copyright (C) 1993, 1998 by wenzel_matiaske@notes.uni-paderborn.de
%% 
%% You are not allowed to distribute this file without the
%% original source paper.dtx. For distribution of the
%% sources see the copyright notice in the file paper.dtx.
%% 
\def\filename{paper}
\def\fileversion{1.0l}
\def\filedate{2008/05/30}
\def\docdate{1996/11/02}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{paper}[\filedate\space\fileversion\space%
       LaTeX document class (wm).]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagefalse
\newif\if@openbib
\@openbibfalse
\if@compatibility\else
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\fi
\if@compatibility
  \renewcommand\@ptsize{0}
\else
   \DeclareOption{10pt}{\renewcommand\@ptsize{0}}
   \DeclareOption{11pt}{\renewcommand\@ptsize{1}}
   \DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\fi
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\newcount\hours \newcount\minutes
\def\SetTime{\hours=\time
        \global\divide\hours by 60
        \minutes=\hours
        \multiply\minutes by 60
        \advance\minutes by-\time
        \global\multiply\minutes by-1 }
\def\now{\number\hours:\ifnum\minutes<10 0\fi\number\minutes}
\newif\iffinal \finaltrue
\DeclareOption{draft}{\setlength\overfullrule{5pt}\finalfalse \SetTime}
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}\finaltrue}
\fi
\newif\if@journal
\@journalfalse
\DeclareOption{journal}{\@journaltrue}
\newif\if@crosshair \@crosshairfalse
\DeclareOption{crosshair}{\@crosshairtrue}
\newif\if@itemization \@itemizationtrue
\DeclareOption{itemize}{\@itemationtrue}
\DeclareOption{noitemize}{\@itemizationfalse}
\newif\if@enumeration \@enumerationtrue
\DeclareOption{enumerate}{\@enumerationtrue}
\DeclareOption{noenumerate}{\@enumerationfalse}
\newif\if@noind \@noindfalse
\DeclareOption{indent}{\@noindfalse}
\DeclareOption{noindent}{\@noindtrue}
\newif\if@center \@centerfalse
\DeclareOption{center}{\@centertrue}
\DeclareOption{nocenter}{\@centerfalse}
\newif\if@upper      \@upperfalse
\DeclareOption{upper}{\@uppertrue}
\DeclareOption{noupper}{\@upperfalse}
\newif\if@headline  \@headlinetrue
\DeclareOption{headline}{\@headlinetrue}
\DeclareOption{noheadline}{\@headlinefalse}
\newif\if@headcount \@headcounttrue
\DeclareOption{headcount}{\@headcounttrue}
\DeclareOption{noheadcount}{\@headcountfalse}
\def\partfont#1{\def\p@font{#1}}             \def\p@font{}
\def\sectionfont#1{\def\s@font{#1}}          \def\s@font{}
\def\subsectionfont#1{\def\ss@font{#1}}      \def\ss@font{}
\def\subsubsectionfont#1{\def\sss@font{#1}}  \def\sss@font{}
\def\paragraphfont#1{\def\pg@font{#1}}       \def\pg@font{}
\def\subparagraphfont#1{\def\spg@font{#1}}   \def\spg@font{}
\def\titlefont#1{\def\t@font{#1}}            \def\t@font{}
\def\subtitlefont#1{\def\st@font{#1}}        \def\st@font{}
\def\authorfont#1{\def\a@font{#1}}           \def\a@font{}
\def\institutionfont#1{\def\in@font{#1}}     \def\in@font{}
\def\theoremheaderfont#1{\def\thh@font{#1}}  \def\thh@font{}
\def\theorembodyfont#1{\def\thb@font{#1}}    \def\thb@font{}
\def\itemfont#1{\def\item@font{#1}}          \def\item@font{}
\def\examplefont#1{\def\ex@font{#1}}         \def\ex@font{}
\def\headingstextfont#1{\def\h@font{#1}}     \def\h@font{}
\def\pagenumberfont#1{\def\pn@font{#1}}      \def\pn@font{}
\def\captionheaderfont#1{\def\cph@font{#1}}  \def\cph@font{}
\def\captionbodyfont#1{\def\cpb@font{#1}}    \def\cpb@font{}
\def\figurefont#1{\def\fig@font{#1}}         \def\fig@font{}
\def\tablefont#1{\def\tab@font{#1}}          \def\tab@font{}
\DeclareOption{slanted}{
    \partfont{\Large}
    \sectionfont{\large\slshape}
    \subsectionfont{\slshape}
    \subsubsectionfont{\slshape}
    \paragraphfont{\slshape}
    \subparagraphfont{\slshape}
    \titlefont{\Large}
    \subtitlefont{\large}
    \authorfont{\large}
    \institutionfont{\slshape}
    \theoremheaderfont{\upshape}
    \theorembodyfont{}
    \itemfont{\slshape}
    \examplefont{}
    \headingstextfont{\small\slshape}
    \pagenumberfont{\small}
    \captionheaderfont{\slshape\small}
    \captionbodyfont{\small}
    \figurefont{}
    \tablefont{}
\@uppertrue}
\DeclareOption{bold}{%
    \partfont{\LARGE\bfseries}
    \sectionfont{\Large\bfseries}
    \subsectionfont{\large\bfseries}
    \subsubsectionfont{\bfseries}
    \paragraphfont{\bfseries}
    \subparagraphfont{\bfseries}
    \titlefont{\LARGE\bfseries}
    \subtitlefont{\large}
    \authorfont{}
    \institutionfont{\slshape}
    \theoremheaderfont{\bfseries}
    \theorembodyfont{\itshape}
    \itemfont{\bfseries}
    \examplefont{}
    \headingstextfont{\small\bfseries}
    \pagenumberfont{\small}
    \captionheaderfont{\bfseries}
    \captionbodyfont{}
    \figurefont{}
    \tablefont{}
}
\DeclareOption{sfbold}{%
    \partfont{\LARGE\sffamily\bfseries}
    \sectionfont{\large\sffamily\bfseries}
    \subsectionfont{\large\sffamily\bfseries}
    \subsubsectionfont{\sffamily\bfseries}
    \paragraphfont{\sffamily\bfseries}
    \subparagraphfont{\sffamily}
    \titlefont{\LARGE\sffamily\bfseries}
    \subtitlefont{\large\sffamily}
    \authorfont{\Large\sffamily\slshape}
    \institutionfont{\sffamily}
    \theoremheaderfont{\sffamily}
    \theorembodyfont{}
    \itemfont{\sffamily}
    \examplefont{}
    \headingstextfont{\small\sffamily}
    \pagenumberfont{\small\rmfamily}
    \captionheaderfont{\sffamily}
    \captionbodyfont{}
    \figurefont{}
    \tablefont{}
}
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}
\ExecuteOptions{letterpaper,10pt,oneside,onecolumn,final,sfbold}
\ProcessOptions
\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\if@noind
  \setlength\parskip{0.5\baselineskip
         \@plus.1\baselineskip \@minus.1\baselineskip}
  \setlength\parindent{\z@}
  \def\noparskip{\par\vspace{-\parskip}}
\else
  \setlength\parskip{0\p@ \@plus \p@}
  \let\noparskip\relax
\fi
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\def\e@skip{\h@font{\phantom{y}}}
\if@twoside
  \def\ps@headings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\vbox{\hsize=\textwidth
      \hbox to \textwidth{%
        {\pn@font\thepage}\hfill{\h@font\leftmark}\e@skip\if@center\hfill\fi}
        \if@headline \vskip 1.5pt \hrule \fi}}%
    \def\@oddhead{\vbox{\hsize=\textwidth
      \hbox to \textwidth{%
        \if@center\hfill\fi{\h@font\rightmark}\e@skip\hfill{\pn@font\thepage}}
        \if@headline \vskip 1.5pt \hrule \fi}}%
    \let\@mkboth\markboth
    \def\sectionmark##1{\markboth{\ifnum \c@secnumdepth
       >\z@ \if@headcount \thesection \ \fi \fi ##1}{}}
    \def\subsectionmark##1{\markright{\ifnum \c@secnumdepth >\@ne
      \if@headcount \thesubsection \ \fi \fi ##1}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{\vbox{\hsize=\textwidth
       \hbox to \textwidth{%
         \if@center\hfill\fi{\h@font\rightmark}\e@skip\hfill{\pn@font\thepage}}
         \if@headline \vskip 1.5pt \hrule \fi}}%
    \def\sectionmark##1{\markright {\if@headcount
      \ifnum \c@secnumdepth >\z@ \thesection \ \fi \fi ##1}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{\vbox{\hsize=\textwidth
      \hbox to \textwidth{%
      \if@center\hfill\fi{\h@font\rightmark}\e@skip\hfill{\pn@font\thepage}}
      \if@headline \vskip 1.5pt \hrule \fi}}%
    \def\@evenhead{\vbox{\hsize=\textwidth
      \hbox to \textwidth{%
      {\pn@font\thepage}\hfill{\h@font\leftmark}\e@skip\if@center\hfill\fi}
      \if@headline \vskip 1.5pt \hrule \fi}}%
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
}
\if@journal
  \def\evenrunhead#1{\gdef\@evenrunhead{#1}}    \def\@evenrunhead{}
  \def\oddrunhead#1{\gdef\@oddrunhead{#1}}      \def\@oddrunhead{}
  \def\ps@journal{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@oddhead{\vbox{\hsize=\textwidth
        \hbox to \textwidth{%
        \if@center\hfill\fi{\h@font%
        \ifx\@oddrunhead\@empty\rightmark\else\@oddrunhead\fi}
        \e@skip\hfill{\pn@font\thepage}}
        \if@headline \vskip 1.5pt \hrule \fi}}%
      \def\@evenhead{\vbox{\hsize=\textwidth
        \hbox to \textwidth{%
        {\pn@font\thepage}\e@skip\hfill{\h@font%
         \ifx\@evenrunhead\@empty\leftmark\else\@evenrunhead\fi}
        \if@center\hfill\fi}
        \if@headline \vskip 1.5pt \hrule \fi}}%
      \let\@mkboth\@gobbletwo
      \let\sectionmark\@gobble
      \let\subsectionmark\@gobble
  }
\fi
\def\ps@draft{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{\vbox{\hsize=\textwidth
      \hbox to \textwidth{%
      {\pn@font\today\ \now\ --- {\h@font \draftname: ``\jobname''}
        \hfil\e@skip \thepage}} \if@headline \vskip 1.5pt \hrule \fi}}%
    \def\@evenhead{\vbox{\hsize=\textwidth
   \hbox to \textwidth{%
       \pn@font\thepage\e@skip\hfil {\h@font \draftname: ``\jobname''} ---
       \today\ \now\ } \if@headline \vskip 1.5pt \hrule \fi}}%
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
}
\@ifundefined{option@crosshair}{}{%
  \def\clap#1{\hbox to 0pt{\hss#1\hss}} \newdimen\@crosshairrule
  \@crosshairrule=.24pt \def\@crosshairs{\vbox to
    0pt{\hsize=0pt\baselineskip=0pt\lineskip=0pt \vss \clap{\vrule
        height .125in width \@crosshairrule depth 0pt} \clap{\vrule
        width .25in height \@crosshairrule depth 0pt} \clap{\vrule
        height .125in width \@crosshairrule depth 0pt} \vss}}
 \def\ps@empty{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@oddhead{\hfill\raise\headheight\@crosshairs}
    \let\@evenhead\@oddhead}}
\def\@subtitle{}    \def\subtitle#1{\gdef\@subtitle{#1}}
\def\@institution{} \def\institution#1{\gdef\@institution{#1}}
\def\@shortauthor{} \def\shortauthor#1{\gdef\@shortauthor{#1}}
\def\@shorttitle{}  \def\shorttitle#1{\gdef\@shorttitle{#1}}
\def\and{\end{tabular}\hskip 1em plus.17fil
  \if@center\begin{tabular}[t]{c}\else\begin{tabular}[t]{@{}l@{}}\fi}
\if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let\real@thanks\thanks
  \DeclareRobustCommand\thanks{\real@thanks}
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \if@center \begin{center} \else \begin{raggedright} \fi
     {\t@font \if@upper \uppercase\expandafter{\@title} \else
                 \@title \fi \par}%
    \vskip 3em%
     {\ifx\@subtitle\@empty\else
                  \vskip.5em \st@font \@subtitle \par \fi}
      \vskip 1.5em
     {\a@font \lineskip .75em
        \if@center\begin{tabular}[t]{c}\else\begin{tabular}[t]{@{}l@{}}\fi
         \@institution \end{tabular} \par }
     {\ifx\@institution\@empty\else\vskip.5em
        \in@font\bf \lineskip .75em
        \if@center\begin{tabular}[t]{c}\else\begin{tabular}[t]{@{}l@{}}\fi
         \@institution \end{tabular} \par\fi}
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \if@center \end{center} \else \end{raggedright} \fi
  \vfil\null
  \@thanks
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \let\thanks\relax\let\maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\gdef\@institution{}
  \gdef\@subtitle{}}
\else
  \newcommand\maketitle{%
  \setcounter{footnote}{0}\par
  \begingroup
    \renewcommand\thefootnote{\fnsymbol{footnote}}%
    \def\@makefnmark{\hbox to\z@{$\m@th^{\@thefnmark}$\hss}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \if@journal
    \typeout{Article: \@shortauthor}
    \setcounter{section}{0}%
    \setcounter{subsection}{0}%
    \setcounter{subsubsection}{0}%
    \setcounter{paragraph}{0}%
    \setcounter{subparagraph}{0}%
    \setcounter{figure}{0}%
    \setcounter{table}{0}%
    \setcounter{equation}{0}%
    \addcontentsline{jou}{titles}{%
      {\sss@font\@shortauthor}\hfill\mbox{}\vskip\normallineskip%
       \ifx\@shorttitle\@empty\@title\else\@shorttitle\fi}
      \if@twoside
        \ifx\@oddrunhead\@empty\ifx\@evenrunhead\@empty
        \markboth{\@shortauthor}{\@shorttitle}\else
        \markboth{}{\@shortauthor, \@shorttitle}\fi \else
        \markboth{\@shortauthor, \@shorttitle}{}\fi
      \else
        \markright{\@shortauthor, \@shorttitle}
      \fi
  \else
    \let\maketitle\relax \let\@maketitle\relax
  \fi
    \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\gdef\@institution{}
    \gdef\@subtitle{}}
\newlength{\beforetitlespace} \setlength{\beforetitlespace}{2em}
\def\@maketitle{%
  \cleardoublepage
  \null
  \vskip \beforetitlespace%
  \if@center \begin{center} \else \begin{raggedright} \fi
     {\t@font \if@upper \uppercase\expandafter{\@title} \else
                 \@title \fi \par}%
     {\ifx\@subtitle\@empty\else
                  \vskip.5em \st@font \@subtitle \par \fi}
      \vskip 1.5em
     {\a@font \lineskip .5em
        \if@center\begin{tabular}[t]{c}\else\begin{tabular}[t]{@{}l@{}}\fi
         \@author \end{tabular} \par}
     {\ifx\@institution\@empty\else\vskip.5em
        \in@font\bf \lineskip .75em
        \if@center\begin{tabular}[t]{c}\else\begin{tabular}[t]{@{}l@{}}\fi
         \@institution \end{tabular} \par\fi}
  \if@center \end{center} \else \end{raggedright} \fi
  \par \vskip 1.5em
}
\fi
\setcounter{secnumdepth}{3}
\newcounter {part}
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand\thepart          {\Roman{part}}
\renewcommand\thesection       {\arabic{section}}
\renewcommand\thesubsection    {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection.\arabic{subsubsection}}
\renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\renewcommand\thesubparagraph  {\theparagraph.\arabic{subparagraph}}
\newcommand\part{\par
   \addvspace{4ex}%
   \@afterindentfalse
   \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    {\parindent \z@ \if@center\centering\else\raggedright\fi
     \interlinepenalty \@M
     \reset@font
     \ifnum \c@secnumdepth >\m@ne
       \p@font \partname~\thepart.\
     \fi
     \if@upper\uppercase{#2}\else#2\fi%
     \if@journal\else\markboth{}{}\fi\par}%
    \nobreak
    \vskip 3ex
    \@afterheading}
\def\@spart#1{%
    {\parindent \z@
     \if@center\centering\else\raggedright\fi
     \interlinepenalty \@M
     \reset@font
     \p@font\if@upper\uppercase{#1}\else#1\fi\par}
     \nobreak
     \vskip 3ex
     \@afterheading}
\def\@endpart{\vfil\newpage
              \if@twoside
                \hbox{}%
                \thispagestyle{empty}%
                \newpage
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\if@journal
\newcommand\journalpart{\par
   \addvspace{4ex}%
   \@afterindentfalse
   \secdef\@journalpart\@sjournalpart}
\def\@journalpart[#1]#2{\addcontentsline{jou}{part}{#1}
   {\parindent \z@ \if@center\centering\else\raggedright\fi
    \interlinepenalty \@M
    \reset@font
    \t@font
    \if@upper\uppercase{#2}\else#2\fi%
    \markboth{#1}{#1}\par}%
    \nobreak
    \vskip 3ex
    \@afterheading}
\def\@sjournalpart#1{{\parindent \z@
     \if@center\centering\else\raggedright\fi
     \interlinepenalty \@M
     \reset@font
     \t@font\if@upper\uppercase{#1}\else#1\fi
     \markboth{#1}{#1}\par}
     \nobreak
     \vskip 3ex
     \@afterheading}
\def\@endjournalpart{\vfil\newpage
              \if@twoside
                \hbox{}%
                \thispagestyle{empty}%
                \newpage
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\fi
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\if@center\centering\else\raggedright\fi
                                    \reset@font\s@font}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\if@center\centering\else\raggedright\fi
                                      \reset@font\ss@font}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\if@center\centering\else\raggedright\fi
                                      \reset@font\sss@font}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\reset@font\pg@font}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\reset@font\spg@font}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength\leftmargin    {\leftmargini}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\if@enumeration
  \renewcommand\theenumi{\arabic{enumi}}
  \renewcommand\theenumii{\alph{enumii}}
  \renewcommand\theenumiii{\roman{enumiii}}
  \renewcommand\theenumiv{\Alph{enumiv}}
  \newcommand\labelenumi{\theenumi.}
  \newcommand\labelenumii{(\theenumii)}
  \newcommand\labelenumiii{\theenumiii.}
  \newcommand\labelenumiv{\theenumiv.}
  \renewcommand\p@enumii{\theenumi}
  \renewcommand\p@enumiii{\theenumi(\theenumii)}
  \renewcommand\p@enumiv{\p@enumiii\theenumiii}
\else
  \renewcommand\theenumi{\arabic{enumi}}
  \renewcommand\theenumii{\arabic{enumii}}
  \renewcommand\theenumiii{\arabic{enumiii}}
  \renewcommand\theenumiv{\arabic{enumiv}}
  \newcommand\labelenumi{\theenumi.}
  \newcommand\labelenumii{\theenumi.\theenumii.}
  \newcommand\labelenumiii{\theenumi.\theenumii.\theenumiii.}
  \newcommand\labelenumiv{\theenumi.\theenumii.\theenumiii.\theenumiv.}
  \renewcommand\p@enumii{\theenumi}
  \renewcommand\p@enumiii{\theenumi(\theenumii)}
  \renewcommand\p@enumiv{\p@enumiii\theenumiii}
\fi
\if@titlepage
  \newenvironment{keywords}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \if@center\begin{center}\else\begin{raggedright}\fi%
        {\sss@font  \keywordname}
        \@endparpenalty\@M
      \if@center\end{center}\else\end{raggedright}\fi}%
     {\par\vfil\null\endtitlepage}
  \newenvironment{abstract}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \if@center\begin{center}\else\begin{raggedright}\fi%
        {\sss@font  \abstractname}
        \@endparpenalty\@M
      \if@center\end{center}\else\end{raggedright}\fi}%
     {\par\vfil\null\endtitlepage}
\else
   \if@center
    \def\abstract{%
       \if@twocolumn
         \small\subsubsection*{\abstractname}%
      \else
        \small
        \begin{center}
        {\sss@font \abstractname\vspace{-.5em}\vspace{\z@}}%
        \end{center} \quotation
      \fi}
    \def\endabstract{\if@twocolumn\else\endquotation\fi}
    \def\keywords{\small\paragraph*{\keywordname:}}
    \def\endkeywords{\par\bigskip}
   \else
     \def\abstract{\small\subsubsection*{\abstractname}}
     \def\endabstract{\par\bigskip}
     \def\keywords{\small\paragraph*{\keywordname: }}
     \let\endkeywords\endabstract
  \fi
\fi
\if@itemization
  \newcommand\labelitemi{$\m@th\bullet$}
  \newcommand\labelitemii{\normalfont\bfseries --}
  \newcommand\labelitemiii{$\m@th\ast$}
  \newcommand\labelitemiv{$\m@th\cdot$}
\else
  \newcommand\labelitemi{\bfseries --}
  \newcommand\labelitemii{\bfseries --}
  \newcommand\labelitemiii{\bfseries --}
  \newcommand\labelitemiv{\bfseries --}
\fi
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand\descriptionlabel[1]{\hspace\labelsep
                                \item@font #1}
\newenvironment{verse}
               {\let\\=\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item[]}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item[]}
               {\endlist}
\def\@begintheorem#1#2{\reset@font\thb@font\trivlist
      \item[\hskip \labelsep{\reset@font\thh@font #1\ #2:}]}
\def\@opargbegintheorem#1#2#3{\reset@font\thb@font\trivlist
      \item[\hskip \labelsep{\reset@font\thh@font #1\ #2\ (#3):}]}
\def\@endtheorem{\endtrivlist}
\newlength{\exampleindent}    \setlength{\exampleindent}{\parindent}
\newenvironment{example}%
   {\begin{list}{}{%
    \setlength{\leftmargin}{\exampleindent}}
    \ex@font \item[]}
   {\end{list}}
\newenvironment{describe}[1][\quad]%
  {\begin{list}{}{%
    \renewcommand{\makelabel}[1]{{\item@font ##1}\hfil}%
    \settowidth{\labelwidth}{{\item@font #1}}%
    \setlength{\leftmargin}{\labelwidth}%
    \addtolength{\leftmargin}{\labelsep}}}%
  {\end{list}}
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \if@compatibility
        \setcounter{page}{0}
      \else
        \setcounter{page}{1}%
      \fi}%
    {\if@restonecol\twocolumn \else \newpage \fi
      \setcounter{page}{1}%
    }
  \def\review{\@ifstar{\@sreview[]}{%
    \@ifnextchar [{\@tempswatrue\@review}{\@tempswafalse\@review[]}}}
  \def\@review[#1]#2#3{\setcounter{footnote}{0}
    \vskip 3.25ex plus1ex minus.2ex \noindent
    {\sss@font #2}\\\emph{#3.}\@afterheading
    \if@journal
      \addcontentsline{jou}{titles}{%
        {\sss@font#2}\hfill\mbox{}\vskip\normallineskip#3
        \if@tempswa (#1)\fi}
    \fi}
  \def\@sreview[#1]#2#3{\setcounter{footnote}{0}
     \vskip 3.25ex plus1ex minus.2ex \noindent
     {\sss@font #2}\\\emph{#3.} \@afterheading}
  \def\revauthor#1{\setcounter{footnote}{0}
    \def\thefootnote{\fnsymbol{footnote}}
    \gdef\@revauthor{#1}\@makerevauthor}
  \def\@makerevauthor{\hfill{\lineskip .5em
    \if@center \begin{tabular}[t]{c} \else \begin{tabular}[t]{@{}l@{}} \fi
    \@revauthor \end{tabular} \par}\@thanks\@afterheading
    \setcounter{footnote}{0}\def\thefootnote{\arabic{footnote}}
    \gdef\@thanks{}\gdef\@revauthor{}}
\newcommand\appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \renewcommand\thesection{\Alph{section}}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\renewcommand{\theequation}{\arabic{equation}}
\def\marginlabel#1{\marginpar%
   {\if@twoside
       \ifodd\c@page
          \raggedright
       \else
          \raggedleft
       \fi
     \else
        \raggedright
     \fi #1}}
\def\attention{\mbox{}%
    \marginpar[\raggedleft\large\bf! $\rightarrow$]%
        {\raggedright\large\bf $\leftarrow$ !}}
\def\seealso#1{\mbox{}%
    \marginpar[\raggedleft$\rightarrow$ \small #1]%
        {\raggedright\small  #1 $\leftarrow$}\ignorespaces}
\newcounter{figure}
\renewcommand\thefigure{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figureshortname~\thefigure}
\newenvironment{figure}
               {\fig@font\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\fig@font\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}
\renewcommand\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tableshortname~\thetable}
\newenvironment{table}
               {\tab@font\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\tab@font\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
 \vskip\abovecaptionskip
 \setbox\@tempboxa\hbox{{\cph@font #1:} {\cpb@font #2}}%
 \ifdim \wd\@tempboxa >\hsize
    \@hangfrom{\cph@font #1: }{\cpb@font #2\par}%
 \else
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
 \fi
 \vskip\belowcaptionskip}
\def\rb#1{\raisebox{1.5ex}[-1.5ex]{#1}}
\def\tablerule{\noalign{\ifnum0=`}\fi
   \hrule \@height \arrayrulewidth \vskip\doublerulesep
   \futurelet \@tempa\@xhline}
\def\thicktablerule{\noalign{\ifnum0=`}\fi
   \hrule \@height 2\arrayrulewidth \vskip\doublerulesep
   \futurelet \@tempa\@xhline}
\def\doubletablerule{\noalign{\ifnum0=`}\fi
   \hrule \@height \arrayrulewidth \vskip2\arrayrulewidth
   \hrule \@height \arrayrulewidth \vskip\doublerulesep
   \futurelet \@tempa\@xhline}
\def\thickhline{\noalign{\ifnum0=`}\fi
   \hrule \@height 2\arrayrulewidth\futurelet \@tempa\@xhline}
\def\doublehline{\noalign{\ifnum0=`}\fi
   \hrule \@height \arrayrulewidth\vskip2\arrayrulewidth
   \hrule \@height \arrayrulewidth \futurelet \@tempa\@xhline}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*{\cal}{\@fontswitch{\relax}{\mathcal}}
\DeclareRobustCommand*{\mit}{\@fontswitch{\relax}{\mathnormal}}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg {2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{3}
\if@journal
   \let\tableofcontents\relax
   \let\smalltableofcontents\relax
   \def\journalcontents{\journalpart*{\contentsname}
          \@starttoc{jou}}
\else
   \newcommand\tableofcontents{%
       \let\smalltableofcontents\relax
       \section*{\contentsname
           \@mkboth{\contentsname}{\contentsname}}%
       \@starttoc{toc}%
       }
   \newcommand\smalltableofcontents{%
      \let\tableofcontents\relax
       \subsubsection*{\contentsname
           \@mkboth{\contentsname}{\contentsname}}%
       \begin{small}
       \@starttoc{toc}%
       \end{small}}
\fi
\newcommand\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{\@secpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \setlength\@tempdima{3em}%
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       {\sss@font#1}\hfil \hbox to\@pnumwidth{\hss #2}}\par
       \nobreak
       \if@compatibility
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}
      \fi
    \endgroup
  \fi}
\if@journal
  \newcommand\l@titles[2]{%
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode #1%
      \nobreak\leaders\hbox{%
          $\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}\hfill
      \nobreak \hbox to\@pnumwidth{\hfil\rm #2}\par
      \penalty\@highpenalty
    \endgroup}
\fi
\newcommand\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\l@subsection   {\@dottedtocline{2}{1.5em}{2.3em}}
\newcommand\l@subsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\newcommand\l@paragraph    {\@dottedtocline{4}{7.0em}{4.1em}}
\newcommand\l@subparagraph {\@dottedtocline{5}{10em}{5em}}
\if@journal
  \let\listoffigures\relax
  \let\smalllistoffigures\relax
  \let\listoftables\relax
  \let\smalllistoftables\relax
\else
  \newcommand\listoffigures{%
      \let\smalllistoffigures\relax
      \section*{\listfigurename
        \@mkboth{\listfigurename}{\listfigurename}}%
      \@starttoc{lof}%
      }
  \newcommand\smalllistoffigures{%
      \let\listoffigures\relax
      \subsubsection*{\listfigurename
        \@mkboth{\listfigurename}{\listfigurename}}%
      \begin{small}
      \@starttoc{lof}%
      \end{small}
      }
  \newcommand\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
  \newcommand\listoftables{%
      \let\smalllistoftables\relax
      \section*{\listtablename
        \@mkboth{\listtablename}{\listtablename}}%
    \@starttoc{lot}%
    }
  \newcommand\smalllistoftables{%
      \let\listoftables\relax
      \subsubsection*{\listtablename
        \@mkboth{\listtablename}{\listtablename}}%
      \begin{small}
      \@starttoc{lot}%
      \end{small}
    }
  \let\l@table\l@figure
\fi
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\section*{\refname
        \@mkboth{\refname}{\refname}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\if@journal
  \def\@mainbblfile{\jobname.bbl}
  \let\@bblfile=\@mainbblfile
  \def\bibliography#1{%
    \if@filesw\immediate\write\@auxout{\string\bibdata{#1}}\fi
    \@input{\@bblfile}}
  \def\@include#1 {\clearpage
    \if@filesw \immediate\write\@mainaux{\string\@input{#1.aux}}\fi
    \@tempswatrue
    \if@partsw \@tempswafalse\edef\@tempb{#1}
       \@for\@tempa:=\@partlist\do{\ifx\@tempa\@tempb\@tempswatrue\fi}
    \fi
    \if@tempswa
       \if@filesw \let\@auxout=\@partaux
           \immediate\openout\@partaux #1.aux
           \immediate\write\@partaux{\relax}
       \fi
       \def\@bblfile{#1.bbl}\@input{#1.tex}
       \let\@bblfile\@mainbblfile\clearpage
       \@writeckpt{#1}
       \if@filesw
          \immediate\closeout\@partaux
       \fi
       \let\@auxout=\@mainaux\else\@nameuse{cp@#1}
   \fi}
\fi
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\section*{\indexname}]%
                \@mkboth{\indexname}%
                        {\indexname}%
                \thispagestyle{empty}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem  {\par\hangindent 40\p@}
\newcommand\subitem   {\par\hangindent 40\p@ \hspace*{20\p@}}
\newcommand\subsubitem{\par\hangindent 40\p@ \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}
\if@noind
  \long\def\@makefntext#1{%
        \leftskip 2.0em%
        \noindent
        \hbox to 0em{\hss\@makefnmark\kern 0.25em}#1}
\else
  \long\def\@makefntext#1{%
      \parindent 1em%
      \noindent
      \hbox to 1.8em{\hss\@makefnmark\kern 0.25em}#1}
\fi
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\refname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\newcommand\figureshortname{Fig.}                      % <-- paper
\newcommand\tableshortname{Tab.}                       % <-- paper
\newcommand\keywordname{Keywords}                      % <-- paper
\newcommand\draftname{preliminary draft}               % <-- paper
\newcommand\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\iffinal
  \if@journal
    \ps@journal
  \else
    \ps@headings
  \fi
\else
  \ps@draft
\fi
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\endinput
%%
%% End of file `paper.cls'.
