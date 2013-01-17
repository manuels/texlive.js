% courseoutline.cls%------------------------------------------------------------------------%%% This is a class (.cls) file for LaTeX2e.%% %% Author:      Norman R. Gall%%              Department of Philosophy%%              The University of Calgary%%              Calgary, Alberta%%%%              ngall@ucalgary.ca%%%% Feel free to copy, modify, and distribute.%% I am interested in all changes you make.%% Please send changes to ngall@ucalgary.ca%%%% This file is based on the default article.cls file %%%% General Notes:%%
%%
%% My purpose in writing this .cls is to automate what I do all too often: 
%% write new course outlines. It is sometimes tedious but the main problem
%% is that the information is obscured by the LaTeX codes. I want to be 
%% able to just see the information when reading the source and when 
%% writing simply drop into the macros what I want.
%%
%% I think that I have chosen the macro names intelligently, but if anyone
%% has suggestions for more intuitive names, I'd like to hear from you.
%%%%
%% Version History% ---------------% v0.1  2002-02-16	Test of Class file 
% v0.9  2003-12-14	Added the rest of the macros and added the 
%					environments
% v1.0  2003-09-20	If there's no TA defined, no TA section will appear
%					First Release                  %					% - Command Notes ------------------------------
%
%% New commands (I hope these are self-explanatory}:	
%
% \university{}
% \department{}
%
% \coursename{}
% \coursenumber{}
% \coursesection{}
% \coursesession{}
% \coursetime{}
% \courselocation{}
% \coursewebpage{}
%
% \instructor{}
% \instructoroffice{}
% \instructorofficehours{}
% \instructorphone{}
% \instructoremail{}
%
% \ta{}
% \taoffice{}
% \taofficehours{}
% \taphone{}
% \taemail{}
% \tutorialtime{}
% \tutoriallocation{}
%
% New Environments
%
%
% Each new environment has the syntax
%
%	\begin{environment_name}[optional section name]
%
%	...Important things for students to know...
%
%	\end{environment_name}
%
%
% I have included the optional name for customisation convenience. I understand 
% that my tastes in choice of name are idiosyncratic.
%
% The environments do nothing more than set the name of the section. You can 
% call each section whatever you like and do whatever you would otherwise be 
% able to do inside any of these environments.
%
% \begin{introduction} ... \end{introduction}
%
%	Provides a section entitled `Course Description'
%
% \begin{evaluation} ... \end{evaluation}
%
%	Provides a section entitled `Evaluation'
%
% \begin{schedule} ... \end{schedule}
%
%	Provides a section entitled `Lecture Schedule'
%
% \begin{assignments} ... \end{assignments}
%
%	Provides a section entitled `Assignments'
%
% \begin{tutorials} ... \end{tutorials}
%
%	Provides a section entitled `Tutorials'
%
% \begin{administrivia} ... \end{administrivia}
%
%	Provides a section entitled `Miscellaneous'
%% - Identification -------------------------------------\NeedsTeXFormat{LaTeX2e}\ProvidesClass{courseoutline}[2003/09/14 v0.9]% Initial Code ---------------------------------------%\RequirePackage{ifthen}%% - Declaration of Options -----------------------------%% saving taken from dissertation.sty with modification%\PassOptionsToClass{letterpaper,oneside,onecolumn}{article}\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}\ExecuteOptions{draft}%% - Execution of Options -------------------------------%\ProcessOptions%% - Package Loading ------------------------------------%\LoadClass{article}%% - Main Code ------------------------------------------%%     some definitions %
\def\university#1{\gdef\@university{#1}}
\def\department#1{\gdef\@department{#1}}
\def\coursename#1{\gdef\@coursename{#1}}
\def\coursenumber#1{\gdef\@coursenumber{#1}}
\def\coursesection#1{\gdef\@coursesection{#1}}
\def\coursesession#1{\gdef\@coursesession{Session: #1}}
\def\coursetime#1{\gdef\@coursetime{Lecture Times: #1}}
\def\courselocation#1{\gdef\@courselocation{Room: #1}}
\def\coursewebpage#1{\gdef\@coursewebpage{WWW: #1}}
\def\texts#1{\gdef\@texts{#1}}
\def\instructor#1{\gdef\@instructor{Instructor: #1}}
\def\instructoroffice#1{\gdef\@instructoroffice{Office: #1}}
\def\instructorofficehours#1{\gdef\@instructorofficehours{#1}}
\def\instructorphone#1{\gdef\@instructorphone{Office Phone: #1}}
\def\instructoremail#1{\gdef\@instructoremail{E-mail: #1}}
\def\ta#1{\gdef\@ta{Teaching Assistant: #1}}
\def\taoffice#1{\gdef\@taoffice{Office: #1}}
\def\taofficehours#1{\gdef\@taofficehours{Office Hours: #1}}
\def\taphone#1{\gdef\@taphone{Office Phone: #1}}
\def\taemail#1{\gdef\@taemail{E-mail: #1}}
\def\tutorialtime#1{\gdef\@tutorialtime{#1}}
\def\tutoriallocation#1{\gdef\@tutoriallocation{#1}}%
\def\@ifdefined#1#2{\@ifundefined{#1}{}{#2}}%% Spacing and margins%% These margins are set for letter size paper for North American tastes.% Other users will have to make the relevant adjustments here or in their % LaTeX source file%\setlength {\topmargin}{0.0in}	 	% top margin    1.0 inch\setlength {\textheight}{8.5in}	 	% bottom margin 1.0 inch\setlength {\oddsidemargin}{0.0in}	% left margin   1.0 inch
\setlength {\evensidemargin}{0.0in}	% right margin  1.0 inch\setlength {\textwidth}{6.5in}	 	% right margin  1.0 inch\setlength {\footnotesep}{14pt}	 	% baseline skip for fn's 1st line\setlength {\headheight}{0.2in}	 	% make room for header\setlength {\headsep}{0.2in}		 	% modest header separation\setlength {\parskip}{0.2in}		 	% set a paragraph skip\setlength {\parindent}{0.0in}	 	% no para indents%% redefine the titlematter%\renewcommand\maketitle{\par  \begingroup    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%    \long\def\@makefntext##1{\parindent 1em\noindent            \hb@xt@1.8em{%                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%      \newpage      \global\@topnum\z@   % Prevents figures from going at top of page.      \@maketitle    \thispagestyle{empty}\@thanks  \endgroup  \setcounter{footnote}{0}%  \global\let\thanks\relax  \global\let\maketitle\relax  \global\let\@maketitle\relax  \global\let\@thanks\@empty  %
  \global\let\university\@empty
  \global\let\department\@empty
  \global\let\coursename\@empty
  \global\let\coursenumber\@empty
  \global\let\coursesection\@empty
  \global\let\coursesession\@empty
  \global\let\coursetime\@empty
  \global\let\courselocation\@empty
  \global\let\coursewebpage\@empty
  \global\let\texts\@empty
  \global\let\instructor\@empty
  \global\let\instructoroffice\@empty
  \global\let\instructorofficehours\@empty
  \global\let\instructorphone\@empty
  \global\let\instructoremail\@empty
  \global\let\ta\@empty
  \global\let\taoffice\@empty
  \global\let\taofficehours\@empty
  \global\let\taphone\@empty
  \global\let\taemail\@empty
  \global\let\tutorialtime\@empty
  \global\let\tutoriallocation\@empty
  %
  \global\let\university\relax
  \global\let\department\relax
  \global\let\coursename\relax
  \global\let\coursenumber\relax
  \global\let\coursesection\relax
  \global\let\coursesession\relax
  \global\let\coursetime\relax
  \global\let\courselocation\relax
  \global\let\coursewebpage\relax
  \global\let\texts\relax
  \global\let\instructor\relax
  \global\let\instructoroffice\relax
  \global\let\instructorofficehours\relax
  \global\let\instructorphone\relax
  \global\let\instructoremail\relax
  \global\let\ta\relax
  \global\let\taoffice\relax
  \global\let\taofficehours\relax
  \global\let\taphone\relax
  \global\let\taemail\relax
  \global\let\tutorialtime\relax
  \global\let\tutoriallocation\relax}\def\@maketitle{%  \newpage  \null  \vskip 2em%  \sffamily
  \begin{center}%
	{\Large \@university
	\@department}

	\vspace{.1in}

	\begin{Large}	\textbf{\@coursenumber\space\@coursesection\space\@coursename}
	\end{Large}

	\vspace{.1in}
	\begin{tabular}[t]{l r}	\@instructor & \@coursesession\\	\@instructoremail  & \@coursewebpage\\	Office: \@instructoroffice &  \@instructorphone \\
	Office Hours: & \@instructorofficehours\\
	&  \\	\@coursetime  & \@courselocation\\
	\end{tabular}

	\vspace{.1in}
	
	\@ifdefined {@ta}{
		\begin{tabular}[t]{l r}
		\@ta &  \@taemail \\		\@taoffice &   \@taphone \\
		\@taofficehours & \\
		&  \\
		Tutorial Times: &   Room\\
		\@tutorialtime  &  \@tutoriallocation\\
		\end{tabular} }  \end{center}
  \rmfamily\hrule\vskip 1em\par  \par  \vskip 1.5em}%% Set up headers%\def\ps@myheadings{%    \let\@oddfoot\@empty\let\@evenfoot\@empty    \def\@evenhead{\thepage -- \slshape\leftmark\hfil}%    \def\@oddhead{\hfil{\slshape\rightmark} -- \thepage}%    \let\@mkboth\@gobbletwo    }%
% Create environments
%
\newenvironment{textbooks}[1][Textbooks]{
	\@startsection{#1}{1}{\z@}%    		{-3.5ex plus -1ex minus -.2ex}%		{1.5ex plus .2ex}%
		{\sffamily\Large}*%
		{#1}}
	{\rmfamily\normalsize}
%
\newenvironment{introduction}[1][Course Description]{
	\@startsection{#1}{1}{\z@}%    		{-3.5ex plus -1ex minus -.2ex}%		{1.5ex plus .2ex}%
		{\sffamily\Large}*%
		{#1}}
	{\rmfamily\normalsize}
%
\newenvironment{evaluation}[1][Evaluation]{
	\@startsection{#1}{1}{\z@}%    		{-3.5ex plus -1ex minus -.2ex}%		{1.5ex plus .2ex}%
		{\sffamily\Large}*%
		{#1}}
	{\rmfamily\normalsize}
%
\newenvironment{schedule}[1][Lecture Schedule]{
	\@startsection{#1}{1}{\z@}%    		{-3.5ex plus -1ex minus -.2ex}%		{1.5ex plus .2ex}%
		{\sffamily\Large}*%
		{#1}}
	{\rmfamily\normalsize}
%
\newenvironment{assignments}[1][Assignment Details]{
	\@startsection{#1}{1}{\z@}%    		{-3.5ex plus -1ex minus -.2ex}%		{1.5ex plus .2ex}%
		{\sffamily\Large}*%
		{#1}}
	{\rmfamily\normalsize}
%
\newenvironment{tutorials}[1][Tutorials]{
	\@startsection{#1}{1}{\z@}%    		{-3.5ex plus -1ex minus -.2ex}%		{1.5ex plus .2ex}%
		{\sffamily\Large}*%
		{#1}}
	{\rmfamily\normalsize}
%
\newenvironment{administrivia}[1][Miscellaneous]{
	\@startsection{#1}{1}{\z@}%    		{-3.5ex plus -1ex minus -.2ex}%		{1.5ex plus .2ex}%
		{\sffamily\Large}*%
		{#1}}
	{\rmfamily\normalsize}%% End of file `courseoutline.cls'.