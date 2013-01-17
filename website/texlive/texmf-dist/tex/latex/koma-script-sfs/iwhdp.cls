%%%****************** iwhdp.cls *********************%%%
%%%==================================================%%%
%%%     Klassendatei für IWH-DISKUSSIONSPAPIERE      %%%
%%%==================================================%%%
%%% First Upload to CTAN: February 2011              %%%
%%%--------------------------------------------------%%%
%%% Dokumentenklasse iwhdp.cls erste Version:        %%%
%%%               Wilfried Ehrenfeld im Februar 2010 %%%
%%%**************************************************%%%
\def\iwhdpversion{0.25}% Diese Version
\def\iwhdpdate{2011/12/06}% yyyy/mm/dd
%%
  %% iwhdp.cls
  %% Copyright 2010-2011 Wilfried Ehrenfeld
  %
  % This work may be distributed and/or modified under the
  % conditions of the LaTeX Project Public License, either version 1.3
  % of this license or (at your option) any later version.
  % The latest version of this license is in
  %   http://www.latex-project.org/lppl.txt
  % and version 1.3 or later is part of all distributions of LaTeX
  % version 2005/12/01 or later.
  %
  % This work has the LPPL maintenance status `maintained'.
  % 
  % The Current Maintainer of this work is Wilfried Ehrenfeld.
  %
  % This work consists of the file iwhdp.cls.
%%
%%%--------------------------------------------------%%%
%%%----- *** Beginn Beispieldatei iwhdp.tex *** -----%%%
%%%--------------------------------------------------%%%
%%%-------------------- schnipp! --------------------%%%
%%
%%=====================================================% 
%%               IWH DISKUSSIONSPAPIER                 %
%%     Vorlage: Wilfried Ehrenfeld (2011-05)           %
%%=====================================================%
%\documentclass[german]{iwhdp}
%%-----------------------------------------------------%
%%------------------- *** Bibliographische Angaben *** %
%%* Titel *--------------------------------------------%
%\title{Eine \LaTeX-Vorlage für IWH-Diskussionspapiere}% Papersprache
%\titlealt{A \LaTeX{} template for IWH discussion papers}% Alternativsprache
%%* Autor *--------------------------------------------%
%\author{Wilfried Ehrenfeld}%
%\department{Abteilung Strukturökonomik}%
%\tel{+49\,(0)\,345 7753 832}%
%\email{wilfried.ehrenfeld@iwh-halle.de}%
%%* Koautor *------------------------------------------%
%\cauthor{NN}% NN: Kein Koautor
%\cdepartment{}%
%\ctel{}%
%\cemail{}%
%%* Zweiter Koautor *----------------------------------%
%\ccauthor{NN}% NN: Kein zweiter Koautor
%\ccdepartment{}%
%\cctel{}%
%\ccemail{}%
%%* Dritter Koautor *----------------------------------%
%\cccauthor{NN}% NN: Kein dritter Koautor
%\cccdepartment{}%
%\ccctel{}%
%\cccemail{}%
%%* Erscheinungsmonat und DP-Nummer -------------------%
%%\dpdate{05}{1984}% {Monat}{Jahr} - nur nötig, wenn abeichend.
%%\dpnumber{1}% Nach Zuteilung aktivieren und eintragen.
%%* Abstract/Zusammenfassung *-------------------------%
%\dpabstract{Dies ist eine \LaTeX-Vorlage für IWH-Diskussionspapiere.}% Papersprache
%\dpabstractalt{This is a \LaTeX{} template for IWH discussion papers.}% Alternativsprache
%%* Keywords, Schlagwörter, JEL -----------------------%
%\keywords{IWH, \LaTeX, Vorlage}% Papersprache
%\keywordsalt{IWH, \LaTeX, template}% Alternativsprache
%\jel{Z0}% JEL-Klassifikation
%%* Titelfussnote: Danksagung, Bemerkungen etc. *------%
%\thanks{NN}% Papersprache. NN: Keine 
%\thanksalt{NN}% Papersprache. NN: Keine 
%%-------------- *** Ende Bibliographische Angaben *** %
%%-----------------------------------------------------%
%% Literaturdatenbank. Standard: {iwhdp_paper} -> Datei: iwhdp_paper.bib
%\bibliography{Anleitung}
%-----------------------------------------------------%
%\begin{document}
%\makeiwhtitle% IWH DP Vorspann ausgeben
%%-------------- *** Text des Papiers *** -------------%
%\section{Einleitung}
% ...
%
%%----------------- *** Textende *** ------------------%
%\clearpage% Seitenumbruch
%\makebib% Literaturverzeichnis ausgeben
%\end{document}
%
%% *** EOF iwhdp_paper.tex *** 
%%
%%%-------------------- schnipp! --------------------%%%
%%%--------------------------------------------------%%%
%%%------ *** Ende Beispieldatei iwhdp.tex *** ------%%%
%%%--------------------------------------------------%%%
%%
%% Anmerkung: documentclass muss in iwhdp.tex VOR den IWH-newcommands stehen,
%% weil sonst das Encoding in den deutschen Abstracts nicht stimmt (ß!)
%% **************************************
%% *** Beginn Klassendatei: iwhdp.cls ***
%% **************************************
\def\filename{iwhdp.cls}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iwhdp}[\iwhdpdate\space IWH Discussion Paper Class
 v.\iwhdpversion\space by Wilfried Ehrenfeld]% yyyy/mm/dd

\usepackage{xifthen}%
%
% Optionen leer deklarieren, defaults setzen, mit gewählten Optionen überschreiben.
\newcommand{\iwhlanguage}{}% Sprache
\newcommand{\iwhbib}{}% Literaturverzeichnis
\newcommand{\iwhbackend}{}% Backend zum Sortieren
\newcommand{\iwhconference}{false}% Option für Konferenz. 2011-05-19
\newcommand{\iwhissn}{false}% Option für issn. 2011-12-06 - give a kiss to I.D.
%
\DeclareOption{german}{\renewcommand{\iwhlanguage}{d}}% deutsches DP
\DeclareOption{english}{\renewcommand{\iwhlanguage}{e}}% englisches DP
%
\DeclareOption{nobib}{\renewcommand{\iwhbib}{nobib}}% kein Literaturmanagement
\DeclareOption{harvard}{\renewcommand{\iwhbib}{harvard}}% harvard-Befehlssatz
\DeclareOption{biblatex}{\renewcommand{\iwhbib}{biblatex}}% Biblatex verwenden
%
\DeclareOption{conference}{\renewcommand{\iwhconference}{true}}% Option für Konferenz. 2011-05-19
%
\DeclareOption{noissn}{\renewcommand{\iwhissn}{false}}% Option für issn. 2011-12-06
\DeclareOption{issn}{\renewcommand{\iwhissn}{true}}% Option für issn. 2011-12-06
%
\DeclareOption{biber}{\renewcommand{\iwhbackend}{biber}}% biber als Backend für biblatex verwenden
%
\DeclareOption*{\ClassWarningNoLine{iwhdp}{Option unbekannt: '\CurrentOption'}}
\ExecuteOptions{english, biblatex}% default options
\ProcessOptions*\relax% Optionen ausführen
%

%% Spracheinstellungen; Pakete laden
\ifthenelse{\equal{\iwhlanguage}{d}}
{\usepackage[USenglish,ngerman]{babel}}
{\usepackage[ngerman,USenglish]{babel}}

% Basis-Klassendatei laden: KomaScript Artikel
\LoadClass[12pt,final,twoside,captions=nooneline,parskip=half-]{scrartcl}%oneline: zentriert; sonst: nooneline
%
\setkomafont{sectioning}{\normalfont\bfseries}% Überschriften
\setkomafont{descriptionlabel}{\normalfont\bfseries}
%\setkomafont{captionlabel}{\normalfont\bfseries}
%\setkomafont{caption}{\normalfont\bfseries}
%
\usepackage[ansinew]{inputenc}% ansinew + textcomp => Euro-Zeichen funktioniert :-) 
\usepackage[T1]{fontenc}
\usepackage{lmodern}%  Schriftart Latin Modern
%
%
\usepackage{fancyhdr}% Formatierung von Kopf- und Fußzeile
\usepackage[hang]{footmisc}% Fussnotengestaltung
%
% Besonderheiten der Textgestaltung
\usepackage{setspace} 	% Veraenderung von Zeilenabstaenden
\usepackage{lscape}			% Drehen von Seiten
\usepackage{rotating}		% Drehen von Seiten
\usepackage{multicol}		% mehspaltiger Text
\usepackage{textcomp}   % mit ansinew für inputenc + textcomp geht auch das €-Zeichen
%
% Tabellen, Abbildungen
\usepackage{float}			% Platzierung von Tab., Abb. in Text
\usepackage{array}			% Formatieren von Tabellen
\usepackage{booktabs}		% Formatieren von Tabellen
\usepackage{longtable}	% Tabellen länger als eine Seite     
\usepackage{dcolumn}		% Ausrichtung der Zahlen in Tabellen am Dezimalpunkt
%
% Einbinden anderer Dateien
\usepackage{pdfpages}	  % Grafik als komplette Seite einfügen (ohne Ränder usw.)
\usepackage{wallpaper}  % Grafiken als Hintergrund
\usepackage{graphicx}		% Einbinden von Grafiken [pdftex]
%
% AMS-Packages fuer mathematische Formeln
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{sansmath}
%
\usepackage{pifont}% Sonderzeichen
\usepackage{xspace}% Leerzeichen mit Abfrage
%
%\setlength{\parskip}{8pt plus0pt minus2pt}% Absatzzwischenraum
\raggedbottom
%
\deffootnote[1em]{1em}{1em}{\textsuperscript{\thefootnotemark}~}% Abstand Fußnotenzahl Fußnote
\setlength{\footnotesep}{12pt}% Abstand Fußnoten untereinander
%
\frenchspacing% Kein großer Abstand nach Punkten (.)
%
\usepackage{color}
\definecolor{LinkColor}{rgb}{0,0,0.3}
\definecolor{Red}{rgb}{0.7,0,0}
\definecolor{Green}{rgb}{0,0.7,0}
\definecolor{Blue}{rgb}{0,0,0.7}
%
\ifthenelse{\equal{\iwhlanguage}{d}}% für Monatsnamen ausgeben
{\usepackage[ngerman]{datenumber}}% deutscher Name
{\usepackage[english]{datenumber}}%
%
%------------------------------------------------%
%              IWH Layout Angaben
%------------------------------------------------%
% Seitenlayout
\usepackage{geometry}		% Seitenlayout
\geometry{top=2.3cm, bottom=2.2cm, inner=3cm, outer=3cm}	% Seitenraender
\geometry{includehead, headheight=15pt}		% Kopfzeile zaehlt zum Textkoerper
\geometry{includefoot}										% Fusszeile zählt zum Textkoerper
\geometry{footskip=1.5cm}                 % Abstand Text und Fusszeile
%\setstretch{1.25}                         % Zeilenabstand im Text
\onehalfspacing
\setlength{\parindent}{0ex}               % kein Einschub der ersten Zeile der Absaetze
%	
\widowpenalty=10000% keine einzelnen Zeilen am Beginn und am Ende einer Seite
\clubpenalty=10000%
\usepackage{microtype}% Laufweiten anpassen
%			
% Kopf- und Fusszeile (zweiseitig) 
\pagestyle{fancy}  
\renewcommand{\headrulewidth}{0pt}
%
\ifthenelse{\equal{\iwhconference}{false}}{%
% Kopf- und Fußzeilen bei DP
\fancyhead{}
\fancyhead[LE]{\small{\sffamily{\textbf{IWH}}}}
\fancyhead[RE]{\rule{14cm}{0.5pt}}
\fancyhead[RO]{\small{\sffamily{\textbf{IWH}}}}
\fancyhead[LO]{\rule{14cm}{0.5pt}}
%
\fancyfoot{}
\fancyfoot[LE]{\thepage}
\fancyfoot[RE]{\small \iwhdpname \@dpnumber /\thedateyear}
\fancyfoot[RO]{\thepage}
\fancyfoot[LO]{\small \iwhdpname \@dpnumber /\thedateyear}
}{% 
% Kopf- und Fußzeilen bei Konferenz
\fancyhead{}
\fancyhead[RE]{\rule{\textwidth}{0.5pt}}
\fancyhead[LO]{\rule{\textwidth}{0.5pt}}
%
\fancyfoot{}
\fancyfoot[LE]{\thepage}
\fancyfoot[RO]{\thepage}
}
%
\newcommand{\trenn}{\hspace{1em}}% Trennbefehl für zweite Seite     
%
%------------------------------------------------%
%        Literaturverzeichnis: Zitierstil
%------------------------------------------------%
\ifthenelse{\equal{\iwhbib}{nobib}}
{% Behelfsumgebung für Literaturverzeichnisse
\newenvironment{iwh_ref}{%
\setlength{\parskip}{10pt}%
\begin{list}{}{%
\setlength{\leftmargin}{1cm}%
\setlength{\itemindent}{-1cm}}}%
{\end{list}}%
%
\newcommand{\makebib}{% 'Literaturverzeichnis' ausgeben
\clearpage
{\Large{\textbf{\ifthenelse{\equal{\iwhlanguage}{d}}%
{Literatur\\[-0pt]}{References\\[-0pt]}}}}}%
}% Ende Behelfsumgebung nobib
%
{% Literaturverzeichnis automatisch erstellen: Biblatex
\usepackage[babel,german=quotes]{csquotes} 
%
\usepackage[%
bibencoding=inputenc,% selbes Encoding in bib und tex Dateien
bibstyle=authoryear,% (.bbx) Autor-Jahr im LitVerz
citestyle=authoryear,% (.cbx) Autor-Jahr in Zitaten
maxnames=3,% Anzahl Namen, über der u.a. geschrieben wird
minnames=2,% Anzahl Namen, die dann noch ausgeschrieben werden
uniquename=init,firstinits=true,% Vornamen im LitVerz abkürzen
%backref=true,% Rück-Referenzen in LitVerz
%style=authoryear,% Zitierweise Autor-Jahr in Zitierstil und LitVerz
hyperref=true% hyperref benutzen
]{biblatex}%
[2010/02/14]% mindestens Version 0.9
%[2010/11/19]% mindestens Verion 1.0

% Backend wählen
\ifthenelse{\equal{\iwhbackend}{biber}}%
	{\ifthenelse{\equal{\iwhlanguage}{d}}%
		{\ExecuteBibliographyOptions{backend=biber,sortlocale=de_DE}}%
		{\ExecuteBibliographyOptions{backend=biber,sortlocale=en_US}}%
	}{\ExecuteBibliographyOptions{backend=bibtex8}}

%
%%% Zitate: Jahr und Seiten durch Doppelpunkt trennen
%%
%\renewcommand{\nameyeardelim}{\space\addcomma\addspace}% Autor-Jahr durch , trennen
\DeclareFieldFormat{postnote}{#1}% Kein 'S. ' vor der Seitenzahl
\renewcommand{\postnotedelim}{\space\addcolon}% Trennzeichen: :

%%% Strings Literaturverzeichnis
%%
\DefineBibliographyStrings{ngerman}{%
bibliography = {Literatur},% Überschrift LitVerz Bücher
references = {Literatur},% Überschrift LitVerz andere
urlseen = {aufgerufen am},% 'besucht am' ändern
andothers = {et al.},% 'u. a. ' ändern
%in = {\addthinspace},% "In" raus (Global!)
}%Ende DeclareBibliographystrings

%%% Im LitVerz Autor und Titel durch : trennen
\renewcommand{\labelnamepunct}{\addcolon\space}%

%%% Formatierung Felder LitVerz (siehe biblatex.def)
%\renewcommand{\mkbibnamelast}[1]{\textit{#1}} Autornachname kursiv
\DeclareFieldFormat{title}{#1\isdot}% Titel nicht kursiv
%\DeclareFieldFormat{journaltitle}{#1\isdot}% Journal Titel nicht kursiv
\DeclareFieldFormat{booktitle}{#1\isdot}% Buchtitel
%
%\DefineBibliographyStrings{english}{in = {\!\!\!}}% "In" raus (Global!)
%\DefineBibliographyStrings{ngerman}{in = {\!\!\!}}% "In" raus (Global!)
%
\DeclareFieldFormat[article]{citetitle}{#1\isdot}% Anführungszeichen raus beim zitieren (biblatex 0.9)
\DeclareFieldFormat[article]{title}{#1\isdot}% Anführungszeichen raus im Lit.Verz. (biblatex 0.9)
%
%%% Layout LitVerz
\setlength{\bibhang}{2em}% Einzug
\setlength{\bibitemsep}{6pt}% Zwischenraum Einträge selber Autor
\setlength{\bibnamesep}{10pt}% Zwischenraum Einträge neuer Autor
%
%% authoryear: 'Strich' für selben Autor entfernen
%% Version für biblatex 0.9: Wilfried Ehrenfeld 2010-02-15
\renewbibmacro*{author}{%
  \ifthenelse{\ifuseauthor\AND\NOT\ifnameundef{author}}
       {\usebibmacro{bbx:savehash}%
        \printnames{author}%
	\iffieldundef{authortype}
	  {\setunit{\addspace}}
	  {\setunit{\addcomma\space}}%
     \iffieldundef{authortype}
       {}
       {\usebibmacro{authorstrg}%
	\setunit{\addspace}}}%
    {\global\undef\bbx@lasthash
     \usebibmacro{labeltitle}%
     \setunit*{\addspace}}%
  \usebibmacro{date+extrayear}}
%  
\ifthenelse{\equal{\iwhbib}{harvard}}%
{% harvard kompatble Zitierbefehle - WE 15.02.2010
%
\usepackage{suffix}% Für Makros mit Stern
%
\DefineBibliographyStrings{english}{in = {\!\!\!}}% % "In" raus (Global!)
%
\renewcommand{\postnotedelim}{\addcomma\space}% Trennzeichen ',' - z.B. zwischen Jahr und Seitenzahl
\renewcommand{\multicitedelim}{\addcomma\space}% Trennzeichen ',' - z.B. bei mehreren Jahreszahlen 
%
\renewcommand{\cite}{\parencite}% 'normales' Zitierkommando -> mit Klammern
 \WithSuffix\newcommand{\cite}*{\parencite}
%
\renewcommand{\citeyear}[1]{(\citefield{#1}{year})}% Jahreszahl mit Klammern
 \WithSuffix\newcommand{\citeyear}*[1]{\citefield{#1}{year}}
%
\newcommand{\citeaffixed}[2]{\parencite[#2][]{#1}}% zweiter Parameter ist der Präfix.
%
\newcommand{\citeasnoun}{\textcite}% Nur Jahreszahl in Klammern
 \WithSuffix\newcommand\citeasnoun*{\textcite}
%
\renewcommand{\citename}{\citeauthor}% Nur Autoren zitieren
 \WithSuffix\newcommand\citename*{\citeauthor*}
}% Ende harvard
%
{% Zitierbefehle Ehrenfeld
%%
%% \zit{Label}{Seite(n)} oder \zit[siehe]{Label}{Kapitel}
%% -> (Ehrenfeld 2009:1–2) oder (siehe Ehrenfeld 2009:1–2)
\newcommand{\zit}[3][]{\parencite[#1][#3]{#2}}
%%
%% \tzit{Label}{Seite(n)}
%% -> Ehrenfeld (2009:1-2)
\newcommand{\tzit}[3][]{\textcite[#1][#3]{#2}}
%
%% citep und citet als Alias für parencite und textcite
%% analog zu Natbib
\newcommand{\citep}{\parencite}
\newcommand{\citet}{\textcite}
%
\newcommand{\pcite}{\parencite}
\newcommand{\tcite}{\textcite}
%
\newcommand{\pcites}{\parencites}
\newcommand{\tcites}{\textcites}
%
\newcommand{\citetype}[1]{\citefield{#1}{type}}% Type-Feld zitieren
%%
}% Ende Zitierbefehle Ehrenfeld
%
%\bibliography{iwhdp}%  Standard-Literaturdatenbank laden
%
\newcommand{\makebib}{% Literaturverzeichnis ausgeben
%\clearpage%
\printbibliography[maxnames=23]% Aufruf mit max. Autoren im Lit-Verz
}%
%
}% Ende Literaturverzeichnis automatisch
%
%------------------------------------------------%
%        Ende Zitierstile Literaturverzeichnis
%------------------------------------------------%
%
\usepackage{hyperref}% PDF Links: Hyperref NACH jurabib laden!
%
\hypersetup{colorlinks=true,%
            linkcolor=LinkColor,%
            citecolor=LinkColor,%
            urlcolor=LinkColor,%
            pdfcreator={iwhdp v.\iwhdpversion\space by Wilfried Ehrenfeld}}% 


% ------------------------------------
%  Übernahme bibliographische Angaben 
% ------------------------------------
% author -> \@author: Latex intern.
\gdef\@author{NN}
\def\author#1{\gdef\@author{#1}}
\def\department#1{\gdef\@department{#1}}
\def\tel#1{\gdef\@tel{#1}}
\def\email#1{\gdef\@email{#1}}
%
\gdef\@cauthor{NN}
\def\cauthor#1{\gdef\@cauthor{#1}}
\def\cdepartment#1{\gdef\@cdepartment{#1}}
\def\ctel#1{\gdef\@ctel{#1}}
\def\cemail#1{\gdef\@cemail{#1}}
%
\gdef\@ccauthor{NN}
\def\ccauthor#1{\gdef\@ccauthor{#1}}
\def\ccdepartment#1{\gdef\@ccdepartment{#1}}
\def\cctel#1{\gdef\@cctel{#1}}
\def\ccemail#1{\gdef\@ccemail{#1}}
%
\gdef\@cccauthor{NN}
\def\cccauthor#1{\gdef\@cccauthor{#1}}
\def\cccdepartment#1{\gdef\@cccdepartment{#1}}
\def\ccctel#1{\gdef\@ccctel{#1}}
\def\cccemail#1{\gdef\@cccemail{#1}}
%
% title -> \@title: Latex intern
\def\@title{~}
\def\title#1{\gdef\@title{#1}}
%
\def\titlealt#1{\gdef\@titlealt{#1}}
%
\gdef\@dpnumber{\_\_}
\def\dpnumber#1{\gdef\@dpnumber{#1}}
%
\def\dpdate#1#2{\gdef\@dpmonth{#1}\gdef\@dpyear{#2}}
%
\def\jel#1{\gdef\@jel{#1}}
%
\def\keywords#1{\gdef\@keywords{#1}}
\def\keywordsalt#1{\gdef\@keywordsalt{#1}}
%
\long\def\dpabstract#1{\gdef\@dpabstract{\protect#1}}
\long\def\dpabstractalt#1{\gdef\@dpabstractalt{#1}}
%
\def\thanks#1{\ifthenelse{\equal{\iwhlanguage}{d}}{\gdef\@thanksger{#1}}{\gdef\@thankseng{#1}}}
\def\thanksalt#1{\ifthenelse{\equal{\iwhlanguage}{e}}{\gdef\@thanksger{#1}}{\gdef\@thankseng{#1}}}
% -------------------------------
%  Ende bibliographische Angaben 
% -------------------------------


% --------------------------------
%  Eigene Befehle und Abkürzungen 
% --------------------------------
\newcommand{\nn}{\nonumber\\}
\newcommand{\mb}{\mbox}
\newcommand{\fns}{\footnotesize}
%
\newcommand{\Quelle}{\textcolor{blue}{\textbf{\mbox{<Quelle>}}}\xspace}
\newcommand{\Mehr}[1]{\textcolor{Green}{\textbf{<#1>}}}
\newcommand{\fehlt}{\textcolor{blue}{\boldmath\Large$\forall$}}
%
\renewcommand{\Check}[1]{\textcolor{blue}{\textbf{?#1?}}}
\newcommand{\verify}[1]{\textcolor{blue}{\textbf{?#1?}}}
%
\newcommand{\Endemarke}{\centerline{\textcolor{Blue}{------~{\fns \today}~------}}}
%
\newcommand{\zB}{\mbox{z.\,B.}\xspace}
\newcommand{\ua}{\mbox{u.\,a.}\xspace}
\newcommand{\so}{\mbox{s.\,o.}\xspace}
\newcommand{\eg}{\mbox{e.\,g.}\xspace}
\newcommand{\ie}{\mbox{i.\,e.}\xspace}
%
\newcommand{\Wkeit}{Wahrscheinlichkeit\xspace}
\newcommand{\GG}{Gleichgewicht\xspace}
%
\newcommand{\Wm}{W/m$^2$\xspace}
\newcommand{\CO}{CO$_2$\xspace}
\newcommand{\IPCC}{\mbox{IPCC}\xspace}
%
\graphicspath{{img/}}% Abbildungen (*.jpg, *.pdf) im Unterverzeichnis img werden automatisch gefunden
%
\hyphenation{%
Emis-si-ons-han-del% Duden 24 Aufl. S.364
}


%=====================================%
%               TITELEI               %
%=====================================%
%                                     
\ifthenelse{\equal{\iwhlanguage}{d}}
{\newcommand{\iwhdpname}{IWH-Diskussionspapier }}% deutscher Name
{\newcommand{\iwhdpname}{IWH Discussion Paper }}% englischer Name
%
%--------------------------------------%
%       Deckblatt und Titelseite       %
%--------------------------------------%
% Makro Koautoren auf Titelseite ausgeben
% \@coname{Name}
\newcommand{\@coname}[1]{% Koautoren ausgeben
 \ifthenelse{\equal{#1}{NN}}{}{% definiert?
  \\{\Large \textit #1}}}% Koautor: Name ausgeben
%
% *** Titelseite definieren ***
\newcommand{\iwhtitlepage}{% 
%
% Fehlermeldungen Klassendatei
%
\ifthenelse{\equal{\@author}{NN}}{\ClassError{iwhdp}{\protect\author\space is undefined}%
 {\@ehc}}{}%
\ifthenelse{\equal{\@title}{~}}{\ClassError{iwhdp}{\protect\title\space is undefined}%
 {\@ehc}}{}%
%
\ifthenelse{\isundefined{\@titlealt}}{\ClassError{iwhdp}{\protect\titlealt\space is undefined}%
 {\@ehc}\gdef\@titlealt{~}}{}%
%
\ifthenelse{\isundefined{\@dpabstract}}{\ClassError{iwhdp}{\protect\dpabstract\space is undefined}%
 {\@ehc}\gdef\@dpabstract{~}}{}%
%
\ifthenelse{\isundefined{\@dpabstractalt}}{\ClassError{iwhdp}{\protect\dpabstractalt\space is undefined}%
 {\@ehc}\gdef\@dpabstractalt{~}}{}%
%
\ifthenelse{\isundefined{\@keywords}}{\ClassError{iwhdp}{\protect\keywords\space is undefined}%
 {\@ehc}\gdef\@keywords{~}}{}%
%
\ifthenelse{\isundefined{\@keywordsalt}}{\ClassError{iwhdp}{\protect\keywordsalt\space is undefined}%
 {\@ehc}\gdef\@keywordsalt{~}}{}%
%
\ifthenelse{\isundefined{\@jel}}{\ClassError{iwhdp}{\protect\jel\space is undefined}{}\gdef\@jel{~}}{}%%
% Monat und Jahr übernehmen
%
\ifthenelse{\isundefined \@dpmonth}{}{%
 \setdatenumber{\@dpyear}{\@dpmonth}{13}}% Veröffentlichungsdatum im Format {Jahr}{Monat}{Tag}

%
% pdfinfo
%
\ifthenelse{\equal{\iwhconference}{false}}{% DP?
\ifthenelse{\equal{\iwhlanguage}{d}}%
 {\def\@iwhauthsep{ und }}{\def\@iwhauthsep{ and }}% sprachabhängiger Autorenseparator
%
\ifthenelse{\equal{\@cccauthor}{NN}}{% 
 \ifthenelse{\equal{\@ccauthor}{NN}}{%
  \ifthenelse{\equal{\@cauthor}{NN}}{%
   \def\@pdfauthor{\@author}}{%
  \def\@pdfauthor{\@author\@iwhauthsep\@cauthor}}}{%
 \def\@pdfauthor{\@author, \@cauthor \@iwhauthsep \@ccauthor}}}{%
\def\@pdfauthor{\@author, \@cauthor, \@ccauthor \@iwhauthsep \@cccauthor}}%
%
\hypersetup{pdfauthor=\@pdfauthor,%
						pdftitle=\@title,%
						pdfkeywords=\@keywords}
}{}%
						

% ---------------------
%  Titelseite ausgeben
% ---------------------
%
\thispagestyle{empty}
%
~\vfill\vfill
%
\begin{center}
%\fbox{%
\begin{minipage}[t]{11cm}
\begin{center}
%
\Large{\bf \@title}\\[0.7cm]
%
{\Large \textit \@author}%  Name Autor ausgeben
\@coname{\@cauthor}%        Name 1. Koautor ausgeben
\@coname{\@ccauthor}%       Name 2. Koautor ausgeben
\@coname{\@cccauthor}%      Name 3. Koautor ausgeben
%
\\[0.7cm]
%
\ifthenelse{\equal{\iwhconference}{false}}{% DP?
	{\large \datemonthname \ \thedateyear \hfill% Monat
	\ifthenelse{\equal{\iwhlanguage}{d}}{Nr.}{No.} \@dpnumber}% Nummer
}{}% Ende DP?
\end{center}
\end{minipage}
%}% Ende fbox
\end{center}
%
\vfill
%
\clearpage
}% Ende Titelseite
%
%
%------------------------------%
%   Zweite Seite: Autoren      %
%------------------------------%
% Makro für Ausgabe Koautoren
% \@coauthor{Name}{Department}{Tel}{eMail}
\newcommand{\@coauthor}[4]{%
\ifthenelse{\equal{#1}{NN}}{}{% Autor definiert?
 ~\\[12pt]\textit{#1}% Autor ausgeben mit Platz darüber
\ifthenelse{\isundefined #2}{}{\\ #2}% Abteilung
\ifthenelse{\isundefined #3}{}{\ifthenelse{\equal{\iwhlanguage}{d}}{\\E-Mail}{\\E-mail}: #3}% eMail
\ifthenelse{\isundefined #4}{}{\ifthenelse{\equal{\iwhlanguage}{d}}{\\Tel.}{\\Phone}: #4}% Telefon
}}% Ende Makro Koautor ausgeben
%
%
% ---------------------
% Zweite Seite ausgeben
% ---------------------
%
\newcommand{\iwhsecondpage}{%
%
\setcounter{page}{2}
%
\setstretch{1.0}
%
\ifthenelse{\equal{\iwhlanguage}{d}}%
{\ifthenelse{\equal{\@cauthor}{NN}}{Autor:}{Autoren:}}% deutsch: Koautor definiert?
{\ifthenelse{\equal{\@cauthor}{NN}}{Author:}{Authors:}}% englisch
 \qquad%
%
%\fbox{ 
\begin{minipage}[t]{12,5cm}
\textit{\@author}% Autor
\ifthenelse{\isundefined \@department}{}{\\ \@department}% Abteilung
\ifthenelse{\isundefined \@email}{}{\ifthenelse{\equal{\iwhlanguage}{d}}{\\E-Mail}{\\E-mail}: \@email}% eMail
\ifthenelse{\isundefined \@tel}{}{\ifthenelse{\equal{\iwhlanguage}{d}}{\\Tel.}{\\Phone}: \@tel}% Telefon
%
\@coauthor{\@cauthor}{\@cdepartment}{\@cemail}{\@ctel}% Koautor
\@coauthor{\@ccauthor}{\@ccdepartment}{\@ccemail}{\@cctel}% 2. Koautor
\@coauthor{\@cccauthor}{\@cccdepartment}{\@cccemail}{\@ccctel}% 3. Koautor
%
\end{minipage}
%}% Ende fbox
%
%
\vfill\vfill
%
%

% ------------------------
% Disclaimer und Impressum
% ------------------------
\ifthenelse{\equal{\iwhconference}{false}}{% DP?
\ifthenelse{\equal{\iwhlanguage}{d}}{%
% *** deutscher Disclaimer und Impressum ***
Die Diskussionspapiere stehen in der alleinigen Verantwortung der jeweiligen Autoren. 
Die darin vertretenen Auffassungen stellen keine Meinungsäußerung des IWH dar. 
IWH-Diskussionspapiere sind Zwischenergebnisse, die zur Diskussion gestellt werden. 
In der Regel sind sie nur für einen begrenzten Zeitraum relevant; 
eine überarbeitete Version ist unter Umständen direkt von den Autoren erhältlich.\\[20pt]
%
Kommentare und Vorschläge sowohl zu angewandten Methoden als auch zu den Ergebnissen sind jederzeit willkommen.\\[10pt]
%
IWH-Diskussionspapiere werden in RePEc-Econpapers und in ECONIS indexiert.
%
\vfill
%
Herausgeber:\\
%
INSTITUT FÜR WIRTSCHAFTSFORSCHUNG HALLE - IWH\\
Prof.\,Dr.\,Dr.\,h.\,c. Ulrich Blum (Präsident), Dr.\,Hubert Gabrisch (Forschungsdirektor)\\
Das IWH ist Mitglied der Leibniz-Gemeinschaft.\\

\setlength{\tabcolsep}{0pt}
%
\begin{tabular}{ll}
Hausanschrift:&\trenn Kleine Märkerstraße 8, D-06108 Halle (Saale)\\
Postanschrift:&\trenn Postfach 11\,03\,61, D-06017 Halle (Saale)\\
Telefon:&\trenn +49\,\,(0)\,345 7753-60\\
Telefax:&\trenn +49\,\,(0)\,345 7753-820\\
Internetadresse:&\trenn http://www.iwh-halle.de %
\end{tabular}
}% Ende deutscher Disclaimer
%
%
{% *** englischer Disclaimer und Impressum ***
The responsibility for discussion papers lies solely with the individual authors. 
The views expressed herein do not necessarily represent those of the IWH. 
The papers represent preliminary work and are circulated to encourage discussion with the authors. 
Citation of the discussion papers should account for their provisional character; 
a revised version may be available directly from the authors.\\[20pt]
%
Comments and suggestions on the methods and results presented are welcome.\\[10pt]
%Suggestions and critical comments on the papers are welcome!\\[10pt]%vor 28.02.11
%
IWH Discussion Papers are indexed in RePEC-Econpapers and in ECONIS.
%
\vfill
%
Editor:\\
%
HALLE INSTITUTE FOR ECONOMIC RESEARCH - IWH\\
Prof\ Dr\ Dr\ h.\,c. Ulrich Blum (President), Dr\ Hubert Gabrisch (Research Director)\\
The IWH is a member of the Leibniz Association.\\

\setlength{\tabcolsep}{0pt}
%
\begin{tabular}{ll}
Address:&\trenn Kleine Maerkerstrasse 8, D-06108 Halle (Saale), Germany\\
Postal Address:&\trenn P.O. Box 11\,03\,61, D-06017 Halle (Saale), Germany\\
Phone:&\trenn +49\,(0)\,345 7753-60\\
Fax:&\trenn +49\,(0)\,345 7753-820\\
Internet:&\trenn http://www.iwh-halle.de %
\end{tabular}
}% Ende englischer Disclaimer
%
\ifthenelse{\equal{\iwhissn}{true}}{%
	\vspace{18pt} \\ ISSN 1860-5303}{% Keine ISSN bei Online-Version
	\vspace{18pt} \\ \phantom{ISSN 1860-5303}}%
%
}{}% Ende DP?
\setstretch{1.25}
\setlength{\tabcolsep}{6pt}% Spaltenabstand Tabelle wieder zurücksetzen
\clearpage%
}% Ende zweite Seite
%
%
%------------------------------%
%   Dritte Seite: deutsch      %
%------------------------------%
\newcommand{\iwhthirdpageger}{%
\selectlanguage{ngerman}% Sprache: Deutsch
%
\begin{center}
\Large{\bf \ifthenelse{\equal{\iwhlanguage}{d}}{\@title}{\@titlealt}}% Titel ausgeben
\ifthenelse{\isundefined \@thanksger}{}{% deutsche Titelfußnote vorhanden?
\ifthenelse{\equal{\@thanksger}{NN}}{}%
{\renewcommand{\thefootnote}{*}% Numerierung ändern -> *
\footnote{\@thanksger}% Fußnote ausgeben: Danksagung
\setcounter{footnote}{0}%
\renewcommand{\thefootnote}{\arabic{footnote}}% 
}% NN
}% undefined
\end{center}

\vspace{1cm}

{\large{\bf Zusammenfassung}}\\[4pt] \ifthenelse{\equal{\iwhlanguage}{d}}{\@dpabstract}{\@dpabstractalt}\\[30pt]
%
{Schlagwörter: }\ifthenelse{\equal{\iwhlanguage}{d}}{\@keywords}{\@keywordsalt}\\[10pt]
%
{JEL-Klassifikation: }\@jel 
%
\ifthenelse{\equal{\iwhlanguage}{d}}
{\selectlanguage{ngerman}}
{\selectlanguage{USenglish}}% Sprache zurückschalten
%
\newpage
}% Ende dritte Seite deutsch
%
%------------------------------%
%   Dritte Seite: englisch     %
%------------------------------%
\newcommand{\iwhthirdpageeng}{%
\selectlanguage{USenglish}
%
\begin{center}
\Large{\bf \ifthenelse{\equal{\iwhlanguage}{e}}{\@title}{\@titlealt}}% Titel ausgeben
\ifthenelse{\isundefined \@thankseng}{}{%
\ifthenelse{\equal{\@thankseng}{NN}}{}%
{\renewcommand{\thefootnote}{*}%
\footnote{\@thankseng}% Fußnote ausgeben: Danksagung
\setcounter{footnote}{0}%
\renewcommand{\thefootnote}{\arabic{footnote}}% 
}% NN
}% undefined
\end{center}

\vspace{1cm}

{\large{\bf Abstract}}\\[4pt] \ifthenelse{\equal{\iwhlanguage}{e}}{\@dpabstract}{\@dpabstractalt}\\[30pt]
%
{Keywords: }\ifthenelse{\equal{\iwhlanguage}{e}}{\@keywords}{\@keywordsalt}\\[10pt]
%
{JEL Classification: }\@jel 
%
\ifthenelse{\equal{\iwhlanguage}{d}}
{\selectlanguage{ngerman}}
{\selectlanguage{USenglish}}% Sprache zurückschalten
%
\newpage
}% Ende dritte Seite englisch
%
%--------------------------------%
%   Routine Vorspann ausgeben    % 
%--------------------------------%
\newcommand{\makeiwhtitle}{%
%
\ifthenelse{\equal{\iwhconference}{false}}{% DP?
\IfFileExists{DP_Deckblatt.pdf}{%
 \ThisCenterWallPaper{1}{DP_Deckblatt}% IWH DP Hintergrund
\setcounter{page}{0}
\iwhtitlepage}{}
}{}% Ende DP?
%
\iwhtitlepage
%
\iwhsecondpage
%
\ifthenelse{\equal{\iwhlanguage}{d}}
{% deutsch
\iwhthirdpageger 
\ifthenelse{\equal{\iwhconference}{false}}{\iwhthirdpageeng}{}
}% 
{% englisch
\iwhthirdpageeng 
\ifthenelse{\equal{\iwhconference}{false}}{\iwhthirdpageger}{}
}%
%
}% Ende Vorspann ausgeben
%
% EOF iwhdp.cls