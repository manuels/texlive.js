\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{nccproc}
         [2005/12/27 v1.3 Generic Proceedings Class (NCC)]
%
% \changes{v1.0}{2004/04/08}{This version was uploaded to CTAN}
% \changes{v1.1}{2004/09/18}{Documentation was corrected}
% \changes{v1.2}{2005/01/14}{Remove small, fleqn, and leqno options}
% \changes{v1.3}{2005/12/27}{11pt option is allowed now}
%
% The base class for NCC Proceedings. It supports bilingual
% (Russian and English) proceedings.
%
\DeclareOption{a5paper}{\OptionNotUsed}
\DeclareOption{a5a4paper}{\OptionNotUsed}
\DeclareOption{b5paper}{\OptionNotUsed}
\DeclareOption{letterpaper}{\OptionNotUsed}
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{fittopage}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{14pt}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{openbib}{\OptionNotUsed}
\DeclareOption{preprint}{\OptionNotUsed}
\DeclareOption{monography}{\OptionNotUsed}
\DeclareOption{report}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ncc}}
\PassOptionsToClass{10pt,twoside,onecolumn,article,a4paper,small}{ncc}
\ProcessOptions\relax
\LoadClass{ncc}
%
% Centered sections with indentation after them
%
\sectionstyle{center}
\indentaftersection
%
% Define page layout
%
\headsep=20pt
\ToCenter[h]{126.5mm}{199mm}
\RequirePackage[title,myheadings]{ncchdr}
\def\NCC@articlehead{\thispagestyle{title}}
%
% Specify a title mark declaration command:
%
% \DeclareTitleMark{Proceedings title}{Location}{Page abbreviation}
%
\newcommand*{\DeclareTitleMark}[3]{%
  \renewcommand\titlemark{\rm
   \smash{\parbox[t]\linewidth{{\centering #1\endgraf}%
     \vspace{.8mm}\small\rm #2, \theyear\hfill
     #3~\thepage--\pageref{NCC@lastpage}}}}
}
\@onlypreamble\DeclareTitleMark
%
% Article info (it is redefined while making contents).
% \info{Author's list}{Title}{Start page}
% In articles, it is used for setting a starting page number
%
\newcommand*\info[3]{\setcounter{page}{#3}}
%
% Defaults
%
\renewcommand{\headrulewidth}{.6\p@}
\renewcommand{\headstrutheight}{.25\normalbaselineskip}
\DeclareTitleMark{PROCEEDINGS TITLE}{Location}{P.}
\endinput
