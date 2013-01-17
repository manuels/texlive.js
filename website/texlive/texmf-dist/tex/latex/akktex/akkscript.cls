%=====================================================================================================================================
% Class akkscript by Igor Akkerman (c) 2004, 2005
% Class for typesetting scripts.
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License (latest version).
%
% The latest version of this license can be found at
%     http://www.latex-project.org/lppl.txt
%
% This file may only be distributed together with the full 'AkkTeX' bundle.
%=====================================================================================================================================
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{akkscript}[2005/04/30 v1.0.0 by Igor Akkerman (c) 2004, 2005 Class for typesetting scripts.]
%=====================================================================================================================================

\makeatletter

% Initialisierungsteil
\RequirePackage{ifthen}
\RequirePackage{theorem}
\RequirePackage{akkconditional}

\AtBeginDocument{}

% Deklaration von Optionen
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{book}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{book}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{book}}

% Ausfuehrung von Optionen
\ProcessOptions

% Laden von Paketen
\LoadClass[a4paper]{book}

\RequirePackage{ifthen}

\RequirePackage{lscape}
\RequirePackage{longtable}
\RequirePackage{theorem}
\RequirePackage{float}
\RequirePackage{enumerate}
\RequirePackage{verbatim}

\RequirePackage[longpage,widepage,twoside,intlimits]{akktex}

% ---------------------------------------------------------
% definition of the \maketitle command
% ---------------------------------------------------------
\newcommand \akk@subtitle {}
\newcommand \subtitle[1] {%
    \renewcommand \akk@subtitle {#1}%
}

\newcommand \akk@maketitle {%
    \begin{titlepage}%
        \let \footnotesize \small
        \let \footnoterule \relax
        \let \footnote \thanks
        \null\vfil
        \vskip 60\p@
        \akk@widepage@setorigvalues%
        \hspace*\fill
        \begin{minipage}{\akk@orig@textwidth}%
            \begin{center}%
                \begin{Huge}%
                    \bfseries%
                    \@title\makebox[0pt]{\phantom{Mg}}%
                    \\%
                \end{Huge}%
                \ifset{akk@subtitle} {%
                    \vspace{2ex}%
                    \begin{large}%
                        \akk@subtitle%
                        \\%
                    \end{large}%
                }
                \vspace{3ex}%
                \begin{Large}%
                    \bfseries%
                    \begin{tabular}[t]{c}%
                        \@author\makebox[0pt]{\phantom{Mg}}%
                    \end{tabular}%
                    \\%
                \end{Large}%
                \ifbooltrue{akk@datetitle} {%
                    \vspace{3ex}%
                    \begin{large}%\bfseries%
                        \@date\\%
                    \end{large}%
                }%
                \vspace{2ex}%
            \end{center}%
        \end{minipage}%
        \hspace*\fill
        \akk@widepage@setdefaultvalues%
        \par
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
% ---------------------------------------------------------

% ---------------------------------------------------------
% theorem environments definition
% ---------------------------------------------------------
% needs to be defined here because it uses section numbers
% ---------------------------------------------------------
\theoremstyle{changebreak}

\theorembodyfont{\rmfamily\upshape}
\newtheorem      {definition}               {Definition} [section]
\newtheorem      {beispiel}    [definition] {Beispiel}
\newtheorem      {lemma}       [definition] {Lemma}
\newtheorem      {korollar}    [definition] {Korollar}
\newtheorem      {corollar}    [definition] {Corollar}
\newtheorem      {theorem}     [definition] {Theorem}
\newtheorem      {bemerkung}   [definition] {Bemerkung}
\newtheorem      {proposition} [definition] {Proposition}

\theorembodyfont {\rmfamily\itshape}
\newtheorem      {satz}        [definition] {Satz}
% ---------------------------------------------------------

\makeatother

