% $Id: ltxdockit.cls,v 1.2d 2011/03/25 20:33:14 lehman stable $
%
% Copyright (c) 2008-2011 Philipp Lehman.
%
% Permission is granted to copy, distribute and/or modify this
% software under the terms of the LaTeX Project Public License
% (LPPL), version 1.3.
%
% The LPPL maintenance status of this software is
% 'author-maintained'.
%
% This software is provided 'as is', without warranty of any kind,
% either expressed or implied, including, but not limited to, the
% implied warranties of merchantability and fitness for a
% particular purpose.

\def\ltd@rcsid$#1: #2 #3 #4 #5${#4 v#3}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ltxdockit}
[\ltd@rcsid $Id: ltxdockit.cls,v 1.2d 2011/03/25 20:33:14 lehman stable $
 LaTeX documentation kit]

\input{ltxdockit.def}

\RequirePackage{etoolbox}
\RequirePackage{multicol}
\RequirePackage{keyval}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage{ltxdockit}
\RequirePackage{hyperref}
\RequirePackage[all]{hypcap}

\newrobustcmd*{\fnurl}[1][]{\hyper@normalise\ltd@fnurl{#1}}
\def\ltd@fnurl#1#2{\footnote{#1\hyper@linkurl{\Hurl{#2}}{#2}}}

\newrobustcmd*{\email}{\hyper@normalise\ltd@email}
\def\ltd@email#1{\href{mailto:#1}{#1}}

\hypersetup{%
  colorlinks=true,
  linkcolor=spot,
  urlcolor=spot,
  bookmarks=true,
  bookmarksopen=false,
  bookmarksnumbered=false,
  hyperfootnotes=false,
  plainpages=false,
  pdfpagelabels=true,
  pdfpagemode=UseOutlines,
  pdfview=FitH,
  pdfstartview=FitH}

% title

\providecommand*{\titlepage}{}
\providecommand*{\titlefont}{}
\renewrobustcmd*{\titlepage}[1]{\setkeys{ltd@ttp}{#1}}
\renewcommand*{\titlefont}{\bfseries}
\define@key{ltd@ttp}{title}{\def\ltd@title@title{#1}}
\define@key{ltd@ttp}{subtitle}{\def\ltd@title@subtitle{#1}}
\define@key{ltd@ttp}{url}{\def\ltd@title@url{#1}}
\define@key{ltd@ttp}{author}{\def\ltd@title@author{#1}}
\define@key{ltd@ttp}{email}{\def\ltd@title@email{#1}}
\define@key{ltd@ttp}{revision}{\def\ltd@title@revision{#1}}
\define@key{ltd@ttp}{date}{\def\ltd@title@date{#1}}

\providecommand*{\printtitlepage}{}
\renewrobustcmd*{\printtitlepage}{%
  \begingroup
  \centering\titlefont
  \begingroup\LARGE
    \ifundef\ltd@title@url
      {\ltd@title@title}
      {\href{\ltd@title@url}{\ltd@title@title}}%
    \par
  \endgroup
  \vspace{0.25\baselineskip}
  \begingroup\large
    \ltd@title@subtitle\par
  \endgroup
  \vspace{0.25\baselineskip}
  \begin{multicols}{2}
  \raggedleft
    \ltd@title@author\par
    \expandafter\email\expandafter{\ltd@title@email}\par
  \raggedright
    Version \ltd@title@revision\par\ltd@title@date
  \end{multicols}
  \endgroup}

% rcs tags

\providecommand*{\rcsfile}{[rcsfile]}
\providecommand*{\rcsrevision}{[revision]}
\providecommand*{\rcsdate}{[date]}
\providecommand*{\rcstime}{[time]}
\providecommand*{\rcsstate}{[state]}
\providecommand*{\rcsauthor}{[author]}
\providecommand*{\rcslocker}{[unlocked]}
\providecommand*{\rcstoday}{\today}

\providecommand*{\rcsid}[1]{%
  \ifblank{#1}{}{\ltd@rcsid@i#1}}
\def\ltd@rcsid@i$Id#1${%
  \ifblank{#1}{}{\ltd@rcsid@ii#1&}}
\def\ltd@rcsid@ii#1#2&{%
  \ifblank{#1}{}{\ltd@rcsid@iii#2&}}
\def\ltd@rcsid@iii#1 #2 #3 #4&{%
  \write\@auxout{%
    \detokenize{\gdef\rcsfile{#2}}^^J%
    \detokenize{\gdef\rcsrevision{#3}}}%
  \ltd@rcsid@iv#4&}
\def\ltd@rcsid@iv#1/#2/#3 #4:#5:#6 #7&{%
  \write\@auxout{%
    \detokenize{\gdef\rcsdate{#1/#2/#3}}^^J%
    \detokenize{\gdef\rcstime{#4:#5:#6}}^^J%
    \detokenize{\ltd@setdate{#1}{#2}{#3}{#4}{#5}}}%
  \ltd@rcsid@v#7&}
\def\ltd@rcsid@v#1 #2 #3&{%
  \write\@auxout{%
    \detokenize{\gdef\rcsauthor{#1}}^^J%
    \detokenize{\gdef\rcsstate{#2}}}%
  \ifblank{#3}{}{\ltd@rcsid@vi#3&}}
\def\ltd@rcsid@vi#1 &{%
  \write\@auxout{%
    \detokenize{\gdef\rcslocker{#1}}}}

\def\ltd@setdate#1#2#3#4#5{%
  \global\year=#1
  \global\month=#2
  \global\day=#3
  \global\time=#4
  \global\multiply\time by 60
  \global\advance\time by #5}

% config file

\InputIfFileExists{ltxdockit.cfg}{}{}

\endinput
