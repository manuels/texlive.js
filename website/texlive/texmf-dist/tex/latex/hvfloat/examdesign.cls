%%
%% This is file `examdesign.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% examdesign.dtx  (with options: `header,ulem,random,othercode')
%% File: examdesign.dtx Copyright (C) 1997-2001 Jason Alexander
%% Copyright (C) 19yy  name of author
%% 
%% This program is free software; you can redistribute it and/or
%% modify it under the terms of the GNU General Public License
%% as published by the Free Software Foundation; either version 2
%% of the License, or (at your option) any later version.
%% 
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License along with
%% this program; if not, write to the Free Software Foundation, Inc., 59 Temple
%% Place - Suite 330, Boston, MA  02111-1307, USA.
%% 
%% For error reports contact me at jalex@uci.edu.
%% 
\ProvidesFile{examdesign.dtx}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{examdesign}
\newcounter{passes}\setcounter{passes}{2}
\newif\ifmcbold \mcboldfalse
\newif\ifmcunder \mcunderfalse
\newif\ifulem \ulemfalse
\newif\ifbox \boxtrue
\newif\iftwocolumn \twocolumnfalse
\gdef\@OneKeyHook{\relax}
\DeclareOption{twocolumn}{\twocolumntrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}

\def\NoKey{\setcounter{passes}{1}}

\def\OneKey{\setcounter{passes}{2}%
  \gdef\@OneKeyHook{\setcounter{passes}{1}
    \gdef\@OneKeyHook{\relax}}}

\def\BoldfaceCorrectMultipleChoiceAnswer{%
  \mcboldtrue
  \boxfalse
  \exam@SetCorrectChoiceFont}

\def\UnderlineCorrectMultipleChoiceAnswer{%
  \mcundertrue
  \boxfalse
  \exam@SetCorrectChoiceFont}

\def\exam@SetCorrectChoiceFont{%
  \ifmcbold
    \ifmcunder
    \def\MCfont##1{\textbf{\uline{##1}}}%
    \else
    \def\MCfont##1{\textbf{##1}}%
    \fi
  \else
    \ifmcunder
    \def\MCfont##1{\uline{##1}}%
    \else
    \def\MCfont##1{\relax{##1}}%
    \fi
  \fi}


\RequirePackage{enumerate}
\RequirePackage{multicol}
\RequirePackage{keyval}
\newcount\randomi % the random number seed (while executing)
\global\randomi\catcode`\@  % scratch variable during definitions
\catcode`\@=11
\def\setrandomseed#1{\global\randomi#1\relax
  \message{Randomizer initialized to \the\randomi.}%
  \nextrandom \nextrandom \nextrandom}

\def\nextrandom{\begingroup
 \ifnum\randomi<\@ne % then initialize with time
    \global\randomi\time
    \global\multiply\randomi388 \global\advance\randomi\year
    \global\multiply\randomi31 \global\advance\randomi\day
    \global\multiply\randomi97 \global\advance\randomi\month
    \message{Randomizer initialized to \the\randomi.}%
    \nextrandom \nextrandom \nextrandom
 \fi
 \count@ii\randomi
 \divide\count@ii 127773 % modulus = multiplier * 127773 + 2836
 \count@\count@ii
 \multiply\count@ii 127773
 \global\advance\randomi-\count@ii % random mod 127773
 \global\multiply\randomi 16807
 \multiply\count@ 2836
 \global\advance\randomi-\count@
 \ifnum\randomi<\z@ \global\advance\randomi 2147483647\relax\fi
 \endgroup
}

\countdef\count@ii=2 % use only in boxes!
\ifx\@tempcnta\undefined \csname newcount\endcsname \@tempcnta \fi
\ifx\@tempcntb\undefined \csname newcount\endcsname \@tempcntb \fi

\def\setrannum#1#2#3{% count register, minimum, maximum
 \@tempcnta#3\advance\@tempcnta-#2\advance\@tempcnta\@ne
 \@tempcntb 2147483645 %  =  m - 2  =  2^{31} - 3
 \divide\@tempcntb\@tempcnta
 \getr@nval
 \advance\ranval#2\relax
 #1\ranval
}

\def\setrandim#1#2#3{% dimen register, minimum length, maximum length
 \dimen@#2\dimen@ii#3\relax
 \setrannum\ranval\dimen@\dimen@ii
 #1\ranval sp\relax
}

\def\getr@nval{% The values in \@tempcnta and \@tempcntb are parameters
 \nextrandom
 \ranval\randomi \advance\ranval\m@ne \divide\ranval\@tempcntb
 \ifnum\ranval<\@tempcnta\else \expandafter\getr@nval \fi
}

\def\pointless{\expandafter\PoinTless\the}
{\catcode`p=12 \catcode`t=12
\gdef\PoinTless#1pt{#1}}

\catcode`\@=\randomi
\global\randomi=0
\newcount\ranval
\expandafter \ifx \csname UL@box\endcsname \relax \else
 \typeout{ulem.sty refuses to load twice. }\endinput \fi
\chardef\ULthickness\catcode\string`\@ % hold catcode temporarily
\catcode\string`\@=11
\def\uline{\relax \ifmmode\expandafter\underline
           \else \bgroup\expandafter\ULset\fi}
\newbox\UL@box
\newbox\UL@hyphenbox
\newskip\UL@skip
\newcount\UL@pe
\let\LA@space\ \let\LA@hskip\hskip
\def\UL@end *{\relax\relax}% something harmless unlikely to be found elsewhere
\def\ULset{\ifdim\ULdepth=\maxdimen\setbox\UL@box\hbox{(j}\ULdepth\dp\UL@box\fi
  \def\UL@leadtype{\leaders \hrule \@height\dimen@ \@depth\ULdepth}%
  \ifmmode \ULdepth-4\p@ \fi
  \dimen@-\ULdepth \advance\dimen@\ULthickness \ULon}
\def\ULon{\ifmmode \expandafter\UL@onmath\else \expandafter\UL@on\fi}
\def\UL@on#1{\leavevmode\UL@ender \let\UL@on\UL@onin
  \everymath{\UL@hrest}\everyvbox{\UL@hrest}\let\hskip\UL@hskip
  \let\\\UL@cr \let\-\UL@dischyp \let\newline\UL@newline \let\ \UL@space
  \def\hfil{\hskip\z@ plus1fil\relax}\def\hfill{\hskip\z@ plus1fill\relax}%
  \def\hss{\hskip\z@ plus1filminus1fil\relax}\let\penalty\UL@penalty
  \UL@word\@empty#1\xdef\UL@spfactor{\the\spacefactor} \UL@end * }
\def\UL@onin#1{\leavevmode\UL@ender % when nested, do multiple underlining
  \dimen@\ULthickness \advance\ULdepth\thr@@\dimen@ \advance\dimen@-\ULdepth
  \setbox\UL@box\hbox{{#1}}\let\UL@start\relax\UL@putbox\egroup}
\def\UL@onmath#1{\UL@ender\mathord{\UL@hrest\mathop{\kern\z@#1}\limits\sb
  {\UL@leadtype\LA@hskip\p@ plus1fill}}\egroup}
\def\UL@unegroup{}
\gdef\UL@ender{}
\def\UL@swender{\ifnum`{=\z@\fi\aftergroup}\gdef\UL@ender{}}
\def\UL@word#1 {\expandafter\UL@start#1 %
  \expandafter\ifx\expandafter\UL@end#1\egroup\egroup
   \unskip \unskip \unskip % remove extra leader at end
   \spacefactor\UL@spfactor \let\UL@word\egroup
  \else % not finished
   \ifmmode\else \ifdim\lastskip=\z@\else % allow syntactical spaces
     \global\UL@skip\lastskip \unskip
     \UL@stop \UL@leaders
   \fi\fi
  \fi \UL@word\@empty}% \@empty preserves braces in param
\def\UL@start{\setbox\UL@box\hbox\bgroup\everyhbox{\UL@hrest}%
  \let\UL@start\@empty \def\UL@unegroup{\bgroup\bgroup}\let\UL@leadtype\@empty
  \bgroup \kern-3sp\kern3sp % kerns so I can test for beginning of list
  \if@ignore \global\@ignorefalse \ignorespaces \fi}
\def\UL@stop{\global\UL@pe\lastpenalty \unpenalty % penalty in \UL@pe
  \ifnum\lastkern=\thr@@ \egroup\egroup % Nothing in hbox...but make sure:
    \ifdim\wd\UL@box=\z@ \else \UL@putbox \fi % something in box so print it
  \else  \egroup\egroup \UL@putbox % something in box so print it
  \fi \ifnum\UL@pe=\z@ \else \LA@penalty\UL@pe \fi % use penalty from inside box
  \UL@unegroup}
\def\UL@putbox{\ifx\UL@start\@empty \else % not inner
  \vrule\@width\z@ \LA@penalty\@M
  {\UL@skip\wd\UL@box \UL@leaders \kern-\UL@skip}%
  \box\UL@box  \fi}
\newdimen\UL@pixel \UL@pixel=1in \divide\UL@pixel 300
\def\UL@leaders{{\LA@hskip-\UL@pixel \advance\UL@skip\tw@\UL@pixel
   \UL@leadtype\LA@hskip\UL@skip  \LA@hskip-\UL@pixel}}
\def\UL@hrest{\let\ \LA@space \let\-\@empty \let\penalty\LA@penalty}
\def\UL@space{\LA@space \global\UL@skip\lastskip \unskip \UL@reskip}% \
\def\UL@dischyp{\global\setbox\UL@hyphenbox\hbox
   {\ifnum \hyphenchar\font<\z@ \string-\else \char\hyphenchar\font \fi}%
   \kern\wd\UL@hyphenbox \LA@penalty\@M \UL@stop \kern-\wd\UL@hyphenbox
   \discretionary{\box\UL@hyphenbox}{}{}\UL@start}
\let\LA@penalty\penalty
\def\UL@penalty{\relax\ifhmode \afterassignment\UL@@penalty\count@
  \else\LA@penalty\fi}
\def\UL@@penalty{\LA@penalty \ifnum\count@=\z@
  \@ne \else \count@ \fi % zero penalty => no penalty, so use 1 instead.
  \UL@stop \UL@start}
\def\UL@hskip{\ifx\ \LA@space \LA@hskip \else
  \afterassignment\UL@reskip \global\UL@skip \fi}
\def\UL@reskip{\UL@stop \UL@leaders \UL@start}
\def\UL@cr{\unskip \ifx\ \LA@space \let\UL@vad\@gobble
  \else \UL@stop \unskip\unskip\unskip \let\UL@vad\vadjust \fi
  \@ifstar{\UL@vad{\LA@penalty\@M}\UL@cra}\UL@cra}
\def\UL@cra{\@ifnextchar[\UL@crb\UL@newline}
\def\UL@crb[#1]{\UL@vad{\vskip#1}\UL@newline}
\def\UL@newline{\ifx\UL@start\@empty % (\UL@cr may have \UL@stop-ed already)
  \unskip \ifx\ \LA@space \else \UL@stop \unskip\unskip\unskip \fi\fi
  \LA@hskip \z@\@plus.0001fil\LA@penalty -\@M \UL@start}
\newbox\ULC@box
\def\markoverwith#1{\setbox\ULC@box\hbox{{#1}}\UL@pixel.5\wd\ULC@box
   \ifmmode \setbox\ULC@box\hbox{\raise1.4ex\box\ULC@box}%
    \dp\ULC@box-1.4ex\ht\ULC@box\z@ \def\UL@leadtype{\cleaders\copy\ULC@box}%
   \else
    \def\UL@leadtype{\leaders\copy\ULC@box}%
   \fi}
\def\uwave{\bgroup \markoverwith{\lower3.5\p@\hbox{\sixly
  \kern-.21\p@ \char58 \kern-.21\p@}}\ULon}
\font\sixly=lasy6 % does not re-load if already loaded, so no memory problem.
\def\uuline{\bgroup \markoverwith{\hbox
 {\kern-.03em\vtop{\kern.2ex\hrule width.2em\kern1.1\p@
 \hrule}\kern-.03em}}\ULon}
\def\sout{\bgroup \ULdepth=-.5ex \ULset}
\def\xout{\bgroup \markoverwith{\kern-.1em{/}\kern-.1em}\ULon}
\def\useunder#1#2#3{\relax
  \ifx\relax#2\relax\else % declaration command given
    \def#2{\def\@tempa{#1}\global\let\UL@ender\UL@swender
    \expandafter\@tempa\expandafter{\ifnum\z@=\string`}\fi}%
    \MakeRobust{#2}\fi
  \ifx\relax#3\relax\else % argumentative command
    \def#3{#1}\MakeRobust{#3}\fi}
\expandafter\ifx \csname @ifundefined\endcsname \relax
  \def\@height{height}
  \def\@depth{depth}
  \def\@width{width}
  \def\@empty{}
  \def\@gobble#1{}
  \def\MakeRobust#1{}
  \csname newif\expandafter\endcsname \csname if@ignore\endcsname
\else
 \def\MakeRobust#1{\expandafter\let
   \csname \expandafter\@gobble\string#1 \endcsname= #1%
  \edef#1{\noexpand\protect \expandafter\noexpand
   \csname\expandafter\@gobble\string#1 \endcsname}
  }
  \MakeRobust\uline
  \MakeRobust\uuline
  \MakeRobust\uwave
  \MakeRobust\sout
  \MakeRobust\xout
  \let\LA@em\em   \let\LA@emph\emph
  \expandafter\let\expandafter\LA@Pem \csname em \endcsname
  \expandafter\let\expandafter\LA@Pemph \csname emph \endcsname
  \def\ULforem{\useunder{\uline}{\em}{\emph}}
  \def\normalem{\let\em\LA@em \let\emph\LA@emph
    \expandafter\let\csname em \endcsname\LA@Pem
    \expandafter\let\csname emph \endcsname\LA@Pemph}
  \ULforem  %  default is to use underlining for \em,
\fi
\catcode`@=\ULthickness % Scratch meaning: restore catcode of @
\def\ULthickness{.4pt}% can change this with \renewcommand
\newdimen\ULdepth  \ULdepth=\maxdimen

\normalem
\newcounter{questionnumber}
\setcounter{questionnumber}{0}
\setcounter{section}{0}
\newcounter{extract}
\newcounter{question} \setcounter{question}{1}
\newcounter{length} \setcounter{length}{0}
\newcounter{temp} \setcounter{temp}{1}
\newcounter{wordtemp} \setcounter{wordtemp}{1}
\newcounter{form}
\newcounter{version}
\newcounter{current@section}
\newcounter{current@question}
\newcounter{innerloop}
\newcounter{sect}
\newcounter{sectionindex}
\newcounter{answer}
\newcounter{choice}
 \setcounter{choice}{1}
\newcounter{mcquestion} \setcounter{mcquestion}{1}
\newcounter{mcchoice} \setcounter{mcchoice}{1}
\newcounter{savelistcnt}
\newlength{\blank@length}
\newlength{\temp@length}
\newlength{\temp@@length}
\newlength{\namedata@vspace}
\newlength{\beforesectsep}
 \setlength{\beforesectsep}{\medskipamount}
\newlength{\aftersectsep}
 \setlength{\aftersectsep}{\medskipamount}
\newlength{\beforeinstsep}
 \setlength{\beforeinstsep}{\medskipamount}
\newlength{\afterinstsep}
 \setlength{\afterinstsep}{\medskipamount}
 \addtolength{\afterinstsep}{-\topsep}
\newif\ifchoice \choicefalse
\newif\ifanswer
\newif\ifnotfixed
\newif\ifcblanks \cblanksfalse
\newif\ifpblanks \pblankstrue
\newif\ifidentifier \identifierfalse
\newif\ifFirstQuestionInBlock \FirstQuestionInBlocktrue
\newif\ifcontinuousnumbering \continuousnumberingtrue
\newif\ifresetcounter\resetcounterfalse
\global\newtoks\temptoks
\global\newtoks\temp@toks
\newcount\exam@c
\newcount\exam@n
\newcount\exam@m
\setrannum{\exam@m}{1}{10}
\newtoks\@toklist
\def\section{\stepcounter{section}
  \setcounter{question}{1}}
\long\def\get@instructions#1\begin{\@toklist=\expandafter{\the\@toklist#1}%
  \find@instructions@end}
\def\find@instructions@end#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@Q
    \let\@next=\Qwrap@up@instructions
  \else
    \ifx\@tempa\@Block
      \let\@next=\Bwrap@up@instructions
    \else
      \@toklist=\expandafter{\the\@toklist\begin{#1}}%
      \let\@next=\get@instructions
   \fi\fi\@next}
\def\Qwrap@up@instructions{%
 \expandafter\xdef\csname inst@sec\thesection\endcsname{\the\@toklist}
 \begin{question}}
\def\Bwrap@up@instructions{%
 \expandafter\xdef\csname inst@sec\thesection\endcsname{\the\@toklist}
 \begin{block}}
\def\endsection{\make@qlist}
\def\make@qlist{%
  \setcounter{temp}{1}
  \edef\@tempa{\thesection}%
  \global\expandafter\newtoks\csname qlist@sec\@tempa\endcsname
  \global\expandafter\newtoks\csname qlist@scr@sec\@tempa\endcsname
  \global\csname qlist@scr@sec\@tempa\endcsname={}
  \@whilenum \value{question}>1 \do{%
    \edef\@questionnumber{\arabic{temp}}%
    \expandafter\append\expandafter{\@questionnumber}%
       {\csname qlist@sec\@tempa\endcsname}
    \addtocounter{question}{-1}
    \addtocounter{temp}{1}}}
\def\question{%
  \@toklist={\exam@ExecuteIfDefined{sec\thesection q\thequestion break}}%
 \get@question@body}
\def\endquestion{\stepcounter{question}}
\long\def\get@question@body#1\end{\@toklist=\expandafter{\the\@toklist#1}%
  \find@question@end}
\def\find@question@end#1{%
  \def\@tempa{#1}%
   \ifx\@tempa\@Q\expandafter\wrap@up
    \else\@toklist=\expandafter{\the\@toklist\end{#1}}%
     \expandafter\get@question@body\fi}
\def\exam@ExecuteIfDefined#1{%
  \@ifundefined{#1}%
    {}%
    {\csname #1\endcsname}}

\def\wrap@up{%
 \edef\@tempa{\thesection}%
 \edef\@tempb{\thequestion}%
 \ifx\@currentsectionname\@truefalse
   \expandafter\xdef\csname sec\@tempa @qst\@tempb\endcsname{%
     \noexpand\exam@ExecuteIfDefined{sec\thesection q\thequestion break}%
     \noexpand\exam@TFItem
     \noexpand\@beforequestionhook
     \noexpand\exam@TFGobbleQuestionHook
     \the\@toklist
     \noexpand\@endquestionhook}
   \else
     \ifx\@currentsectionname\@MC
       \expandafter\xdef\csname sec\@tempa @qst\@tempb\endcsname{%
         \noexpand\exam@ExecuteIfDefined{sec\thesection q\thequestion break}%
         \noexpand\@mcitem
         \noexpand\@beforequestionhook
         \noexpand\exam@MCGobbleQuestionHook
         \the\@toklist
         \noexpand\exam@EndChoiceListIfNecessary
         \noexpand\@mcenditem
         \noexpand\@endquestionhook}
       \else
         \ifx\@currentsectionname\@shortanswer
           \expandafter\xdef\csname sec\@tempa @qst\@tempb\endcsname{%
             \noexpand\exam@ExecuteIfDefined{sec\thesection q\thequestion break}%
             \noexpand\item
             \noexpand\@beforequestionhook
             \noexpand\exam@SAGobbleQuestionHook
             \the\@toklist
             \noexpand\@endquestionhook}
         \else
           \ifx\@currentsectionname\@fillin
             \expandafter\xdef\csname sec\@tempa @qst\@tempb\endcsname{%
               \noexpand\exam@ExecuteIfDefined{sec\thesection q\thequestion break}%
               \noexpand\item
               \noexpand\@beforequestionhook
               \noexpand\exam@FillinGobbleQuestionHook
               \the\@toklist
               \noexpand\@endquestionhook}
           \else
             \expandafter\xdef\csname sec\@tempa @qst\@tempb\endcsname{%
               \noexpand\exam@ExecuteIfDefined{sec\thesection q\thequestion break}%
               \noexpand\item
               \noexpand\@beforequestionhook
               \the\@toklist
               \noexpand\@endquestionhook}
   \fi\fi\fi\fi
   \end{question}}
\def\@Q{question}
\newcounter{first}
\newcounter{last}
\def\exam@GobbleBlockInstructionsHook{\relax}
\newcounter{exam@tf}\setcounter{exam@tf}{0}

\newcommand{\block}[1][]{%
  % Break only if a pagebreak preceeded the block
  \@toklist={\exam@ExecuteIfDefined{sec\current@section q\current@question break}}%
  \@toklist=\expandafter{\the\@toklist
    \global\@newlistfalse
    \setcounter{questionnumber}{\value{enumi}}}%
  \ifx\@currentsectionname\@truefalse
    \@toklist=\expandafter{\the\@toklist
      \end{list}%
      \setcounter{exam@tf}{0}%
      \exam@TrueFalseGobbleBlockInstructionsHook}%
  \else
    \@toklist=\expandafter{\the\@toklist
      \end{enumerate}\exam@GobbleBlockInstructionsHook}%
  \fi
  \setkeys{block}{#1}%
  \exam@GetBlockToFirstQuestion}

\define@key{block}{questions}[0]{%
  \@toklist=\expandafter{\the\@toklist
    \setcounter{first}{\value{enumi}}
    \stepcounter{first}
    \setcounter{last}{\value{enumi}}
    \addtocounter{last}{#1}}}

\long\def\exam@GetBlockToFirstQuestion#1\begin{%
  \@toklist=\expandafter{\the\@toklist #1}%
  \exam@CheckForQuestion}

\def\exam@CheckForQuestion#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@Q
    \ifx\@currentsectionname\@truefalse
      \@toklist=\expandafter{\the\@toklist
        \exam@StartTrueFalseList
        \begin{question}}
    \else
      \@toklist=\expandafter{\the\@toklist
        \begin{enumerate}
        \setcounter{enumi}{\value{questionnumber}}%
        \begin{question}}
    \fi
    \expandafter\get@block@body
  \else
    \expandafter\exam@GetBlockToFirstQuestion
  \fi}

\long\def\get@block@body#1\end{\@toklist=\expandafter{\the\@toklist #1}%
  \find@block@end}
\def\find@block@end#1{%
  \def\@tempa{#1}%
   \ifx\@tempa\@Block\expandafter\block@wrap@up
    \else\@toklist=\expandafter{\the\@toklist\end{#1}}%
     \expandafter\get@block@body\fi}
\def\block@wrap@up{%
 \edef\@tempa{\thesection}%
 \edef\@tempb{\thequestion}%
 \expandafter\xdef\csname sec\@tempa @qst\@tempb\endcsname{%
   \noexpand\@startofblockhook
   \the\@toklist
   \noexpand\@endofblockhook}%
 \end{block}}
\def\@startofblockhook{\relax}
\def\@endofblockhook{\relax}
\def\@Block{block}
\def\endblock{\stepcounter{question}}
\def\frontmatter{\@toklist={}
 \get@frontmatter@body}
\def\endfrontmatter{\relax}
\long\def\get@frontmatter@body#1\end{%
  \@toklist=\expandafter{\the\@toklist#1}%
  \find@frontmatter@end}
\def\find@frontmatter@end#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@Frontmatter
    \expandafter\frontmatter@wrap@up
  \else
    \@toklist=\expandafter{\the\@toklist\end{#1}}%
    \expandafter\get@frontmatter@body
  \fi}
\def\frontmatter@wrap@up{%
  \xdef\@frontmattertext{\the\@toklist}
  \end{frontmatter}}
\def\@Frontmatter{frontmatter}
\def\endmatter{\@toklist={}
 \get@endmatter@body}
\def\endendmatter{\relax}
\long\def\get@endmatter@body#1\end{%
  \@toklist=\expandafter{\the\@toklist#1}%
  \find@endmatter@end}
\def\find@endmatter@end#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@Endmatter
    \expandafter\endmatter@wrap@up
  \else
    \@toklist=\expandafter{\the\@toklist\end{#1}}%
    \expandafter\get@endmatter@body
  \fi}
\def\endmatter@wrap@up{%
  \xdef\@endmattertext{\the\@toklist}
  \end{endmatter}}
\def\@Endmatter{endmatter}
\begin{frontmatter}
  \relax
\end{frontmatter}
\begin{endmatter}
  \relax
\end{endmatter}
\def\exampreface{\@toklist={}
 \get@exampreface@body}
\def\endexampreface{\relax}
\long\def\get@exampreface@body#1\end{%
  \@toklist=\expandafter{\the\@toklist#1}%
  \find@exampreface@end}
\def\find@exampreface@end#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@Exampreface
    \expandafter\exampreface@wrap@up
  \else
    \@toklist=\expandafter{\the\@toklist\end{#1}}%
    \expandafter\get@exampreface@body
  \fi}
\def\exampreface@wrap@up{%
  \xdef\@examprefacetext{\the\@toklist}
  \end{exampreface}}
\def\@Exampreface{exampreface}
\def\examclosing{\@toklist={}
 \get@examclosing@body}
\def\endexamclosing{\relax}
\long\def\get@examclosing@body#1\end{%
  \@toklist=\expandafter{\the\@toklist#1}%
  \find@examclosing@end}
\def\find@examclosing@end#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@Examclosing
    \expandafter\examclosing@wrap@up
  \else
    \@toklist=\expandafter{\the\@toklist\end{#1}}%
    \expandafter\get@examclosing@body
  \fi}
\def\examclosing@wrap@up{%
  \xdef\@examclosingtext{\the\@toklist}
  \end{examclosing}}
\def\@Examclosing{examclosing}
\begin{exampreface}
  \relax
\end{exampreface}
\begin{examclosing}
  \relax
\end{examclosing}
\def\keypreface{\@toklist={}
 \get@keypreface@body}
\def\endkeypreface{\relax}
\long\def\get@keypreface@body#1\end{%
  \@toklist=\expandafter{\the\@toklist#1}%
  \find@keypreface@end}
\def\find@keypreface@end#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@Keypreface
    \expandafter\keypreface@wrap@up
  \else
    \@toklist=\expandafter{\the\@toklist\end{#1}}%
    \expandafter\get@keypreface@body
  \fi}
\def\keypreface@wrap@up{%
  \xdef\@keyprefacetext{\the\@toklist}
  \end{keypreface}}
\def\@Keypreface{keypreface}
\def\keyclosing{\@toklist={}
 \get@keyclosing@body}
\def\endkeyclosing{\relax}
\long\def\get@keyclosing@body#1\end{%
  \@toklist=\expandafter{\the\@toklist#1}%
  \find@keyclosing@end}
\def\find@keyclosing@end#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@Keyclosing
    \expandafter\keyclosing@wrap@up
  \else
    \@toklist=\expandafter{\the\@toklist\end{#1}}%
    \expandafter\get@keyclosing@body
  \fi}
\def\keyclosing@wrap@up{%
  \xdef\@keyclosingtext{\the\@toklist}
  \end{keyclosing}}
\def\@Keyclosing{keyclosing}
\begin{keypreface}
  \relax
\end{keypreface}
\begin{keyclosing}
  \relax
\end{keyclosing}
\def\append#1#2{%
  \global\temp@toks=\expandafter{\the #2\@separator {#1}}%
  \global#2=\expandafter{\the\temp@toks}}
\def\length#1{%
  \setcounter{length}{0}
  \def\@separator##1{\stepcounter{length}}\the#1}
\def\remove#1#2{%
  \exam@c=0
  \temptoks={}
  \def\@separator##1{\advance\exam@c by 1\relax
     \ifnum\exam@c=#1\relax%
     \setcounter{extract}{##1}%
     \else\append{##1}{\temptoks}
     \fi}
  \the#2
  \global#2=\expandafter{\the\temptoks}}
\let\@oldenddocumenthook=\@enddocumenthook
\def\@enddocumenthook{%
  \global\let\pagebreak=\old@pagebreak
  \global\let\BreakPageOnVersion=\exam@DoneReadingBreakPageOnVersion
  \setcounter{version}{1} \stepcounter{form}
  \@whilenum \value{version}<\value{form} \do{%
    \setcounter{innerloop}{0}
    \@whilenum \value{innerloop}<\value{passes} \do{%
        \setcounter{page}{1}
        \setcounter{questionnumber}{0}
        \setcounter{enumi}{0}
        \setcounter{equation}{0}
        \ifx\@frontmattertext\relax
          \relax
        \else
          \@frontmattertext \pagebreak
        \fi
        \ifnum \value{innerloop}=0 %
          \@examtopmatter
          \answerfalse
          \iftwocolumn \begin{multicols}{2}\fi
          \@examprefacetext
        \else%
          \@keytopmatter
          \answertrue
          \iftwocolumn \begin{multicols}{2}\fi
          \@keyprefacetext
        \fi
        \setcounter{sectionindex}{0}
        \@whilenum \value{sectionindex}<\value{section} \do{%
            \addtocounter{sectionindex}{1}
            \edef\current@section{\thesectionindex}
            \length{\csname qlist@sec\current@section\endcsname}
            \csname sec\current@section @fixed\endcsname
            \ifnotfixed
              \ifanswer \relax
              \else \typeout{Scrambling section \current@section, question: }\fi
              \exam@ScrambleQuestionList
            \else
              \csname qlist@scr@sec\current@section\endcsname=\expandafter{%
               \the\csname qlist@sec\current@section\endcsname}
            \fi
        \csname RS@sec@\current@section\endcsname
        \@ifundefined{sec\current@section break}
          {\relax}
          {\pagebreak}
        \ifsection{\@matching}{\@matchingmain}
        \ifsection{\@shortanswer}{\@shortanswermain}
        \ifsection{\@fillin}{\@fillinmain}
        \ifsection{\@MC}{\@multiplechoicemain}
        \ifsection{\@truefalse}{\@truefalsemain}}
        \ifnum \value{innerloop}=0 %
          \@examclosingtext\par
        \else
          \@keyclosingtext\par
        \fi
        \iftwocolumn \end{multicols} \fi
        \ifx\@endmattertext\relax
          \relax
        \else
          \pagebreak \@endmattertext \par
        \fi
        \pagebreak
        \addtocounter{innerloop}{1}}
      \@OneKeyHook
      \stepcounter{version}
      \setcounter{sectionindex}{0}
      \@whilenum \value{sectionindex}<\value{section} \do{%
        \addtocounter{sectionindex}{1}
        \edef\current@section{\thesectionindex}
        \csname sec\current@section @fixed\endcsname
        \ifnotfixed
          \exam@RestoreSectionLists
        \else \notfixedtrue\fi}
      }}

 \def\exam@RestoreSectionLists{%
   \csname qlist@sec\current@section\endcsname=\expandafter{\the\csname
     qlist@scr@sec\current@section\endcsname}
   \csname qlist@scr@sec\current@section\endcsname={}}

\def\exam@ScrambleQuestionList{%
  \length{\csname qlist@sec\current@section\endcsname}%
  \@whilenum \value{length}>0 \do{%
    \setrannum{\exam@m}{1}{\value{length}}%
    \remove{\exam@m}{\csname qlist@sec\current@section\endcsname}%
    \edef\@TEMP{\theextract}%
    \ifnum \value{length}=1
      \message{\@TEMP.}%
    \else
      \message{\@TEMP,}%
    \fi
    \expandafter\append\expandafter{\@TEMP}{\csname
      qlist@scr@sec\current@section\endcsname}
    \length{\csname qlist@sec\current@section\endcsname}}}
\def\NumberOfVersions#1{\setcounter{form}{#1}}
 \NumberOfVersions{1}
\def\instructions{\relax}
\def\class#1{\def\classdata{#1}}
\def\classdata{\relax}
\def\examname#1{\def\examtype{#1}}
 \examname{Exam}
\def\namedata{Name: \hrulefill \\[\namedata@vspace]
              Student Number: \hrulefill \\[\namedata@vspace]
              TA: \hrulefill \\[\namedata@vspace]
              Date: \hrulefill}
\define@key{section}{title}[\relax]{%
  \expandafter\gdef\csname head@sec\thesection\endcsname{#1}}

\define@key{section}{resetcounter}[yes]{%
  \def\exam@arg{#1}%
  \ifx\exam@arg\exam@c@yes
    \expandafter
    \gdef\csname RS@sec@\thesection\endcsname{\resetcountertrue}
  \else
    \expandafter
    \gdef\csname RS@sec@\thesection\endcsname{\resetcounterfalse}
  \fi}

\define@key{section}{suppressprefix}[yes]{%
  \def\exam@arg{#1}%
  \ifx\exam@arg\exam@c@yes
    \expandafter
    \gdef\csname SP@sec@\thesection\endcsname{\resetcountertrue}
  \fi}

\define@key{section}{rearrange}[yes]{%
  \def\exam@arg{#1}%
  \ifx\exam@arg\exam@c@yes
    \exam@SectionIsNotFixed
  \else
    \exam@SectionIsFixed
  \fi}

\define@key{section}{keycolumns}[1]{%
  \ifnum#1=1\relax\else
    \ifx\@currentsectionname\@matching
    \message{Column specification ignored for the `matching' environment.}
    \else
    \exam@SetKeyColumns{#1}
    \fi
  \fi}
\define@key{section}{examcolumns}[1]{%
  \ifnum#1=1\relax\else
    \ifx\@currentsectionname\@matching
    \message{Column specification ignored for the `message' environment.}
    \else
    \exam@SetExamColumns{#1}
    \fi
  \fi}

\def\exam@definesectiontype#1{%
  \expandafter\gdef\csname type@sec\thesection\endcsname{#1}}
\def\exam@SetKeyColumns#1{%
  \expandafter\gdef\csname sec\thesection @KCol\endcsname{#1}}
\def\exam@SetExamColumns#1{%
  \expandafter\gdef\csname sec\thesection @ECol\endcsname{#1}}
\def\exam@SectionIsNotFixed{%
   \expandafter\gdef\csname sec\thesection @fixed\endcsname{\notfixedtrue}}
\def\exam@SectionIsFixed{%
   \expandafter\gdef\csname sec\thesection @fixed\endcsname{\notfixedfalse}}
\def\exam@SetDefaultSectionTitle#1{
   \expandafter\gdef\csname head@sec\thesection\endcsname{#1}}
\def\exam@SetDefaultRecountState#1{
   \expandafter\gdef\csname RS@sec@\thesection\endcsname{#1}}
\def\exam@notitle{\exam@notitle}
\newenvironment{matching}[1][]
  {\begin{section}
   \def\@currentsectionname{matching}
   \exam@definesectiontype{matching}
   \exam@SetDefaultRearrangeBehavior
   \exam@SetDefaultSectionTitle{\exam@notitle}
   \exam@SetDefaultRecountState{\exam@DefaultNumberingBehavior}
   \setkeys{section}{#1}%
   \setcounter{temp}{0}%
   \exam@GetInstructionsForMatchingSection}
  {\end{section}}

\long\def\exam@GetInstructionsForMatchingSection#1\pair{%
  \@ifundefined{sec\thesection q\thequestion break}
    {\@toklist={}}
    {\@toklist={\old@pagebreak}}
  \expandafter
  \xdef\csname inst@sec\thesection\endcsname{\the\@toklist#1}\pair}

\def\exam@MatchingLineLength{.5in}
\def\exam@MatchingLineAfterSkip{6pt}
\def\pair#1#2{%
  \expandafter
  \xdef\csname sec\thesection @\thequestion @tag\endcsname{\thetemp}
  \expandafter
  \gdef\csname sec\thesection @qst\thequestion\endcsname{%
    \exam@PairA{\item[]\hskip-\leftmargin
      \ifanswer
      \underline{\makebox[\exam@MatchingLineLength][c]{\exam@GetMatchingAnswer}}%
      \hskip\exam@MatchingLineAfterSkip #1
      \else
      \rule{\exam@MatchingLineLength}{.4pt}%
      \hskip\exam@MatchingLineAfterSkip #1
      \fi}}
  \stepcounter{question}
  \expandafter
  \xdef\csname sec\thesection @\thequestion @tag\endcsname{\thetemp}
  \expandafter
  \gdef\csname sec\thesection @qst\thequestion\endcsname{%
    \exam@PairB{\item\relax\exam@SaveMatchingAnswer #2}}
  \stepcounter{temp}
  \stepcounter{question}}

\def\exam@GetMatchingAnswer{%
  \edef\exam@tag{\csname sec\current@section @\current@question
  @tag\endcsname}%
  \csname matching@answer@\exam@tag\endcsname}
\def\exam@SaveMatchingAnswer{%
  \edef\exam@tag{\csname sec\current@section @\current@question
    @tag\endcsname}%
  \expandafter
  \xdef\csname matching@answer@\exam@tag\endcsname{(\alph{enumi})}}

\newenvironment{fillin}[1][]
  {\begin{section}
   \def\@currentsectionname{fillin}
   \exam@definesectiontype{fillin}
   \exam@SetDefaultRearrangeBehavior
   \exam@SetDefaultSectionTitle{\exam@notitle}
   \exam@SetDefaultRecountState{\exam@DefaultNumberingBehavior}
   \setkeys{section}{#1}%
   \get@instructions \relax}
  {\end{section}}
\newenvironment{truefalse}[1][]
  {\begin{section}
   \def\@currentsectionname{truefalse}
   \exam@definesectiontype{truefalse}
   \exam@SetDefaultRearrangeBehavior
   \exam@SetDefaultSectionTitle{\exam@notitle}
   \exam@SetDefaultRecountState{\exam@DefaultNumberingBehavior}
   \setkeys{section}{#1}%
   \get@instructions \relax}
  {\end{section}}
\newenvironment{shortanswer}[1][]
  {\begin{section}
   \def\@currentsectionname{shortanswer}
   \exam@definesectiontype{shortanswer}
   \exam@SetDefaultRearrangeBehavior
   \exam@SetDefaultSectionTitle{\exam@notitle}
   \exam@SetDefaultRecountState{\exam@DefaultNumberingBehavior}
   \setkeys{section}{#1}%
   \get@instructions \relax}
  {\end{section}}
\newenvironment{multiplechoice}[1][]
  {\begin{section}
   \def\@currentsectionname{multiplechoice}
   \exam@definesectiontype{multiplechoice}
   \exam@SetDefaultRearrangeBehavior
   \exam@SetDefaultSectionTitle{\exam@notitle}
   \exam@SetDefaultRecountState{\exam@DefaultNumberingBehavior}
   \setkeys{section}{#1}%
   \get@instructions \relax}
  {\end{section}}
\def\@matching{matching}
\def\@fillin{fillin}
\def\@shortanswer{shortanswer}
\def\@truefalse{truefalse}
\def\@MC{multiplechoice}
\newcommand{\exam@DefaultChoice}[2][]{%
  \ifchoice \relax
    \else \@mcstartlist \choicetrue
  \fi
  \ifanswer
    \if#1!%
      \ifbox \vspace{-\fboxsep}\item[\hfill\fbox{(\alph{choice})}\hfill] #2
        \vspace{-\fboxsep}%
      \else
         \item[\hfill\MCfont{(\alph{choice})}\hfill] \MCfont{#2}%
      \fi
    \else \item[\hfill(\alph{choice})\hfill] #2
    \fi
    \stepcounter{choice}%
  \else
    \item[\hfill(\alph{choice})\hfill] #2
    \stepcounter{choice}%
  \fi}
\def\exam@EndChoiceListIfNecessary{%
  \ifchoice\end{list}\choicefalse\fi\setcounter{choice}{1}}
\let\choice=\exam@DefaultChoice
\def\@mcstartlist{\begin{list}{}{%
 \setlength{\topsep}{6pt}
 \setlength{\rightmargin}{0pt}
 \setlength{\labelwidth}{.35in}
 \setlength{\leftmargin}{.5in}
 \setlength{\labelsep}{.15in}
 \setlength{\itemindent}{0in}
 \setlength{\itemsep}{0pt}}}
\newcommand{\Fullpages}{\setlength{\topmargin}{0pc}
                        \setlength{\oddsidemargin}{0pc}
                        \setlength{\evensidemargin}{0pc}
                        \setlength{\headheight}{0pc}
                        \setlength{\headsep}{0pc}
                        \setlength{\textwidth}{6.5in}
                        \setlength{\textheight}{9in}}
\def\ConstantBlanks#1{\setlength{\blank@length}{#1}\cblankstrue\pblanksfalse}
\def\ProportionalBlanks#1{\edef\blank@multiplier{#1}\cblanksfalse\pblankstrue}
 \ProportionalBlanks{1}
\newcommand{\StudentInfoLineSpacing}[1]{\setlength{\namedata@vspace}{#1}}
 \StudentInfoLineSpacing{6pt}
\def\examtop{\@toklist={}
 \get@examtop@body}
\def\endexamtop{\relax}
\long\def\get@examtop@body#1\end{%
  \@toklist=\expandafter{\the\@toklist#1}%
  \find@examtop@end}
\def\find@examtop@end#1{%
  \def\@tempa{#1}%
   \ifx\@tempa\@XMtop\expandafter\XMtop@wrap@up
    \else\@toklist=\expandafter{\the\@toklist\end{#1}}%
     \expandafter\get@examtop@body\fi}
\def\XMtop@wrap@up{\xdef\@examtopmatter{\the\@toklist}%
 \end{examtop}}
\def\@XMtop{examtop}
\begin{examtop}
\@@line{\parbox{3in}{\classdata \\
        \examtype, Form:~\fbox{\textsf{\Alph{version}}}}
        \hfill
        \parbox{3in}{\normalsize \namedata}}
        \bigskip
\end{examtop}
\def\keytop{\@toklist={}
 \get@keytop@body}
\def\endkeytop{\relax}
\long\def\get@keytop@body#1\end{\@toklist=\expandafter{\the\@toklist#1}%
  \find@keytop@end}
\def\find@keytop@end#1{%
  \def\@tempa{#1}%
   \ifx\@tempa\@KYtop\expandafter\KYtop@wrap@up
    \else\@toklist=\expandafter{\the\@toklist\end{#1}}%
     \expandafter\get@keytop@body\fi}
\def\KYtop@wrap@up{\xdef\@keytopmatter{\the\@toklist}%
 \end{keytop}}
\def\@KYtop{keytop}
\begin{keytop}
\@@line{\hfill \Huge Answer Key
        for Exam \fbox{\textsf{\Alph{version}}}\hfill}
        \bigskip
\end{keytop}
\def\@Space{ }
\def\word#1{\def\@wordlist{#1}\expandafter\@wordmain\@wordlist \stop}

\def\@wordmain#1{%
  \ifx#1\@Space
   \let\@next=\@wordmain
  \else
   \ifx#1\stop
    \let\@next=\@dumpthenstart
   \else%
    \ifnum\value{wordtemp}=\value{version}%
     #1\let\@next=\@gobbletostop
    \else
     \stepcounter{wordtemp}%
     \let\@next=\@wordmain
    \fi
   \fi
  \fi
  \@next}
\def\@dumpthenstart{\expandafter\@wordmain\@wordlist \stop}
\def\@gobbletostop#1\stop{\relax\setcounter{wordtemp}{1}}
\def\ifsection#1#2{%
 \expandafter\ifx\csname type@sec\current@section\endcsname#1#2\fi}
\def\exam@AddSectionTitle{%
  \expandafter\ifx\csname head@sec\current@section\endcsname\exam@notitle
    \relax
  \else
    \par\vspace{\beforesectsep}
    \noindent {\exam@sectionfont \exam@sectionprefix
      \csname head@sec\current@section\endcsname}
    \par\vspace{\aftersectsep}
  \fi}

\def\exam@AddSectionInstructions{%
  \ifx\csname inst@sec\current@section\endcsname\relax
    \relax
  \else
    \vspace{\beforeinstsep}
    \csname inst@sec\current@section\endcsname
    \par\vspace{\afterinstsep}
  \fi}
\let\exam@AddSectionInstructionsHook=\exam@AddSectionInstructions
\def\exam@MakeAnswerEnvironGobble{%
  \def\answer{\get@noanswer@body}
  \def\endanswer{\relax}
  \def\@S{answer}
  \long\def\get@noanswer@body##1\end{\find@answer@end}
  \def\find@answer@end##1{\def\@tempa{##1}
    \ifx\@tempa\@S\expandafter\finish@up
    \else\expandafter\get@noanswer@body\fi}
  \def\finish@up{\end{answer}}}
\def\exam@PossiblyStartMultipleColumnsInKey{%
  \ifanswer
    \@ifundefined{sec\current@section @KCol}
      \relax
      {\begin{multicols}{\csname sec\current@section @KCol\endcsname}}
  \fi}
\def\exam@PossiblyEndMultipleColumnsInKey{%
  \ifanswer
    \@ifundefined{sec\current@section @KCol}
      \relax
      {\end{multicols}}
  \fi}
\def\exam@PossiblyStartMultipleColumnsInExam{%
  \ifanswer\relax\else
    \@ifundefined{sec\current@section @ECol}
      \relax
      {\begin{multicols}{\csname sec\current@section @ECol\endcsname}}
  \fi}
\def\exam@PossiblyEndMultipleColumnsInExam{%
  \ifanswer\relax\else
    \@ifundefined{sec\current@section @ECol}
      \relax
      {\end{multicols}}
  \fi}

\def\exam@EnumerateStyle{1.}
\def\exam@DefaultEnumerateStyle{1.}

\def\enumerate{%
  \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}\fi
  \@ifnextchar[{\exam@@enum@}{\@enum@}}
\def\exam@@enum@[#1]{\expandafter\@@enum@\expandafter[#1]}

\def\exam@TypesetQuestions{%
  \exam@PossiblyStartMultipleColumnsInKey
  \exam@PossiblyStartMultipleColumnsInExam
  \ifx\exam@EnumerateStyle\exam@DefaultEnumerateStyle
    \begin{enumerate}
  \else
    \begin{enumerate}[\exam@EnumerateStyle]
  \fi
    \ifresetcounter
      \setcounter{enumi}{0}
    \else
      \setcounter{enumi}{\value{questionnumber}}
    \fi
    \the\csname qlist@scr@sec\current@section\endcsname
    \setcounter{questionnumber}{\value{enumi}}
  \end{enumerate}
  \exam@PossiblyEndMultipleColumnsInKey
  \exam@PossiblyEndMultipleColumnsInExam}
\def\@shortanswermain{%
  \def\question{%
    \item
    \@beforequestionhook
    \exam@SAGobbleQuestionHook}
  \def\endquestion{\@endquestionhook}
  \def\@separator##1{\setcounter{temp}{##1}
    \edef\current@question{\thetemp}
    \csname sec\current@section @qst\current@question\endcsname}
  \ifanswer
    \exam@DefineAnswerEnvironment
  \else
    \exam@MakeAnswerEnvironGobble
  \fi
  \exam@AddSectionTitle
  \exam@AddSectionInstructionsHook
  \exam@TypesetQuestions}
\def\@matchingmain{%
  \def\@separator##1{\setcounter{temp}{##1}
    \edef\current@question{\thetemp}
    \csname sec\current@section @qst\current@question\endcsname}
  \exam@AddSectionTitle
  \exam@AddSectionInstructionsHook
  \def\exam@PairA##1{##1}
  \def\exam@PairB##1{}
  \edef\exam@questionnumber{\thequestionnumber}%
  \begin{multicols}{2}\raggedcolumns
  \exam@TypesetQuestions
  \def\exam@PairA##1{}
  \def\exam@PairB##1{##1}
  \def\exam@EnumerateStyle{(a)}
  \columnbreak
  \exam@TypesetQuestions
  \end{multicols}
  \setcounter{enumi}{\exam@questionnumber}%
  \setcounter{questionnumber}{\exam@questionnumber}}
\def\@fillinmain{%
  \def\question{%
    \item
    \@beforequestionhook
    \exam@FillinBlockGobbleQuestionHook}
  \def\endquestion{\@endquestionhook}
  \def\@separator##1{\setcounter{temp}{##1}
    \edef\current@question{\thetemp}
    \csname sec\current@section @qst\current@question\endcsname}
  \ifanswer
    \ifcblanks
    \def\blank##1{\mbox{\rule[-1pt]{\blank@length}{.4pt}%
        \hspace{-\blank@length}%
        \makebox[\blank@length]{##1}}}
    \fi
    \ifpblanks
    \def\blank##1{\settowidth{\temp@length}{##1}%
      \mbox{\rule[-1pt]{\blank@multiplier\temp@length}{.4pt}%
        \hspace{-\blank@multiplier\temp@length}%
        \makebox[\blank@multiplier\temp@length]{##1}}}
    \fi
  \else
    \ifcblanks
      \def\blank##1{\rule[-1pt]{\blank@length}{.4pt}}
    \fi
    \ifpblanks
      \def\blank##1{\settowidth{\temp@length}{##1}%
        \rule[-1pt]{\blank@multiplier\temp@length}{.4pt}}
    \fi
  \fi
  \exam@AddSectionTitle
  \exam@AddSectionInstructionsHook
  \exam@TypesetQuestions}
\def\@multiplechoicemain{\setcounter{mcchoice}{1}
   \def\question{\@mcitem
     \@beforequestionhook
     \exam@MCGobbleQuestionHook}
   \def\endquestion{\@endquestionhook
     \exam@EndChoiceListIfNecessary\@mcenditem}
   \def\@separator##1{\setcounter{temp}{##1}
     \edef\current@question{\thetemp}
     \csname sec\current@section @qst\current@question\endcsname}
   \exam@AddSectionTitle
   \exam@AddSectionInstructionsHook
   \exam@TypesetQuestions}
\def\@truefalsemain{%
   \def\@separator##1{\setcounter{temp}{##1}
     \edef\current@question{\thetemp}
     \csname sec\current@section @qst\current@question\endcsname}
   \def\question{%
     \edef\current@question{\thetemp.\theexam@tf}%
     \exam@TFItem \@beforequestionhook}
   \def\endquestion{\stepcounter{exam@tf}\@endquestionhook}
     \ifanswer
       \def\answer##1{\relax}
     \else
       \def\answer##1{\expandafter\gdef
          \csname tf@sol\current@question\endcsname{##1}}
          \vspace{-\smallskipamount}
     \fi
     \exam@AddSectionTitle
     \exam@AddSectionInstructionsHook
     \exam@StartTrueFalseList
     \the\csname qlist@scr@sec\current@section\endcsname
     \end{list}}

\def\exam@StartTrueFalseList{%
  \ifanswer
  \begin{list}{}
    {\setlength{\rightmargin}{0pt}
      \setlength{\labelwidth}{.4in}
      \setlength{\leftmargin}{.5in}
      \setlength{\labelsep}{.1in}
      \setlength{\itemindent}{0in}
      \setlength{\itemsep}{3pt}}
  \else
  \begin{list}%{$\underline{\mbox{\hphantom{false}}}$}
    {\setlength{\rightmargin}{0pt}
      \setlength{\labelwidth}{.35in}
      \setlength{\leftmargin}{.5in}
      \setlength{\labelsep}{.15in}
      \setlength{\itemindent}{0in}
      \setlength{\itemsep}{3pt}}
  \fi}
\def\@endquestionhook{\relax}
\def\@beforequestionhook{\relax}
\def\exam@DefaultTFItem{%
  \ifanswer
    \item[\uline{\makebox[.5in][c]{\csname tf@sol\current@question\endcsname}}]
  \else
    \item[\uline{\makebox[.5in][r]{\hss}}]
  \fi}
\let\exam@TFItem=\exam@DefaultTFItem
\def\@mcitem{\item\begin{minipage}[t]{\linewidth}}
\def\@mcenditem{\end{minipage}}
\def\answerspace#1{\ifanswer \relax \else \vspace*{#1} \fi}
\def\exam#1{\ifanswer\relax\else #1\fi}
\def\key#1{\ifanswer#1\fi}
\def\examvspace{\@ifnextchar*{\@examvspacestar}{\@examvspace}}
\def\@examvspacestar*#1{\exam{\vspace*{#1}}}
\def\@examvspace#1{\exam{\vspace{#1}}}
\def\examhspace{\@ifnextchar*{\@examhspacestar}{\@examhspace}}
\def\@examhspacestar*#1{\exam{\hspace*{#1}}}
\def\@examhspace#1{\exam{\hspace{#1}}}
\def\keyvspace{\@ifnextchar*{\@keyvspacestar}{\@keyvspace}}
\def\@keyvspacestar*#1{\key{\vspace*{#1}}}
\def\@keyvspace#1{\key{\vspace{#1}}}
\def\keyhspace{\@ifnextchar*{\@keyhspacestar}{\@keyhspace}}
\def\@keyhspacestar*#1{\key{\hspace*{#1}}}
\def\@keyhspace#1{\key{\hspace{#1}}}
\let\exam@oldlabel=\label
\renewcommand{\label}[1]{\exam{\exam@oldlabel{\theversion @#1}}}
\let\exam@oldref=\ref
\renewcommand{\ref}[1]{\exam@oldref{\theversion @#1}}
\def\problem{\stepcounter{enumi}\theenumi}
\def\SectionFont#1{\def\exam@sectionfont{#1}}
\SectionFont{\large} % The default value
\let\exam@SetDefaultRearrangeBehavior=\exam@SectionIsNotFixed
\def\NoRearrange{%
  \let\exam@SetDefaultRearrangeBehavior=\exam@SectionIsFixed}
\def\exam@resetcounter{%
  \ifresetcounter
    \setcounter{enumi}{0}
    \global\resetcounterfalse
  \else
    \setcounter{enumi}{\value{questionnumber}}
  \fi}
\def\SectionPrefix#1{%
  \def\exam@sectionprefix{%
    \@ifundefined{SP@sec@\current@section}
      {#1}
      \relax}}
\SectionPrefix{Section \arabic{sectionindex}. \space}
\def\ContinuousNumbering{%
  \let\exam@DefaultNumberingBehavior=\resetcounterfalse}
\let\exam@DefaultNumberingBehavior=\resetcountertrue

\def\exam@SAGobbleQuestionHook{\relax}% default values
\def\exam@MCGobbleQuestionHook{\relax}
\def\exam@TFGobbleQuestionHook{\relax}
\def\exam@FillinGobbleQuestionHook{\relax}
\def\exam@FillinBlockGobbleQuestionHook{\relax}
\def\exam@TrueFalseGobbleBlockInstructionsHook{\relax}
\def\exam@answer{answer}
\def\exam@enumerate{enumerate}
\def\exam@list{list}

\long\def\exam@BlockGobbleToBeginEnumerate#1\begin{%
  \exam@CheckNextTokenForEnumerate}
\def\exam@CheckNextTokenForEnumerate#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\exam@enumerate
    \exam@BeginEnumerate
  \else
    \expandafter\exam@BlockGobbleToBeginEnumerate
  \fi}
\def\exam@BeginEnumerate{\begin{enumerate}}

\long\def\exam@TrueFalseBlockInstructionsGobble#1\exam@StartTrueFalseList{%
  \exam@StartTrueFalseList}

\long\def\exam@GobbleUpToAnswer#1\begin{%
  \exam@CheckNextTokenForAnswer}
\def\exam@CheckNextTokenForAnswer#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\exam@answer
    \let\exam@next=\exam@PrepareToTypesetAnswer
  \else
    \ifx\@tempa\@endquestionhook
      \let\exam@next=\@endquestionhook
    \else
      \let\exam@next=\exam@GobbleUpToAnswer
  \fi\fi\exam@next}
\def\exam@PrepareToTypesetAnswer{\begin{answer}}

\long\def\exam@GobbleUpToEndQuestionHook#1\@endquestionhook{%
  \@endquestionhook}

\long\def\exam@GobbleUpToChoice#1\choice{\choice}

\def\exam@FillinGobbleNext#1{%
  \ifx #1\blank
    \let\exam@next=\exam@FillinInsertBlank
  \else
    \ifx #1\@endquestionhook
      \def\exam@insertedblank{no}%
      .\let\exam@next=\relax
    \else
      \let\exam@next=\exam@FillinGobbleNext
  \fi\fi\exam@next}

\def\exam@FillinBlockGobbleNext#1{%
  \ifx #1\blank
    \let\exam@next=\exam@FillinBlockInsertBlank
  \else
    \ifx #1\end
      \let\exam@next=\exam@CheckNextTokenForQuestion
    \else
      \let\exam@next=\exam@FillinBlockGobbleNext
  \fi\fi\exam@next}
\def\exam@CheckNextTokenForQuestion#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@Q
    \expandafter\exam@FillinWrapupAndEndQuestion
  \else
    \expandafter\exam@FillinBlockGobbleNext
  \fi}
\def\exam@FillinWrapupAndEndQuestion{.\end{question}}

\def\exam@insertedblank{no}
\def\exam@FillinInsertBlank#1{%
  \ifx\exam@insertedblank\exam@c@no
    #1\def\exam@insertedblank{yes}%
  \else
    , #1\relax
  \fi\exam@FillinGobbleNext}
\def\exam@FillinBlockInsertBlank#1{%
  \ifx\exam@insertedblank\exam@c@no
    #1\def\exam@insertedblank{yes}%
  \else
    , #1\relax
  \fi\exam@FillinBlockGobbleNext}

\def\ShortKey{%
  \def\exam@AddSectionInstructionsHook{%
    \ifanswer\relax\else\exam@AddSectionInstructions\fi}
  \def\exam@SAGobbleQuestionHook{%
    \ifanswer\expandafter\exam@GobbleUpToAnswer\fi}
  \def\exam@MCGobbleQuestionHook{%
    \ifanswer\expandafter\exam@GobbleUpToChoice\fi}
  \def\exam@FillinGobbleQuestionHook{%
    \ifanswer\expandafter\exam@FillinGobbleNext\fi}
  \def\exam@FillinBlockGobbleQuestionHook{%
    \ifanswer\expandafter\exam@FillinBlockGobbleNext\fi}
  \def\exam@GobbleBlockInstructionsHook{%
    \ifanswer\expandafter\exam@BlockGobbleToBeginEnumerate\fi}
  \def\exam@TrueFalseGobbleBlockInstructionsHook{%
    \ifanswer\expandafter\exam@TrueFalseBlockInstructionsGobble\fi}
  \let\choice=\exam@ShortChoice}

\def\exam@ShortChoice{%
  \ifanswer
    \expandafter\exam@ShortKeyChoice
  \else
    \expandafter\exam@DefaultChoice
  \fi}

\newif\ifOneCorrectAnswerAlreadyGiven
\OneCorrectAnswerAlreadyGivenfalse
\def\MultipleChoiceShortKeyPrefix#1{%
  \def\exam@MultipleChoiceShortKeyPrefix{#1}}
\MultipleChoiceShortKeyPrefix{}

\newcommand{\exam@ShortKeyChoice}[2][]{%
  \if#1!%
    \ifOneCorrectAnswerAlreadyGiven
    , (\alph{choice})
    \else
    \exam@MultipleChoiceShortKeyPrefix
    (\alph{choice})%
    \OneCorrectAnswerAlreadyGiventrue
    \fi
   \else
     \stepcounter{choice}%
  \fi\ignorespaces}

\def\exam@ShortTFItem{%
  \ifanswer
    \item[\csname tf@sol\current@question\endcsname]
  \else
    \item
  \fi}

\def\exam@c@yes{yes}
\def\exam@c@no{no}

\def\exam@MCMinipageWrapperBegin{\begin{minipage}[t]{\noexpand\linewidth}}
\def\exam@MCMinipageWrapperEnd{\end{minipage}}

\def\DefineAnswerWrapper#1#2{%
  \def\exam@DefineAnswerEnvironment{%
    \def\answer{#1}\def\endanswer{#2}}}
\DefineAnswerWrapper{\begin{description}\item[Answer:]}{\end{description}}

\let\old@pagebreak=\pagebreak
\def\exam@none{none}
\def\pagebreak{%
  \ifx\@currentsectionname\exam@none
    \setcounter{temp}{\thesection}
    \stepcounter{temp}
    \expandafter\def\csname sec\thetemp break\endcsname{\old@pagebreak}
  \else
    \expandafter
    \gdef\csname sec\thesection q\thequestion break\endcsname{\old@pagebreak}
  \fi}

\def\exam@WhileReadingBreakPageOnVersion#1{%
  \ifx\@currentsectionname\exam@none
    \setcounter{temp}{\thesection}%
    \stepcounter{temp}%
    \expandafter\def\csname sec\thetemp break\endcsname{%
      \ifnum\value{version}=#1\relax
        \old@pagebreak
      \fi}
  \else
    \expandafter
    \gdef\csname sec\thesection q\thequestion break\endcsname{%
      \ifnum\c@version=#1
        \old@pagebreak
      \fi}
  \fi}
\def\exam@DoneReadingBreakPageOnVersion#1{%
  \ifnum\value{version}=#1\relax
    \old@pagebreak
    \fi}
\let\BreakPageOnVersion=\exam@WhileReadingBreakPageOnVersion

\def\@currentsectionname{none}

\def\IncludeFromFile#1{\def\exam@includefile{#1}}

\def\InsertChunk#1{%
  \def\exam@chunklookup{#1}%
  \input{\exam@includefile}}

\def\chunk#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\exam@chunklookup
    \relax
  \else
    \expandafter\exam@GobbleRestOfChunk
  \fi}
\def\endchunk{\relax}

\def\exam@chunk{chunk}
\long\def\exam@GobbleRestOfChunk#1\end{%
  \exam@CheckNextTokenForChunk}
\def\exam@CheckNextTokenForChunk#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\exam@chunk
    \end{chunk}%
  \else
    \expandafter\exam@GobbleRestOfChunk
  \fi}

\endinput
%%
%% End of file `examdesign.cls'.
