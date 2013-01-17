\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ConcProg}[1996/10/09
                     class file ``ConcProg'' to write programmes for concerts]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% (C) Copyright 1995, Andrej Brodnik, Andrej.Brodnik@IMFM.Uni-Lj.SI.
%% All rights reserved.
%%
%% This file is under GPL.
%%
%% This is a generated file. Permission is granted to to customize the
%% declarations in this file to serve the needs of your installation.
%% However, no permission is granted to distribute a modified version of
%% this file under its original name.
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
%%
%%---

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% User documentation:
% ===================
%
% Environments:
% -------------
% \begin{programme}{<Title of the programme>} ... \end{programme}
%   The complete programme.
%
% \begin{part} ... \end{part}
%   Part of the concert. Between parts of the concerts is printed
%   centered \intermission.
%   Part has an optional argument in square brackets which defines its
%   title. By default \PartTitle is used. At the end of the part is
%   printed cenetered the command \PartEnd.
%   If user wants to redefine \PartTitle (s)he can use counter \Part
%   which counts the parts.
%
% \begin{composition}{<author>}{<years of birth (and death)>}
%                    {<title of the composition>}{<optional description>}
%                    ...
% \end{composition}
%   A single composition which is (sonata, etc.) of a single author.
%   If the title of composition is absent the pieces which are
%   following are not considered to make a single composition (e.g.
%   sonata etc.). The optional argument is used for something like
%   ``for soprano and violine'' etc.
%
% Commands:
% ---------
% \piece{<title>}{<optional description>}{<poet>}{<duration>}
%   Title of the piece (movement of sonata, song in a cycle, etc.),
%   poet (if applicable) and duration. The optional description is for
%   something like ``Op. 2 No.3''.
%
% \intermission
%   Prints out a centered string \IntermissionText, which, by deafult,
%   consists of ``-- -- --''.
%
% Valid options:
% --------------
% poets
%   If set, the names of poets are printed out.
%
% durations
%   If set the durations of individual pieces are printed out.
%
% General:
% --------
%
%   The title of the programme is typeset in Large small capitals and
%   centered in the beginning.
%
%   For typesetting the part the user can use commands \PartTitle and
%   \PartEnd which are printed at the beginning and at the end of the
%   part respectively. They are printed centered in the line. The user
%   can redefine these commands or, for \PartTitle, use an optional
%   square brackets in the ``part'' environment. After the last part, the
%   command \PartEnd is not printed.
%   In construction of commands user can use a counter \Part which
%   counts the parts.
%   By default the command \PartTitle prints ``Part <>'' where <>
%   stands for the number of part, and the command \PartEnd prints
%   ``-- End of Part --''.
%
%   When the composition is typeset, the title appears slanted and
%   bold, followed by a comma and the optional description (if given).
%   This is typeset in the box on the left hand side, while on the
%   right hand side we have author under which are her (his) dates in
%   parentheses. The pieces which appear inside the environment are
%   typeset on the left hand side as well.
%   If the title of composition is given, the pieces are indented for
%   the amount defined by the command ``\SetPieceIndentation''. By
%   default this is 1.5em.
%
%   Between compositions user sometimes wants to put a marker for
%   intermission (e.g. on the recital, when the soloists leaves the
%   stage). This is done using command \Intermission. It prints
%   centered text \IntermissionText. The latter can be changed by the
%   user using \renewcommand.
%
%   When the piece is typeset, its title is slanted. This is followed
%   by the optional description in parentheses (if given).
%   If the user sets option ``poets'' the poets follow the piece title
%   in small caps mode but in a smaller font.
%   If the user sets option ``durations'' they appear at the end of
%   the piece typesetting in parenthesized tiny form and pushed to the
%   right.
%
%------

%------
%
% System documentation:
% =====================
% Class ``ConcProg'' is based on the class ``article''.
%----------------------------------------

%%%%
%
% Process options and load class article:
%---
\newif\if@printPoets       \@printPoetsfalse     % by default no poets nor
\newif\if@printDurations   \@printDurationsfalse % duration times
\newif\if@printAuthors     \@printAuthorstrue    % but authors

\DeclareOption{poets}    { \@printPoetstrue     }
\DeclareOption{durations}{ \@printDurationstrue }
\DeclareOption{noauthors}{ \@printAuthorsfalse  }
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions

\LoadClass{article}            % ConcProg is based on the article class

\usepackage{ifthen}            % We also if-then-else construct.

%%%%
%
% General typesetting parameters and defaults:
%---
    %% text around parts
\newcounter{Part}                             % we count parts
\newcommand{\PartTitle}{Part \Roman{Part}}    % and this is the default
                                              % title of the part
\newcommand{\PartEnd}{-- End of Part --}      % and its ending

    %% intermissions
\newcommand{\IntermissionText}{-- -- --}      % intermission text and
\newcommand{\Intermission}{                   % the way to print it out
  \begin{center} \IntermissionText \end{center}
} % \Intermission

    %% indentation of pieces
\newlength{\@pieceIndent}             % amount the pieces are undented
\newcommand{\SetPieceIndentation}[1]{ % and the command to do it
  \setlength{\@pieceIndent}{#1}       %
} % \SetPieceIndentation
\SetPieceIndentation{1.5em}           % by default they are undented
                                      % for 1.5em

%%%%
%
% ``programme'' environment:
%---
\pagestyle{empty}

\newenvironment{programme}[1]{%
  % first the title
  \begin{center} \Large \textsc{#1} \end{center}

  \vspace{\bigskipamount}
}{%
} % programme

%%%%
%
% inside programme we have several ``parts''
%---
\renewenvironment{part}[1][\PartTitle]{       %
  \ifthenelse{\value{Part} = 0}               % is this the first part
  { \relax }                                  % then relax, otherwise
  { \nopagebreak[4]                           % conclude the previous one
    \ifthenelse{ \equal{#1}{\PartEnd} }       % with the end text
      { \relax }                              % if it exists
      { \begin{center} \PartEnd \end{center} }%
    \bigskip  \pagebreak[3]                   %
  } % \ifthenelse
  \stepcounter{Part}                          % Then begin a new part
  \ifthenelse{ \equal{#1}{} }                 % with a title (if exists)
    { \relax }                                %
    { \begin{center} #1 \end{center} }        %
}{%
} % part

%%%%
%
% Each part consists of several compositions
%---
\newlength{\@AuthorWidth}                   % the width of the author box
\newlength{\@TitleWidth}                    % the width of the box for titles
\newlength{\@tmpL}                          % just for calculation

\newenvironment{composition}[4]{%
  %---
  % #1 -- author
  % #2 -- years of brth (and death)
  % #3 -- title of composition
  % #4 -- additional explanation (e.g. ``for voice and violine Op. 2'')
  %---
  \def\@Author{#1}                           % Remember the author and
  \ifthenelse{ \equal{#2}{} }                % its dates.
    { \def\@Dates{}     }       % no date given --> write nothing
    { \def\@Dates{(#2)} }       % else --> dates in parentheses
       %% Next compute the width of the author box:
  \if@printAuthors
    \settowidth{\@AuthorWidth}{\@Author}     % the author and
    \settowidth{\@tmpL}{\@Dates}             % its dates:
    \ifthenelse{ \lengthtest{\@AuthorWidth < \@tmpL} }%
      { \setlength{\@AuthorWidth}{\@tmpL} }  % and take the wider one;
      { \relax }                             %
    \ifthenelse{ \lengthtest{\@AuthorWidth > 0.33\textwidth} }%
      { \setlength{\@AuthorWidth}{0.33\textwidth} } % but it must not be
      { \relax }                                    % wider than this.
  \else                                      %
    \setlength{\@AuthorWidth}{0pt}           %
  \fi                                        %
       %% And the width of the box for titles:
  \setlength{\@TitleWidth}{\textwidth}       % textwidth       -
  \addtolength{\@TitleWidth}{-\@AuthorWidth} % <author's box>  -
  \addtolength{\@TitleWidth}{-2em}           % <space between>
%

       %% Start typesetting both boxes:

\bigskip                                     % First some space,
\noindent                                    % then the composition:
%
\begin{minipage}[t]{\@TitleWidth}            % the title box:
  \setlength{\parindent}{-\@pieceIndent}     % we undent paragraphs
  \ifthenelse{ \equal{#3}{} }                % Do we have the title at all
    { \let\@piece=\indent }                  % no:  so all pieces are undented
    { \let\@piece=\relax                     % yes: pieces are not undented
      \ifthenelse{ \equal{#4}{} }            % then typeset the title
        { \textbf{\textsl{#3}} }             % no, so typeset only the
                                             % title
        { \textbf{\textsl{#3}}, #4 }         % otherwise also other
                                             % stuff
      \\                                     % and go into a new line
    }                                        %
%                                            % pieces come from here
}{%                                                 ...
%
\end{minipage}                               % up to here, and
%
\hfill                                       % push boxes apart
%
%                                            % and then the author box
\parbox[t]{\@AuthorWidth}{ \raggedleft       % we have everything to
  \if@printAuthors                           % the right
    \@Author \\ \@Dates                      %
  \fi                                        %
}                                            %
} % composition

%
% each composition contains several pieces:

\newcommand{\piece}[4]{%
  %---
  % #1 -- title of the piece
  % #2 -- additional explanation (e.g. ``Op.4 No. 2'')
  % #3 -- poet of the song (if applicable)
  % #4 -- duration
  %---
  \@piece \textsl{#1}                         % The TITLE of the piece
  \ifthenelse{ \equal{#2}{} }                 % if no EXPLANATION
    { \relax }                                % then relax
    { (#2) }                                  % otherwise insert it.
  \if@printPoets                              % Do we print the POET?
    \ifthenelse{ \equal{#3}{} }               % if no poet
      { \relax }                              % then do nothing
      { -- \textsc{\small #3} }               % type it in small capitals
  \fi                                         %
  \if@printDurations                          % Do we print DURATION times?
    \hfill {\tiny (#4)}                       % at the right end we
  \fi                                         % have duration
  \\                                          % and go into a new line
} % \piece
