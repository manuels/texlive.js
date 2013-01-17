%%
%% This is file `articoletteracdp.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cdpbundl.dtx  (with options: `artico')
%% 
%% This is a generated file.
%% It is part of a work named "C.D.P. Bundle".
%% 
%% Copyright (C) 1999-2006 by Gustavo MEZZETTI <mezzetti@math.unipd.it>.
%% 
%% The C.D.P. Bundle may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%% 
%% The C.D.P. Bundle has the LPPL maintenance status
%%   "author-maintained".
%% 
%% The file `manifest.txt' that comes along with this file specifies
%% what the C.D.P. Bundle consists of; more precisely, it explains how
%% the locutions "Work" and "Compiled Work", used in the LaTeX Project
%% Public License, are to be interpreted in the case of this work.
%% 
%% Note that the distribution of this file alone is "distribution of
%% only part of the Work" in the sense of the LaTeX Project Public
%% License, and is not allowed.
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
\NeedsTeXFormat{LaTeX2e}[1996/06/01] % LaTeX2e is required!
\ProvidesClass{articoletteracdp}
              [2006/01/01 v0.34 (development)]
%% \typeout{Copyright (C) 1999-2006 by Gustavo MEZZETTI,
%%   all rights reserved.}
\@ifdefinable\@out@table@list{}
\@ifdefinable\@in@table@list{}
\@ifdefinable\@do@tf{}
\@ifdefinable\@sec@head@size{}
\def\do#1{\@ifdefinable#1{\newif#1}}
\do\if@toc@in@toc@
\do\if@loX@in@toc@
\@ifdefinable\@letter@bookmark{\let\@letter@bookmark\@gobbletwo}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\DeclareOption{titlepage}{%
  \@latexerr{No title page for letters}\@eha
}
\DeclareOption{notitlepage}{}
\DeclareOption{loXintoc}{%
  \@toc@in@toc@false
  \@loX@in@toc@true
}
\DeclareOption{tocintoc}{%
  \@toc@in@toc@true
  \@loX@in@toc@true
}
\DeclareOption{Hofstadter}{%
  \ExecuteOptions{tocintoc}%
}
\DeclareOption{plaintoc}{%
  \@toc@in@toc@false
  \@loX@in@toc@false
}
\DeclareOption{letterbookmarks}{%
  \def\@letter@bookmark{\pdfbookmark[0]}%
  \PassOptionsToPackage{bookmarksopen=false}{hyperref}%
}
\DeclareOption{noletterbookmarks}{%
  \let\@letter@bookmark\@gobbletwo
}
\DeclareOption{openletterbookmarks}{%
  \def\@letter@bookmark{\pdfbookmark[0]}%
  \PassOptionsToPackage{bookmarksopen,bookmarksopenlevel=1}{hyperref}%
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letteracdp}}
\ExecuteOptions{plaintoc,openletterbookmarks}
\ProcessOptions\relax
\LoadClass{letteracdp}[2006/01/01]
\newcounter{section}[letter]
\newcounter{paragraph}[section]
\newcounter{figure}[letter]
\newcounter{table}[letter]
\AtBeginDocument{%
  \def\theHletter{\arabic{letter}}%
  \@ifpackageloaded{hyperref}{%
    \def\theHparagraph{\theHsection.\arabic{paragraph}}%
    \def\theHsection{\theHletter.\arabic{section}}%
    \def\toclevel@paragraph{2}%
  }{%
    \let\@letter@bookmark\@gobbletwo
  }%
}
\@ifdefinable\hyper@last{\let\hyper@last\relax}
%% Command \title and \author redefined to make changes local.
\def\title#1{\def\@title{#1}}
\def\author#1{\def\@author{#1}}
%% Inner command \@starttoc redefined to make table of contents, etc.
%% local to letters (this is tricky!).
\def\@starttoc#1{%
  \begingroup
    \vskip\parskip
    \parskip\z@skip
    \makeatletter
    \@input{\jobname.#1\number\c@letter}%
    \if@filesw
      \@ifundefined{tf@@#1}{%
        \expandafter\newwrite\csname tf@@#1\endcsname
      }\relax
      \immediate\write\@out@table@list{\string\@do@tf{#1}}%
    \fi
    \@nobreakfalse
  \endgroup
}
\g@addto@macro\@begin@letter@hook{%
  \edef\@cdp@reserved{%
    \noexpand\@letter@bookmark
      {\lettername\space\theletter}{letter.\theHletter}%
  }%
  \@cdp@reserved
  \if@filesw
    {\escapechar\m@ne
      \immediate\write\@out@table@list{\string\}^^J\string\{}%
    }%
    \immediate\write\@auxout
      {\string\@deferred@clopen{\number\c@letter}}%
  \fi
}
\@ifdefinable\@deferred@open  {\let\@deferred@open  \@gobble}
\@ifdefinable\@deferred@close {\let\@deferred@close \@empty}
\@ifdefinable\@deferred@clopen{\let\@deferred@clopen\@gobble}
\newwrite\@out@table@list
\newread\@in@table@list
\AtBeginDocument{%
  \if@filesw
    \immediate\openout\@out@table@list = \jobname.summ\relax
    {\escapechar\m@ne
      \immediate\write\@out@table@list{\string\{}%
    }%
    \immediate\write\@auxout{\string\@deferred@open{0}}%
    \def\@deferred@close{%
      \def\@do@tf##1{%
        \@restore@tf{##1}%
        \immediate\closeout \csname tf@##1\endcsname
        \global\expandafter\let\csname tf@##1\endcsname\@undefined
      }%
      \@temp@table@list
    }%
    \def\@deferred@open#1{%
      \ifeof\@in@table@list\else
        \read\@in@table@list to\@temp@table@list
        \def\@do@tf##1{%
          \@restore@tf{##1}%
          \immediate\openout
            \csname tf@##1\endcsname = \jobname.##1#1\relax
        }%
        \@temp@table@list
      \fi
    }%
    \def\@deferred@clopen#1{%
      \@deferred@close
      \@deferred@open{#1}%
    }%
  \fi
}
\AtEndDocument{%
  \if@filesw
    {\escapechar\m@ne
      \immediate\write\@out@table@list{\string\}}%
    }%
    \immediate\closeout\@out@table@list
    \clearpage
    \immediate\write\@auxout{\string\@deferred@close}%
    \openin\@in@table@list = \jobname.summ\relax
  \fi
}
\@ifdefinable\@restore@tf{\def\@restore@tf#1{%
  \edef\@tempa{%
    \let\csname tf@#1\endcsname\csname tf@@#1\endcsname
  }%
  \global\@tempa
}}
\@ifdefinable\@temp@table@list{\let\@temp@table@list\@empty}
\@ifdefinable\@addfullstop{\long\def\@addfullstop#1{%
  {\nonfrenchspacing\ignorespaces#1\unskip
  \ifnum \spacefactor>\@m \else.\fi \/}%
}}
\newcommand*\nopunct{\spacefactor 1001\relax}
\setcounter{topnumber}{\tw@}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{\@ne}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{\thr@@}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\c@dbltopnumber\c@topnumber
\let\dbltopfraction\topfraction
\let\dblfloatpagefraction\floatpagefraction
\setlength  \floatsep           {\bigskipamount}
\@msetlength\textfloatsep    {2}{\bigskipamount}
\setlength  \intextsep          {\bigskipamount}
\setlength  \dblfloatsep        {\bigskipamount}
\@msetlength\dbltextfloatsep {2}{\bigskipamount}
\setlength  \@fptop             {\z@ plus 1 fil}
\setlength  \@fpsep             {1\bigskipamount plus 2 fil}
\setlength  \@fpbot             {\z@ plus 1 fil}
\setlength  \@dblfptop          {\@fptop}
\setlength  \@dblfpsep          {\@fpsep}
\setlength  \@dblfpbot          {\@fpbot}
\setlength\abovecaptionskip{\medskipamount}
\setlength\belowcaptionskip{\z@skip}
\newcommand*\maketitle{%
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\thesenderaddress{\@author}%
    \def\thesubject{\leavevmode\@addfullstop\@title}%
    \let\@empty@sender\@empty
    \let\@thanks\@empty
    \makepresentation
    \@thanks
  \endgroup
  \setcounter{footnote}{\z@}%
  \maketopdate
}
\setcounter{secnumdepth}{\tw@}
\def\@seccntformat#1{\csname the#1\endcsname .\enspace}
\ifcase \@ptsize\relax
  \def\@sec@head@size{\@setfontsize\@sec@head@size\@xiipt{15}}
\or
  \def\@sec@head@size{\@setfontsize\@sec@head@size\@xiipt{17.4}}
\or
  \def\@sec@head@size{\@setfontsize\@sec@head@size\@xivpt{18.75}}
\fi
\newcommand*\section{\@startsection {section}{\@ne}%
  {\z@}%
  {-\bigskipamount}%
  {\smallskipamount}%
  {%
    \normalfont
    \noindent\null\@@par\nobreak\vskip-\baselineskip
    \parskip\z@skip
    \@sec@head@size\bfseries
  }%
}
\newcommand*\paragraph{\@startsection{paragraph}{\tw@}%
  {\z@}%
  {-\medskipamount}%
  {-.66667em}%
  {\normalfont\normalsize\itshape\@addfullstop}%
}
\newcommand*\epilogue{%
  \if@noskipsec \leavevmode \fi
  \par
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\bigskipamount
  \fi
}
\renewcommand*\thesection{\@arabic\c@section}
\renewcommand*\theparagraph{\thesection.\@arabic\c@paragraph}
\renewcommand*\thefigure{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{\@ne}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment*{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment*{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\renewcommand*\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{\tw@}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment*{table}
               {\@float{table}}
               {\end@float}
\newenvironment*{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\itshape \@addfullstop{#1: #2}}%
  \ifdim \wd\@tempboxa >\hsize
    \unhbox\@tempboxa\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip
}
\newcommand*\@pnumwidth{1.55em}
\newcommand*\@tocrmarg{2.55em}
\newcommand*\@dotsep{4.5}
\setcounter{tocdepth}{\@ne}
\newcommand*\tableofcontents{%
  \section*{\contentsname \sectionmark\contentsname}
  \if@toc@in@toc@
    \addcontentsline{toc}{section}{\protect\contentsname}%
  \fi
  \@starttoc{toc}%
}
\newcommand*\l@section{\@dottedtocline{\@ne}{\z@}{2em}}
\newcommand*\l@paragraph[2]{%
  \@dottedtocline{\tw@}{2em}{2.5em}{\small #1}{\small #2}%
}
\newcommand*\listoffigures{%
  \section*{\listfigurename \sectionmark\listfigurename}%
  \if@loX@in@toc@
    \addcontentsline{toc}{section}{\protect\listfigurename}%
  \fi
  \@starttoc{lof}%
}
\def\l@figure{\@dottedtocline{\@ne}{\z@}{2em}}
\newcommand*\listoftables{%
  \section*{\listtablename \sectionmark\listtablename}%
  \if@loX@in@toc@
    \addcontentsline{toc}{section}{\protect\listtablename}%
  \fi
  \@starttoc{lot}%
}
\let\l@table\l@figure
\newenvironment*{thebibliography}[1]{%
  \startbreaks
  \section*{\refname \sectionmark\refname}%
  \addcontentsline{toc}{section}{\protect\refname}%
  \vskip\parskip
  \parskip\z@skip
  \parindent\z@
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}%
  }%
  \sloppy
  \clubpenalty 4000
  \@clubpenalty \clubpenalty
  \widowpenalty 4000
  \sfcode`\.\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}
\newcommand*\newblock{\hskip .11em\@plus.33em\@minus.07em}
\newcommand*\bysame{\leavevmode\hbox to3em{\hrulefill}\thinspace}
\newcommand*\contentsname  {Sommario}
\newcommand*\listfigurename{Indice delle figure}
\newcommand*\listtablename {Indice delle tabelle}
\newcommand*\refname       {Testi citati}
\newcommand*\indexname     {Indice analitico}
\newcommand*\figurename    {Figura}
\newcommand*\tablename     {Tabella}
\endinput
%%
%% End of file `articoletteracdp.cls'.
