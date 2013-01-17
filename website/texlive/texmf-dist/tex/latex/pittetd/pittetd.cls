%%
%% This is file `pittetd.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pittetd.dtx  (with options: `class')
%% The `pittetd' project: Electronic Theses and Dissertations
%%                        at the University of Pittsburgh.
%% 
%% Copyright 2003-4 Federico Garcia and Pitt ETD Working Group
%% 
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pittetd}[2004/08/17 v1.618
    University of Pittsburgh ETD
    (Electronic Thesis & Dissertations) class]
\newwrite\@etdaux
\newif\if@errors
\newif\if@keywords
\newif\if@tables
\newif\if@figures
\newif\if@mainmatter\@mainmattertrue
\newif\if@hyper@ref\@hyper@reftrue
\newif\if@secletters
\newif\if@yeargiven\@yeargivenfalse
\newif\if@dategiven\@dategiventrue
\newlength\@chapterl
\newlength\@sectionl
\newlength\@subsectionl
\newlength\@subsubsectionl
\newlength\@singleline
\newlength\@presubs
\newlength\@presubsub
\newlength\@floatl
\newdimen\bibindent
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\newcounter{@members}\setcounter{@members}{0}
\newcounter{@addprel}\setcounter{@addprel}{8}
\newcounter{@appno}\setcounter{@appno}{0}
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}
\newcounter{subparagraph}
\newcounter{figure}
\newcounter{table}
\newtoks\@expectedprelim
\newtoks\@committee
\newtoks\@coadv
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
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
        \renewcommand\newblock{\par}}}
\newcommand\t@or@d{}
\newcommand\@this{}
\newcommand\@@@degree{}
\DeclareOption{phd}{\renewcommand{\t@or@d}{phd}%
    \renewcommand\@this{Dissertation}%
    \renewcommand\@@@degree{PhD}%
    \def\@degreesought{\textbf{Doctor of Philosophy}}%
    \def\@advisor{Director}}
\DeclareOption{ma}{\renewcommand{\t@or@d}{ma}%
    \renewcommand\@this{Thesis}%
    \renewcommand\@@@degree{M.A.}%
    \def\@degreesought{\textbf{Master of Arts}}%
    \def\@advisor{Advisor}}
\DeclareOption{ms}{\renewcommand{\t@or@d}{ms}%
    \renewcommand\@this{Thesis}%
    \renewcommand\@@@degree{M.S.}%
    \def\@degreesought{\textbf{Master of Sciences}}%
    \def\@advisor{Advisor}}
\DeclareOption{sectionnumbers}{\@seclettersfalse}
\DeclareOption{sectionletters}{\@secletterstrue}
\DeclareOption{draft}{\setlength{\overfullrule}{5pt}}
\DeclareOption{semifinal}{\setlength{\overfullrule}{5pt}}
\DeclareOption{final}{\setlength{\overfullrule}{0pt}%
    \@errorstrue}
\DeclareOption{nohyperref}{\let\nameref\ref\@hyper@reffalse}
\ExecuteOptions{12pt,semifinal,hyperref,phd}
\ProcessOptions
\newcommand\@linemessage[2]{%
    \if@errors
        \ClassError{pittetd}{#1}{#2}
    \else
        \ClassWarning{pittetd}{#1}
    \fi}
\newcommand\@nolinemessage[2]{\if@errors
    \ClassError{pittetd}{#1}{#2}\else
    \ClassWarningNoLine{pittetd}{#1}\fi}
\input{pitetd1\@ptsize.clo}
\let\Small\footnotesize
\let\SMALL\scriptsize
\let\bibindent\parindent
\normalfont
\setlength\@chapterl{1.5em}
\setlength\@sectionl{1.5em}
\setlength\@subsectionl{1em}
\setlength\@subsubsectionl{1em}
\setlength\@floatl{2.3em}
\newcommand\@phd{phd}
\newcommand\contentsname{CONTENTS}
\newcommand\listfigurename{LIST OF FIGURES}
\newcommand\listtablename{LIST OF TABLES}
\newcommand\bibname{BIBLIOGRAPHY}
\newcommand\indexname{INDEX}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{APPENDIX}
\newcommand\abstractname{}
\newcommand\convname{CONVENTIONS}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\InputIfFileExists{\jobname.etd}{}{%
    \if@errors
        \ClassWarningNoLine{pittetd}{%
            No \jobname.etd file. Entering semifinal mode}%
        \@errorsfalse
    \fi}
\if@errors\else\AtEndDocument{\ClassWarningNoLine{pittetd}{%
    Remember to run the document with `final' option}}\fi
\setlength\@presubs{1\@sectionl}
\addtolength\@presubs{1\@chapterl}
\setlength\@presubsub{1\@presubs}
\addtolength\@presubsub{1\@subsectionl}
\newcommand*\l@chapter{%
    \@dottedtocline{0}{\z@}{\@chapterl}}
\newcommand*\l@section{%
    \@dottedtocline{1}{\@chapterl}{\@sectionl}}
\newcommand*\l@subsection{%
    \@dottedtocline{2}{\@presubs}{\@subsectionl}}
\newcommand*\l@subsubsection{%
    \@dottedtocline{3}{\@presubsub}{\@subsubsectionl}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins=\skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset{equation}{chapter}
\renewcommand\theequation{\ifnum \c@chapter>\z@
    \thechapter.\fi\@arabic\c@equation}
\pagestyle{plain}
\pagenumbering{roman}
\setcounter{footnote}{0}
\let\@openbib@code\@empty
\@twosidefalse
\@mparswitchfalse
\@twocolumnfalse
\let\period@or@not\relax
\def\@withperiod{\def\period@or@not{.}}
\let\gobble@or@not\relax
\def\@withgobble{\let\gobble@or@not\@gobble}
\renewcommand\thechapter{\if@secletters
    \expandafter\@Roman\c@chapter\period@or@not
    \else\@arabic\c@chapter\fi}
\renewcommand\thesection{\if@secletters
        \gobble@or@not{\thechapter.}\expandafter\@Alph
        \c@section\period@or@not
    \else\thechapter.\@arabic\c@section\fi}
\renewcommand\thesubsection{\if@secletters
        \gobble@or@not{\thesection.}\@arabic
        \c@subsection\period@or@not
    \else\thesection.\@arabic\c@subsection\fi}
\renewcommand\thesubsubsection{\if@secletters
        \gobble@or@not{\thesubsection.}\@alph
        \c@subsubsection\period@or@not
    \else\thesubsection.\@arabic\c@subsubsection\fi}
\newcommand\pdfstringdefPreHook{%
    \let\acro\relax
    \let\ignorespaces\relax
    \let\gobble@or@not\@gobble
    \def\period@or@not{.}}
\renewcommand\thefigure{\@arabic\c@figure}
\renewcommand\thetable{\@arabic\c@table}
\newcommand\chapterfloats{\@addtoreset{figure}{chapter}%
    \@addtoreset{table}{chapter}%
    \renewcommand\thefigure{%
        \if@mainmatter
            \if@secletters
                \expandafter\@Roman\c@chapter
            \else\@arabic\c@chapter
            \fi.%
        \else\expandafter\@Alph\c@chapter\fi
        \@arabic\c@figure}%
    \renewcommand\thetable{%
        \if@mainmatter
            \if@secletters
                \expandafter\@Roman\c@chapter
            \else\@arabic\c@chapter
            \fi.%
        \else\expandafter\@Alph\c@chapter\fi
        \@arabic\c@table}}
\@onlypreamble\chapterfloats
\newcommand\regularenum{%
    \renewcommand\theenumi{\@arabic\c@enumi}%
    \renewcommand\theenumii{\@alph\c@enumii}%
    \renewcommand\theenumiii{\@roman\c@enumiii}%
    \renewcommand\theenumiv{\@Alph\c@enumiv}}
\if@secletters
    \renewcommand\theenumi{\@Roman\c@enumi}
    \renewcommand\theenumii{\@Alph\c@enumii}
    \renewcommand\theenumiii{\@arabic\c@enumiii}
    \renewcommand\theenumiv{\@alph\c@enumiv}
\else\regularenum\fi
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\setlength\parskip{0\p@ \@plus \p@}
\setlength{\smallskipamount}{%
    .25\@singleline \@plus 1\p@ \@minus 1\p@}
\setlength{\medskipamount}{%
    .5\@singleline \@plus 2\p@ \@minus 2\p@}
\setlength{\bigskipamount}{%
    1\@singleline \@plus 4\p@ \@minus 4\p@}
\@lowpenalty 51
\@medpenalty 151
\@highpenalty 301
\clubpenalty 250
\widowpenalty 250
\setlength\paperwidth{8.5in}
\setlength\textwidth{6.5in}
\setlength\oddsidemargin{\z@}
\setlength\paperheight{11in}
\setlength\textheight{9in}
\setlength\topskip{1\@ptsize \p@}
\setlength\maxdepth{.5\topskip}
\setlength\footskip{.5in}
\setlength\topmargin{\z@}
\setlength\headheight{\z@}
\setlength\headsep{\z@}
\setlength\marginparwidth{\z@}
\setlength\marginparsep{\z@}
\AtBeginDocument{\@ifpackageloaded{showidx}{%
    \setlength\marginparwidth{1in}
    \setlength\marginparsep{2pt}}{}}
\setcounter{topnumber}{2}
\renewcommand{\topfraction}{.5}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setlength{\@fptop}{0\p@ \@plus 1fill}
\setlength{\@fpsep}{8\p@ \@plus 1fill}
\setlength{\@fpbot}{0\p@ \@plus 1fill}
\setlength{\floatsep}{.5\@singleline \@plus \z@ \@minus 10.2\p@}
\setlength{\textfloatsep}%
    {1.5\@singleline \@plus \z@ \@minus 10.2\p@}
\setlength{\intextsep}{.5\@singleline \@plus \z@ \@minus 10.2\p@}
\setlength\abovecaptionskip{\@singleline}
\setlength\belowcaptionskip{\@singleline}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\@ifundefined{acro}{%
    \DeclareRobustCommand\SMC{%
    \ifx\@currsize\normalsize\small\else
    \ifx\@currsize\singlesize\small\else
    \ifx\@currsize\small\footnotesize\else
        \ifx\@currsize\footnotesize\scriptsize\else
        \ifx\@currsize\large\normalsize\else
        \ifx\@currsize\Large\large\else
        \ifx\@currsize\LARGE\Large\else
            \ifx\@currsize\scriptsize\tiny\else
            \ifx\@currsize\tiny\tiny\else
            \ifx\@currsize\huge\LARGE\else
            \ifx\@currsize\Huge\huge\else
                \small\SMC@unknown@warning
    \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
    }
    \newcommand\SMC@unknown@warning{\ClassWarning{pittetd}{%
        \string\SMC: unrecognized text font size
        command---using \string\small}}
    \newcommand\textSMC[1]{{\SMC #1}}
    \newcommand\acro[1]{\textSMC{#1}\@}}{}
\if@hyper@ref
    \AtEndOfClass{%
        \usepackage[bookmarks,hyperindex=false]{hyperref}%
        \def\@pdfcreator{LaTeX, pittetd class, hyperref package}}
    \AtBeginDocument{%
        \hypersetup{letterpaper,bookmarksnumbered,%
            colorlinks,bookmarksopen,%
            linkcolor=blue,citecolor=blue,urlcolor=blue,%
            pdftitle=\@pdftitle,pdfauthor=\@author,%
            pdfkeywords=\@keywords,%
            pdfsubject=\the\subject}}
\fi
\AtBeginDocument{\@ifpackageloaded{hyperref}{%
    \let\maketitle\HyOrg@maketitle
    \@hyper@reftrue}{%
    \@hyper@reffalse
    \let\texorpdfstring\@firstoftwo}}
\newcommand*\patch[1]{\InputIfFileExists{#1.pit}{%
            \ClassInfo{pittetd}{Patch for #1 loaded}}{%
            \ClassInfo{pittetd}{No patch found for #1}}}
\newcommand*\usewithpatch[2][\@empty]{%
    \ifx\@empty#1\usepackage{#2}\else\usepackage[#1]{#2}\fi%
    \patch{#2}}
\@onlypreamble\patch
\renewcommand*{\title}[2][\@empty]{%
    \gdef\@title{#2}\ifx\@empty#1%
        \gdef\@pdftitle{#2}%
    \else\gdef\@pdftitle{#1}\fi}
\renewcommand{\thanks}[1]{\ClassWarning{pittetd}{%
    The argument of \string\thanks\space has been ignored.}}
\renewcommand*{\date}[1]{%
    \sbox\@tempboxa{\normalfont #1}
    \ifnum\wd\@tempboxa>0\global\@dategiventrue
    \else\global\@dategivenfalse\fi
    \gdef\@date{\ #1\ }}
\edef\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or
  December\fi\space\number\day, \number\year}
\date{\today}
\edef\@year{\number\year}
\renewcommand{\year}[1]{%
    \gdef\@year{#1}\@yeargiventrue}
\newcommand\@degree{\@nolinemessage{No \string\degree\space
    command}{It is required to list the author's previous
    degree(s). Use the \string\degree\space (or \string\previousdegree\space command.}}
\newcommand\@school{\@nolinemessage{No \string\school\space
    command}{It is required to name the school (and
    optionally the department). Use the \string\school\space
    command.}}
\newcommand\@@school{\relax}
\newcommand{\degree}[1]{\gdef\@degree{#1}}
\let\previousdegree\degree
\newcommand\school[2][the]{\gdef\@school{#1\ #2}%
    \gdef\@@school{\uppercase{#2}}}
\newcommand\degreesought[1]{\def\@degreesought{#1}}
\newtoks\subject
\def\@keywords{}
\newcommand\keywords[1]{\gdef\@keywords{#1}}
\@onlypreamble\subject
\@onlypreamble\keywords
\newcommand\@enable[2]{%
    \global\expandafter\let\csname @#1message\endcsname\relax
    \global\@expectedprelim{#2}}
\newcommand\@disable[1]{%
    \global\expandafter\def\csname @#1message\endcsname{%
        \@linemessage{Something is missing or misplaced.
            I was expecting \the\@expectedprelim}{%
            The preliminaries should be placed in the next order:
            \MessageBreak title, committee, [copyright],
            abstract, [preface/foreword], tableofcontents,
            [listoftables], [listoffigures].\MessageBreak
            \MessageBreak I think something is either missing or
            misplaced in your document. I will typeset things in
            the given order, but you should double-check.}}}
\newcommand\@@disable[2]{%
    \global\expandafter\def\csname @#1message\endcsname{%
        \@linemessage{There is no #2}{I have found no #2, so it
        makes no sense to me to include a list of them.
        Proceed, but expect an ugly heading followed by
        nothing...}}}
\@enable{title}{\maketitle}
\@disable{committee}
\@disable{copyright}
\@disable{abstract}
\@disable{preface}
\@disable{table}
\@disable{lof}
\@disable{lot}
\@disable{conv}
\newcommand\maketitle{\@titlemessage
    \if@dategiven
        \if@yeargiven\else
            \ClassWarningNoLine{pittetd}{%
                I assumed `\@year' for the year.
                You can use \string\year\space to change it}%
        \fi
    \fi
    \@ifundefined{@outlinefile}{}{%
        \hypertarget{prelim.0}{}%
        \protected@write\@outlinefile{}{%
            \protect\BOOKMARK
            [0][]{prelim.0}{TITLE PAGE}{}}}
    \thispagestyle{empty}%
    {\centering
        \fontsize\@xviipt{1.5\@singleline}\selectfont
        \null\vskip 1.3\@singleline
        {\bfseries\uppercase\expandafter{\@title}}\par
        \vfill
        by\par
        {\bfseries\@author}\par
        {\let\noexpand\relax\@degree}\par
        \vfill
        Submitted to the Graduate Faculty of\par
        \@school\ in partial fulfillment\par
        of the requirements for the degree of\par
        \@degreesought\par
        \vfill
        University of Pittsburgh\par
        \@year\par}
    \@enable{committee}{\makecommittee}
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\title\relax
    \global\let\author\relax
    \global\let\and\relax}
\def\@commline{\ifhmode\\\else\relax\fi}
\def\committeemember#1{%
    \stepcounter{@members}
    \@committee\expandafter{\the\@committee#1\@commline}}
\newcommand\makecommittee{\clearpage\@committeemessage
    \ifnum\value{@members}>0
        \@ifundefined{@outlinefile}{}{%
            \hypertarget{prelim.1}{}%
            \protected@write\@outlinefile{}{%
                \protect\BOOKMARK
                [0][]{prelim.1}{COMMITTEE MEMBERSHIP PAGE}{}}}
        \@committee\expandafter{\the\@committee\relax}%
        {\centering
        \normalsize\fontsize\f@size{1.3\@singleline}\selectfont
        \null\vskip 1.3\@singleline
        UNIVERSITY OF PITTSBURGH\par
        \@@school\par
        \vfill
        This \lowercase\expandafter{\@this} was presented\\
        by\\[.67\@singleline]\@author\\[.67\@singleline]
        \if@dategiven
            It was defended on\\
            \@date\\ \else\ClassWarningNoLine{pittetd}{%
            You really should provide the date of the defense
            (command \string\date)}\fi
        \ifnum\value{@members}>1
            \if@dategiven and \else It was \fi
            approved by\\
            \the\@committee
            \expandafter\@getadvisor\the\@committee
        \else
            \ifx\t@or@d\@phd\@linemessage{Just one committee
            member}{For Ph. D. dissertations, the whole committee
            must be included. For the moment, I will typeset only
            the advisor.}\fi
            \vfill\fi
        \@this\ \@advisor: \the\@committee\the\@coadv
        \vfill
        \newpage}
        \renewcommand\committeemember[1]{\ClassError{pittetd}{%
            Command \string\committeemember\space after
            \string\makecommittee}{The new name will just be
            ignored.}}
        \let\makecommittee\relax
    \else\@linemessage{No members for the committee}{%
        I will ignore the \string\makecommittee\space command
        until you give me some names.}
    \fi
    \@enable{copyright}{\begin{abstract}}%
    \@enable{abstract}{\begin{abstract}}}
\def\@getadvisor#1\@commline#2\relax{\@committee{#1}}
\newcommand\coadvisor[1]{%
    \renewcommand\@advisor{Advisors}%
    \@coadv{,\\#1}}
\newcommand\copyrightpage{\clearpage\@copyrightmessage
    \null\vfill
    {\centering\normalsize Copyright
        \textcopyright\ by \@author\\\@year\\}%
    \vfill\newpage
    \@enable{abstract}{\begin{abstract}}}
\newenvironment{abstract}[1][\@empty]
    {\ifx\@empty#1\else\@keywordstrue\def\@tempcsa{#1}\fi
    \clearpage\@abstractmessage
    \@afterindentfalse
    \typeout{Abstract}%
    \@ifundefined{@outlinefile}{}{%
        \hypertarget{prelim.2}{}%
        \protected@write\@outlinefile{}{%
            \protect\BOOKMARK
            [0][]{prelim.2}{ABSTRACT}{}}}
    \null\nobreak\vskip 1in
    {\centering\normalfont
        {\bfseries\uppercase
        \expandafter{\@title}}\\[.3\@singleline]
        \@author, \@@@degree\\[.3\@singleline]
        University of Pittsburgh, \@year\par}
    \par\vspace{1\@singleline}\@afterheading}%
    {\if@keywords
        \medskip\begin{description}\item[\@tempcsa]\@keywords
        {\normalsfcodes\ifnum\spacefactor=\sfcode`.\else.\fi}
        \end{description}\fi
    \@disable{copyright}%
    \newpage\@enable{table}{\tableofcontents}}
\newenvironment{abstract*}[1][\@empty]
    {\ifx\@empty#1\else\@keywordstrue\def\@tempcsa{#1}\fi
    \clearpage\@abstractmessage
    \@afterindentfalse
    \typeout{Abstract}%
    \@ifundefined{@outlinefile}{}{%
        \hypertarget{prelim.2}{}%
        \protected@write\@outlinefile{}{%
            \protect\BOOKMARK
            [0][]{prelim.2}{ABSTRACT}{}}}
    \null\nobreak\vskip 1in
    {\centering\normalfont
        {\bfseries ABSTRACT\\[.3\@singleline]
        \uppercase\expandafter{\@title}}\\[.3\@singleline]
        \@author, \@@@degree\\[.3\@singleline]
        University of Pittsburgh, \@year\par}
    \par\vspace{1\@singleline}\@afterheading}%
    {\if@keywords
        \medskip\begin{description}\item[\@tempcsa]\@keywords
        {\normalsfcodes\ifnum\spacefactor=\sfcode`.\else.\fi}
        \end{description}\fi
    \@disable{copyright}%
    \newpage\@enable{table}{\tableofcontents}}
\newcommand\tableofcontents{\clearpage\@tablemessage
    \typeout{Table of Contents}%
    \@ifundefined{@outlinefile}{}{%
        \hypertarget{prelim.4}{}%
        \protected@write\@outlinefile{}{%
            \protect\BOOKMARK
            [0][]{prelim.4}{TABLE OF CONTENTS}{}}
    }
    \null\vskip 1in
    {\normalfont\bfseries\centering
        TABLE OF CONTENTS\par}
    \par\vspace{54\p@}%
    {\@withperiod\@withgobble\@starttoc{toc}}%
    \if@tables
        \@enable{lot}{\listoftables}%
    \else
        \@@disable{lot}{tables}
        \if@figures
            \@enable{lof}{\listoffigures}%
        \else
            \@@disable{lof}{figures}%
            \@enable{preface}{the first chapter}%
            \@enable{conv}{the first chapter}%
        \fi
    \fi\@disable{preface}}
\def\prepare@bookmarks#1{%
    \def\@prelim{#1}%
    \def\numberline##1{##1. }
    \let\\\relax
    \def\contentsline##1##2##3##4{%
       \pdfstringdef\@tempcsa{##2}%
       \@expandedBOOKMARK{##4}{\@tempcsa}{prelim.\@prelim}}}
\def\@expandedBOOKMARK#1#2{\edef\reserved@a{%
    \noexpand\BOOKMARK[1][-]{#1}{#2}}\reserved@a}
\newcommand\listoftables{\clearpage\@lotmessage
    \typeout{List of Tables}%
    \@ifundefined{@outlinefile}{}{%
        \hypertarget{prelim.5}{}%
        \protected@write\@outlinefile{}{%
            \protect\BOOKMARK
            [0][]{prelim.5}{LIST OF TABLES}{}%
            \protect\begingroup\protect\makeatletter
            \protect\prepare@bookmarks5
            \protect\@input{\jobname.lot}
            \protect\endgroup}}
    \null\vskip 1in
    {\normalfont\bfseries\centering
        LIST OF TABLES\par}
    \par\vspace{54\p@}%
    \@starttoc{lot}%
    \newpage
    \if@figures\@enable{lof}{\listoffigures}\else
        \@enable{preface}{the first chapter}%
        \@enable{conv}{the first chapter}%
    \fi}
\newcommand*\l@table{\@dottedtocline{1}{1.5em}{\@floatl}}
\newcommand\listoffigures{\clearpage\@lofmessage
    \typeout{List of Figures}%
    \@ifundefined{@outlinefile}{}{%
        \hypertarget{prelim.6}{}%
        \protected@write\@outlinefile{}{%
            \protect\BOOKMARK
            [0][]{prelim.6}{LIST OF FIGURES}{}%
            \protect\begingroup\protect\makeatletter
            \protect\prepare@bookmarks6
            \protect\@input{\jobname.lof}
            \protect\endgroup}}
    \null\vskip 1in
    {\normalfont\bfseries\centering
        LIST OF FIGURES\par}
    \par\vspace{54\p@}%
    \@starttoc{lof}\newpage
    \@enable{preface}{the first chapter}%
    \@disable{lot}}
\let\l@figure\l@table
\newcommand\preface{%
    \clearpage\@prefacemessage
    \@afterindentfalse
    \typeout{Preface}%
    \addcontentsline{toc}{chapter}{\bfseries PREFACE}
     \null\vskip 1in
    {\normalfont\bfseries\centering
        PREFACE\par}
    \par\vspace{1.5\@singleline}
    \@enable{conv}{the first chapter}%
    \@afterheading}
\newcommand\preliminarychapter[1]{%
    \clearpage\@afterindentfalse
    \typeout{#1}
    \@ifundefined{@outlinefile}{}{%
        \hypertarget{prelim.\the\c@@addprel}{}%
        \protected@write\@outlinefile{}{%
            \protect\BOOKMARK
            [0][]{prelim.\the\c@@addprel}{#1}{}}
        }%
    \null\vskip 1in
    {\normalfont\bfseries\centering
        #1\par}
    \par\vspace{1.5\@singleline}
    \@afterheading}
\def\@startsection#1#2#3#4#5#6{%
    \if@noskipsec \leavevmode \fi
    \par
    \@afterindentfalse
    \@tempskipa #4\relax
    \@tempskipa -\@tempskipa
    \if@nobreak
        \everypar{}%
    \else
        \addpenalty\@secpenalty\addvspace\@tempskipa
    \fi
    \@ifstar
        {\ClassWarning{pittetd}{Starred
            \expandafter\string\csname #1\endcsname*\space
            has been treated as
            \expandafter\string\csname #1\endcsname}%
        \@ssect{#3}{#4}{#5}{#6}}%
        {\@ssect{#3}{#4}{#5}{#6}}}
\def\@startbody{%
    \pagenumbering{arabic}%
    \global\def\@startsection##1##2##3##4##5##6{%
        \@getlength{##1}%
        \if@noskipsec \leavevmode \fi
        \par
        \@afterindentfalse
        \@tempskipa ##4\relax
        \@tempskipa -\@tempskipa
        \if@nobreak
            \everypar{}%
        \else
            \addpenalty\@secpenalty\addvspace\@tempskipa
        \fi
        \@ifstar
            {\ClassWarning{pittetd}{Starred
                \expandafter\string\csname ##1\endcsname*\space
                has been treated as
                \expandafter\string\csname ##1\endcsname}%
            \@dblarg{\@sect{##1}{##2}{##3}{##4}{##5}{##6}}}%
            {\@dblarg{\@sect{##1}{##2}{##3}{##4}{##5}{##6}}}}%
    \renewcommand\chapter{\clearpage\global\@topnum\z@
        \@afterindentfalse
        \@ifstar{%
            \ClassWarning{pittetd}{Starred
                \string\chapter*\space has been treated as
                \string\chapter}%
            \@dblarg{\@chapter}}{\@dblarg\@chapter}}}
\newcommand\chapter{\clearpage\@startbody\chapter}
\def\@chapter[#1]#2{%
    \refstepcounter{chapter}%
    \@getlengthchapter
    {\@withperiod\typeout{Chapter\space\thechapter}}%
    \uppercase{\@@chapter{#1}}%
    \null\vskip 1in
    {\@withperiod\normalfont\bfseries\centering
        \if@mainmatter\thechapter\if@secletters\else.0\fi\quad\fi
        \uppercase\expandafter{#2}\par}
    \par\vspace{2\@singleline}\@afterheading}
\def\@@chapter#1{\addcontentsline{toc}{chapter}{{\bfseries
    \protect\numberline{\thechapter\if@secletters\else.0\fi}#1}}}
\newcommand\section{\@startsection{section}{1}%
    {\z@}{-2\@singleline \@plus -1ex \@minus -.2ex}%
    {1\@singleline \@plus .2ex}{\@withperiod\@withgobble%
    \centering\normalfont\bfseries\expandafter\MakeUppercase}}
\newcommand\subsection{\@startsection{subsection}%
    {2}{\z@}{-1\@singleline\@plus -1ex \@minus -.2ex}%
    {.5\@singleline \@plus .2ex}%
    {\@withperiod\@withgobble\normalfont\expandafter\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}%
    {3}{\z@}{-1\@singleline \@plus -1ex \@minus -.2ex}%
    {-1em}{\@withperiod\@withgobble
        \normalfont\expandafter\bfseries}}
\let\part\@gobble
\let\paragraph\@gobble
\let\subparagraph\@gobble
\newcommand\@getlengthchapter{\begingroup\normalfont
    \@withgobble\@withperiod
    \settowidth\@tempskipa{%
        {\bfseries\thechapter\if@secletters\else0\fi}\quad
        \mbox{}}%
    \ifnum\@tempskipa > \@chapterl
        \global\@chapterl =\@tempskipa
    \fi
    \endgroup}
\newcommand\@getlength[1]{\begingroup\normalfont
    \@withgobble\@withperiod
    \stepcounter{#1}%
    \settowidth\@tempskipa{\csname the#1\endcsname.\ \mbox{}}%
    \ifnum\@tempskipa > \csname @#1l\endcsname
        \global\csname @#1l\endcsname = \@tempskipa
    \fi
    \addtocounter{#1}{-1}
    \endgroup}
\newcommand\appendix{%
    \@mainmatterfalse
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
    \ifnum 2>\value{@appno}
        \gdef\thechapter{}%
        \gdef\thesection{A.\@arabic\c@section}%
    \else
        \gdef\thechapter{ \@Alph{\c@chapter}}
    \fi
    \renewcommand\chapter{\clearpage\global\@topnum\z@
        \@afterindentfalse
        \protected@write\@auxout{}%
            {\string\stepcounter{\string @appno}}%
        \@ifstar{%
            \ClassWarning{pittetd}{Starred
                \string\chapter*\space has been treated as
                \string\chapter}%
            \@dblarg{\@appendix}}{\@dblarg\@appendix}}
    \let\appendix\relax}
\def\@appendix[#1]#2{\refstepcounter{chapter}%
    \xdef\@currentlabelname{\appendixname\thechapter}%
    \typeout{Appendix\thechapter}%
    \uppercase{\@@appendix{#1}}%
    \null\vskip 1in
    {\normalfont\bfseries\centering
        APPENDIX\thechapter\\[2\@singleline]
        \uppercase\expandafter{#2}\par}
    \par\vspace{2\@singleline}\@afterheading}
\def\@@appendix#1{\addcontentsline{toc}{chapter}{%
    {\bfseries APPENDIX\thechapter. #1}}}
\let\frontmatter\relax
\let\backmatter\relax
\let\mainmatter\relax
\def\fps@table{tbp}
\def\ftype@table{1}
\def\ext@table{lot}
\def\fnum@table{Table\nobreakspace\thetable}
\newenvironment{table}
    {\global\@tablestrue
        \singlespace\@float{table}}{%
        \end@float
        \settowidth\@tempskipa{%
            \thetable\ \mbox{}}%
        \ifnum\@tempskipa > \@floatl
            \global\@floatl = \@tempskipa
        \fi}
\newenvironment{table*}
    {\global\@tablestrue
        \singlespace\@dblfloat{table}}{%
        \end@dblfloat
        \settowidth\@tempskipa{%
            \thetable\ \mbox{}}%
        \ifnum\@tempskipa > \@floatl
            \global\@floatl = \@tempskipa
        \fi}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{Figure\nobreakspace\thefigure}
\newenvironment{figure}
    {\global\@figurestrue
        \singlespace\@float{figure}}{%
        \end@float
        \settowidth\@tempskipa{%
            \thefigure\ \mbox{}}%
        \ifnum\@tempskipa > \@floatl
            \global\@floatl = \@tempskipa
        \fi}
\newenvironment{figure*}
    {\global\@figurestrue
        \singlespace\@dblfloat{figure}}{%
        \end@dblfloat
        \settowidth\@tempskipa{%
            \thefigure\ \mbox{}}%
        \ifnum\@tempskipa > \@floatl
            \global\@floatl = \@tempskipa
        \fi}
\def\@makecaption#1#2{%
    \vskip\abovecaptionskip
    \sbox\@tempboxa{#1: #2}%
    \ifdim \wd\@tempboxa >\hsize
        {\let\nobreakspace\space\ClassWarning{pittetd}{%
            The caption of #1 is longer than one line}}%
            #1: #2\par
    \else
        \global\@minipagefalse
        \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
    \fi
    \vskip\belowcaptionskip}
\setlength\leftmargini\parindent
\leftmargin\leftmargini
\setlength\leftmarginii{2.2em}
\setlength\leftmarginiii{1.87em}
\setlength\leftmarginiv{1.7em}
\setlength\leftmarginv{1em}
\setlength\leftmarginvi{1em}
\setlength\labelsep{.5em}
\setlength\labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\setlength\partopsep{\@ptsize\p@ \@plus 1\p@ \@minus 1\p@}
\addtolength\partopsep{1.5\p@}
\@beginparpenalty -\@lowpenalty
\@endparpenalty -\@lowpenalty
\@itempenalty -\@lowpenalty
\def\@listi{\topsep\smallskipamount
    \leftmargin\leftmargini
    \parsep \z@ \@plus 2\p@
    \itemsep \z@ \@plus 2\p@}
\let\@listI\@listi\@listi
\def\@listii{\leftmargin\leftmarginii
    \labelwidth\leftmarginii
    \advance\labelwidth-\labelsep
    \topsep \z@ \@plus 2\p@
    \parsep \z@ \@plus\p@
    \itemsep \parsep}
\def\@listiii{\leftmargin\leftmarginiii
    \labelwidth\leftmariniii
    \advance\labelwidth-\labelsep
    \topsep \z@ \@plus\p@
    \parsep \z@
    \itemsep \topsep}
\def\@listiv{\leftmargin\leftmarginiv
    \labelwidth\leftmarginiv
    \advance\labelwidth-\labelsep}
\def\@listiv{\leftmargin\leftmarginv
    \labelwidth\leftmarginv
    \advance\labelwidth-\labelsep}
\def\@listiv{\leftmargin\leftmarginvi
    \labelwidth\leftmarginvi
    \advance\labelwidth-\labelsep}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\theenumii.}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries\textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
    {\list{}{\labelwidth\z@ \itemindent-\leftmargin
        \let\makelabel\descriptionlabel}}
    {\endlist}
\newcommand*\descriptionlabel[1]{%
    \hspace\labelsep\normalfont\bfseries #1}
\newenvironment{verse}
    {\let\\\@centercr
    \list{}{\itemsep \z@
        \itemindent -1.5em
        \listparindent\itemindent
        \rightmargin\leftmargin
        \advance\leftmargin 1.5em}
    \item\relax}
    {\endlist}
\newenvironment{quotation}\relax\relax
\newenvironment{quote}\relax\relax
\renewenvironment{quotation}
    {\list{}{\topsep\medskipamount
        \listparindent 1.5em\relax
        \itemindent \listparindent
        \rightmargin \leftmargin
        \parsep \z@ \@plus\p@}
    \item\small\relax}
    {\endlist}
\renewenvironment{quote}
    {\list{}{\topsep\medskipamount
        \rightmargin\leftmargin}%
        \item\relax\small}
    {\endlist}
\renewcommand\footnoterule{%
    \kern-3\p@
    \hrule\@width.3\columnwidth
    \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newenvironment{thebibliography}[1]{%
    \@safebibliography
    \list{\@biblabel{\@arabic\c@enumiv}}%
    {\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m}
    {\def\@noitemerr{\@latex@warning{Empty
        `thebibliography' environment}}%
    \endlist}
\newcommand\@safebibliography{%
    \renewcommand\chapter{\@ifstar{\@gobble}{\@gobble}}%
    \renewcommand\section{\@ifstar{\@gobble}{\@gobble}}%
    \renewcommand\@mkboth[2]{\relax}%
    \clearpage\null\vskip 1in
    \typeout{\bibname}%
    \@ifundefined{@outlinefile}{}{\phantomsection}%
    \addcontentsline{toc}{chapter}{{\bfseries\protect\bibname}}%
    {\normalfont\bfseries\centering\bibname\par}%
    \par\vspace{2\@singleline}%
    \singlespace
    \let\@listi\@listI
    \setlength{\itemsep}{.5\@singleline \@plus 4\p@}%
    \def\@listi{\topsep\z@
        \leftmargin\leftmargini
        \parsep \z@ \@plus 2\p@
        \itemsep .5\@singleline \@plus 2\p@}
    \@afterheading
    \let\@safebibliography\relax}
\newcommand\safebibliography{\@safebibliography\bibliography}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\AtBeginDocument{\@ifundefined{bibsep}{}{%
    \setlength{\bibsep}{.5\@singleline \@plus 4\p@}}}
\newenvironment{theindex}{%
    \clearpage\typeout{\indexname}%
    \@ifundefined{@outlinefile}{}{\phantomsection}%
    \addcontentsline{toc}{chapter}{{\bfseries\protect\indexname}}%
    \twocolumn[\null\vskip 1in{\normalfont\bfseries\centering
        \indexname\par}\par\vspace{2\@singleline}]%
    \thispagestyle{plain}\parindent\z@
    \columnseprule \z@
    \columnsep 35\p@
    \parskip\z@ \@plus .3\p@\relax
    \small
    \let\item\@idxitem}
    {\clearpage}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par\vskip10\p@ \@plus5\p@ \@minus3\p@
    \relax}
\AtEndDocument{\immediate\openout\@etdaux=\jobname.etd
    \if@tables
        \immediate\write\@etdaux{\string\@tablestrue}
    \fi
    \if@figures
        \immediate\write\@etdaux{\string\@figurestrue}
    \fi
    \immediate\write\@etdaux{%
      \string\setlength{\string\@chapterl}{\the\@chapterl}}
    \immediate\write\@etdaux{%
      \string\setlength{\string\@sectionl}{\the\@sectionl}}
    \immediate\write\@etdaux{%
      \string\setlength{\string\@subsectionl}{\the\@subsectionl}}
    \immediate\write\@etdaux{%
      \string\setlength{\string\@subsubsectionl}{\the\@subsubsectionl}}
    \immediate\write\@etdaux{%
      \string\setlength{\string\@floatl}{\the\@floatl}}
    \immediate\closeout\@etdaux}
\endinput
%%
%% End of file `pittetd.cls'.
