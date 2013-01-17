%%   $Id: dtk.cls 36 2012-05-02 19:43:14Z herbert $
%%
%% This is file `dtk.cls',
%%
%% LaTeX Class for ``Die TeXnische Komoedie''.
%%
%% Copyright (C) 1995-1996 Gerd Neugebauer
%% Copyright (C) 1997-2012 DANTE, Deutschsprachige
%%                                Anwendervereinigung TeX e.V.
%%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%
\def\filename{dtk.cls}
\def\fileversion{1.29}
\def\filedate{2012/05/30}
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{dtk}[\filedate~\fileversion~ dtk document class (gn,rn,hv)]
\let\DTKversion=\fileversion
\let\DTKdate=\filedate
\newif\ifDTK@Author@
\DTK@Author@true
\newif\ifDTK@Draft@
\newif\ifDTK@lineno@
\DTK@lineno@false
\newif\ifDTK@numeric@
\DTK@numeric@true
\newif\ifDTK@german@
\DTK@german@true
\ifx\documentclass\@undefined
  \newcommand\RequirePackage[1]{
    \chardef\DTK@cat=\the\catcode`\@
    \catcode`\@=11
    \input{#1.sty}%
    \catcode`\@=\DTK@cat}
  \let\LoadClass=\RequirePackage
  \newcommand\InputIfFileExists[3]{%
    \openin\DTK@file #1
    \ifeof\DTK@file\closein\DTK@file #3%
    \else\closein\DTK@file #2\input{#1}%
    \fi}
  \newcommand\DeclareOption{\@ifstar{\@gobble}{\DTK@DeclareOption}}
  \newcommand\DTK@DeclareOption[2]{\@namedef{ds@#1}{#2}}
  \let\ProcessOptions=\relax
  \let\OptionNotUsed=\gobble
  \def\ProvidesClass#1[#2]{\typeout{Document Style #1 #2}}
  \newcommand\emph[1]{{\em #1}\/}
  \newcommand\textbf[1]{{\bf #1}}
  \newcommand\textrm[1]{{\rm #1}}
  \newcommand\textsc[1]{{\sc #1}}
  \newcommand\textsf[1]{{\sf #1}}
  \newcommand\textsl[1]{{\sl #1\/}}
  \newcommand\textit[1]{{\it #1\/}}
  \newcommand\texttt[1]{{\tt #1}}

  \@ifundefined{fontshape}{\let\fontshape=\@gobble}{}
  \@ifundefined{selectfont}{\let\selectfont=\relax}{}

  \newcommand\providescommand[2]{\ifx#1\@undefined\newcommand#1{#2}\fi}
\fi
\newread\DTK@file
\ProvidesClass{dtk}[\filedate\space\fileversion\space  gene]
\newcommand\DTK@isnum[1]{%
  \if!\ifnum9<1#1!\else_\fi
      \expandafter\@firstoftwo
  \else
      \expandafter\@secondoftwo
  \fi
}
\newcommand*\DTK@@thelinenumber{\thepage-\arabic{linenumber}}
%%%%
\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{full}{\DTK@Author@false}
\DeclareOption{omitgerman}{\DTK@german@false}
\DeclareOption{alpha}{\DTK@numeric@false}
\DeclareOption{ancient}{\def\DTK@layout{95}}
\DeclareOption{draft}{%
  \DTK@Draft@true
  \DTK@lineno@true
  \PassOptionsToPackage{pagewise}{lineno}%
  \PassOptionsToClass{\CurrentOption}{book}%
}
\DeclareOption{linenumbers}{\DTK@lineno@true}
\DeclareOption{nolinenumbers}{\DTK@lineno@false}
\DeclareOption{pagewise}{%
  \PassOptionsToPackage{\CurrentOption}{lineno}}
\DeclareOption{running}{%
  \PassOptionsToPackage{\CurrentOption}{lineno}}
\DeclareOption{ln-long}{\def\DTK@@thelinenumber{%
  %\def\Hugo{%
  \ifoddNumberedPage% eigtl. Even!!!
    \ifodd\c@page
      \@tempswatrue %C
    \else
      \@tempswafalse %D
    \fi
  \else
    \ifodd\c@page
      \@tempswafalse %A
    \else
      \@tempswatrue %B
    \fi
  \fi
  %}\Hugo
  %\@tempcnta=\c@page
  %\if@tempswa \advance\@tempcnta\@ne \fi
  \if@tempswa \advance\c@page\@ne \fi
  %\edef\thepage{\the\@tempcnta}%
  \thepage-\arabic{linenumber}}}
\DeclareOption{ln-short}{\def\DTK@@thelinenumber{%
  \arabic{linenumber}}}
\iffalse% RN 2005-01-15
\DeclareOption{95}{\def\DTK@layout{95}}
\DeclareOption{96}{\def\DTK@layout{96}}
\DeclareOption{97}{\def\DTK@layout{97}}
\DeclareOption{98}{\def\DTK@layout{98}}
\DeclareOption{99}{\def\DTK@layout{99}}
\DeclareOption{00}{\def\DTK@layout{00}}
\DeclareOption{01}{\def\DTK@layout{01}}
\DeclareOption{02}{\def\DTK@layout{02}}
\DeclareOption{08}{\def\DTK@layout{08}}
\DeclareOption{10}{\def\DTK@layout{10}}
\DeclareOption{11}{\def\DTK@layout{11}}
\DeclareOption{12}{\def\DTK@layout{12}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\else
\DeclareOption*{%
  \DTK@isnum{\CurrentOption}%
    {\edef\DTK@layout{\CurrentOption}}%
    {\PassOptionsToClass{\CurrentOption}{book}}%
}
\fi
\ProcessOptions
\LoadClass{book}
\ifDTK@lineno@
  \RequirePackage{lineno}\linenumbers
  \RequirePackage{xcolor}%
  \linenumbersep=.8ex
  \def\linenumberfont{\normalfont\scriptsize\sffamily\bfseries}%
  \definecolor{DTK@lineno@color}{cmyk}{0.26,0,0.76,0}% SpringGreen
  \def\thelinenumber{%
  \begingroup
    \fboxsep=.3ex\fcolorbox{black}{DTK@lineno@color}{%
      \DTK@@thelinenumber}%
  \endgroup}%
\fi
%%%%%%%%%%
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\ifluatex
  \RequirePackage{textcomp}
  \RequirePackage{eurosym}
  \let\EURO\euro
  \RequirePackage{amsmath}
%  \PassOptionsToPackage{no-math}{fontspec}
  \RequirePackage%[mono={Scale=0.82}]
  {libertineotf}
  \RequirePackage{unicode-math}  
  \setmathfont%[math-style=TeX,
%                  bold-style=TeX]
{Latin Modern Math} 
  \setmathfont[range={\mathcal,\mathbfcal}]{XITS Math} 
%  \setmainfont[Ligatures=TeX]{Linux Libertine O}
%  \setsansfont[Ligatures=TeX]{Linux Biolinum O}
  \g@addto@macro{\sffamily}{\fontdimen5\font=\fontcharht\font`\x}

%  \setmainfont[Scale=0.95,Ligatures=TeX]{TeX Gyre Pagella}
%  \setsansfont[Scale=0.90,Ligatures=TeX]{TeX Gyre Heros}
%  \setmonofont[Scale=0.81,Ligatures=TeX]{Bitstream Vera Sans Mono}
  \setmonofont[Scale=0.81,Ligatures=TeX]{Luxi Mono}
%  \setmonofont[Scale=1.05,Ligatures=TeX]{LMMonoLtCond10-Regular}
%  \setmathrm[ItalicFont=LMRoman10-Italic,
%             BoldItalicFont=LMRoman10-BoldItalic]{Latin Modern Math}
%  \setmathsf{Latin Modern Math}
%  \setmathtt{Latin Modern Math}
%  \setboldmathrm{Latin Modern Math}
  \usepackage{luacode}
%  \usepackage[utf8]{luainputenc}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage{mathpazo}
  \RequirePackage[scale=0.95]{tgpagella}
  \RequirePackage[scale=0.92]{tgheros}
  \RequirePackage[scaled=0.83]{beramono}

  \ifDTK@Author@\else\RequirePackage[utf8]{inputenc}\fi
  \RequirePackage[full]{textcomp}
  \RequirePackage{cmap}
\fi
\RequirePackage[factor=1500,verbose=true,final=true]{microtype}
%
\usepackage{fixltx2e}
\RequirePackage{afterpage}
\usepackage[hyphens]{url}
\DeclareRobustCommand*{\URL}{\url}
\usepackage[newcommands,newparameters]{ragged2e}
\usepackage{filecontents}

\RequirePackage{babel}
\RequirePackage{tabularx}
%\RequirePackage{eurosym}
%\AtBeginDocument{\DeclareTextCommandDefault{\texteuro}{\euro}}% ???
\RequirePackage{graphicx}
\RequirePackage{xspace,shortvrb}
\RequirePackage[bottom,marginal]{footmisc}
\RequirePackage{array}
\RequirePackage{enumerate}
\RequirePackage{booktabs}
\RequirePackage{subfig}
\RequirePackage{setspace}

\RequirePackage{multicol}
\ifDTK@Author@\else
  \RequirePackage{graphicx,xcolor}
  \errorcontextlines=100\relax
\fi
\RequirePackage{dtklogos}
\paperwidth  = 148.5mm
\paperheight = 210mm
\textheight = 485pt           %%%%471pt
\textwidth  = 333pt
\oddsidemargin  = 0pt
\evensidemargin = \oddsidemargin\oddsidemargin  -35.89157pt
\evensidemargin -17.70235pt
\topmargin  -55.66684pt
\headheight = 17pt
\headsep    = 17pt
\footskip = 24pt
\parskip   = 0.3\baselineskip \advance\parskip by 0pt plus 2pt
\parindent = 0pt
\renewcommand\topfraction{.9}
\renewcommand\bottomfraction{.9}
\renewcommand\textfraction{.1}
\columnsep = 5pt
\emergencystretch = 1.5em
\raggedbottom
\clubpenalty  = 10000
\widowpenalty = 10000
\marginparwidth=1cm
\@ifdefinable\DTK@orig@marginpar{\let\DTK@orig@marginpar\marginpar}
\renewcommand*\marginpar{%
  \ClassWarning{dtk}{Command `\string\marginpar' not expected}%
  \DTK@orig@marginpar}
\newcommand\DTKgerman{
  \let\DTK@captionsgerman=\captionsgerman
  \let\captionsgerman=\DTK@captionsgerman
  \@ifundefined{l@ngerman}{}{\selectlanguage{ngerman}}%
}
\newcommand\DTK@captionsgerman{%
  \DTK@captionsgerman%
  \gdef\refname{Literatur}%
  \gdef\bibname{Literatur}%
  \gdef\contentsname{Inhalt Heft \Volume}%
}
\ifDTK@german@
  \DTKgerman
\fi
\newcommand\addressname{Autoren/Organisatoren}
\newcommand\journalname{Die \TeX nische Kom\"odie}
\newcommand\Volume{?/??}
\newcommand\volume{\Volume\ --- Entwurf \today\
  \begingroup
    \count1=\time\divide\count1 60
    \count2=\count1 \multiply\count2 -60 \advance\count2\time
    \ifnum\count1<10 0\fi\the\count1:\ifnum\count2<10 0\fi\the\count2
  \endgroup
}
\newcommand*\DTK@corr@version{}
\ifDTK@Author@\else
  \newcommand*\DTK@today{}%
  \begingroup
    \count@\time
    \divide\count@ 60\relax
    \count2=-\count@
    \multiply\count2 60\relax
    \advance\count2 \time
    %% \loggingall %% Wuduh!
    \xdef\DTK@today{%
      \the\year-\two@digits{\the\month}-\two@digits{\the\day}% %!!! \the
      %\protect~% Warum geht das nicht?
      \noexpand\noexpand~%
      %% Wuduh! 2 \noexpand noetig? Weil \number\the 2mal zuschlaegt?
      %% Ohne \the langt 1 \noexpand!
      \two@digits{\the\count@}:\two@digits{\the\count2}}%
      %%\show\DTK@today
  \endgroup
  \ifDTK@Draft@
    \def\DTK@corr@version{\fbox{Korrekturversion:~\DTK@today}}%
    \AtEndOfClass{%
      \let\ps@empty=\ps@plain
      \let\ps@part=\ps@plain}%
  \else
    \let\@LN\@gobbletwo% Wegen .aux-Datei von vorherigem lineno-Lauf
    \let\@LN@col\@gobble
  \fi
\fi
\newcommand\footmark{{\sffamily\journalname} \volume}
\newcommand\ChapterFont{\Large\sf}
\newcommand\SectionFont{\large\sf}
\newcommand\SubsectionFont{\normalsize\sf}
\newcommand\SubsubsectionFont{\normalsize\sf}
\newcommand\AuthorFont{\large\sf}
\newcommand\TitleFont{\Large\sf}
\newcommand\HeadFont{\sf\fontshape{sl}\selectfont}
\newcommand\FootFont{\footnotesize\sf\fontshape{sl}\selectfont}
\newcommand\PagenoFont{\sf}
\newcommand\NewpageThreshold{100pt}
\newcommand\HeadRuleDepth{0pt}
\newcommand\FootRuleDepth{0pt}
\newcommand\ContentsParSkip{1pt}
\newcommand\DTK@math{%
  \abovedisplayskip      = 4pt plus 2pt minus 1pt
  \belowdisplayskip      = \abovedisplayskip
  \abovedisplayshortskip = 2pt plus 2pt
  \belowdisplayshortskip = \abovedisplayshortskip
}
\let\DTK@@normalsize=\@normalsize
\def\@normalsize{%
  \DTK@@normalsize
  \DTK@math
  \let\@listi=\@listI}
\let\DTK@normalsize=\normalsize
\renewcommand\normalsize{%
  \DTK@normalsize
  \DTK@math
  \let\@listi=\@listI}
\normalsize
\let\DTK@small=\small
\renewcommand\small{%
  \DTK@small
  \DTK@math
  \let\@listi=\@listI}
\let\DTK@footnotesize=\footnotesize
\renewcommand\footnotesize{%
  \DTK@footnotesize
  \DTK@math
  \let\@listi=\@listI}
\begingroup
\gdef\Path@SepI{/""}
\gdef\Path@SepII{\symbol{92}""}
\gdef\Path@SepIII{:""}
\catcode`\/=13
\catcode`\:=13
\catcode`\^=0
^catcode`\\=13
^gdef^Path{^begingroup
  ^catcode`^/=13
  ^catcode`^\=13
  ^catcode`^:=13
  ^catcode`^~=12
  ^catcode`^$=12 %$
  ^catcode`^_=12
  ^catcode`^#=12
  ^let/=^Path@SepI
  ^let\=^Path@SepII
  ^let:=^Path@SepIII
  ^@Path}
^gdef^@Path#1{^texttt{#1}^endgroup}
^endgroup
\DeclareUrlCommand\File{\urlstyle{tt}}
\providecommand\Package[1]{\mbox{\texttt{#1}}}
\providecommand\Program[1]{\mbox{\texttt{#1}}}
\providecommand\Command[1]{\mbox{\texttt{#1}}}
\providecommand\Macro[1]{\mbox{\texttt{\textbackslash#1}}}
\providecommand\Environment[1]{\mbox{\texttt{#1}}}
\let\Env\Environment
\let\Email\url
\providecommand\Acronym[1]{\textsc{#1}}
\def\@listI{%
  \leftmargin = \leftmargini
  \parsep     = \parskip
  \topsep     = 0pt plus 2pt
  \itemsep    = 0pt plus 2pt}
\let\@listi=\@listI
\def\@listii{%
  \leftmargin = \leftmarginii
  \labelwidth = \leftmarginii
  \advance   \labelwidth by-\labelsep
  \parsep     = \parskip
  \topsep     = 0pt plus 2pt
  \itemsep    = 0pt plus 2pt}
\def\@listiii{%
  \leftmargin = \leftmarginiii
  \labelwidth = \leftmarginiii
  \advance   \labelwidth by-\labelsep
  \partopsep  = 1pt plus 0pt minus 1pt
  \parsep     = \parskip
  \topsep     = 0pt plus 2pt
  \itemsep    = 0pt plus 2pt}
\@listi
\renewcommand\labelitemi{$\m@th\circ$}
\renewcommand\labelitemii{$\m@th\triangleright$}
\renewcommand\labelitemiii{$\m@th\diamond$}
\setlength\leftmargini{1.5em}
\setlength\leftmarginii{1.4em}
\setlength\leftmarginiii{1.3em}
\setlength\leftmarginiv{1.2em}
\renewenvironment{description}{%
  \begin{list}{}{%
    \labelwidth = 0pt
    \itemindent = -\leftmargin
    \parsep     = \parskip
    \topsep     = 0pt plus 2pt
    \itemsep    = 0pt plus 2pt
    \let\makelabel=\descriptionlabel}%
  }{\end{list}}
\renewcommand\descriptionlabel[1]{%
  \hspace\labelsep{\normalsize\it #1}}
\renewenvironment{quotation}{%
  \list{}{\rightmargin\leftmargin}%
  \item\relax
}{\endlist}
\newenvironment{roll}%
  {\@ifnextchar[{\r@ll}{\r@ll[0pt]}}%
  {\end{list}}
\def\r@ll[#1]{\begin{list}{}{%
    \labelwidth = #1
    \leftmargin = \labelwidth
    \itemsep    = .3ex
    \let\makelabel=\rolllabel}%
  }
\newcommand\rolllabel[1]{\hspace\labelsep \textbf{#1}\hfill}
\newenvironment{example}{\begin{quote}\small}{\end{quote}}
%\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
%  ext@#1\endcsname}{#1}{\protect\numberline{\csname
%  the#1\endcsname}{\ignorespaces #2}}\begingroup
%    \@parboxrestore
%    \small
%    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
%  \endgroup}
\setcounter{secnumdepth}{0}
\newif\ifFirstArticle
\FirstArticletrue
\ifDTK@Author@
  \renewcommand\part{%
    \typeout{*** Parts can not be used in single articles.}}
\else
  \renewcommand\part{%
    \clearpage
    \thispagestyle{part}%
    \FirstArticletrue
    \Advance@Label@Prefix
    \@ifstar{\part@star{chapter}}{\part@star{part}}}
\fi
\newcommand\part@star[1]{%
  \@ifnextchar[{\part@optional{#1}}{\part@normal{#1}}}
\def\part@optional#1[#2]#3{%
  \markboth{#2}{#2}%
  \addcontentsline{toc}{#1}{#2}%
  \@ifnextchar[{\part@subtitle{#3}}{\part@nosubtitle{#3}}}
\newcommand\part@normal[2]{%
  \markboth{#2}{#2}%
  \addcontentsline{toc}{#1}{#2}%
  \@ifnextchar[{\part@subtitle{#2}}{\part@nosubtitle{#2}}}
\def\part@subtitle#1[#2]{\TopArt{#1}{\\#2}\bigskip\par}
\newcommand\part@nosubtitle[1]{\TopArt{#1}{}\bigskip\par}
\newcommand\TopArtRule{2pt}
\newcommand\TopArt[2]{%
  \begin{minipage}{\textwidth}\parskip=0pt\parindent=0pt
    \null\vspace{18pt}\par\raggedright\large\sf
    {\huge\sf #1}\\[-.5ex]\rule{\textwidth}{\TopArtRule}%
    \vspace{2pt} #2
  \end{minipage}}
\ifDTK@Author@
  \renewcommand\chapter{%
    \typeout{*** Chapters can not be used in single articles.}}
\else
  \renewcommand\chapter{%
    \@ifnextchar*{\chapter@star}{%
      \@ifnextchar[{\chapter@optional}{\chapter@normal}}}
\fi
\def\chapter@star*{\chapter}
\def\chapter@normal#1{\chapter@optional[#1]{#1}}
\def\chapter@optional[#1]{%
  \typeout{#1}%
  \Advance@Label@Prefix
  \addcontentsline{toc}{chapter}{#1}%
  \markboth{#1}{#1}%
  \FirstArticletrue
  \@startsection{chapter}{0}{\z@}{-1ex plus-1ex minus -.2ex}{.5ex plus.2ex}{\ChapterFont}*}
\renewcommand\section{\@startsection{section}{1}{\z@}{-2ex plus-1ex minus-.2ex}{0.2ex plus .1ex}{\SectionFont}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}{-2ex plus-1ex minus-.2ex}{2pt plus .1ex}{\SubsectionFont}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}{-2ex plus-1ex minus-.2ex}{0.2ex plus.1ex}{\SubsubsectionFont}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}{0ex plus1ex minus.2ex}{-.5ex}{\SubsubsectionFont}}
\renewcommand\subparagraph{\@startsection{subparagraph}{4}{\parindent}{0ex plus1ex minus.2ex}{-.5ex}{\SubsubsectionFont}}
%
\newcommand\keywords[1]{\def\DTK@keywords{#1}}
\def\DTK@keywords{}

\renewcommand\title[2][]{%
  \gdef\@title{#2}%
  \ifx\relax#1\relax\gdef\@@title{#2}\else\gdef\@@title{#1}\fi%
}

\renewcommand\maketitle[1][]{%
  \ifDTK@Author@ \thispagestyle{part}\fi
  \ifdim\DTKtitle@skip>0pt\vspace{\DTKtitle@skip}\fi
  \begingroup
    \dimen0=\vsize
    \advance\dimen0 by -\pagetotal
    \ifdim\dimen0<\NewpageThreshold
      \newpage
      \global\FirstArticletrue
    \fi
  \endgroup
  \Advance@Label@Prefix
  \begingroup
    \begin{minipage}{\textwidth}
      \ifFirstArticle
        \global\FirstArticlefalse
        \vskip 3pt
      \else
        \DTKtitle@sep
      \fi
      \setcounter{footnote}0
      \@flushglue=0pt plus .3\textwidth\relax
      \raggedright
      \TitleFont
      \spaceskip=\fontdimen2\font\relax
      \xspaceskip=\fontdimen7\font\relax
      \@title
      \ifx\@author\@empty\else
        \bigskip\par
        \AuthorFont\@author
      \fi
    \end{minipage}%
    \@thanks
    \let\thanks\@gobble
    \addcontentsline{toc}{chapter}{\@@title}%
  \endgroup
  \let\@title=\@empty
  \let\@author=\@empty
  \let\@thanks=\@empty
  \setcounter{figure}0
  \setcounter{table}0
  \setcounter{equation}0
  \medskip\par}

\newcommand\DTKtitle@skip{12pt}
\newcommand\DTKtitle@sep{\vspace{32pt plus 8pt minus 16pt}}
%
\renewcommand\and{, }
\let\@title=\@empty
\let\@author=\@empty
\let\@thanks=\@empty
\newenvironment{abstract}
  {\begin{quote}\small}
  {\end{quote}\medskip\par}
\renewcommand\thefigure{\arabic{figure}}
\renewcommand\thetable{\arabic{table}}
\renewcommand\theequation{\arabic{equation}}
\newcount\DTL@label
\DTL@label=0
\newcommand\Advance@Label@Prefix{%
  \advance\DTL@label 1
  \xdef\Label@Prefix{module \the\DTL@label:}}
\Advance@Label@Prefix
\let\Ref=\ref
\let\Label=\label
\let\Pageref=\pageref
\renewcommand\ref[1]{\Ref{\Label@Prefix:#1}}
\renewcommand\label[1]{\Label{\Label@Prefix:#1}}
\renewcommand\pageref[1]{\Pageref{\Label@Prefix:#1}}
\renewcommand\thebibliography[1]{%
  \section*{\refname}%
  \list{[\arabic{enumi}]}{%
    \settowidth\labelwidth{[#1]}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumi}}
  \def\newblock{\hskip .11em plus .33em minus .07em}
  \sloppy\clubpenalty4000\widowpenalty4000
  \sfcode`\.=1000\relax\DTK@bibliography@rightskip}
\newcommand\DTK@bibliography@rightskip{\rightskip=0pt plus 2em}
\newcommand\DTK@bibliography[1]{
  \InputIfFileExists{#1.bbl}{}{\typeout{--- File #1.bbl not found.}}}
\ifDTK@numeric@ \bibliographystyle{dtk} \else \bibliographystyle{alpha} \fi %%%%%% hv 20111024
\newcommand\DTK@fnrightmargin{0em}
\newcommand\DTK@fnleftmargin{1em}
\long\def\@makefntext#1{%
  \@nobreaktrue
  \begin{list}{}{%
      \rightmargin=0pt%
      \parsep=0.333\baselineskip plus 2pt
      \leftmargin=\DTK@fnleftmargin}
  \item\mbox{}%
     \llap{\@textsuperscript{\normalfont\@thefnmark}\kern1pt}%
     #1%
  \end{list}}
\@ifundefined{@textsuperscript}{%
  \def\@textsuperscript#1{%
    {\m@th\ensuremath{^{\mbox{\fontsize\sf@size\z@#1}}}}}
}{}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width0.333\columnwidth
  \kern2.6\p@}
\renewcommand\ps@plain{%
  \let\@mkboth=\@gobbletwo
  \let\chaptermark=\@gobble
  \let\sectionmark=\@gobble
  \let\subsectionmark=\@gobble
  \def\@oddhead{\vbox{\hbox to \textwidth{%
        \let\\=\relax
        \HeadFont \rightmark \hfil\PagenoFont\thepage}\kern 3pt
      \ifdim\HeadRuleDepth>0pt \hrule depth\HeadRuleDepth\fi}}%
  \def\@evenhead{\vbox{\hbox to \textwidth{%
        \let\\=\relax
        \PagenoFont \thepage\hfil\HeadFont \leftmark}\kern 3pt
      \ifdim\HeadRuleDepth>0pt \hrule depth\HeadRuleDepth\fi}}%
\iffalse% RN 2005-01-17
  \def\@oddfoot{\vbox{%
      \ifdim\FootRuleDepth>0pt \hrule depth\FootRuleDepth \fi
      \kern 5pt \hbox to \textwidth{\FootFont \footmark\hfil\null}}}%
  \def\@evenfoot{\vbox{%
      \ifdim\FootRuleDepth>0pt \hrule depth\FootRuleDepth \fi
      \kern 5pt \hbox to \textwidth{\null\hfil\FootFont \footmark}}}%
\else
  \def\@oddfoot{\vbox{%
      \ifdim\FootRuleDepth>0pt \hrule depth\FootRuleDepth \fi
      \kern 5pt \hbox to \textwidth{%
        \FootFont \footmark\hfil\DTK@corr@version\null}}}%
  \def\@evenfoot{\vbox{%
      \ifdim\FootRuleDepth>0pt \hrule depth\FootRuleDepth \fi
      \kern 5pt \hbox to \textwidth{%
        \null\FootFont\DTK@corr@version\hfil \footmark}}}%
\fi
}
\let\ps@headings\ps@plain
\newcommand\ps@part{%
  \let\@mkboth=\@gobbletwo
  \let\chaptermark=\@gobble
  \let\sectionmark=\@gobble
  \let\subsectionmark=\@gobble
  \let\@oddhead=\@empty
  \let\@evenhead=\@empty
\iffalse% RN 2005-01-17
  \def\@oddfoot{\vbox{%
      \ifdim\FootRuleDepth>0pt \hrule depth\FootRuleDepth \fi
      \kern 5pt \hbox to \textwidth{\FootFont \footmark\hfil\null}}}%
  \def\@evenfoot{\vbox{%
      \ifdim\FootRuleDepth>0pt \hrule depth\FootRuleDepth \fi
      \kern 5pt \hbox to \textwidth{\null\hfil\FootFont \footmark}}}%
\else
  \def\@oddfoot{\vbox{%
      \ifdim\FootRuleDepth>0pt \hrule depth\FootRuleDepth \fi
      \kern 5pt \hbox to \textwidth{%
        \FootFont \footmark\hfil\DTK@corr@version\null}}}%
  \def\@evenfoot{\vbox{%
      \ifdim\FootRuleDepth>0pt \hrule depth\FootRuleDepth \fi
      \kern 5pt \hbox to \textwidth{%
        \null\FootFont \DTK@corr@version\hfil\footmark}}}%
\fi
}
\pagestyle{plain}
\ifDTK@Author@
  \AtEndOfClass{%\show\DTK@jobname
  \InputIfFileExists{\DTK@jobname.inf}{%
  \renewcommand\volume{\Volume}}{}}%
\else
  \newcommand\DieTeXnischeKomoedie[3]{%
    \thispagestyle{empty}%
    \gdef\Volume{#1}%
    \xdef\volume{\Volume}%???
    \gdef\DTKedition{#2}%
    \gdef\DTKdate{#3}%
    \immediate\openout\@unused \jobname.inf\relax
    \immediate\write\@unused{%
      \string\gdef\string\Volume{#1}^^J%
      \string\gdef\string\DTKedition{#2}^^J%
      \string\gdef\string\DTKdate{#3}%
    }%
    \immediate\closeout\@unused
    \iffalse% RN 2005-02-20; unnoetig, da localer \jobname usw.
    \global\let\bibliography=\DTK@bibliography
    \global\let\bibliographystyle=\@gobble
    \fi
    \CoverArt{#1}{#2}{#3}%
    \newpage}
\fi
\newcommand\cover@sub[3]{%
 #2. Jahrgang\quad Heft #1\quad #3%
}
\ifDTK@Author@\else\definecolor{CoverArt@grey}{gray}{.8}\fi
\def\CoverArt@strip@no#1/#2;{#1\raisebox{0.35ex}{\CoverTitleFont/}#2}
\newcommand\CoverArt@linewidth{0pt}%{1.2pt}
\newcommand\CoverArt@barwidth{2.41pt}
\newcommand\CoverArt@font{\Large\raggedleft}
\newcommand\CoverArt@small{\footnotesize}
\newcommand\CoverArt@gap{2em}
\chardef\DTK@cat=\the\catcode`\"
\catcode`\"=13
\newcommand\address[3]{%
  \begingroup
    \def\"##1{\@ifundefined{detex@@##1}{##1}%
      {\csname detex@@##1\endcsname}}%
    \ifcat a\noexpand"\else\let"=\"\fi
    \def\ss{ss}%
    \let\'=\relax
    \let\`=\relax
    \let\^=\relax
    \let\.=\relax
    \let\==\relax
    \let\d=\relax
    \let\b=\relax
    \let\c=\relax
    \let\v=\relax
    \let\H=\relax
    \let\t=\relax
    \let\u=\relax
    \let\~=\relax
    \def\o{o}%
    \def\O{O}%
    \def\aa{aa}%
    \def\AA{Aa}%
    \def\l{l}%
    \def\L{L}%
    \def\ae{ae}%
    \def\AE{Ae}%
    \def\oe{oe}%
    \def\OE{Oe}%
    \def\TeX{TeX}%
    \def\LaTeX{LaTeX}%
    \def\LaTeXe{LaTeX2e}%
    \let\null=\relax
    \xdef\@ddress{#2, #1}%
  \endgroup
  \begingroup
    \def\\{\string\\}%
    \ifcat a\noexpand"\else\def\"{\string"}\fi
    \def"{\string"}%
    \def\null{}%
    \expandafter\@strip\@ddress$%$
    \iffalse% RN 2005-01-15
    \index{\STRIP@*#1 #2!#3}%
    \else
    \glossary{\STRIP@*#1 #2!#3}%
    \fi
  \endgroup
}
\catcode`\"=\DTK@cat
\let\strip@grp={
\let\strip@end=$%$
\def\@strip{\def\STRIP@{}\strip@I}
\def\strip@I{\let\strip@next=\strip@I
  \futurelet\strip@CHAR\strip@II}
\def\strip@II#1{%
  \ifx\strip@CHAR\strip@end
    \let\strip@next=\relax
  \else\ifx\strip@CHAR\strip@grp
    \strip@I #1$%$
    \let\strip@next=\strip@I
  \else\ifcat\strip@CHAR A
    \xdef\STRIP@{\STRIP@#1}%
  \else\ifcat\strip@CHAR.
    \xdef\STRIP@{\STRIP@#1}%
  \else\ifcat\strip@CHAR\space
    \xdef\STRIP@{\STRIP@ #1}%
  \fi\fi\fi\fi\fi
  \strip@next}
\def\detex@@a{ae}
\def\detex@@o{oe}
\def\detex@@u{ue}
\def\detex@@A{Ae}
\def\detex@@O{Oe}
\def\detex@@U{Ue}
\def\detex@@s{ss}
\ifDTK@Author@\else
\newenvironment{theaddresses}{%
  \chapter{\addressname}\Label{addresses}
  \begingroup
    \columnsep=10pt
    \addresssize
    \def\addressitem##1##2##3{%
      \par
      \parbox{\columnwidth}{
      \textbf{##1}\hfill[\ignorespaces ##3]%
      \\ ##2}}
    \begin{multicols}{2}%
      \raggedbottom
      \raggedright
}{%
    \end{multicols}%
  \endgroup
  }
\fi
\newcommand\addresssize{\footnotesize\parskip=6pt plus 2pt minus 3pt}
\ifDTK@Author@
  \newcommand\listofaddresses{%
    \typeout{*** listofaddresses not supported in articles.}}
  \let\makeaddresses\relax% RN 2005-01-15
\else
  \iffalse% RN 2005-01-15
  \newcommand\listofaddresses{%
    \InputIfFileExists{\jobname.ind}{}{%
      \typeout{No file \jobname.ind.}%
      \typeout{Use the following command to create it:\space\space
        makeindex -s dtk.ist \jobname}%
      \typeout{\space}}%
  }
  \else
  \newcommand\listofaddresses{%
    \InputIfFileExists{\jobname.gls}{}{%
      \typeout{No file \jobname.gls.}%
      \typeout{Use the following command to create it:^^J%
        \@spaces makeindex -s dtk.ist -o \jobname.gls \jobname.glo}%
      \typeout{\space}}%
  }
  \let\makeaddresses\makeglossary
  \fi
\fi
\ifDTK@Author@
  \renewcommand\tableofcontents{%
    \typeout{*** tabelofcontents not supported in articles.}}
\else
  \renewcommand\tableofcontents{%
    \clearpage
    \thispagestyle{empty}%
    \markboth{\contentsname}{\contentsname}%
    \ContentsArt
    \begingroup
      \parskip=\ContentsParSkip
      \let\\=\relax
      \TOC@configure
      \raggedright%%%%%%%%%%%%%%%%%% hv 2009-07-25
      \@starttoc{toc}
    \endgroup
  }
\fi
\let\TOC@configure\relax
\newcommand\ContentsArt{%
  \vspace*{-\headheight}\vspace*{-\headsep}\vspace*{-2pt}
  \begin{minipage}{\textwidth}
    \Huge\color{black!60}Die \color{black}\TeX\color{black!60}nische Komödie% \journalname
    \\[2pt]%
    \rule{\textwidth}{2pt}\\[2pt]%
    \null\hfill
    \CoverArt@small
    \cover@sub{\volume}{\DTKedition}{\DTKdate}
  \end{minipage}\vspace{16pt minus 8pt}\par
}
\iffalse
\DeclareFontShape{T1}{cmr}{bdx}{n}
     {<5><6><7><8><9><10><10.95><12>
      <14.4><17.28><20.74><24.88> ecrb10
      }{}
\DeclareFontShape{OT1}{cmr}{bdx}{n}
     {<5><6><7><8><9><10><10.95><12>
      <14.4><17.28><20.74><24.88> cmbdx10
      }{}
\fi
\setcounter{tocdepth}{0}
\renewcommand\l@part[2]{%
  \addpenalty{-\@highpenalty}%
  \addvspace{0.5em plus 0pt}% space above part line
  \@tempdima 1.5em
  \begingroup
    \bf
    \advance\leftskip\@tempdima
    \hskip -\leftskip
    #1\par
    \penalty\@highpenalty
  \endgroup
  \addvspace{0.2em}%
}
\renewcommand\l@chapter[2]{%
  \begingroup
     \vskip \z@ \@plus.2\p@
     \@afterindenttrue
     \interlinepenalty\@M
     \@tempdima 1.5em\relax % number width
     \@tempdimb 2.5em\relax % indent
     \advance\leftskip \@tempdimb
     \advance\rightskip \@tempdimb
     \noindent\hskip -\leftskip
     \hbox to\@tempdimb{#2\hss}%
     #1\par
  \endgroup}

\@ifundefined{DTK@layout}{}{\input{dtk\DTK@layout.clo}}

\begingroup
  \chardef\x=0 %
  % check pdfTeX
  \@ifundefined{pdfoutput}{}{%
    \ifcase\pdfoutput
    \else
      \chardef\x=1 %
    \fi
  }%
  % check VTeX
  \@ifundefined{OpMode}{}{%
    \chardef\x=2 %
  }%
\expandafter\endgroup
\ifcase\x
  % default case
  \AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}%
\or
  % pdfTeX is running in pdf mode
  \pdfpagewidth\paperwidth\pdfpageheight\paperheight
\else
  % VTeX is running
  \mediawidth\paperwidth\mediaheight\paperheight
\fi

\iffalse
\AtBeginDocument{%
  \begingroup% vielleicht noch intelligenter...
    \ttfamily
    \@tempdima\fontdimen3\font
    \advance\@tempdima\fontdimen4\font
    \ifdim\@tempdima>\z@
      \edef\@tempa{\ttdefault}\gdef\ttdefault{cmtt}%
      \ClassWarning{dtk}{%
        Font `\@tempa' is bad, changed to '\ttdefault'}%
    \fi
  \endgroup
}
\fi
\RequirePackage{makeidx}
\renewenvironment{theindex}
  {\begin{multicols}{2}[\section{\indexname}\vspace{-.5\baselineskip}]%
   \parskip\z@ \@plus .3\p@\relax
   \columnseprule \z@
   \columnsep=10pt
   \raggedbottom\raggedright
   \let\item\@idxitem}
  {\end{multicols}}
\renewcommand\@idxitem{\par\hangindent 40\p@}
\renewcommand\subitem{\@idxitem \hspace*{20\p@}}
\renewcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\renewcommand\indexspace{\par \vskip 6\p@ \@plus2\p@ \@minus1\p@\relax}

\newcommand*\DTK@embedded@documentclasshook{}
\newcommand*\AtEmbeddedDocumentclass{%
  \g@addto@macro\DTK@embedded@documentclasshook}
\AtEmbeddedDocumentclass{%
%%%    \filename@parse{\protect#1}\edef\DTK@local@jobname{\filename@base}%???
      \edef\jobname{\DTK@local@jobname}%
}
\newcommand*\DTK@embedded@begindocumenthook{}
\newcommand*\AtEmbeddedBeginDocument{%
  \g@addto@macro\DTK@embedded@begindocumenthook}
\AtEmbeddedBeginDocument{}
\newcommand*\DTK@embedded@enddocumenthook{}
\newcommand*\AtEmbeddedEndDocument{%
  \g@addto@macro\DTK@embedded@enddocumenthook}
\AtEmbeddedEndDocument{\endinput}
\newcommand*\DTK@jobname{}
\ifDTK@Author@\edef\DTK@jobname{komoedie}\else\edef\DTK@jobname{\jobname}\fi
\newcommand*\DTK@local@jobname{}
\newcommand*\DTK@local@inputname{}
%%%\newcommand*\DTK@PSforPDF{}
\newcommand*\DTK@eat@version[1][]{\ignorespaces}
\newcommand*\DTK@usepackage{}
\newcommand*\DTKinput[1]{%
  \begingroup
     \filename@parse{#1}%
     \edef\DTK@local@jobname{\filename@base}%
     \@ifundefined{filename@ext}%
     {\IfFileExists{\DTK@local@jobname.ltx}%
       {\edef\DTK@local@inputname{\DTK@local@jobname.ltx}}%
       {\edef\DTK@local@inputname{\DTK@local@jobname.tex}}%
     }%
     {\edef\DTK@local@inputname{#1}}%
    \renewcommand*\documentclass[2][]{%
      %%\edef\jobname{\DTK@local@jobname}%
      %%%\let\DTK@PSforPDF\PSforPDF
      %\renewcommand\PSforPDF[2][]{}%
      %%%\let\PSforPDF\@gobble
      \DTK@embedded@documentclasshook
      \DTK@eat@version}%
    \renewcommand*\usepackage[2][]{%
      \@ifnextchar[%]
        {\DTK@usepackage{##1}{##2}}%
        {\DTK@usepackage{##1}{##2}[]}%
      }%
    \def\DTK@usepackage##1##2[##3]{%
      \edef\@tempb{\zap@space##2 \@empty}%
      \@for\@tempa:=\@tempb\do{\def\@tempb{inputenc}%
        \ifx\@tempa\@tempb
          \edef\@tempa{##1}%
          \ifx\@tempa\@empty\else\inputencoding{##1}\fi
        \else
%          \ifx\@tempa\@empty\else\usepackage{\@tempa}%
%             \RecordPackage{##1}\@tempa{##3}\DTK@local@inputname
%          \fi
        \fi}}%
    \let\pagestyle\@gobble
    \let\thispagestyle\@gobble
    \let\nocite\@gobble
    \let\listfiles\relax
    \let\nofiles\relax
    \renewcommand*\AtBeginDocument[1]{%
       \typeout{\string\AtBeginDocument\space ignored!}}
    \renewcommand*\AtEndDocument[1]{%
       \typeout{\string\AtEndDocument\space ignored!}}
    \renewenvironment*{document}%
    %%%{\let\PSforPDF\DTK@PSforPDF}%
    %%%{\endinput}%
    {\DTK@embedded@begindocumenthook}%
    {\DTK@embedded@enddocumenthook}%
    \input{\DTK@local@inputname}%
  \endgroup
}
%%%\RequirePackage[final]{ps4pdf}
\@ifdefinable\User@Packages{\newwrite\User@Packages}
\AtBeginDocument{%
  %%%\edef\DTK@jobname{\jobname}%
  %%%\edef\PfP@container{\DTK@jobname-pics.pdf}%
  \ifDTK@Author@\else
    \listfiles
    \InputIfFileExists{userpackages.tex}%
    {\typeout{*************************************^^J%
              * File `userpackages.tex' used.^^J%
              *************************************}%
      \newcommand*\RecordPackage[4]{}%
      % warum gibt es kein \@gobblethree? ist jetzt egal!
    }%
    {%
      \immediate\openout\User@Packages userpackages.tex\relax
      \begingroup \catcode`\~=\active \let~=\space
      \immediate\write\User@Packages{%
        \@percentchar\space userpackages.tex^^J%
        \@percentchar\space generated by `\jobname'^^J%
        \@percentchar\space \DTK@today}%
      \endgroup
      \AtEndDocument{%
        \immediate\closeout\User@Packages\relax}%
      \newcommand*\RecordPackage[4]{%
        \immediate\write\User@Packages{%
          \string\usepackage[##1]{##2}[##3] %
          \@percentchar\space From file: ##4}}%
    }%
  \fi
  % RN 2005-03-21
  \@ifpackageloaded{lineno}{%
    \ifDTK@Draft@\else
      \nolinenumbers
    \fi
  }{}
}
\def\indexname{Stichwortverzeichnis}% Besser woanders?
\def\printindex{%
  \InputIfFileExists{\DTK@jobname.ind}{}{%
    \typeout{No file \DTK@jobname.ind.}%
    \typeout{Use the following command to create it:^^J%
      \@spaces makeindex -s dtk-idx.ist -o \DTK@jobname.ind \DTK@jobname.idx}%
    \typeout{\space}}%
}
\@fptop\z@

\endinput
%%
%% End of file `dtk.cls'.
