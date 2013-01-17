%%
%% This is file `pbsheet.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pbsheet.dtx  (with options: `class')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2003, 2004 Djalil CHAFAI
%% djalil DOT chafai AT laposte DOT net
%% http;//www.lsp.ups-tlse.fr/Chafai/pbsheet.html
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 1999/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{pbsheet}
    [2004/02/14 v0.1 .dtx pbsheet file]
\ClassInfo{pbsheet}{Copyright (c) Djalil CHAFAI, 2003, 2004.}
\ClassInfo{pbsheet}{http://www.lsp.ups-tlse.fr/Chafai/}
\ClassInfo{pbsheet}{chafai AT math DOT ups-tlse DOT fr}
%%
\LoadClassWithOptions{article} \ProcessOptions\relax
%%
\ifx\pdfoutput\undefined
 \usepackage[latin1]{inputenc}
 \usepackage[T1]{fontenc}
 \usepackage{url}
 \usepackage[dvips]{graphicx}
 \newcommand{\phantomsection}{\null} %% provided by hyperref.
\else
 \pdfoutput=1\pdfcompresslevel=9\pdfadjustspacing=1
 \usepackage[pdftex,bookmarks,a4paper,colorlinks]{hyperref}
 \usepackage{aeguill}
 \usepackage[pdftex]{graphicx}
 \hypersetup{bookmarksnumbered,plainpages=false,hypertexnames=false}
 \hypersetup{pagecolor=blue,linkcolor=blue,citecolor=blue,urlcolor=blue}
 \hypersetup{pdfcreator=PDFLaTeX with pbsheet class}
\fi
\RequirePackage{amsmath,amsfonts,amssymb,amsthm,latexsym}
\RequirePackage[a4paper,portrait]{geometry}
\RequirePackage{rotating}
\RequirePackage{moreverb}
\RequirePackage[latin1]{inputenc}
\RequirePackage{xspace}
\RequirePackage[francais]{babel}
\RequirePackage{color}
\RequirePackage{listings}
\ifx\pdfoutput\undefined
\else %% listings/hyperref compatibility.
 \makeatletter
 \providecommand*{\toclevel@lstlisting}{0}
 \makeatother
\fi
%%%%
%%%% Macros et Environments
%%%%
%%
\newcommand{\MFILE}[1]{
  \begin{lstinputlisting}[language=Matlab]{#1.m}%
   \label{code:#1}%
  \end{lstinputlisting}
}
%%
\newcommand{\SCEFILE}[1]{
  \begin{lstinputlisting}[language=Scilab]{#1.sce}%
   \label{code:#1}%
  \end{lstinputlisting}
}
%%
\newcommand{\SCIFILE}[1]{
  \begin{lstinputlisting}[language=Scilab]{#1.sci}%
   \label{code:#1}%
  \end{lstinputlisting}
}
%%
\newcommand{\FFIG}[5]{%%  fname cm scale floatparams caption
%% here, floatparams is in the set {vflt,rflt,lflt}, cf. floatflt doc.
  \begin{floatingfigure}[#4]{#2}%
    \begin{center}%
      \includegraphics[scale=#3]{#1}%
      \caption{#5}%
      \label{fi:#1}%
    \end{center}%
 \end{floatingfigure}%
}
%%
\newcommand{\FIG}[4]{%% fname scale floatparams caption
 \begin{figure}[#3]%
  \begin{center}%
  \includegraphics[scale=#2]{#1}%
  \caption{{#4}}%
  \label{fi:#1}%
  \end{center}%
 \end{figure}
}
%%
\makeatletter%
\newcommand{\@TITRE}{Feuille de Travaux Pratiques}
\newcommand{\@AUTEUR}{Anonyme}
\newcommand{\@DATE}{\today}
\newcommand{\@FORMATION}{Agr\'egation de math\'ematiques%
  -- Oral de mod\'elisation stochastique}
\newcommand{\@ANNEE}{Ann\'ee}
\newcommand{\@ETABLISSEMENT}{\'Etablissement}
\newcommand{\@WEB}{http://www.lsp.ups-tlse.fr/Chafai/agregteam.html}
\newcommand{\@MEL}{anonyme@pas.net}
\newcommand{\TITRE}[1]{%
  \renewcommand{\@TITRE}{#1}}
\newcommand{\AUTEUR}[1]{%
  \renewcommand{\@AUTEUR}{#1}}
\newcommand{\DATE}[1]{%
  \renewcommand{\@DATE}{#1}}
\newcommand{\FORMATION}[1]{%
  \renewcommand{\@FORMATION}{#1}}
\newcommand{\ANNEE}[1]{%
  \renewcommand{\@ANNEE}{#1}}
\newcommand{\ETABLISSEMENT}[1]{%
  \renewcommand{\@ETABLISSEMENT}{#1}}
\newcommand{\WEB}[1]{%
  \renewcommand{\@WEB}{#1}}
\newcommand{\MEL}[1]{%
  \renewcommand{\@MEL}{#1}}
\makeatother
%%
\makeatletter
\newcommand{\PREMIEREPAGE}{%
  \newpage\null%
  \begin{center}%
    \hrule height .2pt%
    \medskip{\Large\bfseries\@TITRE\par}\medskip%
    \hrule height .2pt%
  \end{center}%
  \bigskip%\vfil%
}
\makeatother
%%
\theoremstyle{plain}%
\newtheorem{thm}{Theor\`eme}[section]%
\newtheorem{cor}[thm]{Corollaire}%
\newtheorem{prop}[thm]{Proposition}%
\newtheorem{lem}[thm]{Lemme}%
\theoremstyle{definition}%
\newtheorem{defi}[thm]{D\'efinition}%
\newtheorem{xpl}[thm]{Exemple}%
\newtheorem{exo}[thm]{Exercice}%
\newtheorem{hyp}[thm]{Hypoth\`ese}%
\newtheorem{eur}[thm]{Heuristique}%
\newtheorem{pro}[thm]{Probl\`eme}%
\theoremstyle{remark}%
\newtheorem{rem}[thm]{Remarque}%
%%%%
%%%% Commands to be executed before \begin{document}
%%%%
%%
\geometry{left=2.5cm,right=2.5cm}
%%
\lstset{extendedchars=true,%
        basicstyle=\small,%
        commentstyle=\ttfamily\color[rgb]{0,0,0.5},%
        stringstyle=\color[rgb]{0,0.5,0},%
        frame=tblr,frameround=tttt,%
        %%labelstyle=\tiny,labelstep=1,labelsep=10pt
}
%%
\makeatletter
\renewcommand{\@evenfoot}
{\tiny\normalfont
  \@DATE. Copyright © \@AUTEUR\ \@MEL. GNU FDL Copyleft.
%%  \url{http://www.gnu.org/copyleft/fdl.html}.
  \hfil \upshape Page n°{\thepage}.}
\renewcommand{\@evenhead}
{\tiny\scshape \@ETABLISSEMENT\ -- \@FORMATION\ --
  \normalfont\bfseries\@ANNEE.
  \normalfont\hfil \upshape Page n°{\thepage}.}
\renewcommand{\@oddfoot}{\@evenfoot}
\renewcommand{\@oddhead}{\@evenhead}
\makeatother
%% smaller sections titles
\makeatletter
\renewcommand{\section}{\@startsection%
  {section}%                           % name
  {1}%                                 % level
  {0em}%                               % indent
  {\baselineskip}%                     % beforeskip
  {0.5\baselineskip}%                  % afterskip
  {\normalfont\large\bfseries}}%       % style
\renewcommand{\subsection}{\@startsection%
  {subsection}%                        % name
  {2}%                                 % level
  {0em}%                               % indent
  {\baselineskip}%                     % beforeskip
  {0.25\baselineskip}%                 % afterskip
  {\normalfont\bfseries}%              % style
}
\makeatother
%%
%% Macros
%%
\newcommand{\DOIFPDF}[2]{\ifx\pdfoutput\undefined #2\else#1\fi}
%% For nice typesetting of the actual engine name.
\newcommand{\EngineName}{\DOIFPDF{\texttt{pdf}\LaTeX}{\LaTeXe}}
%% For short rough notes and warnings.
\newcommand{\NB}[1]{{\large\textbf{*** #1 ***}}}
%% To force maths mode.
\newcommand{\EM}{\ensuremath}
%%% Limits
\newcommand{\limLeb}[2]
 {\underset{#1\to+\infty}{\overset{\bL^{#2}}{\longrightarrow}}}
\newcommand{\limE}[1]
 {\underset{#1\to+\infty}{\overset{\text{étr.}}{\longrightarrow}}}
\newcommand{\limW}[1]
 {\underset{#1\to+\infty}{\overset{\text{weak}}{\longrightarrow}}}
\newcommand{\limP}[1]
 {\underset{#1\to+\infty}{\overset{\dP}{\longrightarrow}}}
\newcommand{\limL}[1]
 {\underset{#1\to+\infty}{\overset{\cL}{\longrightarrow}}}
\newcommand{\limn}[1]
 {\underset{#1\to+\infty}{\longrightarrow}}
\newcommand{\mylim}[2]
 {\underset{#1\to#2}{\longrightarrow}}
\newcommand{\limPS}[1]
 {\underset{#1\to+\infty}{\overset{\text{p.s.}}{\longrightarrow}}}
\newcommand{\limAS}[1]
 {\underset{#1\to+\infty}{\overset{\text{a.s.}}{\longrightarrow}}}
%% Time
\makeatletter
\providecommand{\timenow}{\@tempcnta\time%
\@tempcntb\@tempcnta%
\divide\@tempcntb60%
\ifnum10>\@tempcntb0\fi\number\@tempcntb%
\multiply\@tempcntb60%
\advance\@tempcnta-\@tempcntb%
:\ifnum10>\@tempcnta0\fi\number\@tempcnta}
\makeatother
%% Mathmode double capital letters.
\newcommand{\dA}{\EM{\mathbb{A}}}
\newcommand{\dB}{\EM{\mathbb{B}}}
\newcommand{\dC}{\EM{\mathbb{C}}}
\newcommand{\dD}{\EM{\mathbb{D}}}
\newcommand{\dE}{\EM{\mathbb{E}}}
\newcommand{\dF}{\EM{\mathbb{F}}}
\newcommand{\dG}{\EM{\mathbb{G}}}
\newcommand{\dH}{\EM{\mathbb{H}}}
\newcommand{\dI}{\EM{\mathbb{I}}}
\newcommand{\dJ}{\EM{\mathbb{J}}}
\newcommand{\dK}{\EM{\mathbb{K}}}
\newcommand{\dL}{\EM{\mathbb{L}}}
\newcommand{\dM}{\EM{\mathbb{M}}}
\newcommand{\dN}{\EM{\mathbb{N}}}
\newcommand{\dO}{\EM{\mathbb{O}}}
\newcommand{\dP}{\EM{\mathbb{P}}}
\newcommand{\dQ}{\EM{\mathbb{Q}}}
\newcommand{\dR}{\EM{\mathbb{R}}}
\newcommand{\dS}{\EM{\mathbb{S}}}
\newcommand{\dT}{\EM{\mathbb{T}}}
\newcommand{\dU}{\EM{\mathbb{U}}}
\newcommand{\dV}{\EM{\mathbb{V}}}
\newcommand{\dW}{\EM{\mathbb{W}}}
\newcommand{\dX}{\EM{\mathbb{X}}}
\newcommand{\dY}{\EM{\mathbb{Y}}}
\newcommand{\dZ}{\EM{\mathbb{Z}}}
%% Mathmode Roman capital letters.
\newcommand{\rA}{\EM{\mathrm{A}}}
\newcommand{\rB}{\EM{\mathrm{B}}}
\newcommand{\rC}{\EM{\mathrm{C}}}
\newcommand{\rD}{\EM{\mathrm{D}}}
\newcommand{\rE}{\EM{\mathrm{E}}}
\newcommand{\rF}{\EM{\mathrm{F}}}
\newcommand{\rG}{\EM{\mathrm{G}}}
\newcommand{\rH}{\EM{\mathrm{H}}}
\newcommand{\rI}{\EM{\mathrm{I}}}
\newcommand{\rJ}{\EM{\mathrm{J}}}
\newcommand{\rK}{\EM{\mathrm{K}}}
\newcommand{\rL}{\EM{\mathrm{L}}}
\newcommand{\rM}{\EM{\mathrm{M}}}
\newcommand{\rN}{\EM{\mathrm{N}}}
\newcommand{\rO}{\EM{\mathrm{O}}}
\newcommand{\rP}{\EM{\mathrm{P}}}
\newcommand{\rQ}{\EM{\mathrm{Q}}}
\newcommand{\rR}{\EM{\mathrm{R}}}
\newcommand{\rS}{\EM{\mathrm{S}}}
\newcommand{\rT}{\EM{\mathrm{T}}}
\newcommand{\rU}{\EM{\mathrm{U}}}
\newcommand{\rV}{\EM{\mathrm{V}}}
\newcommand{\rW}{\EM{\mathrm{W}}}
\newcommand{\rX}{\EM{\mathrm{X}}}
\newcommand{\rY}{\EM{\mathrm{Y}}}
\newcommand{\rZ}{\EM{\mathrm{Z}}}
%% Mathmode calligraphic capital letters.
\newcommand{\cA}{\EM{\mathcal{A}}}
\newcommand{\cB}{\EM{\mathcal{B}}}
\newcommand{\cC}{\EM{\mathcal{C}}}
\newcommand{\cD}{\EM{\mathcal{D}}}
\newcommand{\cE}{\EM{\mathcal{E}}}
\newcommand{\cF}{\EM{\mathcal{F}}}
\newcommand{\cG}{\EM{\mathcal{G}}}
\newcommand{\cH}{\EM{\mathcal{H}}}
\newcommand{\cI}{\EM{\mathcal{I}}}
\newcommand{\cJ}{\EM{\mathcal{J}}}
\newcommand{\cK}{\EM{\mathcal{K}}}
\newcommand{\cL}{\EM{\mathcal{L}}}
\newcommand{\cM}{\EM{\mathcal{M}}}
\newcommand{\cN}{\EM{\mathcal{N}}}
\newcommand{\cO}{\EM{\mathcal{O}}}
\newcommand{\cP}{\EM{\mathcal{P}}}
\newcommand{\cQ}{\EM{\mathcal{Q}}}
\newcommand{\cR}{\EM{\mathcal{R}}}
\newcommand{\cS}{\EM{\mathcal{S}}}
\newcommand{\cT}{\EM{\mathcal{T}}}
\newcommand{\cU}{\EM{\mathcal{U}}}
\newcommand{\cV}{\EM{\mathcal{V}}}
\newcommand{\cW}{\EM{\mathcal{W}}}
\newcommand{\cX}{\EM{\mathcal{X}}}
\newcommand{\cY}{\EM{\mathcal{Y}}}
\newcommand{\cZ}{\EM{\mathcal{Z}}}
%% Mathmode bold capital letters.
\newcommand{\bA}{\EM{\mathbf{A}}}
\newcommand{\bB}{\EM{\mathbf{B}}}
\newcommand{\bC}{\EM{\mathbf{C}}}
\newcommand{\bD}{\EM{\mathbf{D}}}
\newcommand{\bE}{\EM{\mathbf{E}}}
\newcommand{\bF}{\EM{\mathbf{F}}}
\newcommand{\bG}{\EM{\mathbf{G}}}
\newcommand{\bH}{\EM{\mathbf{H}}}
\newcommand{\bI}{\EM{\mathbf{I}}}
\newcommand{\bJ}{\EM{\mathbf{J}}}
\newcommand{\bK}{\EM{\mathbf{K}}}
\newcommand{\bL}{\EM{\mathbf{L}}}
\newcommand{\bM}{\EM{\mathbf{M}}}
\newcommand{\bN}{\EM{\mathbf{N}}}
\newcommand{\bO}{\EM{\mathbf{O}}}
\newcommand{\bP}{\EM{\mathbf{P}}}
\newcommand{\bQ}{\EM{\mathbf{Q}}}
\newcommand{\bR}{\EM{\mathbf{R}}}
\newcommand{\bS}{\EM{\mathbf{S}}}
\newcommand{\bT}{\EM{\mathbf{T}}}
\newcommand{\bU}{\EM{\mathbf{U}}}
\newcommand{\bV}{\EM{\mathbf{V}}}
\newcommand{\bW}{\EM{\mathbf{W}}}
\newcommand{\bX}{\EM{\mathbf{X}}}
\newcommand{\bY}{\EM{\mathbf{Y}}}
\newcommand{\bZ}{\EM{\mathbf{Z}}}
%% Useful shortcuts to some Greek letters and symbols.
\newcommand{\al}{\alpha}
\newcommand{\be}{\beta}
\newcommand{\De}{\Delta}
\newcommand{\de}{\delta}
\newcommand{\ga}{\gamma}
\newcommand{\Ga}{\Gamma}
\newcommand{\g}{\gamma}
\newcommand{\gn}{\g_n}
\newcommand{\gt}[1]{\g^{\otimes #1}}
\newcommand{\la}{\lambda}
\newcommand{\La}{\Lambda}
\newcommand{\lan}{\la_n}
\newcommand{\na}{\nabla}
\newcommand{\Om}{\Omega}
\newcommand{\om}{\omega}
\newcommand{\ph}{\Phi}
\newcommand{\Si}{\Sigma}
\newcommand{\si}{\sigma}
\newcommand{\Te}{\Theta}
\newcommand{\te}{\theta}
\newcommand{\ta}{\tau}
\newcommand{\Ups}{\Upsilon}
\newcommand{\veps}{\varepsilon}
\newcommand{\vphi}{\varphi}
\newcommand{\bul}{\EM{\bullet}}
%% Functional prototype with dimensioning.
\newcommand{\p}[4]{{#3}\!\left#1{#4}\right#2}
%% Norms and related.
\newcommand{\ABS}[1]{\EM{{\left| #1 \right|}}} % |1|
\newcommand{\BRA}[1]{\EM{{\left\{#1\right\}}}} % {1}
\newcommand{\DP}[1]{\EM{{\left<#1\right>}}} % <1>
\newcommand{\NRM}[1]{\EM{{\left\| #1\right\|}}} % ||1||
\newcommand{\NI}[1]{\EM{{\left\| #1\right\|}_\infty}} % infinite norm.
\newcommand{\OSC}[1]{\EM{{\p(){\mathrm{osc}}{#1}}}} % oscillation.
\newcommand{\PAR}[1]{\EM{{\left(#1\right)}}} % (1)
\newcommand{\BPAR}[1]{\EM{{\biggl(#1\biggr)}}} % (1)
\newcommand{\BABS}[1]{\EM{{\biggl|#1\biggr|}}} % (1)
\newcommand{\pd}{\EM{\partial}} % derivee partielle
\newcommand{\PD}[2]{\EM{{\frac{\partial #1}{\partial #2}}}}%part. deriv.
\newcommand{\SBRA}[1]{\EM{{\left[#1\right]}}} % [1]
\newcommand{\VT}[1]{\EM{{\|#1\|}_{\text{\scriptsize VT}}}} % tot. var.
\newcommand{\LIP}[1]{\EM{\|#1\|_{\mathrm{Lip}}}} % Lipschitz norm.
\newcommand{\WH}[1]{\widehat{#1}}
%% Fonctionals and functions.
\newcommand{\sentf}{\bH}
\newcommand{\sent}[1]{\p(){\sentf}{#1}}
\newcommand{\bentf}[1]{\bH_{#1}}
\newcommand{\bent}[2]{\p(){\bentf{#1}}{#2}}
\newcommand{\eentf}{\bN}
\newcommand{\eent}[1]{\p(){\eentf}{#1}}
\newcommand{\entf}[1]{\mathbf{Ent}_{#1}}
\newcommand{\ent}[2]{\p(){\entf{#1}}{#2}}
\newcommand{\ientf}[1]{\bH^{#1}}
\newcommand{\ient}[2]{\p(){\ientf{#1}}{#2}}
\newcommand{\rentf}{\mathbf{Ent}}
\newcommand{\rent}[2]{\p(){\rentf}{#1\,\vert\,#2}}
\newcommand{\entr}{\mathbf{Ent}_r}
\newcommand{\enef}[1]{\boldsymbol{\mathcal{E}}_{#1}}
\newcommand{\ene}[2]{\p(){\enef{#1}}{#2}}
\newcommand{\imutf}{\bI}
\newcommand{\imut}[1]{\p(){\imutf}{#1}}
\newcommand{\fcrf}{\dI}
\newcommand{\fcr}[1]{\p(){\fcrf}{#1}}
\newcommand{\fishf}{\bJ}
\newcommand{\fish}[1]{\p(){\fishf}{#1}}
\newcommand{\fishmf}{\dJ}
\newcommand{\fishm}[1]{\p(){\fishmf}{#1}}
\newcommand{\moyf}[1]{\bE_{#1}}
\newcommand{\moy}[2]{\p(){\moyf{#1}}{#2}}
\newcommand{\econd}[2]{\p(){\moyf{}}{#1\,\vert\,#2}}
\newcommand{\bmoy}[2]{\moyf{#1}\!\biggl(#2\biggr)}
\newcommand{\corrf}[1]{\mathbf{Cor}_{#1}}
\newcommand{\corr}[3]{\p(){\corrf{#1}}{#2,#3}}
\newcommand{\covf}[1]{\mathbf{Cov}_{#1}}
\newcommand{\cov}[3]{\p(){\covf{#1}}{#2,#3}}
\newcommand{\bcov}[3]{\covf{#1}\!\biggl(#2,#3\biggr)}
\newcommand{\suppf}{\mathrm{supp}}
\newcommand{\supp}[1]{\suppf\PAR{#1}}
\newcommand{\DIMF}{\mathrm{dim}}
\newcommand{\DIM}[1]{\DIMF\PAR{#1}}
\newcommand{\RANGEF}{\mathrm{range}}
\newcommand{\RANGE}[1]{\RANGEF\PAR{#1}}
\newcommand{\varf}[1]{\mathbf{Var}_{#1}}
\newcommand{\var}[2]{\p(){\varf{#1}}{#2}}
\newcommand{\bvar}[2]{\varf{#1}\!\biggl(#2\biggr)}
\newcommand{\Kf}{\bK}
\newcommand{\K}[1]{\p(){\Kf}{#1}}
\newcommand{\vrs}[1]{\mathbf{L}_{#1}}
\newcommand{\lik}[1]{\vrs{#1}}
%% Sets, spaces, and functional spaces.
\newcommand{\C}[1]{\p(){\cC}{#1}}
\newcommand{\Cb}[1]{\p(){\cC_b}{#1}}
\newcommand{\Cc}[1]{\p(){\cC_c}{#1}}
\newcommand{\Cn}[2]{\p(){\cC^{#1}}{#2}}
\newcommand{\Ci}[1]{\Cn{\infty}{#1}}
\newcommand{\Cic}[1]{\p(){\cC_c^\infty}{#1}}
\newcommand{\Cnc}[2]{\p(){\cC_c^{#1}}{#2}}
\newcommand{\Cnb}[2]{\p(){\cC_b^{#1}}{#2}}
\newcommand{\Cib}[1]{\p(){\cC_b^\infty}{#1}}
\newcommand{\leb}[2]{\p(){\bL^{#1}}{#2}}
\newcommand{\lebb}[1]{\bL^{#1}}
%% Determinant, trace, ...
\newcommand{\Tr}{\mathrm{Tr\,}}
\newcommand{\Det}[1]{\mathrm{Det}\,}
\newcommand{\TR}[1]{\p(){\mathrm{Tr}}{#1}}
\newcommand{\DIAG}[1]{\p(){\mathrm{Diag}}{#1}}
\newcommand{\DET}[1]{\p(){\mathrm{Det}}{#1}}
\newcommand{\SIG}[1]{\p(){\mathrm{Sign}}{#1}}
\newcommand{\KER}[1]{\p(){\mathrm{Ker}}{#1}}
\newcommand{\RG}[1]{\p(){\mathrm{Range}}{#1}}
\newcommand{\DIAM}[1]{\p(){\mathrm{Diam}}{#1}}
\newcommand{\ID}{\mathbf{Id}}
\newcommand{\Id}{\mathrm{Id}}
\newcommand{\Mo}{\mathbf{1}}
\newcommand{\Vo}{\mathrm{1}}
%%% Semi-groups, generators, carre-du-champ, ...
\newcommand{\CD}{CD(\rho ,\infty)}
\newcommand{\GA}{\boldsymbol{\Gamma}}
\newcommand{\GD}{\GA_{\!\!{\mathbf 2}}}
\newcommand{\GI}{\bL}
\newcommand{\GR}{\nabla}
\newcommand{\GIV}{\EM{\overrightarrow{\GI}}}
\newcommand{\GIB}{\EM{\overline{\GI}}}
\newcommand{\LA}{\boldsymbol{\Delta}}
\newcommand{\ROT}{\mathbf{rot}\,}
\newcommand{\DIV}{\mathbf{div}\,}
\newcommand{\PT}[1][t]{\mathbf{P}_{\!#1}}
\newcommand{\SGf}[1]{{\mathbf P}_{#1}}
\newcommand{\SG}[2]{\p(){\SGf{\!#1}}{#2}}
\newcommand{\SGQf}[1]{{\mathbf Q}_{#1}}
\newcommand{\SGQ}[2]{\p(){\SGQf{#1}}{#2}}
\newcommand{\isopf}{\mathbf{I}}
\newcommand{\isop}[1]{\p(){\isopf}{#1}}
\newcommand{\disop}[1]{\p(){\isopf'}{#1}}
\newcommand{\ddisop}[1]{\p(){\isopf''}{#1}}
\newcommand{\HESS}[1]{\GR^2\!{#1}}
\newcommand{\Hess}[1]{{\p(){\mathrm{Hess}}{#1}}}
\newcommand{\HAM}{\bH}
\newcommand{\POT}{\bV}
\newcommand{\PF}{\bZ}
\newcommand{\DOM}{\EM{\cD_2(\GI)}}
\newcommand{\laV}{\EM{\overrightarrow{\la}}}
\newcommand{\DOML}{\EM{\cD_2\PAR{\GI}}}
\newcommand{\DOMB}{\EM{\cD_2(\GIB)}}
\newcommand{\DOMV}{\EM{\cD_2(\GIV)}}
\newcommand{\GAV}{\EM{\overrightarrow{\GA}}}
\newcommand{\D}{\mathbf{D}}
%% Topology.
\newcommand{\inter}[1]{{\overset{\circ}{#1}}} % interior
\newcommand{\adher}[1]{{\overline{#1}}} % adherence
\newcommand{\ADH}[1]{\mathbf{adh}(#1)}
\newcommand{\INT}[1]{\mathbf{int}(#1)}
%% Miscellany.
\newcommand{\DOTIMES}{\otimes\cdots\otimes}
\newcommand{\DOPLUS}{\oplus\cdots\oplus}
\newcommand{\CARD}{\mathrm{card}}
\newcommand{\SSK}[1]{\substack{#1}}
\renewcommand{\leq}{\leqslant}
\renewcommand{\geq}{\geqslant}
\newcommand{\bs}{\EM{\backslash}}
\newcommand{\Inf}{\boldsymbol{\inf}}
\newcommand{\Sup}{\boldsymbol{\sup}}
\newcommand{\ds}[1]{\EM{\displaystyle{#1}}}
\newcommand{\eg}{\overset{\Delta}{=}}
\newcommand{\fdefeq}{\overset{\text{déf.}}{=}}
\newcommand{\edefeq}{\overset{\text{def.}}{=}}
\newcommand{\defeq}{:=}
\newcommand{\equ}{\; \Leftrightarrow \;}
\newcommand{\ex}{\exists \,}
\newcommand{\imp}{\Rightarrow  \;}
\newcommand{\ssi}{{\it ssi}}
\newcommand{\tout}{\forall \,}
\newcommand{\tq}{\,|\,}
\newcommand{\st}{\,|\,}
\newcommand{\DSFRAC}[2]{\EM{\frac{\ds{#1}}{\ds{#2}}}}
\newcommand{\SR}[2]{\EM{\strackrel{#1}{#2}}}
\def\Ieme{\up{\lowercase{ième}}\xspace}
%% Vectors and matrices.
\newcommand{\VECTOR}[1]{\PAR{\begin{array}{c} #1 \end{array}}}
\newcommand{\BIMATRIX}[1]{\PAR{\begin{array}{cc} #1 \end{array}}}
\newcommand{\Vector}[2]{\PAR{\begin{array}{#1} #2 \end{array}}}
\newcommand{\Bimatrix}[2]{\PAR{\begin{array}{#1} #2 \end{array}}}
%%%%
%%%% Commands to be executed just after \begin{document}
%%%%
\AtBeginDocument{%
 \selectlanguage{francais}%
 \graphicspath{{images/}{img/}{Images}{Img}{ps}{eps}{PS}{EPS}%
  {postscript}{postscripts}{pdf}{PDF}}%
 \PREMIEREPAGE%
}
%%%%
%%%% Commands to be executed just before \end{document}
%%%%
\AtEndDocument{\vfill}
\endinput
%%
%% End of file `pbsheet.cls'.
