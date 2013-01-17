% Author: Alexey B. Shipunov (plantago@herba.msu.ru)

\ProvidesClass{etiketka}%
              [2008/02/16 v2.7 Herbarium labels]

\newif\if@NOL
\newcounter{etiketka@}
\newcounter{etiketka@@}
\newsavebox{\TMP@etiketka}

\DeclareOption{nolines}{\@NOLtrue}
\DeclareOption{lines}{\@NOLfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ExecuteOptions{lines}
\ProcessOptions

\LoadClass{article}

% SPECIFIC LAYOUT
\topmargin-14mm
\headheight0mm
\headsep0mm
\textheight254mm
\footskip0mm
\textwidth190mm
\oddsidemargin-14mm
\parskip 2ex plus .5ex minus .2ex

\let\ps@plain\ps@empty
\ps@empty

\nofiles

\twocolumn
% Columnsep rule with dots...
\def\@outputdblcol{%
  \if@firstcolumn
    \global \@firstcolumnfalse
    \global \setbox\@leftcolumn \box\@outputbox
  \else
    \global \@firstcolumntrue
    \setbox\@outputbox \vbox {%
                         \hb@xt@\textwidth {%
                           \hb@xt@\columnwidth {%
                             \box\@leftcolumn \hss}%
                           \hfil
                           \hskip-1.2em\rlap{\vbox to \ht\@outputbox {\leaders \vbox to 1.5em{\vss.\vss}\vfill}}\hskip1.2em
                           \hfil
                           \hb@xt@\columnwidth {%
                             \box\@outputbox \hss}%
                                             }%
                              }%
    \@combinedblfloats
    \@outputpage
    \begingroup
      \@dblfloatplacement
      \@startdblcolumn
      \@whilesw\if@fcolmade \fi
        {\@outputpage
         \@startdblcolumn}%
    \endgroup
  \fi
}

\if@NOL
\columnsep0pt
\columnseprule0pt
\def\NameStyle{\centering}
\def\NameRule{\vspace*{.7\baselineskip}}
\def\EtiketkaRule{\relax}
\fi

% USEFUL MACROS
\def\nohyphens{\hyphenpenalty=10000\exhyphenpenalty=10000\relax}

% MAIN ENVIRONMENT
\newenvironment{etiketka}[1][1]{%
\setcounter{etiketka@@}{#1}
\begin{lrbox}{\TMP@etiketka}
        \begin{minipage}{0.93\columnwidth}
                {\centering\scshape\HerbName\par}
                \vspace*{.3cm}
                \raggedright}
                {\EtiketkaRule
        \end{minipage}
\end{lrbox}
        \setcounter{etiketka@}{0}
        \loop\ifnum \value{etiketka@} < \value{etiketka@@}
        \stepcounter{etiketka@}
                \usebox{\TMP@etiketka}
\endgraf\repeat}

% LABEL ELEMENTS
% Maybe redefined...
\def\NameStyle{\parindent2em\hangindent2em}
\def\NameRule{\centerline{\rule{.95\linewidth}{.4pt}}}
\def\EtiketkaRule{%
        \vspace*{1em}
        \hbox to \linewidth{\leaders \hbox to 1.5em{\hss.\hss}\hfill}
        \vspace*{1.2em}}

% NAMES
% You can input something as \Name Plantago {} {}
% Empty line after required!
\def\Name#1 #2 #3\par{{\NameStyle
        \textit{#1 #2} #3\par}%
        \vspace*{-.7\baselineskip}
        \NameRule
        \vspace*{.2cm}}
% Anonimous label
% Empty line after required!
\def\Without{\Name {\rule{0pt}{1ex}} {} {}}

% REGION, DISTRICT AND LOCAL ADDRESS
% Empty line after required!
\def\Dist#1\par{{\parindent 2em\hangindent 2em#1\par}}
\def\Loc#1\par{{\parindent 4em\hangindent 4em#1\par}}

% COORDINATES
\def\CGrad#1#2{#1$^\circ$ \East,
        #2$^\circ$ \North{}}
\def\CMin#1#2#3#4{#1$^\circ$~#2$^\prime$ \East,
        #3$^\circ$~#4$^\prime$ \North{}}
\def\CSec#1#2#3#4#5#6{#1$^\circ$~#2$^\prime$~#3$^{\prime\prime}$ \East,
        #4$^\circ$~#5$^\prime$~#6$^{\prime\prime}$ \North{}}

% HABIT, DATE, COLLECTOR(S)
% Empty line after required!
\def\Date#1\par{\vspace*{.2cm}\parbox[t]{.3\linewidth}{#1}\hfill}
% Empty line after required!
\def\Coll#1\par{\parbox[t]{.5\linewidth}
        {\raggedright\nohyphens\CollName#1}\par}

% COMMANDS FOR REDEFINITION
\def\East{E}
\def\North{N}
\def\Reg{\relax}
\def\Habit{\relax}
\def\HerbName{\relax}
\def\CollName{\relax}

\endinput
