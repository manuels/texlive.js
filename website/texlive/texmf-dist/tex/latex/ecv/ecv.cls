%%
%% Copyright 2006-2011 Christoph P. Neumann, Bernd Haberstumpf
%%
%% This LaTeX class provides a simple interface for creating
%% a verfy fancy Curriculum Vitae. At the moment only CVs in
%% the german language are supported.
%%
%% This file is free property; as a special exception the author
%% gives unlimited permission to copy and/or distribute it, with
%% or without modifications, as long as this notice is
%% preserved.
%%
%% This file is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY, to the extent permitted by law;
%% without even the implied warranty of MERCHANTABILITY or
%% FITNESS FOR A PARTICULAR PURPOSE.
%%
%% SPECIAL THANKS to
%% Alexander von Gernler, who introduced me to the European Curriculum Vitae
%%


\def\fileversion{0.3}
\def\filedate{2011/04/18}

\NeedsTeXFormat{LaTeX2e}


\ProvidesClass{ecv}[\filedate %
  \space Version \fileversion\space by %
  Christoph P.\ Neumann & Bernd Haberstumpf %
]


\def\ecv@lang{german}
\def\ecv@german{german}
\def\ecv@english{english}
\DeclareOption{german}{\def\ecv@lang{\ecv@german}}
\DeclareOption{english}{\def\ecv@lang{\ecv@english}}
\DeclareOption{oneside}{\PassOptionsToClass{oneside}{scrartcl}}
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{scrartcl}}
\DeclareOption{selinput}{\def\ecv@selinput{1}}
\DeclareOption{empty}{\def\ecv@empty{1}}
\ProcessOptions


\LoadClass[a4paper,11pt]{article}

\RequirePackage{ifpdf}

\ifpdf
  \pdfcompresslevel=9           % compression level fortext and image;
\fi


\RequirePackage[\ecv@lang]{ecvNLS}

\RequirePackage{ifthen}

\ifpdf
  \RequirePackage[a4paper, pdftex]{geometry}
\else
  \RequirePackage[a4paper, dvips ]{geometry}
\fi

\RequirePackage{longtable}

\RequirePackage{pgf}

\RequirePackage{paralist}

\RequirePackage{helvet}

\RequirePackage{xcolor}

\RequirePackage{fancyhdr}

\ifx\ecv@empty\undefined
\RequirePackage[latin9]{inputenc} % = latin1, but also with euro sign
\else
  \RequirePackage{selinput}
\fi

\RequirePackage[T1]{fontenc}


\RequirePackage{url}
\ifpdf
  \RequirePackage[pdftex]{hyperref} %,pdfstartpage=9
\else
  \RequirePackage[dvips]{hyperref} %ALT: colorlinks
\fi


\geometry{left=30mm, right=20mm, top=20mm, bottom=15mm}

\ifx\ecv@empty\undefined
  \pagestyle{fancy}
\else
  \pagestyle{empty}
\fi

\definecolor{ecv@ColBlue}{rgb}{0.04,0.44,0.59}   % ANPA 732-0, but darker
\definecolor{ecv@ColRed}{rgb}{0.921,0.282,0.278} % ANPA 723-0

\ClassInfo{ecv}{used language is \ecv@lang}

\newcommand{\ecv@name}{}

\AtBeginDocument{%
  \sffamily
  \raggedbottom
  \fancyhead{}
  \fancyfoot{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyfoot[R]{
    \begin{minipage}{5cm}\begin{flushright}
      \footnotesize{}\textsf{\ecvPage~\thepage}
    \end{flushright}\end{minipage}
  }
  \ifthenelse{\equal{\ecv@name}{}}{
    ~
  }{
    \fancyfoot[L]{
      \begin{minipage}{6cm}
        \footnotesize{}\textsf{\ecvTitle~\ecv@name}
      \end{minipage}
    }
  }
}

\newcommand\ecv@Portrait[1]{%
  %% A frame as placeholder (with  some 1mm inner padding):
  \pgfrect[stroke]{\pgfxy(6.85,0.65)}{\pgfxy(4.3,-6.3)}
  %% Actually a concrete digital image:
  \pgfdeclareimage[interpolate=true,height=60mm,width=40mm]{portrait}{#1}
  \pgfputat{\pgfxy(6.77,0.5)}{\pgfbox[left,top]{\pgfuseimage{portrait}}}
}

\newcommand\ecv@img{}

\newcommand{\ecv@Title}{%
  \ifthenelse{\equal{\ecv@img}{}}{ %
    \ecvLeft{\textsc{\LARGE{\ecvTitle}}%
      \bigskip\bigskip\bigskip%
    } & \tabularnewline %
  }{ %
    \ecvLeft{\textsc{\LARGE{\ecvTitle}}%
      \bigskip\bigskip\bigskip%
    } & \ecv@Portrait{\ecv@img} %
    \tabularnewline %
  } %
}


\newcommand\ecvURL{\begingroup \urlstyle{sf}\Url}
\newcommand\ecvEMail{\begingroup \urlstyle{sf}\Url}
\ifpdf
  \newcommand{\ecvHyperLink}[1]{%
    \href{#1}{\ecvURL{#1}}%
  }
  \newcommand{\ecvHyperEMail}[1]{%
    \href{mailto:#1}{\ecvEMail{#1}}%
  }
  \newcommand{\ecvHttp}[1]{%
    \href{http://#1}{\ecvURL{#1}}%
  }
\else
  \newcommand{\ecvHyperLink}[1]{%
    \ecvURL{#1}%
  }
  \newcommand{\ecvHyperEMail}[1]{%
    \ecvEMail{#1}%
  }
  \newcommand{\ecvHttp}[1]{%
    \ecvURL{#1}%
  }
\fi
\hypersetup{a4paper,pdfpagelayout={SinglePage},pdfstartview={Fit}}
\hyperbaseurl{http://}


\newcommand{\ecvName}[1]{\renewcommand{\ecv@name}{#1}}


\newcommand{\ecvPortrait}[1]{\renewcommand\ecv@img{#1}}


\newenvironment{ecv}{%
  \begin{longtable}{p{.32\linewidth}|p{.68\linewidth}}
  \ecv@Title
}{%
  \end{longtable}
}
\newenvironment{ecv*}{%
  \begin{longtable}{p{.32\linewidth}|p{.68\linewidth}}
}{%
  \end{longtable}
}


\newcommand{\ecvBreaksections}[0]{& \tabularnewline[6pt]}
\newcommand{\ecvBreaksubsections}[0]{& \tabularnewline\smallskip}
\newcommand{\ecvBreakparagraphs}[0]{& \tabularnewline}


\newcommand{\ecvNewLine}[0]{\\}
\newcommand{\ecvNewPara}[0]{\smallskip}


\newcommand{\ecvNewPage}{
  \newpage
}
\newcommand{\ecvPageBreak}{
  \pagebreak
}

\newcommand{\ecvBold}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \textbf{#2}%
  }{}%
}

\newcommand{\ecvBulleted}[1]{$\circ$ #1}
\newcommand{\ecvBulletedFirst}[1]{%
  \textcolor{ecv@ColBlue}{$\triangleright$} #1%
}


\newcommand{\ecvLeft}[1]{%
  \parbox[t]{\linewidth}{\raggedright #1}%
}
\newcommand{\ecvRight}[1]{%
  %\parbox[t]{\linewidth}{
  {\raggedright #1}%
  \tabularnewline%
}
\newcommand{\ecvRightBlock}[1]{%
  \parbox[t]{0.9\linewidth}{#1}%
  \tabularnewline%
}


\newcommand{\ecvTP}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvLeft{#2}%
  }{}%
}
\newcommand{\ecvTagPlain}[2][\ecv@lang]{\ecvTP[#1]{#2}}
\newcommand{\ecvTF}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvBreakparagraphs
    \smallskip
    \ecvLeft{\ecvBulletedFirst{#2}}%
  }{}%
}
\newcommand{\ecvTagFirst}[2][\ecv@lang]{\ecvTF[#1]{#2}}
\newcommand{\ecvTI}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvLeft{\ecvBulletedFirst{#2}}%
  }{}%
}
\newcommand{\ecvTagIntermediate}[2][\ecv@lang]{\ecvTI[#1]{#2}}
\newcommand{\ecvTN}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvLeft{\ecvBulleted{#2}}%
  }{}%
}
\newcommand{\ecvTagNext}[2]{\ecvTN[#1]{#2}}


\newcommand{\ecvVR}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvRight{#2}%
  }{}%
}
\newcommand{\ecvValueRagged}[2][\ecv@lang]{\ecvVR[#1]{#2}}
\newcommand{\ecvVB}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvRightBlock{#2}%
  }{}%
}
\newcommand{\ecvValueBlocked}[2][\ecv@lang]{\ecvVB[#1]{#2}}


\newcommand{\ecvEPR}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvTP[#1]{#2} & \ecvVR[#1]{#3} %
  }{}%
}
\newcommand{\ecvTagPlainValueRagged}[3][\ecv@lang]{\ecvERP[#1]{#2}{#3}}
\newcommand{\ecvEPB}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvTP[#1]{#2} & \ecvVB[#1]{#3} %
  }{}%
}
\newcommand{\ecvTagPlainValueBlocked}[3][\ecv@lang]{\ecvERB[#1]{#2}{#3}}
\newcommand{\ecvEFR}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvTF[#1]{#2} & \ecvVR[#1]{#3} %
  }{}%
}
\newcommand{\ecvTagFirstValueRagged}[3][\ecv@lang]{\ecvEFR[#1]{#2}{#3}}
\newcommand{\ecvEFB}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvTF[#1]{#2} & \ecvVB[#1]{#3} %
  }{}%
}
\newcommand{\ecvTagFirstValueBlocked}[3][\ecv@lang]{\ecvEFB[#1]{#2}{#3}}
\newcommand{\ecvEIR}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvTI[#1]{#2} & \ecvVR[#1]{#3} %
  }{}%
}
\newcommand{\ecvTagIntermediateValueRagged}[3][\ecv@lang]{\ecvEIR[#1]{#2}{#3}}
\newcommand{\ecvEIB}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvTI[#1]{#2} & \ecvVB[#1]{#3} %
  }{}%
}
\newcommand{\ecvTagIntermediateValueBlocked}[3][\ecv@lang]{\ecvEIB[#1]{#2}{#3}}
\newcommand{\ecvENR}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvTN[#1]{#2} & \ecvVR[#1]{#3} %
  }{}%
}
\newcommand{\ecvTagNextValueRagged}[3][\ecv@lang]{\ecvENR[#1]{#2}{#3}}
\newcommand{\ecvENB}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvTN[#1]{#2} & \ecvVB[#1]{#3} %
  }{}%
}
\newcommand{\ecvTagNextValueBlocked}[3][\ecv@lang]{\ecvENB[#1]{#2}{#3}}
\newcommand{\ecvOVR}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    & \ecvVR[#1]{#2} %
  }{}%
}
\newcommand{\ecvOnlyValueRagged}[2][\ecv@lang]{\ecvOVR[#1]{#2}}
\newcommand{\ecvOVB}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    & \ecvVB[#1]{#2} %
  }{}%
}
\newcommand{\ecvOnlyValueBlocked}[2][\ecv@lang]{\ecvOVB[#1]{#2}}


\newcommand{\ecvSec}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvLeft{\textsc{\Large{\textcolor{ecv@ColBlue}{#2}}} \bigskip } &%
    \tabularnewline%
  }{}%
}
\newcommand{\ecvSection}[2][\ecv@lang]{\ecvSec[#1]{#2}}
\newcommand{\ecvBSec}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvBreaksections
    \ecvLeft{\textsc{\Large{\textcolor{ecv@ColBlue}{#2}}} \bigskip } &%
    \tabularnewline%
  }{}%
}
\newcommand{\ecvBreakSection}[2][\ecv@lang]{\ecvBSec[#1]{#2}}
\newcommand{\ecvSub}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvLeft{\textsc{\large{#2}}}%
    & \tabularnewline%
  }{}%
}
\newcommand{\ecvSubSection}[2][\ecv@lang]{\ecvSub[#1]{#2}}
\newcommand{\ecvBSub}[2][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvBreaksubsections
    \ecvLeft{\textsc{\large{#2}}}%
    & \tabularnewline%
  }{}%
}
\newcommand{\ecvBreakSubSection}[2][\ecv@lang]{\ecvBSub[#1]{#2}}
\newcommand{\ecvERSub}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvLeft{\textsc{\large{#2}}} & \ecvRight{#3}%
  }{}%
}
\newcommand{\ecvEntryRaggedSubSection}[3][\ecv@lang]{\ecvERSub[#1]{#2}{#3}}
\newcommand{\ecvBERSub}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvBreaksubsections
    \ecvLeft{\textsc{\large{#2}}} & \ecvRight{#3}%
  }{}%
}
\newcommand{\ecvBreakEntryRaggedSubSection}[3][\ecv@lang]{\ecvBERSub[#1]{#2}{#3}}
\newcommand{\ecvEBSub}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvLeft{\textsc{\large{#2}}} & \ecvRightBlock{#3}%
  }{}%
}
\newcommand{\ecvEntryBlockedSubSection}[3][\ecv@lang]{\ecvEBSub[#1]{#2}{#3}}
\newcommand{\ecvBEBSub}[3][\ecv@lang]{%
  \ifthenelse{\equal{#1}{\ecv@lang}}{%
    \ecvBreaksubsections
    \ecvLeft{\textsc{\large{#2}}} & \ecvRightBlock{#3}%
  }{}%
}
\newcommand{\ecvBreakEntryBlockedSubSection}[3][\ecv@lang]{\ecvBEBSub[#1]{#2}{#3}}


\newcommand{\ecvSig}[2]{ %
  \vspace{1cm}
  \noindent
  #2, \today \\[18pt]

  #1
}
\newcommand{\ecvSignature}[2]{\ecvSig{#1}{#2}}
\endinput
%%
%% End of file `ecv.cls'.
