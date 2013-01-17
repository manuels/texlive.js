%%
%% This is file `facsimile.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% facsimile.dtx  (with options: `facsimile')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from facsimile.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file facsimile.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
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
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{facsimile}[2003/04/25 v1.1 Fax class (TBr)]
\let\@emptyauthor=\@author
\newif\iff@xlanguageset\f@xlanguagesetfalse
\newcommand{\f@xafrikaans}{%
  \def\datename{datum}%
  \def\onepagename{bladsy}%
  \def\pagesname{bladsye}%
  \def\notename{nota}%
  \def\ofname{van}%
  \def\fromname{van}%
}
\DeclareOption{afrikaans}{\f@xafrikaans\f@xlanguagesettrue}
\newcommand{\f@xdutch}{%
  \def\datename{datum}%
  \def\onepagename{bladzijde}%
  \def\pagesname{bladzijden}%
  \def\notename{opmerking}%
  \def\ofname{van}%
  \def\fromname{van}%
}
\DeclareOption{dutch}{\f@xdutch\f@xlanguagesettrue}
\newcommand{\f@xenglish}{%
  \def\datename{date}%
  \def\onepagename{page}%
  \def\pagesname{pages}%
  \def\notename{note}%
  \def\ofname{of}%
  \def\fromname{from}%
}
\DeclareOption{english}{\f@xenglish\f@xlanguagesettrue}
\DeclareOption{USenglish}{\f@xenglish\f@xlanguagesettrue}
\DeclareOption{american}{\f@xenglish\f@xlanguagesettrue}
\DeclareOption{UKenglish}{\f@xenglish\f@xlanguagesettrue}
\DeclareOption{british}{\f@xenglish\f@xlanguagesettrue}
\DeclareOption{canadian}{\f@xenglish\f@xlanguagesettrue}
\newcommand{\f@xfrench}{%
  \def\datename{date}%
  \def\pagename{page}%
  \def\pagesname{pages}%
  \def\notename{note}%
  \def\ofname{de}%
  \def\fromname{de}%
}
\DeclareOption{french}{\f@xfrench\f@xlanguagesettrue}
\DeclareOption{frenchb}{\f@xfrench\f@xlanguagesettrue}
\newcommand{\f@xgerman}{%
  \def\datename{Datum}%
  \def\onepagename{Seite}%
  \def\pagesname{Seiten}%
  \def\notename{Bemerkung}%
  \def\ofname{von}%
  \def\fromname{von}%
}
\DeclareOption{german}{\f@xgerman\f@xlanguagesettrue}
\DeclareOption{germanb}{\f@xgerman\f@xlanguagesettrue}
\DeclareOption{ngerman}{\f@xgerman\f@xlanguagesettrue}
\DeclareOption{austrian}{\f@xgerman\f@xlanguagesettrue}
\DeclareOption{naustrian}{\f@xgerman\f@xlanguagesettrue}
\newcommand{\f@xitalian}{%
  \def\datename{data}%
  \def\onepagename{pagina}%
  \def\pagesname{pagine}%
  \def\notename{nota}%
  \def\ofname{di}%
  \def\fromname{da}%
}
\DeclareOption{italian}{\f@xitalian\f@xlanguagesettrue}
\newcommand{\f@xportuges}{%
  \def\datename{data}%
  \def\onepagename{p\'agina}%
  \def\pagesname{p\'aginas}%
  \def\notename{nota}%
  \def\ofname{de}%
  \def\fromname{de}%
}
\DeclareOption{portuges}{\f@xportuges\f@xlanguagesettrue}
\DeclareOption{portuguese}{\f@xportuges\f@xlanguagesettrue}
\DeclareOption{brazilian}{\f@xportuges\f@xlanguagesettrue}
\DeclareOption{brazil}{\f@xportuges\f@xlanguagesettrue}
\newcommand{\f@xspanish}{%
  \def\datename{fecha}%
  \def\onepagename{p\'agina}%
  \def\pagesname{p\'aginas}%
  \def\notename{nota}%
  \def\ofname{de}%
  \def\fromname{de}%
}
\DeclareOption{spanish}{\f@xspanish\f@xlanguagesettrue}
\newcommand{\f@xswedish}{%
  \def\datename{datum}%
  \def\onepagename{sida}%
  \def\pagesname{sidor}%
  \def\notename{notering}%
  \def\ofname{av}%
  \def\fromname{fr\aa n}%
}
\DeclareOption{swedish}{\f@xswedish\f@xlanguagesettrue}
\newcommand{\datename}{date}
\newcommand{\onepagename}{page}
\newcommand{\pagesname}{pages}
\newcommand{\notename}{note}
\newcommand{\ofname}{of}
\newcommand{\fromname}{from}
\AtBeginDocument{%
  \@ifpackageloaded{babel}{%
    \addto\extrasafrikaans{\f@xafrikaans}%
    %
    \addto\extrasdutch{\f@xdutch}%
    %
    \addto\extrasenglish{\f@xenglish}%
    \addto\extrasUSenglish{\f@xenglish}%
    \addto\extrasamerican{\f@xenglish}%
    \addto\extrasUKenglish{\f@xenglish}%
    \addto\extrasbritish{\f@xenglish}%
    \addto\extrascanadian{\f@xenglish}%
    %
    \addto\extrasfrench{\f@xfrench}%
    \addto\extrasfrancais{\f@xfrench}%
    \addto\extrascanadien{\f@xfrench}%
    \addto\extrasacadian{\f@xfrench}%
    %
    \addto\extrasgerman{\f@xgerman}%
    \addto\extrasngerman{\f@xgerman}%
    \addto\extrasaustrian{\f@xgerman}%
    \addto\extrasnaustrian{\f@xgerman}%
    %
    \addto\extrasitalian{\f@xitalian}%
    %
    \addto\extrasportuges{\f@xportuges}%
    \addto\extrasportuguese{\f@xportuges}%
    \addto\extrasbrazilian{\f@xportuges}%
    \addto\extrasbrazil{\f@xportuges}%
    %
    \addto\extrasspanish{\f@xspanish}%
    %
    \addto\extrasswedish{\f@xswedish}%
  }{\iff@xlanguageset\else
    \@ifpackageloaded{german}{\f@xgerman}{%
      \@ifpackageloaded{ngerman}{\f@xgerman}{%
      }}\fi}%
}
\newcommand{\f@xfontsize}{12pt}
\newcommand{\f@xbaseclassname}{article}
\DeclareOption{10pt}{\renewcommand{\f@xfontsize}{10pt}}
\DeclareOption{11pt}{\renewcommand{\f@xfontsize}{11pt}}
\DeclareOption{12pt}{\renewcommand{\f@xfontsize}{12pt}}
\DeclareOption{koma}{\renewcommand{\f@xbaseclassname}{scrartcl}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}%
                                   {\f@xbaseclassname}}
\ExecuteOptions{12pt}
\ProcessOptions\relax
\LoadClass[\f@xfontsize]{\f@xbaseclassname}
\newcommand{\faxnotetext}{}
\newcommand{\f@xsubject}{\ClassError{facsimile}%
  {No fax subject given}{}\textbf{??}}
\newcommand{\f@xsubjectshort}{\textbf{??}}
\newcommand{\f@xfrom}{\ClassError{facsimile}%
  {No fax sender given}{}
  \gdef\f@xfrom{from:&\textbf{??}\\}\f@xfrom}
\newcommand{\f@xto}{\ClassError{facsimile}%
  {No fax recipient given}{}
  \gdef\f@xto{to:&\textbf{??}\\}\f@xto}
\newcommand*{\faxsubject}[2][\f@xsubject]{
  \renewcommand{\f@xsubject}{#2}
  \renewcommand{\f@xsubjectshort}{#1}}
\newcommand*{\faxto}[1]{\renewcommand{\f@xto}{#1}}
\newcommand*{\faxfrom}[1]{\renewcommand{\f@xfrom}{#1}}
\AtBeginDocument{%
  \InputIfFileExists{facsimile.cfg}{\ClassInfo{facsimile}%
    {Loading configuration file facsimile.cfg}}{}}
\RequirePackage{lastpage}
\newcommand*{\@lstpgno}{%
  \@ifundefined{r@LastPage}{0}{%
    \expandafter\expandafter\expandafter
    \@cdr\csname r@LastPage\endcsname
    \@nil}%
}
\newcommand{\faxheaderfont}{\sffamily}
\newdimen\f@xboxgap \setlength{\f@xboxgap}{1mm}
\newdimen\f@xboxsep \setlength{\f@xboxsep}{2mm}
\newdimen\f@xframethickness \setlength{\f@xframethickness}{0.3mm}
\newcommand{\f@xframebox}[3][]{\hbox to #2{%
    \vrule width \f@xframethickness
    \vbox{\hrule height \f@xframethickness
      \vskip\f@xboxsep
      \hbox{\hskip\f@xboxsep
        \setlength{\@tempdima}{#2}%
        \addtolength{\@tempdima}{-2\f@xboxsep}%
        \addtolength{\@tempdima}{-2\f@xframethickness}%
        \setlength{\hsize}{\@tempdima}%
        \vbox #1{\vbox{#3}\vfill}\hskip\f@xboxsep}%
      \vskip\f@xboxsep
      \hrule height \f@xframethickness}%
    \vrule width \f@xframethickness}}
\newcommand{\f@xdoubleframebox}[2]{\hbox to \hsize{%
    \setlength{\@tempdima}{0.5\hsize}%
    \addtolength{\@tempdima}{-0.5\f@xboxgap}%
    \setlength{\@tempdimb}{\@tempdima}%
    \addtolength{\@tempdima}{-2\f@xboxsep}%
    \addtolength{\@tempdima}{-2\f@xframethickness}%
    \setlength{\hsize}{\@tempdima}%
    \newbox\fr@meleft \newbox\fr@meright
    \setbox\fr@meleft=\vbox{\vbox{#1}\hrule height 0pt}%
    \setbox\fr@meright=\vbox{\vbox{#2}\hrule height 0pt}%
    \newdimen\maxfr@meheight
    \setlength{\maxfr@meheight}{\ht\fr@meleft}%
    \ifdim\maxfr@meheight<\ht\fr@meright
      \setlength{\maxfr@meheight}{\ht\fr@meright}%
    \fi
    \f@xframebox[to \maxfr@meheight]{\@tempdimb}{#1}%
    \hskip\f@xboxgap
    \f@xframebox[to \maxfr@meheight]{\@tempdimb}{#2}%
  }}
\newcommand{\makefaxtitle}{\begingroup
  \faxheaderfont\parskip0pt\parindent0pt
  \centerline{\LARGE\bfseries\f@xsubject}\vskip2ex
  \newdimen\halff@xboxwidth
  \setlength{\halff@xboxwidth}{0.5\hsize}
  \addtolength{\halff@xboxwidth}{-0.5\f@xboxgap}
  \vbox{%
    \f@xdoubleframebox{\f@xto}{\f@xfrom}%
    \nointerlineskip\vskip\f@xboxgap
    \f@xdoubleframebox{%
      \centerline{\textbf{\expandafter
          \MakeUppercase\datename:}\quad\@date}}%
    {%
      \centerline{\textbf{Fax:}\quad
        \pageref{LastPage}~\ifcase\@lstpgno \pagesname
        \or \onepagename \else \pagesname \fi}}%
    \nointerlineskip\vskip\f@xboxgap
    \ifx\faxnotetext\@empty\else
      \f@xframebox{\hsize}{%
        \setbox\@tempboxa\hbox{\textbf{\expandafter
            \MakeUppercase\notename:}}%
        \@tempdima=\ht\@tempboxa
        \framebox{\vrule height \@tempdima width 0pt%
          \smash{\unhbox\@tempboxa}}%
        \hskip1em plus 0.2em\sloppy\hbadness10000\faxnotetext}%
    \fi
  }\endgroup}
\setlength\parskip{0.7em}
\setlength\parindent{0\p@}
\newdimen\longindentation
\longindentation=.5\textwidth
\newdimen\indentedwidth
\indentedwidth=\textwidth
\advance\indentedwidth -\longindentation
\newcommand*{\opening}[1]{\vspace{2\parskip}%
  #1\par\nobreak\vspace{0.5\parskip}\nobreak}
\newcommand*{\stopbreaks}{%
  \interlinepenalty\@M
  \def\par{\@@par\nobreak}%
  \let\\\@nobreakcr
  \let\vspace\@nobreakvspace}
\DeclareRobustCommand\@nobreakvspace
   {\@ifstar\@nobreakvspacex\@nobreakvspacex}
\def\@nobreakvspacex#1{%
  \ifvmode
    \nobreak\vskip #1\relax
  \else
    \@bsphack\vadjust{\nobreak\vskip #1}\@esphack
  \fi}
\def\@nobreakcr{\@ifstar{\@normalcr*}{\@normalcr*}}
\newcommand{\fromsig}{} \let\fromsig\@empty
\AtBeginDocument{\ifx\@empty\fromsig
  \ifx\@author\@emptyauthor\else\def\fromsig{\@author}\fi\fi}
\let\closinghook\@empty
\newcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
  \stopbreaks
  \noindent
  \ifx\@empty\fromaddress\else
  \hspace*{\longindentation}\fi
  \parbox{\indentedwidth}{\raggedright
       \ignorespaces #1\ifx\@empty\closinghook
         \\[6\medskipamount]\else\\\relax\closinghook\fi%
       \fromsig\strut}%
   \par}
\RequirePackage{fancyhdr}
\AtBeginDocument{\pagestyle{fancy}}
\fancyhf{}
\fancyhead[LO]{\leavevmode
  \hbox to 0pt{\ifx\@author\@emptyauthor
    \else\expandafter\MakeUppercase\fromname\
    \@author: \fi\emph{\f@xsubjectshort}\hss}}
\fancyhead[RO]{\leavevmode
  \hbox to 0pt{\hss\onepagename\
    \thepage\ \ofname\ \pageref{LastPage}}}
\fancyfoot[LO]{\leavevmode\hbox to 0pt{\@date\hss}}
\fancyfoot[RO]{\leavevmode
  \hbox to 0pt{\hss\onepagename\
    \thepage\ \ofname\ \pageref{LastPage}}}
\renewcommand{\footrulewidth}{0.4pt}
\setlength{\headheight}{15.5pt}

\endinput
%%
%% End of file `facsimile.cls'.
