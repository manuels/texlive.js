%%
%% This is file `hcart.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% hc.dtx  (with options: `class,hcart')
%% 
%% Copyright (C) 1998--2000 Christian Siefkes <error@cs.tu-berlin.de>
%%
%% Updates are available via http://tal.cs.tu-berlin.de/error/TeX/
%%
%% This file is part of the HC Bundle for LaTeX2e.
%% -----------------------------------------------
%%
%% This file is free software; you can redistribute it and/or modify
%% it under the terms of the GNU Library General Public License as
%% published by the Free Software Foundation; either version 2 of the
%% License, or (at your option) any later version.
%%
%% This document is distributed in the hope that it will be useful, but
%% WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%% General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; see the file COPYING. If not, write to
%% the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
%% Boston, MA 02111-1307, USA.
%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{hcart}%
              [2000/03/23 v1.07 LaTeX2e HC Bundle]
\newcommand{\thisclass}{hcart}
\newcommand{\superclass}{scrartcl}
\newif\if@german
\@germanfalse
\newif\if@deflang
\@deflangtrue
\DeclareOption{german}{\@deflangfalse\@germantrue
  \PassOptionsToPackage{ngerman}{babel}
  \PassOptionsToPackage{german}{fancyref}
  \AtEndOfClass{\input{german.hld}}}
\DeclareOption{english}{\@deflangfalse
  \PassOptionsToPackage{\CurrentOption}{babel}}
\newif\if@defpaper
\@defpapertrue
\DeclareOption{a4paper}{
\PassOptionsToClass{\CurrentOption}{\superclass}
\PassOptionsToPackage{\CurrentOption}{hyperref}
\@defpaperfalse}
\DeclareOption{letterpaper}{
\PassOptionsToClass{\CurrentOption}{\superclass}
\PassOptionsToPackage{\CurrentOption}{hyperref}
\@defpaperfalse}
\newif\if@palatino
\@palatinotrue
\DeclareOption{palatino}{\@palatinotrue}
\DeclareOption{nopalatino}{\@palatinofalse}
\newif\if@ding
\@dingfalse
\DeclareOption{ding}{\@dingtrue}
\newif\if@euro
\@eurotrue
\DeclareOption{euro}{\@eurotrue}
\DeclareOption{noeuro}{\@eurofalse}
\newif\if@fancyref
\@fancyreftrue
\DeclareOption{fancyref}{\@fancyreftrue}
\DeclareOption{nofancyref}{\@fancyreffalse}
\newif\if@html
\@htmltrue
\DeclareOption{html}{\@htmltrue}
\DeclareOption{nohtml}{\@htmlfalse}
\newif\if@defhsl
\@defhsltrue
\DeclareOption{headsepline}{\PassOptionsToClass
{\CurrentOption}{\superclass}\@defhslfalse}
\DeclareOption{headnosepline}{\PassOptionsToClass
{\CurrentOption}{\superclass}\@defhslfalse}
\DeclareOption{onecolumn}{\PassOptionsToClass
{\CurrentOption}{\superclass}}
\DeclareOption{twocolumn}{\PassOptionsToClass
{\CurrentOption}{\superclass}}
\newif\if@hcarea
\@hcareatrue
\DeclareOption{hcarea}{\@hcareatrue}
\DeclareOption{hcnoarea}{\@hcareafalse}
\newif\if@hcfootnotes
\@hcfootnotestrue
\DeclareOption{hcfootnotes}{\@hcfootnotestrue}
\DeclareOption{hcnofootnotes}{\@hcfootnotesfalse}
\newif\if@magazine
\@magazinefalse
\DeclareOption{magazine}{\@magazinetrue\@htmltrue}
\newif\if@parskip
\@parskipfalse
\DeclareOption{parskip}{\@parskiptrue}
\newif\if@wide
\@widefalse
\DeclareOption{wide}{\@widetrue}
\newif\if@defsize
\@defsizetrue
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{\superclass}
\@defsizefalse}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{\superclass}
\@defsizefalse}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{\superclass}
\@defsizefalse}
\newif\if@bib
\@bibfalse
\DeclareOption{bib}{\@bibtrue}
\DeclareOption{nobib}{\@bibfalse}
\newif\if@fnbib
\@fnbibtrue
\newif\if@autbib
\@autbibfalse
\newif\if@numbib
\@numbibfalse
\DeclareOption{fnbib}{\@fnbibtrue\@autbibfalse\@numbibfalse\@bibtrue}
\DeclareOption{autbib}{\@fnbibfalse\@autbibtrue\@numbibfalse\@bibtrue}
\DeclareOption{numbib}{\@fnbibfalse\@autbibfalse\@numbibtrue\@bibtrue}
\newif\if@htmlbib
\@htmlbibtrue
\DeclareOption{htmlbib}{\@htmlbibtrue\@htmltrue}
\DeclareOption{nohtmlbib}{\@htmlbibfalse}
\newif\if@paper
\@paperfalse
\DeclareOption{paper}{\@papertrue\@bibtrue\@htmltrue}
\newif\if@pdf
\ifx\pdfoutput\undefined
  \@pdffalse
\else
  \@pdftrue
\fi
\DeclareOption{pdf}{\@pdftrue}
\DeclareOption{nopdf}{\@pdffalse}
\DeclareOption*{\ClassWarning{\thisclass}%
   {Unknown Option: `\CurrentOption '}%
}
\newcommand{\defaulttitle}{}
\newcommand{\defaultauthor}{}
\newcommand{\defaultaddress}{}
\newcommand{\defaultemail}{}
\newcommand{\defaulthomepage}{}
\newcommand{\currenttitle}{\defaulttitle}
\newcommand{\currentauthor}{\defaultauthor}
\newcommand{\autdiv}{\\[-0.4ex]\normalfont\Large}
\newcommand{\autinfodiv}{\\[-1ex]\normalfont\normalsize}
\ProcessOptions\relax
\if@defhsl
  \PassOptionsToClass{headsepline}{\superclass}
\fi
\PassOptionsToClass{twoside,pointlessnumbers,liststotoc,
  bibtotoc,idxtotoc}{\superclass}
\if@defsize
  \PassOptionsToClass{12pt}{\superclass}
\fi
\if@deflang
  \PassOptionsToPackage{english}{babel}
\fi
\if@defpaper
  \PassOptionsToClass{a4paper}{\superclass}
  \PassOptionsToPackage{a4paper}{hyperref}
\fi
\LoadClass{\superclass}
\sloppy
\clubpenalty9999
\@clubpenalty\clubpenalty
\widowpenalty9999
\displaywidowpenalty1000
\brokenpenalty1000
\frenchspacing
\RequirePackage{natbib}
\RequirePackage[T1]{fontenc}
\RequirePackage[latin1]{inputenc}
\RequirePackage{ifthen}
\RequirePackage{babel}
\RequirePackage{xspace}
\InputIfFileExists{hc.cfg}{%
  \ClassInfo{\thisclass}
    {Loading configuration file hc.cfg}}{%
  \ClassInfo{\thisclass}
    {Configuration file hc.cfg not found}}
\InputIfFileExists{\thisclass.cfg}{%
  \ClassInfo{\thisclass}
    {Loading configuration file \thisclass.cfg}}{%
  \ClassInfo{\thisclass}
    {Configuration file \thisclass.cfg not found}}
\newcommand{\nextstartq}{`}
\newcommand{\nextendq}{'}
\newcommand{\otherstartq}{``}
\newcommand{\otherendq}{''}
\newcommand{\tmpq}{}
\newcommand{\q}[1]{\nextstartq{}%
  \let\tmpq\nextstartq%
  \let\nextstartq\otherstartq%
  \let\otherstartq\tmpq%
  \let\tmpq\nextendq%
  \let\nextendq\otherendq%
  \let\otherendq\tmpq%
  #1%
  \let\tmpq\nextstartq%
  \let\nextstartq\otherstartq%
  \let\otherstartq\tmpq%
  \let\tmpq\nextendq%
  \let\nextendq\otherendq%
  \let\otherendq\tmpq%
  \nextendq{}%
}
\newcommand{\hq}[1]{``#1''}
\newcommand{\fq}[1]{`#1'}
\newcommand{\dash}[1]{---#1---}
\newenvironment{flexlist}[2][:]
    {\begin{list}{}
      {\settowidth{\labelwidth}{\sffamily\bfseries #2#1 }
       \setlength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \renewcommand{\makelabel}[1]
         {\sffamily\bfseries ##1#1 \hfill}}}
    {\end{list}}
\newenvironment{widedesc}[1][:]
  {\begin{flexlist}[#1]{00.00.0000}}
  {\end{flexlist}}
\newcommand{\pcent}[1]{#1\,\%}
\newcommand{\qdots}{\mbox{[\dots]}\xspace}
\newcommand{\phyp}[1]
  {(#1\textormath{\leavevmode\hbox{-}}{-})\hskip\z@skip}
\newcommand{\arrow}{\ensuremath{\rightarrow}\xspace}
\newcommand{\f}{\,f}
\newcommand{\ff}{\,ff}
\newcommand{\distance}{\par\bigskip\noindent}
\newcommand{\stardistance}
  {\par\bigskip{\centering *~~~*~~~*\par}\bigskip\noindent}
\newcommand{\linedistance}{%
  \begin{center}
  \begin{tabular}{p{0.33\textwidth}}
  \hrule
  \end{tabular}
  \end{center}
  \medskip\noindent%
}
\newcommand{\sig}[1]{\par{\raggedleft\emph{#1}\par}}
\newcommand{\intro}[1]{{\par\centering\textbf{#1}\par}
  \medskip\noindent\ignorespaces}
\newcommand{\hint}[1]{{\par\centering\LARGE #1\par}
  \noindent\ignorespaces}
\newcommand{\cen}[1]
  {{\par\centering #1\par}\noindent\ignorespaces}
\newcommand{\marginbox}[1]%
  {\par\small\addvspace{4.5ex plus 1ex}%
   \vskip -\parskip
   \noindent\hspace{-.75\leftmargini}%
   \begin{tabular}{|l|}\hline\ignorespaces
   #1
   \\\hline\end{tabular}\nobreak\par\nobreak
   \vspace{2.3ex}\vskip -\parskip\noindent\ignorespaces}
\newcommand{\rightaddress}[1]{%
  \par\medskip
  {\raggedleft \begin{tabular}{l}\ignorespaces
  #1
  \end{tabular}
  \medskip\par}\noindent\ignorespaces%
}
\newcounter{shortyear}
\setcounter{shortyear}{\the\year}
\addtocounter{shortyear}{-1900}
\whiledo{\theshortyear>99}{\addtocounter{shortyear}{-100}}
\newcommand{\shorttoday}
  {\two@digits{\theshortyear}/\the\month/\the\day\xspace}
\newenvironment{dialog}
  {\begin{flexlist}[\normalfont\emph{:}]{i}
     \setlength{\itemsep}{0ex}}
  {\end{flexlist}}
\makeatletter
\newcommand{\newspeaker}[2]{\newcommand{#1}[2][]
  {\item[\normalfont\emph{#2\ifthenelse{\equal{##1}{}}
     {}{ (##1)}}] ##2}}
\newcommand{\enge}[2]{#1}
\newcommand{\versiontext}{Version date:}
\newcommand{\onlinetext}{Online:}
\newcommand{\accesstext}{Access date:}
\newcommand{\cftext}{cf.}
\newcommand{\bibvoltext}{of}
\newcommand{\bvtext}{vol.}
\newcommand{\bibdir}{Director }
\newcommand{\bibmovtext}{Movie}
\newcommand{\bibactorsbefore}{With}
\newcommand{\bibactorsafter}{et~al}
\newcommand{\noyear}{n.d.}
\newcommand{\noaddress}{n.p.}
\newcommand{\otherabstractname}{Zusammenfassung}
\newcommand{\keywordsname}{Keywords}
\if@palatino
  \RequirePackage{palatino}
  \RequirePackage{mathpple}
\fi
\if@ding
   \RequirePackage{pifont}
   \newcommand{\tick}{\ding{52}}
   \newcommand{\cross}{\ding{56}}
   \newcommand{\checkbox}{\ding{114}}
   \newenvironment{ticklist}
    {\begin{dinglist}{52}}{\end{dinglist}}
   \newenvironment{crosslist}
    {\begin{dinglist}{56}}{\end{dinglist}}
   \newenvironment{checklist}
    {\begin{dinglist}{114}}{\end{dinglist}}
\fi
\if@euro
   \RequirePackage[right,notextcomp]{eurofont}
   \newcommand{\E}{\textsf{\makefakelighteuro}\xspace}
   \newcommand{\Es}[1]{\E\nobreak\,#1}
\fi
\if@fancyref
  \RequirePackage{fancyref}
\fi
\newcommand{\seetext}{see}
\newcommand{\see}[1]{\footnote{\seetext\ \fref{#1}}}
\if@html
  \RequirePackage{html}
  \if@paper
    \newcommand{\htlink}[2]
      {\htmladdnormallink{#1}{#2}%
       \footnote{\htmladdnormallink{\texttt{#2}}{#2}}}
  \else
    \newcommand{\htlink}[2]
      {{\htmladdnormallink{#1 \texttt{<#2>}}{#2}}}
  \fi
  \newcommand{\hturl}[1]
    {{\htmladdnormallink{\texttt{#1}}{#1}}}
  \newcommand{\htmail}[1]
    {{\htmladdnormallink{\texttt{#1}}{mailto:#1}}}
\fi
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\RequirePackage[breakwords]{truncate}
\newlength{\rightmarklength}
\def\ps@headings{\let\@mkboth\markboth
  \def\@evenhead{\vbox{\hsize=\textwidth
    \hb@xt@ \textwidth{%
    {\pnumfont\thepage\hfil\headfont\truncate{0.92\textwidth}%
      {\raggedleft\strut\leftmark}}}%
    \if@hsl \vskip 1.5\p@ \hrule \fi}}
  \def\@oddhead{\settowidth{\rightmarklength}{\rightmark}%
   \vbox{\hsize=\textwidth
    \hb@xt@ \textwidth{{\headfont\truncate{0.92\textwidth}%
      {\strut\ifthenelse{\lengthtest{\rightmarklength=0em}}%
       {\leftmark{}}{\rightmark{}}%
       \hfil}\hfil\pnumfont\thepage}}%
    \if@hsl \vskip 1.5\p@ \hrule \fi}}
  \def\@evenfoot{\vbox{\hsize=\textwidth
    \if@fsl \hrule \vskip 3\p@ \fi
    \hb@xt@ \textwidth{{\pnumfont\hfil}}}}%
  \def\@oddfoot{\vbox{\hsize=\textwidth
    \if@fsl \hrule \vskip 3\p@ \fi
    \hb@xt@ \textwidth{{\pnumfont\hfil}}}}%
  \def\sectionmark##1{%
   \markboth {\ifnum \c@secnumdepth >\z@%
    \sectionmarkformat\fi ##1}{}}
  \def\subsectionmark##1{%
   \markright {\ifnum \c@secnumdepth >\@ne%
    \subsectionmarkformat\fi ##1}}}
\pagestyle{headings}
\if@hcarea
  \RequirePackage{typearea}
  \areaset[15mm]{150mm}{240mm}
\fi
\if@hcfootnotes
  \deffootnote{1em}{0.5em}
    {\textsuperscript{\normalfont\thefootnotemark}\,}
\fi
\if@magazine
  \RequirePackage{multicol}
  \newcommand{\articletitle}[1]
    {\addsec[#1]{\LARGE #1}}
  \newcommand{\subjecttitle}[2]
    {\addsec[#2]{{\large #1}\\{\LARGE #2}}}
  \newcommand{\titlesubject}[2]
    {\addsec[#1]{{\LARGE #1}\\{\large #2}}}
  \newcommand{\articlesection}[1]{\subsection*{#1}}
  \newcommand{\currentsig}{}
  \newenvironment{@art}[2][]{%
    \begin{multicols}{2}[#2]
    \renewcommand{\currentsig}{#1}%
  }{%
    \ifthenelse{\equal{\currentsig}{}}
      {}
      {\sig{\currentsig}}
    \end{multicols}%
  }
  \newenvironment{art}[2][]
    {\begin{@art}[#1]{\articletitle{#2}}}{\end{@art}}
  \newenvironment{artsubtit}[3][]
    {\begin{@art}[#1]{\subjecttitle{#2}{#3}}}{\end{@art}}
  \newenvironment{arttitsub}[3][]
    {\begin{@art}[#1]{\titlesubject{#2}{#3}}}{\end{@art}}
\fi
\if@parskip
  \setlength\parskip{\medskipamount}
  \setlength\parindent{0pt}
\fi
\if@wide
  \linespread{1.3}
\fi
\newcommand{\bibliostyle}{hc-en}
\if@bib
\if@fnbib
  \bibpunct[, ]{}{}{;}{a}{}{,}
  \renewcommand\NAT@cite%
    [3]{\footnote{\ifNAT@swa\NAT@@open\if*#2*\else#2\ \fi
        #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close\else#1\fi}\endgroup}
  \let\@cite\NAT@cite
\fi
\if@autbib
  \bibpunct[, ]{ [}{]}{;}{a}{}{,}
  \let\cite\citep
\fi
\if@numbib
   \bibpunct[, ]{ [}{]}{;}{n}{}{,}
\fi
\newcommand{\cfcite}[2][]{\cite[\cftext][#1]{#2}}
\if@paper
  \newcommand{\beforebiblio}{\newpage}
\else
  \newcommand{\beforebiblio}{\vfill}
\fi
\newcommand{\biblio}[2][\bibliostyle]{%
  \beforebiblio
  \bibliographystyle{#1}
  \bibliography{#2}%
}
\newcommand{\qu}[3][]{\q{#3}\cite[#1]{#2}}
\newcommand{\qul}[3][]{\begin{quote}
  \qu[#1]{#2}{#3}
  \end{quote}}
  \if@htmlbib
    \newcommand{\biburl}[2]{\onlinetext\\
     {\small\hturl{#1}}\\\accesstext\ #2}
  \else
    \newcommand{\biburl}[2]{\onlinetext\\
     {\small\texttt{#1}}\\\accesstext\ #2}
  \fi
   \newcommand{\bibdiv}{. }
   \newcommand{\bibvol}[3][\bibvoltext]
     {\emph{, \bvtext~#2 #1} #3}
   \newcommand{\addrdiv}{ -- }
\newcommand{\etal}[1][]{ et~al%
  \ifthenelse{\equal{#1}{}}{}{. #1}%
}
  \newcommand{\bibmov}[3]{\bibmovtext\bibdiv\ #2, #1\bibdiv\
    \bibactorsbefore\ #3 \bibactorsafter}
\fi
\newcommand{\hypertitle}{}
\newcommand{\hyperauthor}{}
\newcommand{\hyperabstract}{}
\newcommand{\hyperkeywords}{}
\if@pdf
  \AtEndOfClass{\RequirePackage[hyperindex,colorlinks=true,
     pdftex,latex2html,extension=pdf]{hyperref}}
  \AtBeginDocument{%
    \let\oldautdiv\autdiv
    \renewcommand{\autdiv}{, }
    \ifthenelse{\equal{\hypertitle}{}}
       {\renewcommand{\hypertitle}{\currenttitle}}{}
    \ifthenelse{\equal{\hyperauthor}{}}
       {\renewcommand{\hyperauthor}{\currentauthor}}{}
    \ifthenelse{\equal{\hyperabstract}{}}
       {\renewcommand{\hyperabstract}{\abstext}}{}
    \ifthenelse{\equal{\hyperkeywords}{}}
       {\renewcommand{\hyperkeywords}{\keywordstext}}{}
    \pdfinfo{
       /Title (\hypertitle)
       /Author (\hyperauthor)
       /Subject (\hyperabstract)
       /Keywords (\hyperkeywords)
      }
      \let\autdiv\oldautdiv
  }
\fi
\if@paper
  \newcommand{\@toc}{%
    \newpage
    \thispagestyle{empty}
    \if@wide \linespread{1} \fi
    \tableofcontents
    \if@wide \linespread{1.3} \fi
    \newpage%
  }
  \newcommand{\toc}{}
\else
  \newcommand{\@toc}{%
    \vfill
    \thispagestyle{empty}
    \if@wide \linespread{1} \fi
    \tableofcontents
    \if@wide \linespread{1.3} \fi
    \newpage%
  }
  \newcommand{\toc}{\@toc}
\fi
\if@paper
  \newcommand{\titsubinfo}[3]{
    \renewcommand{\defaulttitle}{%
      #1\vfill
      {\Large #2\vfill}
      \vfill {\normalsize #3\vfill}%
    }
    \renewcommand{\currenttitle}{#1}%
  }
  \newcommand{\titsub}[2]{
    \renewcommand{\defaulttitle}{%
      #1\vfill
      {\Large #2\vfill\vfill}%
    }
    \renewcommand{\currenttitle}{#1}%
  }
  \newcommand{\titinfo}[2]{
    \renewcommand{\defaulttitle}{%
      #1\vfill
      \vfill {\normalsize #2\vfill}%
    }
    \renewcommand{\currenttitle}{#1}%
  }
\else
  \newcommand{\titsubinfo}[3]{
    \renewcommand{\defaulttitle}{#1\\[0.8ex]
      {\Large #2\\[0.8ex]}
      {\normalsize #3\\}%
    }
    \renewcommand{\currenttitle}{#1}%
  }
  \newcommand{\titsub}[2]{
    \renewcommand{\defaulttitle}{#1\\[0.8ex]
      {\Large #2\\[0.8ex]}%
    }
    \renewcommand{\currenttitle}{#1}%
  }
  \newcommand{\titinfo}[2]{
    \renewcommand{\defaulttitle}{#1\\[0.8ex]
      {\normalsize #2\\}%
    }
    \renewcommand{\currenttitle}{#1}%
  }
\fi
\newcommand{\autinfo}[4]{%
  \renewcommand{\defaultauthor}{#1}
  \renewcommand{\defaultaddress}{#2}
  \renewcommand{\defaultemail}{#3}
  \renewcommand{\defaulthomepage}{#4}
  \renewcommand{\currentauthor}{#1}
}
\newcommand{\abstext}{}
\newcommand{\otherabstext}{}
\newcommand{\abs}[2][]{%
  \renewcommand{\otherabstext}{#1}
  \renewcommand{\abstext}{#2}
}
\newcommand{\keywordstext}{}
\newcommand{\keywords}[1]{%
  \renewcommand{\keywordstext}{#1}
}
\if@pdf
  \newcommand{\hyperinfo}[4]{
    \renewcommand{\hypertitle}{#1}
    \renewcommand{\hyperauthor}{#2}
    \renewcommand{\hyperabstract}{#3}
    \renewcommand{\hyperkeywords}{#4}
  }
\else
  \newcommand{\hyperinfo}[4]{}
\fi
\if@paper
  \newcommand{\titaut}[3][\today]{%
    \if@wide \linespread{1} \fi
    \ifthenelse{\equal{#2}{}}
      {}
      {\renewcommand{\defaulttitle}{#2}
        \renewcommand{\currenttitle}{#2}}
    \title{\normalfont\huge \defaulttitle \vfill}
    \ifthenelse{\equal{#3}{}}
      {}
      {\renewcommand{\defaultauthor}{#3}
        \renewcommand{\currentauthor}{#3}}
    \author{\normalfont\Large \defaultauthor\\[0.8ex]
      \normalfont\normalsize \defaultaddress\\[0.4ex]
      \normalfont\normalsize
      \htmladdnormallink{\defaultemail}{mailto:\defaultemail}\\[-1ex]
      \normalfont\normalsize
      \htmladdnormallink{\defaulthomepage}{\defaulthomepage}
}
    \date{\vfill\vfill \normalfont\normalsize #1}
    \maketitle
    \ifthenelse{\isundefined{\currentdate}}
      {\newcommand{\currentdate}{#1}}{}
    \setcounter{page}{0}
    \thispagestyle{empty}
     \ifthenelse{\equal{\abstext}{}}{%
        \ifthenelse{\equal{\keywordstext}{}}{}{
           \vfill\vfill
           \minisec{\centering\keywordsname}
           \cen{\keywordstext}}
    }{%
       \vfill\vfill
          \minisec{\centering\abstractname}
          \abstext
          \ifthenelse{\equal{\otherabstext}{}}{}
             {\minisec{\centering\otherabstractname}
               \otherabstext}
          \ifthenelse{\equal{\keywordstext}{}}{}
             {\minisec{\centering\keywordsname}
               \cen{\keywordstext}}
    }
    \setcounter{page}{0}
    \thispagestyle{empty}
    \@toc%
    \if@wide \linespread{1.3} \fi
  }
\else
  \newcommand{\titaut}[3][\today]{%
    \if@wide \linespread{1} \fi
    \ifthenelse{\equal{#2}{}}
      {}
      {\renewcommand{\defaulttitle}{#2}
        \renewcommand{\currenttitle}{#2}}
    \title{\normalfont\huge \defaulttitle}
    \ifthenelse{\equal{#3}{}}
      {}
      {\renewcommand{\defaultauthor}{#3}
        \renewcommand{\currentauthor}{#3}}
    \author{\normalfont\Large \defaultauthor}
    \date{\normalfont\normalsize #1}
    \maketitle
    \ifthenelse{\isundefined{\currentdate}}
      {\newcommand{\currentdate}{#1}}{}
    \setcounter{page}{0}
    \thispagestyle{empty}
     \ifthenelse{\equal{\abstext}{}}{}{
          \minisec{\centering\abstractname}
          \abstext
          \ifthenelse{\equal{\otherabstext}{}}{}
             {\minisec{\centering\otherabstractname}
               \otherabstext}
    }
     \ifthenelse{\equal{\keywordstext}{}}{}
        {\minisec{\centering\keywordsname}
          \cen{\keywordstext}}
    \setcounter{page}{0}
    \thispagestyle{empty}%
    \if@wide \linespread{1.3} \fi
  }
\fi
\newcommand{\tit}[2][\today]{\titaut[#1]{#2}{}}
\newcommand{\titautver}[4][\today]{
  \newcommand{\currentdate}{#1}%
  \titaut[#4\\\versiontext\ #1]{#2}{#3}
}
\newcommand{\titver}[3][\today]{\titautver[#1]{#2}{}{#3}}
\newcounter{fictionsec}[section]
\newcommand{\fictionsec}{\addtocounter{fictionsec}{1}%
  \subsection*{\centering\thefictionsec}}
\renewcommand\part{\clearpage
   \@afterindentfalse
   \secdef\@part\@spart}
\endinput
%%
%% End of file `hcart.cls'.
