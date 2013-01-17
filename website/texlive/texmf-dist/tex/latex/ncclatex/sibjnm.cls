\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{sibjnm}
         [2005/01/11 v1.06 Article class for SibJNM (NCC)]
%
% \changes{v1.01}{2002/03/24}{This version is uploaded to CTAN}
% \changes{v1.02}{2004/04/08}{Fix bug with using russian option}
% \changes{v1.03}{2004/09/23}{In english mode load nccltrus instead of babel}
% \changes{v1.03}{2004/09/23}{Remove unnecessary \frenchspacing}
% \changes{v1.04}{2004/09/30}{Bug with omitted \@thanks fixed}
% \changes{v1.05}{2004/12/06}{Replace \NCC@null with \StartFromTextArea}
% \changes{v1.06}{2005/01/11}{Remove small, fleqn, and leqno options}
%
\DeclareOption{a5paper}{\OptionNotUsed}
\DeclareOption{a5a4paper}{\OptionNotUsed}
\DeclareOption{b5paper}{\OptionNotUsed}
\DeclareOption{letterpaper}{\OptionNotUsed}
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{fittopage}{\OptionNotUsed}
\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{14pt}{\OptionNotUsed}
\DeclareOption{oneside}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{openbib}{\OptionNotUsed}
\DeclareOption{preprint}{\OptionNotUsed}
\DeclareOption{monography}{\OptionNotUsed}
\DeclareOption{report}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ncc}}
\PassOptionsToClass{11pt,twoside,onecolumn,article,a4paper}{ncc}
\ProcessOptions\relax
\LoadClass{ncc}
%
% Text area size
%
\ToCenter[h]{155mm}{225mm}
%
% Change TeX parameters
%
\setlength\smallskipamount{2pt plus 1pt minus .5pt}
\setlength\medskipamount  {4pt plus 1pt minus .5pt}
\setlength\bigskipamount  {8pt plus 1pt minus .5pt}
\setlength\floatsep      {12pt plus 1pt minus .5pt}
\setlength\textfloatsep  {12pt plus 1pt minus .5pt}
\setlength\intextsep     {\floatsep}
%
% Centered sections with indentation after them
%
\sectionstyle{center}
\indentaftersection
%
% Russian and English abstracts
%
\ifNCC@rus
  \def\UDCname{{\cyr\CYRU\CYRD\CYRK}}
  %
  %  Rabstract and Eabstract
  %
  \newenvironment{Rabstract}{\par\addvspace\bigskipamount
    {\footnotesize\noindent \UDCname~\SJNM@UDC}\par\smallskip
    \SJNM@abstr{\SJNM@Rname}%
  }{\par\addvspace{1.5\bigskipamount}}
  \newenvironment{Eabstract}{\par\addvspace\bigskipamount
    \begin{otherlanguage*}{english}\SJNM@abstr{\SJNM@Ename}%
  }{\par\end{otherlanguage*}%
    \smallskip{\centering\rule\linewidth{.5pt}\par}%
    \addvspace{1.5\bigskipamount}%
  }
\else
  \RequirePackage[russian,english]{nccltrus}
  \def\UDCname{UDC}
  %
  %  Rabstract and Eabstract
  %
  \newenvironment{Rabstract}{\par\addvspace\bigskipamount
    {\footnotesize\noindent \UDCname~\SJNM@UDC}\par\smallskip
    \begin{otherlanguage*}{russian}\SJNM@abstr{\SJNM@Rname}%
  }{\par\end{otherlanguage*}%
    \addvspace{1.5\bigskipamount}%
  }
  \newenvironment{Eabstract}{\par\addvspace\bigskipamount
    \SJNM@abstr{\SJNM@Ename}%
  }{\par\smallskip{\centering\rule\linewidth{.5pt}\par}%
    \addvspace{1.5\bigskipamount}%
  }
\fi
%
% \SJNM@Rname and \SJNM@Ename are brief journal titles used in abstracts.
% They are defined in the local definition file sibjnm.def.
%
\let\SJNM@Rname\@empty
\let\SJNM@Ename\@empty
\newcommand*\SJNM@abstr[3]{%
  {\hbadness=4000 \pretolerance=1000 {\bf #2} #3~// #1\par}%
  \bigskip\footnotesize
}
%
% UDC or AMS Subject Classification can be used in articles.
%
\newcommand*\UDC[1]{\def\SJNM@UDC{#1}}
\newcommand\AmSclassification{%
  \def\UDCname{\AmS\ subject classification:\,}%
  \let\AmSclassification\UDC
  \UDC
}
%
% Redefine title making command
%
\def\@maketitle{%
  \StartFromTextArea\vskip 2em \centering
  {\LARGE\bff \@title \par} \vskip 1.5em 
  {\large\sf \lineskip .5em \pbox{\@author}\par}%
  \@thanks
}
\RequirePackage[title,myheadings]{ncchdr}
\def\NCC@articlehead{\thispagestyle{title}}
%
% Defaults
%
\UDC{???}
\renewcommand{\headrulewidth}{\p@}
\renewcommand{\headstrutheight}{.2\normalbaselineskip}
\InputIfFileExists{sibjnm.def}{}{}% Load a file of local definitions
\endinput
