%%
%% This is file `scrlettr.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% scrlettr.dtx  (with options: `scrlettr')
%% scrlogo.dtx  (with options: `logo')
%% 
%% Copyright (c) 1994-2012
%% Markus Kohm and any individual authors listed elsewhere in this file.
%% 
%% This file was generated from file(s) of the KOMA-Script bundle.
%% ---------------------------------------------------------------
%% 
%% It may be distributed under the conditions of the
%% LaTeX Project Public License in the version distributed together
%% with KOMA-Script, see file `lppl.txt' or `lppl-de.txt'.
%% 
%% This file may only be distributed together with a copy of the
%% KOMA-Script bundle.  You may however distribute the
%% KOMA-Script bundle without all such generated files.  See also
%% `lppl.txt' or `lppl-de.txt' for additional information.
%% 
%% The list of files belonging to KOMA-Script distribution is given in
%% the file `manifest.txt'.  See also `lppl.txt' or `lppl-de.txt' for
%% additional information.
%% 
%% If this file is a beta version, you may not be allowed to distribute
%% it.  Look at the comments below to see if this is the case.
%% 
%% English and German manuals are part of KOMA-Script bundle.
%% ----------------------------------------------------------
%% 
%% See `README'.
%% 
%% The KOMA-Script bundle (but maybe not this file) was based upon the
%% LaTeX 2.09 Script family created by Frank Neukam 1993 and the LaTeX2e
%% standard classes created by The LaTeX3 Project 1994-1996.  You may
%% find a complete unmodified copy of LaTeX2e at
%% <http://www.ctan.org/pub/tex-archive/macros/latex/base/>.
%% 
%%% From: scrlettr.dtx
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{scrlettr}
              [2002/05/24 v2.6e
               OBSOLETE
               LaTeX2e KOMA
               document class]
\ClassWarningNoLine{scrlettr}{%
  THIS CLASS IS OBSOLETE AND NOT LONGER SUPPORTED!\MessageBreak
  Since the new KOMA-Script letter class ``scrlttr2'' was\MessageBreak
  released, the use of ``scrlettr'' is obsolete.\MessageBreak
  You should not use this class for writing new letters.\MessageBreak
  You should use ``scrlttr2''.\MessageBreak
  All old commands of ``scrlettr'' are supported at\MessageBreak
  the new class ``scrlttr2''. But the length are not\MessageBreak
  and the typearea was changed - even using the\MessageBreak
  compatiblity option ``KOMAold''. So you may have\MessageBreak
  to do some changes}
\newcommand*\@ptsize{}
\newif\if@bigloc
\newif\if@orgdate
\DeclareOption{10pt}{\renewcommand*\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand*\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand*\@ptsize{2}}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue \@mparswitchtrue%
    \ClassWarningNoLine{scrlettr}{This is no twoside-layout but openright!}
}
\DeclareOption{draft}{\overfullrule 5pt}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{a4paper}{
  \setlength{\paperwidth}{210mm}
  \setlength{\paperheight}{297mm}}
\DeclareOption{wlocfield}{\@bigloctrue}
\DeclareOption{slocfield}{\@biglocfalse}
\DeclareOption{orgdate}{\@orgdatetrue}
\DeclareOption{scrdate}{\@orgdatefalse}
\ExecuteOptions{12pt,oneside,final,slocfield,a4paper}
\ProcessOptions
\input{size1\@ptsize.clo}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareOldFontCommand{\sfb}{\normalfont\sffamily\bfseries}{\@nomath\sfb}
\newcommand*\descfont{\sffamily\bfseries}
\newcommand*\sectfont{\sffamily\bfseries}
\newcommand*\pnumfont{\normalfont}
\newcommand*\headfont{\slshape}
\newcommand*\capfont{\normalfont}
\newcommand*\caplabelfont{\normalfont}
\AtBeginDocument{
 \def\captionsenglish{%
  \def\yourrefname{Your ref.}
  \def\yourmailname{Your letter of}
  \def\myrefname{Our ref.}
  \def\customername{Customer no.}
  \def\invoicename{Invoice no.}
  \def\subjectname{Subject}
  \def\ccname{cc}
  \def\enclname{encl}
  \def\headtoname{To}
  \def\datename{Date}
  \def\pagename{Page}}
 \let\captionsUSenglish=\captionsenglish
 \let\captionsamerican=\captionsUSenglish
 \let\captionsbritish=\captionsenglish
 \let\captionsUKenglish=\captionsenglish
 \def\captionsgerman{%
  \def\yourrefname{Ihr Zeichen}
  \def\yourmailname{Ihr Schreiben vom}
  \def\myrefname{Unser Zeichen}
  \def\customername{Kundennummer}
  \def\invoicename{Rechnungsnummer}
  \def\subjectname{Betr.}
  \def\ccname{Kopien an}
  \def\enclname{Anlagen}
  \def\headtoname{An}
  \def\datename{Datum}
  \def\pagename{Seite}}
 \let\captionsaustrian=\captionsgerman
 \let\captionsngerman=\captionsgerman
 \def\captionsfrench{%
  \def\yourrefname{Vos r\'ef\'erences}
  \def\yourmailname{Votre lettre du}
  \def\myrefname{Nos r\'ef\'erences}
  \def\customername{Num\'ero de client}
  \def\invoicename{Num\'ero de facture}
  \def\subjectname{Concernant}
  \def\ccname{Copie \`a}
  \def\enclname{Annexes}
  \def\headtoname{A}
  \def\datename{Date}
  \def\pagename{Page}}
 \def\captionsitalian{%
  \def\yourrefname{Vs./Rif.}
  \def\yourmailname{Vs.~lettera del}
  \def\myrefname{Ns./Rif.}
  \def\customername{Nr.~cliente}
  \def\invoicename{Nr.~fattura}
  \def\subjectname{Oggetto}
  \def\ccname{Per conoscenza}
  \def\enclname{Allegato}
  \def\headtoname{A}
  \def\datename{Data}
  \def\pagename{Pagina}}
 \def\captionsspanish{%
  \def\yourrefname{Su ref.}
   \def\yourmailname{Su carta de}
   \def\myrefname{Nuestra ref.}
   \def\customername{No. de cliente}
   \def\invoicename{No. de factura}
   \def\subjectname{Asunto}
   \def\ccname{Copias}
   \def\enclname{Adjunto}
   \def\headtoname{A}
   \def\datename{Fecha}
   \def\pagename{P\'agina}}
 \if@orgdate
  \ifx\dateenglish\undefined
   \def\dateenglish{\def\today{\number\day/\number\month/\number\year}}
  \fi
 \else
  \def\dateenglish{\def\today{\number\day/\number\month/\number\year}}
  \def\dateUSenglish{\def\today{\number\month/\number\day/\number\year}}
  \let\datebritish=\dateenglish
  \let\dateUKenglish=\dateenglish
  \let\dateamerican=\dateUSenglish
  \def\dategerman{\def\today{\number\day.\,\number\month.\,\number\year}}
  \let\dateaustrian=\dategerman
  \let\datengerman=\dategerman
  \let\datefrench=\dategerman
  \let\dateitalian=\dategerman
  \let\datespanish=\dategerman
 \fi
 \captionsenglish
 \dateenglish
 \ifx\languagename\undefined
  \ClassWarningNoLine{scrlettr}{\string\languagename\space not
    defined, using \string\language.\MessageBreak
    This may result in use of wrong language!\MessageBreak
    You should use a compatible language
    package\MessageBreak
    (e.g. `Babel', `german', `french', ...)}
  \ifx\l@american\undefined\else\ifnum\language=\l@american
  \captionsamerican
  \dateamerican
  \fi\fi
  \ifx\l@british\undefined\else\ifnum\language=\l@british
  \captionsbritish
  \datebritish
  \fi\fi
  \ifx\l@UKenglish\undefined\else\ifnum\language=\l@UKenglish
  \captionsUKenglish
  \dateUKenglish
  \fi\fi
  \ifx\l@USenglish\undefined\else\ifnum\language=\l@USenglish
  \captionsUSenglish
  \dateUSenglish
  \fi\fi
  \ifx\l@austrian\undefined\else\ifnum\language=\l@austrian
  \captionsaustrian
  \dateaustrian
  \fi\fi
  \ifx\l@german\undefined\else\ifnum\language=\l@german
  \captionsgerman
  \dategerman
  \fi\fi
  \ifx\l@ngerman\undefined\else\ifnum\language=\l@ngerman
  \captionsngerman
  \datengerman
  \fi\fi
  \ifx\l@french\undefined\else\ifnum\language=\l@french
  \captionsfrench
  \datefrench
  \fi\fi
  \ifx\l@italian\undefined\else\ifnum\language=\l@italian
  \captionsitalian
  \dateitalian
  \fi\fi
  \ifx\l@spanish\undefined\else\ifnum\language=\l@spanish
  \captionsspanish
  \datespanish
  \fi\fi
 \else
   \edef\@tempa{nohyphenation}
   \ifx\languagename\@tempa
     \ClassWarningNoLine{scrlettr}
       {You've selected language ``\languagename''.\MessageBreak
        Maybe your LaTeX format contains Babel extension\MessageBreak
        but you have not selected a language using\MessageBreak
        Babel package.\MessageBreak
        Please select another language!\MessageBreak
        Only as a workaround english captions and date\MessageBreak
        will be used}
   \else
     \expandafter\selectlanguage\expandafter{\languagename}
     \ClassInfo{scrlettr}{used language is \languagename}
   \fi
 \fi
}
\oddsidemargin  0in
\evensidemargin 0in
\marginparwidth 0.9in
\marginparsep   0.1in
\marginparpush  0.45\baselineskip
\topmargin      -19mm % mk 941012, was: -15.5mm
\headheight     23mm  % mk 950411, was: 22mm
\headsep        8mm   % mk 941012, was: 9mm
\footskip       20mm  % mk 941012, was: 30mm
\textheight     226mm % mk 950411, was: 217mm
\textwidth      159.2mm

\parskip        0.5\baselineskip % mk 941012
\parindent      0pt
\smallskipamount=0.5\parskip
\medskipamount  =\parskip
\bigskipamount  =2\parskip
\footnotesep    0.8\baselineskip
\skip\footins   0.75\baselineskip plus 2pt minus 4pt
\skip\@mpfootins =\skip\footins
\columnsep      1cc
\columnseprule  0pt
\floatsep       1\baselineskip plus 2pt minus 2pt
\textfloatsep   20pt plus 2pt minus 4pt
\intextsep      1\baselineskip plus 2pt minus 2pt
\dblfloatsep    1\baselineskip plus 2pt minus 2pt
\dbltextfloatsep 20pt plus 2pt minus 4pt
\@fptop 0pt plus 1fil
\@fpsep 0.7\baselineskip plus 2fil
\@fpbot 0pt plus 1fil
\@dblfptop 0pt plus 1fil
\@dblfpsep 0.7\baselineskip plus 2fil
\@dblfpbot 0pt plus 1fil
\arraycolsep    5pt
\tabcolsep      6pt
\arrayrulewidth 0.4pt
\doublerulesep  2pt
\fboxsep        3pt
\fboxrule       0.4pt
\tabbingsep \labelsep
\topsep         0.25\baselineskip
\partopsep      0pt
\itemsep        0.25\baselineskip
\parsep         0.25\baselineskip % ak: 1\baselineskip
\labelsep       .5em
\leftmargini    2.5em
\leftmarginii   2.2em
\leftmarginiii  1.87em
\leftmarginiv   1.7em
\leftmarginv    1em
\leftmarginvi   1em
\leftmargin\leftmargini
\labelwidth\leftmargini
\advance\labelwidth-\labelsep
\def\@listI{\leftmargin\leftmargini}
\let\@listi\@listI
\def\@listii{\leftmargin\leftmarginii
 \labelwidth\leftmarginii\advance\labelwidth-\labelsep}
\def\@listiii{\leftmargin\leftmarginiii
 \labelwidth\leftmarginiii\advance\labelwidth-\labelsep}
\def\@listiv{\leftmargin\leftmarginiv
 \labelwidth\leftmarginiv\advance\labelwidth-\labelsep}
\def\@listv{\leftmargin\leftmarginv
 \labelwidth\leftmarginv\advance\labelwidth-\labelsep}
\def\@listvi{\leftmargin\leftmarginvi
 \labelwidth\leftmarginvi\advance\labelwidth-\labelsep}
\@listi

\@lowpenalty    51
\@medpenalty    151
\@highpenalty   301
\@beginparpenalty -\@lowpenalty
\@endparpenalty -\@lowpenalty
\@itempenalty   -\@lowpenalty

\def\theenumi{\arabic{enumi}}
\def\theenumii{\alph{enumii}}
\def\theenumiii{\roman{enumiii}}
\def\theenumiv{\Alph{enumiv}}
\def\labelenumi{\theenumi.}
\def\labelenumii{\theenumii)}
\def\labelenumiii{\theenumiii.}
\def\labelenumiv{\theenumiv.}
\def\p@enumii{\theenumi}
\def\p@enumiii{\theenumi\theenumii)}
\def\p@enumiv{\p@enumiii\theenumiii}
\def\labelitemi{$\bullet$}
\def\labelitemii{\bf --}
\def\labelitemiii{$\triangleright$}
\def\labelitemiv{$\cdot$}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand\descriptionlabel[1]{\hspace\labelsep
                                \descfont #1}
\newenvironment{labeling}[2][]
  {\def\sc@septext{#1}
    \list{}{\settowidth{\labelwidth}{#2#1}
            \leftmargin\labelwidth \advance\leftmargin by \labelsep
            \let\makelabel\labelinglabel}}
  {\endlist}
\newcommand\labelinglabel[1]{#1\hfil\sc@septext}
\newenvironment{verse}
               {\let\\=\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item[]}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item[]}
               {\endlist}
\def\fromname{}
\def\frombranch{}                       % RTL 21.04.94
\def\fromsig{\fromname}
\def\fromaddress{}
\def\fromplace{}
\def\fromlocation{}
\def\frombackaddress{}
\def\telephonenum{}
\def\varyourref{}
\def\varyourmail{}
\def\varmyref{}
\def\varcustomer{}
\def\varinvoice{}
\def\varrefitemi{}
\def\varrefitemii{}
\def\varrefitemiii{}
\def\varrefitemnamei{}
\def\varrefitemnameii{}
\def\varrefitemnameiii{}
\def\@specialmail{}
\def\@title{}
\def\@subject{}
\def\name#1     {\def\fromname{#1}}
\def\branch#1   {\def\frombranch{#1}}              % RTL 21.04.94
\def\signature#1{\def\fromsig{#1}}
\long\def\address#1{\def\fromaddress{#1}}
\def\place#1    {\def\fromplace{#1}}
\long\def\location#1{\def\fromlocation{#1}}
\def\backaddress#1{\def\frombackaddress{#1}}
\def\telephone#1{\def\telephonenum{#1}}
\def\yourref#1  {\def\varyourref{#1}}
\def\yourmail#1 {\def\varyourmail{#1}}
\def\myref#1    {\def\varmyref{#1}}
\def\customer#1 {\def\varcustomer{#1}}
\def\invoice#1  {\def\varinvoice{#1}}
\def\refitemi#1 {\def\varrefitemi{#1}}
\def\refitemii#1{\def\varrefitemii{#1}}
\def\refitemiii#1{\def\varrefitemiii{#1}}
\def\refitemnamei#1{\def\varrefitemnamei{#1}}
\def\refitemnameii#1{\def\varrefitemnameii{#1}}
\def\refitemnameiii#1{\def\varrefitemnameiii{#1}}
\def\specialmail#1{\def\@specialmail{#1}}
\def\title#1    {\def\@title{#1}}
\def\subject#1  {\def\@subject{{\bf #1}}}
\long\def\firsthead#1{\def\@firsthead{#1}}
\long\def\firstfoot#1{\def\@firstfoot{#1}}
\long\def\nexthead#1{\def\@nexthead{#1}}
\long\def\nextfoot#1{\def\@nextfoot{#1}}
\newif\if@fold
\newif\if@afield
\newif\if@subj
\newif\if@subjafter
\def\foldmarkson        {\@foldtrue}
\def\foldmarksoff       {\@foldfalse}
\def\addrfieldon        {\@afieldtrue}
\def\addrfieldoff       {\@afieldfalse}
\def\subjecton          {\@subjtrue}
\def\subjectoff         {\@subjfalse}
\newcommand*\subjectafteron {\@subjaftertrue}
\newcommand*\subjectafteroff{\@subjafterfalse}
\newdimen\sc@temp
\newdimen\sc@@temp
\newdimen\foldhskip
\newdimen\foldvskipi
\newdimen\foldvskipii
\newdimen\foldvskipiii
\newdimen\addrvskip
\newdimen\addrindent
\newdimen\addrwidth
\newdimen\addrheight
\newdimen\locwidth
\newdimen\refvskip
\newdimen\sigindent
\foldhskip      3.5mm
\foldvskipi     62mm    % war: 65mm RTL
\foldvskipii    45mm    % mk 960531 (war: 40.5mm)
\foldvskipiii   54mm    % mk 960531 (war: 58.5mm)
\addrvskip      7.5mm
\addrindent     0mm
\addrwidth      70mm
\addrheight     35mm
\locwidth\textwidth
\advance\locwidth by -\addrwidth
\if@bigloc                           % mk 940330
    \advance\locwidth by \locwidth
    \divide\locwidth by 3
\else
    \divide\locwidth by 2
\fi
\refvskip       5.5mm
\sigindent      0mm
\def\adrentry#1#2#3#4#5#6#7#8{\def\@tempa{#1}\ifx \@tempa\@empty \else
 \def\@tempa{#2}\ifx \@tempa\@empty
  \expandafter\def\csname #8\endcsname{#1\\#3}
 \else
  \expandafter\def\csname #8\endcsname{#2 #1\\#3}
 \fi \fi}
\def\adrchar#1{}
\long\def\letter#1{\newpage
 \if@twoside\ifodd\c@page\else \thispagestyle{empty}\null\newpage \fi\fi
 \c@page\@ne \interlinepenalty=200 \@processto{#1}}
\def\stopletter{}
\def\endletter{\stopletter\@@par\pagebreak\@@par}
\long\def\@processto#1{\expandafter\@xproc #1\\@@@\ifx\toaddress\@empty
 \else\expandafter\@yproc #1@@@\fi}
\long\def\@xproc #1\\#2@@@{\def\toname{#1}\def\toaddress{#2}}
\long\def\@yproc #1\\#2@@@{\def\toaddress{#2}}
\def\stopbreaks{\interlinepenalty \@M
 \def\par{\@@par\nobreak}\let\\=\@nobreakcr
 \let\vspace\@nobreakvspace}
\def\@nobreakvspace{\@ifstar{\@nobreakvspacex}{\@nobreakvspacex}}
\def\@nobreakvspacex#1{\ifvmode\nobreak\vskip #1\relax\else
 \@bsphack\vadjust{\nobreak\vskip #1}\@esphack\fi}
\def\@nobreakcr{\vadjust{\penalty\@M}\@ifstar{\@xnewline}{\@xnewline}}
\def\startbreaks{\let\\=\@normalcr
 \interlinepenalty 200\def\par{\@@par\penalty 200}}
\def\@foldmarks{\if@fold \bgroup
 \reversemarginpar\vspace{\foldvskipi}
 \marginpar{\hspace{\foldhskip}\rule{2mm}{.2pt}} \vspace{\foldvskipii}
 \marginpar{\hspace{\foldhskip}\rule{4mm}{.2pt}} \vspace{\foldvskipiii}
 \marginpar{\hspace{\foldhskip}\rule{2mm}{.2pt}}
 \vspace{-\foldvskipiii}\vspace{-\foldvskipii}\vspace{-\foldvskipi}
 \egroup \fi}
\def\@addrfield{\bgroup
 \setbox0\vbox{\hsize\addrwidth
  \ifx\frombackaddress\@empty \else
  \underline{\scriptsize \sf \frombackaddress} \fi}
 \setbox1\vbox{\hsize\addrwidth
  \ifx\@specialmail\@empty \else
   \underline{\@specialmail} \fi}
 \setbox2\vbox{\hsize\addrwidth
  \toname \\ \toaddress}
 \vskip\addrvskip \hskip\addrindent
 \vbox to \addrheight{%
  \ifx\frombackaddress\@empty \else \box0 \fi
  \ifx\@specialmail\@empty \else \vfil\box1 \fi
  \vfil\box2\vfil}\egroup}
\def\@locfield{\begin{minipage}[b]{\locwidth}\fromlocation\end{minipage}}
\newif\if@ref
\def\@datefield{\@reffalse
 \ifx\varyourref\@empty \else \@reftrue \fi
 \ifx\varyourmail\@empty \else \@reftrue \fi
 \ifx\varmyref\@empty \else \@reftrue \fi
 \ifx\varcustomer\@empty \else \@reftrue \fi
 \ifx\varinvoice\@empty \else \@reftrue \fi
 \ifx\varrefitemi\@empty \else \@reftrue \fi
 \ifx\varrefitemii\@empty \else \@reftrue \fi
 \ifx\varrefitemiii\@empty \else \@reftrue \fi
 \vskip -\parskip
 \vskip \refvskip
 \if@ref
  \ifx\varyourref\@empty \else
   \settowidth{\sc@temp}{\varyourref}
   \setbox0\hbox{\scriptsize \sf \yourrefname}
   \ifdim \sc@temp > \wd0 \sc@@temp\sc@temp \else \sc@@temp\wd0 \fi
   \parbox[t]{\sc@@temp}{\noindent \box0\par \varyourref}\hfill
  \fi
  \ifx\varyourmail\@empty \else
   \settowidth{\sc@temp}{\varyourmail}
   \setbox0\hbox{\scriptsize \sf \yourmailname}
   \ifdim \sc@temp > \wd0 \sc@@temp\sc@temp \else \sc@@temp\wd0 \fi
   \parbox[t]{\sc@@temp}{\noindent \box0\par \varyourmail}\hfill
  \fi
  \ifx\varmyref\@empty \else
   \settowidth{\sc@temp}{\varmyref}
   \setbox0\hbox{\scriptsize \sf \myrefname}
   \ifdim \sc@temp > \wd0 \sc@@temp\sc@temp \else \sc@@temp\wd0 \fi
   \parbox[t]{\sc@@temp}{\noindent \box0\par \varmyref}\hfill
  \fi
  \ifx\varcustomer\@empty \else
   \settowidth{\sc@temp}{\varcustomer}
   \setbox0\hbox{\scriptsize \sf \customername}
   \ifdim \sc@temp > \wd0 \sc@@temp\sc@temp \else \sc@@temp\wd0 \fi
   \parbox[t]{\sc@@temp}{\noindent \box0\par \varcustomer}\hfill
  \fi
  \ifx\varinvoice\@empty \else
   \settowidth{\sc@temp}{\varinvoice}
   \setbox0\hbox{\scriptsize \sf \invoicename}
   \ifdim \sc@temp > \wd0 \sc@@temp\sc@temp \else \sc@@temp\wd0 \fi
   \parbox[t]{\sc@@temp}{\noindent \box0\par \varinvoice}\hfill
  \fi
  \ifx\varrefitemi\@empty \else
   \settowidth{\sc@temp}{\varrefitemi}
   \setbox0\hbox{\scriptsize \sf \varrefitemnamei}
   \ifdim \sc@temp > \wd0 \sc@@temp\sc@temp \else \sc@@temp\wd0 \fi
   \parbox[t]{\sc@@temp}{\noindent \box0\par \varrefitemi}\hfill
  \fi
  \ifx\varrefitemii\@empty \else
   \settowidth{\sc@temp}{\varrefitemii}
   \setbox0\hbox{\scriptsize \sf \varrefitemnameii}
   \ifdim \sc@temp > \wd0 \sc@@temp\sc@temp \else \sc@@temp\wd0 \fi
   \parbox[t]{\sc@@temp}{\noindent \box0\par \varrefitemii}\hfill
  \fi
  \ifx\varrefitemiii\@empty \else
   \settowidth{\sc@temp}{\varrefitemiii}
   \setbox0\hbox{\scriptsize \sf \varrefitemnameiii}
   \ifdim \sc@temp > \wd0 \sc@@temp\sc@temp \else \sc@@temp\wd0 \fi
   \parbox[t]{\sc@@temp}{\noindent \box0\par \varrefitemiii}\hfill
  \fi
  \ifx\@date\@empty \else
   \settowidth{\sc@temp}{\@date}
   \setbox0\hbox{\scriptsize \sf \datename}
   \ifdim \sc@temp > \wd0 \sc@@temp\sc@temp \else \sc@@temp\wd0 \fi
   \parbox[t]{\sc@@temp}{\noindent \box0\par \@date}
  \fi
  \par
  \vspace{2.5\baselineskip}
 \else
  {\ifx\@date\@empty \else \raggedleft\fromplace\ \@date\par \fi}
  \vspace{1.5\baselineskip}
 \fi}
\def\maketitle{\ifx\@title\@empty \else
 {\centering \LARGE \sectfont \@title\par}
 \vspace{1\baselineskip} \fi}
\def\@subjfield{{%
 \if@subjafter%
  \centering%
 \else%
  \if@subj\ifx\@subject\@empty\else\subjectname:\ \fi\fi
  \@subject\par\nobreak\vspace{1\baselineskip}%
 \fi}}
\def\opening#1{\thispagestyle{firstpage} \null \@foldmarks
 \if@afield \@addrfield \hfill \@locfield \par \fi
 \@datefield
 \maketitle
 \if@subjafter\else\@subjfield\fi
 #1\par%
 \vspace{0.5\baselineskip}% added by unknown
 \nobreak%
 \if@subjafter\@subjfield\fi}
\newcommand*\presig@skip{}
\newcommand*{\setpresigskip}[1]{%
  \begingroup%
    \setlength{\@tempdima}{#1}%
  \endgroup%
  \edef\presig@skip{#1}}
\setpresigskip{2\baselineskip}
\long\def\closing#1{\par\nobreak\vspace{0.5\baselineskip}
 \stopbreaks \noindent \sc@temp\textwidth \advance\sc@temp by
 -\sigindent \hspace{\sigindent}%
 \parbox{\sc@temp}{\raggedright\ignorespaces #1\mbox{}\\[\presig@skip]
 \fromsig\strut}\par
 \vspace{1.5\baselineskip}}
\def\ps{\par\startbreaks}
\newcommand*{\ccnameseparator}{: }
\newcommand*{\cc}[1]{\par\noindent\parbox[t]{\textwidth}
 {\@hangfrom{\ccname\ccnameseparator}%
 \ignorespaces #1\strut}\par}
\newcommand*{\enclnameseparator}{: }
\newcommand*{\encl}[1]{\par\noindent%
 \parbox[t]{\textwidth}{%
  \ifx\enclname\@empty\else\@hangfrom{\enclname\enclnameseparator}\fi%
  \ignorespaces #1\strut}\par}
\def\footnoterule{\kern-1\p@
 \hrule width 0.4\columnwidth
 \kern .6\p@}
\newcommand\deffootnote[4][]{%
  \long\def\@makefntext##1{%
    \edef\@tempa{#1}\ifx\@tempa\@empty
      \@setpar{\@@par
        \@tempdima = \hsize
        \addtolength{\@tempdima}{-#2}
        \parshape \@ne #2 \@tempdima}%
    \else
      \@setpar{\@@par
        \@tempdima = \hsize
        \addtolength{\@tempdima}{-#1}
        \@tempdimb = \hsize
        \addtolength{\@tempdimb}{-#2}
        \parshape \tw@ #1 \@tempdima #2 \@tempdimb}%
    \fi
    \par
    \parindent #3\noindent
    \hbox to \z@{\hss\@@makefnmark}##1}
  \def\@@makefnmark{\hbox{#4}}
}
\newcommand*\deffootnotemark[1]{\def\@makefnmark{\hbox{#1}}}
\def\thefootnotemark{\@thefnmark}
\let\textsuperscript\@textsuperscript
\deffootnote[1em]{1.5em}{1em}
  {\textsuperscript{\thefootnotemark}}
\deffootnotemark{\textsuperscript{\thefootnotemark}}
\def\theequation{\arabic{equation}}
\setcounter{topnumber}{2}
\def\topfraction{.7}
\setcounter{bottomnumber}{1}
\def\bottomfraction{.3}
\setcounter{totalnumber}{3}
\def\textfraction{.2}
\def\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.5}
\def\@firsthead{%
  \parbox[b]{\textwidth}
    {\begin{center}
       \ifx\fromname\@empty\else
         \textsc{\ignorespaces\fromname}\\[-8pt]
         \rule{\textwidth}{.4pt}\\
       \fi
       \ifx\fromaddress\@empty\else
         \ignorespaces\fromaddress
       \fi
     \end{center}}}
\def\@firstfoot{}
\def\@nexthead{%
  \parbox[b]{\textwidth}
  {\ifx\fromname\@empty\else
     \textsc{\ignorespaces\fromname}\\[8pt]
   \fi
   \headtoname\ \ignorespaces\toname\hfill\datename:\ \@date\hfill
   \pagename\ \thepage\\[-8pt]
   \rule{\textwidth}{.4pt}}}
\def\@nextfoot{}

\def\ps@plain{%
  \def\@evenhead{\sffamily\bfseries\fontsize{10pt}{12}\selectfont
  \hfil-- \thepage\ --\hfil}%
 \let\@oddhead\@evenhead%
 \def\@evenfoot{}%
 \def\@oddfoot{}}
\def\ps@firstpage{%
 \def\@evenhead{\@firsthead}%
 \let\@oddhead\@evenhead%
 \def\@evenfoot{\@firstfoot}%
 \let\@oddfoot\@evenfoot}
\def\ps@headings{%
 \def\@evenhead{\@nexthead}%
 \let\@oddhead\@evenhead%
 \def\@evenfoot{\@nextfoot}%
 \let\@oddfoot\@evenfoot}
\@foldtrue
\@afieldtrue
\@subjfalse
\@subjafterfalse
\ps@plain
\pagenumbering{arabic}
\raggedbottom
\frenchspacing
%%% From File: scrlogo.dtx
\@ifundefined{KOMAScript}{%
  \DeclareRobustCommand{\KOMAScript}{\textsf{K\kern.05em O\kern.05em%
      M\kern.05em A\kern.1em-\kern.1em Script}}}{}
\endinput
%%
%% End of file `scrlettr.cls'.
