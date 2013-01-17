%%
%% This is file `achemso.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% achemso.dtx  (with options: `class')
%% ----------------------------------------------------------------
%% achemso --- Support for submissions to American Chemical Society
%%   journals
%% E-mail: joseph.wright@morningstar2.co.uk
%% Released under the LaTeX Project Public License v1.3c or later
%% See http://www.latex-project.org/lppl.txt
%% ----------------------------------------------------------------
%% 
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{achemso}
  [2012/05/08 v3.7a Submission to ACS journals]
\LoadClass[12pt,letter]{article}
\newcommand*\acs@warning{\ClassWarning{achemso}}
\newcommand*\acs@ifundefined[1]{%
  \begingroup\expandafter\expandafter\expandafter\endgroup
  \expandafter\ifx\csname #1\endcsname\relax
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
}
\RequirePackage{xkeyval}
\newcommand*\acs@keyval@bool[2]{%
  \acs@ifundefined{acs@#1#2}{%
    \acs@warning{Unknown option `#2' for key #1}%
  }{%
    \@nameuse{acs@#1#2}%
  }%
}
\newif\ifacs@abbreviations
\newif\ifacs@articletitle
\newif\ifacs@biochem
\newif\ifacs@chaptertitle
\newif\ifacs@email
\newif\ifacs@hyperref
\newif\ifacs@keywords
\newif\ifacs@super
\define@key{acs}{abbreviations}[true]{%
  \acs@keyval@bool{abbreviations}{#1}%
}
\define@key{acs}{articletitle}[true]{%
  \acs@keyval@bool{articletitle}{#1}%
}
\define@key{acs}{biochem}[true]{%
  \acs@keyval@bool{biochem}{#1}%
}
\define@key{acs}{chaptertitle}[true]{%
  \acs@keyval@bool{chaptertitle}{#1}%
}
\define@key{acs}{email}[true]{%
  \acs@keyval@bool{email}{#1}%
}
\define@key{acs}{hyperref}[true]{%
  \acs@keyval@bool{hyperref}{#1}%
}
\define@key{acs}{keywords}[true]{%
  \acs@keyval@bool{keywords}{#1}%
}
\define@key{acs}{super}[true]{%
  \acs@keyval@bool{super}{#1}%
}
\define@key{acs}{usetitle}[true]{%
  \acs@keyval@bool{articletitle}{#1}%
}
\newcommand*\acs@journal{jacsat}
\newcommand*\acs@layout{traditional}
\newcommand*\acs@manuscript{article}
\newcommand*\acs@maxauthors{15}
\define@key{acs}{journal}{%
  \def\acs@journal{#1}%
}
\define@key{acs}{layout}{%
  \def\acs@layout{#1}%
}
\define@key{acs}{manuscript}{%
  \def\acs@manuscript{#1}%
}
\define@key{acs}{maxauthors}{%
  \def\acs@maxauthors{#1}%
}
\newif\ifacs@etal@truncate
\define@key{acs}{etalmode}{%
  \acs@ifundefined{acs@etal@#1}{%
    \acs@warning{%
      Unknown value `#1' for\MessageBreak  etalmode option%
    }%
  }{%
    \AtEndOfClass{\@nameuse{acs@etal@#1}}%
  }%
}
\newcommand*\acs@etal@firstonly{\acs@etal@truncatefalse}
\newcommand*\acs@etal@truncate{\acs@etal@truncatetrue}
\define@key{acs}{biochemistry}{%
  \setkeys{acs}{biochem = #1}%
}
\define@key{acs}{biblabel}{%
  \acs@ifundefined{acs@biblabel@#1}{%
    \acs@warning{%
      Unknown value `#1' for\MessageBreak biblabel option%
    }%
  }{%
    \acs@activate@biblabel{\@nameuse{acs@biblabel@#1}}%
  }%
}
\newcommand*\acs@activate@biblabel{}
\let\acs@activate@biblabel\AtEndOfClass
\AtEndOfClass{\let\acs@activate@biblabel\@firstofone}
\newcommand*\acs@biblabel@brackets{\def\bibnumfmt##1{(##1)}}
\newcommand*\acs@biblabel@fullstop{\def\bibnumfmt##1{##1.}}
\newcommand*\acs@biblabel@period{\def\bibnumfmt##1{##1.}}
\newcommand*\acs@biblabel@plain{\def\bibnumfmt##1{##1}}
\setkeys{acs}{
  email = true,
  super = true
}
\ProcessOptionsX*<acs>
\newcommand*\acs@manuscript@communication{communication}
\newcommand*\acs@manuscript@letter{letter}
\newcommand*\acs@manuscript@note{note}
\newcommand*\acs@manuscript@review{review}
\newcommand*\acs@manuscript@suppinfo{suppinfo}
\newcommand*\acs@niib@create{%
  \@namedef{ver@notes2bib.sty}{%
    2009/04/20 v1.6a Integrating notes into the bibliography (achemso
    version)
  }%
  \@ifundefined{c@bibnote}{\newcounter{bibnote}}{}
  \def\thebibnote{%
    Note-\the\value{bibnote}%
  }%
  \DeclareRobustCommand*{\bibnote}[1][\thebibnote]{%
    \stepcounter{bibnote}%
    \def\acs@niib@after@text{\cite{##1}}%
    \acs@niib@text{##1}%
  }%
  \DeclareRobustCommand*{\bibnotemark}[1][\thebibnote]{%
    \stepcounter{bibnote}%
    \cite{##1}%
  }%
  \DeclareRobustCommand*{\bibnotetext}[1][\thebibnote]{%
    \let\acs@niib@after@text\relax
    \acs@niib@text{##1}%
  }%
  \newcommand*\printbibnotes{%
    \ifnum\the\value{bibnote}>\z@\relax
      \nocite{achemso-control}%
      \acs@bibliography{acs-\jobname}%
    \fi
  }%
}
\newcommand*\acs@niib@after@text{}
\newcommand*\acs@niib@text{%
  \@bsphack
  \if@filesw
    \expandafter\acs@niib@write
  \else
    \expandafter\acs@niib@no@write
  \fi
}
\newcommand*\acs@niib@write[1]{%
  \begingroup
    \let\do\@makeother
    \dospecials
    \catcode`\{ 1\relax
    \catcode`\} 2\relax
    \acs@niib@write@aux@i{#1}%
}
\newcommand*\acs@niib@write@aux@i[1]{%
  \long\def\@tempa##1{%
      \def\@tempa{##1}%
      \@onelevel@sanitize\@tempa
    \expandafter\endgroup
    \expandafter\def\expandafter\@tempa\expandafter{\@tempa}%
    \acs@niib@write@aux@ii{#1}%
  }%
  \catcode`\^^M 10\relax
  \@tempa
}
\newcommand*\acs@niib@write@aux@ii[1]{%
  \immediate\write\acs@bib@file{%
    @Misc\string{#1,^^J%
    \space\space note = \string{\@tempa\string},^^J%
    \string}^^J%
  }%
  \@esphack
  \acs@niib@after@text
}
\newcommand\acs@niib@no@write[2]{%
  \@esphack
  \acs@niib@after@text
}
\AtBeginDocument{
  \def\nmv@natbib@detect{%
    \ifNAT@super
      \expandafter\acs@nmv@activate
    \else
      \expandafter\acs@autonote
    \fi
  }
}
\newcommand*\acs@nmv@activate{%
  \let\nmv@citex@nat\@citex
  \let\@citex\nmv@citex
  \let\nmv@cite\cite
  \renewcommand*{\cite}[2][]{%
    \nmv@ifmtarg{##1}{%
      \nmv@citetrue
      \nmv@cite{##2}%
    }{%
      \nocite{##2}%
      \bibnote{Ref.~\citenum{##2}, ##1}%
    }%
  }%
}
\newcommand*\acs@autonote{%
  \let\nmv@cite\cite
  \renewcommand*{\cite}[2][]{%
    \nmv@ifmtarg{##1}{%
      \nmv@cite{##2}%
    }{%
      \nocite{##2}%
      \bibnote{Ref.~\citenum{##2}, ##1}%
    }%
  }%
}
\newwrite\acs@bib@file
\newcommand*\acs@bib@message{%
  This is an auxiliary file used by the `achemso' bundle.^^J%
  This file may safely be deleted. It will be recreated as required.^^J
}
\newcommand*\acs@bib@name{acs-\jobname.bib}
\newcommand*\acs@bib@write{%
  \if@filesw
    \expandafter\acs@bib@write@aux
  \fi
}
\AtBeginDocument{\acs@bib@write}
\newcommand*\acs@bib@write@aux{%
  \immediate\openout\acs@bib@file\acs@bib@name\relax
  \immediate\write\acs@bib@file{\acs@bib@message}%
  \edef\@tempa##1##2{%
    \space\space##1\space = "##2",^^J%
  }%
  \immediate\write\acs@bib@file{%
    @Control\string{%
      achemso-control,^^J%
      \@tempa{ctrl-article-title\space}{%
        \ifacs@articletitle yes\else no\fi
      }%
      \@tempa{ctrl-chapter-title\space}{%
        \ifacs@chaptertitle yes\else no\fi
      }%
      \@tempa{ctrl-etal-number\space\space\space}{\acs@maxauthors}%
      \@tempa{ctrl-etal-firstonly}{%
        \ifacs@etal@truncate no\else yes\fi
      }%
    \string}^^J%
  }%
  \immediate\write\@auxout{%
    \string\citation\string{achemso-control\string}%
  }%
  \AtEndDocument{%
    \immediate\closeout\acs@bib@file\relax
  }%
}
\IfFileExists{mciteplus.sty}{%
  \RequirePackage{mciteplus}
  \def\@mciteSubRef[##1]##2{\plainref{\@mcitereflabelprefix:##1:##2}}
}{}
\AtBeginDocument{%
  \let\acs@bibliography\bibliography
  \def\bibliography#1{%
    \acs@bibliography{acs-\jobname,#1}%
  }%
}
\setkeys{acs}{
  abbreviations = false,
  articletitle  = false,
  biblabel      = brackets,
  biochem       = false,
  etalmode      = firstonly,
  keywords      = false,
  maxauthors    = 15,
  super         = true
}
\acs@niib@create
\RequirePackage[T1]{fontenc}
\RequirePackage[margin=2.54cm]{geometry}
\RequirePackage[scaled=0.90]{helvet}
\RequirePackage{
  caption,
  courier,
  float,
  graphicx,
  mathptmx,
  setspace,
  url
}
\ifacs@hyperref
  \expandafter\RequirePackage
\else
  \expandafter\@gobble
\fi
  {hyperref}
\AtBeginDocument{\doublespacing}
\renewcommand*{\title}[2][]{%
  \gdef\acs@title@short{#1}%
  \gdef\@title{#2}%
  \ifx\acs@title@short\@empty
    \global\let\acs@title@short\@title
  \fi
}
\@onlypreamble\title
\newcount\acs@author@cnt
\newcount\acs@affil@cnt
\newcount\acs@affil@alt@cnt
\newcount\acs@footnote@cnt
\newcount\acs@affil@marker@cnt
\def\author#1{%
  \global\advance\acs@author@cnt\@ne\relax
  \expandafter\gdef\csname @author@\@roman\acs@author@cnt\endcsname{#1}%
  \begingroup
    \advance\acs@affil@cnt\@ne
    \expandafter\xdef\csname @author@affil@\@roman
      \acs@author@cnt\endcsname
      {\the\acs@affil@cnt}%
  \endgroup
}
\@onlypreamble\author
\def\and{%
  \acs@warning{%
    \string\and\space not used by the achemso class: please see
    the\MessageBreak package documentation for details%
  }%
}
\def\thanks{%
  \acs@warning{%
    \string\thanks\space not used by the achemso class: please see
    the\MessageBreak the package documentation for details%
  }%
}
\newcommand*\affiliation[2][\relax]{%
  \ifnum\acs@author@cnt>\z@\relax
    \acs@affil@ifdup{#2}{%
      \acs@affil@swap{#2}%
    }{%
      \global\advance\acs@affil@cnt\@ne\relax
      \expandafter\gdef\csname @address@\@roman\acs@affil@cnt\endcsname
        {#2}%
      \ifx\relax#1\relax
        \expandafter\gdef\csname @affil@\@roman\acs@affil@cnt\endcsname
          {#2}%
      \else
        \expandafter\gdef\csname @affil@\@roman\acs@affil@cnt\endcsname
          {#1}%
      \fi
    }%
  \else
    \acs@warning{Affiliation with no author}%
  \fi
}
\@onlypreamble\affiliation
\newcommand*\acs@affil@ifdup[1]{%
  \begingroup
    \def\@tempa{#1}%
    \@tempswafalse
    \@tempcnta\z@\relax
    \acs@affil@ifdup@aux
    \if@tempswa
      \aftergroup\@firstoftwo
    \else
      \aftergroup\@secondoftwo
    \fi
  \endgroup
}
\newcommand*\acs@affil@ifdup@aux{%
  \advance\@tempcnta\@ne\relax
  \expandafter\expandafter\expandafter\def\expandafter\expandafter
    \expandafter\@tempb\expandafter\expandafter\expandafter
    {\csname @address@\@roman\@tempcnta\endcsname}%
  \ifx\@tempa\@tempb
    \expandafter\@tempswatrue
  \else
    \ifnum\@tempcnta<\acs@affil@cnt\relax
      \expandafter\expandafter\expandafter\acs@affil@ifdup@aux
    \fi
  \fi
}
\newcommand*\acs@affil@swap[1]{%
  \begingroup
    \def\@tempa{#1}%
    \@tempcnta\z@\relax
    \@tempcntb\z@\relax
    \acs@affil@ifdup@aux
    \advance\acs@affil@cnt\@ne\relax
    \acs@affil@swap@aux
  \endgroup
}
\newcommand*\acs@affil@swap@aux{%
  \advance\@tempcntb\@ne\relax
  \expandafter\ifnum\csname @author@affil@\@roman\@tempcntb\endcsname
    = \acs@affil@cnt\relax
    \expandafter\xdef\csname @author@affil@\@roman\@tempcntb\endcsname{%
      \the\@tempcnta
    }%
  \fi
  \ifnum\@tempcntb<\acs@author@cnt\relax
    \expandafter\acs@affil@swap@aux
  \fi
}
\newcommand*\alsoaffiliation[2][\relax]{%
  \ifnum\acs@author@cnt>\z@\relax
    \acs@affil@ifdup{#2}{%
      \acs@alsoaffil@find{#2}%
    }{%
      \global\advance\acs@affil@cnt\@ne\relax
      \@tempcnta\acs@affil@cnt\relax
      \expandafter\gdef\csname @address@\@roman\acs@affil@cnt\endcsname
        {#2}%
      \ifx\relax#1\relax
        \expandafter\gdef\csname @affil@\@roman\acs@affil@cnt\endcsname
          {#2}%
      \else
        \expandafter\gdef\csname @affil@\@roman\acs@affil@cnt\endcsname
          {#1}%
      \fi
    }%
    \@ifundefined{@author@alsoaffil@\@roman\acs@author@cnt}{%
      \expandafter\xdef\csname @author@alsoaffil@\@roman\acs@author@cnt
        \endcsname{\the\@tempcnta}%
    }{%
      \expandafter\xdef\csname @author@alsoaffil@\@roman\acs@author@cnt
        \endcsname{%
        \csname @author@alsoaffil@\@roman\acs@author@cnt\endcsname
        ,\the\@tempcnta
      }%
    }%
  \else
    \acs@warning{Affiliation with no author}%
  \fi
}
\newcommand*\acs@alsoaffil@find[1]{%
  \begingroup
    \def\@tempa{#1}%
    \@tempcnta\z@\relax
    \@tempcntb\z@\relax
    \acs@affil@ifdup@aux
  \expandafter\endgroup
  \expandafter\@tempcnta\the\@tempcnta\relax
}
\newcommand*\altaffiliation[1]{%
  \ifnum\acs@author@cnt>\z@\relax
    \begingroup
      \acs@altaffil@ifdup{#1}{%
        \expandafter\xdef\csname @author@altaffil@\@roman\acs@author@cnt
          \endcsname{\the\@tempcnta}%
      }{%
        \global\advance\acs@affil@alt@cnt\@ne\relax
        \expandafter\gdef\csname @altaffil@\@roman\acs@affil@alt@cnt
          \endcsname{#1}%
        \expandafter\xdef\csname @author@altaffil@\@roman\acs@author@cnt
          \endcsname{\the\acs@affil@alt@cnt}%
      }%
    \endgroup
  \else
    \acs@warning{Affiliation with no author}%
  \fi
}
\@onlypreamble\altaffiliation
\newcommand*\acs@altaffil@ifdup[1]{%
  \def\@tempa{#1}%
  \@tempswafalse
  \@tempcnta\z@\relax
  \ifnum\acs@affil@alt@cnt>\z@\relax
    \expandafter\acs@altaffil@ifdup@aux
  \fi
  \if@tempswa
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
}
\newcommand*\acs@altaffil@ifdup@aux{%
  \advance\@tempcnta\@ne\relax
  \expandafter\expandafter\expandafter\def\expandafter\expandafter
    \expandafter\@tempb\expandafter\expandafter\expandafter
    {\csname @altaffil@\@roman\@tempcnta\endcsname}%
  \ifx\@tempa\@tempb
    \expandafter\@tempswatrue
  \else
    \ifnum\@tempcnta<\acs@affil@alt@cnt\relax
      \expandafter\expandafter\expandafter\acs@altaffil@ifdup@aux
    \fi
  \fi
}
\newcommand*\email[1]{%
  \ifnum\acs@author@cnt>\z@\relax
    \expandafter\gdef\csname @email@\@roman\acs@author@cnt\endcsname
      {#1}%
  \else
    \acs@warning{E-mail with no author}%
  \fi
}
\@onlypreamble\email
\newcommand*\fax[1]{%
  \ifnum\acs@author@cnt>\z@\relax
    \expandafter\gdef\csname @fax@\@roman\acs@author@cnt\endcsname
      {#1}%
  \else
    \acs@warning{Fax number with no author}%
  \fi
}
\@onlypreamble\fax
\newcommand*\phone[1]{%
  \ifnum\acs@author@cnt>\z@\relax
    \expandafter\gdef\csname @phone@\@roman\acs@author@cnt\endcsname
      {#1}%
  \else
    \acs@warning{Phone number with no author}%
  \fi
}
\@onlypreamble\phone
\newcommand*\abbreviations[1]{%
  \gdef\@abbreviations{#1}%
}
\newcommand*\@abbreviations{}
\@onlypreamble\abbreviations
\newcommand*\keywords[1]{%
  \gdef\@keywords{#1}%
}
\newcommand*\@keywords{}
\@onlypreamble\keywords
\newcommand*\acs@abbreviations@print{%
  \ifx\@abbreviations\@empty\else
    ABBREVIATIONS: \@abbreviations
    \par
  \fi
}
\newcommand*\acs@keywords@print{%
  \ifx\@keywords\@empty\else
    KEYWORDS: \@keywords
    \par
  \fi
}
\newcommand*\acs@title@short@print{%
  RUNNING HEADER: \acs@title@short
}
\newlength\acs@space@pre@title
\setlength\acs@space@pre@title{2em}
\newlength\acs@space@post@title
\setlength\acs@space@post@title{1.5em}
\newlength\acs@space@post@author
\setlength\acs@space@post@author{1em}
\newlength\acs@space@post@address
\setlength\acs@space@post@address{1em}
\newlength\acs@space@post@email
\setlength\acs@space@post@email{1.5em}
\newlength\acs@maketitle@width
\setlength\acs@maketitle@width{\textwidth}
\newcommand*\affilsize{\normalsize}
\newcommand*\authorsize{\large}
\newcommand*\emailsize{\normalsize}
\newcommand*\titlesize{\LARGE}
\newcommand*\affilfont{\itshape}
\newcommand*\authorfont{\sffamily}
\newcommand*\emailfont{}
\newcommand*\titlefont{\bfseries\sffamily}
\newcommand*{\ps@acs}{}
\let\ps@acs\ps@plain
\def\@maketitle{%
  \pagestyle{acs}%
  \ifnum\acs@author@cnt<\z@\relax
    \acs@warning{No authors defined: At least one author is required}%
  \fi
  \newpage
  \null
  \vspace*{\acs@space@pre@title}%
  \begin{center}
    \begin{minipage}{\acs@maketitle@width}
      \begin{center}
        {%
          \titlefont
          \titlesize
          \let\@fnsymbol\acs@author@fnsymbol
          \let\footnote\acs@title@footnote
          \acs@maketitle@suppinfo \@title
          \acs@title@footnote@check
          \global\acs@footnote@cnt\c@footnote\relax
          \@maketitle@title@hook
          \par
        }%
        \vspace*{\acs@space@post@title}%
        {%
          \authorsize
          \authorfont
          \frenchspacing
          \acs@author@list
          \par
        }%
        \vspace*{\acs@space@post@author}%
        {%
          \affilsize
          \affilfont
          \acs@address@list
          \par
        }%
        \vspace*{\acs@space@post@address}%
        {%
          \emailsize
          \emailfont
          \ifacs@email
            \expandafter\acs@contact@details
          \fi
        }%
        \vspace*{\acs@space@post@email}%
      \end{center}
    \end{minipage}
  \end{center}%
}
\newcommand*\@maketitle@title@hook{}
\newcommand*\acs@maketitle@suppinfo{%
  \ifx\acs@manuscript\acs@manuscript@suppinfo
    Supporting information for:\\
  \fi
}
\newcommand*\acs@title@footnote[1]{%
  \footnotemark
  \g@addto@macro\@thanks@hook{%
    \footnotetext{#1}%
  }%
}
\newcommand\acs@title@footnote@check{%
  \ifx\@thanks@hook\@empty\else
    \expandafter\gdef\expandafter\@thanks@hook\expandafter{%
      \expandafter\begingroup
        \expandafter\let\expandafter\@fnsymbol\expandafter
          \acs@author@fnsymbol
        \@thanks@hook
      \endgroup
    }%
  \fi
}
\newcommand*\acs@contact@details{%
  { \sffamily E-mail: \acs@email@list }%
  \acs@number@list
}
\def\@thanks{%
  \@thanks@hook
  \ifnum\acs@affil@cnt>\@ne\relax
    \expandafter\acs@affil@list
  \else
    \ifnum\acs@affil@alt@cnt>\z@\relax
      \expandafter\expandafter\expandafter\acs@affil@list
    \fi
  \fi
}
\newcommand*\@thanks@hook{}
\newcommand*\acs@author@list{%
  \@tempcnta\z@\relax
  \ifnum\acs@author@cnt=\z@\relax\else
    \expandafter\acs@author@list@main
  \fi
  \acs@author@list@star
}
\newcommand*\acs@author@list@star{%
  \g@addto@macro\@thanks@hook{%
      \setcounter{footnote}{1}%
    \footnotetext{To whom correspondence should be addressed}%
  }%
}
\newcommand*\acs@author@footnotes{}
\newcommand*\acs@author@list@main{%
  \advance\@tempcnta\@ne\relax
  \def\acs@author@footnotes{}%
  \acs@author@list@and
  \space
  \@nameuse{@author@\@roman\@tempcnta}%
  \acs@author@list@comma
  \acs@author@star
  \acs@author@affil
  \acs@author@affil@also
  \acs@author@affil@alt
  \ifx\@empty\acs@author@footnotes\else
    \textsuperscript{\acs@author@footnotes}%
  \fi
  \ifnum\@tempcnta<\acs@author@cnt\relax
    \expandafter\acs@author@list@main
  \fi
}
\newcommand*\acs@author@list@and{%
  \ifnum\acs@author@cnt=\@ne\relax\else
    \ifnum\@tempcnta=\acs@author@cnt\relax
      \space and%
    \fi
  \fi
}
\newcommand*\acs@author@list@comma{%
  \ifnum\acs@author@cnt>\tw@\relax
    \ifnum\@tempcnta<\acs@author@cnt\relax
      ,%
    \fi
  \fi
}
\newcommand*\acs@author@star{%
  \acs@ifundefined{@email@\@roman\@tempcnta}{}{%
    \acs@author@star@aux
  }%
}
\newcommand*\acs@author@star@aux{%
  \protected@edef\acs@author@footnotes{%
    \acs@author@fnsymbol{\z@}%
    \ifnum\acs@affil@cnt>\@ne\relax
      ,%
    \else
      \ifnum\acs@affil@alt@cnt>\z@\relax
        ,%
      \fi
    \fi
  }%
}
\newcommand*\acs@author@affil{%
  \acs@ifundefined{%
    @affil@\@roman\csname @author@affil@\@roman\@tempcnta\endcsname
  }{%
    \acs@warning{%
      No affiliation given for author\MessageBreak
      \@nameuse{@author@\@roman\@tempcnta}%
    }%
  }{%
    \acs@author@affil@aux
  }%
}
\newcommand*\acs@author@affil@aux{%
  \ifnum\acs@affil@cnt>\@ne\relax
    \expandafter\acs@affil@marker@cnt\csname @author@affil@\@roman
      \@tempcnta\endcsname\relax
    \advance\acs@affil@marker@cnt\acs@footnote@cnt\relax
    \protected@edef\acs@author@footnotes{%
      \acs@author@footnotes
      \acs@author@fnsymbol{\acs@affil@marker@cnt}%
    }%
  \else
    \ifnum\acs@affil@alt@cnt>\z@\relax
      \acs@affil@marker@cnt\@ne\relax
      \advance\acs@affil@marker@cnt\acs@footnote@cnt\relax
      \protected@edef\acs@author@footnotes{%
        \acs@author@footnotes
        \acs@author@fnsymbol{\acs@affil@marker@cnt}%
      }%
    \fi
  \fi
}
\newcommand*\acs@author@affil@also{%
  \acs@ifundefined{@author@alsoaffil@\@roman\@tempcnta}{}{%
    \acs@author@affil@also@aux
  }%
}
\newcommand*\acs@author@affil@also@aux{%
  \expandafter\@for\expandafter\@tempa\expandafter:\expandafter
    =\csname @author@alsoaffil@\@roman\@tempcnta\endcsname\do{%
    \acs@affil@marker@cnt\@tempa\relax
    \advance\acs@affil@marker@cnt\acs@footnote@cnt\relax
    \protected@edef\acs@author@footnotes{%
      \acs@author@footnotes
      ,%
      \acs@author@fnsymbol{\acs@affil@marker@cnt}%
    }%
  }%
}
\newcommand*\acs@author@affil@alt{%
  \acs@ifundefined{@author@altaffil@\@roman\@tempcnta}{}{%
    \acs@author@affil@alt@aux
  }%
}
\newcommand*\acs@author@affil@alt@aux{%
  \expandafter\acs@affil@marker@cnt
    \csname @author@altaffil@\@roman\@tempcnta\endcsname\relax
  \advance\acs@affil@marker@cnt\acs@affil@cnt\relax
  \advance\acs@affil@marker@cnt\acs@footnote@cnt\relax
  \protected@edef\acs@author@footnotes{%
    \acs@author@footnotes
    ,%
    \acs@author@fnsymbol{\acs@affil@marker@cnt}%
  }%
}
\newcommand*\acs@author@fnsymbol[1]{%
  \ensuremath{%
    \ifcase #1 *\or
      \dagger\or
        \ddagger\or
          \P\or
            \S\or
              \|\or
                \bot\or
                  \#\or
                    @\or
                      \triangle\or
                        \nabla\else
                          #1%
    \fi
  }%
}
\newcommand*\acs@address@list{%
  \@tempcnta\z@\relax
  \ifnum\acs@affil@cnt>\z@\relax
    \acs@address@list@aux
  \else
    \acs@warning{%
      No affiliations: at least one affiliation is needed%
    }%
  \fi
}
\newcommand*\acs@address@list@aux{%
  \advance\@tempcnta\@ne\relax
  \ifnum\acs@affil@cnt>\@ne\relax
    \ifnum\@tempcnta=\acs@affil@cnt\relax
      and
    \fi
  \fi
  \@nameuse{@address@\@roman\@tempcnta}%
  \ifnum\@tempcnta<\acs@affil@cnt\relax
    ,
    \expandafter\acs@address@list@aux
  \fi
}
\newcommand*\acs@fnsymbol@org{}
\newcommand*\acs@affil@list{%
  \let\acs@fnsymbol@org\@fnsymbol
  \let\@fnsymbol\acs@author@fnsymbol
  \@tempcnta\z@\relax
  \@tempcntb\z@\relax
  \ifnum\acs@affil@cnt>\@ne\relax
    \expandafter\acs@affil@list@aux
  \else
    \ifnum\acs@affil@alt@cnt>\z@\relax
      \acs@affil@marker@cnt\@ne\relax
      \advance\acs@affil@marker@cnt\acs@footnote@cnt\relax
      \footnotetext[\acs@affil@marker@cnt]{\@affil@i}%
      \@tempcnta\@ne\relax
    \fi
  \fi
  \ifnum\acs@affil@alt@cnt>\z@\relax
    \expandafter\acs@affil@alt@list
  \fi
  \let\@fnsymbol\acs@fnsymbol@org
}
\newcommand*\acs@affil@list@aux{%
  \advance\@tempcnta\@ne\relax
  \acs@affil@marker@cnt\@tempcnta\relax
  \advance\acs@affil@marker@cnt\acs@footnote@cnt\relax
  \footnotetext[\acs@affil@marker@cnt]{%
    \@nameuse{@affil@\@roman\@tempcnta}%
  }%
  \ifnum\@tempcnta<\acs@affil@cnt\relax
    \expandafter\acs@affil@list@aux
  \fi
}
\newcommand*\acs@affil@alt@list{%
  \advance\@tempcntb\@ne\relax
  \acs@ifundefined{@altaffil@\@roman\@tempcntb}{}{%
    \acs@altaffil@foot@aux
  }
  \ifnum\@tempcntb<\acs@author@cnt\relax
    \expandafter\acs@affil@alt@list
  \fi
}
\newcommand*\acs@altaffil@foot@aux{%
  \advance\@tempcnta\@ne\relax
  \acs@affil@marker@cnt\@tempcnta\relax
  \advance\acs@affil@marker@cnt\acs@footnote@cnt\relax
  \footnotetext[\acs@affil@marker@cnt]{%
    \@nameuse{@altaffil@\@roman\@tempcntb}%
  }%
}
\newcommand*\acs@email@list@font{\sf}
\newcommand*\acs@email@list{%
  \begingroup
    \def\UrlFont{\acs@email@list@font}%
    \@tempcnta\z@\relax
    \@tempcntb\z@\relax
    \acs@email@list@aux
    \ifnum\@tempcntb=\z@\relax
      \acs@warning{%
        No e-mail given:\MessageBreak
        at lest one author must have a contact e-mail%
      }%
    \fi
  \endgroup
}
\newcommand*\acs@email@list@aux{%
  \advance\@tempcnta\@ne\relax
  \ifnum\@tempcnta>\acs@author@cnt\relax\else
    \acs@ifundefined{@email@\@roman\@tempcnta}{}{%
      \advance\@tempcntb\@ne\relax
      \ifnum\@tempcntb>\@ne\relax
        ;
      \fi
      \expandafter\expandafter\expandafter\url\expandafter
        \expandafter\expandafter{%
           \csname @email@\@roman\@tempcnta\endcsname
      }%
    }%
    \expandafter\acs@email@list@aux
  \fi
}
\newcommand*\acs@number@list{%
  \begingroup
    \acs@number@list@aux@i{phone}%
    \let\@tempb\@tempa
    \acs@number@list@aux@i{fax}%
    \ifx\@tempa\@empty\else
      \ifx\@tempb\@empty\else
        \protected@edef\@tempa{%
          \@tempb.\space\@tempa
        }%
      \fi
    \fi
    \ifx\@tempa\@empty\else
      \par
      \@tempa
    \fi
  \endgroup
}
\newcommand*\acs@number@list@aux@i[1]{%
  \def\@tempa{}%
  \@tempcnta\z@\relax
  \def\acs@number@list@aux@ii{%
    \advance\@tempcnta\@ne\relax
    \ifnum\@tempcnta>\acs@author@cnt\relax\else
      \acs@ifundefined{@#1@\@roman\@tempcnta}{}{%
        \acs@ifundefined{@email@\@roman\@tempcnta}{}{%
          \ifx\@tempa\@empty
            \edef\@tempa{%
              \@nameuse{@#1@\@roman\@tempcnta}%
            }%
          \else
            \edef\@tempa{%
              \@tempa
              ;
              \@nameuse{@#1@\@roman\@tempcnta}%
            }%
          \fi
        }%
      }%
      \expandafter\acs@number@list@aux@ii
    \fi
  }%
  \acs@number@list@aux@ii
  \ifx\@tempa\@empty\else
    \protected@edef\@tempa{%
      \MakeUppercase#1: \@tempa
    }%
  \fi
}
\newcommand*\acs@number@list@aux@ii{}
\newcommand*\acs@maketitle@extras{%
  \acs@maketitle@extras@hook
  \ifacs@abbreviations
    \acs@abbreviations@print
    \par
  \fi
  \ifacs@keywords
    \acs@keywords@print
    \par
  \fi
}
\newcommand*\acs@maketitle@extras@hook{}
\g@addto@macro{\maketitle}{\acs@maketitle@extras}
\g@addto@macro{\document}{\maketitle}
\newfloat{scheme}{htbp}{los}
\floatname{scheme}{Scheme}
\newfloat{chart}{htbp}{loc}
\floatname{chart}{Chart}
\newfloat{graph}{htbp}{loh}
\floatname{graph}{Graph}
\newcommand*\schemename{Scheme}
\newcommand*\chartname{Chart}
\newcommand*\graphname{Graph}
\floatplacement{table}{htbp}
\floatplacement{figure}{htbp}
\floatstyle{plaintop}
\restylefloat{table}
\let\acs@floatboxreset\@floatboxreset
\def\@floatboxreset{%
  \centering
  \acs@floatboxreset
}
\newcommand*\plainref{}
\AtBeginDocument{\let\plainref\ref}
\newcommand*\acs@section{}
\let\acs@section\section
\newcommand*\acs@subsection{}
\let\acs@subsection\subsection
\newcommand*\acs@subsubsection{}
\let\acs@subsubsection\subsubsection
\newcommand*\acs@startsection{}
\let\acs@startsection\@startsection
\newcommand*\acs@startsection@alt[6]{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim\@tempskipa<\z@\relax
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty
    \addvspace\@tempskipa
  \fi
  \@ifstar{%
    \@ssect{#3}{#4}{#5}{#6}%
  }{%
    \@ssect{#3}{#4}{#5}{#6}%
  }%
}
\newcommand*\acs@sections@none{%
  \@ifstar{%
    \acs@sections@none@aux
  }{%
    \acs@sections@none@aux
  }%
}
\newcommand*\acs@sections@none@aux[2][]{%
  \acs@warning{%
    (Sub)section `#2' ignored%
  }%
}
\newcommand*\SectionNumbersOff{%
  \let\@startsection\acs@startsection@alt
}
\@onlypreamble\SectionNumbersOff
\newcommand*\SectionNumbersOn{%
  \let\@startsection\acs@startsection
}
\@onlypreamble\SectionNumbersOn
\newcommand*\SectionsOff{%
  \let\section\acs@sections@none
  \let\subsection\acs@sections@none
  \let\subsubsection\acs@sections@none
}
\@onlypreamble\SectionsOff
\newcommand*\SectionsOn{%
  \let\section\acs@section
  \let\subsection\acs@subsection
  \let\subsubsection\acs@subsubsection
}
\@onlypreamble\SectionsOn
\newenvironment{acknowledgement}{%
  \acs@subsection*{\acknowledgementname}%
}{}
\newenvironment{suppinfo}{%
  \acs@subsection*{\suppinfoname}%
  \acs@collect\acs@suppinfo@print
}{}
\newcommand\acs@suppinfo@print[1]{%
  #1
  This material is available free of charge via the Internet at
  \url{http://pubs.acs.org/}.
}
\newcommand*\acknowledgementname{Acknowledgement}
\AtEndOfClass{%
  \def\bibsection{%
    \acs@subsection*{\refname}%
  }%
}
\newcommand*\suppinfoname{Supporting Information Available}
\newcommand*\acs@abstract{}
\let\acs@abstract\abstract
\newcommand*\acs@endabstract{}
\let\acs@endabstract\endabstract
\begingroup
  \catcode`{ \active
  \catcode`} 12\relax
  \catcode`( 1\relax
  \catcode`) 2\relax
  \gdef\acs@abstract@start(%
    \acs@warning(%
      Abstract not allowed for this\MessageBreak
       manuscript type
    )%
    \@bsphack
    \catcode`{ \active
    \catcode`} 12\relax
    \let\end\fi
    \let{\acs@abstract@end% }
    \iffalse
  )%{
  \gdef\acs@abstract@end#1}(%
    \def\@tempa(#1)%
    \ifx\@tempa\@currenvir
      \@Esphack\endgroup
      \if@ignore
        \global\@ignorefalse
        \ignorespaces
      \fi
    \else
       \expandafter\acs@abstract@iffalse
    \fi
  )
\endgroup
\newcommand*\acs@iffalse{\iffalse}
\newcommand*\AbstractOff{%
  \let\abstract\acs@abstract@start
  \let\endabstract\acs@abstract@end
}
\@onlypreamble\AbstractOff
\newcommand*\AbstractOn{%
  \let\abstract\acs@abstract
  \let\endabstract\acs@endabstract
}
\@onlypreamble\AbstractOn
\newtoks\acs@collect@toks
\newtoks\acs@collect@empty@toks
\newcommand*\acs@collect@begins{}
\newcommand*\acs@collect@content{}
\newcommand\acs@collect[1]{%
  \acs@collect@toks{%
    \expandafter#1\expandafter{\the\acs@collect@toks}%
  }%
  \edef\acs@collect@content{%
    \the\acs@collect@toks
    \noexpand\end{\@currenvir}%
  }%
  \acs@collect@toks\acs@collect@empty@toks
  \def\acs@collect@begins{b}%
  \begingroup
    \expandafter\let\csname\@currenvir\endcsname\acs@collect@aux
    \edef\acs@collect@content{%
      \expandafter\noexpand\csname\@currenvir\endcsname
    }%
    \acs@collect@content
}
\newcommand*\acs@collect@aux{}
\long\def\acs@collect@aux#1\end#2{%
  \edef\acs@collect@begins{%
    \acs@collect@begins@#1\begin\end
    \expandafter\@gobble\acs@collect@begins
  }%
  \ifx\@empty\acs@collect@begins
    \endgroup
    \@checkend{#2}%
    \acs@collect@body{#1}%
  \else
    \acs@collect@body{#1\end{#2}}%
  \fi
  \acs@collect@content
}
\newcommand*\acs@collect@begins@{}
\long\def\acs@collect@begins@#1\begin#2{%
  \ifx\end#2\else
    b\expandafter\acs@collect@begins@
  \fi
}
\newcommand\acs@collect@body[1]{%
  \global\acs@collect@toks\expandafter{\the\acs@collect@toks#1}%
}
\newcommand\acs@abstract@print[1]{%
  \global\long\def\acs@abstract@text{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse\newpage
    \fi
    \acs@section*{Abstract}%
    #1%
    \if@restonecol
      \twocolumn
    \else
      \newpage
    \fi
  }%
  \AtEndDocument{\acs@abstract@text}%
}
\newcommand\acs@tocentry@print[1]{%
  \global\long\def\acs@tocentry@text
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \acs@section*{\tocentryname}%
      \tocsize
      \sffamily
      \singlespacing
      \begin{center}
        \fbox
          {%
            \begin{minipage}{\acs@tocentry@height}
              \vbox to \acs@tocentry@width{#1}%
            \end{minipage}%
          }%
      \end{center}%
      \if@restonecol
        \twocolumn
      \else
        \newpage
      \fi
    }%
  \AtEndDocument{\acs@tocentry@text}%
}
\newlength{\acs@tocentry@height}
\newlength{\acs@tocentry@width}
\setlength{\acs@tocentry@height}{9 cm}
\setlength{\acs@tocentry@width}{3.5 cm}
\newenvironment{tocentry}{\acs@collect\acs@tocentry@print}{}
\newcommand*\tocentryname{Graphical TOC Entry}
\newcommand*\tocsize{%
  \@setfontsize\tocsize\@viiipt\@ixpt
}
\newcommand*\acs@type@list{article,communication,suppinfo}
\newcommand*\acs@type@default{article}
\newcommand*\acs@type@check{%
  \@tempswafalse
  \@for\@tempa:=\acs@type@list\do{%
    \ifx\@tempa\acs@manuscript
      \expandafter\@tempswatrue
    \fi
  }%
  \if@tempswa\else
    \acs@warning{%
      Invalid manuscript type \acs@manuscript:\MessageBreak
      changed to default type \acs@type@default
    }%
    \let\acs@manuscript\acs@type@default
  \fi
}
\def\refname{%
  \ifnum\the\value{bibnote}>\z@\relax
    Notes and
  \fi
  References%
}
\newcommand*\acs@setkeys{\setkeys{acs}}
\let\acs@killabstract\AbstractOff
\let\acs@killsecs\SectionsOff
\newcommand*\acs@validtype[2][article]{%
  \def\acs@type@default{#1}%
  \def\acs@type@list{#2}%
}
\newcommand*\acs@par{}
\let\acs@par\par
\newcommand*\acs@layout@shared{%
  \AtBeginDocument{\singlespacing}%
  \twocolumn
  \tolerance=2000\relax
  \emergencystretch=10pt\relax
  \geometry{
    letterpaper,
    top    = 12.7mm,
    bottom = 16.8mm,
    left   = 19.3mm,
    right  = 19.3mm
  }%
  \setlength{\columnsep}{8.1mm}%
  \setlength{\parindent}{3.3mm}%
  \renewenvironment{acknowledgement}{%
    \def\@tempa{acknowledgement}%
    \ifx\@currenvir\@tempa
      \let\par\relax
      \acksize
      \vspace{6pt}%
      \textbf{\acknowledgementname}%
    \else
      \acs@subsection*{\acknowledgementname}%
    \fi
  }{%
    \acs@par
  }%
  \renewenvironment{suppinfo}{%
    \def\@tempa{suppinfo}%
    \ifx\@currenvir\@tempa
      \expandafter\acs@suppinfo@aux
    \else
      \acs@subsection*{\suppinfoname}%
    \fi
  }{%
    \acs@par
  }%
}
\newcommand*\acs@suppinfo@aux{%
  \let\par\relax
  \suppsize
  \vspace{6pt}%
  \textbf{\suppinfoname:}
  \acs@collect\acs@suppinfo@print
}
\newcommand*\acksize{\normalsize}
\newcommand*\suppsize{\normalsize}
\newcommand*\acs@layout@nine{%
  \def\@xipt{11}%
  \long\def\normalsize{%
    \@setfontsize\normalsize\@ixpt\@xipt
  }%
  \normalsize
  \let\@listi\@listI
  \abovedisplayskip 5\p@ \@plus2\p@ \@minus 5\p@\relax
  \abovedisplayshortskip \z@ \@plus3\p@\relax
  \belowdisplayshortskip 3\p@ \@plus3\p@ \@minus 3\p@\relax
  \belowdisplayskip\abovedisplayskip\relax
  \abovecaptionskip 5\p@\relax
  \intextsep 7\p@ \@plus 2\p@ \@minus 2\p@\relax
}
\newcommand*\acs@layout@ten{%
  \long\def\normalsize{%
    \@setfontsize\normalsize\@xpt\@xiipt
  }%
  \normalsize
  \@setfontsize\normalsize\@xpt\@xiipt
  \let\@listi\@listI
  \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@\relax
  \abovedisplayshortskip \z@ \@plus3\p@\relax
  \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@\relax
  \belowdisplayskip \abovedisplayskip\relax
}
\InputIfFileExists{\acs@journal.cfg}{}{%
  \acs@warning{%
    Unknown journal `\acs@journal':\MessageBreak
    using default configuration JACSAT%
  }%
  \input{jacsat.cfg}%
}
\acs@type@check
\ifx\acs@manuscript\acs@manuscript@note
  \SectionsOff
\fi
\ifx\acs@manuscript\acs@manuscript@review
  \SectionsOn
  \SectionNumbersOn
\fi
\ifx\acs@manuscript\acs@manuscript@suppinfo
  \setkeys{acs}{maxauthors = 0}
  \def\thepage{S\arabic{page}}
  \renewcommand*\thefigure{S\@arabic\c@figure}
  \renewcommand*\thescheme{S\@arabic\c@scheme}
  \renewcommand*\thetable{S\@arabic\c@table}
  \AtBeginDocument
    {%
      \renewcommand*\citenumfont[1]{S#1}%
      \renewcommand*\bibnumfmt[1]{(S#1)}%
    }
\fi
\begingroup
  \def\@tempa{twocolumn}
  \ifx\acs@layout\@tempa
    \aftergroup\acs@layout@shared
  \fi
  \def\@tempa{two-column}
  \ifx\acs@layout\@tempa
    \aftergroup\acs@layout@shared
  \fi
\endgroup
\ifacs@super
  \RequirePackage[sort&compress,numbers,super]{natbib}
\else
  \RequirePackage[sort&compress,numbers,round]{natbib}
  \def\citenumfont{\textit}
\fi
\RequirePackage{natmove}
\newcommand*\acs@bibstyle{achemso}
\ifacs@biochem
  \def\acs@bibstyle{biochem}
  \bibliographystyle{biochem}
\else
  \bibliographystyle{achemso}
\fi
\newcommand*\acs@bibliographystyle{}
\let\acs@bibliographystyle\bibliographystyle
\def\bibliographystyle#1{%
  \acs@warning{\string\bibliographystyle\space ignored}%
  \expandafter\acs@bibliographystyle\expandafter{\acs@bibstyle}%
}
%% 
%% Originally developed by Mats Dahlgren
%% Copyright (C) 1996-1998 by Mats Dahlgren
%% Copyright (C) 2008-2011 by
%%   Joseph Wright <joseph.wright@morningstar2.co.uk>
%% 
%% Part of this bundle is derived from cite.sty, to which the
%% following license applies:
%%   Copyright (C) 1989-2009 by Donald Arseneau
%%   These macros may be freely transmitted, reproduced, or
%%   modified provided that this notice is left intact.
%% 
%% It may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License (LPPL), either version 1.3c of
%% this license or (at your option) any later version.  The latest
%% version of this license is in the file:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status) by
%%   Joseph Wright.
%% 
%% This work consists of the file  achemso.dtx
%%           and the derived files achemso.cls,
%%                                 achemso.ins,
%%                                 achemso.pdf,
%%                                 achemso.sty,
%%                                 achemso-demo.bib,
%%                                 achemso-demo.tex,
%%                                 natmove.sty and
%%                                 a number of configuration files.
%% 
%%
%% End of file `achemso.cls'.
