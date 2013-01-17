%\iffalse (Meta-Kommentar)
% Eine Klasse zur Erstellung von Tibetischen Texten mit \TibTeX
% \fi
% \title{Eine \LaTeX2e~Klasse zur Erstellung tibetischer Texte mit \TibTeX}
% \author{Dieter Jäger}
% Version 0.1 - 10.11.2004
% Copyright 2004 by Dieter Jäger
% License: GPL

\ProvidesClass{pecha}[2004/11/10 v0.1 Tibetan Pecha document class]
\NeedsTeXFormat{LaTeX2e}
% Tibetan language package
\RequirePackage{ctib}

% This is needed to be able to do the margin texts
\RequirePackage{rotating}


% Set page dimensons
% All the page sizes from the standard classes
% But a5 or b5 may not be very usefull

\DeclareOption{a4pecha3}
   {\setlength\paperwidth {297mm}
    \setlength\paperheight {70mm}}
\DeclareOption{a4pecha2}
   {\setlength\paperwidth {297mm}
    \setlength\paperheight {140mm}}
\DeclareOption{a4paper}
   {\setlength\paperwidth {297mm}%
    \setlength\paperheight  {210mm}}
\DeclareOption{a5pecha3}
   {\setlength\paperwidth {210mm}%
    \setlength\paperheight  {47mm}}
\DeclareOption{a5pecha2}
   {\setlength\paperwidth {210mm}%
    \setlength\paperheight  {74mm}}
\DeclareOption{a5paper}
   {\setlength\paperwidth {210mm}%
    \setlength\paperheight  {148mm}}
\DeclareOption{b5pecha3}
   {\setlength\paperwidth {250mm}%
    \setlength\paperheight  {49.3mm}}
\DeclareOption{b5pecha2}
   {\setlength\paperwidth {250mm}%
    \setlength\paperheight  {74mm}}
\DeclareOption{b5pecha3}
   {\setlength\paperwidth {250mm}%
    \setlength\paperheight  {58.67mm}}
\DeclareOption{b5pecha2}
   {\setlength\paperwidth {250mm}%
    \setlength\paperheight  {88mm}}
\DeclareOption{b5paper}
   {\setlength\paperwidth {250mm}%
    \setlength\paperheight  {176mm}}
\DeclareOption{letterpecha3}
   {\setlength\paperwidth {11in}%
    \setlength\paperheight  {2.83in}}
\DeclareOption{letterpecha2}
   {\setlength\paperwidth {11in}%
    \setlength\paperheight  {4.25in}}
\DeclareOption{letterpaper}
   {\setlength\paperwidth {11in}%
    \setlength\paperheight  {8.5in}}
\DeclareOption{legalpecha3}
   {\setlength\paperwidth {14in}%
    \setlength\paperheight  {2.83in}}
\DeclareOption{legalpecha2}
   {\setlength\paperwidth {14in}%
    \setlength\paperheight  {4.25in}}
\DeclareOption{legalpaper}
   {\setlength\paperwidth {14in}%
    \setlength\paperheight  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperwidth {10.5in}%
    \setlength\paperheight  {2.42in}}
\DeclareOption{executivepaper}
   {\setlength\paperwidth {10.5in}%
    \setlength\paperheight  {3.625in}}
\DeclareOption{executivepaper}
   {\setlength\paperwidth {10.5in}%
    \setlength\paperheight  {7.25in}}

% This is from the book class
% May be changed in future ...
\newcommand\@ptsize{0}
\DeclareOption{8pt}{\renewcommand\@ptsize{8}}
\DeclareOption{9pt}{\renewcommand\@ptsize{9}}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

%\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
%\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
%\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
%\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
%\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
%\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
%\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
%\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
%\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}


% option "rotate", standard: do not do that
% If set the class will rotate the even pages by 180 degrees
\newif\if@pecharotate
\@pecharotatefalse

% standard page frame, using double lines
\def\@pageframe#1{\@doubleframe{#1}}
\newif\if@fsingle
\@fsinglefalse
\newif\if@ffancy
\@ffancyfalse

\newlength\@rulers

\DeclareOption{rotate}{\@pecharotatetrue}
\DeclareOption{fancyframe}{
  \global\@fsingletrue\global\@ffancytrue
  \global\def\@pageframe#1{\@fancyframe{#1}}
}
\DeclareOption{doubleframe}{\@fsinglefalse \global\@rulers=9.2pt \global\def\@pageframe#1{\@doubleframe{#1}}}
\DeclareOption{simplefram}{\global\@rulers=1.6pt \global\def\@pageframe#1{\@fsingletrue \@singleframe{#1}}}

% The pageheight can be adjusted a little bit
\newlength\pecha@pheight
\DeclareOption{narrowpage}{\setlength\pecha@pheight{26ex}}
\DeclareOption{mediumpage}{\setlength\pecha@pheight{28ex}}
\DeclareOption{widepage}{\setlength\pecha@pheight{33ex}}
\DeclareOption{extrawide}{\setlength\pecha@pheight{36ex}}

\newif\if@septitle
\@septitlefalse
\DeclareOption{septitle}{\global\@septitletrue}

\ExecuteOptions{doubleframe,letterpaper,10pt,mediumpage}
\ProcessOptions


\renewcommand{\baselinestretch}{0.7}
\ifnum\@ptsize < 3
   \input{bk1\@ptsize.clo}
   \setlength\lineskip{1\p@}
   \setlength\normallineskip{1\p@}
%   \renewcommand\baselinestretch{}
   \setlength\parskip{0\p@ \@plus \p@}
\else
   \input{size\@ptsize.clo}
   \setlength\lineskip{\p@}
   \setlength\normallineskip{\p@}
%   \renewcommand\baselinestretch{}
   \setlength\parskip{\p@}
\fi


\ifx\pdftexversion\undefined
  \special{papersize=\the\paperwidth,\the\paperheight}
  \special{! /landplus90 true store}
\else
  \setlength\pdfpagewidth{\paperwidth}
  \setlength\pdfpageheight{\paperheight}
  \RequirePackage{times}
\fi

\setlength{\textheight}{\pecha@pheight}

\newlength{\@marginht}
\newlength{\@margindp}
\newlength{\@marginsep}

\newlength{\@pechadim}
\newlength{\@titledim}
\newlength{\@pechawidth}
\newlength{\@@textwidth} % speichert Textbreit für fancy
\newlength{\@titlewidth}
\newlength{\pechamargin}
\setlength{\pechamargin}{0.6in}

\newcounter{pechasheet}
\setcounter{pechasheet}{\@ne}
\@marginht 3ex
\@margindp 1ex

\@pechadim 6em % Abstand zu den Rändern
\advance\@pechadim by \@rulers % Summe der dicke aller vertikalen Linien
\advance\@pechadim by 2\@marginht % Höhe der Randboxen
\advance\@pechadim by 2\@margindp % Tiefe der Randboxen

\textwidth\paperwidth
\advance\textwidth by - 2\pechamargin % Abstand zu Papierrand, 0.6in beidseitig
\@pechawidth\textwidth
\@titledim 0.2\textwidth
\advance\textwidth by - \@pechadim

\@titlewidth\textwidth
\advance\@titlewidth by - \@titledim

\@@textwidth=\textwidth
\if@ffancy
  \advance\textwidth by - 12em % fancy Rahmen haben breite Ränder
\fi

\headheight 0pt
\headsep 0pt
\marginparsep 0pt
\marginparwidth 0pt
\footskip 0pt
\marginparpush 0pt

\topmargin \paperheight
\advance\topmargin by - \textheight
\advance\topmargin by -0.5 \topmargin
\advance\topmargin by - 1.1in
%\advance\topmargin by - 1.2in

\oddsidemargin \paperwidth
\advance \oddsidemargin by - \@pechawidth
\advance \oddsidemargin by - 0.5 \oddsidemargin
%\advance \oddsidemargin by - 1in
\advance \oddsidemargin by - 1.5\pechamargin
\evensidemargin \oddsidemargin

\pagenumbering{arabic}
\sloppy
%\raggedright
\parindent=0pt
\parskip12pt

% Some dimensons I will need

\newbox\@pbox
\newbox\@obox



% Some usefull and simple macros
\newcommand{\tibsmall}[1]{{\footnotesize \begin{tib} #1\end{tib}}}


% Translate numerals from 1 to 99 into words
% numeraly >=100 stay as is 
\def\tibnumeral#1{
\ifnum #1<100
  \ifcase #1
  % 1-10
    \or gcig \or gnyis \or gsum \or bzhi \or lnga
    \or drug \or bdun  \or b-rgyad \or dgu
    \or bcu
  % 11-20
    \or {bcu gcig} \or {bcu gnyis} \or {bcu gsum} \or {bcu bzhi} \or {bco lnga}
    \or {bcu drug} \or {bcu bdun} \or {bco b-rgyad} \or {bcu dgu} \or {nyi zhu}
  % 21 - 30
    \or {nyi zhu tsa gcig} \or {nyi zhu tsa gnyis} \or {nyi zhu tsa gsum}
    \or {nyi zhu tsa bzhi} \or {nyi zhu tse lnga} \or {nyi zhu tsa drug}
    \or {nyi zhu tsa bdun} \or {nyi zhu tsa b-rgyad} \or {nyi zhu tsa dgu}
    \or {gsum bcu}
  % 31 - 40
    \or {gsum bcu so gcig} \or {gsum bcu so gnyis} \or {gsum bcu so gsum}
    \or {gsum bcu so bzhi} \or {gsum bcu so lnga} \or {gsum bcu so drug}
    \or {gsum bcu so bdun} \or {gsum bcu so b-rgyad} \or {gsum bcu so dgu}
    \or {bzhi bcu}
  % 41 - 50
    \or {bzhi bcu zhe gcig} \or {bzhi bcu zhe gnyis} \or {bzhi bcu zhe gsum}
    \or {bzhi bcu zhe bzhi} \or {bzhi bcu zhe lnga} \or {bzhi bcu zhe drug}
    \or {bzhi bcu zhe bdun} \or {bzhi bcu zhe b-rgyad} \or {bzhi bcu zhe dgu}
    \or {lnga bcu}
  % 51 - 60
    \or {lnga bcu nga gcig} \or {lnga bcu nga gnyis} \or {lnga bcu nga gsum}
    \or {lnga bcu nga bzhi} \or {lnga bcu nge lnga} \or {lnga bcu nga drug}
    \or {lnga bcu nga bdun} \or {lnga bcu nga b-rgyad} \or {lnga bcu nga dgu}
    \or {drug bcu}
  % 61 - 70
    \or {drug bcu re gcig} \or {drug bcu re gnyis} \or {drug bcu re gsum}
    \or {drug bcu re bzhi} \or {drug bcu re lnga} \or {drug bcu re drug}
    \or {drug bcu re bdun} \or {drug bcu re b-rgyad} \or {drug bcu re dgu}
    \or {bdun bcu}
  % 71 - 80
    \or {bdun bcu don gcig} \or {bdun bcu don gnyis} \or {bdun bcu don gsum}
    \or {bdun bcu don bzhi} \or {bdun bcu don lnga} \or {bdun bcu don drug}
    \or {bdun bcu don bdun} \or {bdun bcu don b-rgyad} \or {bdun bcu don dgu}
    \or {b-rgyad bcu}
  % 81 -90
    \or {b-rgyad bcu rgya gcig} \or {b-rgyad bcu rgya gnyis}
    \or {b-rgyad bcu rgya gsum}
    \or {b-rgyad bcu rgya bzhi} \or {b-rgyad bcu rgya lnga}
    \or {b-rgyad bcu rgya drug}
    \or {b-rgyad bcu rgya bdun} \or {b-rgyad bcu rgya b-rgyad}
    \or {b-rgyad bcu rgya dgu}
    \or {dgu bcu}
  % 91 - 99
    \or {dgu bcu go gcig} \or {dgu bcu go gnyis} \or {dgu bcu go gsum}
    \or {dgu bcu go bzhi} \or {dgu bcu go lnga} \or {dgu bcu go drug}
    \or {dgu bcu go bdun} \or {dgu bcu go b-rgyad} \or {dgu bcu go dgu}
  \fi
\else
  #1
\fi
}

% Makros to create the right and left margin texts

\def\@oleft{}
\def\@@oleft{}
\def\@eleft{}
\def\@eright{}
\def\@oright{}
\def\@oddright{}
\def\@evenright{}
\def\@evenleft{}
\def\@oddleft{}
\def\@theleft{}
\def\@theright{}

\newcommand{\oddleft}[2]{\global\def\@oleft{#1}\global\def\@@oleft{#2}}
\newcommand{\oddright}[1]{\global\def\@oright{#1}}
\newcommand{\evenleft}[1]{\global\def\@eleft{#1}}
\newcommand{\evenright}[1]{\global\def\@eright{#1}}


% Print a title page (default: none)
\newif\if@pechatitle
\@pechatitlefalse


% Title page (similar to book.cls)
\def\title#1{\gdef\@title{#1}}
\def\@title{\@latex@error{No \noexpand\title given}\@ehc}

% vertical double line
\def\@doubleruler{\vrule\kern1.5pt\vrule}


% ignore standard chapter marks
\newcommand{\paragraph}[1]{}
\newcommand{\subparagraph}[1]{}
\newcommand{\section}[1]{\medskip}
\newcommand{\subsection}[1]{}
\newcommand{\subsubsection}[1]{}
\newcommand{\chapter}[1]{\bigskip}
\newcommand{\part}[1]{\bigskip}

\newcommand{\newsheet}{\clearpage\ifodd\c@page\else
    \hbox{}\newpage\fi}

% Titlepage environment
\newenvironment{titlepage}{%
  \newsheet
  \setcounter{page}\@ne
}%
{%
  \if@septitle 
    \newsheet
    \setcounter{page}\@ne
    \setcounter{pechasheet}{\@ne}
  \else
    \newpage
  \fi
}

% Print a title page with the typical frame
\newcommand{\maketitle}
{
  \global\@pechatitletrue
  \setbox\@pbox\hbox{\parbox{\@titlewidth}{\begin{center}\@title\par\end{center}}}
  % Beautify short titles
  %\ifdim\ht\@pbox < 2.5ex \ht\@pbox=2.5ex \dp\@pbox=1.25ex\fi
  % Calculate offsets to center the title page
  \setlength\@tempdima{\textwidth}
  \advance\@tempdima by - 12pt
  \advance\@tempdima by - 10em
  \advance\@tempdima by - \wd\@pbox
  \advance\@tempdima by - 0.5\@tempdima
  \ifdim\@tempdima < 0em \setlength\@tempdima{0em}\fi
  \setlength\@tempdimb{\textheight}
  \advance\@tempdimb - 4pt
  \advance\@tempdimb - 5em
  \advance\@tempdimb by - \ht\@pbox
  \advance\@tempdimb by - \dp\@pbox
  \advance\@tempdimb by - 0.5 \@tempdimb
  \ifdim\@tempdimb < 0em \setlength\@tempdimb{0em}\fi
  \begin{titlepage}
    \hbox{
    \kern\@tempdima
    \vbox{%
      \kern\@tempdimb
      \hrule
      \hbox{%
        \vrule\kern1.5pt
        \vbox{\kern1.5pt\hrule
          \hbox{\vrule
            \if@septitle
              \kern2em
            \else
              \pecha@numtitle
            \fi
            \vbox{\kern2.5em\hrule
              \hbox{\vrule\kern1.5pt
                \vbox{\kern1.5pt\hrule
                  \hbox{\vrule\kern4em\@doubleruler\kern2em\@doubleruler
                    \kern1em\box\@pbox\kern1ex
                 \@doubleruler\kern2em\@doubleruler\kern4em\vrule
               }
               \hrule\kern1.5pt}\kern1.5pt\vrule
             }\hrule\kern2.5em
           }\kern2.5em\vrule
         }\hrule\kern1.5pt
       }\kern1.5pt\vrule
     }\hrule\vfill
   }\hfill
   }
  \end{titlepage}
}

% print sheet number on title page

\def\pecha@numtitle{
  \setlength{\@tempdimc}{\textheight}
  \advance \@tempdimc by - 2\@tempdimb
  \advance \@tempdimc by - 1em
  \if@septitle
  \else
  \setbox\@obox\hbox{
    \hbox to \@tempdimc{
      \scriptsize\tib\@oleft~\hss\tib\tibnumeral{\thepechasheet}\hss\@@oleft
  }}
  \ht\@obox=\@marginht
  \dp\@obox=\@margindp
  \kern\dp\@obox
  \begin{turn}{-90}
     \kern-\@tempdimc\kern-0.8em\box\@obox
  \end{turn}
  \fi
}

\def\pecha@titlepage#1{
  \box#1
  \global\@pechatitlefalse
}


% The left "header" on odd pages
\def\@oddleft{%
  \setbox\@pbox\hbox{
      \hbox to \textheight{
        \scriptsize\tib\@oleft\hss\tib\tibnumeral{\thepechasheet}\hss\@@oleft
      }}
  \ht\@pbox=\@marginht
  \dp\@pbox=\@margindp
  \begin{turn}{-90}
    \kern-\textheight\kern-1em\box\@pbox
  \end{turn}
}

% the left "header" on even pages
\def\@evenleft{%
  \setbox\@pbox\hbox{
      \hskip-\textheight\kern-1em\hbox to \textheight{
        \scriptsize\tib\hss\@eleft\hss
      }
    }
  \ht\@pbox=\@marginht
  \dp\@pbox=\@margindp
  \begin{turn}{-90}
    \box\@pbox
  \end{turn}
}

% The right "header" on odd pages
\def\@oddright{%
  \setbox\@pbox\hbox{
    \hbox to \textheight{
      \footnotesize\hss\kern1em\@oright\hss}}
  \ht\@pbox=\@marginht
  \dp\@pbox=\@margindp
  \begin{turn}{90}
    \box\@pbox
  \end{turn}
}

% The right "header" on even pages
\def\@evenright{%
  \setbox\@pbox\hbox{
    \hbox to \textheight
      {\footnotesize\hss\kern1em\@eright\hss}}
  \ht\@pbox=\@marginht
  \dp\@pbox=\@margindp
  \begin{turn}{90}
    \box\@pbox
  \end{turn}
}

% The left "header" on odd pages
\def\@oddfancy{
  \setbox\@pbox\hbox{
      \hbox to \textheight{
        \footnotesize\tib\@oleft\hss\tibnumeral{\thepechasheet}\hss\@@oleft
      }}
  \ht\@pbox=\@marginht
  \dp\@pbox=\@margindp
  \begin{turn}{-90}
    \hskip-\textheight\kern-1em\box\@pbox
  \end{turn}
}

% the left "header" on even pages
\def\@evenfancy{
  \setbox\@pbox\hbox{
      \hskip-\textheight\kern-1em\hbox to \textheight{
        \footnotesize\tib\hss\@eleft\hss\
      }
    }
  \ht\@pbox=\@marginht
  \dp\@pbox=\@margindp
  \begin{turn}{-90}
    \box\@pbox
  \end{turn}

}


% section{Die Ausgabefunktionen}
% Um die Pecha-typischen Textrahmen zu erzeugen, wurde die
% LaTeX Ausgaberoutine umgeschrieben.
% Kopf- und Fußzeilen machen bei Pechas keinen Sinn,
% deshalb werden sie ausgelassen.
% Dafür übernehmen die linken und rechten Ränder
% eine ähnliche Funktion.
%
% Klassenoptionen:
% Seiten können derzeit in drei unterschiedlichen
% Stilen ausgegeben werden:
% Mit folgenden Klassenoptionen kann die Ausgabe
% beeinflußt werden:
% doubleframe
% Wird von dieser Klasse als Standardrahmen verwendet.
% Der Textrahmen besteht aus einer Doppellinie.
% singleframe
% Entspricht eher dem originalen tibetischen Stil:
% Der Text wird von einem einfachen Textrahmen umgeben.
% fancyframe
% Diese Option kann mit einer der vorangehenden Optionen
% kombiniert werden. Sie bewirkt, daß die ersten drei
% Seiten von einem besonderen Rahmen umgeben werden. 
% Die restlichen Seiten werden mit doppeltem oder 
% einfachen Rahmen ausgegeben.
%
% Die Seiten werden mit Hilfe des geometry-Pakets korrekt
% auf die Mitte des Blattes positioniert.
% Auch der linke Offset für die Buchbindung
% muß wieder abgezogen werden, damit die Seiten
% auf Vor- und Rückseite gleich positioniert werden.
%
% Das Paket "rotating" wird benutzt, um die
% Randzeilen hochkant darzustellen.
% Außerdem ermöglicht die Klassenoption "rotate" es,
% jede gerade Seite um 180 Grad gedreht darzustellen,
% was beim Ausdruck auf Duplexdruckern hilfreich sein kann.

% |@doubleframe|
% Dieses Makro erzeugt einen pechatypischen Doppelrahmen
% um die Textbox in Argument #1
\def\@doubleframe#1{
  \hbox{\vrule %left outer line
    \vbox{\hrule\kern1.5pt % top outer line
      \hbox{\kern1.5pt\vrule % left inner line
        \vbox{\hrule % top inner line
          \hbox{
          \vbox{
            \hbox{
              \@theleft % left box content
              \@doubleruler\kern0.5em % left box inner margin
              \vbox{
                \kern1.5ex
                \box#1
                \kern1.5ex
              }
              %\kern0.5em 
              \@doubleruler % right box inner margin
              \@theright}
            } % right box content
          }\hrule % right inner line
        }\vrule\kern1.5pt % lower inner line
      }\kern1.5pt\hrule % right outer line
    }\vrule % lower outer line
  }
}

% |@singleframe|
% Dieses Makro erzeugt einen pechatypischen einfachen Rahmen
% um die Textbox in Argument #1

\def\@singleframe#1{
  \hbox{\vrule
        \vbox{\hrule
          \hbox{
          \vbox{
            \hbox{
            \@theleft
            \vrule\kern0.5em
            \vbox{
              \kern1.5ex
              \box#1
              \kern1.5ex
            }
            %\kern0.5em
            \vrule
            \@theright}}
          }\hrule
        }\vrule
  }
}

% |@fancyframe|
% Dieses Makro erzeugt einen pechatypischen Rahmen
% um die Textbox in Argument #1.
% Hier wird auf den ersten ein besonderer Rahmen erstellt,
% alle folgenden Seiten werden je nach Option (simple,fancy oder
% standard,fancy) in einem einfachen oder einem doppelten Rahmen
% ausgegeben.
\def\@fancyframe#1{
%  \ifnum\thepage > 2
%    \global\@ffancyfalse
%    \if@fsingle
%      \global\def\@pageframe{\@singleframe#1}
%    \else
%      \global\def\@pageframe{\@doubleframe#1}
%    \fi
%    \global\addtolength\textwidth{-12em}
%    \global\addtolength\linewidth{-12em}
%  \fi
  \hbox{\vrule
    \vbox{\hrule\kern1.5pt
      \hbox{\kern1.5pt\vrule
        \vbox{\hrule\kern2em
          \hbox{
            \ifodd\c@page
              \@oddfancy
            \else
              \@evenfancy
            \fi
            \vrule
            \vbox{\hrule\kern1.5pt
              \hbox{\kern1.5pt
                \vrule
                \vbox{
                  \hrule
                  \hbox{
                    \kern4em\@doubleruler\kern2em\@doubleruler\kern0.5em
                    \vbox{
		    %\kern0.5em
                    \box#1}
                    \@doubleruler\kern2em\@doubleruler\kern4em
                  }
                  \hrule
                }\vrule\kern1.5pt
              }\kern1.5pt\hrule
            }\vrule\kern2em
          }\kern2em\hrule
        }\vrule\kern1.5pt
      }\kern1.5pt\hrule
    }\vrule
  }
}


% |pecha@outputpage|
% Das ist die neu geschriebene Ausgaberoutine
% Derzeit kann sie folgendes:
% Ausgabe einer Titelseite (muß beim Pecha von hier aus geschehen)
% Ausgabe einer einfachen Textseite mit beliebigem Inhalt im
% Pecha-Doppelrahmen
% Ausgabe der linken Randzeilen im Pecha-Stil
% Ausgabe von rechten Randzeilen, voreingestellt
% auf die Seitennummer. Man kann geradseitige und
% ungeradseitige rechte können mit den Makros
% |\oddright| und |\evenright| unabhängig von einander
% eingestellt werden.

\def\@outputpage{\pecha@outputpage}

\def\pecha@outputpage{%
  \begingroup
    \let\protect\noexpand
    \set@typeset@protect % otherwise fonts cannot be changed here
    \reset@font
    \normalsize
    \normalsfcodes
    \@parboxrestore
    % a hack for empty pages: These need to be framed properly
    \ifodd\count\z@ 
         \let\@themargin\oddsidemargin
    \else 
         \let\@themargin\evensidemargin
      \fi
    \setbox\@outputbox\vbox{\hfil\box\@outputbox\hfil}
    \if@pechatitle
      \setbox\@outputbox\hbox{\pecha@titlepage{\@outputbox}}
    \else
      \ifodd\c@page
        \let\@theleft\@oddleft
        \let\@theright\@oddright
        \setbox\@outputbox\hbox{\@pageframe{\@outputbox}}
      \else
        \let\@theleft\@evenleft
        \let\@theright\@evenright
        \if@pecharotate
          \setbox\@outputbox\hbox{%
          %\hskip3pt %I don't know why I do need this!
          \begin{turn}{180}
            \@pageframe{\@outputbox}
          \end{turn}
          }
        \else
          \setbox\@outputbox\hbox{\@pageframe{\@outputbox}}
        \fi
        \stepcounter{pechasheet}
      \fi
    \fi
    \shipout\vbox{%
    \let\label\@gobble
    \let\index\@gobble
    \let\glossary\@gobble
    \baselineskip \footskip
    \@begindvi
    \vskip \topmargin 
    \moveright\@themargin
    \box\@outputbox
  }
  \set@typeset@protect
  \endgroup
  \stepcounter{page}%
}

\endinput

