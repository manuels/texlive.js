%%
%% This is file `labbook.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% labbook.dtx  (with options: `labbook')
%% 
%% Copyright (C) 2002 Frank Küster.
%% 
%% All rights reserved.
\ProvidesClass{labbook}
            [2003/05/20 v1.1 LaTeX2e labbook document class]
\newif\ifwe@use@hyperref\we@use@hyperreffalse
\DeclareOption{hyperref}{\we@use@hyperreftrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax
\LoadClass{scrbook}
\RequirePackage{makeidx} \makeindex
\def\newexperiment#1{%
  \@ifnextchar [{\opt@arg@newexperiment{#1}}%
    {\nopt@arg@newexperiment{#1}}%]
}
\def\nopt@arg@newexperiment#1#2{%
  \@ifundefined{long@exp@#1}{%
    \@namedef{long@exp@#1}{#2}%
    \@namedef{short@exp@#1}{#2}%
    }{%
    \ClassError
      {labbook}
      {experiment abbreviation yet defined}
      {The abbreviation for an experiment that you wanted to define
      with this command has already been defined.}%
    }
}
\def\opt@arg@newexperiment#1[#2]#3{%
  \@ifundefined{long@exp@#1}{%
    \@namedef{long@exp@#1}{#3}%
    \@namedef{short@exp@#1}{#2}%
  }{%
    \ClassError
      {labbook}
      {experiment abbreviation yet defined}
      {The abbreviation for an experiment that you wanted to define
      with this command has already been defined.}%
  }
}
\def\newsubexperiment#1{%
  \@ifnextchar [{\opt@arg@newsubexperiment{#1}}%]
    {\nopt@arg@newsubexperiment{#1}}%
}%
\def\nopt@arg@newsubexperiment#1#2{%
  \@ifundefined{long@subexp@#1}{%
    \@namedef{long@subexp@#1}{#2}%
    \@namedef{short@subexp@#1}{#2}%
    }{%
    \ClassError
      {labbook}
      {experiment abbreviation yet defined}
      {The abbreviation for an experiment that you wanted to define
      with this command has already been defined.}%
    }%
}%
\def\opt@arg@newsubexperiment#1[#2]#3{%
  \@ifundefined{long@subexp@#1}{%
    \@namedef{long@subexp@#1}{#3}%
    \@namedef{short@subexp@#1}{#2}%
  }{%
    \ClassError
      {labbook}
      {experiment abbreviation yet defined}
      {The abbreviation for an experiment that you wanted to define
      with this command has already been defined.}%
  }%
}%
\def\@tmpA#1{%
\def\FK@@sp@def##1##2{%
  \futurelet\FK@tempa\FK@@sp@d##2\@nil\@nil#1\@nil\relax##1}%
\def\FK@@sp@d{%
  \ifx\FK@tempa\@sptoken
    \expandafter\FK@@sp@b
  \else
    \expandafter\FK@@sp@b\expandafter#1%
  \fi}%
\def\FK@@sp@b#1##1 \@nil{\FK@@sp@c##1}%
  }%
\def\FK@@sp@c#1\@nil#2\relax#3{\FK@toks@{#1}\edef#3{\the\FK@toks@}}%
\newtoks\FK@toks@%
\@tmpA{ }%
\newcounter{fk@commasep@argnumber}%
\def\fk@getcommasep@list#1#2#3#4#5#6{%
  \setcounter{fk@commasep@argnumber}{0}%
  #1
  \def\fk@commasep@beforebranch{#2}%
  \def\fk@commasep@firstelement{#3}%
  \def\fk@commasep@furtherelements{#4}%
  \def\fk@commasep@afterlastelement{#5\empty}%
  \def\fk@commasep@aftereachelement{#6}%
  \fk@@getcommasep@list
}
\def\fk@@getcommasep@list#1,{%
  \stepcounter{fk@commasep@argnumber}%
  \fk@commasep@beforebranch%
  \ifx\relax#1%
    \fk@commasep@afterlastelement%
  \else%
    \FK@@sp@def\fk@commasep@arg{#1}%
    \ifnum\c@fk@commasep@argnumber=1%
      \fk@commasep@firstelement%
    \else%
      \fk@commasep@furtherelements%
    \fi%
    \fk@commasep@aftereachelement%
    \expandafter\fk@@getcommasep@list%
  \fi%
}
\newcounter{fk@atdashsep@argnumber}%
\def\fk@getatdashsep@list#1#2#3#4#5#6{%
  \setcounter{fk@atdashsep@argnumber}{0}%
  #1
  \def\fk@atdashsep@beforebranch{#2}%
  \def\fk@atdashsep@firstelement{#3}%
  \def\fk@atdashsep@furtherelements{#4}%
  \def\fk@atdashsep@afterlastelement{#5\empty}%
  \def\fk@atdashsep@aftereachelement{#6}%
  \fk@@getatdashsep@list
}
\def\fk@@getatdashsep@list#1§{%
  \stepcounter{fk@atdashsep@argnumber}%
  \fk@atdashsep@beforebranch%
  \ifx\relax#1%
    \fk@atdashsep@afterlastelement%
  \else%
    \FK@@sp@def\fk@atdashsep@arg{#1}%
    \ifnum\c@fk@atdashsep@argnumber=1%
      \fk@atdashsep@firstelement%
    \else%
      \fk@atdashsep@furtherelements%
    \fi%
    \fk@atdashsep@aftereachelement%
    \expandafter\fk@@getatdashsep@list%
  \fi%
}
\newif\ifmore@thanone@item%
\def\fk@parse@optarg{%
  \fk@getcommasep@list{%
    \more@thanone@itemfalse%
  }{%
  }{%
    \@onelevel@sanitize{\fk@commasep@arg}%
    \protected@edef\fk@current@tocentry{\fk@commasep@arg}%
  }{%
    \more@thanone@itemtrue%
    \protected@edef\fk@currentarg{\fk@commasep@arg}%
    \@onelevel@sanitize{\fk@currentarg}%
    \protected@edef\fk@currentarg@withspace{\fk@currentarg\space}%
    \expandafter\fk@checkifabbrev@arg%
      \fk@currentarg@withspace&{long@\fk@explevel}%
    \ifabbrev@defined%
      \expandafter\protected@edef%
          \csname fk@current@\fk@explevel name\expandafter%
          \endcsname{%
            \csname short@\fk@explevel @\fk@currentarg\endcsname}%
      \fk@buildindexlist{%
        \csname short@\fk@explevel @\fk@currentarg\endcsname}%
    \else%
      \expandafter\protected@edef%
          \csname fk@current@\fk@explevel name\endcsname{%
            \fk@currentarg}%
      \expandafter\fk@buildindexlist{\fk@currentarg}
    \fi%
  }{%
    \protected@edef\fk@currentarg{\fk@current@tocentry}%
    \@onelevel@sanitize{\fk@currentarg}%
    \protected@edef\fk@currentarg@withspace{\fk@currentarg\space}%
    \expandafter\fk@checkifabbrev@arg%
      \fk@currentarg@withspace&{long@\fk@explevel}%
    \ifmore@thanone@item\else%
      \ifabbrev@defined%
        \fk@buildindexlist{%
          \csname short@\fk@explevel @\fk@currentarg\endcsname}%
      \else%
        \expandafter\fk@buildindexlist{\fk@currentarg}%
      \fi%
    \fi%
  }{%
  }%
}
\def\fk@exp@indexlist{}%
\def\fk@subexp@indexlist{}%
\def\fk@buildindexlist#1{%
  \def\@tmpA{exp}
  \ifx\fk@explevel\@tmpA
    \protected@edef\fk@exp@indexlist{#1§\fk@exp@indexlist}
  \else
    \protected@edef\fk@subexp@indexlist{#1§\fk@subexp@indexlist}
  \fi
}
\def\fk@useindexlist{%
  \fk@getatdashsep@list{}{}{}{}{}{%
    \fk@@writeindex{\fk@atdashsep@arg}%
  }%
}%
\def\fk@@writeindex#1{%
  \def\@tmpA{exp}%
  \ifx\fk@explevel\@tmpA%
    \fk@writeindex{#1}%
  \else%
    \ifx\fk@parselevel\@tmpA% we are iterating over the current list
                            % of experiments
      \protected@edef\fk@current@expname{#1}
      \def\fk@parselevel{subexp}
      \expandafter\fk@useindexlist\fk@subexp@indexlist\relax§%
      \def\fk@parselevel{exp}
    \else
      \fk@writeindex{\fk@current@expname!#1}%
    \fi
  \fi%
}%
\def\fk@openindex#1{\index{#1|(}}%)
\def\fk@closeindex#1{\index{#1|)}}%)
\def\muST@bE@emPTy{\message{Numquam videbor}}%
\newif\ifabbrev@defined%
\def\fk@checkifabbrev@arg #1 #2&#3{%
  \ifx\muST@bE@emPTy#2\muST@bE@emPTy%
    \protected@edef\@tmpA{#1\space}%
    \expandafter\fk@checkfirst\@tmpA{#3}%
  \else%
    \abbrev@definedfalse%
  \fi%
}%
\def\fk@checkfirst #1 #2{%
  \@ifundefined{#2@#1}{\abbrev@definedfalse}{\abbrev@definedtrue}%
}%
\def\fk@close@labindex{%
  \let\fk@writeindex\fk@closeindex%
  \@ifundefined{fk@explevel}{}{%
    \def\@tmpA{exp}%
    \ifx\fk@explevel\@tmpA%
      \def\fk@parselevel{exp}%
      \def\fk@explevel{subexp}%
      \fk@@close@labindex%
      \def\fk@explevel{exp}%
      \fk@@close@labindex%
    \else%
      \fk@@close@labindex%
    \fi%
  }%
}%
\def\fk@@close@labindex{%
  \expandafter\fk@useindexlist\fk@exp@indexlist\relax§%
  \expandafter\def\csname fk@\fk@explevel @indexlist\endcsname{}%
}
\newcounter{labday}
\newcounter{experiment}[labday]
\newcounter{subexperiment}[experiment]
\@addtoreset{footnote}{labday}
\@addtoreset{subsubsection}{subexperiment}
\let\experimentmark\@gobble
\let\subexperimentmark\@gobble
\setcounter{tocdepth}{3}
\def\experiment{%
  \def\fk@explevel{exp}
  \fk@close@labindex%
  \lower@sectionlevelfalse%
  \@ifstar{\@sexperiment}{\@experiment}%
}
\def\@experiment{%
  \@ifnextchar [{\opt@arg@experiment}{\nopt@arg@experiment}%
}
\def\nopt@arg@experiment#1{%
  \def\fk@currentarg{#1 }\@onelevel@sanitize{\fk@currentarg}%
  \expandafter\fk@checkifabbrev@arg\fk@currentarg&{long@exp}%
  \ifabbrev@defined%
    \fk@buildindexlist{\csname short@exp@#1\endcsname}%
    \@startsection{experiment}{1}{\z@}%
         {-3.5ex \@plus -1ex \@minus -.2ex}%
         {2.3ex \@plus.2ex}%
         {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
         [\@nameuse{short@exp@#1}]{\@nameuse{long@exp@#1}}%
  \else%
    \expandafter\fk@buildindexlist{\fk@currentarg}
    \@startsection{experiment}{1}{\z@}%
         {-3.5ex \@plus -1ex \@minus -.2ex}%
         {2.3ex \@plus.2ex}%
         {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
         {#1}%
  \fi%
}%
\def\opt@arg@experiment[#1]#2{%
  \fk@parse@optarg#1,\relax,%
  \ifabbrev@defined%
    \def\fk@currentarg{#2 }\@onelevel@sanitize{\fk@currentarg}%
    \expandafter\fk@checkifabbrev@arg\fk@currentarg&{long@exp}%
    \ifabbrev@defined%
          \expandafter\ifx%
               \csname short@exp@\fk@current@tocentry\expandafter%
               \endcsname\csname short@exp@#2\endcsname%
            \@startsection{experiment}{1}{\z@}%
              {-3.5ex \@plus -1ex \@minus -.2ex}%
              {2.3ex \@plus.2ex}%
              {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
              [\@nameuse{short@exp@\fk@current@tocentry}]%
              {\@nameuse{long@exp@#2}}%
          \else%
            \ClassError
             {labbook}
             {index entry and experiment title don't match}
             {%
               You have used \protect\experiment\space with an
               optional argument, and used abbreviations
               \MessageBreak both in the optional argument
               (the first item in square brackets, for the index
               and toc\MessageBreak entries) and the mandatory
               argument (in curly braces, for the experiment title
               in the text). This is only possible if both would
               yield the same index/toc\MessageBreak
               entries. However, you requested the index
               entry\MessageBreak
               \@nameuse{short@exp@\fk@current@tocentry}
               \MessageBreak
               but the title corresponds to index entry\MessageBreak
               \@nameuse{short@exp@#2}}%
          \fi%
    \else%
      \ClassWarning{labbook}
        {Using a pre-defined short form for this
          \protect\experiment.\MessageBreak
          Please check that the abbreviation\MessageBreak
          \csname short@exp@#1\endcsname\MessageBreak corresponds
          properly to the long form \MessageBreak #2\MessageBreak}
      \@startsection{experiment}{1}{\z@}%
        {-3.5ex \@plus -1ex \@minus -.2ex}%
        {2.3ex \@plus.2ex}%
        {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
        [\@nameuse{short@exp@\fk@current@tocentry}]{#2}%
    \fi%
  \else%
    \def\fk@currentarg{#2 }\@onelevel@sanitize{\fk@currentarg}%
    \expandafter\fk@checkifabbrev@arg\fk@currentarg&{long@exp}%
    \ifabbrev@defined%
    \ClassError {labbook} {Manual short form conflicts with
      abbreviated title} {You have used an optional argument to
      \protect\experiment\space (the first element in
      square\MessageBreak brackets) that TeX does not
      recognize as an abbreviation. However, in the
      \MessageBreak experiment title (in the curly braces),
      you have used an abbreviation defined\MessageBreak with
      \protect\newexperiment. This doesn't make sense, so
      I don't accept it.}%
    \else%
      \@startsection{experiment}{1}{\z@}%
         {-3.5ex \@plus -1ex \@minus -.2ex}%
         {2.3ex \@plus.2ex}%
         {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
         [\fk@current@tocentry]{#2}%
    \fi%
  \fi%
}%
\def\@sexperiment#1{%
  \ClassError{labbook}{%
    Starred form of \protect\experiment\space not defined
  }{%
    There is no starred form of \protect\experiment\space defined
  in this version of labbook.cls. Please use the unstarred form, or
  check for a new version.
  }
}
\def\subexperiment{%
  \def\fk@explevel{subexp}%
  \def\fk@parselevel{exp}%
  \fk@close@labindex%
  \lower@sectionlevelfalse%
  \@ifstar{\@ssubexperiment}{\@subexperiment}%
}%
\def\@subexperiment{%
  \@ifnextchar [{\opt@arg@subexperiment}{\nopt@arg@subexperiment}%]
}%
\def\nopt@arg@subexperiment#1{%
  \def\fk@parselevel{exp}
  \def\fk@currentarg{#1 }\@onelevel@sanitize{\fk@currentarg}%
  \expandafter\fk@checkifabbrev@arg\fk@currentarg&{long@subexp}%
  \ifabbrev@defined%
    \fk@buildindexlist{\csname short@subexp@#1\endcsname}%
    \@startsection{subexperiment}{2}{\z@}%
         {-3.5ex \@plus -1ex \@minus -.2ex}%
         {2.3ex \@plus.2ex}%
         {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
         [\@nameuse{short@subexp@#1}]{\@nameuse{long@subexp@#1}}%
  \else
    \expandafter\fk@buildindexlist{#1}
    \@startsection{subexperiment}{2}{\z@}%
         {-3.5ex \@plus -1ex \@minus -.2ex}%
         {2.3ex \@plus.2ex}%
         {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
         {#1}%
  \fi%
}%
\def\opt@arg@subexperiment[#1]#2{%
  \def\fk@parselevel{subexp}
  \fk@parse@optarg#1,\relax,%
  \def\fk@parselevel{exp}%
  \ifabbrev@defined%
    \def\fk@currentarg{#2 }\@onelevel@sanitize{\fk@currentarg}%
    \expandafter\fk@checkifabbrev@arg\fk@currentarg&{long@exp}%
    \ifabbrev@defined%
      \expandafter\ifx\csname short@subexp@\fk@current@tocentry%
          \expandafter\endcsname\csname short@subexp@#2\endcsname%
        \@startsection{subexperiment}{2}{\z@}%
           {-3.5ex \@plus -1ex \@minus -.2ex}%
           {2.3ex \@plus.2ex}%
           {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
           [\@nameuse{short@subexp@\fk@current@tocentry}]%
           {\@nameuse{long@subexp@#2}}%
      \else%
        \ClassError
          {labbook}
          {index entry and subexperiment title don't match}
          {%
            You have used \protect\subexperiment\space with an
            optional argument, and used abbreviations\MessageBreak
            both in the optional argument (in square brackets, for
            the index and toc\MessageBreak entries) and the
            mandatory argument (in curly braces, for the experiment
            title in the text). This is only possible if both would
            yield the same index/toc\MessageBreak entries. However,
            you requested the index entry\MessageBreak
            \@nameuse{short@subexp@#1}\MessageBreak
            but the title corresponds to index entry\MessageBreak
            \@nameuse{short@subexp@#2}}%
      \fi%
    \else%
       \ClassWarning{labbook}
         {Using a pre-defined short form for this
          \protect\subexperiment.\MessageBreak
          Please check that the abbreviation\MessageBreak \csname
          short@subexp@#1\endcsname\MessageBreak corresponds
          properly to the long form \MessageBreak #2\MessageBreak}%
       \@startsection{subexperiment}{2}{\z@}%
         {-3.5ex \@plus -1ex \@minus -.2ex}%
         {2.3ex \@plus.2ex}%
         {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
         [\@nameuse{short@subexp@\fk@current@tocentry}]{#2}%
    \fi%
  \else%
    \def\fk@currentarg{#2 }\@onelevel@sanitize{\fk@currentarg}%
    \expandafter\fk@checkifabbrev@arg\fk@currentarg&{long@subexp}%
    \ifabbrev@defined%
      \ClassError
         {labbook}
         {Manual short form conflicts with abbreviated title}
         {You have used an optional argument to
          \protect\subexperiment\space (the short form, in
          \MessageBreak square brackets) that TeX does not
          recognize as an abbreviation. However, \MessageBreak
          in the subexperiment title (in the curly braces),
          you have used an abbreviation\MessageBreak defined
          with \protect\newsubexperiment. This doesn't make
          sense, so I don't accept it.}%
    \else%
      \@startsection{subexperiment}{2}{\z@}%
         {-3.5ex \@plus -1ex \@minus -.2ex}%
         {2.3ex \@plus.2ex}%
         {\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}%
         [\fk@current@tocentry]{#2}%
    \fi%
  \fi%
}%
\def\@ssubexperiment#1{%
  \ClassError{labbook}{%
    Starred form of \protect\subexperiment\space not defined
  }{%
    There is no starred form of \protect\subexperiment\space defined
  in this version of labbook.cls. Please use the unstarred form, or
  check for a new version.
  }%
}%
\newcommand*{\labday}{%
  \def\fk@explevel{exp}%
  \fk@close@labindex%
  \let\fk@explevel\@undefined%
  \refstepcounter{labday}%
  \addchap%
}%
\let\fk@part\part
\renewcommand*{\part}{%
  \def\fk@explevel{exp}%
  \fk@close@labindex%
  \let\fk@explevel\@undefined%
  \fk@part%
}
\newif\iflower@sectionlevel
\let\fk@oldsubsubsection\subsubsection%
\renewcommand{\subsubsection}{%
  \lower@sectionleveltrue%
  \fk@oldsubsubsection%
}
\renewcommand*\theexperiment{\@arabic\c@experiment}%
\renewcommand*\thesubexperiment{%
  \theexperiment.\@arabic\c@subexperiment}%
\renewcommand*\thesubsubsection{%
  \thesubexperiment.\@arabic\c@subsection}%
\renewcommand*\theparagraph{%
  \thesubsubsection.\@arabic\c@paragraph}%
\renewcommand*\thesubparagraph{%
  \theparagraph.\@arabic\c@subparagraph}%
\@addtoreset{figure}{labday}%
\@addtoreset{table}{labday}%
\renewcommand*\thefigure{%
  \@arabic\c@figure}%
\renewcommand*\thetable{%
  \@arabic\c@table}%
\let\l@labday\l@chapter%
\let\l@experiment\l@section%
\let\l@subexperiment\l@subsection%
\def\define@addcontentsline{%
  \let\fk@old@addcontentsline\addcontentsline%
  \def\addcontentsline##1##2##3{%
    \fk@old@addcontentsline{##1}{##2}{##3}%
    \def\@tmpA{toc}%
    \def\@tmpB{##1}%
    \ifx\@tmpA\@tmpB%
      \@ifundefined{fk@explevel}{}{%
        \iflower@sectionlevel\else%
          \let\fk@writeindex\fk@openindex%
          \expandafter\fk@useindexlist\fk@exp@indexlist\relax§%
        \fi%
      }%
    \fi%
  }%
}%
\ifwe@use@hyperref\else%
  \define@addcontentsline%
\fi%
\newif\iflast@labindex@closed\last@labindex@closedfalse%
\let\fk@old@appendix\appendix%
\def\appendix{%
  \iflast@labindex@closed\else%
    \def\fk@explevel{exp}%
    \fk@close@labindex%
    \last@labindex@closedtrue%
    \let\fk@explevel\@undefined%
    \setcounter{footnote}{0}%
  \fi%
  \fk@old@appendix%
}%
\let\fk@old@backmatter\backmatter%
\def\backmatter{%
  \iflast@labindex@closed\else%
    \def\fk@explevel{exp}%
    \fk@close@labindex%
    \last@labindex@closedtrue%
    \let\fk@explevel\@undefined
    \setcounter{footnote}{0}%
  \fi%
  \fk@old@backmatter%
}
\AtEndDocument{%
  \iflast@labindex@closed\else%
    \def\fk@explevel{exp}%
    \fk@close@labindex%
  \fi%
}
\ifwe@use@hyperref
  \AfterPackage{hyperref}{%
    \define@addcontentsline%
    \providecommand*{\toclevel@labday}{0}%
    \providecommand*{\toclevel@experiment}{1}%
    \providecommand*{\toclevel@subexperiment}{2}%
    \newcommand*\theHlabday{%
      \arabic{labday}}%
    \newcommand*\theHexperiment{%
      \theHlabday.\arabic{experiment}}%
    \newcommand*\theHsubexperiment{%
      \theHexperiment.\arabic{subexperiment}}%
    \renewcommand*\theHsubsubsection{%
      \theHsubexperiment.\arabic{subsubsection}}%
    \renewcommand*\theHfigure{%
      \theHlabday.\arabic{figure}}%
    \renewcommand*\theHtable{%
      \theHlabday.\arabic{table}}%
    \newcommand*\theHsubfigure{%
      \theHfigure.\arabic{subfigure}}
  }%
  \AtBeginDocument{%
    \@ifpackageloaded{hyperref}{}{%
      \ClassError{labbook}{%
        hyperref option given, but package not loaded}{%
        You have specified the class option hyperref, but
        not loaded the package until \protect\begin{document}.
      }
    }
  }
\else
  \AtBeginDocument{%
    \@ifpackageloaded{hyperref}{%
      \ClassError{labbook}{%
        hyperref option not given, but package loaded}{%
        You have not specified the class option hyperref,
        but loaded the package. Don't do that again!
      }%
    }{}%
  }%
\fi%
\endinput
%%
%% End of file `labbook.cls'.
