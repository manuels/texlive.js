%%
%% This is file `curve.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% curve.dtx  (with options: `header,curve')
%% 


%% Copyright (C) 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007 Didier Verna

%% Copyright (C) 2010 Didier Verna

%% This file is part of CurVe.

%% CurVe may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.1
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%% http://www.latex-project.org/lppl.txt
%% and version 1.1 or later is part of all distributions of LaTeX
%% version 1999/06/01 or later.

%% CurVe consists of the files listed in the file `README'.

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
\ProvidesClass{curve}[2010/12/14 v1.16 Curriculum Vitae class for LaTeX2e]

\RequirePackage{ltxtable}
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{filehook}

\gdef\@nextentry{}

\def\@keyfont{}
\newcommand\keyfont[1]{\gdef\@keyfont{#1}}

\newcolumntype{k}{>{\@keyfont}l}
\newcommand\keyalignment[1]{%
  \ifthenelse{\equal{#1}{l}}{}{%
    \ifthenelse{\equal{#1}{r}}{}{%
      \ifthenelse{\equal{#1}{c}}{}{%
        \ClassError{curve}{Invalid key alignment}{%
          You have called \protect\keyalignment\space with an invalid value.%
          \MessageBreak
          Valid options include l, c, and r.\MessageBreak
          Type X <return> to quit, fix the typo, and rerun LaTeX.}}}}%
  \newcolumntype{k}{>{\@keyfont}#1}}

\def\@prefix{\textbullet}
\newcommand\prefix[1]{\gdef\@prefix{#1}}

\def\@maybekey#1{%
  \def\@newkey{#1}%
  \ifx\@previouskey\@newkey\gdef\@@key{}\else%
    \gdef\@@key{#1}\gdef\@previouskey{#1}%
  \fi}

\def\@alwayskey#1{%
  \gdef\@@key{#1}}

\let\@key\@alwayskey
\DeclareOption{skipsamekey}{\let\@key\@maybekey}
\newcommand\@entry[2][]{%
  \gdef\@nextentry{}\@key{#1}%
  \egroup% end of \noalign opened in \entry.
  \@@key&\@prefix&#2\\\par}

\newcommand\@sentry[1][]{%
  \gdef\@nextentry{\\\par}\@key{#1}%
  \egroup% end of \noalign opened in \entry.
  \@@key&\@prefix&}

\newcommand\entry{%
  \@nextentry
  \noalign\bgroup\gdef\@beforespace{\subrubricbeforespace}%
  \@ifstar{\@sentry}{\@entry}}

\newlength{\@almosttextwidth}
\AtBeginDocument{\setlength\@almosttextwidth{\textwidth-\hfuzz}}

\newcommand\@text[1]{%
  \gdef\@nextentry{}%
  \egroup% end of \noalign opened in \text.
  \multicolumn{3}{@{}p{\@almosttextwidth}@{}}{#1}\\}

\newcommand\@stext{%
  \gdef\@nextentry{\egroup\\\par}%
  \egroup% end of \noalign opened in \text.
  \multicolumn{3}{@{}p{\@almosttextwidth}@{}}\bgroup}

\newcommand\text{%
  \@nextentry
  \noalign\bgroup\gdef\@beforespace{\subrubricbeforespace}%
  \@ifstar{\@stext}{\@text}}

\newcommand\noentry[1]{\@nextentry
  \noalign{\gdef\@nextentry{}}#1&&\kill}

\def\@subrubricfont{\Large\itshape}
\newcommand\subrubricfont[1]{\gdef\@subrubricfont{#1}}

\newlength\subrubricbeforespace
\setlength\subrubricbeforespace{20pt}

\newlength\subrubricspace
\setlength\subrubricspace{5pt}

\let\@subrubricmark\@gobble

\def\@@subrubric#1{%
  \rule{0bp}{\@beforespace}
  {\@subrubricfont#1}
  \@subrubricmark{#1}}

\def\@clcccolsep{\hspace{\tabcolsep}\ifx\@prefix\@empty~\fi}


\def\@subrubric@l#1{\multicolumn{3}{@{}l@{}}{\@@subrubric{#1}}}
\def\@subrubric@c#1{\multicolumn{3}{@{}c@{}}{\@@subrubric{#1}}}
\def\@subrubric@r#1{\multicolumn{3}{@{}r@{}}{\@@subrubric{#1}}}
\def\@subrubric@cl#1{&\multicolumn{2}{@{\@clcccolsep}l@{}}{\@@subrubric{#1}}}
\def\@subrubric@cc#1{&\multicolumn{2}{@{\@clcccolsep}c@{}}{\@@subrubric{#1}}}

\let\@subrubric\@subrubric@cl

\newcommand\subrubricalignment[1]{%
  \def\@curve@temp@a{\let\@subrubric}
  \expandafter\@curve@temp@a\csname @subrubric@#1\endcsname
  \@ifundefined{@subrubric}{%
    \ClassError{curve}{Invalid subrubric alignment}{%
      You have called \protect\subrubricalignment\space with an invalid value.%
      \MessageBreak
      Valid options include l, c, r, cl and cc.\MessageBreak
      Type X <return> to quit, fix the typo, and rerun LaTeX.}}
}

\newcommand\subrubric[1]{%
  \@nextentry
  \noalign{\gdef\@nextentry{}}%
  \@subrubric{#1}\\*[\subrubricspace]\par}

\def\@rubricfont{\Large\bfseries}
\newcommand\rubricfont[1]{\gdef\@rubricfont{#1}}

\newlength\rubricspace
\setlength\rubricspace{10pt}

\def\@@rubrichead#1{\@rubricfont#1}

\def\@rubrichead@l#1{\multicolumn{3}{@{}l@{}}{\@@rubrichead{#1}}}
\def\@rubrichead@c#1{\multicolumn{3}{@{}c@{}}{\@@rubrichead{#1}}}
\def\@rubrichead@r#1{\multicolumn{3}{@{}r@{}}{\@@rubrichead{#1}}}
\def\@rubrichead@cl#1{&\multicolumn{2}{@{\@clcccolsep}l@{}}{\@@rubrichead{#1}}}
\def\@rubrichead@cc#1{&\multicolumn{2}{@{\@clcccolsep}c@{}}{\@@rubrichead{#1}}}

\let\@rubrichead\@rubrichead@c

\newcommand\rubricalignment[1]{%
  \def\@curve@temp@a{\let\@rubrichead} \expandafter\@curve@temp@a\csname
  @rubrichead@#1\endcsname \@ifundefined{@rubrichead}{%
    \ClassError{curve}{Invalid rubric alignment}{%
      You have called \protect\rubricalignment\space with an invalid value.%
      \MessageBreak Valid options include l, c, r, cl and cc.\MessageBreak
      Type X <return> to quit, fix the typo, and rerun LaTeX.}} }

\newlength\rubricafterspace
\setlength\rubricafterspace{0pt}

\let\@rubricmark\@gobble

\newenvironment{rubric}[1]{%
  %% \begin{rubric}
  \def\raggedright{%
    \@rightskip\@flushglue\rightskip\@rightskip\leftskip\z@skip}%
  \def\raggedleft{%
    \rightskip\z@skip\leftskip\@flushglue\parfillskip\z@skip}%
  \gdef\@beforespace{0pt}%
  \gdef\@nextentry{}%
  \gdef\@previouskey{}%
  \global\let\old@newpage\newpage%
  \global\let\old@pagebreak\pagebreak%
  \global\let\old@nopagebreak\nopagebreak
  \begin{longtable}{@{}kl@{~}X@{}}
    \@rubrichead{#1}\\*[\rubricspace]
    \endfirsthead
    \@rubrichead{#1\@continuedname}\\*[\rubricspace]
    \endhead
    \noalign{\@rubricmark{#1}%
      \global\let\in@newpage\newpage%
      \global\let\in@pagebreak\pagebreak%
      \global\let\in@nopagebreak\nopagebreak%
      \gdef\newpage{\@nextentry\noalign{\gdef\@nextentry{}}\in@newpage}
      \gdef\pagebreak{\@nextentry\noalign{\gdef\@nextentry{}}\in@pagebreak}
      \gdef\nopagebreak{\@nextentry\noalign{\gdef\@nextentry{}}\in@nopagebreak}}}{%
    %% \end{rubric}
    \@nextentry
  \end{longtable}\par\vspace\rubricafterspace
  \global\let\newpage\old@newpage%
  \global\let\pagebreak\old@pagebreak%
  \global\let\nopagebreak\old@nopagebreak}

\newcommand\continuedname[1]{\gdef\@continuedname{#1}}

\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

\def\header@scale{.5}
\newcommand\headerscale[1]{\gdef\header@scale{#1}}
\@onlypreamble\headerscale

\newlength\headerspace
\setlength\headerspace{10pt}

\def\@leftheader{%
  \ClassError{curve}{No \protect\leftheader\space given}{%
    You have called \protect\makeheaders, %
    but you didn't provide a left header.\MessageBreak
    Type X <return> to quit, add a call to \protect\lefheader\space %
    in the preamble of your CV,\MessageBreak
    and rerun LaTeX.}}
\newcommand\leftheader[1]{\gdef\@leftheader{#1}}
\@onlypreamble\leftheader

\def\@rightheader{%
  \ClassError{curve}{No \protect\rightheader\space given}{%
    You have called \protect\makeheaders, %
    but you didn't provide a right header.\MessageBreak
    Type X <return> to quit, add a call to \protect\rightheader\space %
    in the preamble of your CV,\MessageBreak
    and rerun LaTeX.}}
\newcommand\rightheader[1]{\gdef\@rightheader{#1}}
\@onlypreamble\rightheader

\def\photo@scale{.1}
\newcommand\photoscale[1]{\gdef\photo@scale{#1}}
\@onlypreamble\photoscale

\newlength\photosep
\setlength\photosep{10pt}

\newcommand\photo[2][l]{%
  \RequirePackage{graphicx}
  \ifthenelse{\equal{#1}{l}}{}{%
    \ifthenelse{\equal{#1}{r}}{}{%
      \ifthenelse{\equal{#1}{c}}{}{%
        \ClassError{curve}{Invalid argument to \protect\photo}{%
          Argument 2 of \protect\photo must be `l', `r' or `c'.}}}}%
  \def\tmp@cmd{\global\let\makeheaders@}
  \expandafter\tmp@cmd\csname makeheaders@#1\endcsname
  \gdef\photo@file{#2}}
\@onlypreamble\photo

\newlength\photo@width

\def\includephoto@t{%
  \raisebox{.7\baselineskip-\height}{%
    \includegraphics[width=\photo@width]{\photo@file}}}

\def\includephoto@c{%
  \raisebox{-.5\height}{%
    \includegraphics[width=\photo@width]{\photo@file}}}

\def\includephoto@b{\includegraphics[width=\photo@width]{\photo@file}}

\newlength\leftheader@width
\newlength\rightheader@width

\def\makeheaders@l#1{%
  \setlength\photo@width{\photo@scale\textwidth} \setlength\leftheader@width{%
    (\textwidth - \photo@width - \photosep) * \real{\header@scale}}
  \setlength\rightheader@width{%
    \textwidth - \photo@width - \photosep - \leftheader@width}
  \parbox[#1]{\photo@width + \photosep}{\includephoto@\hspace\photosep}%
  \parbox[#1]{\leftheader@width}{\@leftheader}%
  \parbox[#1]{\rightheader@width}{\raggedleft\@rightheader}}

\def\makeheaders@c#1{%
  \setlength\photo@width{\photo@scale\textwidth}
  \setlength\leftheader@width{(\textwidth - \photo@width) * \real{.5}}
  \setlength\rightheader@width{\leftheader@width}
  \parbox[#1]{\leftheader@width}{\@leftheader}%
  \parbox[#1]{\photo@width}{\includephoto@}%
  \parbox[#1]{\rightheader@width}{\raggedleft\@rightheader}}

\def\makeheaders@r#1{%
  \setlength\photo@width{\photo@scale\textwidth}
  \setlength\leftheader@width{%
    (\textwidth - \photo@width - \photosep) * \real{\header@scale}}
  \setlength\rightheader@width{%
    \textwidth - \photo@width - \photosep - \leftheader@width}
  \parbox[#1]{\leftheader@width}{\@leftheader}%
  \parbox[#1]{\rightheader@width}{\raggedleft\@rightheader}%
  \parbox[#1]{\photo@width + \photosep}{\hspace\photosep\includephoto@}}

\def\makeheaders@#1{%
  \setlength\leftheader@width{\header@scale\textwidth}%
  \setlength\rightheader@width{\textwidth - \leftheader@width}%
  \parbox[#1]{\leftheader@width}{\@leftheader}%
  \parbox[#1]{\rightheader@width}{\raggedleft\@rightheader}}

\newcommand\makeheaders[1][c]{%
  \ifthenelse{\equal{#1}{t}}{}{%
    \ifthenelse{\equal{#1}{b}}{}{%
      \ifthenelse{\equal{#1}{c}}{}{%
        \ClassError{curve}{Invalid argument to \protect\makeheaders}{%
          Argument of \protect\makeheaders must be `t', `b' or `c'.}}}}%
  \def\tmp@cmd{\global\let\includephoto@}
  \expandafter\tmp@cmd\csname includephoto@#1\endcsname
  \makeheaders@{#1}%
  \par\vspace\headerspace}

\@onlypreamble\title

\def\@titlefont{\Huge\bfseries}
\newcommand\titlefont[1]{\gdef\@titlefont{#1}}
\@onlypreamble\titlefont

\newlength\titlespace
\setlength\titlespace{0pt}

\let\@subtitle\@undefined
\newcommand\subtitle[1]{\gdef\@subtitle{#1}}
\@onlypreamble\subtitle

\def\@subtitlefont{\huge\itshape}
\newcommand\subtitlefont[1]{\gdef\@subtitlefont{#1}}
\@onlypreamble\subtitlefont

\def\@titlealignment@l{\raggedright}
\def\@titlealignment@c{\centering}
\def\@titlealignment@r{\raggedleft}

\let\@title@lignment\@titlealignment@c

\def\@titlealignment#1#2{%
  \def\@curve@temp@a{\let\@title@lignment}
  \expandafter\@curve@temp@a\csname @titlealignment@#2\endcsname
  \@ifundefined{@title@lignment}{%
    \ClassError{curve}{Invalid title alignment}{%
      You have called \expandafter\string\csname#1\endcsname\space%
      with an invalid value.%
      \MessageBreak
      Valid options include l, c and r.\MessageBreak
      Type X <return> to quit, fix the typo, and rerun LaTeX.}}
}

\newcommand\titlealignment[1]{\@titlealignment{titlealignment}{#1}}

\def\@@maketitle{%
  \bgroup\trivlist\@title@lignment\item\relax {\@titlefont\@title}
  \ifx\@subtitle\@undefined\else\\\@subtitlefont\@subtitle\fi
  \endtrivlist\egroup
  \vspace\titlespace}

\def\@maketitle[#1]{\@titlealignment{maketitle}{#1}\@@maketitle}

\newcommand\maketitle{\@ifnextchar[%]
  \@maketitle\@@maketitle}

\let\@flavor\empty \newcommand\flavor[1]{\gdef\@flavor{#1}
  \ifx\@flavor\empty\else\edef\@flavor{.\@flavor}\fi}

\DeclareOption{ask}{%
  \typein[\@flavor]{Please specify a CV flavor (none by default):}
  \ifx\@flavor\empty\else\edef\@flavor{.\@flavor}\fi}

\def\@curveinput#1{%
  \IfFileExists{#1\@flavor.ltx}{\@iinput{#1\@flavor.ltx}}{%
    \IfFileExists{#1\@flavor.tex}{\@iinput{#1\@flavor.tex}}{%
      \IfFileExists{#1.ltx}{\@iinput{#1.ltx}}{%
\IfFileExists{#1.tex}{\@iinput{#1.tex}}{%
  \@iinput{#1}}}}}}
\renewcommand\input{\@ifnextchar\bgroup\@curveinput\@@input}

\newcommand\makerubric[1]{\LTXtable{\linewidth}{#1}}

\PassOptionsToPackage{export}{splitbib}

\let\newblock\empty
\DeclareOption{openbib}{\let\newblock\par}

\newcounter{bibcount}
\newcounter{bibtotal}
\newif\ifcurve@revbib\curve@revbibfalse
\AtEndDocument{
  \if@filesw
    \immediate\write\@auxout{\string\setcounter{bibtotal}{\thebibcount}}%
  \fi}
\DeclareOption{revbib}{\curve@revbibtrue}

\newcommand\listpubname[1]{\gdef\@listpubname{#1}}

\def\@curve@input@#1{%
  \IfFileExists{#1}{\makerubric{#1}}{\typeout{No file #1.}}}

\let\@curveltx@lbibitem\@lbibitem
\def\@curve@lbibitem[#1]#2{\@sentry[\@biblabel{#1}]%
  \if@filesw
    {\let\protect\noexpand%
     \immediate\write\@auxout{\string\bibcite{#2}{#1}}}%
  \fi%
  \ignorespaces}
\let\@lbibitem\@curve@lbibitem

\let\@curveltx@bibitem\@bibitem
\def\@curve@bibitem#1{\stepcounter{bibcount}%
  \@sentry[\@biblabel{\ifcurve@revbib\thebibtotal\else\thebibcount\fi}]%
  \ifcurve@revbib\addtocounter{bibtotal}{-1}\fi%
  \if@filesw
    \immediate\write\@auxout{\string\bibcite{#1}{\thebibcount}}%
  \fi%
  \ignorespaces}
\let\@bibitem\@curve@bibitem

\let\@curveltxbibitem\bibitem
\def\@curvebibitem{%
  %% #### FIXME: Dirty code duplication from \entry.
  \@nextentry
  \noalign\bgroup\gdef\@beforespace{\subrubricbeforespace}%
  \@ifnextchar[%]
  \@lbibitem\@bibitem}
\let\bibitem\@curvebibitem

\AtBeginOfFile{bibentry.sty}{
  \let\@lbibitem\@curveltx@lbibitem
  \let\@bibitem\@curveltx@bibitem
  \let\bibitem\@curveltxbibitem}

\AtBeginOfFile{splitbib.sty}{
  \let\@lbibitem\@curveltx@lbibitem
  \let\@bibitem\@curveltx@bibitem
  \let\bibitem\@curveltxbibitem}

\AtBeginOfFile{hyperref.sty}{
  \let\@curveprevious@lbibitem\@lbibitem
  \let\@curveprevious@bibitem\@bibitem}
\AtEndOfFile{hyperref.sty}{
  \let\@lbibitem\@curveprevious@lbibitem
  \let\@bibitem\@curveprevious@bibitem}

\newenvironment{thebibliography}[1]{%
  \let\@key\@alwayskey
  \def\@prefix{}
  \begin{rubric}{\@ifundefined{bibname}{%
\@ifundefined{refname}{\@listpubname}{\refname}}{%
\bibname}}
  }{%
  \end{rubric}
}

\let\@curveltxbibliography\bibliography
\def\bibliography#1{%
  \if@filesw
    \immediate\write\@auxout{\string\bibdata{#1}}%
  \fi%
  \@curve@input@{\jobname.bbl}}

\AtEndOfFile{multibbl.sty}{
  \def\bibliography##1##2##3{%
    \@ifundefined{##1@auxfile}{}{%
      \expandafter\immediate\write\csname ##1@auxfile\endcsname%
      {\string\bibdata{##2}}}%
    \def\bibname{##3}%
    \def\refname{##3}%
    \@curve@input@{##1.bbl}}}

\AtBeginOfFile{splitbib.sty}{
  \let\bibliography\@curveltxbibliography}

\AtEndOfFile{splitbib.sty}{
  \def\NMSB@writeentry##1##2##3##4##5,{\ifx\relax ##5\relax
    \else
      \def\NMSB@currcat{##1##2##3##4}%
      \def\NMSB@currcatlevelone{##1##2}%
      \ifx\NMSB@currcatlevelone\NMSB@prevcatlevelone\else
        \expandafter\ifx\csname NMSBtitle@\NMSB@currcatlevelone
         \endcsname\relax
        \else
          \if@filesw
            \expandafter\let\expandafter\NMSB@tempentry
              \csname NMSBtitle@\NMSB@currcatlevelone\endcsname
            \edef\NMSB@tempentry{\@backslashchar subrubric{\NMSB@tempentry}}
            \expandafter\NMSB@writecatbib\expandafter{\NMSB@tempentry}
            \expandafter\ifx\csname
             NMSBcomment@\NMSB@currcatlevelone\endcsname\relax
            \else
              \immediate\write\NMSB@catbib{\string\vskip2ex^^J%
                \string\hspace{-\leftmargin}\string\relax^^J%
                \string\begin{minipage}{\textwidth}^^J%
                \string\addtolength\string\parindent{20pt}^^J%
                \string\noindent}
              \expandafter\let\expandafter\NMSB@tempentry
                \csname NMSBcomment@\NMSB@currcatlevelone\endcsname
              \expandafter\NMSB@writecatbib\expandafter{%
                \NMSB@tempentry^^J}%
              \immediate\write\NMSB@catbib{\string\end{minipage}^^J%
                \string\par\string\addpenalty{\NMSB@penalty}
                \string\vskip2ex}
            \fi
          \fi
        \fi
        \xdef\NMSB@prevcatlevelone{##1##2}%
        \ifnum\theSBresetdepth>0\relax
          \setcounter{\@listctr}{0}%
        \fi
        \expandafter\ifx\csname NMSBprefix@\NMSB@prevcatlevelone
         \endcsname\relax
          \NMSB@currprefixlevelonetok{\relax}%
        \else
          \expandafter\expandafter\expandafter\NMSB@currprefixlevelonetok
          \expandafter\expandafter\expandafter{%
             \csname NMSBprefix@\NMSB@prevcatlevelone\endcsname}%
        \fi
      \fi
      \ifx\NMSB@currcat\NMSB@prevcat\else
        \ifnum\NMSB@currcat=9999\else
          \expandafter\ifx\csname NMSBtitle@\NMSB@currcat\endcsname
           \relax
          \else
            \if@filesw
              \immediate\write\NMSB@catbib{%
                \string\par\string\addpenalty{-\NMSB@halfpenalty}%
                \string\relax^^J%
                \string\item[]%
                \string\SBsubtitle}%
              \expandafter\let\expandafter\NMSB@tempentrya
                \csname NMSBtitle@\NMSB@currcatlevelone\endcsname
              \expandafter\let\expandafter\NMSB@tempentryb
                \csname NMSBtitle@\NMSB@currcat\endcsname
              \expandafter\NMSB@writecatbib\expandafter{%
                \expandafter{\NMSB@tempentrya}}
              \expandafter\NMSB@writecatbib\expandafter{%
                \expandafter{\NMSB@tempentryb}}
              \immediate\write\NMSB@catbib{\string\relax^^J%
                \string\par\string\addpenalty{\NMSB@penalty}%
                \string\relax}%
              \expandafter\ifx\csname
               NMSBcomment@\NMSB@currcat\endcsname\relax
              \else
                \immediate\write\NMSB@catbib{\string\vskip2ex^^J%
                  \string\hspace{-\leftmargin}\string\relax^^J%
                  \string\begin{minipage}{\textwidth}^^J%
                  \string\addtolength\string\parindent{20pt}^^J%
                  \string\noindent}
                \expandafter\let\expandafter\NMSB@tempentry
                  \csname NMSBcomment@\NMSB@currcat\endcsname
                \expandafter\NMSB@writecatbib\expandafter{%
                  \NMSB@tempentry^^J}%
                \immediate\write\NMSB@catbib{\string\end{minipage}^^J%
                  \string\par\string\addpenalty{\NMSB@penalty}%
                  \string\vskip2ex}
              \fi
            \fi
          \fi
        \fi
        \xdef\NMSB@prevcat{##1##2##3##4}%
        \ifnum\theSBresetdepth>1\relax
          \setcounter{\@listctr}{0}%
        \fi
        \expandafter\ifx\csname NMSBprefix@\NMSB@currcat\endcsname\relax
          \expandafter\NMSB@currprefixtok\expandafter{%
             \the\NMSB@currprefixlevelonetok}%
        \else
          \expandafter\expandafter\expandafter\NMSB@currprefixtok
          \expandafter\expandafter\expandafter{%
            \csname NMSBprefix@\NMSB@currcat\endcsname}
        \fi
      \fi
      \expandafter\ifx\csname NMSBlabel@##5\endcsname\relax
        \if@filesw
          \stepcounter\@listctr
          \expandafter\ifx\expandafter\relax\the\NMSB@currprefixtok
            \def\NMSB@tempentry{}%
          \else
            \expandafter\expandafter\expandafter\def
            \expandafter\expandafter\expandafter\NMSB@tempentry
            \expandafter\expandafter\expandafter{%
              \expandafter\the\expandafter\NMSB@currprefixtok
                      \the\value{\@listctr}}%
            \edef\NMSB@tempentry{[\NMSB@tempentry]}
          \fi
          \edef\NMSB@tempentry{%
            \@backslashchar bibitem%
            \NMSB@tempentry{\csname NMSBkey@##5\endcsname}}%
          \expandafter\NMSB@writecatbib\expandafter{%
            \NMSB@tempentry}
          \expandafter\let\expandafter\NMSB@tempentry
            \csname NMSBentry@##5\endcsname%
          \expandafter\NMSB@writecatbib\expandafter{%
            \NMSB@tempentry}
        \fi
        \setbox\@tempboxa=\hbox{\the\NMSB@currprefixtok\the\value{\@listctr}}%
        \ifdim\NMSB@reallylongest<\wd\@tempboxa
          \setlength{\NMSB@reallylongest}{\wd\@tempboxa}%
          \xdef\NMSB@reallylongestlabel{%
            \expandafter\ifx\expandafter\relax\the\NMSB@currprefixtok
    \else\the\NMSB@currprefixtok\fi\the\value{\@listctr}}%
        \fi
      \else
        \if@filesw
          \immediate\write\NMSB@catbib{%
            \string\bibitem}
          \expandafter\let\expandafter\NMSB@tempentry
            \csname NMSBlabel@##5\endcsname
          \expandafter\NMSB@writecatbib\expandafter{%
            \expandafter[\NMSB@tempentry]}%
          \immediate\write\NMSB@catbib{%
            {\csname NMSBkey@##5\endcsname}}%
          \expandafter\let\expandafter\NMSB@tempentry
            \csname NMSBentry@##5\endcsname%
          \expandafter\NMSB@writecatbib\expandafter{%
            \NMSB@tempentry^^J^^J}
        \fi
        \setbox\@tempboxa=\hbox{\csname NMSBlabel@##5\endcsname}%
        \ifdim\NMSB@reallylongest<\wd\@tempboxa
          \setlength{\NMSB@reallylongest}{\wd\@tempboxa}%
          \expandafter\let\expandafter\NMSB@reallylongestlabel\csname
    NMSBlabel@##5\endcsname
        \fi
      \fi
    \fi
  }
  \def\endthebibliography{%
    \usecounter{enumiv}%
    \edef\NMSB@sortedvaluelist{%
      \expandafter\NMSBsortlt\expandafter{\NMSB@valuelist}}%
    \expandafter\NMSB@writelist\expandafter{\NMSB@sortedvaluelist}%
    \if@filesw
      \immediate\write\NMSB@catbib{%
        \string\end{thebibliography}}
      \immediate\closeout\NMSB@catbib
    \fi
    \begingroup
      \ifNMSB@newchap\else
        \@ifundefined{chapter}{\def\section####1####2{}}{%
          \def\chapter####1####2{}}%
      \fi
      \let\thebibliography\@NMSBorig@thebibliography
      \let\endthebibliography\@NMSBorig@endthebibliography
      \let\bibitem\@curvebibitem
      \let\@lbibitem\@curve@lbibitem
      \let\@bibitem\@curve@bibitem
      \@curve@input@{\jobname.sbb}
    \endgroup
    \ifx\NMSB@missingcat\NMSB@empty\else
      \expandafter\NMSB@warnnocateg\NMSB@missingcat\end
    \fi
    \ifNMSB@strict
      \ifx\NMSB@doublecat\NMSB@empty\else
        \expandafter\NMSB@warndblcateg\NMSB@doublecat\end
      \fi
    \fi
    \ifdim\NMSB@reallylongest=\NMSB@longest\relax\else
      \NMSB@warnwronglongest
    \fi}}

\DeclareOption{english}{%
  \continuedname{~(continued)}
  \listpubname{List of Publications}}
\DeclareOption{french}{%
  \continuedname{~(suite)}
  \listpubname{Liste des Publications}}
\DeclareOption{francais}{%
  \ExecuteOptions{french}}
\DeclareOption{spanish}{%
  \continuedname{~(contin\'ua)}
  \listpubname{Lista de Publicaciones}}
\DeclareOption{portuges}{%
  \continuedname{~(continua\c c\~ao)}
  \listpubname{Publica\c c\~oes}}
\DeclareOption{portuguese}{%
  \ExecuteOptions{portuges}}
\DeclareOption{brazil}{%
  \ExecuteOptions{portuges}}
\DeclareOption{brazilian}{%
  \ExecuteOptions{portuges}}
\DeclareOption{italian}{%
  \continuedname{~(continua)}
  \listpubname{Pubblicazioni}}
\DeclareOption{german}{%
  \continuedname{~(fortgesetzt)}
  \listpubname{Verzeichnis der Ver\"offentlichungen}}
\DeclareOption{ngerman}{%
  \ExecuteOptions{german}}
\DeclareOption{dutch}{%
  \continuedname{~(vervolg)}
  \listpubname{Publicaties}}
\DeclareOption{danish}{%
  \continuedname{~(fortsat)}
  \listpubname{Udgivelser}}
\DeclareOption{swedish}{%
 \continuedname{~(forts.)}
 \listpubname{Publikationer}}
\DeclareOption{polish}{
  \continuedname{~(kontynuacja)}
  \listpubname{Publikacje}}

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
\DeclareOption{final}{%
  \setlength\overfullrule{0pt}
  \setlongtables}

\ExecuteOptions{english,letterpaper,10pt,oneside,final}
\ProcessOptions

\input{size1\@ptsize.clo}
\setlength\parindent{0pt}
\setlength\parskip{0pt}
\setlength\tabcolsep{10pt}
\setlength\arrayrulewidth{.4\p@}
\setlength\leftmargini{2.5em}
\leftmargin\leftmargini
\setlength\leftmarginii{2.2em}
\setlength\leftmarginiii{1.87em}
\setlength\leftmarginiv{1.7em}
\setlength\leftmarginv{1em}
\setlength\leftmarginvi{1em}
\setlength\labelsep{.5em}
\setlength\labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\raggedbottom
\onecolumn
\pagestyle{empty}
\pagenumbering{arabic}

\newcommand\@makefntext[1]{\noindent\hb@xt@1em{\hss\@makefnmark}#1}

\if@twoside
  \def\ps@headings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\@rubricmark##1{\markboth{\MakeUppercase{##1}}{}}%
    \def\@subrubricmark##1{\markright{##1}}%
  }
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\@rubricmark##1{\markright{\MakeUppercase{##1}}}%
  }
\fi
\def\ps@myheadings{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{\thepage\hfil\slshape\leftmark}%
  \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
  \let\@mkboth\@gobbletwo
  \let\@rubricmark\@gobble
  \let\@subrubricmark\@gobble
}

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}

\endinput
%%
%% End of file `curve.cls'.
