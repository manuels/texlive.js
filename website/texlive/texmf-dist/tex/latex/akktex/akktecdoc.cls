%=====================================================================================================================================
% Class akktecdoc by Igor Akkerman (c) 2004, 2005
% Class for typesetting technical documents.
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
\ProvidesClass{akktecdoc}[2005/04/30 v1.0.1 by Igor Akkerman (c) 2004, 2005 Class for typesetting technical documents.]
%=====================================================================================================================================

\makeatletter

% Initialisierungsteil
\RequirePackage{ifthen}
\RequirePackage{akkconditional}

\AtBeginDocument{}

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

\RequirePackage{akktex}

% ---------------------------------------------------------
% definition of the abstract: use original paragraph values
% ---------------------------------------------------------
\let \akk@orig@abstract    \abstract
\let \akk@orig@endabstract \endabstract
\renewenvironment {abstract} {%
    \akk@setoriginalvalues%
    \akk@orig@abstract%
}{%
    \akk@orig@endabstract%
    \akk@setdefaultvalues%
}
% ---------------------------------------------------------

% ---------------------------------------------------------
% definition of the \maketitle command
% ---------------------------------------------------------
\newcommand \akk@maketitle {%
    \normalsize%
    \begin{center}%
        \begin{Huge}%
            \bfseries%
            \@title\makebox[0pt]{\phantom{Mg}}%
            \\%
        \end{Huge}%
        \vspace{2.5ex}%
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
    \renewcommand \maketitle \relax%
}
% ---------------------------------------------------------

\makeatother
