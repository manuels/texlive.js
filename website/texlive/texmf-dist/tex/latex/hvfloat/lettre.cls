%  %NAME%    : Lettre
%  %AUTHOR%  : Denis Mégevand - Observatoire de Genève
%  %EMAIL%   : Denis.Megevand@obs.unige.ch
%  %VERSION% : v2.346
%% 
%% This is file `lettre.cls'.
%% 
%% The original source files were:
%% 
%% letter.cls  - LaTeX 2e team
%% lettre.sty  - D. Megevand
%% 
%% 
%% IMPORTANT NOTICE: 
%% 
%% This file is part of the "lettre" package.
%% This package is distributed under the terms of the LaTeX Project
%% Public License (LPPL) described in the file lppl.txt.
%%
%% Denis Mégevand - Observatoire de Genève.
%%
%% Ce fichier fait partie de la distribution du paquetage "lettre".
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
\ProvidesClass{lettre}[2002/07/22 v2.346]
\typeout{Copyleft Denis Megevand - Observatoire de Geneve}%
%%
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility
  \DeclareOption{twoside}{\@latexerr{No `twoside' layout for letters}%
                                   \@eha}
\else
  \DeclareOption{twoside}{\@twosidetrue}
\fi
\DeclareOption{oneside}{\@twosidefalse}
\DeclareOption{origdate}{\@origdatetrue\PackageWarningNoLine{lettre}{Mode `origdate'}}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{francais}{\def\defaultlanguage{francais}}
\DeclareOption{romand}{\def\defaultlanguage{romand}}
\DeclareOption{allemand}{\def\defaultlanguage{allemand}}
\DeclareOption{americain}{\def\defaultlanguage{americain}}
\DeclareOption{anglais}{\def\defaultlanguage{anglais}}
\if@compatibility
\else
\DeclareOption*{\PackageWarningNoLine{lettre}{Option inconnue : `\CurrentOption'}}
\fi
\newif\if@origdate\@origdatefalse
\newif\if@etiq\@etiqfalse
\ExecuteOptions{10pt,oneside,final,francais}
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
%    *       PARAGRAPHES : parametres       *
%    ****************************************
%
\lineskip  1pt%
\normallineskip 1pt%
\parskip  .7em%
\parindent 0pt%
\topsep   .2em%
\partopsep 0pt%
\itemsep  .2em%
\renewcommand\baselinestretch{1}
%
\@lowpenalty   51\relax
\@medpenalty  151\relax
\@highpenalty 301\relax
\@beginparpenalty -\@lowpenalty 
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
%
%    ****************************************
%    *      MISE-EN-PAGE : parametres       *
%    ****************************************
%
% suppression de l'offset vertical
\voffset          -1in%
% marge sup.      25mm
\topmargin        25mm%
% sep. d'entete    4mm
\headheight        0pt%
\headsep           4mm%
% hauteur texte  250mm
\textheight      250mm%
% sep d'embase     9mm
\footskip          9mm%
%
% total vertical 25+4+250+9=288 mm, reste 9 mm sur A4 = 297 mm.
%
\footnotesep       5mm%
\marginparpush     1mm%
%
% suppression de l'offset horizontal
\hoffset          -1in%
% marge gauche    25mm
\oddsidemargin    25mm%
\evensidemargin   25mm%
% largeur texte  160mm
\textwidth       160mm%
% sep. note lat.  4mm
\marginparsep      4mm%
% larg. note lat 15mm
\marginparwidth   15mm%
%
% total horizontal 25+160+4+15=204 mm, reste 6 mm sur A4 = 210 mm.
%
\skip\footins    4mm plus 2pt minus 4pt%
%
%    ************************************************
%    *       LE FORMAT LETTRE ET FAX DE             *
%    *        L'OBSERVATOIRE DE GENEVE              *
%    ************************************************
%
%    ************************************************
%    *   NEWCOUNTS, NEWDIMENS, NEWIFS, NEWWRITE     *
%    ************************************************
%
\newcount\auxcount
\newcount\c@infos\c@infos=1\relax
\newcount\c@labelstart
\newcount\c@lettre
\newcount\c@telefax
\newcount\emailcount
\newcount\faxpage
\newcount\sigflag
\newcount\signum
%
\newdimen\letterwidth
\newdimen\openingspace
\newdimen\openingindent
\newdimen\lettermargin
\newdimen\listmargin
\newdimen\sigspace
\newdimen\ssigindent
\newdimen\ssigwidth
\newdimen\msigwidth
\newdimen\fromaddress@let@width
\newdimen\fromlieu@let@width
\newdimen\toaddress@let@width
\newdimen\fromaddress@fax@width
\newdimen\faxstring@width
\newdimen\faxbox@width
\newdimen\toaddress@fax@width
\newdimen\fromname@fax@width
%
\newif\if@letter\@lettertrue
\newif\if@detail\@detailfalse 
%
\newwrite\@tensionaux
\newwrite\@dateaux
\newwrite\@etiqaux
\newwrite\@faxaux
%
%    ************************************************
%    *               MACROS INTERNES                *
%    ************************************************
%
\def\t#1#2{\begin{list}{#1}{\setlength{\labelsep}{10pt}%
                            \setlength{\labelwidth}{\listmargin}%
                            \setlength{\leftmargin}{\listmargin}%
                            \setlength{\listparindent}{0pt}}%
           \item #2%
           \end{list}}
\def\detailledaddress{\@detailtrue}%
%
\def\stopletter{\vskip0ptplus1filll}%
\def\stopfax{\vskip0ptplus1filll}%
%
\def\resetopenenv{%
        \faxpage=0\relax
        \csname\defaultlanguage\endcsname
        \def\concdecl{}%
        \def\fromlocation{}%
        }%
\def\resetcloseenv{
        \def\fromsig{}\def\fromssig{}\def\fromtsig{}
        \ps@plain
        \pagenumbering{arabic}       
        \onecolumn                   
        \signum=0\relax
        }
\def\resetauxenv{
        \def\auxflag{}
        \auxcount=0\relax
        \def\toref{}\def\fromref{}
        \def\telexnum{}\def\ccpnum{}
        }
\def\resetemailenv{
        \def\emailflag{}
        \emailcount=0\relax
        \def\@username{}
        \def\ccittnum{}\def\internetnum{}\def\bitnetnum{}\def\telepacnum{}\def\decnetnum{}
        }
%
% \@processto extrait \toname et \toaddress de l'environnement letter
%
\long\def\@processto#1{\@xproc #1\\@@@\ifx\toaddress\@empty 
    \else \@yproc #1@@@\fi}%
\long\def\@xproc #1\\#2@@@{\def\toname{#1}\def\toaddress{#2}}%
\long\def\@yproc #1\\#2@@@{\def\toaddress{#2}}%
%
\def\stopbreaks{\interlinepenalty \@M
   \def\par{\@@par\nobreak}\let\\=\@nobreakcr
   \let\vspace\@nobreakvspace}%
\def\@nobreakvspace{\@ifstar{\@nobreakvspacex}{\@nobreakvspacex}}%
\def\@nobreakvspacex#1{\ifvmode\nobreak\vskip #1\relax\else
               \@bsphack\vadjust{\nobreak\vskip #1}\@esphack\fi}%
\def\@nobreakcr{\vadjust{\penalty\@M}\@ifstar{\@xnewline}{\@xnewline}}%
\def\startbreaks{\let\\=\@normalcr
   \interlinepenalty 200\relax\def\par{\@@par\penalty -100\relax}}%
%
%*************************************************************
%                  MESSAGES ET AVERTISSSEMENTS               *
%*************************************************************
%
% Envoyes a la console et dans le fichier de log
%
% On peut supprimer allumer ou eteindre en tout temps les
% messages d'informations par les commandes \infos et \noinfos.
% Les avertissements ne peuvent etre supprimes.
%*************************************************************
\def\infos{\c@infos=1\relax}
\def\noinfos{\c@infos=0\relax}
%
\def\ltypeout#1{{\let\protect\string\immediate\write16{#1}}}%
\def\l@@warning#1{\typeout{LETTRE WARNING: #1.}}%
\def\l@warning#1{\l@@warning{#1\on@line}}%
\def\l@@info#1{\ifnum\c@infos=1\typeout{LETTRE INFO: #1.}\fi}%
%
%    ************************************************
%    *                 ETIQUETTES                   *
%    ************************************************
%
% La commande \startlabels suivante definit des pages 
% A4 de 2 colonnes d'etiquettes avec 15 mm de marges
% gauche et droite sur chaque etiquette.
% Si l'on change le nombre d'etiquettes sur une page, 
% il faut aussi modifier la routine \@startlabels
%
\def\startlabels{%
\baselineskip=0pt\lineskip=0pt%
\pagestyle{empty}%
\let\@texttop=\relax
\topmargin=0pt\headsep=0pt%
\oddsidemargin=15mm\evensidemargin=15mm%
%
% modifications des dimensions de la page a faire ici
%
\textheight=297mm\textwidth=180mm\columnsep=30mm%
\@colht=\textheight\@colroom=\textheight\vsize=\textheight
\small
\baselineskip=0pt\lineskip=0pt%
\boxmaxdepth=0pt%
\twocolumn\relax}%
%
% La commande \@startlabels suivante definit la position de la 
% premiere etiquette sur la page, a partir de la valeur du 
% compteur \c@labelstart.
%
\def\@startlabels{%
\l@@info{Position de la premiere etiquette: \the\c@labelstart}%
\ifnum\c@labelstart>\z@
    \ifnum\c@labelstart>16\relax 
        \l@@warning{Position de la premiere etiquette ignoree}%
    \else
    \@whilenum\c@labelstart>\@ne\do
        {\immediate\write\@etiqaux{\string\mlabel{~\string\\~}}%
         \advance\c@labelstart\m@ne}%
    \fi%
\else
    \l@@warning{Position de la premiere etiquette ignoree}%
\fi
}%
%
% La commande \mlabel fabrique une etiquette de 37 mm de hauteur,
% la largeur etant definie dans \startlabels (105mm-30mm de marges)
% chacune contenant 70 mm de texte au centre de l'etiquette.
\def\mlabel#1{\setbox0\vbox{\parbox[b]{70mm}{\rm\strut\ignorespaces #1}}%
         \vbox to 37mm{\vskip5mmplus1fil \box0 \vskip5mmplus1fil}}%
%
% \makelabels demande a \begin{document} d'imprimer sur le fichier 
% auxiliaire .etq l'ordre de preparer les etiquettes.
% Son argument optionnel definit quelle est la prochaine etiquette 
% libre sur la page, de maniere a utiliser des feuilles deja 
% partiellement utilisees. Dans ce cas, \begin{document} imprime 
% autant d'etiquettes vides que necessaire.
%
\def\makelabels{%
    \@etiqtrue
    \l@@info{On demande des etiquettes}%
    \@ifnextchar [{\i@makelabels}{\i@makelabels[1]}}%
\def\i@makelabels[#1]{\c@labelstart=#1}%
%
%    ****************************************
%    *       ADAPTATIONS DES DEFAUTS        *
%    ****************************************
%
\def\institut#1{%
  \l@@info{Fichier de defaut: #1.ins}%
  \def\@institut{\makeatletter
                 \input{#1.ins}%
                 \makeatother}}%
%
%    ************************************************
%    *        ENVIRONNEMENTS LETTER ET FAX          *
%    ************************************************
%
\long\def\letter#1{%
  \rm
  \global\advance\c@lettre\@ne
  \l@@info{Lettre \the\c@lettre}%
  \expandafter\ifx\csname newletter\the\c@lettre\endcsname\relax
     \expandafter\def\csname letter\the\c@lettre\endcsname{2}
  \else
     \expandafter\def\csname letter\the\c@lettre\endcsname{%
		\csname newletter\the\c@lettre\endcsname}
  \fi
  \ifodd\c@page%
  \else
    \if@twoside
      \l@@info{Saut de page force pour commencer la lettre sur une page impaire.}%
      \thispagestyle{empty}
      \hbox{}\penalty-10000\relax
    \fi
  \fi
  \c@page\@ne
  \resetopenenv\resetcloseenv\resetauxenv\resetemailenv
  \@lettertrue
  \@institut
  \let\opening=\letteropening
  \interlinepenalty=200\relax
  \@processto{#1}
}%
%
\def\endletter{\par
  \ifdim\pagetotal < 50pt
    \immediate\write\@tensionaux{%
          \string\expandafter\string\def%
          \string\csname\space newletter\the\c@lettre\string\endcsname{-2}}%
    \l@@warning{Longueur de la derniere page : \the\pagetotal < 50pt}%
    \l@@warning{  tension de page modifiee a -2, veuillez recompiler}%
  \else
  \ifdim\pagetotal < 90pt
    \immediate\write\@tensionaux{%
          \string\expandafter\string\def%
          \string\csname\space newletter\the\c@lettre\string\endcsname{-4}}%
    \l@@warning{Longueur de la derniere page : \the\pagetotal < 90pt}%
    \l@@warning{  tension de page modifiee a -4, veuillez recompiler}%
  \else
  \ifdim\pagetotal < 130pt
    \immediate\write\@tensionaux{%
          \string\expandafter\string\def%
          \string\csname\space newletter\the\c@lettre\string\endcsname{-5}}%
    \l@@warning{Longueur de la derniere page : \the\pagetotal < 130pt}%
    \l@@warning{  tension de page modifiee a -5, veuillez recompiler}%
  \else
  \ifdim\pagetotal < 170pt
    \immediate\write\@tensionaux{%
          \string\expandafter\string\def%
          \string\csname\space newletter\the\c@lettre\string\endcsname{-6}}%
    \l@@warning{Longueur de la derniere page : \the\pagetotal < 170pt}%
    \l@@warning{  tension de page modifiee a -6, veuillez recompiler}%
  \else
  \ifdim\pagetotal < 210pt
    \immediate\write\@tensionaux{%
          \string\expandafter\string\def%
          \string\csname\space newletter\the\c@lettre\string\endcsname{4}}%
    \l@@warning{Longueur de la derniere page : \the\pagetotal < 210pt}%
    \l@@warning{  tension de page modifiee a 4, veuillez recompiler}%
  \else
  \ifdim\pagetotal < 250pt
    \immediate\write\@tensionaux{%
          \string\expandafter\string\def%
          \string\csname\space newletter\the\c@lettre\string\endcsname{6}}%
    \l@@warning{Longueur de la derniere page : \the\pagetotal < 250pt}%
    \l@@warning{  tension de page modifiee a 6, veuillez recompiler}%
  \else
    \immediate\write\@tensionaux{%
          \string\expandafter\string\def%
          \string\csname\space newletter\the\c@lettre\string\endcsname{%
          \csname letter\the\c@lettre\endcsname}}%
    \l@@info{Longueur de la derniere page : \the\pagetotal >= 250pt}%
  \fi
  \fi
  \fi
  \fi
  \fi
  \fi
  \stopletter
  \@@par\pagebreak\@@par
  \if@etiq 
    \ifodd\c@page%
    \else
      \if@twoside
  	\l@@info{Saut de page force pour commencer les etiquettes sur une page impaire.}%
  	\thispagestyle{empty}
  	\hbox{}\penalty-10000\relax
      \fi
    \fi
    \begingroup 
      \def\protect{\string}%
      \let\\=\relax
      \def\protect##1{\string##1\space}%
      \immediate\write\@etiqaux{\string\mlabel{\toname
           \\\toaddress}}%
    \endgroup 
  \fi}%
%
\long\def\telefax#1#2{%
  \rm
  \global\advance\c@telefax\@ne
  \l@@info{Telefax \the\c@telefax}%
  \ifnum\c@telefax=\@ne
  \else
    \l@@warning{Un seul telefax par fichier, s.v.p.,}
    \l@@warning{  sinon le nombre de pages du fax est incorrect !}
  \fi
  \ifodd\c@page%
  \else
    \if@twoside
      \l@@info{Saut de page force pour commencer le telefax sur une page impaire.}%
      \thispagestyle{empty}
      \hbox{}\penalty-10000\relax
    \fi
  \fi
  \c@page\@ne
  \resetopenenv\resetcloseenv\resetauxenv\resetemailenv
  \@letterfalse
  \@institut
  \def\tofaxnum{#1}%
  \let\opening=\faxopening
  \interlinepenalty=200\relax
  \makeatletter
  \@input{\jobname.fax}%
  \l@@info{Lecture du fichier auxiliaire de fax: Nombre total de pages=\totalpages}%
  \makeatother
  \@processto{#2}
}%
%
\def\endtelefax{%
  \stopfax
  \begingroup 
    \advance\faxpage by\c@page
    \def\protect{\string}%
    \let\\=\relax
    \def\protect##1{\string##1\space}%
    \immediate\openout\@faxaux=\jobname.fax%
    \immediate\write\@faxaux{\string\def\string\totalpages{\the\faxpage}}%
    \if\totalpages\the\faxpage\else
      \l@@warning{Le nombre de pages du fax a change, }%
      \l@@warning{(ancien=\totalpages, nouveau=\the\faxpage) }%
      \l@@warning{  veuillez recompiler pour le corriger dans l'entete.}%
    \fi
  \endgroup
  \@@par\pagebreak\@@par
}%
%
%    ************************************************
%    *              OPENING ET CLOSING              *
%    ************************************************
%
\def\letteropening#1{%
                 \if@origdate
                   \expandafter\ifx\csname origdate\the\c@lettre
                                   \endcsname\relax
                   \else
                      \l@@info{Date originale lue dans \jobname.odt}%
                      \def\pdate{\csname origdate\the\c@lettre\endcsname}%
                   \fi
                   \l@@info{`\pdate' ecrit dans \jobname.odt}%
                   \immediate\write\@dateaux{%
                        \string\expandafter\string\def%
                        \string\csname\space origdate\the\c@lettre
                        \string\endcsname{\pdate}}%
                \fi
   \hbadness=10000\relax
   \thispagestyle{empty}% 
   \setlength{\unitlength}{1mm}%
   \advance\rightskip -75pt%
   \begin{picture}(\pict@let@width,\pict@let@height)%
                  (\pict@let@hoffset,\pict@let@voffset)%
     \put(\rule@hpos,\rule@vpos){\line(1,0){\rule@length}}%
     \put(\fromaddress@let@hpos,\fromaddress@let@vpos){\makebox(0,0)[tl]{%
          \parbox[t]{\fromaddress@let@width}{%
                  \fromaddress\\[3mm]%
                  \ifx\@empty\fromlocation
                  \else \fromlocation \\%
                  \fi 
                  \ifx\@empty\telephonenum
                  \else \tellabelname \telephonenum \\
                  \fi
                  \ifx\@empty\faxnum
                  \else \faxlabelname \faxnum \\
                  \fi
                  \ifx\@empty\emailnum
                  \else \mbox{\emaillabelname\ttfamily\emailnum} \\
                  \fi}}}
     \put(\fromlieu@let@hpos,\fromlieu@let@vpos){\makebox(0,0)[bl]{%
          \parbox[t]{\fromlieu@let@width}{%
                 \ifx\@empty\fromlieu
                 \else\fromlieu, %
                 \fi 
                \ifx\@empty\pdate ~%
                \else \pdate
                \fi}}}%
     \put(\toaddress@let@hpos,\toaddress@let@vpos){\makebox(0,0)[tl]{%
          \parbox{\toaddress@let@width}{%
                 \toname\\\toaddress}}}%
   \end{picture}%
   \par\vskip\csname letter\the\c@lettre\endcsname mm
   \advance\leftskip\lettermargin
   \advance\rightskip75pt%
   \ifx\@empty\auxflag
     \vspace{2\openingspace}%
   \else 
     \vspace{\openingspace}\auxline\vspace{\openingspace}%
   \fi
   \vskip\csname letter\the\c@lettre\endcsname mm
   \ifx\@empty\concdecl 
     \vspace{\openingspace}%
   \else 
     \concline\vspace{\openingspace}%
   \fi
   \vskip\csname letter\the\c@lettre\endcsname mm
   \hbadness=1000\relax
   {\parindent=\openingindent
   #1}\par\startbreaks\nobreak
   \let\flushleft=\letterflushleft
   \let\raggedright=\letterraggedright
   \let\center=\lettercenter
   \let\centering=\lettercentering}%
%
\def\faxopening#1{%
   \hbadness=10000\relax
   \thispagestyle{empty}%
   \setlength{\unitlength}{1mm}%
   \advance\rightskip -75pt%
   \begin{picture}(\pict@fax@width,\pict@fax@height)
                   (\pict@fax@hoffset,\pict@fax@voffset)%
     \put(\fromaddress@fax@hpos,\fromaddress@fax@vpos){\makebox(0,0)[tl]{
          \parbox[t]{\fromaddress@fax@width}{\fromaddress}}}%
     \put(\faxstring@hpos,\faxstring@vpos){\makebox(0,0)[bl]{%
          \parbox[t]{\faxstring@width}{\telefaxstring}}}
   \end{picture}\par%
 \par\vspace{5mm}%
  \makebox[\faxbox@width]{\scriptsize\telephonelabelname\telephonenum
   \hfill\telefaxlabelname\faxnum
   \ifx\@empty\emailnum\else\hfill\emaillabelname{\ttfamily\emailnum}\fi
   \ifx\@empty\telexnum\else\hfill\telexlabelname\telexnum\fi}%
 \par
 \begin{tabular*}{\faxbox@width}[t]{l@{\hspace{5mm}}p{70mm}@{\hfill}r}%
    \hline
    \multicolumn{3}{@{}c@{}}{\vrule height 0pt depth 0pt width \faxbox@width}\\
    \headtoname
       &\parbox[t]{\toaddress@fax@width}{\toname\\\toaddress}%
       &\telefaxname\tofaxnum\\%
    \\%
    \headfromname
       &\parbox[t]{\fromname@fax@width}{\ifx\@empty\fromlocation
                                       \fromname
                                   \else
                                       \fromlocation
                                   \fi}%
       &\pagetotalname\totalpages\\%
 \end{tabular*}\par%
 \begin{tabular*}{\faxbox@width}[t]{@{\hfill}c@{\hfill}}%
    \hline
    \vrule height 3ex depth 7pt width 0pt\faxwarning\\%
    \hline
 \end{tabular*}\par%
 \begin{tabular*}{\faxbox@width}[t]{@{}r@{}}%
    \vrule height 0pt depth 0pt width \faxbox@width\\
    \multicolumn{1}{r}{\ifx\@empty\fromlieu
                       \else\fromlieu, %
                       \fi
                 \if@origdate
                   \expandafter\ifx\csname origdate\the\c@lettre
                                   \endcsname\relax
                   \else
                      \l@@info{Date originale lue dans \jobname.odt}%
                      \def\pdate{\csname origdate\the\c@lettre\endcsname}%
                   \fi
                   \l@@info{`\pdate' ecrit dans \jobname.odt}%
                   \immediate\write\@dateaux{%
                        \string\expandafter\string\def%
                        \string\csname\space origdate\the\c@lettre
                        \string\endcsname{\pdate}}%
                \fi
                \ifx\@empty\pdate ~%
                \else \pdate
                \fi}\\%
 \end{tabular*}%
 \par
   \vspace{\openingspace}%
   \advance\leftskip  \lettermargin
   \advance\rightskip 75pt%
   \ifx\@empty\concdecl 
     \vspace{\openingspace}%
   \else 
     \concline\vspace{\openingspace}%
   \fi
   \hbadness=1000\relax
   {\parindent=\openingindent
   #1}\par\startbreaks\nobreak
   \let\flushleft=\letterflushleft
   \let\raggedright=\letterraggedright
   \let\center=\lettercenter
   \let\centering=\lettercentering}%
%
\long\def\closing#1{%
  \let\center=\normalcenter
  \let\centering=\normalcentering
  \let\flushleft=\normalflushleft
  \let\raggedright=\normalraggedright
  \par\stopbreaks
  \if@letter
    \vskip\csname letter\the\c@lettre\endcsname mm
  \fi
  \par\vspace{2\parskip}%
  \nobreak
  \noindent
  \l@@info{Signature \ifcase\signum manquante \or simple\or double\or triple\fi}%
  \ifcase\sigflag
    \ifcase\signum
       \parbox[t]{\letterwidth}{#1}%
       \par\vspace*{4\parskip}%
           \vspace*{\sigspace}%
       \hspace*{\ssigindent}%
       \noindent
       \parbox[t]{\ssigwidth}{\centering \ignorespaces\fromname}%
    \or
       \parbox[t]{\letterwidth}{#1}%
       \par\vspace*{4\parskip}%
           \vspace*{\sigspace}%
       \hspace*{\ssigindent}%
       \noindent
       \parbox[t]{\ssigwidth}{\centering \ignorespaces\fromsig}%
    \or
       \parbox[t]{\letterwidth}{#1}%
       \par\vspace*{4\parskip}%
           \vspace*{\sigspace}%
       \msigwidth=\letterwidth
       \divide\msigwidth by 2\relax
       \advance\msigwidth -3pt%
       \noindent
       \mbox{\parbox[t]{\msigwidth}{\centering\ignorespaces\fromsig}%
             \parbox[t]{\msigwidth}{\centering\ignorespaces\fromssig}}%
    \or
       \parbox[t]{\letterwidth}{#1}%
       \par\vspace*{4\parskip}%
           \vspace*{\sigspace}%
       \msigwidth=\letterwidth
       \divide\msigwidth by 3\relax
       \advance\msigwidth -3pt%
       \noindent
       \mbox{\parbox[t]{\msigwidth}{\centering\ignorespaces\fromsig}%
             \parbox[t]{\msigwidth}{\centering\ignorespaces\fromssig}%
             \parbox[t]{\msigwidth}{\centering\ignorespaces\fromtsig}}%
    \fi
  \or
    \ifcase\signum
        \hspace*{\ssigindent}%
        \parbox[t]{\ssigwidth}%
        {\centering \ignorespaces
        #1%
        \par\vspace*{4\parskip}%
            \vspace*{\sigspace}%
        \fromname}%
    \or
        \hspace*{\ssigindent}%
        \parbox[t]{\ssigwidth}%
        {\centering \ignorespaces
        #1%
        \par\vspace*{4\parskip}%
            \vspace*{\sigspace}%
        \fromsig}%
    \or
       \parbox[t]{\letterwidth}{#1}%
       \par\vspace*{4\parskip}%
           \vspace*{\sigspace}%
       \msigwidth=\letterwidth
       \divide\msigwidth by 2\relax
       \advance\msigwidth -3pt%
       \noindent
       \mbox{\parbox[t]{\msigwidth}{\centering\ignorespaces\fromsig}%
             \parbox[t]{\msigwidth}{\centering\ignorespaces\fromssig}}%
    \or
       \parbox[t]{\letterwidth}{#1}%
       \par\vspace*{4\parskip}%
           \vspace*{\sigspace}%
       \msigwidth=\letterwidth
       \divide\msigwidth by 3\relax
       \advance\msigwidth -3pt%
       \noindent
       \mbox{\parbox[t]{\msigwidth}{\centering\ignorespaces\fromsig}%
             \parbox[t]{\msigwidth}{\centering\ignorespaces\fromssig}%
             \parbox[t]{\msigwidth}{\centering\ignorespaces\fromtsig}}%
    \fi
  \fi
  \par\vfill\startbreaks
}%
%
%    ************************************************
%    *           COMMANDES UTILISATEURS             *
%    ************************************************
%
\def\marge#1{%
 \lettermargin=#1%
 \listmargin=#1%
 \leftmargini=\listmargin%
   \advance\leftmargini   2.5em%
 \letterwidth=\textwidth
   \advance\letterwidth by -\lettermargin
   \advance\letterwidth by 0pt}%
%
\def\basdepage#1{%
  \def\bdp{#1}}%
%
\def\tension#1{%
  \if@letter
    \expandafter\def\csname letter\the\c@lettre\endcsname{#1}%
  \fi
}%
%
\def\addpages#1{%
  \l@@info{Pages additionnelles: #1}%
  \advance\faxpage by #1}%
%
\def\name#1{\def\fromname{#1}}%
%
\def\signature#1{%
  \ifnum\signum=0\relax
    \def\fromsig{#1}\signum=1\relax
  \else
    \l@@warning{Signature deja definie}%
  \fi
}%
\def\secondsignature#1{%
  \ifnum\signum=1\relax
    \def\fromssig{#1}\signum=2\relax
  \else
    \l@@warning{Seconde signature illegale ou deja definie}%
  \fi
}%
\def\thirdsignature#1{%
  \ifnum\signum=2\relax
    \def\fromtsig{#1}\signum=3\relax
  \else
    \l@@warning{Troisieme signature illegale ou deja definie}%
  \fi
}%
%
\def\vref#1{\l@@warning{La commande \string\Vref\ devrait etre utilisee.}
            \def\auxflag{.}%
            \def\toref{\parbox[t]{17mm}{#1}}}%
\def\Vref#1{\def\auxflag{.}%
            \def\toref{\parbox[t]{17mm}{#1}}}%
\def\nref#1{\l@@warning{La commande \string\Nref~ devrait etre utilisee.}
            \def\auxflag{.}%
            \def\fromref{\parbox[t]{17mm}{#1}}}%
\def\Nref#1{\def\auxflag{.}%
            \def\fromref{\parbox[t]{17mm}{#1}}}%
%
\def\concline{%
         \noindent\parbox[t]{\letterwidth}%
           {\@hangfrom{\textrm{\concname}}\ignorespaces\concdecl\strut}%
         \par}%
%
\def\auxline{%
  \l@@info{Ligne auxiliaire demandee}%
  {\scriptsize
   \vrefname%
    \ifx\@empty \toref
      \hspace{21mm}\hfill%
    \else 
      {\small\toref}\hfill%
    \fi
   \nrefname%
    \ifx\@empty \fromref
      \hspace{21mm}\hfill%
    \else 
      {\small\fromref}\hfill
    \fi
    \ifx\@empty \telexnum
      \hfill%
    \else 
      T\'ELEX\ \telexnum\hspace{5mm}%
    \fi
    \ifx\@empty \ccpnum
      \hfill%
    \else 
      C.C.P.\ \ccpnum\hspace{5mm}%
    \fi}\par}%
%
\def\emailine{%
  \l@@info{Ligne d'E-Mail demandee}%
  {\scriptsize
    \emaillabelname\hfill\ttfamily
    \ifx\@empty \ccittnum
    \else
     \hfill \ccittnum\hfill
    \fi
    \ifx\@empty \internetnum
    \else
     \hfill \internetnum\hfill
    \fi
    \ifx\@empty \bitnetnum
    \else
     \hfill \bitnetnum\hfill
    \fi
    \ifx\@empty \telepacnum
    \else 
     \hfill \telepacnum\hfill
    \fi
    \ifx\@empty \decnetnum
    \else 
     \hfill \decnetnum\hfill
    \fi
    \ifnum\emailcount<3\relax
     \hfill\mbox{}%
    \fi}}%
%
\long\def\address#1{\l@@info{Adresse precisee}\def\fromaddress{#1}}%
%\long\def\address*#1{\if@letter
%                        \l@@info{Adresse avec nom precisee}%
%                        \def\fromaddress{\fromname\\#1}
%                     \else
%                        \l@@warning{Commande illegale dans un fax}
%                     \fi}%
%
\def\nodate{\l@@info{Date supprimee}\def\pdate{}}%
\def\date#1{\l@@info{Date precisee}\def\pdate{#1}}%
%
\def\nolieu{\l@@info{Lieu supprime}\def\fromlieu{}}%
\def\lieu#1{\l@@info{Lieu precise}\def\fromlieu{#1}}%
%
\def\conc#1{\l@@info{Champ d'objet defini}\def\concdecl{#1}}%
%
\def\location#1{\l@@info{Precision d'adresse definie}\def\fromlocation{#1}}%
%
\def\notelephone{\l@@info{Numero de telephone supprime}\def\telephonenum{}}%
\def\telephone#1{\l@@info{Numero de telephone precise}\def\telephonenum{#1}}%
%
\def\nofax{\l@@info{Numero de fax supprime}\def\faxnum{}}%
\def\fax#1{\l@@info{Numero de fax precise}\def\faxnum{#1}}%
%
\def\email#1{\l@@info{Numero d'E-Mail precise}\def\emailnum{#1}}%
%
\def\username#1{\def\@username{#1}}%
%
\def\ccitt#1{\ifnum\emailcount<3\relax
                  \def\emailflag{.}%
                  \advance\emailcount by 1\relax
                   \def\ccittnum{\ifx\@empty \@username
                                           \l@@warning{<<username>> indefini}
                                           #1%
                                  \else
                                        S=\@username;#1%
                               \fi}%
                \else
                  \def\ccittnum{}%
                \fi}%
\def\internet#1{\ifnum\emailcount<3\relax
                  \def\emailflag{.}%
                  \advance\emailcount by 1\relax
                   \def\internetnum{\ifx\@empty \@username
                                           \l@@warning{<<username>> indefini}
                                           #1\relax
                                    \else
                                        \@username @#1\relax
                                 \fi}%
                \else
                  \def\internetnum{}%
                \fi}%
\def\bitnet#1{\ifnum\emailcount<3\relax
               \def\emailflag{.}%
               \advance\emailcount by 1\relax
               \def\bitnetnum{\ifx\@empty \@username
                                     \l@@warning{<<username>> indefini}
                                     #1\relax
                                   \else
                                  \@username\ at #1\relax
                                \fi}%
             \else
               \def\bitnetnum{}%
             \fi}%
\def\telepac#1{\ifnum\emailcount<3\relax
             \def\emailflag{.}%
             \advance\emailcount by 1\relax
              \def\telepacnum{\ifx\@empty \@username
                                 \l@@warning{<<username>> indefini}
                                 #1\relax
                              \else
                              #1::\@username
                           \fi}%
           \else
             \def\telepacnum{}%
           \fi}%
\def\decnet#1{\ifnum\emailcount<3\relax
             \def\emailflag{.}%
             \advance\emailcount by 1\relax
              \def\decnetnum{\ifx\@empty \@username
                                \l@@warning{<<username>> indefini}
                                #1\relax
                              \else
                             #1::\@username
                           \fi}%
           \else
             \def\decnetnum{}%
           \fi}%
\def\telex#1{\ifnum\auxcount<2\relax
               \def\auxflag{.}%
               \advance\auxcount by 1\relax
               \def\telexnum{#1}%
             \else
               \def\telexnum{}%
             \fi}%
\def\ccp#1{\ifnum\auxcount<2\relax
             \def\auxflag{.}%
             \advance\auxcount by 1\relax
             \def\ccpnum{#1}%
           \else
             \def\ccpnum{}%
           \fi}%
%
\def\ps#1#2{\penalty100\relax
  \if@letter
    \vskip\csname letter\the\c@lettre\endcsname mm
  \fi
  \l@@info{Post-scriptum defini}%
  \noindent\t{#1}{#2\\}\vfill\penalty-100\relax}%
%
\def\cc#1{\penalty100\relax
  \if@letter
    \vskip\csname letter\the\c@lettre\endcsname mm
  \fi
  \l@@info{Copies declarees}%
  \noindent\t{\ccname}{#1\\}\vfill\penalty-100\relax}%
%
\def\encl#1{\penalty100\relax
  \if@letter
    \vskip\csname letter\the\c@lettre\endcsname mm
  \fi
  \l@@info{Annexes declarees}%
  \noindent\t{\enclname}{#1\\}\vfill\penalty-100\relax}%
\def\mencl{\penalty100\relax
  \if@letter
    \vskip\csname letter\the\c@lettre\endcsname mm
  \fi
  \l@@info{Annexes mentionnees}%
  \noindent\t{\mentionname\\}{~}\vfill\penalty-100\relax}%
%
%    ****************************************
%    *   DEFINITIONS DEPENDANT DU LANGAGE   *
%    ****************************************
%
\def\FAXSTR{\fontfamily{cmdh}\fontseries{m}\fontshape{n}\selectfont}%
\def\FRANCAIS{francais}
\def\francais{%
  \ifx\defaultlanguage\FRANCAIS\else\l@@info{Langage modifie: francais}\fi%
  \ifx\undefined\frenchname\else % style french loaded
        \french
  \fi
  \ifx\undefined\extrasfrancais\else % style babel and French language loaded
        \selectlanguage{francais}
        \reset@frenchitemize
  \fi
  \sigflag=0\relax
  \def\cejour{le
    \ifx\ier\undefined\def\ier{er}\fi
    \ifnum\day=1\relax 1\ier\else \number\day\fi
    \space\ifcase\month\or
    janvier\or f\'evrier\or mars\or avril\or mai\or juin\or
    juillet\or ao\^ut\or septembre\or octobre\or novembre\or d\'ecembre\fi
    \space \number\year}%
  \def\faxwarning{\large\slshape\bfseries En cas de mauvaise transmission, 
                               appelez s.v.p. l'op\'erateur t\'el\'efax}%
  \def\telefaxstring{{\FAXSTR T~\'E~L~\'E~F~A~X}}%
  \def\telephonelabelname{T\'EL\'EPHONE :~}%
  \def\telefaxlabelname{T\'EL\'EFAX :~}%
  \def\telefaxname{T\'el\'ecopie :~}%
  \def\tellabelname{T\'el.~}%
  \def\faxlabelname{Fax :~}%
  \def\emaillabelname{E-Mail :~}%
  \def\telexlabelname{T\'ELEX :~}%
  \def\headtoname{\`A :~}%
  \def\headfromname{De :~}%
  \def\pagetotalname{Nombre de pages :~}%
  \def\concname{Objet :~}%
  \def\ccname{C.c.~}%
  \def\enclname{P.j.~}%
  \def\mentionname{Annexe(s) mentionn\'ee(s)}%
  \def\vrefname{V.\raise.4ex\hbox{\tiny /}r\'ef.~}
  \def\nrefname{N.\raise.4ex\hbox{\tiny /}r\'ef.~}
}%
\def\ROMAND{romand}
\def\romand{%
  \ifx\defaultlanguage\ROMAND\else\l@@info{Langage modifie: romand}\fi%
  \ifx\undefined\frenchname\else % style french loaded
        \french
  \fi
  \ifx\undefined\extrasfrancais\else % style babel and French language loaded
        \selectlanguage{francais}
        \reset@frenchitemize
  \fi
  \sigflag=0\relax
  \def\cejour{le
    \ifx\ier\undefined\def\ier{er}\fi
    \ifnum\day=1\relax 1\ier\else \number\day\fi
    \space\ifcase\month\or
    janvier\or f\'evrier\or mars\or avril\or mai\or juin\or
    juillet\or ao\^ut\or septembre\or octobre\or novembre\or d\'ecembre\fi
    \space \number\year}%
  \def\faxwarning{\large\slshape\bfseries En cas de mauvaise transmission, 
                               appelez s.v.p. l'op\'erateur t\'el\'efax}%
  \def\telefaxstring{{\FAXSTR T~\'E~L~\'E~F~A~X}}%
  \def\telephonelabelname{T\'EL\'EPHONE :~}%
  \def\telefaxlabelname{T\'EL\'EFAX :~}%
  \def\telefaxname{T\'el\'efax :~}%
  \def\tellabelname{T\'el.~}%
  \def\faxlabelname{Fax :~}%
  \def\emaillabelname{E-Mail :~}%
  \def\telexlabelname{T\'ELEX :~}%
  \def\headtoname{\`A :~}%
  \def\headfromname{De :~}%
  \def\pagetotalname{Nombre de pages :~}%
  \def\concname{Concerne :~}%
  \def\ccname{C.c.~}%
  \def\enclname{Ann.~}%
  \def\mentionname{Annexe(s) mentionn\'ee(s)}%
  \def\vrefname{V.\raise.4ex\hbox{\tiny /}r\'ef.~}
  \def\nrefname{N.\raise.4ex\hbox{\tiny /}r\'ef.~}
}%
\def\ANGLAIS{anglais}
\def\anglais{%
  \ifx\defaultlanguage\ANGLAIS\else\l@@info{Langage modifie: anglais}\fi%
  \ifx\undefined\frenchname\else % style french loaded
        \english
  \fi
  \ifx\undefined\extrasenglish\else % style babel and English language loaded
        \selectlanguage{english}
  \fi
  \sigflag=1\relax
  \def\cejour{\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space\number\day ,\space\number\year}%
  \def\faxwarning{\large\slshape\bfseries If improperly transmitted, please 
                               call the telefax operator}%
  \def\telefaxstring{{\FAXSTR T~E~L~E~F~A~X}}%
  \def\telephonelabelname{TELEPHONE:~}%
  \def\telefaxlabelname{TELEFAX:~}%
  \def\telefaxname{Telefax:~}%
  \def\tellabelname{Tel:~}%
  \def\faxlabelname{Fax:~}%
  \def\emaillabelname{E-Mail:~}%
  \def\telexlabelname{TELEX:~}%
  \def\headtoname{To:~}%
  \def\headfromname{From:~}%
  \def\pagetotalname{Total pages:~}%
  \def\concname{Subject:~}%
  \def\ccname{Cc:~}%
  \def\enclname{Encl(s):~}%
  \def\mentionname{Encl(s).}%
  \def\vrefname{Y.\raise.4ex\hbox{\tiny /}ref.~}
  \def\nrefname{O.\raise.4ex\hbox{\tiny /}ref.~}
}%
\def\AMERICAIN{americain}
\def\americain{%
  \ifx\defaultlanguage\AMERICAIN\else\l@@info{Langage modifie: americain}\fi%
  \ifx\undefined\frenchname\else % style french loaded
        \english
  \fi
  \ifx\undefined\extrasenglish\else % style babel and English language loaded
        \selectlanguage{english}
  \fi
  \sigflag=1\relax
  \def\cejour{\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi
    \space\number\day ,\space\number\year}%
  \def\faxwarning{\large\slshape\bfseries If improperly transmitted, please 
                               call the telefax operator}%
  \def\telefaxstring{{\FAXSTR T~E~L~E~F~A~X}}%
  \def\telephonelabelname{PHONE:~}%
  \def\telefaxlabelname{TELEFAX:~}%
  \def\telefaxname{Telefax:~}%
  \def\tellabelname{Phn:~}%
  \def\faxlabelname{Fax:~}%
  \def\emaillabelname{E-Mail:~}%
  \def\telexlabelname{TELEX:~}%
  \def\headtoname{To:~}%
  \def\headfromname{From:~}%
  \def\pagetotalname{Total pages:~}%
  \def\concname{Re:~}%
  \def\ccname{Cc:~}%
  \def\enclname{Encl(s):~}%
  \def\mentionname{Encl(s).}%
  \def\vrefname{Y.\raise.4ex\hbox{\tiny /}ref.~}
  \def\nrefname{O.\raise.4ex\hbox{\tiny /}ref.~}
}%
\def\ALLEMAND{allemand}
\def\allemand{%
  \ifx\defaultlanguage\ALLEMAND\else\l@@info{Langage modifie: allemand}\fi%
  \ifx\undefined\extrasgerman\else % style babel and German language loaded
        \selectlanguage{german}
  \fi
  \sigflag=1\relax
  \def\cejour{den \number\day .\space\ifcase\month\or
  Januar\or Februar\or M\"arz\or April\or Mai\or Juni\or
  Juli\or August\or September\or Oktober\or November\or Dezember\fi
  \space \number\year}%
  \def\concname{Betrifft: }%
  \def\faxwarning{\large\slshape\bfseries Bitte unrichtige \"Ubertragungen dem 
                               Sender telefonisch melden}%
  \def\telefaxstring{{\FAXSTR T~E~L~E~F~A~X}}%
  \def\telephonelabelname{TELEFON:~}%
  \def\telefaxlabelname{TELEFAX:~}%
  \def\telefaxname{Telefax:~}%
  \def\tellabelname{Tel:~}%
  \def\faxlabelname{Fax:~}%
  \def\emaillabelname{E-Mail:~}%
  \def\telexlabelname{TELEX:~}%
  \def\headtoname{An:~}%
  \def\headfromname{Von:~}%
  \def\pagetotalname{Gesamtanzahl der Bl\"atter:~}%
  \def\concname{Betrifft:~}%
  \def\ccname{Kopie an:~}%
  \def\enclname{Beilage(n):~}%
  \def\mentionname{Beilage(n) erw\"ahnt}%
  \def\vrefname{Ihr Zeichen~}
  \def\nrefname{Unser Zeichen~}
}%
%
%************************************************************************
%
% \document redefini pour ecrire '\startlabels' sur le fichier .etq 
% et executer \@startlabels.
%
%************************************************************************
%
\AtBeginDocument{%
  \makeatletter
  \@input{\jobname.tns}%
  \@input{\jobname.odt}%
  \begingroup\@floatplacement\@dblfloatplacement
  \immediate\openout\@tensionaux=\jobname.tns%
  \if@origdate
    \immediate\openout\@dateaux=\jobname.odt%
  \fi
  \endgroup
  \if@etiq
    \immediate\openout\@etiqaux=\jobname.etq%
    \immediate\write\@etiqaux{\string\startlabels}%
    \@startlabels
  \fi
  \makeatother
}%
%
%************************************************************************
%
% \enddocument redefini pour sortir la page d'etiquettes, si necessaire.
%
%************************************************************************
%
\AtEndDocument{%
  \l@@info{Nombre de lettres :\the\c@lettre}%
  \l@@info{Nombre de telefax :\the\c@telefax}%
  \newpage\begingroup 
  \immediate\closeout\@tensionaux%
  \if@origdate
    \immediate\closeout\@dateaux%
  \fi
  \if@letter
    \if@etiq 
      \immediate\closeout\@etiqaux%
      \makeatletter
      \@input{\jobname.etq}%
      \makeatother
      \clearpage
    \fi
  \else
    \immediate\closeout\@faxaux%
  \fi
  \endgroup
}%
%
%    ****************************************
%    *             STYLES DE PAGE           *
%    ****************************************
%
%
\def\@texttop{\ifnum\c@page=1\vskip 0pt plus .00001fil\relax\fi}%
%
\if@twoside
  \def\ps@headings{%
    \headheight 12pt%
    \headsep 25pt%
    \def\@oddhead{{\hspace{15mm}\ifx\@empty\fromlieu\else\fromlieu , \fi
                                  \pdate\hfill Page \thepage}}%
    \def\@oddfoot{}%
    \def\@evenhead{{Page \thepage\hfill\ifx\@empty\fromlieu\else\fromlieu , \fi
                                  \pdate\hspace{15mm}}}%
    \def\@evenfoot{}}%
\else
  \def\ps@headings{%
    \headheight 12pt%
    \headsep 25pt%
    \def\@oddhead{{\hspace{15mm}\ifx\@empty\fromlieu\else\fromlieu , \fi
                                  \pdate\hfill Page \thepage}}%
    \def\@oddfoot{}%
    \def\@evenhead{}%
    \def\@evenfoot{}}%
\fi
%
\def\ps@empty{%
   \headheight 0pt%
   \headsep 9pt%
   \def\@oddhead{}%
   \def\@oddfoot{%
       \ifnum\c@page=1\relax
          \ifx\@empty\emailflag
             \ifx\@empty\bdp
             \else
                \hbadness=10000\relax
                \rlap{\parbox{\textwidth}{\mbox{}\\\rule{\textwidth}{.4pt}\\\bdp}}
                ~\hfill~
                \hbadness=1000\relax
             \fi
          \else
             \hbadness=10000\relax
             \rlap{\parbox{\textwidth}{\mbox{}\\\rule{\textwidth}{.4pt}\\\emailine}}%
             ~\hfill~
             \hbadness=1000\relax
          \fi
       \fi}%
   \def\@evenhead{}%
   \def\@evenfoot{}}%
%
\def\ps@firstpage{%
   \headheight 12pt%
   \headsep 25pt%
   \def\@oddhead{}%
   \def\@oddfoot{}%
   \def\@evenhead{}%
   \def\@evenfoot{}}%
%
\def\ps@plain{%
   \headheight 0pt%
   \headsep 9pt%
   \def\@oddhead{}%
   \def\@oddfoot{\textrm{\hfill\thepage\hfill}}%
   \def\@evenhead{}%
   \def\@evenfoot{\textrm{\hfill\thepage\hfill}}}%
%
%    ****************************************
%    *        CENTER et FLUSHLEFT           *
%    ****************************************
%
\def\normalcenter{\trivlist \normalcentering\item[]}%
\def\lettercenter{\trivlist \lettercentering\item[]}%
\def\normalcentering{\let\\=\@centercr\rightskip\@flushglue
                     \leftskip\@flushglue
                     \parindent\z@\parfillskip\z@}%
\def\lettercentering{\let\\=\@centercr\rightskip\@flushglue
                     \leftskip\@flushglue\advance\leftskip\lettermargin
                     \parindent\z@\parfillskip\z@}%
\let\endcenter=\endtrivlist
%
\def\normalflushleft{\trivlist \normalraggedright\item[]}%
\def\letterflushleft{\trivlist \letterraggedright\item[]}%
\def\normalraggedright{\let\\=\@centercr\leftskip\z@
                       \@rightskip\@flushglue\rightskip\@rightskip
                       \parindent\z@}%
\def\letterraggedright{\let\\=\@centercr\leftskip\lettermargin
                       \@rightskip\@flushglue\rightskip\@rightskip
                       \parindent\z@}%
\let\endflushleft=\endtrivlist
%
%    ****************************************
%    *               LISTES                 *
%    ****************************************
%
\def\reset@frenchitemize{%
      \renewenvironment{itemize}%
        {\begin{list}{\textendash}%
          {\settowidth{\labelwidth}{\textendash}%
           \setlength{\leftmargin}{\listmargin}%
           \addtolength{\leftmargin}{\labelwidth}%
           \addtolength{\leftmargin}{\labelsep}%
           \ifnum\@listdepth=0
             \setlength{\itemindent}{\parindent}%
           \else
             \addtolength{\leftmargin}{\parindent}%
           \fi
           \setlength{\itemsep}{\z@}%
           \setlength{\parsep}{\z@}%
           \setlength{\topsep}{\z@}%
           \setlength{\partopsep}{\z@}%
           \addtolength{\topsep}{-\parskip}%
           \addtolength{\partopsep}{\parskip}%
          }%
        }%
        {\end{list}}%
}
%
\rightmargin   25mm%
   \advance\rightmargin   5pt%
\leftmarginii  2.2em%
\leftmarginiii 1.87em%
\leftmarginiv  1.7em%
\leftmarginv   1em%
\leftmarginvi  1em%
\leftmargin\leftmargini
\labelsep 5pt%
\parsep 0pt%
\def\@listi{\leftmargin\listmargin\labelwidth\leftmargin
   \advance\leftmargin 1.5em\advance\labelwidth-\labelsep}%
\def\@listii{\leftmargin\leftmarginii
   \labelwidth\leftmarginii\advance\labelwidth-\labelsep}%
\def\@listiii{\leftmargin\leftmarginiii
    \labelwidth\leftmarginiii\advance\labelwidth-\labelsep
    \topsep .1em% 
    \itemsep \topsep}%
\def\@listiv{\leftmargin\leftmarginiv
     \labelwidth\leftmarginiv\advance\labelwidth-\labelsep}%
\def\@listv{\leftmargin\leftmarginv
     \labelwidth\leftmarginv\advance\labelwidth-\labelsep}%
\def\@listvi{\leftmargin\leftmarginvi
     \labelwidth\leftmarginvi\advance\labelwidth-\labelsep}%
%
\def\labelitemi{$\bullet$}%
\def\labelitemii{\bfseries --}%
\def\labelitemiii{$\ast$}%
\def\labelitemiv{$\cdot$}%
%
\def\labelenumi{\arabic{enumi}.}%
\def\theenumi{\arabic{enumi}}%     
\def\labelenumii{(\alph{enumii})}%
\def\theenumii{\alph{enumii}}%
\def\p@enumii{\theenumi}%
\def\labelenumiii{\roman{enumiii}.}%
\def\theenumiii{\roman{enumiii}}%
\def\p@enumiii{\theenumi(\theenumii)}%
\def\labelenumiv{\Alph{enumiv}.}%
\def\theenumiv{\Alph{enumiv}}%
\def\p@enumiv{\p@enumiii\theenumiii}%
%
\def\verse{\let\\=\@centercr  
  \list{}{\itemsep\z@ \itemindent -15pt\listparindent \itemindent 
          \rightmargin\leftmargin\advance\leftmargin 15pt}\item[]}%
\let\endverse\endlist
%   
\def\quotation{\list{}{\listparindent 1.5em%
    \itemindent\listparindent
    \rightmargin\leftmargin}\item[]}%
\let\endquotation=\endlist
%
\def\quote{\list{}{\rightmargin\leftmargin}\item[]}%
\let\endquote=\endlist
%
\def\descriptionlabel#1{\itshape #1}%
\def\description{\list{}{\leftmargin=2\listmargin
       \labelwidth\listmargin \advance\labelwidth -\labelsep 
       \let\makelabel\descriptionlabel}}%
\let\enddescription\endlist
%
%    ****************************************
%    *               DIVERS                 *
%    ****************************************
%
\def\@begintheorem#1#2{\itshape \trivlist \item[\hskip \labelsep{\bfseries #1\ #2}]}%
\def\@endtheorem{\endtrivlist}%
%
\def\theequation{\arabic{equation}}%
%
\arraycolsep 5pt%
\tabcolsep 5pt%
\arrayrulewidth .4pt%
\doublerulesep 2pt%
\tabbingsep\labelsep
\skip\@mpfootins=\skip\footins
%
\fboxsep = 3pt    % Space left between box and text by \fbox and \framebox.
\fboxrule = .4pt  % Width of rules in box made by \fbox and \framebox.
%
%    ****************************************
%    *             FOOTNOTES                *
%    ****************************************
%
\def\footnoterule{\kern-1\p@   
  \hrule width .4\columnwidth 
  \kern .6\p@}%
%
\long\def\@makefntext#1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}#1}%
%
%    ****************************************
%    *     INITIALISATIONS DES DEFAUTS      *
%    ****************************************
%
\def\pict@let@width{185}%
\def\pict@let@height{65}%
\def\pict@let@hoffset{0}%
\def\pict@let@voffset{0}%
\def\rule@hpos{-25}%
\def\rule@vpos{-15}%
\def\rule@length{10}%
\def\fromaddress@let@hpos{-10}%
\def\fromaddress@let@vpos{70}%
\fromaddress@let@width=69mm
\def\fromlieu@let@hpos{90}%
\def\fromlieu@let@vpos{62}%
\fromlieu@let@width=69mm
\def\toaddress@let@hpos{90}%
\def\toaddress@let@vpos{40}%
\toaddress@let@width=80mm
%
\def\pict@fax@width{185}%
\def\pict@fax@height{30}%
\def\pict@fax@hoffset{0}%
\def\pict@fax@voffset{0}%
\def\fromaddress@fax@hpos{-10}%
\def\fromaddress@fax@vpos{30}%
\fromaddress@fax@width=69mm
\def\faxstring@hpos{90}%
\def\faxstring@vpos{20}%
\faxstring@width=69mm%
\faxbox@width=170mm%
\toaddress@fax@width=69mm%
\fromname@fax@width=69mm%
%
\def\@institut{\makeatletter
         \input{default.ins}%
         \makeatother}%
%
\smallskipamount=.5\parskip
\medskipamount=\parskip
\bigskipamount=2\parskip
%
\ps@plain
\pagenumbering{arabic}%
\raggedbottom
\onecolumn
%
% Initialisations des variables de la lettre
%
\def\pdate{\cejour}%
%
\def\emailnum{}%
%
\def\fromlocation{}%
\signum=0\relax
\def\fromsig{}%
\def\fromssig{}%
\def\fromtsig{}%
%
\csname\defaultlanguage\endcsname
\l@@info{Langage par defaut: \defaultlanguage}
\def\concdecl{}%
%
\marge{15mm}%
\msigwidth=\letterwidth
\ssigindent=0.5\letterwidth
\ssigwidth=\letterwidth
  \advance\ssigwidth by -\ssigindent
  \advance\ssigwidth by -5pt
\sigspace=1.5cm
\openingspace=1cm
\openingindent=0pt
%
\@lettertrue        
\faxpage=0\relax
\def\totalpages{}%
%
\def\auxflag{}%
\auxcount=0\relax
\def\toref{}%
\def\fromref{}%
\def\telexnum{}%
\def\ccpnum{}%
%
\def\emailflag{}%
\emailcount=0\relax
\def\@username{}%
\def\ccittnum{}%
\def\internetnum{}%
\def\bitnetnum{}%
\def\telepacnum{}%
\def\decnetnum{}%
%
\def\bdp{}%
\endinput
%%
%% End of file `lettre.cls'.
