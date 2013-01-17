%%
%% This is file `ppr-prv.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% ppr-prv.dtx  (with options: `class')
%% ========================================================================
%%  ppr-prv class: "Prosper Preview", a class to produce a printable
%%                 version of prosper slides
%%  Copyright (C) 2003-2004 Mathieu Goutelle (INRIA, France)
%%  mgoutell[at]users[dot]sourceforge[dot]net
%% 
%%  This program may be distributed and/or modified under the
%%  conditions of the LaTeX Project Public License, either version 1.2
%%  of this license or (at your option) any later version.
%%  The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%%  and version 1.2 or later is part of all distributions of LaTeX
%%  version 1999/12/01 or later.
%% ========================================================================
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
\def\PPRPRV@Version{v. 0.13}
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ppr-prv}[2005/09/02, \PPRPRV@Version]
\typeout{(c) 2003-2005 Mathieu Goutelle}
\newif\ifDVItoPS
\DeclareOption{ps}{\global\DVItoPStrue}
\DeclareOption{pdf}{\global\DVItoPSfalse}

\newif\ifisDraft
\DeclareOption{draft}{\global\isDrafttrue}
\DeclareOption{final}{\global\isDraftfalse}

\newif\ifinColor
\DeclareOption{slideColor}{}
\DeclareOption{slideBW}{}

\newif\ifallPages
\DeclareOption{total}{}
\DeclareOption{nototal}{}

\newif\ifcolorBG
\DeclareOption{nocolorBG}{}
\DeclareOption{colorBG}{}

\newif\ifAccumulate
\DeclareOption{accumulate}{}
\DeclareOption{noaccumulate}{}

\newif\ifnoFooter
\DeclareOption{noFooter}{\global\noFootertrue}
\noFooterfalse

\newif\if@distiller
\@distillerfalse
\DeclareOption{distiller}{\global\@distillertrue}

\newif\if@nopagebreak
\@nopagebreakfalse
\DeclareOption{nopagebreak}{\global\@nopagebreaktrue}

\DeclareOption{YandY}{\gdef\@pdf@driver{dvipsone}}
\DeclareOption{ps2pdf}{\gdef\@pdf@driver{ps2pdf}}
\DeclareOption{vtex}{\gdef\@pdf@driver{vtex}}

%% Default style file = default
\def\Style@chosen{default}
\DeclareOption*{\global\let\Style@chosen=\CurrentOption}
\DeclareOption{a4paper}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{geometry}%
}
\DeclareOption{a5paper}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{geometry}%
}
\DeclareOption{b5paper}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{geometry}%
}
\DeclareOption{letterpaper}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{geometry}%
}
\DeclareOption{legalpaper}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{geometry}%
}
\DeclareOption{executivepaper}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{geometry}%
}
\DeclareOption{landscape}{%
  \PassOptionsToClass{\CurrentOption}{article}%
  \PassOptionsToPackage{\CurrentOption}{geometry}%
}

\PassOptionsToClass{10pt,11pt,12pt,oneside,twoside,final,draft,
  leqno,fleqn,openbib}{article}

\ExecuteOptions{final,slideBW,total,nocolorBG,noaccumulate,ps,ps2pdf,a4paper,10pt}
\ProcessOptions\relax
%% Preliminary stuff
\LoadClass{article}

%% I save here the old value of the macros I need and which may be
%% modified by HA-prosper and define a test for detecting HA-prosper.
\newif\if@HAprosper\global\@HAprosperfalse
\let\old@section\section
\let\old@subsection\subsection
\let\old@itemize\itemize
\let\old@enditemize\enditemize
\let\old@enumerate\enumerate
\let\old@endenumerate\endenumerate
\RequirePackage{pstricks}
\RequirePackage{textcomp}
\RequirePackage{graphicx}
\RequirePackage[hmargin=2cm,vmargin=2cm,noheadfoot]{geometry}
\RequirePackage{keyval,ifpdf}
\ifpdf\gdef\@pdf@driver{pdftex}\fi
\RequirePackage[\@pdf@driver,plainpages=false,colorlinks=true]{hyperref}
\RequirePackage{float}
\newfloat{figure}{H}{lof}
\newfloat{table}{H}{lot}
\newcommand{\NoPageBreak}{\global\@nopagebreaktrue}
\newcommand{\PageBreak}{\global\@nopagebreakfalse}

\setlength{\parindent}{0pt}
\pagestyle{empty}
%% Support for the HA-propser package: we try here to mimic the prosper
%% class to avoid the HA patch to complain about a missing length or
%% macro.
\let\normal@write\write
\newlength{\slideWidth}
\setlength{\slideWidth}{\linewidth}
\newlength{\slidewidth}
\setlength{\slidewidth}{\linewidth}
\newlength{\slideheight}
\newcounter{trueSlideCounter}
\newcounter{overlaysCount}
\newcounter{item@step}
\newcommand{\slidetitle}[1]{}
\newcommand{\slideframe}[1]{}
\newcommand{\NewSlideStyle}[4][]{}
\newcommand{\newslideframe}[2]{}
\newcommand{\slidepagestyle}[1]{}
\def\@fontTextColor{}
\def\@fontTextBW{}
\def\@fontTitleColor{}
\def\@fontTitleBW{}
\def\@fontSubtitleColor{}
\def\@fontSubtitleBW{}
\def\ptsize#1{}
\newenvironment{slide@seminar}{}{}
\def\@DefMyItem{}
\def\@titleSpacing{\vspace*{10pt}}
\newif\ifInOverlays\InOverlaysfalse
\newcounter{limitOverlays}
\def\@cleanupOverlay{}
%% Commands from Seminar
\newcounter{slide}
\newcommand{\renewpagestyle}[3]{}
\def\slidefonts{}
\newif\ifarticle\articletrue
\newif\if@needsnewpage\global\@needsnewpagetrue
%% Definition of the part command to suppress the optional transition argument
\let\part\relax
\newcommand{\part}[2][]{%
  \if@needsnewpage
    \if@nopagebreak\else\ifodd\theslideii\else\mbox{}\clearpage\fi\fi
    \global\@needsnewpagefalse
  \fi
  \refstepcounter{slidei}%
  \old@section*{#2}%
}
%% Handle all the maketitle stuff
\let\@cartouche\@empty
\newcommand{\slideCaption}[1]{\gdef\@cartouche{#1}}
\let\@Subtitle\@empty
\newcommand{\subtitle}[1]{\gdef\@Subtitle{#1}}
\let\old@Title\title
\renewcommand{\title}[1]{\gdef\@Title{#1}}

\let\@email\@empty
\newcommand{\email}[1]{\gdef\@email{#1}}
\let\@institution\@empty
\newcommand{\institution}[1]{\gdef\@institution{#1}}

\gdef\@Author{}
\renewcommand{\author}[1]{\gdef\@Author{#1}}

\renewcommand{\maketitle}{
  \thispagestyle{empty}\setcounter{page}{0}%
  \refstepcounter{slidei}%
  \mbox{}\vfill
  \begin{center}%
    {\LARGE \@Title \par}%
    \ifx\@Subtitle\@empty\else\vskip 2em{\large\@Subtitle\par}\fi
    \vskip 6em%
    {\large\@Author
    \ifx\@email\@empty\else\vskip 1em\@email\fi
    \ifx\@institution\@empty\else\vskip 1em\@institution\par\fi}%
  \end{center}%
  \vfill\mbox{}\clearpage
  \global\@needsnewpagefalse
}
%% Definition of the Itemize environment ;)
\let\Itemize\itemize
\let\endItemize\enditemize

%% Definition of the itemstep environment to gobble the optional argument.
\newenvironment{itemstep}[1][]%
  {\itemize}
  {\enditemize}
%% \@size@overlay contains the height of the current slide if we are using
%% overlays. It is equal at least to 4cm to try to avoid really little frame
%% when the user wants exactly two slides per page.
\newlength{\@size@tmp}
\global\@size@tmp\z@
\newlength{\@size@overlay}
%% Definition of the slide environment
\newsavebox{\@slide@content} % will contain the slide
%% Slide counter to be printed on the bottom of each slide
\newcounter{slidei}\setcounter{slidei}{0}
%% Slide counter to print just two slides per page (even when there is a
%% \part...)
\newcounter{slideii}\setcounter{slideii}{0}

\newenvironment{prv@slide}[1]{%
  \if@needsnewpage
    \if@nopagebreak\else\ifodd\theslideii\mbox{}\clearpage\fi\fi
  \fi
  \global\@needsnewpagetrue
  \if@nopagebreak
    \global\setlength{\@size@overlay}{\z@}%
  \else
    \global\setlength{\@size@overlay}{4cm}%
  \fi
  \begin{lrbox}{\@slide@content}\begin{minipage}{\linewidth}%
  \old@subsection*{#1}%
}{%
  \end{minipage}\end{lrbox}%
  \settoheight{\@size@tmp}{\@slide@content}%
  \begin{minipage}{\linewidth}
  \fbox{%
    \usebox{\@slide@content}%
    \ifdim\@size@overlay>\@size@tmp
       \addtolength{\@size@overlay}{\baselineskip}%
       \rule[-\@size@overlay]{1pt}{0pt}%
    \fi
  }%
  \ifnoFooter\else
    \ifhmode\\\fi
    \makebox[\linewidth][r]{%
      \footnotesize
      \ifx\@cartouche\@empty\else\@cartouche~---~\fi
      \slidename~\no\theslidei}%
  \fi
  \end{minipage}
  \par\if@nopagebreak\bigskip\else\vfill\fi
}
\newenvironment{slide}[2][]
{%
  \refstepcounter{slidei}\stepcounter{slideii}%
  \begin{prv@slide}{#2}%
}
  {\end{prv@slide}}
\AtEndDocument{\if@nopagebreak\else\ifodd\theslideii\vfill\mbox{}\else\fi\fi}
%% For the \Logo, don't do anything !
\newcommand{\Logo}{%
    \@ifnextchar({\Logo@one}{\Logo@two}%
}
\def\Logo@one(#1)#2{}
\def\Logo@two#1{}

%% For the \Font*, don't do anything !
\newcommand{\FontTitle}[2]{}
\newcommand{\FontSubtitle}[2]{}
\newcommand{\FontText}[2]{}
%% Definition of the whole overlay stuff: a bit annoying...
\newcommand{\overlays}[2]{#2} % We ignore overlays

\def\FromSlide#1{\relax}
\def\UntilSlide#1{\relax}
\def\OnlySlide#1{\relax}

\long\def\fromSlide@NE#1#2{#2}
\long\def\untilSlide@NE#1#2{#2}
\long\def\onlySlide@NE#1#2{#2}

\newbox\PRV@tempbox
\long\def\fromSlide@E#1#2{%
  \sbox\PRV@tempbox{\begin{minipage}{\linewidth}#2\end{minipage}}%
  \setlength{\@size@tmp}{\the\ht\PRV@tempbox}%
  \addtolength{\@size@tmp}{\the\dp\PRV@tempbox}%
  \ifdim\@size@tmp>\@size@overlay\global\@size@overlay\@size@tmp\fi
  \vbox to 0pt\bgroup\usebox{\PRV@tempbox}\egroup
  \vskip -\baselineskip\ignorespaces
}
\long\def\untilSlide@E#1#2{%
  \sbox\PRV@tempbox{\begin{minipage}{\linewidth}#2\end{minipage}}%
  \setlength{\@size@tmp}{\the\ht\PRV@tempbox}%
  \addtolength{\@size@tmp}{\the\dp\PRV@tempbox}%
  \ifdim\@size@tmp>\@size@overlay\global\@size@overlay\@size@tmp\fi
  \vbox to 0pt\bgroup\usebox{\PRV@tempbox}\egroup
  \vskip -\baselineskip\ignorespaces
}
\long\def\onlySlide@E#1#2{%
  \sbox\PRV@tempbox{\begin{minipage}{\linewidth}#2\end{minipage}}%
  \setlength{\@size@tmp}{\the\ht\PRV@tempbox}%
  \addtolength{\@size@tmp}{\the\dp\PRV@tempbox}%
  \ifdim\@size@tmp>\@size@overlay\global\@size@overlay\@size@tmp\fi
  \vbox to 0pt\bgroup\usebox{\PRV@tempbox}\egroup
  \vskip -\baselineskip\ignorespaces
}

\def\fromSlide{\@ifstar{\fromSlide@E}{\fromSlide@NE}}
\def\untilSlide{\@ifstar{\untilSlide@E}{\untilSlide@NE}}
\def\onlySlide{\@ifstar{\onlySlide@E}{\onlySlide@NE}}
%% All the things I may have forgotten if I haven't read the docs
%% carefully enough
\newcommand{\PDFtransition}[1]{}
\newcommand{\DefaultTransition}[1]{}
\def\NoFrenchBabelItemize{\relax}
\newcommand{\ColorFoot}[1]{}
\newif\ifshowVersion
\showVersionfalse
\newcommand{\displayVersion}{\global\showVersiontrue}

\def\fontTitle#1{#1}
\def\fontText#1{#1}

\newcommand{\myitem}[2]{}

%% Stolen from the prosper.cls code
\newcommand{\PDForPS}{%
  \ifDVItoPS
    \let\prosper@next\@secondoftwo
  \else
    \let\prosper@next\@firstoftwo
  \fi
  \prosper@next}
%% #1 appears on the slide only on PS mode
\newcommand{\onlyInPS}{%
  \ifDVItoPS
    \let\prosper@next\@iden
   \else
    \let\prosper@next\@gobble
  \fi
  \prosper@next}
%% #1 appears on the slide only on PDF mode
\newcommand{\onlyInPDF}{%
  \ifDVItoPS
    \let\prosper@next\@gobble
  \else
    \let\prosper@next\@iden
  \fi
  \prosper@next}
\AtBeginDocument{% Multi-language support with Babel
  \@ifpackageloaded{babel}{%
    \def\@test{french}%
    \ifx\languagename\@test
      \newcommand{\slidename}{transparent}%
      \providecommand{\no}{n\textdegree}%
    \fi
    \def\@test{english}%
    \ifx\languagename\@test
      \newcommand{\slidename}{slide}%
      \providecommand{\no}{\#}%
    \fi
    \def\@test{british}%
    \ifx\languagename\@test
      \newcommand{\slidename}{slide}%
      \providecommand{\no}{\#}%
    \fi
    \def\@test{canadian}%
    \ifx\languagename\@test
      \newcommand{\slidename}{slide}%
      \providecommand{\no}{\#}%
    \fi
    \def\@test{USenglish}%
    \ifx\languagename\@test
      \newcommand{\slidename}{slide}%
      \providecommand{\no}{\#}%
    \fi
    \def\@test{UKenglish}%
    \ifx\languagename\@test
      \newcommand{\slidename}{slide}%
      \providecommand{\no}{\#}%
    \fi
    \def\@test{german}%
    \ifx\languagename\@test
      \newcommand{\slidename}{transparent}%
      \providecommand{\no}{Nr.}%
    \fi
    \def\@test{germanb}%
    \ifx\languagename\@test
      \newcommand{\slidename}{transparent}%
      \providecommand{\no}{Nr.}%
    \fi
    \def\@test{austrian}%
    \ifx\languagename\@test
      \newcommand{\slidename}{transparent}%
      \providecommand{\no}{Nr.}%
    \fi
    \def\@test{ngerman}%
    \ifx\languagename\@test
      \newcommand{\slidename}{transparent}%
      \providecommand{\no}{Nr.}%
    \fi
    \def\@test{naustrian}%
    \ifx\languagename\@test
      \newcommand{\slidename}{transparent}%
      \providecommand{\no}{Nr.}%
    \fi
  }{}
  \providecommand{\slidename}{slide}%
  \providecommand{\no}{\#}%
}
\endinput
%%
%% End of file `ppr-prv.cls'.
