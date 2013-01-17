%%
%% This is file `g-brief2.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% g-brief.dtx  (with options: `class2')
%% 
%% =======================================================================
%% 
%% Copyright (C) 1991-2003 Michael Lenzen.
%% 
%% For additional copyright information see further down in this file.
%% 
%% This file is part of the G-BRIEF package.
%% -----------------------------------------------------------------------
%% 
%% It may be distributed under the terms of the LaTeX Project Public
%% License (LPPL), as described in lppl.txt in the base LaTeX distribution.
%% Either version 1.1 or, at your option, any later version.
%% 
%% The latest version of this license is in
%% 
%%          http://www.latex-project.org/lppl.txt
%% 
%% LPPL Version 1.1 or later is part of all distributions of LaTeX
%% version 1999/06/01 or later.
%% 
%% 
%% Error reports in case of UNCHANGED versions to
%% 
%%                            <lenzen@lenzen.com>
%%                            <m.lenzen@t-online.de>
%% 
%% 
\def\filedate{2008/07/15}
\def\fileversion{4.0.2}
\def\filedate{2008/07/15}
\def\fileversion{4.0.2}
\def\filename{g-brief2.cls}
\NeedsTeXFormat{LaTeX2e}[2001/06/01]

\ProvidesClass{g-brief2}[\filedate\space v\fileversion\space g-brief2 class]

\IfFileExists{ifthen.sty}
  {\RequirePackage{ifthen}}
  {\ClassError{g-brief2}
    {LaTeX2e not complete installed or out of date !!!}
    {Get current LaTeX2e !!!}}

\newdimen\VorschubH
\newdimen\VorschubV
\VorschubH = 0.0mm
\VorschubV = 0.0mm

\def\sprache{ngerman}
\def\adresstext{Adresse\/:}
\def\telefontext{Telefon\/:}
\def\internettext{Internet\/:}
\def\banktext{Bankverbindung\/:}
\def\ihrzeichentext{\footnotesize\textsc{Ihr Zeichen}}
\def\ihrschreibentext{\footnotesize\textsc{Ihr Schreiben vom}}
\def\meinzeichentext{\footnotesize\textsc{Mein Zeichen}}
\def\unserzeichentext{\footnotesize\textsc{Unser Zeichen}}
\def\datumtext{\footnotesize\textsc{Datum}}
\def\datum{\number\day.~\ifcase\month\or Januar\or Februar\or
  M\"arz\or April\or Mai\or Juni\or Juli\or August\or September\or
  Oktober\or November\or Dezember\fi \space\number\year}

\DeclareOption{10pt}{\def\@schrift{0}}
\DeclareOption{11pt}{\def\@schrift{1}}
\DeclareOption{12pt}{\def\@schrift{2}}

\let\@docencoding\@empty
\DeclareOption{ansinew}{\def\@docencoding{ansinew}}
\DeclareOption{applemac}{\def\@docencoding{applemac}}
\DeclareOption{ascii}{\def\@docencoding{ascii}}
\DeclareOption{cp1250}{\def\@docencoding{cp1250}}
\DeclareOption{cp1252}{\def\@docencoding{cp1252}}
\DeclareOption{cp437de}{\def\@docencoding{cp437de}}
\DeclareOption{cp437}{\def\@docencoding{cp437}}
\DeclareOption{cp850}{\def\@docencoding{cp850}}
\DeclareOption{cp852}{\def\@docencoding{cp852}}
\DeclareOption{cp865}{\def\@docencoding{cp865}}
\DeclareOption{decmulti}{\def\@docencoding{decmulti}}
\DeclareOption{latin1}{\def\@docencoding{latin1}}
\DeclareOption{latin2}{\def\@docencoding{latin2}}
\DeclareOption{latin3}{\def\@docencoding{latin3}}
\DeclareOption{latin4}{\def\@docencoding{latin4}}
\DeclareOption{latin5}{\def\@docencoding{latin5}}
\DeclareOption{latin9}{\def\@docencoding{latin9}}
\DeclareOption{next}{\def\@docencoding{next}}

\DeclareOption{german}{
  \def\sprache{german}
  \def\adresstext{Adresse\/:}
  \def\telefontext{Telefon\/:}
  \def\internettext{Internet\/:}
  \def\banktext{Bankverbindung\/:}
  \def\ihrzeichentext{\footnotesize\textsc{Ihr Zeichen}}
  \def\ihrschreibentext{\footnotesize\textsc{Ihr Schreiben vom}}
  \def\meinzeichentext{\footnotesize\textsc{Mein Zeichen}}
  \def\unserzeichentext{\footnotesize\textsc{Unser Zeichen}}
  \def\datumtext{\footnotesize\textsc{Datum}}
  \def\datum{\number\day.~\ifcase\month\or Januar\or Februar\or
    M\"arz\or April\or Mai\or Juni\or Juli\or August\or September\or
    Oktober\or November\or Dezember\fi \space\number\year}}

\DeclareOption{ngerman}{
  \def\sprache{ngerman}
  \def\adresstext{Adresse\/:}
  \def\telefontext{Telefon\/:}
  \def\internettext{Internet\/:}
  \def\banktext{Bankverbindung\/:}
  \def\ihrzeichentext{\footnotesize\textsc{Ihr Zeichen}}
  \def\ihrschreibentext{\footnotesize\textsc{Ihr Schreiben vom}}
  \def\meinzeichentext{\footnotesize\textsc{Mein Zeichen}}
  \def\unserzeichentext{\footnotesize\textsc{Unser Zeichen}}
  \def\datumtext{\footnotesize\textsc{Datum}}
  \def\datum{\number\day.~\ifcase\month\or Januar\or Februar\or
    M\"arz\or April\or Mai\or Juni\or Juli\or August\or September\or
    Oktober\or November\or Dezember\fi \space\number\year}}

\DeclareOption{english}{
  \def\sprache{english}
  \def\adresstext{Address\/:}
  \def\telefontext{Phone\/:}
  \def\internettext{Internet\/:}
  \def\banktext{Bank\/:}
  \def\ihrzeichentext{\footnotesize\textsc{Your Ref.}}
  \def\ihrschreibentext{\footnotesize\textsc{Your Mail}}
  \def\meinzeichentext{\footnotesize\textsc{My Ref.}}
  \def\unserzeichentext{\footnotesize\textsc{Our Ref.}}
  \def\datumtext{\footnotesize\textsc{Date}}}

\DeclareOption{american}{
  \def\sprache{american}
  \def\adresstext{Address\/:}
  \def\telefontext{Phone\/:}
  \def\internettext{Internet\/:}
  \def\banktext{Bank\/:}
  \def\ihrzeichentext{\footnotesize\textsc{Your Ref.}}
  \def\ihrschreibentext{\footnotesize\textsc{Your Mail}}
  \def\meinzeichentext{\footnotesize\textsc{My Ref.}}
  \def\unserzeichentext{\footnotesize\textsc{Our Ref.}}
  \def\datumtext{\footnotesize\textsc{Date}}}

\ExecuteOptions{11pt,@sprache} \ProcessOptions
\LoadClass[1\@schrift pt, a4paper, oneside, final]{letter}[1999/04/29]
\normalsize

\setlength\oddsidemargin{0\p@}
\setlength\evensidemargin{\oddsidemargin}
\setlength\marginparwidth{90\p@}
\setlength\marginparsep{11\p@}
\setlength\marginparpush{5\p@}
\setlength\topmargin{-12.69mm}
\setlength\headheight{4.23mm}
\setlength\headsep{6.35mm}
\setlength\topskip{3.38mm}
\addtolength\footskip{10mm}
\setlength\textheight{168.88mm}
\setlength\textwidth{165mm}

\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}

\renewcommand\baselinestretch{1}

\advance\topmargin by \VorschubV
\advance\oddsidemargin by \VorschubH
\setlength\evensidemargin{\oddsidemargin}

\AtEndOfClass{\pagestyle{regularpage}}

\def\Name#1{\def\name{#1}} \def\name{}

\def\RetourAdresse#1{\def\retouradresse{#1}} \def\retouradresse{}
\def\Postvermerk#1{\def\postvermerk{#1}} \def\postvermerk{}
\def\Adresse#1{\def\adresse{#1}} \def\adresse{}

\def\IhrZeichen#1{\def\ihrzeichen{#1}} \def\ihrzeichen{}
\def\IhrSchreiben#1{\def\ihrschreiben{#1}} \def\ihrschreiben{}
\def\MeinZeichen#1{\def\meinzeichen{#1}} \def\meinzeichen{}
\def\Datum#1{\def\datum{#1}} \def\datum{\today}

\def\Betreff#1{\def\betreff{#1}} \def\betreff{}

\def\Anrede#1{\def\anrede{#1}} \def\anrede{}
\def\Gruss#1#2{\def\gruss{#1} \def\grussskip{#2}}
    \def\gruss{} \def\grussskip{}
\def\Unterschrift#1{\def\unterschrift{#1}} \def\unterschrift{}

\def\Anlagen#1{\def\anlagen{#1}} \def\anlagen{}
\def\Verteiler#1{\def\verteiler{#1}} \def\verteiler{}

\def\NameZeileA#1{\def\namezeilea{#1}} \def\namezeilea{}
\def\NameZeileB#1{\def\namezeileb{#1}} \def\namezeileb{}
\def\NameZeileC#1{\def\namezeilec{#1}} \def\namezeilec{}
\def\NameZeileD#1{\def\namezeiled{#1}} \def\namezeiled{}
\def\NameZeileE#1{\def\namezeilee{#1}} \def\namezeilee{}
\def\NameZeileF#1{\def\namezeilef{#1}} \def\namezeilef{}
\def\NameZeileG#1{\def\namezeileg{#1}} \def\namezeileg{}

\def\AdressZeileA#1{\def\adresszeilea{#1}} \def\adresszeilea{}
\def\AdressZeileB#1{\def\adresszeileb{#1}} \def\adresszeileb{}
\def\AdressZeileC#1{\def\adresszeilec{#1}} \def\adresszeilec{}
\def\AdressZeileD#1{\def\adresszeiled{#1}} \def\adresszeiled{}
\def\AdressZeileE#1{\def\adresszeilee{#1}} \def\adresszeilee{}
\def\AdressZeileF#1{\def\adresszeilef{#1}} \def\adresszeilef{}

\def\TelefonZeileA#1{\def\telefonzeilea{#1}} \def\telefonzeilea{}
\def\TelefonZeileB#1{\def\telefonzeileb{#1}} \def\telefonzeileb{}
\def\TelefonZeileC#1{\def\telefonzeilec{#1}} \def\telefonzeilec{}
\def\TelefonZeileD#1{\def\telefonzeiled{#1}} \def\telefonzeiled{}
\def\TelefonZeileE#1{\def\telefonzeilee{#1}} \def\telefonzeilee{}
\def\TelefonZeileF#1{\def\telefonzeilef{#1}} \def\telefonzeilef{}

\def\InternetZeileA#1{\def\internetzeilea{#1}} \def\internetzeilea{}
\def\InternetZeileB#1{\def\internetzeileb{#1}} \def\internetzeileb{}
\def\InternetZeileC#1{\def\internetzeilec{#1}} \def\internetzeilec{}
\def\InternetZeileD#1{\def\internetzeiled{#1}} \def\internetzeiled{}
\def\InternetZeileE#1{\def\internetzeilee{#1}} \def\internetzeilee{}
\def\InternetZeileF#1{\def\internetzeilef{#1}} \def\internetzeilef{}

\def\BankZeileA#1{\def\bankzeilea{#1}} \def\bankzeilea{}
\def\BankZeileB#1{\def\bankzeileb{#1}} \def\bankzeileb{}
\def\BankZeileC#1{\def\bankzeilec{#1}} \def\bankzeilec{}
\def\BankZeileD#1{\def\bankzeiled{#1}} \def\bankzeiled{}
\def\BankZeileE#1{\def\bankzeilee{#1}} \def\bankzeilee{}
\def\BankZeileF#1{\def\bankzeilef{#1}} \def\bankzeilef{}

\long\def\Einrueckung#1{\par\begin{tabular}{@{\hspace{1in}}p{5in}@{}}
    #1\end{tabular}\par}

\newif\iftrennlinien\trennlinienfalse
\def\trennlinien{\trennlinientrue}

\newif\iflochermarke\lochermarkefalse
\def\lochermarke{\lochermarketrue}

\newif\iffaltmarken\faltmarkenfalse
\def\faltmarken{\faltmarkentrue}

\newif\iffenstermarken\fenstermarkenfalse
\def\fenstermarken{\fenstermarkentrue}

\newif\ifunserzeichen\unserzeichenfalse
\def\unserzeichen{\unserzeichentrue}


\newenvironment{g-brief}{
  \thispagestyle{firstpage}
  \setlength\unitlength{1mm}

  \c@page\@ne
  \interlinepenalty=200
  \clearpage

  \ifx \ihrzeichen\empty \ifx \ihrschreiben\empty \ifx
  \meinzeichen\empty \makebox[45.5mm][l]{} \makebox[55.0mm][l]{}
  \makebox[20.0mm][l]{} \else \makebox[45.5mm][l]{\ihrzeichentext}
  \makebox[55.0mm][l]{\ihrschreibentext} \ifunserzeichen
  \makebox[20.0mm][l]{\unserzeichentext} \else
  \makebox[20.0mm][l]{\meinzeichentext} \fi \fi \else
  \makebox[45.5mm][l]{\ihrzeichentext}
  \makebox[55.0mm][l]{\ihrschreibentext} \ifunserzeichen
  \makebox[20.0mm][l]{\unserzeichentext} \else
  \makebox[20.0mm][l]{\meinzeichentext} \fi \fi \else
  \makebox[45.5mm][l]{\ihrzeichentext}
  \makebox[55.0mm][l]{\ihrschreibentext} \ifunserzeichen
  \makebox[20.0mm][l]{\unserzeichentext} \else
  \makebox[20.0mm][l]{\meinzeichentext} \fi \fi
  \makebox[41.0mm][r]{\datumtext} \\
  \makebox[45.5mm][l]{\ihrzeichen}
  \makebox[55.0mm][l]{\ihrschreiben}
  \makebox[20.0mm][l]{\meinzeichen}
  \makebox[41.0mm][r]{\datum} \par

  \vspace{8mm}

  \ifcase\@ptsize\vspace{0.045pt}\or \vspace{-1.555pt}\or
  \vspace{-2.955pt} \fi

  \ifx \betreff\empty \else \textbf{\betreff} \mbox{} \par \vspace{-1\parskip}
    \vspace{8mm} \fi

  \ifcase\@ptsize\vspace{0.045pt}\or \vspace{-1.555pt}\or
  \vspace{-2.955pt} \fi

  \ifx \anrede\empty \else \anrede \par \fi\nobreak
  \addtolength\textheight{63mm}}
  { \renewcommand{\baselinestretch}{1.0}
  \ifcase \@ptsize\relax \normalsize \or \small \or \footnotesize \fi

  \vspace{\grussskip} \par \nobreak \stopbreaks \noindent
  \parbox[t]{3.5in}{\raggedright \ignorespaces {\normalsize \ifx
      \gruss\empty \else \gruss \mbox{} \\[16.92mm] \fi \ifx
      \unterschrift\empty \relax \else \unterschrift
    \fi} \strut} \ifx \anlagen\empty \else \vspace{4mm} \par \anlagen
  \par \fi \ifx \verteiler\empty \else \ifx \anlagen\empty
  \vspace{4mm}\par \fi \verteiler \fi}

\def\ps@firstpage{
  \renewcommand{\baselinestretch}{1.0}
  \ifcase \@ptsize\relax
    \normalsize \or \small \or \footnotesize
  \fi
  \headheight16pt\headsep63mm
  \def\@oddhead{
    \unitlength1mm
    \begin{picture}(0,0)
      \put(-6, 3){\parbox{180mm}{\Large \textsc{\quad\name}}}
      \iftrennlinien \put(0,-8){\rule{165mm}{0.5pt}} \fi
      \iflochermarke \put(-20,- 130.50){\line(1,0){4}} \fi
      \iffaltmarken \put(-15,- 75.16){\line(1,0){3}}
        \put(-15,-182.16){\line(1,0){3}} \fi
      \put( -9, -22.00){\makebox(85,4)
      {\scriptsize \textrm{\retouradresse}}}
      \iftrennlinien \put( -9, -22.10){\line(1,0){85}} \fi
      \put(-1,-28.15){\parbox[t]{3in}{\ifx \postvermerk\empty \hfill \par
        \else \textbf{\postvermerk} \par \vspace{2mm} \fi \adresse}}
      \iffenstermarken
        \put(-9,-18.15){\line( 1, 0){1}} \put(-9,-18.15){\line( 0,-1){1}}
        \put(76,-18.15){\line(-1, 0){1}} \put(76,-18.15){\line( 0,-1){1}}
        \put(-9,-61.00){\line( 1, 0){1}} \put(-9,-61.00){\line( 0, 1){1}}
        \put(76,-61.00){\line(-1, 0){1}} \put(76,-61.00){\line( 0, 1){1}}
        \fi
    \end{picture}
    \hfill
  }
  \def\@oddfoot{
    \unitlength1mm
    \begin{picture}(0,0)
      \put(-9,0){\parbox{180mm}{
        \tiny \newcounter{blockzahl} \def\@blockbreite{170mm}
        \iftrennlinien \rule{180mm}{0.5pt} \fi
        \ifthenelse{
          \equal{\namezeilea}{\empty} \and \equal{\namezeileb}{\empty} \and
          \equal{\namezeilec}{\empty} \and \equal{\namezeiled}{\empty} \and
          \equal{\namezeilee}{\empty} \and \equal{\namezeilef}{\empty} \and
          \equal{\namezeileg}{\empty}}
          {}{\stepcounter{blockzahl}}
        \ifthenelse{
          \equal{\adresszeilea}{\empty} \and \equal{\adresszeileb}{\empty} \and
          \equal{\adresszeilec}{\empty} \and \equal{\adresszeiled}{\empty} \and
          \equal{\adresszeilee}{\empty} \and \equal{\adresszeilef}{\empty}}
          {}{\stepcounter{blockzahl}}
        \ifthenelse{
          \equal{\telefonzeilea}{\empty} \and \equal{\telefonzeileb}{\empty}
          \and \equal{\telefonzeilec}{\empty} \and \equal{\telefonzeiled}
          {\empty} \and \equal{\telefonzeilee}{\empty} \and
          \equal{\telefonzeilef}{\empty}}
          {}{\stepcounter{blockzahl}}
        \ifthenelse{
          \equal{\internetzeilea}{\empty} \and \equal{\internetzeileb}{\empty}
          \and \equal{\internetzeilec}{\empty} \and \equal{\internetzeiled}
          {\empty} \and \equal{\internetzeilee}{\empty} \and
          \equal{\internetzeilef}{\empty}}
          {}{\stepcounter{blockzahl}}
        \ifthenelse{
          \equal{\bankzeilea}{\empty} \and \equal{\bankzeileb}{\empty} \and
          \equal{\bankzeilec}{\empty} \and \equal{\bankzeiled}{\empty} \and
          \equal{\bankzeilee}{\empty} \and \equal{\bankzeilef}{\empty}}
          {}{\stepcounter{blockzahl}}
        \ifthenelse{\value{blockzahl} = 1}
          {\scriptsize \def\@blockbreite{177mm}}{}
        \ifthenelse{\value{blockzahl} = 2}
          {\scriptsize \def\@blockbreite{88mm}}{}
        \ifthenelse{\value{blockzahl} = 3}
          {\scriptsize \def\@blockbreite{59mm}}{}
        \ifthenelse{\value{blockzahl} = 4}
          {\scriptsize \def\@blockbreite{44mm}}{}
        \ifthenelse{\value{blockzahl} = 5}
          {\tiny \def\@blockbreite{35mm}}{}
        \ifthenelse{
          \equal{\namezeilea}{\empty} \and \equal{\namezeileb}{\empty} \and
          \equal{\namezeilec}{\empty} \and \equal{\namezeiled}{\empty} \and
          \equal{\namezeilee}{\empty} \and \equal{\namezeilef}{\empty} \and
          \equal{\namezeileg}{\empty}}
          {}{\begin{minipage}[t]{\@blockbreite}
            \namezeilea \hspace*{0mm} \\ \namezeileb \hspace*{0mm} \\
            \namezeilec \hspace*{0mm} \\ \namezeiled \hspace*{0mm} \\
            \namezeilee \hspace*{0mm} \\ \namezeilef \hspace*{0mm} \\
            \namezeileg \hspace*{0mm}
          \end{minipage}}
        \ifthenelse{
          \equal{\adresszeilea}{\empty} \and \equal{\adresszeileb}{\empty} \and
          \equal{\adresszeilec}{\empty} \and \equal{\adresszeiled}{\empty} \and
          \equal{\adresszeilee}{\empty} \and \equal{\adresszeilef}{\empty}}
          {}{\begin{minipage}[t]{\@blockbreite} {\bf \adresstext} \\
            \adresszeilea \hspace*{0mm} \\ \adresszeileb \hspace*{0mm} \\
            \adresszeilec \hspace*{0mm} \\ \adresszeiled \hspace*{0mm} \\
            \adresszeilee \hspace*{0mm} \\ \adresszeilef \hspace*{0mm}
          \end{minipage}}
        \ifthenelse{
          \equal{\telefonzeilea}{\empty} \and \equal{\telefonzeileb}{\empty}
          \and \equal{\telefonzeilec}{\empty} \and \equal{\telefonzeiled}
          {\empty} \and \equal{\telefonzeilee}{\empty} \and
          \equal{\telefonzeilef}{\empty}}
          {}{\begin{minipage}[t]{\@blockbreite} {\bf \telefontext} \\
            \telefonzeilea\hspace*{0mm} \\ \telefonzeileb\hspace*{0mm} \\
            \telefonzeilec\hspace*{0mm} \\ \telefonzeiled\hspace*{0mm} \\
            \telefonzeilee\hspace*{0mm} \\ \telefonzeilef\hspace*{0mm}
          \end{minipage}}
        \ifthenelse{
          \equal{\internetzeilea}{\empty} \and \equal{\internetzeileb}{\empty}
          \and \equal{\internetzeilec}{\empty} \and \equal{\internetzeiled}
          {\empty} \and \equal{\internetzeilee}{\empty} \and
          \equal{\internetzeilef}{\empty}}
          {}{\begin{minipage}[t]{\@blockbreite} {\bf \internettext} \\
            \internetzeilea\hspace*{0mm} \\ \internetzeileb\hspace*{0mm} \\
            \internetzeilec\hspace*{0mm} \\ \internetzeiled\hspace*{0mm} \\
            \internetzeilee\hspace*{0mm} \\ \internetzeilef\hspace*{0mm}
          \end{minipage}}
        \ifthenelse{
          \equal{\bankzeilea}{\empty} \and \equal{\bankzeileb}{\empty} \and
          \equal{\bankzeilec}{\empty} \and \equal{\bankzeiled}{\empty} \and
          \equal{\bankzeilee}{\empty} \and \equal{\bankzeilef}{\empty}}
          {}{\begin{minipage}[t]{\@blockbreite} {\bf \banktext} \\
            \bankzeilea\hspace*{0mm} \\ \bankzeileb\hspace*{0mm} \\
            \bankzeilec\hspace*{0mm} \\ \bankzeiled\hspace*{0mm} \\
            \bankzeilee\hspace*{0mm} \\ \bankzeilef\hspace*{0mm}
          \end{minipage}}}}
    \end{picture} \hfill}
  \def\@evenhead{\@oddhead} \def\@evenfoot{\@oddfoot}}

\def\ps@regularpage{ \headheight36pt\def\@oddhead{\unitlength1mm
    \begin{picture}(0,0)
      \put(-6,3){\makebox(171,15){\normalsize
        \textsc{{\Large\quad}\name\hfill\pagename\ \thepage\quad\hfill
        \datum}}}
      \iftrennlinien \put(0,0){\rule{165mm}{0.5pt}} \fi
    \end{picture}\hfill}
  \def\@oddfoot{\empty} \def\@evenhead{\@oddhead}
  \def\@evenfoot{\@oddfoot}}


\IfFileExists{babel.sty}
  {\RequirePackage[\sprache]{babel}[2001/03/01]}
  {\ClassError{g-brief}
    {Babel not installed !!!}
    {Get babel package !!!}}

\ifx \@docencoding\empty \else
\IfFileExists{inputenc.sty}
  {\RequirePackage[\@docencoding]{inputenc}}
  {\ClassError{g-brief}
    {LaTeX2e not complete installed or out of date !!!}
    {Get current LaTeX2e !!!}}
\fi

\IfFileExists{marvosym.sty}
  {\RequirePackage{marvosym}}
  {}{}
\IfFileExists{europs.sty}
  {\RequirePackage{europs}}
  {}{}
\IfFileExists{eurosym.sty}
  {\RequirePackage{eurosym}}
  {}{}


\endinput
%%
%% End of file `g-brief2.cls'.
