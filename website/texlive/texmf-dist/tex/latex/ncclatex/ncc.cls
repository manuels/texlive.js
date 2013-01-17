\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ncc}
         [2006/01/17 v1.10 NCC-LaTeX document class (NCC)]
%
% \changes{v1.01}{2002/03/24}{This version is uploaded to CTAN}
% \changes{v1.02}{2002/04/03}{Bug in loading book class fixed}
% \changes{v1.03}{2004/04/08}{The processing of 'russian' option is improved}
% \changes{v1.04}{2004/09/23}{Provide index making commands via the makeidx}
% \changes{v1.05}{2004/11/30}{Remove \NCC@null from the titlepage env.}
% \changes{v1.05}{2004/11/30}{Rename \NCC@null to \StartFromTextArea}
% \changes{v1.05}{2004/11/30}{Add the \StartFromHeaderArea command}
% \changes{v1.06}{2004/12/16}{Remove \NCC@gempty command}
% \changes{v1.07}{2005/01/12}{Remove options passed to packages}
% \changes{v1.07}{2005/02/21}{Set tbtags as default option}
% \changes{v1.07}{2005/03/23}{Add optional arg. to \alloweqbreak}
% \changes{v1.07}{2005/03/30}{Fix bug in the \preprint command}
% \changes{v1.07}{2005/05/20}{Move \StartFromTextArea to the nccsect package}
% \changes{v1.07}{2005/05/20}{Move \StartFromHeaderArea to the nccsect package}
% \changes{v1.08}{2005/06/18}{Add titlepage*, \ExpandTextArea, \RestoreTextArea}
% \changes{v1.08}{2005/07/02}{Improve \ExpandTextArea command}
% \changes{v1.09}{2005/12/24}{Move biblist to a separate package}
% \changes{v1.09}{2005/12/24}{Unify toc-headers using topsection package}
% \changes{v1.09}{2005/12/26}{Move titlepage and text area controls to separate packages}
% \changes{v1.09}{2005/12/26}{Loading ncctitle package instead of ncctitle.clo}
% \changes{v1.09}{2005/12/28}{Code revision and minor changes}
% \changes{v1.09}{2005/12/28}{More minor changes}
% \changes{v1.09}{2006/01/05}{The \SetTOCStyle was removed from here}
% \changes{v1.10}{2006/01/17}{addtopackage -> afterpackage}
% 
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@openright
%
% What goes first in title: author or title?
%
\newif\ifNCC@authorbeforetitle
\newcommand{\AuthorBeforeTitle}{\NCC@authorbeforetitletrue}
\newcommand{\TitleBeforeAuthor}{\NCC@authorbeforetitlefalse}
\@onlypreamble\AuthorBeforeTitle
\@onlypreamble\TitleBeforeAuthor
%
% Paper size options
%
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{a5a4paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\DeclareOption{fittopage}{}
%
% Base font size options
%
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{14pt}{\renewcommand\@ptsize{4}%
                     \PassOptionsToPackage{small}{ncclatex}}
%
% Layout options
%
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
%
% Special openbib option
%
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
    \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }
    \renewcommand\newblock{\par}
  }%
}
%
% \setyear{year} command defines \theyear
%
\newcommand*{\setyear}[1]{\gdef\theyear{#1}}
\newcommand\theyear{\number\year}
%
% Subclass selection options
%
\DeclareOption{article}{%
  \def\NCC@clsload{%
    \TitleBeforeAuthor
    \input{nccart.clo}%
    \newcommand*{\setseries}[1]{\gdef\theseries{##1}}%
    \newcommand*{\setvolume}[1]{\gdef\thevolume{##1}}%
    \newcommand*{\setissue}[1]{\gdef\theissue{##1}}%
    \setseries{}\setvolume{}\setissue{}%
    \AtEndDocument{%
      \clearpage
      \if@filesw \advance\c@page\m@ne
        \immediate\write\@mainaux{\string\newlabel
          {NCC@lastpage}{{}{\thepage}}}%
        \advance\c@page\@ne
      \fi
      \openrightorany
    }%
    \pagestyle{myheadings}%
    \countstyle{}%
    \InputIfFileExists{nccadd.sty}{}{}%
  }%
  \let\chapter\relax
  \let\thechapter\relax
}
\DeclareOption{preprint}{%
  \def\NCC@clsload{%
    \AuthorBeforeTitle
    \input{nccart.clo}%
    \RequirePackage{ncctitle}%
    \RequirePackage{afterpackage}
    \newcommand\preprintname{Preprint}
    \AfterPackage{babel}{%
      \addto\captionsrussian{%
        \def\preprintname{%
          {\cyr\CYRP\cyrr\cyre\cyrp\cyrr\cyri\cyrn\cyrt}}%
      }
    }
    \newcommand*{\preprint}[1]{%
      \def\thepreprint{##1}%
      \ifx\thepreprint\@empty
        \titlecomment{}%
      \else
        \titlecomment{\bfseries \preprintname\\[1.5ex]\thepreprint}%
      \fi
    }%
    \preprint{}%
    \pagestyle{headings}%
    \countstyle{}%
  }%
  \let\chapter\relax
  \let\thechapter\relax
}
\DeclareOption{book}{%
  \def\NCC@clsload{%
    \AuthorBeforeTitle
    \input{nccbook.clo}%
    \RequirePackage{ncctitle}%
    \let\bookeditor\titlecomment
    \pagestyle{headings}%
    \countstyle{chapter}%
  }%
  \let\chapter\@empty    % nccsect and russianb packages test an existence of
  \let\thechapter\@empty % \thechapter and \chapter to understand what class
}                        % was loaded
\DeclareOption{report}{\ExecuteOptions{book,oneside}}
%
% We set tbtags as the default tags positioning in split environment
%
\def\NCC@temp{\PassOptionsToPackage{tbtags}{nccmath}}
\DeclareOption{centertags}{\let\NCC@temp\relax}
%
% Process options and load size option file
%
\ExecuteOptions{a4paper,10pt,article,twoside,onecolumn,final,openany}
\ProcessOptions\relax
\NCC@temp \let\NCC@temp\relax
\input{ncc1\@ptsize.clo}
\@ifclasswith{ncc}{fittopage}{\input{nccfit.clo}}{}
%
% Center text on the page taking into account the header only,
% because default NCC-LaTeX style is headings or myheadings and
% marginal notes are useless. The top margin is bounded by 1.5in.
%
\RequirePackage{tocenter}
\ToCenter[h]{\textwidth}{\textheight}
\ifdim\topmargin >.5in \topmargin=.5in \fi
%
% Set list margins
%
\if@twocolumn
  \setlength\leftmargini  {2em}
  \setlength\leftmarginii {1.7em}
  \setlength\leftmarginiii{1.5em}
  \setlength\leftmarginiv {1.2em}
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmargini  {2.5em}
  \setlength\leftmarginii {2.2em}
  \setlength\leftmarginiii{1.87em}
  \setlength\leftmarginiv {1.7em}
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength\labelsep{.5em}
\leftmargin\leftmargini
\def\NCC@labelwidth{\labelwidth\leftmargin\advance\labelwidth-\labelsep}
\NCC@labelwidth
%
% Set enumeration styles
%
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
%
% Set other dimensions, skips, and penalties
%
\if@twocolumn \setlength\parindent{1em}
\else         \setlength\parindent{1.5em}
\fi
\setlength\smallskipamount{3\p@ \@plus \p@ \@minus \p@}
\setlength\medskipamount{6\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\bigskipamount{12\p@ \@plus 4\p@ \@minus 4\p@}
\setlength\maxdepth{.5\topskip}
\setlength\lineskip{\p@}
\setlength\normallineskip{\p@}
\renewcommand\baselinestretch{}
\setlength\columnseprule{0\p@}
\setlength\parskip{\z@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\setcounter{topnumber}{4}
\renewcommand\topfraction{.8}
\setcounter{bottomnumber}{2}
\renewcommand\bottomfraction{.6}
\setcounter{totalnumber}{6}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{4}
\renewcommand\dbltopfraction{.8}
\renewcommand\dblfloatpagefraction{.5}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\def\@dotsep{4.5}
%
% Declare old font selection commands
%
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
%
% Create section counters. We use \countstyle command from dcounter package.
%
\RequirePackage{dcounter}
\newcounter{part}
\renewcommand\thepart{\@Roman\c@part}
\@ifundefined{chapter}{
  \countstyle[section]{}
}{
  \countstyle[chapter]{}
  \countstyle[section]{chapter}
}
\countstyle[subsection]{section}
\countstyle[subsubsection]{subsection}
\countstyle[paragraph]{subsubsection}
\countstyle[subparagraph]{paragraph}
%
% Declare floats
%
\DeclareDynamicCounter{figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newenvironment{figure}{\@float{figure}}{\end@float}
\newenvironment{figure*}{\@dblfloat{figure}}{\end@dblfloat}
\DeclareDynamicCounter{table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}{\@float{table}}{\end@float}
\newenvironment{table*}{\@dblfloat{table}}{\end@dblfloat}
%
% Names of standard english captions
%
\newcommand\prefacename{Preface}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\refname{References}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\glossaryname{Glossary}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
%
% English version of \today
%
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
%
% Prepare commands for making indices
%
\RequirePackage{makeidx}
\newcommand\printglossary{\@input@{\jobname.gls}}
%
% Load remaining packages
%
\RequirePackage{ncclatex}
\RequirePackage{topsection}
\RequirePackage{watermark}
\RequirePackage{ncctitlepage}
\RequirePackage{nccheadings}
\RequirePackage{nccold}
%
% Define the bibliography
%
\newdimen\bibindent
\setlength\bibindent{1.5em}
\let\@openbib@code\@empty
\newcommand\newblock{\hskip .11em\@plus .33em\@minus .07em}
\RequirePackage{nccbiblist}
\def\NCC@biblisthook{\itemsep\parsep}
%
% noeqbreak supresses page breaks before display equations
% alloweqbreak[number] allows page breaks before display equations
% (default is alloweqbreak[4])
%
\newenvironment{noeqbreak}{\predisplaypenalty\@M
  \ignorespaces
}{\ignorespacesafterend}
\newenvironment*{alloweqbreak}[1][4]{%
  \predisplaypenalty 
  \ifcase #1\@highpenalty
    \or \@lowpenalty
    \or \z@
    \or \@beginparpenalty
    \else \@secpenalty
  \fi
  \ignorespaces
}{\ignorespacesafterend}
\alloweqbreak                 % Break before display formulas is allowed
\allowdisplaybreaks           % Breaks in display formulas are allowed
%
% Verse, quotation, quote. The description is already defined in ncclatex
%
\newenvironment{verse}{%
  \let\\\centercr
  \list{}{\itemsep \z@ \itemindent -1.5em \listparindent\itemindent
          \rightmargin \leftmargin \advance\leftmargin 1.5em}%
  \item\relax
}{\endlist}
\newenvironment{quotation}{%
  \list{}{\listparindent 1.5em \itemindent \listparindent
          \rightmargin \leftmargin \parsep \z@ \@plus \p@}%
  \item\relax
}{\endlist}
\newenvironment{quote}{%
  \list{}{\rightmargin\leftmargin}\item\relax
}{\endlist}
%
% Footnote making commands
%
\renewcommand{\footnoterule}{%
  \kern-3\p@ \hrule\@width .4\columnwidth \kern2.6\p@
}
\newcommand{\@makefntext}[1]{%
  \parindent 1em \noindent
  \hb@xt@ 1.8em{\hss\@makefnmark}#1}
%
% \tableofcontents, \listoffigures, \listoftables
%
\newcommand{\tableofcontents}{\NCC@toc\contentsname{toc}}
\newcommand{\listoffigures}{\NCC@toc\listfigurename{lof}}
\newcommand{\listoftables}{\NCC@toc\listtablename{lot}}
\def\NCC@toc#1{\skipwritingtoaux\topsection{#1}\@starttoc}
%
% theindex and theglossary
%
\newenvironment{theindex}{\NCC@index\indexname}{\endNCC@index}
\newenvironment{theglossary}{\NCC@index\glossaryname}{\endNCC@index}
\newenvironment*{NCC@index}[1]{%
  \if@twocolumn \@restonecolfalse \else \@restonecoltrue \fi
  \columnseprule \z@ \columnsep 35\p@
  \@iftopchapter{\twocolumn \topsection{#1}}%
                {\twocolumn[\topsection{#1}]\thispageheading{}}%
  \parindent\z@ \parskip\z@ \@plus .3\p@
  \let\item\@idxitem \small
}{\if@restonecol\onecolumn \else \clearpage\fi}
\newcommand\@idxitem{\par\hangindent 5em}
\newcommand\subitem{\@idxitem \hspace*{2em}}
\newcommand\subsubitem{\@idxitem \hspace*{4em}}
\newcommand\indexspace{\par \addvspace{4ex \@plus 1ex \@minus .5ex}}
%
% Final actions
%
\pagenumbering{arabic}
\NCC@clsload % load specified subclass
\let\NCC@clsload\relax
\if@twocolumn
  \twocolumn \sloppy \flushbottom
\else
  \onecolumn
  \if@twoside \flushbottom \else \raggedbottom \fi
\fi
\endinput
