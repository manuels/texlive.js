%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                 %%
%% Package name: bookest                                           %%
%% Author: Riccardo Bresciani - bresciani(at)sssup.it              %%
%% Web: http://tex.boris-web.net/bookest                           %%
%%                                                                 %%
%% Description: This package provides an extension to the          %%
%%              book class                                         %%
%%                                                                 %%
%% Copyright 2007-2008 Riccardo Bresciani                          %%
%%                                                                 %%
%% This work may be distributed and/or modified under the          %%
%% conditions of the LaTeX Project Public License, either          %%
%% version 1.3c of this license or (at your option) any            %%
%% later version.                                                  %%
%% The latest version of the license is in                         %%
%%    http://www.latex-project.org/lppl.txt                        %%
%% and version 1.3c or later is part of all distributions of LaTeX %%
%% version 2005/12/01 or later.                                    %%
%%                                                                 %%
%% This work has the LPPL maintenance status "author-maintained".  %%
%%                                                                 %%
%% This work consists of the files: README, bookest.cls,           %%
%% bookestdoc-it.tex, bookestdoc-it.pdf, bookestdoc-en.tex,        %%
%% bookestdoc-en.pdf                                               %%
%%                                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bookest}[2008/03/20 v1.1 Extension for the book class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass{book}
\RequirePackage{color}
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{eso-pic}
\RequirePackage{geometry}
\RequirePackage{everyshi}

\makeatletter

%% Filigrana
\newcommand{\shipoutimage}[2]{\EveryShipout{\AddToShipoutPicture*{\AtPageCenter{\makebox(0,0){\includegraphics[#1]{#2}}}}}}

\newcommand{\shipouttext}[3]{\EveryShipout{\AddToShipoutPicture*{\AtPageCenter{\makebox(0,0){\rotatebox{#1}{\scalebox{#2}{{\color[rgb]{.95,.95,.95}\normalfont\normalsize #3}}}}}}}}

%% Rinomina la bibliografia
\newcommand{\setbibname}[1]{\def\bibname{#1}}
\newcommand{\setcontentsname}[1]{\def\contentsname{#1}}

%% Paragrafo
\newcommand{\ppar}{\vspace{1.5ex}}

%% Ambiente dimst - per dimostrazioni
\newcommand{\dimstleftskip}{\setlength{\leftskip}{1cm}}
\newenvironment{dimst}{
	\dimstleftskip
	\ppar
	\slshape
}

%% Ambiente abstract
\newenvironment{abstract}[1]{
\begin{center}
\begin{minipage}{0.8\textwidth}
\textbf{#1}\hspace{3ex}}
{\end{minipage}
\end{center}
\vspace{1ex}
}

%% Colora il righello di footnote
\renewcommand{\footnoterule}{%
  {\colorB\kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}}

%% Layout di pagina
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse}
\fi
\DeclareOption{twoside}{\@twosidetrue}
\DeclareOption{centered}{
  \geometry{
     hmargin=2.5cm,
     vmargin={3cm,3cm},
     bindingoffset=0mm,
     columnsep=20pt
  }
}
\DeclareOption{left5mm}{
  \geometry{
     lmargin=2.5cm,
     rmargin=2cm,
     vmargin={3cm,3cm},
     bindingoffset=5mm,
     columnsep=20pt
  }
}
\DeclareOption{left8mm}{
  \geometry{
     lmargin=2.5cm,
     rmargin=1.7cm,
     vmargin={3cm,3cm},
     bindingoffset=8mm,
     columnsep=20pt
  }
}

%% Colori
\newcommand{\black}{\color{black}}
\newcommand{\colorA}{}
\newcommand{\setcolorA}[1]{\renewcommand{\colorA}{\color[rgb]{#1}}}
\newcommand{\SETcolorA}[1]{\renewcommand{\colorA}{#1}}
\newcommand{\colorB}{}
\newcommand{\setcolorB}[1]{\renewcommand{\colorB}{\color[rgb]{#1}}}
\newcommand{\SETcolorB}[1]{\renewcommand{\colorB}{#1}}
\DeclareOption{blue}{
	\renewcommand{\colorA}{\color[rgb]{0.3,0.5,1}}
	\renewcommand{\colorB}{\color[rgb]{0.2,0.2,0.6}}
	\hypersetup{linkbordercolor={0.3 0.5 1},citebordercolor={0.2 0.2 0.6},urlbordercolor={0.3 0.5 1}}}
\DeclareOption{green}{
	\renewcommand{\colorA}{\color[rgb]{0.2,0.5,0.2}}
	\renewcommand{\colorB}{\color[rgb]{0,0.3,0}}
	\hypersetup{linkbordercolor={0.2 0.5 0.2},citebordercolor={0 0.3 0},urlbordercolor={0.2 0.5 0.2}}}
\DeclareOption{red}{
	\renewcommand{\colorA}{\color[rgb]{1,0.3,0.2}}
	\renewcommand{\colorB}{\color[rgb]{1,0.5,0}}
	\hypersetup{linkbordercolor={1 0.3 0.2},citebordercolor={1 0.5 0},urlbordercolor={1 0.3 0.2}}}
\DeclareOption{sssupcolor1}{
	\renewcommand{\colorB}{\color[rgb]{0.7,0.36,0.19}}
	\renewcommand{\colorA}{\color[rgb]{0.66,0.55,0.51}}
	\hypersetup{linkbordercolor={0.7 0.36 0.19},citebordercolor={0.66 0.55 0.51},urlbordercolor={0.7 0.36 0.19}}}
\DeclareOption{sssupcolor2}{
	\renewcommand{\colorA}{\color[rgb]{0.7,0.36,0.19}}
	\renewcommand{\colorB}{\color[rgb]{0.66,0.55,0.51}}
	\hypersetup{linkbordercolor={0.7 0.36 0.19},citebordercolor={0.66 0.55 0.51},urlbordercolor={0.7 0.36 0.19}}}
\DeclareOption{sssupcolor3}{
	\renewcommand{\colorA}{\black}
	\renewcommand{\colorB}{\color[rgb]{0.7,0.36,0.19}}
	\hypersetup{linkbordercolor={0.7 0.36 0.19},citebordercolor={0.7 0.36 0.19},urlbordercolor={0.7 0.36 0.19}}}
\DeclareOption{guitgreen}{
	\renewcommand{\colorA}{\color[rgb]{0.09,0.56,0.07}}
	\renewcommand{\colorB}{\color[rgb]{0,0.35,0}}
	\hypersetup{linkbordercolor={0.09 0.56 0.07},citebordercolor={0 0.35 0},urlbordercolor={0.09 0.56 0.07}}}
\DeclareOption{enscblue}{
	\renewcommand{\colorA}{\color[rgb]{0,0.52,0.71}}
	\renewcommand{\colorB}{\color[rgb]{0.05,0.16,0.49}}
	\hypersetup{linkbordercolor={0 0.52 0.71},citebordercolor={0.05 0.16 0.49},urlbordercolor={0 0.52 0.71}}}

%% Colora gli item dentro itemize, description
\renewcommand\labelitemi{{\colorA\textbullet}}
\renewcommand\descriptionlabel[1]{\hspace\labelsep
                                {\colorA\normalfont\bfseries #1}}
\renewcommand\labelenumi{{\colorA\theenumi.}}

%% Per chi non vuole le liste colorate
\DeclareOption{noitemcolor}{
	\renewcommand\labelitemi{\textbullet}
	\renewcommand\descriptionlabel[1]{\hspace\labelsep\normalfont\bfseries #1}
	\renewcommand\labelenumi{\theenumi.}
}

% Titling page
\newcommand{\inslogo}[1]{\includegraphics[width=0.6\paperwidth]{#1}}
\newcommand{\setlogooptions}[1]{
  \renewcommand{\inslogo}{\includegraphics[#1]}}
\newcommand{\logo}{logo}
\newcommand{\rightlogo}{\logo}
\newcommand{\leftlogo}{\logo}
\newcommand{\setlogo}[1]{
  \renewcommand{\logo}{#1}}
\newcommand{\setrightlogo}[1]{
  \renewcommand{\rightlogo}{#1}}
\newcommand{\setleftlogo}[1]{
  \renewcommand{\leftlogo}{#1}}
\renewcommand{\maketitle}{
  \begin{center}
    {\large\@author}\par
    \vspace{\stretch{1}}
    {\colorB\Huge\@title}\par
  \end{center}
}
\newcommand{\titlingpagemiddle}{}
\newcommand{\settitlingpagemiddle}[1]{
  \renewcommand{\titlingpagemiddle}{#1}}
\newcommand{\titlingpageprefooter}{}
\newcommand{\settitlingpageprefooter}[1]{
  \renewcommand{\titlingpageprefooter}{#1}}
\newcommand{\titlingpagefooter}{\today}
\newcommand{\settitlingpagefooter}[1]{
  \renewcommand{\titlingpagefooter}{#1}}
\newcommand{\settitlingpagetitle}[1]{
  \renewcommand{\maketitle}{#1}}
\newcommand{\titling}{
  \begin{titlepage}
  \maketitle
  \vspace{\stretch{8}}
  \begin{center}
    \titlingpageprefooter
    {\colorB\rule[.5ex]{50ex}{.4pt}}\\
    \titlingpagefooter
  \end{center}
\end{titlepage}}

%% setspace
\DeclareOption{onehalfspacing}{\onehalfspacing}
\DeclareOption{doublespacing}{\doublespacing}

%%% Opzioni per i paragrafi
\DeclareOption{noparindent}{
	\setlength{\parindent}{0pt}
}
\DeclareOption{noparskip}{
	\setlength{\parskip}{0pt}
}

%%% Comandi e ambienti per article-like
\newcommand{\nomatter}{
	\renewcommand{\frontmatter}{}
	\renewcommand{\mainmatter}{}
	\renewcommand{\backmatter}{}
	}
\newcommand{\notinarticle}{}

%%% Alias per article-like: non indispensabili, solo per ordine mentale
\newcommand{\artsection}[1]{\chapter{#1}}
\newcommand{\artsubsection}[1]{\section{#1}}
\newcommand{\artsubsubsection}[1]{\subsection{#1}}
\newcommand{\artparagraph}[1]{\subsubsection{#1}}
\newcommand{\artsubparagraph}[1]{\paragraph{#1}}

%%% Opzioni per article-like
\DeclareOption{nomatter}{
	\nomatter
}
\DeclareOption{article}{
\let\chapter\section
\let\section\subsection
\let\subsection\subsubsection
\let\subsubsection\paragraph
\let\paragraph\subparagraph
\makeatletter
\renewcommand \thesection {\@arabic\c@section}
\renewcommand{\maketitle}{\thispagestyle{plain}{\centering\LARGE\textbf{\colorB\@title}\Large\\\vspace{1ex}\@author\\\vspace{1ex}\today\\\vspace{3ex}}}
\makeatother
\renewcommand{\titling}{
	\maketitle
	}
\let\toctemp\tableofcontents
\renewcommand{\tableofcontents}{
	\begin{center}
	\begin{minipage}{0.9\textwidth}
	\toctemp
	\end{minipage}
	\end{center}
	\vspace{3ex}
	}
\let\include\input
\setleftmark{\rightmark}
\renewcommand{\notinarticle}[1]{}
}

%%% Opzioni per la title page
\DeclareOption{nofooter}{
\renewcommand{\titling}{
  \begin{titlepage}
  \maketitle
  \vspace{\stretch{4}}
  \titlingpagemiddle
  \vspace{\stretch{4}}
\end{titlepage}}
}
\DeclareOption{logo-bg}{
\renewcommand{\titling}{
  \begin{titlepage}
  \AddToShipoutPicture*{\AtPageCenter{\makebox(0,0){\inslogo{\logo}}}}
  \maketitle
  \vspace{\stretch{4}}
  \titlingpagemiddle
  \vspace{\stretch{4}}
  \begin{center}
    \titlingpageprefooter
    {\colorB\rule[.5ex]{50ex}{.4pt}}\\
    \titlingpagefooter
  \end{center}
\end{titlepage}}
}
\DeclareOption{logo-bg-nofooter}{
\renewcommand{\titling}{
  \begin{titlepage}
  \AddToShipoutPicture*{\AtPageCenter{\makebox(0,0){\inslogo{\logo}}}}
  \maketitle
  \vspace{\stretch{4}}
  \titlingpagemiddle
  \vspace{\stretch{4}}
\end{titlepage}}
}
\DeclareOption{logo}{
\renewcommand{\titling}{
  \begin{titlepage}
  \maketitle
  \vspace{\stretch{3}}
  \begin{center}
    \inslogo{\logo}
  \end{center}
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
  \begin{center}
    \titlingpageprefooter
    {\colorB\rule[.5ex]{50ex}{.4pt}}\\
    \titlingpagefooter
  \end{center}
\end{titlepage}}
}
\DeclareOption{logo-nofooter}{
\renewcommand{\titling}{
  \begin{titlepage}
  \maketitle
  \vspace{\stretch{3}}
  \begin{center}
    \inslogo{\logo}
  \end{center}
  \vspace{\stretch{1.5}}
  \titlingpagemiddle
  \vspace{\stretch{1.5}}
\end{titlepage}}
}
\DeclareOption{logo-topr}{
\renewcommand{\titling}{
  \begin{titlepage}
  \begin{flushright}
    \setlogooptions{width=0.2\paperwidth}
    \inslogo{\rightlogo}
  \end{flushright}
  \vspace{\stretch{2}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
  \begin{center}
    \titlingpageprefooter
    {\colorB\rule[.5ex]{50ex}{.4pt}}\\
    \titlingpagefooter
  \end{center}
\end{titlepage}}
}
\DeclareOption{logo-topr-nofooter}{
\renewcommand{\titling}{
  \begin{titlepage}
  \begin{flushright}
    \setlogooptions{width=0.2\paperwidth}
    \inslogo{\rightlogo}
  \end{flushright}
  \vspace{\stretch{3}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
\end{titlepage}}
}
\DeclareOption{logo-topl}{
\renewcommand{\titling}{
  \begin{titlepage}
  \begin{raggedleft}
    \setlogooptions{width=0.2\paperwidth}
    \inslogo{\leftlogo}
  \end{raggedleft}
  \vspace{\stretch{2}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
  \begin{center}
    \titlingpageprefooter
    {\colorB\rule[.5ex]{50ex}{.4pt}}\\
    \titlingpagefooter
  \end{center}
\end{titlepage}}
}
\DeclareOption{logo-topl-nofooter}{
\renewcommand{\titling}{
  \begin{titlepage}
  \begin{flushleft}
    \setlogooptions{width=0.2\paperwidth}
    \inslogo{\leftlogo}
  \end{flushleft}
  \vspace{\stretch{3}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
\end{titlepage}}
}
\DeclareOption{logo-toplr}{
\renewcommand{\titling}{
  \begin{titlepage}
  \setlogooptions{width=0.2\paperwidth}
  \inslogo{\leftlogo}\hfill\inslogo{\rightlogo}
  \vspace{\stretch{2}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
  \begin{center}
    \titlingpageprefooter
    {\colorB\rule[.5ex]{50ex}{.4pt}}\\
    \titlingpagefooter
  \end{center}
\end{titlepage}}
}
\DeclareOption{logo-toplr-nofooter}{
\renewcommand{\titling}{
  \begin{titlepage}
  \setlogooptions{width=0.2\paperwidth}
  \inslogo{\leftlogo}\hfill\inslogo{\rightlogo}
  \vspace{\stretch{3}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
\end{titlepage}}
}
\DeclareOption{logo-topc}{
\renewcommand{\titling}{
  \begin{titlepage}
  \begin{center}
    \setlogooptions{width=0.2\paperwidth}
    \inslogo{\logo}
  \end{center}
  \vspace{\stretch{2}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
  \begin{center}
    \titlingpageprefooter
    {\colorB\rule[.5ex]{50ex}{.4pt}}\\
    \titlingpagefooter
  \end{center}
\end{titlepage}}
}
\DeclareOption{logo-topc-nofooter}{
\renewcommand{\titling}{
  \begin{titlepage}
  \begin{center}
    \setlogooptions{width=0.2\paperwidth}
    \inslogo{\logo}
  \end{center}
  \vspace{\stretch{3}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
\end{titlepage}}
}
\DeclareOption{logo-toplcr}{
\renewcommand{\titling}{
  \begin{titlepage}
  \setlogooptions{width=0.1\paperwidth}
  \inslogo{\leftlogo}\hfill\inslogo{\logo}\hfill\inslogo{\rightlogo}
  \vspace{\stretch{2}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
  \begin{center}
    \titlingpageprefooter
    {\colorB\rule[.5ex]{50ex}{.4pt}}\\
    \titlingpagefooter
  \end{center}
\end{titlepage}}
}
\DeclareOption{logo-toplcr-nofooter}{
\renewcommand{\titling}{
  \begin{titlepage}
  \setlogooptions{width=0.1\paperwidth}
  \inslogo{\leftlogo}\hfill\inslogo{\logo}\hfill\inslogo{\rightlogo}
  \vspace{\stretch{3}}
  \maketitle
  \vspace{\stretch{3}}
  \titlingpagemiddle
  \vspace{\stretch{3}}
\end{titlepage}}
}

%% Colori di sezioni, sottosezioni, etc.
\newcommand{\sectionfont}{\normalfont\colorA\Large\bfseries}
\newcommand{\setsectionfont}[1]{
  \renewcommand{\sectionfont}{#1}}
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\sectionfont}}
\newcommand{\subsectionfont}{\normalfont\colorA\large\bfseries}
\newcommand{\setsubsectionfont}[1]{
  \renewcommand{\subsectionfont}{#1}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\subsectionfont}}
\newcommand{\subsubsectionfont}{\normalfont\colorA\normalsize\bfseries}
\newcommand{\setsubsubsectionfont}[1]{
  \renewcommand{\subsubsectionfont}{#1}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\subsubsectionfont}}
\newcommand{\paragraphfont}{\normalfont\colorA\normalsize\bfseries}
\newcommand{\setparagraphfont}[1]{
  \renewcommand{\paragraphfont}{#1}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\paragraphfont}}
\newcommand{\subparagraphfont}{\normalfont\colorA\normalsize\bfseries}
\newcommand{\setsubparagraphfont}[1]{
  \renewcommand{\subparagraphfont}{#1}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                       {\subparagraphfont}}

%% Capitoli e parti
\def\@makechapterhead#1{%
  \vspace*{20\p@}
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        {\colorA\huge\scshape \@chapapp\space \thechapter}
        \par\nobreak
        \vskip 10\p@
      \fi
    \fi
    \interlinepenalty\@M
  {\colorB\hrule}
  \vskip 15\p@
   \begin{flushright}
     {\colorA\Huge \bfseries #1}\par\nobreak
   \end{flushright}
  \vskip 5\p@
  {\colorB\hrule}
  \vskip 30\p@
  }}
\def\@makeschapterhead#1{%
  \vspace*{20\p@}
  {\parindent \z@ \raggedright \normalfont
  {\colorB\hrule}
  \vskip 15\p@
   \begin{center}
     {\colorA\Huge \bfseries #1}\par\nobreak
   \end{center}
  \vskip 5\p@
  {\colorB\hrule}
  \vskip 30\p@
  }}
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \colorA\huge\bfseries \partname\nobreakspace\thepart
       \par
       \vskip 20\p@
     \fi
     \Huge \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \colorA\Huge \bfseries #1\par}%
    \@endpart}

%Page headings
\newcommand{\setevenhead}[1]{\def\@evenhead{#1}}
\newcommand{\setoddhead}[1]{\def\@oddhead{#1}}
\newcommand{\setevenfoot}[1]{\def\@evenfoot{#1}}
\newcommand{\setoddfoot}[1]{\def\@oddfoot{#1}}
\newcommand{\oddheadtext}{{\colorA{\slshape\rightmark}\hfill\thepage}}
\newcommand{\setoddheadtext}[1]{\renewcommand{\oddheadtext}{#1}}
\newcommand{\evenheadtext}{\oddheadtext}
\newcommand{\setevenheadtext}[1]{\renewcommand{\evenheadtext}{#1}}
\newcommand{\evenfoottext}{}
\newcommand{\setevenfoottext}[1]{\renewcommand{\evenfoottext}{#1}}
\newcommand{\oddfoottext}{}
\newcommand{\setoddfoottext}[1]{\renewcommand{\oddfoottext}{#1}}
\newcommand{\setleftmark}[1]{\renewcommand{\leftmark}{#1}}
\newcommand{\setrightmark}[1]{\renewcommand{\rightmark}{#1}}
\newcommand{\makeheadrule}{{\colorB\hrule\@width\textwidth \@height 0.4pt \vskip-0.4pt}}
\newcommand{\makefootrule}{\makeheadrule}
\if@twoside
  \setevenheadtext{{\colorA\thepage\hfill\slshape\leftmark}}
\fi
\setevenhead{\vbox{\evenheadtext \vskip 5\p@ \makeheadrule}}
\setoddhead{\vbox{\oddheadtext \vskip 5\p@ \makeheadrule}}

%% MakeUppercase fa si' che tutte le intestazioni predefinite siano in maiuscolo:
%% il comando viene ridefinito come comando vuoto, ma per chi dovesse aver bisogno
%% di MakeUppercase viene definito \UCase
\let\UCase\MakeUppercase
\renewcommand{\MakeUppercase}{}

% Ridefinizione del pagestyle plain per colorare il numero di pagina
\def\ps@plain{%
    \def\@oddfoot{{\hfil\colorA\thepage\hfil}}
    \def\@evenfoot{{\hfil\colorA\thepage\hfil}}
    \let\@oddhead\@empty
    \let\@evenhead\@empty
}

% Epigrafi
\newcommand{\epigraph}[4]{
\begin{#3}
 \begin{minipage}{#4}
  #1\\
 {\colorB\rule[.5ex]{#4}{.4pt}}\\
  #2
 \end{minipage}
\end{#3}
}

\makeatother
% Rimozione epigrafi (utile per fare diverse versioni di un documento)
\newcommand{\noepigraph}{\renewcommand{\epigraph}[4]{}}
\DeclareOption{noepigraph}{
	\noepigraph
}

\ProcessOptions