\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{knittingpattern}[2009/11/13 Formatting for knitting patterns]

%% knittingpattern.cls, version 1
  %% Copyright 2010 Hugh Griffiths
  %
  % This work may be distributed and/or modified under the conditions
  % of the LaTeX Project Public License, either version 1.3 of this
  % license or (at your option) any later version.  The latest version
  % of this license is in http://www.latex-project.org/lppl.txt and
  % version 1.3 or later is part of all distributions of LaTeX version
  % 2005/12/01 or later.
  %
  % This work has the LPPL maintenance status `maintained'.
  % 
  % The Current Maintainer of this work is Hugh Griffiths.
  %
  % This work consists of the files knittingpattern.cls, template.tex, template.pdf, introduction.tex and introduction.pdf

\LoadClass{article}

\RequirePackage{graphicx, float, fancyhdr, longtable, calc}
\RequirePackage[table]{xcolor}

% This section is from Manas Tungare's ``lesspaper.sty'', which he has
 % generously donated to the public domain.
\setlength{\textwidth}{7.5in}
\setlength{\textheight}{9.5in}
\setlength{\evensidemargin}{-0.5in}
\setlength{\oddsidemargin}{-0.5in}
\setlength{\topmargin}{-0.5in}
\setlength{\voffset}{-0.5in}

\newcommand{\intro}[3][.25]{\begin{tabular}{m{\textwidth - 4\tabcolsep
- #1\textwidth}m{#1\textwidth}}
#2&\fbox{\includegraphics[width=#1\textwidth]{#3}}
\end{tabular}}

\newcommand{\note}[5][.9]{\begin{center}
\fcolorbox{#2}{#3}{\parbox{#1\textwidth}{\underline{\Large{#4}} \\ #5 }
}
\end{center}
} 

\newcommand{\diagram}[2][.5]{\begin{center}
\fbox{\includegraphics[width=#1\textwidth]{#2}}
\end{center}
}

\newenvironment{pattern}[3][.05]{\begin{center}
\rowcolors{1}{#2}{#3}
\begin{longtable}{p{\textwidth-#1\textwidth- 4\tabcolsep} p{#1\textwidth}}}{\end{longtable}\end{center}}

\newcommand{\important}[4][.9]{\begin{center}\fcolorbox{#2}{#3}{\parbox{#1\textwidth}{#4}}\end{center}}

\newcommand{\biog}[3][.25]{\begin{table}[b]\begin{tabular}{m{#1\textwidth}m{\textwidth-#1\textwidth-4\tabcolsep}}
\fbox{\includegraphics[width=#1\textwidth]{#2}}& #3
\end{tabular} \end{table}}

\newcommand{\cpyrght}[1]{
\pagestyle{fancy}
\fancyhead{}
\fancyfoot{}
\renewcommand{\footrulewidth}{.4pt}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[R]{#1}
\thispagestyle{fancy}
}

\setlength{\fboxrule}{2pt}
\setlength{\tabcolsep}{0.025\textwidth}

