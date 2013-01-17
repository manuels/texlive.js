% Author: A. Shipunov (plantago@herba.msu.ru)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cassete}
        [2008/02/05 v0.2 Labels  for audiocassetes]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\newcounter{A@Side}
\newcounter{B@Side}

\def\nohyphens{\hyphenpenalty=10000\exhyphenpenalty=10000\relax}

% Main command
\def\cassete{\@ifstar{\c@ss}{\c@@ss}}

% Without star -- 5 arguments
\long\def\c@@ss#1#2#3#4#5{%
\def\Labe@l{\centering\FormatLabel#1}%
\def\Text@A{\raggedleft\hspace*{-6mm}\SideA\par\vspace{1mm}\raggedright#2}%
\def\Text@B{\raggedleft\hspace*{-6mm}\SideB\par\vspace{1mm}\raggedright#3}%
\def\Text@AD{\raggedright#4}%
\def\Text@BD{\raggedright#5}%
\begin{center}
\unitlength=1mm
        \begin{picture}(100,105)
        \put(0,0){\dashbox{2}(100,97){}}
        \put(8,2){\parbox[b][63mm][t]{39.5mm}{\Text@A}}
        \put(50,0){\rule{.4pt}{67mm}}
        \put(58.3,2){\parbox[b][63mm][t]{39.5mm}{\Text@B}}
        \put(0,80){\rule{100mm}{.4pt}}
        \put(2,69){\parbox[b][9mm][c]{95mm}{\Labe@l}}
        \put(0,67){\rule{100mm}{.4pt}}
        \put(8,80){\parbox[b][15mm][t]{39.5mm}{\Text@AD}}
        \put(50,80){\rule{.4pt}{17mm}}
        \put(58.3,80){\parbox[b][15mm][t]{39.5mm}{\Text@BD}}
\end{picture}
\end{center}
\setcounter{A@Side}{0}
\setcounter{B@Side}{0}}

% With star -- 3 arguments
\long\def\c@ss#1#2#3{%
\def\Labe@l{\centering\FormatLabel#1}%
\def\Text@A{\raggedleft\hspace*{-6mm}\SideA\par\vspace{1mm}\raggedright#2}%
\def\Text@B{\raggedleft\hspace*{-6mm}\SideB\par\vspace{1mm}\raggedright#3}%
\begin{center}
\unitlength=1mm
        \begin{picture}(99,105)
        \put(0,0){\dashbox{2}(99,105){}}
        \put(8,38){\parbox[b][65mm][t]{39mm}{\Text@A}}
        \put(49.5,38){\rule{.4pt}{67mm}}
        \put(57.8,38){\parbox[b][65mm][t]{39mm}{\Text@B}}
        \put(0,38){\rule{99mm}{.4pt}}
        \put(2,27){\parbox[b][9mm][c]{95mm}{\Labe@l}}
        \put(0,25){\rule{99mm}{.4pt}}
\end{picture}
\end{center}
\setcounter{A@Side}{0}
\setcounter{B@Side}{0}}

% For separate songs
\def\AS{\stepcounter{A@Side}\makebox[0pt][r]{\arabic{A@Side}.\ }}
\def\BS{\stepcounter{B@Side}\makebox[0pt][r]{\arabic{B@Side}.\ }}

% It is possible to redefine them:
% Sides
\def\SideAWord{Side A}
\def\SideBWord{Side B}
\def\SideA{\textbf\SideAWord}
\def\SideB{\textbf\SideBWord}
% Front edge
\def\FormatLabel{\large\scshape}
% Putative headers
\def\SideT#1{\addvspace{.5mm}\hspace*{-6mm}%
        \parbox{45mm}{\raggedright#1}\vspace{.5mm}}

% Specific layout
\topmargin=-14mm
\headheight=0mm
\headsep=0mm
\textheight=255mm
\footskip=0mm
\textwidth=190mm
\oddsidemargin=-14mm

\pagestyle{empty}
\renewcommand{\baselinestretch}{.92}
\endinput
