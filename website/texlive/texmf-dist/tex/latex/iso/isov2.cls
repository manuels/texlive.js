%%
%% This is file `isov2.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% isoe.dtx  (with options: `iso')
%% 
%%      This work has been partially funded by the US government and is
%%  not subject to copyright.
%% 
%%      This program is provided under the terms of the
%%  LaTeX Project Public License distributed from CTAN
%%  archives in directory macros/latex/base/lppl.txt.
%% 
%%  Author: Peter Wilson (CUA and NIST)
%%          now at: peter.r.wilson@boeing.com
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{isov2}[2002/07/22 v2.4 LaTeX ISO document class]
\RequirePackage{url}
\newcommand{\@ptsize}{}
\newif\if@restonecol
\def\isostringsequal #1#2{%
  TT\fi
  \edef\@is@str@ngsequali{#1}%
  \edef\@is@str@ngsequalii{#2}%
  \ifx\@is@str@ngsequali\@is@str@ngsequalii}
\def\isoemptystring #1{%
  TT\fi
  \if\isostringsequal{#1}{}}
\newcommand{\fillline}{\mbox{}\hrulefill\mbox{}}
\newcommand{\makecommand}{\@star@or@long\make@command}
\newcommand{\make@command}[1]{%
  \let\@ifdefinable\@rc@ifdefinable
  \new@command#1}
\newif\ifpdf
\ifx\pdfoutput\undefined
  \pdffalse
\else
  \pdftrue
\fi
\newif\ifisohyper
  \isohyperfalse
\AtBeginDocument{%
  \@ifpackageloaded{hyperref}%
      {\isohypertrue}%
      {\newcommand{\hyperpage}[1]{#1}}%
}

\newif\if@us\@usfalse
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%   %% 11.69in
    \setlength\paperwidth  {210mm}}   %%  8.27in
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%    %% 279mm
    \setlength\paperwidth  {8.5in}%   %% 216mm
    \@ustrue}
\renewcommand{\@ptsize}{1}
\DeclareOption{9pt}{\renewcommand{\@ptsize}{9}}
\DeclareOption{10pt}{\renewcommand{\@ptsize}{0}}
\DeclareOption{11pt}{\renewcommand{\@ptsize}{1}}
\@twosidetrue  \@mparswitchtrue
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\newif\ifc@pyright\c@pyrightfalse
\newif\ifc@pyrightopt\c@pyrightoptfalse
\DeclareOption{copyright}{\c@pyrightopttrue}
\DeclareOption{notcopyright}{\c@pyrightoptfalse}
\newif\ifisstandard\isstandardfalse
\newif\iffdisstandard\fdisstandardfalse
\newif\ifdisstandard\disstandardfalse
\newif\ifcdstandard\cdstandardfalse
\newif\ifwdstandard\wdstandardfalse
\newif\iftechrep\techrepfalse
\newif\ifotherdoc\otherdocfalse
\newif\iftechspec\techspecfalse
\newif\ifpaspec\paspecfalse
\DeclareOption{is}{\isstandardtrue
                   \fdisstandardfalse
                   \disstandardfalse
                   \cdstandardfalse
                   \wdstandardfalse
                   \techrepfalse
                   \techspecfalse
                   \paspecfalse
                   \otherdocfalse}
\DeclareOption{fdis}{\isstandardfalse
                   \fdisstandardtrue
                   \disstandardfalse
                   \cdstandardfalse
                   \wdstandardfalse
                   \techrepfalse
                   \techspecfalse
                   \paspecfalse
                   \otherdocfalse}
\DeclareOption{dis}{\isstandardfalse
                   \fdisstandardfalse
                   \disstandardtrue
                   \cdstandardfalse
                   \wdstandardfalse
                   \techrepfalse
                   \techspecfalse
                   \paspecfalse
                   \otherdocfalse}
\DeclareOption{cd}{\isstandardfalse
                   \fdisstandardfalse
                   \disstandardfalse
                   \cdstandardtrue
                   \wdstandardfalse
                   \techrepfalse
                   \techspecfalse
                   \paspecfalse
                   \otherdocfalse
                   \c@pyrightfalse}
\DeclareOption{wd}{\isstandardfalse
                   \fdisstandardfalse
                   \disstandardfalse
                   \cdstandardfalse
                   \wdstandardtrue
                   \techrepfalse
                   \techspecfalse
                   \paspecfalse
                   \otherdocfalse
                   \c@pyrightfalse}
\DeclareOption{techrep}{\isstandardfalse
                   \fdisstandardfalse
                   \disstandardfalse
                   \cdstandardfalse
                   \wdstandardfalse
                   \techreptrue
                   \techspecfalse
                   \paspecfalse
                   \otherdocfalse}
\DeclareOption{techspec}{\isstandardfalse
                   \fdisstandardfalse
                   \disstandardfalse
                   \cdstandardfalse
                   \wdstandardfalse
                   \techrepfalse
                   \techspectrue
                   \paspecfalse
                   \otherdocfalse}
\DeclareOption{pas}{\isstandardfalse
                   \fdisstandardfalse
                   \disstandardfalse
                   \cdstandardfalse
                   \wdstandardfalse
                   \techreptrue
                   \techspecfalse
                   \paspectrue
                   \otherdocfalse}
\DeclareOption{otherdoc}{\isstandardfalse
                   \fdisstandardfalse
                   \disstandardfalse
                   \cdstandardfalse
                   \wdstandardfalse
                   \techrepfalse
                   \techspecfalse
                   \paspecfalse
                   \otherdoctrue
                   \c@pyrightfalse}
\newif\ifdr@ftd@c\dr@ftd@cfalse
\setlength{\overfullrule}{\z@}
\DeclareOption{final}{\setlength{\overfullrule}{\z@}
                      \dr@ftd@cfalse}
\DeclareOption{draft}{\setlength\overfullrule{5pt}%
                      \dr@ftd@ctrue}
\ExecuteOptions{notcopyright,otherdoc,final,a4paper,11pt,onecolumn}
\ProcessOptions
\c@pyrightfalse
\ifc@pyrightopt
  \c@pyrighttrue
\fi
\ifnum\@ptsize < \tw@
  \input{iso1\@ptsize.clo}
\else
  \input{iso\@ptsize.clo}
\fi
  \newcommand{\captionsize}{\normalsize}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand{\baselinestretch}{}
\setlength\parindent{\z@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\clubpenalty  1000
\widowpenalty 1000
\setlength\headheight{12\p@}
\setlength\headsep{12\p@}
\setlength\footskip{24\p@}
\setlength\maxdepth{.5\topskip}
\setlength\@maxdepth\maxdepth
\setlength\textwidth{160mm}
%%%\setlength\textheight{221.5mm}
\setlength\textheight{252mm}
\setlength\columnsep{10mm}
%%%\setlength\topmargin{0mm}
\setlength\topmargin{-13.5mm}
\setlength\oddsidemargin{0mm}
\setlength\evensidemargin{0mm}
\setlength\marginparwidth{0pt}
\setlength\marginparsep{0pt}
\setlength\marginparpush{3mm}
\ifdr@ftd@c
    \setlength\marginparwidth{20mm}
    \setlength\marginparsep{0.5mm}
\fi
\if@us
%%%    \setlength\topmargin{-9.4mm}
%%%    \setlength\oddsidemargin{1.55mm}
%%%    \setlength\evensidemargin{1.55mm}
    \addtolength{\topmargin}{-9mm}
    \setlength\oddsidemargin{2mm}
    \setlength\evensidemargin{2mm}
    \typeout{ }
    \typeout{*********************************************************}
    \typeout{* Warning: You have used the letterpage option. *********}
    \typeout{* This will not be acceptable as ISO camera ready copy. *}
    \typeout{*********************************************************}
    \typeout{ }
\fi
\setlength\footnotesep{12\p@}
\setlength{\skip\footins}{6\p@ \@plus 2\p@ \@minus 2\p@}
\setcounter{topnumber}{2}
\renewcommand{\topfraction}{.8}
\setcounter{bottomnumber}{2}
\renewcommand{\bottomfraction}{.5}
\setcounter{totalnumber}{4}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.7}
\setcounter{dbltopnumber}{2}
\renewcommand{\dbltopfraction}{.8}
\renewcommand{\dblfloatpagefraction}{.7}
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep   {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
 %%%\mark{{}{}}   % Initializes TeX's marks   <--- can vanish
\gdef\thestandard{}
\gdef\thesyear{}
\gdef\theslanguage{}
\def\standard#1{\gdef\thestandard{#1}}
\def\yearofedition#1{\gdef\thesyear{#1}}
\def\languageofedition#1{\gdef\theslanguage{#1}}
\ifotherdoc
    \newcommand{\@runninghead}{\thestandard}
\else
    \newcommand{\@runninghead}{\thestandard:\thesyear\theslanguage}
\fi

\newcommand{\copyrighthead}{\ifc@pyright
  {\mbox{\copyright \textsc{\copyrightname} \thesyear{} --- All rights reserved}}
  \else
    \mbox{}
  \fi}

\newcommand{\extrahead}{\mbox{}}

\newcommand{\ps@headings}{%
    \def\@oddhead{\bfseries\extrahead\hfil\@runninghead}%
    \def\@evenhead{\bfseries\@runninghead\hfil\extrahead}%
    \def\@oddfoot{\copyrighthead\hfil\thepage}%
    \def\@evenfoot{\thepage\hfil\copyrighthead}}
\newcommand{\ps@startpage}{%
    \def\@oddhead{\bfseries\extrahead\hfil\@runninghead}%
    \def\@evenhead{\bfseries\@runninghead\hfil\extrahead}%
    \def\@oddfoot{\hfil\thepage}%
    \def\@evenfoot{\thepage\hfil}}
\newcommand{\ps@nohead}{%
    \def\@oddhead{}%
    \def\@evenhead{}%
    \def\@oddfoot{}%
    \def\@evenfoot{}}
\newcommand{\rectoisotitlehead}{%
    \fillline\vspace{0.1\baselineskip}\linebreak%
    {\bfseries \uppercase{\ISname}}
%%     \mbox{\ifc@pyright\space\copyright {\scshape \copyrightname}\else
%%           \space{\scshape (\copyrightname)}\fi}
     \hfil {\bfseries \@runninghead}%
    \vspace{-0.5\baselineskip}\linebreak\fillline}
\newcommand{\versoisotitlehead}{%
    \fillline\vspace{0.1\baselineskip}\linebreak%
    {\bfseries \@runninghead} \hfil
       {\bfseries \uppercase{\ISname}}
%%     \mbox{\ifc@pyright\space\copyright {\scshape \copyrightname}\else
%%           \space{\scshape (\copyrightname)}\fi}
    \vspace{-0.5\baselineskip}\linebreak\fillline}
\def\ps@isotitlehead{%
    \def\@oddhead{\parbox{\textwidth}{\protect\rectoisotitlehead}}%
    \def\@evenhead{\parbox{\textwidth}{\protect\versoisotitlehead}}%
%%    \def\@oddfoot{\hfil\thepage}%
%%    \def\@evenfoot{\thepage\hfil}}
    \def\@oddfoot{\copyrighthead\hfil\thepage}%
    \def\@evenfoot{\thepage\hfil\copyrighthead}}
\gdef\thetitle{}
\newcommand{\introelement}[1]{\if\isoemptystring{#1}\else {#1 ---\newline}\fi}
\newcommand{\mainelement}[1]{#1}
\newcommand{\compelement}[1]{\if\isoemptystring{#1}\else { --- \newline #1}\fi}
\renewcommand{\title}[3]{%
    \cleardoublepage\pagenumbering{arabic}%
    \setcounter{clause}{0}%
    \ifotherdoc \else %
         \protect\thispagestyle{isotitlehead}
     \fi
     \gdef\thetitle{{\Tfont \introelement{#1} %
                             \mainelement{#2} %
                             \compelement{#3}\par}}
      \if@twocolumn
         \twocolumn[\vspace*{2\baselineskip}\vbox to 35mm{\thetitle}]
      \else
          \vspace*{2\baselineskip}\vbox to 35mm{\thetitle}
      \fi}
\newenvironment{cover}{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \setcounter{page}{1} \pagenumbering{roman}
  \thispagestyle{empty}}{%
%%  \clearpage
  \thispagestyle{startpage}
  \mbox{}
  \ifc@pyright\@copyrighttext\fi
  \newpage
  \if@restonecol\twocolumn\fi}

\newcommand*{\toclevel@clause}{1}
\newcommand*{\toclevel@sclause}{2}
\newcommand*{\toclevel@ssclause}{3}
\newcommand*{\toclevel@sssclause}{4}
\newcommand*{\toclevel@ssssclause}{5}
\newcommand*{\toclevel@sssssclause}{6}
\newcommand*{\toclevel@annex}{1}
\newcommand*{\toclevel@index}{1}

\setcounter{secnumdepth}{6}
\newcounter{annex}
\newcounter{clause}
\newcounter{fibicl@use}
\newcounter{sclause}[clause]
\newcounter{ssclause}[sclause]
\newcounter{sssclause}[ssclause]
\newcounter{ssssclause}[sssclause]
\newcounter{sssssclause}[ssssclause]
\newcounter{yextra}

\renewcommand{\theannex}{\Alph{annex}}
\renewcommand{\theclause}{\arabic{clause}}
\renewcommand{\thefibicl@use}{\arabic{fibicl@use}}
\renewcommand{\thesclause}{\theclause.\arabic{sclause}}
\renewcommand{\thessclause}{\thesclause.\arabic{ssclause}}
\renewcommand{\thesssclause}{\thessclause.\arabic{sssclause}}
\renewcommand{\thessssclause}{\thesssclause.\arabic{ssssclause}}
\renewcommand{\thesssssclause}{\thessssclause.\arabic{sssssclause}}

\newcommand{\theHannex}{\Alph{annex}}
\newcommand{\theHclause}{\arabic{clause}}
\newcommand{\theHsclause}{\theHclause.\arabic{sclause}}
\newcommand{\theHssclause}{\theHsclause.\arabic{ssclause}}
\newcommand{\theHsssclause}{\theHssclause.\arabic{sssclause}}
\newcommand{\theHssssclause}{\theHsssclause.\arabic{ssssclause}}
\newcommand{\theHsssssclause}{\theHssssclause.\arabic{sssssclause}}

\newcommand{\zerocounters}{%
  \setcounter{note}{0}\setcounter{example}{0}}
\renewcommand{\@hangfrom}[1]{#1}

\newcommand{\clause}{\zerocounters
  \addtocounter{clause}{1}
  \typeout{Clause: \theclause}
  \addtocounter{clause}{-1}
  \tocskip{\tocentryskip}
  \@startsection{clause}{1}%
    {\z@}%
    {\beforecskip}%
    {\aftercskip}%
%%    {\raggedright\Cfont\bfseries}}
    {\raggedright\Cfont}}
\newcommand{\fibicl@use}{%
  \@startsection{fibicl@use}{1}%
    {\z@}%
    {\beforecskip}%
    {\aftercskip}%
%%    {\raggedright\Cfont\bfseries}}
    {\raggedright\Cfont}}
\newcommand{\sclause}{\zerocounters
    \@startsection{sclause}{2}%
        {\z@}%
        {\beforescskip}%
        {\afterscskip}%
        {\raggedright\SCfont}}
\newcommand{\ssclause}{\zerocounters
    \@startsection{ssclause}{3}%
        {\z@}%
        {\beforesscskip}%
        {\aftersscskip}%
        {\raggedright\SSCfont}}
\newcommand{\sssclause}{\zerocounters
    \@startsection{sssclause}{4}%
        {\z@}%
        {\beforesscskip}%
        {\aftersscskip}%
        {\raggedright\SSCfont}}
\newcommand{\ssssclause}{\zerocounters
    \@startsection{ssssclause}{5}%
        {\z@}%
        {\beforesscskip}%
        {\aftersscskip}%
        {\raggedright\SSCfont}}
\newcommand{\sssssclause}{\zerocounters
    \@startsection{sssssclause}{6}%
        {\z@}%
        {\beforesscskip}%
        {\aftersscskip}%
        {\raggedright\SSCfont}}
\def\clausemark#1{}
\def\sclausemark#1{}
\def\ssclausemark#1{}
\def\sssclausemark#1{}
\def\ssssclausemark#1{}
\def\sssssclausemark#1{}
\newcommand{\init@nnex}{%
    \clearpage
    \setcounter{table}{0}
    \setcounter{figure}{0}
    \setcounter{sclause}{0}
    \zerocounters
    \refstepcounter{annex}
    \ifnum 9=\value{annex} \refstepcounter{annex}\fi
    \ifnum 15=\value{annex} \refstepcounter{annex}\fi
%%%    \ifnum 1=\value{annex}
       \renewcommand{\clause}{%
         \ClassWarning{iso}{%
           \protect\clause\space commands are not allowed after starting Annexes}{%
           Type \space <return> to proceed and I'll ignore your \protect\clause.}}
       \renewcommand{\thesclause}{\theannex.\arabic{sclause}}
       \renewcommand{\thetable}{\theannex.\arabic{table}}
       \renewcommand{\thefigure}{\theannex.\arabic{figure}}
       \renewcommand{\theHsclause}{\theHannex.\arabic{sclause}}
       \ifisohyper
         \renewcommand{\theHtable}{\theHannex.\arabic{table}}
         \renewcommand{\theHfigure}{\theHannex.\arabic{figure}}
       \fi
%%%     \fi
     \global\@topnum\z@
     \@afterindentfalse
}
\newcommand{\makepreannexhead}[1]{%
  \begin{center}
  {{\Cfont \annexname~\theannex}\\\Large #1}
  \end{center}
}
\newcommand{\makeannexhead}[1]{%
  \centerline{\Cfont #1}
  \vskip 0.5\baselineskip
}
\newcommand{\addannextotoc}[2]{%
  \tocskip{\tocentryskip}
  \addcontentsline{toc}{annex}{\ifnum2>\c@secnumdepth \else
    \protect\numberline{\annexname~\theannex\space #1}\fi #2}%
}
\newcommand{\@infannex}[1]{%
  \makepreannexhead{(\informativename)}
  \makeannexhead{#1}
  \addannextotoc{(\informativename)}{#1}
}
\newcommand{\infannex}[1]{%
  \init@nnex
  \@infannex{#1}
  \typeout{Informative annex: #1}
}
\newcommand{\@normannex}[1]{%
  \makepreannexhead{(\normativename)}
  \makeannexhead{#1}
  \addannextotoc{(\normativename)}{#1}
}
\newcommand{\normannex}[1]{%
  \init@nnex
  \@normannex{#1}
  \typeout{Normative annex: #1}
}
\newcommand{\@repannex}[1]{%
  \makepreannexhead{}
  \makeannexhead{#1}
  \addannextotoc{}{#1}
}
\newcommand{\repannex}[1]{%
  \init@nnex
  \@repannex{#1}
  \typeout{Annex: #1}
}
\setlength{\leftmargini}{2em}
\leftmargin \leftmargini
\setlength{\leftmarginii}{\leftmargini}
\setlength{\leftmarginiii}{\leftmargini}
\setlength{\leftmarginiv}{\leftmargini}
\setlength{\leftmarginv}{\leftmargini}
\setlength{\leftmarginvi}{\leftmargini}
\setlength{\itemindent}{\z@}
\setlength{\labelsep}{0.5em}
\setlength{\labelwidth}{\leftmargini}
  \addtolength{\labelwidth}{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand{\theenumi}{\alph{enumi}}
\renewcommand{\theenumii}{\arabic{enumii}}
\renewcommand{\theenumiii}{\roman{enumiii}}
\renewcommand{\theenumiv}{\Roman{enumiv}}
\newcommand{\labelenumi}{\theenumi)}
\newcommand{\labelenumii}{\theenumii)}
\newcommand{\labelenumiii}{\theenumiii)}
\newcommand{\labelenumiv}{\theenumiv)}
\renewcommand{\p@enumii}{\theenumi}
\renewcommand{\p@enumiii}{\p@enumii\theenumii}
\renewcommand{\p@enumiv}{\p@enumiii\theenumiii}
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%

      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{##1\hfill}}%
  \fi}
\let\endenumerate =\endlist
\newcommand{\labelitemi}{{\normalfont\bfseries \textemdash}\hfill}
%%\newcommand{\labelitemii}{\textbullet\hfill}
%%\newcommand{\labelitemiii}{\textasteriskcentered}
%%\newcommand{\labelitemiv}{\textperiodcentered}
\newcommand{\labelitemii}{\labelitemi}
\newcommand{\labelitemiii}{\labelitemi}
\newcommand{\labelitemiv}{\labelitemi}
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%

    \expandafter
    \list
      \csname\@itemitem\endcsname
       {\def\makelabel##1{##1\hfill}}%
  \fi}
\let\enditemize =\endlist
\newenvironment{description}%
               {\list{}{\labelwidth\z@ \itemindent 0.5em \labelsep 0.5em
                        \let\makelabel\descriptionlabel}}%
               {\endlist}
\newcommand*{\descriptionlabel}[1]{\normalfont\bfseries #1:\hfill}
\newenvironment{quotation}%
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}%
               {\endlist}
\newenvironment{quote}%
               {\list{}{\rightmargin\leftmargin}%
                \item[]}%
               {\endlist}
\newif\ifinfloat\infloatfalse
\newcounter{note}[clause]
\renewcommand{\thenote}{\arabic{note}}
\newcounter{floatnote}
\renewcommand{\thefloatnote}{\arabic{floatnote}}
\newcommand{\theHnote}{\thenote.\arabic{yextra}}
\newcommand{\theHfloatnote}{\thefloatnote.\arabic{yextra}}

\newcommand{\notelabel}[1]{{#1\hfill}}
\newcommand{\@setnoteparams}{%
  \setlength{\partopsep}{\z@}
  \setlength{\topsep}{\z@}
  \setlength{\labelsep}{1em}
  \setlength{\itemindent}{\labelsep}
  \setlength{\labelwidth}{\z@}
  \setlength{\listparindent}{\z@}
  \setlength{\leftmargin}{\z@}     % added in v2.3
}
\newenvironment{anote}{\list{}{%
%%  \ifinfloat \setlength{\leftmargin}{\z@} \else
%%             \setlength{\leftmargin}{2em} \fi
  \@setnoteparams}
  \Nfont\item[\notename]}%
{\endlist}
\newenvironment{note}{\list{}{%
  \stepcounter{yextra}
  \ifinfloat
    \refstepcounter{floatnote}
    \let\thenote\thefloatnote
  \else
    \refstepcounter{note}
  \fi
%%  \ifinfloat \setlength{\leftmargin}{\z@} \else
%%             \setlength{\leftmargin}{2em} \fi
  \@setnoteparams}
  \Nfont\item[\notename~\thenote]}%
  {\endlist}
\newcounter{example}[clause]
\renewcommand{\theexample}{\arabic{example}}
\newcommand{\theHexample}{theexample.\arabic{yextra}}
\newenvironment{anexample}{\list{}{%
%%  \ifinfloat \setlength{\leftmargin}{\z@} \else
%%             \setlength{\leftmargin}{2em} \fi
  \@setnoteparams}
  \Nfont\item[\examplename]}{\endlist}
\newenvironment{example}{\list{}{%
  \stepcounter{yextra}
  \refstepcounter{example}
%%  \ifinfloat \setlength{\leftmargin}{\z@} \else
%%             \setlength{\leftmargin}{2em} \fi
  \@setnoteparams}
  \Nfont\item[\examplename~\theexample]}%
  {\endlist}
\newcommand{\nreferencelabel}[1]{#1,\hfill}
\newenvironment{nreferences}{\list{}%
    {\leftmargin 0pt \itemindent 0.5em
     \labelwidth\z@ \labelsep 0.5em
     \let\makelabel\nreferencelabel}}%
    {\endlist}
\newcommand{\isref}[2]{\item[#1]{\itshape #2}}
\newif\ifd@is\d@isfalse
\newcommand{\disref}[2]{\begingroup
    \ifd@is
         {\item[#1\protect\@footnotemark]{\itshape #2}}
    \else
         \addtocounter{footnote}{1}
         \xdef\@thefnmark{\thefootnote}
         \item[#1\protect\@footnotemark]{\itshape #2}%
         \footnotetext[\value{footnote}]{\tbpname}
         \d@istrue
    \fi
    \endgroup\d@istrue}
\newcounter{infrefctr}
\renewcommand{\p@infrefctr}{}
\renewcommand{\theinfrefctr}{\arabic{infrefctr}}
\newcommand{\labelinfref}{[\arabic{infrefctr}]}
\newenvironment{references}{\list{\labelinfref}{\usecounter{infrefctr}
     \leftmargin 0pt \itemindent 0.5em
     \labelwidth\z@ \labelsep 0.5em}}%
    {\endlist}
\newcommand{\reference}[3]{\item {#1} {{\itshape #2}} {#3}}
\newenvironment{olddefinitions}%
    {\begin{itemize}}%
    {\end{itemize}}
\newcommand{\olddefinition}[2]{\item #1 #2}
\newcounter{cl@level}
\newcommand{\@defcl}[1]{}
\newenvironment{definitions}{%
  \setcounter{cl@level}{6}
  \ifnum\value{sssssclause}=0 \setcounter{cl@level}{5} \fi
  \ifnum\value{ssssclause}=0 \setcounter{cl@level}{4} \fi
  \ifnum\value{sssclause}=0 \setcounter{cl@level}{3} \fi
  \ifnum\value{ssclause}=0 \setcounter{cl@level}{2} \fi
  \ifnum\value{sclause}=0 \setcounter{cl@level}{1} \fi
  \ifnum\value{clause}=0 \setcounter{cl@level}{0} \fi
  \ifcase\value{cl@level} % 0, NOT YET IN A CLAUSE
    \ClassWarning{iso}{Definitions started before the initial clause}
    \renewcommand{\@defcl}[1]{\setcounter{note}{0}\setcounter{example}{0}
      \par
      \addvspace{\beforecskip}
      \@afterindentfalse
      \refstepcounter{clause}
      {\raggedright\bfseries \theclause\\ ##1\\}}
  \or % 1, called in a clause
    \renewcommand{\@defcl}[1]{\setcounter{note}{0}\setcounter{example}{0}
      \par
      \addvspace{\beforescskip}
      \@afterindentfalse
      \refstepcounter{sclause}
      {\raggedright\bfseries \thesclause\\ ##1\\}}
  \or % 2, called in an sclause
    \renewcommand{\@defcl}[1]{\setcounter{note}{0}\setcounter{example}{0}
      \par
      \addvspace{\beforesscskip}
      \@afterindentfalse
      \refstepcounter{ssclause}
      {\raggedright\bfseries \thessclause\\ ##1\\}}
  \or % 3, called in an ssclause
    \renewcommand{\@defcl}[1]{\setcounter{note}{0}\setcounter{example}{0}
      \par
      \addvspace{\beforesscskip}
      \@afterindentfalse
      \refstepcounter{sssclause}
      {\raggedright\bfseries \thesssclause\\ ##1\\}}
  \or % 4, called in an sssclause
    \renewcommand{\@defcl}[1]{\setcounter{note}{0}\setcounter{example}{0}
      \par
      \addvspace{\beforesscskip}
      \@afterindentfalse
      \refstepcounter{ssssclause}
      {\raggedright\bfseries \thessssclause\\ ##1\\}}
  \or % 5, called in an ssssclause
    \renewcommand{\@defcl}[1]{\setcounter{note}{0}\setcounter{example}{0}
      \par
      \addvspace{\beforesscskip}
      \@afterindentfalse
      \refstepcounter{sssssclause}
      {\raggedright\bfseries \thesssssclause\\ ##1\\}}
  \else % 5+, called in an sssssclause or lower
    \ClassWarning{iso}{Definitions too deeply nested}
    \renewcommand{\@defcl}[1]{
      \par
      \addvspace{\beforesscskip}
      \@afterindentfalse
      \refstepcounter{sssssclause}
      {\raggedright\bfseries \thesssssclause\\ ##1\\}}
  \fi}%
  {}
\newcommand{\definition}[2]{\@defcl{#1} #2}
\newcommand{\symbollabel}[1]{{#1 \hfill}}
\newenvironment{symbols}{\list{}%
    {\itemindent 0em \leftmargin 8em
     \labelsep 1em \labelwidth 5em
     \let\makelabel\symbollabel}}%
    {\endlist}
\newcommand{\symboldef}[2]{\item[#1] #2}
\newenvironment{inscope}[1]{%
  \inscopename #1:
  \begin{itemize}}%
  {\end{itemize}}
\newenvironment{outofscope}[1]{%
  \outofscopename #1:
  \begin{itemize}}%
  {\end{itemize}}
\setlength\arraycolsep{4\p@}
\setlength\tabcolsep{4\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}

\renewcommand{\theequation}{\arabic{equation}}
\newcounter{figure}
\renewcommand{\thefigure}{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newif\iffigs\figsfalse
\newcommand{\@initisofig}{%
  \iffigs\else\figstrue
    \if@filesw \immediate\write\@mainaux{%
      \string\gdef\string\setfigs{%
         \string\floatlist{\listfigurename}{lof}}}
    \fi
  \fi
  \infloattrue\setcounter{floatnote}{0}
}
\newenvironment{figure}{%
  \@initisofig
  \@float{figure}}%
  {\end@float\infloatfalse}
\newenvironment{figure*}{%
  \@initisofig
  \@dblfloat{figure}}%
 {\end@dblfloat\infloatfalse}
\newcounter{table}
\renewcommand{\thetable}{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newif\iftabs\tabsfalse
\newcommand{\@initisotab}{%
  \iftabs\else\tabstrue
    \if@filesw \immediate\write\@mainaux{%
      \string\gdef\string\settabs{%
        \string\floatlist{\listtablename}{lot}}}
    \fi
  \fi
  \infloattrue\setcounter{floatnote}{0}
}
\newenvironment{table}{%
  \@initisotab
  \@float{table}}%
 {\end@float\infloatfalse}
\newenvironment{table*}{%
  \@initisotab
  \@dblfloat{table}}%
 {\end@dblfloat\infloatfalse}
\newcounter{bottomfloat}
\renewcommand{\thebottomfloat}{\@arabic\c@bottomfloat}
\def\fps@bottomfloat{b}
\def\ftype@bottomfloat{4}
\def\ext@bottomfloat{lbf}
\def\fnum@bottomfloat{\thebottomfloat}
\newenvironment{bottomfloat}%
                {\@float{bottomfloat}}%
                {\end@float}
\newenvironment{bottomfloat*}%
               {\@dblfloat{bottomfloat}}%
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{10\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{{\captionsize\bfseries #1 -- #2}}%
  \ifdim \wd\@tempboxa >\hsize
    {\centering {\captionsize\bfseries #1 -- #2}\par}
  \else
    \global \@minipagefalse
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\newcommand{\contcaption}{\@contcaption\@captype}
\long\def\@contcaption#1#2{%
    \begingroup
        \@parboxrestore
        \normalsize
        \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #2}\par
    \endgroup}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*{\cal}{\@fontswitch{\relax}{\mathcal}}
\DeclareRobustCommand*{\mit}{\@fontswitch{\relax}{\mathnormal}}
%%\newcommand{\isourl}[1]{\texttt{<}\underline{\url{#1}}\texttt{>}}
\newcommand{\isourl}[1]{\texttt{<}\url{#1}\texttt{>}}
\newcommand{\aref}[1]{\annexrefname~\ref{#1}}
\newcommand{\bref}[1]{[\ref{#1}]}
\newcommand{\cref}[1]{\clauserefname~\ref{#1}}
\newcommand{\eref}[1]{\examplerefname~\ref{#1}}
\newcommand{\fref}[1]{\figurerefname~\ref{#1}}
\newcommand{\nref}[1]{\noterefname~\ref{#1}}
\newcommand{\tref}[1]{\tablerefname~\ref{#1}}
\newcommand{\pref}[1]{\pagerefname~\pageref{#1}}
\newcommand{\@pnumwidth}{1.55em}
\newcommand{\@tocrmarg} {2.55em}
\newcommand{\@dotsep}{4.5}
\newlength{\tocentryskip} \setlength{\tocentryskip}{1em}
\newlength{\tocbaseline} \setlength{\tocbaseline}{20pt}
\newcommand{\tocskip}[1]{%
    \addtocontents{toc}{\protect\vspace{#1}}}
\newcommand{\tableofcontents}{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
%%%    \setcounter{page}{2}
%%%    \thispagestyle{startpage}
%%%    \mbox{}
%%%    \ifc@pyright\@copyrighttext\fi
%%%    \cleardoublepage
    \setcounter{page}{3}
    \pagestyle{headings}
    \hbox to \textwidth{{\Cfont \contentsname}\hfil\pagename}
    \ifisohyper
      \pdfbookmark[1]{\contentsname}{isotoc}%
    \fi
    \begingroup
        \parskip\z@
        \@starttoc{toc}
    \endgroup
    \if@restonecol\twocolumn\fi}
\newcommand{\l@clause}{\@dottedtocline{1}{0em}{2.3em}}
\newcommand{\l@sclause}{\@dottedtocline{2}{1.5em}{3.2em}}
\newcommand{\l@ssclause}{\@dottedtocline{3}{3em}{4.1em}}
\newcommand{\l@sssclause}{\@dottedtocline{4}{4.5em}{5em}}
\newcommand{\l@ssssclause}{\@dottedtocline{5}{6em}{5.9em}}
\newcommand{\l@sssssclause}{\@dottedtocline{6}{7.5em}{6.8em}}
\newcommand{\l@annex}{\@dottedtocline{1}{0em}{11.0em}}
\newcommand{\floatlist}[2]{%
    \vspace{2\tocentryskip}
    \hbox to \textwidth{\bfseries #1\hfil}
    \vspace*{\tocentryskip}
    \nopagebreak
    \begingroup
        \parskip\z@
        \@starttoc{#2}
    \endgroup}
\newif\iffigs\figsfalse
\newcommand{\listoffigures}{%
    \ifx\undefined\setfigs\else\setfigs\fi}
\newcommand{\loftnumberline}[1]{#1 --- }

\newcommand{\l@figure}{\@dottedtocline{1}{0em}{7.5em}}
\renewcommand{\l@figure}[2]{%
  \vskip \z@ \@plus.2\p@
  {%
   \leftskip 0em
   \rightskip \@tocrmarg
   \parfillskip -\rightskip
   \parindent 0em\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode
   \@tempdima 3.15em
   \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
   {\let\numberline\loftnumberline \normalfont\figurename{} #1}\nobreak
   \loftfillnum{#2}}
}

\newcommand{\loftfillnum}[1]{\normalfont%
  {\leaders\hbox{$\m@th\mkern 4.5mu\hbox{.}\mkern 4.5mu$}\hfill}\nobreak
  \hb@xt@\@pnumwidth{\hfil #1}\par}

\newif\iftabs\tabsfalse
\newcommand{\listoftables}{%
    \ifx\undefined\settabs\else\settabs\fi}
\newcommand{\l@table}{\@dottedtocline{1}{0em}{6.5em}}

\renewcommand{\l@table}[2]{%
  \vskip \z@ \@plus.2\p@
  {%
   \leftskip 0em
   \rightskip \@tocrmarg
   \parfillskip -\rightskip
   \parindent 0em\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode
   \@tempdima 2.75em
   \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
   {\let\numberline\loftnumberline \normalfont\tablename{} #1}\nobreak
   \loftfillnum{#2}}
}

\long\def\@isocaption#1[#2]#3{%
  \par
  \addcontentsline{\csname ext@#1\endcsname}{#1}%
    {\protect\numberline{{\@nameuse{#1name}} {\@nameuse{the#1}} --- }%
    {\ignorespaces #2}}%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\newif\if@knownclause
\newcommand{\@setclcnt}[2]{
  \@knownclausefalse
  \if\isostringsequal{#1}{none}
    \setcounter{#2}{-10}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{clause}
    \setcounter{#2}{1}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{sclause}
    \setcounter{#2}{2}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{ssclause}
    \setcounter{#2}{3}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{sssclause}
    \setcounter{#2}{4}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{ssssclause}
    \setcounter{#2}{5}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{sssssclause}
    \setcounter{#2}{6}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{all}
    \setcounter{#2}{50}
    \@knownclausetrue
  \fi
  \if@knownclause\else
    \ClassError{isov2}{%
      Unknown clause command name (#1)
    }{%
      I'll ignore it. Type \space <return> and I'll continue.\MessageBreak
      If you haven't mistyped the name then use \protect\setcounter\space instead.}
  \fi
}
\newcommand{\settocdepth}[1]{%
  \@knownclausefalse
  \if\isostringsequal{#1}{none}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{-10}}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{clause}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{1}}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{sclause}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{2}}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{ssclause}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{3}}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{sssclause}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{4}}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{ssssclause}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{5}}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{sssssclause}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{6}}
    \@knownclausetrue
  \fi
  \if\isostringsequal{#1}{all}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{50}}
    \@knownclausetrue
  \fi
  \if@knownclause\else
    \ClassError{isov2}{%
      Unknown clause command name (#1)
    }{%
      I'll ignore it. Type \space <return> and I'll continue.}
  \fi
}
\newcommand{\maxtocdepth}[1]{%
  \@setclcnt{#1}{tocdepth}
}
\newcommand{\setsecnumdepth}[1]{\leavevmode%
  \@setclcnt{#1}{secnumdepth}
}
\newcommand{\maxsecnumdepth}[1]{%
  \@setclcnt{#1}{secnumdepth}
}
\newenvironment{theindex}%
  {\clearpage
   \typeout{Index}%
   \refstepcounter{clause}%
   \tocskip{\tocentryskip}%
   \addcontentsline{toc}{index}{\indexname}%
   \columnseprule \z@
   \onecolumn{\fibicl@use*{\indexname}}
   \parindent\z@
   \parskip\z@ \@plus .3\p@\relax
   \let\item\@idxitem}%
  {\clearpage}
\newcommand{\l@index}{\@dottedtocline{1}{0em}{0pt}}
\newcommand{\@idxitem}  {\par\hangindent 40\p@}
\newcommand{\subitem}   {\par\hangindent 40\p@ \hspace*{20\p@}}
\newcommand{\subsubitem}{\par\hangindent 40\p@ \hspace*{30\p@}}
\newcommand{\indexspace}{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\newcommand{\indexfill}{\dotfill}
\newcommand{\sindexfill}{\dotfill}
\newcommand{\ssindexfill}{\dotfill}
\newcommand{\indexsee}[1]{\par \hspace*{2em} \emph{see} #1}
\newcommand{\indexseealso}[1]{\par \hspace*{2em} \emph{see also} #1}
\newcommand{\alphaindexspace}[1]{}
\newcommand{\otherindexspace}[1]{}
\renewcommand{\footnoterule}{%
  \kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}
\renewcommand{\thefootnote}{\arabic{footnote})}
\long\def\@makefntext#1{%
    \parindent 1em%
    \noindent
    \hbox to 1.8em{\hss\@makefnmark}#1}
\newif\ifchangemarks\changemarksfalse
\newcommand{\v@rid}[2]{%
    \ifchangemarks
       \ifdr@ftd@c
           \marginpar[#1]{#2}%
    \fi\fi}
\newcommand{\editorial}[1]{%
  \@bsphack
    \ifchangemarks
        \v@rid{\small\hfill$^{#1}$ED}%
        {\small ED$^{#1}$\hfill}%
    \fi\@esphack}
\long\def\added#1#2{%
  \@bsphack
    \ifchangemarks
        \v@rid{\small\hfill$^{#2}\Rightarrow$}%
        {\small $\Leftarrow^{#2}$\hfill}%
        \emph{#1}%
    \else
       #1
    \fi\@esphack}
\newcommand{\deleted}[1]{%
  \@bsphack
    \ifchangemarks
        \v@rid{\small\hfill$^{#1}\Leftarrow$}%
        {\small $\Rightarrow^{#1}$\hfill}%
    \fi\@esphack}
\long\def\moved#1#2{%
  \@bsphack
    \ifchangemarks
        \v@rid{\small\hfill$^{#2}\Leftrightarrow$}%
        {\small $\Leftrightarrow^{#2}$\hfill}%
        \emph{#1}%
    \else
       #1
    \fi\@esphack}
\newenvironment{foreword}%
  {\tableofcontents
   \listoffigures
   \listoftables
   \clearpage
   \if@twocolumn
     \@restonecoltrue\onecolumn
   \else
     \@restonecolfalse
   \fi
   \fibicl@use*{\forewordname}%
%%    \tocskip{\tocentryskip}%
%%    \addcontentsline{toc}{clause}{\forewordname}%
   \ifisohyper
     \pdfbookmark[1]{\forewordname}{isofwd}%
   \fi}%
  {\if@restonecol\twocolumn\fi}
\newcommand{\@copyrighttext}{%
  \vfill
%%%    \begin{bottomfloat}[b]
        \begin{small}
        \copyrightnotice
        \end{small}
%%%    \end{bottomfloat}
}
\newenvironment{introduction}%
  {\clearpage
   \if@twocolumn
     \@restonecoltrue\onecolumn
   \else
     \@restonecolfalse
   \fi
   \fibicl@use*{\introductionname}%
%%    \tocskip{\tocentryskip}
%%    \addcontentsline{toc}{clause}{\introductionname}%
   \ifisohyper
     \pdfbookmark[1]{\introductionname}{isointro}
   \fi}%
  {\if@restonecol\twocolumn\fi}
\newcommand{\scopeclause}{\clause{\scopename}\label{;i1}}
\newcommand{\normrefsclause}{\clause{\normrefsname}\label{;i2}}
\newcommand{\defclause}{\clause{\defname}\label{;i3}}
\newcommand{\symclause}{\clause{\symname}\label{;i3}}
\newcommand{\abbclause}{\clause{\abbname}\label{;i3}}
\newcommand{\defsymclause}{\clause{\defsymname}\label{;i3}}
\newcommand{\defabbclause}{\clause{\defabbname}\label{;i3}}
\newcommand{\symabbclause}{\clause{\symabbname}\label{;i3}}
\newcommand{\defsymabbclause}{\clause{\defsymabbname}\label{;i3}}
\newcommand{\defsubclause}{\sclause{\defname}}
\newcommand{\symsubclause}{\sclause{\symname}}
\newcommand{\abbsubclause}{\sclause{\abbname}}
\newcommand{\defsymsubclause}{\sclause{\defsymname}}
\newcommand{\defabbsubclause}{\sclause{\defabbname}}
\newcommand{\symabbsubclause}{\sclause{\symabbname}}
\newcommand{\fcandaclause}{\clause{\fcandaname}}
\newcommand{\bibannex}{%
  \typeout{Bibliography}
  \clearpage
  \fibicl@use*{\bibname}
  \tocskip{\tocentryskip}
  \addcontentsline{toc}{index}{\bibname}
}
\newcommand{\copyrightnotice}{%
\copyright\quad \copyrightname\quad \thesyear\newline
All rights reserved. Unless otherwise specified, no part of
this publication may be reproduced or utilized in any form or
by any means, electronic or mechanical, including photocopying
and microfilm, without permission in writing from %%% the publisher.
%%%\makebox[\textwidth][r]{%
%%%ISO/IEC Copyright Office $\bullet$ Case Postale 56 $\bullet$
%%%CH-1211 Gen{\`e}ve 20 $\bullet$ Switzerland}
%%\vspace{\baselineskip}\newline
%%\hspace*{1em} International Organization for Standardization\newline
%%\hspace*{1em} Case Postale 56 $\bullet$ CH-2111 Gen{\`e}ve 20 $\bullet$ Switzerland
either ISO at the address below or ISO's member body in the country
of the requester.
\par
\noindent ISO copyright office \\
Case postale 56. CH-1211 Geneva 20 \\
Tel. +41 22 749 01 11 \\
Fax  +41 22 734 10 79 \\
E-mail \texttt{copyright@iso.ch} \\
Web \texttt{www.iso.ch}
%%\ifisst@ndard \ifc@pyright
%%    \vspace{\baselineskip}\newline\noindent
%%    Printed in Switzerland
%%\fi\fi
%%\ift@chrep \ifc@pyright
%%    \vspace{\baselineskip}\newline\noindent
%%    Printed in Switzerland
%%\fi\fi
}
\newcommand{\fwdbp}{\input{isofwdbp}}
\newcommand{\tspasfwdbp}{\input{tspasfwdbp}}
\newcommand{\trfwdbpi}{\input{trfwd1}}
\newcommand{\trfwdbpii}[1]{%
  \ClassError{iso}{The \protect\trfwdpbii\space command has been removed}%
     {Type <return> to proceed, and change your source file before
      running LaTeX again.}
}
\newcommand{\intropatents}{\par
  Attention is drawn to the possibility that some of the elements of this
document may be the subject of patent rights
other than those mentioned above.
ISO [and/or] IEC shall not be held responsible
for identifying any or all such patent rights.\par}

\newcommand{\fwdnopatents}{\par
  Attention is drawn to the possibility that some of the elements of this
document may be the subject of patent rights.
ISO shall not be held responsible
for identifying any or all such patent rights.\par}

\newcommand{\normrefbp}[1]{%

The following normative documents contain provisions which, through
reference in this text, constitute provisions of this #1.
For dated references, subsequent amendments to, or revisions of,
any of these publications do not apply.
However, parties
to agreements based on this #1
are encouraged to investigate the possibility of applying
the most recent editions of the normative documents indicated below.
For undated references, the latest edition of the normative
document referred to applies.
Members of ISO and IEC maintain registers of currently
valid International Standards.

}
\newcommand{\abbname}{Abbreviations}
\newcommand{\annexname}{Annex}
\newcommand{\bibname}{Bibliography}
\newcommand{\contentsname}{Contents}
\newcommand{\defname}{Terms and definitions}
\newcommand{\defabbname}{Terms, definitions, and abbreviations}
\newcommand{\defsymname}{Terms, definitions, and symbols}
\newcommand{\defsymabbname}{Terms, definitions, abbreviations, and symbols}
\newcommand{\fcandaname}{Fundamental concepts and assumptions}
\newcommand{\forewordname}{Foreword}
\newcommand{\indexname}{Index}
\newcommand{\informativename}{informative}
\newcommand{\introductionname}{Introduction}
\newcommand{\normativename}{normative}
\newcommand{\normrefsname}{Normative references}
\newcommand{\scopename}{Scope}
\newcommand{\sectionname}{Section}
\newcommand{\symname}{Symbols}
\newcommand{\symabbname}{Symbols and abbreviations}
\newcommand{\copyrightname}{ISO}
\newcommand{\examplename}{EXAMPLE}
 %%%\newcommand{\examplesname}{EXAMPLES}
\newcommand{\figurename}{Figure}
\newcommand{\inscopename}{The following are within the scope of this }
\newcommand{\ISname}{INTERNATIONAL STANDARD}
\iffdisstandard\renewcommand{\ISname}{FINAL DRAFT INTERNATIONAL STANDARD}\fi
\ifdisstandard\renewcommand{\ISname}{DRAFT INTERNATIONAL STANDARD}\fi
\ifcdstandard\renewcommand{\ISname}{COMMITTEE DRAFT}\fi
\ifwdstandard\renewcommand{\ISname}{WORKING DRAFT}\fi
\iftechrep\renewcommand{\ISname}{TECHNICAL REPORT}\fi
\iftechspec\renewcommand{\ISname}{TECHNICAL SPECIFICATION}\fi
\ifpaspec\renewcommand{\ISname}{PUBLICLY AVAILABLE SPECIFICATION}\fi
\ifotherdoc\renewcommand{\ISname}{}\fi
\newcommand{\listannexname}{Annexes}
\newcommand{\listfigurename}{Figures}
\newcommand{\listtablename}{Tables}
\newcommand{\notename}{NOTE}
 %%%\newcommand{\notesname}{NOTES}
\newcommand{\outofscopename}{The following are outside the scope of this }
\newcommand{\pagename}{Page}
\newcommand{\tablename}{Table}
\newcommand{\tbpname}{To be published.}
\newcommand{\annexrefname}{annex}
\newcommand{\clauserefname}{clause}
\newcommand{\examplerefname}{example}
\newcommand{\figurerefname}{Figure}
\newcommand{\noterefname}{note}
\newcommand{\tablerefname}{Table}
\newcommand{\pagerefname}{page}
\newcommand{\abstractname}{}
\newcommand{\appendixname}{}
\newcommand{\chaptername}{}
\newcommand{\partname}{}
\newcommand{\refname}{}
\newcommand{\today}{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{headings}
\pagenumbering{roman}
\setcounter{clause}{0}
\setcounter{annex}{0}
\setcounter{tocdepth}{1}
\@twosidetrue
\raggedbottom
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\endinput
%%
%% End of file `isov2.cls'.
