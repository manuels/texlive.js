%% This is file `proc.cls',
%% Copyright 1993 1994 1995 1996 1997 1998 1999
%% The LaTeX3 Project and any individual authors listed elsewhere
%% in this file.
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{extproc}
              [1995/11/30 v1.3l
               NON-Standard LaTeX document class]
\DeclareOption{a5paper}
    {\ClassError{proc}{Option `a5paper' not supported}{}}
\DeclareOption{b5paper}
    {\ClassError{proc}{Option `b5paper' not supported}{}}
\DeclareOption{onecolumn}%
    {\ClassError{proc}{Option `onecolumn' not supported}{}}
\DeclareOption{titlepage}%
    {\ClassError{proc}{Option `titlepage' not supported}{}}
\PassOptionsToClass{twocolumn}{article}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions
\LoadClass{extarticle}
\setlength\footskip{75\p@}
\setlength\textwidth{\paperwidth}
\addtolength\textwidth{-126\p@}
\@settopoint\textwidth
\@settopoint\textwidth
\ifcase\@ptsize
\or\or\or\or\or\or\or
\or  \setlength\textheight{67\baselineskip}
\or  \setlength\textheight{58\baselineskip}  
\or  \setlength\textheight{53\baselineskip}
\or  \setlength\textheight{47\baselineskip}
\or  \setlength\textheight{44\baselineskip}
\or
\or \setlength\textheight{37\baselineskip}
\or \or
\or \setlength\textheight{29\baselineskip}
\or \or
\or \setlength\textheight{25\baselineskip}
\fi
\advance\textheight by \topskip
\setlength\oddsidemargin{-10\p@}
\setlength\evensidemargin{-10\p@}
\setlength\marginparwidth {\z@}
\setlength\topmargin{-47\p@}
\setlength\columnsep{.375in}
\let\@oddhead\@empty
\let\@evenhead\@empty
\def\@oddfoot{\normalfont\rightmark \hfil
              \pagename{} \thepage}
\def\@evenfoot{\@oddfoot}
\def\maketitle{\par
 \begingroup
   \renewcommand\thefootnote{\fnsymbol{footnote}}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
     \long\def\@makefntext##1{\parindent 1em\noindent
             \hb@xt@1.8em{%
                 \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
   \twocolumn[\@maketitle]%
   \@thanks
 \endgroup
 \setcounter{footnote}{0}%
 \let\maketitle\relax
 \let\@maketitle\relax
 \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\thanks\relax}
\def\@maketitle{%
  \vbox to 2.25in{%
    \hsize\textwidth
    \linewidth\hsize
    \vfil
    \centering
    {\LARGE \@title \par}
    \vskip 2em
    {\large \begin{tabular}[t]{c}\@author \end{tabular}\par}
    \vfil}}
\def\copyrightspace{%
  \footnotetext[0]{\mbox{}\vrule \@height 97\p@ \@width \z@}}
\renewenvironment{abstract}%
  {\section*{\abstractname}}
  {\par}
\newcommand\pagename{Page}
\endinput
