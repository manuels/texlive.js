%%
%% This is file `sffms.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% sffms.dtx  (with options: `sffms')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from sffms.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file sffms.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sffms}[2003/03/13 v2.0
 The SF/F manuscript class]

\newcounter{wordcounter}
\newcount\wordc
\newif\ifsffms@submit
\newif\ifsffms@novel
\newif\ifsffms@smart
\newif\ifsffms@dumb
\newif\ifsffms@notitle
\newif\ifsffms@courier
\newif\ifsffms@baen
\newif\ifsffms@daw
\newif\ifsffms@wotf
\newif\ifsffms@runningtitle
\newif\ifsffms@surname
\newif\ifsffms@afour
\newif\ifsffms@geometry
\sffms@submittrue

\sfcode`\" = 0

\def\word@count{\ref{sffmswc}}
\def\author@name{\@author}
\def\author@address{}
\def\sur@name{}
\def\running@title{}
\def\scenesepstring{\#}
\def\thirtystring{\# \# \# \# \#}
\def\disposablestring{}
\def\pageofpages{Page {\thepage} of \pageref{sffmswc}}
\def\msheadstring{\getsurname\hspace{.5ex}/\hspace{.5ex}\getrunningtitle\hspace{.5ex}/\hspace{.5ex}\thepage}

\DeclareOption{courier}{%
   \sffms@couriertrue%
   \AtBeginDocument{
        \fontfamily{pcr}\selectfont
      \renewcommand{\ttdefault}{pcr}
    \renewcommand{\bfdefault}{pcr}
    \renewcommand{\itdefault}{pcr}
    \renewcommand{\sldefault}{pcr}
    \renewcommand{\scdefault}{pcr}
    \renewcommand{\updefault}{pcr}
   }
}

\DeclareOption{nonsubmission}{\sffms@submitfalse}
\DeclareOption{submission}{\sffms@submittrue}%obsolete
\DeclareOption{novel}{\sffms@noveltrue}

\DeclareOption{smart}{%
   \sffms@smarttrue%
   \AtBeginDocument{\begindoublequotes}
   \AtEndDocument{\enddoublequotes}
}

\DeclareOption{dumb}{\sffms@dumbtrue}
\DeclareOption{notitle}{\sffms@notitletrue}

\DeclareOption{baen}{\sffms@baentrue}
\DeclareOption{daw}{\sffms@dawtrue}
\DeclareOption{wotf}{\sffms@wotftrue}

\DeclareOption{geometry}{\sffms@geometrytrue}

\DeclareOption{a4paper}{
  \sffms@afourtrue%
  \PassOptionsToClass{\CurrentOption}{geometry}
  \PassOptionsToClass{\CurrentOption}{report}}

\DeclareOption{letterpaper}{
  \sffms@afourfalse%
  \PassOptionsToClass{\CurrentOption}{geometry}
  \PassOptionsToClass{\CurrentOption}{report}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

\ifsffms@submit%
 \LoadClass[12pt]{report}
 \RequirePackage[T1]{fontenc}
 \RequirePackage{fancyhdr}
 \RequirePackage{ulem}
 \RequirePackage{setspace}\setstretch{1.83}
 \ifsffms@geometry
    \ifsffms@baen \RequirePackage[hmargin=1.5in,bmargin=1.5in,tmargin=1.5in,headheight=.38in,headsep=.12in,nofoot]{geometry}%
    \else \RequirePackage[hmargin=1in,bmargin=1in,tmargin=1in,headheight=.88in,headsep=.12in,nofoot]{geometry}%
     \fi%endbaenif
     \fi%endgeometryif
\else\LoadClass{report}%
 \RequirePackage{setspace} \fi

\ifsffms@smart \RequirePackage{sffsmart} \fi
\ifsffms@dumb \RequirePackage{sffdumb} \fi

\ifsffms@submit%
  \ifsffms@geometry%    then margins are all set so do nothing
    \sffms@geometrytrue
  \else%  have to set margins manually from paperdim
  \setlength\headheight{.38in}
  \setlength\headsep{.12in}
  \setlength\textwidth{\paperwidth}
  \newlength{\sffms@margin}
  \setlength{\sffms@margin}{0in}
  \ifsffms@baen \addtolength{\sffms@margin}{.5in} \fi
  \setlength\textwidth{\paperwidth}
  \addtolength\textwidth{-2in}
  \addtolength\textwidth{-2\sffms@margin}
  \setlength\oddsidemargin{\sffms@margin}
  \setlength\textheight{\paperheight}
  \addtolength\textheight{-2in}
  \addtolength\textheight{-2\sffms@margin}
  \setlength\topmargin{\sffms@margin}
  \addtolength\topmargin{-.5in}
  \fi%
\fi%

\newcommand{\authorname}[1]{\def\author@name{#1}}
\newcommand{\address}[1]{\def\author@address{#1}}
\newcommand{\wordcount}[1]{\def\word@count{#1}}
\newcommand{\surname}[1]{\def\sur@name{#1} \sffms@surnametrue}
\newcommand{\runningtitle}[1]{\def\running@title{#1} \sffms@runningtitletrue}
\newcommand{\sceneseparator}[1]{\def\scenesepstring{#1}}
\newcommand{\thirty}[1]{\def\thirtystring{#1}}
\newcommand{\disposable}{\def\disposablestring{Disposable~Copy}}
\ifsffms@wotf%
  \def\msheadstring{\MakeUppercase{\@title}\hspace{.5ex}/\hspace{.5ex}\thepage} \fi%
\newcommand{\msheading}[1]{\def\msheadstring{#1}}

\newcommand{\penname}[1]{} % obsolete
\newcommand{\getpenname}{\@author} % obsolete

\newcommand{\getrunningtitle}{\ifsffms@runningtitle%
  \MakeUppercase{\running@title}%
  \else \MakeUppercase{\@title}%
\fi}

\newcommand{\getsurname}{\ifsffms@surname%
  \sur@name \else \@author \fi}

\ifsffms@submit%
\newcommand{\newscene}{\centerline {\scenesepstring}}
 \newcommand{\ifsubmission}[2]{#1}%
\else \newcommand{\newscene}{\vspace{1\baselineskip}}
 \newcommand{\ifsubmission}[2]{#2} \fi

\newcommand{\submit}[1]{\ifsubmission{#1}{}}
\newcommand{\nosubmit}[1]{\ifsubmission{}{#1}}

\newcommand{\scenebreak}{\newscene}

\newcommand{\thought}[1]{\emph{#1}}

\ifsffms@submit
 \AtBeginDocument{
   \ttfamily
   \useunder{\uwave}{\bfseries}{\textbf}%ulem command for boldface
   \useunder{\uuline}{\scshape}{\textsc}%ulem command for smallcaps
   \renewcommand\chapter{\if@openright\clearpage\else\cleardoublepage\fi
                        \secdef\@chapter\@schapter}
    \def\@makechapterhead#1{\vspace*{4\baselineskip}
        \begin{center}\@chapapp\space\thechapter\\ #1 \end{center}
        \vspace*{1\baselineskip}}
    \def\@schapter#1{%
        \if@twocolumn\@topnewpage[\@makeschapterhead{#1}]%
        \else\@makeschapterhead{#1}\@afterheading\fi}
    \def\@makeschapterhead#1{\vspace*{4\baselineskip}
        \begin{center} #1 \end{center} \vspace*{1\baselineskip}}
    }%
\fi

\ifsffms@novel%
 \newcounter{tempcounter}
 \newenvironment{synopsis}
  {\setcounter{tempcounter}{\value{page}}
   \pagenumbering{roman}
   \singlespace
   \chapter*{Synopsis of \MakeUppercase{\@title}}}
  {\clearpage \setcounter{page}{\value{tempcounter}}
   \pagenumbering{arabic} \pagestyle{fancy}}%
\else \newenvironment{synopsis}{SYNOPSIS:  }{\scenebreak} \fi

\newcommand{\sffms@commonsubsetup}%
{\pagestyle{fancy}
 \fancyhead[r]{{\ttfamily \msheadstring}}
 \fancyfoot{}
 \renewcommand{\headrulewidth}{0pt}
 \renewcommand{\footrulewidth}{0pt}
 \raggedright
 \settowidth{\parindent}{\texttt{~~~~~}}
}

\AtBeginDocument{
\ifsffms@notitle%
    \ifsffms@submit \sffms@commonsubsetup \fi%
 \else%
   \ifsffms@submit%beginning of + 2nd submit if
    \sffms@commonsubsetup
    \thispagestyle{empty}
    \newsavebox{\sffms@fronttopsavebox}
    \begin{lrbox}{\sffms@fronttopsavebox}
    \begin{minipage}[t]{\textwidth}
    \begin{singlespace}%
    \ifsffms@daw \hfill\parbox[t]{.40\textwidth}{\raggedright\author@name\\%
        \author@address\\[\baselineskip]%
        \word@count\ words\\ \disposablestring}%
    \else%
     \parbox[t]{.65\textwidth}{\author@name\\\author@address}\hfill
     \parbox[t]{.30\textwidth}{\raggedleft\word@count\ words\\[\baselineskip]%
     \disposablestring}%
    \fi%
    \end{singlespace}
    \end{minipage}
    \end{lrbox}
    \noindent\raisebox{0pt}[0pt][0pt]{\usebox{\sffms@fronttopsavebox}}
    \vspace{0.39\textheight}
    \begin{center}\MakeUppercase{\@title}\\by \@author\end{center}
    \vspace{1\baselineskip}%
   \else \maketitle \setcounter{page}{2} \fi%
  \ifsffms@wotf \setcounter{page}{0} \clearpage%
  \else \ifsffms@novel\clearpage\fi%
  \fi%
\fi%
}

\AtEndDocument{\vspace{12pt}\centerline{\thirtystring}%
  \ifsffms@submit%
      \wordc=\thepage%
\ifsffms@courier \multiply\wordc by 250%
   \else \ifsffms@baen \multiply\wordc by 250%
           \else \multiply\wordc by 295 \fi \fi%
\setcounter{wordcounter}{\the\wordc}%
\addtocounter{wordcounter}{-1}%
\refstepcounter{wordcounter}%
  \fi%
  \label{sffmswc}%
}
\endinput
%%
%% End of file `sffms.cls'.
