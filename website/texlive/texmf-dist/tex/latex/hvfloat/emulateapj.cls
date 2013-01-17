%% This is emulateapj.cls, version November 10, 2009
%% For the latest version check http://hea-www.harvard.edu/~alexey/emulateapj
%%
%% NOTE: ApJ has moved its publishing to IOP and they have slightly changed
%% the formatting. To implement these changes, call emulateapj with the iop
%% option, as in
%% \usepackage[iop]{emulateapj}
%%
%% Other available options:
%%
%% [chicago] - (default) typeset as was done in the University of Chicago Press
%% [twocolumn] - (default) two-column mode
%% [onecolumn] - main text in one-column mode
%% [apj]       - typeset as for main journal
%% [apjl]      - (default) typeset as for ApJ Letters 
%% [tighten]   - some adjustments to approximate grid typesetting
%% [numberedappendix]   - number appendix sections as A, B, etc
%% [appendixfloats]  - use separate numbering for floats within appendix
%%
%% NOTE 2: Starting from version 11/10/2009, emulateapj tries to load
%% revtex4-1 if present on the system. This may cause small changes in
%% typesetting for old documents. If you want full compatibility, please
%% download the last version based on revtex4,
%% http://hea-www.harvard.edu/~alexey/emulateapj/emulateapj-rtx4.cls
%% and bundle it with your TeX source code
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Copyright 2000-2009 Alexey Vikhlinin
%%
%% The first version of this package was written by Maxim Markevitch. 
%% Pieces of AASTeX code are used for compatibility with aastex.cls.
%%
%% This program can be redistributed and/or modified under the terms of
%% the LaTeX Project Public License available from CTAN archives in
%% macros/latex/base/lppl.txt. This means you are free to use and
%% distribute this package; however, if you modify anything, please
%% change the file name and remove the author's email address.
%%
%% Alexey Vikhlinin <alexey@head.cfa.harvard.edu>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% `emulateapj' is a LaTeX2e class to emulate the Astrophysical Journal
%% (ApJ) page layout. The page length of the resulting document is very
%% close to that in ApJ when Times fonts are used instead of the LaTeX
%% default CM fonts.
%% 
%% If a manuscript is prepared for ApJ submission using the standard
%% American Astronomical Society LaTeX macros and the `aastex' style
%% (see instructions for authors on the ApJ web site), the only thing
%% required from the user should be to replace \documentclass{aastex}
%% with \documentclass{emulateapj}, and perhaps resize figures as
%% desired and replace {deluxetable} with {deluxetable*}. Possible minor
%% problems are described below.
%%
%% emulateapj requires revtex4.cls. If you don't have it already, it can be
%% downloaded from http://publish.aps.org/revtex4/ (it's a small package). 
%% Other extrnal packages used are latexsym, graphicx, amssymb, longtable,
%% epsf. They should already be present in the modern TeX distributions; if
%% not, download them from www.ctan.org. 
%%
%%
%% For release notes and change log, see at bottom
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\emulapj@ver{11/10/09}


\ProvidesClass{emulateapj}

\newif\if@revtex@four@one@
\IfFileExists{revtex4-1.cls}{
\@revtex@four@one@true
\def\@revtex@cls{revtex4-1}
}{
\@revtex@four@one@false
\def\@revtex@cls{revtex4}
}

\newif\if@two@col
\DeclareOption{twocolumn}{\@two@coltrue}
\DeclareOption{onecolumn}{\@two@colfalse}

\newif\if@chicago
\DeclareOption{chicago}{\@chicagotrue}
\DeclareOption{iop}{\@chicagofalse}

\newlength{\bibbaselineskip}\setlength{\bibbaselineskip}{3.075mm}
\newif\if@apj@letter
\DeclareOption{apj}{
  \setlength{\bibbaselineskip}{2.7mm}
  \def\apjsecfont{\normalsize}
  \def\secnum@size{\small}
  \def\subsecnum@size{\normalsize}
  \@apj@letterfalse
}
\DeclareOption{apjl}{
  \setlength{\bibbaselineskip}{3.075mm}
  \def\apjsecfont{\footnotesize}
  \def\secnum@size{\small}
  \def\subsecnum@size{\small}
  \@apj@lettertrue
}

\DeclareOption{tighten}{
% lineskiplimits to facilitate grid typesetting
  \lineskiplimit=-2mm
}

\def\AppendixApjSectionMarkInTitle#1{\relax}
\DeclareOption{numberedappendix}{
  \def\AppendixApjSectionMarkInTitle#1{#1.\ }
}

\newif\if@number@appendix@floats\@number@appendix@floatsfalse
\DeclareOption{appendixfloats}{
  \@number@appendix@floatstrue
}


\def\center@table@notes{%
  \def\@spew@tblnotes{%
        \centerline{\begin{minipage}{\pt@width}\spew@tblnotes\end{minipage}}%
        }%
}

\def\left@just@table@notes{%
  \def\@spew@tblnotes{\spew@tblnotes}%
}


\left@just@table@notes

\ExecuteOptions{apjl,twocolumn,chicago}

\ProcessOptions

\let\@startsection@from@latex=\@startsection

\if@two@col
  \LoadClass[twocolumn,nofootinbib,showkeys,twoside,floatfix,unsortedaddress,flushbottom]{\@revtex@cls}
\else
  \LoadClass[nofootinbib,showkeys,twoside,floatfix,unsortedaddress,flushbottom]{\@revtex@cls}
\fi
\def\blankaffiliation{~}%

\if@chicago
 \def\@eapj@cap@font{\scshape}
 \def\@eapj@figname{Fig.}
 \def\@eapj@tabname{TABLE}
\else
 \def\@eapj@cap@font{\bfseries}
 \def\@eapj@figname{Figure}
 \def\@eapj@tabname{Table}
\fi

% Restore natbib package without sorting. 
\def\NAT@sort{0}
\def\NAT@cmprs{0}
% only redefine sort@cites for natbib versions < 2009
\@ifundefined{NAT@sort@cites@}{\def\NAT@sort@cites#1{\edef\NAT@cite@list{#1}}}%

\RequirePackage{latexsym}% 
\RequirePackage{graphicx}% 
\RequirePackage{amssymb}% 
\RequirePackage{longtable}% 

\newcommand{\bibstyle@aas}{\bibpunct{(}{)}{;}{a}{}{,}}% 
\@citestyle{aas}% 


\let\@startsection=\@startsection@from@latex
\def\baselinestretch{1.0}
\AtBeginDocument{\def\arraystretch{1.0}}

\if@revtex@four@one@
\def\raggedcolumn@sw#1#2{#2}  % implement flushbottom as it was in revtex4
\fi

\RequirePackage{epsf,graphicx}

%%%%%%%% The following code is taken from size10.clo; it fixes
%%%%%%%% aastex's definition of type sizes
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xpt{10.56}
   \abovedisplayskip 2.2mm \@plus2\p@ \@minus1\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 2.2mm \@plus2\p@ \@minus1\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\renewcommand\small{%
   \@setfontsize\small\@ixpt{9.68}%
   \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 4\p@ \@plus2\p@ \@minus2\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize\@viiipt{8.36}%
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@ \@plus\p@ \@minus\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\scriptsize{\@setfontsize\scriptsize\@viipt\@viiipt}
\renewcommand\tiny{\@setfontsize\tiny\@vpt\@vipt}
\renewcommand\large{\@setfontsize\large\@xiipt{14}}
\renewcommand\Large{\@setfontsize\Large\@xivpt{18}}
\renewcommand\LARGE{\@setfontsize\LARGE\@xviipt{22}}
\renewcommand\huge{\@setfontsize\huge\@xxpt{25}}
\renewcommand\Huge{\@setfontsize\Huge\@xxvpt{30}}
\setlength\smallskipamount{3\p@ \@plus 1\p@ \@minus 1\p@}
\setlength\medskipamount{6\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\bigskipamount{12\p@ \@plus 4\p@ \@minus 4\p@}
\setlength\headheight{12\p@}
\def\@listi{\leftmargin\leftmargini
            \parsep 4\p@ \@plus2\p@ \@minus\p@
            \topsep 8\p@ \@plus2\p@ \@minus4\p@
            \itemsep4\p@ \@plus2\p@ \@minus\p@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    4\p@ \@plus2\p@ \@minus\p@
              \parsep    2\p@ \@plus\p@  \@minus\p@
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    2\p@ \@plus\p@\@minus\p@
              \parsep    \z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep   \topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}




%  ****************************************************
%  *             TWO AND SINGLE ONE COLUMN STYLES: AV *
%  ****************************************************
%

%%%%% include atbeginend.sty by AV:

% Copy \begin and \end to \BeginEnvironment and \EndEnvironment
\let\BeginEnvironment=\begin
\let\EndEnvironment=\end
%% \ifundefined from TeXbook
\def\IfUnDef#1{\expandafter\ifx\csname#1\endcsname\relax}
% Null command needed to eat its argument
\def\NullCom#1{}
\def\begin#1{%
% if defined \BeforeBeg for this environment, execute it
\IfUnDef{BeforeBeg#1}\else\csname BeforeBeg#1\endcsname\fi%
\IfUnDef{AfterBeg#1}% This is done to skip the command for environments
                     % which can take arguments, like multicols; YOU MUST NOT
                     % USE \AfterBegin{...}{...} for such environments! 
        \let\SaveBegEnd=\BeginEnvironment%
\else
        % Start this environment
                \BeginEnvironment{#1}%
        % and execute code after \begin{environment}
                \csname AfterBeg#1\endcsname
        \let\SaveBegEnd=\NullCom
\fi
\SaveBegEnd{#1}
}
\def\end#1{%
% execute code before \end{environment}
\IfUnDef{BeforeEnd#1}\else\csname BeforeEnd#1\endcsname\fi%
% close this environment
\EndEnvironment{#1}
% and execute code after \begin{environment}
\IfUnDef{AfterEnd#1}\else\csname AfterEnd#1\endcsname\fi%
}
\long\def\BeforeBegin#1#2{\expandafter\gdef\csname BeforeBeg#1\endcsname {#2}}
\long\def\BeforeEnd  #1#2{\expandafter\gdef\csname BeforeEnd#1\endcsname {#2}}
\long\def\AfterBegin #1#2{\expandafter\gdef\csname AfterBeg#1\endcsname {#2}}
\long\def\AfterEnd   #1#2{\expandafter\gdef\csname AfterEnd#1\endcsname{#2}}

%%%% end of atbeginend.sty

%  ****************************************
%  *            PAGE LAYOUT               *
%  ****************************************

% Page size, spacing parameters, etc. 

\textwidth=7.1in
\columnsep=0.3125in
\parindent=0.125in
\voffset=-20mm
\hoffset=-7.5mm

\topmargin=0in
\headheight=.15in
\headsep=0.5in
\oddsidemargin=0in
\evensidemargin=0in
\parskip=0cm

%\tolerance=600          % 3x "normal" value; cuts down on overfull complaints

%% AV,MM, to have 64 lines per column, with textheight 25cm:
\textheight=64\baselineskip
\textheight=\baselinestretch\textheight
\ifdim\textheight>25.2cm\textheight=25.0cm\fi

\topskip\baselineskip
\maxdepth\baselineskip


\let\tighten=\relax
\let\tightenlines=\tighten
\let\singlespace=\relax
\let\doublespace=\relax

\def\eqsecnum{
    \@newctr{equation}[section]
    \def\theequation{\hbox{\normalsize\arabic{section}-\arabic{equation}}}}

%% running heads:
\def\lefthead#1{\gdef\@versohead{#1}} \lefthead{\relax}
\def\righthead#1{\gdef\@rectohead{#1}} \righthead{\relax}
\let\shorttitle=\lefthead        % New AASTEX commands
\let\shortauthors\righthead      % New AASTEX commands

%% MM Create "apjheads" page style:
\def\ps@apjheads{\let\@mkboth\markboth
    \def\@evenfoot{}
    \def\@evenhead{\lower9mm\hbox to\textwidth{
                     \rm\thepage\hfil \rm\@rectohead \hfil}}}
    \def\@oddfoot{}
    \def\@oddhead{\lower9mm\hbox to\textwidth{
                     \hfil\rm\@versohead\hfil \rm\thepage}}
\@twosidetrue
\ps@apjheads

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    TITLE PAGE                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\long\def\frontmatter@title@above{
\vspace*{-\headsep}\vspace*{\headheight}
\footnotesize
{\footnotesize\textsc{\@journalinfo}}\par
{\scriptsize Preprint typeset using \LaTeX\ style emulateapj v.\
  \emulapj@ver}\par\vspace*{-\baselineskip}\vspace*{0.625in}
}%
\def\frontmatter@title@produce{%
 \begingroup
 \frontmatter@title@above
  \frontmatter@title@format
  \@title
  \@ifx{\@title@aux\@title@aux@cleared}{}{%
   \expandafter\frontmatter@footnote\expandafter{\@title@aux}%
  }%
  \par
%% \class@warn{Unused short title ignored}%
  \frontmatter@title@below
 \endgroup
}%
\renewcommand\title[2][]{%
 \def\@title{\uppercase{#2}}%
 \def\@shorttitle{#1}%
 \let\@AF@join\@title@join
}%
\def\frontmatter@title@format{\normalsize\centering}
\def\frontmatter@title@below{\vspace*{-2.63\baselineskip\vspace*{0.25in}}}%

\def\frontmatter@above@affilgroup{\vspace*{0.25in}}%
\def\frontmatter@authorformat{\small\scshape\centering}%
\def\frontmatter@affiliationfont{\normalfont\footnotesize}%

\def\frontmatter@finalspace{\vspace*{-\baselineskip}\vspace*{0.375in}}

\def\@separator{\\}%

\def\frontmatter@footnote#1{%
 \begingroup
  \@booleanfalse\temp@sw
  \def\@tempa{#1}%
  \let\@tempb\@empty
  \def\@TBN@opr{\y@match\@tempa}%
  \@FMN@list
  \temp@sw{%
   \expandafter\frontmatter@footnotemark
   \expandafter{\@tempb}%
  }{%
    \def\@thefnmark{\relax}
    \frontmatter@footnotetext{#1}
  }%
 \endgroup
}%

\newcounter{front@matter@foot@note}\setcounter{front@matter@foot@note}{0}

\def\frontmatter@above@affiliation{\vspace*{0.5mm}}%
\renewcommand\affiliation[1]{%
 \move@AU\move@AF%
 \begingroup%
  \@affiliation{\hspace*{2mm}#1}%
}%
\let\affil=\affiliation

\def\affil@mark#1{\textsuperscript{#1}}
\def\affile@mark@pad{0.2em}

\def\altaffilmark#1{\affil@mark{#1}}

% Fight poor revtex algorithm for altaffiliation:
\def\@alt@affil@kill@next@symbol#1{\relax}
\newtoks\alt@affil@toks \alt@affil@toks{\@alt@affil@kill@next@symbol}
\newtoks\alt@affil@toks@count \alt@affil@toks@count{}


\def\altaffiltext#1#2{%
\global\alt@affil@toks\expandafter{\the\alt@affil@toks\\\hspace*{3mm}\affil@mark{#1}\hspace*{\affile@mark@pad}#2}%
\global\alt@affil@toks@count\expandafter{\the\alt@affil@toks@count\stepcounter{front@matter@foot@note}}%
}
\let\@author@finish@revtex=\@author@finish
\def\@author@finish{%
\if!\the\alt@affil@toks@count!%
\relax
\else
\altaffiliation{\the\alt@affil@toks}\the\alt@affil@toks@count
\fi
\@author@finish@revtex
}

%\def\altaffiltext#1#2{\altaffiliation{\hspace*{3mm}\textsuperscript{#1}\hspace*{0.7mm}#2}\stepcounter{front@matter@foot@note}}

%% end altaffiliation

\let\old@foot@note@mark=\footnotemark
\let\old@foot@note@text=\footnotetext
\def\footnotemark[#1]{\altaffilmark{#1}}
\def\footnotetext[#1]#2{\altaffiltext{#1}{#2}}

%   ABSTRACT
\def\frontmatter@abstractfont{\normalsize\parindent=0.125in}%
\def\frontmatter@abstractwidth{6in}
\def\frontmatter@preabstractspace{0.0\baselineskip}
\def\frontmatter@postabstractspace{0.0\baselineskip}

\def\abstractname{ABSTRACT}
\long\def\frontmatter@abstractheading{%
  \vspace*{-\baselineskip}\vspace*{1.5pt}
  \centerline{\itshape\footnotesize\@submitted}
  \vspace*{0.13189in}
 \begingroup
  \centering
  \abstractname
  \vskip 1mm
  \par
 \endgroup
 \everypar{\rightskip=0.5in\leftskip=\rightskip}\par
}%

% Redefine the LaTeX \and command for this style. 
\def\and{\author{\vspace*{-0.2in}and\vspace*{-0.558cm}}\noaffiliation}
\def\@listand{\@ifnum{\@tempcnta=\tw@}{\andname\space}{}}%

%  ****************************************
%  *             KEYWORDS                 *
%  ****************************************

\def\@keys@name{\textit{Subject headings:}\/~\mbox{}}%
\newlength{\keys@width}
\def\frontmatter@keys@format{\vspace*{0.5mm}%
  \settowidth{\keys@width}{\normalsize\@keys@name}%
  \rightskip=0.5in\leftskip=\rightskip\parindent=0pt%
    \hangindent=\keys@width\hangafter=1\normalsize}%
\def\@keywords@produce#1{%
 \showKEYS@sw{%
  \begingroup%
   \frontmatter@keys@format%
   \@keys@name#1\par
  \endgroup
 }{%
  \@if@empty{#1}{}{%
   \class@warn{If you want your keywords to appear in your output, use document class option showkeys}%
  }%
 }%
}%

\let\subjectheadings=\keywords

%  ****************************************
%  *             FOOTNOTES                *
%  ****************************************

% Modify code from revtex:
\def\@xfootnotemark@ltx[#1]{%
 \begingroup
%   \csname c@\@mpfn\endcsname #1\relax
   \unrestored@protected@xdef\@thefnmark{#1}%
 \endgroup
 \H@@footnotemark
}%
% Modify code from LaTeX to fix footnotes:
\def\@xfootnotenext[#1]{%
  \begingroup
%  \csname c@\@mpfn\endcsname #1\relax
  \unrestored@protected@xdef\@thefnmark{#1}%
  \endgroup
  \@footnotetext}



% Footnotes on the last page: user issues \lastpagefootnotes. It catches all
% footnotes and issues them before \begin{refernces} or
% \begin{\thebibliography} or \begin{appendix}, whichever comes first,
% at the end of right column.  
\newcounter{lastfootnote}
\let\orig@footnote=\footnote
%
\def\spit@out@footnotes@{\addtocounter{footnote}{-\c@lastfootnote}\vspace*{-\baselineskip}\vspace*{\skip\footins}\bgroup\footnotesize\lastfootnote\par\egroup\let\footnote=\orig@footnote}
%
\let\spit@out@footnotes\relax
%
\long\def\lastpagefootnotes{%
\raggedbottom% Have to use flushbottom with revtex4-1 but it eats away
             % last page footnotes
\setcounter{lastfootnote}{0}
\long\gdef\lastfootnote{\mbox{}}
\let\spit@out@footnotes\spit@out@footnotes@
\long\def\footnote##1{\refstepcounter{lastfootnote}\footnotemark\g@addto@macro\lastfootnote{\\[\footnotesep]\refstepcounter{footnote}\mbox{}\hspace*{3mm}\textsuperscript{\thefootnote}~##1}}
\BeforeBegin{appendix}{\spit@out@footnotes\let\spit@out@footnotes\relax}
\BeforeBegin{references}{\spit@out@footnotes\let\spit@out@footnotes\relax}
\BeforeBegin{thebibliography}{\spit@out@footnotes\let\spit@out@footnotes\relax}
% in case \lastpagefootnotes were given inside \begin{appendix}\end{appendix},
\BeforeEnd{appendix}{\spit@out@footnotes\let\spit@out@footnotes\relax}
\AfterEnd{appendix}{\let\footnote=\orig@footnote}
\AfterEnd{references}{\let\footnote=\orig@footnote}
\AfterEnd{thebibliography}{\let\footnote=\orig@footnote}
}
\let\lastpagefootnote=\lastpagefootnotes

\if@revtex@four@one@\else
% this command is copied from the original revtex, but adds space above
% footnote (if any) above the references. 
\@namedef{balance@2}{%
 \expandafter\balance@two\csname col@1\endcsname\@outputbox
 % Avoid a bug by preventing a restore when leaving this group
 \global\setbox\csname col@1\endcsname\box\csname col@1\endcsname
 \@ifvoid\footbox{}{%
  \global\setbox\footbox\vbox{%
   \setbox\z@\box\@tempboxa
   \let\recover@footins\relax
   \balance@two\footbox\@tempboxa
   \vskip\skip\footins
   \hb@xt@\textwidth{\box\footbox\hfil\box\@tempboxa}%
  }%
 }%
}%
\fi

\skip\footins 4.5mm plus 1mm minus 1mm
\footnotesep 0pt
\let\footnoterule\relax

\def\@makefntext#1{\mbox{}\hspace*{3mm}\@makefnmark~#1}

\def\notetoeditor#1{}%   % We do not need notes to editor in the preprint
\def\placetable#1{}%   % We do not need notes to editor in the preprint
\def\placefigure#1{}%   % We do not need notes to editor in the preprint

%  ****************************************
%  *             SECTIONS                 *
%  ****************************************

\setcounter{secnumdepth}{3}

\newif\if@firstsection \@firstsectiontrue

\def\section{%
    \if@firstsection\@firstsectionfalse
      \maketitle\setcounter{footnote}{\thefront@matter@foot@note}%
      \let\footnotetext=\old@foot@note@text
      \let\footnotemark=\old@foot@note@mark
    \fi
    \@startsection{section}{1}{\z@}{9pt plus 2pt minus 1pt}{4pt}{\apjsecfont\center}}
  
\def\subsection{\@startsection{subsection}{2}{\z@}{9pt plus 1pt minus 1pt}{4pt}%
  {\normalsize\itshape \center}}

\def\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {2ex plus 1ex minus .2ex}{1ex plus .2ex}{\small\itshape \center}}

\def\paragraph{\@startsection{paragraph}{4}{\z@}%
  {1.5ex plus 1ex minus .2ex}{-0.5\parindent}{\small\it}}

\def\subparagraph{\@startsection{subparagraph}{5}{\z@}%
  {1ex plus 1ex minus .2ex}{-0.5\parindent}{\small\it}}

\def\thesection{\@arabic{\c@section}}
\def\thesubsection{\thesection.\@arabic{\c@subsection}}
\def\thesubsubsection{\thesubsection.\@arabic{\c@subsubsection}}
\def\theparagraph{\thesubsubsection.\@arabic{\c@paragraph}}
\def\p@section        {}
\def\p@subsection     {}
\def\p@subsubsection  {}
\def\p@paragraph      {}
\def\p@subparagraph   {}


\def\sec@upcase#1{\uppercase{#1}}
\def\subsec@upcase#1{\relax{#1}}

%
% How the section number will appear in the section title - AV
\def\ApjSectionMarkInTitle#1{#1.\ }
\def\ApjSectionpenalty{0}

\def\@sect#1#2#3#4#5#6[#7]#8%
{\@tempskipa #5\relax 
 \ifdim \@tempskipa >\z@ \begingroup
     #6\relax 
  \ifnum #2>\c@secnumdepth \def \@svsec {}\else 
    \refstepcounter{#1} \edef \@svsec {\ApjSectionMarkInTitle 
    {\csname the#1\endcsname}}\fi
  \@hangfrom {\hskip #3\relax 
    \ifnum #2=1{\secnum@size {\rm\@svsec~}}%
    \else {\subsecnum@size {\rm\@svsec~}}\fi }%
  {\interlinepenalty \@M 
   \ifnum #2=1\sec@upcase{#8}%
   \else \subsec@upcase{#8}\fi\par}\endgroup 
  \csname #1mark\endcsname {#7}\addcontentsline{toc}{#1}%
  {\ifnum #2>\c@secnumdepth \else \protect \numberline 
     {\csname the#1\endcsname }\fi #7}%
  \else 
  \ifnum #2>\c@secnumdepth \def \@svsec {}\else 
    \refstepcounter{#1} \edef \@svsec {\ApjSectionMarkInTitle 
    {\csname the#1\endcsname}}\fi
    \def \@svsechd {#6\hskip #3%
    \ifnum #2=1{\secnum@size{\rm\@svsec~}}\else{\subsecnum@size{\rm\@svsec~}}\fi%
    \ifnum #2=1\sec@upcase{#8}\else\subsec@upcase{#8}\fi%
    \ifnum #2=4\hskip 0.4ex{\rm ---}\fi%
     \csname #1mark\endcsname {#7}\addcontentsline{toc}{#1}%
      {\ifnum #2>\c@secnumdepth \else \protect \numberline {\csname
      the#1\endcsname }\fi #7}}\fi \@xsect {#5} \penalty \ApjSectionpenalty
%-refstepcounter is now within a group. So \@currentlabel, which is normally
%-set by \refstepcounter is hidden within a group. Need to set it manually. 
\protected@edef\@currentlabel{\csname p@#1\endcsname\csname the#1\endcsname}
}


\def\@ssect#1#2#3#4#5{\@tempskipa #3\relax
   \ifdim \@tempskipa>\z@
     \begingroup #4\@hangfrom{\hskip #1}{\interlinepenalty \@M
       \sec@upcase{#5}\par}\endgroup
   \else \def\@svsechd{#4\hskip #1\relax \sec@upcase{#5}}\fi
    \@xsect{#3}
% MM:
\penalty \ApjSectionpenalty}


\def\acknowledgments{\vskip 5.8mm plus 1mm minus 1mm}
\let\acknowledgements=\acknowledgments                  % second spelling


%  ****************************************
%  *          APPENDIX                    *
%  ****************************************

\newcounter{remember@figure@num}
\newcounter{remember@table@num}

\renewenvironment{appendix}[0]{
  \onecolumngrid
        \vskip 10pt plus 2pt minus 1pt
        \noindent\mbox{}\hfill{\apjsecfont APPENDIX}\hfill\mbox{}\par
        \nopagebreak\medskip\@nobreaktrue\def\ApjSectionpenalty{\@M}
        \@firstsectionfalse
          \setcounter{section}{0}
          \setcounter{subsection}{0}
          \setcounter{equation}{0}
          \setcounter{remember@figure@num}{\c@figure}
          \setcounter{remember@table@num}{\c@table}
%  \def\fnum@figure{Figure \Alph{section}\thefigure:}
%  \def\fnum@table{Table \Alph{section}\thetable:}
          \def\thesection{\Alph{section}}
          \def\theequation{\hbox{\Alph{section}\arabic{equation}}}

          \if@number@appendix@floats
          \setcounter{figure}{0}
          \setcounter{table}{0}
          \def\thefigure{\thesection\@arabic\c@figure}
          \def\thetable{\thesection\@arabic\c@table}
          \fi
%
% Do not use appendix numbers in the titles
          \def\ApjSectionMarkInTitle{\AppendixApjSectionMarkInTitle}
          \def\section{\setcounter{equation}{0}\if@number@appendix@floats\setcounter{figure}{0}\setcounter{table}{0}\fi\@startsection {section}{1}{\z@} 
            {10pt}{5pt}{\centering\scshape\apjsecfont}}
%
%
          }{%
            \if@number@appendix@floats
            \setcounter{figure}{\c@remember@figure@num}%
            \setcounter{table}{\c@remember@table@num}%
            \fi
          }



%  ****************************************
%  *          BIBLIOGRAPHY                *
%  ****************************************

\renewenvironment{references}[0]{
  \onecolumngrid
  \par
  \vspace{10pt plus 3pt}
  \noindent \makebox[\textwidth][c]{\small\scshape REFERENCES}
  \par
  \vspace*{4pt plus 3pt}
  \set@column@hsize{2}\twocolumngrid
  \parindent=0cm \parskip=0cm
  \def\baselinestretch{1.0}
  \footnotesize \baselineskip=\baselinestretch\bibbaselineskip plus 1pt
  minus 1pt \interlinepenalty \@M
  \hyphenpenalty=10000
  \frenchspacing    % AV - to get right spacing after ``et al.'' 
  \def\refpar{\par\hangindent=1.2em\hangafter=1}}
{
  \onecolumngrid
}

% redefine thebibliography
% redefine thebibliography

% remove numbers from the reference list
\def\@biblabel#1{\relax}

\newdimen\bibindent
\renewenvironment{thebibliography}[1]{
 \if@chicago \onecolumngrid \fi
 \par
 \raggedright
 \vspace{10pt plus 3pt}
 \if@chicago
    \noindent \makebox[\textwidth][c]{\footnotesize REFERENCES}
 \else
    \centerline{\footnotesize REFERENCES}
 \fi
 \par
 \vspace*{4pt plus 3pt}
 \if@chicago\set@column@hsize{2} \twocolumngrid \fi
 \list{}%
   {
     \parindent=0pt \parskip=0pt \parsep=0pt % AV
     \bibindent=0pt                          %
     \def\baselinestretch{1.0}
     \footnotesize \baselineskip=\bibbaselineskip \interlinepenalty \@M  % AV
     \frenchspacing    % AV - to get right spacing after ``et al.'' 
     \hyphenpenalty=10000
     \itemindent=-1.0em                      %
     \itemsep=0pt                            %
     \listparindent=0pt                      %
     \settowidth\labelwidth{0pt} %
     \labelsep=0pt                           %
     \leftmargin=1.0em
     \advance\leftmargin\labelsep
%%%      \usecounter{enumiv}%
      \let\p@enumiv\@empty
      \renewcommand\theenumiv{\relax}}%
    \sloppy\clubpenalty4000\widowpenalty4000%
    \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
    \onecolumngrid
  }

% %% AV: 

\def\reference{\@ifnextchar\bgroup {\@reference}
        {\@latexerr{Missing key on reference command}
        {Each reference command should have a key corresponding to a markcite somewhere in the text}}}
\def\@reference#1{\refpar}

%% subtitle header and journal info:
\def\submitted#1{\gdef\@submitted{#1}}
\def\journalinfo#1{\gdef\@journalinfo{#1}}
\def\subtitle{
  \vspace*{-12mm}
  \noindent
  {\scriptsize {\sc \@journalinfo} \\
        Preprint typeset using \LaTeX\ style emulateapj v.\ \emulapj@ver}
}
\let\slugcomment\submitted   % slugcomment == submitted
\submitted{Draft version \today}
\journalinfo{\@submitted}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Equations                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EQNARRAY with reduced spacing around tab characters - AV
\def\eqnarray{%
  \stepcounter{equation}%
  \def\@currentlabel{\p@equation\theequation}%
  \global\@eqnswtrue
  \setlength{\arraycolsep}{0.25\arraycolsep}
  \m@th
  \global\@eqcnt\z@
  \tabskip\@centering
  \let\\\@eqncr
  $$\everycr{}\halign to\displaywidth\bgroup
  \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
  &\global\@eqcnt\@ne\hskip \tw@\arraycolsep \hfil${##}$\hfil
  &\global\@eqcnt\tw@ \hskip \tw@\arraycolsep
  $\displaystyle{##}$\hfil\tabskip\@centering
  &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
  \tabskip\z@skip
  \cr
  }

%  ****************************************
%  *         TABLES AND FIGURES           *
%  ****************************************



\def\@arstrut@hline@clnc{0.5\p@}% % Klootch: magic number

\setcounter{topnumber}{7}

\setlength{\belowcaptionskip}{0pt}
\setlength{\abovecaptionskip}{5pt}

\setlength{\textfloatsep}{-\baselinestretch\baselineskip}
\setlength{\dbltextfloatsep}{-\baselinestretch\baselineskip}
\if@apj@letter
  \addtolength{\textfloatsep}{5mm plus 10mm minus 10mm}
  \addtolength{\dbltextfloatsep}{5mm plus 10mm minus 10mm}
\else
  \addtolength{\textfloatsep}{7mm plus 10mm minus 10mm}
  \addtolength{\dbltextfloatsep}{7mm plus 10mm minus 10mm}
\fi

\renewcommand{\topfraction}{1.0}
\renewcommand{\bottomfraction}{1.0}
\renewcommand{\textfraction}{0.0}
\renewcommand{\dbltopfraction}{0.85}
\renewcommand{\dblfloatpagefraction}{0.85}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9} 

% Copied from revtex4.cls; without it, captions are centered
\def\@xfloat@prep{%
  \let\footnote\footnote@latex
  \def\@mpfn{mpfootnote}%
  \def\thempfn{\thempfootnote}%
  \c@mpfootnote\z@
  \let\@footnotetext\@mpfootnotetext
  \let\H@@footnotetext\@mpfootnotetext
  \let\@makefntext\@mpmakefntext
}%

\long\def\@makecaption#1#2{%
 \noindent\begin{minipage}{0.9999\linewidth} %% \noindent is needed because
   %% otherwise minipage + parindent does not fit into the line and spurious
   %% vertical skip appear after caption
   \if\csname ftype@\@captype\endcsname 2 
   \vskip 2ex\noindent \centering\@table@type@size{\@eapj@cap@font  #1}\par
    \if@chicago\@eapj@cap@font\fi #2\par\medskip
   \else
   \vspace*{\abovecaptionskip}\noindent\footnotesize #1 #2\par\vskip \belowcaptionskip
   \fi
 \end{minipage}
 }



%%%%%%%%%%%% FIX \cutinhead
\def\@ptabularcr{\\}
\newcommand\cutinhead[1]{% 
 \noalign{\vskip 1.5ex}% 
 \hline 
 \@ptabularcr 
 \noalign{\vskip -1.5ex}% 
 \multicolumn{\LT@cols}{c}{#1}% 
 \@ptabularcr 
 \noalign{\vskip .8ex}% 
 \hline 
 \@ptabularcr 
 \noalign{\vskip -2ex}% 
}% 

\newcommand\sidehead[1]{% 
 \noalign{\vskip 1.5ex}% 
%  \hline 
%  \@ptabularcr 
%  \noalign{\vskip -1.5ex}% 
 \multicolumn{\LT@cols}{l}{#1}% 
 \@ptabularcr 
 \noalign{\vskip .8ex}% 
%  \hline 
%  \@ptabularcr 
%  \noalign{\vskip -2ex}% 
}% 


\newcommand\figcaption{\@testopt{\@xfigcaption}{}}% 
%% suggested by Joern Wilms
\def\@figcaption#1{{\def\@captype{figure}\caption{\footnotesize #1}}}
\def\@xfigcaption[#1]#2{{\def\@captype{figure}\caption{\footnotesize #2}}}

\def\thefigure{\@arabic\c@figure}
\def\fnum@figure{{\footnotesize{\@eapj@cap@font\if@chicago~~\fi\mbox{\@eapj@figname~\thefigure.}\if@chicago---\else~\fi}}}

\def\thetable{\@arabic\c@table}
%%% Table captions without making a floating table
\def\tabcaption{\@ifnextchar[{\@xtabcaption}{\@tabcaption}}
\def\@tabcaption#1{{\def\@captype{table}\caption{#1}}}
\def\@xtabcaption[#1]#2{{\def\@captype{table}\caption{#2}}}
\def\fnum@table{{\@eapj@cap@font \@eapj@tabname~\thetable}}
% \let\fnum@ptable=\fnum@table
% \def\fnum@ptablecont{{\centering{\scshape Table~\thetable}---{\itshape
% Continued}}}% 
% \long\def\@make@caption@text#1#2{% 
%   {\small\centering#1{\scshape #2}\par\vskip1.4ex}
% }% 
\long\def\@makecaption@plano@cont#1#2{% 
  {\small \centering#1\par}\vskip1.4ex\relax
}% 


%% Commands from aastex.cls:
\newcommand\dataset{\@testopt\@dataset{[}}%
\def\@dataset[#1]#2{#2}%
\newcommand\facility{\@testopt\@facility{[}}%
\def\@facility[#1]#2{#2}%
\newcommand\object{\@testopt\@object{[}}%
\def\@object[#1]#2{#2}%
\newcommand\objectname{\@testopt\@objectname{[]}}% 
\def\@objectname[#1]#2{#2}% 
\newlength{\plot@width}
\def\eps@scaling{1.0}% 
\newcommand\epsscale[1]{\def\eps@scaling{#1}}% 
\newcommand\plotone[1]{% 
 \centering 
 \leavevmode 
 \setlength{\plot@width}{0.85\linewidth}
 \includegraphics[width={\eps@scaling\plot@width}]{#1}% 
}% 
\newcommand\plottwo[2]{% 
 \centering 
 \leavevmode 
 \setlength{\plot@width}{0.425\linewidth}
 \includegraphics[width={\eps@scaling\plot@width}]{#1}% 
 \hfil 
 \includegraphics[width={\eps@scaling\plot@width}]{#2}% 
}% 
\newcommand\plotfiddle[7]{% 
 \centering 
 \leavevmode 
 \vbox\@to#2{\rule{\z@}{#2}}% 
 \includegraphics[% 
  scale=#4, 
  angle=#3, 
  origin=c 
 ]{#1}% 
}% 
\newcommand\figurenum[1]{% 
 \def\thefigure{#1}% 
 \let\@currentlabel\thefigure 
 \addtocounter{figure}{\m@ne}% 
}% 

\newcommand\phn{\phantom{0}}% 
\newcommand\phd{\phantom{.}}% 
\newcommand\phs{\phantom{$-$}}% 
\newcommand\phm[1]{\phantom{#1}}% 
\let\la=\lesssim            % For Springer A&A compliance... 
\let\ga=\gtrsim 
\newcommand\sq{\mbox{\rlap{$\sqcap$}$\sqcup$}}% 
\newcommand\arcdeg{\mbox{$^\circ$}}% 
\newcommand\arcmin{\mbox{$^\prime$}}% 
\newcommand\arcsec{\mbox{$^{\prime\prime}$}}% 
\newcommand\fd{\mbox{$.\!\!^{\mathrm d}$}}% 
\newcommand\fh{\mbox{$.\!\!^{\mathrm h}$}}% 
\newcommand\fm{\mbox{$.\!\!^{\mathrm m}$}}% 
\newcommand\fs{\mbox{$.\!\!^{\mathrm s}$}}% 
\newcommand\fdg{\mbox{$.\!\!^\circ$}}% 
\newcommand\farcm@mss{\mbox{$.\mkern-4mu^\prime$}}% 
\let\farcm\farcm@mss 
\newcommand\farcs@mss{\mbox{$.\!\!^{\prime\prime}$}}% 
\let\farcs\farcs@mss 
\newcommand\fp{\mbox{$.\!\!^{\scriptscriptstyle\mathrm p}$}}% 
\newcommand\micron{\mbox{$\mu$m}}% 
\def\farcm@apj{% 
 \mbox{.\kern -0.7ex\raisebox{.9ex}{\scriptsize$\prime$}}% 
}% 
\def\farcs@apj{% 
 \mbox{% 
  \kern  0.13ex.% 
  \kern -0.95ex\raisebox{.9ex}{\scriptsize$\prime\prime$}% 
  \kern -0.1ex% 
 }% 
}% 
 

\newcommand\ion[2]{#1$\;${%
\ifx\@currsize\normalsize\small \else
\ifx\@currsize\small\footnotesize \else
\ifx\@currsize\footnotesize\scriptsize \else
\ifx\@currsize\scriptsize\tiny \else
\ifx\@currsize\large\normalsize \else
\ifx\@currsize\Large\large
\fi\fi\fi\fi\fi\fi
\rmfamily\@Roman{#2}}\relax}% 

\renewcommand\case[2]{\mbox{$\frac{#1}{#2}$}}% 
\renewcommand\slantfrac{\case}% 
\newcommand\onehalf{\slantfrac{1}{2}}% 
\newcommand\onethird{\slantfrac{1}{3}}% 
\newcommand\twothirds{\slantfrac{2}{3}}% 
\newcommand\onequarter{\slantfrac{1}{4}}% 
\newcommand\threequarters{\slantfrac{3}{4}}% 
\newcommand\ubvr{\mbox{$U\!BV\!R$}}%% UBVR system 
\newcommand\ub{\mbox{$U\!-\!B$}}%   % U-B 
\newcommand\bv{\mbox{$B\!-\!V$}}%   % B-V 
\renewcommand\vr{\mbox{$V\!-\!R$}}%   % V-R 
\newcommand\ur{\mbox{$U\!-\!R$}}%   % U-R 
\newcommand\nodata{ ~$\cdots$~ }% 
\newcommand\diameter{\ooalign{\hfil/\hfil\crcr\mathhexbox20D}}% 
\newcommand\degr{\arcdeg}% 
\newcommand\Sun{\sun}% 
\newcommand\Sol{\sun}% 
\newcommand\sun{\odot}% 
\newcommand\Mercury{\astro{\char1}}% Mercury symbol, "1" 
\newcommand\Venus{\astro{\char2}}% Venus symbol, "2" 
\newcommand\Earth{\earth}% 
\newcommand\Terra{\earth}% 
\newcommand\earth{\oplus}% 
\newcommand\Mars{\astro{\char4}}% Mars symbol, "4" 
\newcommand\Jupiter{\astro{\char5}}% Jupiter symbol, "5" 
\newcommand\Saturn{\astro{\char6}}% Saturn symbol, "6" 
\newcommand\Uranus{\astro{\char7}}% Uranus symbol, "7" 
\newcommand\Neptune{\astro{\char8}}% Neptune symbol, "8" 
\newcommand\Pluto{\astro{\char9}}% Pluo symbol, "9" 
\newcommand\Moon{\astro{\char10}}% Moon symbol, "M" 
\newcommand\Luna{\Moon}% 
\newcommand\Aries{\astro{\char11}}% 
\newcommand\VEq{\Aries}% vernal equinox (Aries) 
\newcommand\Taurus{\astro{\char12}}% 
\newcommand\Gemini{\astro{\char13}}% 
\newcommand\Cancer{\astro{\char14}}% 
\newcommand\Leo{\astro{\char15}}% 
\newcommand\Virgo{\astro{\char16}}% 
\newcommand\Libra{\astro{\char17}}% 
\newcommand\AEq{\Libra}% autumnal equinox (Libra) 
\newcommand\Scorpius{\astro{\char18}}% 
\newcommand\Sagittarius{\astro{\char19}}% 
\newcommand\Capricornus{\astro{\char20}}% 
\newcommand\Aquarius{\astro{\char21}}% 
\newcommand\Pisces{\astro{\char22}}% 

\newcommand\anchor[2]{#2}% 
\renewcommand\url{\@dblarg\@url}% 
\def\@url[#1]{\anchor{#1}}% 

\let\jnl@style=\rmfamily 
\def\ref@jnl#1{{\jnl@style#1}}% 
\newcommand\aj{\ref@jnl{AJ}}% 
          % Astronomical Journal 
\newcommand\araa{\ref@jnl{ARA\&A}}% 
          % Annual Review of Astron and Astrophys 
\renewcommand\apj{\ref@jnl{ApJ}}% 
          % Astrophysical Journal 
\newcommand\apjl{\ref@jnl{ApJ}}% 
          % Astrophysical Journal, Letters 
\newcommand\apjs{\ref@jnl{ApJS}}% 
          % Astrophysical Journal, Supplement 
\renewcommand\ao{\ref@jnl{Appl.~Opt.}}% 
          % Applied Optics 
\newcommand\apss{\ref@jnl{Ap\&SS}}% 
          % Astrophysics and Space Science 
\newcommand\aap{\ref@jnl{A\&A}}% 
          % Astronomy and Astrophysics 
\newcommand\aapr{\ref@jnl{A\&A~Rev.}}% 
          % Astronomy and Astrophysics Reviews 
\newcommand\aaps{\ref@jnl{A\&AS}}% 
          % Astronomy and Astrophysics, Supplement 
\newcommand\azh{\ref@jnl{AZh}}% 
          % Astronomicheskii Zhurnal 
\newcommand\baas{\ref@jnl{BAAS}}% 
          % Bulletin of the AAS 
\newcommand\jrasc{\ref@jnl{JRASC}}% 
          % Journal of the RAS of Canada 
\newcommand\memras{\ref@jnl{MmRAS}}% 
          % Memoirs of the RAS 
\newcommand\mnras{\ref@jnl{MNRAS}}% 
          % Monthly Notices of the RAS 
\renewcommand\pra{\ref@jnl{Phys.~Rev.~A}}% 
          % Physical Review A: General Physics 
\renewcommand\prb{\ref@jnl{Phys.~Rev.~B}}% 
          % Physical Review B: Solid State 
\renewcommand\prc{\ref@jnl{Phys.~Rev.~C}}% 
          % Physical Review C 
\renewcommand\prd{\ref@jnl{Phys.~Rev.~D}}% 
          % Physical Review D 
\renewcommand\pre{\ref@jnl{Phys.~Rev.~E}}% 
          % Physical Review E 
\renewcommand\prl{\ref@jnl{Phys.~Rev.~Lett.}}% 
          % Physical Review Letters 
\newcommand\pasp{\ref@jnl{PASP}}% 
          % Publications of the ASP 
\newcommand\pasj{\ref@jnl{PASJ}}% 
          % Publications of the ASJ 
\newcommand\qjras{\ref@jnl{QJRAS}}% 
          % Quarterly Journal of the RAS 
\newcommand\skytel{\ref@jnl{S\&T}}% 
          % Sky and Telescope 
\newcommand\solphys{\ref@jnl{Sol.~Phys.}}% 
          % Solar Physics 
\newcommand\sovast{\ref@jnl{Soviet~Ast.}}% 
          % Soviet Astronomy 
\newcommand\ssr{\ref@jnl{Space~Sci.~Rev.}}% 
          % Space Science Reviews 
\newcommand\zap{\ref@jnl{ZAp}}% 
          % Zeitschrift fuer Astrophysik 
\renewcommand\nat{\ref@jnl{Nature}}% 
          % Nature 
\newcommand\iaucirc{\ref@jnl{IAU~Circ.}}% 
          % IAU Cirulars 
\newcommand\aplett{\ref@jnl{Astrophys.~Lett.}}% 
          % Astrophysics Letters 
\newcommand\apspr{\ref@jnl{Astrophys.~Space~Phys.~Res.}}% 
          % Astrophysics Space Physics Research 
\newcommand\bain{\ref@jnl{Bull.~Astron.~Inst.~Netherlands}}% 
          % Bulletin Astronomical Institute of the Netherlands 
\newcommand\fcp{\ref@jnl{Fund.~Cosmic~Phys.}}% 
          % Fundamental Cosmic Physics 
\newcommand\gca{\ref@jnl{Geochim.~Cosmochim.~Acta}}% 
          % Geochimica Cosmochimica Acta 
\newcommand\grl{\ref@jnl{Geophys.~Res.~Lett.}}% 
          % Geophysics Research Letters 
\renewcommand\jcp{\ref@jnl{J.~Chem.~Phys.}}% 
          % Journal of Chemical Physics 
\newcommand\jgr{\ref@jnl{J.~Geophys.~Res.}}% 
          % Journal of Geophysics Research 
\newcommand\jqsrt{\ref@jnl{J.~Quant.~Spec.~Radiat.~Transf.}}% 
          % Journal of Quantitiative Spectroscopy and Radiative Trasfer 
\newcommand\memsai{\ref@jnl{Mem.~Soc.~Astron.~Italiana}}% 
          % Mem. Societa Astronomica Italiana 
\newcommand\nphysa{\ref@jnl{Nucl.~Phys.~A}}% 
          % Nuclear Physics A 
\newcommand\physrep{\ref@jnl{Phys.~Rep.}}% 
          % Physics Reports 
\newcommand\physscr{\ref@jnl{Phys.~Scr}}% 
          % Physica Scripta 
\newcommand\planss{\ref@jnl{Planet.~Space~Sci.}}% 
          % Planetary Space Science 
\newcommand\procspie{\ref@jnl{Proc.~SPIE}}% 
          % Proceedings of the SPIE 
\let\astap=\aap 
\let\apjlett=\apjl 
\let\apjsupp=\apjs 
\let\applopt=\ao 

\renewcommand\nodata{ ~$\cdots$~ }% 
\newcommand\ulap[1]{\vbox\@to\z@{{\vss#1}}}% 
\newcommand\dlap[1]{\vbox\@to\z@{{#1\vss}}}% 


% Implementation of deluxetables via the longtable package


\newcounter{table@save}
\def\save@label#1{
  \if@filesw\immediate\write\@auxout{%
    \string\newlabel{#1}{{\@currentlabel}{\thepage}}}%
  \fi%
}

\def\tablenum#1{%
  \setcounter{table@save}{\the\c@table}
  \gdef\use@tablenum{1}
  \setcounter{table}{#1}\def\thetable{#1}\def\@currentlabel{#1}
  \def\label##1{\save@label{##1}}
}%
\gdef\use@tablenum{0}
\def\restore@tablenum{\if\use@tablenum0\else\setcounter{table}{\the\c@table@save}\addtocounter{table}{\m@ne}\gdef\use@tablenum{0}\fi}


\def\tabletypesize#1{\def\table@hook{#1}\gdef\@table@type@size{#1}}
\tabletypesize{\footnotesize}
\let\tablefontsize=\tabletypesize % for compatibility with old documents

\gdef\@tablecaption{}
\def\tablecaption#1{\gdef\@tablecaption{\if@chicago \@eapj@cap@font \fi #1}}

\def\LT@endpbox{%
  \@finalstrut\@arstrutbox
  \egroup
  \the\LT@p@ftn
  \global\LT@p@ftn{}%
  \hfil}

\def\LT@makecaption#1#2#3{%
  \LT@mcol\LT@cols c{\hbox to\z@{\hss\parbox[t]\LTcapwidth{%
%     \sbox\@tempboxa{#2.~~#3}%
                                %     \ifdim\wd\@tempboxa>\hsize
      \centering
      #2~~#3%
%     \else
%       \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
%     \fi
    \endgraf\vskip\baselineskip}%
  \hss}}}
\let\LT@makecaption@rtx=\LT@makecaption % to fight redefinition in Revtex-4.1

\global\let\tablenotemark\relax
\global\def\tablenotemark#1{{\normalfont\textsuperscript{#1}}}
\global\let\tablenotetext\relax
\global\def\tablenotetext#1#2{\footnotetext[#1]{\@table@type@size#2}}


\newif\if@table@not@headed

\def\startdata{\if@table@not@headed\kill\caption{\\%
    \@tablecaption}\endhead\hline\endfoot%
  \fi%
}

\def\tablehead#1{
  \@table@not@headedfalse%
  \kill
  \caption{\\%
    \@tablecaption}%
    \\
  \hline
  \hline\\[-1.7ex]
  #1\hskip\tabcolsep\\[.7ex]
  \hline\\[-1.5ex]
  \endfirsthead
  \caption[]{--- \emph{Continued}}\\
  \hline
  \hline\\[-1.7ex]
  #1\hskip\tabcolsep\\[.7ex]
  \hline\\[-1.5ex]
  \endhead
  \hline
  \endfoot%
}

\newlength{\table@note@skip}
\setlength{\table@note@skip}{0.5ex}
\newlength{\deluxe@table@width}
\newlength{\@d@t@a}
\newcounter{deluxe@table@num}

\def\colhead#1{\multicolumn{1}{c}{#1}}


\def\tablewidth#1{%
  \ifdim#1=\z@
  \else
  \gdef\@d@t@@flag{1}
  \if@filesw\immediate\write\@auxout{%
   \gdef\expandafter\noexpand
   \csname deluxe@table@width@\romannumeral\c@LT@tables\endcsname
   {#1}}
  \fi
  \fi
}


\def\save@natural@width{%
      \ifnum\@d@t@@flag=0
        \setlength{\@d@t@a}{0pt}%
        \let\@d@t@b=\LT@entry%
        \def\LT@entry##1##2{\addtolength{\@d@t@a}{##2}%
        }%
        \expandafter\csname LT@\romannumeral\c@deluxe@table@num\endcsname
        \setlength{\@d@t@a}{-\@d@t@a}
        \tablewidth{\the\@d@t@a}
        \def\LT@entry{\@d@t@b}
      \fi
}

\def\lt@expand@linewidth@one{\setlength\LTleft{0pt}\setlength\LTright{0pt}}
\def\lt@expand@linewidth@two{@{\extracolsep{0pt plus 1filll}}}
\def\find@table@width{%
%%% set table width using aux file and command \tablewidth
    \setcounter{deluxe@table@num}{\c@LT@tables}
    \refstepcounter{deluxe@table@num}
    \expandafter\ifx\csname deluxe@table@width@\romannumeral\c@deluxe@table@num\endcsname\relax
      \def\@d@t@{0.999\linewidth}
    \else
      \edef\@d@t@{\expandafter\csname deluxe@table@width@\romannumeral\c@deluxe@table@num\endcsname}
    \fi
    \ifdim\@d@t@<\z@% then natural width is used
      \setlength{\deluxe@table@width}{-\@d@t@}
      \setlength{\LTcapwidth}{-\@d@t@}
      \def\lt@expand@linewidth{\relax}
      \def\lt@expand@linewidth@{}
    \else% we will enclose table in the minipage of the given width and make
         % longtable to span the full minipage width
      \ifdim\@d@t@>\z@\else\def\@d@t@{0.999\linewidth}\fi
      \setlength{\deluxe@table@width}{\@d@t@}
      \setlength{\LTcapwidth}{\@d@t@}
      \def\lt@expand@linewidth{\lt@expand@linewidth@one}
      \def\lt@expand@linewidth@{\lt@expand@linewidth@two}
    \fi
}

\newlength{\abovedeluxetableskip}
\newlength{\belowdeluxetableskip}
\setlength{\abovedeluxetableskip}{0pt}
\setlength{\belowdeluxetableskip}{0pt}
\setlength{\tabcolsep}{5pt}

\setlength\doublerulesep{1.5pt}
\newdimen\lastrowheight
\def\set@last@row@height{\setlength{\lastrowheight}{\ht\strutbox}\addtolength{\lastrowheight}{\dp\strutbox}\setlength{\lastrowheight}{-\arraystretch\lastrowheight}}

\let\tableline=\hline % Revtex said: Command \tableline is obsolete; Use \colrule instead.. 

\newtoks\DT@p@ftn 
\global\def\tablenotetext@DT#1#2{
%  \edef\@tempa{\the\DT@p@ftn\noexpand\footnotetext[#1]}
  \edef\@tempa{\the\DT@p@ftn\noexpand\tablenotemark{#1}~}
  \global\DT@p@ftn\expandafter{\@tempa{\@table@type@size#2}\par}}%


\newenvironment{deluxetable}[1]{
  \lineskiplimit=\z@ % restore default setting
  \def\tablenotetext{\tablenotetext@DT}
  \gdef\tblnote@list{}
  \gdef\tblref@list{}
  \DT@p@ftn{}%
  \set@last@row@height\edef\lastrowheight@{\the\lastrowheight}
  \renewcommand\tablecomments[1]{\gdef\tblnote@list{\@tablecom{##1}}}% 
  \renewcommand\tablerefs[1]{\gdef\tblref@list{\@tableref{##1}}}% 
  \@table@not@headedtrue
  \begin{table}
    \vspace*{\abovedeluxetableskip}
    \gdef\@d@t@@flag{0}
    \def\nl{\\}
%    \def\tabcolsep{5pt}
    \let\caption=\LT@caption
    \find@table@width
    \centering
    \begin{minipage}{\deluxe@table@width}
      \lt@expand@linewidth
      \begin{longtable}{\lt@expand@linewidth@#1}
      }{
        \restore@tablenum%
      \end{longtable}%
      \save@natural@width
      \@spew@tblnotes\end{minipage}
    \vspace*{\belowdeluxetableskip}
  \end{table}
}


\newenvironment{deluxetable*}[1]{
  \lineskiplimit=\z@ % restore default setting
  \def\tablenotetext{\tablenotetext@DT}
  \gdef\tblnote@list{}
  \gdef\tblref@list{}
  \DT@p@ftn{}%
  \set@last@row@height\edef\lastrowheight@{\the\lastrowheight}
  \renewcommand\tablecomments[1]{\gdef\tblnote@list{\@tablecom{##1}}}% 
  \renewcommand\tablerefs[1]{\gdef\tblref@list{\@tableref{##1}}}% 
  \@table@not@headedtrue
  \begin{table*}
    \vspace*{\abovedeluxetableskip}
    \gdef\@d@t@@flag{0}
    \def\nl{\\}
%    \def\tabcolsep{5pt}
    \let\caption=\LT@caption
    \centering
    \find@table@width
    \begin{minipage}{\deluxe@table@width}
    \lt@expand@linewidth
    \begin{longtable*}{\lt@expand@linewidth@#1}
    }{\gdef\pt@width{\LTcapwidth}%
      \restore@tablenum%
    \end{longtable*}%
    \save@natural@width
    \@spew@tblnotes%
  \end{minipage}%
  \vspace*{\belowdeluxetableskip}
\end{table*}}

\def\enddata{\\[\lastrowheight@]\vspace*{1.5mm}}


\def\LongTables{
  \renewcommand\tablecomments[1]{\gdef\tblnote@list{\@tablecom{##1}}}% 
  \renewcommand\tablerefs[1]{\gdef\tblref@list{\@tableref{##1}}}% 
  \renewenvironment{deluxetable}[1]{
    \def\tablenotetext{\tablenotetext@DT}
    \global\DT@p@ftn{}%
    \def\nl{\\}
%    \def\tabcolsep{5pt}
    \let\caption=\LT@caption
    \begin{longtable}{##1}
      \set@last@row@height\global\edef\lastrowheight@{\the\lastrowheight}
        \@table@not@headedtrue
    }{\gdef\pt@width{\LTcapwidth}\restore@tablenum
    \end{longtable}%
    \vspace*{-1.5ex}
    \begin{minipage}{0.99\linewidth}
      \@spew@tblnotes%
    \end{minipage}
  }
  \renewenvironment{deluxetable*}[1]{
    \def\tablenotetext{\tablenotetext@DT}
    \global\DT@p@ftn{}%
    \@table@not@headedtrue
    \def\nl{\\}
%    \def\tabcolsep{5pt}
    \let\caption=\LT@caption
    \begin{longtable*}{##1}
      \set@last@row@height\global\edef\lastrowheight@{\the\lastrowheight}
        \@table@not@headedtrue
    }{\gdef\pt@width{\LTcapwidth}%
      \restore@tablenum%
    \end{longtable*}%
    \vspace*{-1.5ex}
    \begin{minipage}{0.99\linewidth}
      \@spew@tblnotes%
    \end{minipage}
}
}

\def\tableheadfrac#1{}
\newcount\pt@column 
\newcount\pt@ncol 
\newcommand\tablecolumns[1]{% 
 \pt@column=#1\relax 
 \pt@ncol=#1\relax 
 \global\let\pt@addcol\@empty 
}% 
\def\cutinhead@ppt#1{% 
 \noalign{\vskip 1.5ex}% 
 \hline 
 \@ptabularcr 
 \noalign{\vskip -2ex}% Style Note: in apj, it is -1.5ex 
 \multicolumn{\pt@ncol}{c}{#1}% 
 \\
 \noalign{\vskip .8ex}% 
 \hline 
 \\
 \noalign{\vskip -2ex}% 
}% 
% \newcommand\sidehead[1]{% 
%  \noalign{\vskip 1.5ex}% 
%  \multicolumn{\pt@ncol}{@{\hskip\z@}l}{#1}% 
%  \\
%  \noalign{\vskip .5ex}% 
% }% 
%\def\startdata{\relax}

\gdef\tblnote@list{}
\gdef\tblref@list{}
\newcommand\tablecomments[1]{\@tablecom{#1}}% 
\newcommand\tablerefs[1]{\@tableref{#1}}% 
\def\@tablecom#1{% 
 \vspace*{\table@note@skip}
\par 
{\parbox{\linewidth}{\hskip1em\rmfamily {\@eapj@cap@font Note}. --- #1}\par}% 
}% 
\def\@tableref#1{% 
 \vspace*{\table@note@skip}
\par 
{\parbox{\linewidth}{\hskip1em\rmfamily {\@eapj@cap@font References}. --- #1}\par}% 
}% 
\def\spew@tblnotes{% 
 \@ifx@empty\tblref@list{}{% 
  \@tablenotes{\tblref@list}%
  \vspace*{\table@note@skip}%
  \global\let\tblref@list\@empty 
 }% 
 \@ifx@empty\tblnote@list{}{% 
  \@tablenotes{\tblnote@list}% 
  \vspace*{\table@note@skip}%
  \global\let\tblnote@list\@empty
 }
 \the\DT@p@ftn%
}% 
\def\@tablenotes#1{% 
 \par 
% \footnoterule% 
 {\@table@type@size#1}% 
}% 

\endinput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Release notes (02/09/03):
%% 
%% 1) This is a complete rewrite of emulateapj. The package is now
%% based on revtex instead of aastex + multicol.
%%
%% 2) The {deluxetable} environment is re-implemented (the problem with the
%% the aastex's deluxetable is it does not float). There is also a new
%% environment {deluxetable*} (absent in aastex) to set a floating table
%% two-column wide. Known problems:
%%   (a) \rotate doesn't work (too difficult to implement). Solution:
%%       - load package lscape  (\usepackage{lscape} in the header)
%%       - move table at the end of the paper after references
%%       - \clearpage before the table
%%       - \LongTables if the table will span more than 1 page (see next item)
%%       - put the table inside the landscape environment and \clearpage
%%         at the end: 
%%         \clearpage
%%         \LongTables % optionally
%%         \begin{landscape}
%%           \begin{deluxetable}
%%           .... 
%%           \end{deluxetable}
%%         \clearpage
%%         \end{landscape}
%%
%% 3) Multi-page tables cannot be set properly inside the main text; you
%% need to move the table to the end of the paper (after the references) and
%% issue the command \LongTables before it. 
%% 
%% 4) By default, deluxetables are typeset with \footnotesize. If you want
%% to use a different size, use, e.g., \tabletypesize{\normalsize} _outside_
%% the deluxetable environment. If you need to increase interline spacing
%% in the tables, use \def\arraystretch{1.XXX} also _outside_ deluxetables. 
%% 
%% 5) Option `onecolumn' (as in \documentclass[onecolumn]{emulateapj})
%% sets the whole paper (except the reference section) in one column
%% as done by the ApJ for papers with long equations. 
%% 
%% 6) Options `apj' and `apjl' (\documentclass[apj]{emulateapj}) change the
%% spacing of the references (the default is ApJL wide spacing), and
%% also the spacing between figures and text (last check with printed
%% Journal in 4/2005). 
%%
%% 7) By default, appendix subsections are not numbered:
%%             APPENDIX
%%      Derivation of Equations
%% If you want them numbered (`A. Derivation of Equations'), use the option
%% \documentclass[numberedappendix]{emulateapj}
%%  
%% It is recommended to use the {appendix} environment instead of the
%% \appendix command. Equation (and optionally also table and figure)
%% counters are reset within the {appendix} to something like A1,A2,B1
%% etc. The counters are restored at \end{appendix} because sometimes we
%% want to place figures and tables belonging to the main matter at the
%% end of the paper.
%%  
%% 8) By default, the comment in the upper-left corner of the title page and
%% under the abstract will say "Draft version \today". There are additional
%% commands \journalinfo{} and \submitted{} (the latter is equivalent to the
%% aastex \slugcomment{} which also works) to change those comments. Used
%% alone, \submitted{} will act on both those places. 
%% 
%% 9) The \title command sets the entire title, including math, in upper
%% case. If this is undesirable, use \lowercase{} macro, e.g., 
%% \title{UPPER CASE OK HERE \lowercase{$a+b=c$}}. 
%%
%% 10) On the last page where the references or appendix start, there
%% may be problems with placement of footnotes. There is a command
%% \lastpagefoot notes which can be issued somewhere before those
%% footnotes. It will result in the remaining footnotes set together at
%% the end of the text, properly adjusted. 
%% 
%% 11) There may be problems with single-column figure placements on the
%% last page; try moving the figure around or explicitly specifying the [t]
%% placement.  There may also be minor column misalignments on
%% complicated pages with footnotes, sections, etc.; these are too difficult
%% to fix. 
%%
%% 12) Any footnotes in the paper title should be set as
%% \title{Title\footnotemark[1]} \footnotetext[1]{text} (with foootnotetext
%% outside the title), rather that simply a \footnote{}. 
%%
%% NOTE that if you use the footnote in the title, the footnote counter for
%% the main text will be wrong. You need to reset it manually _after_ the
%% first \section. For example, if the frontmatter footnotes (title +
%% affiliations) stop at 3, you need \setcounter{footnote}{3}
%%
%% 13) \label's within the deluxetable environments should go INSIDE the
%% \tablecaption{...} command or after \tablehead
%%
%% 14) ... if, however, you use \tablenum [not recommended], \label should
%%     go IMMEDIATELY AFTER the \tablenum command
%%
%% 15) Marc Audard reports that if the bibliography is exactly finishing the
%% page, and the next page should be a table, latex is not working. If an
%% empty character (\mbox{~}) is added after (or before) the bibliography,
%% i.e., starting a new page, the problem disappears. 
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Change Log
%% 
%% 2/14/3: fixed several bugs in deluxetable and footnotes inside the title. 
%%
%% 3/3/3:  Table caption is made in two lines. works only in {table} or
%% {table*}, but not in {deluxetable}
%%
%% 3/3/3:  Redefine p@subsection etc. for ApJ-style cross-references. 
%%
%% 3/16/3:  Define \tablerefs
%%
%% 3/25/3:  Fix two-column references in the onecolumn mode (see 
%%          \set@column@hsize{2})
%%
%% 4/9/3:  Change the definition of \tablenotemark. It is less general but
%%         works in the table caption. Also, put the body of deluxetable*
%%         inside a minipage to fix table footnotes. 
%%
%% 5/14/3: Change section title font sizes. They are now different for 'apj'
%%         and 'apjl' options
%%
%% 7/8/3:  redefine NAT@sort@cites after loding revtex4 to prevent citations
%%         from being sorted
%%
%% 7/15/3: Fix \and in the author list
%%
%% 7/17/3: Make \colhead to center column titles by default
%% 
%% 7/27/3: Redefile \@biblabel to remove the numbered list from thebibliography
%%
%% 9/08/3: Further fixes to cutinhead: define @ptabularcr and use LT@cols
%%
%% 10/08/3: Copy definitions for \anchor and \url from aastex. 
%%
%% 10/10/3: define \paragraph, \subparagraph. suppress section numbering
%%          below \subsection. If you want subsubsections numbered, use 
%%          \setcounter{secnumdepth}{3}
%%          in the header
%%
%% 11/13/3: add 'unsortedaddress' option to revtex4 to prevent groupin the
%% authors by the institute
%%
%% 11/26/3: define \def\blankaffiliation{~} after revtex4 to prevent \and's
%%          from combining
%%
%% 2/10/4: implement \tablewidth; works as documented in aastex;
%%         change format for caption of deluxetables from Table 1. Title to
%%                          Table 1. 
%%                           Title
%%         Make table notes of the same width as the table. 
%%         Fix tabletypesize for table notes
%%
%% 2/12/4: fix \tablewidth: \tablewidth{0pt} gives natural size (as does no
%%         \tablewidth at all)
%%         Remove dot after "Table 1." 
%%         Also change format to Table 1--- Continued
%%
%% 2/19/4: implement \tablenum within deluxetable; abstract paragraphs
%%         indented; 
%%
%% 3/19/4: if no \tablehead is given, \startdata still prints out the caption
%%
%% 4/2/4: remove a spurious space from the definition of \tablehead
%%
%% 4/12/4: Due to popular demand, define \tablecomments and \tablerefs for
%%         ordinary {table}s. 
%%
%% 6/6/4: Proper implementation of \sidehead in the deluxetable
%%
%% 6/21/4: Fix issues with table heading which were introduced when I tried
%%         to implement deluxetable's _without_ any heading. 
%%
%% 6/22/4: correct implementation of \tablenotetext in the \LongTable mode
%%         (they previously generated plain footnotes at the end of the table)
%%
%% 9/21/4: fix bug fix figure and table numbers in the appendicies
%%
%% 10/8/4: add \object \facility \dataset from aastex
%%
%% 11/26/4: Change floats-to-text distance to 5mm in ApJLetter style and
%%          7mm in ApJ style (verified with Journal version in Dec 2004)
%%  
%% 4/21/5: change \renewcommand{\dbltopfraction}{0.85}; add
%%         \renewcommand{\dblfloatpagefraction}{0.85}
%%         \setcounter{topnumber}{9}
%%         \setcounter{bottomnumber}{9}
%%         \setcounter{totalnumber}{20}
%%         \setcounter{dbltopnumber}{9} 
%%
%% 11/27/5: Add parameters to fine-tune spacing to deluxetables:
%%         \abovedeluxetableskip   % = 0 by default
%%         \belowdeluxetableskip   % = 0 
%%
%%         Use these to fiddle with the spacing, e.g. 
%%         \setlength{\abovetableskipamount}{-1\baselineskip}
%%
%% 12/14/5: no more explicit setting of tabcolsep inside deluxetables (so
%%          the user has control over this parameter)
%%
%% 05/04/6: redefine \tableline as \hrule; otherwise it weirdly interact
%%          with my implementation of deluxetable
%%
%% 08/13/6: Collect altaffiltext into token and issue \altaffiliation
%%          only once. This overcomes the problem with 2**n processing 
%%          time for long affiliation lists. 
%%
%% 08/29/6: fix a problem with alignment of last row in deluxetables
%%
%% 09/06/6: Change code of tablenotetext in all deluxetables (otherwise
%%          the change introduced on 6/22/4 sometimes causes the notes to
%%          disappear)
%%
%% 09/19/6: Correct propagation of the [apj] and [apjl] for subsection
%%          formatting 
%%
%% 09/19/6: Appendix no longer changes the numbering for figure and
%%          unless the [appendixfloats] option is selected
%%
%% 09/22/6  Fix a bug with last row in deluxetables after \LongTables
%%
%% 10/04/6  redefine tablenotetext again because hyperref incompatibly
%%          changes the definition of \footnotetext
%%
%% 10/04/6  Fix spacing before thebilbiography and refereneces
%%          (\vspace*->\vspace)
%%
%% 12/01/6  Add \par to the definition of \tablenotetext (to make sure
%%          each note is in a separate block)
%%
%% 02/7/07  By popular demand, \tablenotetext is reintroduced in the 
%%          regular {table} environments. BEWARE: the use of this 
%%          feature makes your documents non-portable as \tablenotetext
%%          is not a part of standard LaTeX
%%
%% 03/7/07  Misc. fixes to \lastpagefootnotes
%%
%% 04/21/07  introduce \affil@mark to facilitate integration with the
%%           MinionPro package; slightly change the spacing in the
%%           altaffiltext mark
%%
%% 03/31/08 new option [tighten] to facilitate grid typesetting (by
%%          setting negative lineskiplimit etc). Correspondingly increase
%%          v-spacing at \enddata in the tables
%% 
%% 04/15/08 improve table@note@skip (put it inside spew@tblnotes)
%%
%% 04/17/08 set baselinestretch to 1
%%
%% 04/20/08 Fix above and below display skips (too much of negative stretch
%%          was possible)
%%
%% 12/19/08 Fix \ion to use relative sizes (not \small); thanks to Gabor
%%          Worseck for pointing this out
%%
%% 12/19/08 Option for IOP formatting: \usepackage[iop,...]{emulateapj}
%%
%% 08/22/09 Fix NAT@sort coding for new release of bibtex
%%
%% 11/10/09 Switch to revtex4-1
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
