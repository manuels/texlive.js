\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elpres}[2005/08/12 class for plain electronic presentations]
%
% 2004/06/19 v0.1 initial version
%
% 2004/08/29 v0.2 - Page number: now `footnotesize' instead of `normalsize',
%                 - Left and right margins changed
%                 - `cenumerate' and `cdescription' environments
%                   added
% 2005/08/12 v0.3 - Options for selection of fonts added
%
%

% Options: select fonts
\newcommand{\fontna}{initialisiert}
\DeclareOption{tmrfont}{%
  \renewcommand{\familydefault}{\rmdefault}%
  \renewcommand{\fontna}{tmrfo}%
}
\DeclareOption{helvetfont}{%
  \renewcommand{\familydefault}{\sfdefault}%
  \renewcommand{\fontna}{helvetfo}%
}
\DeclareOption{cmfont}{%
  \renewcommand{\familydefault}{\rmdefault}%
  \renewcommand{\fontna}{cmfo}%
}
\DeclareOption{sansfont}{%
  \renewcommand{\familydefault}{\sfdefault}%
  \renewcommand{\fontna}{sansfo}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}
% \LoadClassWithOptions{article}

%% \RequirePackage[foot=10.2pt,head=15pt,paperwidth=128mm,paperheight=96mm,left=5mm,top=5mm,right=5mm,bottom=8mm]{geometry}
\RequirePackage[foot=10.2pt,head=0pt,paperwidth=128mm,paperheight=96mm,left=5mm,top=5mm,right=7mm,bottom=8mm]{geometry}
\RequirePackage{ifthen}

\RequirePackage{fancyhdr}
\renewcommand{\headrulewidth}{0mm}
%% \pagestyle{fancy}
%% \rfoot{\thepage}
%% \cfoot{}
%% \lfoot{}

\renewcommand{\maketitle}%
  {\ClassError{elpres}{Caution: ``maketitle'' command not supported}%
  {Please use ``titlepage'' environment instead}%
}

\fancypagestyle{pres}{%
\fancyhf{}%
\fancyfoot[RO]{\footnotesize \thepage}%
}

\pagestyle{pres}

\newcommand{\distance}[1]{\vspace*{\stretch{#1}}}
\newcommand{\abstand}[1]{\vspace*{\stretch{#1}}}

\setlength{\parskip}{0.6ex}
\setlength{\parindent}{0mm}

\newenvironment{psli}[1][]%
   {{\raggedright \large\bfseries #1\par}\par\vspace*{\stretch{1}}}%
%   {{\centering \large\bfseries #1\par}\par\vspace*{\stretch{1}}}%
   {\par\vspace*{\stretch{1}}\newpage}

%% raw slide -- no heading
\newenvironment{rsli}{}{\newpage}%

%% compressed itemize
\newenvironment{citemize}%
  {\begin{itemize}%
    \setlength{\itemsep}{0ex}%
    \setlength{\parskip}{0.1ex}%
    \setlength{\parsep}{0ex}%
    }%
  {\end{itemize}}%

%% compressed enumerate
\newenvironment{cenumerate}%
  {\begin{enumerate}%
    \setlength{\itemsep}{0ex}%
    \setlength{\parskip}{0.1ex}%
    \setlength{\parsep}{0ex}%
    }%
  {\end{enumerate}}%

%% compressed description
\newenvironment{cdescription}%
  {\begin{description}%
    \setlength{\itemsep}{0ex}%
    \setlength{\parskip}{0.1ex}%
    \setlength{\parsep}{0ex}%
    }%
  {\end{description}}%




\ifthenelse{\equal{\fontna}{tmrfo}}{\RequirePackage{mathptmx}\RequirePackage{courier}}{}
\ifthenelse{\equal{\fontna}{helvetfo}}{\RequirePackage[scaled=0.92]{helvet}\RequirePackage{courier}}{}
\ifthenelse{\equal{\fontna}{initialisiert}}{\renewcommand{\familydefault}{\sfdefault}}{}


% vim: syntax=tex tw=2048 ai
