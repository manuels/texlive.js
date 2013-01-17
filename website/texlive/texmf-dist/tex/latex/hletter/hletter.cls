%%
%% This is file `hletter.cls' which is part of the hletter package
%%
%% Copyright (C) 2011 Brian Housley
%%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.2
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
%%
%% Problems, bugs and comments to
%% brian.housley@gcs.ch
%%

% hletter document class
%
% Original: Copyright (C) 1991 by Leslie Lamport
%
%  Modified version for Brian Housley -- V4.1 (2nd. July, 2011)/B. Housley
%  A "from" address makes a private letter but
%  if there is no "from" address the layout is:
%    --------------------------------------------------------------------
%    |                            \centreA                 \addressA    |
%    |                            \centreB                 \addressB    |
%    |     <the logo>             \centreC                 \addressC    |
%    |                            \centreD                 \extraA      |
%    |                            \centreE                 \extraB      |
%    |                            \centreF                 \extraC      |
%    |                                                                  |
%    |                                                                  |
%    |                                              <to-address>        |
%    |                                                                  |
%    |                                               date               |
%    |          opening                                                 |
%    |                                                                  |
%                               ................
%    |                                                                  |
%    |    \bottomL                \bottomC                  \bottomR    |
%    --------------------------------------------------------------------
%                                                  .
%  further options:
%   \reference{<text>}  bold text ontop for german and below for English
%   \cc{<text>\\...}    copies to
%   \encl{<text>\\...}  enclosure(s)
%   \encls              enclosures as mentioned
%   \closingtwo{<text>} same as \closing but permits two names in \signature
%                       separated with &(s)
%
\NeedsTeXFormat{LaTeX2e}[1996/06/01]
\ProvidesClass{hletter}[2009/07/02 v4.0 Housley's letter class]

\typeout{H-Letter class V4.0 <02/07/2009> hsy}

\newif\ifhlet  \hlettrue
\newdimen\signatureheight
\newcommand*{\sign}[2][15mm]{\global\signatureheight=#1 \gdef\signatureimage{#2}} \sign{}
%
\input hsetup.sty   % input the definition of \heading
%
\setlength{\headsep}{25pt}
\setlength{\topmargin}{12pt}
\setlength{\parskip}{0pt plus 1pt}
\addtolength{\textwidth}{30pt}
\addtolength{\oddsidemargin}{-15pt}
\addtolength{\evensidemargin}{-15pt}
\raggedbottom

\renewenvironment{letter}[1]
  {\newpage
    \if@twoside \ifodd\c@page
                \else\thispagestyle{empty}\null\newpage\fi
    \fi
    \c@page \@ne
    \c@footnote \z@
    \interlinepenalty=200 % smaller than the TeXbook value
    \@processto{#1}}
  {\stopletter\@@par\pagebreak\@@par
    \if@filesw
      \begingroup
        \let\\=\relax
        \let\protect\@unexpandable@protect
        \immediate\write\@auxout{%
          \string\@mlabel{\returnaddress}{\toname\\\toaddress}}%
      \endgroup
    \fi}

\renewcommand*{\opening}[2][\@empty]{%
%  parameters: 1- top right text; 2- introduction; 3- from address; 4- to address.
  \dohead{#1}{#2}{\fromaddress}{\toname\\\toaddress}
%
  \ifnum\hlangcnt=0\noindent #2\ifx\reftext\@empty\par\smallskip\else
     \par\smallskip\noindent\parbox{\textwidth}{\centering\textbf{\reftext}}\par\smallskip\fi
     \else
     \ifx\reftext\@empty\else
      \noindent\parbox{\textwidth}{\textbf{\reftext}}\par\medskip \fi
      \noindent #2\par\medskip\fi}
%

\renewcommand*{\closing}[1]{\par\medskip%
   \ifx\undefined\sigbx \newbox\sigbx
     \ifx\signatureimage\@empty
       \global\setbox\sigbx\hbox{\rule{0pt}{15mm}}\else
       \global\setbox\sigbx\hbox{\mbox{\rule[-7.5mm]{0pt}{15mm}\raisebox{-.5\height}%
       {\includegraphics[height=\signatureheight]{\signatureimage}}}}\fi\fi
%  \stopbreaks
  \noindent
  \hspace*{\fill}\begin{tabular}{c}
     #1\\
     \copy\sigbx \\
     \fromsig\\
     \end{tabular}\hspace{.1\textwidth}%
   \par\thispagestyle{empty}}

\newcommand*{\closingtwo}[1]{\par\medskip%
  \noindent
  \hspace*{\fill}\begin{tabular}{@{}c@{\hspace{8\tabcolsep}}c@{}}
     \multicolumn{2}{c}{#1}\\[15mm]
     \fromsig\\
     \end{tabular}\hspace{.1\textwidth}%
   \par\thispagestyle{empty}}

\newcommand{\reference}[1]{\def\reftext{#1}} \reference{}
%\endinput
%
%  end of file IDLETTER.CLS
