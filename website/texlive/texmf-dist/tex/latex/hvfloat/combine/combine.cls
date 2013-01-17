%%
%% This is file `combine.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% combine.dtx  (with options: `usc')
%% 
%%   Author: Peter Wilson, Herries Press
%%   Maintainer: Will Robertson (will dot robertson at latex-project dot org)
%%   Copyright 2000, 2001, 2002, 2003 Peter R. Wilson
%%   Copyright 2010 Will Robertson
%% 
%%   This work may be distributed and/or modified under the
%%   conditions of the LaTeX Project Public License, either
%%   version 1.3c of this license or (at your option) any
%%   later version: <http://www.latex-project.org/lppl.txt>
%% 
%%   This work has the LPPL maintenance status "maintained".
%%   The Current Maintainer of this work is Will Robertson.
%% 
%%   This work consists of the files listed in the README file.
%% 
\ProvidesClass{combine}
  [2010/07/10 v0.7a
              collection of documents
  ]
\RequirePackage{keyval}
\newcommand{\c@lclass}{article}
\define@key{COLCLASS}{colclass}[article]%
           {\renewcommand{\c@lclass}{#1}
            \ClassWarningNoLine{combine}
                               {Expect warnings like:\MessageBreak
            \space\space LaTeX Warning: Unused global option(s):\MessageBreak
            \space\space\space\space [colclass=#1]}}
\let\c@l@tempa\@empty
\def\c@l@getoptionname#1=#2\@nil{#1}
\@for\CurrentOption:=\@classoptionslist\do{%
  \@ifundefined{%
    KV@COLCLASS@\expandafter\c@l@getoptionname\CurrentOption=\@nil
  }%
  {%  other options
  }{%
    \edef\c@l@tempa{\c@l@tempa,\CurrentOption,}%
  }%
}%
\edef\c@l@tempa{%
  \noexpand\setkeys{COLCLASS}{\c@l@tempa}%
}
\c@l@tempa

\newif\ifc@lclasses
  \c@lclassesfalse
\newif\ifc@lpackages
  \c@lpackagesfalse
\newif\ifc@llayouts
  \c@llayoutsfalse
\newif\ifc@lfolios
  \c@lfoliosfalse
\newif\ifc@lnotoc
  \c@lnotocfalse
\newif\ifc@lnolof
  \c@lnoloffalse
\newif\ifc@lnolot
  \c@lnolotfalse
\newif\ifc@lmaintoc
  \c@lmaintocfalse
\newif\ifc@lnodate
  \c@lnodatetrue
\newif\ifc@lnoauthor
  \c@lnoauthorfalse
\newif\ifc@lnotitle
  \c@lnotitlefalse
\newif\ifc@lnomaketitle
  \c@lnomaketitlefalse
\newif\ifc@lnopubindoc
  \c@lnopubindocfalse
\newif\ifc@lnopubintoc
  \c@lnopubintocfalse
\newif\ifc@lonebib
  \c@lonebibfalse
\newif\ifc@lcombib
  \c@lcombibfalse

\DeclareOption{book}{\def\c@lclass{book}}
\DeclareOption{report}{\def\c@lclass{report}}
\DeclareOption{letter}{\def\c@lclass{letter}}
\DeclareOption{memoir}{\def\c@lclass{memoir}}
\DeclareOption{classes}{\c@lclassestrue}
\DeclareOption{packages}{\c@lpackagestrue}
\DeclareOption{layouts}{\c@llayoutstrue}
\DeclareOption{folios}{\c@lfoliostrue}
\DeclareOption{notoc}{\c@lnotoctrue}
\DeclareOption{nolof}{\c@lnoloftrue}
\DeclareOption{nolot}{\c@lnolottrue}
\DeclareOption{maintoc}{\c@lmaintoctrue}
\DeclareOption{date}{\c@lnodatefalse}
\DeclareOption{noauthor}{\c@lnoauthortrue}
\DeclareOption{notitle}{\c@lnotitletrue}
\DeclareOption{nomaketitle}{\c@lnomaketitletrue}
\DeclareOption{nopubindoc}{\c@lnopubindoctrue}
\DeclareOption{nopubintoc}{\c@lnopubintoctrue}
\DeclareOption{onebib}{\c@lonebibtrue}
\DeclareOption{combinedbib}{\c@lcombibtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\c@lclass}}
\ProcessOptions\relax
\ifc@lcombib
  \c@lonebibtrue
\fi

\LoadClass{\c@lclass}

\newif\ifc@lhaschapter
  \c@lhaschapterfalse
\@ifundefined{chapter}{}{\c@lhaschaptertrue}

\@ifundefined{if@titlepage}{\newif\if@titlepage\@titlepagefalse}{}
\newif\ifc@ltoctitle
  \c@ltoctitlefalse
\newif\ifc@ltocauthor
  \c@ltocauthorfalse
\newif\ifc@lpub
  \c@lpubfalse

\newcounter{colpage} \setcounter{colpage}{1}
  \renewcommand{\thecolpage}{\arabic{colpage}}
\newcounter{c@lctr}
\@ifundefined{c@section}{\newcounter{section}}{}

\newwrite\c@ltocfnum
\newwrite\c@lloffnum
\newwrite\c@llotfnum

\def\provideenvironment{%
  \@star@or@long\c@lprovide@environment}
\def\c@lprovide@environment#1{%
  \@ifundefined{#1}{%
    \expandafter\let\csname#1\endcsname\relax
    \expandafter\let\csname end#1\endcsname\relax
    \new@environment{#1}}{\c@lenvironment{#1}}
}
\def\c@lenvironment#1{%
  \@testopt{\c@lenva#1}0}
\def\c@lenva#1[#2]{%
  \@ifnextchar [{\c@lenvb#1[#2]}{\c@lthrowenv{#1}{[#2]}}}
\def\c@lenvb#1[#2][#3]{\c@lthrowenv{#1}{[#2][#3]}}
\def\c@lthrowenv#1#2#3#4{}

\@ifundefined{newtheorem}{}{%
  \newcommand{\c@lnamethm}[3]{%
    \@namedef{#1}{\@thm{#2}{#3}}%
    \@namedef{end#1}{\@endtheorem}}
  \def\@xnthm#1#2[#3]{%
    \expandafter\@ifdefinable\csname #1\endcsname
      {\@definecounter{#1}\@newctr{#1}[#3]%
       \expandafter\xdef\csname the#1\endcsname{%
         \expandafter\noexpand\csname the#3\endcsname \@thmcountersep
           \@thmcounter{#1}}%
       \c@lnamethm{#1}{#1}{#2}}}
  \def\@ynthm#1#2{%
    \expandafter\@ifdefinable\csname #1\endcsname
      {\@definecounter{#1}%
       \expandafter\xdef\csname the#1\endcsname{\@thmcounter{#1}}%
       \c@lnamethm{#1}{#1}{#2}}}
  \def\@othm#1[#2]#3{%
    \@ifundefined{c@#2}{\@nocounterr{#2}}%
      {\expandafter\@ifdefinable\csname #1\endcsname
       {\@namedef{the#1}{\@nameuse{the#2}}
       \c@lnamethm{#1}{#2}{#3}}}}
}

\providecommand{\providelength}[1]{%
  \ifx #1\undefined
    \newlength{#1}
  \fi
}
\providecommand{\providecounter}[1]{%
  \expandafter\ifx \csname c@#1\endcsname \undefined
    {\@definecounter{#1}}%
    \@ifnextchar[{\@newctr{#1}}{}
  \else
    \@ifnextchar[{\c@l@gobbleoptarg}{}
  \fi
}

\def\c@l@gobbleoptarg[#1]{}

\providecommand{\appendiargdef}[2]{\begingroup
  \toks@\expandafter{#1{##1}#2}%
  \edef\@bsx{\endgroup \def\noexpand#1####1{\the\toks@}}%
  \@bsx}

\ifc@lclasses
  \newcommand\c@lbdocumentclass{%
    \makeatletter                           %% added
    \let\newcommand\providecommand          %% added
    \let\newenvironment\provideenvironment  %% added
%%    \let\documentclass\@twoclasseserror
%%    \if@compatability\else\let\usepackage\RequirePackage\fi
    \@fileswithoptions\@clsextension
  }
\else
  \newcommand{\c@lbdocumentclass}[2][\@empty]{%
    \makeatletter
  }
\fi

\ifc@lpackages\else
  \newcommand{\c@lbusepackage}[2][\@empty]{}
\fi

\newcommand{\c@lbLoadClass}{%
  \ifx\@currext\@pkgextension
    \@latex@error{\noexpand\LoadClass in package file}%
      {You may only use \noexpand\LoadClass in a class file.}%
  \fi
  \@fileswithoptions\@clsextension}

\newcommand{\c@ltextblock}{%
  \@colht\textheight
  \@colroom\textheight \vsize\textheight
  \columnwidth\textwidth
  \@clubpenalty\clubpenalty
  \if@twocolumn
    \advance\columnwidth -\columnsep
    \divide\columnwidth\tw@ \hsize\columnwidth \@firstcolumntrue
  \fi
  \hsize\columnwidth \linewidth\hsize
}

\newcommand{\c@ladocument}{%
  \endgroup
  \let\mainjobname\jobname            %% added
  \def\c@lmainauxfile{\jobname.aux}   %% added
  \ifx\@unusedoptionlist\@empty\else
    \@latex@warning@no@line{Unused global option(s):^^J%
           \@spaces[\@unusedoptionlist]}%
  \fi
  \c@ltextblock                       %% a replacement
  \begingroup\@floatplacement\@dblfloatplacement
    \makeatletter\let\@writefile\@gobbletwo
    \global \let \@multiplelabels \relax
    \@input{\c@lmainauxfile}%                   %% changed
  \endgroup
  \if@filesw
    \immediate\openout\@mainaux\c@lmainauxfile  %% changed
    \immediate\write\@mainaux{\relax}%
  \fi
  \process@table
  \let\glb@currsize\@empty
  \normalsize
  \everypar{}%
  \ifx\normalsfcodes\@empty
    \ifnum\sfcode`\.=\@m
      \let\normalsfcodes\frenchspacing
    \else
      \let\normalsfcodes\nonfrenchspacing
    \fi
  \fi
  \@noskipsecfalse
  \g@addto@macro{\@outputpage}{\stepcounter{colpage}}  %% added
  \let\maketitle\c@lamaketitle                         %% added
  \@ifundefined{c@chapter}%            %% added
    {\@ifundefined{c@section}{}{\let\c@lthesec\thesection}}%
    {\let\c@lthechap\thechapter}
  \let \@refundefined \relax
  \let\AtBeginDocument\@firstofone
  \@begindocumenthook
  \ifdim\topskip<1sp\global\topskip 1sp\relax\fi
  \global\@maxdepth\maxdepth
%%  \global\let\@begindocumenthook\@undefined
  \ifx\@listfiles\@undefined
    \global\let\@filelist\relax
    \global\let\@addtofilelist\@gobble
  \fi
%%  \gdef\do##1{\global\let ##1\@notprerr}%
%%  \@preamblecmds
  \global\let \@nodocument \relax
  \global\let\do\noexpand
  \ignorespaces}

\newcommand{\c@lbdocument}{%
%%  \endgroup
%%  \ifx\@unusedoptionlist\@empty\else
%%    \@latex@warning@no@line{Unused global option(s):^^J%
%%           \@spaces[\@unusedoptionlist]}%
%%  \fi
  \ifc@llayouts            %% layouts option
    \c@ltextblock
  \fi
  \begingroup\@floatplacement\@dblfloatplacement
    \makeatletter \let\@writefile\@gobbletwo
%%    \global \let \@multiplelabels \relax
    \@input{\c@lauxfile}%
  \endgroup
  \if@filesw
    \immediate\openout\@partaux\c@lauxfile
    \immediate\write\@partaux{\relax}%
  \fi
  \process@table
  \let\glb@currsize\@empty
  \normalsize
  \everypar{}%
  \@noskipsecfalse
%%  \let \@refundefined \relax
  \let\AtBeginDocument\@firstofone
  \@begindocumenthook
  \ifdim\topskip<1sp\global\topskip 1sp\relax\fi
  \global\@maxdepth\maxdepth
%%  \global\let\@begindocumenthook\@undefined
  \ifx\@listfiles\@undefined
    \global\let\@filelist\relax
    \global\let\@addtofilelist\@gobble
  \fi
%%  \gdef\do##1{\global\let ##1\@notprerr}%
%%  \@preamblecmds
  \global\let \@nodocument \relax
  \global\let\do\noexpand
  \let\ps@plain\c@lbps@plain   %% set pagestyle
%%  \pagestyle{plain}
  \ifc@lfolios                 %% folios option initialises page number
    \setcounter{page}{1}
  \fi
  \ifc@lhaschapter             %% set chapter/section number
    \setcounter{c@lctr}{\value{chapter}}
    \setcounter{chapter}{0}
  \else
    \setcounter{c@lctr}{\value{section}}
    \setcounter{section}{0}
  \fi
  \c@lresetcounters            %% added
  \makeatother                 %% added
  \ignorespaces}

\newcommand{\c@lresetcounters}{%
  \@ifundefined{c@figure}{}{\setcounter{figure}{0}}
  \@ifundefined{c@table}{}{\setcounter{table}{0}}
  \@ifundefined{c@equation}{}{\setcounter{equation}{0}}
  \@ifundefined{c@footnote}{}{\setcounter{footnote}{0}}
  \@ifundefined{c@chapter}%
    {\@ifundefined{c@section}{}{\renewcommand{\thesection}{\c@lthesec}}}%
    {\renewcommand{\thechapter}{\c@lthechap}}
  \zeroextracounters
}
\newcommand{\zeroextracounters}{}

\newcommand{\c@lenddoca}{%
    \@dofilelist
    \ifdim \font@submax >\fontsubfuzz\relax
      \@font@warning{Size substitutions with differences\MessageBreak
                 up to \font@submax\space have occured.\@gobbletwo}%
    \fi
    \@defaultsubs
%%    \@refundefined
    \if@filesw
      \ifx \@multiplelabels \relax
        \if@tempswa
          \@latex@warning@no@line{Label(s) may have changed.
              Rerun to get cross-references right}%
        \fi
      \else
        \@multiplelabels
      \fi
    \fi
}

\newcommand{\c@laenddocument}{%
  \@enddocumenthook
  \@checkend{document}%
  \clearpage
  \begingroup
    \if@filesw
      \immediate\closeout\@mainaux
      \immediate\closeout\@partaux
      \let\@setckpt\@gobbletwo
      \let\@newl@bel\@testdef
      \@tempswafalse
      \makeatletter \input\c@lmainauxfile  %% change here
    \fi
    \c@lenddoca                            %% a replacement
    \@refundefined
  \endgroup
  \deadcycles\z@\@@end}

\newcommand{\c@lbenddocument}{%
  \@enddocumenthook
  \@checkend{document}%
  \clearpage
  \begingroup
    \if@filesw
      \immediate\closeout\@partaux   %% change here
      \let\@setckpt\@gobbletwo
      \let\@newl@bel\@testdef
      \@tempswafalse
      \makeatletter \input\c@lauxfile  %% change here
    \fi
    \c@lenddoca                        %% a replacement
%%    \@refundefined
  \endgroup
  \deadcycles\z@  %%\@@end     %% \@@end will close *all* files
  \c@lclosetocs                %% close local files
  \ifc@lhaschapter             %% reset chap/sec and page numbering
    \setcounter{chapter}{\value{c@lctr}}
    \gdef\thechapter{\c@lthechap}
    \gdef\@chapapp{\chaptername}
  \else
    \setcounter{section}{\value{c@lctr}}
    \gdef\thesection{\c@lthesec}
  \fi
  \setcounter{page}{\value{colpage}}
  \pagestyle{\c@lastyle}
  \erasetitling                %% no \coltoc... or \published commands defined
%%  \let\@auxout\@mainaux
  \gdef\jobname{\mainjobname}  %% swap back to main document file name
  \endinput                    %% ignore any text after \end{document}
}

\newcommand{\maintitlefont}{\begin{center}\LARGE}
\newcommand{\postmaintitle}{\par\end{center}\vskip 0.5em}
\newcommand{\mainauthorfont}{\begin{center}
  \large \lineskip .5em%
  \begin{tabular}[t]{c}}
\newcommand{\postmainauthor}{\end{tabular}\par\end{center}}
\newcommand{\maindatefont}{\begin{center}\large}
\newcommand{\postmaindate}{\par\end{center}}

\if@titlepage
  \newcommand{\c@lamaketitle}{\begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \null\vfil
    \vskip 60\p@
    {\maintitlefont \@title \postmaintitle}
    {\mainauthorfont \@author \postmainauthor}
    {\maindatefont \@date \postmaindate}
    \par
    \@thanks
    \vfil\null
    \end{titlepage}%
    \setcounter{footnote}{0}%
    \c@lmtitlempty                %% change here
  } % end titlepage defs
\else
  \newcommand{\c@lamaketitle}{\par
    \begingroup
      \c@lmtitle                   %% change here
    \endgroup
    \setcounter{footnote}{0}%
    \c@lmtitlempty                 %% change here
  } % end non-titlepage


  \def\@maketitle{%
    \newpage
    \null
    \vskip 2em%
    {\maintitlefont \@title \postmaintitle}
    {\mainauthorfont \@author \postmainauthor}
    {\maindatefont \@date \postmaindate}
    \par
    \vskip 1.5em}
\fi    % end mod A of titling

\newcommand{\c@lmtitle}{%
  \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
  \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
  \long\def\@makefntext##1{\parindent 1em\noindent
    \hb@xt@1.8em{%
      \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
  \if@twocolumn
    \ifnum \col@number=\@ne
      \@maketitle
    \else
      \twocolumn[\@maketitle]%
    \fi
  \else
    \newpage
    \global\@topnum\z@
    \@maketitle
  \fi
  \thispagestyle{plain}\@thanks
}

  \newcommand{\c@lbmaketitle}{\par
    \begingroup
      \let\newpage\relax
      \let\@maketitle\c@lb@maketitle
      \c@lmtitle
    \endgroup
    \setcounter{footnote}{0}%
    \c@lmtitlempty
  }

\newcommand{\c@lmtitlempty}{%
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
}
\newcommand{\importtitlefont}{\begin{center}\LARGE\bfseries}
\newcommand{\postimporttitle}{\par\end{center}}
\newcommand{\importauthorfont}{\begin{center}
  \large\itshape \lineskip .5em%
  \begin{tabular}[t]{c}}
\newcommand{\postimportauthor}{\end{tabular}\par\end{center}}
\newcommand{\importdatefont}{\begin{center}\large}
\newcommand{\postimportdate}{\par\end{center}}

\newcommand{\c@lb@maketitle}{%
%%  \newpage
  \begingroup
    \let\footnote\thanks
    \null
    \vskip 2em%
    \ifc@lnotitle\else
      {\importtitlefont \@title \postimporttitle}
    \fi
    \ifc@lnoauthor\else
      {\importauthorfont \@author \postimportauthor}
    \fi
    \ifc@lnodate\else
      {\importdatefont \@date \postimportdate}%
    \fi
    \par
  \endgroup
}

\newcommand{\c@lb@starttoc}[1]{%
  \begingroup
    \makeatletter
    \def\tocfname{\jobname.#1}
    \@input{\tocfname}%
    \if@filesw
      \def\c@ltempa{#1} \def\c@ltempb{toc}
      \ifx \c@ltempa \c@ltempb
         \immediate\openout\c@ltocfnum \tocfname\relax
      \else
        \def\c@ltempb{lof}
        \ifx \c@tempa \c@ltempb
          \immediate\openout\c@lloffnum \tocfname\relax
        \else
          \def\c@ltempb{lot}
          \ifx \c@tempa \c@ltempb
            \immediate\openout\c@llotfnum \tocfname\relax
          \else
            \expandafter\newwrite\csname c@l#1fnum\endcsname
            \immediate\openout\csname c@l#1fnum\endcsname \tocfname\relax
          \fi
        \fi
      \fi
    \fi
    \@nobreakfalse
  \endgroup}

\newcommand{\c@lb@writefile}[2]{%
  \def\tocfname{\jobname.#1}
  \IfFileExists{\tocfname}
    {\@temptokena{#2}%
     \immediate\write\csname c@l#1fnum\endcsname{\the\@temptokena}}
    {}
}

\newcommand{\c@lclosetocs}{%
  \immediate\closeout\c@ltocfnum
  \immediate\closeout\c@lloffnum
  \immediate\closeout\c@llotfnum
}

\newcommand{\c@ltocgobble}{%
  \let\label\@gobble \let\index\@gobble \let\glossary\@gobble}

\newcommand{\c@laaddtocontents}[2]{%
  \protected@write\@mainaux
    {\c@ltocgobble}%
    {\string\@writefile{#1}{#2}}
}
\newcommand{\c@laaddcontentsline}[3]{%
  \c@laaddtocontents{#1}{\protect\contentsline{#2}{#3}{\thecolpage}}
}

\ifc@lmaintoc
  \newcommand{\c@lbaddtocontents}[2]{%
    \protected@write\@auxout
      {\c@ltocgobble}%
      {\string\@writefile{#1}{#2}}
    \ifx\@mainaux\@auxout\else    %% prevent writing twice to mainaux
      \protected@write\@mainaux
        {\c@ltocgobble}%
        {\string\@writefile{#1}{\protect\begin{tocindent}{\toctocindent}}}
      \protected@write\@mainaux
        {\c@ltocgobble}%
        {\string\@writefile{#1}{#2}}
      \protected@write\@mainaux
        {\c@ltocgobble}%
        {\string\@writefile{#1}{\protect\end{tocindent}}}
    \fi
  }
\fi

\newcommand{\c@lblabel}[1]{\@bsphack
  \protected@write\@auxout{}%
    {\string\newlabel{#1}{{\@currentlabel}{\thecolpage}}}%
  \@esphack}
\newcommand{\c@lb@setref}[3]{%
  \ifx#1\relax
    \protect\G@refundefinedtrue
    \nfss@text{\reset@font\bfseries ??}%
    \@latex@warning{Reference `#3' on page \thecolpage \space
                    undefined}%
  \else
    \expandafter#2#1\null
  \fi}

\newcommand{\c@lbnewlabel}{\@newl@bel{R?\jobname?}}
\newcommand{\c@lbref}[1]{\expandafter\@setref\csname R?\jobname?@#1\endcsname
               \@firstoftwo{#1}}
\newcommand{\c@lbpageref}[1]{\expandafter\@setref\csname R?\jobname?@#1\endcsname
               \@secondoftwo{#1}}

\newcommand{\c@lwritemainbib}{%
     \if@filesw\immediate\write\@mainaux{\string\citation{\@citeb}}\fi
     \@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
      \G@refundefinedtrue
      \@latex@warning
        {Citation `\@citeb' on page \thecolpage \space undefined}}%
      {\hbox{\csname b@\@citeb\endcsname}}}
\newcommand{\c@lwritelocalbib}{%
     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
     \@ifundefined{B?\jobname?@\@citeb}{\mbox{\reset@font\bfseries ?}%
      \G@refundefinedtrue
      \@latex@warning
        {Citation `\@citeb' on page \thecolpage \space undefined}}%
      {\hbox{\csname B?\jobname?@\@citeb\endcsname}}}

\newcommand{\c@lanocite}[1]{\@bsphack
  \@for\@citeb:=#1\do{%
    \edef\@citeb{\expandafter\@firstofone\@citeb}%
    \if@filesw\immediate\write\@mainaux{\string\citation{\@citeb}}\fi
    \@ifundefined{b@\@citeb}{\G@refundefinedtrue
      \@latex@warning{Citation `\@citeb' undefined}}{}}%
  \@esphack}
\let\nocite\c@lanocite

\newcommand{\c@lbnocite}[1]{\@bsphack
  \@for\@citeb:=#1\do{%
    \edef\@citeb{\expandafter\@firstofone\@citeb}%
    \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
    \@ifundefined{B?\jobname?@\@citeb}{\G@refundefinedtrue
      \@latex@warning{Citation `\@citeb' undefined}}{}}%
  \@esphack}

\def\c@lb@citex[#1]#2{%
  \ifc@lcombib
    \c@lanocite{#2}%
  \fi
  \let\@citea\@empty
  \@cite{\@for\@citeb:=#2\do
    {\@citea\def\@citea{,\penalty\@m\ }%
     \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
     \ifc@lcombib
       \c@lwritelocalbib
     \else
       \ifc@lonebib
         \c@lwritemainbib
       \else
         \c@lwritelocalbib
       \fi
     \fi}}{#1}}

\ifc@lonebib
  \newcommand{\c@lbbibcite}{\@newl@bel b}
  \ifc@lcombib
    \renewcommand{\c@lbbibcite}{\@newl@bel{B?\jobname?}}
  \fi
\else
  \newcommand{\c@lbbibcite}{\@newl@bel{B?\jobname?}}
\fi

\newcommand{\c@lapagestyle}[1]{%
  \gdef\c@lastyle{#1}
  \@ifundefined{ps@#1}{}{\@nameuse{ps@#1}}
}
\newcommand{\c@lbpagestyle}[1]{%
  \@ifundefined{ps@#1}{}{\@nameuse{ps@#1}}
}

\ifc@lfolios
  \newcommand{\c@lbpagenumbering}[1]{%
    \global\c@page \@ne \gdef\thepage{\csname @#1\endcsname
      \c@page}}
\else
  \newcommand{\c@lbpagenumbering}[1]{}
\fi

\if@twoside
  \newcommand{\c@laps@plain}{%
    \let\@mkboth\@gobbletwo
    \let\@oddhead\@empty \let\@evenhead\@empty
    \def\@oddfoot{\reset@font\hfil\thepage}%
    \def\@evenfoot{\reset@font\thepage\hfil}%
  }
  \ifc@lfolios
    \newcommand{\c@lbps@plain}{%
      \let\@mkboth\@gobbletwo
      \let\@oddhead\@empty \let\@evenhead\@empty
      \def\@oddfoot{\reset@font(\thepage)\hfil\thecolpage}%
      \def\@evenfoot{\reset@font\thecolpage\hfil(\thepage)}%
    }
  \else
    \newcommand{\c@lbps@plain}{%
      \let\@mkboth\@gobbletwo
      \let\@oddhead\@empty \let\@evenhead\@empty
      \def\@oddfoot{\reset@font\hfil\thecolpage}%
      \def\@evenfoot{\reset@font\thecolpage\hfil}%
    }
  \fi
\else
  \newcommand{\c@laps@plain}{%
    \let\@mkboth\@gobbletwo
    \let\@oddhead\@empty \let\@evenhead\@empty
    \def\@oddfoot{\reset@font\hfil\thepage}%
    \let\@evenfoot\@oddfoot
  }
  \ifc@lfolios
    \newcommand{\c@lbps@plain}{%
      \let\@mkboth\@gobbletwo
      \let\@oddhead\@empty \let\@evenhead\@empty
      \def\@oddfoot{\reset@font(\thepage)\hfil\thecolpage}%
      \let\@evenfoot\@oddfoot
    }
  \else
    \newcommand{\c@lbps@plain}{%
      \let\@mkboth\@gobbletwo
      \let\@oddhead\@empty \let\@evenhead\@empty
      \def\@oddfoot{\reset@font\hfil\thecolpage}%
      \let\@evenfoot\@oddfoot
    }
  \fi
\fi

\if@twoside
  \newcommand{\ps@combine}{%
    \let\@mkboth\@gobbletwo
    \let\@oddhead\@empty \let\@evenhead\@empty
    \def\@oddfoot{\reset@font\hfil\thepage}%
    \def\@evenfoot{\reset@font\thepage\hfil}%
    \let\ps@plain\c@laps@plain
  }
\else
  \newcommand{\ps@combine}{%
    \let\@mkboth\@gobbletwo
    \let\@oddhead\@empty \let\@evenhead\@empty
    \def\@oddfoot{\reset@font\hfil\thepage}%
    \let\@evenfoot\@oddfoot
    \let\ps@plain\c@laps@plain
  }
\fi

\newcommand{\import}[1]{%
  \ifc@ltoctitle
    \addtocontents{toc}{\protect\contentsline{coltoctitle}%
      {\protect\numberline{}\savec@ltoctitle}{\thecolpage}}
    \c@ltoctitlefalse
  \fi
  \ifc@ltocauthor
    \addcontentsline{toc}{coltocauthor}{\protect\numberline{}\savec@ltocauthor}
    \c@ltocauthorfalse
  \fi
  \ifc@lpub
    \addcontentsline{toc}{published}{\protect\numberline{}\savec@lpublished}
    \c@lpubfalse
  \fi
  \gdef\jobname{#1}
  \expandafter\let\csname B?\jobname?@*\endcsname\@empty
  \gdef\c@lauxfile{#1.aux}
  \@tempswatrue
  \let\@auxout\@partaux
  \@input@{#1.tex}%
%%  \@writeckpt{#1}%
  \let\@auxout\@mainaux
}

\newcommand*\bodytitlemark[1]{}
\newcounter{bodytitle}
\renewcommand{\thebodytitle}{\@arabic\c@bodytitle}
\ifc@lhaschapter
  \newcommand{\bodytitle}{\@startsection{bodytitle}{0}{\z@}%
                                        {-3.5ex \@plus -1ex \@minus -.2ex}%
                                        {2.3ex \@plus.2ex}%
                                        {\normalfont\Huge\bfseries}}
\else
  \newcommand{\bodytitle}{\@startsection{bodytitle}{1}{\z@}%
                                        {-3.5ex \@plus -1ex \@minus -.2ex}%
                                        {2.3ex \@plus.2ex}%
                                        {\normalfont\Large\bfseries}}
\fi

\newcommand{\c@ll@chapseci}{%
  \setlength\@tempdima{0em}%
  \begingroup
    \parindent \z@ \rightskip \@pnumwidth
    \parfillskip -\@pnumwidth
    \leavevmode
}
\newcommand{\c@ll@chapsecii}[2]{%
  \advance\leftskip\@tempdima
  \hskip -\leftskip
  #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
}

\ifc@lhaschapter
  \newcommand*\l@bodytitle[2]{%  % as per chapter
    \ifnum \c@tocdepth >\m@ne
      \addpenalty{-\@highpenalty}%
      \addvspace{1.0em \@plus\p@}%
      \c@ll@chapseci
      \bfseries                    %% bold ToC entry
      \c@ll@chapsecii{#1}{#2}
      \penalty\@highpenalty
      \endgroup
    \fi}
\else
  \newcommand*\l@bodytitle[2]{%  % as per section
    \ifnum \c@tocdepth >\z@
      \addpenalty\@secpenalty
      \addvspace{1.0em \@plus\p@}%
      \c@ll@chapseci
      \bfseries                    %% bold ToC entry
      \c@ll@chapsecii{#1}{#2}
      \endgroup
    \fi}
\fi

\newlength{\toctitleindent}\setlength{\toctitleindent}{0pt}
\newlength{\tocauthorindent}\setlength{\tocauthorindent}{1.5em}
\newlength{\tocpubindent}\setlength{\tocpubindent}{1.5em}
\newlength{\toctocindent}\setlength{\toctocindent}{1.5em}

\newenvironment{tocindent}[1]{%
  \hangindent #1 \hangafter -100\relax}{}

\newcommand{\toctitlefont}{\bfseries}
\newcommand{\tocauthorfont}{\itshape}
\newcommand{\tocpubfont}{\normalfont}

\newcommand*{\coltoctitle}[1]{%
  \c@ltoctitletrue%
  \gdef\savec@ltoctitle{#1}
}

\ifc@lhaschapter
  \newcommand*\l@coltoctitle[2]{%  % as per chapter
    \ifnum \c@tocdepth >\m@ne
      \addpenalty{-\@highpenalty}% encourage page break
      \addvspace{1.0em \@plus\p@}%
      \c@ll@chapseci
      \setlength{\@tempdima}{\toctitleindent}% eliminate any spaces here
      \toctitlefont                    %% bold ToC entry
      \c@ll@chapsecii{#1}{#2}
      \penalty\@highpenalty      % discourage page break
      \endgroup
    \fi}
\else
  \newcommand*\l@coltoctitle[2]{%  % as per section
    \ifnum \c@tocdepth >\z@
      \addpenalty\@secpenalty
      \addvspace{1.0em \@plus\p@}%
      \c@ll@chapseci
      \setlength{\@tempdima}{\toctitleindent}% eliminate any spaces here
      \toctitlefont                    %% bold ToC entry
      \c@ll@chapsecii{#1}{#2}
      \penalty\@highpenalty      % discourage page break
      \endgroup
    \fi}
\fi

\newcommand*{\coltocauthor}[1]{%
  \c@ltocauthortrue%
  \gdef\savec@ltocauthor{#1}
}

\ifc@lhaschapter
  \newcommand*\l@coltocauthor[2]{%  % similar to chapter
    \ifnum \c@tocdepth >\m@ne
      \c@ll@chapseci
      \setlength{\@tempdima}{\tocauthorindent}% eliminate any spaces here
      \tocauthorfont                    %% italic ToC entry
      \c@ll@chapsecii{#1}{}
      \penalty\@highpenalty  % discourage page break
      \endgroup
    \fi}
\else
  \newcommand*\l@coltocauthor[2]{%  % similar to section
    \ifnum \c@tocdepth >\z@
      \c@ll@chapseci
      \setlength{\@tempdima}{\tocauthorindent}% eliminate any spaces here
      \tocauthorfont                    %% italic ToC entry
      \c@ll@chapsecii{#1}{}
      \penalty\@highpenalty  % discourage page break
      \endgroup
    \fi}
\fi

\newcommand{\published}[2][\@empty]{%
  \c@lpubtrue
  \ifc@lnopubintoc\else
    \ifx #1\@empty
      \gdef\savec@lpublished{#2}
    \else
      \gdef\savec@lpublished{#1}
    \fi
  \fi
  \ifc@lnopubindoc\else
    {\parindent \z@ \pubfont #2\par\nobreak}
  \fi
}
\newcommand{\pubfont}{\normalfont\centering}

\ifc@lhaschapter
  \newcommand*\l@published[2]{%  % similar to chapter
    \ifnum \c@tocdepth >\m@ne
      \c@ll@chapseci
      \setlength{\@tempdima}{\tocpubindent}% eliminate any spaces here
      \tocpubfont               %% normal font ToC entry
      \c@ll@chapsecii{#1}{}
      \endgroup
    \fi}
\else
  \newcommand*\l@published[2]{%  % similar to section
    \ifnum \c@tocdepth >\z@
      \c@ll@chapseci
      \setlength{\@tempdima}{\tocpubindent}% eliminate any spaces here
      \tocpubfont              %% normal font ToC entry
      \c@ll@chapsecii{#1}{}
      \endgroup
    \fi}
\fi

\newcommand{\erasetitling}{\c@ltoctitlefalse\c@ltocauthorfalse\c@lpubfalse}

\newenvironment{papers}[1][\cleardoublepage]{%
#1
\setuppapers
}{%
\takedownpapers
}

\newcommand{\setuppapers}{%
\let\documentclass\c@lbdocumentclass
\ifc@lpackages\else \let\usepackage\c@lbusepackage \fi
\let\document\c@lbdocument
\let\enddocument\c@lbenddocument
\let\LoadClass\c@lbLoadClass
%% \let\maketitle\c@lbmaketitle
\def\maketitle{\c@lbmaketitle}
\let\@writefile\c@lb@writefile
\let\@starttoc\c@lb@starttoc
\ifc@lnomaketitle \let\maketitle\relax \fi
\ifc@lnotoc \let\tableofcontents\relax \fi
\ifc@lnolof \let\listoffigures\relax \fi
\ifc@lnolot \let\listoftables\relax \fi
\ifc@lmaintoc \let\addtocontents\c@lbaddtocontents \fi
\let\label\c@lblabel
\let\@setref\c@lb@setref
\let\newlabel\c@lbnewlabel
\let\ref\c@lbref
\let\pageref\c@lbpageref
%%% \renewcommand{\bibliographystyle}[1]{}
\ifc@lcombib
\else
  \ifc@lonebib
    \renewcommand{\bibliography}[1]{}
  \fi
\fi
\let\@citex\c@lb@citex
\let\bibcite\c@lbbibcite
\let\nocite\c@lbnocite
\ifc@lhaschapter
  \renewcommand{\chapter}{\@startsection{chapter}{0}{\z@}%
                                        {-3.5ex \@plus -1ex \@minus -.2ex}%
                                        {2.3ex \@plus.2ex}%
                                        {\normalfont\Large\bfseries}}
\fi
\c@ltoctitlefalse
\c@ltocauthorfalse
\c@lpubfalse
\let\pagenumbering\c@lbpagenumbering
\setcounter{colpage}{\value{page}}
\let\pagestyle\c@lbpagestyle
\pagestyle{\c@lastyle}
\let\include\input
}

\newcommand{\takedownpapers}{%
}

\newcommand{\emptyAtBeginDocument}{\let\@begindocumenthook\@empty}

\let\document\c@ladocument
\let\enddocument\c@laenddocument
%%\let\maketitle\c@lamaketitle
\let\pagestyle\c@lapagestyle
\pagestyle{combine}

\endinput
%%
%% End of file `combine.cls'.
