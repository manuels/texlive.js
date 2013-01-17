%    This file is part of flacards.
%
%    Flacards is free software; you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation; either version 2 of the License, or
%    (at your option) any later version.
%
%    Flacards is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with Foobar; if not, write to the Free Software
%    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
%
%
% Klasse für Lernkarten
% class for flashcards
%
% Version 0.1     2005/11/16
% Norbert Stuhrmann
%
% Changelog:
%
% 0.1.1:
% - bug fix: front side content also printed on back side
% - updated examples
% - improved/advanced interface for card layout
% 
% 0.1: 
% - file creation
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{flacards}[2005/11/06 Klasse fuer Lernkarten/Class for flashcards]


\DeclareOption{frontgrid}{\def\fc@frontgrid{true}}
\DeclareOption{backgrid}{\def\fc@backgrid{true}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[twoside]{article}

%TODO: margin managment
\RequirePackage[noheadfoot, margin=1cm, outer=1cm, inner=1cm]{geometry}

\pagestyle{empty}

% TODO: replace
\newcommand*{\fc@strippt}[1]{%
    \strip@pt#1}%

\newcounter{cardno}\setcounter{cardno}{0}
\newcount\cardperpage
\newdimen\cardwidth
\newdimen\cardheight


\newcommand{\fc@boxcontent}[2]{%
\parindent=0pt%
{\cardbox{#1}{#2}}%
}

\newcommand{\cardbox}[2]{%
\vbox{%
\vskip\fboxsep%
\hbox{%
\hskip\fboxsep%
{\advance\cardheight by -2\fboxsep
\vbox to \cardheight {%
\hsize=\cardwidth\advance\hsize by -2\fboxsep%
{\cardinnerbox{#1}{#2}}}%
}\hskip\fboxsep}}%
}

\newcommand{\cardinnerbox}[2]{%
 \sloppy%
 %\smash%
 {%
 \makebox[0pt][l]{\parbox[t]{\cardwidth}{\raggedright\csname #1lhead\endcsname}}\hfill%
 \makebox[0pt][c]{\parbox[t]{\cardwidth}{\centering\csname #1chead\endcsname}}\hfill%
 \makebox[0pt][r]{\parbox[t]{\cardwidth}{\raggedleft\csname #1rhead\endcsname}}%
 }%
 \vfill%
 {\cardtext{#1}{#2}}
 \vfill%
 %\smash%
 {%
 \makebox[0pt][l]{\parbox[b]{\cardwidth}{\raggedright\csname #1lfoot\endcsname}}\hfill%
 \makebox[0pt][c]{\parbox[b]{\cardwidth}{\centering\csname #1cfoot\endcsname}}\hfill%
 \makebox[0pt][r]{\parbox[b]{\cardwidth}{\raggedleft\csname #1rfoot\endcsname}}%
 }%
}

\newcommand{\cardtext}[2]{%
\centering{\csname cardtextstyle#1\endcsname #2\\}%
}

\newcommand{\cardtextstylef}{%
\itshape}

\newcommand{\cardtextstyleb}{%
\itshape}

%% front
\newsavebox\front
\setbox\front=\vbox{}
% layout
\newcommand{\flhead}{}\newcommand{\fchead}{}\newcommand{\frhead}{}
\newcommand{\flfoot}{}\newcommand{\fcfoot}{}\newcommand{\frfoot}{}

%% back
\newsavebox\back
\setbox\back=\vbox{}
% layout 
\newcommand{\blhead}{}\newcommand{\bchead}{}\newcommand{\brhead}{}
\newcommand{\blfoot}{}\newcommand{\bcfoot}{}\newcommand{\brfoot}{}

\renewcommand{\frfoot}{\footnotesize \thecardno}
\renewcommand{\brfoot}{\footnotesize \thecardno}

\newcommand{\pagesetup}[2]{%
\def\rowsperpage{#2}\relax%
\def\colsperpage{#1}\relax%
\cardwidth=\textwidth\relax%
\cardheight=\textheight\relax%
\divide\cardwidth by \colsperpage%
\divide\cardheight by \rowsperpage%
\cardperpage=\colsperpage\relax%
\multiply\cardperpage by \rowsperpage\relax%
}

\newcommand{\card}[2]{%
\@tempcnta=-\thecardno\divide\@tempcnta by \cardperpage\multiply\@tempcnta by \cardperpage\advance\@tempcnta by \thecardno\relax%
\@tempcntb=\@tempcnta%
\count@=\@tempcnta\relax%
\divide\count@ by \colsperpage\relax%
\@tempcnta=\count@\relax%
\multiply\count@ by \colsperpage\relax%
\advance\@tempcntb by -\count@\relax%
\stepcounter{cardno}%
\unitlength=1pt%
\advance\@tempcnta by 1\relax%
\@tempdima=\cardheight\relax%
\@tempdimb=\cardwidth\relax%
\advance\@tempdima by \fboxrule\relax%
\advance\@tempdimb by \fboxrule\relax%
\multiply\@tempdima by \@tempcnta\relax%
\multiply\@tempdimb by \@tempcntb\relax%
\advance\@tempdima by -\baselineskip\relax%
\setbox\front=\vbox{\unvbox\front%
\noindent\begin{picture}(0,0)%
\put(\fc@strippt\@tempdimb,-\fc@strippt\@tempdima){%
\ifdefined\fc@frontgrid\framebox(\fc@strippt\cardwidth,\fc@strippt\cardheight)[t]{\fc@boxcontent{f}{#1}}
\else\makebox(\fc@strippt\cardwidth,\fc@strippt\cardheight)[t]{\fc@boxcontent{f}{#1}}%
\fi
}%
\end{picture}%
}%
\setbox\back=\vbox{\unvbox\back%
\noindent\begin{picture}(0,0)%
\multiply\@tempdimb by -1\relax%
\advance\@tempdimb by \textwidth\relax%
\advance\@tempdimb by -\cardwidth\relax%
\put(\fc@strippt\@tempdimb,-\fc@strippt\@tempdima){%
\ifdefined\fc@backgrid\framebox(\fc@strippt\cardwidth,\fc@strippt\cardheight)[t]{\fc@boxcontent{b}{#2}}%
\else\makebox(\fc@strippt\cardwidth,\fc@strippt\cardheight)[t]{\fc@boxcontent{b}{#2}}%
\fi%
}%
\end{picture}%
}%
\count@=\thecardno\divide\count@ by \cardperpage\multiply\count@ by \cardperpage\advance\count@ by -\thecardno\relax%
\ifnum \count@=0\relax%
\noindent\box\front\newpage\box\back\newpage%
\else\fi
}

\AtEndDocument{\box\front\newpage\box\back}

% Default layout
\pagesetup{3}{8}
