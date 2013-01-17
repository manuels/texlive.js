%=====================================================================================================================================
% Class uebungsblatt by Igor Akkerman (c)2004,2005,2006
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License (latest version).
%
% The latest version of this license can be found at
%     http://www.latex-project.org/lppl.txt
%=====================================================================================================================================
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{uebungsblatt}[2006/10/24 by Igor Akkerman (c)2004,2005,2006 v1.5.0 Klasse zum Setzen von Uebungsblaettern]
%=====================================================================================================================================

% Dokumentklassen-Optionen:
%     aufgeqno - In Gleichungsnummern soll die Aufgabennummer auftauchen (<Aufgabennummer>.<Gleichungsnummer>)
%     fleqn    - Gleichungen werden nicht zentriert sondern linksbündig angezeigt
%     leqno    - Gleichungsnummern werden nicht rechts sondern links von der Gleichung angezeigt
%     10pt     - Schriftgröße: 10pt (Standard)
%     11pt     - Schriftgröße: 11pt
%     12pt     - Schriftgröße: 12pt

%--------------------------
% \begin{aufgabe} ... \end{aufgabe}
% Aufgabe ohne Teilaufgaben
%--------------------------
% \begin{aufgabe}[<teilaufgabenlabelmuster>] ... \end{aufgabe}
% Aufgabe mit Teilaufgaben
%
% <Teilaufgabennummerierung> wie im Paket counterlabelpattern definiert
%--------------------------

%--------------------------
% \begin{aufgabe*}{<aufgabentitel>} ... \end{aufgabe*}
% Aufgabe mit Titel <aufgabentitel> ohne Teilaufgaben
%--------------------------
% \begin{aufgabe*}[<teilaufgabenlabelmuster>]{<aufgabentitel>} ... \end{aufgabe*}
% Aufgabe mit Titel <aufgabentitel> mit Teilaufgaben
%
% <Teilaufgabennummerierung> kann beliebige Werte enthalten.
%--------------------------
% Der Aufgabenzähler wird NICHT erhöht!
%--------------------------

%--------------------------
% \begin{teilaufgaben}{<teilaufgabenlabelmuster>} ... \end{teilaufgaben}
% Liste der Teilaufgaben
%--------------------------

%--------------------------
% \teilaufgabe
% beginnt eine neue Teilaufgabe
%--------------------------

%--------------------------
% \begin{teilteilaufgaben}{<teilteilaufgabenlabelmuster>} ... \end{teilteilaufgaben}
% Liste der Teilteilaufgaben
%--------------------------

%--------------------------
% \teilteilaufgabe
% beginnt eine neue Teilteilaufgabe
%--------------------------

% -------------------------------
% Lehrveranstaltungsinformationen
% -------------------------------
% Um Lehrveranstaltungsinformationen, die sich von Blatt zu Blatt derselben
% Lehrveranstaltung nicht verändern, nicht in jede Datei eintragen zu müssen
% Es wird automatisch versucht, die Datei "lv.tex" zu laden, die Angaben zur
% Lehrveranstaltung enthalten kann (Name der LV, Namen der Gruppenmitglieder usw.)
% Die Datei wird zuerst im aktuellen Verzeichnis gesucht. Wird sie dort nicht
% gefunden, wird sie im uebergeordneten Verzeichnis gesucht. Danach wird die
% Suche abgebrochen.
%--------------------------

%--------------------------
% \lvname{<lvname>}
% Setzt den Lehrveranstaltungsnamen auf <lname>.
% Der LV-Name erscheint links oben im Header so wie er hier definiert wird.
% Zum Zeilenumbruch wird \\ verwendet.
% Default: {}
%--------------------------

%--------------------------
% \blatttitel{<titel>}
% Setzt den Blatttitel auf <titel>.
% Zum Zeilenumbruch wird \\ verwendet.
% Der Titel wird im Kopf und bei Beginn des Übungsblatts verwendet.
% Optional kann im Text '\ifinhead{<danntext>}{<sonsttext>}' eingefügt werden,
% was <danntext> lediglich im Kopf an der Stelle erzeugt, ansonsten wird der <sonsttext> erzeugt
% Default: Bearbeitung des \theblatt.~Übungsblatts\ifinhead{\\}{}
%--------------------------

%--------------------------
% \blattnummer{<nummer>}
% Setzt den Wert des Zählers blatt auf <nummer>.
%--------------------------

%--------------------------
% \ifinhead{<danntext>}{<sonsttext>}
% <danntext> im inhead-Modus; <sonsttext> sonst
%--------------------------

%--------------------------
% \autoren{<autoren>}
% Setzt die Namen der Autoren auf <autoren>.
% Die Autoren erscheinen rechts oben im Header so wie sie hier definiert werden.
% Default: {}
%--------------------------

%--------------------------
% \aufgabelabel{<labelmuster>}
% Setzt das Label der Aufgaben auf <labelmuster>.
% <labelmuster> ist ein Muster wie definiert im Paket counterlabelpattern.
%--------------------------

% -----------------
% definierte Zähler
% -----------------
% uebungsblatt : Nummer des Übungsblatts
%                Die Nummer wird automatisch bestimmt aus dem Dateinamen der Hauptdatei.
%                Dazu muss der Dateiname mit der Blattnummer beginnen.
%                (Vorsicht bei Leerzeichen: Der Dateiname könnte mit Anführungszeichen beginnen.)
% aufgabe      : Nummer der aktuellen Aufgabe
% teilaufgabe  : Nummer der aktuellen Teilaufgabe
%                (\theteilaufgabe liefert die korrekte Darstellung)

%=====================================================================================================================================

% Initialisierungsteil
\RequirePackage{ifthen}
\newboolean{aufgeqno}

\AtBeginDocument{%
    \chead{\@inhead{\textbf{\@blatttitel}}}%
    \addtocounter{aufgabe}{-1}% Aufgabennummer zurücksetzen
    \vspace*{-\baselineskip}%
    \par%
    \hspace*\fill\begin{Large}\textbf{\@blatttitel}\end{Large}\hspace*\fill%
    \ifset{\@blattuntertitel}{%
    	\\[.5\baselineskip]%
         \hspace*\fill\begin{large}\textbf{\@blattuntertitel}\end{large}\hspace*\fill%
    }%
    \par%
}

\AtEndDocument{%
    \label{lastpage}%
}

% Deklaration von Optionen
\DeclareOption {aufgeqno} {\setboolean{aufgeqno}{true}}%
\DeclareOption {10pt}     {\PassOptionsToClass{10pt}{akktecdoc}}%
\DeclareOption {11pt}     {\PassOptionsToClass{11pt}{akktecdoc}}%
\DeclareOption {12pt}     {\PassOptionsToClass{12pt}{akktecdoc}}%

% Ausfuehrung von Optionen
\ProcessOptions

% Laden von Paketen
\LoadClass[widepage,longpage]{akktecdoc}
\RequirePackage{akkgerman}
\RequirePackage{uebungsblatt}
\ifthenelse{\boolean{aufgeqno}} {%
    \RequirePackage{amsmath}%
    \numberwithin{equation}{aufgabe}% Nummerierung der Gleichungen: (<Nr. der Aufgabe>.<Nr. der Gleichung>)%
}{}

% -----------------
% Initialisierungen
% -----------------

% Seiteneinstellungen
\pagestyle{fancy}
\setlength \headheight {3\baselineskip}  % max. Anzahl der Zeilen im Header: 3
\setlength \headsep {\baselineskip}      % Abstand zum Text
\cfoot{\thepage/\pageref{lastpage}}      % im Footer: Seitenzahl

% Defaultwerte
\blatttitel{Bearbeitung des \theblatt.~Übungsblatts\ifinhead{\\}{}}
\aufgabelabel{{Aufgabe }1}

% Bestimmen der Übungsblatt-Nummer
\extractnumber \jobname {blatt}
\typeout{[uebungsblatt] Dateiname: \jobname}
\typeout{[uebungsblatt] Uebungsblattnummer: \theblatt}

% Laden der Datei lv.tex
\typeout{[uebungsblatt] Suche Datei 'lv.tex'}
\InputIfFileExists {lv.tex} {
    \typeout{[uebungsblatt] Datei 'lv.tex' in aktuellem Verzeichnis gefunden. Datei wird geladen.}
}
{
    \InputIfFileExists {../lv.tex} {
        \typeout{[uebungsblatt] Datei 'lv.tex' in übergeordnetem Verzeichnis gefunden. Datei wird geladen.}
    }
    {
        \typeout{[uebungsblatt] Datei 'lv.tex' nicht gefunden.}
    }
}
