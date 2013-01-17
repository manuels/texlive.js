% Document class for Unified Process Methodology
%
% Copyright (c) 2006-2009 Stephane GALLAND <galland@arakhne.org>
% 
% This program is free library; you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as
% published by the Free Software Foundation; either version 3 of the
% License, or any later version.
%
% This library is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this library; see the file COPYING.  If not,
% write to the Free Software Foundation, Inc., 59 Temple Place - Suite
% 330, Boston, MA 02111-1307, USA.
%
% Creation date: 2006-04-06
% Modifications:
%   2009-10-30   Add "book", "report" and "article" options.
%   2009-10-28   Add hyperref declarations.
%   2009-10-27   Add publication page.
%   2009-10-22   Add back page.
%   2009-10-09   Add option to hide the document informations
%   2007-07-03   Force the height of the small logo in headers.
%                Remove the copyright date building function.
%   2007-03-19   Add localization.
%   2006-04-19   Add version number.
%   2006-04-20   Add task package.
%   2006-04-21   Add specification package.
%   2006-04-22   Remove task and specification packages.
%

\global\edef\upm@package@docclazz@ver{2009/10/30}

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{upmethodology-document}[\upm@package@docclazz@ver]

\RequirePackage{upmethodology-p-common}

\newif\ifupm@package@docclazz@nodocinfo
\upm@package@docclazz@nodocinfofalse
\newif\ifupm@package@docclazz@nopubpage
\upm@package@docclazz@nopubpagefalse

\gdef\upm@package@docclazz@optionstopass{a4paper,11pt}

\DeclareOption{twoside}{%
  \xdef\upm@package@docclazz@optionstopass{\upm@package@docclazz@optionstopass,twoside,openright}%
}
\DeclareOption{oneside}{%
  \xdef\upm@package@docclazz@optionstopass{\upm@package@docclazz@optionstopass,oneside}%
}

\DeclareOption{french}{%
  \xdef\upm@package@docclazz@optionstopass{\upm@package@docclazz@optionstopass,french}%
  \PassOptionsToPackage{french}{upmethodology-document}
}
\DeclareOption{francais}{%
  \xdef\upm@package@docclazz@optionstopass{\upm@package@docclazz@optionstopass,french}%
  \PassOptionsToPackage{french}{upmethodology-document}
}
\DeclareOption{english}{%
  \xdef\upm@package@docclazz@optionstopass{\upm@package@docclazz@optionstopass,english}%
  \PassOptionsToPackage{english}{upmethodology-document}
}
\DeclareOption{nodocumentinfo}{%
	\upm@package@docclazz@nodocinfotrue%
}
\DeclareOption{documentinfo}{%
	\upm@package@docclazz@nodocinfofalse%
}
\DeclareOption{nopubpage}{%
	\upm@package@docclazz@nopubpagetrue%
}
\DeclareOption{pubpage}{%
	\upm@package@docclazz@nopubpagefalse%
}
\DeclareOption{book}{%
	\upmbookformattrue
	\upmreportformatfalse
	\upmarticleformatfalse
	\upm@package@docclazz@nopubpagefalse%
	\upm@package@docclazz@nodocinfofalse%
	\xdef\upm@package@docclazz@optionstopass{\upm@package@docclazz@optionstopass,twoside}%
}
\DeclareOption{report}{%
	\upmbookformatfalse
	\upmreportformattrue
	\upmarticleformatfalse
	\upm@package@docclazz@nopubpagetrue%
	\upm@package@docclazz@nodocinfofalse%
	\xdef\upm@package@docclazz@optionstopass{\upm@package@docclazz@optionstopass,oneside}%
}
\DeclareOption{article}{%
	\upmbookformatfalse
	\upmreportformatfalse
	\upmarticleformattrue
	\upm@package@docclazz@nopubpagetrue%
	\upm@package@docclazz@nodocinfotrue%
	\xdef\upm@package@docclazz@optionstopass{\upm@package@docclazz@optionstopass,oneside}%
}

\DeclareOption*{%
	\xdef\upm@package@docclazz@optionstopass{\upm@package@docclazz@optionstopass,\CurrentOption}%
	}
\ExecuteOptions{report}
\ProcessOptions

\ifupmbookformat
	\message{*********** UPMETHODOLOGY BOOK CLASS (WITH PART AND CHAPTER)}
	\expandafter\LoadClass[\upm@package@docclazz@optionstopass]{book}
\else\ifupmreportformat
	\message{*********** UPMETHODOLOGY REPORT CLASS (WITHOUT PART, WITH CHAPTER)}
	\expandafter\LoadClass[\upm@package@docclazz@optionstopass]{report}
\else
	\message{*********** UPMETHODOLOGY ARTICLE CLASS (WITHOUT PART AND CHAPTER)}
	\expandafter\LoadClass[\upm@package@docclazz@optionstopass]{article}
\fi\fi

\RequirePackage{a4wide}
\RequirePackage{fancyhdr}

\RequirePackage{upmethodology-document}
\RequirePackage{upmethodology-extension}
\RequirePackage{upmethodology-frontpage}
\RequirePackage{upmethodology-backpage}
\RequirePackage{upmethodology-task}
\RequirePackage{upmethodology-code}
\RequirePackage{upmethodology-spec}

\RequirePackage{url}
\RequirePackage[pdftex=true,
		breaklinks, %make links breakable on several lines
		pageanchor=true, %put implicit anchor on each page (required for \printindex)
                bookmarks=false, %hide bookmarks
		hyperfigures=true, %not documented
		hyperindex=true, %the page numbers in the index are links
		linktocpage=true, %page numbers are used for links in TOC, LOF...
		bookmarks=true, %open the bookmarks
		bookmarksopen=true, %open all the bookmark's nodes by default
		bookmarksnumbered=true, %section number in bookmarks
		colorlinks=false, % Use a frame around links
		pdfproducer={upmethodology \upm@package@docclazz@ver},
                ]{hyperref}
\urlstyle{same}

\pdfpageheight=29.7cm
\pdfpagewidth=21.0cm

%----------------------------------------
% HEADERS AND FOOTERS
%----------------------------------------

\def\upm@header@fmt#1{\textsc{\scriptsize #1}}
\def\upm@copyright@fmt#1{\textsc{\tiny #1}}

\pagestyle{fancyplain}

\newdimen{\upm@smalllogo@height}
\upm@smalllogo@height=1cm

\if@twoside

\lhead[]{\fancyplain{}{\upm@header@fmt{\theupmfulldocname}}}
\chead{}
\rhead{\Ifdefined{smalllogo}{\expandafter\includegraphics[height=\upm@smalllogo@height]{\theupmsmalldoclogo}}}
\lfoot[\upm@header@fmt{\ifthenelse{\thepage>0}{\thepage}{}}]{\upm@copyright@fmt{\tiny\theupmdocref~\copyright~\upmcopyrightdate~\theupmformattedcopyrighter}}
\cfoot{}
\rfoot[\upm@copyright@fmt{\tiny\theupmdocref~\copyright~\upmcopyrightdate~\theupmformattedcopyrighter}]{\upm@header@fmt{\ifthenelse{\thepage>0}{\thepage}{}}}

\else

\lhead{\fancyplain{}{\upm@header@fmt{\theupmfulldocname}}}
\chead{}
\rhead{\Ifdefined{smalllogo}{\expandafter\includegraphics[height=\upm@smalllogo@height]{\theupmsmalldoclogo}}}
\lfoot{\upm@copyright@fmt{\tiny\theupmdocref~\copyright~\upmcopyrightdate~\theupmformattedcopyrighter}}
\cfoot{}
\rfoot{\upm@header@fmt{\ifthenelse{\thepage>0}{\thepage}{}}}

\fi

%----------------------------------------
% AUTO-GENERATED DOCUMENT
%----------------------------------------

\AtBeginDocument{
	\makefrontcover
	\ifupm@package@docclazz@nopubpage\else\upmpublicationpage\fi
	\ifupm@package@docclazz@nodocinfo\else\upmdocinfopage\fi
	\sloppy
}

\AtEndDocument{
	\makebackcover
}

%----------------------------------------
% PDF COLORS
%----------------------------------------
\gdef\upm@package@getcolor#1,#2,#3{#1 #2 #3}
\renewcommand{\setpdfcolor}[1]{
	\hypersetup{
		filebordercolor={\upm@package@getcolor #1}, % frame color
		linkbordercolor={\upm@package@getcolor #1}, % frame color
		citebordercolor={\upm@package@getcolor #1}, % frame color
		menubordercolor={\upm@package@getcolor #1}, % frame color
		urlbordercolor={\upm@package@getcolor #1}, % frame color
		runbordercolor={\upm@package@getcolor #1}, % frame color
	}
}

%----------------------------------------
% SET FORBIDDEN SECTIONNING FUNCTIONS
%----------------------------------------
\ifupmbookformat\else
	\gdef\upm@package@docclazz@hidesec@a#1{%
		\@ifnextchar*{\upm@package@docclazz@hidesec@d{#1}}{%
		\@ifnextchar[{\upm@package@docclazz@hidesec@b{#1}}{\upm@package@docclazz@hidesec@c{#1}}%
		}}
	\gdef\upm@package@docclazz@hidesec@d#1#2{%
		\@ifnextchar[{\upm@package@docclazz@hidesec@b{#1}}{\upm@package@docclazz@hidesec@c{#1}}}
	\gdef\upm@package@docclazz@hidesec@b#1[#2]#3{\@warning{"#1" macro is skipped. Title: "#3"}}
	\gdef\upm@package@docclazz@hidesec@c#1#2{\@warning{"#1" macro is skipped. Title: "#2"}}

	\gdef\part{\upm@package@docclazz@hidesec@a{\string\part}}
	\gdef\partstar{\upm@package@docclazz@hidesec@a{\string\part*}}
	\gdef\parttoc{\upm@package@docclazz@hidesec@a{\string\parttoc}}

\ifupmreportformat\else

	\gdef\chapter{\upm@package@docclazz@hidesec@a{\string\part}}
	\gdef\chapterstar{\upm@package@docclazz@hidesec@a{\string\part*}}
	\gdef\chaptertoc{\upm@package@docclazz@hidesec@a{\string\parttoc}}

\fi\fi

\endinput
