%%
%% This is file `protocol.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% protocol.dtx  (with options: `protocol')
%% 
%% This is a generated file.
%% Copyright (C) 1997 Projektgruppe ACIT, Lehrstuhl VII,
%%                    Fachbereich Informatik, Universit"at Dortmund
%%               1997-1999,2006,2009-2012 Thomas Leineweber (protocol@tleine.de)
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Thomas Leineweber.
%% 
%% This work consists of the files protocol.dtx and protocol.ins,
%% protest.tex, readme
%% and the derived file protocol.cls.
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
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{protocol}
              [2012/02/18 v1.13
               LaTeX-Class fuer Sitzungs-Protokolle TL]
\DeclareOption{a5paper}
     {\ClassError{protocol}{Option `a5paper' not supported}{}}
\DeclareOption{b5paper}
     {\ClassError{protocol}{Option `b5paper' not supported}{}}
\DeclareOption{twocolumn}
     {\ClassError{protocol}{Option `twocolumn' not supported}{}}
\DeclareOption{titlepage}
     {\ClassError{protocol}{Option `titlepage' not supported}{}}
\DeclareOption{nonext}
     {\AtBeginDocument{\let\@makefoot\relax}}
\DeclareOption{signatures}
     {\AtBeginDocument{\let\@protocol@signatures\protocol@signatures}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\PassOptionsToClass{halfparskip}{scrartcl}
\LoadClass{scrartcl}
\def\groupname#1{\gdef\@groupname{#1}\gdef\ProtocolGroupName{#1}}
\def\chair#1{\gdef\@chair{#1}}
\def\writer#1{\gdef\@writer{#1}}
\def\place#1{\gdef\protocol@place{#1}}
\def\begintime#1{\gdef\@begintime{#1}}
\def\endtime#1{\gdef\@endtime{#1}}
\def\nextdate#1{\gdef\@nextdate{#1}}
\def\nextplace#1{\gdef\@nextplace{#1}}
\def\nexttime#1{\gdef\@nexttime{#1}}
\def\actionitem#1#2#3{\par Aufgabe: #1\\Verantwortlich: #2\\Termin: #3\par}
\def\vote#1#2#3#4#5{\par Abstimmung: #1\\Stimmen dafür: #2. Stimmen dagegen: #3. Enthaltungen: #4.\\Ergebnis: #5\par}
\def\@groupname{\ClassWarning{protocol}{No \noexpand\groupname given}}
\def\@chair{\ClassWarning{protocol}{No \noexpand\chair given}}
\def\@writer{\ClassWarning{protocol}{No \noexpand\writer given}}
\global\let\protocol@place\@empty
\global\let\@nextdate\@empty
\global\let\@nextplace\@empty
\gdef\@nexttime{\ClassWarning{protocol}{No \noexpand\nexttime given}}
\gdef\@begintime{\ClassWarning{protocol}{No \noexpand\beginn given}}
\gdef\@endtime{\ClassWarning{protocol}{No \noexpand\endtime given}}
\newcommand\makehead{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@makehead
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \global\let\makehead\relax
  \global\let\@makehead\relax
  \global\let\chairman\relax
  %\global\let\@chair\@empty
  \global\let\writer\relax
  %\global\let\@writer\@empty
  \global\let\place\relax
  \global\let\protocol@place\@empty
  \global\let\begintime\relax
  \global\let\@begintime\@empty
  \global\let\endtime\relax
  \global\let\@endtime\@empty
  \global\let\groupname\relax
  \global\let\@groupname\@empty
}
\def\@makehead{%
    \clearpage
    \let\footnote\thanks
    \null
    \vskip 2em%
    \begin{center}%
    {\titlefont\huge \@groupname \par}%
    \vskip 1.5em%
    {\Large
      \lineskip .5em%
Protokoll der Sitzung vom \@date \par}%
    \vskip 1em%
    {\Large Sitzungsleitung: \@chair\\
       Protokollf\"uhrer: \@writer \par}%
    \vskip \z@ \@plus 1em
  \end{center}%
  \par
  \vskip 2em{%
    \ifx\protocol@place\@empty
    \noindent\begin{tabular}{@{}ll}
      Beginn: & \@begintime\ Uhr \\
      Ende: &   \@endtime\ Uhr \\
    \end{tabular}
    \else
    \noindent\begin{tabular}{@{}ll}
      Beginn: & \@begintime\ Uhr \\
      Ende: &   \@endtime\ Uhr \\
      Ort: & \protocol@place \\
    \end{tabular}
    \fi\par}\vskip 0.5cm}
\newcommand{\@makefoot}{
    \ifx\@nextdate\@empty
      \section*{N\"achste Sitzung}
      Es wurde keine n\"achste Sitzung vereinbart.
    \else
       \section*{N\"achste Sitzung} Die n\"achste Sitzung
       findet am \@nextdate\ um \@nexttime\ Uhr statt.
       \ifx\@nextplace\@empty
         \ClassWarning{protocol}{No \noexpand\nextplace given}
        \else
         Ort:~\@nextplace.
       \fi
    \fi
    }
\newcommand{\protocol@signatures}{\vspace{20mm}\par\noindent\hrulefill\hrulefill\hfill\hrulefill\hrulefill\\
   \@chair\hfill\@writer\\
   (Sitzungsleitung)\hfill{}(Protokoll)\\[-1cm]\mbox{}}
\newcommand{\@makeend}{\@makefoot\@protocol@signatures}
\let\@protocol@signatures\relax
\newenvironment{Persons}{\section*{Anwesenheit:}}{}
\newenvironment{Absent}{\section*{Abwesenheit:}}{}
\AtBeginDocument{\makehead}
\AtEndDocument{\@makeend}
\endinput
%%
%% End of file `protocol.cls'.
