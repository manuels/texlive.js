%% documentclass only for the documentation of mdframed
%% This documentclass isn't maintanened or efficient for writing
%%
%%
%% Copyright (c) 2010 Marco Daniel
%%
%% This package may be distributed under the terms of the LaTeX Project
%% Public License, as described in lppl.txt in the base LaTeX distribution.
%% Either version 1.0 or, at your option, any later version.


%%$Id: ltxmdf.cls 374 2012-04-08 10:47:37Z marco $
%%$Rev: 374 $
%%$Author: marco $
%%$Date: 2012-04-08 12:47:37 +0200 (So, 08. Apr 2012) $


%% Allgemeine Angaben
\def\ltxmdf@svn$#1: #2 #3 #4-#5-#6 #7 #8${#4/#5/#6\space }
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{ltxmdf}[\ltxmdf@svn$Id: ltxmdf.cls 374 2012-04-08 10:47:37Z marco $ ltxmdf]
\DeclareOption{tocdepthsec}{\def\ltxmdf@tocdepth{1}}
\DeclareOption{tocdepthsub}{\def\ltxmdf@tocdepth{2}}
\newif\ifltxmdf@lipsum
\ltxmdf@lipsumfalse
\DeclareOption{ltxlipsum}{\ltxmdf@lipsumtrue}
\newif\ifltxmdf@showframe
\ltxmdf@showframefalse
\DeclareOption{ltxshowframe}{\ltxmdf@showframetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ExecuteOptions{tocdepthsub}
\ProcessOptions\relax
\LoadClass{scrartcl}
\RequirePackage{selinput}
\SelectInputMappings{
  adieresis={ä},
  germandbls={ß},
  Euro={€},
}

\RequirePackage{etoolbox}
%Required Packages no font / no language
%\RequirePackage[nofancy,draft,notoday]{svninfo}
\RequirePackage[left=2.5cm,right=2.5cm,top=3cm,bottom=3cm]{geometry}
\ifltxmdf@showframe
  \RequirePackage{showframe}
\fi
\ifltxmdf@lipsum
  \RequirePackage{lipsum}
\fi
\RequirePackage[T1]{fontenc}
\RequirePackage[scaled=0.82]{beramono}
\RequirePackage{microtype}
\RequirePackage[french=quotes]{csquotes}
\RequirePackage{xspace}
\begingroup
  \text@command\relax
  \global\let\xspace@check@icr\check@icr
\endgroup
\xspaceaddexceptions{\xspace@check@icr}
\RequirePackage{multicol}\columnseprule0.4pt
\RequirePackage{scrpage2}
\RequirePackage{listings}
\RequirePackage[inline]{enumitem}
\RequirePackage{amsmath}
\RequirePackage[amsmath]{ntheorem}
\RequirePackage{array,booktabs}
\RequirePackage{xcolor,tikz}
\RequirePackage{graphicx}

\RequirePackage[numbered]{hypdoc}
%set columns of index
\c@IndexColumns = 2

    \hypersetup{%
        breaklinks=true,
        pdftitle={Documenation of mdframed},%
        pdfauthor={Marco Daniel},%
        colorlinks=true,%
        linkcolor=ltxmdfblue,
        urlcolor=cyan,
        bookmarksdepth=\ltxmdf@tocdepth,
    }


%Kopf- und Fusszeilen
\clearscrheadfoot
\pagestyle{scrheadings}
\automark[subsection]{section}
\renewcommand{\sectionmark}[1]{\markboth{\sectionmarkformat #1}{}}%
\renewcommand{\subsectionmark}[1]{\markright{\subsectionmarkformat #1}} %nur Titel ohne Nr.
\ihead{\rightmark}
\ohead{\leftmark}
\ofoot{\pagemark}

\def\ltxmdfsetifoot$#1: #2 #3 #4-#5-#6 #7 #8${%
  \ifoot{#2 #3 #4-#5-#6 #7 #8}
}

\ltxmdfsetifoot$Id: ltxmdf.cls 374 2012-04-08 10:47:37Z marco $



%Tikz und Farbe
\usetikzlibrary{calc,backgrounds,arrows,matrix}
\colorlet{ltxmdfblue}{blue!30!black}

\lstset{keywordstyle=\bfseries}
\lstdefinestyle{lstltxmdf}{%
     basicstyle=\small\ttfamily,
     language={[LaTeX]TeX},
     basicstyle=\small,%
     xleftmargin=20pt,%
     xrightmargin=20pt,%
     frame=single,%
     rulecolor=\color{ltxmdfblue},%
     framesep=5pt,%
     framerule=1pt,%
     texcsstyle=*\color{red!50!black}\bfseries,
     moretexcs=intertext,
     keywordstyle=\color{blue!60!black}\bfseries,%
     columns=fullflexible,%
     fontadjust=true,%
     basewidth=0.65em,%
     breakatwhitespace=true,
     morekeywords=[2]{@length},
     keywordstyle=[2]\color{red!50!black}\bfseries,
     morekeywords={outerlinewidth,leftmargin,rightmargin,backgroundcolor,%
                   outerlinecolor,innertopmargin,splittopskip,skipbelow,%
                   skipabove,ntheorem,theorem,lemma,mdframed,linecolor,%
                   frametitle,infobox,innerlinewidth,roundcorner,leftline,topline,%
                   splitbottomskip,middlelinewidth,middlelinecolor,tikzsetting,%
                   rightline,bottomline,innerrightmargin,style,linewidth,lem,section,%
                   definedstyle,mdfapptodefinestyle,needspace,mdf@globalstyle@cnt,framemethod,%
                   ExampleText,titregris,draw,gray,thick,fill,white,shading,exersicetitle,%
                   exersicebackground,color,green,black,exercise,exercisepoints,%
                   text,rectangle,rounded,corners,right,minimum,height,xshift,at,%
                   exercisestyle,settings,frametitlefont,%
                   frametitlerule,frametitlebelowskip,frametitleaboveskip,%
                   frametitlebackgroundcolor,frametitlerulecolor,picins,figure},%
     moretexcs={newmdtheoremenv,newmdenv,theoremstyle,mdfsetup,@length,%
                   md@putbox@single,@tempboxa,mdf@,%
                   mdf@linewidth,mdf@leftmargin@length,interruptlength,%
                   setlength,newrobustcmd,overlaplines,appto,md@frame@leftline@singe,%
                   color,md@frame@leftline@single,mdf@innerbottommargin@length,%
                   mdf@middlelinewidth@length,mdfboundingboxheight,%
                   md@frame@rightline@single,mdfboundingboxwidth,%
                   mdf@innerrightmargin@length,mdfdefinestyle,mdfapptodefinestyle,defcounter,%
                   tikzstyle,pgfdeclarehorizontalshading,theexercise,mdf@@exercisepoints,%
                   define@key,renewrobustcmd,mdfcreateextratikz,node,ifdefempty,%
                   mdf@frametitlefont,dimexpr,mdframedtitleenv,ifstrempty,@undefined,%
                   mdtheorem,surroundwithmdframed,@captype,@dblarg,@newcaption,newcaption,%
                   mdflength,%
                   },%
}


\lstnewenvironment{tltxmdfexample}[1][]
  {\lstset{style=lstltxmdf,#1}}%
  {}

\lstMakeShortInline[basicstyle=\small\ttfamily\color{blue!60!black}]{|}

%table of contens anpassen:
\renewcommand\tableofcontents{%
  \setcounter{tocdepth}{\ltxmdf@tocdepth}%
  \begin{multicols}{2}[\centering\textbf{\sffamily\Large\contentsname}]
        \@starttoc{toc}
  \end{multicols}
}

%%Maketitle angepasst:
\def\title#1{\def\@title{#1}}
\def\subtitle#1{\def\@subtitle{#1}}
\def\author#1{\def\@author{#1}}
\def\version#1{\def\@version{#1}}
\def\date#1{\def\@date{#1}}
\def\@@date$#1: #2 #3 #4-#5-#6 #7 #8${#4/#5/#6}
\date{\@@date$Id: ltxmdf.cls 374 2012-04-08 10:47:37Z marco $}
\let\mdfdateID\@@date


\long\def\introduction#1{\def\@introduction{#1}}

\def\maketitle{%
 \clearpage
 \thispagestyle{empty}
 \begingroup
  \begingroup
    \parindent\z@
    \centering
     \color{ltxmdfblue}\Large\bfseries\sffamily\@title
     \par\kern.5\baselineskip
     \normalfont\large\normalcolor\@subtitle
     \par\kern.5\baselineskip
     \null\quad\@author\hfill\@version\hfill\@date\quad\null
  \endgroup
     \par\kern.5\baselineskip
  \begin{abstract}
     \@introduction
  \end{abstract}
     \par\kern.2\baselineskip
  \pdfbookmark[1]{\contentsname}{tocbook}
  \tableofcontents
 \endgroup
}

%Own Appendix
\def\ltxmdfappendix{%
 \clearpage
 %\newgeometry{left=5.5cm,}%
} 
%Modifkation of code
\preto\theCodelineNo{\color{gray}}
\setlength\MacroTopsep{10pt}
\appto\MacroFont{\color{ltxmdfblue}}


\DoNotIndex{\@captype,\@endparenv,\@endparpenalty,\@endpetrue,\@floatpenalty,\@footnotetext,\@ifnextchar,\@undefined,\@tempboxa} 
\DoNotIndex{\@M,\@empty,\@height,\@mpfn,\@mpfootins,\@mpfootnotetext,\@nil,\@plus,\@width}

\DoNotIndex{\@captype,\@endparenv,\@endparpenalty,\@endpetrue,\@floatpenalty}
\DoNotIndex{\@footnotetext,\@ifnextchar,\@undefined,\@tempboxa} 
\DoNotIndex{\@M,\@empty,\@height,\@mpfn,\@mpfootins,\@mpfootnotetext,\@nil,\@plus,\@width}
\DoNotIndex{\@afterheading,\@afterindentfalse,\@firstoftwo,\@gobble,\@ifpackageloaded}
\DoNotIndex{\@nobreaktrue,\@nobreakfalse,\@secondoftwo,\@tempa,\@tempdima}

\DoNotIndex{\addpenalty,\addvspace,\advance,\afterassignment,\AfterEndEnvironment,\appto}

\DoNotIndex{\baselineskip,\begin,\boolfalse,\begingroup,\box}
\DoNotIndex{\BeforeBeginEnvironment,\bfseries,\bgroup,\boxmaxdepth}

\DoNotIndex{\color@endgroup,\color@setgroup,\columnwidth,\csdef,\c@mpfootnote,\csname}
\DoNotIndex{\clip,\color,\color@begingroup,\coordinate,\csappta,\csuse,\csxdef,\Currentoption}

\DoNotIndex{\dimexpr,\DeclareBoolOption,\DeclareListParser,\def,\define@key,\dimen@,\dimen@i,\dp,\deflength}
\DoNotIndex{\DeclareDefaultOption,\defcounter,\DisableKeyvaloption}

\DoNotIndex{\eject,\end,\endtrivlist,\edef,\else,\endcsname,\endinput,\expandafter,\endgroup\egroup,\enlargethispage}

\DoNotIndex{\fwd@reserved@a,\fwd@reserveda,\fi,\fill,\forcsvlist}

\DoNotIndex{\gdef}

\DoNotIndex{\hbox,\height,\hrule,\hsize,\hspace,\ht,\hb@xt@,\hss}

\DoNotIndex{\if@minipage,\if@twocolumn,\if@twoside,\ifbool,\ifdim,\ifdimequal}
\DoNotIndex{\ifdimgreater,\ifdimless,\iffwd@footnoteinside,\ifinner,\ifnum,\ifodd}
\DoNotIndex{\ifblank,\ifboolexpr,\ifcase,\ifcsundef,\IfFileExists,\ifnumequal,\ifstrequal}
\DoNotIndex{\iftoggle,\ifundef,\input,\kernel@ifnextchar,\ifvoid,\ifx,\item}

\DoNotIndex{\kern}

\DoNotIndex{\leftline,\let,\linewidth,\lrbox,\large,\letcs,\listadd,\llap,\lowercase}

\DoNotIndex{\maxdimen,\medskipamount,\MessageBreak,\makebox}

\DoNotIndex{\NeedsTeXFormat,\newcounter,\newlength,\newrobustcmd,\nobreak,\normalcolor,\number}
\DoNotIndex{\newbool,\newcommand,\newenvironment,\newtheorem,\newtoggle,\node,\noindent}
\DoNotIndex{\notblank,\notbool,\null,\newpsstyle}
\DoNotIndex{\next}

\DoNotIndex{\or}

\DoNotIndex{\p@,\PackageInfo,\PackageWarning,\pagegoal,\pagetotal,\partopsep,\patchcmd,\penalty}
\DoNotIndex{\ProcessKeyvalOptions,\ProvidesPackage,\providecommand,\path}
\DoNotIndex{\protected@edef,\ProvidesFile,\psframe,\psline,\psset,\pst@number,\psxunit}
\DoNotIndex{\par,\parfillskip,\parindent,\PassOptionsToPackage,\pgfmathsetlengthmacro}

\DoNotIndex{\relax,\RequirePackage,\raggedright,\renewcommand,\rlap,\rput,\rule}

\DoNotIndex{\setbox,\setkeys,\setlength,\SetupKeyvalOptions,\splitmaxdepth,\splittopskip,\stepcounter,\strutbox}
\DoNotIndex{\setbool,\settoggle,\space,\string}

\DoNotIndex{\textwidth,\the,\thempfn,\thempfootnote,\topsep,\trivlist,\tw@,\tikzset}

\DoNotIndex{\unskip,\unvbox}

\DoNotIndex{\value,\vbox,\vfill,\vsize,\vskip,\vsplit}

\DoNotIndex{\width,\wd}

\DoNotIndex{\xifinlist}

\DoNotIndex{\z@,\z@skip,\zref@addprop,\zref@extract,\zref@label,\zref@newprop,\zref@refused,\ZREF@mainlist}

\IndexPrologue{\section*{Index}%
                 \markboth{Index}{Index}The index only collect package relevant words.}
%\DoNotIndex{\newrobustcmd,\DeclareBoolOption,\DeclareListParser,\deflength}
%\DoNotIndex{\z@,\@ne,\@M}
%\DoNotIndex{\define@key}
%\DoNotIndex{\@nil,\dimen@,\dimen@i}
%\DoNotIndex{\@mpfn,\@mpfootins,\@mpfootnotetext,\c@mpfootnote}
%\DoNotIndex{\advance,\begingroup,\ifx,\fi,\else,\@plus,\@height,\@width,\dp,\ht,\wd}
%\DoNotIndex{\closeout,\day,\def,\edef,\else,\empty,\endgroup,\csname,\endcsname,\endinput}
%\DoNotIndex{\def,\long,\edef,\xdef,\gdef,\let,\global}
%\DoNotIndex{\if,\ifnum,\ifdim,\ifcat,\ifmmode,\ifvmode,\ifhmode,%
%            \iftrue,\iffalse,\ifvoid,\ifx,\ifeof,\ifcase,\else,\or,\fi}
%\DoNotIndex{\box,\copy,\setbox,\unvbox,\unhbox,\hbox,%
%            \vbox,\vtop,\vcenter}
%\DoNotIndex{\@empty,\immediate,\write}
%\DoNotIndex{\egroup,\bgroup,\expandafter,\begingroup,\endgroup}
%\DoNotIndex{\divide,\advance,\multiply,\count,\dimen}
%\DoNotIndex{\relax,\space,\string}
%\DoNotIndex{\csname,\endcsname,\@spaces,\openin,\openout,%
%            \closein,\closeout}
%\DoNotIndex{\catcode,\endinput}
%\DoNotIndex{\jobname,\message,\read,\the,\m@ne,\noexpand}
%\DoNotIndex{\hsize,\vsize,\hskip,\vskip,\kern,\hfil,\hfill,\hss}
%\DoNotIndex{\m@ne,\z@,\z@skip,\@ne,\tw@,\p@}
%\DoNotIndex{\dp,\wd,\ht,\vss,\unskip}

\def\macro#1{%
     \MakePrivateLetters
   \topsep\MacroTopsep \trivlist
   \edef\saved@macroname{#1}%
   \def\makelabel##1{\makebox[0pt][l]{\kern-2em ##1}}%
   \if@inlabel
    \let\@tempa\@empty \count@\macro@cnt
    \loop \ifnum\count@>\z@
      \edef\@tempa{\@tempa\hbox{\strut}}\advance\count@\m@ne \repeat
    \edef\makelabel##1{\llap{\vtop to\baselineskip
                               {\@tempa\hbox{##1}\vss}}}%
    \advance \macro@cnt \@ne
   \else  \macro@cnt\@ne  \fi
    \toks@={\@gobble}%
    \@for\next:=#1\do
      {\toks@=\expandafter{\the\expandafter\toks@%
                           \expandafter\\%
                           \expandafter\PrintMacroName\expandafter{\next}}}%
   \item[\fbox{\begin{tabular}{@{\textbackslash}>{}l}
                \the\toks@
               \end{tabular}}]%
   \leavevmode\par\kern\MacroTopsep\noindent\ignorespaces
   \global\advance\c@CodelineNo\@ne
   \@for\next:=#1\do
       {%
       \expandafter\SpecialMainIndex\expandafter{\next}\nobreak
       \expandafter\DoNotIndex\expandafter{\next}}%
  \global\advance\c@CodelineNo\m@ne
  \ignorespaces}



%Anweisung zur Darstellung
\newcommand*\Opt[1]{{\MacroFont #1}\xspace}
\newcommand*\Env[1]{{\MacroFont #1}\xspace}
\newcommand*\Cmd[1]{{\MacroFont\textbackslash  #1}\xspace}
\newcommand*\Pack[1]{\texttt{#1}\xspace}

\newcommand*\ExplCmd[2][]{%
    \par\kern\baselineskip%
    \noindent\makebox[0pt][l]{\kern-2em%
                              \@bsphack
                              \MacroFont\textbackslash #2%
                              \SpecialUsageIndex{#2}%
                              \@esphack
                            }%
    \hfill\mbox{%
        \ifx\relax#1\relax
           \space
        \else
         {\small default=\ttfamily #1}
        \fi
      }%
    \par\kern.5ex\noindent\ignorespaces
   }
\newcommand*\ExplEnv[2][]{%
    \par\kern\baselineskip%
    \noindent\makebox[0pt][l]{\kern-2em%
                              \@bsphack
                              \MacroFont #2%
                              \SpecialEnvIndex{#2}%
                              \@esphack
                            }%
    \hfill\mbox{%
        \ifx\relax#1\relax
           \space
        \else
         {\small default=\ttfamily #1}
        \fi
      }%
    \par\kern.5ex\noindent\ignorespaces
   }

\def\SpecialOptIndex#1{\@bsphack
    \index{#1\actualchar{\protect\ttfamily#1}
           (option)\encapchar usage}%
    \index{options:\levelchar#1\actualchar{\protect\ttfamily#1}\encapchar
           usage}\@esphack}
\newcommand*\ExplOpt[2][]{%
    \par\kern\baselineskip%
    \noindent\makebox[0pt][l]{\kern-2em%
                              \@bsphack
                              \MacroFont #2%
                              \SpecialOptIndex{#2}%
                              \@esphack
                            }%
    \hfill\mbox{%
        \ifx\relax#1\relax
           \space
        \else
         {\small default=\ttfamily #1}
        \fi
      }%
    \par\kern.5ex\noindent\ignorespaces
   }

% % \newcommand*\mdoption[1]{\textsf{\color{ltxmdfblue}#1}}
% % \newcommand*\mdname{\textsf{mdframed}\xspace}
% % \newcommand*\mdpack[1]{\texttt{#1}\xspace}
% % \newcommand*\mdsetting[1]{\textsf{#1}\xspace}
% % \newcommand*\mdcommand[1]{\texttt{\textbackslash #1}\xspace}
% % 
% % \newcommand*\mdDescribeMacro[2][]{\par\kern\baselineskip%
% %                                    \noindent\makebox[0pt][l]{\kern-2em%
% %                                    \textsf{\bfseries\color{ltxmdfblue}#2}%
% %                                    }\hfill\mbox{\mdDefault{#1}}\par\kern.5ex\noindent\ignorespaces}
% % \newcommand*{\mdDefault}[1]{%
% %  \ifx\relax#1\relax\else{\small\mdsetting{default=#1}}\fi}
% % 
% % \newcommand*\mdDescribeCmd[2][]{\par\kern\baselineskip%
% %                                    \noindent\makebox[0pt][l]{\kern-2em%
% %                                    \textsf{\bfseries\color{ltxmdfblue}\textbackslash #2}%
% %                                    }{#1}\hfill\mbox{\mdDefault{#1}}\par\kern.5ex\noindent\ignorespaces}


\newcommand\NOTE{\minisec{Note}}

\newcommand\limitation[1][TikZ]{\newline{\small This works only with \Opt{framemethod=#1}.}}





