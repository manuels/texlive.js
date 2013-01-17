%% talk -- (talk.cls) Class file
%% A LaTeX class for creating presentations
%% Author: Martin Wiebusch
%%
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.


\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{talk}[2006/07/11 v1.1]

\def\pres@dt@notes{notes}
\def\pres@dt@slides{slides}
\def\pres@dt@screen{screen}
\def\pres@doctype{}
\newif\if@pres@rotate

\def\@ifnotes#1#2{\ifx\pres@doctype\pres@dt@notes#1\else#2\fi}
\def\@ifslides#1#2{\ifx\pres@doctype\pres@dt@slides#1\else#2\fi}
\def\@ifscreen#1#2{\ifx\pres@doctype\pres@dt@screen#1\else#2\fi}

\DeclareOption{notes}{\global\let\pres@doctype\pres@dt@notes}
\DeclareOption{slides}{\global\let\pres@doctype\pres@dt@slides}
\DeclareOption{screen}{\global\let\pres@doctype\pres@dt@screen}
\DeclareOption{rotate}{\@pres@rotatetrue}
\DeclareOption{norotate}{\@pres@rotatefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ExecuteOptions{screen,rotate}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage{multido}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage{pgf}
\RequirePackage{hyperref}

% title and author
%
\def\title{\@ifnextchar[{\pres@titleii}{\pres@titlei}}
\def\pres@titleii[#1]#2{\gdef\@title{#2}\gdef\@shorttitle{#1}}
\def\pres@titlei#1{\pres@titleii[#1]{#1}}
\def\author{\@ifnextchar[{\pres@authorii}{\pres@authori}}
\def\pres@authorii[#1]#2{\gdef\@author{#2}\gdef\@shortauthor{#1}}
\def\pres@authori#1{\pres@authorii[#1]{#1}}

% collect@body (from amsmath.sty)
%
\long\def\pres@addto@envbody#1{\global\@envbody\@xp{\the\@envbody#1}}
\long\def\pres@collect@body#1{%
  \@envbody{\@xp#1\@xp{\the\@envbody}}%
  \edef\process@envbody{\the\@envbody\@nx\end{\@currenvir}}%
  \@envbody\@emptytoks \def\begin@stack{b}%
  \begingroup
  \@xp\let\csname\@currenvir\endcsname\pres@collect@@body
  \edef\process@envbody{\@xp\@nx\csname\@currenvir\endcsname}%
  \process@envbody
}
\long\def\pres@push@begins#1\begin#2{%
  \ifx\end#2\else b\@xp\pres@push@begins\fi
}
\long\def\pres@collect@@body#1\end#2{%
  \edef\begin@stack{\pres@push@begins#1\begin\end \@xp\@gobble\begin@stack}%
  \ifx\@empty\begin@stack
    \endgroup
    \@checkend{#2}%
    \pres@addto@envbody{#1}%
  \else
    \pres@addto@envbody{#1\end{#2}}%
  \fi
  \process@envbody % A little tricky! Note the grouping
}


% some definitions
%
\newlength{\slidewidth}
\newlength{\slideheight}
\newlength{\pres@hadjust}
\newlength{\pres@vadjust}
\def\pres@currentslidestyle{}
\def\pres@oldslidestyle{}
\def\@slidetitle{}
\def\@slidebody{}
\long\def\pres@defslidebody#1{\long\gdef\@slidebody{#1}}
\def\pres@slidesmag{1}


% section and subsection handling
%
\long\def\@tableofcontents{}
\newcommand{\pres@artsection}[2][]{}
\newcommand{\pres@artsubsection}[2][]{}
\@ifnotes{%
  \let\pres@artsection\section
  \let\pres@artsubsection\subsection
}{}
\def\pres@addtocsection#1#2#3{%
  \expandafter\gdef\expandafter\@tableofcontents\expandafter{\@tableofcontents\@maketocsection{#1}{#2}{#3}}%
}
\def\pres@addtocsubsection#1#2#3#4{%
  \expandafter\gdef\expandafter\@tableofcontents\expandafter{\@tableofcontents\@maketocsubsection{#1}{#2}{#3}{#4}}%
}
\def\section{\@ifnextchar[{\@@pres@section}{\@pres@section}}
\def\@pres@section#1{\@@pres@section[#1]{#1}}
\def\@@pres@section[#1]#2{%
  \pres@artsection[#1]{#2}
  \@ifnotes{}{\refstepcounter{section}}
  \addtocontents{ttc}{\string\pres@addtocsection{\the\c@section}{#1}{#2}}
}
\def\subsection{\@ifnextchar[{\@@pres@subsection}{\@pres@subsection}}
\def\@pres@subsection#1{\@@pres@subsection[#1]{#1}}
\def\@@pres@subsection[#1]#2{%
  \pres@artsubsection[#1]{#2}
  \@ifnotes{}{\refstepcounter{subsection}}
  \addtocontents{ttc}{\string\pres@addtocsubsection{\the\c@section}{\the\c@subsection}{#1}{#2}}
}
\long\def\@ifcurrentsection#1#2#3{\ifnum\c@section=#1 #2\else#3\fi}
\long\def\@ifcurrentsubsection#1#2#3{\ifnum\c@subsection=#1 #2\else#3\fi}
\@input{\jobname.ttc}%
\newwrite\tf@ttc
\immediate\openout\tf@ttc\jobname.ttc\relax
\newwrite\tf@toc
\immediate\openout\tf@toc\jobname.toc\relax


% table of contents
%
\long\def\maketitle{}
\long\def\tableofcontents{}
\long\def\pres@ifinrange#1#2[#3.#4-#5.#6]#7#8{%
  \ifnum#1=#3
    \ifnum#2<#4 #8\else #7\fi
  \else
    \ifnum#1=#5
      \ifnum#2>#6 #8\else #7\fi
    \else
      \ifnum#1<#3 #8\else
        \ifnum#1>#5 #8\else #7\fi
      \fi
    \fi
  \fi
}
\long\def\@ifinrange#1#2#3#4#5{\pres@ifinrange{#1}{#2}[#3]{#4}{#5}}


% default make commands
%
\long\def\pres@defaultslide{%
  \vspace*{1.2em minus 0.4em}%
  \centerline{\LARGE\@slidetitle}%
  \vspace*{1.8em minus 0.6em}%
  \@slidebody%
  \vfill%
  \raggedleft\tiny\@title\ -- \theslidelabel%
}
\def\pres@defaultslidebackground{%
  \pgfsetlinewidth{0.8pt}
  \color{black}
  \pgfrect[stroke]{\pgfpointorigin}{\pgfpoint\slidewidth\slideheight}
}
\def\pres@restoredefaults{%
  \gdef\@makeslidecontent{\pres@defaultslide}
  \gdef\@makeslidebackground{\pres@defaultslidebackground}
  \gdef\@makeslide{%
    \@makeslidebackground%
    \pgfputat{\pgfpointorigin}{\pgfbox[left,bottom]{%
        \begin{minipage}[b][\slideheight][t]{\slidewidth}%
          \@makeslidecontent%
        \end{minipage}%
    }}%
  }
  \gdef\@makenotesslide{\par\hspace*{\fill}\@slidebox\hspace*{\fill}\par}
  \gdef\@maketocsection##1##2##3{}
  \gdef\@maketocsubsection##1##2##3##4{}
}
\pres@restoredefaults


% the slide environment
%
\def\@slidebox{%
  \begin{pgfpicture}
    \@ifslides{%
      \pgftransformscale{\pres@slidesmag}%
      \if@pres@rotate
        \pgftransformrotate{90}%
      \fi
    }{}%
    \pgfpathrectangle{\pgfpointorigin}{\pgfpoint\slidewidth\slideheight}%
    \pgfusepath{use as bounding box}%
    \pgflowlevelsynccm%
    \@makeslide
  \end{pgfpicture}%
}

\@ifnotes{\def\pres@makeslide{\noindent\@makenotesslide}}{}
\@ifslides{%
  \def\pres@makeslide{%
    \vspace*{\fill}%
    \vspace{2\pres@vadjust}
    \noindent%
    \hspace*{\fill}%
    \hspace{2\pres@hadjust}
    \@slidebox%
    \hspace*{\fill}%
    \vspace*{\fill}%
    \newpage%
  }%
}{}
\@ifscreen{\def\pres@makeslide{%
    \noindent\@slidebox%
    \newpage%
}}{}

\def\slide{\@ifnextchar[{\@@slide}{\@slide}}
\long\def\@@slide[#1]#2{%
  \refstepcounter{slide}
  \csname pres@sty@#1\endcsname%
  \long\global\def\@slidetitle{#2}
  \pres@collect@body\pres@defslidebody%
}
\long\def\@slide#1{%
  \refstepcounter{slide}
  \csname pres@sty@\pres@currentslidestyle\endcsname
  \long\global\def\@slidetitle{#1}
  \pres@collect@body\pres@defslidebody%
}
\def\endslide{%
  \global\@ignoretrue%
  \pres@makeslide%
}


% slide styles
%
\long\def\@newslidestyle#1#2{%
  \edef\@temp{#1}%
  \expandafter\gdef\csname pres@sty@\@temp\endcsname{%
    \pres@restoredefaults%
    #2%
  }%
}
\newcommand{\slidestyle}[1]{\gdef\pres@currentslidestyle{#1}}


% slide and subslide numbering
%
\newcounter{slide}
\newcounter{subslide}
\def\theslide{\arabic{slide}}
\def\thesubslide{\theslide.\arabic{subslide}}
\def\theslidelabel{\theslide}

% overlay commands
%
\@ifnotes{
  \long\gdef\fromslide{\@ifnextchar*{\@fromslidestar}{\@fromslide}}
  \long\gdef\@fromslide#1#2{#2}
  \long\gdef\@fromslidestar*#1#2{#2}
  \long\gdef\toslide{\@ifnextchar*{\@toslidestar}{\@toslide}}
  \long\gdef\@toslide#1#2{#2}
  \long\gdef\@toslidestar*#1#2{#2}
  \long\gdef\onlyslide{\@ifnextchar*{\@onlyslidestar}{\@onlyslide}}
  \long\gdef\@onlyslide#1#2{#2}
  \long\gdef\@onlyslidestar*#1#2{#2}
  \gdef\pres@makemultislide{\pres@makeslide}
}{%
  \long\gdef\fromslide{\@ifnextchar*{\@fromslidestar}{\@fromslide}}
  \long\gdef\@fromslide#1#2{%
    \ifnum\c@subslide<#1%
      \pgfsys@begininvisible#2\pgfsys@endinvisible%
    \else%
      #2%
    \fi%
  }
  \long\gdef\@fromslidestar*#1#2{%
    \ifnum\c@subslide<#1%
    \else%
      #2%
    \fi%
  }
  \long\gdef\toslide{\@ifnextchar*{\@toslidestar}{\@toslide}}
  \long\gdef\@toslide#1#2{%
    \ifnum\c@subslide>#1%
      \pgfsys@begininvisible#2\pgfsys@endinvisible%
    \else%
      #2%
    \fi%
  }
  \long\gdef\@toslidestar*#1#2{%
    \ifnum\c@subslide>#1\relax%
    \else%
      #2%
    \fi%
  }
  \long\gdef\onlyslide{\@ifnextchar*{\@onlyslidestar}{\@onlyslide}}
  \long\gdef\@onlyslide#1#2{%
    \ifnum\c@subslide=#1\relax%
      #2%
    \else%
      \pgfsys@begininvisible#2\pgfsys@endinvisible%
    \fi%
  }
  \long\gdef\@onlyslidestar*#1#2{%
    \ifnum\c@subslide=#1\relax%
      #2%
    \fi%
  }
}
\@ifslides{%
  \def\pres@makemultislide{%
    \setcounter{subslide}{0}%
    \def\theslidelabel{\thesubslide}
    \multido{}{\pres@msmax}{%
      \refstepcounter{subslide}%
      \vspace*{\fill}%
      \noindent%
      \hspace*{\fill}%
      \@slidebox%
      \hspace*{\fill}%
      \vspace*{\fill}%
      \newpage%
    }%
  }%
}{}
\@ifscreen{%
  \def\pres@makemultislide{%
    \setcounter{subslide}{0}%
    \def\theslidelabel{\thesubslide}
    \multido{}{\pres@msmax}{%
      \refstepcounter{subslide}
      \noindent\@slidebox%
      \newpage%
    }%
  }%
}{}
\def\multislide{\@ifnextchar[{\@@multislide}{\@multislide}}
\long\def\@@multislide[#1]#2#3{%
  \refstepcounter{slide}
  \csname pres@sty@#1\endcsname
  \long\global\def\@slidetitle{#3}%
  \global\def\pres@msmax{#2}%
  \pres@collect@body\pres@defslidebody%
}
\long\def\@multislide#1#2{%
  \refstepcounter{slide}%
  \csname pres@sty@\pres@currentslidestyle\endcsname
  \long\global\def\@slidetitle{#2}%
  \global\def\pres@msmax{#1}%
  \pres@collect@body\pres@defslidebody%
}
\def\endmultislide{%
  \global\@ignoretrue%
  \pres@makemultislide%
}


% notes
%
\newcommand{\pres@notes}[1]{\@ifnotes{#1}{}}
\newenvironment{notes}{\pres@collect@body\pres@notes}{\global\@ignoretrue}


% size settings
%
\AtBeginDocument{%
  \AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}%
}
\def\pres@removemargins{%
  \setlength\oddsidemargin{-1in}%
  \setlength\evensidemargin{-1in}%
  \setlength\topmargin{-1in}%
  \setlength\headheight\z@%
  \setlength\headsep\z@%
  \setlength\topskip\z@%
  \setlength\footskip\z@%
  \setlength\textwidth\paperwidth%
  \setlength\textheight\paperheight%
}
\def\@slidesize#1#2{
  \setlength\slidewidth{#1}
  \setlength\slideheight{#2}
  \@ifscreen{%
    \setlength\paperwidth\slidewidth%
    \setlength\paperheight\slideheight%
    \pres@removemargins%
  }{}%
  \@ifslides{\pres@removemargins}{}%
}
\def\slidesmag#1{\gdef\pres@slidesmag{#1}}
\def\slidesadjust#1#2{%
  \if@pres@rotate
    \setlength{\pres@hadjust}{#2}%
    \setlength{\pres@vadjust}{#1}%
    \setlength{\pres@vadjust}{-\pres@vadjust}%
  \else
    \setlength{\pres@hadjust}{#1}%
    \setlength{\pres@vadjust}{#2}%
  \fi
}

\@slidesize{4in}{3in}
\@ifnotes{}{\pagestyle{empty}}


% footnote style
%
\def\thempfootnote{\@arabic\c@mpfootnote}
\let\thanks\footnote

