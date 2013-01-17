%  %NAME%    : Petiteannonce
%  %AUTHOR%  : Vincent Bela\"\i che
%  %EMAIL%   : vincent.b.1@hotmail.fr
%  %VERSION% : v1.001
%% 
%% This is file `petiteannonce.cls'.
%% 
%% 
%% IMPORTANT NOTICE: 
%% 
%% This file is part of the "petiteannonce" package.
%% This package is distributed under the terms of the LaTeX Project
%% Public License (LPPL) described in the file lppl.txt.
%%
%% Ce fichier fait partie de la distribution du paquetage "petiteannonce".
%% Ce paquetage est distribué sous les termes de la License Publique
%% du Projet LaTeX (LPPL) décrite dans le fichier lppl.txt.
%%
%
%    ****************************************
%    *             PREAMBULE                *
%    ****************************************
%
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{graphicx}
\RequirePackage{keyval}
\ProvidesClass{petiteannonce}[2012/04/10 v1.001]
% Get font sizes
\makeatletter
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}


%\typeout{}
%% petiteannonce options
%\DeclareOption{someoption}{do something}
\ExecuteOptions{10pt}

\newdimen\petiteannonce@margin
\petiteannonce@margin=1mm
\define@key{petiteannonce@args}{margin}{\petiteannonce@margin=#1}

\DeclareOption*{%
  \def\@tempa#1{\setkeys{petiteannonce@args}{#1}}%
  \expandafter\@tempa\expandafter{\CurrentOption}%
}
\ProcessOptions
\input{size1\@ptsize.clo}
%
%    ****************************************
%    *               POLICES                *
%    ****************************************
%
\DeclareOldFontCommand{\rm}{\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sl}{\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\it}{\itshape}{\mathit}
\DeclareOldFontCommand{\sc}{\scshape}{\@nomath\sc}
\DeclareOldFontCommand{\bf}{\bfseries}{\mathbf}
\DeclareOldFontCommand{\sf}{\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\ttfamily}{\mathtt}
\DeclareRobustCommand*{\cal}{\@fontswitch{\relax}{\mathcal}}
\DeclareRobustCommand*{\mit}{\@fontswitch{\relax}{\mathnormal}}


%
%    ****************************************
%    *      MISE-EN-PAGE : parametres       *
%    ****************************************
%
\topmargin        =\petiteannonce@margin%  marge sup.
% suppression de l'offset vertical
\advance\topmargin by -1in
\headheight        0pt% entete
\headsep           0mm% sep. d'entete
\textheight        297mm 
\advance\textheight by -2\petiteannonce@margin% hauteur texte
\footskip          0mm% sep d'embase
%
% total vertical 1+0+295+0=296 mm, reste 1 mm sur A4 = 297 mm.
%
\footnotesep       0mm%
\marginparpush     0mm%
%
% marge gauche    
\oddsidemargin    =\petiteannonce@margin%
\evensidemargin   =\petiteannonce@margin%
% suppression de l'offset horizontal
\advance \oddsidemargin by  -1in%
\advance \evensidemargin by  -1in%
\textwidth       210mm
\advance\textwidth by -2\petiteannonce@margin%largeur texte  
\marginparsep      0mm% separation note lat\'erale
\marginparwidth   0mm% largeur note latérale
%
% total horizontal 1+208+0+0=209 mm, reste 1 mm sur A4 = 210 mm.
%
\skip\footins    4mm plus 2pt minus 4pt%
\pagestyle{empty}

% objects for keyval-ed arguments
\newcount \petiteannonce@cols
\newcount \petiteannonce@count
\newcount \petiteannonce@skip
\newdimen \petiteannonce@cutvspace
\newdimen \petiteannonce@telcolsep % separation between telephone columns
\newdimen \petiteannonce@telrulewidth
\newdimen \petiteannonce@telvspace % space before and after telephone number
\newdimen \petiteannonce@texthspace % space before and after text
\newdimen \petiteannonce@textvspace % space above and below text
\newdimen \petiteannonce@frame@width
\newdimen \petiteannonce@width
\newdimen \petiteannonce@this@textwidth
% ============================================================================
% Define keys and their default values
% ============================================================================
\define@key{petiteannonce}{cols}[1]{%
  \petiteannonce@cols=#1\relax
  \petiteannonce@frame@width=\textwidth
  \divide\petiteannonce@frame@width by \petiteannonce@cols
  \petiteannonce@width=\petiteannonce@frame@width
  \advance\petiteannonce@width by -2\fboxrule
  \advance\petiteannonce@width by -2\fboxsep
}
\define@key{petiteannonce}{count}[1]{\petiteannonce@count=#1}
\define@key{petiteannonce}{cutvspace}[10pt]{\petiteannonce@cutvspace=#1}
\define@key{petiteannonce}{skip}[0]{\petiteannonce@skip=#1}
\define@key{petiteannonce}{telcolsep}[10pt]{\petiteannonce@telcolsep=#1}
\define@key{petiteannonce}{telrulewidth}[0.5pt]{\petiteannonce@telrulewidth=#1}
\define@key{petiteannonce}{telvspace}[10pt]{\petiteannonce@telvspace=#1}
\define@key{petiteannonce}{textvspace}[10pt]{\petiteannonce@textvspace=#1}
\define@key{petiteannonce}{texthspace}[20pt]{\petiteannonce@texthspace=#1}
\define@key{petiteannonce}{width}[\textwidth]{\petiteannonce@frame@width=#1\relax
  \petiteannonce@width=\petiteannonce@frame@width
  \advance\petiteannonce@width by -2\fboxrule
  \advance\petiteannonce@width by -2\fboxsep
}
% other objects for dimensions
\newcount \petiteannonce@telcount@temp
\newdimen \petiteannonce@half@colsep@worule % without rule
\newdimen \petiteannonce@telheight% width of telephone number when horizontal + hspace 
\newdimen \petiteannonce@telwidth % total = height + depth of telephone number when horizontal
\newdimen \petiteannonce@telwidth@temp 
\newdimen \petiteannonce@textwidth
\newdimen \petiteannonce@width@min@colsep % width reduced by column separator.
% counters for counting telephone number strips
\newcount \petiteannonce@telcount 
\newcount \petiteannonce@telcount@minone % same as above minus 1
% counters for counting petiteannonce
\newcount \petiteannonce@count@temp
\newcount \petiteannonce@col@temp
% boxes
\newsavebox{\petiteannonce@telbox}
\newsavebox{\petiteannonce@box}
\newsavebox{\petiteannonce@tel}

% ==============================================================================
% The \petiteannonce command:
%
% Arg 1            = Telephone number
% Arg 2            = Advertisement text
% Arg 3 (optional) = Option keys
% ==============================================================================
\newcommand\petiteannonce[3][]{%
  % Omitting keyed arguments is same as setting them to their default values
  \KV@petiteannonce@cols@default{}%
  \KV@petiteannonce@count@default{}%
  \KV@petiteannonce@cutvspace@default{}%
  \KV@petiteannonce@skip@default{}%
  \KV@petiteannonce@telcolsep@default{}%
  \KV@petiteannonce@telrulewidth@default{}%
  \KV@petiteannonce@telvspace@default{}%
  \KV@petiteannonce@texthspace@default{}%
  \KV@petiteannonce@textvspace@default{}%
  \KV@petiteannonce@width@default{}%
  % parse keyed arguments
  \setkeys{petiteannonce}{#1}%
  % consistency checks
  \ifnum\petiteannonce@cols<1\relax%
    \ClassError{petiteannonce}%
    {non positive cols key value}%
    {The value of key cols shall be positive;\MessageBreak
     cols value will be forced to 1.}%
     \petiteannonce@cols=1
   \fi%
  % consistency check is  To Be Compeleted
  \petiteannonce@width@min@colsep=\petiteannonce@width%
  \advance\petiteannonce@width@min@colsep by -\petiteannonce@telcolsep%
  % compute half values and other temporary dimensions and counters
  \petiteannonce@textwidth=\petiteannonce@width%
  \advance\petiteannonce@textwidth by -\petiteannonce@texthspace%
  \petiteannonce@half@colsep@worule=0.5\petiteannonce@telcolsep%
  \advance\petiteannonce@half@colsep@worule by -\petiteannonce@telrulewidth%
  %
  \sbox{\petiteannonce@tel}{\mbox{#2}}%
  \def\petiteannonce@text{%
    \hspace{0.5\petiteannonce@texthspace}%
    \begin{minipage}{\petiteannonce@textwidth}%
      #3%
    \end{minipage}%
    \hspace{0.5\petiteannonce@texthspace}%
  }%
  % compute tel dimension
  % ------------------------------
  %
  % tel-width = total height+depth when looked at horizontally
  % this is a first approximate that is going to be refined later on
  \settoheight{\petiteannonce@telwidth}{\usebox{\petiteannonce@tel}}%
  \settodepth{\petiteannonce@telwidth@temp}{\usebox{\petiteannonce@tel}}%
  \advance\petiteannonce@telwidth by \petiteannonce@telwidth@temp%
  % tel-height = width when looked at horizontally + some vspace
  \settowidth{\petiteannonce@telheight}{\usebox{\petiteannonce@tel}}
  \advance\petiteannonce@telheight by \petiteannonce@telvspace
  % compute into \petiteannonce@telwidth@temp the number of columns (as a real number)
  \advance\petiteannonce@telwidth by \petiteannonce@telcolsep
  \petiteannonce@telwidth@temp=\petiteannonce@width%
  %\advance\petiteannonce@telwidth@temp by \petiteannonce@telcolsep 
  \divide\petiteannonce@telwidth@temp by \petiteannonce@telwidth
  \petiteannonce@telcount=\petiteannonce@telwidth@temp % floor
  % column count - 1
  \petiteannonce@telcount@minone=\petiteannonce@telcount
  \advance\petiteannonce@telcount@minone by -1
  % refine tel width now
  \petiteannonce@telwidth@temp=\petiteannonce@telcolsep
  \multiply\petiteannonce@telwidth@temp by \petiteannonce@telcount
  \petiteannonce@telwidth=\petiteannonce@width
  \advance\petiteannonce@telwidth by - \petiteannonce@telwidth@temp
  \divide\petiteannonce@telwidth by \petiteannonce@telcount
  % save the telephone into a box
  \savebox{\petiteannonce@telbox}[\petiteannonce@telwidth]{%
    \rotatebox{90}{%
      \hspace{0.5\petiteannonce@telvspace}\usebox{\petiteannonce@tel}\hspace{0.5\petiteannonce@telvspace}%
    }%
  }
  % define the row of repeated telephone number
  % -----------------------------------------------
  \def\petiteannonce@telrow
  {%
    \makebox[\petiteannonce@width]{%
    \hspace{0.5\petiteannonce@telcolsep}%
    \usebox{\petiteannonce@telbox}%
    \petiteannonce@telcount@temp=\petiteannonce@telcount%
    \loop%
      \hspace\petiteannonce@half@colsep@worule%
      \vrule width\petiteannonce@telrulewidth height\petiteannonce@telheight%
      \hspace\petiteannonce@half@colsep@worule%
      \usebox{\petiteannonce@telbox}%
      \advance\petiteannonce@telcount@temp by -1%
    \ifnum\petiteannonce@telcount@temp>2\repeat\relax%
    \hspace{0.5\petiteannonce@telcolsep}%
    }%
  }%
  % now make one petiteannonce
  \savebox{\petiteannonce@box}[\petiteannonce@frame@width]{%
    \framebox[\petiteannonce@frame@width]{%
      \begin{minipage}{\petiteannonce@width}%
        \vspace{0.5\petiteannonce@textvspace}%

        \petiteannonce@this@textwidth=\petiteannonce@textwidth
        \noindent\petiteannonce@text%

        \vspace{0.5\petiteannonce@textvspace}%

        \noindent \hbox to\petiteannonce@width{\dotfill}%

        \vspace{\petiteannonce@cutvspace}%
        
        \noindent\petiteannonce@telrow%
      \end{minipage}%
    }%
  }%
  % now the petiteannonce main loop
  \petiteannonce@count@temp=\petiteannonce@skip%
  \petiteannonce@col@temp=1%
  %
  \noindent%
  \loop\ifnum\petiteannonce@count@temp<\petiteannonce@count\relax%
    \usebox{\petiteannonce@box}%
    \advance\petiteannonce@count@temp by 1%
    \advance\petiteannonce@col@temp by 1%
    \ifnum\petiteannonce@col@temp=\petiteannonce@cols\relax%
      \newline%
      \petiteannonce@col@temp=1%
    \fi%
  \repeat%
  }%

\@ifundefined{petiteannoncewidth}{%
  \def\petiteannoncewidth#1{#1\petiteannonce@this@textwidth}%
}{%
  \ClassError{petiteannonce}%
  {Already defined command petiteannoncewidth}%
  {Already defined command petiteannoncewidth}%
}

\@ifundefined{petiteannonceaddtowidth}{%
  \def\petiteannonceaddtowidth#1{\advance \petiteannonce@this@textwidth by #1\relax}%
}{%
  \ClassError{petiteannonce}%
  {Already defined command petiteannonceaddtowidth}%
  {Already defined command petiteannonceaddtowidth}%
}

\makeatother
%
%%
%% End of file `petiteannonce.cls.
