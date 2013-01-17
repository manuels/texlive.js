% Copyright (C) 2009 Alain Matthes  
% encoding : utf8
% engine   : pdflatex   
%   H I G H L Y   E X P E R I M E N T A L
% This file may be distributed and/or modified
%
% 1. under the LaTeX Project Public License , either version 1.3
% of this license or (at your option) any later version and/or
% 2. under the GNU Public License.
%
% See the file doc/generic/pgf/licenses/LICENSE for more details.%
% See http://www.latex-project.org/lppl.txt for details.
%
%
% ``tkz-doc'' class for use with the tkz documentation ( AlterMundus Collection ).
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%     tkz-doc.cls       encodage : utf8                         %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%           Créé par Alain Matthes le 2009-02-22.               %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Objet :  Classe LaTeX  et Styles pour créer des documentations.
%<--------------------------------------------------------------------------->
%<-------------- Définitions relatives au package --------------------------->
\newcommand*{\PackageName}{tkz-doc}
\newcommand*{\PackageVersion}{1.1 c}
\newcommand*{\filedate}{2011/05/30}
%<---------------------- Identification Part -------------------------------->
%
%<--------------------------------------------------------------------------->
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\PackageName}%
[\filedate\space Version:\space\PackageVersion\space tkz documentation class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[titlepage,oneside]{scrartcl}
\PassOptionsToPackage{usenames,dvipsnames,svgnames}{xcolor}
\RequirePackage{etex}
\RequirePackage[utf8]{inputenc}
\RequirePackage{xkeyval}[2005/11/25] 
\RequirePackage{framed,eso-pic}
\RequirePackage{amsmath,amssymb}
\RequirePackage{textcomp}
\RequirePackage[upright]{fourier}
\RequirePackage[scaled=0.85]{berasans}
\RequirePackage[scaled=0.85]{beramono}
\RequirePackage[bottom,stable,ragged]{footmisc}
\RequirePackage[automark,nouppercase]{scrpage2} 


\pagestyle{scrheadings} 
\clearscrheadings
\clearscrplain
\ohead{\textcolor{Peach}{\pagemark}}
\ihead{\textcolor{Peach}{\headmark}}
\rofoot{\textcolor{Peach}{\namecollection}} 
\lofoot{\textcolor{Peach}{\nameofpack}}
\automark[subsection]{section}
\setheadsepline{.4pt}[\color{Peach}]
\setfootsepline{.4pt}[\color{Peach}]
\setheadwidth[0pt]{text}
\setfootwidth[0pt]{text}
\renewcommand{\footnoterule}{\vspace*{-3pt}{%
   \color{Peach}\hrule width 2in height 0.4pt}
   \vspace*{2.6pt}}
\deffootnote{1.5em}{1em}{\makebox[1.5em][l]{%
   \thefootnotemark}}
\addtolength{\skip\footins}{\baselineskip}%
%<------------------–  En-tête et pied de page ------------------------------>
%
%<--------------------------------------------------------------------------->
\pagenumbering{arabic}
\newcommand\SectionFontStyle{\sffamily}
\setkomafont{sectioning}{\bfseries\SectionFontStyle}
\setkomafont{pagenumber}{\bfseries\SectionFontStyle}
\setkomafont{pagehead}{\small\sffamily}
\setkomafont{pagefoot}{\small\sffamily}
\setkomafont{descriptionlabel}{\itshape}
\addtokomafont{sectioning}{\color{sectioncolor}}
\renewcommand*{\raggedsection}{\raggedright}
%<--------------------------------------------------------------------------->
%
%<--------------------------------------------------------------------------->
\newcounter{cnt}\setcounter{cnt}{1}
\setcounter{secnumdepth}{3}%
\setcounter{tocdepth}{3} 

\color{Maroon}
\usepackage{titlesec}
\titleformat{\section}[frame] 
{\normalfont}
{\filright\footnotesize\enspace SECTION \thesection\enspace} 
{8pt} 
{\Large\bfseries\filcenter}
\titleformat{\subsection}[block] {\large\bfseries\filright}{\fbox{\thesubsection}}{2em}{}%
%<------------------  Éxécution et chargement ------------------------------->
%
%<--------------------------------------------------------------------------->
% ------------------–Fin    Taille des fontes ------------------------------->
\RequirePackage{makeidx} 
\@twocolumnfalse
\makeindex 

\RequirePackage{calc}
\RequirePackage{tikz}
% We need lots of libraries...
\usetikzlibrary{%
  arrows,%
  calc,%
  fit,%
  patterns,%
  plotmarks,%
  shapes.geometric,%
  shapes.misc,%
  shapes.symbols,%
  shapes.arrows,%
  backgrounds,%
  topaths,%
  trees,%
  matrix,%
  folding,%
  fadings,%
  through,%
  positioning,%
  scopes,%
  decorations.shapes,%
  decorations.text,%
  decorations.pathreplacing,%
  decorations.pathmorphing,%
  decorations.markings,%
  shadows} 
  
\RequirePackage{multido}
\RequirePackage{lscape}
\RequirePackage{graphicx}
\RequirePackage{array}
\RequirePackage{multicol}
\RequirePackage{multirow} 
\RequirePackage{tabularx,ragged2e}
\RequirePackage{booktabs}
\RequirePackage[bottom,stable,ragged]{footmisc}


\raggedbottom 
% colors
\definecolor{fondpaille}{cmyk}{0,0,0.1,0}
\definecolor{bistre}{rgb}{.75,.50,.30}
\providecolor{bistre}{rgb}{.75,.50,.30}
\colorlet{graphicbackground}{fondpaille}
\colorlet{codebackground}{fondpaille!92!Maroon} 
\colorlet{sectioncolor}{Maroon}
\definecolor{textcolor}{RGB}{0, 0, 0}
\colorlet{titlecolorbox}{fondpaille!92!Maroon}  
\colorlet{pdflinkcolor}{blue}
\colorlet{pdfurlcolor}{blue}
\colorlet{pdffilecolor}{Peach}
\colorlet{stringcolor}{green!40!black!100}
\colorlet{commencolor}{blue!0!black!100}

\newbox\tkzbox 

\def\nodeshadowedone(#1,#2)#3{% 
\node[Mahogany,above,inner sep=0pt]{\global\setbox\tkzbox=\hbox{#3}\copy\tkzbox}; 
\node[above,yscale=#2,inner sep=0pt,xslant=#1,Peach!60]{\box\tkzbox};
}%  
%<--------------------------- Indexation ------------------------------------>
\newcommand*{\Ilib}[1]{\index{Library_1@\texttt{Library}!\texttt{#1}}}
\newcommand*{\Ienv}[1]{\index{Environment_1@\texttt{Environment}!\texttt{#1}}}
\newcommand*{\IargEnv}[2]{\index{#1_2@\texttt{#1: arguments}!\texttt{#2}}}
\newcommand*{\IargNameEnv}[2]{\tkzname{#2}\index{#1_2@\texttt{#1: arguments}!\texttt{#2}}}
\newcommand*{\IoptEnv}[2]{\index{#1_3@\texttt{#1: options}!\texttt{#2}}} 
\newcommand*{\IoptNameEnv}[2]{\tkzname{#2}\index{#1_3@\texttt{#1: options}!\texttt{#2}}}
\newcommand*{\Imacro}[1]{\index{#1_1@\texttt{\textbackslash#1}}}%n
\newcommand*{\Iarg}[2]{%
                \index{#1_2@\texttt{\textbackslash#1: arguments}!\texttt{#2}}}
\newcommand*{\IargName}[2]{\tkzname{#2}\index{#1_2@\texttt{\textbackslash#1: arguments}!\texttt{#2}}}
\newcommand*{\IoptName}[2]{\tkzname{#2}\index{#1_3@\texttt{\textbackslash#1: options}!\texttt{#2}}}     
\newcommand*{\Iopt}[2]{\index{#1_3@\texttt{\textbackslash#1: options}!\texttt{#2}}}
\newcommand*{\Istyle}[2]{\index{#1_3@\texttt{\textbackslash#1: styles}!\texttt{#2}}} 
\newcommand*{\IstyleEnv}[2]{\index{#1_3@\texttt{#1: styles}!\texttt{#2}}} 
\newcommand*{\Iaccent}[2]{\index{#1@\texttt{#2}}}
\newcommand*{\NameLib}[1]{\tkzname{#1}\index{Ti\emph{k}Z Library !#1@\texttt{#1}}}
\newcommand*{\NameSys}[1]{\index{Operating System  !#1@\texttt{#1}}}
\newcommand*{\NameDist}[1]{\index{TeX Distributions  !#1@\texttt{#1}}}
\newcommand*{\NameFonct}[1]{\index{Functions !#1@\texttt{#1}}} 
\newcommand*{\NamePack}[1]{\index{Package !#1@\texttt{#1}}}  

\newcommand*{\TOenvline}[3]{\IoptNameEnv{\ActivBoxName}{#1}&\tkzdft{#2}&\ttfamily #3\\}
\newcommand*{\TOline}[3]{\IoptName{\ActivBoxName}{#1}&\tkzdft{#2}&\ttfamily  #3\\}
\newcommand*{\TAline}[3]{\IargName{\ActivBoxName}{#1}&\tkzdft{#2}&\ttfamily  #3\\}
\newcommand*{\TMline}[3]{\tkzcname{#1}\index{#1_1@\texttt{\textbackslash#1}}&\tkzdft{#2}&\ttfamily  #3\\}

\newcommand*{\tkzNamePack}[1]{\tkzname{#1}\NamePack{#1}}
\newcommand*{\tkzNameMacro}[1]{\tkzcname{#1}\Imacro{#1}}
\newcommand*{\tkzNameEnv}[1]{\tkzname{#1}\Ienv{#1}} 
%<-------------------------------------------------------------------------->
%<-------------------------------------------------------------------------->
\newcommand*{\addbs}[1]{\texttt{\textbackslash#1}} 
\newcommand*{\@CellCode}[1]{}
\newcommand*{\thead}{\noalign{\iffalse}\fi\@thead}
\newcommand*{\@thead}[1][\em\ttfamily]{\gdef\@CellCode{#1}\iffalse{\fi}}
\newcommand*{\tbody}{\noalign{\gdef\@CellCode{}}}
\newcolumntype{I}{>{\@CellCode}}   
%<---------------------------------  Couverture ---------------------------->
%<---------------------------------  Make Title ---------------------------->
\renewcommand\maketitle{%
\null
\AddToShipoutPicture*{%
\setlength\unitlength{1mm}
\put(0,0){\makebox(0,0)[lb]{\color{Peach!10}\rule{\paperwidth}{\paperheight}}}
\put(0,0){\makebox(0,0)[lb]{\color{Mahogany}\rule{40mm}{\paperheight}}}
\put(20,270){\rotatebox{90}{% 
\makebox(0,0)[r]{\fontsize{60}{60}\color{orange!50!white}%
\bfseries \selectfont{\@title\ \versionofpack}\hfill}}}%
    \put(60,80){%
    \begin{pgfpicture} 
\pgfmathdeclarerandomlist{color}{{Peach}{Orange}{Red}{Brown}} 
\foreach \a in {1,...,5}{% 
  \pgfmathrandominteger{\x}{1}{300} 
  \pgfmathrandominteger{\y}{1}{200} 
  \pgfmathrandominteger{\r}{20}{100} 
  \pgfmathrandominteger{\s}{5}{95} 
  \pgfmathrandominteger{\o}{50}{80}
  \pgfmathrandomitem{\c}{color} 
  \pgfdeclareradialshading{ballshading}{\pgfpoint{-10bp}{10bp}} 
  {color(0bp)=(\c!15!white); color(9bp)=(\c!75!white); 
   color(18bp)=(\c!70!black); color(25bp)=(\c!50!black); color(50bp)=(black)}
  \pgfsetfillopacity{\o/100} 
  \pgfpathcircle{\pgfpoint{+\x pt}{+\y pt}}{+\r pt} 
  \pgfshadepath{ballshading}{\s} 
  \pgfusepath{}
}%
\end{pgfpicture}}
\put(60,250){\makebox(0,0)[l]{%
\begin{tikzpicture}
\nodeshadowedone(2,-1.25){\fontsize{60}{60}\selectfont{\namecollection}};
\end{tikzpicture}
}}%
\put(130,40){\makebox(0,0)[l]{%
\fontsize{17}{21}
\textcolor{Mahogany}{\selectfont{\authorofpack}}}} 
\put(130,20){\makebox(0,0)[l]{%
\textcolor{Mahogany}{\url{\urlauthor} \ \url{\urlauthorcom}}}}
\put(130,30){\makebox(0,0)[l]{\textcolor{Mahogany}{\today}}}}
%<----------------------------- End   Couverture ---------------------------->
\setcounter{footnote}{0}%
}
%<----------------------------- def macro arg opt---------------------------->
 % some of the macros below are absolete
\def\cmd#1{\cs{\expandafter\cmd@to@cs\string#1}}
\def\cmd@to@cs#1#2{\char\number`#2\relax}
\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\providecommand\marg[1]{{\ttfamily\char`\{}\opt{\meta{#1}}{\ttfamily\char`\}}}
\providecommand\oarg[1]{{\ttfamily[}\opt{\meta{#1}}{\ttfamily]}}
\providecommand\parg[1]{{\ttfamily(}\opt{\meta{#1}}{\ttfamily)}}
\newcommand\opt[1]{{\color{Maroon}#1}}
\newcommand\ooarg[1]{{\ttfamily[}\meta{#1}{\ttfamily]}}  
\newcommand*{\var}[1]{\{\opt{\meta{#1}}\}}
\newcommand*{\varp}[1]{\big(\opt{\meta{#1}}\big)}
\newcommand*{\vara}[1]{\{#1\}}


\DeclareRobustCommand\meta[1]{%
\ensuremath\langle
     \ifmmode \expandafter \nfss@text \fi
     {%
      \meta@font@select
      \edef\meta@hyphen@restore
        {\hyphenchar\the\font\the\hyphenchar\font}%
      \hyphenchar\font\m@ne
      \language\l@nohyphenation
      \/#1\/%
      \meta@hyphen@restore
     }\ensuremath\rangle
}
\def\meta@font@select{\itshape}
%
%<-------------------------- NewMacroBox ----------------------------------->

\newcommand*{\ActivBoxName}{}
\newenvironment{NewMacroBox}[2]{%
\parindent=0pt
\renewcommand*{\ActivBoxName}{#1}
\def\FrameCommand{\color{Maroon}
{\vrule width 1pt\hspace{3pt}}%
}%
\MakeFramed{\advance\hsize-\width}%
\noindent
\makebox[0pt][l]{%
\hspace{-4pt}%
\setlength{\fboxrule}{1pt}%
\setlength{\fboxsep}{3pt}%
\fcolorbox{Maroon}{titlecolorbox}{%
\rule{6pt}{0pt}%
\makebox[\width+6pt][l]{\tkzcname{#1#2}}%
}%
}\\*[.5\baselineskip]%
\noindent
% \ignorespaces\tkzcname{#1#3}
\Imacro{#1}%
\color{Maroon}}{%
\par\noindent%
\makebox[0pt][l]{%
\hspace{-6pt}%
\rule{6pt}{1pt}%
\rule{\textwidth}{1pt}%
\hspace{-1pt}%
\rule{1pt}{10pt}%
}%
\endMakeFramed
\noindent
\ignorespacesafterend
\par\medskip
}%
%<----------------- end NewMacroBox ----------------------------------------->
%<----------------------------- NewEnvBox ----------------------------------->
\let\fram@d=\MakeFramed  \let\endfram@d=\endMakeFramed

\newenvironment{NewEnvBox}[1]{%
\parindent=0pt
\renewcommand*{\ActivBoxName}{#1}
%\gdef\tkzEnvMacro{#1}
\def\FrameCommand{\color{Maroon}
{\vrule width 1pt\hspace{3pt}}%
}%
\MakeFramed{\advance\hsize-\width}%
\noindent
\makebox[0pt][l]{%

\hspace{-4pt}%
\setlength{\fboxrule}{1pt}%
\setlength{\fboxsep}{3pt}%
\fcolorbox{Maroon}{titlecolorbox}{%
\rule{6pt}{0pt}%
\makebox[\width+6pt][l]{%
 \tkzcname{\textcolor{Maroon}{begin}\{\ActivBoxName\}}{\oarg{options}}%
 \hspace*{.25cm}\meta{environment contents}\hspace*{.25cm}%
 \tkzcname{\textcolor{Maroon}{end}\{\ActivBoxName\}}}%
}%
}\\*[.5\baselineskip]%
\noindent
% \ignorespaces\tkzcname{#1#3}
\Ienv{#1}
\color{Maroon}}{%
\par\noindent%
\makebox[0pt][l]{%

\hspace{-6pt}%
\rule{6pt}{1pt}%
\rule{\textwidth}{1pt}%

\hspace{-1pt}%
\rule{1pt}{10pt}%
}%
\endMakeFramed
\noindent
\ignorespacesafterend
\par\medskip
}
%<------------------- end NewEnvBox ----------------------------------------->
\def\nameoffile#1{\gdef\@nameoffile{#1}}
\def\@nameoffile{\@latex@warning@no@line{No \noexpand\nameoffile given}}
\long\def\defoffile#1{
    \protected@xdef\@defoffile{\@defoffile{#1}}%
}
\let\@defoffile\@empty
\def\nameoffile#1{\gdef\@nameoffile{#1}}
\def\@nameoffile{\@latex@warning@no@line{No \noexpand\nameoffile given}}
\long\def\defoffile#1{\protected@xdef\@defoffile{\@defoffile{#1}}%
}
\let\@defoffile\@empty

\newcommand*{\red}{\color{red}}
\newcommand*{\blue}{\color{BlueViolet}}
\newcommand*{\BS}{\texttt{\char92}}
\newcommand*{\tkz}{Ti{\em k}Z}
\newcommand*{\orange}{\color{Orange}}
\newcommand*{\blanc}{\color{White}}
\newcommand*{\PGF}{\tkzname{PGF}}      
\newcommand*{\TIKZ}{\tkzname{Ti\emph{k}Z}} 
\newcommand*{\beamer}{\textsc{beamer}}
\newcommand*{\pdf}{\textsc{pdf}}
\newcommand*{\pgfname}{\textsc{pgf}}
\newcommand*{\tikzname}{Ti\emph{k}Z}
\newcommand*{\pstricks}{\textsc{pstricks}}

\newcommand*{\tkzdft}[1]{{\texttt{#1}}}
\providecommand\LaTeX{%
  L\kern-.36em\raise.3ex\hbox{\sc a}\kern-.15em\TeX}
\providecommand\LATEX{\LaTeX}  
\renewcommand\TeX{T\kern-.1667em\lower.5ex\hbox{E}\kern-.125emX%
  \spacefactor1000 }
  \providecommand\TEX{\TeX} 
  \newcommand*{\tkzAttention}[3]{\ \\\llap{\textcolor{#3}{#1\hskip #2}}} 
\newcommand*{\tkzHand}{\ \\\llap{\textcolor{red}{\lefthand\hskip1em}}}
\newcommand*{\tkzHandBomb}{\ \\\llap{\textcolor{red}{\lefthand\ \bomb\hskip1em}}}
\newcommand*{\tkzBomb}{\ \\\llap{\textcolor{red}{\bomb\hskip1em}}}
\newcommand*{\tkzTwoBomb}{\ \\\llap{\textcolor{red}{\bomb\ \bomb\hskip1em}}}

\newcommand*{\tkzname}[1]{\textbf{\texttt{\textcolor{Maroon}{#1}}}}
\newcommand*{\tkzimp}[1]{\textbf{#1}}
\newcommand*{\tkzcname}[1]{\Imacro{#1}\textbf{\texttt{\textcolor{Maroon}{\textbackslash#1}}}}  
\newcommand*{\tkzhname}[1]{\textbf{\texttt{\textcolor{Maroon}{\textbackslash#1}}}}   
%<--------------------------- presentation ---------------------------------->
% \providecommand\href[2]{\texttt{#1}}

\newcommand\presentation{%
  \thispagestyle{empty}%
 \par\vspace*{3 cm}
     \begin{center}
     	{\Huge \@nameoffile}
     \end{center}   
    \par\vspace*{3 cm}
    \noindent
  \newlength{\@lx}\settowidth{\@lx}{\huge \namecollection}%
  \advance\@lx3em\quad
  \href{\urlauthor}{%
    \rotatebox{90}{\hspace*{1.5em}{\huge \namecollection}}}
  \textcolor{Mahogany}{\rule{2pt}{\@lx}}\quad%
  \begin{minipage}[b]{.90\textwidth}
    {%
    \noindent\hfill
     \raggedleft\Large
     \href{mailto:al.ma@mac.com}{\textcolor{blue}{\authorofpack}}\par
     }%
     \emph{\@defoffile}\par
    %[\nameofdoc\ \dateofdoc]\par\medskip
  \end{minipage}
}
%<---------------------- end  presentation ---------------------------------->

\renewcommand*{\idx@heading}{%
 \idx@@heading{\indexname}%
 % \@mkboth{\indexname}{\indexname}%
}
\renewenvironment{theindex}{%
    \@restonecoltrue
  \columnseprule \z@
  \columnsep 35\p@
  \idx@heading%
  \index@preamble\par\nobreak
  \thispagestyle{\indexpagestyle}\parindent\z@
  \setlength{\parskip}{\z@ \@plus .3\p@}%
  \setlength{\parfillskip}{\z@ \@plus 1fil}%
  \let\item\@idxitem
}{%
  \if@restonecol\onecolumn\else\clearpage\fi
} 
  
\def\tkz@background@color{white}
\def\tkz@text@color{black} 
\global\edef\tkz@suc@bkc{\tkz@background@color}
\global\edef\tkz@suc@txt{\tkz@text@color}
\pgfkeys{/tkzsetupcolor/.cd,
          background/.code    = {\global\edef\tkz@suc@bkc{#1}},
          text/.code          = {\global\edef\tkz@suc@txt{#1}}}
          
\def\tkzSetUpColors{\pgfutil@ifnextchar[{\tkz@SetUpColors}{%
                                         \tkz@SetUpColors[]}} 
\def\tkz@SetUpColors[#1]{%
\begingroup
\pgfkeys{tkzsetupcolor/.cd,
         background  = \tkz@background@color,
         text        = \tkz@text@color}
\pgfqkeys{/tkzsetupcolor}{#1}      
\pagecolor{\tkz@suc@bkc}
\color{\tkz@suc@txt}} 

%<--------------------------------------------------------------------------->
\endinput
%<--------------------------------------------------------------------------->

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                               %
    %          End of file `tkz-doc.cls'.                           %
    %                                                               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
