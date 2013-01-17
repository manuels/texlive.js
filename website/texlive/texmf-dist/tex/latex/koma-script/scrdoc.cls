% ======================================================================
% scrdoc.dtx
% Copyright (c) Markus Kohm, 2002-2012
%
% This file is part of the LaTeX2e KOMA-Script bundle.
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, version 1.3c of the license.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX 
% version 2005/12/01 or later and of this work.
%
% This work has the LPPL maintenance status "author-maintained".
%
% The Current Maintainer and author of this work is Markus Kohm.
%
% This work consists of all files listed in manifest.txt.
% ----------------------------------------------------------------------
% scrdoc.dtx
% Copyright (c) Markus Kohm, 2002-2012
%
% Dieses Werk darf nach den Bedingungen der LaTeX Project Public Lizenz,
% Version 1.3c, verteilt und/oder veraendert werden.
% Die neuste Version dieser Lizenz ist
%   http://www.latex-project.org/lppl.txt
% und Version 1.3c ist Teil aller Verteilungen von LaTeX
% Version 2005/12/01 oder spaeter und dieses Werks.
%
% Dieses Werk hat den LPPL-Verwaltungs-Status "author-maintained"
% (allein durch den Autor verwaltet).
%
% Der Aktuelle Verwalter und Autor dieses Werkes ist Markus Kohm.
% 
% Dieses Werk besteht aus den in manifest.txt aufgefuehrten Dateien.
% ======================================================================
%
% Note: This class was made to shrink size of dtx files.
%       Do not use this class for anything because it may change
%       incompatible from distribution to distribution
%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{scrdoc}[%
  2003/01/19 v0.1d KOMA-Script source documentation class]

% Load standard LaTeX documentation class, passing all options to it
% but use scrartcl instead of article.
\IfFileExists{scrartcl.cls}{%
  \newcommand*{\sd@saved@LoadClass}{}
  \let\sd@saved@LoadClass=\LoadClass
  \renewcommand*{\LoadClass}[2][]{%
    \begingroup
      \edef\@tempc{##2}\def\@tempb{article}%
      \ifx\@tempc\@tempb
        \let\LoadClass\sd@saved@LoadClass
        \def\@tempc{scrartcl}%
      \fi
      \edef\@tempc{%
        \noexpand\endgroup\noexpand\sd@saved@LoadClass[{##1}]{\@tempc}}%
    \@tempc
  }
  \newcommand*{\sd@saved@PassOptionsToClass}{}
  \let\sd@saved@PassOptionsToClass=\PassOptionsToClass
  \renewcommand*{\PassOptionsToClass}[2]{%
    \begingroup
      \edef\@tempc{##2}\def\@tempb{article}%
      \ifx\@tempc\@tempb
        \def\@tempc{scrartcl}%
      \fi
      \edef\@tempc{%
        \noexpand\endgroup\noexpand\sd@saved@PassOptionsToClass{##1}{%
          \@tempc}}%
    \@tempc
  }
}{%
  \typeout{^^J%
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!^^J%
    !!! You should generate KOMA-Script classes first!^^J%
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!^^J%
    ^^J%
  }%
}
\LoadClassWithOptions{ltxdoc}

% Use two columns at index
\setcounter{IndexColumns}{2}

% If \EnableCrossrefs is used, we don't want following macros to be
% indexed:

\DoNotIndex{\.,\\,\ ,\@Alph,\@M}
\DoNotIndex{\@abstrtfalse,\@abstrttrue,\@addtoreset,\@afterheading}
\DoNotIndex{\@afterindentfalse,\@alph,\@arabic}
\DoNotIndex{\@beginparpenalty}
\DoNotIndex{\@car,\@cdr,\@centercr}
\DoNotIndex{\@dblfloat,\@dotsep}
\DoNotIndex{\@dottedtocline,\@empty,\@endparpenalty}
\DoNotIndex{\@float,\@fontswitch}
\DoNotIndex{\@gobbletwo}
\DoNotIndex{\@hangfrom,\@highpenalty}
\DoNotIndex{\@ifnextchar,\@ifundefined,\@itempenalty}
\DoNotIndex{\@latex@warning}
\DoNotIndex{\@m,\@medpenalty,\@minus,\@mkboth,\@mparswitchfalse}
\DoNotIndex{\@mparswitchtrue}
\DoNotIndex{\@ne,\@nil,\@nobreakfalse,\@nobreaktrue,\@nomath}
\DoNotIndex{\@plus}
\DoNotIndex{\@tempa,\@tempcnta,\@tempdima,\@tempskipka}
\DoNotIndex{\@tempswafalse,\@tempswatrue}
\DoNotIndex{\@tempb,\@tempcntb,\@tempdimb,\@tempskipkb}
\DoNotIndex{\@tempswbfalse,\@tempswbtrue}
\DoNotIndex{\@tempc,\@tempcntc,\@tempdimc,\@tempskipkc}
\DoNotIndex{\@tocrmarg,\@topnewpage,\@topnum,\@twocolumnfalse}
\DoNotIndex{\@twocolumntrue,\@twosidefalse,\@twosidetrue}
\DoNotIndex{\@whiledim,\@whilenum}
\DoNotIndex{\addcontentsline,\addpenalty,\addtocontents,\addtolength}
\DoNotIndex{\addvspace,\advance}
\DoNotIndex{\begin,\begingroup,\bfseries,\box,\bullet}
\DoNotIndex{\c@figure,\c@page,\c@secnumdepth,\c@table,\c@tocdepth}
\DoNotIndex{\cdot,\centering,\changes,\cleardoublepage,\clearpage}
\DoNotIndex{\cmd,\col@number,\CurrentOption,\CodelineIndex,\cs}
\DoNotIndex{\day,\dblfloatpagefraction,\dbltopfraction}
\DoNotIndex{\DeclareOldFontCommand,\DeclareOption,\def,\DisableCrossrefs}
\DoNotIndex{\divide,\DoNotIndex}
\DoNotIndex{\ifdim,\else,\fi,\empty,\em,\EnableCrossrefs,\end}
\DoNotIndex{\end@dblfloat}
\DoNotIndex{\end@float,\endgroup,\endlist,\endquotation,\endtitlepage}
\DoNotIndex{\everypar,\ExecuteOptions,\expandafter}
\DoNotIndex{\fboxrule,\fboxsep}
\DoNotIndex{\gdef,\global}
\DoNotIndex{\hangindent,\hbox,\hfil,\hrule,\hsize,\hskip,\hspace,\hss}
\DoNotIndex{\if@tempswa,\ifcase,\or,\fi,\fi}
\DoNotIndex{\ifnum,\ifodd,\ifx,\fi,\fi,\fi}
\DoNotIndex{\include,\input,\InputIfFileExists,\item,\itshape}
\DoNotIndex{\kern,\leavevmode,\leftmark,\leftskip,\let,\lineskip}
\DoNotIndex{\list,\long}
\DoNotIndex{\m@ne,\m@th,\marginpar,\markboth,\markright,\mathbf,\mathcal}
\DoNotIndex{\mathit,\mathnormal,\mathrm,\mathsf,\mathtt,\MessageBreak}
\DoNotIndex{\month}
\DoNotIndex{\newblock,\newcommand,\newcount,\newcounter,\newdimen}
\DoNotIndex{\newenvironment,\newlength,\newpage,\nobreak,\noindent}
\DoNotIndex{\normalfont,\normallineskip,\normalsize,\null,\number}
\DoNotIndex{\numberline,\normalcolor}
\DoNotIndex{\OldMakeindex,\OnlyDescription,\overfullrule}
\DoNotIndex{\p@,\PackageError,\PackageInfo,\PackageWarningNoLine}
\DoNotIndex{\pagenumbering,\pagestyle,\par,\paragraph,\parbox}
\DoNotIndex{\PassOptionsToPackage,\pcal,\penalty,\pmit,\PrintChanges}
\DoNotIndex{\PrintIndex,\ProcessOptions,\protect,\providecommand}
\DoNotIndex{\ProvidesClass}
\DoNotIndex{\raggedbottom,\raggedleft,\raggedright,\refstepcounter,\relax}
\DoNotIndex{\renewcommand,\RequirePackage,\reset@font}
\DoNotIndex{\rightmargin,\rightmark,\rightskip,\rmfamily,\@Roman,\@roman}
\DoNotIndex{\scshape,\secdef,\setbox,\setcounter,\setlength}
\DoNotIndex{\settowidth,\sfcode,\sffamily,\skip,\sloppy,\slshape,\space}
\DoNotIndex{\string}
\DoNotIndex{\the,\thispagestyle,\triangleright,\ttfamily}
\DoNotIndex{\twocolumn,\typeout}
\DoNotIndex{\undefined,\usecounter}
\DoNotIndex{\vfil,\vfill,\vspace}
\DoNotIndex{\wd,\xdef,\year,\z@}
% More may be set by the source files.

% Redefine some defaults to handle not only macros and environments
% but also options, Length, Counters, KOMAvars. Also define some new.
\def\macro{\begingroup
  \catcode`\\12
  \MakePrivateLetters \m@cro@{0}}
\def\environment{\begingroup
  \catcode`\\12
  \MakePrivateLetters \m@cro@{1}}
\def\option{\begingroup
  \catcode`\\12
  \MakePrivateLetters \m@cro@{2}}
\def\Length{\begingroup
  \catcode`\\12
  \MakePrivateLetters \m@cro@{3}}
\def\Counter{\begingroup
  \catcode`\\12
  \MakePrivateLetters \m@cro@{4}}
\def\KOMAvar{\begingroup
  \catcode`\\12
  \MakePrivateLetters \m@cro@{5}}
\def\KOMAfont{\begingroup
  \catcode`\\12
  \MakePrivateLetters \m@cro@{6}}
\long\def\m@cro@#1#2{\endgroup \topsep\MacroTopsep \trivlist
  \edef\saved@macroname{\string#2}%
  \def\makelabel##1{\llap{##1}}%
  \if@inlabel
    \let\@tempa\@empty \count@\macro@cnt
    \loop \ifnum\count@>\z@
      \edef\@tempa{\@tempa\hbox{\strut}}\advance\count@\m@ne 
    \repeat
    \edef\makelabel##1{\llap{\vtop to\baselineskip
        {\@tempa\hbox{##1}\vss}}}%
    \advance \macro@cnt \@ne
  \else \macro@cnt\@ne \fi
  \edef\@tempa{\noexpand\item[%
    \ifcase #1
      \noexpand\PrintMacroName
    \or
      \noexpand\PrintEnvName
    \or
      \noexpand\PrintOptionName
    \or
      \noexpand\PrintLengthName
    \or
      \noexpand\PrintCounterName
    \or
      \noexpand\PrintKOMAvarName
    \or
      \noexpand\PrintKOMAfontName
    \fi
    {\string#2}]}%
  \@tempa
  \global\advance\c@CodelineNo\@ne
  \ifcase #1
    \SpecialMainIndex{#2}\nobreak
    \DoNotIndex{#2}%
  \or
    \SpecialMainEnvIndex{#2}\nobreak
  \or
    \SpecialMainOptionIndex{#2}\nobreak
  \or
    \SpecialMainLengthIndex{#2}\nobreak
    \DoNotIndex{#2}%
  \or
    \SpecialMainCounterIndex{#2}\nobreak
  \or
    \SpecialMainKOMAvarIndex{#2}\nobreak
  \or
    \SpecialMainKOMAfontIndex{#2}\nobreak
  \fi
  \global\advance\c@CodelineNo\m@ne
  \ignorespaces}
\let\endoption\endmacro
\let\endLength\endmacro
\let\endCounter\endmacro
\let\endKOMAvar\endmacro

% The new names we need
\providecommand*{\EnvName}{Umgebung}% This is german
\providecommand*{\EnvsName}{Umgebungen}% This is german
\providecommand*{\OptionName}{Option}% This is german
\providecommand*{\OptionsName}{Optionen}% This is german
\providecommand*{\PrintOptionName}[1]{\strut \MacroFont #1\ }
\providecommand*{\PrintDescribeOption}[1]{\strut \MacroFont #1\ }
\providecommand*{\LengthName}{L\"ange}% This is german
\providecommand*{\LengthsName}{L\"angen}% This is german
\providecommand*{\PrintLengthName}[1]{\strut \MacroFont \string #1\ }
\providecommand*{\PrintDescribeLength}[1]{\strut \MacroFont \string #1\ }
\providecommand*{\CounterName}{Z\"ahler}% This is german
\providecommand*{\CountersName}{Z\"ahler}% This is german
\providecommand*{\PrintCounterName}[1]{\strut \MacroFont #1\ }
\providecommand*{\PrintDescribeCounter}[1]{\strut \MacroFont #1\ }
\providecommand*{\KOMAvarName}{Variable}% This is german
\providecommand*{\KOMAvarsName}{Variablen}% This is german
\providecommand*{\PrintKOMAvarName}[1]{\strut \MacroFont #1\ }
\providecommand*{\PrintDescribeKOMAvar}[1]{\strut \MacroFont #1\ }
\providecommand*{\KOMAfontName}{Element mit Schrift}% This is german
\providecommand*{\KOMAfontsName}{Elemente mit Schrift}% This is german
\providecommand*{\PrintKOMAfontName}[1]{\strut \MacroFont #1\ }
\providecommand*{\PrintDescribeKOMAfont}[1]{\strut \MacroFont #1\ }

% Defining new main index commands
\newcommand*{\SpecialMainIndex@Type}[3]{%
  \@bsphack\special@index{%
    #1\actualchar
    {\string\ttfamily\space#1}
    (\string #2)%
    \encapchar main}%
  \special@index{%
    #3:\levelchar{%
      \string\ttfamily\space#1}\encapchar
    main}\@esphack}
\renewcommand*{\SpecialMainEnvIndex}[1]{%
  \SpecialMainIndex@Type{#1}{\EnvName}{\EnvsName}}
\newcommand*{\SpecialMainOptionIndex}[1]{%
  \SpecialMainIndex@Type{#1}{\OptionName}{\OptionsName}}
\newcommand*{\SpecialMainLengthIndex}[1]{%
  \@bsphack\SpecialIndex@{#1}{(\string\LengthName )\encapchar main}%
  \@esphack}
\newcommand*{\SpecialMainCounterIndex}[1]{%
  \SpecialMainIndex@Type{#1}{\CounterName}{\CountersName}}
\newcommand*{\SpecialMainKOMAvarIndex}[1]{%
  \SpecialMainIndex@Type{#1}{\KOMAvarName}{\KOMAvarsName}}
\newcommand*{\SpecialMainKOMAfontIndex}[1]{%
  \SpecialMainIndex@Type{#1}{\KOMAfontName}{\KOMAfontsName}}

% Defining new usage index commands
\newcommand*{\SpecialIndex@Type}[3]{%
  \@bsphack
  \index{#1\actualchar{\protect\ttfamily#1}
    (#2)\encapchar usage}%
  \index{#3:\levelchar{\protect\ttfamily#1}\encapchar
    usage}\@esphack}
\renewcommand{\SpecialEnvIndex}[1]{%
  \SpecialIndex@Type{#1}{\EnvName}{\EnvsName}}
\newcommand*{\SpecialOptionIndex}[1]{%
  \SpecialMainIndex@Type{#1}{\OptionName}{\OptionsName}}
\newcommand*{\SpecialLengthIndex}[1]{\@bsphack%
  {\let\special@index\index
    \SpecialIndex@{#1}{(\string\LengthName )\encapchar usage}}%
  \@esphack}
\newcommand*{\SpecialCounterIndex}[1]{%
  \SpecialMainIndex@Type{#1}{\CounterName}{\CountersName}}
\newcommand*{\SpecialKOMAvarIndex}[1]{%
  \SpecialMainIndex@Type{#1}{\KOMAvarName}{\KOMAvarsName}}

% Define new describe commands
\newcommand*{\newDescribe}[1]{%
  \expandafter\newcommand\expandafter*\csname Describe#1\endcsname{%
    \leavevmode\@bsphack\begingroup\MakePrivateLetters
    \csname Describe@#1\endcsname}%
  \expandafter\newcommand\expandafter*\csname Describe@#1\endcsname[1]{%
    \endgroup
    \marginpar{\raggedleft\csname PrintDescribe#1\endcsname{##1}}%
    \csname Special#1Index\endcsname{##1}\@esphack\ignorespaces}%
}
\newDescribe{Option}

% We use left margin very much, so shift everything to the right
\if@twoside
\else
\addtolength{\oddsidemargin}{1in}
\setlength{\oddsidemargin}{1.5\oddsidemargin}
\addtolength{\oddsidemargin}{-1in}
\fi

% We need some logos:
\providecommand*{\eTeX}{$\m@th\varepsilon$-\TeX}

% Terms for other languages:
\AtBeginDocument{%
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname addto\endcsname\relax
    \ClassWarning{scrdoc}{Package babel not loaded}%
  \else
    \addto\captionsenglish{%
      \def\partname{File}%
    }%
    \addto\captionsngerman{%
      \def\partname{Datei}%
    }%
    \ClassInfo{scrdoc}{Select language \languagename}%
    \expandafter\selectlanguage\expandafter{\languagename}%
  \fi
}

\endinput
% end of ``scrdoc.cls''
