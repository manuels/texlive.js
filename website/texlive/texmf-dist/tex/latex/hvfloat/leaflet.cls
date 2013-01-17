%%
%% This is file `leaflet.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% leaflet.dtx  (with options: `class')
%% 
%% Copyright (C) 2003, 2004
%% Rolf Niepraschk, Rolf.Niepraschk@ptb.de
%% Hubert Gaesslein, HubertJG@open.mind.de
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%% 
%% This work has the LPPL maintenance status "author-maintained".
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{leaflet}
  [2004/12/22 v1.0d LaTeX document class (JS,WaS,RN,HjG)]
\let\LL@shipout\shipout \let\LL@outputpage\@outputpage
\let\LL@begindvi\@begindvi \let\LL@@end\@@end
\@ifundefined{iflandscape}{\newif\iflandscape}{}%
\@ifundefined{iftumble}{\newif\iftumble}{}%
\newcommand\LL@debug@info[1]{}%
\DeclareOption{dvips}{\PassOptionsToPackage{\CurrentOption}{graphics}}
\DeclareOption{pdftex}{\PassOptionsToPackage{\CurrentOption}{graphics}}
\DeclareOption{vtex}{\PassOptionsToPackage{\CurrentOption}{graphics}}
\DeclareOption{dvipdfm}{\PassOptionsToPackage{\CurrentOption}{graphics}}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{landscape}{\landscapetrue}
\DeclareOption{portrait}{\landscapefalse}
\DeclareOption{debug}{\let\LL@debug@info\typeout}
\DeclareOption{nospecialtricks}{%
  \AtEndOfClass{%
    \ifLL@combine
      \let\immediate\@@@immediate\let\write\@@@write
      \let\openout\@@@openout\let\closeout\@@@closeout
      \let\special\@@@special\let\@@@exec@outs\relax
    \fi}}
\newcommand*\LL@setPaperSize{}
\DeclareOption{a3paper}{\def\LL@setPaperSize{%
  \paperwidth=420mm\paperheight=297mm\relax}}%
\@ifdefinable\ifLL@combine{\newif\ifLL@combine}
\DeclareOption{combine}{\LL@combinetrue}
\DeclareOption{nocombine}{\LL@combinefalse}
\newcommand*\LL@selectOutput{}
\DeclareOption{frontside}{\def\LL@selectOutput#1#2{#1}}
\DeclareOption{backside}{\def\LL@selectOutput#1#2{#2}}
\DeclareOption{bothsides}{\def\LL@selectOutput#1#2{#1#2}}
\DeclareOption{tumble}{\tumbletrue}
\DeclareOption{notumble}{\tumblefalse}
\newcommand*\LL@foldmark{}
\DeclareOption{foldmark}{%
  \def\LL@foldmark{%
    \begingroup
      \linethickness{\LenToUnit{\foldmarkrule}}%
      \setlength\@tempdima{\paperheight-\LL@tmargin}%
      \put(0,\LenToUnit{\@tempdima}){%
        \line(0,-1){\LenToUnit{\foldmarklength}}}%
    \endgroup}%
}
\DeclareOption{nofoldmark}{\def\LL@foldmark{}}%
\newcommand*\LL@toomanypages[2]{}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{article}%
  \AtEndOfClass{%
    \def\LL@toomanypages#1#2{%
        \ClassWarningNoLine{leaflet}{#1.\MessageBreak#2}}%
  }%
}
\DeclareOption{final}{\PassOptionsToClass{\CurrentOption}{article}%
  \AtEndOfClass{%
    \ifLL@combine
      \def\LL@toomanypages#1#2{%
        \ClassError{leaflet}{#1}{#2.}}%
    \else
      \def\LL@toomanypages#1#2{%
        \ClassWarningNoLine{leaflet}{#1.\MessageBreak#2}}%
    \fi
  }%
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\PassOptionsToClass{landscape,a4paper}{article}
\ExecuteOptions{tumble,foldmark,bothsides,combine,landscape,final}
\ProcessOptions\relax
\ifLL@combine
  \newcommand*\LL@rotate@I{}\newcommand*\LL@rotate@II{}%
  \iflandscape
    \def\LL@rotate@I#1{#1}%
    \iftumble
      \def\LL@rotate@II#1{\rotatebox[origin=c]{180}{#1}}%
    \else
      \def\LL@rotate@II#1{#1}%
    \fi
  \else
    \def\LL@rotate@I#1{\rotatebox[origin=c]{90}{#1}}%
    \iftumble
      \def\LL@rotate@II#1{\rotatebox[origin=c]{270}{#1}}%
    \else
      \def\LL@rotate@II#1{\rotatebox[origin=c]{90}{#1}}%
    \fi
  \fi
  \def\@@@pending@outs{}\let\@@@immediate\immediate
  \let\@@@write\write \let\@@@special\special
  \let\@@@openout\openout \let\@@@closeout\closeout
  \def\immediate{%
    \let\write\immediate@write%
    \let\openout\immediate@openout%
    \let\closeout\immediate@closeout%
    \let\special\immediate@special}%
  \def\reset@immediate{%
    \let\write\pending@write%
    \let\openout\pending@openout%
    \let\closeout\pending@closeout%
    \let\special\@@@special}%
  \long\def\pending@write#1#{\pending@@write{#1}}
  \def\immediate@write{%
    \reset@immediate\@@@immediate\@@@write}%
  \def\immediate@openout{%
    \reset@immediate\@@@immediate\@@@openout}%
  \def\immediate@closeout{%
    \reset@immediate\@@@immediate\@@@closeout}%
  \def\immediate@special{%
    \reset@immediate\@@@immediate\@@@special}%
  \let\write\pending@write
  \let\openout\pending@openout
  \let\closeout\pending@closeout
  \def\@dummy@whatsit{\special{}}
  \begingroup\@ifundefined{pdfoutput}%
  {\endgroup}
  {\endgroup
   \ifnum\pdfoutput>\z@\def\@dummy@whatsit{\pdfliteral{}}\fi}
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname eTeXversion\endcsname\relax
    %%% Test is from Markus Kohm (d.c.t.t, 29 Jun 2004)
    \ClassWarningNoLine{leaflet}{%
    *************************************\MessageBreak
    * It's very recommended to use eTeX  \MessageBreak
    * with this package!                 \MessageBreak
    *************************************}%
    \long\def\pending@@write#1#2{%
      \@dummy@whatsit
      \g@addto@macro\@@@pending@outs{\@@@immediate\@@@write\number#1{#2},}}%
    \def\pending@openout#1 {%
      \@dummy@whatsit
      \g@addto@macro\@@@pending@outs{\@@@immediate\@@@openout\number#1,}}%
    \def\pending@closeout#1{%
      \@dummy@whatsit
      \g@addto@macro\@@@pending@outs{\@@@immediate\@@@closeout\number#1,}}%
    \newcommand*\@@@exec@outs{%
      \@@@pending@outs\gdef\@@@pending@outs{}%
      \LL@debug@info{%
        >>> execute the output commands of the current page <<<}}%
  \else
    \RequirePackage{etex}
    \globmarks\@@@out@mark
    \newcounter{@@total@outs}\setcounter{@@total@outs}{0}
    \newcounter{@@last@exec}\setcounter{@@last@exec}{0}
  \long\def\pending@@write#1#2{%
    \global\advance\c@@@total@outs\@ne%
    \marks\@@@out@mark{\the\c@@@total@outs}%
    \g@addto@macro\@@@pending@outs{\@@@immediate\@@@write\number#1{#2},}}%
\def\pending@openout#1 {%
  \global\advance\c@@@total@outs\@ne%
  \marks\@@@out@mark{\the\c@@@total@outs}%
  \g@addto@macro\@@@pending@outs{\@@@immediate\@@@openout\number#1,}}%
\def\pending@closeout#1{%
  \global\advance\c@@@total@outs\@ne%
  \marks\@@@out@mark{\the\c@@@total@outs}%
  \g@addto@macro\@@@pending@outs{\@@@immediate\@@@closeout\number#1,}}%
    \newcommand*\@@@exec@outs{%
      \begingroup
        \@tempcntb\c@@@total@outs\advance\@tempcntb-\c@@@last@exec%
        \edef\reserved@a{\botmarks\@@@out@mark}%
        \ifx\reserved@a\@empty\@tempcnta\z@\else\@tempcnta\reserved@a\fi%
        \LL@debug@info{PENDING-OUTS:\the\@tempcntb\space\space
                       TOTAL-OUTS:\the\c@@@total@outs\space\space
                       LAST-EXEC:\the\c@@@last@exec\space\space
                       TOPMARK:\topmarks\@@@out@mark\space\space
                       FIRSTMARK:\firstmarks\@@@out@mark\space\space
                       BOTMARK:\botmarks\@@@out@mark}%
        \advance\@tempcnta-\c@@@total@outs \advance\@tempcntb\@tempcnta
        \@tempcnta-\@tempcnta%
        \ifnum\@tempcnta>\z@
          \LL@debug@info{%
            >>> resave \the\@tempcnta\space output command(s).
                Too early to execute! <<<}%
        \fi
        \@tempcnta\z@ \def\reserved@b{}%
        \@for\reserved@a :=\@@@pending@outs\do{%
          \ifx\reserved@a\@empty\else
            \ifnum\@tempcnta<\@tempcntb%
              \reserved@a%  execute output's related to the current page box.
              \global\advance\c@@@last@exec\@ne
              \LL@debug@info{>>> execute output command number
                       \the\c@@@last@exec\space<<<}%
            \else
              \expandafter\g@addto@macro\expandafter\reserved@b\expandafter{%
                \reserved@a,}%
            \fi
            \advance\@tempcnta\@ne%
          \fi}%
        \expandafter\@temptokena\expandafter{\reserved@b}%
        \xdef\@@@pending@outs{\the\@temptokena}%
      \endgroup}%
  \fi% end of eTeX test.
  \long\def\protected@write#1#2#3{%
    \begingroup
       \let\thepage\relax
       #2%
       \let\protect\@unexpandable@protect
       \edef\reserved@a{\noexpand\write#1{#3}}%
       \reserved@a%
    \endgroup
    \if@nobreak\ifvmode\nobreak\fi\fi}%
  \def\shipout{\deadcycles\z@\setbox\@tempboxa=}
  \let\@begindvi\@empty
\fi% end of \ifLL@combine
\LoadClass{article}
\RequirePackage{everyshi,calc,graphicx}
\newcommand*\LL@pagesize@specials[2]{}
\@ifundefined{Gin@driver}{}%
{%
  \ifx\Gin@driver\@empty\else%
    \filename@parse{\Gin@driver}\@tempswafalse%
    \def\reserved@a{dvips}%
    \ifx\filename@base\reserved@a\@tempswatrue\fi%
    \def\reserved@a{dvipdfm}%
    \ifx\filename@base\reserved@a\@tempswatrue\fi%
    \if@tempswa%
      \ClassInfo{leaflet}{Generating code for dvips}%
      \def\LL@pagesize@specials#1#2{%
        \@tempdima=#1\@tempdimb=#2%
        \AtBeginDvi{\special{papersize=\the\@tempdima,\the\@tempdimb}}}%
    \fi%
    \def\reserved@a{pdftex}%
    \ifx\filename@base\reserved@a
      \ClassInfo{leaflet}{Generating code for pdfTeX}%
      \def\LL@pagesize@specials#1#2{%
        \@tempdima=#1\@tempdimb=#2%
        \pdfpagewidth\@tempdima\pdfpageheight\@tempdimb}%
    \fi%
    \def\reserved@a{vtex}%
    \ifx\filename@base\reserved@a
      \ClassInfo{leaflet}{Generating code for VTeX}%
      \def\LL@pagesize@specials#1#2{%
        \@tempdima=#1\@tempdimb=#2%
        \mediawidth\@tempdima\mediaheight\@tempdimb}%
    \fi%
  \fi
}
\newcommand*\LL@CmdIgnored[1]{%
  \ClassWarning{leaflet}{%
    `\string#1' ignored}}
\setlength{\parskip}{1ex plus 2pt}
\@listi%
\setlength{\labelwidth}{\leftmargin}
\addtolength{\labelwidth}{-\labelsep}
\pagestyle{empty}
\headheight\z@
\headsep\z@
\footskip\z@
\marginparwidth\z@
\marginparsep\z@
\sloppy
\setcounter{secnumdepth}{0}
\renewcommand\twocolumn[1][]{\LL@CmdIgnored{\twocolumn}}
\renewcommand\onecolumn{\LL@CmdIgnored{\onecolumn}}
\renewcommand\topfraction{0.7}
\renewcommand\bottomfraction{0.7}
\setlength{\textfloatsep}{10pt plus 4pt minus 3pt}
\setlength{\parindent}{\z@}
\setlength{\leftmargini}{1.5em}
\setlength{\leftmarginii}{1.5em}
\setlength{\leftmarginiii}{1.5em}
\setlength{\leftmarginiv}{1.5em}
\setlength{\leftmarginv}{1.5em}
\setlength{\leftmarginvi}{1.5em}
\setlength{\labelsep}{.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\def\noparskip{\par\vspace{-\parskip}}
\let\old@small\small
\renewcommand{\small}{\old@small\let\@listi\@listI}
\let\old@footnotesize\footnotesize
\renewcommand{\footnotesize}{\old@footnotesize\let\@listi\@listI}
\newcommand{\sectfont}{\bfseries}
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-3.5ex \@plus -.75ex}%
  {1ex} %{1.5ex}%
  {\normalfont\large\sectfont}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-2.5ex plus -.5ex}%
  {1\p@} %{1ex}%
  {\normalfont\normalsize\sectfont}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-2.5ex plus -.5ex}%
  {-1em}%
  {\normalfont\normalsize\sectfont}}
\def\part{\LL@CmdIgnored{\part}\secdef\@part\@spart}
\def\@part[#1]#2{}
\def\@spart#1{}

\renewcommand*\descriptionlabel[1]{%
  \hspace\labelsep\normalfont\descfont #1}
\newcommand*\descfont{\bfseries}
\iffalse
\g@addto@macro\enumerate{\parsep2\p@\@plus2\p@\@minus\z@}
\g@addto@macro\itemize{\parsep2\p@\@plus2\p@\@minus\z@}
\g@addto@macro\description{\parsep2\p@\@plus2\p@\@minus\z@}
\else
\newcommand*\LL@listsetup{%
  \parsep1ex\@plus.5ex\@minus.25ex%
  \LL@debug@info{***parsep=\the\parsep}%
  \itemsep\z@
  \LL@debug@info{***itemsep=\the\itemsep}%
  \topsep\z@
  \LL@debug@info{***topsep=\the\topsep}%
  \LL@debug@info{***partopsep=\the\partopsep}%
}
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
    \expandafter
    \list
      \csname label\@enumctr\endcsname
      {\usecounter\@enumctr
        \def\makelabel##1{\hss\llap{##1}}%
        %\def\makelabel##1{##1\hfill}%
        %\def\makelabel##1{\hss##1}%
        \LL@listsetup
      }%
  \fi}
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {%
        \def\makelabel##1{\hss\llap{##1}}%
        %\def\makelabel##1{##1\hfill}%
        %\def\makelabel##1{\hss##1}%
        \LL@listsetup
      }%
  \fi}
\renewenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel
                        \LL@listsetup}}
               {\endlist}
\fi
\newcommand*\setmargins[4]{%
   \setlength\topmargin{#1}%
   \edef\LL@tmargin{\the\topmargin}%
   \setlength\evensidemargin{#2}%
   \setlength\textheight{%
     \paperheight-\topmargin-\evensidemargin%
     -\headheight-\headsep-\footskip}%
   \setlength\oddsidemargin{#3}%
   \setlength\evensidemargin{#4}%
   \setlength\textwidth{%
     \paperwidth-\oddsidemargin-\evensidemargin-\marginparwidth-\marginparsep}%
   \addtolength\topmargin{-1in}%
   \addtolength\oddsidemargin{-1in}%
   \evensidemargin\oddsidemargin%
}
\LL@setPaperSize
\paperwidth=0.333333334\paperwidth
\setmargins{11mm}{11mm}{8mm}{8mm}
\newcommand*\foldmarkrule{0.4pt}
\newcommand*\foldmarklength{2mm}
\newcommand\AddToBackground{%
  \@ifstar{\@tempswatrue\LL@AddToBackground}
          {\@tempswafalse\LL@AddToBackground}}
\@onlypreamble\AddToBackground
\newcommand\LL@AddToBackground[2]{%
  \if@tempswa\def\@tempa{LL@largePic}\else\def\@tempa{LL@smallPic}\fi
  \expandafter\providecommand\csname\@tempa\@Roman{#1}\endcsname{}%
  \expandafter\g@addto@macro\csname\@tempa\@Roman{#1}\endcsname{#2}}
\newcommand\LenToUnit[1]{#1\@gobble}
\newcommand*\CutLine{%
  \@ifstar{\@tempswatrue\LL@CutLine}{\@tempswafalse\LL@CutLine}}
\@onlypreamble\CutLine
\newcommand*\LL@CutLine[1]{%
  \ifLL@combine
    \ifx\Scissors\@empty\@tempswatrue\fi
    \if@tempswa
      \AddToBackground{#1}{%
        \put(0,0){%
          \rotatebox{90}{\makebox(\LenToUnit{\paperheight},0){%
            \normalsize
            \dotfill}}}}%
    \else
      \AddToBackground{#1}{%
        \put(0,0){%
          \rotatebox{90}{\makebox(\LenToUnit{\paperheight},0){%
            \normalsize
            \dotfill\Scissors\dotfill\dotfill\Scissors\dotfill}}}}%
    \fi
  \fi}
\IfFileExists{pifont.sty}
  {\RequirePackage{pifont}%
   \newcommand*\Scissors{\raisebox{-0.85ex}{\large\ding{34}}}}%
  {\newcommand*\Scissors{}}
\AddToBackground{3}{\LL@foldmark}
\providecommand*\vb@xt@{\vbox to}
\AtBeginDocument{\EveryShipout{\LL@savePage}}
\newcounter{LL@page}\setcounter{LL@page}{1}
\newcommand\LL@tempa{}
\newcommand*\LL@savePage{%
  \ifnum\c@LL@page<7\relax
    \setbox\@cclv\vbox{%
      \vbox{\@tempdima=1in\relax
        \@tempdimb=\paperheight\advance\@tempdimb-\@tempdima
        \pictur@(0,0)(\LenToUnit{\@tempdima},\LenToUnit{\@tempdimb})%
          \begingroup
          \set@typeset@protect
          \@nameuse{LL@smallPic\Roman{LL@page}}%
          %\set@display@protect
          \endgroup
        \endpicture}%
        \nointerlineskip\box\@cclv}%
    \ifLL@combine
      \@@@exec@outs
      \expandafter\newsavebox\csname LL@box\Roman{LL@page}\endcsname%
      \setbox\@cclv=\vbox{\vskip1in\unvbox\@cclv}%
      \setbox\@cclv=\vbox{\moveright1in\box\@cclv}%
      \setbox\@cclv=\hb@xt@\paperwidth{\box\@cclv\hss}%
      \setbox\@cclv=\vb@xt@\paperheight{\box\@cclv\vss}%
      \global\expandafter\setbox%
        \csname LL@box\Roman{LL@page}\endcsname=\box\@cclv%
      \typeout{\@spaces[\the\c@LL@page] ==> [\Roman{LL@page}]}%
    \fi
  \fi
  \ifnum\c@LL@page=7\relax
    \begingroup
      \set@typeset@protect
      \LL@toomanypages{%
        The text you supplied fills more than six pages\MessageBreak
        and will therefore not fit onto a single flyer}{%
        Try using smaller fonts or reducing vertical space}%
    \endgroup
  \fi
  \stepcounter{LL@page}}
\ifLL@combine
  \def\@@end{%
    \clearpage\pagestyle{empty}%
    \let\@outputpage\LL@outputpage
    \def\@EveryShipout@Hook{}%
    \def\@EveryShipout@AtNextHook{}%
    \EveryShipout{\LL@savePage}%
    \loop\ifnum\c@LL@page<7\relax
      \ClassInfo{leaflet}{Generating empty page \the\c@page}%
      \null\newpage
    \repeat
    \let\shipout\LL@shipout \let\@begindvi\LL@begindvi
    \paperwidth=3\paperwidth
    \iflandscape
      \LL@pagesize@specials{\paperwidth}{\paperheight}%
    \else
      \LL@pagesize@specials{\paperheight}{\paperwidth}%
    \fi
    \newcommand*\LL@shipoutPage[1]{%
      \let \protect \noexpand
      \shipout\vb@xt@\paperheight{%
        \set@typeset@protect
        \vskip-1in%
        \@begindvi\hb@xt@\paperwidth{\hskip-1in##1\hss}\vss}}%
    \newcommand*\LL@preparePages[3]{%
      \typeout{[\@Roman{##1}\space\@Roman{##2}\space\@Roman{##3}] ==>}%
      \pictur@(0,0)\@nameuse{LL@largePic\Roman{page}}\endpicture%
      \LL@preparePage{##1}\LL@preparePage{##2}\LL@preparePage{##3}}%
    \newcommand*\LL@preparePage[1]{%
      \expandafter\box\csname LL@box\@Roman{##1}\endcsname}%
    \LL@selectOutput
      {\setcounter{page}{1}%
       \LL@shipoutPage{\LL@rotate@I{\LL@preparePages{5}{6}{1}}}}%
      {\setcounter{page}{2}%
       \LL@shipoutPage{\LL@rotate@II{\LL@preparePages{2}{3}{4}}}}%
    \LL@@end
  }%
\else
  \LL@pagesize@specials{\paperwidth}{\paperheight}%
  \AtEndDocument{%
    \clearpage\pagestyle{empty}%
    \loop\ifnum\c@LL@page<7\relax
      \ClassInfo{leaflet}{Generating empty page \the\c@page}%
      \null\newpage
    \repeat
  }
\fi
\endinput
%%
%% End of file `leaflet.cls'.
