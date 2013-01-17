%%
%% This is file `meetingmins.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% meetingmins.dtx  (with options: `class')
%% ----------------------------------------------------------------------
%% 
%% meetingmins - A LaTeX class for formatting minutes of meetings
%% 
%% Copyright (C) 2011 by Brian D. Beitzel <brian@beitzel.com>
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version.  The latest version of this license is in the file:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% Users may freely modify these files without permission, as long as the
%% copyright line and this statement are maintained intact.
%% 
%% ----------------------------------------------------------------------
%% 
\ProvidesClass{meetingmins}[2011/10/28 v1.0 Meeting minutes]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{agenda}{%
\def\@agenda{\@agendamode}
}

\DeclareOption{chair}{%
\def\@chair{\@chairmode}
}

\def\@committeename{}
\newcommand{\setcommittee}[1]{\def\@committee{#1}}
\newcommand{\show@committee}{\@committee}

\def\@members{None}
\newcommand{\setmembers}[1]{\def\@members{#1}}
\newcommand{\show@members}{\@members}

\newcommand{\role}[2]{#1~(#2)}
\newcommand{\chair}[1]{\role{#1}{Chair}}
\newcommand{\secretary}[1]{\role{#1}{Secretary}}

\global\let\@absent\@empty
\newcommand{\setabsent}[1]{\def\@absent{#1}}
\let\absent\setabsent %
\newcommand{\show@absent}{\@absent}

\global\let\@present\@empty
\newcommand{\setpresent}[1]{\def\@present{#1}}
\newcommand{\show@present}{\@present}

\global\let\@alsopresent\@empty
\newcommand{\setalsopresent}[1]{\def\@alsopresent{#1}}
\let\alsopresent\setalsopresent %
\newcommand{\show@alsopresent}{\@alsopresent}

\def\@date{\today}
\newcommand{\setdate}[1]{\def\@date{#1}}
\newcommand{\show@date}{\@date}

\DeclareOption*{\InputIfFileExists{\CurrentOption.min}{}{%
    \PassOptionsToClass{\CurrentOption}{article}}}

\ProcessOptions \relax

\LoadClass{article}

\RequirePackage[margin=1in]{geometry}

\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}

\RequirePackage{fancyhdr}
\fancypagestyle{firstpage}{%
  \fancyhf{} % clear all six fields
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{followingpage}{%
  \fancyhf{} % clear all six fields
  \lhead{\show@committee, \show@date}
  \rhead{\thepage}
  \renewcommand{\headrulewidth}{1pt}
  \renewcommand{\footrulewidth}{0pt}
}

\pagestyle{followingpage}
\AtBeginDocument{\thispagestyle{firstpage}}

\RequirePackage{enumitem}

\@ifundefined{@chair}{% minutes/agenda
}{%  chair's agenda
  \RequirePackage{mathabx}
  \RequirePackage{xstring}
}

\newcommand{\member@list}{
  \begin{description}
    \item[Members:] \show@members
  \end{description}
}

\newcommand{\member@table}{
  \begin{description}
    \raggedright
    \item[Members:] \StrSubstitute{$\Box$~\show@members}{,}{,\ \ \ $\Box$~}
  \end{description}
}

\newcommand{\head@list}{
  \begin{description}
    \item[Present:] \show@present
    \ifx\@absent\@empty
      \relax
    \else
      \item[Absent:] \show@absent
    \fi %
    \ifx\@alsopresent\@empty
      \relax
    \else
      \item[Also present:] \show@alsopresent
    \fi %
  \end{description}
}

\renewcommand{\maketitle}{%
  \begin{center}
    {\large\textbf{\show@committee}}  \\[1ex]
    \@ifundefined{@agenda}{%
      \@ifundefined{@chair}{% minutes
        Minutes for \show@date
      }{%  chair's agenda
        Chair's Agenda for \show@date
      }
    }{% agenda only
      Agenda for \show@date
    }
  \end{center}
  \vspace{0.5ex}
  \@ifundefined{@agenda}{% minutes
    \@ifundefined{@chair}{% minutes
      \head@list
      \vspace{0.1ex}
    }{%  chair's agenda
      \member@table
    }
  }{% agenda only
  }
}{%
}

\setcounter{secnumdepth}{0}
\renewcommand{\section}{\@startsection {section}{1}{\z@}%
    {1\baselineskip \@plus 0.2ex \@minus 0.2ex\leftskip=0in}%
    {0.8\baselineskip \@plus .2ex}%
    {\normalfont\normalsize\bfseries}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{0.5in}%
    {1\baselineskip \@plus 0.2ex \@minus 0.2ex\leftskip=0in}%
    {0.5\baselineskip \@plus 0.2ex}%
    {\normalfont\normalsize\bfseries\itshape}}

\@ifundefined{@agenda}{%
  \@ifundefined{@chair}{% minutes
    \renewcommand{\subsubsection}[1]{\@startsection{subsubsection}{3}{0in}%
      {0.4\baselineskip \@plus 0.2ex \@minus 0.2ex\leftskip=0.5in}%
      {-\z@}%
      {\normalfont\normalsize\itshape}{#1} \hspace{0.2em} ---\hspace{0.2em}}
  }{% chair's agenda
    \renewcommand{\subsubsection}[1]{\@startsection{subsubsection}{3}{0in}%
      {0.4\baselineskip \@plus 0.2ex \@minus 0.2ex\leftskip=0.5in}%
      {-\z@}%
      {\normalfont\normalsize\itshape}{#1}}
  }
}{% agenda only
  \renewcommand{\subsubsection}[1]{\@startsection{subsubsection}{3}{0in}%
    {0.4\baselineskip \@plus 0.2ex \@minus 0.2ex\leftskip=0.5in}%
    {-\z@}%
    {\normalfont\normalsize\itshape}{#1}}
}

\RequirePackage{environ}

\newenvironment{emptysection}{\Collect@Body\@gobble}{}

\newenvironment{items}{%
  \begin{itemlist}
}{%
  \end{itemlist}
}

\newenvironment{itemlist}{%
  \begin{enumerate}[leftmargin=0.5in]
}{%
  \end{enumerate}
}

\@ifundefined{@agenda}{% minutes
  \newenvironment{hiddenitems}{\begin{enumerate}[leftmargin=0.5in]}{\end{enumerate}}
}{% agenda only
  \let\hiddenitems\emptysection
}

\newenvironment{subitems}{%
  \begin{subitemlist}
}{%
  \end{subitemlist}
}

\newenvironment{subitemlist}{%
  \begin{enumerate}[leftmargin=1in]
}{%
  \end{enumerate}
}

\@ifundefined{@agenda}{% minutes
  \newenvironment{hiddensubitems}{\begin{enumerate}[leftmargin=1in]}{\end{enumerate}}
}{% agenda only
  \let\hiddensubitems\emptysection
}

\newenvironment{subsubitems}{%
  \begin{subsubitemlist}
}{%
  \end{subsubitemlist}
}

\newenvironment{subsubitemlist}{%
  \begin{enumerate}[leftmargin=1in]
}{%
  \end{enumerate}
}

\@ifundefined{@agenda}{% minutes
  \newenvironment{hiddensubsubitems}{\begin{enumerate}[leftmargin=1in]}{\end{enumerate}}
}{% agenda only
  \let\hiddensubsubitems\emptysection
}

\newcommand{\priormins}{The minutes of the previous meeting were approved.}

\newcommand{\nextmeeting}[1]{%
  \@ifundefined{@agenda}{% minutes
    \par\noindent\textbf{Next Meeting:} #1\par
  }{% agenda only
    %\par\noindent\textbf{Next Meeting:} #1\par
  }
}

%% 
%% Copyright (C) 2011 by Brian D. Beitzel <brian@beitzel.com>
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version.  The latest version of this license is in the file:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% Users may freely modify these files without permission, as long as the
%% copyright line and this statement are maintained intact.
%% 
%% This work is "maintained" (as per LPPL maintenance status) by
%% Brian D. Beitzel.
%% 
%% This work consists of the file  meetingmins.dtx
%% and the derived files           meetingmins.cls,
%%                                 sampleminutes.tex,
%%                                 department.min,
%%                                 README.txt, and
%%                                 meetingmins.pdf.
%% 
%%
%% End of file `meetingmins.cls'.
