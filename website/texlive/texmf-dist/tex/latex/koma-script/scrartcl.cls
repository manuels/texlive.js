%%
%% This is file `scrartcl.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% scrkvers.dtx  (with options: `class,article')
%% scrkbase.dtx  (with options: `load')
%% tocbasic.dtx  (with options: `class,load')
%% scrkcomp.dtx  (with options: `class,article,option')
%% scrkmisc.dtx  (with options: `class,article,option')
%% scrklang.dtx  (with options: `class,article,option')
%% scrkfont.dtx  (with options: `class,article,option')
%% scrktare.dtx  (with options: `class,article,option')
%% scrkpar.dtx  (with options: `class,article,option')
%% scrktitl.dtx  (with options: `class,article,option')
%% scrksect.dtx  (with options: `class,article,option')
%% scrkpage.dtx  (with options: `class,article,option')
%% scrkfloa.dtx  (with options: `class,article,option')
%% scrkftn.dtx  (with options: `class,article,option')
%% scrkliof.dtx  (with options: `class,article,option')
%% scrkbib.dtx  (with options: `class,article,option')
%% scrkidx.dtx  (with options: `class,article,option')
%% scrklist.dtx  (with options: `class,article,option')
%% scrkmisc.dtx  (with options: `class,article,execoption')
%% scrkcomp.dtx  (with options: `class,article,body')
%% scrkfont.dtx  (with options: `class,article,body')
%% scrklang.dtx  (with options: `class,article,body')
%% scrktare.dtx  (with options: `class,article,body')
%% scrkpar.dtx  (with options: `class,article,body')
%% scrktitl.dtx  (with options: `class,article,body')
%% scrksect.dtx  (with options: `class,article,body')
%% scrkmisc.dtx  (with options: `class,article,body')
%% scrkpage.dtx  (with options: `class,article,body')
%% scrkfloa.dtx  (with options: `class,article,body')
%% scrkftn.dtx  (with options: `class,article,body')
%% scrkliof.dtx  (with options: `class,article,body')
%% scrkbib.dtx  (with options: `class,article,body')
%% scrkidx.dtx  (with options: `class,article,body')
%% scrklist.dtx  (with options: `class,article,body')
%% scrlogo.dtx  (with options: `logo')
%% 
%% Copyright (c) 1994-2012
%% Markus Kohm and any individual authors listed elsewhere in this file.
%% 
%% This file was generated from file(s) of the KOMA-Script bundle.
%% ---------------------------------------------------------------
%% 
%% It may be distributed under the conditions of the
%% LaTeX Project Public License in the version distributed together
%% with KOMA-Script, see file `lppl.txt' or `lppl-de.txt'.
%% 
%% This file may only be distributed together with a copy of the
%% KOMA-Script bundle.  You may however distribute the
%% KOMA-Script bundle without all such generated files.  See also
%% `lppl.txt' or `lppl-de.txt' for additional information.
%% 
%% The list of files belonging to KOMA-Script distribution is given in
%% the file `manifest.txt'.  See also `lppl.txt' or `lppl-de.txt' for
%% additional information.
%% 
%% If this file is a beta version, you may not be allowed to distribute
%% it.  Look at the comments below to see if this is the case.
%% 
%% English and German manuals are part of KOMA-Script bundle.
%% ----------------------------------------------------------
%% 
%% See `README'.
%% 
%% The KOMA-Script bundle (but maybe not this file) was based upon the
%% LaTeX 2.09 Script family created by Frank Neukam 1993 and the LaTeX2e
%% standard classes created by The LaTeX3 Project 1994-1996.  You may
%% find a complete unmodified copy of LaTeX2e at
%% <http://www.ctan.org/pub/tex-archive/macros/latex/base/>.
%% 
%%% From File: scrkvers.dtx
\begingroup
  \makeatletter
  \ifx\KOMAScriptVersion\undefined
    \newcommand*{\@CheckKOMAScriptVersion}[1]{%
      \gdef\KOMAScriptVersion{#1}%
    }%
  \else
    \newcommand*{\@CheckKOMAScriptVersion}[1]{%
      \def\@tempa{#1}%
      \ifx\KOMAScriptVersion\@tempa\else
        \@latex@warning@no@line{%
          \noexpand\KOMAScriptVersion\space is
          `\KOMAScriptVersion',\MessageBreak
          but `#1' was expected!\MessageBreak
          You should not use classes, packages or files
          from\MessageBreak
          different KOMA-Script versions%
        }%
      \fi
    }
  \fi
  \@CheckKOMAScriptVersion{2012/05/15 v3.11 KOMA-Script}%
\endgroup
\newcommand*{\KOMAClassName}{%
  scrartcl%
}
\newcommand*{\ClassName}{%
  article%
}
\ProvidesClass{\KOMAClassName}[%
  \KOMAScriptVersion\space document class (\ClassName)%
]
%%% From File: scrkbase.dtx
\RequirePackage{scrkbase}[\KOMAScriptVersion]
%%% From File: tocbasic.dtx
\def\tocbasicversion{2012/04/04 v3.10b}
\edef\@tempa{\noexpand\RequirePackage{tocbasic}[\tocbasicversion]}
\@tempa
\addtotoclist{toc}
\addtotoclist[float]{lof}
\addtotoclist[float]{lot}
%%% From File: scrkcomp.dtx
\newcommand*
  {\scr@compatibility}{\scr@v@last}
\KOMA@key{version}[last]{%
  \scr@ifundefinedorrelax{scr@v@#1}{%
    \def\scr@compatibility{0}%
    \ClassWarningNoLine{\KOMAClassName}{%
      You have set option `version' to value `#1', but\MessageBreak
      this value of version is not supported.\MessageBreak
      Because of this, version was set to `first'%
    }%
  }{%
    \ClassInfoNoLine{\KOMAClassName}{%
      Switching compatibility level to `#1'%
    }%
    \edef\scr@compatibility{\@nameuse{scr@v@#1}}%
  }%
}
\AtEndOfClass{%
  \KOMA@key{version}[]{%
    \ClassError{\KOMAClassName}{%
      Option `version' too late%
    }{%
      Option `version' may be set only while loading the
      class.\MessageBreak
      But you've tried to set it up later.%
    }%
  }%
}
\@namedef{scr@v@first}{0}
\@namedef{scr@v@2.9}{0}
\@namedef{scr@v@2.9t}{0}
\@namedef{scr@v@2.9u}{1}
\@namedef{scr@v@2.95}{2}
\@namedef{scr@v@2.95a}{2}
\@namedef{scr@v@2.95b}{2}
\@namedef{scr@v@2.96}{2}
\@namedef{scr@v@2.96a}{3}
\@namedef{scr@v@2.97}{3}
\@namedef{scr@v@2.97a}{3}
\@namedef{scr@v@2.97b}{3}
\@namedef{scr@v@2.97c}{4}
\@namedef{scr@v@2.97d}{5}
\@namedef{scr@v@2.97e}{6}
\@namedef{scr@v@2.98}{6}
\@namedef{scr@v@2.98a}{6}
\@namedef{scr@v@2.98b}{6}
\@namedef{scr@v@2.98c}{7}
\@namedef{scr@v@3.00}{8}
\@namedef{scr@v@3.01}{8}
\@namedef{scr@v@3.01a}{8}
\@namedef{scr@v@3.01b}{9}
\@namedef{scr@v@3.01c}{9}
\@namedef{scr@v@3.02}{9}
\@namedef{scr@v@3.02b}{9}
\@namedef{scr@v@3.02c}{10}
\@namedef{scr@v@3.03}{10}
\@namedef{scr@v@3.03a}{10}
\@namedef{scr@v@3.03b}{10}
\@namedef{scr@v@3.04}{10}
\@namedef{scr@v@3.04a}{10}
\@namedef{scr@v@3.05}{10}
\@namedef{scr@v@3.05a}{10}
\@namedef{scr@v@3.06}{10}
\@namedef{scr@v@3.07}{10}
\@namedef{scr@v@3.08}{10}
\@namedef{scr@v@3.08a}{10}
\@namedef{scr@v@3.08b}{10}
\@namedef{scr@v@3.09}{10}
\@namedef{scr@v@3.09a}{10}
\@namedef{scr@v@3.10}{10}
\@namedef{scr@v@3.10a}{10}
\@namedef{scr@v@3.10b}{10}
\@namedef{scr@v@3.11}{10}
\@namedef{scr@v@last}{10}
%%% From File: scrkmisc.dtx
\KOMA@key{draft}[true]{%
  \KOMA@set@ifkey{draft}{@tempswa}{#1}%
  \if@tempswa
    \setlength{\overfullrule}{5pt}%
  \else
    \setlength{\overfullrule}{\z@}%
  \fi
}
\KOMA@DeclareStandardOption
{final}{draft=false}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
%%% From File: scrklang.dtx
%%% From File: scrkfont.dtx
\newcommand*\@ptsize{%
  11%
}
\newcommand*{\@pt@scan}{%
  \expandafter\@pt@@scan\CurrentOption pt\@pt@@scan%
}
\newcommand*{\@pt@@scan}{}
\def\@pt@@scan #1pt#2\@pt@@scan{%
  \ifstr{#2}{pt}{%
    \ifnumber{#1}{%
      \KOMA@UseObsoleteOption{\PackageInfoNoLine{\KOMAClassName}}%
                             {#1#2}{fontsize=#1#2}%
    }{\@headlines}%
  }{\@headlines}%
}
\providecommand*{\@fontsizefilebase}{scrsize}
\KOMA@key{fontsize}{%
  \scr@ifundefinedorrelax{changefontsizes}{%
    \@defaultunits\@tempdima#1pt\relax\@nnil
    \edef\@ptsize{#1}%
  }{%
    \expandafter\@defaultunits\expandafter\@tempdima#1 pt\relax\@nnil
    \edef\@tempa{#1}%
    \setlength{\@tempdimb}{\@tempdima}%
    \edef\@tempb{\strip@pt\@tempdimb}%
    \addtolength{\@tempdimb}{-10\p@}%
    \edef\@ptsize{\strip@pt\@tempdimb}%
    \edef\@tempa{%
      \noexpand\makeatletter
      \noexpand\InputIfFileExists{\@fontsizefilebase\@tempa.clo}{%
        \noexpand\ClassInfo{\KOMAClassName}{%
          File `\@fontsizefilebase\@tempa.clo' used to setup font sizes}%
      }{%
        \noexpand\InputIfFileExists{\@fontsizefilebase\@tempb pt.clo}{%
          \noexpand\ClassInfo{\KOMAClassName}{%
            File `\@fontsizefilebase\@tempb pt.clo' used instead of%
            \noexpand\MessageBreak
            file `\@fontsizefilebase\@tempa.clo' to setup font sizes}%
        }{%
          \noexpand\changefontsizes{#1}%
        }%
      }%
      \noexpand\catcode`\noexpand\@=\the\catcode`\@
    }%
    \@tempa
  }%
}
%%% From File: scrktare.dtx
\newcommand*{\@BCOR}{\expandafter\@@BCOR\CurrentOption BCORBCOR\@@BCOR}
\newcommand*{\@@BCOR}{}
\def\@@BCOR #1BCOR#2BCOR#3\@@BCOR{%
  \ifstr{#1}{}{%
    \ifstr{#3}{BCOR}{%
      \PassOptionsToPackage{BCOR#2}{typearea}%
    }{\scr@pti@nerr@r}%
  }{\scr@pti@nerr@r}%
}
\newcommand*{\@DIV}{\expandafter\@@DIV\CurrentOption DIVDIV\@@DIV}
\newcommand*{\@@DIV}{}
\def\@@DIV #1DIV#2DIV#3\@@DIV{%
  \edef\@tempa{#1}\ifx\@tempa\@empty
    \edef\@tempa{#3}\def\@tempb{DIV}\ifx\@tempa\@tempb
      \PassOptionsToPackage{DIV#2}{typearea}%
    \else\scr@pti@nerr@r\fi
  \else\@BCOR\fi
}
\newcommand{\@headlines}{%
  \expandafter\@@headlines\CurrentOption headlines\@@headlines%
}
\newcommand*{\@@headlines}{}
\def\@@headlines #1headlines#2\@@headlines{
  \edef\@tempa{#2}\edef\@tempb{headlines}\ifx\@tempa\@tempb
    \PassOptionsToPackage{#1headlines}{typearea}
  \else\@DIV\fi
}
\newcommand*{\x@paper}{%
  \expandafter\x@@paper\CurrentOption paper\x@@paper%
}
\newcommand*{\x@@paper}{}
\def\x@@paper #1#2paper#3\x@@paper{%
  \ifstr{#3}{paper}{%
    \ifnumber{#2}{%
      \ifstr{#1}{a}{%
        \PassOptionsToPackage{#3=#1#2}{typearea}%
      }{%
        \ifstr{#1}{b}{%
          \PassOptionsToPackage{#3=#1#2}{typearea}%
        }{%
          \ifstr{#1}{c}{%
            \PassOptionsToPackage{#3=#1#2}{typearea}%
          }{%
            \ifstr{#1}{d}{%
              \PassOptionsToPackage{#3=#1#2}{typearea}%
            }{\scr@pti@nerr@r}%
          }%
        }%
      }%
    }{\scr@pti@nerr@r}%
  }{%
    \@pt@scan
  }%
}
\newcommand*{\scr@pti@nerr@r}{
  \OptionNotUsed
}
\KOMA@key{twoside}[true]{%
  \if@atdocument\else\PassOptionsToPackage{twoside=#1}{typearea}\fi%
}
\KOMA@DeclareStandardOption%
  {oneside}{twoside=false}
\KOMA@key{twocolumn}[true]{%
  \if@atdocument\else\PassOptionsToPackage{twocolumn=#1}{typearea}\fi%
}
\KOMA@DeclareStandardOption%
  {onecolumn}{twocolumn=false}
\DeclareOption*{%
  \x@paper}
%%% From File: scrkpar.dtx
\newcommand*{\setparsizes}[3]{%
  \edef\f@parindent{\the\parindent}%
  \edef\f@parskip{\the\parskip}%
  \edef\f@parfillskip{\the\parfillskip}%
  \def\scr@parindent{#1}%
  \def\scr@parskip{#2}%
  \def\scr@parfillskip{#3}%
  \def\par@update{\let\par@update\default@par@update\par@updaterelative}%
}
\newcommand*{\f@parindent}{\the\parindent}
\newcommand*{\f@parskip}{\the\parskip}
\newcommand*{\f@parfillskip}{\the\parfillskip}
\AtEndOfClass{%
  \edef\f@parindent{\the\parindent}%
  \edef\f@parskip{\the\parskip}%
  \edef\f@parfillskip{\the\parfillskip}%
}
\newcommand*{\par@update}{}
\let\par@update\relax
\newcommand*{\default@par@update}{}
\let\default@par@update\relax
\newcommand*{\scr@parindent}{1em}
\newcommand*{\scr@parskip}{\z@}
\newcommand*{\scr@parfillskip}{\z@ \@plus 1fil}
\KOMA@key{parskip}[true]{%
  \begingroup
    \KOMA@set@ncmdkey{parskip}{@tempa}{%
      {never}{0},%
      {false}{1},{off}{1},{no}{1},%
      {full-}{2},%
      {half-}{3},%
      {full}{4},{true}{4},{on}{4},{yes}{4},%
      {half}{5},%
      {full+}{6},%
      {half+}{7},%
      {full*}{8},%
      {half*}{9},%
      {relative}{10},%
      {absolute}{11}%
    }{#1}%
    \ifcase\number\@tempa% 0
      \endgroup
      \setparsizes{1em}{\z@}{\z@ \@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 1
      \endgroup
      \setparsizes{1em}{\z@ \@plus \p@}{\z@ \@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 2
      \endgroup
      \setparsizes{\z@}{\baselineskip \@plus .1\baselineskip}{%
        \z@ \@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 3
      \endgroup
      \setparsizes{\z@}{.5\baselineskip \@plus .5\baselineskip}{%
        \z@ \@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 4
      \endgroup
      \setparsizes{\z@}{\baselineskip \@plus .1\baselineskip}{%
        1em \@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 5
      \endgroup
      \setparsizes{\z@}{.5\baselineskip \@plus .5\baselineskip}{%
        1em \@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 6
      \endgroup
      \setparsizes{\z@}{\baselineskip \@plus .1\baselineskip}{%
        .3333\linewidth\@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 7
      \endgroup
      \setparsizes{\z@}{.5\baselineskip \@plus .5\baselineskip}{%
        .3333\linewidth \@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 8
      \endgroup
      \setparsizes{\z@}{\baselineskip \@plus .1\baselineskip}{%
        .25\linewidth \@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 9
      \endgroup
      \setparsizes{\z@}{.5\baselineskip \@plus .5\baselineskip}{%
        .25\linewidth \@plus 1fil}%
      \if@atdocument\AfterKOMAoptions{\selectfont}\fi
    \or% 10
      \endgroup
      \ifx\par@updaterelative\undefined
        \expandafter\AtEndOfClass
      \else
        \expandafter\@firstofone
      \fi
      {%
        \ifx\par@update\default@par@update
          \let\par@update\par@updaterelative
        \fi
        \let\default@par@update=\par@updaterelative
      }%
    \or%11
      \endgroup
      \ifx\par@updaterelative\undefined
        \expandafter\AtEndOfClass
      \else
        \expandafter\@firstofone
      \fi
      {%
        \ifx\par@update\default@par@update
          \let\par@update\relax
        \fi
        \let\default@par@update=\relax
      }%
    \else% sonst
      \endgroup
  \fi
}
\KOMA@DeclareDeprecatedOption{parskip-}{parskip=full-}
\KOMA@DeclareDeprecatedOption{parskip+}{parskip=full+}
\KOMA@DeclareDeprecatedOption{parskip*}{parskip=full*}
\KOMA@DeclareDeprecatedOption{halfparskip}{parskip=half}
\KOMA@DeclareDeprecatedOption{halfparskip-}{parskip=half-}
\KOMA@DeclareDeprecatedOption{halfparskip+}{parskip=half+}
\KOMA@DeclareDeprecatedOption{halfparskip*}{parskip=half*}
\KOMA@DeclareDeprecatedOption{parindent}{parskip=false}
%%% From File: scrktitl.dtx
\newif\if@titlepage
\@titlepagefalse
\KOMA@ifkey{titlepage}{@titlepage}%
\KOMA@DeclareStandardOption%
  {notitlepage}{titlepage=false}
\newif\if@abstrt\@abstrtfalse
\KOMA@ifkey{abstract}{@abstrt}
\KOMA@DeclareStandardOption{abstracton}{abstract=true}
\KOMA@DeclareStandardOption{abstractoff}{abstract=false}
%%% From File: scrksect.dtx
%% \fi
\newcommand*{\scr@dotchangeatdocument}[1]{%
  \ClassError{\KOMAClassName}{%
    change of end dot feature after \string\begin{document}%
  }{%
    You've tried to set `numbers=#1' after \string\begin{document},\MessageBreak
    but this option is only allowed at the document preamble.\MessageBreak
    See KOMA-Script manual for more information about.%
  }%
}
\KOMA@key{numbers}{%
  \KOMA@set@ncmdkey{numbers}{@tempa}{%
    {autoendperiod}{0},{autoenddot}{0},{auto}{0},%
    {endperiod}{1},{withendperiod}{1},{periodatend}{1},%
    {enddot}{1},{withenddot}{1},{dotatend}{1},%
    {noendperiod}{2},{noperiodatend}{2},%
    {noenddot}{2},{nodotatend}{2}%
  }{#1}%
  \ifcase \@tempa\relax
    \if@atdocument\scr@dotchangeatdocument{#1}\else
      \let\scr@altsecnumhook\@empty
    \fi
  \or
    \if@atdocument\scr@dotchangeatdocument{#1}\else
      \let\scr@altsecnumhook\scr@altsecnumhooktrue
    \fi
  \or
    \if@atdocument\scr@dotchangeatdocument{#1}\else
      \let\scr@altsecnumhook\scr@altsecnumhookfalse
    \fi
  \fi
}
\newcommand*{\scr@altsecnumhook}{}
\AtBeginDocument{\scr@altsecnumhook}
\newcommand*{\scr@altsecnumhooktrue}{%
  \@altsecnumformattrue\global\let\@altsecnumformatfalse\@altsecnumformattrue
}
\newcommand*{\scr@altsecnumhookfalse}{%
  \@altsecnumformatfalse\global\let\@altsecnumformattrue\@altsecnumformatfalse
}
\KOMA@DeclareDeprecatedOption{pointednumbers}{numbers=enddot}
\KOMA@DeclareDeprecatedOption{pointlessnumbers}{numbers=noenddot}
\newcommand*{\size@part}{}
\newcommand*{\size@partnumber}{}
\newcommand*{\size@section}{}
\newcommand*{\size@subsection}{}
\newcommand*{\size@subsubsection}{}
\newcommand*{\size@paragraph}{}
\newcommand*{\size@subparagraph}{}
\newcommand*{\chapterheadstartvskip}{}
\newcommand*{\chapterheadendvskip}{}
\KOMA@key{headings}{%
  \KOMA@set@ncmdkey{headings}{@tempa}{%
    {big}{0},%
    {normal}{1},%
    {small}{2},%
    {optiontotocandhead}{10},{optiontoheadandtoc}{10},%
    {optiontotoc}{11},%
    {optiontohead}{12}%
  }{#1}%
  \ifcase \@tempa\relax
    \renewcommand*{\size@part}{\Huge}%
    \renewcommand*{\size@partnumber}{\huge}%
    \renewcommand*{\size@section}{\Large}%
    \renewcommand*{\size@subsection}{\large}%
    \renewcommand*{\size@subsubsection}{\normalsize}%
    \renewcommand*{\size@paragraph}{\normalsize}%
    \renewcommand*{\size@subparagraph}{\normalsize}%
  \or
    \renewcommand*{\size@part}{\huge}%
    \renewcommand*{\size@partnumber}{\huge}%
    \renewcommand*{\size@section}{\large}%
    \renewcommand*{\size@subsection}{\normalsize}%
    \renewcommand*{\size@subsubsection}{\normalsize}%
    \renewcommand*{\size@paragraph}{\normalsize}%
    \renewcommand*{\size@subparagraph}{\normalsize}%
  \or
    \renewcommand*{\size@part}{\LARGE}%
    \renewcommand*{\size@partnumber}{\LARGE}%
    \renewcommand*{\size@section}{\normalsize}%
    \renewcommand*{\size@subsection}{\normalsize}%
    \renewcommand*{\size@subsubsection}{\normalsize}%
    \renewcommand*{\size@paragraph}{\normalsize}%
    \renewcommand*{\size@subparagraph}{\normalsize}%
  \or
  \or
  \or
  \or
  \or
  \or
  \or
  \or
    \scr@activate@xsection{3}%
  \or
    \scr@activate@xsection{2}%
  \or
    \scr@activate@xsection{1}%
  \fi
}
\KOMA@DeclareDeprecatedOption{bigheadings}{headings=big}
\KOMA@DeclareDeprecatedOption{normalheadings}{headings=normal}
\KOMA@DeclareDeprecatedOption{smallheadings}{headings=small}
\newcommand*{\scr@osectarg}{0}
\newcommand*{\scr@activate@xsection}[1]{%
  \renewcommand*{\scr@osectarg}{#1}%
}
%%% From File: scrkpage.dtx
\newif\if@hsl
\KOMA@key{headsepline}[true]{%
  \KOMA@set@ifkey{headsepline}{@hsl}{#1}%
  \KOMA@options{headinclude=#1}{}%
}
\KOMA@DeclareDeprecatedOption{headnosepline}{headsepline=false}
\newif\if@fsl
\KOMA@key{footsepline}[true]{%
  \KOMA@set@ifkey{footsepline}{@fsl}{#1}%
  \KOMA@options{footinclude=#1}{}%
}
\KOMA@DeclareDeprecatedOption{footnosepline}{footsepline=false}
\@twosidefalse
\KOMA@key{cleardoublepage}{%
  \begingroup%
    \def\@tempc{%
      \endgroup%
      \KOMA@unknown@keyval{cleardoublepage}{#1}{%
        'current' or any defined pagestyle e.g. 'empty','plain'}%
    }%
    \ifstr{#1}{current}{%
      \def\@tempc{\endgroup%
        \def\cleardoublepage{\cleardoublestandardpage}%
        \def\cleardoubleoddpage{\cleardoubleoddstandardpage}%
        \def\cleardoubleevenpage{\cleardoubleevenstandardpage}%
      }%
    }{%
      \ifnotundefined{ps@#1}{%
        \def\@tempc{\endgroup%
          \def\cleardoublepage{\cleardoublepageusingstyle{#1}}%
          \def\cleardoubleoddpage{\cleardoubleoddpageusingstyle{#1}}%
          \def\cleardoubleevenpage{\cleardoubleevenpageusingstyle{#1}}%
        }%
      }{}%
    }%
  \@tempc
}
\newcommand*{\cleardoubleoddstandardpage}{}
\let\cleardoubleoddstandardpage=\cleardoublepage
\newcommand*{\cleardoubleoddpageusingstyle}[1]{\clearpage
  {\pagestyle{#1}\cleardoubleoddstandardpage}}
\newcommand*{\cleardoubleoddemptypage}{\cleardoubleoddpageusingstyle{empty}}
\newcommand*{\cleardoubleoddplainpage}{\cleardoubleoddpageusingstyle{plain}}
\newcommand*{\cleardoubleevenstandardpage}{%
  \clearpage
  \if@twoside\ifodd\c@page
      \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi
  \fi\fi
}
\newcommand*{\cleardoubleevenpageusingstyle}[1]{\clearpage
  {\pagestyle{#1}\cleardoubleevenstandardpage}}
\newcommand*{\cleardoubleevenemptypage}{\cleardoubleevenpageusingstyle{empty}}
\newcommand*{\cleardoubleevenplainpage}{\cleardoubleevenpageusingstyle{plain}}
\newcommand*{\cleardoublestandardpage}{\cleardoubleoddstandardpage}
\renewcommand*{\cleardoublepage}{%
  \expandafter\ifnum \@nameuse{scr@v@2.98c}<\scr@compatibility\relax
    \cleardoubleemptypage
  \else
    \cleardoublestandardpage
  \fi
}
\newcommand*{\cleardoubleoddpage}{\cleardoubleoddemptypage}
\newcommand*{\cleardoubleevenpage}{\cleardoubleevenemptypage}
\newcommand*{\cleardoublepageusingstyle}[1]{\clearpage
  {\pagestyle{#1}\cleardoublestandardpage}}
\newcommand*{\cleardoubleemptypage}{\cleardoublepageusingstyle{empty}}
\newcommand*{\cleardoubleplainpage}{\cleardoublepageusingstyle{plain}}
\KOMA@DeclareDeprecatedOption{cleardoubleempty}{cleardoublepage=empty}
\KOMA@DeclareDeprecatedOption{cleardoubleplain}{cleardoublepage=plain}
\KOMA@DeclareDeprecatedOption{cleardoublestandard}{cleardoublepage=current}
%%% From File: scrkfloa.dtx
\newif\if@captionabove\@captionabovefalse
\newif\if@tablecaptionabove\@tablecaptionabovefalse
\newif\if@figurecaptionabove\@figurecaptionabovefalse
\newif\ifonelinecaptions\onelinecaptionstrue
\newcommand*{\scap@pos}{r}
\newcommand*{\scap@valign}{b}
\KOMA@key{captions}{%
  \KOMA@set@ncmdkey{captions}{@tempa}{%
    {heading}{0},{above}{0},{top}{0},%
    {signature}{1},{below}{1},{bot}{1},{bottom}{1},%
    {tableheading}{2},%
    {tableabove}{2},{abovetable}{2},{abovetabular}{2},{topattable}{2},%
    {tablesignature}{3},%
    {tablebelow}{3},{belowtable}{3},{belowtabular}{3},{bottomattable}{3},%
    {figureheading}{4},{figureabove}{4},{abovefigure}{4},{topatfigure}{4},%
    {figuresignature}{5},{figurebelow}{5},{belowfigure}{5},{bottomatfigure}{5},%
    {oneline}{6},%
    {nooneline}{7},%
    {rightbeside}{8},{besideright}{8},%
    {leftbeside}{9},{besideleft}{9},%
    {innerbeside}{10},{besideinner}{10},%
    {outerbeside}{11},{besideouter}{11},%
    {topbeside}{12},{besidetop}{12},%
    {centeredbeside}{13},{besidecentered}{13},%
    {middlebeside}{13},{besidemiddle}{13},%
    {bottombeside}{14},{besidebottom}{14}%
  }{#1}%
  \ifcase \@tempa\relax
    \@tablecaptionabovetrue
    \@figurecaptionabovetrue
    \@captionabovetrue
  \or
    \@tablecaptionabovefalse
    \@figurecaptionabovefalse
    \@captionabovefalse
  \or
    \@tablecaptionabovetrue
  \or
    \@tablecaptionabovefalse
  \or
    \@figurecaptionabovetrue
  \or
    \@figurecaptionabovefalse
  \or
    \onelinecaptionstrue
  \or
    \onelinecaptionsfalse
  \or
    \renewcommand*{\scap@pos}{r}%
  \or
    \renewcommand*{\scap@pos}{l}%
  \or
    \renewcommand*{\scap@pos}{i}%
  \or
    \renewcommand*{\scap@pos}{o}%
  \or
    \renewcommand*{\scap@valign}{t}%
  \or
    \renewcommand*{\scap@valign}{c}%
  \or
    \renewcommand*{\scap@valign}{b}%
  \fi
}
\KOMA@DeclareDeprecatedOption{tablecaptionabove}{captions=tableheading}
\KOMA@DeclareDeprecatedOption{tablecaptionbelow}{captions=tablesignature}
\newif\if@komalongtable\@komalongtabletrue
\DeclareOption{origlongtable}{\@komalongtablefalse}
\KOMA@DeclareDeprecatedOption{onelinecaption}{captions=oneline}
\KOMA@DeclareDeprecatedOption{noonelinecaption}{captions=nooneline}
%%% From File: scrkftn.dtx
\KOMA@key{footnotes}{%
  \ifx\@footnotemark\scr@saved@footnotemark
  \else
    \ifx\@footnotemark\scr@footnotemark
    \else
      \ClassWarning{\KOMAClassName}{%
        Change of `\string\@footnotemark' detected!\MessageBreak
        Use of `footnotes=#1' may break\MessageBreak
        another package!\MessageBreak
        Maybe you should remove the usage of\MessageBreak
        option `footnotes=#1'}%
    \fi
  \fi
  \ifstr{#1}{multiple}{%
    \let\@footnotemark\scr@footnotemark
    \def\FN@mf@prepare{\scr@mf@prepare}%
    \def\scr@footmisc@options{multiple}%
  }{%
    \ifstr{#1}{nomultiple}{%
      \let\@footnotemark\scr@saved@footnotemark
      \let\FN@mf@prepare\relax
      \let\scr@footmisc@options\@empty
    }{%
      \KOMA@unknown@keyval{footnotes}{#1}{`multiple' and `nomultiple'}%
    }%
  }%
}
\newcommand*{\scr@footmisc@options}{}
\PassOptionsToPackage{\noexpand\scr@footmisc@options}{footmisc}
\newcommand*{\scr@saved@footnotemark}{%
  \leavevmode
  \ifhmode\edef\@x@sf{\the\spacefactor}\nobreak\fi
  \@makefnmark
  \ifhmode\spacefactor\@x@sf\fi
  \relax}
\expandafter\CheckCommand\expandafter*\expandafter\@footnotemark
\expandafter{\scr@saved@footnotemark}
\newcommand*{\scr@footnotemark}{%
  \leavevmode
  \ifhmode\edef\@x@sf{\the\spacefactor}\FN@mf@check\nobreak\fi
  \@makefnmark
  \csname FN@mf@prepare\endcsname
  \ifhmode\spacefactor\@x@sf\fi
  \relax}
%%% From File: scrkliof.dtx
\newif\if@tocleft
\KOMA@key{toc}{%
  \KOMA@set@ncmdkey{toc}{@tempa}{%
    {noindex}{0},{noidx}{0},%
    {index}{1},{idx}{1},%
    {nolistof}{2},%
    {listof}{3},%
    {listofnumbered}{4},{numberedlistof}{4},%
    {nobibliography}{5},{nobib}{5},%
    {bibliography}{6},{bib}{6},%
    {bibliographynumbered}{7},{bibnumbered}{7},{numberedbibliography}{7},%
    {numberedbib}{7},%
    {flat}{8},{left}{8},%
    {graduated}{9},{indent}{9},{indented}{9}%
  }{#1}%
  \ifcase \@tempa\relax
    \KOMA@options{index=notoc}{}%
  \or
    \KOMA@options{index=totoc}{}%
  \or
    \KOMA@options{listof=notoc}{}%
  \or
    \KOMA@options{listof=totoc}{}%
  \or
    \KOMA@options{listof=numbered}{}%
  \or
    \KOMA@options{bibliography=nottotoc}{}%
  \or
    \KOMA@options{bibliography=totoc}{}%
  \or
    \KOMA@options{bibliography=totocnumbered}{}%
  \or
    \@toclefttrue
  \or
    \@tocleftfalse
  \fi
}
\KOMA@DeclareDeprecatedOption{tocleft}{toc=flat}
\KOMA@DeclareDeprecatedOption{tocindent}{toc=graduated}
\newcommand*{\float@@listhead}{%
  \section*
}
\newif\if@dynlist
\KOMA@key{listof}{%
  \KOMA@set@ncmdkey{listof}{@tempa}{%
    {notoc}{0},{nottotoc}{0},{plainheading}{0},%
    {totoc}{1},{toc}{1},{notnumbered}{1},%
    {numbered}{2},{totocnumbered}{2},{tocnumbered}{2},{numberedtotoc}{2},%
    {numberedtoc}{2},%
    {flat}{3},{left}{3},%
    {graduated}{4},{indent}{4},{indented}{4},%
    {leveldown}{5},
    {entryprefix}{6},
  }{#1}%
  \ifcase \@tempa\relax
    \renewcommand*{\float@@listhead}{%
    \section*
    }%
    \doforeachtocfile[float]{%
      \unsettoc{\@currext}{numbered}%
      \unsettoc{\@currext}{totoc}%
    }%
    \AtAddToTocList[float]{%
      \unsettoc{\@currext}{numbered}%
      \unsettoc{\@currext}{totoc}%
    }%
  \or% totoc
    \renewcommand*{\float@@listhead}{%
    \addsec
    }%
    \doforeachtocfile[float]{%
      \unsettoc{\@currext}{numbered}%
      \setuptoc{\@currext}{totoc}%
    }%
    \AtAddToTocList[float]{%
      \unsettoc{\@currext}{numbered}%
      \setuptoc{\@currext}{totoc}%
    }%
  \or% numbered
    \renewcommand*{\float@@listhead}{%
    \section
    }%
    \doforeachtocfile[float]{%
      \setuptoc{\@currext}{numbered}%
      \setuptoc{\@currext}{totoc}%
    }%
    \AtAddToTocList[float]{%
      \setuptoc{\@currext}{numbered}%
      \setuptoc{\@currext}{totoc}%
    }%
  \or% flat
    \@dynlisttrue
  \or% graduated
    \@dynlistfalse
  \or% leveldown
    \doforeachtocfile[float]{%
      \setuptoc{\@currext}{leveldown}%
    }%
    \AtAddToTocList[float]{%
      \setuptoc{\@currext}{leveldown}%
    }%
  \or% entryprefix
    \@dynlisttrue
    \doforeachtocfile[float]{%
      \BeforeStartingTOC[\@currext]{%
        \scr@ifundefinedorrelax{listof\@currext entryname}{}{%
          \expandafter\def\expandafter\numberline@prefix
          \expandafter{\csname listof\@currext entryname\endcsname
            \nobreakspace}%
        }%
      }%
    }%
    \AtAddToTocList[float]{%
      \BeforeStartingTOC[\@currext]{%
        \scr@ifundefinedorrelax{listof\@currext entryname}{}{%
          \expandafter\def\expandafter\numberline@prefix
          \expandafter{\csname listof\@currext entryname\endcsname
            \nobreakspace}%
        }%
      }%
    }%
  \fi
}
\KOMA@DeclareDeprecatedOption{liststotoc}{listof=totoc}
\KOMA@DeclareDeprecatedOption{liststotocnumbered}{listof=numbered}
\KOMA@DeclareDeprecatedOption{listsleft}{listof=flat}
\KOMA@DeclareDeprecatedOption{listsindent}{listof=graduated}
%%% From File: scrkbib.dtx
\newcommand{\newbibstyle}[3][]{%
  \scr@ifundefinedorrelax{scr@bibstyle@#2}{%
    \scr@ifundefinedorrelax{scr@bibstyle@#1}{%
      \ClassError{\KOMAClassName}{%
        parent bibliography style `#1' does not exist}{%
        You've told me to define the new bibliography style `#2'\MessageBreak
        to be a child of bibliography style `#1', but bibliography
        style\MessageBreak
        `#1' does not exist.\MessageBreak
        You have to remove the parent declaration or use an existing parent!
        See the KOMA-Script manual for more information.%
      }%
    }{%
      \@namedef{scr@bibstyle@#2}{%
        \let\@openbib@code\@empty
        \let\newblock\@empty
        \let\bib@beginhook\@empty
        \let\bib@endhook\@empty
        \csname scr@bibstyle@#1\endcsname
        #3%
      }%
      \g@addto@macro\scr@bibstylelist{, `#2'}%
    }%
  }{%
    \ClassError{\KOMAClassName}{bibliography style `#2' already exists}{%
      You've told me to define the new bibliography style `#2',\MessageBreak
      but this style already exists.\MessageBreak
      You have to use another bibliography style name.\MessageBreak
      See the KOMA-Script manual for more information.%
    }%
  }%
}
\newcommand*{\scr@bibstyle@}{}
\newcommand*{\bib@beginhook}{}
\newcommand*{\bib@endhook}{}
\newcommand*{\scr@bibstylelist}{\@gobble}
\newcommand*{\@openbib@code}{}
\newcommand*{\newblock}{}
\newbibstyle{openstyle}{%
  \renewcommand*{\@openbib@code}{%
    \advance\leftmargin\bibindent
    \itemindent -\bibindent
    \listparindent \itemindent
    \parsep \z@
  }%
  \renewcommand*{\newblock}{\par}%
}
\newbibstyle{oldstyle}{%
  \renewcommand*{\newblock}{\hskip .11em\@plus.33em\@minus.07em}%
}
\scr@bibstyle@oldstyle
\newcommand*\bib@heading{%
  \section*{\refname}%
  \@mkboth{\MakeMarkcase{\refname}}{\MakeMarkcase{\refname}}%
}
\KOMA@key{bibliography}{%
  \scr@ifundefinedorrelax{scr@bibstyle@#1}{%
    \let\FamilyElseValues\scr@bibstylelist
    \KOMA@set@ncmdkey{bibliography}{@tempa}{%
      {notoc}{0},{nottotoc}{0},{plainheading}{0},%
      {totoc}{1},{toc}{1},{notnumbered}{1},%
      {numbered}{2},{totocnumbered}{2},{tocnumbered}{2},{numberedtotoc}{2},%
      {numberedtoc}{2}%
    }{#1}%
    \ifcase \@tempa\relax
      \renewcommand*\bib@heading{%
        \section*{\refname}%
        \@mkboth{\MakeMarkcase{\refname}}{\MakeMarkcase{\refname}}%
      }%
    \or% totoc
      \renewcommand*\bib@heading{%
        \addsec{\refname}%
        \@mkboth{\MakeMarkcase{\refname}}{\MakeMarkcase{\refname}}%
      }%
    \or% numbered
      \renewcommand*\bib@heading{%
        \section{\refname}%
        \@mkboth{\MakeMarkcase{\sectionmarkformat \refname}}%
                {\MakeMarkcase{\sectionmarkformat \refname}}%
      }
    \fi
  }{%
    \csname scr@bibstyle@#1\endcsname
  }%
}
\KOMA@DeclareStandardOption{openbib}{bibliography=openstyle}
\KOMA@DeclareDeprecatedOption{bibtotoc}{bibliography=totoc}
\KOMA@DeclareDeprecatedOption{bibtotocnumbered}{bibliography=totocnumbered}
%%% From File: scrkidx.dtx
\newcommand*{\idx@@heading}{%
  \section*
}
\KOMA@key{index}{%
  \KOMA@set@ncmdkey{index}{@tempa}{%
    {notoc}{0},{nottotoc}{0},{default}{0},{plainheading}{0},%
    {totoc}{1},{toc}{1},{notnumbered}{1}%
  }{#1}%
  \ifcase \@tempa\relax
    \renewcommand*{\idx@@heading}{%
    \section*
    }%
  \or
    \renewcommand*{\idx@@heading}{%
    \addsec
    }%
  \fi
}
\KOMA@DeclareDeprecatedOption{idxtotoc}{index=totoc}
%%% From File: scrklist.dtx
%%% From File: scrkmisc.dtx
\KOMAExecuteOptions{%
  parskip=false,%
  headings=big%
}
\KOMAProcessOptions\relax
%%% From File: scrkcomp.dtx
%%% From File: scrkfont.dtx
\newcommand*{\changefontsizes}[2][1.2\@tempdima]{%
  \ClassWarning{\KOMAClassName}{%
    Using fallback calculation to setup font sizes\MessageBreak
    for basic size `#2'}%
  \scr@ifundefinedorrelax{dimexpr}{%
    \ClassError{\KOMAClassName}{%
      feature only allowed using e-TeX%
    }{%
      The fallback calculation to setup font sizes was implemented
      using e-TeX.\MessageBreak
      You should not continue, because the fallback calculation would fail%
    }
  }{%
    \@defaultunits\@tempdima#2pt\relax\@nnil
    \setlength{\@tempdimc}{\@tempdima}%
    \addtolength{\@tempdimc}{-10\p@}%
    \edef\@ptsize{\strip@pt\@tempdimc}%
    \@defaultunits\@tempdimb#1pt\relax\@nnil
    \setlength{\@tempdimc}{\dimexpr (100\@tempdimb / \@tempdima * \p@)}%
    \edef\@tempb{\the\@tempdimc}%
    \setlength{\@tempdimc}{\@tempdima}%
    \def\@tempa##1##2##3##4##5\@nnil{\def##1{##2.##3##4}}%
    \expandafter\@tempa\expandafter\@tempb\@tempb\@nnil%
    \setlength{\abovedisplayskip}{%
      \@tempdima \@plus .25\@tempdima \@minus .58\@tempdima}%
    \setlength{\abovedisplayshortskip}{\z@ \@plus .25\@tempdima}%
    \setlength{\belowdisplayskip}{\abovedisplayskip}%
    \setlength{\belowdisplayshortskip}{%
      .55\@tempdima \@plus .3\@tempdima \@minus .25\@tempdima}%
    \edef\normalsize{%
      \noexpand\@setfontsize\noexpand\normalsize
      {\the\@tempdima}{\the\@tempdimb}%
      \abovedisplayskip \the\abovedisplayskip
      \abovedisplayshortskip \the\abovedisplayshortskip
      \belowdisplayskip \the\belowdisplayskip
      \belowdisplayshortskip \the\belowdisplayshortskip
      \let\noexpand\@listi\noexpand\@listI
    }%
    \setlength{\@tempdima}{0.9125\@tempdimc}%
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \setlength{\abovedisplayskip}{%
      \@tempdima \@plus .25\@tempdima \@minus .58\@tempdima}%
    \setlength{\abovedisplayshortskip}{\z@ \@plus .25\@tempdima}%
    \setlength{\belowdisplayskip}{\abovedisplayskip}%
    \setlength{\belowdisplayshortskip}{%
      .55\@tempdima \@plus .3\@tempdima \@minus .25\@tempdima}%
    \edef\small{%
      \noexpand\@setfontsize\noexpand\small
      {\the\@tempdima}{\the\@tempdimb}%
      \abovedisplayskip \the\abovedisplayskip
      \abovedisplayshortskip \the\abovedisplayshortskip
      \belowdisplayskip \the\belowdisplayskip
      \belowdisplayshortskip \the\belowdisplayshortskip
      \let\noexpand\@listi\noexpand\@listi@small
    }%
    \setlength{\@tempdima}{.83334\@tempdimc}%
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \setlength{\abovedisplayskip}{%
      \@tempdima \@plus .25\@tempdima \@minus .58\@tempdima}%
    \setlength{\abovedisplayshortskip}{\z@ \@plus .25\@tempdima}%
    \setlength{\belowdisplayskip}{\abovedisplayskip}%
    \setlength{\belowdisplayshortskip}{%
      .55\@tempdima \@plus .3\@tempdima \@minus .25\@tempdima}%
    \edef\footnotesize{%
      \noexpand\@setfontsize\noexpand\footnotesize
      {\the\@tempdima}{\the\@tempdimb}%
      \abovedisplayskip \the\abovedisplayskip
      \abovedisplayshortskip \the\abovedisplayshortskip
      \belowdisplayskip \the\belowdisplayskip
      \belowdisplayshortskip \the\belowdisplayshortskip
      \let\noexpand\@listi\noexpand\@listi@footnotesize
    }%
    \setlength{\@tempdima}{.66667\@tempdimc}%
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \edef\scriptsize{%
      \noexpand\@setfontsize\noexpand\scriptsize
      {\the\@tempdima}{\the\@tempdimb}%
    }%
    \setlength{\@tempdima}{.5\@tempdimc}%
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \edef\tiny{%
      \noexpand\@setfontsize\noexpand\tiny
      {\the\@tempdima}{\the\@tempdimb}%
    }%
    \setlength{\@tempdima}{1.2\@tempdimc}%
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \edef\large{%
      \noexpand\@setfontsize\noexpand\large
      {\the\@tempdima}{\the\@tempdimb}%
    }%
    \setlength{\@tempdima}{1.44\@tempdimc}%
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \edef\Large{%
      \noexpand\@setfontsize\noexpand\Large
      {\the\@tempdima}{\the\@tempdimb}%
    }%
    \setlength{\@tempdima}{1.728\@tempdimc}%
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \edef\LARGE{%
      \noexpand\@setfontsize\noexpand\LARGE
      {\the\@tempdima}{\the\@tempdimb}%
    }%
    \setlength{\@tempdima}{2.074\@tempdimc}%
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \edef\huge{%
      \noexpand\@setfontsize\noexpand\huge
      {\the\@tempdima}{\the\@tempdimb}%
    }%
    \setlength{\@tempdima}{2.488\@tempdimc}%
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \edef\Huge{%
      \noexpand\@setfontsize\noexpand\Huge
      {\the\@tempdima}{\the\@tempdimb}%
    }%
    \normalsize
    \setlength{\footnotesep}{.7\@tempdimc}%
    \setlength{\skip\footins}{.9\@tempdimc \@plus .3333\@tempdimc \@minus
      .6\@tempdimc}%
    \setlength{\floatsep}{\@tempdimc \@plus .1667\@tempdimc \@minus
      .3333\@tempdimc}%
    \setlength{\textfloatsep}{1.6667\@tempdimc \@plus .1667\@tempdimc \@minus
      .3333\@tempdimc}%
    \setlength{\intextsep}{\@tempb\@tempdimc \@plus .3333\@tempdimc \@minus
      .3333\@tempdimc}%
    \setlength{\dblfloatsep}{\@tempb\@tempdimc \@plus .1667\@tempdimc \@minus
      .3333\@tempdimc}%
    \setlength{\dbltextfloatsep}{\textfloatsep}%
    \setlength{\@fptop}{0\p@ \@plus 1fil}%
    \setlength{\@fpsep}{.8333\@tempdimc \@plus 2fil}%
    \setlength{\@fpbot}{\@fptop}%
    \setlength{\@dblfptop}{0\p@ \@plus 1fil}%
    \setlength{\@dblfpsep}{.8333\@tempdimc \@plus 2fil}%
    \setlength{\@dblfpbot}{\@fptop}%
    \setlength{\partopsep}{.25\@tempdimc \@plus .16667\@tempdimc \@minus
      .16667\@tempdimc}%
    \setlength{\topsep}{.8333\@tempdimc \@plus .3333\@tempdimc \@minus
      .5\@tempdimc}%
    \setlength{\parsep}{.4167\@tempdimc \@plus .2083\@tempdimc \@minus \p@}%
    \@tempswafalse
    \begingroup
      \def\@list@extra{\aftergroup\@tempswatrue}%
      \csname @listi\endcsname
    \endgroup
    \edef\@listi{\leftmargin\leftmargini
      \topsep \the\topsep
      \parsep \the\parsep
      \itemsep \parsep
      \if@tempswa\noexpand\@list@extra\fi
    }%
    \let\@listI\@listi
    \setlength{\topsep}{.75\@tempdimc \@plus .25\@tempdimc \@minus
      .41667\@tempdimc}%
    \setlength{\parsep}{.375\@tempdimc \@plus .16667\@tempdimc \@minus \p@}%
    \@tempswafalse
    \begingroup
      \def\@list@extra{\aftergroup\@tempswatrue}%
      \csname @listi\endcsname
    \endgroup
    \edef\@listi@small{\leftmargin\leftmargini
      \topsep \the\topsep
      \parsep \the\parsep
      \itemsep \parsep
      \if@tempswa\noexpand\@list@extra\fi
    }%
    \setlength{\topsep}{.5\@tempdimc \@plus .16667\@tempdimc \@minus
      .16667\@tempdimc}%
    \setlength{\parsep}{.25\@tempdimc \@plus .16667\@tempdimc \@minus \p@}%
    \@tempswafalse
    \begingroup
      \def\@list@extra{\aftergroup\@tempswatrue}%
      \csname @listi\endcsname
    \endgroup
    \edef\@listi@footnotesize{\leftmargin\leftmargini
      \topsep \the\topsep
      \parsep \the\parsep
      \itemsep \parsep
      \if@tempswa\noexpand\@list@extra\fi
    }%
    \setlength{\topsep}{.4167\@tempdimc \@plus .2083\@tempdimc \@minus \p@}%
    \setlength{\parsep}{.2083\@tempdimc \@plus \p@ \@minus \p@}%
    \@tempswafalse
    \begingroup
      \def\@list@extra{\aftergroup\@tempswatrue}%
      \csname @listii\endcsname
    \endgroup
    \edef\@listii{\leftmargin\leftmarginii
      \labelwidth=\dimexpr \leftmargin-\labelsep
      \topsep \the\topsep
      \parsep \the\parsep
      \itemsep \parsep
      \if@tempswa\noexpand\@list@extra\fi
    }%
    \setlength{\topsep}{.2083\@tempdimc \@plus \p@ \@minus \p@}%
    \setlength{\parsep}{\p@ \@plus\z@ \@minus\p@}%
    \@tempswafalse
    \begingroup
      \def\@list@extra{\aftergroup\@tempswatrue}%
      \csname @listiii\endcsname
    \endgroup
    \edef\@listiii{\leftmargin\leftmarginiii
      \labelwidth=\dimexpr \leftmargin-\labelsep
      \topsep \the\topsep
      \parsep \z@
      \partopsep \the\parsep
      \itemsep \topsep
      \if@tempswa\noexpand\@list@extra\fi
    }%
    \@tempswafalse
    \begingroup
      \def\@list@extra{\aftergroup\@tempswatrue}%
      \csname @listiv\endcsname
    \endgroup
    \edef\@listiv{\leftmargin\leftmarginiv
      \labelwidth=\dimexpr \leftmargin-\labelsep
      \if@tempswa\noexpand\@list@extra\fi
    }%
    \@tempswafalse
    \begingroup
      \def\@list@extra{\aftergroup\@tempswatrue}%
      \csname @listv\endcsname
    \endgroup
    \edef\@listv{\leftmargin\leftmarginv
      \labelwidth=\dimexpr \leftmargin-\labelsep
      \if@tempswa\noexpand\@list@extra\fi
    }%
    \@tempswafalse
    \begingroup
      \def\@list@extra{\aftergroup\@tempswatrue}%
      \csname @listvi\endcsname
    \endgroup
    \edef\@listvi{\leftmargin\leftmarginvi
      \labelwidth=\dimexpr \leftmargin-\labelsep
      \if@tempswa\noexpand\@list@extra\fi
    }%
    \@listi
    \setlength{\@tempdimb}{\@tempb\@tempdima}%
    \setlength{\@tempdima}{\dimexpr \@tempdimb-\@tempdimc}%
    \setlength\intextsep{\@tempdimb \@plus.2\@tempdima \@minus.2\@tempdima}%
    \setlength\dblfloatsep\intextsep
    \setlength\partopsep{.2\@tempdimc \@plus.1\@tempdimc \@minus.1\@tempdimc}%
  }%
}
\expandafter\@defaultunits\expandafter\@tempdima\@ptsize pt\relax\@nnil
\edef\@tempa{\@ptsize}%
\setlength{\@tempdimb}{\@tempdima}%
\edef\@tempb{\strip@pt\@tempdimb}%
\addtolength{\@tempdimb}{-10\p@}%
\edef\@ptsize{\strip@pt\@tempdimb}%
\InputIfFileExists{\@fontsizefilebase\@tempa.clo}{
  \ClassInfo{\KOMAClassName}{%
    File `\@fontsizefilebase\@tempa.clo' used to setup font sizes}%
}{%
  \InputIfFileExists{\@fontsizefilebase\@tempb pt.clo}{%
    \ClassInfo{\KOMAClassName}{%
      File `\@fontsizefilebase\@tempb pt.clo' used instead of\MessageBreak
      file `\@fontsizefilebase\@tempa.clo' to setup font sizes}%
  }{%
      \InputIfFileExists{size\@tempb.clo}{%
        \ClassInfo{\KOMAClassName}{%
          File `size\@tempb.clo' used to setup font sizes}%
      }{%
        \changefontsizes{\@tempa}%
      }%
  }%
}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareOldFontCommand{\sfb}{\normalfont\sffamily\bfseries}{%
  \@nomath\sfb}
\DeclareRobustCommand*{\cal}{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*{\mit}{\@fontswitch\relax\mathnormal}
%%% From File: scrklang.dtx
      \def\today{\ifcase\month\or
        January\or February\or March\or April\or May\or June\or
        July\or August\or September\or October\or November\or December\fi
        \space\number\day, \number\year}%
%%% From File: scrktare.dtx
\let\@BCOR                =\relax
\let\@@BCOR               =\relax
\let\@DIV                 =\relax
\let\@@DIV                =\relax
\let\@headlines           =\relax
\let\@@headlines          =\relax
\let\x@paper              =\relax
\let\x@@paper             =\relax
\let\scr@pti@nerr@r       =\relax
\RequirePackage{typearea}[\KOMAScriptVersion]
%%% From File: scrkpar.dtx
\setlength{\lineskip}{\p@}
\setlength{\normallineskip}{\p@}
\setlength{\columnsep}{10\p@}
\setlength{\columnseprule}{\z@}
\newcommand*{\scr@selectfont}{}
\expandafter\let\expandafter\scr@selectfont\csname selectfont \endcsname
\BeforePackage{everysel}{%
  \AtBeginDocument{%
    \expandafter\ifx\csname selectfont \endcsname\scr@new@selectfont\else
      \ClassWarningNoLine{\KOMAClassName}{discard change of \string\selectfont}%
    \fi
    \expandafter\let\csname selectfont \endcsname\scr@selectfont
  }%
}
\AfterPackage{everysel}{%
  \scr@ifundefinedorrelax{@EverySelectfont@Init}{%
    \expandafter\ifx\csname selectfont \endcsname\scr@new@selectfont
      \ClassWarningNoLine{\KOMAClassName}{%
        \string\selectfont\space already changed}%
    \else
      \expandafter\g@addto@macro\csname selectfont \endcsname{\par@update}%
      \expandafter\let\expandafter\scr@new@selectfont
        \csname selectfont \endcsname
    \fi
  }{%
    \g@addto@macro\@EverySelectfont@Init{%
      \expandafter\g@addto@macro\csname selectfont \endcsname{\par@update}%
      \expandafter\let\expandafter\scr@new@selectfont
        \csname selectfont \endcsname
    }%
  }%
}
\AfterPackage{tracefnt}{%
  \expandafter\let\expandafter\scr@selectfont\csname selectfont \endcsname
  \expandafter\g@addto@macro\csname selectfont \endcsname{\par@update}%
  \expandafter\let\expandafter\scr@new@selectfont\csname selectfont \endcsname
}
\expandafter\g@addto@macro\csname selectfont \endcsname{\par@update}
\newcommand*{\scr@new@selectfont}{}
\expandafter\let\expandafter\scr@new@selectfont\csname selectfont \endcsname
\newcommand*{\par@updaterelative}{%
  \begingroup
    \edef\@tempa{\the\parindent}\ifx\@tempa\f@parindent
      \aftergroup\parindent@update
    \fi
    \edef\@tempa{\the\parskip}\ifx\@tempa\f@parskip
      \aftergroup\parskip@update
    \fi
    \edef\@tempa{\the\parfillskip}\ifx\@tempa\f@parfillskip
      \aftergroup\parfillskip@update
    \fi
  \endgroup
}
\newcommand*{\parindent@update}{%
  \scr@defaultunits\parindent\scr@parindent
  \begingroup
    \let\@tempb\endgroup
    \edef\@tempa{\the\parindent}\ifx\@tempa\f@parindent\else
      \def\@tempb{\endgroup\edef\f@parindent{\the\parindent}}%
    \fi
  \@tempb
}
\newcommand*{\parskip@update}{%
  \scr@defaultunits\parskip\scr@parskip
  \begingroup
    \let\@tempb\endgroup
    \edef\@tempa{\the\parskip}\ifx\@tempa\f@parskip\else
      \def\@tempb{\endgroup\edef\f@parskip{\the\parskip}}%
    \fi
  \@tempb
}
\newcommand*{\parfillskip@update}{%
  \scr@defaultunits\parfillskip\scr@parfillskip
  \begingroup
    \let\@tempb\endgroup
    \edef\@tempa{\the\parfillskip}\ifx\@tempa\f@parfillskip\else
      \def\@tempb{\endgroup\edef\f@parfillskip{\the\parfillskip}}%
    \fi
  \@tempb
}
\newcommand*{\scr@defaultunits}[2]{%
  \begingroup
    \edef\@tempa{#2}%
    \expandafter\scr@@defaultunits\expandafter#1\@tempa plusplus\@nnil
    \edef\@tempa{\noexpand\endgroup\noexpand\setlength{\noexpand#1}{\the#1}}%
  \@tempa
}
\newcommand*{\scr@@defaultunits}{}
\def\scr@@defaultunits#1#2plus#3plus#4\@nnil{%
  \ifx\relax#3\relax
    \scr@@@defaultunits#1{}#2minusminus\@nnil
  \else
    \scr@@@defaultunits#1{#2}#3minusminus\@nnil
  \fi
}
\newcommand*{\scr@@@defaultunits}{}
\def\scr@@@defaultunits#1#2#3minus#4minus#5\@nnil{%
  \ifx\relax#2\relax
    \@defaultunits\@tempskipa#3pt\relax\@nnil
    \setlength{#1}{\@tempskipa}%
  \else
    \@defaultunits\@tempskipa\z@\@plus#3pt\relax\@nnil
    \setlength{#1}{\@tempskipa}%
    \@defaultunits\@tempskipa#2pt\relax\@nnil
    \addtolength{#1}{\@tempskipa}%
  \fi
  \ifx\relax#4\relax\else
    \@defaultunits\@tempskipa\z@\@minus #4pt\relax\@nnil
    \addtolength{#1}{\@tempskipa}%
  \fi
}
\newcommand*{\@list@extra}{%
  \ifdim\parskip>\z@\topsep\z@\parsep\parskip\itemsep\z@\fi
}
\newcommand*{\add@extra@listi}[1]{%
  \expandafter\let\csname #1@listi\endcsname=\@listi
  \def\@listi{\csname #1@listi\endcsname\@list@extra}%
}
  \l@addto@macro{\@listi}{\@list@extra}%
  \let\@listI=\@listi
  \l@addto@macro{\@listii}{\@list@extra}%
  \l@addto@macro{\@listiii}{\@list@extra}%
  \l@addto@macro{\footnotesize}{\protect\add@extra@listi{ftns}}%
  \l@addto@macro{\small}{\protect\add@extra@listi{sml}}%
\@lowpenalty  = 51
\@medpenalty  =151
\@highpenalty =301
%%% From File: scrktitl.dtx
\newcommand*{\@extratitle}{}%
\newcommand{\extratitle}[1]{\gdef\@extratitle{%
    #1%
}}%
\newcommand*{\@titlehead}{}%
\newcommand{\titlehead}[1]{\gdef\@titlehead{%
    #1%
}}%
\newcommand*{\@subject}{}%
\newcommand*{\subject}[1]{\gdef\@subject{%
    #1%
}}%
\newcommand*{\subtitle}[1]{\gdef\@subtitle{%
    #1%
}}%
\newcommand*{\@subtitle}{}%
\newcommand*{\@publishers}{}%
\newcommand{\publishers}[1]{\gdef\@publishers{%
    #1%
}}%
\newcommand*{\@uppertitleback}{}%
\newcommand{\uppertitleback}[1]{\gdef\@uppertitleback{%
    #1%
}}%
\newcommand*{\@lowertitleback}{}%
\newcommand{\lowertitleback}[1]{\gdef\@lowertitleback{%
    #1%
}}%
\newcommand*{\@dedication}{}%
\newcommand{\dedication}[1]{\gdef\@dedication{%
    #1%
}}%
\newcommand*{\next@tpage}{\clearpage\thispagestyle{empty}}%
\newcommand*\maketitle[1][1]{%
  \if@titlepage
    \begin{titlepage}
      \setcounter{page}{%
        #1%
      }%
      \let\footnotesize\small
      \let\footnoterule\relax
      \let\footnote\thanks
      \renewcommand*\thefootnote{\@fnsymbol\c@footnote}%
      \let\@oldmakefnmark\@makefnmark
      \renewcommand*{\@makefnmark}{\rlap\@oldmakefnmark}%
      \ifx\@extratitle\@empty \else
        \noindent\@extratitle\next@tpage\cleardoubleemptypage
        \thispagestyle{empty}%
      \fi
      \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
      \ifx\@titlehead\@empty \else
        \begin{minipage}[t]{\textwidth}%
        \@titlehead
        \end{minipage}\par
      \fi
      \null\vfill
      \begin{center}
        \ifx\@subject\@empty \else
          {\subject@font \@subject \par}%
          \vskip 3em
        \fi
        {\titlefont\huge \@title\par}%
        \vskip 1em
        {\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
        \vskip 2em
        {\Large \lineskip 0.75em
          \begin{tabular}[t]{c}
            \@author
          \end{tabular}\par
        }%
        \vskip 1.5em
        {\Large \@date \par}%
        \vskip \z@ \@plus3fill
        {\Large \@publishers \par}%
        \vskip 3em
      \end{center}\par
      \@thanks
      \vfill\null
      \if@twoside\next@tpage
        \begin{minipage}[t]{\textwidth}
          \@uppertitleback
        \end{minipage}\par
        \vfill
        \begin{minipage}[b]{\textwidth}
          \@lowertitleback
        \end{minipage}
      \fi
      \ifx\@dedication\@empty \else
        \next@tpage\null\vfill
        {\centering \Large \@dedication \par}%
        \vskip \z@ \@plus3fill
        \if@twoside \next@tpage\cleardoubleemptypage \fi
      \fi
    \end{titlepage}
  \else
    \par
    \@tempcnta=%
    #1%
    \relax\ifnum\@tempcnta=1\else
      \ClassWarning{\KOMAClassName}{%
        Optional argument of \string\maketitle\space ignored
        at\MessageBreak
        notitlepage-mode%
      }%
    \fi
    \begingroup
      \renewcommand*\thefootnote{\@fnsymbol\c@footnote}%
      \let\@oldmakefnmark\@makefnmark
      \renewcommand*{\@makefnmark}{\rlap\@oldmakefnmark}
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
      \thispagestyle{\titlepagestyle}\@thanks
    \endgroup
  \fi
  \setcounter{footnote}{0}%
  \let\thanks\relax
  \let\maketitle\relax
  \let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\@subtitle\@empty
  \global\let\@extratitle\@empty
  \global\let\@titlehead\@empty
  \global\let\@subject\@empty
  \global\let\@publishers\@empty
  \global\let\@uppertitleback\@empty
  \global\let\@lowertitleback\@empty
  \global\let\@dedication\@empty
  \global\let\author\relax
  \global\let\title\relax
  \global\let\extratitle\relax
  \global\let\titlehead\relax
  \global\let\subject\relax
  \global\let\publishers\relax
  \global\let\uppertitleback\relax
  \global\let\lowertitleback\relax
  \global\let\dedication\relax
  \global\let\date\relax
  \global\let\and\relax
}%
\newcommand*{\@maketitle}{%
  \clearpage
  \let\footnote\thanks
  \ifx\@extratitle\@empty \else
    \noindent\@extratitle \next@tpage \if@twoside \null\next@tpage \fi
  \fi
  \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
  \ifx\@titlehead\@empty \else
    \begin{minipage}[t]{\textwidth}
      \@titlehead
    \end{minipage}\par
  \fi
  \null
  \vskip 2em%
  \begin{center}%
    \ifx\@subject\@empty \else
      {\subject@font \@subject \par}
      \vskip 1.5em
    \fi
    {\titlefont\huge \@title \par}%
    \vskip .5em
    {\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
    \vskip 1em
    {\Large
      \lineskip .5em%
      \begin{tabular}[t]{c}
        \@author
      \end{tabular}\par
    }%
    \vskip 1em%
    {\Large \@date \par}%
    \vskip \z@ \@plus 1em
    {\Large \@publishers \par}
    \ifx\@dedication\@empty \else
      \vskip 2em
      {\Large \@dedication \par}
    \fi
  \end{center}%
  \par
  \vskip 2em
}%
\newenvironment{titlepage}{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse\newpage
  \fi
  \thispagestyle{empty}%
  \if@compatibility
    \setcounter{page}{0}%
  \fi
}{%
  \if@restonecol\twocolumn \else \newpage \fi
}%
\newcommand*\titlefont{\sectfont}%
\newcommand*{\subject@font}{\normalfont\normalcolor\bfseries\Large}%
\newkomafont{subtitle}{\usekomafont{title}\large}%
\newcommand*{\scr@fnt@title}{\titlefont}%
\newcommand*{\scr@fnt@subject}{\subject@font}%
\newenvironment{abstract}{%
  \if@titlepage
    \titlepage
    \null\vfil
    \@beginparpenalty\@lowpenalty
    \if@abstrt
      \begin{center}
        \normalfont\sectfont\nobreak\abstractname
        \@endparpenalty\@M
      \end{center}
    \fi
  \else
    \if@twocolumn\if@abstrt
        \addsec*{\abstractname}
      \fi
    \else
      \if@abstrt
        \small
        \begin{center}
          {\normalfont\sectfont\nobreak\abstractname
            \vspace{-.5em}\vspace{\z@}}%
        \end{center}
      \fi
      \quotation
    \fi
  \fi
}{%
  \if@titlepage
    \par\vfil\null\endtitlepage
  \else
    \if@twocolumn\else\endquotation\fi
  \fi
}
%%% From File: scrksect.dtx
\newcommand*\appendix{\par%
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \gdef\thesection{\@Alph\c@section}%
  \csname appendixmore\endcsname
}
\newif\if@altsecnumformat\@altsecnumformatfalse
\newif\if@autodot
\renewcommand*{\@autodottrue}{\global\let\if@autodot\iftrue}
\renewcommand*{\@autodotfalse}{\global\let\if@autodot\iffalse}
\@autodotfalse
\newcommand{\@maybeautodot}[1]{\if@autodot\else\begingroup%
  \expandafter\@@maybeautodot #1\@stop\endgroup\fi
}
\newcommand*{\@@maybeautodot}[1]{%
  \ifx #1\@stop\let\@@maybeautodot\relax
  \else
    \ifx #1\Alph \@autodottrue\fi
    \ifx #1\alph \@autodottrue\fi
    \ifx #1\Roman \@autodottrue\fi
    \ifx #1\roman \@autodottrue\fi
    \ifx #1\@Alph \@autodottrue\fi
    \ifx #1\@alph \@autodottrue\fi
    \ifx #1\@Roman \@autodottrue\fi
    \ifx #1\@roman \@autodottrue\fi
    \ifx #1\romannumeral \@autodottrue\fi
  \fi
  \@@maybeautodot
}
\def\@tempa#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\ifx\@sect\@tempa\else
  \ClassWarning{\KOMAClassName}{%
    Unexpected definition of \string\@sect!\MessageBreak
    Please send an information about this to\MessageBreak
    the KOMA-Script maintainer!\MessageBreak
    Maybe LaTeX will be broken by the redefinition\MessageBreak
    of \string\@sect\space}%
\fi
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum \scr@osectarg=\z@
    \@scr@tempswafalse
  \else
    \scr@istest#7=\@nil
  \fi
  \if@scr@tempswa
    \setkeys{KOMAarg.section}{tocentry={#8},head={#8},#7}%
  \else
    \ifcase \scr@osectarg\relax
      \setkeys{KOMAarg.section}{tocentry={#7},head={#7}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#8},head={#7}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#7},head={#8}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#7},head={#7}}%
    \fi
  \fi
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \expandafter\@maybeautodot\csname the#1\endcsname
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
        \interlinepenalty \@M #8\@@par}%
    \endgroup
    \expandafter\csname #1mark\expandafter\endcsname\expandafter{\scr@ds@head}%
    \ifx\scr@ds@tocentry\@empty\else
      \scr@ifundefinedorrelax{add#1tocentry}{%
        \expandafter\global\expandafter\def
        \csname add#1tocentry\endcsname##1##2{%
          \addtocentrydefault{#1}{##1}{##2}%
        }%
      }{}%
      \ifnum #2>\c@secnumdepth
        \csname add#1tocentry\endcsname{}{\scr@ds@tocentry}%
      \else
        \csname add#1tocentry\endcsname{\csname the#1\endcsname}{%
          \scr@ds@tocentry}%
      \fi
    \fi
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
        \@svsec #8}%
      \expandafter\csname #1mark\expandafter\endcsname\expandafter{%
        \scr@ds@head}%
      \ifx\scr@ds@tocentry\@empty\else
        \scr@ifundefinedorrelax{add#1tocentry}{%
          \expandafter\global\expandafter\def
          \csname add#1tocentry\endcsname####1####2{%
            \addtocentrydefault{#1}{####1}{####2}%
          }%
        }{}%
        \ifnum #2>\c@secnumdepth
          \csname add#1tocentry\endcsname{}{\scr@ds@tocentry}%
        \else
          \csname add#1tocentry\endcsname{\csname the#1\endcsname}{%
            \scr@ds@tocentry}%
        \fi
      \fi
    }%
  \fi
  \@xsect{#5}%
}
\DefineFamily{KOMAarg}
\DefineFamilyMember[.section]{KOMAarg}
\DefineFamilyKey[.section]{KOMAarg}{tocentry}{\def\scr@ds@tocentry{#1}}
\DefineFamilyKey[.section]{KOMAarg}{head}{\def\scr@ds@head{#1}}
\newcommand*\scr@ds@tocentry{}
\newcommand*\scr@ds@head{}
\newcommand*{\scr@istest}{}
\def\scr@istest#1=#2\@nil{%
  \ifx\relax#2\relax\@scr@tempswafalse\else\@scr@tempswatrue\fi
}
\newif\if@scr@tempswa
\BeforeClosingMainAux{%
  \if@autodot\if@filesw\immediate\write\@mainaux{%
      \string\global\string\@altsecnumformattrue}%
  \fi\fi}
\newcommand*\autodot{\if@altsecnumformat.\fi}
\setcounter{secnumdepth}{3}
\newcounter{part}
\renewcommand*{\thepart}{\@Roman\c@part}
\newcommand*{\partformat}{\partname~\thepart\autodot}
\newcounter{section}
\renewcommand*{\thesection}{\@arabic\c@section}
\newcommand*\sectionmarkformat{\thesection\autodot\enskip}
\newcounter{subsection}[section]
\renewcommand*{\thesubsection}{\thesection.\@arabic\c@subsection}
\newcommand*\subsectionmarkformat{\thesubsection\autodot\enskip}
\newcounter{subsubsection}[subsection]
\renewcommand*{\thesubsubsection}{%
  \thesubsection.\@arabic\c@subsubsection
}
\newcounter{paragraph}[subsubsection]
\renewcommand*{\theparagraph}{\thesubsubsection.\@arabic\c@paragraph}
\newcounter{subparagraph}[paragraph]
\renewcommand*{\thesubparagraph}{%
  \theparagraph.\@arabic\c@subparagraph
}
\newcommand*{\othersectionlevelsformat}[3]{#3\autodot\enskip}
\renewcommand*{\@seccntformat}[1]{%
   \protect\othersectionlevelsformat{#1}{%
     \expandafter\aftergroup\noexpand\@gobble}{\csname the#1\endcsname}%
}
\newcommand*\partname{Part}
\newcommand*\abstractname{Abstract}
\newcommand*\appendixname{Appendix}
\newcommand*{\partheadstartvskip}{%
 \addvspace{4ex}%
}
\newcommand*{\partheadmidvskip}{%
  \par\nobreak
}
\newcommand*{\partheadendvskip}{%
    \vskip 3ex
}
\newcommand\part{\par
  \partheadstartvskip%
  \@afterindentfalse
  \secdef\@part\@spart
}
\newcommand*{\@part}{}
\def\@part[#1]#2{%
  \ifnum \scr@osectarg=\z@
    \@scr@tempswafalse
  \else
    \scr@istest#1=\@nil
  \fi
  \if@scr@tempswa
    \setkeys{KOMAarg.section}{tocentry={#2},head={#2},#1}%
  \else
    \ifcase \scr@osectarg\relax
      \setkeys{KOMAarg.section}{tocentry={#1},head={#1}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#2},head={#1}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#1},head={#2}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#1},head={#1}}%
    \fi
  \fi
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{part}%
    \@maybeautodot\thepart%
    \ifx\scr@ds@tocentry\@empty\else
      \addparttocentry{\thepart}{\scr@ds@tocentry}%
    \fi
  \else
    \ifx\scr@ds@tocentry\@empty\else
      \addparttocentry{}{\scr@ds@tocentry}%
    \fi
  \fi
  \begingroup
    \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
    \raggedpart
    \interlinepenalty \@M
    \normalfont\sectfont\nobreak
    \ifnum \c@secnumdepth >\m@ne
      \size@partnumber{\partformat}%
      \partheadmidvskip
    \fi
    \size@part{#2}\strut
    \ifx\partmark\@gobble
      \@mkboth{}{}\par
    \else
      \expandafter\partmark\expandafter{\scr@ds@head}\par
    \fi
  \endgroup
  \nobreak
  \partheadendvskip
  \@afterheading
}
\newcommand*{\@spart}[1]{%
  \begingroup
    \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
    \raggedpart
    \interlinepenalty \@M
    \normalfont
    \sectfont\nobreak\size@part{#1}\strut\@mkboth{}{}\par
  \endgroup
  \nobreak
  \partheadendvskip
  \@afterheading
}
\newcommand*{\addparttocentry}[2]{%
  \addtocentrydefault{part}{#1}{#2}%
}
\newcommand\addpart{%
  \par
  \partheadstartvskip
  \@afterindentfalse
  \secdef\@addpart\@saddpart
}
\newcommand*{\@addpart}{}
\def\@addpart[#1]#2{%
  \ifnum \scr@osectarg=\z@
    \@scr@tempswafalse
  \else
    \scr@istest#1=\@nil
  \fi
  \if@scr@tempswa
    \setkeys{KOMAarg.section}{tocentry={#2},head={#2},#1}%
  \else
    \ifcase \scr@osectarg\relax
      \setkeys{KOMAarg.section}{tocentry={#1},head={#1}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#2},head={#1}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#1},head={#2}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#1},head={#1}}%
    \fi
  \fi
  \csname phantomsection\endcsname
  \ifx\scr@ds@tocentry\@empty\else
    \expandafter\addparttocentry\expandafter{\expandafter}\expandafter{%
      \scr@ds@tocentry}%
  \fi
  \@spart{#2}%
  \ifx\partmark\@gobble
    \@mkboth{}{}%
  \else
    \expandafter\@mkboth\expandafter{%
      \expandafter\MakeMarkcase\expandafter{\scr@ds@head}}{}%
  \fi
}
\newcommand*{\@saddpart}{\@spart}
\newcommand*{\partmark}{}
\let\partmark\@gobble
\newcommand*\addsec{\secdef\@addsec\@saddsec}
\newcommand*{\@addsec}{}
\def\@addsec[#1]#2{\section*{#2}%
  \ifnum \scr@osectarg=\z@
    \@scr@tempswafalse
  \else
    \scr@istest#1=\@nil
  \fi
  \if@scr@tempswa
    \setkeys{KOMAarg.section}{tocentry={#2},head={#2},#1}%
  \else
    \ifcase \scr@osectarg\relax
      \setkeys{KOMAarg.section}{tocentry={#1},head={#1}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#2},head={#1}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#1},head={#2}}%
    \or
      \setkeys{KOMAarg.section}{tocentry={#1},head={#1}}%
    \fi
  \fi
  \ifx\scr@ds@tocentry\@empty\else
    \addsectiontocentry{}{\scr@ds@tocentry}%
  \fi
  \if@twoside
    \expandafter\@mkboth\expandafter{%
      \expandafter\MakeMarkcase\expandafter{\scr@ds@head}}{}%
  \else
    \expandafter\@mkboth\expandafter{\expandafter}\expandafter{%
      \expandafter\MakeMarkcase\expandafter{\scr@ds@head}}%
  \fi
}
\newcommand*{\@saddsec}[1]{\section*{#1}\@mkboth{}{}}
\newcommand*{\addsectiontocentry}[2]{%
  \addtocentrydefault{section}{#1}{#2}%
}
\newcommand*{\addsubsectiontocentry}[2]{%
  \addtocentrydefault{subsection}{#1}{#2}%
}
\newcommand*{\addparagraphtocentry}[2]{%
  \addtocentrydefault{paragraph}{#1}{#2}%
}
\newcommand*{\addsubparagraphtocentry}[2]{%
  \addtocentrydefault{subparagraph}{#1}{#2}%
}
\newcommand\section{\@startsection{section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\ifnum \scr@compatibility>\@nameuse{scr@v@2.96}\relax
    \setlength{\parfillskip}{\z@ plus 1fil}\fi
    \raggedsection\normalfont\sectfont\nobreak\size@section}%
}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\ifnum \scr@compatibility>\@nameuse{scr@v@2.96}\relax
    \setlength{\parfillskip}{\z@ plus 1fil}\fi
    \raggedsection\normalfont\sectfont\nobreak\size@subsection
  }%
}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\ifnum \scr@compatibility>\@nameuse{scr@v@2.96}\relax
    \setlength{\parfillskip}{\z@ plus 1fil}\fi
    \raggedsection\normalfont\sectfont\nobreak\size@subsubsection
  }%
}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\raggedsection\normalfont\sectfont\nobreak\size@paragraph}%
}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
  {3.25ex \@plus1ex \@minus .2ex}%
  {-1em}%
  {\raggedsection\normalfont\sectfont\nobreak\size@subparagraph}%
}
\newkomafont{minisec}{}
\newcommand\minisec[1]{\@afterindentfalse \vskip 1.5ex
  {\parindent \z@
    \ifnum \scr@compatibility>\@nameuse{scr@v@2.96}\relax
      \setlength{\parfillskip}{\z@ plus 1fil}\fi
    \raggedsection\normalfont\sectfont\nobreak
    \usekomafont{minisec}#1\par\nobreak}\nobreak%
  \@afterheading
}
\newcommand*{\raggedsection}{}
\let\raggedsection\raggedright
\newcommand*{\raggedpart}{}
\let\raggedpart\raggedsection
\newcommand*\sectfont{\normalcolor\sffamily\bfseries}
\newkomafont{partentry}{\usekomafont{disposition}\large}
\newkomafont{partentrypagenumber}{}
\newkomafont{sectionentry}{\usekomafont{disposition}}
\newkomafont{sectionentrypagenumber}{}
\newcommand*{\scr@fnt@disposition}{\sectfont}
\aliaskomafont{sectioning}{disposition}
\newcommand*{\scr@fnt@part}{\size@part}
\newcommand*{\scr@fnt@partnumber}{\size@partnumber}
\newcommand*{\scr@fnt@section}{\size@section}
\newcommand*{\scr@fnt@subsection}{\size@subsection}
\newcommand*{\scr@fnt@subsubsection}{\size@subsubsection}
\newcommand*{\scr@fnt@paragraph}{\size@paragraph}
\newcommand*{\scr@fnt@subparagraph}{\size@subparagraph}
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{\@secpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength{\@tempdima}{2em}%
    \if@tocleft
      \ifx\toc@l@number\@empty\else
        \setlength\@tempdima{0\toc@l@number}%
      \fi
    \fi
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \usekomafont{partentry}{#1\nobreak
        \usekomafont{partentrypagenumber}{\hfil\nobreak
          \hb@xt@\@pnumwidth{\hss#2}}}\par
      \ifnum \scr@compatibility>\@nameuse{scr@v@2.96}\relax
      \endgroup
      \penalty20010
      \else
        \if@compatibility
          \global\@nobreaktrue
          \everypar{\global\@nobreakfalse\everypar{}}%
        \else
          \penalty\@highpenalty
         \fi
      \endgroup
    \fi
  \fi
}
\newcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \ifnum \lastpenalty<20009
      \addpenalty{\@secpenalty}%
    \fi
    \addvspace{1.0em \@plus\p@}%
    \setlength\@tempdima{1.5em}%
     \if@tocleft
      \ifx\toc@l@number\@empty\else
        \setlength\@tempdima{0\toc@l@number}%
      \fi
    \fi
   \begingroup
      \raggedsectionentry
      \parindent \z@ \advance\rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \interlinepenalty\@M
      \leavevmode
      \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
      \usekomafont{sectionentry}{#1\nobreak
        \usekomafont{sectionentrypagenumber}{%
          \hfill\nobreak
          \hb@xt@\@pnumwidth{\hss#2}}}\par
    \endgroup
    \ifnum \scr@compatibility>\@nameuse{scr@v@2.96}\relax
      \penalty20008
    \fi
  \fi
}
\newcommand*{\raggedsectionentry}{}
\newcommand*\l@subsection{\bprot@dottedtocline{2}{1.5em}{2.3em}}
\newcommand*\l@subsubsection{\bprot@dottedtocline{3}{3.8em}{3.2em}}
\newcommand*\l@paragraph{\bprot@dottedtocline{4}{7.0em}{4.1em}}
\newcommand*\l@subparagraph{\bprot@dottedtocline{5}{10em}{5em}}
\newcommand*{\bprot@dottedtocline}[5]{%
  \ifnum \scr@compatibility>\@nameuse{scr@v@2.96}\relax
    \ifnum #1>\c@tocdepth \else
      \begingroup
        \@tempcnta 20010
        \advance \@tempcnta by -#1
      \ifnum \@tempcnta>\lastpenalty
        \endgroup
        \addpenalty{\@lowpenalty}%
      \else
        \endgroup
      \fi
      \@dottedtocline{#1}{#2}{#3}{#4}{#5}%
      \@tempcnta 20009
      \advance \@tempcnta by -#1
      \penalty\@tempcnta
    \fi
  \else
    \@dottedtocline{#1}{#2}{#3}{#4}{#5}%
  \fi
}
%%% From File: scrkmisc.dtx
\newif\if@restonecol
\newcommand{\dictum}[2][]{\par%
  \begingroup
    \raggeddictum\parbox{\dictumwidth}{%
      {\@dictumfont{\raggeddictumtext #2\strut\par}%
        \def\@tempa{#1}\ifx\@tempa\@empty\else%
          {\raggeddictumtext\dictumrule}%
          \raggeddictumauthor\@dictumauthorfont\dictumauthorformat{#1}%
          \strut\par%
        \fi%
      }%
    }\par%
  \endgroup
}
\newcommand*{\dictumrule}{\vskip-1ex\hrulefill\par}%
\newcommand*{\dictumwidth}{.3333\textwidth}
\newcommand*{\raggeddictum}{\raggedleft}
\newcommand*{\dictumauthorformat}[1]{(#1)}
\newcommand*{\raggeddictumtext}{\raggedright}
\newcommand*{\raggeddictumauthor}{\raggedleft}
\newkomafont{dictum}{\normalfont\normalcolor\sffamily\small}
\newkomafont{dictumauthor}{\itshape}
\aliaskomafont{dictumtext}{dictum}
\setlength{\skip\@mpfootins}{\skip\footins}
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\renewcommand*\theequation{%
  \@arabic\c@equation
}
\newcommand*{\new@tpo@label}{\@newl@bel{tpo}}
\newcommand*{\scr@tpo}{0}
\newcommand*{\is@thispageodd}{%
  \@bsphack
  \begingroup
    \@tempcnta=\scr@tpo
    \advance\@tempcnta by\@ne
    \xdef\scr@tpo{\the\@tempcnta}%
    \protected@write\@auxout{\let\arabic\relax}{%
      \string\new@tpo@label{\scr@tpo}{\arabic{page}}}%
    \expandafter\ifx\csname tpo@\scr@tpo\endcsname\relax
      \protect\G@refundefinedtrue
      \ClassWarning{\KOMAClassName}{%
        odd/even page label number \scr@tpo\space undefined}%
      \edef\@tempa{\the\value{page}}%
    \else
      \edef\@tempa{\csname tpo@\scr@tpo\endcsname}%
    \fi
    \ifodd\number\@tempa
      \aftergroup\thispagewasoddtrue
    \else
      \aftergroup\thispagewasoddfalse
    \fi
  \endgroup
  \@esphack
}
\newif\ifthispagewasodd
\newcommand{\ifthispageodd}{%
  \is@thispageodd
  \ifthispagewasodd
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
}
\DeclareRobustCommand*\textsubscript[1]{%
  \@textsubscript{\selectfont#1}%
}
\providecommand*{\@textsubscript}[1]{%
  {\m@th\ensuremath{_{\mbox{\fontsize\sf@size\z@#1}}}}%
}
%%% From File: scrkpage.dtx
\newcommand*{\set@tempdima@hw}{%
  \setlength{\@tempdima}{\textwidth}%
  \if@mincl
    \addtolength{\@tempdima}{\marginparsep}%
    \addtolength{\@tempdima}{\marginparwidth}%
  \fi
}
\newcommand*{\pnumfont}{\normalfont\normalcolor}
\newcommand*{\headfont}{\normalfont\normalcolor\slshape}
\newcommand*{\footfont}{}
\newcommand*{\scr@fnt@pagenumber}{\pnumfont}
\aliaskomafont{pagination}{pagenumber}
\newcommand*{\scr@fnt@pageheadfoot}{\headfont}
\aliaskomafont{pagehead}{pageheadfoot}
\newcommand*{\scr@fnt@pagefoot}{\footfont}
\newcommand*{\scr@fnt@wrn@pagefoot}[1]{%
  This class does not use font element `pagefoot'!\MessageBreak
  Maybe you should load package `scrpage2', before\MessageBreak
  using this element%
}
\newcommand*{\pagemark}{{\usekomafont{pagenumber}{%
    \thepage}}}
\renewcommand*{\ps@plain}{%
  \renewcommand*{\@oddhead}{}%
  \let\@evenhead\@oddhead
  \renewcommand*{\@evenfoot}{%
    \set@tempdima@hw\hss\hb@xt@ \@tempdima{\vbox{%
        \if@fsl \hrule \vskip 3\p@ \fi
        \hb@xt@ \@tempdima{{\pagemark\hfil}}}}}%
  \renewcommand*{\@oddfoot}{%
    \set@tempdima@hw\hb@xt@ \@tempdima{\vbox{%
        \if@fsl \hrule \vskip 3\p@ \fi
        \hb@xt@ \@tempdima{{\hfil\pagemark
            \if@twoside\else\hfil\fi}}}}\hss}%
}%
\newcommand*{\ps@headings}{\let\@mkboth\markboth
  \renewcommand*{\@evenhead}{%
    \set@tempdima@hw\hss\hb@xt@ \@tempdima{\vbox{%
        \hb@xt@ \@tempdima{{\headfont\strut\leftmark\hfil}}%
        \if@hsl \vskip 1.5\p@ \hrule \fi}}}%
  \renewcommand*{\@oddhead}{%
    \set@tempdima@hw\hb@xt@ \@tempdima{\vbox{%
        \hb@xt@ \@tempdima{{\headfont\hfil\strut\rightmark
            \if@twoside\else\hfil\fi}}%
        \if@hsl \vskip 1.5\p@ \hrule \fi}}\hss}%
  \renewcommand*{\@evenfoot}{%
    \set@tempdima@hw\hss\hb@xt@ \@tempdima{\vbox{%
        \if@fsl \hrule \vskip 3\p@ \fi
        \hb@xt@ \@tempdima{{\pagemark\hfil}}}}}%
  \renewcommand*{\@oddfoot}{%
    \set@tempdima@hw\hb@xt@ \@tempdima{\vbox{%
        \if@fsl \hrule \vskip 3\p@ \fi
        \hb@xt@ \@tempdima{{\hfil\pagemark
            \if@twoside\else\hfil\fi}}}}\hss}%
  \renewcommand*{\sectionmark}[1]{%
    \if@twoside\expandafter\markboth\else\expandafter\markright\fi
    {\MakeMarkcase{\ifnum \c@secnumdepth >\z@%
        \sectionmarkformat\fi ##1}}{}}%
  \renewcommand*{\subsectionmark}[1]{%
    \if@twoside
      \markright{\MakeMarkcase{\ifnum \c@secnumdepth >\@ne%
          \subsectionmarkformat\fi ##1}}%
    \fi
  }%
}%
\newcommand*{\ps@myheadings}{\let\@mkboth\@gobbletwo
  \renewcommand*{\@evenhead}{%
    \set@tempdima@hw\hss\hb@xt@ \@tempdima{\vbox{%
        \hb@xt@ \@tempdima{{\headfont\strut\leftmark\hfil}}%
        \if@hsl \vskip 1.5\p@ \hrule \fi}}}%
  \renewcommand*{\@oddhead}{%
    \set@tempdima@hw\hb@xt@ \@tempdima{\vbox{%
        \hb@xt@ \@tempdima{{\headfont\hfil\strut\rightmark
            \if@twoside\else\hfil\fi}}%
        \if@hsl \vskip 1.5\p@ \hrule \fi}}\hss}%
  \renewcommand*{\@evenfoot}{%
    \set@tempdima@hw\hss\hb@xt@ \@tempdima{\vbox{%
        \if@fsl \hrule \vskip 3\p@ \fi
        \hb@xt@ \@tempdima{{\pagemark\hfil}}}}}%
  \renewcommand*{\@oddfoot}{%
    \set@tempdima@hw\hb@xt@ \@tempdima{\vbox{%
        \if@fsl \hrule \vskip 3\p@ \fi
        \hb@xt@ \@tempdima{{\hfil\pagemark
            \if@twoside\else\hfil\fi}}}}\hss}%
  \renewcommand*{\subsectionmark}[1]{}%
  \renewcommand*{\sectionmark}[1]{}%
}
\newcommand*{\titlepagestyle}{plain}
\newcommand*{\indexpagestyle}{plain}
\pagestyle{plain}
\pagenumbering{arabic}
\if@twoside
  \flushbottom
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
%%% From File: scrkfloa.dtx
\newcommand\marginline[1]{%
  \marginpar[\raggedleft{#1}]{\raggedright #1}%
}
\newlength{\abovecaptionskip}
\newlength{\belowcaptionskip}
\setlength{\abovecaptionskip}{10\p@}
\setlength{\belowcaptionskip}{0\p@}
\newcommand*{\captionformat}{:\ }
\newcommand{\scr@caption}{}
\AtBeginDocument{\let\scr@caption\caption}
\newcommand{\captionabove}{\@captionabovetrue\scr@caption}
\newcommand{\captionbelow}{\@captionabovefalse\scr@caption}
\newcommand*{\scap@caption}{}
\newcommand*{\scap@width}{\linewidth}
\newcommand*{\scap@move}{\z@}
\newcommand*{\scap@currentlabel}{}
\newif\ifscap@alt
\newcommand*{\@captionbeside}{}
\long\def\@captionbeside[#1]#2{%
  \@ifnextchar [%]
    {\@@captionbeside[{#1}]{#2}}
    {\c@pti@nb@sid@[{#1}]{#2}}%
}
\newcommand*{\@@captionbeside}{}
\long\def\@@captionbeside[#1]#2[#3]{%
  \def\scap@pos{#3}%
  \@ifnextchar [%]
    {\@@@captionbeside[{#1}]{#2}}
    {\c@pti@nb@sid@[{#1}]{#2}}%
}
\newcommand*{\@@@captionbeside}{}
\long\def\@@@captionbeside[#1]#2[#3]{%
  \def\scap@width{#3}%
  \@ifnextchar [%]
    {\@@@@captionbeside[{#1}]{#2}}
    {\setlength{\@tempdima}{#3}%
      \addtolength{\@tempdima}{-\linewidth}%
      \setlength{\@tempdima}{-.5\@tempdima}%
      \edef\scap@move{\the\@tempdima}%
      \c@pti@nb@sid@[{#1}]{#2}}%
}
\newcommand*{\@@@@captionbeside}{}
\long\def\@@@@captionbeside[#1]#2[#3]{%
  \def\scap@move{#3}%
  \@ifstar
    {\scap@alttrue\c@pti@nb@sid@[{#1}]{#2}}
    {\scap@altfalse\c@pti@nb@sid@[{#1}]{#2}}%
}
\newbox\c@pti@nb@sid@b@x
\newcommand{\c@pti@nb@sid@}{}
\long\def\c@pti@nb@sid@[#1]#2{%
  \def\scap@caption{%
    \if c\scap@valign
      \setlength{\abovecaptionskip}{\z@}%
    \else \if t\scap@valign
        \setlength{\abovecaptionskip}{-\ht\strutbox}%
      \else \if b\scap@valign
          \setlength{\abovecaptionskip}{\z@}%
        \fi
      \fi
    \fi
    \setlength{\belowcaptionskip}{-\dp\strutbox}%
    \captionbelow[{#1}]{#2}%
  }%
  \begin{lrbox}{\c@pti@nb@sid@b@x}%
}
\newenvironment*{captionbeside}{%
  \@dblarg\@captionbeside%
}{%
  \end{lrbox}%
  \settowidth{\@tempdima}{\usebox\c@pti@nb@sid@b@x}%
  \setlength{\@tempdimb}{\scap@width}%
  \addtolength{\@tempdimb}{-\@tempdima}%
  \addtolength{\@tempdimb}{-\columnsep}%
  \ifdim \@tempdimb<2em
    \ClassWarning{\KOMAClassName}{%
      caption beside will be very, very small.\MessageBreak
      In most cases this will result in overfull and\MessageBreak
      underfull \string\hbox\space messages%
    }%
  \fi
  \onelinecaptionsfalse
  \setcapwidth[r]{\@tempdimb}%
  \let\@tempa\scap@pos
  \setlength{\@tempdimc}{\scap@move}%
  \if i\scap@pos\def\@tempa{l}\fi
  \if o\scap@pos\def\@tempa{r}\fi
  \if@twoside
    \ifthispageodd{}{%
      \if o\scap@pos\def\@tempa{l}\fi
      \if i\scap@pos\def\@tempa{r}\fi
      \ifscap@alt
        \addtolength{\@tempdimc}{\scap@width}%
        \addtolength{\@tempdimc}{-\linewidth}%
        \setlength{\@tempdimc}{-\@tempdimc}%
      \fi
    }%
  \fi
  \hspace*{\@tempdimc}%
  \if l\@tempa
    \rlap{%
      \parbox[\scap@valign]{\@tempdimb}{\scap@caption
        \global\let\scap@currentlabel\@currentlabel}%
      \nobreak\hskip\columnsep
      \parbox[\scap@valign]{\wd\c@pti@nb@sid@b@x}{\usebox\c@pti@nb@sid@b@x}%
    }%
  \else
    \rlap{%
      \parbox[\scap@valign]{\wd\c@pti@nb@sid@b@x}{\usebox\c@pti@nb@sid@b@x}%
      \nobreak\hskip\columnsep
      \parbox[\scap@valign]{\@tempdimb}{\scap@caption
        \global\let\scap@currentlabel\@currentlabel}%
    }%
  \fi
  \par
  \aftergroup\let\aftergroup\@currentlabel
  \aftergroup\scap@currentlabel
}
\newcommand*\capfont{\normalfont\normalcolor}
\newcommand*\caplabelfont{\normalfont\normalcolor}
\newcommand*{\scr@fnt@caption}{\capfont}
\newcommand*{\scr@fnt@captionlabel}{\caplabelfont}
\newif\ifdofullc@p
\dofullc@ptrue
\newif\if@capbreak\@capbreakfalse
\newcommand*{\setcapindent}{\@ifstar{\@@setcapindent}{\@setcapindent}}
\newcommand*{\@setcapindent}[1]{%
  \setlength{\@tempdima}{#1}%
  \ifdim\@tempdima>\hsize
    \addtolength{\@tempdima}{-\hsize}\@capbreaktrue
  \else
    \@capbreakfalse
  \fi
  \edef\cap@indent{\the\@tempdima}%
  \dofullc@pfalse
}
\newcommand*{\@@setcapindent}[1]{%
  \setlength{\@tempdima}{#1}%
  \edef\cap@indent{\the\@tempdima}%
  \dofullc@pfalse\@capbreaktrue
}
\AfterPackage{caption2}{%
  \renewcommand*{\setcapindent}{%
    \ClassWarning{\KOMAClassName}{%
      You're using package `caption2'.\MessageBreak
      Because of this you should also use `\string\captionstyle'
      and\MessageBreak
      set length '\string\captionindent' instead of
      using\MessageBreak
      `\string\setcapindent'%
    }%
    \captionstyle{indent}%
    \@ifstar{\setlength{\captionindent}}{\setlength{\captionindent}}%
  }%
}
\newcommand*{\setcaphanging}{\dofullc@ptrue\@capbreakfalse}
\AfterPackage{caption2}{%
  \renewcommand*{\setcaphanging}{%
    \ClassWarning{\KOMAClassName}{%
      You're using package `caption2'.\MessageBreak
      Because of this you should also use
      `\string\captionstyle'\MessageBreak
      instead of `\string\setcaphang'%
    }
    \captionstyle{hang}%
  }%
}
\newcommand{\@makecaption}[2]{%
  \if@captionabove
    \vskip\belowcaptionskip
  \else
    \vskip\abovecaptionskip
  \fi
  \@@makecaption\@firstofone{#1}{#2}%
  \if@captionabove
    \vskip\abovecaptionskip
  \else
    \vskip\belowcaptionskip
  \fi
}
\newcommand*{\cap@width}{\hsize}
\newcommand*{\cap@left}{\hfill}
\newcommand*{\cap@right}{\hfill}
\newcommand*{\setcapwidth}[2][]{%
  \begingroup%
    \setlength{\@tempdima}{#2}%
    \ifdim\@tempdima <\z@
      \@tempdima\z@
      \ClassWarning{\KOMAClassName}{%
        caption width less than 0pt not allowed.\MessageBreak
        Setting caption width to 0pt%
      }%
    \fi
    \edef\@tempa{\endgroup\def\noexpand\cap@width{\the\@tempdima}}%
  \@tempa
  \begingroup
    \edef\@tempa{#1}%
    \def\@tempb{c}\ifx\@tempa\@tempb
      \endgroup
      \def\cap@margin{\let\cap@left=\hfill\let\cap@right=\hfill}%
    \else
      \def\@tempb{l}\ifx\@tempa\@tempb
        \endgroup
        \def\cap@margin{\let\cap@left=\relax\let\cap@right\hfill}%
      \else
        \def\@tempb{r}\ifx\@tempa\@tempb
          \endgroup
          \def\cap@margin{\let\cap@left=\hfill\let\cap@right=\relax}%
        \else
          \def\@tempb{i}\ifx\@tempa\@tempb
            \endgroup
            \def\cap@margin{%
              \let\cap@left=\relax
              \let\cap@right=\hfill
              \if@twoside
                \ifthispageodd{}{%
                  \let\cap@left=\hfill
                  \let\cap@right=\relax
                }%
              \fi
            }%
          \else
            \def\@tempb{o}\ifx\@tempa\@tempb
              \endgroup
              \def\cap@margin{%
                \let\cap@left=\hfill
                \let\cap@right=\relax
                \if@twoside
                  \ifthispageodd{}{%
                    \let\cap@left=\relax
                    \let\cap@right=\hfill
                  }%
                \fi
              }%
            \else
              \ifx \@tempa\@empty\else
                \ClassError{\KOMAClassName}{%
                  unknown optional position argument%
                }{%
                  You've used `#1' as position argument at
                  \string\setcaptionwidth,\MessageBreak
                  but only ONE of `c', `l', `r', `i`, `o` ist
                  allowed.\MessageBreak
                  Argument will be ignored, if you'll continue.%
                }%
              \fi
              \endgroup
  \fi\fi\fi\fi\fi
}
\AfterPackage{caption2}{%
  \renewcommand*{\setcapwidth}[2][]{%
    \ClassWarning{\KOMAClassName}{%
      Ignorring optional argument of `\string\setcapwidth'!\MessageBreak
      You're using package `caption2'.\MessageBreak
      Because of this you should also use
      `\string\setcaptionwidth'\MessageBreak
      instead of `\string\setcapwidth'%
    }%
    \setcaptionwidth{#2}%
  }%
}%
\newcommand*{\cap@margin}{}
\let\cap@margin=\relax%
\newcommand*{\setcapmargin}{\@ifstar{\@setcapmargin}{\@@setcapmargin}}
\newcommand*{\@setcapmargin}[2][\@tempdimb]{%
  \def\cap@margin{%
    \onelinecaptionsfalse
    \begingroup
      \setlength{\@tempdima}{\hsize}%
      \setlength{\@tempdimb}{#2}%
      \addtolength{\@tempdima}{-\@tempdimb}%
      \setlength{\@tempdimc}{#1}%
      \addtolength{\@tempdima}{-\@tempdimc}%
      \edef\@tempa{\endgroup
        \def\noexpand\cap@width{\the\@tempdima}%
        \noexpand\if@twoside
          \noexpand\ifthispageodd{%
            \def\noexpand\cap@left{\noexpand\hspace*{\the\@tempdimc}}%
            \def\noexpand\cap@right{\noexpand\hspace*{\the\@tempdimb}}%
          }{%
            \def\noexpand\cap@right{\noexpand\hspace*{\the\@tempdimc}}%
            \def\noexpand\cap@left{\noexpand\hspace*{\the\@tempdimb}}%
          }%
        \noexpand\else
          \def\noexpand\cap@left{\noexpand\hspace*{\the\@tempdimc}}%
          \def\noexpand\cap@right{\noexpand\hspace*{\the\@tempdimb}}%
        \noexpand\fi
      }%
    \@tempa
  }%
}
\newcommand*{\@@setcapmargin}[2][\@tempdimb]{%
  \def\cap@margin{%
    \onelinecaptionsfalse
    \begingroup
      \setlength{\@tempdima}{\hsize}%
      \setlength{\@tempdimb}{#2}%
      \addtolength{\@tempdima}{-\@tempdimb}%
      \setlength{\@tempdimc}{#1}%
      \addtolength{\@tempdima}{-\@tempdimc}%
      \edef\@tempa{\endgroup
        \def\noexpand\cap@width{\the\@tempdima}%
        \def\noexpand\cap@left{\noexpand\hspace*{\the\@tempdimc}}%
        \def\noexpand\cap@right{\noexpand\hspace*{\the\@tempdimb}}%
      }%
    \@tempa
  }%
}
\AfterPackage{caption2}{%
  \renewcommand*{\@setcapmargin}[2][\@tempdimb]{%
    \setlength{\@tempdimb}{#2}%
    \setlength{\@tempdima}{#1}%
    \ifdim\@tempdima\@tempdimb\else
      \ClassWarning{\KOMAClassName}{%
        Can set only centered caption!\MessageBreak
        You're using package `caption2'.\MessageBreak
        Because of this you should also use
        `\string\setcaptionmargin'\MessageBreak
        instead of `\string\setcapmargin'%
      }%
    \fi
    \addtolength{\@tempdimb}{\@tempdimb}%
    \setcaptionmargin{.5\@tempdimb}}%
  \let\@@setcapmargin=\@setcapmargin
}
\newcommand{\@@makecaption}[3]{%
  \cap@margin
  \ifonelinecaptions
    \@tempcnta=\value{mpfootnote}\@tempcntb=\value{footnote}%
    \let\scr@tmp@footnotetext=\@footnotetext
    \let\@footnotetext=\@gobble
    \sbox\@tempboxa{%
      {\capfont{\strut\ignorespaces
        #1{{\caplabelfont{#2\captionformat}}}%
        #3\unskip\strut}}%
    }%
    \let\@footnotetext=\scr@tmp@footnotetext
    \let\scr@tmp@footnotetext=\undefined
    \setcounter{footnote}{\@tempcntb}%
    \setcounter{mpfootnote}{\@tempcnta}%
  \else
    \sbox\@tempboxa{\hspace*{2\cap@width}}%
  \fi
  \begingroup%
    \setlength{\@tempdima}{\cap@width}%
    \ifdim \wd\@tempboxa >\@tempdima
      \hb@xt@\hsize{%
        \setbox\@tempboxa\vbox{\hsize=\cap@width
          \ifdofullc@p
            {\capfont{\@hangfrom{\scr@smashdp{\strut\ignorespaces
                  #1{{\caplabelfont{#2\captionformat}}}}}%
              {#3\unskip\strut\par}}}%
          \else%
            \ifdim\cap@indent<\z@
              {\capfont{\strut\ignorespaces
                #1{{\caplabelfont{#2\captionformat\par}}}%
                \noindent\hspace*{-\cap@indent}#3\unskip\strut\par}}%
            \else%
              \if@capbreak
                {\capfont{\strut\ignorespaces
                  #1{{\caplabelfont{#2\captionformat\par}}}%
                  \noindent\@hangfrom{\hspace*{\cap@indent}}{#3\par}}}%
              \else
                {\capfont{\@hangfrom{\scr@smashdp\strut\hspace*{\cap@indent}}%
                  {\hspace{-\cap@indent}\scr@smashdp{\ignorespaces#1%
                    {{\caplabelfont{#2\captionformat}}}}#3\unskip\strut\par}}}%
              \fi
            \fi
          \fi
        }%
        \setlength{\@tempdima}{\ht\@tempboxa}%
        \addtolength{\@tempdima}{\dp\@tempboxa}%
        \addtolength{\@tempdima}{-\ht\strutbox}%
        \ht\@tempboxa\ht\strutbox
        \dp\@tempboxa\@tempdima
        \strut\cap@left
        \box\@tempboxa
        \cap@right\strut
      }%
    \else
      \global \@minipagefalse
      \sbox\@tempboxa{%
        {\capfont{\scr@smashdp{\strut\ignorespaces
          #1{{\caplabelfont{#2\captionformat}}}}%
          #3}}%
      }%
      {\capfont{\hb@xt@\hsize{\strut\cap@left\box\@tempboxa\cap@right\strut}}}%
    \fi
  \endgroup
}
\newcommand*{\scr@caption@before@longtable@warning}[1]{%
  \ClassWarning{\KOMAClassName}{%
    you've loaded package `#1' before package\MessageBreak
    `longtable'!\MessageBreak
    Because of this package `#1' isn't able to\MessageBreak
    control `\string\caption' at longtables. \space After loading
    \MessageBreak
    package `#1' KOMA-Script also doesn't control\MessageBreak
    `\string\caption'.\MessageBreak
    I think, you should load package `caption' after\MessageBreak
    package `longtable'%
  }%
}
\AfterPackage{longtable}{%
  \@ifpackageloaded{caption2}{\@komalongtablefalse
    \scr@caption@before@longtable@warning{caption2}%
  }{}%
  \if@komalongtable
    \renewcommand{\LT@makecaption}[3]{%
      \noalign{%
        \if@captionabove
          \vskip\belowcaptionskip
        \else
          \vskip\abovecaptionskip
        \fi
      }%
      \LT@mcol\LT@cols c{%
        \hbox to\z@{\hss\parbox[t]\linewidth{%
            \@@makecaption{#1}{#2}{#3}%
            \endgraf
            \if@captionabove
              \vskip\abovecaptionskip
            \else
              \vskip\belowcaptionskip
            \fi
          }%
          \hss
        }%
      }%
    }%
    \newcommand*{\scr@LT@array}{}%
    \let\scr@LT@array=\LT@array
    \renewcommand*{\LT@array}{%
      \let\scr@caption=\LT@caption
      \def\captionabove{\noalign{\global\@captionabovetrue}%
        \scr@caption}%
      \def\captionbelow{\noalign{\global\@captionabovefalse}%
        \scr@caption}%
      \if@tablecaptionabove
        \let\LT@caption=\captionabove
      \else
        \let\LT@caption=\captionbelow
      \fi
      \scr@LT@array
    }%
    \ClassInfo{\KOMAClassName}{%
      longtable captions redefined%
    }%
  \fi
}
\newcommand*{\fs@komaabove}{%
  \let\@fs@capt\floatc@komascript
  \let\@fs@pre\@empty
  \def\@fs@mid{\vskip\abovecaptionskip}%
  \let\@fs@post\@empty
  \let\@fs@iftopcapt\iftrue}
\newcommand*{\fs@komabelow}{%
  \let\@fs@capt\floatc@komascript
  \let\@fs@pre\@empty
  \def\@fs@mid{\vskip\abovecaptionskip}%
  \let\@fs@post\@empty
  \let\@fs@iftopcapt\iffalse}
\newcommand{\floatc@komascript}{\@@makecaption\@firstofone}
\setcounter{topnumber}{2}
\renewcommand*\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand*\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand*\textfraction{.2}
\renewcommand*\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand*\dbltopfraction{.7}
\renewcommand*\dblfloatpagefraction{.5}
\newcommand*{\captionof}[1]{\def\@captype{#1}%
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname if@#1captionabove\endcsname\iftrue
    \@captionabovetrue
  \fi
  \scr@caption}
\newcommand*{\captionaboveof}{\@captionabovetrue\captionof}
\newcommand*{\captionbelowof}{\@captionabovefalse\captionof}
\BeforePackage{capt-of}{\let\captionof\relax}
\newenvironment{captionofbeside}[1]{%
  \def\@captype{#1}%
  \captionbeside
}{%
  \endcaptionbeside
}
\newcommand*\figurename{Figure}
\newcommand*\tablename{Table}
\newcounter{figure}
\renewcommand*\thefigure{%
  \@arabic\c@figure
}
\newcommand*{\figureformat}{%
  \figurename~\thefigure%
}
\newcommand*{\fps@figure}{tbp}
\newcommand*{\ftype@figure}{1}
\newcommand*{\ext@figure}{lof}
\newcommand*{\fnum@figure}{\figureformat}
\newenvironment{figure}{%
  \if@figurecaptionabove\let\caption\captionabove
  \else\let\caption\captionbelow\fi
  \let\caption\captionbelow\@float{figure}%
}{%
  \end@float
}
\newenvironment{figure*}{%
  \if@figurecaptionabove\let\caption\captionabove
  \else\let\caption\captionbelow\fi
  \let\caption\captionbelow\@dblfloat{figure}%
}{%
  \end@dblfloat
}
\newcounter{table}
\renewcommand*\thetable{%
  \@arabic\c@table
}
\newcommand*{\tableformat}{%
  \tablename~\thetable%
}
\newcommand*{\fps@table}{tbp}
\newcommand*{\ftype@table}{2}
\newcommand*{\ext@table}{lot}
\newcommand*{\fnum@table}{\tableformat}
\newenvironment{table}{%
  \if@tablecaptionabove\let\caption\captionabove
  \else\let\caption\captionbelow\fi
  \@float{table}%
}{%
  \end@float
}
\newenvironment{table*}{%
  \if@tablecaptionabove\let\caption\captionabove
  \else\let\caption\captionbelow\fi
  \@dblfloat{table}%
}{%
  \end@dblfloat
}
%%% From File: scrkftn.dtx
\renewcommand*\footnoterule{%
  \normalsize\ftn@rule@test@values
  \kern-\dimexpr 2.6\p@+\ftn@rule@height\relax
  \ifx\@textbottom\relax\else\vskip \z@ \@plus.05fil\fi
  {\usekomafont{footnoterule}{%
      \hrule \@height\ftn@rule@height \@width\ftn@rule@width}}%
  \kern 2.6\p@}
\newcommand*{\ftn@rule@test@values}{%
  \ifdim\ftn@rule@height <\z@
    \ClassWarning{\KOMAClassName}{%
      You might get into trouble, because the\MessageBreak
      height of the footnote rule has a value\MessageBreak
      less than 0%
    }%
  \else
    \ifdim\ftn@rule@height >\dimexpr\skip\footins -2.6\p@\relax
      \ClassWarning{\KOMAClassName}{%
        You might get into trouble, because the\MessageBreak
        height of the footnote rule has a value\MessageBreak
        greater than \the\dimexpr\skip\footins -2.6\p@\relax
      }%
    \fi
  \fi
  \ifdim\ftn@rule@width <\z@
    \ClassWarning{\KOMAClassName}{%
      You might get into trouble, because the width\MessageBreak
      or length of the footnote rule has a value\MessageBreak
      less than 0pt%
    }%
  \else
    \ifdim\ftn@rule@width >\columnwidth
      \ClassWarning{\KOMAClassName}{%
        You might get into trouble, because the width\MessageBreak
        or length of the footnote rule has a value\MessageBreak
        greater than \string\columnwidth
      }%
    \fi
  \fi
}
\newkomafont{footnoterule}{}
\newcommand*{\ftn@rule@width}{.4\columnwidth}
\newcommand*{\ftn@rule@height}{.4\p@}
\newcommand*{\setfootnoterule}[2][]{%
  \ifstr{#1}{}{}{%
    \renewcommand*{\ftn@rule@height}{#1}%
  }%
  \ifstr{#2}{}{}{%
    \renewcommand*{\ftn@rule@width}{#2}%
  }%
  \ftn@rule@test@values
}
\newcommand\deffootnote[4][]{%
  \long\def\@makefntext##1{%
    \setlength{\@tempdimc}{#3}%
    \def\@tempa{#1}\ifx\@tempa\@empty
      \@setpar{\@@par
        \@tempdima = \hsize
        \addtolength{\@tempdima}{-#2}%
        \parshape \@ne #2 \@tempdima}%
    \else
      \addtolength{\@tempdimc}{#2}%
      \addtolength{\@tempdimc}{-#1}%
      \@setpar{\@@par
        \@tempdima = \hsize
        \addtolength{\@tempdima}{-#1}%
        \@tempdimb = \hsize
        \addtolength{\@tempdimb}{-#2}%
        \parshape \tw@ #1 \@tempdima #2 \@tempdimb
      }%
    \fi
    \par
    \parindent\@tempdimc\noindent
    \ftn@font\hbox to \z@{\hss\@@makefnmark}##1%
  }%
  \def\@@makefnmark{\hbox{\ftnm@font{#4}}}%
}
\newcommand*{\ftn@font}{\normalfont}
\newcommand*{\scr@fnt@footnote}{\ftn@font}
\newcommand*{\ftnm@font}{}
\newcommand*{\scr@fnt@footnotenumber}{\ftnm@font}
\newcommand*{\scr@fnt@footnotelabel}{\ftnm@font}
\newcommand*{\scr@fnt@instead@footnotetext}{footnote}
\newcommand*\deffootnotemark[1]{%
  \def\@makefnmark{\hbox{\ftntm@font{#1}}}%
}
\newcommand*{\ftntm@font}{}
\newcommand*{\scr@fnt@footnotereference}{\ftntm@font}
\newcommand*{\scr@fnt@footnoteref}{\ftntm@font}
\newcommand*{\FN@mf@check}{%
  \ifdim\lastkern=\multiplefootnotemarker\relax
    \edef\@x@sf{\the\spacefactor}%
    \unkern\multiplefootnoteseparator
    \spacefactor\@x@sf\relax
  \fi
}
\newcommand*{\scr@mf@prepare}{%
  \kern-\multiplefootnotemarker
  \kern\multiplefootnotemarker\relax
}
\@ifundefined{FN@mf@prepare}{}{}
\newcommand{\scr@saved@footnotetext}{}
\let\scr@saved@footnotetext\@footnotetext
\renewcommand{\@footnotetext}[1]{%
  \scr@saved@footnotetext{#1}%
  \csname FN@mf@prepare\endcsname
}
\BeforePackage{footmisc}{%
  \ifx\@footnotemark\scr@footnotemark
    \let\@footnotemark\scr@saved@footnotemark
  \fi
  \let\@footnotetext\scr@saved@footnotetext
}
\BeforePackage{setspace}{%
  \let\@footnotetext\scr@saved@footnotetext
}
\AfterPackage{setspace}{%
  \let\scr@saved@footnotetext\@footnotetext
  \renewcommand{\@footnotetext}[1]{%
    \scr@saved@footnotetext{#1}%
    \csname FN@mf@prepare\endcsname
  }%
}
\newcommand*{\multiplefootnoteseparator}{%
  \begingroup\let\thefootnotemark\multfootsep\@makefnmark\endgroup
}
\newcommand*{\multfootsep}{,}
\newcommand*{\multiplefootnotemarker}{3sp}
\newcommand*{\thefootnotemark}{\@thefnmark}
\deffootnote[1em]{1.5em}{1em}{\textsuperscript{\thefootnotemark}}
\deffootnotemark{\textsuperscript{\thefootnotemark}}
\newcommand*{\footref}[1]{%
  \begingroup
    \unrestored@protected@xdef\@thefnmark{\ref{#1}}%
  \endgroup
  \@footnotemark
}
%%% From File: scrkliof.dtx
\renewcommand*{\numberline}[1]{%
  \numberline@box{%
    \numberline@prefix\numberline@numberformat{#1}\numberline@postfix
  }%
}
\newcommand*{\numberline@prefix}{}
\newcommand*{\numberline@postfix}{\hfil}
\newcommand*{\numberline@numberformat}[1]{#1\autodot}
\newcommand*{\numberline@box}[1]{\hb@xt@\@tempdima{#1}}
\newcommand*\@pnumwidth{1.55em}
\newcommand*\@tocrmarg {2.55em}
\newcommand*\@dotsep{4.5}
\newcommand*{\scr@dottedtocline}{}
\newcommand*{\last@l@number}{}
\newcommand*{\@l@number}{}
\newcommand*{\set@l@number}[1]{%
  \settowidth{\@tempdima}{#1\enskip}%
  \ifdim\@tempdima >\@l@number
    \xdef\@l@number{\the\@tempdima}%
  \fi%
  \ifdim\@tempdima >\last@l@number \else
    \setlength{\@tempdima}{\last@l@number}%
  \fi%
}
\newcommand*{\before@starttoc}[1]{
  \let\scr@dottedtocline=\@dottedtocline
  \renewcommand*{\@dottedtocline}[3]{%
    \scr@dottedtocline{##1}{\z@}{\last@l@number}}%
  \renewcommand*{\numberline@box}[1]{%
    \set@l@number{##1}\hb@xt@\@tempdima{##1}}%
  \gdef\@l@number{\z@}%
  \@ifundefined{#1@l@number}{%
    \def\last@l@number{2em}%
  }{%
    \expandafter\ifx\csname #1@l@number\endcsname\@empty
      \let\last@l@number\z@
    \else
      \expandafter\let\expandafter\last@l@number
      \expandafter=\csname#1@l@number\endcsname
    \fi
  }%
}
\newcommand*{\after@starttoc}[1]{%
  \protected@write\@auxout{}{%
    \string\gdef\expandafter\string\csname#1@l@number\endcsname{%
      \@l@number}}%
  }
\g@addto@macro\tocbasic@@before@hook{%
  \if@dynlist\expandafter\before@starttoc\expandafter{\@currext}\fi
}
\g@addto@macro\tocbasic@@after@hook{%
  \if@dynlist\expandafter\after@starttoc\expandafter{\@currext}\fi
}
\newcommand*\contentsname{Contents}
\newcommand*\listoftocname{\contentsname}
\setcounter{tocdepth}{3}
\newcommand*\toc@heading{%
  \ClassWarning{\KOMAClassName}{%
    usage of deprecated \string\toc@heading!\MessageBreak
    You should use the features of package `tocbasic'\MessageBreak
    instead of \string\toc@heading.\MessageBreak
    Definition of \string\toc@heading\space my be removed from\MessageBreak
    KOMA-Script soon, so it should not be used
  }%
  \section*{\contentsname}%
  \@mkboth{\MakeMarkcase{\contentsname}}{\MakeMarkcase{\contentsname}}%
}
\newcommand*{\toc@l@number}{}
\newcommand*{\tableofcontents}{%
  \begingroup\let\if@dynlist\if@tocleft\listoftoc{toc}\endgroup
}
\newcommand{\addtocentrydefault}[3]{%
  \ifstr{#2}{}{%
    \addcontentsline{toc}{#1}{#3}%
  }{%
    \addcontentsline{toc}{#1}{\protect\numberline{#2}#3}%
  }%
}
\newcommand*{\float@listhead}[1]{%
  \scr@float@listhead@warning
  \float@@listhead{#1}%
  \@mkboth{\MakeMarkcase{#1}}{\MakeMarkcase{#1}}%
  \if@dynlist%
    \newcommand*{\scr@starttoc}{}%
    \let\scr@starttoc=\@starttoc
    \renewcommand*{\@starttoc}[1]{%
      \before@starttoc{##1}\scr@starttoc{##1}\after@starttoc{##1}%
    }%
  \fi
}
\newcommand*{\scr@float@listhead@warning}{%
  \ClassWarning{\KOMAClassName}{%
    Usage of deprecated \string\float@listhead!\MessageBreak
    You should use the features of package `tocbasic'\MessageBreak
    instead of \string\float@listhead.\MessageBreak
    Definition of \string\float@listhead\space my be removed from\MessageBreak
    `\KOMAClassName' soon, so it should not be used
  }%
}
\newcommand*{\scr@float@addtolists@warning}{%
  \ClassWarningNoLine{\KOMAClassName}{%
    \string\float@addtolists\space detected!\MessageBreak
    You should use the features of package `tocbasic'\MessageBreak
    instead of \string\float@addtolists.\MessageBreak
    Support for \string\float@addtolists\space may be removed
    from\MessageBreak
    `\KOMAClassName' soon
  }%
  \global\let\scr@float@addtolists@warning\relax
}
\newcommand*\listfigurename{List of Figures}
\newcommand*\listoflofname{\listfigurename}
\newcommand*\listoflofentryname{\figurename}
\newcommand*\listtablename{List of Tables}
\newcommand*\listoflotname{\listtablename}
\newcommand*\listoflotentryname{\tablename}
\newcommand*\listoffigures{\listoftoc{lof}}
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\listoftables{\listoftoc{lot}}
\let\l@table\l@figure
%%% From File: scrkbib.dtx
\newcommand*\refname{References}
\newcommand*{\bibpreamble}{\relax}
\let\bibpreamble\relax
\newcommand{\setbibpreamble}[1]{\def\bibpreamble{#1}}
\newdimen\bibindent
\bibindent=1.5em
\newenvironment{thebibliography}[1]{%
  \if@bib@break@
    \bib@beginhook
  \else
    \bib@heading
    \ifx\bibpreamble\relax\else\ifx\bibpreamble\@empty\else
        \noindent\bibpreamble\par\nobreak
    \fi\fi
    \bib@beginhook
    \bib@before@hook
  \fi
  \renewcommand{\BreakBibliography}[1]{%
    \@bib@break
    \end{thebibliography}%
    \begingroup ##1\endgroup
    \begin{thebibliography}{#1}
  }%
  \list{%
    \@biblabel{\@arabic\c@enumiv}%
  }{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \if@bib@break@
      \edef\@tempa{%
        \noexpand\usecounter{enumiv}%
        \noexpand\setcounter{enumiv}{\the\c@enumiv}%
      }\@tempa
      \no@bib@break
    \else
      \usecounter{enumiv}%
    \fi
    \let\p@enumiv\@empty
    \renewcommand*\theenumiv{\@arabic\c@enumiv}%
  }%
  \sloppy\clubpenalty4000 \widowpenalty4000
  \sfcode`\.=\@m
}{%
  \if@bib@break@
    \def\@noitemerr{%
      \@latex@warning{%
        \string\BreakBibliography\space at begin of `thebibliography'
        environment\MessageBreak
        or following \string\BreakBibliography}%
    }%
  \else
    \def\@noitemerr{%
      \@latex@warning{%
        Empty `thebibliography' environment or
        \string\BreakBibliography\MessageBreak
        before end of `thebibliography' environment}%
    }%
  \fi
  \endlist
  \if@bib@break@
  \else
    \bib@after@hook
    \let\bib@before@hook\@empty
    \let\bib@after@hook\@empty
  \fi
  \bib@endhook
}
\newif\if@bib@break@
\newcommand{\no@bib@break}{\global\let\if@bib@break@\iffalse}
\newcommand*{\@bib@break}{\global\let\if@bib@break@\iftrue}
\newcommand*{\bib@before@hook}{}
\newcommand*{\bib@after@hook}{}
\newcommand{\BreakBibliography}[1]{%
  \ClassWarning{\KOMAClassName}{%
    You've used \string\BreakBibliography\space either outside of\MessageBreak
    the bibliography or `thebibliography' was redefined\MessageBreak
    incompatible, e.g., using a bibliography package.\MessageBreak
    \string\BreakBibliography\space ignored%
  }%
}
\newcommand{\AfterBibliographyPreamble}{\g@addto@macro\bib@before@hook}
\newcommand{\AtEndBibliography}{\g@addto@macro\bib@after@hook}
%%% From File: scrkidx.dtx
\newcommand*{\index@preamble}{}
\let\index@preamble=\relax
\newcommand{\setindexpreamble}[1]{\def\index@preamble{#1}}
\newcommand*{\idx@heading}{%
  \twocolumn[\idx@@heading{\indexname}]%
  \@mkboth{\MakeMarkcase{\indexname}}{\MakeMarkcase{\indexname}}%
}
\newenvironment{theindex}{%
  \if@twocolumn
    \@restonecolfalse
  \else
    \@restonecoltrue
  \fi
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
\newcommand*\@idxitem{\par\hangindent 40\p@}
\newcommand*\subitem{\@idxitem \hspace*{20\p@}}
\newcommand*\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand*\indexspace{%
  \par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax
}
\newcommand*\indexname{Index}
%%% From File: scrklist.dtx
\if@twocolumn
  \setlength{\leftmargini}{2em}
\else
  \setlength{\leftmargini}{2.5em}
\fi
\setlength{\leftmarginii}{2.2em}
\setlength{\leftmarginiii}{1.87em}
\setlength{\leftmarginiv}{1.7em}
\if@twocolumn
  \setlength{\leftmarginv}{.5em}
  \setlength{\leftmarginvi}{.5em}
\else
  \setlength{\leftmarginv}{1em}
  \setlength{\leftmarginvi}{1em}
\fi
\setlength{\leftmargin}{\leftmargini}
\setlength{\labelsep}{.5em}
\setlength{\labelwidth}{\leftmargini}
\addtolength{\labelwidth}{-\labelsep}
\@beginparpenalty=-\@lowpenalty
\@endparpenalty  =-\@lowpenalty
\@itempenalty    =-\@lowpenalty
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\renewcommand*\theenumi{\@arabic\c@enumi}
\renewcommand*\theenumii{\@alph\c@enumii}
\renewcommand*\theenumiii{\@roman\c@enumiii}
\renewcommand*\theenumiv{\@Alph\c@enumiv}
\newcommand*\labelenumi{\theenumi.}
\newcommand*\labelenumii{\theenumii)}
\newcommand*\labelenumiii{\theenumiii.}
\newcommand*\labelenumiv{\theenumiv.}
\renewcommand*\p@enumii{\theenumi}
\renewcommand*\p@enumiii{\p@enumii(\theenumii)}
\renewcommand*\p@enumiv{\p@enumiii\theenumiii}
\newcommand*\labelitemi{\textbullet}
\newcommand*\labelitemii{\normalfont\bfseries\textendash}
\newcommand*\labelitemiii{\textasteriskcentered}
\newcommand*\labelitemiv{\textperiodcentered}
\newenvironment{description}{%
  \list{}{\labelwidth\z@ \itemindent-\leftmargin
    \let\makelabel\descriptionlabel}%
}{%
  \endlist
}
\newcommand*{\descriptionlabel}[1]{%
  \hspace{\labelsep}\descfont #1%
}
\newenvironment{labeling}[2][]{%
  \def\sc@septext{#1}%
  \list{}{\settowidth{\labelwidth}{{%
        \usekomafont{labelinglabel}{#2%
          \usekomafont{labelingseparator}{\sc@septext}}%
      }}%
    \leftmargin\labelwidth \advance\leftmargin by \labelsep
    \let\makelabel\labelinglabel
  }%
}{%
  \endlist
}
\newcommand\labelinglabel[1]{%
  \usekomafont{labelinglabel}{#1\hfil
    \usekomafont{labelingseparator}{\sc@septext}}%
}
\newenvironment{verse}{%
  \let\\=\@centercr
  \list{}{\itemsep=\z@
    \itemindent=-1.5em
    \listparindent=\itemindent
    \rightmargin=\leftmargin
    \advance\leftmargin by1.5em
  }%
  \item\relax
}{%
  \endlist
}
\newenvironment{quotation}{%
  \list{}{\listparindent 1em%
    \itemindent    \listparindent
    \rightmargin   \leftmargin
    \parsep        \z@ \@plus\p@
  }%
  \item\relax
}{%
  \endlist
}
\newenvironment{quote}{%
  \list{}{\rightmargin\leftmargin}%
  \item\relax
}{%
  \endlist
}
\newenvironment{addmargin}{%
  \@tempswafalse\@addmargin
}{%
  \advance\@listdepth\@ne
  \endlist
}
\newenvironment{addmargin*}{%
  \@tempswafalse
  \if@twoside\ifthispageodd{}{\@tempswatrue}\fi
  \@addmargin
}{%
  \advance\@listdepth\@ne
  \endlist
}
\newcommand*{\@addmargin}[2][\@tempa]{%
  \list{}{%
    \if@tempswa
      \def\@tempa{\leftmargin}%
      \setlength{\leftmargin}{#2}%
      \setlength{\rightmargin}{#1}%
    \else
      \def\@tempa{\rightmargin}%
      \setlength{\rightmargin}{#2}%
      \setlength{\leftmargin}{#1}%
    \fi
    \setlength{\listparindent}{\parindent}%
    \setlength{\itemsep}{\parskip}%
    \setlength{\itemindent}{\z@}%
    \setlength{\topsep}{\z@}%
    \setlength{\parsep}{\parskip}%
    \setlength{\partopsep}{\z@}%
    \let\makelabel\@gobble
    \setlength{\labelwidth}{\z@}%
    \advance\@listdepth\m@ne
  }%
  \item\relax%
}
\newcommand*\descfont{\sffamily\bfseries}
\newcommand*{\scr@fnt@descriptionlabel}{\descfont}
\newkomafont{labelinglabel}{}
\newkomafont{labelingseparator}{}
%%% From File: scrlogo.dtx
\@ifundefined{KOMAScript}{%
  \DeclareRobustCommand{\KOMAScript}{\textsf{K\kern.05em O\kern.05em%
      M\kern.05em A\kern.1em-\kern.1em Script}}}{}
\endinput
%%
%% End of file `scrartcl.cls'.
