
% Rolf Niepraschk <Rolf.Niepraschk@ptb.de>
%
% This file may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in:
%
%    http://www.latex-project.org/lppl.txt
%
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.

\errorcontextlines=100

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{image-gallery}[2007/10/04 v1.0j image gallery -- RN]
\DeclareOption{dummy}{%
  \AtEndOfClass{%
    \renewcommand*\IG@image[2][]{\rule{\IG@width}{\IG@height}}%
    \renewcommand*\IG@fillBox{%
      \textcolor{red}{\rule{\IG@width}{\IG@height}}}%
    \RequirePackage{color}%
  }%
}
\DeclareOption{nocaption}{%
  \AtEndOfClass{%
    \let\IG@@showname\@gobble
    \let\IG@@showtext\@gobble
  }%
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[10pt]{article}

\RequirePackage{graphicx,keyval,url}
\RequirePackage[margin={0mm,0mm},dvips]{geometry}
  
\newcommand*\IG@image[2][]{%
  \let\IG@tempa=\@empty
  \ifIG@autorotate
    \sbox\IG@box{\includegraphics[#1]{#2}}%
    \ifdim\wd\IG@box<\ht\IG@box
      \def\IG@tempa{angle=90,}%
    \fi
    \setbox\IG@box\box\voidb@x
  \fi
  \expandafter\includegraphics\expandafter[\IG@tempa#1]{#2}%
} 

\newcommand*\IG@fillBox{\mbox{\phantom{\rule{\IG@width}{\IG@height}}}}

\newlength\IG@width \newlength\IG@height
\newlength\IG@top \newlength\IG@bottom
\newlength\IG@left \newlength\IG@right
\newif\ifIG@more
\newcommand*\IG@rows{} \newcommand*\IG@columns{}
\newcommand*\IG@tempa{} \newcommand*\IG@imagefile{}
\newread\IG@input
\newsavebox\IG@box
\newif\ifIG@autorotate \IG@autorotatetrue

\define@key{IG}{width}{\setlength\IG@width{#1}}
\define@key{IG}{height}{\setlength\IG@height{#1}}
\define@key{IG}{top}{\setlength\IG@top{#1}}
\define@key{IG}{bottom}{\setlength\IG@bottom{#1}}
\define@key{IG}{left}{\setlength\IG@left{#1}}
\define@key{IG}{right}{\setlength\IG@right{#1}}
\define@key{IG}{rows}{\edef\IG@rows{\number#1}}
\define@key{IG}{columns}{\edef\IG@columns{\number#1}}
\define@key{IG}{autorotate}[true]{\csname IG@autorotate#1\endcsname}

\newcommand*\gallerySetup[1]{%
  \setkeys{IG}{#1}
  \geometry{left=\IG@left,right=\IG@right,top=\IG@top,bottom=\IG@bottom}
}

\newcommand*\IG@showname{}
\newcommand*\IG@alt@name{}

\newcommand*\makeGallery[1]{%
  \begingroup
    \immediate\openin\IG@input=#1\relax
    \IG@moretrue\@tempcnta=\z@\@tempcntb=\@ne
    \endlinechar=\m@ne
    \loop
      \ifeof\IG@input\IG@morefalse\else
        \read\IG@input to\IG@tempa
        \if\IG@tempa\par\else
          \ifx\IG@tempa\@empty\else
            \count@=\z@ \let\IG@alt@name=\@empty
            \@for\reserved@a:=\IG@tempa\do{%
             \ifcase\count@
               \edef\IG@imagefile{\reserved@a}%
             \or
               \protected@edef\IG@alt@name{\reserved@a}%
             \fi
             \advance\count@\@ne
            }%
            \advance\@tempcnta\@ne
            \makebox[\IG@width][c]{%
              \IG@image[width=\IG@width,height=\IG@height,keepaspectratio]%
                {\IG@imagefile}}%
            \ifx\IG@alt@name\@empty
              \edef\@tempa{\IG@imagefile}\let\IG@showname\IG@@showname
            \else
              \def\@tempa{\IG@alt@name}\let\IG@showname\IG@@showtext
            \fi
            \makebox[0pt][c]{%
              \hskip-\IG@width\raisebox{-\ht\strutbox}[0pt][0pt]{%
                \expandafter\IG@showname\expandafter{\@tempa}}}%
            \ifnum\@tempcnta=\IG@columns\relax
              \@tempcnta=\z@ \par
              \ifnum\@tempcntb=\IG@rows\relax
                \@tempcntb=\@ne \newpage
              \else
                \advance\@tempcntb\@ne \vfill
              \fi
            \else
              \hfill
            \fi
          \fi
        \fi
      \fi
    \ifIG@more\repeat
    \immediate\closeout\IG@input
    \IG@moretrue
    \ifnum\@tempcntb=\@ne\else
      \loop
        \advance\@tempcnta\@ne
        \IG@fillBox
        \ifnum\@tempcnta=\IG@columns\relax
          \@tempcnta=\z@ \par
          \ifnum\@tempcntb=\IG@rows\relax
            \@tempcntb=\@ne \IG@morefalse
          \else
            \advance\@tempcntb\@ne \vfill
          \fi
        \else
          \hfill
        \fi
      \ifIG@more\repeat
    \fi
  \endgroup
}

\parindent=\z@ \pagestyle{empty}
\DeclareUrlCommand\IG@@showname{\urlstyle{same}}
\let\IG@@showtext=\@firstofone

\endinput
