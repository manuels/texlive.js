%=====================================================================================================================================
% Class akklecture by Igor Akkerman (c) 2005
% Class for typesetting lecture notes.
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
\ProvidesClass{akklecture}[2005/05/05 v1.0.0 by Igor Akkerman (c) 2005 Class for typesetting lecture notes.]
%=====================================================================================================================================

\makeatletter

% Initialisierungsteil
\AtBeginDocument{%
    \maketitle%
}

\AtEndDocument{%
    \label{lastpage}%
}

% Deklaration von Optionen
\DeclareOption {10pt}     {\PassOptionsToClass   {10pt}     {article}}
\DeclareOption {11pt}     {\PassOptionsToClass   {11pt}     {article}}
\DeclareOption {12pt}     {\PassOptionsToClass   {12pt}     {article}}
\DeclareOption {draft}    {\PassOptionsToClass   {draft}    {article}}
\DeclareOption {final}    {\PassOptionsToClass   {final}    {article}}

\DeclareOption {widepage} {\PassOptionsToPackage {widepage} {akktex}}
\DeclareOption {longpage} {\PassOptionsToPackage {longpage} {akktex}}

\DeclareOption* {\OptionNotUsed} % don't forward unknown options

% Ausfuehrung von Optionen
\ProcessOptions

% Laden von Paketen
\LoadClass[a4paper]{article}

\RequirePackage[longpage,widepage]{akktex}
\RequirePackage{fancyhdr}

% ---------------------------------------------------------
% set headers / footer
% ---------------------------------------------------------
\pagestyle{fancy}
\setlength \headheight \baselineskip  % maximum number of rows in header: 1
\setlength \headsep    \baselineskip  % vertical space between header and text
\lhead{\@title}
\chead{\thepage/\pageref{lastpage}}
\rhead{\@date}
\lfoot{}
\cfoot{}
\rfoot{}

% ---------------------------------------------------------
% remove \abstract command
% ---------------------------------------------------------
\global\let\abstract\relax

% ---------------------------------------------------------
% definition of the \maketitle command
% ---------------------------------------------------------
\newcommand \akk@maketitle {%
    \normalsize%
    \begin{large}%
        \bfseries%
        \@title\makebox[0pt]{\phantom{Mg}}%
        \hspace*\fill
        \@date%
    \end{large}%
    \renewcommand \maketitle \relax%
    \par%
}
% ---------------------------------------------------------

% ---------------------------------------------------------
% theorem environments definition
% ---------------------------------------------------------
% needs to be defined here because it doesn't use section numbers
% ---------------------------------------------------------
\theoremstyle{break}

\theorembodyfont{\rmfamily\upshape}
\newtheorem      {definition}               {Definition}
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
