%%
%% This is file `scrlttr2.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% scrkvers.dtx  (with options: `class,letter')
%% scrkbase.dtx  (with options: `load')
%% scrkcomp.dtx  (with options: `class,letter,option')
%% scrkmisc.dtx  (with options: `class,letter,option')
%% scrklco.dtx  (with options: `class,letter,option')
%% scrklang.dtx  (with options: `class,letter,option')
%% scrkfont.dtx  (with options: `class,letter,option')
%% scrkvars.dtx  (with options: `class,letter,option')
%% scrkplen.dtx  (with options: `class,letter,option')
%% scrktare.dtx  (with options: `class,letter,option')
%% scrkpar.dtx  (with options: `class,letter,option')
%% scrkpage.dtx  (with options: `class,letter,option')
%% scrkfloa.dtx  (with options: `class,letter,option')
%% scrkftn.dtx  (with options: `class,letter,option')
%% scrklist.dtx  (with options: `class,letter,option')
%% scrknpap.dtx  (with options: `class,letter,option')
%% scrkcile.dtx  (with options: `class,letter,option')
%% scrkmisc.dtx  (with options: `class,letter,execoption')
%% scrkcomp.dtx  (with options: `class,letter,body')
%% scrkfont.dtx  (with options: `class,letter,body')
%% scrkmisc.dtx  (with options: `class,letter,body')
%% scrklco.dtx  (with options: `class,letter,body')
%% scrklang.dtx  (with options: `class,letter,body')
%% scrkvars.dtx  (with options: `class,letter,body')
%% scrkplen.dtx  (with options: `class,letter,body')
%% scrktare.dtx  (with options: `class,letter,body')
%% scrkpar.dtx  (with options: `class,letter,body')
%% scrkpage.dtx  (with options: `class,letter,body')
%% scrkfloa.dtx  (with options: `class,letter,body')
%% scrkftn.dtx  (with options: `class,letter,body')
%% scrklist.dtx  (with options: `class,letter,body')
%% scrknpap.dtx  (with options: `class,letter,body')
%% scrkcile.dtx  (with options: `class,letter,body')
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
  scrlttr2%
}
\newcommand*{\ClassName}{%
  letter%
}
\ProvidesClass{\KOMAClassName}[%
  \KOMAScriptVersion\space document class (\ClassName)%
]
%%% From File: scrkbase.dtx
\RequirePackage{scrkbase}[\KOMAScriptVersion]
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
%%% From File: scrklco.dtx
\newcommand*{\lco@test}{%
  \IfFileExists{\CurrentOption.lco}{%
    \expandafter\AtEndOfClass\expandafter{%
      \expandafter\LoadLetterOption\expandafter{\CurrentOption}%
    }%
    \expandafter\def\expandafter\scr@pti@nerr@r\expandafter{%
      \expandafter\def\expandafter\scr@pti@nerr@r\expandafter{%
        \scr@pti@nerr@r
      }%
    }%
  }{}%
}
\AtEndOfClass{\LoadLetterOption{DIN}}
%%% From File: scrklang.dtx
\newif\if@orgdate\@orgdatetrue
\KOMA@key{numericaldate}[true]{%
  \if@orgdate\@orgdatefalse\else\@orgdatetrue\fi
  \KOMA@set@ifkey{numericaldate}{@orgdate}{#1}%
  \if@orgdate\@orgdatefalse\else\@orgdatetrue\fi
}
\KOMA@DeclareDeprecatedOption{scrdate}{numericaldate=true}
\KOMA@DeclareDeprecatedOption{orgdate}{numericaldate=false}
%%% From File: scrkfont.dtx
\newcommand*\@ptsize{%
  12%
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
%%% From File: scrkvars.dtx
%%% From File: scrkplen.dtx
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
  \lco@test
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
%%% From File: scrklist.dtx
%%% From File: scrknpap.dtx
\KOMA@ifkey{firsthead}{@firsthead}\@firstheadtrue
\newcommand*{\@alignfrom}{0}
\KOMA@key{fromalign}{%
  \KOMA@set@ncmdkey{fromalign}{@alignfrom}{%
    {left}{0},%
    {center}{1},{centered}{1},{middle}{1},%
    {right}{2},%
    {locationleft}{3},{leftlocation}{3},%
    {locationright}{4},{rightlocation}{4},{location}{4},%
    {no}{10000},{false}{10000},{off}{10000}%
  }{#1}%
  \ifcase\@alignfrom\or\or\or\@firstheadfalse\or\@firstheadfalse\fi
}
\newcommand*{\@rulefrom}{0}
\KOMA@ncmdkey{fromrule}[below]{@rulefrom}{%
  {false}{0},{no}{0},{off}{0},{aftername}{1},%
  {below}{2},{afteraddress}{2},{true}{2},{yes}{2},{on}{2}%
}
\KOMA@ifkey{fromphone}{@phone}
\KOMA@ifkey{fromfax}{@fax}
\KOMA@ifkey{fromemail}{@email}
\KOMA@ifkey{fromurl}{@www}
\KOMA@ifkey{fromlogo}{@logo}
\newcommand*{\if@afield}{%
  \ClassWarning{\KOMAClassName}{%
    Usage of \string\if@afield\space deprecated.\MessageBreak
    Internal macro \string\if@afield\space was removed at\MessageBreak
    KOMA-Script version 3.03.  I'll replace the usage of\MessageBreak
    \string\if@afield\space by \string\ifnum
    \string\@afieldmode=\string\@ne.\MessageBreak
    This may result in errors.  A better solution would be\MessageBreak
    to change the code}%
  \ifnum \@afieldmode=\@ne}
\newcommand*{\@afieldtrue}{%
  \ClassWarning{\KOMAClassName}{%
    Usage of \string\if@afield\space deprecated.\MessageBreak
    Internal macro \string\if@afield\space was removed at\MessageBreak
    KOMA-Script version 3.03.  I'll replace the usage of\MessageBreak
    \string\@afieldtrue\space by
    \string\KOMAoptions{addrfield=true}.\MessageBreak
    This may result in erros.  A better solution would be\MessageBreak
    to change the code}%
  \KOMAoptions{addrfield=true}}
\newcommand*{\@afieldfalse}{%
  \ClassWarning{\KOMAClassName}{%
    Usage of \string\if@afield\space deprecated.\MessageBreak
    Internal macro \string\if@afield\space was removed at\MessageBreak
    KOMA-Script version 3.03.  I'll replace the usage of\MessageBreak
    \string\@afieldfalse\space by
    \string\KOMAoptions{addrfield=false}.\MessageBreak
    This may result in erros.  A better solution would be\MessageBreak
    to change the code}%
  \KOMAoptions{addrfield=false}}
\newcommand*{\@afieldmode}{\@ne}
\KOMA@ncmdkey{addrfield}[true]{@afieldmode}{%
  {false}{0},{off}{0},{no}{0},%
  {true}{1},{on}{1},{yes}{1},%
  {PP}{2},{pp}{2},%
  {PPexplicite}{2},{PPExplicite}{2},%
  {ppexplicite}{2},{ppExplicite}{2},%
  {backgroundimage}{3},%
  {PPbackgroundimage}{3},{PPBackgroundImage}{3},{PPBackGroundImage}{3},%
  {ppbackgroundimage}{3},{ppBackgroundImage}{3},{ppBackGroundImage}{3},%
  {image}{4},{Image}{4},%
  {PPimage}{4},{PPImage}{4},%
  {ppimage}{4},{ppImage}{4}%
}
\newcommand*{\ltr@priority}{0}%
\KOMA@ncmdkey{priority}[A]{ltr@priority}{%
  {no}{0},{off}{0},{false}{0},{manual}{1},%
  {B}{1},{b}{1},%
  {economy}{1},{Economy}{1},{ECONOMY}{1},%
  {B-ECONOMY}{1},{B-Economy}{1},{b-economy}{1},%
  {A}{2},{a}{2},%
  {priority}{2},{Priority}{2},{PRIORITY}{2},%
  {A-PRIORITY}{2},{A-Priority}{2},{a-priority}{2}%
}%
\newcommand{\backaddr@format}[1]{}
\let\backaddr@format\underline
\newif\if@baddr\@baddrtrue
\KOMA@key{backaddress}[true]{%
  \begingroup
    \KOMA@set@ncmdkey{backaddress}{@tempa}{%
      {false}{0},{off}{0},{no}{0},%
      {true}{1},{on}{1},{yes}{1},%
      {underlined}{2},%
      {plain}{3}%
    }{#1}%
    \ifcase\@tempa
      \endgroup
      \@baddrfalse
    \or
      \endgroup
      \@baddrtrue
    \or
      \endgroup
      \@baddrtrue
      \let\backaddr@format\underline
    \or
      \endgroup
      \@baddrtrue
      \let\backaddr@format\@firstofone
    \else
      \endgroup
    \fi
}
\newif\if@bigloc
\KOMA@key{locfield}[wide]{%
  \begingroup
    \KOMA@set@ncmdkey{locfield}{@tempa}{{wide}{0},{narrow}{1}}{#1}%
    \ifcase\@tempa
      \endgroup
      \@bigloctrue
    \else
      \endgroup
      \@biglocfalse
    \fi
}
\KOMA@DeclareDeprecatedOption{wlocfield}{locfield=wide}
\KOMA@DeclareDeprecatedOption{slocfield}{locfield=narrow}
\newif\if@fold\@foldtrue
\newcommand*{\@usefolds}{TMBPL}
\KOMA@key{foldmarks}[true]{%
  \begingroup
    \def\FamilyUnknownKeyValue##1##2##3##4{%
      \def\sc@nf@ldch@rs####1{%
        \ifx ####1\@nil\else
          \if ####1T\g@addto@macro\@usefolds{####1}\else
            \if ####1M\g@addto@macro\@usefolds{####1}\else
              \if ####1B\g@addto@macro\@usefolds{####1}\else
                \if ####1P\g@addto@macro\@usefolds{####1}\else
                  \if ####1L\g@addto@macro\@usefolds{####1}\else
                    \if ####1V\g@addto@macro\@usefolds{L}\else
                      \if ####1H\g@addto@macro\@usefolds{TMBP}\else
                        \if ####1t\scr@removechar\@usefolds{T}\else
                          \if ####1m\scr@removechar\@usefolds{M}\else
                            \if ####1b\scr@removechar\@usefolds{B}\else
                              \if ####1p\scr@removechar\@usefolds{P}\else
                                \if ####1l\scr@removechar\@usefolds{L}\else
                                  \if ####1v%
                                    \scr@removechar\@usefolds{L}%
                                  \else
                                    \if ####1h%
                                      \scr@removechar\@usefolds{T}%
                                      \scr@removechar\@usefolds{M}%
                                      \scr@removechar\@usefolds{B}%
                                    \else
                                      \ClassError{\KOMAClassName}{%
                                        unknown fold mark switch `####1'}{%
                                        You should use option `foldmarks'
                                        either with one of\MessageBreak
                                        \@spaces `true', `on', or `yes' to
                                        switch fold marks on,\MessageBreak
                                        \@spaces `false', `off', or `no' to
                                        switch fold marks off,\MessageBreak
                                        or a combination of\MessageBreak
                                        \@spaces `T', `M', `B', 'P', 'L', `V',
                                        `H' to select dedicated fold
                                        marks\MessageBreak
                                        or\MessageBreak
                                        \@spaces `t', `m', 'b', 'p', 'l', 'v',
                                        'h' to deselect dedicated fold
                                        marks.\MessageBreak
                                        See the KOMA-Script manual for more
                                        information.
                                      }%
                                    \fi
                                  \fi
                                \fi
                              \fi
                            \fi
                          \fi
                        \fi
                      \fi
                    \fi
                  \fi
                \fi
              \fi
            \fi
          \fi
          \expandafter\sc@nf@ldch@rs
        \fi
      }%
      \expandafter\sc@nf@ldch@rs#1\@nil
    }%
    \KOMA@set@ifkey\@empty{@fold}{#1}%
    \if@fold\aftergroup\@foldtrue\else\aftergroup\@foldfalse\fi
  \endgroup
}
\newcommand*{\scr@removechar}[2]{%
  \def\in@@##1#2##2##3\in@@{%
    \ifx\in@##2\else
      \def\in@@####1#2\in@{\gdef#1{##1####1}}%
      \in@@##2##3%
    \fi}%
  \expandafter\in@@#1#2\in@\in@@
}
\newif\if@refwide
\newcommand*{\@datepos}{1}
\KOMA@key{refline}[wide]{%
  \begingroup
    \KOMA@set@ncmdkey{refline}{@tempa}{{wide}{0},{narrow}{1},%
    {dateleft}{2},{leftdate}{2},%
    {dateright}{3},{rightdate}{3},%
    {nodate}{4}%
  }{#1}%
    \ifcase\@tempa
      \endgroup
      \@refwidetrue
    \or
      \endgroup
      \@refwidefalse
    \or
      \endgroup
      \def\@datepos{2}%
    \or
      \endgroup
      \def\@datepos{1}%
    \or
      \endgroup
      \def\@datepos{0}%
    \fi
}
\newcommand{\subject@format}[1]{#1}
\newcommand*{\raggedsubject}{}
\newif\if@subj
\newif\if@subjafter
\KOMA@key{subject}{%
  \begingroup
    \KOMA@set@ncmdkey{subject}{@tempa}{%
      {titled}{0},%
      {untitled}{1},%
      {afteropening}{2},%
      {beforeopening}{3},%
      {underlined}{4},%
      {left}{5},%
      {right}{6},%
      {centered}{7}%
    }{#1}%
    \ifcase\@tempa
      \aftergroup\@subjtrue
    \or
      \aftergroup\@subjfalse
    \or
      \aftergroup\@subjaftertrue
    \or
      \aftergroup\@subjafterfalse
    \or
      \aftergroup\let\aftergroup\subject@format\aftergroup\underline
    \or
      \aftergroup\let\aftergroup\raggedsubject\aftergroup\raggedright
    \or
      \aftergroup\let\aftergroup\raggedsubject\aftergroup\raggedleft
    \or
      \aftergroup\let\aftergroup\raggedsubject\aftergroup\centering
    \fi
  \endgroup
}
\KOMA@ifkey{enlargefirstpage}{@enlargefp}
\KOMA@ifkey{firstfoot}{@firstfoot}\@firstfoottrue
\newcommand*{\@pageat}{4}
\KOMA@key{pagenumber}{%
  \begingroup
    \KOMA@set@ncmdkey{pagenumber}{@tempa}{%
      {no}{-1},{off}{-1},{false}{-1},%
      {topleft}{0},{headleft}{0},%
      {topmiddle}{1},{topcenter}{1},{topcentered}{1},%
      {headmiddle}{1},{headcenter}{1},{headcentered}{1},%
      {topright}{2},{headright}{2},%
      {botleft}{3},{footleft}{3},%
      {botmiddle}{4},{botcenter}{4},{botcentered}{4},%
      {footmiddle}{4},{footcenter}{4},{footcentered}{4},%
      {botright}{5},{footright}{5},%
      {top}{10},{head}{10},{bot}{11},{foot}{11},%
      {left}{20},{middle}{21},{center}{21},{centered}{21},{right}{22}%
    }{#1}%
    \ifnum\@tempa<10
      \edef\@tempa{\endgroup\edef\noexpand\@pageat{\@tempa}}%
    \else
      \ifnum\@tempa<20
        \@tempcnta\@pageat\relax
        \ifnum\@tempcnta>2
          \advance\@tempcnta by -3
        \fi
        \ifnum\@tempa=11
          \advance\@tempcnta by 3
        \fi
        \edef\@tempa{\endgroup\edef\noexpand\@pageat{\the\@tempcnta}}%
      \else
        \ifnum\@pageat>2
          \edef\@pageat{3}%
        \else
          \edef\@pageat{0}%
        \fi
        \@tempcnta\@tempa
        \advance\@tempcnta by -20
        \advance\@tempcnta by\@pageat
        \edef\@tempa{\endgroup\edef\noexpand\@pageat{\the\@tempcnta}}%
      \fi
    \fi
  \@tempa
}
%%% From File: scrkcile.dtx
%%% From File: scrkmisc.dtx
\KOMAExecuteOptions{%
  parskip=false,%
  headings=big%
}
\KOMAProcessOptions\relax
%%% From File: scrkcomp.dtx
\expandafter\ifnum \@nameuse{scr@v@2.95}>\scr@compatibility\relax
  \newcommand*{\@setif}[2][]{%
    \begingroup
      \edef\@tempa{#1}\ifx\@tempa\@empty
        \def\@tempa{\KOMA@set@ifkey{#2}{@#2}}%
      \else
        \def\@tempa{\KOMA@set@ifkey{#2}{#1}}%
      \fi
    \expandafter\endgroup\@tempa
  }%
\fi
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
%%% From File: scrkmisc.dtx
\setlength{\skip\@mpfootins}{\skip\footins}
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
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
%%% From File: scrklco.dtx
\newcommand*{\LoadLetterOption}[1]{%
  \@ifundefined{@restore@catcode@level}%
    {\let\@restore@catcode@level=\z@}{}%
  \ifnum\@restore@catcode@level =\z@
    \ifnum\catcode`\@=11
      \let\@restore@catcode\relax
    \else
      \@tempcnta=\catcode`\@
      \edef\@restore@catcode{%
        \noexpand\catcode`\noexpand\@=\the\@tempcnta}%
      \makeatletter
    \fi
  \fi
  \@tempcnta=\@restore@catcode@level\relax
  \advance\@tempcnta by \@ne\relax
  \edef\@restore@catcode@level{\the\@tempcnta}%
  \InputIfFileExists{#1.lco}{%
    \ClassInfo{%
      scrlttr2%
      }{Letter-Class-Option `#1' loaded}%
    }{%
    \ClassError{%
      scrlttr2%
      }{%
      Letter-Class-Option file `#1.lco' not found%
      }{%
      You've told me to load the Letter-Class-Option `#1'. So I have
      to load\MessageBreak
      the file `#1.lco'. But the file isn't available.}%
    }%
  \@tempcnta=\@restore@catcode@level\relax
  \advance\@tempcnta by \m@ne\relax
  \edef\@restore@catcode@level{\the\@tempcnta}%
  \ifnum\@tempcnta =\z@
    \@restore@catcode
  \fi
  }
\newcommand*{\LOPNP@option}{}
\newcommand*{\LOPNP@size}{}
\newcommand*{\@PapersizeWarning}{%
  \begingroup%
    \edef\@tempc{\noexpand\@tempswatrue
      \noexpand\ifdim\paperwidth=\the\paperwidth\noexpand\else
      \noexpand\@tempswafalse\noexpand\fi
      \noexpand\ifdim\paperheight=\the\paperheight\noexpand\else
      \noexpand\@tempswafalse\noexpand\fi
      \noexpand\@@PapersizeWarning
      }
    \def\@tempb{letter}\ifx\LOPNP@size\@tempb%
      \setlength{\paperheight}{11in}\setlength{\paperwidth}{8.5in}%
    \else\def\@tempb{legal}\ifx\LOPNP@size\@tempb%
      \setlength{\paperheight}{14in}\setlength{\paperwidth}{8.5in}%
    \else\def\@tempb{executive}\ifx\LOPNP@size\@tempb%
      \setlength{\paperheight}{10.5in}\setlength{\paperwidth}{7.25in}%
    \else%
      \def\ta@opt@err{%
        \ClassError{%
          scrlttr2%
          }{papersize `\LOPNP@size' undefined}{%
          You've told me to check for paper size
          `\LOPNP@size'\MessageBreak
          at letter option file `\LOPNP@option.lco',\MessageBreak
          but this paper size is not supported.\MessageBreak
          See the KOMA-Script manual for informations about known
          paper sizes.}%
        }%
      \let\@headlines\ta@opt@err%
      \expandafter\x@@paper\LOPNP@size paperpaper\x@@paper%
    \fi\fi\fi
    \@tempc
  \endgroup%
}
\newcommand*{\@@PapersizeWarning}{%
  \if@tempswa\else%
  \ClassWarningNoLine{%
    scrlttr2%
    }{%
    Letter option file `\LOPNP@option.lco'\MessageBreak
    needs paper size `\LOPNP@size'.\MessageBreak
    Current paper size is not `\LOPNP@size'!\MessageBreak
    You should add `paper=\LOPNP@size' at the\MessageBreak
    option list of \string\documentclass!\MessageBreak
    Maybe you know what you are doing,\MessageBreak
    so I do not change this myself}%
  \fi
  }
\newcommand*{\LetterOptionNeedsPapersize}[2]{%
  \edef\LOPNP@size{#2}\edef\LOPNP@option{#1}%
  }
%%% From File: scrklang.dtx
\newcommand*{\g@addnumerical@date}[2]{%
  \@ifundefined{date#1}{%
    \ClassInfo{%
      scrlttr2%
    }{%
      no date found for language `#1'\MessageBreak
      --> skipped%
    }%
  }{%
    \expandafter\g@addto@macro\csname date#1\endcsname{%
      \let\sym@date=\today%
      \def\num@date{#2}%
      \def\today{\if@orgdate\sym@date\else\num@date\fi}%
    }%
  }%
}
\AtBeginDocument{%
  \@ifundefined{captionsenglish}{\let\captionsenglish\@empty}{}%
  \@ifundefined{dateenglish}{\def\dateenglish{%
      \def\today{\ifcase\month\or
        January\or February\or March\or April\or May\or June\or
        July\or August\or September\or October\or November\or December\fi
        \space\number\day, \number\year}%
    }%
  }{}%
  \providecaptionname{english}\yourrefname{Your ref.}%
  \providecaptionname{english}\yourmailname{Your letter of}%
  \providecaptionname{english}\myrefname{Our ref.}%
  \providecaptionname{english}\customername{Customer no.}%
  \providecaptionname{english}\invoicename{Invoice no.}%
  \providecaptionname{english}\subjectname{Subject}%
  \providecaptionname{english}\ccname{cc}%
  \providecaptionname{english}\enclname{encl}%
  \providecaptionname{english}\headtoname{To}%
  \providecaptionname{english}\headfromname{From}%
  \providecaptionname{english}\datename{Date}%
  \providecaptionname{english}\pagename{Page}%
  \providecaptionname{english}\phonename{Phone}%
  \providecaptionname{english}\faxname{Fax}%
  \providecaptionname{english}\emailname{Email}%
  \providecaptionname{english}\wwwname{Url}%
  \providecaptionname{english}\bankname{Bank account}%
  \g@addnumerical@date{english}{\number\day/\number\month/\number\year}%
  \providecaptionname{USenglish}\yourrefname{Your ref.}%
  \providecaptionname{USenglish}\yourmailname{Your letter of}%
  \providecaptionname{USenglish}\myrefname{Our ref.}%
  \providecaptionname{USenglish}\customername{Customer no.}%
  \providecaptionname{USenglish}\invoicename{Invoice no.}%
  \providecaptionname{USenglish}\subjectname{Subject}%
  \providecaptionname{USenglish}\ccname{cc}%
  \providecaptionname{USenglish}\enclname{encl}%
  \providecaptionname{USenglish}\headtoname{To}%
  \providecaptionname{USenglish}\headfromname{From}%
  \providecaptionname{USenglish}\datename{Date}%
  \providecaptionname{USenglish}\pagename{Page}%
  \providecaptionname{USenglish}\phonename{Phone}%
  \providecaptionname{USenglish}\faxname{Fax}%
  \providecaptionname{USenglish}\emailname{Email}%
  \providecaptionname{USenglish}\wwwname{Url}%
  \providecaptionname{USenglish}\bankname{Bank account}%
  \g@addnumerical@date{USenglish}{\number\month/\number\day/\number\year}%
  \providecaptionname{american}\yourrefname{Your ref.}%
  \providecaptionname{american}\yourmailname{Your letter of}%
  \providecaptionname{american}\myrefname{Our ref.}%
  \providecaptionname{american}\customername{Customer no.}%
  \providecaptionname{american}\invoicename{Invoice no.}%
  \providecaptionname{american}\subjectname{Subject}%
  \providecaptionname{american}\ccname{cc}%
  \providecaptionname{american}\enclname{encl}%
  \providecaptionname{american}\headtoname{To}%
  \providecaptionname{american}\headfromname{From}%
  \providecaptionname{american}\datename{Date}%
  \providecaptionname{american}\pagename{Page}%
  \providecaptionname{american}\phonename{Phone}%
  \providecaptionname{american}\faxname{Fax}%
  \providecaptionname{american}\emailname{Email}%
  \providecaptionname{american}\wwwname{Url}%
  \providecaptionname{american}\bankname{Bank account}%
  \g@addnumerical@date{american}{\number\month/\number\day/\number\year}%
  \providecaptionname{british}\yourrefname{Your ref.}%
  \providecaptionname{british}\yourmailname{Your letter of}%
  \providecaptionname{british}\myrefname{Our ref.}%
  \providecaptionname{british}\customername{Customer no.}%
  \providecaptionname{british}\invoicename{Invoice no.}%
  \providecaptionname{british}\subjectname{Subject}%
  \providecaptionname{british}\ccname{cc}%
  \providecaptionname{british}\enclname{encl}%
  \providecaptionname{british}\headtoname{To}%
  \providecaptionname{british}\headfromname{From}%
  \providecaptionname{british}\datename{Date}%
  \providecaptionname{british}\pagename{Page}%
  \providecaptionname{british}\phonename{Phone}%
  \providecaptionname{british}\faxname{Fax}%
  \providecaptionname{british}\emailname{Email}%
  \providecaptionname{british}\wwwname{Url}%
  \providecaptionname{british}\bankname{Bank account}%
  \g@addnumerical@date{british}{\number\day/\number\month/\number\year}%
  \providecaptionname{UKenglish}\yourrefname{Your ref.}%
  \providecaptionname{UKenglish}\yourmailname{Your letter of}%
  \providecaptionname{UKenglish}\myrefname{Our ref.}%
  \providecaptionname{UKenglish}\customername{Customer no.}%
  \providecaptionname{UKenglish}\invoicename{Invoice no.}%
  \providecaptionname{UKenglish}\subjectname{Subject}%
  \providecaptionname{UKenglish}\ccname{cc}%
  \providecaptionname{UKenglish}\enclname{encl}%
  \providecaptionname{UKenglish}\headtoname{To}%
  \providecaptionname{UKenglish}\headfromname{From}%
  \providecaptionname{UKenglish}\datename{Date}%
  \providecaptionname{UKenglish}\pagename{Page}%
  \providecaptionname{UKenglish}\phonename{Phone}%
  \providecaptionname{UKenglish}\faxname{Fax}%
  \providecaptionname{UKenglish}\emailname{Email}%
  \providecaptionname{UKenglish}\wwwname{Url}%
  \providecaptionname{UKenglish}\bankname{Bank account}%
  \g@addnumerical@date{UKenglish}{\number\day/\number\month/\number\year}%
  \providecaptionname{german}\yourrefname{Ihr Zeichen}%
  \providecaptionname{german}\yourmailname{Ihr Schreiben vom}%
  \providecaptionname{german}\myrefname{Unser Zeichen}%
  \providecaptionname{german}\customername{Kundennummer}%
  \providecaptionname{german}\invoicename{Rechnungsnummer}%
  \providecaptionname{german}\subjectname{Betrifft}%
  \providecaptionname{german}\ccname{Kopien an}%
  \providecaptionname{german}\enclname{Anlagen}%
  \providecaptionname{german}\headtoname{An}%
  \providecaptionname{german}\headfromname{Von}%
  \providecaptionname{german}\datename{Datum}%
  \providecaptionname{german}\pagename{Seite}%
  \providecaptionname{german}\phonename{Telephon}%
  \providecaptionname{german}\faxname{Fax}%
  \providecaptionname{german}\emailname{E-Mail}%
  \providecaptionname{german}\wwwname{URL}%
  \providecaptionname{german}\bankname{Bankverbindung}%
  \g@addnumerical@date{german}{\number\day.\,\number\month.\,\number\year}%
  \providecaptionname{ngerman}\yourrefname{Ihr Zeichen}%
  \providecaptionname{ngerman}\yourmailname{Ihr Schreiben vom}%
  \providecaptionname{ngerman}\myrefname{Unser Zeichen}%
  \providecaptionname{ngerman}\customername{Kundennummer}%
  \providecaptionname{ngerman}\invoicename{Rechnungsnummer}%
  \providecaptionname{ngerman}\subjectname{Betrifft}%
  \providecaptionname{ngerman}\ccname{Kopien an}%
  \providecaptionname{ngerman}\enclname{Anlagen}%
  \providecaptionname{ngerman}\headtoname{An}%
  \providecaptionname{ngerman}\headfromname{Von}%
  \providecaptionname{ngerman}\datename{Datum}%
  \providecaptionname{ngerman}\pagename{Seite}%
  \providecaptionname{ngerman}\phonename{Telefon}%
  \providecaptionname{ngerman}\faxname{Fax}%
  \providecaptionname{ngerman}\emailname{E-Mail}%
  \providecaptionname{ngerman}\wwwname{URL}%
  \providecaptionname{ngerman}\bankname{Bankverbindung}%
  \g@addnumerical@date{ngerman}{\number\day.\,\number\month.\,\number\year}%
  \providecaptionname{austrian}\yourrefname{Ihr Zeichen}%
  \providecaptionname{austrian}\yourmailname{Ihr Schreiben vom}%
  \providecaptionname{austrian}\myrefname{Unser Zeichen}%
  \providecaptionname{austrian}\customername{Kundennummer}%
  \providecaptionname{austrian}\invoicename{Rechnungsnummer}%
  \providecaptionname{austrian}\subjectname{Betrifft}%
  \providecaptionname{austrian}\ccname{Kopien an}%
  \providecaptionname{austrian}\enclname{Anlagen}%
  \providecaptionname{austrian}\headtoname{An}%
  \providecaptionname{austrian}\headfromname{Von}%
  \providecaptionname{austrian}\datename{Datum}%
  \providecaptionname{austrian}\pagename{Seite}%
  \providecaptionname{austrian}\phonename{Telefon}%
  \providecaptionname{austrian}\faxname{Fax}%
  \providecaptionname{austrian}\emailname{E-Mail}%
  \providecaptionname{austrian}\wwwname{URL}%
  \providecaptionname{austrian}\bankname{Bankverbindung}%
  \g@addnumerical@date{austrian}{\number\day.\,\number\month.\,\number\year}%
  \providecaptionname{naustrian}\yourrefname{Ihr Zeichen}%
  \providecaptionname{naustrian}\yourmailname{Ihr Schreiben vom}%
  \providecaptionname{naustrian}\myrefname{Unser Zeichen}%
  \providecaptionname{naustrian}\customername{Kundennummer}%
  \providecaptionname{naustrian}\invoicename{Rechnungsnummer}%
  \providecaptionname{naustrian}\subjectname{Betrifft}%
  \providecaptionname{naustrian}\ccname{Kopien an}%
  \providecaptionname{naustrian}\enclname{Anlagen}%
  \providecaptionname{naustrian}\headtoname{An}%
  \providecaptionname{naustrian}\headfromname{Von}%
  \providecaptionname{naustrian}\datename{Datum}%
  \providecaptionname{naustrian}\pagename{Seite}%
  \providecaptionname{naustrian}\phonename{Telefon}%
  \providecaptionname{naustrian}\faxname{Fax}%
  \providecaptionname{naustrian}\emailname{E-Mail}%
  \providecaptionname{naustrian}\wwwname{URL}%
  \providecaptionname{naustrian}\bankname{Bankverbindung}%
  \g@addnumerical@date{naustrian}{\number\day.\,\number\month.\,\number\year}%
  \providecaptionname{french}\yourrefname{Vos r\'ef\'erences}%
  \providecaptionname{french}\yourmailname{Votre lettre du}%
  \providecaptionname{french}\myrefname{Nos r\'ef\'erences}%
  \providecaptionname{french}\customername{Num\'ero de client}%
  \providecaptionname{french}\invoicename{Num\'ero de facture}%
  \providecaptionname{french}\subjectname{Concernant}%
  \providecaptionname{french}\ccname{Copie \`a}%
  \providecaptionname{french}\enclname{Annexes}%
  \providecaptionname{french}\headtoname{A}%
  \providecaptionname{french}\headfromname{De}%
  \providecaptionname{french}\datename{Date}%
  \providecaptionname{french}\pagename{Page}%
  \providecaptionname{french}\phonename{T\'el\'ephone}%
  \providecaptionname{french}\faxname{T\'el\'efax}%
  \providecaptionname{french}\emailname{E-mail}%
  \providecaptionname{french}\wwwname{URL}%
  \providecaptionname{french}\bankname{Compte en banque}%
  \g@addnumerical@date{french}{\number\day.\,\number\month.\,\number\year}%
  \providecaptionname{italian}\yourrefname{Vs./Rif.}% or Vostro Riferimento
  \providecaptionname{italian}\yourmailname{Vs.~lettera del}% or Vostra
                                                            % lettera del
  \providecaptionname{italian}\myrefname{Ns./Rif.}% or Nostro Riferimento
  \providecaptionname{italian}\customername{Nr.~cliente}% or Cliente num.
  \providecaptionname{italian}\invoicename{Nr.~fattura}% or Fattura num.
  \providecaptionname{italian}\subjectname{Oggetto}%
  \providecaptionname{italian}\ccname{Per conoscenza}% or Copia a
  \providecaptionname{italian}\enclname{Allegato}% or (plural) Allegati
  \providecaptionname{italian}\headtoname{A}%
  \providecaptionname{italian}\headfromname{Da}%
  \providecaptionname{italian}\datename{Data}%
  \providecaptionname{italian}\pagename{Pagina}%
  \providecaptionname{italian}\phonename{Telefono}%
  \providecaptionname{italian}\faxname{Fax}%
  \providecaptionname{italian}\emailname{Email}%
  \providecaptionname{italian}\wwwname{Sito Web}%
  \providecaptionname{italian}\bankname{Conto bancario}%
  \g@addnumerical@date{italian}{\number\day.\,\number\month.\,\number\year}%
  \providecaptionname{spanish}\yourrefname{Su ref.}%
  \providecaptionname{spanish}\yourmailname{Su carta de}%
  \providecaptionname{spanish}\myrefname{Nuestra ref.}%
  \providecaptionname{spanish}\customername{No. de cliente}%
  \providecaptionname{spanish}\invoicename{No. de factura}%
  \providecaptionname{spanish}\subjectname{Asunto}%
  \providecaptionname{spanish}\ccname{Copias}%
  \providecaptionname{spanish}\enclname{Adjunto}%
  \providecaptionname{spanish}\headtoname{A}%
  \providecaptionname{spanish}\headfromname{De}%
  \providecaptionname{spanish}\datename{Fecha}%
  \providecaptionname{spanish}\pagename{P\'agina}%
  \providecaptionname{spanish}\phonename{Tel\'efono}%
  \providecaptionname{spanish}\faxname{Fax}%
  \providecaptionname{spanish}\emailname{Email}% or Correo electr\'onico
  \providecaptionname{spanish}\wwwname{URL}% or P\`agina web
  \providecaptionname{spanish}\bankname{Cuenta bancaria}%
  \g@addnumerical@date{spanish}{\number\day.\,\number\month.\,\number\year}%
  \providecaptionname{croatian}\yourrefname{Va\v{s} znak}%
  \providecaptionname{croatian}\yourmailname{Va\v{s}e pismo od}%
  \providecaptionname{croatian}\myrefname{Na\v{s} znak}%
  \providecaptionname{croatian}\customername{Broj kupca}%
  \providecaptionname{croatian}\invoicename{Broj fakture}%
  \providecaptionname{croatian}\subjectname{Predmet}%
  \providecaptionname{croatian}\ccname{Kopija}%
  \providecaptionname{croatian}\enclname{Privitak}%
  \providecaptionname{croatian}\headtoname{Prima}%
  \providecaptionname{croatian}\headfromname{\v{S}alje}%
  \providecaptionname{croatian}\datename{Nadnevak}%
  \providecaptionname{croatian}\pagename{Stranica}%
  \providecaptionname{croatian}\phonename{Telefon}%
  \providecaptionname{croatian}\faxname{Fax}%
  \providecaptionname{croatian}\emailname{E-Mail}%
  \providecaptionname{croatian}\wwwname{URL}%
  \providecaptionname{croatian}\bankname{Bankovna veza}%
  \g@addnumerical@date{croatian}{\number\day.\,\number\month.\,\number\year.}%
  \providecaptionname{dutch}\yourrefname{Uw kenmerk}%
  \providecaptionname{dutch}\yourmailname{Uw brief van}%
  \providecaptionname{dutch}\myrefname{Ons kenmerk}%
  \providecaptionname{dutch}\customername{Klant No.}%
  \providecaptionname{dutch}\invoicename{Rekening No.}%
  \providecaptionname{dutch}\subjectname{Onderwerp}%
  \providecaptionname{dutch}\ccname{Kopie aan}%
  \providecaptionname{dutch}\enclname{Bijlage(n)}%
  \providecaptionname{dutch}\headtoname{Aan}%
  \providecaptionname{dutch}\headfromname{Van}%
  \providecaptionname{dutch}\datename{Datum}%
  \providecaptionname{dutch}\pagename{Pagina}%
  \providecaptionname{dutch}\phonename{Telefoon}%
  \providecaptionname{dutch}\faxname{Fax}%
  \providecaptionname{dutch}\emailname{E--mail}%
  \providecaptionname{dutch}\wwwname{URL}%
  \providecaptionname{dutch}\bankname{Bankrekening}%
  \g@addnumerical@date{dutch}{\number\day.\,\number\month.\,\number\year}%
  \providecaptionname{finnish}\yourrefname{Viitteenne}%
  \providecaptionname{finnish}\yourmailname{Kirjeenne}%
  \providecaptionname{finnish}\myrefname{Viitteemme}%
  \providecaptionname{finnish}\customername{Asiakasnumero}%
  \providecaptionname{finnish}\invoicename{Laskun numero}%
  \providecaptionname{finnish}\subjectname{Asia}%
  \providecaptionname{finnish}\ccname{Jakelu}%
  \providecaptionname{finnish}\enclname{Liitteet}%
  \providecaptionname{finnish}\headtoname{Vastaanottaja}%
  \providecaptionname{finnish}\headfromname{L\"ahett\"aj\"a}%
  \providecaptionname{finnish}\datename{P\"aiv\"a}%
  \providecaptionname{finnish}\pagename{Sivu}%
  \providecaptionname{finnish}\phonename{Puhelin}%
  \providecaptionname{finnish}\faxname{Faksi}%
  \providecaptionname{finnish}\emailname{S\"ahk\"oposti}%
  \providecaptionname{finnish}\wwwname{URL}%
  \providecaptionname{finnish}\bankname{Pankkitilin numero}%
  \g@addnumerical@date{finnish}{\number\day.\number\month.\number\year}%
  \providecaptionname{norsk}\yourrefname{Deres ref.}%
  \providecaptionname{norsk}\yourmailname{Deres brev av:}%
  \providecaptionname{norsk}\myrefname{V\aa{}r ref:}%
  \providecaptionname{norsk}\customername{Kundenummer}%
  \providecaptionname{norsk}\invoicename{Fakturanummer}%
  \providecaptionname{norsk}\subjectname{Emne}%
  \providecaptionname{norsk}\ccname{Kopi til}%
  \providecaptionname{norsk}\enclname{Vedlegg}%
  \providecaptionname{norsk}\headtoname{Til}%
  \providecaptionname{norsk}\headfromname{Fra}%
  \providecaptionname{norsk}\datename{Dato}%
  \providecaptionname{norsk}\pagename{Side}%
  \providecaptionname{norsk}\phonename{Telefon}%
  \providecaptionname{norsk}\faxname{Telefaks}%
  \providecaptionname{norsk}\emailname{E-post}%
  \providecaptionname{norsk}\wwwname{Url}%
  \providecaptionname{norsk}\bankname{Bankkontonummer}%
  \g@addnumerical@date{norsk}{\number\day.\number\month.\number\year}%
  \providecaptionname{swedish}\yourrefname{Er ref}%
  \providecaptionname{swedish}\yourmailname{Ert brev av}%
  \providecaptionname{swedish}\myrefname{V\aa{}r ref}%
  \providecaptionname{swedish}\customername{Kundnummer}%
  \providecaptionname{swedish}\invoicename{Fakturanummer}%
  \providecaptionname{swedish}\subjectname{\"Amne}%
  \providecaptionname{swedish}\ccname{Kopia till}%
  \providecaptionname{swedish}\enclname{Bilagor}% Singular: Bilaga
  \providecaptionname{swedish}\headtoname{Till}%
  \providecaptionname{swedish}\headfromname{Fr\aa{}n}%
  \providecaptionname{swedish}\datename{Datum}%
  \providecaptionname{swedish}\pagename{Sida}%
  \providecaptionname{swedish}\phonename{Telefon}%
  \providecaptionname{swedish}\faxname{Telefax}%
  \providecaptionname{swedish}\emailname{E-post}%
  \providecaptionname{swedish}\wwwname{Hemsida}%
  \providecaptionname{swedish}\bankname{Bankgiro}% PlusGiro
  \g@addnumerical@date{swedish}{\number\day/\number\month~\number\year}%
  \captionsenglish
  \dateenglish
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname date\languagename\endcsname\relax
    \ClassWarningNoLine{%
      scrlttr2%
    }{%
      \string\language\space is \the\language, \string\languagename\space is
      `\languagename'\MessageBreak
      but \expandafter\string\csname
      date\languagename\endcsname\space not defined!\MessageBreak
      This seems to be a bug at you're `hyphen.cfg'.\MessageBreak
      Undefining macro \string\languagename\space to avoid errors%
    }%
    \let\languagename=\undefined
  \fi
  \ifx\languagename\undefined
    \ClassWarningNoLine{scrlttr2}{\string\languagename\space not
      defined, using \string\language.\MessageBreak
      This may result in use of wrong language!\MessageBreak
      You should use a compatible language
      package\MessageBreak
      (e.g. `Babel', `german', `ngerman', ...)}%
    \ifx\l@american\undefined\else\ifnum\language=\l@american
        \captionsamerican
        \dateamerican
    \fi\fi
    \ifx\l@british\undefined\else\ifnum\language=\l@british
        \captionsbritish
        \datebritish
    \fi\fi
    \ifx\l@UKenglish\undefined\else\ifnum\language=\l@UKenglish
        \captionsUKenglish
        \dateUKenglish
    \fi\fi
    \ifx\l@USenglish\undefined\else\ifnum\language=\l@USenglish
        \captionsUSenglish
        \dateUSenglish
    \fi\fi
    \ifx\l@austrian\undefined\else\ifnum\language=\l@austrian
        \captionsaustrian
        \dateaustrian
    \fi\fi
    \ifx\l@naustrian\undefined\else\ifnum\language=\l@naustrian
        \captionsnaustrian
        \datenaustrian
    \fi\fi
    \ifx\l@german\undefined\else\ifnum\language=\l@german
        \captionsgerman
        \dategerman
    \fi\fi
    \ifx\l@ngerman\undefined\else\ifnum\language=\l@ngerman
        \captionsngerman
        \datengerman
    \fi\fi
    \ifx\l@french\undefined\else\ifnum\language=\l@french
        \captionsfrench
        \datefrench
    \fi\fi
    \ifx\l@italian\undefined\else\ifnum\language=\l@italian
        \captionsitalian
        \dateitalian
    \fi\fi
    \ifx\l@spanish\undefined\else\ifnum\language=\l@spanish
        \captionsspanish
        \datespanish
    \fi\fi
    \ifx\l@croatian\undefined\else\ifnum\language=\l@croatian
        \captionscroatian
        \datecroatian
    \fi\fi
    \ifx\l@dutch\undefined\else\ifnum\language=\l@dutch
        \captionsdutch
        \datedutch
    \fi\fi
    \ifx\l@finnish\undefined\else\ifnum\language=\l@finnish
        \captionsfinnish
        \datefinnish
    \fi\fi
    \ifx\l@norsk\undefined\else\ifnum\language=\l@norsk
        \captionsnorsk
        \datenorsk
    \fi\fi
    \ifx\l@swedish\undefined\else\ifnum\language=\l@swedish
        \captionsswedish
        \dateswedish
    \fi\fi
  \else
    \edef\@tempa{nohyphenation}%
    \ifx\languagename\@tempa
      \ClassWarningNoLine{%
        scrlttr2%
      }{%
        You've selected language `\languagename'.\MessageBreak
        Maybe your LaTeX format contains Babel extension\MessageBreak
        but you have not selected a language using\MessageBreak
        Babel package.\MessageBreak
        Please select another language!\MessageBreak
        Only as a workaround english captions and date\MessageBreak
        will be used%
      }%
    \else
      \expandafter\selectlanguage\expandafter{\languagename}%
      \ClassInfo{%
        scrlttr2%
      }{%
        used language is `\languagename'.\MessageBreak
        Supported languages are `english', `UKenglish',\MessageBreak
        `british', `american', `USenglish',\MessageBreak
        `german', `ngerman', `austrian', `naustrian',\MessageBreak
        `dutch', `italian', `spanish',\MessageBreak
        `croatian', `finnish', `norsk'%
      }%
    \fi
  \fi
}
%%% From File: scrkvars.dtx
\newcommand*{\newkomavar}{%
  \@ifstar {\@tempswatrue\@newkomavar}{\@tempswafalse\@newkomavar}}
\newcommand*{\@newkomavar}[2][\relax]{%
  \@ifundefined{scr@#2@name}{%
    \@ifundefined{scr@#2@var}{%
      \begingroup
        \def\@tempa{#1}\def\@tempb{\relax}%
        \ifx\@tempa\@tempb\endgroup\else
        \endgroup\@namedef{scr@#2@name}{#1}%
      \fi%
      \expandafter\let\csname scr@#2@var\endcsname=\@empty
      \if@tempswa\addtoreffields{#2}\fi
    }{%
      \ClassError{%
        scrlttr2%
      }{%
        This should never happen%
      }{%
        The contents of the KOMA-Script variable `#2'\MessageBreak
        is undefined, but the name of the variable is
        defined.\MessageBreak
        This should never happen. So someone crashs me!%
      }%
    }%
  }{%
    \ClassError{%
      scrlttr2%
    }{%
      Variable `#2' already defined%
    }{%
      I'll ignore this command, if you'll continue.%
    }%
  }%
}
\newcommand*{\setkomavar}{%
  \@ifstar {\@setkomaname}{\@setkomavar}}
\newcommand*{\@setkomavar}[1]{%
  \@ifnextchar [%]
  {\@@setkomavar{#1}}{\@@setkomavar{#1}[\relax]}}
\newcommand*{\@setkomaname}[2]{%
  \@ifundefined{scr@#1@var}{%
    \@komavar@err{set}{#1}%
  }{%
    \@namedef{scr@#1@name}{#2}%
    \csname scr@#1@postsetname\endcsname
  }%
}
\newcommand*{\@@setkomavar}{}
\long\def\@@setkomavar#1[#2]#3{%
  \@ifundefined{scr@#1@var}{%
    \@komavar@err{set}{#1}%
  }{%
    \@namedef{scr@#1@var}{#3}%
    \csname scr@#1@postsetvar\endcsname
    \begingroup
      \def\@tempa{#2}\def\@tempb{\relax}%
      \ifx\@tempa\@tempb\endgroup\else
      \endgroup\@namedef{scr@#1@name}{#2}%
      \csname scr@#1@postsetname\endcsname
    \fi
  }%
}
\newcommand*{\@komavar@err}[2]{%
  \ClassError{%
    scrlttr2%
  }{%
    KOMA-Script variable not defined%
  }{%
    You've tried to #1 the not defined KOMA-Script variable
    `#2'.\MessageBreak
    You have to define the variable using \string\newkomavar\space
    before\MessageBreak
    you do this.%
  }%
}
\DeclareRobustCommand*{\usekomavar}{%
  \@ifstar {\@usekomaname}{\@usekomavar}}
\newcommand*{\@usekomavar}[2][\@firstofone]{%
  \@ifundefined{scr@#2@var}{%
    \@komavar@err{use}{#2}%
  }{%
    #1{\@nameuse{scr@#2@var}}%
  }%
}
\newcommand*{\@usekomaname}[2][\@firstofone]{%
  \@ifundefined{scr@#2@var}{%
    \@komavar@err{use}{#2}%
  }{%
    #1{\@nameuse{scr@#2@name}}%
  }%
}
\DeclareRobustCommand*{\ifkomavar}[1]{%
  \scr@ifundefinedorrelax{scr@#1@var}{%
    \expandafter\@secondoftwo
  }{%
    \expandafter\@firstoftwo
  }%
}
\DeclareRobustCommand*{\ifkomavarempty}{%
  \begingroup
  \@ifstar {\@tempswatrue\@ifkomavarempty}%
           {\@tempswafalse\@ifkomavarempty}%
  }
\newcommand{\@ifkomavarempty}[1]{%
    \ifkomavar{#1}{%
      \if@tempswa
        \@ifundefined{scr@#1@name}{%
          \aftergroup\@firstoftwo
        }{%
          \expandafter\ifx\csname scr@#1@name\endcsname\@empty
            \aftergroup\@firstoftwo
          \else
            \aftergroup\@secondoftwo
          \fi
        }%
      \else
        \expandafter\ifx\csname scr@#1@var\endcsname\@empty
          \aftergroup\@firstoftwo
        \else
          \aftergroup\@secondoftwo
        \fi
      \fi
    }{%
      \@komavar@err{use}{#1}%
      \aftergroup\@gobbletwo
    }%
  \endgroup
}
%%% From File: scrkplen.dtx
\newcommand*{\@newplength}[1]{%
  \@ifundefined{ltr@len@#1}{%
    \expandafter\let\csname ltr@len@#1\endcsname=\z@%
  }{%
    \ClassError{scrlttr2}{%
      pseudo-length \expandafter\string\csname ltr@len@#1\endcsname
      already defined%
      }{%
      You tried to define a new pseudo-length using
      \string\@newplength\MessageBreak
      which is already defined. Try another name or
      better\MessageBreak
      Don't use this KOMA-Script internal macro}%
    }%
  }
\scr@ifundefinedorrelax{dimexpr}{%
  \newcommand*{\useplength}[1]{%
    \number \csname ltx@len@#1\endcsname\relax}%
}{%
  \newcommand*{\useplength}[1]{%
    \dimexpr \csname ltr@len@#1\endcsname\relax}%
}
\newcommand*{\setlengthtoplength}[3][]{%
  \setlength{#2}{\useplength{#3}}%
  \setlength{#2}{#1#2}}
\newcommand*{\@setplength}[3][]{%
  \begingroup%
    \setlength{\@tempskipa}{#3}%
    \setlength{\@tempskipa}{#1\@tempskipa}%
    \edef\@tempa{\noexpand\endgroup%
      \noexpand\expandafter\noexpand\renewcommand\noexpand\expandafter*%
      \noexpand\csname ltr@len@#2\noexpand\endcsname{\the\@tempskipa}%
      }%
    \@tempa%
  }
\newcommand*{\addtolengthplength}[3][]{%
  \begingroup%
    \setlengthtoplength[{#1}]{\@tempskipa}{#3}%
    \edef\@tempa{\endgroup%
      \noexpand\addtolength{#2}{\the\@tempskipa}}%
    \@tempa%
  }
\newcommand*{\@addtoplength}[3][]{%
  \begingroup%
    \setlength{\@tempskipa}{#3}%
    \setlength{\@tempskipa}{#1\@tempskipa}%
    \addtolengthplength{\@tempskipa}{#2}%
    \edef\@tempa{\noexpand\endgroup%
      \noexpand\expandafter\noexpand\renewcommand\noexpand\expandafter*%
      \noexpand\csname ltr@len@#2\noexpand\endcsname{\the\@tempskipa}%
      }%
    \@tempa%
  }
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
\newcommand*{\scr@fnt@wrn@pagehead}[1]{%
  `pagehead' is only an alias of `pageheadfoot'.\MessageBreak
  Font of page foot will also be changed%
}
\newcommand*{\scr@fnt@pagefoot}{\footfont}
\newcommand*{\pagemark}{{\usekomafont{pagenumber}{%
    \pagename\ %
    \thepage}}}
\renewcommand*{\ps@plain}{%
  \renewcommand*{\@oddhead}{%
    \vbox{\vbox{\hsize=\textwidth\hbox to\textwidth{%
          \parbox[b]{\textwidth}{\strut
            \ifnum\@pageat>-1
              \ifnum\@pageat<3
                \ifcase\@pageat\raggedright\or\centering\or\raggedleft\fi
                \pagemark
              \else
                \hfill
              \fi
            \else
              \hfill
            \fi
          }%
        }%
        \if@hsl\kern1pt\rule{\textwidth}{.4pt}\fi
      }%
    }%
  }%
  \let\@evenhead\@oddhead%
  \renewcommand*{\@oddfoot}{%
    \parbox[t]{\textwidth}{%
      \if@fsl
        {%
          \raggedright%
          \vskip-\baselineskip\vskip.4pt
          \hrulefill\\
        }%
      \fi
      \ifnum\@pageat>2
        \ifcase\@pageat\or\or\or\raggedright\or\centering\or\raggedleft\fi
        \strut\pagemark
      \else
        \hfill
      \fi
    }%
  }%
  \let\@evenfoot\@oddfoot
}
\newcommand*{\ps@headings}{\let\@mkboth\markboth
  \renewcommand*{\@oddhead}{%
    \vbox{%
      \vbox{\hsize=\textwidth\hbox to\textwidth{\headfont\noindent
          \usekomavar{nexthead}}}%
      \if@hsl\kern1pt\rule{\textwidth}{.4pt}\fi%
    }%
  }%
  \let\@evenhead\@oddhead
  \renewcommand*{\@oddfoot}{%
    \parbox[t]{\textwidth}{%
      \if@fsl
        {%
          \raggedright%
          \vskip-\baselineskip\vskip.4pt
          \hrulefill\\
        }%
      \fi
      \vbox{\hsize=\textwidth\hbox to\textwidth{\headfont\footfont\noindent
          \usekomavar{nextfoot}}}%
    }%
  }%
  \let\@evenfoot\@oddfoot
}
\newcommand*{\ps@myheadings}{%
  \ps@headings
  \let\@mkboth\@gobbletwo
}
\pagestyle{plain}
\pagenumbering{arabic}
  \raggedbottom
  \onecolumn
%%% From File: scrkfloa.dtx
\newcommand\marginline[1]{%
  \marginpar[\raggedleft{#1}]{\raggedright #1}%
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
%%% From File: scrklist.dtx
  \setlength{\leftmargini}{2.5em}
\setlength{\leftmarginii}{2.2em}
\setlength{\leftmarginiii}{1.87em}
\setlength{\leftmarginiv}{1.7em}
  \setlength{\leftmarginv}{1em}
  \setlength{\leftmarginvi}{1em}
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
%%% From File: scrknpap.dtx
\newcommand*{\@firsthead}{%
  \ClassWarning{scrlttr2}{%
    Deprecated usage of \string\@firsthead.\MessageBreak
    \string\usekomavar{firsthead} should be used\MessageBreak
    instead of \string\@firsthead
  }%
  \usekomavar{firsthead}%
}
\newkomavar{firsthead}
\setkomavar{firsthead}{%
  \parbox[b]{\useplength{firstheadwidth}}%
  {\centering\usekomafont{fromaddress}{%
      \ifkomavarempty{fromname}{}{%
        {\usekomafont{fromname}%
          {\ignorespaces\usekomavar{fromname}}}\\[-8pt]
        {\usekomafont{fromrule}{\rule{\useplength{firstheadwidth}}{.4pt}}}\\
      }%
      \ifkomavarempty{fromaddress}{}{%
        \ignorespaces\usekomavar{fromaddress}%
      }%
    }%
  }%
}
\newcommand*{\scr@firsthead@postsetvar}{%
  \renewcommand*{\@alignfrom}{10000}%
}
\newcommand*{\@gen@firsthead}{%
  \ifcase\@alignfrom
    \setkomavar{firsthead}{%
      \parbox[b]{\textwidth}{\raggedright
        {\usekomafont{fromname}\strut\ignorespaces
          \usekomavar{fromname}%
          {%
            \ifnum\@rulefrom=1\\[-.5\baselineskip]%
              \usekomafont{fromrule}{%
                \setlength{\@tempdima}{\useplength{fromrulewidth}}%
                \ifdim\@tempdima=\z@
                  \setlength{\@tempdima}{\textwidth}%
                  \if@logo
                    \settowidth{\@tempdimb}{\usekomavar{fromlogo}}%
                    \addtolength{\@tempdima}{-\@tempdimb}%
                  \fi
                \fi
                \expandafter\rule\expandafter{\the\@tempdima}{%
                  \useplength{fromrulethickness}}}%
            \fi
          }%
          \\
        }%
        {\usekomafont{fromaddress}\strut\ignorespaces
          \usekomavar{fromaddress}%
          \if@phone\\\usekomavar*{fromphone}\usekomavar{fromphone}\fi%
          \if@fax\\\usekomavar*{fromfax}\usekomavar{fromfax}\fi%
          \if@email\\\usekomavar*{fromemail}\usekomavar{fromemail}\fi%
          \if@www\\\usekomavar*{fromurl}\usekomavar{fromurl}\fi%
          \ifnum\@rulefrom=2\\[-.5\baselineskip]%
            \usekomafont{fromrule}{%
              \setlength{\@tempdima}{\useplength{fromrulewidth}}%
              \ifdim\@tempdima=\z@
                \setlength{\@tempdima}{\textwidth}%
              \fi
              \expandafter\rule\expandafter{\the\@tempdima}{%
                \useplength{fromrulethickness}}}%
          \fi
          \\
        }%
      }%
      \if@logo
        \llap{\usekomavar{fromlogo}}%
      \fi
    }%
    \renewcommand*{\@alignfrom}{0}%
  \or
    \setkomavar{firsthead}{%
      \parbox[b]{\textwidth}{\centering
        {\usekomafont{fromname}\strut\ignorespaces
          \usekomavar{fromname}%
          {%
            \ifnum\@rulefrom=1\\[-.5\baselineskip]%
              \usekomafont{fromrule}{%
                \setlength{\@tempdima}{\useplength{fromrulewidth}}%
                \ifdim\@tempdima=\z@
                  \setlength{\@tempdima}{\textwidth}%
                \fi
                \expandafter\rule\expandafter{\the\@tempdima}{%
                  \useplength{fromrulethickness}}}%
            \fi
          }%
          \\
        }%
        {\usekomafont{fromaddress}\strut\ignorespaces
          \usekomavar{fromaddress}%
          \if@phone\\\usekomavar*{fromphone}\usekomavar{fromphone}\fi%
          \if@fax\\\usekomavar*{fromfax}\usekomavar{fromfax}\fi%
          \if@email\\\usekomavar*{fromemail}\usekomavar{fromemail}\fi%
          \if@www\\\usekomavar*{fromurl}\usekomavar{fromurl}\fi%
          \ifnum\@rulefrom=2\\[-.5\baselineskip]%
            \usekomafont{fromrule}{%
              \setlength{\@tempdima}{\useplength{fromrulewidth}}%
              \ifdim\@tempdima=\z@
                \setlength{\@tempdima}{\textwidth}%
              \fi
              \expandafter\rule\expandafter{\the\@tempdima}{%
                \useplength{fromrulethickness}}}%
          \fi
          \\
        }%
      }%
    }%
    \renewcommand*{\@alignfrom}{1}%
  \or
    \setkomavar{firsthead}{%
      \if@logo
        \rlap{\usekomavar{fromlogo}}%
      \fi
      \parbox[b]{\textwidth}{\raggedleft
        {\usekomafont{fromname}\strut\ignorespaces
          \usekomavar{fromname}%
          {%
            \ifnum\@rulefrom=1\\[-.5\baselineskip]%
              \usekomafont{fromrule}{%
                \setlength{\@tempdima}{\useplength{fromrulewidth}}%
                \ifdim\@tempdima=\z@
                  \setlength{\@tempdima}{\textwidth}%
                  \if@logo
                    \settowidth{\@tempdimb}{\usekomavar{fromlogo}}%
                    \addtolength{\@tempdima}{-\@tempdimb}%
                  \fi
                \fi
                \expandafter\rule\expandafter{\the\@tempdima}{%
                  \useplength{fromrulethickness}}}%
            \fi
          }%
          \\
        }%
        {\usekomafont{fromaddress}\strut\ignorespaces
          \usekomavar{fromaddress}%
          \if@phone\\\usekomavar*{fromphone}\usekomavar{fromphone}\fi%
          \if@fax\\\usekomavar*{fromfax}\usekomavar{fromfax}\fi%
          \if@email\\\usekomavar*{fromemail}\usekomavar{fromemail}\fi%
          \if@www\\\usekomavar*{fromurl}\usekomavar{fromurl}\fi%
          \ifnum\@rulefrom=2\\[-.5\baselineskip]%
            \usekomafont{fromrule}{%
              \setlength{\@tempdima}{\useplength{fromrulewidth}}%
              \ifdim\@tempdima=\z@
                \setlength{\@tempdima}{\textwidth}%
              \fi
              \expandafter\rule\expandafter{\the\@tempdima}{%
                \useplength{fromrulethickness}}}%
          \fi
          \\
        }%
      }%
    }%
    \renewcommand*{\@alignfrom}{2}%
  \fi
}
\newcommand{\firsthead}{%
  \ClassWarning{scrlttr2}{%
    Deprecated usage of \string\firsthead.\MessageBreak
    You should use \string\setkomavar{firsthead}\MessageBreak
    instead of \string\firsthead
  }
  \setkomavar{firsthead}%
}
\newkomafont{foldmark}{}
\newkomafont{fromname}{}
\newkomafont{fromaddress}{}
\newkomafont{fromrule}{}
\newkomafont{backaddress}{\sffamily}
\newkomafont{specialmail}{}
\newkomafont{priority}{\fontsize{10pt}{10pt}\sffamily\bfseries}
\newkomafont{prioritykey}{\fontsize{24.88pt}{24.88pt}\selectfont}
\newkomafont{PPlogo}{\sffamily\bfseries}
\newkomafont{PPdata}{\sffamily}
\newkomafont{addressee}{}
\newkomafont{toname}{}
\newkomafont{toaddress}{}
\newkomafont{refname}{\sffamily\scriptsize}
\ifnum\scr@compatibility=\@nameuse{scr@v@2.97}\relax
  \newkomafont{refvalue}{\sffamily\scriptsize}
\else
  \newkomafont{refvalue}{}
\fi
\newkomafont{title}{\normalcolor\sffamily\bfseries}
\newkomafont{subject}{\normalcolor\bfseries}
\@newplength{foldmarkhpos}
\@newplength{foldmarkvpos}
\@newplength{tfoldmarkvpos}
\@newplength{mfoldmarkvpos}
\@newplength{bfoldmarkvpos}
\@newplength{lfoldmarkhpos}
\@newplength{pfoldmarklength}
\@newplength{tfoldmarklength}
\@newplength{mfoldmarklength}
\@newplength{bfoldmarklength}
\@newplength{lfoldmarklength}
\@newplength{foldmarkthickness}
\@setplength{foldmarkthickness}{.2pt}
\@newplength{toaddrvpos}
\@newplength{backaddrheight}
\@newplength{toaddrhpos}
\@newplength{specialmailindent}
\@newplength{specialmailrightindent}
\@newplength{toaddrindent}
\@newplength{PPheadheight}
\@newplength{PPheadwidth}
\@newplength{PPdatamatrixvskip}
\@newplength{toaddrwidth}
\@newplength{toaddrheight}
\@newplength{locvpos}
\@newplength{locwidth}
\@newplength{lochpos}
\@newplength{locheight}
\@newplength{refvpos}
\@newplength{refwidth}
\@newplength{refhpos}
\@newplength{refaftervskip}
\@newplength{sigbeforevskip}
\@newplength{sigindent}
\@newplength{firstfootvpos}
\@newplength{firstfootwidth}
\@newplength{firstfoothpos}
\@setplength{firstfoothpos}{\maxdimen}
\@newplength{firstheadvpos}
\@newplength{firstheadwidth}
\@newplength{firstheadhpos}
\@setplength{firstheadhpos}{\maxdimen}
\@newplength{fromrulewidth}
\@setplength{fromrulewidth}{0pt}
\@newplength{fromrulethickness}
\@setplength{fromrulethickness}{.4pt}
\newkomavar{firstfoot}
\newcommand*{\@firstfoot}{%
  \ClassWarning{scrlttr2}{%
    Deprecated usage of \string\@firstfoot.\MessageBreak
    \string\usekomavar{firstfoot} should be used\MessageBreak
    instead of \string\@firstfoot
  }%
  \usekomavar{firstfoot}%
}
\newcommand{\firstfoot}{%
  \ClassWarning{scrlttr2}{%
    Deprecated usage of \string\firstfoot.\MessageBreak
    You should use \string\setkomavar{firstfoot}\MessageBreak
    instead of \string\firstfoot
  }
  \setkomavar{firstfoot}%
}
\newcommand*{\move@topt}{%
  \null\vskip -1in\vskip -\topmargin%
  \vskip -\headheight\vskip -\headsep%
  \vskip -\topskip%
  \ignorespaces%
}
\newcommand*{\move@frompt}{%
  \vskip 1in\vskip \topmargin%
  \vskip \headheight\vskip \headsep%
  \vskip \topskip%
  \vskip -\baselineskip%
  \ignorespaces%
}
\newcommand*{\move@topl}{%
  \null\hskip -1in%
  \ifodd\value{page}\hskip -\oddsidemargin\else\hskip -\evensidemargin\fi
  \ignorespaces%
}
\newcommand*{\move@frompl}{%
  \hskip 1in%
  \ifodd\value{page}\hskip \oddsidemargin\else\hskip \evensidemargin\fi%
  \ignorespaces%
}
\newcommand{\vb@t@z}[1]{{%
    \setbox0\vbox to\z@{#1\vss}%
    \setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative
    \setlength{\baselineskip}{\z@}%
    \setlength{\@tempdima}{\ht0}\addtolength{\@tempdima}{\dp0}%
    \box0\vskip-\@tempdima%
  }%
}
\newcommand*{\@foldmark}[2]{%
  \vb@t@z{\setlength{\@tempdima}{#1}%
    \addtolengthplength[-.5]{\@tempdima}{foldmarkthickness}%
    \vskip \@tempdima
    \rlap{\move@topl\hskip\useplength{foldmarkhpos}%
      \usekomafont{foldmark}{%
        \rule{#2}{\useplength{foldmarkthickness}}}}}%
  \ignorespaces
}
\newcommand*{\@hfoldmark}[1]{%
  \begingroup
    \@expandtwoargs\in@{#1}{\@usefolds}%
    \ifin@
      \lowercase{%
        \edef\@tempa{%
          \noexpand\ifdim \noexpand\useplength{#1foldmarkvpos}=\noexpand\z@
          \noexpand\else
            \noexpand\@foldmark{%
              \noexpand\useplength{#1foldmarkvpos}%
            }{%
              \noexpand\useplength{#1foldmarklength}%
            }%
          \noexpand\fi
        }%
      }%
      \@tempa
    \fi
  \endgroup
}
\newcommand*{\@vfoldmark}[1]{%
  \begingroup
    \@expandtwoargs\in@{#1}{\@usefolds}%
    \ifin@
      \ifdim \useplength{lfoldmarkhpos}=\z@\else
        \vb@t@z{%
          \ifdim \useplength{foldmarkvpos}<\z@
            \nobreak\vskip \paperheight\nobreak
          \fi
          \vskip \useplength{foldmarkvpos}%
          \vskip \useplength{foldmarkthickness}%
          \rlap{\move@topl
            \setlength{\@tempdima}{\useplength{lfoldmarkhpos}}%
            \addtolengthplength[-.5]{\@tempdima}{foldmarkthickness}%
            \hskip\@tempdima
            \usekomafont{foldmark}{%
              \rule{\useplength{foldmarkthickness}}%
                   {\useplength{lfoldmarklength}}%
            }%
          }%
        }%
        \ignorespaces
      \fi
    \fi
  \endgroup
}
\newcommand*{\@foldmarks}{%
  \if@fold%
    \typeout{Foldmarks: yes}%
    \move@topt
    \ifdim \useplength{pfoldmarklength}=\z@
      \@setplength{pfoldmarklength}{4mm}%
    \fi
    \ifdim \useplength{tfoldmarklength}=\z@
      \@setplength{tfoldmarklength}{2mm}%
    \fi
    \ifdim \useplength{mfoldmarklength}=\z@
      \@setplength{mfoldmarklength}{2mm}%
    \fi
    \ifdim \useplength{bfoldmarklength}=\z@
      \@setplength{bfoldmarklength}{2mm}%
    \fi
    \ifdim \useplength{lfoldmarklength}=\z@
      \@setplength{lfoldmarklength}{4mm}%
    \fi
    \begingroup
      \@expandtwoargs\in@{P}{\@usefolds}%
      \ifin@
        \@foldmark{.5\paperheight}{\useplength{pfoldmarklength}}%
      \fi
    \endgroup
    \@hfoldmark{T}%
    \@hfoldmark{M}%
    \@hfoldmark{B}%
    \@vfoldmark{L}%
    \move@frompt
  \else
    \typeout{Foldmarks: no}%
  \fi%
}
\newif\if@savevbox@warning\@savevbox@warningtrue
\newcommand{\@savevbox}[6][]{%
  \begingroup%
    \vbox to #2{#1#3}%
    \if@savevbox@warning\@savevbox@warningfalse%
    \setbox0\vbox{#3}%
    \setlength{\@tempdima}{#2}%
    \setlength{\@tempdimb}{\ht0}\addtolength{\@tempdimb}{\dp0}%
    \ifdim \@tempdimb>\@tempdima%
      \addtolength{\@tempdimb}{-\@tempdima}%
      \ClassWarning{%
        scrlttr2%
      }{%
        #4 is \the\@tempdimb\space too high.\MessageBreak
        You have to change `\string#5'\MessageBreak
        or you have to define a smaller\MessageBreak
        #4 using \string#6.\MessageBreak
        Because of this too high #4\MessageBreak
        you've got an overfull \string\vbox\space message%
      }%
    \fi%
    \fi%
  \endgroup%
}
\newcommand*{\@firstheadfootfield}{%
  \if@firsthead
    \typeout{Head of first page}%
    \move@topt\vskip\useplength{firstheadvpos}%
    \vb@t@z{%
      \rlap{\move@topl
        \ifdim\useplength{firstheadhpos}<\paperwidth
          \ifdim \useplength{firstheadhpos}>-\paperwidth
            \ifdim \useplength{firstheadhpos}<\z@
              \setlength\@tempskipa{\paperwidth}%
              \addtolengthplength{\@tempskipa}{firstheadhpos}%
              \addtolengthplength[-]{\@tempskipa}{firstheadwidth}%
            \else
              \setlength{\@tempskipa}{\useplength{firstheadhpos}}%
            \fi
          \else
            \setlength\@tempskipa{\oddsidemargin}%
            \addtolength\@tempskipa{1in}%
          \fi
        \else
          \setlength\@tempskipa{.5\paperwidth}%
          \addtolengthplength[-.5]{\@tempskipa}{firstheadwidth}%
        \fi
        \hskip\@tempskipa
        \vbox{\hsize\useplength{firstheadwidth}%
          \setlength{\@tempskipa}{\useplength{toaddrvpos}}%
          \addtolengthplength[-1]{\@tempskipa}{firstheadvpos}%
          \addtolength{\@tempskipa}{-\baselineskip}%
          \setlength{\textwidth}{\useplength{firstheadwidth}}%
          \setlength{\parfillskip}{\z@ \@plus 1fil}%
          \@savevbox{\@tempskipa}{\noindent\usekomavar{firsthead}%
            \vskip \z@ \@plus .00001fil}%
          {head of first page}{firstheadvpos}{\setkomavar}%
        }%
      }%
    }%
    \vskip-\useplength{firstheadvpos}\move@frompt
  \else
    \typeout{No head at first page}%
  \fi
  \move@topt
  \if@firstfoot
    \typeout{Foot of first page}%
    \vb@t@z{%
      \rlap{\move@topl
         \ifdim\useplength{firstfoothpos}<\paperwidth
          \ifdim \useplength{firstfoothpos}>-\paperwidth
            \ifdim \useplength{firstfoothpos}<\z@
              \setlength\@tempskipa{\paperwidth}%
              \addtolengthplength{\@tempskipa}{firstfoothpos}%
              \addtolengthplength[-]{\@tempskipa}{firstfootwidth}%
            \else
              \setlength{\@tempskipa}{\useplength{firstfoothpos}}%
            \fi
          \else
            \setlength\@tempskipa{\oddsidemargin}%
            \addtolength\@tempskipa{1in}%
          \fi
        \else
          \setlength\@tempskipa{.5\paperwidth}%
          \addtolengthplength[-.5]{\@tempskipa}{firstfootwidth}%
        \fi
        \hskip\@tempskipa
        \vbox{\hsize\useplength{firstfootwidth}%
          \vskip\useplength{firstfootvpos}%
          \setlength{\textwidth}{\useplength{firstfootwidth}}%
          \setlength{\parfillskip}{\z@ \@plus 1fil}%
          \vbox{\hsize\useplength{firstfootwidth}\noindent
            \usekomavar{firstfoot}}%
        }%
      }%
    }%
  \else
    \typeout{No foot at first page}%
  \fi
  \move@frompt%
  {%
    \setlength{\@tempdima}{1in}\addtolength{\@tempdima}{\topmargin}%
    \addtolength{\@tempdima}{\headheight}%
    \addtolength{\@tempdima}{\headsep}%
    \addtolength{\@tempdima}{\textheight}%
    \addtolength{\@tempdima}{\footskip}%
    \if@firstfoot
      \addtolengthplength[-1]{\@tempdima}{firstfootvpos}%
    \else
      \addtolength{\@tempdima}{-\paperheight}%
    \fi
    \ifdim\@tempdima>\z@\enlargethispage{-\@tempdima}%
    \else\if@enlargefp\enlargethispage{-\@tempdima}\fi\fi
  }%
}
\newcommand*{\@addrfield}{%
  \ifcase \@afieldmode\relax
    \typeout{Address: No}%
  \or
    \begingroup%
      \if@baddr
        \ifkomavarempty{backaddress}{%
          \let\@tempa\@empty\let\@tempb\@empty
        }{%
          \def\@tempa{backaddress}\def\@tempb{,\space}%
        }%
      \else
        \let\@tempa\@empty\let\@tempb\@empty
      \fi
      \ifcase \ltr@priority
        \ifkomavarempty{specialmail}{}{%
          \edef\@tempa{\@tempa\@tempb specialmail}\def\@tempb{,\space}%
        }%
      \or
        \edef\@tempa{\@tempa\@tempb B-Economy}\def\@tempb{,\space}%
      \or
        \edef\@tempa{\@tempa\@tempb A-Priority}\def\@tempb{,\space}%
      \fi
      \typeout{Address (\@tempa\@tempb addressee)}%
    \endgroup%
    \move@topt\vskip\useplength{toaddrvpos}%
    \vb@t@z{{\setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative
        \rlap{\move@topl
          \setlengthtoplength{\@tempskipa}{toaddrhpos}%
          \ifdim \@tempskipa<\z@
            \addtolength{\@tempskipa}{\paperwidth}%
            \addtolengthplength[-]{\@tempskipa}{toaddrwidth}%
          \fi
          \hskip\@tempskipa
          \@savevbox{\useplength{toaddrheight}}{\hsize\useplength{toaddrwidth}%
            \@savevbox[\vss]{\useplength{backaddrheight}}{%
              \hsize\useplength{toaddrwidth}%
              \if@baddr
                \ifkomavarempty{backaddress}{}{{%
                    \noindent%
                    \def\\{\usekomavar{backaddressseparator}\@ogobble}%
                    \backaddr@format{\scriptsize\usekomafont{backaddress}%
                      \usekomavar{backaddress}}}}%
              \fi
            }{backaddress}{backaddrheight}{\setkomavar}%
            \ifcase \ltr@priority
            \or
              \setkomavar{specialmail}{%
                {\usekomafont{priority}{%
                    {\usekomafont{prioritykey}{B}}%
                    -ECONOMY}}%
              }%
            \or
              \setkomavar{specialmail}{%
                {\usekomafont{priority}{%
                    {\usekomafont{prioritykey}{A}}%
                    -PRIORITY}}%
              }%
            \fi
            \ifkomavarempty{specialmail}{}{%
              \vbox{\hsize\useplength{toaddrwidth}%
                \noindent\hspace*{\useplength{specialmailindent}}%
                \specialmail@format{%
                  \usekomafont{specialmail}\usekomavar{specialmail}}%
                \hspace*{\useplength{specialmailrightindent}}}%
            }%
            \vfil%
            \noindent\hskip\useplength{toaddrindent}%
            \setlength{\@tempdima}{\useplength{toaddrwidth}}%
            \addtolengthplength[-2]{\@tempdima}{toaddrindent}%
            \vbox{\hsize\@tempdima\raggedright
              \usekomafont{addressee}{%
                \usekomafont{toname}{\usekomavar{toname}\\}%
                \usekomafont{toaddress}{\usekomavar{toaddress}}}}%
            \vfil\null\vskip-\baselineskip}%
          {address field}{toaddrheight}%
          {\begin{letter} or you\MessageBreak
            have to define a smaller special purpose using\MessageBreak
            \string\specialmail}%
        }}}%
    \vskip-\useplength{toaddrvpos}\move@frompt
  \else
    \begingroup%
      \if@baddr
        \let\@tempa\@empty\let\@tempb\@empty
        \ifcase \@afieldmode\relax\or\or
          \def\@tempa{PP-mode}\def\@tempb{,\space}%
        \or
          \def\@tempa{backgroundimage-mode}\def\@tempb{,\space}%
        \or
          \def\@tempa{image-mode}\def\@tempb{,\space}%
        \fi
        \ifkomavarempty{backaddress}{}{%
          \edef\@tempa{\@tempa\@tempb backaddress ignored}\def\@tempb{,\space}%
        }%
      \else
        \let\@tempa\@empty\let\@tempb\@empty
      \fi
      \ifcase \ltr@priority
        \ifkomavarempty{specialmail}{}{%
          \edef\@tempa{\@tempa\@tempb specialmail ignored}\def\@tempb{,\space}%
        }%
      \or
        \edef\@tempa{\@tempa\@tempb B-Economy}\def\@tempb{,\space}%
      \or
        \edef\@tempa{\@tempa\@tempb A-Priority}\def\@tempb{,\space}%
      \fi
      \typeout{Address (\@tempa\@tempb addressee)}%
    \endgroup%
    \move@topt\vskip\useplength{toaddrvpos}%
    \vb@t@z{{%
        \setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative
        \ifdim \useplength{toaddrindent}=\z@
          \@setplength{toaddrindent}{8mm}%
        \fi
        \ifdim \useplength{PPheadheight}=\z@
          \@setplength{PPheadheight}{20.74pt}%
        \fi
        \ifdim \useplength{PPheadwidth}=\z@
          \@setplength{PPheadwidth}{42mm}%
        \fi
        \ifdim \useplength{PPdatamatrixvskip}=\z@
          \@setplength{PPdatamatrixvskip}{9mm}%
        \fi
        \rlap{\move@topl
          \setlengthtoplength{\@tempskipa}{toaddrhpos}%
          \ifdim \@tempskipa<\z@
            \addtolength{\@tempskipa}{\paperwidth}%
            \addtolengthplength[-]{\@tempskipa}{toaddrwidth}%
          \fi
          \hskip\@tempskipa
          \@savevbox{\useplength{toaddrheight}}{\hsize\useplength{toaddrwidth}%
            \ifnum\@afieldmode=\tw@
              \vskip 2pt\relax
              \hskip \useplength{toaddrindent}\relax
              \fbox{%
                \vbox to \dimexpr \useplength{PPheadheight}-2\fboxsep\relax{%
                  \setlength{\parindent}{0pt}%
                  \hsize \dimexpr \useplength{PPheadwidth}-2\fboxsep\relax
                  \setbox\@tempboxa\hbox{%
                    {\fontsize{20.74pt}{20.74pt}\selectfont
                      \usekomafont{PPlogo}{P.P.}}\hskip 2mm%
                  }%
                  \dp\@tempboxa\z@
                  \setlength{\@tempdima}{\hsize}%
                  \addtolength{\@tempdima}{-\wd\@tempboxa}%
                  \hbox{\box\@tempboxa
                    \vbox to \dimexpr
                    \useplength{PPheadheight}-2\fboxsep\relax{%
                      \vss\hsize\@tempdima
                      \raggedright
                      \fontsize{8pt}{9pt}\selectfont\usekomafont{PPdata}%
                      \usekomavar*{fromzipcode}\usekomavar{zipcodeseparator}%
                      \usekomavar{fromzipcode}\unskip\strut\\
                      \usekomavar{place}\unskip\strut
                      \hfill
                    }%
                  }%
                  \vss
                }%
              }%
              \hskip 1mm
              \mbox{%
                \vbox to \useplength{PPheadheight}{%
                  \addtolengthplength[-]{\hsize}{PPheadwidth}%
                  \addtolength{\hsize}{-1mm}%
                  \addtolengthplength[-2]{\hsize}{toaddrindent}%
                  \setlength{\parindent}{0pt}%
                  \fontsize{8pt}{9pt}\selectfont\usekomafont{PPdata}%
                  \hfill\usekomavar{PPcode}
                  \vss
                  \ifcase \ltr@priority
                  \or
                    \usekomafont{priority}{%
                      {\usekomafont{prioritykey}{B}}%
                      -ECONOMY\hss\vskip-\dp\strutbox
                    }%
                  \or
                    \usekomafont{priority}{%
                      {\usekomafont{prioritykey}{A}}%
                      -PRIORITY\hss\vskip-\dp\strutbox
                    }%
                  \fi
                  \vss
                }%
              }%
              \vskip 1mm
              \vskip-\ht\strutbox
              \noindent\hskip\useplength{toaddrindent}%
              \hrulefill%
              \hskip\useplength{toaddrindent}%
              \vbox to\z@{\hsize\z@
                \vskip \useplength{PPdatamatrixvskip}\relax
                \llap{\usekomavar{PPdatamatrix}\hskip\useplength{toaddrindent}}%
                \vss
              }%
            \else
              \vskip 1mm
              \noindent\expandafter\hskip\useplength{toaddrindent}%
              \vbox to \useplength{PPheadheight}{%
                \addtolengthplength[-2]{\hsize}{toaddrindent}%
                \setlength{\parindent}{0pt}%
                \usekomavar{addresseeimage}%
                \vss
              }%
              \vskip 1mm
              \vskip\dp\strutbox
            \fi
            \ifnum \@afieldmode=4 \else
              \vfil%
              \noindent\hskip\useplength{toaddrindent}%
              \setlength{\@tempdima}{\useplength{toaddrwidth}}%
              \addtolengthplength[-2]{\@tempdima}{toaddrindent}%
              \vbox{\hsize\@tempdima
                \ifkomavarempty{PPdatamatrix}{}{%
                  \addtolength{\hsize}{-2mm}%
                  \settowidth\@tempdima{\usekomavar{PPdatamatrix}}%
                  \addtolength{\hsize}{-\@tempdima}%
                }%
                \raggedright
                \usekomafont{addressee}{%
                  \usekomafont{toname}{\usekomavar{toname}\\}%
                  \usekomafont{toaddress}{\usekomavar{toaddress}}}}%
            \fi
            \vss\null}%
          {address field}{toaddrheight}%
          {\string\begin{letter}}%
        }}}%
    \vskip-\useplength{toaddrvpos}\move@frompt
  \fi
}
\newcommand*{\specialmail@format}[1]{}
\let\specialmail@format\underline
\newcommand*{\@ogobble}[1][]{}
\newcommand*{\@locfield}{%
  \ifdim \useplength{locwidth}=\z@%
    \@setplength{locwidth}{\paperwidth}%
    \ifdim \useplength{toaddrhpos}>\z@
      \@addtoplength[-2]{locwidth}{\useplength{toaddrhpos}}%
    \else
      \@addtoplength[2]{locwidth}{\useplength{toaddrhpos}}%
    \fi
    \@addtoplength[-1]{locwidth}{\useplength{toaddrwidth}}%
    \if@bigloc%
      \@setplength[.66667]{locwidth}{\useplength{locwidth}}%
    \else%
      \@setplength[.5]{locwidth}{\useplength{locwidth}}%
    \fi%
  \fi%
  \ifcase\@alignfrom
  \or
    \if@logo
      \ifkomavarempty{location}{\setkomavar{location}{\null}}{}%
    \fi
  \or
  \or
    \ifkomavarempty{location}{\setkomavar{location}{\null}}{}%
  \or
    \ifkomavarempty{location}{\setkomavar{location}{\null}}{}%
  \fi
  \ifkomavarempty{location}{%
    \typeout{Location field: empty}%
    }{%
    \typeout{Location field: yes}%
    \ifdim \useplength{lochpos}=\z@%
      \@setplength{lochpos}{\useplength{toaddrhpos}}%
    \fi
    \ifdim \useplength{locvpos}=\z@%
      \@setplength{locvpos}{\useplength{toaddrvpos}}%
    \fi
    \ifdim \useplength{locheight}=\z@%
      \@setplength{locheight}{\useplength{toaddrheight}}%
    \fi
    \move@topt\vskip\useplength{locvpos}%
    \vb@t@z{\noindent\makebox[0pt][l]{%
        \move@topl
        \setlengthtoplength[-]{\@tempskipa}{lochpos}%
        \ifdim \@tempskipa<\z@
          \addtolength{\@tempskipa}{\paperwidth}%
        \else
          \addtolengthplength{\@tempskipa}{locwidth}%
        \fi
        \hskip\@tempskipa
        \makebox[0pt][r]{%
          \@savevbox{\useplength{locheight}}{%
            \noindent\hsize\useplength{locwidth}%
            \ifcase\@alignfrom
            \or
              \if@logo
                \ifkomavarempty{fromlogo}{\null}{%
                  {\raggedleft\noindent\usekomavar{fromlogo}\\
                    \vskip\parskip}\noindent}%
              \fi
            \or
            \or
              \if@logo
                \ifkomavarempty{fromlogo}{}{%
                  \raggedleft\usekomavar{fromlogo}\par}%
              \fi
              \raggedright
              {\usekomafont{fromname}\strut\ignorespaces
                \usekomavar{fromname}%
                {%
                  \ifnum\@rulefrom=1\\[-.5\baselineskip]%
                    \usekomafont{fromrule}{%
                      \setlength{\@tempdima}{\useplength{fromrulewidth}}%
                      \ifdim\@tempdima=\z@
                        \setlength{\@tempdima}{\useplength{locwidth}}%
                      \fi
                      \expandafter\rule\expandafter{\the\@tempdima}{%
                        \useplength{fromrulethickness}}%
                    }%
                  \fi
                }%
                \\
              }%
              {\usekomafont{fromaddress}\strut\ignorespaces
                \usekomavar{fromaddress}%
                \if@phone\\\usekomavar*{fromphone}\usekomavar{fromphone}\fi%
                \if@fax\\\usekomavar*{fromfax}\usekomavar{fromfax}\fi%
                \if@email\\\usekomavar*{fromemail}\usekomavar{fromemail}\fi%
                \if@www\\\usekomavar*{fromurl}\usekomavar{fromurl}\fi%
                \ifnum\@rulefrom=2\\[-.5\baselineskip]%
                  \usekomafont{fromrule}{%
                    \setlength{\@tempdima}{\useplength{fromrulewidth}}%
                    \ifdim\@tempdima=\z@
                      \setlength{\@tempdima}{\useplength{locwidth}}%
                    \fi
                    \expandafter\rule\expandafter{\the\@tempdima}{%
                      \useplength{fromrulethickness}}}%
                \fi
                \\
              }%
            \or
              \raggedleft
              \if@logo
                \ifkomavarempty{fromlogo}{}{\usekomavar{fromlogo}\par}%
              \fi
              {\usekomafont{fromname}\strut\ignorespaces
                \usekomavar{fromname}%
                {%
                  \ifnum\@rulefrom=1\\[-.5\baselineskip]%
                    \usekomafont{fromrule}{%
                      \setlength{\@tempdima}{\useplength{fromrulewidth}}%
                      \ifdim\@tempdima=\z@
                        \setlength{\@tempdima}{\useplength{locwidth}}%
                      \fi
                      \expandafter\rule\expandafter{\the\@tempdima}{%
                        \useplength{fromrulethickness}}%
                    }%
                  \fi
                }%
                \\
              }%
              {\usekomafont{fromaddress}\strut\ignorespaces
                \usekomavar{fromaddress}%
                \if@phone\\\usekomavar*{fromphone}\usekomavar{fromphone}\fi%
                \if@fax\\\usekomavar*{fromfax}\usekomavar{fromfax}\fi%
                \if@email\\\usekomavar*{fromemail}\usekomavar{fromemail}\fi%
                \if@www\\\usekomavar*{fromurl}\usekomavar{fromurl}\fi%
                \ifnum\@rulefrom=2\\[-.5\baselineskip]%
                  \usekomafont{fromrule}{%
                    \setlength{\@tempdima}{\useplength{fromrulewidth}}%
                    \ifdim\@tempdima=\z@
                      \setlength{\@tempdima}{\useplength{locwidth}}%
                    \fi
                    \expandafter\rule\expandafter{\the\@tempdima}{%
                      \useplength{fromrulethickness}}}%
                \fi
                \\
              }%
            \fi
            \usekomavar{location}%
            \vskip \z@ \@plus .00001fil}%
          {location field}{locheight}{\setkomavar}%
        }}%
    }%
    \vskip-\useplength{locvpos}\move@frompt
  }%
}
\newcommand*{\do@set@reffield}{}
\newcommand*{\@set@reffield}[1]{%
  \ifkomavarempty{#1}{}{%
    \settowidth{\@tempdima}{\strut\usekomafont{refvalue}\usekomavar{#1}}%
    \setbox0\hbox{\strut\usekomafont{refname}\usekomavar*{#1}}%
    \ifdim \@tempdima<\wd0\setlength{\@tempdima}{\wd0}\fi
    \if@tempswa\enskip\hfill\fi
    \parbox[t]{\@tempdima}{\noindent\raggedright
        \strut\box0\\\usekomafont{refvalue}\strut\usekomavar{#1}}%
    \@tempswatrue
  }%
}
\newcommand*{\@test@reffield}[1]{%
  \ifkomavarempty{#1}{}{%
    \@tempswatrue
  }%
}
\newcommand*{\@set@reffields}{}%
\newcommand*{\addtoreffields}[1]{%
  \l@addto@macro{\@set@reffields}{\do@set@reffield{#1}}%
}
\newcommand*{\removereffields}{%
  \renewcommand*{\@set@reffields}{}%
}
\newcommand*{\defaultreffields}{%
  \removereffields
  \addtoreffields{yourref}%
  \addtoreffields{yourmail}%
  \addtoreffields{myref}%
  \addtoreffields{customer}%
  \addtoreffields{invoice}%
}
\defaultreffields
\newcommand*{\@datefield}{{%
    \setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative
    \ifdim\useplength{refwidth}=\z@
      \if@refwide
        \@setplength{refwidth}{\paperwidth}%
        \ifdim \useplength{toaddrhpos}>\z@
          \@setplength{refhpos}{\useplength{toaddrhpos}}%
        \else
          \@setplength[-]{refhpos}{\useplength{toaddrhpos}}%
        \fi
        \@addtoplength[-2]{refwidth}{\useplength{refhpos}}%
      \else
        \@setplength{refwidth}{\textwidth}%
        \@setplength{refhpos}{\oddsidemargin}%
        \@addtoplength{refhpos}{1in}%
      \fi
    \else
      \ifdim\useplength{refhpos}=\z@
        \begingroup
          \setlength\@tempdima{\textwidth}%
          \addtolengthplength[-]{\@tempdima}{refwidth}%
          \setlength\@tempdimb{\oddsidemargin}%
          \addtolength\@tempdimb{1in}%
          \setlength{\@tempdimc}{\paperwidth}%
          \addtolength{\@tempdimc}{-\textwidth}%
          \divide\@tempdimb by 32768\relax
          \divide\@tempdimc by 32768\relax
          \ifdim\@tempdimc=\z@\else
            \multiply\@tempdima by\@tempdimb
            \divide\@tempdima by\@tempdimc
          \fi
          \edef\@tempa{\noexpand\endgroup
            \noexpand\@setplength{refhpos}{\the\@tempdima}}%
        \@tempa
    \fi\fi
    \@tempswafalse
    \move@topt\vskip\useplength{refvpos}%
    \@tempswafalse
    \let\do@set@reffield\@test@reffield
    \@set@reffields
    \ifcase \@datepos\else\@test@reffield{date}\fi
    \if@tempswa
      \@tempswafalse
      \rlap{\noindent\move@topl\hskip\useplength{refhpos}%
        \vbox{\hsize\useplength{refwidth}%
          \noindent
          \ifnum \@datepos=2
            \@set@reffields
            \if@tempswa
              \@tempswafalse
              \@set@reffield{date}%
            \fi
          \fi
          \let\do@set@reffield\@set@reffield
          \@set@reffields%
          \if@tempswa
            \ifnum \@datepos=1 \@set@reffield{date}\fi%
            \setbox0\hbox{\usekomafont{refname}\strutbox}%
            \ifdim\ht0>\ht\strutbox
              \ClassWarningNoLine{scrlttr}{%
                Font element `refname' should not be larger than
                \string\normalsize!}%
            \fi
            \setbox0\hbox{\usekomafont{refvalue}\strutbox}%
            \ifdim\ht0>\ht\strutbox
              \ClassWarningNoLine{scrlttr}{%
                Font element `refvalue' should not be larger than
                \string\normalsize!}%
            \fi
          \else
            \ifcase \@datepos\else
              \ifnum \@datepos=1 \enskip\hfill\fi
              \ifkomavarempty{place}{}{%
                \usekomavar{place}\usekomavar{placeseparator}}%
              \usekomavar{date}%
            \fi
          \fi
        }%
      }%
    \fi
    \vskip\useplength{refaftervskip}%
  }%
}
\newcommand*{\@maketitle}{%
  \ifkomavarempty{title}{%
    \typeout{Title: no}%
  }{%
    \typeout{Title: yes}%
    {\setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative
      \centering\LARGE\usekomafont{title}\usekomavar{title}\par}%
    \vskip\baselineskip%
  }%
}
\newcommand*{\@subjfield}{{%
    \setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative
    \ifkomavarempty{subject}{%
      \typeout{Subject: no}%
    }{%
      \ifx\raggedsubject\@empty
        \ifdim\useplength{subjectvpos}=\z@
          \if@subjafter%
            \typeout{Subject: after opening}%
            \let\raggedsubject\centering%
          \else
            \typeout{Subject: before opening}%
            \def\raggedsubject{\noindent\@hangfrom}%
          \fi
        \else
          \typeout{Subject: at absolute vertical position}%
          \def\raggedsubject{\noindent\@hangfrom}%
        \fi
      \fi
      \ifdim\useplength{subjectvpos}=\z@
        \vskip\useplength{subjectbeforevskip}%
        \begingroup
      \else
        \move@topt\vskip\useplength{subjectvpos}%
        \expandafter\vb@t@z\expandafter{%
      \fi
      \usekomafont{subject}%
      \raggedsubject{\if@subj \subject@format{\strut\ignorespaces
          \usekomavar*{subject}}\fi}%
      \subject@format{\strut\ignorespaces\usekomavar{subject}}\par
      \ifdim\useplength{subjectvpos}=\z@
        \endgroup
        \vskip\useplength{subjectaftervskip}%
      \else
        }%
        \vskip-\useplength{subjectvpos}\move@frompt
      \fi
    }%
  }%
}
\@newplength{subjectvpos}
\@setplength{subjectvpos}{0pt}
\@newplength{subjectaftervskip}
\@setplength{subjectaftervskip}{2\baselineskip}
\@newplength{subjectbeforevskip}
\@setplength{subjectbeforevskip}{0pt}
\newcommand*{\@nexthead}{%
  \ClassWarning{scrlttr2}{%
    Deprecated usage of \string\@nexthead.\MessageBreak
    \string\usekomavar{nexthead} should be used\MessageBreak
    instead of \string\@nexthead
  }%
  \usekomavar{nexthead}%
}
\newkomavar{nexthead}
\setkomavar{nexthead}{%
  \rlap{\parbox[c]{\textwidth}{\raggedright\strut
      \ifnum\@pageat=0\pagemark\else\leftmark\fi\strut}}%
  \parbox[c]{\textwidth}{%
    \centering\strut
    \ifcase\@pageat
      \rightmark
    \or
      \pagemark
    \or
      \rightmark
    \fi\strut}%
  \llap{\parbox[c]{\textwidth}{\raggedleft\strut
      \ifcase\@pageat
        \leftmark
      \or
        \rightmark
      \or
        \pagemark
      \else
        \rightmark
      \fi\strut}}%
}%
\newcommand{\nexthead}{%
  \ClassWarning{scrlttr2}{%
    Deprecated usage of \string\nexthead.\MessageBreak
    You should use \string\setkomavar{nexthead}\MessageBreak
    instead of \string\nexthead
  }
  \setkomavar{nexthead}%
}
\newcommand*{\@nextfoot}{%
  \ClassWarning{scrlttr2}{%
    Deprecated usage of \string\@nextfoot.\MessageBreak
    \string\usekomavar{nextfoot} should be used\MessageBreak
    instead of \string\@nextfoot
  }%
  \usekomavar{nextfoot}%
}
\newkomavar{nextfoot}
\setkomavar{nextfoot}{%
  \ifnum\@pageat>2
    \parbox[c]{\textwidth}{%
      \ifcase\@pageat\or\or\or\raggedright\or\centering\or\raggedleft\fi
      \strut\pagemark%
      }%
  \fi
}
\newcommand{\nextfoot}{%
  \ClassWarning{scrlttr2}{%
    Deprecated usage of \string\nextfoot.\MessageBreak
    You should use \string\setkomavar{nextfoot}\MessageBreak
    instead of \string\nextfoot
  }
  \setkomavar{nextfoot}%
}
\newenvironment{letter}[2][]{%
  \newpage
  \if@twoside\ifodd\c@page\else\thispagestyle{empty}\null\newpage\fi\fi
  \setcounter{page}{\@ne}%
  \setcounter{footnote}{0}%
  \interlinepenalty=200\@processto{#2}%
  \KOMAoptions{#1}%
  \@beginletterhook
}{%
  \stopletter\@@par\pagebreak\@@par%
}
\newcommand*{\stopletter}{}
\newcommand{\@processto}[1]{%
  \ifx\relax#1\relax\else
    \expandafter\@xproc#1\\\@nil\ifkomavarempty{toaddress}{}{%
    \expandafter\@xproc#1\@nil}%
  \fi
}
\newcommand*{\@xproc}{}
\long\def\@xproc#1\\#2\@nil{%
  \setkomavar{toname}{#1}\setkomavar{toaddress}{#2}}
\g@addto@macro\flushbottom{%
  \g@addto@macro\stopletter{\vskip \z@\@plus.0001fil\relax}%
}
\newcommand{\AtBeginLetter}{\g@addto@macro\@beginletterhook}
\newcommand{\@beginletterhook}{}
\newcommand{\AtEndLetter}{\g@addto@macro\stopletter}
\newcommand*{\stopbreaks}{\interlinepenalty \@M
 \def\par{\@@par\nobreak}\let\\=\@nobreakcr
 \let\vspace\@nobreakvspace}
\newcommand*{\@nobreakvspace}{%
  \@ifstar{\@nobreakvspacex}{\@nobreakvspacex}}
\newcommand*{\@nobreakvspacex}[1]{\ifvmode\nobreak\vskip #1\relax\else
 \@bsphack\vadjust{\nobreak\vskip #1}\@esphack\fi}
\newcommand*{\@nobreakcr}{%
  \vadjust{\penalty\@M}\@ifstar{\@xnewline}{\@xnewline}}
\newcommand*{\startbreaks}{\let\\=\@normalcr
 \interlinepenalty 200\def\par{\@@par\penalty 200}}
\newcommand{\opening}[1]{%
  \@PapersizeWarning
  \@gen@firsthead
  \@mkboth{\scr@fromname@var}{\scr@subject@var}%
  \thispagestyle{empty}\noindent
  \@foldmarks\@firstheadfootfield\@addrfield\@locfield
  \ifdim\useplength{subjectvpos}=\z@\else\@subjfield\fi
  \@datefield
  \@maketitle
  \ifdim\useplength{subjectvpos}=\z@\if@subjafter\else\@subjfield\fi\fi
  {\setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative#1\par}%
  {\setlength{\@tempdima}{\baselineskip}%
    \addtolength{\@tempdima}{-\parskip}%
    \ifdim \@tempdima>\z@\vskip\@tempdima\fi}%
  \ifdim\useplength{subjectvpos}=\z@\if@subjafter\@subjfield\fi\fi
  \@afterindentfalse\@afterheading
}
\newcommand*{\@xtrimtempa}{%
  \@ifnextchar [{\@@xtrimtempa}{\@@xtrimtempa[]}}
\newcommand*{\@@xtrimtempa}{}
\def\@@xtrimtempa[#1]#2\@nil{\def\@tempa{#2}}
\newcommand*{\@tempdimaismaxwidthof}{}
\def\@tempdimaismaxwidthof#1\\#2\@nil{%
  \settowidth{\@tempdimb}{\strut\ignorespaces#1}%
  \ifdim\@tempdima<\@tempdimb\setlength{\@tempdima}{\@tempdimb}\fi
  \def\@tempa{#2}\ifx\@tempa\@empty
    \let\@tempb\relax
  \else
    \expandafter\@xtrimtempa\@tempa\@nil
    \def\@tempb{\expandafter\@tempdimaismaxwidthof\@tempa\@nil}%
  \fi
  \@tempb
}
\newcommand*{\closing}[1]{{%
    \setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative\nobreak\par%
    \nobreak\vskip\baselineskip%
    \stopbreaks\noindent%
    \setlength{\@tempdima}{0pt}%
    \expandafter\@tempdimaismaxwidthof\scr@signature@var\\\@nil
    \expandafter\@tempdimaismaxwidthof\strut\ignorespaces#1\\\@nil
    \setlength{\@tempdimb}{\hsize}%
    \addtolength{\@tempdimb}{-\useplength{sigindent}}%
    \ifdim\@tempdima>\@tempdimb\setlength{\@tempdima}{\@tempdimb}\fi%
    \hspace{\useplength{sigindent}}%
    \parbox{\@tempdima}{\raggedsignature\strut\ignorespaces%
      #1\strut\\[\useplength{sigbeforevskip}]
      \strut\usekomavar{signature}\strut}}\par
  \nobreak\vskip\baselineskip%
}
\newcommand\ps{\par%
  \ifdim\parskip=\z@%
    \vskip\baselineskip%
  \fi\startbreaks\noindent\ignorespaces%
}
\newcommand*{\cc}[1]{\par%
  \ifdim\parskip=\z@%
    \vskip\baselineskip%
  \fi\noindent%
  \begingroup
    \parbox[t]{\textwidth}{%
      \ifkomavarempty{ccseparator}{}{%
        \@hangfrom{%
          \strut\usekomavar*{ccseparator}\usekomavar{ccseparator}}%
        }%
      \ignorespaces #1\strut}%
    \setlength{\parfillskip}{\z@ \@plus 1fil}\par
  \endgroup
}
\newcommand*{\encl}[1]{\par%
  \ifdim\parskip=\z@%
    \vskip\baselineskip%
  \fi\noindent%
  \begingroup
    \parbox[t]{\textwidth}{%
      \ifkomavarempty*{enclseparator}{}{%
        \@hangfrom{%
          \strut\usekomavar*{enclseparator}\usekomavar{enclseparator}}%
        }%
      \ignorespaces #1\strut}%
    \setlength{\parfillskip}{\z@ \@plus 1fil}\par
  \endgroup
}
\newkomavar{signature}
\setkomavar{signature}{\usekomavar{fromname}}
\newkomavar{place}
\newkomavar{location}
\newkomavar{backaddress}
\setkomavar{backaddress}{%
  \ifkomavarempty{fromname}{}{%
    \strut\ignorespaces\usekomavar{fromname}%
    \ifkomavarempty{fromaddress}{}{\\}}%
  \ifkomavarempty{fromaddress}{}{%
    \strut\ignorespaces\usekomavar{fromaddress}}%
  }
\newkomavar{specialmail}
\newkomavar{title}
\newkomavar{fromlogo}
\newkomavar{fromzipcode}
\newkomavar{PPcode}
\newkomavar{PPdatamatrix}
\newkomavar{addresseeimage}
\newkomavar[\usekomavar{place}]{placeseparator}
\setkomavar{placeseparator}{,~}
\newkomavar[\subjectname]{subjectseparator}
\setkomavar{subjectseparator}{: }
\newkomavar[\ccname]{ccseparator}
\setkomavar{ccseparator}{: }
\newkomavar[\enclname]{enclseparator}
\setkomavar{enclseparator}{: }
\newkomavar{backaddressseparator}
\setkomavar{backaddressseparator}{,~}
\newkomavar[\phonename]{phoneseparator}
\setkomavar{phoneseparator}{:~}
\newkomavar[\faxname]{faxseparator}
\setkomavar{faxseparator}{:~}
\newkomavar[\emailname]{emailseparator}
\setkomavar{emailseparator}{:~}
\newkomavar[\wwwname]{urlseparator}
\setkomavar{urlseparator}{:~}
\newkomavar{zipcodeseparator}
\setkomavar{zipcodeseparator}{\,--\,}
\newkomavar[\headfromname]{fromname}
\newkomavar[\usekomavar{fromname}]{fromaddress}
\newkomavar[\headtoname]{toname}
\newkomavar[\usekomavar{toname}]{toaddress}
\newkomavar[\usekomavar*{phoneseparator}%
  \usekomavar{phoneseparator}]{fromphone}
\newkomavar[\usekomavar*{faxseparator}%
  \usekomavar{faxseparator}]{fromfax}
\newkomavar[\usekomavar*{emailseparator}%
  \usekomavar{emailseparator}]{fromemail}
\newkomavar[\usekomavar*{urlseparator}%
  \usekomavar{urlseparator}]{fromurl}
\newkomavar[\bankname]{frombank}
\newkomavar[\yourrefname]{yourref}
\newkomavar[\yourmailname]{yourmail}
\newkomavar[\myrefname]{myref}
\newkomavar[\customername]{customer}
\newkomavar[\invoicename]{invoice}
\newkomavar[\usekomavar*{subjectseparator}%
  \usekomavar{subjectseparator}]{subject}
\newkomavar[\datename]{date}
\setkomavar{date}{\@date}
%%% From File: scrkcile.dtx
\newcommand*{\adrentry}[7]{%
  \addrentry{#1}{#2}{#3}{#4}{#5}{#6}{#7}{}}
\newcommand*{\adrchar}{\addrchar}
\newcommand*{\addrentry}[9]{\def\@tempa{#1}\ifx \@tempa\@empty \else
 \def\@tempa{#2}\ifx \@tempa\@empty
  \expandafter\def\csname #9\endcsname{#1\\#3}%
 \else
  \expandafter\def\csname #9\endcsname{#2 #1\\#3}%
 \fi \fi}
\newcommand*{\addrchar}[1]{}
%%% From File: scrlogo.dtx
\@ifundefined{KOMAScript}{%
  \DeclareRobustCommand{\KOMAScript}{\textsf{K\kern.05em O\kern.05em%
      M\kern.05em A\kern.1em-\kern.1em Script}}}{}
\endinput
%%
%% End of file `scrlttr2.cls'.
