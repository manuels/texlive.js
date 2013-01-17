%% 
%% \iffalse ^^A we skip the debug setting
\IfFileExists{\string~/bin/gen_and_xela}{\errorcontextlines=1000 }{}
%% \fi
%% ^^A $Id: TheUltimateMaster.gmd,v 0.298 2011/02/02 18:35:58 natror Exp natror $
%% This is file “gmdocc.cls” generated with the DocStrip utility.
%% 
%%
%% The original source files were:
%%
%% gmdoc/gmdoc.gmd  (with options: `docc')
%%
%% 
%% Copyright ©  
%% by Grzegorz ‘Natror’ Murzynowski
%% natror (at) gmail (dot) com
%% 
%% This program is subject to the LaTeX Project Public License.
%% See http://www.ctan.org/tex-archive/help/Catalogue/licenses.lppl.html
%% for the details of that license.
%%
%% LPPL status: "author-maintained".
%%
%% 
%% 
%% For the documentation please refer to the file(s)
%% gmdoc.{gmd,pdf}.
%% 
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gmdocc}
    [2010/08/15 v0.993 a class for gmdoc driver files (GM)]


%%
%%
%% This file is a~part of \pk{gmdoc} bundle and provides a~document
%% class for the driver files documenting \LaTeXpar\ packages \&a.\
%% with my \pk{gmdoc.sty} package. It's not necessary, of course: most
%% probably you may use another document class you like.
%%
%% By default this class loads \pk{mwart} class with a4paper (default)
%% option and \pk{lmodern} package with T1 fontencoding. It loads also
%% my \pk{gmdoc} documenting package which loads some auxiliary
%% packages of mine and the standard ones.
%%
%% If the \pk{mwart} class is not found, the standard \pk{article}
%% class is loaded instead. Similarly, if the \pk{lmodern} is not
%% found, the standard Computer Modern font family is used in the
%% default font encoding.
%%

\PassOptionsToPackage{rgb}{xcolor}

\RequirePackage{xkeyval}

\newcommand*\gm@DOX{\DeclareOptionX[gmcc]<>}
\newcommand*\gm@EOX{\ExecuteOptionsX[gmcc]<>}

\newif\ifgmcc@mwcls

\gm@DOX{class}{% the default will be Marcin Woli\nacute ski class
  % (\pk{mwcls}) analogous to \pk{article}, see line \ref{EOXmwart}.
  \def\gmcc@CLASS{#1}%
  \@for\gmcc@resa:=mwart,mwrep,mwbk\do {%
    \ifx\gmcc@CLASS\gmcc@resa\gmcc@mwclstrue\fi}%
}

\gm@DOX{mwart}{\gmcc@class{mwart}}% The \pk{mwart} class may also

\gm@DOX{mwrep}{\gmcc@class{mwrep}}% If you need

\gm@DOX{mwbk}{\gmcc@class{mwbk}}% and this MW class

\gm@DOX{article}{\gmcc@class{article}}% you can also

\gm@DOX{outeroff}{\let\outer\relax}% This option allows

\newif\if@debug

\gm@DOX{debug}{\@debugtrue}% This option causes \pk{trace} to

\gm@DOX{noindex}{%
  \PassOptionsToPackage{noindex}{gmdoc}}% This

\newif\if@gmccnochanges

\gm@DOX{nochanges}{\@gmccnochangestrue}% This option turns the


\newif\ifgmcc@oldfonts

\gm@DOX{sysfonts}{\gmcc@oldfontsfalse}

\gm@DOX{mptt}[17]{\relax}% now a~no-op, left only for backwards

\def\gmcc@tout#1{\typeout{^^J@@@@ gmdocc class: #1^^J}}

\def\gmcc@setfont#1{%
  \gmcc@oldfontsfalse% note that if we are not in \XeTeX, this switch
  % will be turned true in line \ref{ofstrue}
  \AtEndOfClass{%
    \ifdefined\zf@init\afterfi{%
      \gmcc@tout{Main font set to #1}%
      \def\gmcc@dff{Numbers={OldStyle, Proportional}}
      \@xa\setmainfont\@xa[\gmcc@dff, Mapping=tex-text]{#1}%
      % ^^A      \setsansfont[Mapping=tex-text]{Latin Modern Sans}%
      % ^^A      \gmcc@tout{Sans serif font set to Latin Modern Sans}%
      % ^^A      \setmonofont{Latin Modern Mono}%
      % \chgs{2008/12/01 v0.82 I~commented out setting of Latin Modern
      %   fonts for sans serif and monospaced: \XeTeX\discret/\pk{fontspec}
      %   does that by default.}
      % ^^A      \def\sl{\it} \def{\textsl}\textit% we cover original \incs{sl}
      % ^^A      % and \incs{textsl} with \incs{def} to allow consistent font
      % ^^A      % change later.
      \@xa\defaultfontfeatures\@xa{\gmcc@dff, Scale=MatchLowercase}%\
      % when put before \incs{setmainfont},
      \gmath
      \def\LineNumFont{% \chgs{2008/11/30 v0.82 added}
        \normalfont\scriptsize\addfontfeature{Numbers=Monospaced}}%
    }%
    \else\afterfi{\gmcc@tout{I~can set main font to #1 only in
        XeTeX/fontspec}}%
    \fi
  }}

\gm@DOX{minion}{\gmcc@setfont{Minion Pro}}
\gm@DOX{pagella}{\gmcc@setfont{TeX Gyre Pagella}
  % ^^A  \def\gmcc@PAGELLA{1}% caused an error
}
\gm@DOX{cronos}{% \chgs{2008/12/01 v0.82 added, for Iwona sans font}
  \AtEndOfClass{\setsansfont[Mapping=tex-text]{Cronos Pro}}}
\gm@DOX{trebuchet}{% \chgs{2008/12/03 v0.82 added, for Trebuchet
  % \ac{MS} sans font}
  \AtEndOfClass{\setsansfont[Mapping=tex-text]{Trebuchet MS}}}
\gm@DOX{myriad}{% \chgs{2008/12/03 v0.82 added, for Myriad Web Pro
                % sans font}
  \AtEndOfClass{\setsansfont[Mapping=text-text]{Myriad Web Pro}}}
\gm@DOX{lsu}{% \chgs{2008/12/03 v0.82 added, for Lucida Sans Unicode
  % sans font}
  \AtEndOfClass{\setsansfont[Mapping=tex-text]{Lucida Sans Unicode}}}

\gm@DOX{cursor}{% \chgs{2008/12/01 v0.82 added, for \TeX\ Gyre Cursor
  % mono font, which I~embolden a~little and shrink
  % horizontally a~little}
  % \chgs{2008/12/12 v0.82 subtly distinguished weights of
  %   the \TeX\ Gyre Cyursor typewriter font in the code
  %   and in verbatims in the commentary}
  \AtEndOfClass{%
    \setmonofont[FakeBold=2.5, BoldFeatures={FakeBold=0},
    FakeStretch=0.87, Ligatures=NoCommon
    ]{TeX Gyre Cursor}%
    \def\marginpartt{\tt\addfontfeature{FakeBold=2,
        FakeStretch=0.609}%
      \color{black}}% to provide proper color when marginpar occurs
    % between lines that break a~coloured text.
    \def\narrativett{\ttfamily\addfontfeature{FakeBold=1}}%
    \let\UrlFont\narrativett
  }% of |\AtEndOfClass|.
}% of the |cursor| option.

\gm@DOX{fontspec}{\PassOptionsToPackage{#1}{fontspec}}

\gm@EOX{class=mwart}% \label{EOXmwart}We set the default basic class to


\newif\if@gmcc@tikz@
\gm@DOX{tikz}{\@gmcc@tikz@true}

\PassOptionsToPackage{countalllines}{gmdoc}% \chgs[countalllines]{2008/11/30

\DeclareOptionX*{\PassOptionsToPackage{\CurrentOption}{gmdoc}}

\ProcessOptionsX[gmcc]<>

\long\def\@gobble#1{}
\long\def\@firstofone#1{#1}

\if@gmcc@tikz@\expandafter\@firstofone\else\expandafter\@gobble\fi
{\RequirePackage{tikz}}

\XKV@ifundefined{ifSecondClass}{%
  \newif\ifSecondClass}{}

\ifSecondClass\else
\ifgmcc@mwcls
  \IfFileExists{\gmcc@CLASS.cls}{}{\gmcc@mwclsfalse}% As
  % announced, we do the ontological test to any \pk{mwcls}.
\fi
\ifgmcc@mwcls
  \LoadClass[fleqn, oneside, noindentfirst, 11pt, withmarginpar,
  sfheadings]{\gmcc@CLASS}%
\else
  \LoadClass[fleqn, 11pt]{article}% Otherwise the standard \pk{article} is
  % loaded.
\fi
\fi

\RequirePackage[mw=on]{gmutils}[2008/10/08]% we load it early to provide

\ifgmcc@mwcls\afterfi\ParanoidPostsec\fi

\@ifXeTeX{}{\gmcc@oldfontstrue}

\AtBeginDocument{\mathindent=\CodeIndent}

\ifgmcc@oldfonts
  \IfFileExists{lmodern.sty}{% We also examine the ontological status of
    % this package
    \RequirePackage{lmodern}% and if it shows to be satisfactory (the
    % package shows \emph{to be}), we load it and set the proper
    % font encoding.
    \RequirePackage[T1]{fontenc}%
  }{}%
  \def\agrave  {\`a}%
  \def\cacute  {\'c}%
  \def\eacute  {\'e}%
  \def\idiaeres{\"\i}%
  \def\nacute  {\'n}%
  \def\ocircum {\^o}%
  \def\oumlaut {\"o}%
  \def\uumlaut {\"u}%
\else% this case happens only with \XeTeX.
  \let\do\relaxen
  \do\Finv\do\Game\do\beth\do\gimel\do\daleth% these five caused the
  % `already defined' error.
  \let\@zf@euenctrue\zf@euencfalse
   \XeTeXthree%
  \def\agrave  {\char"00E0 }%
  \def\cacute  {\char"0107 }% Note the space to be sure the number
                            % ends here.
  \def\eacute  {\char"00E9 }%
  \def\idiaeres{\char"00EF }%
  \def\nacute  {\char"0144 }%
  \def\oumlaut {\char"00F6 }%
  \def\uumlaut {\char"00FC }%
  \def\ocircum {\char"00F4 }%
  \AtBeginDocument{%
    \def\ae{\char"00E6 }%
    \def\l {\char"0142 }%
    \def\oe{\char"0153 }%
  }%
\fi

\RequirePackage{geometry}
\def\gmdoccMargins@params{{top=77pt, height=687pt, % =53 lines but the
    % |lines| option seems not to work 2007/11/15 with \TeX\ Live 2007
    % and \XeTeX 0.996-patch1
    left=4cm, right=2.2cm}}
\def\gmdoccMargins{%
  \@xa  \newgeometry\gmdoccMargins@params}

\@xa\geometry\gmdoccMargins@params

\if@debug%  For debugging we load also the \pk{trace} package that was
  \RequirePackage{trace}%
  \errorcontextlines=100 % And we set an error info parameter.
\fi

\newcommand*\ifdtraceon{\if@debug\afterfi\traceon\fi}
\newcommand*\ifdtraceoff{\if@debug\traceoff\fi}

\RequirePackage{gmdoc}

\ifgmcc@oldfonts
  \@ifpackageloaded{lmodern}{% The Latin Modern font family provides
    % a~light condensed typewriter font that seems to be the most
    % suitable for the marginpar CS marking.
    \def\marginpartt{\normalfont\fontseries{lc}\ttfamily}}{}%
\else
  \def\marginpartt{\fontspec{LMTypewriter10 LightCondensed}}%
\fi


\raggedbottom

\setcounter{secnumdepth}{0}% We wish only the parts and chapters to be

\renewcommand*\thesection{\arabic{section}}% isn't it redundant at the

\@ifnotmw{}
{% if MW class
  \@ifclassloaded{mwart}
  {% We set the indentation of Contents:
    \SetTOCIndents{{}{\quad}{\quad}{\quad}{\quad}{\quad}{\quad}}%
  }
  {% for \pk{mwart} …\ilrr
    \SetTOCIndents{{}{\bf9.\enspace}{\quad}{\quad}{\quad}{\quad}{\quad}}%
  }% and for the two other \pk{mwcls}s. \ilrr
  \pagestyle{outer}}% We set the page numbers to be printed in the

\def\titlesetup{\bfseries\sffamily}% We set the title(s) to be

\if@gmccnochanges\let\RecordChanges\relax\fi% If the |nochanges|

\RecordChanges% We turn the writing the |\changes| out to the

\RequirePackage{amsfonts}
\RequirePackage[intlimits]{amsmath}
\RequirePackage{amssymb}

\dekclubs*% We declare the club sign \verb+|+ to be a~shorthand for
\edverbs% to redefine |\[| so that it puts a~shortverb in a~|\hbox|.
\smartunder% and we declare the |_| char to behave as usual in the

\exhyphenpenalty\hyphenpenalty% 'cause \pk{mwcls} set it |=10000| due

\def\EOFMark{\rightline{\ensuremath{\square}}}

\DoNotIndex{\@nx \@xa %^^A\count \dimen \box \setbox \copy
}

\provide\ac{\acro}

\def\+{\-\penalty\@M\hskip\z@} % a~discretionary hyphen that allows

\Xedekfracc

\let\mch\metachar

\ATfootnotes
\AtBegInput{\ATfootnotes}

\UrlFix

\GMverbatimspecials

\def\texcode@hook{\makestarlow}

\let\lv\leavevmode
\CommandLet\ac\acro

\def\OK{\acro{OK}\spifletter}

\pdef\oczko{;-)\spifletter}


\endinput
%%
%% End of file `gmdocc.cls'.
