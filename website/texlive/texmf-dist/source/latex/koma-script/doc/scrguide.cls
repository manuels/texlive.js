% ======================================================================
% scrguide.cls
% Copyright (c) Markus Kohm, 2005-2012
%
% This file is part of the LaTeX2e KOMA-Script bundle.
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, version 1.3c of the license.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX 
% version 2005/12/01 or later and of this work.
%
% This work has the LPPL maintenance status "author-maintained".
%
% The Current Maintainer and author of this work is Markus Kohm.
%
% This work consists of all files listed in manifest.txt.
% ----------------------------------------------------------------------
% scrguide.cls
% Copyright (c) Markus Kohm, 2005-2012
%
% Dieses Werk darf nach den Bedingungen der LaTeX Project Public Lizenz,
% Version 1.3c, verteilt und/oder veraendert werden.
% Die neuste Version dieser Lizenz ist
%   http://www.latex-project.org/lppl.txt
% und Version 1.3c ist Teil aller Verteilungen von LaTeX
% Version 2005/12/01 oder spaeter und dieses Werks.
%
% Dieses Werk hat den LPPL-Verwaltungs-Status "author-maintained"
% (allein durch den Autor verwaltet).
%
% Der Aktuelle Verwalter und Autor dieses Werkes ist Markus Kohm.
% 
% Dieses Werk besteht aus den in manifest.txt aufgefuehrten Dateien.
% ======================================================================
%
% \section{Identification}
%
%    \begin{macrocode}
\ProvidesClass{scrguide}[2011/10/18 v1.6 internal KOMA-Script guide class]
%    \end{macrocode}
%
%
% \section{Options on my own}
%
% This class also has options.
%
% \begin{option}{pagereftolabel}
%   |\autopageref| should reference the label not the page.
% \begin{option}{pagereftopage}
%   |\autopageref| should reference the page not the label.
% \begin{macro}{\if@pagereftolabel}
%    \begin{macrocode}
\newif\if@pagereftolabel\@pagereftolabeltrue
\DeclareOption{pagereftolabel}{\@pagereftolabeltrue}
\DeclareOption{pagereftopage}{\@pagereftolabelfalse}
%    \end{macrocode}
% \end{macro}
% \end{option}
% \end{option}
%
% \begin{option}{moreindexnotes}
%   Show more notes at the index.
% \begin{option}{lessindexnotes}
%   Show less notes at the index.
% \begin{macro}{\if@moreindexnotes}
%    \begin{macrocode}
\newif\if@moreindexnotes\@moreindexnotesfalse
\DeclareOption{moreindexnotes}{\@moreindexnotestrue}
\DeclareOption{lessindexnotes}{\@moreindexnotesfalse}
%    \end{macrocode}
% \end{macro}
% \end{option}
% \end{option}
%
% Note: You have to pass options to class \textsf{scrguide}, because only
% these options will be processed by |\LoadClassWithOptions| below.
%    \begin{macrocode}
\ExecuteOptions{pagereftolabel,lessindexnotes}
\PassOptionsToClass{%
  bibliography=totoc,
  index=totoc,
  captions=tableabove,
  headings=small,
  headings=optiontoheadandtoc,
  version=last,
}{scrguide}
\ProcessOptions\relax
%    \end{macrocode}
%
%
% \section{Load the Base Class and Packages}
%
% NOTE: I use \texttt{latin1} instead of the prefered \texttt{utf8} because of
%       problems of package \textsf{listings}.
%    \begin{macrocode}
\LoadClassWithOptions{scrbook}
\RequirePackage[latin1]{inputenc}
\RequirePackage[TS1,T1]{fontenc}
\def\languages{ngerman,english,}
\g@addto@macro\languages{,\languagename}
\edef\uselanguage{\languagename}
\edef\languages{\languages}
\expandafter\RequirePackage\expandafter[\languages]{babel}%
\AtBeginDocument{%
  \expandafter\selectlanguage\expandafter{\uselanguage}%
  \typeout{Current language is `\languagename`.}}%
\RequirePackage[fixlanguage]{babelbib}
\expandafter\selectbiblanguage\expandafter{\uselanguage}
\RequirePackage{afterpage}
\RequirePackage{makeidx}
\RequirePackage{scrdate}
\RequirePackage{scrtime}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{amsmath}
\RequirePackage{listings}
\RequirePackage{multicol}
\RequirePackage{marginnote}
\RequirePackage{xcolor,tocstyle}% hyperref needs xcolor with tocstyle
\RequirePackage[\uselanguage]{hyperref}
\RequirePackage[open,openlevel=0]{bookmark}% improved pdf bookmarks
\RequirePackage{scrhack}
\RequirePackage{mparhack}
%    \end{macrocode}
%
%
% \section{Free or Non-Free Version}
%
%    \begin{macrocode}
\newif\ifshortversion\shortversionfalse
\AtEndOfClass{%
  \InputIfFileExists{scrnonfree.tex}{}{%
    \typeout{^^J
      ----------------------------------------------------------------------^^J
      FREE VERSION OF THE KOMA-SCRIPT GUIDE.^^J
      NOTE THAT THIS VERSION MAY BE FULL OF UGLY PARAGRAPH AND PAGE BREAKS.^^J
      THIS IS BECAUSE THIS VERSION OF THE KOMA-SCRIPT GUIDE IS UNDER^^J
      CONSTRUCTION FOREVER.^^J
      ----------------------------------------------------------------------^^J
      ^^J%
    }%
    \newcommand*{\iffree}{\@firstoftwo}%
    \newcommand*{\important}[2][]{}%
    \newcommand*{\textnote}[2][]{}%
    \shortversiontrue
    \newcommand*{\LoadNonFree}[2]{\par\GuideLoadNonFree\par}%
    \AtBeginDocument{\InputIfFileExists{linkalias.tex}{}{}}%
    \usepackage{lmodern}%
    \@twosidefalse\@openrightfalse\@mparswitchfalse
    \RequirePackage{geometry}%
    \geometry{papersize={180mm,210mm},%
      includehead,includemp,reversemp,marginparwidth=4em,%
      vmargin={1.5mm,3mm},hmargin=1.75mm}%
    \RequirePackage{xcolor}%
    \RequirePackage{scrpage2}%
    \clearscrheadfoot
    \ohead{\smash{%
        \rule[-\dp\strutbox]{0pt}{\headheight}\headmark\hspace{2mm}}%
    }%
    \ihead[{\smash{\colorbox{yellow!50}{%
        \makebox[\dimexpr\linewidth-2\fboxsep\relax][l]{%
            \rule[-\dp\strutbox]{0pt}{\headheight}%
            \makebox[2em][r]\pagemark}}}}]%
      {\smash{\colorbox{yellow!50}{%
          \makebox[\dimexpr\linewidth-2\fboxsep\relax][l]{%
            \rule[-\dp\strutbox]{0pt}{\headheight}%
            \makebox[2em][r]\pagemark}}}}%
    \renewcommand*{\headfont}{\normalfont\sffamily}%
    \setkomafont{pagenumber}{}%
    \renewcommand*{\chaptermark}[1]{%
      \markboth\chaptermarkformat\chaptermarkformat}%
    \renewcommand*{\chaptermarkformat}{\chapapp~\thechapter\autodot}%
    \renewcommand*{\chapterformat}{}%
    \renewcommand*{\chapterpagestyle}{scrheadings}%
    \setlength{\@tempdimc}{\oddsidemargin}%
    \addtolength{\@tempdimc}{1in}%
    \setheadwidth[-\@tempdimc]{paper}%
    \pagestyle{scrheadings}%
    % Entweder:
    \hypersetup{colorlinks}% 
    % oder:
%    \hypersetup{pdfborderstyle={/S/U/W 1}}%
    \let\orig@maketitle\maketitle
    \def\maketitle{%
      \begingroup
        \@twosidetrue
        \let\cleardoublepage\clearpage
        \addtolength{\oddsidemargin}{\evensidemargin}%
        \setlength{\evensidemargin}{.5\oddsidemargin}%
        \setlength{\oddsidemargin}{\evensidemargin}%
        \orig@maketitle\relax
      \endgroup
    }%
    \renewcommand*{\chapterheadstartvskip}{}%
    \raggedbottom
    \sloppy
    \lstset{breaklines,prebreak=\mbox{$\hookleftarrow$}}%
  }%
}
%    \end{macrocode}
%
% Now loading the last package (better do it late than never):
%    \begin{macrocode}
\RequirePackage{textcomp}
%    \end{macrocode}
%
% \section{Load common paragraphs}
%
% \begin{macrocode}
\newcounter{commonpar}
\newcommand*{\LoadCommon}[2][\label@base]{%
  \setcounter{commonpar}{#2}%
  \@ifundefined{ifCommon#1}{%
    \expandafter\csname newif\expandafter\endcsname
    \csname ifCommon#1\endcsname
  }{}%
  \csname Common#1true\endcsname
  \input{common-#2.tex}%
  \csname Common#1false\endcsname
}
\newcommand*{\IfCommon}[1]{%
  \ifstr{\label@base}{#1}{%
    \@firstofone
  }{%
    \@gobble
  }%
}
\newcommand*{\IfNotCommon}[1]{%
  \ifstr{\label@base}{#1}{%
    \@gobble
  }{%
    \@firstofone
  }%
}
% \end{macrocode}
%
% \section{Language Dependencies}
%
% We load the language dependency file at |\begin{document}| and add some
% of the extensions to the language.
%    \begin{macrocode}
\AtBeginDocument{%
  \InputIfFileExists{\jobname-\uselanguage.tex}{%
    \ClassInfo{scrguide}{Loading language dependencies for \uselanguage}%
  }{%
    \ClassError{scrguide}{\uselanguage\space not supported}{%
      You've tried to generate a guide for language `\uselanguage' but
      language\MessageBreak
      dependency file `\jobname-\uselanguage.tex' was not found.\MessageBreak
      This may result in a lot of errors and warnings, if you'll continue}%
  }%
  \expandafter\addto\csname extras\uselanguage\endcsname
  \GuideLanguageExtensions\GuideLanguageExtensions
}
%    \end{macrocode}
%
%
% \section{Breaking of Paragraphs and Pages}
%
% There are several parameters to configure the breaking. I've tried to find
% good values. First of all the placement of floats and text.
%    \begin{macrocode}
\renewcommand*{\floatpagefraction}{.75}% was .6
\renewcommand*{\textfraction}{.2}% original
\renewcommand*{\topfraction}{.75}% was .7
\renewcommand*{\bottomfraction}{.33}% was .3
\setcounter{topnumber}{1}% was 2
\setcounter{bottomnumber}{1}% original
\setcounter{totalnumber}{3}% original
%    \end{macrocode}
%
%
% \section{Find the Date of the Newest Documentation File}
%
% \begin{macro}{\newestfiledate}
%    The latex date of the newest used file.
%    \begin{macrocode}
\newcommand*{\newestfiledate}{0001-01-01}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\@notonlypreamble}
%    Remove commands from to be \@onlypreamble commands.
%    \begin{macrocode}
\newcommand*{\@notonlypreamble}[1]{%
  \begingroup
    \let\new@preamblecmds\@empty%
    \def\do##1{\ifx ##1#1\else
      \expandafter\def\expandafter\new@preamblecmds\expandafter{%
        \new@preamblecmds\do##1}\fi}%
    \@preamblecmds
    \global\let\@preamblecmds\new@preamblecmds
  \endgroup
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\@ifl@t@r}
%    Not longer a |\@onlypreamble| command.
%    \begin{macrocode}
\@notonlypreamble\@ifl@t@r
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\@parse@version}
%    Not longer a |\@onlypreamble| command.
%    \begin{macrocode}
\@notonlypreamble\@parse@version
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\@latex@version}
%    Like |\@parse@version| but returns a \LaTeX{} date.
%    \begin{macrocode}
\newcommand*{\@latex@version}{}
\def\@latex@version#1/#2/#3#4#5\@nil{#1/#2/#3#4}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\@iso@version}
%    Like |\@parse@version| but returns an iso date.
%    \begin{macrocode}
\newcommand*{\@iso@version}{}
\def\@iso@version#1/#2/#3#4#5\@nil{#1-#2-#3#4}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\IsoDate}
%    Converts \LaTeX{} date #1 into an iso date.
%    \begin{macrocode}
\newcommand*{\IsoDate}[1]{\expandafter\@iso@version#1//00\@nil}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\@CheckDate}
%    Check if the provided date of file #1.tex is newer than
%    \@newestfiledate. If so, write the new date to the aux file.
%    \begin{macrocode}
\newcommand*{\@CheckDate}[1]{%
  \begingroup
    \expandafter\ifx\csname ver@#1.tex\endcsname\relax\else
      \typeout{\csname ver@#1.tex\endcsname}%
      \expandafter\@ifl@t@r\csname ver@#1.tex\endcsname\newestfiledate{%
        \xdef\newestfiledate{%
          \expandafter\expandafter\expandafter\@latex@version
          \csname ver@#1.tex\endcsname//00\@nil%
        }%
        \write\@auxout{\noexpand\gdef\noexpand\newestfiledate{%
            \newestfiledate}\@percentchar\space #1.tex}%
     }{}%
    \fi
  \endgroup
}
%    \end{macrocode}
% \end{macro}
%
% Check the date of the jobfile:
%    \begin{macrocode}
\@CheckDate\jobname
%    \end{macrocode}
%
% \begin{macro}{\@providesfile}
% \begin{macro}{\SCR@providesfile}
%    Redefine |\ProvidesFile| to also check the date.
%    \begin{macrocode}
\newcommand*{\SCR@providesfile}{}
\AtBeginDocument{%
  \let\SCR@providesfile\@providesfile
  \def\@providesfile#1[#2]{%
    \SCR@providesfile#1[#2]%
    \expandafter\@CheckDate\expandafter{\expandafter\@BaseFileName#1.\@nil}%
  }%
}
%    \end{macrocode}
% \begin{macro}{\@BaseFileName}
%    Split of extension of the file name.
%    \begin{macrocode}
\newcommand*{\@BaseFileName}{}
\def\@BaseFileName#1.#2\@nil{#1}
%    \end{macrocode}
% \end{macro}
% \end{macro}
% \end{macro}
%
% Predefine current date:
%    \begin{macrocode}
\AtBeginDocument{\date{\IsoDate\newestfiledate}}
%    \end{macrocode}
%
%
% \section{Collect All Translators}
%
% At the translated guides, the translators should also be shown somewhere at
% the title.
%
% \begin{macro}{\translator}
%   \changes{v0.9d}{2007/09/18}{new}
% This macro is used, so save one or more translators into the aux file.
%    \begin{macrocode}
\newcommand*{\translator}[1]{%
  \protected@write\@auxout{\def\and{,}}{%
    \protect\@addtranslators{#1}%
  }%
}
%    \end{macrocode}
% \begin{macro}{\@translator}
% \begin{macro}{\@addtranslator}
% And we need macros so store the translators
%    \begin{macrocode}
\newcommand*{\@translator}{}
%    \end{macrocode}
% and to read the translators from the aux file.
%    \begin{macrocode}
\newcommand*{\@addtranslators}[1]{%
  \ifx\@translator\@empty\else\g@addto@macro\@translator{,}\fi
  \g@addto@macro\@translator{#1}%
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
% \end{macro}
%
%
% \begin{macro}{\settranslator}
%   \changes{v0.9d}{2007/09/18}{new}
% Last but not least, we need a macro to set the list of translators.
%    \begin{macrocode}
\newcommand{\settranslator}[2]{%
  \ifx\@translator\@empty\else
    #1%
    \begingroup
%   \end{macrocode}
% Run through all translators, but store each once only.
      \let\@tempb\@empty
      \@tempcnta=\z@
      \expandafter\@for \expandafter\@tempa\expandafter:\expandafter=%
      \@translator\do {%
        \ifx\@tempa\@empty\else
          \typeout{Test: `,\@tempa,' at `,\@tempb,'}%
          \@expandtwoargs\in@{,\@tempa,}{,\@tempb,}%
          \ifin@\else
            \edef\@tempb{\@tempb\@tempa,}%
            \advance\@tempcnta by 1\relax
          \fi
        \fi
      }%
%    \end{macrocode}
% Set each of the stored translators.
%    \begin{macrocode}
      \@tempcntb=\z@
      \expandafter\@for \expandafter\@tempa\expandafter:\expandafter=%
      \@tempb\do {%
        \ifx\@tempa\@empty\else
          \advance\@tempcntb by 1\relax
          \typeout{Translator \the\@tempcntb: \@tempa}%
          \ifnum\@tempcntb >\@ne\relax
            \ifnum\@tempcntb=\@tempcnta\relax
              \ifnum\@tempcntb=\tw@\relax
                \GuideAnd
              \else
                \GuideListAnd
              \fi
            \else
              ,
            \fi
          \fi
          \@tempa
        \fi
      }%
    \endgroup
    #2%
  \fi
}
%    \end{macrocode}
% \end{macro}
%
% \section{Emphasization and Fonts}
%
% The \KOMAScript{} guide uses a lot of emphasizations. Most of them are
% declared robustly to avoid problems at index, change log etc.
%
% \begin{macro}{\textsfrm}
%   Something like |\emph| using |\textsf| and |\textrm| instead of |\textit|
%   and |\textup|.
%    \begin{macrocode}
\newcommand*{\textsfrm}[1]{%
  \begingroup
    \edef\@tempa{\sfdefault}%
    \ifx\@tempa\f@family\textrm{#1}\else\textsf{#1}\fi
  \endgroup
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\File}
% \begin{macro}{\Class}
% \begin{macro}{\Package}
%   Some markup macros for files with special meanings.
\DeclareRobustCommand*{\File}[1]{\mbox{\texttt{#1}}}
\DeclareRobustCommand*{\Class}[1]{\mbox{\textsfrm{#1}}}
\DeclareRobustCommand*{\Package}[1]{\mbox{\textsfrm{#1}}}
% \end{macro}
% \end{macro}
% \end{macro}
%
% \begin{macro}{\Macro}
% \begin{macro}{\Option}
% \begin{macro}{\KOption}
% \begin{macro}{\OptionValue}
% \begin{macro}{\Environment}
% \begin{macro}{\Counter}
% \begin{macro}{\Length}
% \begin{macro}{\PLength}
% \begin{macro}{\FloatStyle}
% \begin{macro}{\Pagestyle}
% \begin{macro}{\Variable}
% \begin{macro}{\FontElement}
% \begin{macro}{\PName}
% \begin{macro}{\PValue}
% \begin{macro}{\Parameter}
% \begin{macro}{\OParameter}
% \begin{macro}{\AParameter}
% \begin{macro}{\PParameter}
% \begin{macro}{\POParameter}
%   \begin{description}
%   \item[\cs{Macro}] \LaTeX{} or \TeX{} macro
%   \item[\cs{Option}] class or package option
%   \item[\cs{KOption}] |\KOMAoptions| option
%   \item[\cs{Environment}] \LaTeX{} environment
%   \item[\cs{Counter}] \LaTeX{} counter
%   \item[\cs{Length}] \LaTeX{} length
%   \item[\cs{PLength}] \KOMAScript{} pseudo length
%   \item[\cs{Variable}] \KOMAScript{} variable
%   \item[\cs{FontElement}] \KOMAScript{} element that has its own font
%     selection
%   \item[\cs{PName}] name of a parameter of a macro or environment
%   \item[\cs{PValue}] value of a parameter of a macro or environment
%   \item[\cs{Parameter}] the mandatory parameter of a macro or environment
%   \item[\cs{OParameter}] the optional parameter of a macro or environment
%   \item[\cs{AParameter}] the alternativ parameter of a macro or environment
%   \item[\cs{PParameter}] the part-of-command parameter of a macro or
%     environment
%   \end{description}
%    \begin{macrocode}
\DeclareRobustCommand*{\Macro}[1]{\mbox{\texttt{\char`\\#1}}}
\DeclareRobustCommand*{\Option}[1]{\mbox{\texttt{#1}}}
\DeclareRobustCommand*{\KOption}[1]{\mbox{\Option{#1}\texttt=}}
\DeclareRobustCommand*{\OptionValue}[2]{\mbox{\texttt{#1=#2}}}
\DeclareRobustCommand*{\FloatStyle}[1]{\mbox{\texttt{#1}}}
\DeclareRobustCommand*{\Pagestyle}[1]{\mbox{\texttt{#1}}}
\DeclareRobustCommand*{\Environment}[1]{\mbox{\texttt{#1}}}
\DeclareRobustCommand*{\Counter}[1]{\mbox{\texttt{#1}}}
\DeclareRobustCommand*{\Length}[1]{\mbox{\texttt{\char`\\#1}}}
\DeclareRobustCommand*{\PLength}[1]{\mbox{\PValue{#1}}}
\DeclareRobustCommand*{\Variable}[1]{\mbox{\PValue{#1}}}
\DeclareRobustCommand*{\FontElement}[1]{\PValue{#1}}
\DeclareRobustCommand*{\PName}[1]{\texttt{\textit{#1}}}
\DeclareRobustCommand*{\PValue}[1]{\texttt{#1}}
\DeclareRobustCommand*{\Parameter}[1]{\texttt{\{}\PName{#1}\texttt{\}}}
\DeclareRobustCommand*{\OParameter}[1]{%
  \texttt{[%]
  }\PName{#1}\texttt{%[
    ]}}
\DeclareRobustCommand*{\AParameter}[1]{%
  \texttt{(%)
  }\PName{#1}\texttt{%(
    )}}
\DeclareRobustCommand*{\PParameter}[1]{\texttt{\{#1\}}}
\DeclareRobustCommand*{\POParameter}[1]{\texttt{[#1]}}
%    \end{macrocode}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
%
% \begin{macro}{\EMail}
%   An email adress.
%    \begin{macrocode}
\DeclareRobustCommand*{\EMail}[1]{\textless #1\textgreater}
%    \end{macrocode}
% \end{macro}
% \begin{macro}{\TextEMail}
%   EMail address at the text.
%    \begin{macrocode}
\DeclareRobustCommand*{\TextEMail}[1]{{\small\EMail{#1}}}
%    \end{macrocode}
% \end{macro}
%
% Setup fonts for table and figure captions:
%    \begin{macrocode}
\setkomafont{caption}{\normalcolor\small}
%    \end{macrocode}
%
%
% \section{Footnotes}
%
% \begin{macro}{\thempfootnote}
%    \begin{macrocode}
\renewcommand*{\thempfootnote}{\textit{\@arabic{\c@mpfootnote}}}
%    \end{macrocode}
% \end{macro}
%
% \section{Math}
%
% I will not use real math. But there will be some »pseudo math code«. So I
% need some macros for this.
%
% \begin{macro}{\Var}
%   Variables (in real math simply |$a$| will be |\Var{a}| in my math:
%    \begin{macrocode}
\newcommand*{\Var}[1]{\ensuremath{\textit{#1}}}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\Unit}
%   The unit of a length.
%    \begin{macrocode}
\newcommand*{\Unit}[1]{\,\ifmmode \textrm{#1}\else #1\fi}
%    \end{macrocode}
% \end{macro}
%
% Wie allow page breaks at display math.
%    \begin{macrocode}
\allowdisplaybreaks[1]
%    \end{macrocode}
%
%
% \section{Acronyms}
%
% \begin{macro}{\Script}
% \begin{macro}{\ScriptII}
%    \begin{macrocode}
\DeclareRobustCommand{\Script}{\Package{Script}}
\DeclareRobustCommand{\ScriptII}{\Package{Script-2}}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
% \begin{macro}{\eTeX}
%   This may already be defined.
%    \begin{macrocode}
\providecommand*{\eTeX}{\ensuremath{\varepsilon}-\TeX}
%    \end{macrocode}
% \end{macro}
%
%
% \section{Identification}
%
% \begin{macro}{\labelbase}
%    \begin{macrocode}
\newcommand*{\labelbase}[1]{%
  \renewcommand*{\label@base}{#1}%
  \label{cha:#1}%
}
%    \end{macrocode}
% \begin{macro}{\label@base}
%    \begin{macrocode}
\newcommand*{\label@base}{unknown}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
% \section{Special Environments}
%
% \begin{environment}{Declaration}
%   Declaration of macros, environments, options, lengths, counters, pseudo
%   length, variables etc.\footnote{TODO: Redefining most declaration commands
%     to also write labels.}
%    \begin{macrocode}
\newenvironment{Declaration}{%
%    \end{macrocode}
% \begin{macro}{\new@element}
%   Help macro to define new Declaration elements.
%    \begin{macrocode}
  \newcommand*{\new@element}[1]{%
    \expandafter\newcommand\expandafter*\csname X##1\endcsname{}%
    \expandafter\let\csname X##1\expandafter\endcsname
    \csname ##1\endcsname
    \expandafter\newcommand\expandafter*\csname new##1\endcsname[1]{%
%      \begingroup
%        \let\ensuremath\@firstofone
%        \let\textit\@firstofone
%        \lowercase{\def\@tempa{##1}}%
%        \pdfstringdef\@tempb{\label@base.\@tempa.####1}%
%        \xdef\@currentHref{\@tempb}%
%        \Hy@raisedlink{\hyper@anchorstart{\@currentHref}\hyper@anchorend}%
%        \label{desc:\label@base.\@tempa.####1}%
%      \endgroup
      \csname X##1\endcsname{####1}\ignorespaces
    }%
    \expandafter\let\csname ##1\expandafter\endcsname\csname new##1\endcsname
  }%
  \newcommand*{\new@xelement}[2]{%
    \expandafter\newcommand\expandafter*\csname X##1\endcsname{}%
    \expandafter\let\csname X##1\expandafter\endcsname
    \csname ##1\endcsname
    \expandafter\newcommand\expandafter*\csname new##1\endcsname[2]{%
%      \begingroup
%        \let\ensuremath\@firstofone
%        \let\textit\@firstofone
%        \lowercase{\def\@tempa{##1}}%
%        \pdfstringdef\@tempb{\label@base.\@tempa.####1.####2}%
%        \xdef\@currentHref{\@tempb}%
%        \Hy@raisedlink{\hyper@anchorstart{\@currentHref}\hyper@anchorend}%
%        \label{desc:\label@base.\@tempa.####1.####2}%
%      \endgroup
      \csname X##1\endcsname{####1}{##2{####2}}\ignorespaces
    }%
    \expandafter\let\csname ##1\expandafter\endcsname\csname new##1\endcsname
  }%
%    \end{macrocode}
%    \begin{macrocode}
  \new@element{Option}%
  \new@element{Macro}%
  \new@element{Environment}%
  \new@element{Counter}%
  \new@element{FloatStyle}%
  \new@element{PLength}%
  \new@element{Variable}%
  \new@xelement{OptionValue}{\PValue}%
%    \end{macrocode}
% \end{macro}
%    \begin{macrocode}
  \ifvmode\else\par\fi\small\addvspace{2\baselineskip}%
  \vspace{-\baselineskip}%
  \vspace{\z@ plus \baselineskip}%
  \noindent
  \start@Declaration
  \tabular{|l|}\hline\ignorespaces
}{%
  \\\hline\endtabular\nobreak\after@Declaration\nobreak\par\nobreak
  \vspace{1.5\baselineskip}\nobreak\vspace{-\baselineskip}\nobreak%
  \vspace{0pt minus .5\baselineskip}\nobreak%
  \aftergroup\@afterindentfalse\aftergroup\@afterheading
}
\newcommand*{\start@Declaration}{\hspace{-1em}}
\newcommand*{\after@Declaration}{}
%    \end{macrocode}
% \end{environment}
%
% \begin{environment}{Example}
%   This environment is used for all examples at the \KOMAScript{} guide.
%    \begin{macrocode}
\newenvironment{Example}{%
  \labeling{{\usekomafont{disposition}\GuideExample:\ }}
  \item[{\usekomafont{disposition}\GuideExample:\ }]%
}{%
  \endlabeling
}
%    \end{macrocode}
% \end{environment}
%
% \begin{environment}{ShowOutput}
%   This environment is used for the output of examples. It shows the middle
%   part of a page\footnote{TODO: optional arguments for printing a top or
%     bottom part of a page}. It uses |\scalebox| so you should never use a
%   DVI preview or a raw DVI printing.
%    \begin{macrocode}
\newsavebox\ShowOutputBox
\newenvironment{ShowOutput}[1][0pt]{\par
  \begin{lrbox}{\ShowOutputBox}%
    \minipage{.9\linewidth}%
      \vspace*{\baselineskip}\vspace{-#1}%
}{%
    \endminipage
  \end{lrbox}%
  \setlength{\unitlength}{1pt}%
  \setlength{\@tempdima}{\ht\ShowOutputBox}%
  \addtolength{\@tempdima}{\dp\ShowOutputBox}%
  \setlength{\@tempdima}{.75\@tempdima}%
  \edef\MidY{\strip@pt\@tempdima}%
  \addtolength{\@tempdima}{5pt}%
  \edef\HighY{\strip@pt\@tempdima}%
  \addtolength{\@tempdima}{-10pt}%
  \edef\LowY{\strip@pt\@tempdima}%
  \addtolength{\@tempdima}{5pt}%
  \setlength{\@tempdima}{.9\linewidth}\edef\QuadIV{\strip@pt\@tempdima}%
  \setlength{\@tempdima}{.675\linewidth}\edef\QuadIII{\strip@pt\@tempdima}%
  \setlength{\@tempdima}{.45\linewidth}\edef\QuadII{\strip@pt\@tempdima}%
  \setlength{\@tempdima}{.225\linewidth}\edef\QuadI{\strip@pt\@tempdima}%
  \centering
  \begin{picture}(\QuadIV,\MidY)
     \qbezier(0,\MidY)(\QuadI,\HighY)(\QuadII,\MidY)%
     \qbezier(\QuadII,\MidY)(\QuadIII,\LowY)(\QuadIV,\MidY)
     \put(0,0){\makebox(\QuadIV,\MidY)[c]{%
         \scalebox{.75}{\usebox{\ShowOutputBox}}%
       }%
     }%
     \put(0,-5){\line(0,1){\HighY}}%
     \put(\QuadIV,-5){\line(0,1){\HighY}}%
     \qbezier(0,-5)(\QuadI,0)(\QuadII,-5)%
     \qbezier(\QuadII,-5)(\QuadIII,-10)(\QuadIV,-5)
  \end{picture}\par  
  \vspace{1ex plus 1ex minus .5ex}%
}
%    \end{macrocode}
% \end{environment}
%
% \begin{environment}{Explain}
%   Some parts of the documentation are importing for understanding
%   \KOMAScript{} but not important for using \KOMAScript.
%    \begin{macrocode}
\newenvironment{Explain}{%
  \par\sffamily\ignorespaces
}{%
  \par
}
%    \end{macrocode}
% \end{environment}
%
%
% \subsection{Used by Jens-Uwe only}
%
% There are some example visualizations used only by Jens-Uwe.\footnote{TODO:
%   All these should be merged with \texttt{ShowOutputBox}.}
%
% \begin{environment}{XmpTopPage}
%   Output of the top of a page.
%    \begin{macrocode}
\newenvironment{XmpTopPage}
 {%
   \begin{center}
     \iffree{\setlength{\unitlength}{1mm}}{\setlength{\unitlength}{.833mm}}%
     \begin{picture}(100,39)
       \thinlines
       \qbezier(0,5)(25,7)(50,5)\qbezier(50,5)(75,3)(100,5)
       \put(0,5){\line(0,1){34}}
       \thicklines
       \put(100,5){\line(0,1){34}}\put(0,39){\line(1,0){100}}
       \footnotesize
 }{%
     \end{picture}
   \end{center}\vspace{-1.5\baselineskip}%
}
%    \end{macrocode}
% \end{environment}
%
% \begin{environment}{XmpBotPage}
%   Output of the bottom of a page.
%    \begin{macrocode}
\newenvironment{XmpBotPage}
 {\begin{center}
     \iffree{\setlength{\unitlength}{1mm}}{\setlength{\unitlength}{.833mm}}%
     \begin{picture}(100,40)%
       \thinlines
       \qbezier(0,38)(25,40)(50,38)\qbezier(50,38)(75,36)(100,38)
       \put(0,5){\line(0,1){33}}
       \thicklines
       \put(100,5){\line(0,1){33}}\put(0,5){\line(1,0){100}}
       \footnotesize
}{%
  \end{picture}\end{center}\vspace{-1.5\baselineskip}%
}
%    \end{macrocode}
% \end{environment}
%
% \begin{macro}{\XmpSetText}
%   Output some text at \texttt{XmpTopPage} or \texttt{XmpBotPage}.
%    \begin{macrocode}
\newcommand{\XmpSetText}[2][\XmpText]{%
        \put(#2){\makebox(0,0)[tl]{\parbox{70\unitlength}{\parfillskip=0pt 
              #1}}}}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\XmpMarginNote}
%   Output a margin note at \texttt{XmpTopPage} or \texttt{XmpBotPage}.
%    \begin{macrocode}
\newcommand{\XmpMarginNote}[1]{%
        \put(#1){\makebox(0,5)[tl]{\scriptsize\XmpMarginTextA}}
        \put(#1){\makebox(0,5)[bl]{\scriptsize\XmpMarginTextB}}}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\XmpRule}
%   Output a horizonal rule at a \texttt{XmpTopPage} or \texttt{XmpBotPage}.
%    \begin{macrocode}
\newcommand{\XmpRule}[2]{\put(#1){\line(1,0){#2}}}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\XmpHeading}
%   Output a head line at a \texttt{XmpTopPage} or \texttt{XmpBotPage}.
%    \begin{macrocode}
\newcommand{\XmpHeading}[3][\KOMAScript\hfill 3]{%
        \put(#2){\makebox(#3,0)[l]{#1}}}
%    \end{macrocode}
% \end{macro}
%
%
% \section{Margin Notes}
%
% \begin{macro}{\OnlyAt}
%   Some things are not available at every \KOMAScript{} class. To show the
%   differences we'll put a margin note. If more than one class or package
%   should be noted, |\and| will be used to separate them.
%    \begin{macrocode}
\newcommand*{\OnlyAt}[1]{%
  \marginline{\def\and{,\\}\footnotesize #1\par}%
}
%    \end{macrocode}
% \end{macro}
%
%
% \section{Change Log}
%
% Not all features are part of every old \KOMAScript{} release. New features
% will be marked and these marks are referenced at a kind of index.
%
% \begin{macro}{\ChangedAt}
%   Set the margin note and write an entry to the change log.\footnote{TODO:
%     Don't use the glossary, use a file by my own.}
%    \begin{macrocode}
\providecommand*{\ChangedAt}[2]{%
  \marginnote{\footnotesize\fbox{\strut#1}}%
  \begingroup
    \let\@tempa\@empty
    \ifstr{#1}{v2.9i}{\def\@tempa{v2.90i=}}{}%
    \ifstr{#1}{v2.9t}{\def\@tempa{v2.90t=}}{}%
    \let\and\ignorespaces
    \def\Package##1{%
      \glossary{##1=\string\Package{##1}>\@tempa#1|indexrm}%
      \glossary{\@tempa#1>##1=\string\Package{##1}|indexrm}%
      \ignorespaces
    }%
    \def\Class##1{%
      \glossary{##1=\string\Class{##1}>\@tempa#1|indexrm}%
      \glossary{\@tempa#1>##1=\string\Class{##1}|indexrm}%
      \ignorespaces
    }%
    \ignorespaces #2%
  \endgroup
}
%    \end{macrocode}
% \end{macro}
% 
% While I currently use the glossary, we have to make it:
%    \begin{macrocode}
\makeglossary
%    \end{macrocode}
%
% \begin{macro}{\printchangelog}
%   We don't want to generate the change log only. We also have to print it.
%    \begin{macrocode}
\newcommand*{\printchangelog}{\@input@{\jobname.chn}}
%    \end{macrocode}
% \end{macro}
% \begin{environment}{thechangelog}
%   And this will be used at the \texttt{chn} file. The change log index will
%   always generate an entry to the table of contents.
%    \begin{macrocode}
\newenvironment{thechangelog}{%
  \setchapterpreamble{\GuideChangeLogPreamble\par\bigskip}%
  \addchap{\changelogname}%
  \markboth{\changelogname}{\changelogname}%
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{0pt plus .3pt}%
  \setlength{\parfillskip}{0pt plus 1fil}%
  \def\and{,\ }%
  \let\item\@idxitem
}{%
  \clearpage
}
%    \end{macrocode}
%   The macros |\GuideChangeLogPreamble| and |\changelogname| have to be
%   defined at the language file.
% \end{environment}
%
%
% \section{Special Tabulars and Tables}
%
% I need some special tabulars and tables. These are used for describing
% single topics.
%
% \begin{environment}{desctabular}
%   This kind of tabluar has primary one column but uses two columns in
%   declaration. It's something like a \texttt{description} environment with
%   line break after the item. I've used a \texttt{tabular} at the definition
%   because of full compatibitlity with \texttt{desctable}.
% \begin{length}{\descwidth}
%   I need a length of local usage. I could have used |\@tempdima| or
%   another local length from kernel. But I've decided not to try to find a
%   unused length at \texttt{tabular} environment.
% \begin{length}{\descdefaultindent}
%   And I need a length of global usage.
%    \begin{macrocode}
\newlength{\descwidth}
\newlength{\descdefaultindent}\setlength{\descdefaultindent}{2em}
%    \end{macrocode}
% \end{length}
% \end{length}
%   The definition of \texttt{desctabular} is very simple, because the main
%   work will be done by a \emph{worker} macro that will be defined later.
%    \begin{macrocode}
\newenvironment{desctabular}[1][c]{%
  \start@desctab{\descdefaultindent}%
  \tabular[#1]{lp{\descwidth}}
  \toprule
}{
  \addlinespace[-.5\normalbaselineskip]\bottomrule
  \endtabular
}
%    \end{macrocode}
% \end{environment}
%
% \begin{environment}{desctable}
%   \textbf{Deprecated! Use \texttt{desclist} instead of!}
%   This is almost the same like \texttt{desctabular} but it uses a longtable
%   to allow page breaks.
%    \begin{macrocode}
\newenvironment{desctable}[1][\descdefaultindent]{%
  \onelinecaptionsfalse
  \start@desctab{#1}%
  \newcommand{\Endfirsthead}{\toprule\endfirsthead}%
  \newcommand{\Endhead}{\midrule\endhead}%
  \newcommand*{\standardfoot}{%
    \addlinespace[-.5\normalbaselineskip]\midrule
    \multicolumn{2}{r@{}}{\dots}\\
    \endfoot
    \addlinespace[-.5\normalbaselineskip]\bottomrule
    \endlastfoot
  }%
  \longtable{lp{\descwidth}}%
}{%
  \endlongtable
}
%    \end{macrocode}
% \end{environment}
%
% \begin{macro}{\start@desctab}
%   This is the \emph{worker} macro of \texttt{desctable} and
%   \texttt{desctabular}. It does the complete calculations and definition of
%   the entry (something like |\item|) commands.
%    \begin{macrocode}
\newcommand*{\start@desctab}[1]{%
  \setlength{\descwidth}{\linewidth}%
  \addtolength{\descwidth}{-4\tabcolsep}%
  \addtolength{\descwidth}{-#1}%
  \setlength{\labelwidth}{\linewidth}%
  \addtolength{\labelwidth}{-2\tabcolsep}%
  \newcommand{\nentry}[2]{%
    \multicolumn{2}{p{\labelwidth}}{\raggedright##1}\tabularnewline*%
    \hspace*{#1} & ##2\tabularnewline%
  }%
  \newcommand{\entry}[2]{\nentry{##1}{##2}[.5\baselineskip]}%
  \newcommand*{\pentry}[1]{%
    \entry{\PLength{##1}\IndexPLength[indexmain]{##1}}}%
  \newcommand*{\pventry}[1]{\entry{\PValue{##1}}}%
  \newcommand*{\mentry}[1]{\entry{\Macro{##1}}}%
  \newcommand*{\ventry}[1]{%
    \entry{\Variable{##1}\IndexVariable[indexmain]{##1}}%
  }%
  \newcommand*{\feentry}[1]{%
    \entry{\FontElement{##1}\IndexFontElement[indexmain]{##1}}%
  }%
  \newcommand*{\oentry}[1]{%
    \entry{\Option{##1}\IndexOption[indexmain]{##1}}%
  }%
}
% \end{macro}
%
% \begin{environment}{desclist}
%   This is similar to \texttt{desctable} but it has been build by single
%   tabulars instead of longtable.
% \begin{macro}{\desccaptionb@xfirst}
% \begin{macro}{\desccaptionb@xother}
% \begin{macro}{\descfootb@x}
% \begin{macro}{\descentryb@x}
% \begin{macro}{\desccaptiob@xnext}
%    \begin{macrocode}
\newsavebox\desccaptionb@xfirst
\newsavebox\desccaptionb@xother
\newsavebox\descfootb@x
\newsavebox\descentryb@x
\newif\ifdescpage@dd
\newcommand*{\desccaptionb@xnext}{}
\newcommand*{\abovecaptionskipcorrection}{}
\newenvironment{desclist}[1][\descdefaultindent]{%
  \par
  \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\selectfont%
  \vskip\intextsep
  \start@desctab{#1}%
  \csname @desclistinithook\endcsname
  \def\@captype{table}%
  \newcommand{\desccaption}{\@dblarg{\@desccaption}}%
  \newcommand{\@desccaption}[3][]{%
    \setbox\desccaptionb@xfirst\vbox{%
      \tabular{p{\labelwidth}}%
        \multicolumn{1}{@{}p{\dimexpr\labelwidth+2\tabcolsep}@{}}{%
          \captionaboveof{table}[##1]{##2}%
        }\tabularnewline[\dimexpr \abovecaptionskip\abovecaptionskipcorrection\relax]
        \toprule\tabularnewline
      \endtabular
      \vskip -\baselineskip
    }%
    \let\abovecaptionskipcorrection\@empty
    \setbox\desccaptionb@xother\vbox{%
      \tabular{p{\labelwidth}}
      \multicolumn{1}{@{}p{\dimexpr\labelwidth+2\tabcolsep}@{}}{%
        \@@makecaption\@firstofone{\fnum@table}{\ignorespaces ##3}%
      }\tabularnewline[-\normalbaselineskip]
      \addlinespace[\abovecaptionskip]
        \toprule\tabularnewline
      \endtabular
      \vskip -\baselineskip
    }%
    \let\desccaptionb@xnext\desccaptionb@xfirst
  }%
  \setbox\descfootb@x\vbox{%
    \tabular{p{\labelwidth}}%
      \addlinespace[-.5\normalbaselineskip]\midrule
      \addlinespace[-\dp\strutbox]
      \raggedleft\dots\hspace*{-\tabcolsep}\tabularnewline
    \endtabular
  }%
  \newcommand*{\entryskip}[1][]{%
    \ifx\relax##1\relax\else\vskip##1\relax\fi
  }%
  \renewcommand{\nentry}[2]{%
    \setbox\descentryb@x\vbox{%
      \ifx\desccaptionb@xnext\desccaptionb@xfirst\copy\desccaptionb@xnext\fi
      \tabular{lp{\descwidth}}%
        \multicolumn{2}{p{\labelwidth}}{\raggedright##1}\tabularnewline
        \hspace*{#1} & ##2\tabularnewline
      \endtabular
    }%
    \begingroup
      \dimen@ \ht\descentryb@x \advance \dimen@ \dp\descentryb@x
      \advance \dimen@ \ht\descfootb@x \advance \dimen@ \dp\descfootb@x
      \advance \dimen@ \baselineskip
      \dimen@ii \pagegoal \advance \dimen@ii -\pagetotal
      \typeout{TRACE: \the\dimen@>\the\dimen@ii?}%
      \ifdim \dimen@>\dimen@ii
        \typeout{TRACE: Break table}%
        \ifx\desccaptionb@xnext\@empty
          \csname @desclistentryhook\endcsname
          {\copy\descfootb@x}%
        \fi
        \newpage
        \ifx\desccaptionb@xnext\@empty
          \typeout{TRACE: switch page}%
          \ifdescpage@dd
            \aftergroup\descpage@ddfalse
            \expandafter\descpage@ddfalse
          \else
            \aftergroup\descpage@ddtrue
            \expandafter\descpage@ddtrue
          \fi
          \csname @desclistentryhook\endcsname
          {\copy\desccaptionb@xother}%
         \fi
      \fi
    \endgroup
    \ifx\desccaptionb@xnext\desccaptionb@xfirst
      \ifthispageodd{\descpage@ddtrue}{\descpage@ddfalse}%
    \fi
    \csname @desclistentryhook\endcsname
    {\copy\descentryb@x}%
    \let\desccaptionb@xnext\@empty
   \entryskip
  }%
}{%
  \vskip -.5\baselineskip
  \setbox\descfootb@x\vbox{%
    \tabular{p{\labelwidth}}
    \bottomrule\tabularnewline
    \endtabular
  }%
  \csname @desclistentryhook\endcsname
  {\copy\descfootb@x}%
  \par
  \vskip -\baselineskip \vskip \intextsep
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{environment}
%
%
% \section{Listings}
%
% Setup listings:
%    \begin{macrocode}
\lstdefinestyle{basics}{%
  basicstyle=\ttfamily,%
  columns=fullflexible,keepspaces,%
  aboveskip=.4\baselineskip,%
  belowskip=0pt%
}
\lstdefinestyle{code}{%
  style=basics,%
  language=[LaTeX]TeX,%
  moretexcs={%
    @auxout,
    @currext,
    @empty,
    @float,
    @ifpackagelater,
    @ifundefined,
    @rightmark,
    @secondoftwo,
    @tempswafalse,@tempswatrue,
    @undefined,
    AtBeginDocument,AtEndDocument,
    appendix,
    ClassWarningNoLine,CurrentOption,
    DeclareOption,DeclareRobustCommand,dimexpr,
    end@float,
    ExecuteOptions,
    if@filesw,if@tempswa,if@twoside,
    includegraphics,
    MessageBreak,
    onehalfspacing,
    PackageError,PackageInfo,PackageWarning,PassOptionsToPackage,
    ProcessOptions,protected@write,ProvidesFile,ProvidesPackage,
    RequirePackage,RequirePackageWithOptions,
    setkey,setlength,
    textsuperscript}%
}
\lstdefinestyle{output}{%
  style=basics,breaklines,prebreak=\mbox{$\hookleftarrow$}%
}
\lstdefinestyle{KOMA}{%
  style=code,%
  moretexcs={%
    @addtoplength,@setplength,@newplength,
    activateareas,
    addchap,addrentry,Address,addcontentslinetoeachtocfile,addsec,
    addtoeachtocfile,
    addtokomafont,addtolengthplength,addtoreffields,addtotoclist,
    adrchar,adrentry,AfterBibliographyPreamble,AfterCalculatingTypearea,
    AfterFile,AfterPackage,AfterStartingTOC,
    appendixmore,appendixname,areaset,autodot,automark,AtAddToTocList,
    AtBeginLetter,
    BeforeClosingMainAux,BeforePackage,bib@beginhook,bib@endhook,
    cc,captionabove,captionaboveof,captionbelow,captionbelowof,captionformat,
    captionof,cefoot,cfoot,chapapp,
    chapappifchapterprefix,
    chapter,chapterformat,chaptermarkformat,chapterpagestyle,chead,
    cleardoubleevenemptypage,clearscrheadfoot,closing,cofoot,Comment,
    DeclareNewTOC,
    dedication,deffootnote,deffootnotemark,DefineFamily,DefineFamilyKey,
    DefineFamilyMember,defpagestyle,deftripstyle,
    dictum,dictumauthorformat,dictumrule,dictumwidth,doforeachtocfile,
    encl,extratitle,
    FamilyBoolKey,FamilyExecuteOptions,FamilyNumericalKey,%
    FamilyOption,FamilyOptions,FamilyProcessOptions,FamilySetBool,
    figureformat,figurename,firstfoot,firsthead,FirstName,footfont,footref,
    FreeI,FreeII,FreeIII,FreeIV,
    headfont,headmark,
    ifattoclist,ifoot,ihead,ifkomavarempty,ifstr,ifthispageodd,InputAddressFile,
    KOMAoption,KOMAoptions,KOMAScript,
    l@addto@macro,LastName,LetterOptionNeedsPapersize,listoffigures,
    listoftables,listoftoc,LoadLetterOption,lohead,lowertitleback,
    MakeMarkcase,maketitle,manualmark,marginline,minisec,
    multfootsep,multiplefootnoteseparator,
    Name,nameday,newbibstyle,newcaptionname,newkomavar,nexthead,
    ofoot,ohead,opening,othersectionlevelsformat,
    p@section,pagemark,Paragraph,parformat,parname,parshortname,
    part,partformat,partname,partpagestyle,pnumfont,
    PreventPackageFromLoading,publishers,ps,
    raggedsection,raggedpart,raggedsignature,recalctypearea,
    refL,refS,refN,refParagraph,refParagraphN,refPar,refParL,refParS,refParN,
    refSentence,refSentenceL,refSentenceS,refSentenceN,
    rehead,
    removereffields,ReplaceInput,ReplacePackage,ResetPreventPackageFromLoading,
    sectionmarkformat,Sentence,sentencename,sentenceshortname,
    setbibpreamble,setcapindent,setcapwidth,
    setchapterpreamble,setfootbotline,setfootsepline,setfootwidth,
    setheadsepline,setheadtopline,setheadwidth,setindexpreamble,setkomafont,
    setkomavar,setlengthtoplength,setparsizes,setpartpreamble,setuptoc,
    showfields,showenvelope,showISOenvelope,showUScommercial,showUScheck,
    StorePreventPackageFromLoading,
    subject,SubParagraph,subsectionmarkformat,subtitle,
    tableformat,tablename,tableofcontents,textsubscript,thechapter,thefigure,
    thefootnotemark,thepar,thepart,thesection,thesentence,thesubsection,
    thetable,thistime,
    titlehead,tocbasic@extend@babel,TOCclone,todaysname,typearea,
    unitfactor,
    unsettoc,usekomafont,useplength,usekomavar,uppertitleback
  }%
}
\lstset{style=basics}
\lstnewenvironment{lstoutput}[1][]{%
  \lstset{style=output,basicstyle=\ttfamily\small,#1}%
}{}
\lstnewenvironment{lstcode}[1][]{%
  \lstset{style=KOMA,basicstyle=\ttfamily\small,#1}%
}{}
\newcommand*{\lstinputcode}[1][]{%
  \lstinputlisting[style=KOMA,basicstyle=\ttfamily\small,#1]%
}
%    \end{macrocode}
%
%
% \section{hyperref Addons}
%
% \begin{macro}{\KOMAScript}
% \begin{macro}{\Guide@KOMAScript}
%   We need some additions to \textsf{hyperref}.
%    \begin{macrocode}
\newcommand*{\Guide@KOMAScript}{}
\expandafter\let\csname Guide@KOMAScript\expandafter\endcsname\csname
KOMAScript \endcsname
\DeclareRobustCommand*{\KOMAScript}{%
  \texorpdfstring{\Guide@KOMAScript}{KOMA-Script}%
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
% \begin{macro}{\url@}
%   Redefine to make \texttt{CTAN://} be an alias for
%   \texttt{ftp://|\GuideCTANserver|/tex-archive/}.
%    \begin{macrocode}
\def\url@#1{\expandafter\url@@#1\@nil}
\def\url@@#1://#2\@nil{%
  \def\@tempa{#1}\def\@tempb{CTAN}\ifx\@tempa\@tempb
    \hyper@linkurl{\Hurl{#1://#2}}{ftp://\GuideCTANserver/tex-archive/#2}%
  \else
    \hyper@linkurl{\Hurl{#1://#2}}{#1://#2}%
  \fi
}
%    \end{macrocode}
% \end{macro}
%
% We have to setup \textsf{hyperref}:
%    \begin{macrocode}
\AtBeginDocument{%
  \hypersetup{%
    plainpages=false,
    pdftitle={\GuideTitle},
    pdfauthor={Markus Kohm, Jens-Uwe Morawski},
    pdfsubject={\GuideSubject},
    pdfkeywords={\KOMAScript, scrbook, scrreprt, scrartcl, 
      typearea, scrlfile,
      scrpage, scrpage2, scrlettr, scrlttr2, scraddr, scrtime, scrdate},
    pdfcreator={\KOMAScript, hyperref}
  }%
}
%    \end{macrocode}
%
% \begin{macro}{\autopageref}
%   This is something like |\autoref| but with page reference. A simple
%   definition would use |\hyperref| and |\pageref*|. But I want to allow to
%   decide if the reference is the page or the label. So this definition is
%   more like |\autoref|.
%    \begin{macrocode}
\DeclareRobustCommand{\autopageref}[1]{%
  \expandafter\auto@setpageref\csname r@#1\endcsname
  \@secondoffive
  {#1}%
}
%    \end{macrocode}
% \begin{macro}{\auto@setpageref}
%   This is the \emph{worker} macro. It checks for the label and trys to set
%   either a reference to the page or a reference to the label.
%    \begin{macrocode}
\newcommand*{\auto@setpageref}[3]{%
  \@safe@activestrue
  \ifx#1\relax
    \protect\G@refundefinedtrue
    \nfss@text{\reset@font\bfseries ??}%
    \@latex@warning{%
      Reference `#3' on page \thepage \space undefined%
    }%
  \else
    \def\@currentHtag{\pageautorefname~}%
    \if@pagereftolabel
      \hyper@@link
      {\expandafter\@fifthoffive#1}%
      {\expandafter\@fourthoffive#1\@empty\@empty}%
      {\@currentHtag\expandafter#2#1\@empty\@empty\null}%
    \else
      \hyper@@link
      {\expandafter\@fifthoffive#1}%
      {page.\expandafter\@secondoffive#1\@empty\@empty}%
      {\@currentHtag\expandafter#2#1\@empty\@empty\null}%
    \fi
  \fi
  \@safe@activesfalse
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
%
% \section{Entries to \contentsname, \figurelistname, etc.}
%
% We have large page numbers, so better setup the needed width. And we like
% other dot seperation.
%    \begin{macrocode}
\usetocstyle{classic}
\renewcommand*{\@pnumwidth}{1.8em}% 1.67
\renewcommand*\@tocrmarg {2.70em}% 2.55em
\renewcommand*\@dotsep{2.5}
\settocfeature[toc][-1]{entryhook}{%
  \let\sg@numberline\numberline
  \renewcommand*{\numberline}[1]{%
    \sg@numberline{\partname~##1}%
    ~\linebreak\nopagebreak\hspace*{-\@tempdima}%
  }%
  \def\autodot{: }%
  \sectfont
}
%    \end{macrocode}
%
% \section{Part}
%
% We want another vertical spacing at part headings.
%    \begin{macrocode}
\renewcommand*{\partheadstartvskip}{\vspace*{.1\textheight}}
\renewcommand*{\partheadmidvskip}{\par\nobreak\vspace{.5\baselineskip}}
\renewcommand*{\partpagestyle}{empty}
%    \end{macrocode}
%
%
% \section{Appendix}
%
% \begin{macro}{\appendix}
% Use only first if used more than once. With this, every appendix file may
% start with |\appendix|.
%    \begin{macrocode}
\g@addto@macro\appendix{\global\let\appendix\relax}
%    \end{macrocode}
% \end{macro}
%
% \section{Bibliography}
%
% \begin{macro}{\BibTeX}
%   I use the same hack like the \LaTeX{} team uses at \texttt{ltlogos.dtx}
%   for |\LaTeX|:
%    \begin{macrocode}
\DeclareRobustCommand{\BibTeX}{B\kern-.05em%
  \hbox{$\m@th$%
    \csname S@\f@size\endcsname \fontsize\sf@size\z@
    \math@fontsfalse\selectfont
    I\kern-.025emB}%
  \kern-.08em%
  \-\TeX%
}
%    \end{macrocode}
% \end{macro}
%
% Use of a preamble and sime other usefull changes.
%    \begin{macrocode}
\AtBeginDocument{%
  \setbibpreamble{\GuideBibPreamble\bigskip}%
  \selectbiblanguage{\languagename}%
  \bibliographystyle{babalpha-fl}%
  \renewcommand*{\@openbib@code}{%
    \setlength{\parsep}{0pt}%
    \renewcommand*{\btxauthorcolon}[1]{:\par\nobreak}%
    \renewcommand*{\btxurlfont}{\par\nobreak\url}%
    \raggedright
  }%
}
%    \end{macrocode}
%
% The generated argument of thebibliography is to short:
%    \begin{macrocode}
\newcommand*{\OrigTheBibliography}{}
\let\OrigTheBibliography\thebibliography
\renewcommand*{\thebibliography}[1]{%
  \OrigTheBibliography{XXXX99}%
}
%    \end{macrocode}
%
%
% \section{Index}
%
% This is realy tricky. The index depends on an external perl script, which
% splits the one index into several indexes. But first of all, we need to make
% the raw index.
%    \begin{macrocode}
\makeindex
%    \end{macrocode}
%
% Use of a preamble:
%    \begin{macrocode}
\AtBeginDocument{\setindexpreamble{\GuideIndexPreamble\bigskip}}
%    \end{macrocode}
%
% \begin{macro}{\ifusemultiindex}
%   Now let's decide wether to use one index or to use a multi part index.
%    \begin{macrocode}
\newif\ifusemultiindex
\IfFileExists{\jobname-gen.ind}{\usemultiindextrue}{\usemultiindexfalse}
\ifusemultiindex
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\printmultiindex}
%   Print one part of the multi part index.
%    \begin{macrocode}
  \newcommand*{\printmultiindex}[3][]{%
    \begingroup
      \def\indexname{#2}%
%    \end{macrocode}
% \begin{macro}{\CrossIndex}
%   Produce a reference from one index to another. The macro |\UseIndex| tells
%   the external splitt processor the index to be used for that entry. The
%   first argument is the entry to the index. The second is the shortcut of
%   the source index and the third is the shortcut of the index with the main
%   entry for the entry from first argument. This macro should be used at the
%   preamble of one part of the multi part index only. Because of this, it's
%   defined here only.
%    \begin{macrocode}
      \newcommand*{\CrossIndex}[3]{%
        \Index{##1=\UseIndex{##2}\protect##1>##3=\UseIndex{##2}\SeeSign
          \protect##3}%
      }%
%    \end{macrocode}
% \end{macro}
%    \begin{macrocode}
      \ifx\relax#1\relax\let\index@preamble=\relax
      \else\def\index@preamble{#1}%
      \fi
      \label{idx:#3}%
      \@input@{\jobname-#3.ind}%
    \endgroup
  }
%    \end{macrocode}
% \begin{environment}{theindex}
%   I don't want every part of the index starting a new page. So I'll use the
%   \textsf{multicol} package to generate the two columns instead of
%   |\twocolumn|.
%    \begin{macrocode}
  \renewenvironment{theindex}{%
    \setchapterpreamble{\index@preamble}
    \begin{multicols}{2}[\idx@heading\vspace{-1\baselineskip}][.2\textheight]%
    \parindent\z@
    \setlength{\parskip}{\z@ \@plus .3\p@}%
    \setlength{\parfillskip}{\z@ \@plus 1fil}%
    \let\item\@idxitem
    \small
  }{%
    \end{multicols}%
  }
%    \end{macrocode}
% \end{environment}
% \end{macro}
%
% \begin{macro}{\printindex}
%   Print the full index.
%    \begin{macrocode}
  \renewcommand*{\printindex}{%
    \setchapterpreamble{\index@preamble}%
    \addchap{\indexname}%
    \let\index@preamble=\relax
    \renewcommand*\idx@heading{%
      \addsec{\indexname}%
      \ifx\index@preamble\relax
      \else\index@preamble\let\index@preamble=\relax\fi
    }%
    \printmultiindex{\GuidegenIndex}{gen}%
    \printmultiindex[%
      \CrossIndex{\GuideMacro}{gen}{\GuidecmdIndexShort}%
      \CrossIndex{\GuideEnvironment}{gen}{\GuidecmdIndexShort}%
      \CrossIndex{\GuideCounter}{gen}{\GuidecmdIndexShort}%
      \CrossIndex{\GuideLength}{gen}{\GuidecmdIndexShort}%
    ]{\GuidecmdIndex}{cmd}%
    \printmultiindex[%
      \CrossIndex{\GuideLength}{gen}{\GuidelenIndexShort}%
      \CrossIndex{\GuidePLength}{gen}{\GuidelenIndexShort}%
      \CrossIndex{\GuideCounter}{gen}{\GuidelenIndexShort}%
    ]{\GuidelenIndex}{len}%
    \printmultiindex[%
      \CrossIndex{\GuideFontElement}{gen}{\GuideelmIndexShort}%
    ]{\GuideelmIndex}{elm}%
    \printmultiindex[%
      \CrossIndex{\GuideFile}{gen}{\GuidefilIndexShort}%
      \CrossIndex{\GuidePackage}{gen}{\GuidefilIndexShort}%
      \CrossIndex{\GuideClass}{gen}{\GuidefilIndexShort}%
    ]{\GuidefilIndex}{fil}%
    \printmultiindex[%
      \CrossIndex{\GuideOption}{gen}{\GuideoptIndexShort}%
    ]{\GuideoptIndex}{opt}%
  }
\fi
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\indexsection}
%   Heading of the next section (e.g. the next character) at an index.
%    \begin{macrocode}
\newcommand*{\indexsection}[1]{%
  \ifx\empty#1\empty\else
  \hspace{0pt plus 2fil}{{\usekomafont{disposition} #1}}\hspace{0pt plus
    1fil}\nopagebreak
  \fi
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\indexdelim}
% \begin{macro}{\indexdelimi}
% \begin{macro}{\indexdelimii}
%   The delimiter after the index topic but before the page number. There are
%   three index levels, so there are three delimiters too.
%    \begin{macrocode}
\newcommand*{\indexdelim}{\ \hspace{0pt plus 1fil}\penalty0\null\nobreak
  \dotfill~}
\newcommand*{\indexdelimi}{~\dotfill\penalty0\ }
\newcommand*{\indexdelimii}{~\dotfill\penalty0\ }
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
% \begin{macro}{\UseIndex}
%   This macro does nothing but shows the external index split processor the
%   destination index.
%    \begin{macrocode}
\DeclareRobustCommand*{\UseIndex}[1]{\ignorespaces}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\SeeSign}
%   The symbol used to sign a reference at an index.
%    \begin{macrocode}
\DeclareRobustCommand*{\SeeSign}{\ensuremath{\protect\rightarrow}~}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\AddSeeIndex}
%   Add »\emph{see another index}« entry to an index. First argument is an
%   index entry to the index with shortcut of second argument. The third
%   argument is the name of another index given also by the shortcut at the
%   fourth argument.
%    \begin{macrocode}
\newcommand*{\AddSeeIndex}[4]{%
  \ifusemultiindex
    \Index[seeindex{#4}]{#1=\UseIndex{#2}#1>#3=\UseIndex{#2}\SeeSign#3}%
  \fi
}
%    \end{macrocode}
% \begin{macro}{\seeindex}
%   Page number style of references to another index. This eats the page
%   number of the index entry and set's a page number reference to the label
%   of the other index. Don't use this on your own. This is need by
%   |\AddSeeIndex|.
%    \begin{macrocode}
\newcommand*{\seeindex}[2]{\pageref{idx:#1}}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
% \begin{macro}{\IndexSeeAt}
%   A more general version of |\AddSeeIndex|. First (optional) argument is a
%   entry note (e.g. |\GuidePagestyle|). This is only used if option
%   \texttt{moreindexnotes} was set.  Second argument is the entry. Third is
%   the shortcut of the source index, the index the entry should be set.
%   Fourth is the shortcut of the destination index, the index the entry
%   should reference. Fifth is the name of that index. Sixth is the output
%   command (e.g. |\Macro|) for the entry.
%    \begin{macrocode}
\newcommand*{\IndexSeeAt}[6][\relax]{%
  \ifusemultiindex
    \if@moreindexnotes
      \edef\@tempa{idx@f@\string#1.\string#2.#3.#4}%
    \else
      \edef\@tempa{idx@f@\string#2.#3.#4}%
    \fi
    \expandafter\ifx\csname \@tempa\endcsname\relax
      \expandafter\gdef\csname \@tempa\endcsname{}%
      \begingroup
        \@tempswatrue
        \if@moreindexnotes
          \ifx\relax#1\relax\else\@tempswafalse
            \Index[seeindex{#4}]{%
              #2 (#1)=\UseIndex{#3}#6{#2} (\protect#1)>%
              #5=\UseIndex{#3}\SeeSign\protect#5}%
          \fi
        \fi
        \if@tempswa
          \Index[seeindex{#4}]{%
            #2=\UseIndex{#3}#6{#2}>#5=\UseIndex{#3}\SeeSign\protect#5}%
        \fi
      \endgroup
    \fi
  \fi
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\Index}
%   Primary index command. First (optional) argument is the page number style
%   of the entry. Second argument is the entry. The page number style should
%   be either \texttt{indexother} or \texttt{indexmain}. Default is
%   \texttt{indexother}.
%    \begin{macrocode}
\newcommand*{\Index}[2][indexother]{\index{#2|#1}}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\BeginIndex}
% \begin{macro}{\EndIndex}
%   Its also usefull to define index range entries. These have three
%   arguments. First (optiona) argument is the page number style. Default of
%   this parameter is \texttt{indexmain}. See |\Index| for more information
%   about this parameter. The second parameter is the kind of index
%   entry. This is not the same like the name or shortcut of an index! See
%   |\Define|\dots|Index| for more information about the kind of an index
%   entry. The third argument is the index entry.
%    \begin{macrocode}
\newif\ifnolabel
\def\nolabelfalse{\global\let\ifnolabel\iffalse}%
\def\nolabeltrue{\global\let\ifnolabel\iftrue}%
\newlength\PreserveSkip
\newcommand*{\BeginIndex}[3][indexmain]{%
  \ifvmode\PreserveSkip=\lastskip\else\PreserveSkip=\z@\fi
  \expandafter\ifx\csname Index#2\endcsname\relax
    \GenericError{(scrguide)\@spaces\@spaces\@spaces\@spaces}{%
      Document scrguide Error: \string\BeginIndex\space with unknown
      index%
    }{Check the \string\BeginIndex-command or add a new index type
      ``#2''.}{%
      See scrguide2.tex for more information.}%
  \else
    \csname Index#2\endcsname[(%)
      #1]{#3}%
  \fi
  \ifnolabel\nolabelfalse\else
    \ifx\relax#2\relax\else
        \begingroup
        \def\SplitIndexValue##1~=##2~=##3\@nil{%
          ##1\expandafter\ifx\expandafter\relax##2\relax\else.##2\fi
        }%
        \let\PName\@gobble
        \let\PValue\@firstofone
        \let\ensuremath\@firstofone
        \let\textit\@firstofone
        \def~{\string~}%
        \lowercase{\def\@tempa{#2}}%
        \edef\@tempa{\label@base.\@tempa.\SplitIndexValue#3~=~=\@nil}%
        \pdfstringdef\@tempb{\@tempa}%
        \expandafter\ifx\csname \@tempb\endcsname\relax
          \expandafter\xdef\csname \@tempb\endcsname{\the\inputlineno}%
          \xdef\@currentHref{\@tempb}%
          \ClassInfo{scrguide}{Anchor: `\@currentHref'}%
          \Hy@raisedlink{\hyper@anchorstart{\@currentHref}\hyper@anchorend}%
          \label{desc:\@tempa}%
        \else
          \ClassWarning{scrguide}{%
            Label \@tempa\space already defined at \csname
            \@tempb\endcsname,\MessageBreak
            ignored}%
        \fi
      \endgroup
    \fi
  \fi
  \ifvmode\ifdim \PreserveSkip=\z@\else
      \vskip -\PreserveSkip\vskip\PreserveSkip
  \fi\fi
  \ignorespaces
}
\newcommand*{\EndIndex}[3][indexmain]{%
  \@tempdima\lastskip
  \ifdim \lastskip>\z@
    \vskip -\lastskip
  \fi
  \expandafter\ifx\csname Index#2\endcsname\relax
    \GenericError{(scrguide)\@spaces\@spaces\@spaces\@spaces}{%
      Document scrguide Error: \string\EndIndex\space with unknown
      index%
    }{Check the \string\BeginIndex-command or add a new index type
      ``#2''.}{%
      See scrguide2.tex for more information.}%
  \else
    \csname Index#2\endcsname[%(
      )#1]{#3}%
  \fi
  \ifdim\@tempdima >\z@
    \vskip\@tempdima
  \fi
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
% Now we have to define different kinds of index entries. We have entries that
% will be added to only one index. We have entries that will be added to one
% index with reference to that index at another index. And there are even
% entries that will be added to one index with reference to to that index from
% another index and from the main index.
% \begin{macro}{\DefineSingeIndex}
%   This defines a single index entry, e.g. of commands. A macro will be
%   defined that addes the entry only to one index. First (optional)
%   agrument is a not, which shows the kind of entry (e.g. |\GuideMacro|). The
%   second is the macro postfix (e.g. \texttt{Cmd} would define |\IndexCmd|).
%   The third is the shortcut of the index to bee used
%   (e.g. \texttt{cmd}). The fourth argument is the command to be used to
%   output (format) the index entries (e.g. |\Macro|).
%    \begin{macrocode}
\newcommand*{\DefineSingleIndex}[4][\relax]{%
  \ifx\relax#1\relax
    \expandafter\newcommand\expandafter*%
    \csname Index#2\endcsname[2][indexother]{%
      \Index[##1]{##2=\UseIndex{#3}#4{##2}}%
    }%
  \else
    \expandafter\newcommand\expandafter*%
    \csname Index#2\endcsname[2][indexother]{%
      \Index[##1]{##2 (#1)=\UseIndex{#3}#4{##2} (\protect #1)}%
    }%
  \fi
}
%    \end{macrocode}
% \end{macro}
% \begin{macro}{\DefineDoubleIndex}
%   This defines a double index entry, e.g. of page styles. A macro will be
%   defined that adds the entry to an index and also adds a reference entry to
%   the main index. See |\DefineSingleIndex| for informations about the
%   parameters. If a note was given (first optional argument) it will be used
%   to make a top level entry to the main index with the corresponding
%   subentry.
%    \begin{macrocode}
\newcommand*{\DefineDoubleIndex}[4][\relax]{%
                                % #1 = optional entry note (\GuidePagestyle)
                                % #2 = index macro postfix (Pagestyle)
                                % #3 = see-from-index to be used (cmd)
                                % #4 = output command (\Macro)
  \ifx\relax#1\relax
    \expandafter\newcommand\expandafter*%
    \csname Index#2\endcsname[2][indexother]{%
      \Index[##1]{##2=\UseIndex{gen}#4{##2}}%
      \IndexSeeAt{##2}{#3}{gen}{\GuidegenIndex}{#4}%
    }%
  \else
    \expandafter\newcommand\expandafter*%
    \csname Index#2\endcsname[2][indexother]{%
      \Index[##1]{##2 (#1)=\UseIndex{gen}#4{##2} (\protect #1)}%
      \Index[##1]{\csname Guide#2IndexCategoryExpanded\endcsname=\UseIndex{gen}\expandafter\protect\csname Guide#2IndexCategory\endcsname>##2=\UseIndex{gen}#4{##2}}%
      \IndexSeeAt[#1]{##2}{#3}{gen}{\GuidegenIndex}{#4}%
    }%
  \fi
}
%    \end{macrocode}
% \end{macro}
% \begin{macro}{\DefineTripleIndex}
%   This defines a triple index entry, e.g. of lengths. A macro will be
%   defined that adds the entry to an index and also adds a reference entry to
%   another index and the main index. The first (optional) argument is a note
%   (e.g. (|\GuideLength|) that will be used to generate a top level index
%   entry to the main index. The second argument is the macro postfix
%   (e.g. \texttt{Length} to define |\IndexLength|). The third argument is the
%   shortcut of the primary index (e.g. \texttt{len}). The fourth argument is
%   the short name of that index (e.g. |\GuidelenIndexShort|). The fifth
%   argument is the shortcut of the index to put the reference into
%   (e.g. \texttt{cmd}). The sixth argument is the output command of the index
%   entry (e.g. |\Length|).
%    \begin{macrocode}
\newcommand*{\DefineTripleIndex}[6][\relax]{%
                                % #1 = optional entry note (\GuideLength)
                                % #2 = index macro postfix (Length)
                                % #3 = index to be used (len)
                                % #4 = index name (\GuidelenIndexShort)
                                % #5 = also-from-index to be used (cmd)
                                % #6 = output command (\Macro)
  \ifx\relax#1\relax
    \expandafter\newcommand\expandafter*%
    \csname Index#2\endcsname[2][indexother]{%
      \IndexSeeAt{##2}{gen}{#3}{#4}{#6}%
      \IndexSeeAt{##2}{#5}{#3}{#4}{#6}%
      \Index[##1]{##2=\UseIndex{#3}#6{##2}}%
      \IndexSeeAt{##2}{#3}{gen}{\GuidegenIndex}{#4}%
    }%
  \else
    \expandafter\newcommand\expandafter*%
    \csname Index#2\endcsname[2][indexother]{%
%      \IndexSeeAt[#1]{##2}{gen}{#3}{#4}{#6}%
%      \Index[##1]{#1=\UseIndex{gen}\protect#1>##2=\UseIndex{gen}#6{##2}}%
      \IndexSeeAt[#1]{##2}{#5}{#3}{#4}{#6}%
      \Index[##1]{##2 (#1)=\UseIndex{#3}#6{##2} (\protect #1)}%
    }%
  \fi
}
%    \end{macrocode}
% \end{macro}
%
% After this, let's define all used kinds of index entries:
%    \begin{macrocode}
\DefineSingleIndex{Cmd}{cmd}{\Macro}
\DefineDoubleIndex[\GuidePagestyle]{Pagestyle}{cmd}{\PValue}
\DefineDoubleIndex[\GuideFloatstyle]{Floatstyle}{cmd}{\PValue}
\DefineTripleIndex[\GuideCounter]{Counter}
  {len}{\GuidelenIndexShort}{cmd}{\Counter}
\DefineTripleIndex[\GuideLength]{Length}
  {len}{\GuidelenIndexShort}{cmd}{\Length}
\ifusemultiindex
  \DefineSingleIndex[\GuideEnvironment]{Env}{cmd}{\Environment}
  \DefineSingleIndex{Option}{opt}{\Option}
  \DefineSingleIndex[\GuidePackage]{Package}{fil}{\Package}
  \DefineSingleIndex[\GuideClass]{Class}{fil}{\Class}
  \DefineSingleIndex{File}{fil}{\File}
  \DefineSingleIndex[\GuideVariable]{Variable}{cmd}{\Variable}
  \DefineSingleIndex{FontElement}{elm}{\FontElement}
  \DefineSingleIndex{PLength}{len}{\PLength}
\else
  \DefineDoubleIndex[\GuideEnvironment]{Env}{cmd}{\Environment}
  \DefineDoubleIndex{Option}{opt}{\Option}
  \DefineDoubleIndex[\GuidePackage]{Package}{fil}{\Package}
  \DefineDoubleIndex[\GuideClass]{Class}{fil}{\Class}
  \DefineDoubleIndex{File}{fil}{\File}
  \DefineDoubleIndex[\GuideVariable]{Variable}{cmd}{\Variable}
  \DefineDoubleIndex{FontElement}{elm}{\FontElement}
  \DefineDoubleIndex{PLength}{len}{\PLength}
\fi
%    \end{macrocode}
%
% \begin{macro}{\indexrm}
% \begin{macro}{\indexother}
% \begin{macro}{\indexit}
% \begin{macro}{\indexbf}
% \begin{macro}{\indexmain}
% \begin{macro}{\indexsl}
% \begin{macro}{\indexsf}
% \begin{macro}{\indexsc}
%   Some helpers to get page numbers with different fontification but hyper
%   links.
%    \begin{macrocode}
\newcommand*{\indexrm}[1]{\textrm{\hyperpage{#1}}}
\newcommand*{\indexother}{}\let\indexother\indexrm
\newcommand*{\indexit}[1]{\textit{\hyperpage{#1}}}
\newcommand*{\indexbf}[1]{\textbf{\hyperpage{#1}}}
\newcommand*{\indexmain}{}\let\indexmain\indexbf
\newcommand*{\indexsl}[1]{\textsl{\hyperpage{#1}}}
\newcommand*{\indexsf}[1]{\textsf{\hyperpage{#1}}}
\newcommand*{\indexsc}[1]{\textsc{\hyperpage{#1}}}
%    \end{macrocode}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
%
%
\endinput
%
%%% Local Variables: 
%%% mode: doctex
%%% TeX-master: "test.tex"
%%% End: 
