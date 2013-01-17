% This class file is provided 'as is' in the event that someone
% wants to compile the documentation that comes with my packages.
% Some of the code is taken from doc.sty
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nlctdoc}[2012/05/21 v1.01 (NLCT)]
\def\@nlctdoc@class{scrartcl}%
\DeclareOption{article}{\def\@nlctdoc@class{scrartcl}}
\DeclareOption{book}{\def\@nlctdoc@class{scrbook}}
\DeclareOption{report}{\def\@nlctdoc@class{scrreprt}}
\DeclareOption{a5paper}{\@latexerr{Option not supported}%
   {}}
\DeclareOption*{%
    \PassOptionsToClass  {\CurrentOption}{\@nlctdoc@class}}
\ProcessOptions
\LoadClass{\@nlctdoc@class}
\RequirePackage{xcolor}
\RequirePackage{fourier}
\RequirePackage{ifpdf}
\ifpdf
  \RequirePackage{cmap}
\else
  \RequirePackage[xhtml,fn-in,css-in,uni-html4,utf8]{tex4ht}
\fi
\@ifundefined{macro@cnt}{}{\endinput}
\catcode`\^^A=14
\AtBeginDocument{\catcode`\^^A=14\relax}
\def\macrocode{\macro@code
   \frenchspacing \@vobeyspaces
   \xmacro@code}
\def\macro@code{%
   \topsep \MacrocodeTopsep
   \@beginparpenalty \predisplaypenalty
   \if@inlabel\leavevmode\fi
   \trivlist \parskip \z@ \item[]%
   \macro@font
   \leftskip\@totalleftmargin \advance\leftskip\MacroIndent
   \rightskip\z@ \parindent\z@ \parfillskip\@flushglue
   \blank@linefalse \def\par{\ifblank@line
                             \leavevmode\fi
                             \blank@linetrue\@@par
                             \penalty\interlinepenalty}
   \obeylines
   \let\do\do@noligs \verbatim@nolig@list
   \let\do\@makeother \dospecials
   \global\@newlistfalse
   \global\@minipagefalse
   \ifcodeline@index
     \everypar{\global\advance\c@CodelineNo\@ne
               \llap{\theCodelineNo\ \hskip\@totalleftmargin}%
               \check@module}%
   \else \everypar{\check@module}%
   \fi
   \init@crossref}
\newif\ifblank@line
\def\endmacrocode{%
                 \ifpm@module \endgroup \pm@modulefalse \fi
                 \everypar{}%
                 \global\@inlabelfalse
                 \endtrivlist
                 \close@crossref}
\@ifundefined{MacroFont}{%
  \if@compatibility
    \def\MacroFont{\small
                   \usefont\encodingdefault
                           \ttdefault
                           \mddefault
                           \updefault
                   }%
  \else
    \def\MacroFont{\fontencoding\encodingdefault
                   \fontfamily\ttdefault
                   \fontseries\mddefault
                   \fontshape\updefault
                   \small}%
  \fi
  }{}
\@ifundefined{AltMacroFont}{%
  \if@compatibility
    \def\AltMacroFont{\small
                      \usefont\encodingdefault
                              \ttdefault
                              \mddefault
                              \sldefault
                      }%
  \else
    \def\AltMacroFont{\fontencoding\encodingdefault
                      \fontfamily\ttdefault
                      \fontseries\mddefault
                      \fontshape\sldefault
                      \small
                      }%
 \fi
  }{}
\AtBeginDocument{\let\macro@font\MacroFont}
\def\check@module{%
  \ifcheck@modules
    \ifpm@module \endgroup \pm@modulefalse \fi
    \expandafter\futurelet\expandafter\next\expandafter\ch@percent
  \fi}
\newif\ifpm@module
\def\DontCheckModules{\check@modulesfalse}
\def\CheckModules{\check@modulestrue}
\newif\ifcheck@modules  \check@modulestrue
\def\ch@percent{%
  \if \percentchar\next
    \expandafter\check@angle
  \fi}
\def\check@angle#1{\futurelet\next\ch@angle}
\begingroup
\catcode`\<\active
\gdef\ch@angle{\ifx<\next
    \expandafter\ch@plus@etc
  \else \percentchar \fi}
\gdef\ch@plus@etc<{\futurelet\next\check@plus@etc}
\gdef\check@plus@etc{%
    \if +\next
      \let\next\pm@module
    \else\if -\next
      \let\next\pm@module
    \else\if *\next
      \let\next\star@module
    \else\if /\next
      \let\next\slash@module
    \else\ifx <\next
      \percentchar
    \else
      \let\next\pm@module
    \fi\fi\fi\fi\fi
    \next}
\endgroup
\begingroup
\catcode`\~=\active
\lccode`\~=`\>
\lowercase{\gdef\pm@module#1~}{\pm@moduletrue
   \Module{#1}\begingroup
     \advance\guard@level\@ne
     \ifnum\guard@level>\c@StandardModuleDepth\AltMacroFont\fi
}
\lowercase{\gdef\star@module#1~}{%
  \Module{#1}%
  \global \advance \guard@level\@ne
  \ifnum \guard@level>\c@StandardModuleDepth
    \global\let\macro@font=\AltMacroFont \macro@font
  \fi}
\catcode`\>=\active
\gdef\slash@module#1>{%
  \Module{#1}%
  \global \advance \guard@level\m@ne
  \ifnum \guard@level=\c@StandardModuleDepth
    \global\let\macro@font\MacroFont  \macro@font
  \fi
}
\endgroup
\newcounter{StandardModuleDepth}
\newcount \guard@level
\@ifundefined{Module}{%
      \def\Module#1{\mod@math@codes$\langle\mathsf{#1}\rangle$}
  }{}
\def\mod@math@codes{\mathcode`\|="226A \mathcode`\&="2026}
\newskip\MacrocodeTopsep \MacrocodeTopsep = 3pt plus 1.2pt minus 1pt
\newdimen\MacroIndent
\settowidth\MacroIndent{\rmfamily\scriptsize 00\ }
\@namedef{macrocode*}{\macro@code\sxmacro@code}
\expandafter\let\csname endmacrocode*\endcsname = \endmacrocode
\catcode`\!=\catcode`\%   ^^A In this section there must not be
                              ^^A any exclamation marks.
                              ^^A
\begingroup
\catcode`\|=\z@ \catcode`\[=\@ne \catcode`\]=\tw@
\catcode`\{=12 \catcode`\}=12
\catcode`\%=12 \catcode`\ =\active \catcode`\\=\active
!%    \end{macrocode*}
!    Next follows the actual definition of  |\macro@code|;
!    notice the
!    use of the new escape character.  We manage to get the argument
!    surrounded by the string |\end{macrocode}|, but at the end
!    however, in spite of the actual characters used during the
!    definition of
!    this macro, |\end| with the argument |{macrocode}|
!    will be executed, to ensure a balanced environment.
!    \begin{macrocode*}
|gdef|xmacro@code#1%    \end{macrocode}[#1|end[macrocode]]
!%    \end{macrocode*}
! \begin{macro}{\sxmacro@code}
!    The definition of |\sxmacro@code| is completely analogous,
!    only
!    here a slightly different terminating string will be used.
!    Note that the space is not active in this environment.
!    \begin{macrocode}
|catcode`| =12
|gdef|sxmacro@code#1%    \end{macrocode*}[#1|end[macrocode*]]
!%    \end{macrocode}
!    because the |\catcode| changes have been made local by
!    commencing a
!    new group, there now follows the matching |\endgroup|
!    in a rather
!    unusual style of writing.
!    \begin{macrocode}
|endgroup
!%    \end{macrocode}
\catcode`\!=12
\def\DescribeMacro{\leavevmode\@bsphack
   \begingroup\MakePrivateLetters\Describe@Macro}
\def\Describe@Macro#1{\endgroup
              \marginpar{\raggedleft\PrintDescribeMacro{#1}}%
              \SpecialUsageIndex{#1}\@esphack\ignorespaces}
\def\DescribeEnv{\leavevmode\@bsphack\begingroup\MakePrivateLetters
  \Describe@Env}
\def\Describe@Env#1{\endgroup
              \marginpar{\raggedleft\PrintDescribeEnv{#1}}%
              \SpecialEnvIndex{#1}\@esphack\ignorespaces}
\reversemarginpar
\setlength\marginparpush{0pt}  \setlength\marginparwidth{8pc}
{\catcode`\|=\z@ \catcode`\\=12
|gdef|bslash{\}}
\def\verbatim{\@beginparpenalty \predisplaypenalty \@verbatim
              \MacroFont \frenchspacing \@vobeyspaces \@xverbatim}
\@namedef{verbatim*}{\@beginparpenalty \predisplaypenalty \@verbatim
              \MacroFont \@sxverbatim}
\def\@verbatim{\trivlist \item[]\if@minipage\else\vskip\parskip\fi
      \leftskip\@totalleftmargin\rightskip\z@
      \parindent\z@\parfillskip\@flushglue\parskip\z@
      \@@par
      \@tempswafalse
 \def\par{\if@tempswa\hbox{}\fi\@tempswatrue\@@par
          \penalty\interlinepenalty
   \check@percent}%
 \obeylines
 \let\do\do@noligs \verbatim@nolig@list
 \let\do\@makeother \dospecials}
{\catcode`\%=12
 \long\gdef\check@percent#1{\ifx #1%\let\next\@empty \else
                                    \let\next=#1\fi \next}}
\def\verb{\relax\ifmmode\hbox\else\leavevmode\null\fi
  \bgroup \let\do\do@noligs \verbatim@nolig@list
    \ttfamily \verb@eol@error \let\do\@makeother \dospecials
    \@ifstar{\@sverb}{\@vobeyspaces \frenchspacing \@sverb}}
\let\verb@balance@group\@empty

\def\verb@egroup{\global\let\verb@balance@group\@empty\egroup}

\begingroup
  \obeylines%
  \gdef\verb@eol@error{\obeylines%
    \def^^M{\verb@egroup\@latex@error{%
           Text for \noexpand\verb command ended by end of line}\@ehc}}%
\endgroup
\def\@sverb#1{%
  \catcode`#1\active  \lccode`\~`#1%
  \gdef\verb@balance@group{\verb@egroup
     \@latex@error{Illegal use of \noexpand\verb command}\@ehc}%
  \aftergroup\verb@balance@group
  \lowercase{\let~\verb@egroup}}
\def\verbatim@nolig@list{\do\`\do\<\do\>\do\,\do\'\do\-}
\def\do@noligs#1{%
  \catcode`#1\active
  \begingroup
     \lccode`\~=`#1\relax
     \lowercase{\endgroup\def~{\leavevmode\kern\z@\char`#1}}}
\newcount\macro@cnt \macro@cnt=0
\def\macro{\begingroup
   \catcode`\\12
   \MakePrivateLetters \m@cro@ \iftrue}
\def\environment{\begingroup
   \catcode`\\12
   \MakePrivateLetters \m@cro@ \iffalse}
\long\def\m@cro@#1#2{\endgroup \topsep\MacroTopsep \trivlist
   \edef\saved@macroname{\string#2}%
  \def\makelabel##1{\llap{##1}}%
  \if@inlabel
    \let\@tempa\@empty \count@\macro@cnt
    \loop \ifnum\count@>\z@
      \edef\@tempa{\@tempa\hbox{\strut}}\advance\count@\m@ne \repeat
    \edef\makelabel##1{\llap{\vtop to\baselineskip
                               {\@tempa\hbox{##1}\vss}}}%
    \advance \macro@cnt \@ne
  \else  \macro@cnt\@ne  \fi
  \edef\@tempa{\noexpand\item[%
     #1%
       \noexpand\PrintMacroName
     \else
       \noexpand\PrintEnvName
     \fi
     {\string#2}]}%
  \@tempa
  \global\advance\c@CodelineNo\@ne
   #1%
      \SpecialMainIndex{#2}\nobreak
      \DoNotIndex{#2}%
   \else
      \SpecialMainEnvIndex{#2}\nobreak
   \fi
  \global\advance\c@CodelineNo\m@ne
  \ignorespaces}
\let\endmacro \endtrivlist
\let\endenvironment\endmacro
\newskip\MacroTopsep     \MacroTopsep = 7pt plus 2pt minus 2pt
\@ifundefined{PrintMacroName}
   {\def\PrintMacroName#1{\strut \MacroFont \string #1\ }}{}
\@ifundefined{PrintDescribeMacro}
   {\def\PrintDescribeMacro#1{\strut \MacroFont \string #1\ }}{}
\@ifundefined{PrintDescribeEnv}
   {\def\PrintDescribeEnv#1{\strut \MacroFont #1\ }}{}
\@ifundefined{PrintEnvName}
   {\def\PrintEnvName#1{\strut \MacroFont #1\ }}{}
\begingroup
\catcode`\~\active
\gdef\SpecialEscapechar#1{%
    \begingroup
     \uccode`\~`#1%
     \uppercase{\gdef\active@escape@char{~}}%
     \escapechar\m@ne  \xdef\special@escape@char{\string#1}%
   \endgroup}
\endgroup
\begingroup   \catcode`\|=\z@  \catcode`\\=\active
|gdef|init@crossref{|catcode`|\|active   |let\|bslash
    |MakePrivateLetters
    |catcode|expandafter`|special@escape@char|active
    |expandafter|let|active@escape@char|scan@macro}
|endgroup
\SpecialEscapechar{\\}
\@ifundefined{MakePrivateLetters}
    {\let\MakePrivateLetters\makeatletter}{}
\def\close@crossref{\SpecialEscapechar\\}
\def\scan@macro{%
   \special@escape@char
   \step@checksum
   \ifscan@allowed
      \let\macro@namepart\@empty
      \def\next{\futurelet\next\macro@switch}%
   \else \let\next\@empty \fi
   \next}
\newif\ifscan@allowed    \scan@allowedtrue
\def\DisableCrossrefs{\@bsphack\scan@allowedfalse\@esphack}
\def\EnableCrossrefs{\@bsphack\scan@allowedtrue
                     \def\DisableCrossrefs{\@bsphack\@esphack}\@esphack}
\def\macro@switch{\ifcat\noexpand\next a%
     \let\next\macro@name
     \else \let\next\short@macro  \fi
   \next}
\begingroup
\catcode`\&=12
\gdef\short@macro#1{\begingroup
   \uccode`\&=\expandafter`\string#1%
   \uppercase{\def\x{\def\macro@namepart{&}}}%
   \expandafter\endgroup\x
   \ifnot@excluded
     \produce@index{#1}\fi
    \scan@allowedfalse#1%
    \scan@allowedtrue }
\endgroup
\def\produce@index#1{%
  \if\noexpand#1\special@escape@char
     \scan@allowedfalse \it@is@a\special@escape@char \else
     \if\noexpand#1\bslash \it@is@a\bslash \else
       \if\noexpand#1\space \it@is@a\space \else
         \ifx#1\par
         \it@is@a\space \else
         \ifx#1\relax \else
           \if\noexpand#1\bgroup \LeftBraceIndex \else
             \if\noexpand#1\egroup \RightBraceIndex \else
               \if\noexpand#1\percentchar \PercentIndex \else
                 \it@is@a{\string#1}%
       \fi \fi \fi \fi \fi \fi \fi \fi}
\def\macro@name#1{\edef\macro@namepart{\macro@namepart#1}%
     \futurelet\next\more@macroname}
\def\more@macroname{\ifcat\noexpand\next a%
     \let\next\macro@name
     \else \let\next\macro@finish \fi
     \next}
\def\macro@finish{%
  \macro@namepart
  \ifnot@excluded
     \edef\@tempa{\noexpand\SpecialIndex{\bslash\macro@namepart}}%
     \@tempa  \fi}
\def\DoNotIndex{\begingroup \MakePrivateLetters
    \catcode`\\12
    \do@not@index}
\long\def\do@not@index#1{%
    \endgroup
    \addto@hook\index@excludelist{#1,}}
\long\def\addto@hook#1#2{#1\expandafter{\the#1#2}}
\newtoks\index@excludelist
\index@excludelist{}
\begingroup
\catcode`\|=0%
\catcode`\\=12
|gdef|ifnot@excluded{|expandafter
     |expanded@notin|expandafter{|expandafter
     \|macro@namepart,}{|the|index@excludelist}}
|endgroup
\def\expanded@notin#1#2{%
 \def\in@@##1#1##2##3\in@@{%
  \ifx\expanded@notin##2}%
 \expandafter\in@@#2#1\expanded@notin\in@@}
\@ifundefined{actualchar}{\def\actualchar{=}}{}
\@ifundefined{quotechar}{\def\quotechar{!}}{}
\@ifundefined{levelchar}{\def\levelchar{>}}{}
\@ifundefined{encapchar}{\def\encapchar{|}}{}
\@ifundefined{verbatimchar}{\def\verbatimchar{+}}{}
\def\SpecialIndex#1{\@bsphack\special@index{\expandafter\@gobble
                                      \string#1\actualchar
      \string\verb\quotechar*\verbatimchar\string#1\verbatimchar}%
    \@esphack}

\def\SpecialMainIndex#1{\@bsphack\SpecialIndex@{#1}{\encapchar main}%
                        \@esphack}
\begingroup
 \catcode`\|=0
 \catcode`\\=12
 |gdef|@SpecialIndexHelper@#1#2|@nil{%
   |if |noexpand#1\%
     |gdef|@gtempa{#2}%
   |else
     |begingroup
       |escapechar|m@ne
       |expandafter|gdef|expandafter|@gtempa|expandafter{|string#1#2}%
     |endgroup
   |fi}
|endgroup
\def\SpecialIndex@#1#2{%
   \@SpecialIndexHelper@#1\@nil
   \def\@tempb{ }%
   \ifcat \@tempb\@gtempa
      \special@index{\quotechar\space\actualchar
                     \string\verb\quotechar*\verbatimchar
                     \quotechar\bslash\quotechar\space\verbatimchar#2}%
   \else
     \def\@tempb##1##2\relax{\ifx\relax##2\relax
          \def\@tempc{\special@index{\quotechar##1\actualchar
                      \string\verb\quotechar*\verbatimchar
                      \quotechar\bslash\quotechar##1\verbatimchar#2}}%
        \else
          \def\@tempc{\special@index{##1##2\actualchar
                       \string\verb\quotechar*\verbatimchar
                       \bslash##1##2\verbatimchar#2}}%
        \fi}%
     \expandafter\@tempb\@gtempa\relax
     \@tempc
   \fi}
\def\SpecialMainEnvIndex#1{\@bsphack\special@index{%
                                      #1\actualchar
                                      {\string\ttfamily\space#1}
                                         (environment)%
                                      \encapchar main}%
    \special@index{environments:\levelchar#1\actualchar{%
                   \string\ttfamily\space#1}\encapchar
           main}\@esphack}
\def\SpecialUsageIndex#1{\@bsphack
   {\let\special@index\index\SpecialIndex@{#1}{\encapchar usage}}%
   \@esphack}
\def\SpecialEnvIndex#1{\@bsphack
    \index{#1\actualchar{\protect\ttfamily#1}
           (environment)\encapchar usage}%
    \index{environments:\levelchar#1\actualchar{\protect\ttfamily#1}\encapchar
           usage}\@esphack}
\def\SortIndex#1#2{\index{#1\actualchar#2}}
\def\it@is@a#1{\special@index{\quotechar #1\actualchar
                          \string\verb\quotechar*\verbatimchar
                          \quotechar\bslash\quotechar#1\verbatimchar}}
\@ifundefined{LeftBraceIndex}{\def\LeftBraceIndex{%
   \special@index{\bgroup\actualchar\string\verb\quotechar*\verbatimchar
          \quotechar\bslash{\verbatimchar\string\iffalse}\string\fi}}}{}

\@ifundefined{RightBraceIndex}{\def\RightBraceIndex{%
 \special@index{\egroup\actualchar\string\iffalse{\string\fi\string\verb
           \quotechar*\verbatimchar\quotechar\bslash}\verbatimchar}}}{}
\@ifundefined{PercentIndex}
  {\def\PercentIndex{\it@is@a\percentchar}}{}
\def\OldMakeindex{\def\PercentIndex{%
    \special@index{\quotechar\percentchar\actualchar\string\verb
           \quotechar*\verbatimchar\quotechar\bslash
           \percentchar\percentchar\verbatimchar}}}
{\catcode`\%=12 \gdef\percentchar{%}}
\newif\ifhave@multicol
\IfFileExists{multicol.sty}{\have@multicoltrue
                            \RequirePackage{multicol}%
                           }{}

\newdimen\IndexMin         \IndexMin       = 80pt
\newcount\c@IndexColumns   \c@IndexColumns = 3
\ifhave@multicol
  \renewenvironment{theindex}
    {\begin{multicols}\c@IndexColumns[\index@prologue][\IndexMin]%
      \IndexParms \let\item\@idxitem \ignorespaces}%
    {\end{multicols}}
\else
  \typeout{Can't find multicol.sty -- will use normal index layout if
     necessary.}
  \def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
    \columnseprule \z@  \columnsep 35\p@
    \twocolumn[\index@prologue]%
    \IndexParms \let\item\@idxitem \ignorespaces}
  \def\endtheindex{\if@restonecol\onecolumn\else\clearpage\fi}
\fi
\long\def\IndexPrologue#1{\@bsphack\def\index@prologue{#1}\@esphack}
\@ifundefined{index@prologue}
     {\def\index@prologue{\section*{Index}%
                 \markboth{Index}{Index}%
                 Numbers written in italic refer to the page
                 where the corresponding entry is described;
                 numbers underlined refer to the
                 \ifcodeline@index
                   code line of the
                 \fi
                 definition; numbers in roman refer to the
                 \ifcodeline@index
                   code lines
                 \else
                   pages
                 \fi
                 where the entry is used.
                 }}{}
\@ifundefined{IndexParms}
    {\def\IndexParms{%
       \parindent \z@
       \columnsep 15pt
       \parskip 0pt plus 1pt
       \rightskip 15pt
       \mathsurround \z@
       \parfillskip=-15pt
        \small
       \def\@idxitem{\par\hangindent 30pt}%
       \def\subitem{\@idxitem\hspace*{15pt}}%
       \def\subsubitem{\@idxitem\hspace*{25pt}}%
       \def\indexspace{\par\vspace{10pt plus 2pt minus 3pt}}%
      }}{}
\def\efill{\hfill\nopagebreak}%
\def\dotfill{\leaders\hbox to.6em{\hss .\hss}\hskip\z@ plus  1fill}%
\def\dotfil{\leaders\hbox to.6em{\hss .\hss}\hfil}%
\def\pfill{\unskip~\dotfill\penalty500\strut\nobreak
               \dotfil~\ignorespaces}%
\def\*{\leavevmode\lower.8ex\hbox{$\,\widetilde{\ }\,$}}

\@ifundefined{main}{\def\main#1{\underline{\hyperpage{#1}}}}{}
\@ifundefined{usage}{\def\usage#1{\textit{\hyperpage{#1}}}}{}

\def\PrintIndex{\@input@{\jobname.ind}%
                \global\let\PrintIndex\@empty}
\def\changes{\@bsphack\begingroup\@sanitize
   \catcode`\\\z@ \catcode`\ 10 \MakePercentIgnore
   \changes@}
\def\changes@#1#2#3{%
  \protected@edef\@tempa{\noexpand\glossary{#1\levelchar
                                 \ifx\saved@macroname\@empty
                                   \space
                                   \actualchar
                                   \generalname
                                 \else
                                   \expandafter\@gobble
                                   \saved@macroname
                                   \actualchar
                                   \string\verb\quotechar*%
                                   \verbatimchar\saved@macroname
                                   \verbatimchar
                                 \fi
                                 :\levelchar #3}}%
  \@tempa\endgroup\@esphack}
\def\saved@macroname{}
\def\generalname{General}
\let\RecordChanges\makeglossary
\newdimen\GlossaryMin         \GlossaryMin       = 80pt
\newcount\c@GlossaryColumns   \c@GlossaryColumns = 2
\ifhave@multicol
  \newenvironment{theglossary}{%
    \begin{multicols}\c@GlossaryColumns
                     [\glossary@prologue][\GlossaryMin]%
    \GlossaryParms \let\item\@idxitem \ignorespaces}%
   {\end{multicols}}
\else
  \newenvironment{theglossary}{%
      \@restonecoltrue\if@twocolumn\@restonecolfalse\fi
      \columnseprule \z@  \columnsep 35\p@
      \twocolumn[\glossary@prologue]%
      \GlossaryParms \let\item\@idxitem \ignorespaces}
    {\if@restonecol\onecolumn\else\clearpage\fi}
\fi
\long\def\GlossaryPrologue#1{\@bsphack
                             \def\glossary@prologue{#1}%
                             \@esphack}
\@ifundefined{glossary@prologue}
     {\def\glossary@prologue{\section*{{Change History}}%
                 \markboth{{Change History}}{{Change History}}%
                 }}{}
\@ifundefined{GlossaryParms}{\let\GlossaryParms\IndexParms}{}
\def\PrintChanges{\@input@{\jobname.gls}%
                  \global\let\PrintChanges\@empty}
\newcommand\AlsoImplementation{%
   \long\def\StopEventually##1{\@bsphack\gdef\Finale{##1%
                  \check@checksum}%
              \init@checksum
              \@esphack}%
         }
\AlsoImplementation
\def\OnlyDescription{\@bsphack\long\def\StopEventually##1{%
           ##1\endinput}\@esphack}
\let\Finale\relax
\ifx\l@nohyphenation\undefined
  \newlanguage\l@nohyphenation
\fi
\DeclareRobustCommand\meta[1]{%
     \ensuremath\langle
     \ifmmode \expandafter \nfss@text \fi
     {%
      \meta@font@select
      \edef\meta@hyphen@restore
        {\hyphenchar\the\font\the\hyphenchar\font}%
      \hyphenchar\font\m@ne
      \language\l@nohyphenation
      #1\/%
      \meta@hyphen@restore
     }\ensuremath\rangle
}
\def\meta@font@select{\rmfamily\itshape}
\def\IndexInput#1{%
     \begingroup \macro@code
   \frenchspacing \@vobeyspaces
     \input{#1}\endmacrocode
     \endgroup}
\@ifundefined{ps@titlepage}
    {\let\ps@titlepage=\ps@plain}{}
\def\MakeShortVerb{%
  \@ifstar
    {\def\@shortvrbdef{\verb*}\@MakeShortVerb}%
    {\def\@shortvrbdef{\verb}\@MakeShortVerb}}
\def\@MakeShortVerb#1{%
  \expandafter\ifx\csname cc\string#1\endcsname\relax
    \@shortvrbinfo{Made }{#1}\@shortvrbdef
    \add@special{#1}%
    \expandafter
    \xdef\csname cc\string#1\endcsname{\the\catcode`#1}%
    \begingroup
      \catcode`\~\active  \lccode`\~`#1%
      \lowercase{%
      \global\expandafter\let
         \csname ac\string#1\endcsname~%
      \expandafter\gdef\expandafter~\expandafter{\@shortvrbdef~}}%
    \endgroup
    \global\catcode`#1\active
  \else
    \@shortvrbinfo\@empty{#1 already}{\@empty\verb(*)}%
  \fi}
\def\DeleteShortVerb#1{%
  \expandafter\ifx\csname cc\string#1\endcsname\relax
    \@shortvrbinfo\@empty{#1 not}{\@empty\verb(*)}%
  \else
    \@shortvrbinfo{Deleted }{#1 as}{\@empty\verb(*)}%
    \rem@special{#1}%
    \global\catcode`#1\csname cc\string#1\endcsname
    \global \expandafter\let \csname cc\string#1\endcsname \relax
    \ifnum\catcode`#1=\active
      \begingroup
        \catcode`\~\active   \lccode`\~`#1%
        \lowercase{%
          \global\expandafter\let\expandafter~%
          \csname ac\string#1\endcsname}%
      \endgroup \fi \fi}
\def\@shortvrbinfo#1#2#3{%
  \PackageInfo{doc}{%
     #1\expandafter\@gobble\string#2 a short reference
                                          for \expandafter\string#3}}
\def\add@special#1{%
  \rem@special{#1}%
  \expandafter\gdef\expandafter\dospecials\expandafter
    {\dospecials \do #1}%
  \expandafter\gdef\expandafter\@sanitize\expandafter
    {\@sanitize \@makeother #1}}
\def\rem@special#1{%
  \def\do##1{%
    \ifnum`#1=`##1 \else \noexpand\do\noexpand##1\fi}%
  \xdef\dospecials{\dospecials}%
  \begingroup
    \def\@makeother##1{%
      \ifnum`#1=`##1 \else \noexpand\@makeother\noexpand##1\fi}%
    \xdef\@sanitize{\@sanitize}%
  \endgroup}
\def\MakeShortverb{\typeout{*** Switch to \noexpand\MakeShortVerb
                         syntax, this is obsolete ***}\MakeShortVerb}
\def\DeleteShortverb{\typeout{*** Switch to \noexpand\DeleteShortVerb
                         syntax, this is obsolete ***}\DeleteShortVerb}
\def\init@checksum{\relax
    \global\bslash@cnt\z@}
\def\check@checksum{\relax
     \ifnum\check@sum=\z@
       \typeout{**********************************}%
       \typeout{* This macro file has no checksum!}%
       \typeout{* The checksum should be \the\bslash@cnt!}%
       \typeout{**********************************}%
     \else
       \ifnum\check@sum=\bslash@cnt
         \typeout{*******************}%
         \typeout{* Checksum passed *}%
         \typeout{*******************}%
       \else
         \PackageError{doc}{Checksum not passed
                    (\the\check@sum<>\the\bslash@cnt)}%
          {The file currently documented seems to be wrong.^^J%
           Try to get a correct version.}%
       \fi
     \fi
     \global\check@sum\z@}
\newcount\check@sum           \check@sum  = \z@
\newcount\bslash@cnt          \bslash@cnt = \z@
\def\CheckSum#1{\@bsphack\global\check@sum#1\relax\@esphack}
\def\step@checksum{\global\advance\bslash@cnt\@ne}
\def\CharacterTable{\begingroup \CharTableChanges \character@table}
\begingroup
  \catcode`\~=11
  \gdef\character@table#1{\def\used~table{#1}%
      \ifx\used~table\default~table
           \typeout{***************************}%
           \typeout{* Character table correct *}%
           \typeout{***************************}%
      \else
         \PackageError{doc}{Character table corrupted}
                           {\the\wrong@table}
         \show\default~table
         \show\used~table
      \fi
      \endgroup}
  \global\let\CharTableChanges\@empty
  \makeatother
  \gdef\default~table
     {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
      Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
      Digits        \0\1\2\3\4\5\6\7\8\9
      Exclamation   \!     Double quote  \"     Hash (number) \#
      Dollar        \$     Percent       \%     Ampersand     \&
      Acute accent  \'     Left paren    \(     Right paren   \)
      Asterisk      \*     Plus          \+     Comma         \,
      Minus         \-     Point         \.     Solidus       \/
      Colon         \:     Semicolon     \;     Less than     \<
      Equals        \=     Greater than  \>     Question mark \?
      Commercial at \@     Left bracket  \[     Backslash     \\
      Right bracket \]     Circumflex    \^     Underscore    \_
      Grave accent  \`     Left brace    \{     Vertical bar  \|
      Right brace   \}     Tilde         \~}
\endgroup
  \newhelp\wrong@table{Some of the ASCII characters are corrupted.^^J
            I now \string\show\space you both tables for comparison.}
\newif\ifcodeline@index \codeline@indexfalse
\let\CodelineNumbered\codeline@indextrue
\def\codeline@wrindex#1{\if@filesw
        \immediate\write\@indexfile
            {\string\indexentry{#1}%
            {\number\c@CodelineNo}}\fi}
\let\special@index = \@gobble
\def\CodelineIndex{\makeindex
                   \codeline@indextrue
                   \let\special@index\codeline@wrindex}
\def\PageIndex{\makeindex
               \codeline@indexfalse
               \let\special@index\index}
\newcount\c@CodelineNo  \c@CodelineNo\z@
\@ifundefined{theCodelineNo}
  {\ifx\selectfont\undefined
     \def\theCodelineNo{\rmfamily\scriptsize\arabic{CodelineNo}}%
   \else
     \def\theCodelineNo{\reset@font\scriptsize\arabic{CodelineNo}}%
   \fi}
  {}
       \tolerance=1000\relax
{ \catcode`\"=12
  \global\mathcode`\\="705C \global\mathcode`\@="7040 }
\@ifundefined{DocstyleParms}{}{}
\DocstyleParms     \let\DocstyleParms\relax
\@ifundefined{AmSTeX}
   {\def\AmSTeX{\leavevmode\hbox{$\mathcal A\kern-.2em\lower.376ex%
        \hbox{$\mathcal M$}\kern-.2em\mathcal S$-\TeX}}}{}
\@ifundefined{BibTeX}
   {\def\BibTeX{{\rmfamily B\kern-.05em%
    \textsc{i\kern-.025em b}\kern-.08em%
    T\kern-.1667em\lower.7ex\hbox{E}\kern-.125emX}}}{}
\@ifundefined{SliTeX}
   {\def\SliTeX{{\rmfamily S\kern-.06emL\kern-.18em\raise.32ex\hbox
                {\scshape i}\kern -.03em\TeX}}}{}
\@ifundefined{PlainTeX}{\def\PlainTeX{\textsc{Plain}\kern2pt\TeX}}{}
\@ifundefined{Web}{\def\Web{\textsc{Web}}}{}
\def\MakePercentIgnore{\catcode`\%9\relax}
\def\MakePercentComment{\catcode`\%14\relax}
\def\DocInput#1{\MakePercentIgnore\input{#1}\MakePercentComment}
\def\GetFileInfo#1{%
  \def\filename{#1}%
  \def\@tempb##1 ##2 ##3\relax##4\relax{%
    \def\filedate{##1}%
    \def\fileversion{##2}%
    \def\fileinfo{##3}}%
  \edef\@tempa{\csname ver@#1\endcsname}%
  \expandafter\@tempb\@tempa\relax? ? \relax\relax}
\RequirePackage{dox}
\AtBeginDocument{\MakeShortVerb{\|}}
\DeclareFontShape{OT1}{cmtt}{bx}{n}{<-> ssub * cmtt/m/n}{}
\DeclareFontFamily{OMS}{cmtt}{\skewchar\font 48}  % '60
\DeclareFontShape{OMS}{cmtt}{m}{n}{<-> ssub * cmsy/m/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{n}{<-> ssub * cmsy/b/n}{}
\DeclareFontShape{OT1}{cmss}{m}{it}{<->ssub*cmss/m/sl}{}
\CodelineNumbered
\DisableCrossrefs
\setlength{\textwidth}{355pt}
\addtolength\marginparwidth{30pt}
\addtolength\oddsidemargin{20pt}
\addtolength\evensidemargin{20pt}
\setcounter{StandardModuleDepth}{1}
\def\cmd#1{\cs{\expandafter\cmd@to@cs\string#1}}
\def\cmd@to@cs#1#2{\char\number`#2\relax}
\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\providecommand\marg[1]{%
  {\ttfamily\char`\{}\meta{#1}{\ttfamily\char`\}}}
\providecommand\oarg[1]{%
  {\ttfamily[}\meta{#1}{\ttfamily]}}
\providecommand\parg[1]{%
  {\ttfamily(}\meta{#1}{\ttfamily)}}
\def\oc@scan#1{%
  \ifx\oc@bslash#1%
                      \egroup\let\next\oc@bslash\else
  \ifcat a\noexpand#1%
                      #1\let\next\oc@scan\else
  \ifx\oc@percent#1%
                      \def\next{\char`\%\egroup}%
  \else
                      #1\let\next\egroup
  \fi\fi\fi\next}
\def\oc@bslash{\bgroup\oc@ttf\char`\\\oc@scan}%
\def\oc@verb#1{%
  \catcode`#1\active
  \uccode`\~`#1%
  \uppercase{\def~{{\oc@ttf\char`#1}}}}
\begingroup
  \obeyspaces%
  \catcode`\/=\catcode`\\
  /catcode`/\/active
  /catcode`<=/catcode`{%
  /catcode`>=/catcode`}%
  /catcode`/{/active%
  /catcode`/}/active%
  /gdef/oldc< \end{oldcomments}>%
  /gdef/begmac<    \begin{macrocode}>%
  /gdef/obs</def <</oc@ttf/ >>>%
/endgroup%
\begingroup
  \catcode`\/=\catcode`\\
  \catcode`\\=13
  /catcode`/|=/catcode`/%
  /catcode`/%=13
  /gdef/oldcomments{|
    /makeatletter
    /let/do/oc@verb/dospecials
    /frenchspacing/@vobeyspaces/obs
    /raggedright
    /oc@verb/>|
    /oc@verb/<|
    /let\/oc@bslash
    /let%/oc@percent
    /obeylines
    /parindent/z@
    /ttfamily/expandafter/let/expandafter/oc@ttf/the/font
    /rmfamily
    /hfuzz/maxdimen
    }
/endgroup
\begingroup
  \sloppy%
  \obeylines%
  \gdef\oc@percent#1^^M{%
    \ifvmode%
    \def\commentline{#1}%
    \ifx\commentline\oldc%
    \end{oldcomments}%
    \else%
    \ifx\commentline\begmac%
    \begin{macrocode}%
    \else%
    \leavevmode%
    #1^^M%
    \fi\fi%
    \else%
    {\oc@ttf\char`\%}#1^^M%
    \fi}%
\endgroup%
\@addtoreset{CodelineNo}{part}
\def\partname{File}
\newcommand*{\DocInclude}[1]{%
  \relax
  \clearpage
  \docincludeaux
  \IfFileExists{#1.fdd}{\def\currentfile{#1.fdd}}{\def\currentfile{#1.dtx}}%
  \ifnum\@auxout=\@partaux
    \@latexerr{\string\include\space cannot be nested}\@eha
  \else \@docinclude#1 \fi}
\def\@docinclude#1 {\clearpage
\if@filesw \immediate\write\@mainaux{\string\@input{#1.aux}}\fi
\@tempswatrue\if@partsw \@tempswafalse\edef\@tempb{#1}\@for
\@tempa:=\@partlist\do{\ifx\@tempa\@tempb\@tempswatrue\fi}\fi
\if@tempswa \let\@auxout\@partaux \if@filesw
\immediate\openout\@partaux #1.aux
\immediate\write\@partaux{\relax}\fi
\let\@ltxdoc@PrintIndex\PrintIndex
\let\PrintIndex\relax
\let\@ltxdoc@PrintChanges\PrintChanges
\let\PrintChanges\relax
\let\@ltxdoc@theglossary\theglossary
\let\@ltxdoc@endtheglossary\endtheglossary
\part{\currentfile}%
  {\let\ttfamily\relax
  \xdef\filekey{\filekey, \thepart={\ttfamily\currentfile}}}%
\DocInput{\currentfile}%
\let\PrintIndex\@ltxdoc@PrintIndex
\let\PrintChanges\@ltxdoc@PrintChanges
\let\theglossary\@ltxdoc@theglossary
\let\endtheglossary\@ltxdoc@endtheglossary
\clearpage
\@writeckpt{#1}\if@filesw \immediate\closeout\@partaux \fi
\else\@nameuse{cp@#1}\fi\let\@auxout\@mainaux}
\gdef\codeline@wrindex#1{\if@filesw
        \immediate\write\@indexfile
            {\string\indexentry{#1}%
            {\filesep\number\c@CodelineNo}}\fi}%
\let\filesep\@empty
\def\aalph#1{\@aalph{\csname c@#1\endcsname}}
\def\@aalph#1{%
  \ifcase#1\or a\or b\or c\or d\or e\or f\or g\or h\or i\or
         j\or k\or l\or m\or n\or o\or p\or q\or r\or s\or
         t\or u\or v\or w\or x\or y\or z\or A\or B\or C\or
         D\or E\or F\or G\or H\or I\or J\or K\or L\or M\or
         N\or O\or P\or Q\or R\or S\or T\or U\or V\or W\or
         X\or Y\or Z\else\@ctrerr\fi}
\def\docincludeaux{%
  \def\thepart{\aalph{part}}\def\filesep{\thepart-}%
  \let\filekey\@gobble
  \g@addto@macro\index@prologue{%
    \gdef\@oddfoot{\parbox{\textwidth}{\strut\footnotesize
       \raggedright{\bfseries File Key:} \filekey}}%
    \let\@evenfoot\@oddfoot}%
  \global\let\docincludeaux\relax
 \gdef\@oddfoot{%
   \expandafter\ifx\csname ver@\currentfile\endcsname\relax
    File \thepart: {\ttfamily\currentfile} %
   \else
    \GetFileInfo{\currentfile}%
    File \thepart: {\ttfamily\filename} %
    Date: \filedate\ %
    Version \fileversion
    \fi
    \hfill\thepage}%
 \let\@evenfoot\@oddfoot}%
\def\task#1#2{}
\newcommand{\see}[2]{\emph{see} #1}
\RecordChanges
\PageIndex
\CodelineNumbered

\newcommand{\importantsymbol}{\bfseries\Huge\danger}

\ifpdf
  \definecolor{defbackground}{rgb}{1,1,0.75}
  \newsavebox\defsbox
  \newlength\defwidth
  \newenvironment{definition}[1][]{%
    \def\defarg{#1}%
    \setlength{\fboxsep}{4pt}\setlength{\fboxrule}{1.25pt}%
    \begin{lrbox}{\defsbox}%
      \setlength\defwidth\linewidth
      \addtolength\defwidth{-2\fboxrule}%
      \addtolength\defwidth{-2\fboxsep}%
      \begin{minipage}{\defwidth}\flushleft\ttfamily
  }{%
      \end{minipage}
    \end{lrbox}%
    \vskip10pt
    \noindent
    \defarg\fcolorbox{black}{defbackground}{\usebox\defsbox}%
    \vskip10pt
    \noindent
    \ignorespacesafterend
  }

  \newlength\tmpwidth
  \newlength\tmpheight

  \newcommand{\importantpar}[1][-3]{%
    \settoheight{\tmpheight}{\importantsymbol}%
    \settowidth{\tmpwidth}{\importantsymbol}%
    \advance\tmpwidth by .5em\relax
    \par\noindent
    \hangindent=\tmpwidth
    \hangafter=#1\relax
    \makebox[0pt][l]{\hspace*{-\tmpwidth}%
      \smash{\raisebox{-\tmpheight}{\importantsymbol}}%
    }%
  }

  \newenvironment{important}{%
    \setlength{\fboxrule}{4pt}%
    \setlength\defwidth{\linewidth}%
    \addtolength\defwidth{-2\fboxsep}%
    \addtolength\defwidth{-2\fboxrule}%
    \begin{lrbox}{\defsbox}%
      \begin{minipage}{\defwidth}%
  }{%
      \end{minipage}%
    \end{lrbox}%
    \par\vskip10pt\noindent
    \fcolorbox{red}{white}{\usebox{\defsbox}}\par\vskip10pt
    \noindent\ignorespacesafterend
  }

  \newenvironment{prompt}{%
    \par\vskip\baselineskip
    \begin{ttfamily}\obeylines\noindent\ignorespaces
  }{%
    \end{ttfamily}%
    \par\vskip\baselineskip
    \noindent\ignorespacesafterend
  }

  \newenvironment{display}{%
    \par\vskip\baselineskip\noindent
    \obeylines\ignorespaces
  }{%
    \par
    \vskip\baselineskip
    \noindent\ignorespacesafterend
  }

  \newenvironment{labelledbox}[1]{%
    \def\defarg{#1}%
    \setlength{\fboxsep}{4pt}\setlength{\fboxrule}{1.25pt}%
    \begin{lrbox}{\defsbox}%
      \setlength\defwidth\linewidth
      \addtolength\defwidth{-2\fboxrule}%
      \addtolength\defwidth{-2\fboxsep}%
      \begin{minipage}{\defwidth}\flushleft
  }{%
      \end{minipage}
    \end{lrbox}%
    \vskip10pt
    \noindent
    \begin{tabular}{@{}r@{}}%
      \fbox{\usebox\defsbox}\\[4pt]
      \footnotesize\mbox{\defarg}%
    \end{tabular}
    \vskip10pt
    \noindent
    \ignorespacesafterend
  }

\else
  \newenvironment{definition}[1][]{%
    \par\HCode{<hr><div title="Definition">}#1\ttfamily\noindent
  }{%
    \HCode{</div><hr>}\par\noindent
  }

  \newcommand{\importantpar}[1][-3]{\importantsymbol\space}

  \newenvironment{important}{%
    \par\HCode{<div class="important" title="Important Note">}\noindent
  }{%
    \HCode{</div>}\par\noindent
  }

  \newenvironment{prompt}{%
    \HCode{<spacer type=vertical size=10>}\begin{ttfamily}\obeylines\ignorespaces
  }{%
    \end{ttfamily}\HCode{<spacer type=vertical size=10>}\noindent
  }

  \newenvironment{display}{%
    \HCode{<spacer type=vertical size=10>}\obeylines\ignorespaces
  }{%
    \HCode{<spacer type=vertical size=10>}\noindent
  }

  \newenvironment{labelledbox}[1]{%
    \par\HCode{<hr><div>}\marginpar{#1}\noindent
  }{%
    \HCode{</div><hr>}\par\noindent
  }

\fi

\newcommand*{\appfmt}[1]{\texttt{#1}}
\newcommand*{\iapp}[1]{\index{#1=\appfmt{#1}|hyperpage}}
\newcommand*{\app}[1]{\appfmt{#1}\iapp{#1}}

\newcommand*{\qt}[1]{``#1''}

\newcommand*{\termdef}[1]{\emph{#1}\iterm{#1}}
\newcommand*{\term}[1]{#1\iterm{#1}}
\newcommand*{\iterm}[1]{\index{#1|main}}
\newcommand*{\tableref}[1]{\hyperref[#1]{table~\ref*{#1}}}
\newcommand*{\Tableref}[1]{\hyperref[#1]{Table~\ref*{#1}}}

\newcommand*{\ics}[1]{\cs{#1}\SpecialMainIndex{#1}}

\newcommand*{\icsopt}[2]{\index{#1
options=\cs{#1} options>#2=\textsf{#2}|hyperpage}}

\newcommand*{\csopt}[2]{%
  \textsf{#2}%
  \@for\@thiscmd:=#1\do{%
    \icsopt{\@thiscmd}{#2}%
  }%
}

\newcommand*{\pkgoptfmt}[1]{\textsf{#1}}

% \ipkgopt[value]{option}
\newcommand*{\ipkgopt}[2][]{%
  \def\@argi{#1}%
  \ifx\@argi\@empty
    \index{package options:>#2=\pkgoptfmt{#2}|main}%
  \else
    \index{package options:>#2=\pkgoptfmt{#2}>#1=\pkgoptfmt{#1}|main}%
\fi
}

\newcommand*{\pkgopt}[2][]{%
  \def\@argi{#1}%
  \ifx\@argi\@empty
    \pkgoptfmt{#2}\index{package options:>#2=\pkgoptfmt{#2}|main}%
  \else
    \pkgoptfmt{#2=#1}%
    \index{package options:>#2=\pkgoptfmt{#2}>#1=\pkgoptfmt{#1}|main}%
\fi
}

% \pkgoptval{value}{option}
\newcommand*{\pkgoptval}[2]{%
  \pkgoptfmt{#1}%
  \index{package options:>#2=\pkgoptfmt{#2}>#1=\pkgoptfmt{#1}|main}%
}

\newcommand*{\clsoptfmt}[1]{\textsf{#1}}

% \iclsopt[value]{option}
\newcommand*{\iclsopt}[2][]{%
  \def\@argi{#1}%
  \ifx\@argi\@empty
    \index{class options:>#2=\clsoptfmt{#2}|main}%
  \else
    \index{class options:>#2=\clsoptfmt{#2}>#1=\clsoptfmt{#1}|main}%
\fi
}

\newcommand*{\clsopt}[2][]{%
  \def\@argi{#1}%
  \ifx\@argi\@empty
    \clsoptfmt{#2}\index{class options:>#2=\clsoptfmt{#2}|main}%
  \else
    \clsoptfmt{#2=#1}%
    \index{class options:>#2=\clsoptfmt{#2}>#1=\clsoptfmt{#1}|main}%
\fi
}

% \clsoptval{value}{option}
\newcommand*{\clsoptval}[2]{%
  \clsoptfmt{#1}%
  \index{class options:>#2=\clsoptfmt{#2}>#1=\clsoptfmt{#1}|main}%
}

\newcommand*{\filetypefmt}[1]{\texttt{#1}}
\newcommand*{\ifiletype}[1]{\index{file
  types>#1=\filetypefmt{#1}|hyperpage}}

\newcommand*{\filetype}[1]{\filetypefmt{#1}\ifiletype{#1}}

\newcommand*{\styfmt}[1]{\textsf{#1}}

\newcommand*{\isty}[1]{\index{#1 package=\styfmt{#1}
  package|hyperpage}}
\newcommand*{\sty}[1]{\styfmt{#1}\isty{#1}}

\newcommand*{\clsfmt}[1]{\textsf{#1}}

\newcommand*{\icls}[1]{\index{#1 class=\clsfmt{#1} class|hyperpage}}
\newcommand*{\cls}[1]{\clsfmt{#1}\icls{#1}}

\newcommand*{\envfmt}[1]{\textsf{#1}}
\newcommand*{\ienv}[1]{\SpecialMainEnvIndex{#1}}
\newcommand*{\env}[1]{\envfmt{#1}\ienv{#1}}

\newcommand*{\ctrfmt}[1]{\textsf{#1}}
\newcommand*{\ictr}[1]{\index{#1 counter=\ctrfmt{#1}
counter|hyperpage}}
\newcommand*{\ctr}[1]{\ctrfmt{#1}\ictr{#1}}

\newcommand*{\boolfmt}[1]{\textsf{#1}}
\newcommand*{\ibool}[1]{\index{#1 boolean variable=\boolfmt{#1}
boolean variable|hyperpage}}
\newcommand*{\bool}[1]{\boolfmt{#1}\ibool{#1}}

\newcommand*{\bstfmt}[1]{\textsf{#1}}
\newcommand*{\ibst}[1]{\index{#1 bibliography style=\bstfmt{#1} 
bibliography style|hyperpage}}
\newcommand*{\bst}[1]{\bstfmt{#1}\ibst{#1}}

\newcommand*{\menu}[1]{\textsf{#1}}

\providecommand*{\ctandoc}[1]{%
  \urlfootref{http://ctan.org/pkg/#1}{\sty{#1} documentation}%
}

\newcounter{example}
\newcommand*{\examplename}{example}

\newenvironment{example}[2]{%
  \refstepcounter{example}\label{#2}%
  \par\vskip10pt\noindent
  \textbf{\large Example \theexample\ (#1)}%
  \addcontentsline{loe}{section}{\protect\numberline{\theexample}#1}%
  \nopagebreak\par\vskip10pt\nopagebreak
}
{%
  \begin{center}\rule{2in}{1pt}\end{center}%
}

\newcommand*{\listofexamples}{%
  \section*{List of Examples}%
  \@starttoc{loe}%
}

\ifpdf
  \newcommand*{\toTop}{}
  \newcommand*{\sectionref}[1]{Section~\ref{#1}}
  \newcommand*{\qtdocref}[2]{\qt{#1} (\href{#2.pdf}{#2.pdf})}
  \newcommand*{\docref}[2]{#1 (\href{#2.pdf}{#2.pdf})}
  \newcommand*{\urlref}[2]{\url{#1}}
  \newcommand*{\urlfootref}[2]{#2\footnote{\url{#1}}}
  \newcommand*{\submenu}[1]{\,$\to$\,\menu{#1}}

  % \altdocref{text}{pdf}{html}
  \newcommand*{\altdocref}[3]{#1 (\href{#2.pdf}{#2.pdf})}

  % \xrsectionref{label}{html file}{html title}
  \newcommand*{\xrsectionref}[3]{Section~\ref{#1}}
\else
  \newcommand*{\toTop}{\par\noindent\hyperlink{top}{Top}}
  \AtBeginDocument{%
    \Configure{section}{}{\toTop}{}{}%
    \Configure{subsection}{\toTop}{}{}{}%
    \Configure{subsubsection}{\toTop}{}{}{}%
    \Configure{paragraph}{\toTop\par}{}{}{}%
    \Configure{subparagraph}{\toTop\par}{}{}{}%
    \Css{div.important { background-color:red; }}%
    \titlehead{\hypertarget{top}{}}%
  }

  \let\oldlabel\label
  \renewcommand*{\label}[1]{%
    \HCode{<a name=\string"#1\string">}\oldlabel{#1}%
  }

  \renewcommand{\StopEventually}[1]{#1\toTop}
  \renewcommand*{\OnlyDescription}{}

  \newcommand*{\sectionref}[1]{\hyperref[#1]{\S\ref*{#1} }\nameref{#1}}
  \newcommand*{\xrsectionref}[3]{\href{#2.html\##1}{#3}}
  \newcommand*{\qtdocref}[2]{\href{#2.html}{\qt{#1}}}
  \newcommand*{\docref}[2]{\href{#2.html}{#1}}
  \newcommand*{\altdocref}[3]{\href{#3.html}{#1}}
  \newcommand*{\urlref}[2]{\href{#1}{#2}}
  \newcommand*{\urlfootref}[2]{\href{#1}{#2}}
  \newcommand*{\submenu}[1]{\menu{-\textgreater #1}}
\fi

\endinput
