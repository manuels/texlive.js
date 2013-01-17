%%
%% This is file `octavo.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% octavo.dtx  (with options: `octavo')
%% 
%% Copyright 2003, 2007 Stefan A. Revets
%% 
%% Author : Stefan A. Revets
%%          s.revets@bigpond.com
%% 
%% The program is provided under the terms of the LaTeX Project Public License
%% distributed from CTAN archives in directory macros/latex/base/lppl.txt
%% 
%% This file is part of the Octavo Package, for the typesetting of books along
%% classical layout and design ideas. It is a modification of the standard LaTeX
%% book class, written by Lamport (1992), Mittelbach and Braams (1994-1997).
%% 
%% The program consists of the files octavo.ins and octavo.dtx.
%% 
%%
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{octavo}
              [2007/03/07 v1.2
 a LaTeX document class]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\newif\if@openbib
\@openbibfalse
\newif\if@mainmatter
\@mainmattertrue
\DeclareOption{foolscap}
    {\setlength\paperheight{171mm}%
    \setlength\paperwidth{108mm}}
\DeclareOption{crown}
    {\setlength\paperheight{191mm}%
    \setlength\paperwidth{127mm}}
\DeclareOption{post}
    {\setlength\paperheight{194mm}%
    \setlength\paperwidth{122mm}}
\DeclareOption{largepost}
    {\setlength\paperheight{210mm}%
    \setlength\paperwidth{137mm}}
\DeclareOption{demy}
    {\setlength\paperheight{222mm}%
    \setlength\paperwidth{143mm}}
\DeclareOption{medium}
    {\setlength\paperheight{229mm}%
    \setlength\paperwidth{146mm}}
\DeclareOption{royal}
    {\setlength\paperheight{254mm}%
    \setlength\paperwidth{159mm}}
\DeclareOption{superroyal}
    {\setlength\paperheight{267mm}%
    \setlength\paperwidth{171mm}}
\DeclareOption{imperial}
    {\setlength\paperheight{279mm}%
    \setlength\paperwidth{191mm}}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{twoside}{\@twosidetrue \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{titlepage}{\@titlepagetrue}
\DeclareOption{notitlepage}{\@titlepagefalse}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{\@openbibtrue}
\ExecuteOptions{crown,10pt,twoside,final,notitlepage,openright,onecolumn}
\ProcessOptions
\input{oct1\@ptsize.clo}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\@lowpenalty 51
\@medpenalty 151
\@highpenalty 301
\setlength\headheight{12\p@}
\setlength\maxdepth{0.5\topskip}
\setlength{\topmargin}{0.1\paperheight}
    \addtolength{\topmargin}{-\headheight}
    \addtolength{\topmargin}{-\headsep}
    \addtolength{\topmargin}{-1in}
\setlength{\textwidth}{0.7\paperwidth}
    \@settopoint\textwidth
\setlength\@tempdima{0.7\paperheight}
    \addtolength\@tempdima{-\topskip}
    \addtolength\@tempdima{5\p@}
    \divide\@tempdima\baselineskip
    \@tempcnta=\@tempdima
    \setlength\textheight{\@tempcnta\baselineskip}
    \addtolength\textheight{\topskip}
\setlength{\evensidemargin}{0.2\paperwidth}
\addtolength{\evensidemargin}{-1in}
\setlength{\oddsidemargin}{0.1\paperwidth}
\addtolength{\oddsidemargin}{-1in}
\if@twocolumn
    \setlength\marginparsep{10\p@}
\else
\fi
\setlength\@tempdima{\paperwidth}
    \addtolength\@tempdima{-\textwidth}
    \addtolength\@tempdima{-\oddsidemargin}
    \addtolength\@tempdima{-\marginparsep}
    \addtolength\@tempdima{-30\p@}
    \setlength\marginparwidth{\@tempdima}
    \@settopoint\marginparwidth
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.5}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\def\ps@headings{%
    \def\@oddfoot{\hfil\thepage\hfil}%
    \def\@evenfoot{\hfil\thepage\hfil}%
    \def\@evenhead{\hfil{\scshape\leftmark}\hfil}%
    \def\@oddhead{\hfil{\scshape\rightmark}\hfil}%
    \let\@mkboth\markboth
\def\chaptermark##1{%
    \markboth {%
    \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
            \@chapapp\ \thechapter. \ %
        \fi
    \fi
    ##1}{}}%
\def\sectionmark##1{%
    \markright {%
    \ifnum \c@secnumdepth >\z@
        \thesection. \ %
    \fi
    ##1}}}
\def\ps@myheadings{%
    \def\@oddfoot{\hfil\thepage\hfil}%
    \def\@evenfoot{\hfil\thepage\hfil}%
    \def\@evenhead{\hfil{\scshape\leftmark}\hfil}%
    \def\@oddhead{\hfil{\scshape\rightmark}\hfil}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble}
\if@titlepage
    \newcommand\maketitle{\begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \let\footnote\thanks
    \null\vfil
    \vskip 60\p@
    \begin{center}%
        {\LARGE \@title \par}%
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
    \let\thanks\relax
    \let\maketitle\relax
    \gdef\@thanks{}
    \gdef\@author{}
    \gdef\@title{}}
\fi
\setcounter{secnumdepth}{-2}
\newcounter{part}
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\renewcommand\thepart{\@Roman\c@part}
\renewcommand\thechapter{\@arabic\c@chapter}
\renewcommand\thesection{\thechapter.\@arabic\c@section}
\renewcommand\thesubsection{\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph{\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph{\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
\newcommand\frontmatter{\cleardoublepage
    \@mainmatterfalse\pagenumbering{roman}}
\newcommand\mainmatter{\cleardoublepage
    \@mainmattertrue\pagenumbering{arabic}}
\newcommand\backmatter{\cleardoublepage
    \@mainmatterfalse}
\newcommand\part{\cleardoublepage
    \thispagestyle{plain}%
    \if@twocolumn
        \onecolumn
        \@tempswatrue
    \else
        \@tempswafalse
    \fi
    \hbox{}\vfil
    \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
        \refstepcounter{part}%
        \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
        \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
    \interlinepenalty \@M
    \normalfont
    \ifnum \c@secnumdepth >-2\relax
        \huge \partname~\thepart
        \par
        \vskip 20\p@
    \fi
    \Huge #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
    \interlinepenalty \@M
    \normalfont
    \Huge #1\par}%
    \@endpart}
\def\@endpart{%
    \vfil\newpage
    \hbox{}%
    \thispagestyle{empty}%
    \newpage
    \if@tempswa
        \twocolumn
    \fi}
\newcommand\chapter{%
    \if@openright\cleardoublepage
    \else\clearpage
    \fi
    \thispagestyle{plain}%
    \global\@topnum\z@
    \@afterindentfalse
    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
            \refstepcounter{chapter}%
            \typeout{\@chapapp\space\thechapter.}%
            \addcontentsline{toc}{chapter}%
            {\protect\numberline{\thechapter}#1}%
        \else
            \addcontentsline{toc}{chapter}{#1}%
        \fi
    \else
        \addcontentsline{toc}{chapter}{#1}%
    \fi
    \chaptermark{#1}%
    \addtocontents{lof}{\protect\addvspace{10\p@}}%
    \addtocontents{lot}{\protect\addvspace{10\p@}}%
    \if@twocolumn
        \@topnewpage[\@makechapterhead{#2}]%
    \else
        \@makechapterhead{#2}%
        \@afterheading
    \fi}
\def\@makechapterhead#1{%
    \vspace*{4\baselineskip}%
    {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
            \Large \@chapapp{} \thechapter
            \par\nobreak
            \ifnum \@ptsize < 1
                \vskip 26\p@
            \else
                \vskip 22\p@
            \fi
        \fi
    \fi
    \interlinepenalty\@M
    \Large #1\par\nobreak
    \vskip 34\p@ \@minus 4\p@
    }}
\def\@schapter#1{%
    \if@twocolumn
        \@topnewpage[\@makeschapterhead{#1}]%
    \else
        \@makeschapterhead{#1}%
        \@afterheading
    \fi}
\def\@makeschapterhead#1{%
    \vspace*{4\baselineskip}%
    {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Large #1\par\nobreak
    \ifnum \@ptsize < 1
        \vskip 30\p@
    \else
        \vskip 34.8\p@
    \fi
    }}
\newcommand\section{%
    \@startsection{section}%
    {1}%
    {0em}%
    {-1.166\baselineskip \@minus -2\p@}%
    {0.835\baselineskip \@minus 2\p@}%
    {\centering\large\normalfont\scshape}}
\newcommand\subsection{%
    \@startsection{subsection}%
    {2}%
    {1em}%
    {-0.666\baselineskip \@minus -2\p@}%
    {0.333\baselineskip \@minus 2\p@}%
    {\normalfont\normalsize\scshape}}
\newcommand\subsubsection{%
    \@startsection{subsubsection}%
    {3}%
    {1em}%
    {-0.666\baselineskip \@minus -2\p@}%
    {0.333\baselineskip \@minus 2\p@}%
    {\normalfont\normalsize\itshape}}
\newcommand\paragraph{%
    \@startsection{paragraph}%
    {4}%
    {\z@}%
    {0\p@}%
    {-1em}%
    {\normalfont\normalsize}}
\newcommand\subparagraph{%
    \@startsection{subparagraph}%
    {5}%
    {\parindent}%
    {0\p@}%
    {-1em}%
    {\normalfont\normalsize}}
\if@twocolumn
    \setlength\leftmargini{2em}
\else
    \setlength\leftmargini{2.5em}
\fi
\setlength\leftmargin{\leftmargini}
\setlength\leftmarginii{2.2em}
\setlength\leftmarginiii{1.87em}
\setlength\leftmarginiv{1.7em}
\if@twocolumn
    \setlength\leftmarginv{.5em}
    \setlength\leftmarginvi{.5em}
\else
    \setlength\leftmarginv{1em}
    \setlength\leftmarginvi{1em}
\fi
\setlength\labelsep{.5em}
\setlength\labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty -\@lowpenalty
\@itempenalty -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\normalfont\bfseries --}
\newcommand\labelitemii{$\m@th\cdot$}
\newcommand\labelitemiii{$\m@th\bullet$}
\newcommand\labelitemiv{$\m@th\ast$}
\newenvironment{description}
    {\list{}%
    {\labelwidth\z@%
    \itemindent-\leftmargin%
    \let\makelabel\descriptionlabel}}%
    {\endlist}
\newcommand*\descriptionlabel[1]{%
    \hspace\labelsep%
    \normalfont\bfseries #1}
\newenvironment{verse}
    {\let\\=\@centercr
    \list{}{\itemsep \z@
    \itemindent -1.5em%
    \listparindent\itemindent
    \rightmargin \leftmargin
    \advance\leftmargin 1.5em}%
    \item[]}
    {\endlist}
\newenvironment{quotation}
    {\list{}{\listparindent 1.5em%
    \itemindent \listparindent
    \rightmargin \leftmargin
    \parsep \z@}%
    \item[]}
    {\endlist}
\newenvironment{quote}
    {\list{}%
    {\rightmargin\leftmargin}%
    \item[]}
    {\endlist}
\newenvironment{titlepage}{%
    \cleardoublepage
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse\newpage
    \fi
    \thispagestyle{empty}}%
    {\if@restonecol
        \twocolumn
    \else
        \newpage
    \fi}
\newcommand\appendix{\par
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
    \renewcommand\@chapapp{\appendixname}%
    \renewcommand\thechapter{\@Alph\c@chapter}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\renewcommand\theequation{\@arabic\c@equation}
\newcounter{figure}
\renewcommand\thefigure{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
    {\@float{figure}}
    {\end@float}
\newenvironment{figure*}
    {\@dblfloat{figure}}
    {\end@dblfloat}
\newcounter{table}
\renewcommand\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
    {\@float{table}}
    {\end@float}
\newenvironment{table*}
    {\@dblfloat{table}}
    {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
    \vskip\abovecaptionskip
    \sbox\@tempboxa{#1: #2}%
    \ifdim \wd\@tempboxa >\hsize
        #1: #2\par
    \else
        \global \@minipagefalse
        \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
    \fi
    \vskip\belowcaptionskip}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4500}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
        \MakeUppercase\contentsname}
        {\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol
        \twocolumn
    \fi}
\newcommand*\l@part[2]{%
    \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
        \setlength\@tempdima{3em}%
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        {\leavevmode
        \large #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
        \nobreak
        \global\@nobreaktrue
        \everypar{\global\@nobreakfalse\everypar{}}
    \endgroup
    \fi}
\newcommand*\l@chapter[2]{%
    \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \leavevmode
        \advance\leftskip\@tempdima
        \hskip -\leftskip
        #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
        \penalty\@highpenalty
    \endgroup
    \fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listfigurename
        \@mkboth{\MakeUppercase\listfigurename}%
        {\MakeUppercase\listfigurename}}%
        \@starttoc{lof}%
        \if@restonecol\twocolumn
    \fi}
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\listtablename
        \@mkboth{%
        \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
        \@starttoc{lot}%
        \if@restonecol\twocolumn
    \fi}
\let\l@table\l@figure
\newdimen\bibindent
\bibindent=1.5em
\newenvironment{thebibliography}[1]
    {\chapter*{\bibname
        \@mkboth{\MakeUppercase\bibname}
        {\MakeUppercase\bibname}}%
    \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \if@openbib
            \advance\leftmargin\bibindent
            \itemindent -\bibindent
            \listparindent \itemindent
            \parsep \z@
        \fi
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
        \if@openbib
            \renewcommand\newblock{\par}%
        \else
            \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
        \fi
        \sloppy
        \clubpenalty4000
        \@clubpenalty \clubpenalty
        \widowpenalty4000
        \sfcode`\.=\@m}
        {\def\@noitemerr
        {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist}
\newcommand\newblock{}
\newenvironment{theindex}
    {\if@twocolumn
        \@restonecolfalse
    \else
        \@restonecoltrue
    \fi
    \columnseprule \z@
    \columnsep 35\p@
    \twocolumn[\@makeschapterhead{\indexname}]%
    \@mkboth{\MakeUppercase\indexname}%
    {\MakeUppercase\indexname}%
    \thispagestyle{plain}\parindent\z@
    \parskip\z@ \@plus .3\p@\relax
    \let\item\@idxitem}
    {\if@restonecol
        \onecolumn
    \else
        \clearpage
    \fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\par\hangindent 40\p@ \hspace*{20\p@}}
\newcommand\subsubitem{\par\hangindent 40\p@ \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\today{\number\day \ \ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \ \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{headings}
\pagenumbering{arabic}
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\endinput
%%
%% End of file `octavo.cls'.
