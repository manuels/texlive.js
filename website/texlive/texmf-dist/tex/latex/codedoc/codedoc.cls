% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% This is the CodeDoc class, produced by itself
% with the `produce' option on, from `CodeDoc-manual.tex'.
% 
% Date: 2010/03/30
% Version: v.0.3
% Author: Paul Isambert
% 
% The documentation can be found in `CodeDoc-manual.pdf'
% (you can produce it with `CodeDoc-manual.tex' without the
% `produce' option).
% 
% This file is published under the LaTeX Project Public License.
% 
% Comments, suggestions, bugs and, of course, NOTES:
% zappathustra@free.fr
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{codedoc}[2010/03/30 v.0.3 Code and documentation in one file.]
\makeatletter
\catcode`\^^?=13

\newif\ifcd@produce
\newif\ifcd@autoclose
\newif\ifcd@obeystop
\newif\ifcd@makeindex
\newif\ifcd@noheader
\newcount\cd@tracingmode
\cd@tracingmode1
\def\cd@GetClass{article()}

\DeclareOption{autoclose}{\cd@autoclosetrue}
\DeclareOption{produce}{\cd@producetrue}
\DeclareOption{index}{\cd@makeindextrue}
\DeclareOption{obeystop}{\cd@obeystoptrue}
\DeclareOption{noheader}{\cd@noheadertrue}
\DeclareOption{tracing0}{\cd@tracingmode0}
\DeclareOption{tracing1}{\cd@tracingmode1}
\DeclareOption{tracing2}{\cd@tracingmode2}
\DeclareOption*{\edef\cd@GetClass{\CurrentOption()}}
\ProcessOptions\relax

\def\cd@end{cd@end}
\ifcd@produce
\else
\def\cd@LoadClass#1(#2){%
	\def\cd@Class{#1}
	\expandafter\cd@GetOptions#2;cd@end;%
	\LoadClass{#1}%
	\@ifnextchar({\expandafter\@gobble\@gobble}{}}
\def\cd@GetOptions#1;{%
	\def\cd@TempArg{#1}
	\ifx\cd@TempArg\cd@end%
		\let\cd@next\relax
	\else%
		\PassOptionsToClass{#1}{\cd@Class}%
		\let\cd@next\cd@GetOptions%
	\fi\cd@next}
\expandafter\cd@LoadClass\cd@GetClass

\ifcd@makeindex
	\RequirePackage{makeidx}
	\makeindex
\else
	\let\printindex\relax
\fi
\ifcd@obeystop
	\ifcd@makeindex
		\long\def\StopHere#1{#1\relax\par\printindex\end{document}}
	\else
		\long\def\StopHere#1{#1\relax\par\end{document}}
	\fi
\else
	\long\def\StopHere#1{}
\fi
\fi

\newif\ifcd@eTeX
\@ifundefined{eTeXversion}{\cd@eTeXfalse}{\cd@eTeXtrue}

\def\cd@Warning{\ClassWarningNoLine{codedoc}}
\def\cd@Error#1{\ClassError{codedoc}{#1}{}}

\def\DocStripMarginpar{\reversemarginpar\marginparpush0pt\relax\marginparwidth8pc\relax}
\def\PrintMacro#1{\noindent\marginpar{\raggedleft\strut\ttfamily#1}\ignorespaces}

\newcount\cd@Index
\def\hyperpage#1{#1}

\def\DescribeIndexFont#1{\gdef\cdatDescribeFont##1{{#1\hyperpage{##1}}}}
\DescribeIndexFont{}
\def\DescribeMacro{\makeatletter\cd@DescribeMacro}
\def\cd@DescribeMacro#1{%
	\makeatother%
	\cd@Index=0 %
	\cd@MakeEntry#1\cd@EndOfEntry%
	\PrintMacro{\string#1}}
\def\DescribeEnvironment{\makeatletter\cd@DescribeEnvironment}
\def\cd@DescribeEnvironment#1{%
	\makeatother%
	\index{#1@\texttt{#1} (environment)|cdatDescribeFont}%
	\PrintMacro{\string#1}}

\def\DefineIndexFont#1{\gdef\cdatDefineFont##1{{#1\hyperpage{##1}}}}
\DefineIndexFont{\itshape}
\def\DefineMacro{\makeatletter\cd@DefineMacro}
\def\cd@DefineMacro#1{%
	\makeatother%
	\cd@Index1 %
	\cd@MakeEntry#1\cd@EndOfEntry%
	\PrintMacro{\string#1}}
\def\DefineEnvironment{\makeatletter\cd@DefineEnvironment}
\def\DefineEnvironment#1{%
	\makeatother%
	\index{#1@\texttt{#1} (environment)|cdatDefineFont}%
	\PrintMacro{\string#1}}

\def\cd@MakeEntry#1#2\cd@EndOfEntry{%
	\def\cd@TempEntry{}%
	\begingroup\escapechar\m@ne\expandafter\cd@AnalyzeEntry\string#1\cd@end\endgroup%
	\expandafter\cd@AnalyzePrefix\cd@TempEntry\cd@end%
	\expandafter\cd@@MakeEntry\cd@TempEntry\cd@EndOfEntry}
\chardef\AtChar=`\@
\def\cd@AnalyzeEntry#1{%
	\let\cd@next\cd@AnalyzeEntry%
	\ifx#1\cd@end%
		\let\cd@next\relax%
	\else\if#1@%
		\expandafter\gdef\expandafter\cd@TempEntry\expandafter{\cd@TempEntry\AtChar}%
	\else%
		\expandafter\gdef\expandafter\cd@TempEntry\expandafter{\cd@TempEntry#1}%
	\fi\fi\cd@next}

\newcount\cd@PrefixCount
\def\IgnorePrefix#1{\cd@PrefixCount\z@\def\Prefix{}\cd@IgnorePrefix#1\cd@end}
\def\cd@IgnorePrefix#1{%
	\let\cd@next\cd@IgnorePrefix%
	\ifx#1\cd@end%
		\def\cd@next{\expandafter\cd@ScanPrefix\Prefix\cd@end}%
	\else\if#1@%
		\expandafter\def\expandafter\Prefix\expandafter{\Prefix\AtChar}%
	\else%
		\edef\cd@PrefixLetter{\string#1}%
		\expandafter\cd@MakePrefix\cd@PrefixLetter%
	\fi\fi\cd@next}
\def\cd@MakePrefix#1{%
	\expandafter\def\expandafter\Prefix\expandafter{\Prefix#1}}%
\def\cd@ScanPrefix#1{%
	\ifx#1\cd@end%
		\let\cd@next\cd@DefPrefix%
	\else%
		\advance\cd@PrefixCount\@ne%
		\let\cd@next\cd@ScanPrefix%
	\fi\cd@next}
\def\cd@DefPrefix{%
	\ifcase\cd@PrefixCount%
		\def\cd@AnalyzePrefix##1\cd@end{}%
	\or\def\cd@AnalyzePrefix##1##2\cd@end{%
		\def\cd@TempPrefix{##1}\def\cd@RestOfEntry{##2}\cd@ComparePrefix}%
	\or\def\cd@AnalyzePrefix##1##2##3\cd@end{%
		\def\cd@TempPrefix{##1##2}\def\cd@RestOfEntry{##3}\cd@ComparePrefix}%
	\or\def\cd@AnalyzePrefix##1##2##3##4\cd@end{%
		\def\cd@TempPrefix{##1##2##3}\def\cd@RestOfEntry{##4}\cd@ComparePrefix}%
	\or\def\cd@AnalyzePrefix##1##2##3##4##5\cd@end{%
		\def\cd@TempPrefix{##1##2##3##4}\def\cd@RestOfEntry{##5}\cd@ComparePrefix}%
	\or\def\cd@AnalyzePrefix##1##2##3##4##5##6\cd@end{%
		\def\cd@TempPrefix{##1##2##3##4##5}\def\cd@RestOfEntry{##6}\cd@ComparePrefix}%
	\or\def\cd@AnalyzePrefix##1##2##3##4##5##6##7\cd@end{%
		\def\cd@TempPrefix{##1##2##3##4##5##6}\def\cd@RestOfEntry{##7}\cd@ComparePrefix}%
	\or\def\cd@AnalyzePrefix##1##2##3##4##5##6##7##8\cd@end{%
		\def\cd@TempPrefix{##1##2##3##4##5##6##7}\def\cd@RestOfEntry{##8}\cd@ComparePrefix}%
	\or\def\cd@AnalyzePrefix##1##2##3##4##5##6##7##8##9\cd@end{%
		\def\cd@TempPrefix{##1##2##3##4##5##6##7##8}\def\cd@RestOfEntry{##9}\cd@ComparePrefix}%
	\fi\ignorespaces}
\newif\ifcd@Prefix
\def\cd@ComparePrefix{%
	\ifx\cd@TempPrefix\Prefix%
		\expandafter\def\expandafter\cd@TempEntry\expandafter{\cd@RestOfEntry}%
		\cd@Prefixtrue%
	\else%
		\cd@Prefixfalse%
	\fi}
\def\cd@@MakeEntry#1\cd@EndOfEntry{%
	\ifcd@Prefix%
		\ifcase\cd@Index%
			\index{#1@\texttt{\char\escapechar\PrintPrefix\Prefix#1}|cdatDescribeFont}%
		\or%
			\index{#1@\texttt{\char\escapechar\PrintPrefix\Prefix#1}|cdatDefineFont}%
		\fi%
	\else%
	\ifcase\cd@Index%
			\index{#1@\texttt{\char\escapechar#1}|cdatDescribeFont}%
		\or%
			\index{#1@\texttt{\char\escapechar#1}|cdatDefineFont}%
		\fi%
	\fi}

\IgnorePrefix{}%
\let\PrintPrefix\relax

\def\meta#1{{\ensuremath\langle\emph{#1}\ensuremath\rangle}}
\def\marg#1{\texttt{\{}\meta{#1}\texttt{\}}}
\def\oarg#1{\texttt{[}\meta{#1}\texttt{]}}
\def\parg#1{\texttt{(}\meta{#1}\texttt{)}}
\def\cd@bslash{\char`\\}
\def\bslash{\texorpdfstring{\cd@bslash}{\string\\}}
\AtBeginDocument{\@ifundefined{texorpdfstring}{\def\texorpdfstring#1#2{#1}}{}}
\def\cd@CharErr#1#2{%
	\bgroup
		\escapechar\m@ne
		\cd@Error{You can't use \string#1 for \string\\#2}
	\egroup}

\newif\ifcd@BadChar

\def\cd@BadChar#1#2{%
	\cd@BadChartrue
	\ifcase\catcode`#1 % \
		\cd@CharErr{\\}{#2}%
	\or% {
		\cd@CharErr{\{}{#2}%
	\or% }
		\cd@CharErr{\}}{#2}%
	\or% $
		\cd@BadCharfalse%
	\or% &
		\cd@BadCharfalse%
	\or% ^^M
	\or% #
		\cd@BadCharfalse%
	\or% ^
		\cd@BadCharfalse%
	\or% _
		\cd@BadCharfalse%
	\or% Ignored
	\or% Spaces
		\cd@CharErr{spaces}{#2}%
	\or% Letters
		\cd@CharErr{letters}{#2. \MessageBreak That's really bad}%
	\or% Other
		\cd@BadCharfalse%
	\or% Active
		\cd@CharErr{#1}{#2 - it's already active}%
	\or% %
		\cd@CharErr{#1}{#2}%
	\fi}

\def\cd@UndoErr#1{%
	\bgroup%
		\escapechar\m@ne%
		\cd@Error{%
			There is no \string\\\string#1\space defined.\MessageBreak%
			\string\\Undo\string#1\space on line \the\inputlineno\space is useless}%
	\egroup}
\def\cd@DefErr#1#2{%
	\bgroup%
	\escapechar\m@ne%
		\expandafter\xdef\csname cd@#2Error\endcsname{%
			\noexpand\cd@Error{%
				You've already defined \string#1 as a \string\\#2\noexpand\MessageBreak%
				on l. \the\inputlineno. You can't have two.\noexpand\MessageBreak%
				Say \string\\Undo#2\space and then \string\\#2\space to change}}%
	\egroup}

\newif\ifcd@ShortVerb

\def\ShortVerb#1{%
	\cd@BadChar{#1}{ShortVerb}%
	\ifcd@BadChar%
	\else\ifcd@ShortVerb
		\cd@ShortVerbError
	\else
		\cd@ShortVerbtrue
		\cd@DefErr{#1}{ShortVerb}
		\chardef\cd@ShortVerbCat\catcode`#1%
		\bgroup%
			\lccode`\~=`#1%
			\lowercase{%
				\gdef~{\leavevmode\bgroup\ttfamily\cd@Verbatim\catcode`#1\active\cd@ShortVerb}%
				\gdef\cd@ShortVerb##1~{##1\egroup}%
				\gdef\UndoShortVerb{%
					\ifcd@ShortVerb%
						\cd@ShortVerbfalse%
						\catcode`~\cd@ShortVerbCat%
					\else%
						\cd@UndoErr{\ShortVerb}%
					\fi}}%
		\egroup%
		\catcode`#1=13
	\fi\fi}%
\def\UndoShortVerb{\cd@UndoErr{\ShortVerb}}

\newif\ifcd@ShortCode
\newif\ifcd@ShortCodeChar

\def\ShortCode{%
	\@ifnextchar[
		{\cd@MakeShortCode}
		{\cd@MakeShortCode[code]}}
\bgroup
\catcode`\^^M13%
\gdef\cd@MakeShortCode[#1]#2{%
	\def\cd@TempEnv{#1}%
	\cd@BadChar{#2}{ShortCode}%
	\ifcd@BadChar%
	\else\ifcd@ShortCodeChar%
		\cd@ShortCodeError%
	\else%
		\expandafter\ifx\csname #1@cd@EOL\endcsname\relax%
			\cd@Error{%
				`#1' is not an example environment.\MessageBreak%
				`code' is selected instead}%
			\def\cd@TempEnv{code}%
		\fi%
		\cd@ShortCodeChartrue%
		\cd@DefErr{#2}{ShortCode}%
		\chardef\cd@ShortCodeCat=\catcode`#2%
		\bgroup%
			\lccode`\~=`#2%
			\lowercase{%
			\gdef~{\cd@ShortCodetrue\csname\cd@TempEnv\endcsname}%
			\gdef\cd@ShortEnd{~}%
			\gdef\cd@ShortCode##1^^M##2~{\cd@StartGobble##2^^?\egroup}%
			\gdef\cd@ActivateShortCode{\catcode`#2=13\relax}%
			\gdef\UndoShortCode{%
				\ifcd@ShortCodeChar%
					\catcode`~=\cd@ShortCodeCat\relax%
					\let\cd@ActivateShortCode\relax%
					\cd@ShortCodeCharfalse%
				\else%
					\cd@UndoErr{\ShortCode}%
				\fi}}%
		\egroup%
		\catcode`#2=13 %
	\fi\fi}%
\egroup
\def\UndoShortCode{\cd@UndoErr{\ShortCode}}

\newif\ifcd@VerbBreak
\newtoks\cd@@Everypar

\def\VerbBreak#1{%
	\cd@BadChar{#1}{VerbBreak}%
	\ifcd@BadChar%
	\else\ifcd@VerbBreak%
		\cd@VerbBreakError%
	\else\cd@VerbBreaktrue
		\cd@DefErr{#1}{VerbBreak}%
		\bgroup%
			\lccode`\~`#1 %
			\lowercase{%
			\gdef\cd@ActivateVerbBreak{%
				\catcode`#1\active%
				\gdef~{%
					\cd@@Everypar\everypar%
					\everypar{}%
					\dimen0=\cd@FirstSpaces\fontdimen2\font\relax%
					\expandafter\ifx\csname\cd@ExampleName @cd@boxwidth\endcsname\relax%
					\else%
						\advance\dimen0 \csname\cd@ExampleName @cd@boxwidth\endcsname\relax%
					\fi%
					\endgraf\leavevmode\everypar\cd@@Everypar\hbox to\dimen0{\hss}}}}%
		\egroup%
		\def\cd@IgnoreVerbBreak{\catcode`#1=9\relax}%
	\fi\fi}
\def\UndoVerbBreak{%
	\ifcd@VerbBreak%
		\let\cd@ActivateVerbBreak\relax
		\let\cd@IgnoreVerbBreak\relax
		\cd@VerbBreakfalse
	\else
		\cd@UndoErr{\VerbBreak}
	\fi}
\let\cd@ActivateVerbBreak\relax
\newif\ifcd@VerbCommand

\def\VerbCommand#1#2#3{%
	\cd@BadChar{#1}{VerbCommand}%
	\cd@BadChar{#2}{VerbCommand}%
	\cd@BadChar{#3}{VerbCommand}%
	\ifcd@BadChar%
	\else\ifcd@VerbCommand%
		\cd@VerbCommandError
	\else%
		\cd@DefErr{#1, \string#2 and \string#3}{VerbCommand}
		\cd@VerbCommandtrue%
		\def\cd@ActivateVerbCommand{\catcode`#1=0 \catcode`#2=1 \catcode`#3=2\relax}%
		\def\cd@IgnoreVerbCommand{%
			\catcode`#1=13 %
			\lccode`\~=`#1 %
			\lowercase{\def~{\cd@GobbleLetters}}%
			\catcode`#2=13 %
			\lccode`\~=`#2 %
			\lowercase{\def~####1#3{}}}%
	\fi\fi}
\def\UndoVerbCommand{%
	\ifcd@VerbCommand%
		\let\cd@ActivateVerbCommand\relax%
		\let\cd@IgnoreVerbCommand\relax%
		\cd@VerbCommandfalse%
	\else%
		\cd@UndoErr{\VerbCommand}%
	\fi}%
\let\cd@IgnoreVerbCommand\relax
\let\cd@ActivateVerbCommand\relax
\def\cd@GobbleLetters#1{\ifnum\catcode`#1=11 \expandafter\cd@GobbleLetters\else\expandafter#1\fi}
\newif\ifcd@CodeEscape%

\def\CodeEscape#1{%
	\cd@BadChar{#1}{CodeEscape}%
	\ifcd@BadChar%
	\else\ifcd@CodeEscape%
		\cd@CodeEscapeError%
	\else%
		\cd@CodeEscapetrue%
		\cd@DefErr{#1}{CodeEscape}%
	\fi\fi}
\def\UndoCodeEscape{%
	\ifcd@CodeEscape%
		\cd@CodeEscapefalse%
	\else%
		\cd@UndoErr{\CodeEscape}%
	\fi}%

\newif\ifcd@Star
\newif\ifcd@NewLine
\newcount\cd@FirstSpaces

\bgroup
\catcode`\ 12%
\gdef\cd@SpaceChar{\texttt{ }}%

\catcode`\^^I=13\relax%
\catcode`\ =13\relax%
\gdef\cd@MakeSpace{%
\ifcd@Star%
\let\cd@ObeySpaces\cd@SpaceChar%
\else%
\let\cd@ObeySpaces\@xobeysp%
\fi%
\catcode`\ =13\relax%
\catcode`\^^I=13\relax%
\let =\cd@VerbSpace%
\let^^I=\cd@VerbTab}%
\gdef\cd@VerbSpace#1{%
\cd@ObeySpaces%
\ifcd@NewLine\advance\cd@FirstSpaces1\relax\fi%
\ifx#1^^I\else\ifx#1 \else\cd@NewLinefalse\fi\fi#1}%
\gdef\cd@VerbTab#1{%
\leavevmode\hbox%
to\cd@TabSize\fontdimen2\font{\hss}%
\ifcd@NewLine\advance\cd@FirstSpaces\cd@TabSize\fi%
\ifx#1^^I\else\ifx#1 \else\cd@NewLinefalse\fi\fi#1}
\egroup

\def\cd@Verbatim{%
	\parindent\z@%
	\hfuzz=\cd@BoxTolerance%
	\ifcd@ShortVerb%
		\UndoShortVerb%
	\fi%
	\ifcd@ShortCode%
		\else%
		\ifcd@ShortCodeChar%
			\UndoShortCode%
		\fi%
	\fi%
	\let\do\@makeother\dospecials\@noligs%
	\ifcd@ShortCode%
		\cd@ActivateShortCode%
	\fi%
	\cd@ActivateVerbBreak%
	\cd@ActivateVerbCommand%
	\frenchspacing%
	\catcode`\^^M=13\relax%
	\cd@MakeSpace}%

\newdimen\cd@BoxTolerance
\def\BoxTolerance#1{\cd@BoxTolerance=#1\relax}
\def\TabSize#1{\chardef\cd@TabSize=#1\relax}
\TabSize2
\def\Gobble#1{\chardef\cd@GobbleNum=#1\relax}
\Gobble0

\def\CodeFont#1{\def\cd@CodeFont{#1}}
\CodeFont{\ttfamily}
\newcount\code@cd@LineNumber
\def\code@cd@boxwidth{0pt}
\def\code@cd@BoxStyle{\rmfamily\footnotesize}
\gdef\code@cd@LineNumberBox{%
	\global\advance\code@cd@LineNumber1\relax%
	\def\@currentlabel{\the\code@cd@LineNumber}%
	\hbox to\code@cd@boxwidth{%
	\hss%
	\code@cd@BoxStyle\relax%
	\the\code@cd@LineNumber\enspace}}%
\let\code@cd@EOL\iffalse%
\def\code{%
	\endgraf%
  \bgroup%
  	\def\cd@ExampleName{code}%
    \cd@Verbatim%
    \cd@ObeyLines%
    \everypar{%
    	\code@cd@LineNumberBox
      \cd@NewLinetrue%
      \cd@FirstSpaces0\relax}%
    \cd@CodeFont%
    \ifcd@ShortCode%
    	\global\cd@ShortCodefalse%
    	\let\cd@next\cd@ShortCode%
    \else\ifcd@Star%
    	\global\cd@Starfalse%
    	\let\cd@next\cd@StarCode%
    \else%
    	\let\cd@next\cd@Code%
    \fi\fi\cd@next}
\expandafter\def\csname code*\endcsname{\cd@Startrue\code}
\def\invisible{%
	\bgroup%
	\catcode`\\=12 \catcode`\{=12 \catcode`\}=12 \catcode`\^^M=13 %
	\cd@Invisible}
\gdef^^?{\cd@UnlikelyCommand}
\gdef\cd@UnlikelyCommand{}

\begingroup
\catcode`|=0
\catcode`<=1
\catcode`>=2
\catcode`{=12
\catcode`}=12
\catcode`\^^M=13 %
\catcode`\\=12 %
|gdef|cd@Code#1^^M#2\end{code}<|cd@StartGobble#2^^?|egroup|end<code>>%
|gdef|cd@StarCode#1^^M#2\end{code*}<|cd@StartGobble#2^^?|egroup|end<code*>>%
|gdef|cd@Invisible#1^^M#2\end{invisible}<|egroup|end<invisible>|ignorespaces>%
|endgroup
\newcount\cd@GobbleCount%
\begingroup
\catcode`\^^M13\relax%
\gdef\cd@StartGobble#1{%
	\ifx#1^^?%
		\cd@GobbleCount=0 %
		\let\cd@next\relax%
	\else\ifnum\cd@GobbleCount=\cd@GobbleNum%
		\cd@GobbleCount=0 %
		\def\cd@next{#1}%
	\else\ifx#1^^M%
		\cd@GobbleCount=0 %
		\def\cd@next{^^M}%
	\else%
		\advance\cd@GobbleCount1 %
		\let\cd@next\cd@StartGobble%
	\fi\fi\fi\cd@next}%
\gdef\cd@ObeyLines{%
	\def^^M##1{%
		\ifx##1^^?%
		\cd@GobbleCount=0 %
		\def\cd@next{\leavevmode\endgraf}%
	\else\ifnum\cd@GobbleCount=\cd@GobbleNum%
		\cd@GobbleCount=0 %
		\def\cd@next{\leavevmode\endgraf##1}%
	\else\ifx##1^^M%
		\cd@GobbleCount=0 %
		\def\cd@next{\leavevmode\endgraf^^M}%
	\else%
		\advance\cd@GobbleCount1 %
		\let\cd@next^^M%
	\fi\fi\fi\cd@next}}%
\endgroup

\def\eTeXOn{%
	\@ifundefined{eTeXversion}%
		{\cd@Error{%
		You're not running on eTeX.\MessageBreak%
		Command \string\eTeXOn\space ignored}}%
		{\cd@eTeXtrue}}
\def\eTeXOff{\cd@eTeXfalse}
\def\NewExample{%
	\@ifnextchar[%
		{\cd@NewExample}%
		{\cd@NewExample[]}}
\def\cd@NewExample[#1]#2{%
	\expandafter\ifx\csname #2\endcsname\relax
		\def\cd@next{\catcode`\#=13 \cd@@NewExample{#1}{#2}}%
	\else%
		\let\cd@next\relax%
		\cd@Error{%
		Style `#2' already defined or the name\MessageBreak%
		is already in use.\MessageBreak%
		Use \protect\RenewExample\space if you want to redefine it}%
		\let\cd@next\cd@GobbleThree%
	\fi\cd@next}

\def\RenewExample{%
	\@ifnextchar[%
		{\cd@RenewExample}%
		{\cd@RenewExample[]}}
\def\cd@RenewExample[#1]#2{%
	\expandafter\ifx\csname #2\endcsname\relax
		\let\cd@next\relax%
		\cd@Error{%
		Style `#2' is undefined.\MessageBreak%
		Use \protect\NewExample\space to redefine it}%
		\let\cd@next\cd@GobbleThree%
	\else\expandafter\ifx\csname #2\endcsname\code%
		\def\CodeFont{%
			\cd@Error{%
			You have redefined the `code' environment.\MessageBreak%
			\string\CodeFont\space is no longer operative}}
	\fi%
		\def\cd@next{\catcode`\#=13 \cd@@NewExample{#1}{#2}}%
	\fi\cd@next}

\def\cd@GobbleThree#1#2#3{}

\begingroup
\catcode`\"=6 %
\catcode`\#=13 %
\long\gdef\cd@@NewExample"1"2"3"4"5{%
	\expandafter\gdef\csname"2@cd@EOL\endcsname{\iffalse}%
	\expandafter\let\csname"2@cd@LineNumberBox\endcsname\relax%
	\def\cd@ExampleName{"2}%
	\cd@ExampleOptions"1,cd@end,%
	\expandafter\def\csname"2\endcsname{%
		\gdef\CodeInput{{%
			\def\cd@ExampleName{"2}%
			\let#\cd@Input%
			"3}}%
		\gdef\CodeOutput{%
			\def\cd@ExampleName{"2}%
			\let#\cd@Output{"4}}%
		\gdef\cd@MakeExample{{"5}}%
		\cd@Example{"2}}%
	\expandafter\def\csname"2*\endcsname{%
		\global\cd@Startrue%
		\gdef\CodeInput{{%
		\def\cd@ExampleName{"2}%
		\cd@Startrue%
		\let#\cd@Input%
		"3}}%
		\gdef\CodeOutput{%
			\def\cd@ExampleName{"2}%
			\let#\cd@Output{"4}}%
		\gdef\cd@MakeExample{{"5}}%
		\cd@Example{"2*}}%
	\catcode`\#=6\relax}%
\endgroup

\def\cd@numbered{numbered}
\def\cd@continuous{continuous}
\def\cd@visibleEOL{visibleEOL}
\def\cd@empty{}
\def\cd@ExampleOptions#1,{%
	\def\cd@TempOption{#1}%
	\let\cd@next\cd@ExampleOptions%
	\ifx\cd@TempOption\cd@end%
		\let\cd@next\relax%
	\else\ifx\cd@TempOption\cd@numbered%
		\global\expandafter\newcount\csname\cd@ExampleName @cd@LineNumber\endcsname%
		\expandafter\gdef\csname\cd@ExampleName @cd@boxwidth\endcsname{0pt}%
		\expandafter\let\csname\cd@ExampleName @cd@BoxStyle\endcsname\relax%
		\expandafter\gdef\csname\cd@ExampleName @cd@LineNumberBox\endcsname{%
			\expandafter\advance\csname\cd@ExampleName @cd@LineNumber\endcsname1\relax%
			\def\@currentlabel{\expandafter\the\csname\cd@ExampleName @cd@LineNumber\endcsname}%
			\hbox to\csname\cd@ExampleName @cd@boxwidth\endcsname{%
				\hss%
				\csname\cd@ExampleName @cd@BoxStyle\endcsname\relax%
				\expandafter\the\csname\cd@ExampleName @cd@LineNumber\endcsname\enspace}}%
	\else\ifx\cd@TempOption\cd@continuous%
		\expandafter\ifx\csname\cd@ExampleName @cd@LineNumber\endcsname\relax%
			\global\expandafter\newcount\csname\cd@ExampleName @cd@LineNumber\endcsname%
		\fi%
		\expandafter\gdef\csname\cd@ExampleName @cd@boxwidth\endcsname{0pt}%
		\expandafter\let\csname\cd@ExampleName @cd@BoxStyle\endcsname\relax%
		\expandafter\gdef\csname\cd@ExampleName @cd@LineNumberBox\endcsname{%
			\global\expandafter\advance\csname\cd@ExampleName @cd@LineNumber\endcsname1\relax%
			\def\@currentlabel{\expandafter\the\csname\cd@ExampleName @cd@LineNumber\endcsname}%
			\hbox to\csname\cd@ExampleName @cd@boxwidth\endcsname{%
				\hss%
				\csname\cd@ExampleName @cd@BoxStyle\endcsname\relax%
				\expandafter\the\csname\cd@ExampleName @cd@LineNumber\endcsname\enspace}}%
	\else\ifx\cd@TempOption\cd@visibleEOL%
		\expandafter\gdef\csname\cd@ExampleName @cd@EOL\endcsname{\csname iftrue\endcsname}%
	\else\ifx\cd@TempOption\cd@empty%
	\else%
		\cd@Error{`#1' is not a valid option}%
	\fi\fi\fi\fi\fi\cd@next}%

\def\LineNumber#1#2#3{%
	\expandafter\ifx\csname#1@cd@EOL\endcsname\relax%
		\cd@Error{`#1' is not an example environment'}%
	\else\expandafter\ifx\csname #1@cd@LineNumber\endcsname\relax%
		\cd@Warning{%
			`#1' is not `numbered' nor `continuous'.\MessageBreak%
			\string\LineNumber\space on line \the\inputlineno\space is useless}{}%
	\else%
		\expandafter\gdef\csname #1@cd@BoxStyle\endcsname{#2}%
		\expandafter\gdef\csname #1@cd@boxwidth\endcsname{#3}%
	\fi\fi%
	\@ifnextchar[{\cd@SetLineNumber#1}\relax}
\def\cd@SetLineNumber#1[#2]{%
	\expandafter\ifx\csname#1@cd@LineNumber\endcsname\relax%
	\else%
		\csname#1@cd@LineNumber\endcsname=#2\relax%
		\expandafter\advance\csname#1@cd@LineNumber\endcsname\m@ne%
	\fi}

\NewExample{example}{\ttfamily#}{#}{}
\def\CodeInput{%
	\cd@Error{%
		No example environment has been created.\MessageBreak%
		\string\CodeInput\space is void}}
\def\CodeOutput{%
	\cd@Error{%
		No example environment has been created.\MessageBreak%
		\string\CodeOutput\space is void}}

\begingroup
\catcode`|=0 %
\catcode`<=1 %
\catcode`>=2 %
\catcode`{=12 %
\catcode`}=12 %
\catcode`\\=12 %
|gdef|cd@Example#1<%
	|bgroup%
		|let|do|@makeother%
		|dospecials%
		|ifcd@ShortCode%
			|global|let|cd@EndEnv|relax
			|expandafter|cd@MakeExampleEnd|expandafter<|cd@ShortEnd>%
			|global|cd@ShortCodefalse%
			|cd@ActivateShortCode%
		|else%
			|gdef|cd@EndEnv<|end<#1>>%
			|cd@MakeExampleEnd<\end{#1}>%
			|ifcd@ShortCodeChar%
				|UndoShortCode%
			|fi%
		|fi%
		|ifcd@ShortVerb%
			|UndoShortVerb%
		|fi%
		|catcode`|^^I=12 %
		|catcode`|^^M=13 %
		|ifcd@eTeX%
			|catcode`|%=13 %
		|fi%
		|cd@ExampleEnd>%
|endgroup
\begingroup
\catcode`\^^M=13 %
%
\gdef\cd@MakeExampleEnd#1{%
	\ifcd@eTeX%
		\gdef\cd@ExampleEnd##1^^M##2#1{%
			\egroup%
			\cd@EndEnv%
			\bgroup%
				\everypar{}%
				\cd@AssigneTeXInput{##2}%
			\global\cd@Starfalse}%
	\else%
		\def\cd@ExampleEnd##1^^M##2#1{%
			\expandafter\ifx\csname cd@TestRead\endcsname\relax%
				\newread\cd@TestRead%
			\fi%
			\openin\cd@TestRead=\jobname.exp %
			\ifeof\cd@TestRead\relax%
				\cd@Warning{%
				You're not running on eTeX or you've said \string\eTeXOff.\MessageBreak%
				I create the file \jobname.exp to produce\MessageBreak%
				the example environment on line \the\inputlineno.\MessageBreak%
				You can delete it whenever you want, but\MessageBreak%
				keeping it prevents this message from reappearing.}%
			\fi%
			\closein\cd@TestRead %
			\expandafter\ifx\csname cd@expFile\endcsname\relax%
				\newwrite\cd@expFile%
			\fi%
				\immediate\openout\cd@expFile=\jobname.exp %
			\let^^M\cd@noeTeXEOL%
			^^M##2^^?^^M^^?%
			\egroup%
			\cd@EndEnv%
			\immediate\closeout\cd@expFile%
			\bgroup%
				\everypar{}%
				\cd@AssignInput%
			\egroup\global\cd@Starfalse}%
	\fi}%
\endgroup
\begingroup
\catcode`\^^M\active%
\gdef\cd@noeTeXEOL#1{%
	\ifx#1^^?%
		\cd@GobbleCount=0 %
		\let^^M\relax%
		\let\cd@next\relax%
	\else\ifx#1^^M%
		\cd@GobbleCount=0 %
		\def\cd@next{\immediate\write\cd@expFile{}\cd@noeTeXEOL}%
	\else\ifnum\cd@GobbleCount=\cd@GobbleNum%
		\cd@GobbleCount=0 %
		\def\cd@next{\cd@LineWrite#1}%
	\else%
		\advance\cd@GobbleCount1 %
		\let\cd@next\cd@noeTeXEOL%
	\fi\fi\fi\cd@next}%
\gdef\cd@LineWrite#1^^M{\immediate\write\cd@expFile{#1}\cd@noeTeXEOL}%
\newtoks\cd@Everypar
%
\gdef\cd@AssignInput{%
	\gdef\cd@Input{%
		\bgroup%
			\cd@Everypar\everypar%
			\everypar{%
				\leavevmode\csname\cd@ExampleName @cd@LineNumberBox\endcsname\relax%
				\cd@NewLinetrue\cd@FirstSpaces0\relax\the\cd@Everypar\relax}%
			\cd@Verbatim%
			\def^^M{\leavevmode\endgraf}%
			\input{\jobname.exp}%
		\egroup}%
	\gdef\cd@Output{%
		\bgroup%
			\cd@IgnoreVerbBreak%
			\cd@IgnoreVerbCommand%
			\input{\jobname.exp}%
		\egroup}%
		\cd@MakeExample}%
%
\long\gdef\cd@AssigneTeXInput#1{%
	\gdef\cd@Input{%
		\bgroup%
			\cd@Everypar\everypar%
			\everypar{%
			\leavevmode\csname\cd@ExampleName @cd@LineNumberBox\endcsname\relax%
			\cd@NewLinetrue\cd@FirstSpaces0\relax\the\cd@Everypar\relax}%
			\cd@Verbatim%
			\catcode`\^^M=13 %
			\let^^M\cd@eTeXStartGobble%
			\catcode`\^^?13 %
			\def^^?{\catcode`\^^M=9\relax}%
			\scantokens{^^M#1^^?}%
		\egroup}%
	\gdef\cd@Output{%
		\bgroup%
			\cd@IgnoreVerbBreak%
			\catcode`\^^?13 %
			\catcode`\%=13 %
			\catcode`\^^M=13 %
			\csname\cd@ExampleName @cd@EOL\endcsname%
				\cd@VisibleComment%
				\let^^M\cd@eTeXOutVisibleEOL%
				\def^^?{\let^^M\relax}%
				\cd@IgnoreVerbCommand%
				\scantokens{#1^^?}%
			\else%
				\cd@ActiveComment%
				\let^^M\cd@eTeXOutEOL%
				\def^^?{\catcode`\^^M9\relax}%
				\xdef\cd@exinput{#1^^?}%
				\cd@IgnoreVerbCommand%
				\catcode`\^^M=9 %
				\catcode`\^^@=9 %
				\expandafter\scantokens\expandafter{\cd@exinput}%
			\fi%
		\egroup}%
	\cd@MakeExample\egroup}%
%
\gdef\cd@eTeXStartGobble#1{%
	\ifx#1^^?%
		\cd@GobbleCount=0 %
		\let\cd@next\relax%
	\else\ifnum\cd@GobbleCount=\cd@GobbleNum%
		\cd@GobbleCount=0 %
		\let^^M\cd@eTeXEOL%
		\def\cd@next{#1}%
	\else\ifx#1^^M%
		\cd@GobbleCount=0 %
		\let^^M\cd@eTeXEOL%
		\let\cd@next^^M%
	\else%
		\advance\cd@GobbleCount1 %
		\let\cd@next\cd@eTeXStartGobble%
	\fi\fi\fi\cd@next}%
%
\gdef\cd@eTeXEOL#1{%
	\ifx#1^^?%
		\cd@GobbleCount=0 %
		\def\cd@next{\let^^M\relax\leavevmode\endgraf}%
	\else\ifx#1^^M%
		\cd@GobbleCount=0 %
		\def\cd@next{\leavevmode\endgraf^^M}%
	\else\ifnum\cd@GobbleCount=\cd@GobbleNum%
		\cd@GobbleCount=0 %
		\def\cd@next{\leavevmode\endgraf#1}%
	\else%
		\advance\cd@GobbleCount1 %
		\let\cd@next^^M%
	\fi\fi\fi\cd@next}%
%
\gdef\cd@eTeXOutVisibleEOL#1{%
	\ifx#1^^?%
		\let^^M\relax%
		\let\cd@next\relax%
	\else\ifx#1^^M%
		\par%
		\let\cd@next^^M%
	\else%
		\def\cd@next{ #1}%
	\fi\fi\cd@next}%
\catcode`\^^@=12\relax%
\gdef\cd@eTeXOutEOL#1{%
	\ifx#1^^?%
	\else\ifx#1^^M%
		\par%
		\expandafter^^M%
	\else%
	^^@ \expandafter\expandafter\expandafter#1%
	\fi\fi}%
\catcode`\/=14\relax%
\catcode`\%=13\relax/
\catcode`\ =12\relax/
\catcode`\^^I=12\relax/
\gdef\cd@VisibleComment{/
\def%##1^^M{\cd@EatBOL}/
\def\cd@EatBOL##1{/
\let\cd@next\cd@EatBOL/
\ifx##1 /
\else\ifx##1^^I/
\else\ifx##1^^M/
\let\cd@next\par/
\else/
\def\cd@next{##1}/
\fi\fi\fi\cd@next}}/
\gdef\cd@ActiveComment{/
\def%##1^^M{\cd@EatBOL}/
\def\cd@EatBOL##1{/
\ifx##1 /
\expandafter\cd@EatBOL/
\else\ifx##1^^I/
\expandafter\expandafter\expandafter\cd@EatBOL/
\else\ifx##1^^M/
\par/
\else/
\expandafter\expandafter\expandafter\expandafter\expandafter\expandafter\expandafter##1/
\fi\fi\fi}}/
\endgroup
\def\CloseFile#1{%
	\def\FileSource{%
		\cd@Error{%
			No file in production. \string\FileSource\space is empty}}%
	\def\FileName{%
		\cd@Error{%
			No file in production. \string\FileName\space is empty}}%
	\def\FileVersion{%
		\cd@Error{%
			No file in production. \string\FileVersion\space is empty}}%
	\def\FileDate{%
		\cd@Error{%
			No file in production. \string\FileDate\space is empty}}}
\ifcd@produce%
	\def\FileName{}
	\def\FileVersion{}
	\def\FileDate{}
\else
	\CloseFile{}
	\def\FileSource{}
	\newcount\@cd@LineCount%
\fi
\def\ProduceFile#1{%
	\ifcd@autoclose%
		\code@cd@LineNumber0\relax%
	\else%
		\expandafter\csname\FileSource @cd@LineCount\endcsname=\code@cd@LineNumber%
		\expandafter\ifx\csname #1@cd@LineCount\endcsname\relax%
			\expandafter\newcount\csname #1@cd@LineCount\endcsname%
			\code@cd@LineNumber0\relax%
		\else%
			\expandafter\code@cd@LineNumber\csname #1@cd@LineCount\endcsname%
		\fi%
	\fi%
	\def\FileName{%
		\cd@Error{%
			No \string\FileName\space has been given to \FileSource}}%
	\def\FileVersion{%
	\cd@Error{%
		No \string\FileVersion\space has been given to \FileSource}}%
	\def\FileDate{%
	\cd@Error{%
		No \string\FileDate\space has been given to \FileSource}}%
	\edef\FileSource{#1}%
	\@ifnextchar[%
	{\cd@GetFileName}%
	\relax}
\def\cd@GetFileName[#1]{%
	\edef\FileName{#1}%
	\@ifnextchar[\cd@GetFileVersion\relax}
\def\cd@GetFileVersion[#1]{%
	\edef\FileVersion{#1}%
	\@ifnextchar[\cd@GetFileDate\relax}
\def\cd@GetFileDate[#1]{%
	\edef\FileDate{#1}}

\def\Header{\bgroup\catcode`\%=12 \cd@HeaderGobble}
\long\def\cd@HeaderGobble#1{\egroup}
\let\AddBlankLine\relax
\let\StartIgnore\relax
\let\StopIgnore\relax
\def\DangerousEnvironment#1{}

%
% Definitions for the produce mode
%
\ifcase\cd@tracingmode
	\def\cd@Tracing#1{}
	\def\cd@TChar#1#2{}
	\def\cd@TUChar#1{}
	\let\cd@TCode\relax
\or
	\def\cd@Tracing#1{}
	\def\cd@TChar#1#2{}
	\def\cd@TUChar#1{}
	\def\cd@TCode{\immediate\write17{%
		*** Code written from line \the\cd@ProduceLine\space to \the\inputlineno\space to \cd@CurrentFile. ***}}
\or
	\def\cd@Tracing#1{\immediate\write17{On line \the\cd@ProduceLine: #1.}}
	\def\cd@TChar#1#2{
		\bgroup
			\escapechar\m@ne\cd@Tracing{`\string#1' defined as \string\\#2}
		\egroup}
	\def\cd@TUChar#1{
		\bgroup
			\escapechar\m@ne\cd@Tracing{\string\\#1 undone}
		\egroup}
	\def\cd@TCode{\immediate\write17{%
		*** Code written from line \the\cd@ProduceLine\space to \the\inputlineno\space to \cd@CurrentFile. ***}}
\fi
\def\cd@CDError#1{%
	\immediate\write17{%
		^^J! CodeDoc Error:^^J#1^^Jl.\the\cd@ProduceLine^^J }}
\def\cd@CDWarning#1{%
	\immediate\write17{%
		^^J? CodeDoc Warning: ^^J#1^^Jl.\the\cd@ProduceLine^^J }}
\def\cd@NoFileWarning{\cd@CDWarning{No file in production. This code will be lost.}}

\ifcd@produce
\def\@documentclasshook{
	\let\do\@makeother
	\dospecials
	\catcode`\^^I=12\relax
	\catcode`\%=14\relax
	\catcode`\\\active
	\let\normalsize\relax
	\ifnum\cd@tracingmode>0
		\immediate\write17{^^J*** CODEDOC REPORT ***^^J}
	\fi
	\hfuzz=100cm%
	\output={\deadcycles0\setbox0\box255}
	\everypar{}
	\tracingcommands\z@\tracingmacros\z@\tracingoutput\z@\tracingparagraphs\z@
	\tracingpages\z@\tracinglostchars\z@\tracingrestores\z@\tracingstats\z@}
\fi

\begingroup
\catcode`\{=12 %
\catcode`\}=12 %
\catcode`\<=1 %
\catcode`\>=2 %
\gdef\cd@LeftBrace<{>
\gdef\cd@RightBrace<}>
\gdef\cd@LeftBracket<[>
\catcode`\ =12\relax
\catcode`\^^I=12\relax
\gdef\cd@Space< >
\gdef\cd@Tab<^^I>
\catcode`\^^M=12\relax%
\gdef\cd@EndOfLine<^^M>%
\catcode`\/=14\relax/
\catcode`\%=12\relax/
\gdef\cd@Comment<%>/
\endgroup

\newcount\cd@ProduceLine

\begingroup
\catcode`|=0 %
\catcode`\\=13 %
|gdef|cd@Escape{\}%
|gdef\#1{%
	|cd@ProduceLine|inputlineno%
	|bgroup
		|catcode`|^^M=12 %
		|catcode`|%=12 %
		|gdef|cd@MacroName{}%
		|ifnum|catcode`#1=11 %
			|def|cd@next{|cd@Gather#1}%
		|else
			|def|cd@next{|egroup|relax}
		|fi
		|cd@next}
|long|gdef|cd@Gather#1{%
	|ifnum|catcode`#1=11 %
		|xdef|cd@MacroName{|cd@MacroName#1}%
		|let|cd@next|cd@Gather%
	|else%
		|gdef|cd@NextChar{#1}%
		|let|cd@next|cd@GobbleSpace%
		|fi|cd@next}
|endgroup

\long\def\cd@GobbleSpace{%
	\let\cd@next\cd@TakeNextChar
	\ifx\cd@NextChar\cd@Space
	\else\ifx\cd@NextChar\cd@Tab
	\else\ifx\cd@NextChar\cd@EndOfLine
	\else\ifx\cd@NextChar\cd@Comment
		\let\cd@next\cd@GobbleEndOfLine
	\else
		\egroup
		\def\cd@next{\expandafter\cd@Evaluate\cd@NextChar}
	\fi\fi\fi\fi\cd@next}
\long\def\cd@TakeNextChar#1{\gdef\cd@NextChar{#1}\cd@GobbleSpace}
\begingroup
\catcode`\^^M=12%
\gdef\cd@GobbleEndOfLine#1^^M#2{%
	\gdef\cd@NextChar{#2}%
	\cd@GobbleSpace}%
\endgroup
\def\cd@Evaluate{\csname\cd@MacroName @Produce\endcsname}
\def\cd@Gobble#1{}
\def\cd@PrepareChar#1{%
	\catcode`\\=0 %
	\def\cd@next{\expandafter#1\cd@Gobble}
	\ifx\cd@NextChar\cd@LeftBrace%
	\else\ifx\cd@NextChar\cd@Escape%
	\else%
		\def\cd@next{#1}
	\fi\fi}%

\def\ShortVerb@Produce{\cd@PrepareChar\cd@MakeShortVerb@Produce\cd@next}
\let\DefineShortVerb@Produce\ShortVerb@Produce
\def\cd@VerbList{}
\def\cd@MakeShortVerb@Produce#1{%
	\cd@TChar{#1}{ShortVerb}
	\expandafter\def\expandafter\cd@VerbList\expandafter{\cd@VerbList#1,}
	\lccode`\~=`#1 %
	\lowercase{%
		\def~{\bgroup\let\do\@makeother\dospecials\catcode`#1\active\cd@ShortVerb@Produce}%
		\def\cd@ShortVerb@Produce##1~{\egroup}}%
	\def\UndoShortVerb@Produce{\cd@TUChar{ShortVerb}\catcode`#1=12\relax}%
	\catcode`#1=13 %
	\catcode`\\=13\relax}
\let\UndoShortVerb@Produce\relax
\def\UndefineShortVerb@Produce{\cd@PrepareChar\cd@UndefineShortVerb@Produce\cd@next}%
\def\cd@UndefineShortVerb@Produce#1{
	\cd@TUChar{ShortVerb (from fancyvrb)}
	\catcode`#1=12 \catcode`\\=13\relax}

\def\VerbBreak@Produce{\cd@PrepareChar\cd@MakeVerbBreak@Produce\cd@next}
\def\cd@MakeVerbBreak@Produce#1{
	\cd@TChar{#1}{VerbBreak}
	\def\cd@IgnoreVerbBreak{\catcode`#1=9\relax}
	\def\UndoVerbBreak@Produce{\cd@TUChar{VerbBreak}\let\cd@IgnoreVerbBreak\relax}
	\catcode`\\=13\relax}
\let\cd@IgnoreVerbBreak\relax
\let\UndoVerbBreak@Produce\relax
\def\cd@GobbleOptions#1[#2]#3{\def\cd@NextChar{#3}\expandafter#1\cd@NextChar}

\def\ShortCode@Produce{%
	\ifx\cd@NextChar\cd@LeftBracket%
		\def\cd@next{\cd@GobbleOptions\ShortCode@Produce}%
	\else%
	\cd@PrepareChar\cd@MakeShortCode@Produce
	\fi\cd@next}
\begingroup
\catcode`\^^M13%
\gdef\cd@MakeShortCode@Produce#1{%
	\cd@TChar{#1}{ShortCode}
	\lccode`\~=`#1%
	\lowercase{%
	\def~{\cd@ProduceLine\inputlineno\cd@ShortCodetrue\cd@CodeWrite}%
	\def\ActivateShortCode@Produce{\catcode`#1\active}%
	\def\cd@ShortWriteFile##1^^M##2~{%
		^^M##2^^?^^M^^?%
		\ifx\cd@NoFileWarning\relax%
			\cd@TCode%
		\else%
			\cd@NoFileWarning%
		\fi\egroup}}%
	\def\UndoShortCode@Produce{\cd@TUChar{ShortCode}\catcode`#1=12\relax}%
	\catcode`\\=13 %
	\catcode`#1=13\relax}%
\endgroup
\let\ActivateShortCode@Produce\relax
\let\UndoShortCode@Produce\relax

\def\VerbCommand@Produce{\cd@PrepareChar\cd@VerbEscape@Produce\cd@next}
\def\cd@VerbEscape@Produce#1{
	\bgroup\escapechar\m@ne\xdef\cd@TempEsc{\string#1}\egroup
	\def\cd@IgnoreEscape@Produce{
		\catcode`#1=13
		\lccode`\~=`#1
		\lowercase{\def~{\cd@GobbleLetters}}}
		\ifx\cd@NextChar\cd@LeftBrace
			\def\cd@next{\expandafter\cd@VerbBraces@Produce\cd@Gobble}
		\else
			\let\cd@next\cd@VerbBraces@Produce
		\fi\cd@next}
\def\cd@VerbBraces@Produce{\catcode`\{=1 \catcode`\}=2 \cd@@VerbBraces@Produce}
\def\cd@@VerbBraces@Produce#1#2{%
	\expandafter\cd@TChar\expandafter{\cd@TempEsc', `\string#1' and `\string#2'}{VerbCommand}
	\def\cd@IgnoreBraces@Produce{%
		\catcode`#1=13
		\lccode`\~=`#1
		\lowercase{\def~####1#2{}}}
	\catcode`\\=13 \catcode`\{=12 \catcode`\}=12\relax}
\def\UndoVerbCommand@Produce{
	\cd@TUChar{VerbCommand}
	\let\cd@IgnoreEscape@Produce\relax
	\let\cd@IgnoreBraces@Produce\relax}
\let\cd@IgnoreEscape@Produce\relax
\let\cd@IgnoreBraces@Produce\relax

\def\CodeEscape@Produce{\cd@PrepareChar\cd@CodeEscape@Produce\cd@next}
\def\cd@CodeEscape@Produce#1{%
	\cd@TChar{#1}{CodeEscape}
	\def\cd@ActivateCodeEscape{\catcode`#1=0\relax}\catcode`\\=13\relax}
\let\cd@ActivateCodeEscape\relax
\def\UndoCodeEscape@Produce{\cd@TUChar{CodeEscape}\let\cd@ActivateCodeEscape\relax}

\def\NewExample@Produce{%
	\ifx\cd@NextChar\cd@LeftBracket%
		\def\cd@next{\cd@GobbleOptions\NewExample@Produce}%
	\else%
		\let\cd@next\cd@DangerousExample@Produce%
	\fi\cd@next}
\let\RenewExample@Produce\NewExample@Produce

\let\cd@@Evaluate\cd@Evaluate
\def\StartIgnore@Produce{
	\cd@Tracing{\string\StartIgnore\space found. I will ignore everything from now on}
	\let\cd@Evaluate\cd@FindIgnore}
\def\cd@FindIgnore{
	\expandafter\ifx\csname cd@\cd@MacroName\endcsname\cd@StopIgnore
		\cd@Tracing{\string\StopIgnore\space found. I resume my normal behavior}
		\let\cd@Evaluate\cd@@Evaluate
	\fi}
\def\cd@StopIgnore{\cd@StopIgnore}

\def\verb@Produce{\count@=0 \cd@VerbEater}
\def\cd@VerbEater#1{%
	\ifcase\count@ %
		\ifx#1*
			\count@=1 %
			\let\cd@@VerbEater\cd@VerbEater
		\else
			\def\cd@@VerbEater##1#1{}
		\fi
	\else
		\def\cd@@VerbEater##1#1{}
	\fi\cd@@VerbEater}

\def\DescribeMacro@Produce#1#2{}
\def\DefineMacro@Produce#1#2{}
\def\DescribeEnvironment@Produce#1#2{}
\def\DefineEnvironment@Produce#1#2{}
\def\noexpand@Produce#1{}
\def\string@Produce#1{}
\def\protect@Produce#1{}
\def\begin@Produce{
	\ifx\cd@NextChar\cd@LeftBrace
		\expandafter\begin@@Produce
	\fi}
\def\end@Produce{
	\ifx\cd@NextChar\cd@LeftBrace
		\expandafter\end@@Produce
	\fi}

\def\Gobble@Produce#1{%
	\ifx\cd@NextChar\cd@LeftBrace%
		\def\cd@next{\expandafter\Gobble@@Produce\cd@NextChar}
	\else
		\def\cd@next{\chardef\cd@GobbleNum=#1\relax}%
	\fi\cd@next}
\newif\ifcd@HeaderFirstLine
\begingroup
\catcode`\^^M=13 %
\catcode`\/=14 %
\catcode`\%=12 /
\gdef\Header@Produce{/
	\bgroup/
	\catcode`\^^M=13 /
	\catcode`\%=12 /
	\catcode`\\=0 /
	\Header@@Produce}/
\gdef\cd@HeaderEOL{\def^^M{^^J% }}
\endgroup

\def\cd@DocumentString{document}
\def\cd@CodeString{code}
\def\cd@StarCodeString{code*}
\def\cd@InvisibleString{invisible}
\def\cd@StoredEnvironments{example,verbatim,Verbatim,BVerbatim,LVerbatim,SaveVerbatim,VerbatimOut,Example,CenterExample,SideBySideExample,PCenterExample,PSideBySideExample,}

\newif\ifcd@everyeof
\cd@everyeoftrue

\begingroup
\catcode`\{=12 %
\catcode`\}=12 %
\catcode`\<=1 %
\catcode`\>=2 %
\long\gdef\Header@@Produce{#1}<
	\gdef\cd@Header<\bgroup\cd@HeaderEOL\cd@ProduceFile<\cd@Comment\space#1>\egroup>
	\egroup>

\gdef\Gobble@@Produce{#1}<\chardef\cd@GobbleNum=#1\relax>

\gdef\DangerousEnvironment@Produce{#1}<
	\cd@Tracing<#1 added to dangerous environments>
	\xdef\cd@StoredEnvironments<\cd@StoredEnvironments#1,>>
\gdef\cd@DangerousExample@Produce{#1}#2{#3}#4{#5}#6{#7}<
	\cd@Tracing<#1 added to dangerous environments (CodeDoc examples)>
	\xdef\cd@StoredEnvironments<\cd@StoredEnvironments#1,>>
\let\DefineVerbatimEnvironment@Produce\DangerousEnvironment@Produce

\gdef\begin@@Produce{#1}<
	\def\cd@TempArg<#1>
	\ifx\cd@TempArg\cd@CodeString
		\let\cd@next\cd@CodeWrite
	\else\ifx\cd@TempArg\cd@StarCodeString
		\cd@Startrue
		\let\cd@next\cd@CodeWrite
	\else\ifx\cd@TempArg\cd@InvisibleString
		\cd@Invisibletrue
		\let\cd@next\cd@CodeWrite
	\else
		\def\cd@next<\cd@CheckEnvironment<#1>>
	\fi\fi\fi\cd@next>
\gdef\end@@Produce{#1}<
	\def\cd@TempArg<#1>
	\ifx\cd@TempArg\cd@DocumentString
		\def\cd@next<\cd@Tracing<\string\end{document}>
		\ifnum\cd@tracingmode=0 %
		\else
			\immediate\write17<^^J*** END OF CODEDOC REPORT ***^^J>
		\fi\@@end>
	\else
		\let\cd@next\relax
	\fi\cd@next>
\gdef\ProduceFile@Produce{#1}<\ProduceFile@@Produce<#1>>
\gdef\CloseFile@Produce{#1}<\CloseFile@@Produce<#1>>

\newcount\cd@InputDepth
\gdef\input@Produce{#1}<
  \ifcd@everyeof
    \cd@everyeoffalse
    \ifx\everyeof\@undefined
      \cd@CDWarning<%
        You're not running on e-TeX; the \string\input\space of files might be problematic.%
        ^^JAdd `{}' at the end of \string\input\space files if you ever get a `File ended...' message>
    \else
      \everyeof<{}>
    \fi
  \fi
	\cd@Tracing<\string\input\space file #1>
	\expandafter\let\csname cd@MasterSource\the\cd@InputDepth\endcsname\cd@CurrentSource
	\edef\cd@CurrentSource<#1 (\string\input\space in \cd@CurrentSource)>
	\advance\cd@InputDepth1\relax
	\@@input #1\relax
	\advance\cd@InputDepth-1\relax
	\expandafter\let\expandafter\cd@CurrentSource\csname cd@MasterSource\the\cd@InputDepth\endcsname>

\catcode`\|=0 %
\catcode`\\=13 %
|gdef|cd@MakeSpecialEater#1<
	|long|def|cd@SpecialEater##1\end{#1}<>
	|cd@SpecialEater>
|endgroup

\edef\cd@CurrentSource{\jobname.tex}

\def\cd@CheckEnvironment#1{
	\def\cd@TempEnv{#1}
	\expandafter\cd@@CheckEnvironment\cd@StoredEnvironments cd@end,}
\def\cd@@CheckEnvironment#1,{
	\def\cd@@TempEnv{#1}
	\def\cd@@StarTempEnv{#1*}
	\ifx\cd@@TempEnv\cd@end
		\let\cd@next\relax
	\else\ifx\cd@@TempEnv\cd@TempEnv
		\def\cd@next{\cd@MakeSpecialEater{#1}}
	\else\ifx\cd@@StarTempEnv\cd@TempEnv
		\def\cd@next{\cd@MakeSpecialEater{#1*}}
	\else
		\let\cd@next\cd@@CheckEnvironment
	\fi\fi\fi
	\cd@next}
\def\cd@MakeOther#1,{%
	\def\cd@TempArg{#1}%
	\ifx\cd@TempArg\cd@end%
	\else%
		\catcode`#1=12 %
		\expandafter\cd@MakeOther%
	\fi}

\newif\ifcd@Invisible
\begingroup
\catcode`\^^M=13\relax%
\gdef\cd@CodeWrite{%
	\bgroup%
		\let\do\@makeother%
		\dospecials%
		\catcode`\^^I=12 %
		\expandafter\cd@MakeOther\cd@VerbList cd@end,%
		\cd@IgnoreVerbBreak%
		\ifcd@ShortCode%
			\ActivateShortCode@Produce%
		\else%
			\let\cd@TempTUChar\cd@TUChar
			\def\cd@TUChar##1{}
			\UndoShortCode@Produce%
			\let\cd@TUChar\cd@TempTUChar
		\fi%
		\cd@IgnoreEscape@Produce%
		\cd@IgnoreBraces@Produce%
		\cd@ActivateCodeEscape%
		\catcode`\^^M=13\relax%
		\let^^M\cd@produceEOL%
		\ifcd@ShortCode%
			\global\cd@ShortCodefalse\let\cd@next\cd@ShortWriteFile%
		\else\ifcd@Star%
			\global\cd@Starfalse\let\cd@next\cd@StarWriteFile%
		\else\ifcd@Invisible%
			\global\cd@Invisiblefalse\let\cd@next\cd@InvisibleWriteFile%
		\else%
			\let\cd@next\cd@WriteFile%
		\fi\fi\fi\cd@next}%
\gdef\cd@produceEOL#1{%
	\ifx#1^^?%
		\cd@GobbleCount=0 %
		\let^^M\relax%
		\let\cd@next\relax%
	\else\ifx#1^^M%
		\cd@GobbleCount=0 %
		\def\cd@next{\cd@ProduceFile{}\cd@produceEOL}%
	\else\ifnum\cd@GobbleCount=\cd@GobbleNum%
		\cd@GobbleCount=0 %
		\def\cd@next{\cd@LineWrite@Produce#1}%
	\else%
		\advance\cd@GobbleCount1 %
		\let\cd@next\cd@produceEOL%
	\fi\fi\fi\cd@next}%
\gdef\cd@LineWrite@Produce#1^^M{\cd@ProduceFile{#1}\cd@produceEOL}%
\catcode`|=0 %
\catcode`<=1 %
\catcode`>=2 %
\catcode`{=12 %
\catcode`}=12 %
\catcode`\\=12 %
|long|gdef|cd@WriteFile#1^^M#2\end{code}<%
	^^M#2^^?^^M^^?%
	|ifx|cd@NoFileWarning|relax%
		|cd@TCode%
	|else%
		|cd@NoFileWarning%
	|fi|egroup>%
|long|gdef|cd@StarWriteFile#1^^M#2\end{code*}<%
	^^M#2^^?^^M^^?%
	|ifx|cd@NoFileWarning|relax%
		|cd@TCode%
	|else%
		|cd@NoFileWarning%
	|fi|egroup>%
|long|gdef|cd@InvisibleWriteFile#1^^M#2\end{invisible}<%
	^^M#2^^?^^M^^?%
	|ifx|cd@NoFileWarning|relax%
		|cd@TCode%
	|else%
		|cd@NoFileWarning%
	|fi|egroup>%
|endgroup

\def\cd@Closed{closed}
\def\cd@Open{open}
\def\cd@Wait{wait}

\newcount\cd@ProduceCount

\def\cd@CurrentFile{}
\chardef\@unused=17

\def\cd@ProduceFile#1{}
\def\AddBlankLine@Produce{\cd@ProduceFile{}}

\def\ProduceFile@@Produce#1{%
	\let\cd@next\relax
	\expandafter\ifx\csname #1@Status\endcsname\cd@Closed
		\cd@CDError{%
		File `#1' has already been closed.^^J%
		If I open it again, it will be erased.^^J%
		I can't do that. I quit. Sorry.}
		\let\cd@next\@@end
	\else\expandafter\ifx\csname #1@Status\endcsname\cd@Open
		\cd@CDWarning{%
		File `#1' is currently in production.^^J%
		Why do you try to open it again?}
	\else\expandafter\ifx\csname #1@Status\endcsname\cd@Wait
		\expandafter\let\csname #1@Status\endcsname\cd@Open
		\let\cd@NoFileWarning\relax
		\def\cd@ProduceFile{\immediate\write\csname #1@Stream\endcsname}
		\expandafter\let\csname \cd@CurrentFile @Status\endcsname\cd@Wait
		\def\cd@CurrentFile{#1}
	\else\ifnum\cd@ProduceCount>15
		\chardef\cd@ProduceStream=16
		\expandafter\cd@FindStream\cd@StreamList cd@end,
		\ifnum\cd@ProduceStream=16 %
			\cd@CDError{%
			No more stream for a new file. Close one with \string\CloseFile\space^^J%
			(or use the `autoclose' option).^^J%
			This situation makes me feel bad. I quit.}
			\let\cd@next\@@end
		\else
			\cd@Tracing{I will now produce file #1}
			\ifx\cd@CurrentFile\cd@empty
			\else
				\ifcd@autoclose
					\cd@Tracing{I close file \cd@CurrentFile\space (autoclose mode)}
					\expandafter\let\csname \cd@CurrentFile @Status\endcsname\cd@Closed
				\else
					\expandafter\let\csname \cd@CurrentFile @Status\endcsname\cd@Wait
				\fi
			\fi
			\def\cd@CurrentFile{#1}
			\expandafter\let\csname #1@Status\endcsname\cd@Open
			\expandafter\chardef\csname #1@Stream\endcsname\cd@ProduceStream
			\immediate\openout\cd@ProduceStream=#1 %
			\let\cd@NoFileWarning\relax
			\def\cd@ProduceFile{\immediate\write\cd@ProduceStream}
			\let\cd@next\cd@GetFile@Produce
		\fi
	\else\chardef\cd@ProduceStream\cd@ProduceCount
		\cd@Tracing{I will now produce file #1}
		\ifx\cd@CurrentFile\cd@empty
		\else
			\ifcd@autoclose
				\cd@Tracing{I close file \cd@CurrentFile\space (autoclose mode)}
				\expandafter\let\csname \cd@CurrentFile @Status\endcsname\cd@Closed
			\else
				\expandafter\let\csname \cd@CurrentFile @Status\endcsname\cd@Wait
			\fi
		\fi
		\def\cd@CurrentFile{#1}
		\expandafter\let\csname #1@Status\endcsname\cd@Open
		\expandafter\chardef\csname #1@Stream\endcsname\cd@ProduceStream
		\immediate\openout\cd@ProduceStream=#1 %
		\let\cd@NoFileWarning\relax
		\def\cd@ProduceFile{\immediate\write\cd@ProduceStream}
		\ifcd@autoclose
		\else
			\advance\cd@ProduceCount\@ne
		\fi
		\let\cd@next\cd@GetFile@Produce
	\fi\fi\fi\fi\cd@next}

\def\cd@GetFile@Produce{
	\bgroup
		\UndoShortCode@Produce
		\UndoShortVerb@Produce
		\gdef\FileName{}
		\gdef\FileVersion{}
		\gdef\FileDate{}
		\@ifnextchar[
			{\catcode`\\\z@ \cd@GetFileName@Produce}
			{\ifcd@noheader\else\cd@Header\fi\egroup}}
\def\cd@GetFileName@Produce[#1]{
	\xdef\FileName{#1}
	\catcode`\\\active
	\@ifnextchar[
		{\catcode`\\\z@ \cd@GetFileVersion@Produce}
		{\ifcd@noheader\else\cd@Header\fi\egroup}}
\def\cd@GetFileVersion@Produce[#1]{%
	\xdef\FileVersion{#1}
	\catcode`\\\active
	\@ifnextchar[
		{\catcode`\\\z@ \cd@GetFileDate@Produce}
		{\ifcd@noheader\else\cd@Header\fi\egroup}}
\def\cd@GetFileDate@Produce[#1]{%
	\xdef\FileDate{#1}
	\ifcd@noheader\else\cd@Header\fi\egroup}

\def\CloseFile@@Produce#1{
	\ifcd@autoclose
		\expandafter\ifx\csname #1@Status\endcsname\relax
			\cd@CDWarning{%
				You haven't opened `#1'. Closing it does nothing.^^J%
				Besides, you're in autoclose mode. \string\CloseFile\space is redundant.}
		\else\expandafter\ifx\csname #1@Status\endcsname\cd@Closed
			\cd@CDWarning{%
				`#1' was already closed. Closing it again does nothing.^^J%
				Besides, you're in autoclose mode. \string\CloseFile\space is redundant.}
		\else
			\cd@CDWarning{%
				You're in autoclose mode.	\string\CloseFile\space is redundant.}
		\fi\fi%
	\else
		\expandafter\ifx\csname #1@Status\endcsname\relax
			\cd@CDWarning{%
				You haven't opened `#1'. Closing it does nothing.}
		\else\expandafter\ifx\csname #1@Status\endcsname\cd@Closed
			\cd@CDWarning{%
				`#1' was already closed. Closing it again does nothing.}
		\else
			\cd@Tracing{I close file #1}
			\expandafter\let\csname #1@Status\endcsname\cd@Closed
			\def\cd@TempFile{#1}
			\ifx\cd@TempFile\cd@CurrentFile
				\def\cd@NoFileWarning{\cd@CDWarning{No file in production. This code will be lost.}}
				\def\cd@ProduceFile##1{}%
			\fi
			\edef\cd@StreamList{%
				\cd@StreamList\expandafter\the\csname #1@Stream\endcsname,}
	\fi\fi\fi}

\def\cd@StreamList{}
\def\cd@BuildList#1cd@end,{\def\cd@StreamList{#1}}
\newif\ifcd@stream
\def\cd@FindStream#1,{%
	\def\cd@TempArg{#1}
	\ifx\cd@TempArg\cd@end
		\cd@streamfalse
		\let\cd@@next\relax
	\else
		\cd@streamtrue
		\chardef\cd@ProduceStream=#1 %
		\let\cd@@next\cd@BuildList
	\fi\cd@@next}

\catcode`\%=12\relax
\edef\cd@Header{
\noexpand\cd@ProduceFile{% This is \noexpand\FileName, produced by the CodeDoc class
^^J% with the `produce' option on.
^^J%
^^J% To create the documentation, compile \cd@CurrentSource
^^J% without the `produce' option.
^^J%
^^J% SOURCE: \noexpand\cd@CurrentSource
^^J% DATE: \noexpand\FileDate
^^J% VERSION: \noexpand\FileVersion
}}
\catcode`\%=14\relax

\makeatother
