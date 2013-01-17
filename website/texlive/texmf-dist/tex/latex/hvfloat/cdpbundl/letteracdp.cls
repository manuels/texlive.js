%%
%% This is file `letteracdp.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cdpbundl.dtx  (with options: `letter')
%% 
%% This is a generated file.
%% It is part of a work named "C.D.P. Bundle".
%% 
%% Copyright (C) 1999-2006 by Gustavo MEZZETTI <mezzetti@math.unipd.it>.
%% 
%% The C.D.P. Bundle may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%% 
%% The C.D.P. Bundle has the LPPL maintenance status
%%   "author-maintained".
%% 
%% The file `manifest.txt' that comes along with this file specifies
%% what the C.D.P. Bundle consists of; more precisely, it explains how
%% the locutions "Work" and "Compiled Work", used in the LaTeX Project
%% Public License, are to be interpreted in the case of this work.
%% 
%% Note that the distribution of this file alone is "distribution of
%% only part of the Work" in the sense of the LaTeX Project Public
%% License, and is not allowed.
%% 
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}[1997/06/01] % LaTeX2e is required!
\ProvidesClass{letteracdp}
              [2006/01/01 v0.34 (**incomplete**)]
\typeout{Copyright (C) 1999-2006 by Gustavo MEZZETTI,
  all rights reserved.}
\@ifdefinable\@letteracdp{\def\@letteracdp{letteracdp}}
\newcommand*\Coordinamento{%
  Coordinamento dei Dottorandi e dei Dottori di Ricerca
  dell'Universit\`a di Padova%
}
\newcommand*\CoordinamentoWWW{%
  http://www.dei.unipd.it/\string~assdott/%
}
\DeclareFixedFont\@lh@nss{OT1}{cmss}{m}{n} {12}
\DeclareFixedFont\@lh@bss{OT1}{cmss}{m}{n} {17}
\DeclareFixedFont\@lh@rm {OT1}{cmr} {m}{n} {9}
\DeclareFixedFont\@lh@it {OT1}{cmr} {m}{it}{9}
\DeclareFixedFont\@lh@tt {OT1}{cmtt}{m}{n} {9}
\newcommand\@ptsize{}
%% A couple of useful things that are missing from the LaTeX kernel:
\@ifdefinable\@newrigidlength{\def\@newrigidlength#1{%
  \@ifdefinable#1{\newdimen#1}%
}}
\@ifdefinable\@msetlength{\def\@msetlength#1#2#3{%
  #1#3\multiply#1#2\relax
}}
\newcounter{letter}
\newcounter{emptyaddrlabels}
\newcounter{addrlabelrows}
\newcounter{addrlabelcolumns}
\newcounter{label}[letter]
\newcounter{totallabel}
\@addtoreset{equation}{letter}
\@addtoreset{footnote}{letter}
\@addtoreset{mpfootnote}{letter}
\@newrigidlength\@lh@left@margin
\@newrigidlength\@lh@right@margin
\@newrigidlength\@block@inden
\@newrigidlength\@block@width
\@newrigidlength\longindentation
\@newrigidlength\senderindentation
\@newrigidlength\senderwidth
\@newrigidlength\addresseeindentation
\@newrigidlength\addresseewidth
\@newrigidlength\signatureindentation
\@newrigidlength\signaturewidth
\@newrigidlength\foldedheight
  \setlength\foldedheight{-\maxdimen}
\@newrigidlength\@folding@ht
\@newrigidlength\@lh@folding@ht
\@newrigidlength\@above@folding@margin
\@newrigidlength\@above@folding@shrink
\newlength\@block@space
\newlength\@block@andspace
\newlength\@below@folding@skip
\newlength\aboveaddressvspace
\newlength\andaddressvspace
\newlength\belowaddressvspace
\newlength\abovesubjectvspace
\newlength\presubjectvspace
\newlength\belowsubjectvspace
\newlength\abovesignaturevspace
\newlength\abovesignatureshortvspace
\newlength\belowsignaturevspace
\newlength\belowpresentationvspace
\def\do#1{\@newrigidlength #1\setlength #1\z@}
\do\addrlabelsleftmargin
\do\addrlabelstopmargin
\do\addrlabelshsep
\do\addrlabelsvsep
\do\addrlabelborder
\@newrigidlength\addrlabelwidth
\@newrigidlength\addrlabelheight
\@newrigidlength\addrlabeltrimwidth
\@newrigidlength\addrlabeltrimheight
\@ifdefinable\@cdp@reserved{}
\@ifdefinable\@empty@block{}
\@ifdefinable\@beginlabels{}
\@ifdefinable\@beginlabelgroup{}
\@ifdefinable\@mlabel{}
\@ifdefinable\@endlabelgroup{}
\@ifdefinable\@endlabels{}
\@ifdefinable\startaddrlabel{}
\@ifdefinable\startaddrlabel{}
\@ifdefinable\stopaddrlabel{}
\@ifdefinable\ifactuallabel{}
\@ifdefinable\@lett@decl{\newtoks\@lett@decl}
\def\do#1{\@ifdefinable#1{\let#1\@empty}}
\do\thesenderaddress
\do\thesendername
\do\thesendersignature
\do\thesenderlocation
\do\thesenderphone
\do\theaddresseeaddress
\do\theaddresseename
\do\thesubject
\do\@subject@style
\do\@signature@style
\do\@place
\do\@begin@letter@hook
\do\@end@letter@hook
\def\do#1{\@ifdefinable#1{\let#1\@undefined}}
\do\presubject
\do\registered
\do\registeredRR
\def\do#1{\@ifdefinable#1{\newcount#1}}
\do\@fold@basepenalty
\do\@fold@lowpenalty
\do\@fold@medpenalty
\do\@fold@highpenalty
\do\@fold@toppenalty
\do\@b@frompenalty
\do\@i@frompenalty
\do\@e@frompenalty
\do\@b@topenalty
\do\@i@topenalty
\do\@e@topenalty
\do\@b@subjpenalty
\do\@e@subjpenalty
\do\@e@prespenalty
\do\@i@penalty
\do\@e@penalty
\do\@cdp@gencount
\def\do#1{\@ifdefinable#1{\newif#1}}
\do\if@use@eepic@
\do\if@do@fold@
\@ifdefinable\if@new@block@{
  \def\@new@block@true {\global\let\if@new@block@\iftrue }
  \def\@new@block@false{\global\let\if@new@block@\iffalse}
}
\@ifdefinable\if@empty@and@{
  \def\@empty@and@true {\global\let\if@empty@and@\iftrue }
  \def\@empty@and@false{\global\let\if@empty@and@\iffalse}
}
\newsavebox\@logo@box@base
\newsavebox\@logo@box@addS
\newsavebox\@logo@box@addL
\newsavebox\@oordinamento@box
\newsavebox\@name@and@WWW@box
\let\and\relax
\@ifdefinable\andcc{\def\andcc{\and}}
\@ifdefinable\m@kel@bel{\let\m@kel@bel\makelabel}
\@ifdefinable\@@vspace{\let\@@vspace\vspace}
\@ifdefinable\@indent@pref{\let\@indent@pref F}
\@ifdefinable\voidisOK{\let\voidisOK\@empty}
\newcommand*\subjectnamegap{.5em}
\newcommand*\closingindentation{\parindent}
\newcommand*\signaturealignment{\raggedright}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}%
    \setlength\foldedheight{3.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}%
    \setlength\foldedheight{4.7in}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}%
    \setlength\foldedheight{3.7in}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}%
    \setlength\foldedheight{-\maxdimen}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}%
    \setlength\foldedheight{-\maxdimen}}
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}%
    \setlength\foldedheight{100mm}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}%
    \setlength\foldedheight{-\maxdimen}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\if@compatibility
  \DeclareOption{twoside}{%
    \@latexerr{No `twoside' layout for letters}\@eha
  }
\else
  \DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\fi
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twocolumn}{%
  \@latexerr{No `twocolumn' layout for letters}\@eha
}
\DeclareOption{onecolumn}{}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{boldsubject}{\let\@subject@style\bfseries}
\DeclareOption{mediumsubject}{\let\@subject@style\mdseries}
\DeclareOption{italicsignature}{\let\@signature@style\itshape}
\DeclareOption{uprightsignature}{\let\@signature@style\upshape}
\DeclareOption{usePS}{\@use@eepic@true}
\DeclareOption{noPS}{\@use@eepic@false}
\DeclareOption{smartindent}{\let\@indent@pref O}
\DeclareOption{shortindent}{\let\@indent@pref L}
\DeclareOption{noindent}{\let\@indent@pref N}
\DeclareOption{indent}{\let\@indent@pref F}
\DeclareOption{Avery5352labels}{%
  \setcounter{addrlabelrows}{5}%
  \setcounter{addrlabelcolumns}{\tw@}%
  \setlength\addrlabelsleftmargin{-35\p@}%
  \addtolength\addrlabelsleftmargin{1in}%
  \setlength\addrlabelstopmargin{-50\p@}%
  \addtolength\addrlabelstopmargin{1in}%
  \setlength\addrlabelshsep{26\p@}%
  \setlength\addrlabelwidth{262\p@}%
  \setlength\addrlabelheight{2in}%
}
\DeclareOption{70x37labels}{%
  \setcounter{addrlabelrows}{8}%
  \setcounter{addrlabelcolumns}{\thr@@}%
  \setlength\addrlabelwidth{70mm}%
  \setlength\addrlabelheight{37mm}%
  \setlength\addrlabelborder{6mm}%
}
\DeclareOption{105x37labels}{%
  \setcounter{addrlabelrows}{8}%
  \setcounter{addrlabelcolumns}{\tw@}%
  \setlength\addrlabelwidth{105mm}%
  \setlength\addrlabelheight{37mm}%
  \setlength\addrlabelborder{6mm}%
}
\ExecuteOptions{a4paper,10pt,oneside,onecolumn,final,%
mediumsubject,uprightsignature,noPS,indent,105x37labels}
\ProcessOptions\relax
\if@use@eepic@
  \IfFileExists{eepic.sty}{%
    \RequirePackage{eepic}%
  }{%
    \@use@eepic@false
    \ClassWarningNoLine{\@letteracdp}{%
      Can't find the eepic package;\MessageBreak
      option usePS ignored (converted to noPS)%
    }%
  }%
\fi
%% Command \date redefined to make changes to date local.
\def\date#1{\def\@date{#1}}
\newcommand*\place[1]{%
  \ifx \@empty #1\@empty % if #1 is empty
    \let\@place\@empty
  \else
    \def\@place{#1,}%
  \fi
}
\input{size1\@ptsize.clo}
\setlength\lineskip{\p@}
\setlength\normallineskip{\p@}
\renewcommand*\baselinestretch{}
\renewcommand*\thelabel{\theletter\@alph\c@label}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\@fold@basepenalty 9000
\@fold@lowpenalty  9101
\@fold@medpenalty  9202
\@fold@highpenalty 9303
\@fold@toppenalty  9500
\@b@frompenalty\z@
\@i@frompenalty\@highpenalty
\@e@frompenalty\@lowpenalty
\@b@topenalty\z@
\@i@topenalty\@highpenalty
\@e@topenalty\@lowpenalty
\@b@subjpenalty\z@
\@e@subjpenalty\z@
\@e@prespenalty\@e@subjpenalty
\setlength\headheight{1cm}
\setlength\topmargin{1.5cm}
\addtolength\topmargin{-1in}
\setlength\headsep{1.5cm}
\setlength\marginparsep {11\p@}
\setlength\marginparpush{5\p@}
\setlength\footnotesep{12\p@}
\setlength{\skip\footins}{10\p@ plus 2\p@ minus 4\p@}
\if@compatibility
  \setlength\oddsidemargin{53pt}
  \setlength\evensidemargin{53pt}
  \setlength\marginparwidth{90pt}
  \setlength\textwidth{365\p@}
  \setlength\textheight{505\p@}
  \setlength\footskip{25\p@}
\else
  \setlength\@tempdima{\paperwidth}
  \addtolength\@tempdima{-\textwidth}
  \setlength\@tempdima{.5\@tempdima}
  \ifdim\@tempdima < 3.25cm % align to centre of logo
    \setlength\oddsidemargin{3cm}
  \else\ifdim\@tempdima < 4.5cm % align to right edge of logo
    \setlength\oddsidemargin{4cm}
  \else % keep the computed margin
    \setlength\oddsidemargin{\@tempdima}
  \fi\fi
  \setlength\textwidth{\paperwidth}
  \addtolength\textwidth{-2\oddsidemargin}
  \setlength\marginparwidth{\oddsidemargin}
  \addtolength\marginparwidth{-\marginparsep}
  \addtolength\marginparwidth{-7mm}
  \setlength\@tempdima{.33333\textwidth}
  \ifdim\marginparwidth > \@tempdima
    \ifdim\@tempdima < 90pt\else
      \setlength\marginparwidth{\@tempdima}
    \fi
  \fi
  \addtolength\oddsidemargin{-1in}
  \setlength\evensidemargin{\oddsidemargin}
  \setlength\@tempdima{\paperheight}
  \addtolength\@tempdima{-8cm}
  \setlength\footskip{\@tempdima}
  \addtolength\@tempdima{-\topskip}
  \divide\@tempdima\baselineskip
  \@tempcnta=\@tempdima
  \setlength\textheight{\@tempcnta\baselineskip}
  \addtolength\textheight{\topskip}
  \addtolength\footskip{-\textheight}
  \addtolength\footskip{1.5cm}
\fi
\newcommand*\computelongindentation{%
  \setlength\@tempdima{\wd\@oordinamento@box}%
  \setlength\longindentation{\@tempdima}%
  \addtolength\@tempdima{2.5mm}%
  \ifdim\@tempdima<.5\textwidth
    \setlength\longindentation{.5\textwidth}%
  \else
    \addtolength\@tempdima{-12.5mm}%
    \ifdim\@tempdima>.5\textwidth
      \setlength\longindentation{.5\textwidth}%
    \fi
  \fi
  \ifdim\longindentation<.4\textwidth
    \setlength\longindentation{.5\textwidth}%
  \else\ifdim\longindentation>.6\textwidth
    \setlength\longindentation{.5\textwidth}%
  \fi\fi
}
\@ifdefinable\@folding@ht@warn{\def\@folding@ht@warn#1#2{%
  \ClassWarningNoLine{\@letteracdp}{%
    \protect\foldedheight\space ignored:
    it is too #1!\MessageBreak
    (#2.)\MessageBreak
    Folded letters will be shunned%
  }%
  \@do@fold@false
}}%
\@ifdefinable\@folding@ht@NO{\def\@folding@ht@NO#1#2{%
  \ClassWarning{\@letteracdp}{%
    Bad value of \protect\foldedheight: it is too #1!\MessageBreak
    (#2.)\MessageBreak
    Therefore, at present folded letters are _shunned_;\MessageBreak
    warning issued%
  }%
  \@do@fold@false
}}%
\@ifdefinable\@folding@ht@OK{\def\@folding@ht@OK{%
  \ClassWarning{\@letteracdp}{%
    Checked \protect\foldedheight,
    current value is acceptable.\MessageBreak
    Therefore, at present folded letters are _allowed_;\MessageBreak
    warning issued%
  }%
  \@do@fold@true
}}%
\@ifdefinable\@checkfoldedheight{\def\@checkfoldedheight#1#2{%
  \ifdim\foldedheight>\z@
    \ifdim\foldedheight>.6\paperheight
      #1{tall}{% action to take if value is bad
        It must not exceed 0.6\protect\paperheight%
      }%
    \else
      \setlength\@folding@ht{\foldedheight}%
      \addtolength\@folding@ht{-1in}%
      \addtolength\@folding@ht{-\topmargin}%
      \addtolength\@folding@ht{-\headheight}%
      \setlength\@lh@folding@ht{-\@folding@ht}%
      \addtolength\@folding@ht{-\headsep}%
      \ifdim\@folding@ht<2.5cm
        #1{short}{% action to take if value is bad
          At least 2cm _of_text_ and 0.5cm of margin\MessageBreak
          must be allowed above the folding%
        }%
      \else
        \setlength\@above@folding@margin{1cm}%
        \setlength\@above@folding@shrink{5mm}%
        \setlength\@below@folding@skip{5mm}%
        \dimen4 .5\baselineskip
        \dimen@ \@folding@ht
        \advance\dimen@ \@below@folding@skip
        \advance\dimen@ -\topskip
        \dimen@ii -\dimen@
        \divide\dimen@ \dimen4%
        \count@ \dimen@
        \advance\dimen@ii \count@\dimen4%
        \addtolength\@below@folding@skip{\dimen@ii}%
        \addtolength\@folding@ht{-\@above@folding@margin}%
        #2% action to take if value is OK
      \fi
    \fi
  \else
    \@do@fold@false
  \fi
}}
\newcommand*\checkfoldedheight{%
  \@checkfoldedheight\@folding@ht@NO\@folding@ht@OK
}
\AtBeginDocument{%
  \setlength\@lh@left@margin{4cm}%
  \addtolength\@lh@left@margin{-1in}%
  \addtolength\@lh@left@margin{-\oddsidemargin}%
  \setlength\@lh@right@margin{\@lh@left@margin}%
  \addtolength\@lh@right@margin{-2cm}%
  \@checkfoldedheight\@folding@ht@warn\@do@fold@true
  \let\@folding@ht@warn\@undefined
}
\sbox\@oordinamento@box{%
  \@lh@nss oordinamento dei {\@lh@bss D}\kern-.033333em ottorandi di
  {\@lh@bss P}\kern-.1em adova\enspace
}
\computelongindentation
\newcommand*\standardvertspaces{%
  \setlength\aboveaddressvspace       {\medskipamount}%
  \@msetlength\andaddressvspace       {2}{\medskipamount}%
  \@msetlength\belowaddressvspace     {3}{\medskipamount}%
  \setlength\abovesubjectvspace       {\medskipamount}%
  \setlength\presubjectvspace         {\medskipamount}%
  \@msetlength\belowsubjectvspace     {3}{\medskipamount}%
  \@msetlength\abovesignaturevspace   {6}{\medskipamount}%
  \setlength\abovesignatureshortvspace{\bigskipamount}%
  \setlength\belowsignaturevspace     {\bigskipamount}%
  \@msetlength\belowpresentationvspace{3}{\medskipamount}%
}
\setlength\senderindentation   {\z@}
\setlength\senderwidth         {\textwidth}
\setlength\addresseeindentation{\z@}
\setlength\addresseewidth      {\textwidth}
\setlength\signatureindentation{\z@}
\setlength\signaturewidth      {\textwidth}
\standardvertspaces
\newcommand*{\automark}{\let\@mkboth\markboth}
\newcommand*{\usermark}{\let\@mkboth\@gobbletwo}
\automark % default is to put page no. and addressee in the header
%% We need to change even the definition of the standard page styles.
\def\ps@empty{%
  \let\@oddhead\@empty
  \let\@evenhead\@empty
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
}
\def\ps@plain{%
  \let\@oddhead\@empty
  \let\@evenhead\@empty
  \let\@oddfoot\@centred@folio
  \let\@evenfoot\@centred@folio
}
\def\ps@firstpage{%
  \let\@oddhead\@empty
  \let\@evenhead\@empty
  \let\@oddfoot\@first@foot
  \let\@evenfoot\@centred@folio
}
\def\ps@foldedpage{%
  \def\@oddhead{\hfill\@folding@tag}%
  \let\@evenhead\@empty
  \let\@oddfoot\@first@foot
  \let\@evenfoot\@centred@folio
}
\def\ps@letterhead{%
  \let\@oddhead\@cdp@head
  \let\@evenhead\@empty
  \let\@oddfoot\@centred@folio
  \let\@evenfoot\@centred@folio
}
\def\ps@firstletterhead{%
  \let\@oddhead\@cdp@head
  \let\@evenhead\@empty
  \let\@oddfoot\@cdp@foot
  \let\@evenfoot\@centred@folio
}
\def\ps@foldedletterhead{%
  \def\@oddhead{\@cdp@head\@folding@tag}%
  \let\@evenhead\@empty
  \let\@oddfoot\@cdp@foot
  \let\@evenfoot\@centred@folio
}
\def\ps@logo{%
  \def\@oddhead{\@cdp@logo\hfill}%
  \let\@evenhead\@empty
  \let\@oddfoot\@centred@folio
  \let\@evenfoot\@centred@folio
}
\def\ps@headings{%
  \automark
  \let\@oddhead\@r@head
  \let\@evenhead\@l@head
  \let\@oddfoot\@centred@folio
  \let\@evenfoot\@centred@folio
}
\def\ps@logoheadings{%
  \automark
  \def\@oddhead{\@cdp@logo\@r@head}%
  \let\@evenhead\@l@head
  \let\@oddfoot\@centred@folio
  \let\@evenfoot\@centred@folio
}
\def\ps@myheadings{%
  \usermark
  \let\@oddhead\@r@head
  \let\@evenhead\@l@head
  \let\@oddfoot\@centred@folio
  \let\@evenfoot\@centred@folio
}
\def\ps@logomyheadings{%
  \usermark
  \def\@oddhead{\@cdp@logo\@r@head}%
  \let\@evenhead\@l@head
  \let\@oddfoot\@centred@folio
  \let\@evenfoot\@centred@folio
}
\def\ps@letterheadnpn{%
  \let\@oddhead\@cdp@head
  \let\@evenhead\@empty
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
}
\def\ps@logonpn{%
  \def\@oddhead{\@cdp@logo\hfill}%
  \let\@evenhead\@empty
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
}
\@ifdefinable\@centred@folio{\def\@centred@folio{%
  \reset@font\hfil\thepage\hfil
}}
\@ifdefinable\@l@head{\def\@l@head{%
  \reset@font\slshape\hfil\ignorespaces\leftmark\unskip\/\hfil
}}
\@ifdefinable\@r@head{\def\@r@head{%
  \reset@font\slshape\hfil\ignorespaces\rightmark\unskip\/\hfil
}}
\@ifdefinable\@first@foot{\def\@first@foot{%
  \reset@font
  \raisebox{-24\p@}[\z@]{%
    \hb@xt@\textwidth{%
      \ifcase \@ptsize\relax
        \normalsize
      \or
        \small
      \or
        \footnotesize
      \fi
      \thesenderlocation \hfill \thesenderphone
    }%
  }\hss
}}
\@ifdefinable\@folding@tag{\def\@folding@tag{%
  \if@do@fold@
    \raisebox{\@lh@folding@ht}[\z@][\z@]{%
      \makebox[\z@][l]{%
        \dimen@ -\@lh@right@margin
        \advance\dimen@ 1cm%
        \kern\dimen@ \vbox{%
          \kern -.1\p@
          \hrule \@height .1\p@ \@depth .1\p@ \@width 5mm%
          \kern -.1\p@
        }%
      }%
    }%
  \fi
}}
\savebox\@logo@box@base[\z@][r]{\setlength\unitlength{.625mm}%
  \begin{picture}(32,16)(-3,7.87)%
    \put(8,16){\oval(10,10)[l]}%
    \put(8,11){\line(0,1){10}}%
    \put(9,11){\framebox(3,20){}}%
    \put(18,16){\oval(10,10)[r]}%
    \put(18,11){\line(0,1){10}}%
    \put(14,1){\framebox(3,20){}}%
    \thicklines
    \put(8,16){\oval(16,16)[l]}%
    \put(8,8){\line(1,0){5}}%
    \put(13,24){\line(1,0){10}}%
    \put(8,16){\oval(14,14)[l]}%
    \put(8,9){\line(1,0){5}}%
    \put(13,23){\line(1,0){10}}%
  \end{picture}%
}%
\savebox\@logo@box@addS[\z@][r]{\setlength\unitlength{.625mm}%
  \begin{picture}(32,16)(-3,7.87)%
    \thicklines
    \put(18,8){\line(1,0){8}}%
    \put(18,9){\line(1,0){8}}%
  \end{picture}%
}%
\savebox\@logo@box@addL[\z@][r]{\setlength\unitlength{.625mm}%
  \begin{picture}(32,16)(-3,7.87)%
    \thicklines
    \put(18,8){\line(1,0){10}}%
    \put(18,9){\line(1,0){10}}%
  \end{picture}%
}%
\@ifdefinable\@logo@overlay{\def\@logo@overlay{%
  \kern\@lh@left@margin
  \copy\@logo@box@base \copy
}}
\@ifdefinable\@cdp@logo{\def\@cdp@logo{%
  \@logo@overlay\@logo@box@addS
}}
\@ifdefinable\@cdp@head{\def\@cdp@head{%
  \@logo@overlay\@logo@box@addL
  \copy\@oordinamento@box \hrulefill \kern\@lh@right@margin
}}
\setbox\@name@and@WWW@box = \vtop{%
  \baselineskip 11\p@
  \hb@xt@\z@{\hss \@lh@rm\Coordinamento \hss}%
  \hb@xt@\z@{%
    \hss
    \@lh@it World Wide Web:\/
    \@lh@tt \CoordinamentoWWW
    \hss
  }%
}
\@ifdefinable\@cdp@foot{\def\@cdp@foot{%
  \reset@font
  \setlength\@tempdima{\textwidth}%
  \addtolength\@tempdima{-2\@lh@right@margin}%
  \hss\parbox[t]{\@tempdima}{%
    \parfillskip\z@skip
    \noindent\hrulefill\@@par
    \baselineskip 11\p@
    \hb@xt@\hsize{\hfil\copy\@name@and@WWW@box\hfil}%
  }\hss
}}
\newcommand*\name     [1]{\def\thesendername{#1}}
\newcommand \signature[1]{\def\thesendersignature{#1}}
\newcommand \address  [1]{\def\thesenderaddress{#1}}
\newcommand \location [1]{\def\thesenderlocation{#1}}
\newcommand*\telephone[1]{\def\thesenderphone{#1}}
\newcommand*\makelabels{%
  \AtBeginDocument{%
     \def\@beginlabels{\begin{labels}}%
     \def\@beginlabelgroup{\begin{labelgroup}}%
     \let\@mlabel\basemlabel
     \def\@endlabelgroup{\end{labelgroup}}%
     \def\@endlabels{\end{labels}}%
     \if@filesw
       \immediate\write\@mainaux{\string\@beginlabels}\fi}%
  \AtEndDocument{%
     \if@filesw\immediate\write\@mainaux{\string\@endlabels}\fi}}
\@onlypreamble\makelabels
\newcommand*\cleardoubleemptypage{\par
  \onecolumn
  \if@twoside \ifodd\c@page \else
    \thispagestyle{empty}\null\newpage
  \fi\fi
}
\@ifdefinable\@safe@space{\def\@safe@space#1#2{%
  \setbox\z@\hbox{\ignorespaces #1\unskip}%
  \ifdim\wd\z@>\z@
    \unhbox\z@ #2%
  \else
    \unhbox\z@
  \fi
}}
\newenvironment{baseletter}[2]{%
  #1%
  \@lett@decl{#2}%
  \cleardoubleemptypage
  \c@page\@ne
  \refstepcounter{letter}%
  \typeout{\lettername \space \number\c@letter}%
  \interlinepenalty 200 % smaller than the TeXbook value
  \parskip\medskipamount
  \ifx\@indent@pref L\else
    \ifx\@indent@pref N%
      \setlength\parindent{\z@}%
    \else
      \ifdim .1\textwidth>2pc
        \setlength\parindent{.1\textwidth}%
      \else
        \setlength\parindent{2pc}%
      \fi
    \fi
  \fi
  \@ifnextchar[\x@baseletter\y@baseletter % ] bracket matching
}{%
  \stopletter
  \@@par\addpenalty\z@
  \clearpage
  \@end@letter@hook
  \if@filesw
    \begingroup
      \let\\\relax
      \let ~\relax
      \let\protect\@unexpandable@protect
      \def\and{%
        \iffalse{\fi}\expandafter\@gobble\expandafter{\iffalse}\fi
      }%
      \let\andcc\and
      \edef\@cdp@reserved{{\returnaddress}}%
      \def\and{%
        \iffalse{\fi}^^J%
        \string\@mlabel{\@cdp@reserved}{\iffalse}\fi
      }%
      \let\andcc\and
      \immediate\write\@auxout{%
        \string\@beginlabelgroup ^^J%
        \string\@mlabel
          {\@cdp@reserved}{\theaddresseeaddress}^^J%
        \string\@endlabelgroup
      }%
    \endgroup
  \fi
}
\@ifdefinable\x@baseletter{\long\def\x@baseletter[#1]#2{%
  \def\theaddresseename{#1}%
  \def\theaddresseeaddress{#2}%
  \@baseletter
}}
\@ifdefinable\y@baseletter{\long\def\y@baseletter#1{%
  \@cut@andcc #1\andcc\@@@
  \def\theaddresseeaddress{#1}%
  \@baseletter
}}
\newcommand\@baseletter[1][]{%
  \def\thesubject{#1}%
  \if@twoside
    \@mkboth{%
      \noexpand\@safe@space\noexpand\headtoname\noexpand\enspace
      \ignorespaces\theaddresseename\unskip \hfill \noexpand\@date
    }{%
      \noexpand\@date \hfill
      \noexpand\@safe@space\noexpand\headtoname\noexpand\enspace
      \ignorespaces\theaddresseename % \unskip put by \@?@head
    }%
  \else
    \@mkboth{}{%
      \noexpand\@safe@space\noexpand\headtoname\noexpand\enspace
      \ignorespaces\theaddresseename\unskip \hfill \noexpand\@date
    }%
  \fi
  \the\@lett@decl
  \@begin@letter@hook
}
\@ifdefinable\@cut@andcc{\long\def\@cut@andcc#1\andcc#2\@@@{%
  \@cut@and #1\and\@@@%
}}
\@ifdefinable\@cut@and{\long\def\@cut@and#1\and#2\@@@{%
  \@cut@nl #1\\\@@@%
}}
\@ifdefinable\@cut@nl{\long\def\@cut@nl#1\\#2\@@@{%
  \@cut@par #1\par\@@@%
}}
\@ifdefinable\@cut@par{\long\def\@cut@par#1\par#2\@@@{%
  \def\theaddresseename{#1}%
}}
\newcommand*\stopbreaks{%
  \interlinepenalty\@M
  \def\par{\ifvmode\else\@@par\nobreak\fi}%
  \let\\\@nobreakcr
  \let\vspace\@nobreakvspace
}
\DeclareRobustCommand\@nobreakvspace
   {\@ifstar\@vspacer\@nobreakvspacex}
\@ifdefinable\@nobreakvspacex{\def\@nobreakvspacex#1{%
  \ifvmode
    \nobreak
    \vskip #1%
    \vskip\z@skip
  \else
    \@bsphack
    \vadjust{\@restorepar
      \nobreak
      \vskip #1%
      \vskip\z@skip
    }%
    \@esphack
  \fi
}}
\@ifdefinable\@nobreakcr{\def\@nobreakcr{%
  \@ifstar{\@normalcr*}{\@normalcr*}%
}}
\newcommand*\startbreaks{%
  \interlinepenalty 200%
  \let\par\@@par
  \let\\\@normalcr
  \let\vspace\@@vspace
}
\@ifdefinable\@par@stopbreaks{\def\@par@stopbreaks{%
  \par\nobreak\stopbreaks
}}
\@ifdefinable\@@letter{\def\@@letter#1#2#3{%
  \ifx#2N%
    \renewcommand*\makepresentation{\makenormalpresentation}%
    \renewenvironment*{presentation}{%
      \normalpresentation
    }{%
      \endnormalpresentation
    }%
  \else\ifx#2F%
    \renewcommand*\makepresentation{\makefoldedpresentation}%
    \renewenvironment*{presentation}{%
      \foldedpresentation
    }{%
      \endfoldedpresentation
    }%
  \fi\fi
  \setlength\senderindentation   {\z@}%
  \setlength\senderwidth         {#3}%
  \setlength\addresseeindentation{#3}%
  \setlength\addresseewidth      {\textwidth}%
    \addtolength\addresseewidth{-\addresseeindentation}%
  \setlength\signatureindentation{.3\textwidth}%
  \setlength\signaturewidth      {.6\textwidth}%
  \renewcommand*\closingindentation{\parindent}
  \renewcommand*\signaturealignment{\centering}%
  \standardvertspaces
  \baseletter{}{%
    #1%
  }%
}}
\@ifdefinable\@letter{\def\@letter#1{%
  \@@letter{\thispagestyle{#1}}%
}}
\newenvironment*{customletter}{%
  \@@letter{}L%
}{\endbaseletter}
\newenvironment*{letter}{%
  \@letter{firstpage}N{.5\textwidth}%
}{\endbaseletter}
\newenvironment*{foldedletter}{%
  \@letter{foldedpage}F{.5\textwidth}%
}{\endbaseletter}
\newenvironment*{letter*}{%
  \@letter{firstpage}N\longindentation
}{\endbaseletter}
\newenvironment*{foldedletter*}{%
  \@letter{foldedpage}F\longindentation
}{\endbaseletter}
\newenvironment*{letterhead}{%
  \@letter{firstletterhead}N\longindentation
}{\endbaseletter}
\newenvironment*{foldedletterhead}{%
  \@letter{foldedletterhead}F\longindentation
}{\endbaseletter}
\@ifdefinable\@block@parshape{\def\@block@parshape{%
  \parshape \@ne\@block@inden\@block@width
}}
\@ifdefinable\@block@@everypar{\def\@block@@everypar{%
  \parskip\z@skip
  \@nobreakfalse \@minipagefalse % these are already \global
  \@new@block@false \@empty@and@false % these too
  \everypar{\@block@parshape}%
}}
\@ifdefinable\@block@everypar{\def\@block@everypar{%
  \@block@parshape
  \@block@@everypar
}}
\@ifdefinable\x@custom@block{\def\x@custom@block#1#2#3#4#5#6#7#8#9{%
  \@custom@block#1#4#5#6#8#9%
  \@block@inden #2%
  \@block@width #3%
  \def\voidisOK{\global\let\@empty@block\@empty}%
  \everypar{\@block@everypar}%
  \@@custom@block #7%
}}
\@ifdefinable\y@custom@block{\def\y@custom@block#1#2#3#4#5#6#7#8{%
  \@custom@block#1#3#4#5#7#8%
  \sbox\@labels{\normalfont\ignorespaces #2\unskip}%
    % We use \@labels to save a box register.
  \@block@inden\wd\@labels
  \ifdim\@block@inden>\z@
    \advance \@block@inden by \subjectnamegap \relax
    \wd\@labels\@block@inden
  \fi
  \@block@width\textwidth \advance\@block@width -\@block@inden
  \everypar{%
    \parshape \tw@ \z@\textwidth \@block@inden\@block@width
    \box\@labels
    \@block@@everypar
  }%
  \@@custom@block #6%
}}
\@ifdefinable\@custom@block{\def\@custom@block#1#2#3#4#5#6{%
  \if@inlabel \indent \fi
  \let\par\@@par \par
  \if@newlist \@noitemerr \fi
  \let\makelabel\m@kel@bel
  \@nobreakfalse
  \@noskipsecfalse
  \@totalleftmargin\z@
  \leftskip\z@skip \rightskip\z@skip \@rightskip\z@skip
  \parfillskip\@flushglue
  \ifx#1Y%
    \parskip #2\relax
    \ifdim\lastskip>\parskip
      \parskip\z@skip
    \else
      \advance\parskip -\lastskip
    \fi
  \else
    \parskip\z@skip
  \fi
  \parindent\z@
  \linewidth\textwidth
  \hsize\textwidth
  \@block@space #4%
  \@block@andspace #3%
  \@i@penalty #5%
  \@e@penalty #6%
  \stopbreaks
  \@new@block@true \@empty@and@true
}}
\@ifdefinable\@@custom@block{\def\@@custom@block#1{%
  \addpenalty #1%
  \color@begingroup
}}
\def\end@custom@block#1{\par
  \color@endgroup
  \if@new@block@
    \@empty@block
  \else
    \if@empty@and@
      \@empty@and
    \fi
    \ifx#1Y%
      \addpenalty\@e@penalty
      \addvspace\@block@space
    \fi
  \fi
  \everypar{}%
}
\newcommand*\makeandvspace{%
  \addpenalty\@i@penalty
  \addvspace\@block@andspace
}
\newcommand*\makeandcclabel[1][\andccname]{%
  \makebox[\z@][r]{\normalfont\@safe@space{#1}\quad}%
  \ignorespaces
}
\@ifdefinable\@block@nd{\def\@block@nd{\par
  \if@empty@and@
    \@empty@and
  \else
    \makeandvspace
  \fi
  \@empty@and@true
  \everypar{\@block@everypar}%
}}
\@ifdefinable\@empty@and{\def\@empty@and{%
  \ClassWarning{\@letteracdp}{%
    \protect\and\space with nothing inside%
  }%
}}
\@ifdefinable\@empty@sender{\def\@empty@sender{%
  \ClassWarning{\@letteracdp}{%
    Empty sender address%
  }%
}}
\@ifdefinable\@sender{\def\@sender#1{%
  \let\@empty@block\@empty@sender
  \let\and\@block@nd
  \x@custom@block #1%
    \senderindentation\senderwidth
    \aboveaddressvspace\andaddressvspace\belowaddressvspace
    \@b@frompenalty\@i@frompenalty\@e@frompenalty
  \raggedright
}}
\newenvironment*{sender} {\@sender Y}{\end@custom@block Y}
\newenvironment*{sender*}{\@sender N}{\end@custom@block N}
\@ifdefinable\@empty@addressee{\def\@empty@addressee{%
  \ClassWarning{\@letteracdp}{%
    Empty addressee address%
  }%
}}
\@ifdefinable\@addressee{\def\@addressee#1{%
  \let\@empty@block\@empty@addressee
  \let\and\@block@nd
  \def\andcc{\@block@nd
    \everypar\expandafter{\the\everypar
      \makeandcclabel\relax
    }%
  }%
  \x@custom@block #1%
    \addresseeindentation\addresseewidth
    \aboveaddressvspace\andaddressvspace\belowaddressvspace
    \@b@topenalty\@i@topenalty\@e@topenalty
  \raggedright
}}
\newenvironment*{addressee} {\@addressee Y}{\end@custom@block Y}
\newenvironment*{addressee*}{\@addressee N}{\end@custom@block N}
\@ifdefinable\@good@prsbj{\def\@good@prsbj#1{%
  \@new@block@false \@empty@and@false
  \let\presubject\@bad@prsbj
  \vskip\parskip
  \leftline{\normalfont\ignorespaces #1\unskip}%
  \nobreak
  \parskip\presubjectvspace
}}
\@ifdefinable\@bad@prsbj{\def\@bad@prsbj#1{%
  \ClassError{\@letteracdp}{%
    Misused \protect\presubject%
  }{%
    At the beginning of the subject of a letter
    you can write something like\MessageBreak
    \protect\presubject{A short phrase...}
    in order to typeset "A short phrase..."\MessageBreak
    just above the subject; but the \protect\presubject\space
    command must come before\MessageBreak
    any other text in the subject,
    and it cannot be used twice.\MessageBreak
    (If you are wondering where you used the
    \protect\presubject\space command,\MessageBreak
    recall that both \protect\registered\space and
    \protect\registeredRR\space invoke
    \protect\presubject.)\MessageBreak
    The offending command will be ignored:
    try to type \space <return> \space to proceed.%
  }%
}}
\@ifdefinable\@subject{\def\@subject#1#2{%
  \let\@empty@block\@empty
  \y@custom@block #1%
    {#2}%
    \abovesubjectvspace\z@skip\belowsubjectvspace
    \@b@subjpenalty\@M\@e@subjpenalty
  \let\presubject\@good@prsbj
  \def\registered  {\presubject{\registeredname}}%
  \def\registeredRR{\presubject{\registeredRRname}}%
  \everypar\expandafter{\the\everypar
    \let\presubject\@bad@prsbj
  }%
  \@subject@style
}}
\newenvironment*{subject} [1][\subjectname]
  {\@subject Y{#1}}{\end@custom@block Y}
\newenvironment*{subject*}[1][\subjectname]
  {\@subject N{#1}}{\end@custom@block N}
\newcommand*\ifemptyblock{%
  \if@new@block@
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
}
\@ifdefinable\@makesender{\def\@makesender#1{%
  \begin{sender#1}\thesenderaddress\end{sender#1}%
}}
\newcommand*\makesender{%
  \@ifstar{\@makesender *}{\@makesender {}}%
}
\@ifdefinable\@makeaddressee{\def\@makeaddressee#1{%
  \begin{addressee#1}\theaddresseeaddress\end{addressee#1}%
}}
\newcommand*\makeaddressee{%
  \@ifstar{\@makeaddressee *}{\@makeaddressee {}}%
}
\newcommand*\x@makesubject[1][\subjectname]{%
  \begin{subject}[#1]\thesubject\end{subject}%
}
\newcommand*\y@makesubject[1][\subjectname]{%
  \begin{subject*}[#1]\thesubject\end{subject*}%
}
\newcommand*\makesubject{\@ifstar\y@makesubject\x@makesubject}
\@ifdefinable\@setup@pres{\def\@setup@pres{%
  \global\@topnum\z@ % prevents figures from going at top of page
  \parskip\z@skip
  \parindent\z@
  \@b@frompenalty \@M
  \@i@frompenalty \@fold@toppenalty
  \@e@frompenalty \@M
  \@b@topenalty   \@fold@toppenalty
  \@i@topenalty   \@fold@toppenalty
  \@e@topenalty   \@M
  \@b@subjpenalty \@fold@toppenalty
  \@e@subjpenalty \@M
  \interlinepenalty\@M
  \def\par{\ifvmode\else\@@par\penalty\@fold@toppenalty\fi}%
  \let\\\@nobreakcr
  \let\vspace\@nobreakvspace
}}
\newenvironment*{presentation}{%
  \normalpresentation
}{%
  \endnormalpresentation
}
\newenvironment*{normalpresentation}{%
  \cleardoublepage
  \@setup@pres
}{%
  \@@par
  \addpenalty\@e@prespenalty
  \addvspace\belowpresentationvspace
}
\@ifdefinable\@nofoldwarning{\def\@nofoldwarning{%
  \ClassWarning{\@letteracdp}{%
    The paper format you chose does not allow\MessageBreak
    folded letters; making normal presentation.\MessageBreak
    (Modify \protect\foldedheight\space in the preamble\MessageBreak
    if you want to alter the default behavior.)\MessageBreak
    Warning issued%
  }%
}}
\newenvironment*{foldedpresentation}{%
  \if@do@fold@
    \cleardoublepage
    \setbox\z@\vbox\bgroup
      \@setup@pres
      \boxmaxdepth\maxdepth
      \color@begingroup
      \penalty-\@M
  \else
    \@nofoldwarning
    \normalpresentation
  \fi
}{%
  \if@do@fold@
      \@@par
      \color@endgroup
      \global\dimen@i\prevdepth
      \@f@ldingfilbreak\@fold@basepenalty
      \vskip\maxdimen % "discourage" the break at the \penalty-10000
    \egroup
    \splitmaxdepth\maxdepth
    \splittopskip\topskip
    \setbox\tw@\vsplit\z@ to\z@
    \splittopskip\baselineskip
    \advance\splittopskip\@below@folding@skip
    \advance\splittopskip\parskip
    \setbox\tw@\vsplit\z@ to\@folding@ht
    \nointerlineskip
    \box\tw@
    {\baselineskip\@above@folding@margin \nobreak\null}%
    \penalty\@highpenalty
    \ifvoid\z@
      \vskip\@below@folding@skip
    \else
      \unvbox\z@
      \unskip    % remove "\vskip\maxdimen"
      \unpenalty % remove "\penalty\@fold@basepenalty"
      \unskip    % remove "\vskip \dimen@ plus 1fil minus ..."
      \unskip    % remove "\vskip -\skip@"
      \unpenalty % remove "\penalty 10000"
      \prevdepth\dimen@i
      \addpenalty\@e@prespenalty
      \addvspace\belowpresentationvspace
      \ClassWarning{\@letteracdp}{%
        Some text that did not fit into the folded flap\MessageBreak
        was moved into the main text below the folding;\MessageBreak
        warning issued%
      }%
    \fi
  \else
    \endnormalpresentation
  \fi
}
\newcommand*\iffoldedallowed{%
  \if@do@fold@
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
}
\newcommand*\makepresentation{\makenormalpresentation}
\newcommand*\makenormalpresentation{%
  \begin{normalpresentation}%
    \makesender\relax
    \makeaddressee\relax
    \makesubject\relax
  \end{normalpresentation}%
}
\@ifdefinable\@f@ldingfilbreak{\def\@f@ldingfilbreak#1{%
  \ifdim\prevdepth<\maxdepth
    \dimen@ -\prevdepth
  \else
    \dimen@ -\maxdepth
  \fi
  \skip@ \lastskip
  \nobreak
  \vskip -\skip@
  \vskip \dimen@ \@plus 1fil\@minus \@above@folding@shrink
  \penalty #1%
}}
\@ifdefinable\@foldingfilbreak{\def\@foldingfilbreak#1#2{\par
  \@f@ldingfilbreak#1%
  \vskip -\dimen@ \@plus -1fil\@minus -\@above@folding@shrink
  \vskip \skip@
  \addvspace{#2}%
}}
\@ifdefinable\@fold@getpen{\def\@fold@getpen#1{%
  \ifcase #1 \@fold@basepenalty \or \@fold@lowpenalty
    \or \@fold@medpenalty \or \@fold@highpenalty
    \else \@fold@toppenalty \fi
}}
\newcommand*\foldingbreak[1][\z@]{%
  \ifvmode
    \penalty\@fold@getpen{#1}%
  \else
    \@bsphack
    \vadjust{\penalty\@fold@getpen{#1}}%
    \@esphack
  \fi
}
\newcommand*\foldingfilbreak[1][\z@]{%
  \@foldingfilbreak{\@fold@getpen{#1}}%
}
\newcommand*\makefoldedpresentation{%
  \if@do@fold@
    \begin{foldedpresentation}%
      \renewcommand*\makeandvspace{%
        \@foldingfilbreak\@fold@medpenalty\andaddressvspace
      }%
      \makesender\relax
      \@foldingfilbreak\@fold@medpenalty\z@skip
      \if@new@block@
        \aboveaddressvspace \z@\@plus1fil\relax
        \nointerlineskip\null\nobreak
      \fi
      \makeaddressee\relax
      \@foldingfilbreak\@fold@lowpenalty\z@skip
      \makesubject\relax
    \end{foldedpresentation}%
  \else
    \@nofoldwarning
    \makenormalpresentation
  \fi
}
\@ifdefinable\@make@date{\def\@make@date#1#2#3{\par
  \ifx#2Y%
    \nobreak\medskip
  \fi
  \noindent\@safe@space{#1}\space\@date\par
  \ifx#3Y%
    \nobreak\medskip
  \fi
}}
\newcommand*\makedate      [1][\@place]{\@make@date{#1}NN}
\newcommand*\maketopdate   [1][\@place]{\@make@date{#1}NY}
\newcommand*\makebottomdate[1][\@place]{\@make@date{#1}YN}
\@ifdefinable\@empty@signature{\def\@empty@signature{%
  \ClassWarning{\@letteracdp}{%
    Empty signature%
  }%
}}
\@ifdefinable\@signatureenv{\def\@signatureenv#1{\par
  \let\@empty@block\@empty@signature
  \let\and\@block@nd
  \x@custom@block Y%
    \signatureindentation\signaturewidth
    #1#1\z@skip
    \@M\@M\@M
  \signaturealignment\@signature@style
}}
\def\end@signatureenv{%
  \end@custom@block N% not "Y" for efficiency
  \addvspace\belowsignaturevspace
}
\newenvironment*{signatureenv}{%
  \@signatureenv\abovesignaturevspace
}{%
  \end@signatureenv
}
\newenvironment*{signatureenv*}{%
  \@signatureenv\abovesignatureshortvspace
}{%
  \end@signatureenv
}
\@ifdefinable\x@msignature{\def\x@msignature#1{%
  \begin{signatureenv#1}%
    \ifx\thesendersignature\@empty
      \thesendername
    \else
      \thesendersignature
    \fi
  \end{signatureenv#1}%
}}
\@ifdefinable\y@msignature{\def\y@msignature{%
  \begin{signatureenv}%
    \vskip\parskip \vskip\z@skip
    \the\everypar
  \end{signatureenv}%
}}
\newcommand*\makesignature{\@par@stopbreaks
  \@ifstar{%
    \x@msignature *%
  }{%
    \@ifnextchar -{%
      \@firstoftwo\y@msignature
    }{%
      \x@msignature {}%
    }%
  }%
}
\newcommand*\makeopening{\par
  \@ifnextchar +{\@firstoftwo\y@mopening}\x@mopening
}
\@ifdefinable\x@mopening{\def\x@mopening#1{%
  \ifx\@indent@pref O%
    \dimen@\prevdepth
    \setbox\z@\vbox{\color@begingroup
      \null
      \prevdepth\dimen@
      \noindent\null\ignorespaces #1\par
      \global\dimen@i\prevdepth
    \color@endgroup}%
    \setbox\tw@\vbox{%
      \unvcopy\z@
      \setbox\z@\lastbox
      \global\setbox\@ne\hbox{\unhbox\z@}%
    }%
    \ifdim\wd\@ne<2pc
      \parindent 2pc\relax
    \else\ifdim\wd\@ne>.4\textwidth
      \parindent .1\textwidth\relax
    \else
      \parindent \wd\@ne
    \fi\fi
    \unvbox\z@
    \prevdepth\dimen@i
  \else
    \noindent\null\ignorespaces #1\par
  \fi
  \nobreak
}}
\@ifdefinable\y@mopening{\def\y@mopening{%
  \@handwr@box\z@ \nobreak
}}
\newcommand*\opening{\par
  \@ifnextchar +{%
    \let\@cdp@reserved\y@mopening
    \@firstoftwo\@opening
  }{%
    \let\@cdp@reserved\x@mopening
    \@opening
  }%
}
\newcommand*\@opening[1][\@place]{%
  \makepresentation
  \maketopdate[#1]%
  \@cdp@reserved
}
\newcommand*\makeclosing{\@par@stopbreaks
  \@ifnextchar +{\@firstoftwo\y@mclosing}\x@mclosing
}
\@ifdefinable\x@mclosing{\def\x@mclosing#1{%
  \noindent\hspace*{\closingindentation}\ignorespaces #1\par
}}
\@ifdefinable\y@mclosing{\def\y@mclosing{%
  \@handwr@box\closingindentation
}}
\newcommand*\closing{\@par@stopbreaks
  \@ifstar{%
    \@closing{\x@msignature *}%
  }{%
    \@ifnextchar +{%
      \@firstoftwo{\y@mclosing \y@msignature}%
    }{%
      \@ifnextchar -{%
        \@firstoftwo{\@closing \y@msignature}%
      }{%
        \@closing{\x@msignature {}}%
      }%
    }%
  }%
}
\@ifdefinable\@closing{\def\@closing#1#2{\x@mclosing{#2}#1}}
\@ifdefinable\@handwr@box{\def\@handwr@box#1{%
  \vskip .5\baselineskip
  \setbox\z@\vbox{%
    \hrule\@height .1\p@ \@depth .1\p@ \@width 3\p@
  }%
  \wd\z@\z@ \ht\z@\z@ \dp\z@\z@ \noindent\hspace*{#1}\box\z@\par
  \vskip .5\baselineskip\vskip\z@skip
}}
\newcommand\@cc@encl[2]{\par
  \noindent\parbox[t]{\textwidth}{%
    \@hangfrom{\normalfont\@safe@space{#1}\enspace}%
    \ignorespaces #2\strut
  }\par
}
\newcommand*\cc  [1][\ccname]  {\@cc@encl{#1}}
\newcommand*\encl[1][\enclname]{\@cc@encl{#1}}
\newenvironment{enclosures}[1][\enclname]{%
  \baseenclosures[#1]{}%
}{%
  \endbaseenclosures
}
\newenvironment{baseenclosures}[2][\enclname]{\par
  \addpenalty{-\@lowpenalty}%
  \addvspace{\bigskipamount}%
  \startbreaks
  \parskip\z@skip
  {\parindent\z@ #1\par}%
  \list{\labelenumi}{%
    \usecounter{enumi}%
    \@beginparpenalty\@M
    \@itempenalty-\@lowpenalty
    \@endparpenalty-\@medpenalty
%% ( paren match
    \renewcommand*\labelenumi{\theenumi)}%
    #2%
  }%
}{%
  \endlist
  \aftergroup\startbreaks
}
\newcommand*\ps{\par\startbreaks\parindent\z@}
\newcommand*\@PS@rigid [1][\PSname]{%
  {\normalfont\@safe@space{#1}\enspace}\ignorespaces
}
\newcommand*\@PS@rubber[1][\PSname]{%
  \@safe@space{#1}\space\ignorespaces
}
\newcommand*\PS{%
  \ps\@ifstar{\@PS@rubber}{\@PS@rigid}%
}
\newcommand*\stopletter{}
\newcommand*\returnaddress{\thesenderaddress}
\@ifdefinable\@emptyaddrlabels@err{\def\@emptyaddrlabels@err{%
  \advance \@cdp@gencount \m@ne
  \ClassError{\@letteracdp}{%
    Counter emptyaddrlabels out of range%
  }{%
    The counter emptyaddrlabels holds
    the number of labels\MessageBreak
    to leave blank when starting to print
    the address labels\MessageBreak
    (e.g., because some labels
    have already been peeled off).\MessageBreak
    For the label format you chose,
    it must lie in the range\MessageBreak
    0..\number\@cdp@gencount\space (inclusive),
    but presently its value is \number\c@emptyaddrlabels.\MessageBreak
    It will therefore be ignored;
    type \space <return> \space to proceed.%
  }%
}}
\newcommand*\skipemptylabels{%
  \@cdp@gencount \c@addrlabelrows
  \multiply \@cdp@gencount \c@addrlabelcolumns
  \ifnum\c@emptyaddrlabels<\z@
    \@emptyaddrlabels@err
  \else\ifnum\c@emptyaddrlabels<\@cdp@gencount
    \begingroup
      \let\ifactuallabel\@secondoftwo
      \@whilenum\c@totallabel<\c@emptyaddrlabels\do{\@mlabel{}{}}%
    \endgroup
  \else
    \@emptyaddrlabels@err
  \fi\fi
}
\newenvironment*{baselabels}{%
  \cleardoubleemptypage
  \c@page\@ne
  \typeout{Address Labels}%
  \pagestyle{empty}%
  \textwidth \c@addrlabelcolumns\addrlabelwidth
  \count@ \c@addrlabelcolumns
  \advance \count@ \m@ne
  \ifnum\count@>\z@
    \advance \textwidth \count@\addrlabelshsep
  \fi
  \linewidth\textwidth \hsize\textwidth
  \oddsidemargin -1in%
  \advance \oddsidemargin \addrlabelsleftmargin
  \evensidemargin \oddsidemargin
  \@totalleftmargin\z@
  \leftskip\z@skip \rightskip\z@skip \@rightskip\z@skip
  \parfillskip\@flushglue
  \textheight \c@addrlabelrows\addrlabelheight
  \count@ \c@addrlabelrows
  \advance \count@ \m@ne
  \ifnum\count@>\z@
    \advance \textheight \count@\addrlabelsvsep
  \fi
  \@colht\textheight  \@colroom\textheight \vsize\textheight
  \headsep \z@
  \headheight \z@
  \footskip \z@
  \topmargin -1in%
  \advance \topmargin \addrlabelstopmargin
  \ifcase \@ptsize\relax
    \normalsize
  \or
    \small
  \or
    \footnotesize
  \fi
  \parindent \z@
  \baselineskip \z@skip
  \lineskip \z@skip
  \boxmaxdepth \z@
  \raggedright
  \fboxrule \z@
  \fboxsep \addrlabelborder
  \addrlabeltrimwidth \addrlabelwidth
  \advance \addrlabeltrimwidth -2\addrlabelborder
  \addrlabeltrimheight \addrlabelheight
  \advance \addrlabeltrimheight -2\addrlabelborder
  \setcounter{totallabel}{\z@}%
  \setcounter{label}{\z@}%
  \setcounter{letter}{\z@}%
  \noindent
  \skipemptylabels
}{%
  \@killglue\clearpage
}
\newenvironment*{labels}{\baselabels}{\endbaselabels}
\let\@beginlabels=\relax
\let\@endlabels=\relax
\newenvironment*{labelgroup}{\stepcounter{letter}}{}
\let\@beginlabelgroup=\relax
\let\@endlabelgroup=\relax
\newcommand*\labeltab{\@killglue
  \ifnum\c@totallabel>\z@
    \count@ \c@totallabel
    \divide \count@ \c@addrlabelcolumns
    \multiply \count@ -\c@addrlabelcolumns
    \advance \count@ \c@totallabel
    \ifnum\count@=\z@
      \par\vskip\addrlabelsvsep\noindent
    \else
      \hskip\addrlabelshsep
    \fi
  \fi
  \stepcounter{totallabel}%
  \stepcounter{label}%
}
\let\ifactuallabel\@firstoftwo
\newcommand\basemlabel[2]{%
  \begingroup
    \def\startaddrlabel{\par
      \noindent \vrule\@height\topskip \@depth\z@ \@width\z@ \par
      \vskip-\baselineskip \vskip\z@skip
    }%
    \def\stopaddrlabel{\par
      \ifnum\prevdepth>\z@
        \kern -\prevdepth
        \prevdepth\z@
      \fi
    }%
    \labeltab\mlabel{\ignorespaces #1}{\ignorespaces #2}%
  \endgroup
}
\newcommand\mlabel[2]{%
  \fbox{%
    \parbox[c][\addrlabeltrimheight]{\addrlabeltrimwidth}{%
      \raggedright\startaddrlabel #2\stopaddrlabel
    }%
  }%
}
\let\@mlabel=\@gobbletwo
\normalfont \normalsize
\setlength\leftmargini  {2em}
\setlength\leftmarginii {2em}
\setlength\leftmarginiii{2em}
\setlength\leftmarginiv {1.75em}
\setlength\leftmarginv  {1.5em}
\setlength\leftmarginvi {1.5em}
\setlength\leftmargin   {\leftmargini}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\setlength\partopsep{\z@skip}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\def\@listI{\leftmargin\leftmargini
            \parsep \smallskipamount
            \topsep \medskipamount
            \itemsep\smallskipamount}
\let\@listi\@listI
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep\smallskipamount
              \parsep\z@skip}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}
\renewcommand*\theenumi{\@arabic\c@enumi}
\renewcommand*\theenumii{\@alph\c@enumii}
\renewcommand*\theenumiii{\@roman\c@enumiii}
\renewcommand*\theenumiv{\@Alph\c@enumiv}
\newcommand*\labelenumi{\theenumi.}
\newcommand*\labelenumii{(\theenumii)}
\newcommand*\labelenumiii{\theenumiii.}
\newcommand*\labelenumiv{\theenumiv.}
\renewcommand*\p@enumii{\theenumi}
\renewcommand*\p@enumiii{\theenumi(\theenumii)}
\renewcommand*\p@enumiv{\p@enumiii\theenumiii}
\newcommand*\labelitemi{\textbullet}
\newcommand*\labelitemii{\normalfont\bfseries \textendash}
\newcommand*\labelitemiii{\textasteriskcentered}
\newcommand*\labelitemiv{\textperiodcentered}
\newenvironment*{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newenvironment*{verse}
               {\let\\\@centercr
                \list{}{\setlength\itemsep{\z@skip}%
                        \setlength\itemindent{-15\p@}%
                        \setlength\listparindent{\itemindent}%
                        \setlength\rightmargin{\leftmargin}%
                        \addtolength\leftmargin{15\p@}}%
                \item[]}
               {\endlist}
\newenvironment*{quotation}
               {\list{}{\setlength\listparindent{1.5em}%
                        \setlength\itemindent{\listparindent}%
                        \setlength\rightmargin{\leftmargin}}%
                \item[]}
               {\endlist}
\newenvironment*{quote}
               {\list{}{\setlength\rightmargin{\leftmargin}}%
                \item[]}
               {\endlist}
\setlength\parindent{2em}
\setlength\parskip{\z@ plus \p@}
\setlength\columnsep{10\p@}
\setlength\columnseprule{\z@}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\renewcommand*\theequation{\@arabic\c@equation}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\relax}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\relax}
\DeclareRobustCommand*{\cal}{\@fontswitch{\relax}{\mathcal}}
\DeclareRobustCommand*{\mit}{\@fontswitch{\relax}{\mathnormal}}
\renewcommand*\footnoterule{%
  \kern-\p@
  \hrule \@width .4\columnwidth
  \kern .6\p@}
\long\def\@makefntext#1{%
    \noindent
    \hangindent 5\p@
    \hb@xt@5\p@{\hss\@makefnmark}#1}
\newcommand*\subjectname     {Oggetto:}
\newcommand*\registeredname  {Raccomandata}
\newcommand*\registeredRRname{\registeredname~A.R.}
\newcommand*\andccname       {e~p.~c.}
\newcommand*\ccname          {P.~c.:}
\newcommand*\enclname        {Allegati:}
\newcommand*\PSname          {P.S.:}
\newcommand*\headtoname      {A:}
\newcommand*\lettername      {Lettera}
\newcommand*\today{\number\day~\ifcase\month\or
  gennaio\or febbraio\or marzo\or aprile\or maggio\or giugno\or
  luglio\or agosto\or settembre\or ottobre\or novembre\or dicembre\fi
  \space\number\year}
\let\do\@undefined
\pagestyle{plain}
\pagenumbering{arabic}
\raggedbottom
\onecolumn
\endinput
%%
%% End of file `letteracdp.cls'.
