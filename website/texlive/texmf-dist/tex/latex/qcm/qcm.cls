%%
%% This is file `qcm.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% qcm.dtx  (with options: `qcmclass')
%% 


%% Copyright (C) 2004 Didier Verna

%% This file is part of QCM.

%% QCM may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.1
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%% http://www.latex-project.org/lppl.txt
%% and version 1.1 or later is part of all distributions of LaTeX
%% version 1999/06/01 or later.

%% QCM consists of the files listed in the file `README'.

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

\ProvidesClass{qcm}[2004/11/27 v2.1
                    Multiple Choice Questionnaire class for LaTeX2e]

\RequirePackage{qcm}[2004/11/09]

\def\@titlefont{\LARGE\bfseries}
\newcommand\titlefont[1]{\gdef\@titlefont{#1}}
\@onlypreamble\titlefont

\newlength\titlespace
\setlength\titlespace{20pt}

\@onlypreamble\title

\def\@make@title{%
  \begin{center}
    \@titlefont\@title
  \end{center}
  \vspace\titlespace}
\let\@maketitle\empty
\newcommand\maketitle{%
  \@make@title%
  \let\@maketitle\@make@title}

\let\old@makeform@nocorrection\makeform@nocorrection
\def\makeform@nocorrection{%
  \newpage
  \@maketitle
  \thispagestyle{empty}
  \old@makeform@nocorrection}

\let\old@makemask@nocorrection\makemask@nocorrection
\def\makemask@nocorrection{%
  \newpage
  \@maketitle
  \thispagestyle{empty}
  \old@makemask@nocorrection}

\newcommand\questiontitle[1]{\gdef\@questiontitle{#1}}

\def\@questiontitlefont{\bfseries}
\newcommand\questiontitlefont[1]{\gdef\@questiontitlefont{#1}}

\newlength\questiontitlespace
\setlength\questiontitlespace{5pt}

\newlength\questionsepspace
\setlength\questionsepspace{20pt}
\gdef\@questionsepspace{0pt}

\let\old@question\question
\let\old@endquestion\endquestion
\renewenvironment{question}[1]{%
  %% \begin{question}
  \vspace\@questionsepspace
  \fbox{\parbox[c]{0.25\linewidth}{\@questiontitlefont\@questiontitle}}
  \nopagebreak\vspace\questiontitlespace\par
  \old@question{#1}}{%
  %% \end{question}
  \old@endquestion
  \gdef\@questionsepspace{\questionsepspace}}

\DeclareOption{english}{%
  \questiontitle{Question N.\thequestion:}}
\DeclareOption{french}{%
  \questiontitle{Question N$^{o}$~\thequestion~:}}
\DeclareOption{francais}{%
  \ExecuteOptions{french}}

\DeclareOption{a4paper}{
  \setlength\paperheight{297mm}
  \setlength\paperwidth{210mm}}
\DeclareOption{a5paper}{
  \setlength\paperheight{210mm}
  \setlength\paperwidth{148mm}}
\DeclareOption{b5paper}{
  \setlength\paperheight{250mm}
  \setlength\paperwidth{176mm}}
\DeclareOption{letterpaper}{
  \setlength\paperheight{11in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{legalpaper}{
  \setlength\paperheight{14in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{executivepaper}{
  \setlength\paperheight{10.5in}
  \setlength\paperwidth{7.25in}}
\DeclareOption{landscape}{
  \setlength\@tempdima{\paperheight}
  \setlength\paperheight{\paperwidth}
  \setlength\paperwidth{\@tempdima}}

\DeclareOption{10pt}{\def\@ptsize{0}}
\DeclareOption{11pt}{\def\@ptsize{1}}
\DeclareOption{12pt}{\def\@ptsize{2}}

\DeclareOption{oneside}{\@twosidefalse\@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue\@mparswitchtrue}

\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

\ExecuteOptions{english,letterpaper,10pt,oneside,final}
\ProcessOptions

\input{size1\@ptsize.clo}
\setlength\parindent{0pt}
\setlength\parskip{0pt}
\setlength\tabcolsep{6pt}
\setlength\arrayrulewidth{0.4pt}
\raggedbottom
\onecolumn
\pagestyle{plain}
\pagenumbering{arabic}

\if@twoside
  \def\ps@headings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
  }
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
  }
\fi
\def\ps@myheadings{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{\thepage\hfil\slshape\leftmark}%
  \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
  \let\@mkboth\@gobbletwo
}

\endinput
%%
%% End of file `qcm.cls'.
