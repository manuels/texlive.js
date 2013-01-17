% exam.cls
%
% A LaTeX2e document class for preparing exams.

%% exam.cls
%% Copyright (c) 1994, 1997, 2000, 2004, 2008 Philip S. Hirschhorn
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.
%
% This work has the LPPL maintenance status "author-maintained".
% 
% This work consists of the files exam.cls and examdoc.tex.


% The user's guide for exam.cls is in the file examdoc.tex.


%%% Philip Hirschhorn
%%% Department of Mathematics
%%% Wellesley College
%%% Wellesley, MA 02481
%%% psh@math.mit.edu

% The newest version of this documentclass should always be available
% from my web page: http://www-math.mit.edu/~psh/


\def\fileversion{2.4}
\def\filedate{2011/05/22}
%---------------------------------------------------------------------
%---------------------------------------------------------------------
% 
% If there's some feature that you'd like that this file doesn't
% provide, tell me about it.
% 
%
%
%
%
% Thanks to:
%
% Piet van Oostrum, from whose excellent ``fancyheadings.sty'' we
% shamelessly stole most of the code for setting the headers and
% footers.
%
% Mate Wierdl <mw@wierdlmpc.msci.memphis.edu>, who contributed the
% code so that if the number of points is ``1'', then the default
% value of \pointname will print ``1 point'' instead of ``1 points''.
%
% Tom Brikowski <brikowi@utdallas.edu>, who contributed the code for
% making the number of points and number of questions available as
% macros (as well as the idea of putting the number of points in a 
% box, instead of in parentheses).  (I changed his code to make this
% all optional, so if there are errors there, it's my fault and not
% his.)
%
% Ottmar Beucher <beucher@fh-karlsruhe.de>, Dan Drake
% <drake@math.umn.edu>, and Justus Piater <Justus.Piater@ULg.ac.be> who
% contributed ideas and code for the \pointsofquestion and \gradetable
% commands for printing a Grading Table.  (I changed all the code to
% make this compatible with hyperref.sty, so if there are errors there,
% it's my fault and not theirs.)
%
% Justus Piater <Justus.Piater@ULg.ac.be>, who contributed the code for
% the solution environment.  (I changed his code to allow page breaks
% inside solutions so, once again, if it's buggy, it's my fault.) 
%
% Donald Arseneau <asnd@triumf.ca>, who created the excellent
% ``framed.sty'' and generously allowed me to include basically the
% whole thing in exam.cls, making the few changes needed for it to
% work well with question environments:
% framed.sty   v 0.8a   21-Jul-2003
% Copyright (C) 1992-2003 by Donald Arseneau
% These macros may be freely transmitted, reproduced, or modified
% provided that this notice is left intact.
%
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%                    Changelog since version 2.3:

%--------------------------------------------------------------------
% Version 2.4, 2011/05/22:
%
% No longer betatest.
%
%--------------------------------------------------------------------
% Version 2.321$\beta$, 2011/05/15:
%
% New environments: EnvUplevel and EnvFullwidth
%
% The EnvUplevel environment is similar to the command \uplevel,
% except that \uplevel is a command taking one argument.  The
% EnvUplevel environment has the advantage that you can include
% verbatim material (using, e.g., the \verb command) in the
% environment.  (You can't include verbatim material in the argument
% of an \uplevel command.)
%
% The EnvFullwidth environment is similar to the command \fullwidth,
% except that \fullwidth is a command taking one argument.  The
% EnvFullwidth environment has the advantage that you can include
% verbatim material (using, e.g., the \verb command) in the
% environment.  (You can't include verbatim material in the argument
% of a \fullwidth command.)
%
%--------------------------------------------------------------------
% Version 2.320$\beta$, 2011/04/16:
%
% New document class options: cancelspace
%                             nocancelspace
%               New commands: \cancelspace
%                             \nocancelspace
%
% Using the document class option cancelspace is equivalent to giving
% the command \cancelspace at the beginning of the file.  The default is
% \nocancelspace.  Thus, the document class option nocancelspace has no
% effect, but is there to avoid errors if a user is confused.
%
% If the user uses the document class option cancelspace and if
% solutions are not being printed, then any space that would be added by
% an optional argument to the solution, solutionorbox, solutionorlines,
% or solutionordottedlines environments will not be added.
%
% If solutions are being printed (because the user used the document
% class option answers or gave the command \printanswers), then the
% option cancelspace (and the command \cancelspace) will have no
% effect.
%
%--------------------------------------------------------------------
% Version 2.319$\beta$, 2011/04/11:
%
% We fixed an obscure bug, in which if the user gives a \qformat
% command, in which case they shouldn't want to give a \droppoints
% command, but they *do* give a \droppoints command, there is an
% error (\padded@point@block undefined).
%
%--------------------------------------------------------------------
% Version 2.318$\beta$, 2011/04/05:
%
% \qformat and \bonusqformat are now totally independent.
% That is: \qformat doesn't affect bonus questions, and \noqformat
% no longer cancels \bonusqformat.
%
% New command: \nobonusqformat
% \nobonusqformat does for \bonusqformat what \noqformat does for
% \qformat.
%
%--------------------------------------------------------------------
% Version 2.317$\beta$, 2011/04/02:
%
% We changed the definition of \numcoverpages so that on the first run
% of latex (when \exam@lastcoverpage isn't yet defined), \numcoverpages
% will expand to
%     0\mbox{\normalfont\bf ??}
% instead of
%     \mbox{\normalfont\bf ??}
% so that the construction \romannumeral\numcoverpages will not generate
% an error on the first run of latex.
%
% We also made changes and corrections to comments.
%
%--------------------------------------------------------------------
% Version 2.316$\beta$, 2010/12/22:
%
%
% New commands:
%
%   \pointsinrange{rangename}
%   \bonuspointsinrange{rangename}
%
% If `rangename' is the name of a grading range defined using
% \begingradingrange{rangename} and \endgradingrange{rangename}, then
% \pointsinrange{rangename} expands to the number of points in that
% grading range and \bonuspointsinrange{rangename} expands to the number
% of bonus points in that grading range.

% We also changed the checkboxes and oneparcheckboxes environments so
% that, when solutions are being printed, a \CorrectChoice will be
% printed with \CorrectChoiceEmphasis (along with the \checkedchar
% that marks the \CorrectChoice).  This brings the behavior in line
% with that of the choices and oneparchoices environments.
%
%--------------------------------------------------------------------
% Version 2.315$\beta$, 2010/12/21:
%
% New commands:
%
%  \settabletotalpoints
%  \settabletotalbonuspoints
%
% Each of those takes one argument.  After giving the command
% \settabletotalpoints{numpoints}, any grade or point table (partial
% or full) will list the total points as numpoints instead of the
% actual total number of points in the table.
%
% After giving the command \settabletotalbonuspoints{numbonuspoints},
% any grade or point table will list the total bonus points as
% numbonuspoints instead of the actual total number of bonus points in
% the table.
%
% These commands are intended for exams in which students are asked to
% do some subset of the problems, but not all of them, and so the
% total number of points possible is less than the sum of the points
% for all of the questions.
%
%
% To have one of these commands affect only a single table, confine the
% command and the \gradetable command inside of a group, as in
%
%   \begingroup
%     \settabletotalpoints{100}
%     \gradetable[v][questions]
%   \endgroup
%
% or even just
%
%   \begin{center}
%     \settabletotalpoints{100}
%     \gradetable[v][questions]
%   \end{center}
%
%--------------------------------------------------------------------
% Version 2.314$\beta$, 2010/12/01:
%
% New user command:
%
%   \addquestionobject
%
% This is for when some of a question spills onto the next page, but
% that page doesn't have any parts, subparts, subsubparts, or choices
% beginning on theat page (which means that the \ifincomplete command
% won't know that any of that question is on that page).  If you say
% \addquestionobject at the very end of the question, it will write a
% questionobject to the .aux file so that \ifincomplete will work
% correctly.
%
% New commands used only internally:
%
%   \first@questionobject
%   \questionobject@pluspagecheck
%
% These were just to clean up some of the internal code.
%
%--------------------------------------------------------------------
% Version 2.313$\beta$, 2010/02/18:
%
% Bug fix: When solutions are not being printed, the solution,
% solutionorlines, and solutionordottedlines environments disallow
% pagebreaks before the environment, which can pull the last line of
% the question (or part, or etc.) preceding the environment onto the
% next page, even when leaving a rather large space before the
% pagebreak.  We insert
%
% \penalty 0
%
% to allow a pagebreak before the environment.  We make no change to
% the solutionorbox environment, since it didn't have this problem.
%
%--------------------------------------------------------------------
% Version 2.312$\beta$, 2010/01/17:
%
% New commands:
% 
%   \combinedgradetable
%   \combinedpointtable
%   \partialcombinedgradetable
%   \partialcombinedpointtable
%
% These are similar to \gradetable, \pointable, \bonusgradetable,
% \bonuspointtable, \partialgradetable, \partialpointtable,
% \partialbonusgradetable, and \partialbonuspointtable except that
% these new commands list both the points and the bonus points.
%
% \partialcombinedgradetable and \partialcombinedpointtable take one
% required argument, which is the name of the grading range.  All four
% of these commands take two optional arguments, the first being either
% ``v'' or ``h'' and the second being either ``questions'' or
% ``pages''.  The possibilities are thus
%
%   \combinedgradetable[v][questions]
%   \combinedgradetable[v][pages]
%   \combinedgradetable[h][questions]
%   \combinedgradetable[h][pages]
%   \partialcombinedgradetable{rangename}[v][questions]
%   \partialcombinedgradetable{rangename}[v][pages]
%   \partialcombinedgradetable{rangename}[h][questions]
%   \partialcombinedgradetable{rangename}[h][pages]
%
% The defaults are ``v'' and ``questions''.
%
% The horizontal tables have separate rows for the points and bonus
% points.  The vertical tables have separate columns for the points and
% bonus points.
%
% The default values for the words that appear in the tables are set by
% the commands
%
% \chqword{Question:}
% \chpgword{Page:}
% \chpword{Points:}
% \chbpword{Bonus Points:}
% \chsword{Score:}
% \chtword{Total}
% \cvqword{Question}
% \cvpgword{Page}
% \cvpword{Points}
% \cvbpword{Bonus Points}
% \cvsword{Score}
% \cvtword{Total:}
%
% The words in the table can be changed by giving any of these
% commands with the desired word as argument.
%
%--------------------------------------------------------------------
% Version 2.311$\beta$, 2010/01/10:
%
% New environment: oneparcheckboxes
%
% The oneparcheckboxes environment is to the checkboxes environment as
% the oneparchoices environment is to the choices environment.  That is,
% each choice is begun with either a \choice or a \correctchoice
% command, and these will all be printed as a single paragraph.  When
% answers are not being printed, each choice will have a label
% consisting of a box that the student can check, created by the
% argument to the last \checkboxchar command.  The default value is
% created by the command
%
% \checkboxchar{$\bigcirc$}
%
% (Note the dollar signs, since \bigcirc can appear only in math
% mode.)  When answers are being printed, then any choice created
% using the \correctchoice command will be labelled by the argument to
% the last \checkedchar command, the default value of which is created
% by the command
%
% \checkedchar{$\surd$}
%
%--------------------------------------------------------------------
% Version 2.310$\beta$, 2010/01/09:
%
% New command: \bonusqformat
%
% The \bonusqformat command takes one argument, with the same
% description as for the argument of the \qformat command.
%
% Note added 2011/04/05: Version 2.318$\beta$ changes the behavior so
% that \qformat and \bonusqformat are now completely independent!
%
% If the user gives a \qformat command, then the argument of that
% command is used to format both questions and bonusquestions.  If,
% after giving the \qformat command, the user gives a \bonusqformat
% command, then the argument of the \bonusqformat command will be used
% to format bonus questions.
%
% Note: The \bonusqformat command must be given *after* the \qformat
% command, or else the \bonusqformat command will have no effect.
%
% Note: If the user hasn't given a \qformat command, then a
% \bonusqformat command will have no effect.
%
% Note: If the user gives a \qformat command and a \bonusqformat
% command, and then later says \noqformat, then the arguments of both
% the \qformat and \bonusqformat commands are no longer usable.  That
% is, if the user later on once again says \qformat, and wants the bonus
% questions to have a different format from the questions, then another
% \bonusqformat command must be given.
%
% Note added 2011/04/05:: The above is changed in version 2.318$\beta$.
% \qformat and \bonusqformat are now completely independent.
% \noqformat cancels only \qformat, and the new command 
% \nobonusqformat cancels \bonusqformat.
% 
%--------------------------------------------------------------------
% Version 2.309$\beta$, 2009/11/30:
%
% New environment: checkboxes
% New commands: \checkboxeshook
%               \checkboxchar
%               \checkedchar
%
% The checkboxes environment is similar to the choices environment,
% except that choices are not numbered.  Instead of numbers, each
% choice has a label consisting of a box that the student can check,
% created by the argument to the last \checkboxchar command.  The
% default value is created by the command
%
% \checkboxchar{$\bigcirc$}
%
% (Note the dollar signs, since \bigcirc can appear only in math
% mode.)  When answers are being printed, then any choice created
% using the \correctchoice command will be labelled by the argument to
% the last \checkedchar command, the default value of which is created
% by the command
%
% \checkedchar{$\surd$}
%
% The list parameters used in the checkboxes environment can be
% customized by redefining \checkboxeshook, the default value of which
% is empty.  (This is similar to using \choiceshook to alter the
% choices environment.)
%
%--------------------------------------------------------------------
% Version 2.308$\beta$, 2009/11/26:
%
% We fixed a bug that caused \bonussubpart to act like \subpart and
% \bonussubsubpart to act like \subsubpart.
%
%--------------------------------------------------------------------
% Version 2.307$\beta$, 2009/06/11:
%
% We fixed a bug that arose only when there were cover pages and the
% first page of the cover pages used a different extraheadheight or
% extrafootheight from that used on the first page of the regular pages.
% The bug caused the first page of the regular pages to use the
% extraheadheight and extrafootheight intended only for the first cover
% page.
%
%--------------------------------------------------------------------
% Version 2.306$\beta$, 2009/03/28:
%
% We fixed a bug that arose only when the user used a figure or
% table environment that floated to the top of a page.  If that
% happened, then a full page's worth of text was placed below
% the figure or table, makeing the text run over the footline and off
% the bottom of the page.
%
% We fixed this by commenting out several lines at the end of
% \@setheadheight and @setfootheight.
%
%--------------------------------------------------------------------
% Version 2.305$\beta$, 2009/01/30:
%
% We fixed a bug to keep page breaks from occurring inside of
% \makeemptybox.  We also added \begingroup \endgroup for the off
% chance that someone was using box0 and didn't want us to change it.
%
% We also fixed a bug in the solutionorbox environment that showed
% itself when the user used \stretch in the optional argument.
%
%--------------------------------------------------------------------
% Version 2.304$\beta$, 2009/01/22:
%
% We rewrote the definition of \makeemptybox and the solutionorbox
% environment (created in version 2.303).
%
% The argument to \makeemptybox can now be either a length, or \fill, or
% \stretch{number}.
%
% The optional argument to the solutionorbox environment can also be
% either a length, or \fill, or \stretch{number}.  If the optional
% argument is omitted, then no box is printed when printanswers is
% false.
%
% The minimum box height is \minboxheight, whose value is set by the
% command
%
%   \setlength\minboxheight{.1in}
%
% This can be changed by giving a new setlength command, but it's not
% likely that anyone actually wants a box of height less than .1 inch.
%
%--------------------------------------------------------------------
% Version 2.303$\beta$, 2009/01/21:
%
% New command: \makeemptybox
% New environment: solutionorbox
%
% \makeemptybox takes one argument, which is a length, and it creates
% an empty box of width the length of the current line and of height
% equal to the argument. That is, the box extends from the current
% left margin (which depends on whether we're in a question, part,
% subpart, or subsubpart) to the right margin.
%
% The solutionorbox environment is similar to the solution
% environment, except that if printanswers is false and an optional
% argument is specified, then instead of leaving that much blank space
% we print an empty box of that height.  The optional argument must be
% a dimension; it can not be \fill.  If the optional argument is
% missing or equal to 0pt, then when printanswers is false we print
% nothing at all.
%
% Note: This is changed in version 2.304.  As of that version, the
% argument can be a length, or \fill, or \stretch{number}.
%
%--------------------------------------------------------------------
% Version 2.302$\beta$, 2008/10/18:
%
% New commands: \numcoverpages and \totalnumpages
%
% \numcoverpages inserts the number of pages occupied by the
% coverpages environment.  If there is no coverpages environment,
% it inserts 0.
%
% \totalnumpages inserts the sum of \numcoverpages and \numpages.
% Note that if there are pages preceding a coverpages environment, then
% those pages will not be counted by \totalnumpages.
%
% We also added \relax after some \ifnum comparisons and commented
% out some line endings to remove, e.g., an unwanted space inserted
% by \ifcontinuation when the page is a continuation.
%
%--------------------------------------------------------------------
% Version 2.301$\beta$, 2008/09/22:
%
% All solution, solutionorlines, and solutionordotteslines
% environments are now enclosed in a group which is begun
% with the argument of the command
%
%   \SolutionEmphasis
%
% the default value of which is determined by the command
%
%   \SolutionEmphasis{}
%
% That is, the default is that nothing is inserted.
% For example, if the command
%
%   \SolutionEmphasis{\itshape\small}
%
% is used, the solutions will be set in italics, in small type.
%
%
% New command: \unframedsolutions
%
% This causes solutions to be printed as normal text, without any
% framing or shading.  Anyone using this command should use the
% \SolutionEmphasis command so that the solutions will be
% distinguishable from the rest of the exam.
%
%--------------------------------------------------------------------
% Version 2.3, 2008/07/16:
%
% Minor typographic corrections to comments.
%
%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{exam}[\filedate\space Version \fileversion\space by
  Philip Hirschhorn]

\RequirePackage{ifthen}

\newif\ifprintanswers
\printanswersfalse
\DeclareOption{answers}{\printanswerstrue}
\DeclareOption{noanswers}{\printanswersfalse}

\newif\ifcancelspace
\cancelspacefalse
\DeclareOption{cancelspace}{\cancelspacetrue}
\DeclareOption{nocancelspace}{\cancelspacefalse}

% The following keeps track of whether the user has requested that we
% add up the points on the exam.  We make the default false so that
% users who put other than numbers into the points argument of a
% question (or part, or subpart) won't get error messages.
% We use \if@printtotalpoints as a flag to signal that we are counting
% points, so that we will know to print the total on the screen (and
% in the log file).  We use this separate flag so that the user can
% use both \addpoints and \noaddpoints to count some points and not
% others, but still have the total printed when we finish the file no
% matter what the state of \if@addpoints.
\newif\if@addpoints
\newif\if@printtotalpoints
\def\addpoints{\global\@addpointstrue\global\@printtotalpointstrue}
\def\noaddpoints{\global\@addpointsfalse}
\@addpointsfalse
\@printtotalpointsfalse
\DeclareOption{addpoints}{\addpoints}


\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}




%                         *****************
%                         ** PAGE LAYOUT **
%                         *****************


% We set the parameters in terms of \paperwidth and \paperheight
% so that the options

% a4paper
% a5paper
% b5paper
% letterpaper
% legalpaper
% executivepaper
% landscape

% will all work:

\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-2in}
\setlength{\oddsidemargin}{0pt}
\setlength{\evensidemargin}{0pt}

\setlength{\headheight}{15pt}
\setlength{\headsep}{15pt}
\setlength{\topmargin}{0in}
\addtolength{\topmargin}{-\headheight}
\addtolength{\topmargin}{-\headsep}
\setlength{\footskip}{29pt}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-2.2in}

\setlength{\marginparwidth}{.5in}
\setlength{\marginparsep}{5pt}

%--------------------------------------------------------------------

%                          ****************
%                          ** EXTRAWIDTH **
%                          ****************

\newlength\@extrawidth

% \@rightmargin is needed for \pointsinrightmargin and
% \pointsdroppedatright, so that we can right justify the points:
\newlength\@rightmargin
\setlength{\@rightmargin}{1in}

% We put the argument of \extrawidth into a length so that it will
% work correctly even if it's negative:

\def\extrawidth#1{%
  \@extrawidth=#1
  \advance \textwidth by \@extrawidth
  \divide\@extrawidth by 2
  \advance\oddsidemargin by -\@extrawidth
  \advance\evensidemargin by -\@extrawidth
  % Bug fix, 13 April 2004: 
  %\advance\@rightmargin by \@extrawidth
  \advance\@rightmargin by -\@extrawidth
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%             Making room for large headers and footers

% The following are used to save the effect of any changes to 
% \topmargin and \textheight caused by \extraheadheight or
% \extrafootheight commands.  They hold the values currently in effect.
% We put them into lengths so that it will work correctly even if the
% argument is negative:

\newlength\@extrahead
\newlength\@extrafoot
\setlength{\@extrahead}{0in}
\setlength{\@extrafoot}{0in}

% The following are used to hold the requested values for extrahead and
% extrafoot, first page and all pages after the first, and then the
% similar things requested for the cover pages:
\newlength\run@exhd
\newlength\fp@exhd
\newlength\run@exft
\newlength\fp@exft
\newlength\covrun@exhd
\newlength\covfp@exhd
\newlength\covrun@exft
\newlength\covfp@exft

\setlength{\run@exhd}{0in}
\setlength{\fp@exhd}{0in}
\setlength{\run@exft}{0in}
\setlength{\fp@exft}{0in}
\setlength{\covrun@exhd}{0in}
\setlength{\covfp@exhd}{0in}
\setlength{\covrun@exft}{0in}
\setlength{\covfp@exft}{0in}

\newcommand*\adj@hdht@ftht{%
  \if@coverpages
    \ifnum\value{page}=1\relax
      \@setheadheight{\covfp@exhd}%
      \@setfootheight{\covfp@exft}%
    \else
      \@setheadheight{\covrun@exhd}%
      \@setfootheight{\covrun@exft}%
    \fi
  \else
    \ifnum\value{page}=1\relax
      \@setheadheight{\fp@exhd}%
      \@setfootheight{\fp@exft}%
    \else
      \@setheadheight{\run@exhd}%
      \@setfootheight{\run@exft}%
    \fi
  \fi
}

\newcommand*\extraheadheight{%
  \@ifnextchar[{\@xtrahd}{\@ytrahd}%
}

\def\@xtrahd[#1]#2{%
  \setlength{\fp@exhd}{#1}%
  \setlength{\run@exhd}{#2}%
  \adj@hdht@ftht
}

\def\@ytrahd#1{%
  \setlength{\fp@exhd}{#1}%
  \setlength{\run@exhd}{#1}%
  \adj@hdht@ftht
}

\newcommand*\extrafootheight{%
  \@ifnextchar[{\@xtraft}{\@ytraft}%
}

\def\@xtraft[#1]#2{%
  \setlength{\fp@exft}{#1}%
  \setlength{\run@exft}{#2}%
  \adj@hdht@ftht
}

\def\@ytraft#1{%
  \setlength{\fp@exft}{#1}%
  \setlength{\run@exft}{#1}%
  \adj@hdht@ftht
}

\newcommand*\coverextraheadheight{%
  \@ifnextchar[{\cov@xtrahd}{\cov@ytrahd}%
}

\def\cov@xtrahd[#1]#2{%
  \setlength{\covfp@exhd}{#1}%
  \setlength{\covrun@exhd}{#2}%
  \adj@hdht@ftht
}

\def\cov@ytrahd#1{%
  \setlength{\covfp@exhd}{#1}%
  \setlength{\covrun@exhd}{#1}%
  \adj@hdht@ftht
}

\newcommand*\coverextrafootheight{%
  \@ifnextchar[{\cov@xtraft}{\cov@ytraft}%
}

\def\cov@xtraft[#1]#2{%
  \setlength{\covfp@exft}{#1}%
  \setlength{\covrun@exft}{#2}%
  \adj@hdht@ftht
}

\def\cov@ytraft#1{%
  \setlength{\covfp@exft}{#1}%
  \setlength{\covrun@exft}{#1}%
  \adj@hdht@ftht
}

\def\@appendoutput#1{%
  \output=\expandafter{\the\output #1}%
}

\@appendoutput{\adj@hdht@ftht}

%--------------------------------------------------------------------
%                 \@setheadheight and \@setfootheight:

\def\@setheadheight#1{%
  \begingroup % Avoid trouble from using \@temp and \@spaces
    % Reset the effect of the most recent change:
    \global\advance\topmargin by -\@extrahead
    \global\advance\textheight by \@extrahead
    % Save the newly set value:
    \def\@temp{#1}
    \def\@spaces{ }
    \ifx\@temp\@empty
      \global\@extrahead=0in
    \else
      \ifx\@temp\@spaces
        \global\@extrahead=0in
      \else
        \global\@extrahead=#1
      \fi
    \fi
    % Set the new values:
    \global\advance\topmargin by \@extrahead
    \global\advance\textheight by -\@extrahead
    % Make it take effect RIGHT NOW!:
    % (The following stuff isn't necessary if \@setheadheight is
    % executed only in the preamble or as we return from the output
    % routine, but we're leaving it in so that this will still work if
    % we use this at some random point in the middle of composing a
    % page).
    % Bugfix, Version 2.306beta, 2009/03/28:
    % We don't do this!!
    % If the user had a figure environment that floated to the
    % top of a page, then this would cause that page to run
    % over the footer and off the bottom of the page, because
    % this somehow caused a full page's worth of stuff to be
    % placed after the figure, as if the figure wasn't taking
    % up space on the page.
    % We *do* need to put \@colht at the correct new value, though,
    % apparently because \@colht is set near the end of the
    % output routine.
    \global\@colht=\textheight
%     \global\@colroom=\textheight
%     \global\vsize=\textheight
%     \global\pagegoal=\textheight
  \endgroup
}

\def\@setfootheight#1{%
  \begingroup % Avoid trouble from using \@temp and \@spaces
    % Reset the effect of the most recent change:
    \global\advance\textheight by \@extrafoot
    % Save the newly set value:
    \def\@temp{#1}
    \def\@spaces{ }
    \ifx\@temp\@empty
      \global\@extrafoot=0in
    \else
      \ifx\@temp\@spaces
        \global\@extrafoot=0in
      \else
        \global\@extrafoot=#1
      \fi
    \fi
    % Set the new values:
    \global\advance\textheight by -\@extrafoot
    % Make it take effect RIGHT NOW!:
    % (The following stuff isn't necessary if \@setfootheight is
    % executed only in the preamble or as we return from the output
    % routine, but we're leaving it in so that this will still work if
    % we use this at some random point in the middle of composing a
    % page). 
    % Bugfix, Version 2.306beta, 2009/03/28:
    % We don't do this!!
    % If the user had a figure environment that floated to the
    % top of a page, then this would cause that page to run
    % over the footer and off the bottom of the page, because
    % this somehow caused a full page's worth of stuff to be
    % placed after the figure, as if the figure wasn't taking
    % up space on the page.
    % We *do* need to put \@colht at the correct new value, though,
    % apparently because \@colht is set near the end of the
    % output routine.
    \global\@colht=\textheight
%     \global\@colroom=\textheight
%     \global\vsize=\textheight
%     \global\pagegoal=\textheight
  \endgroup
}




%---------------------------------------------------------------------
%
%                      *************************
%                      ** HEADERS AND FOOTERS **
%                      *************************
% 
% The pagestyles available are head, foot, headandfoot, and empty.
% \pagestyle{head} prints the head, and gives an empty foot.
% \pagestyle{foot} prints the foot, and gives an empty head.
% \pagestyle{headandfoot} prints both the head and the foot.
% \pagestyle{empty} gives an empty head and an empty foot.
% 

%                            Pagestyles:

\newcommand*\ps@head{%
  \@dohead
  \@nofoot
}

\newcommand*\ps@headandfoot{%
  \@dohead
  \@dofoot
}

\newcommand*\ps@foot{%
  \@nohead
  \@dofoot
}

% \ps@empty is already defined by article.cls, so we'll
% say \def instead of \newcommand*:
\def\ps@empty{%
  \@nohead
  \@nofoot
}

\newif\if@coverpages
\@coverpagesfalse

\newcounter{num@coverpages}
% We'll set this to zero in case there is no coverpages environment:
\setcounter{num@coverpages}{0}

\newenvironment{coverpages}{%
    \ifnum \value{numquestions}>0\relax
      \ClassError{exam}{%
        Coverpages cannot be used after questions have begun.\MessageBreak
      }{%
        All question, part, subpart, and subsubpart environments
        \MessageBreak
        must begin after the cover pages are complete.\MessageBreak
      }%
    \fi
    \@coverpagestrue
    \pagenumbering{roman}%
    \adj@hdht@ftht
  }{%
    \clearpage
    \setcounter{num@coverpages}{\value{page}}%
    \addtocounter{num@coverpages}{-1}%
    \pagenumbering{arabic}%
    % Bugfix, Version 2.307\beta, 2009/06/11:
    % We have to say \@coverpagesfalse before \adj@hdht@ftht
    % because we're still inside the group created by the
    % coverpages environment and we want to set the 
    % extraheadheight and extrafootheight to the values correct
    % for the first non-cover page:
    \@coverpagesfalse
    \adj@hdht@ftht
}

\newcommand*\cover@question@error{%
  \ClassError{exam}{%
    No questions are allowed in the cover pages.\MessageBreak
  }{%
    All question, part, subpart, and subsubpart environments
    \MessageBreak
    must begin after the cover pages are complete.\MessageBreak
  }%
}

\newcommand*\@dohead{%
  \def\@oddhead{%
    \if@coverpages
      \ifnum\value{page}=1\relax
        \cov@fullhead
      \else
        \covrun@fullhead
      \fi
    \else
      \ifnum\value{page}=1\relax
        \@fullhead
      \else
        \run@fullhead
      \fi
    \fi
  }% @oddhead
  \let\@evenhead=\@oddhead
}

\newcommand*\@dofoot{%
  \def\@oddfoot{%
    \if@coverpages
      \ifnum\value{page}=1\relax
        \cov@fullfoot
      \else
        \covrun@fullfoot
      \fi
    \else
      \ifnum\value{page}=1\relax
        \@fullfoot
      \else
        \run@fullfoot
      \fi
    \fi
  }% @oddfoot
  \let\@evenfoot=\@oddfoot
}

\newcommand*\@nohead{%
  \def\@oddhead{}%
  \let\@evenhead=\@oddhead
}

\newcommand*\@nofoot{%
  \def\@oddfoot{}%
  \let\@evenfoot=\@oddfoot
}

%--------------------------------------------------------------------
%       \@fullhead, \run@fullhead, \@fullfoot, and \run@fullfoot:

\newcommand*\@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\@rhead\strut}}%
    }% hbox
    \if@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}

\newcommand*\run@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\run@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\run@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\run@rhead\strut}}%
    }% hbox
    \ifrun@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}

% We arrange it so that the very top of first line of text in the
% foot is at a fixed position on the page, whether or not there's
% a footrule:

\newcommand*\@fullfoot{%
  \vbox to 0pt{%
    \if@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

\newcommand*\run@fullfoot{%
  \vbox to 0pt{%
    \ifrun@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\run@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\run@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\run@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

%--------------------------------------------------------------------
%       \cov@fullhead, \covrun@fullhead, \cov@fullfoot, and
%       \covrun@fullfoot: 

\newcommand*\cov@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\cov@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\cov@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\cov@rhead\strut}}%
    }% hbox
    \ifcov@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}

\newcommand*\covrun@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\covrun@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\covrun@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\covrun@rhead\strut}}%
    }% hbox
    \ifcovrun@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}

% We arrange it so that the very top of first line of text in the
% foot is at a fixed position on the page, whether or not there's
% a footrule:

\newcommand*\cov@fullfoot{%
  \vbox to 0pt{%
    \ifcov@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\cov@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\cov@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\cov@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

\newcommand*\covrun@fullfoot{%
  \vbox to 0pt{%
    \ifcovrun@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\covrun@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\covrun@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\covrun@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%            ********************************************
%            ** COMMANDS TO DEFINE HEADERS AND FOOTERS **
%            ********************************************
%
% \lhead[#1]{#2} sets the first page left head to #1, and the
%   running left head to #2
% 
% \lhead{#1} sets both the first page left head and the running
%   left head to #1
% 
% \chead, \rhead, \lfoot, \cfoot, and \rfoot work similarly.
% 
% 
% \@lhead is the left head for Page 1
% \run@lhead is the running left head
% (i.e., for all pages other than the first)
% 
% \@chead is the center head for Page 1
% \run@chead is the running center head
% (i.e., for all pages other than the first)
% 
% etc.
% 
% Alternative commands are:
% \firstpageheader{LEFT}{CENTER}{RIGHT}
% \runningheader{LEFT}{CENTER}{RIGHT}
% or
% \header{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \firstpageheader{LEFT}{CENTER}{RIGHT}
%          \runningheader{LEFT}{CENTER}{RIGHT}
% 
% Alternative commands are:
% \firstpagefooter{LEFT}{CENTER}{RIGHT}
% \runningfoother{LEFT}{CENTER}{RIGHT}
% or
% \footer{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \firstpagefooter{LEFT}{CENTER}{RIGHT}
%          \runningfoother{LEFT}{CENTER}{RIGHT}

\def\firstpageheader#1#2#3{%
  \def\@lhead{#1}%
  \def\@chead{#2}%
  \def\@rhead{#3}%
}

\def\runningheader#1#2#3{%
  \def\run@lhead{#1}%
  \def\run@chead{#2}%
  \def\run@rhead{#3}%
}

\def\header#1#2#3{%
  \firstpageheader{#1}{#2}{#3}%
  \runningheader{#1}{#2}{#3}%
}

\def\firstpagefooter#1#2#3{%
  \def\@lfoot{#1}%
  \def\@cfoot{#2}%
  \def\@rfoot{#3}%
}

\def\runningfooter#1#2#3{%
  \def\run@lfoot{#1}%
  \def\run@cfoot{#2}%
  \def\run@rfoot{#3}%
}

\def\footer#1#2#3{%
  \firstpagefooter{#1}{#2}{#3}%
  \runningfooter{#1}{#2}{#3}%
}

\def\lhead{\@ifnextchar[{\@xlhead}{\@ylhead}}
\def\@xlhead[#1]#2{\def\@lhead{#1}\def\run@lhead{#2}}
\def\@ylhead#1{\def\run@lhead{#1}\def\@lhead{#1}}

\def\chead{\@ifnextchar[{\@xchead}{\@ychead}}
\def\@xchead[#1]#2{\def\@chead{#1}\def\run@chead{#2}}
\def\@ychead#1{\def\run@chead{#1}\def\@chead{#1}}

\def\rhead{\@ifnextchar[{\@xrhead}{\@yrhead}}
\def\@xrhead[#1]#2{\def\@rhead{#1}\def\run@rhead{#2}}
\def\@yrhead#1{\def\run@rhead{#1}\def\@rhead{#1}}

\def\lfoot{\@ifnextchar[{\@xlfoot}{\@ylfoot}}
\def\@xlfoot[#1]#2{\def\@lfoot{#1}\def\run@lfoot{#2}}
\def\@ylfoot#1{\def\run@lfoot{#1}\def\@lfoot{#1}}

\def\cfoot{\@ifnextchar[{\@xcfoot}{\@ycfoot}}
\def\@xcfoot[#1]#2{\def\@cfoot{#1}\def\run@cfoot{#2}}
\def\@ycfoot#1{\def\run@cfoot{#1}\def\@cfoot{#1}}

\def\rfoot{\@ifnextchar[{\@xrfoot}{\@yrfoot}}
\def\@xrfoot[#1]#2{\def\@rfoot{#1}\def\run@rfoot{#2}}
\def\@yrfoot#1{\def\run@rfoot{#1}\def\@rfoot{#1}}


%                    Initialize head and foot:

\pagestyle{headandfoot}

\lhead{}
\chead{}
\rhead{}
\lfoot{}
\cfoot[]{Page \thepage}
\rfoot{}

%--------------------------------------------------------------------
%                    Coverpage headers and footers
%
% \coverlhead[#1]{#2} sets the first cover page left head to #1, and the
%   running cover left head to #2
% 
% \coverlhead{#1} sets both the first cover page left head and the running
%   cover left head to #1
% 
% \coverchead, \coverrhead, \coverlfoot, \covercfoot, and \coverrfoot
% work similarly.
% 
% 
% \cov@lhead is the left head for Page 1
% \covrun@lhead is the running left head
% (i.e., for all pages other than the first)
% 
% \cov@chead is the center head for Page 1
% \covrun@chead is the running center head
% (i.e., for all pages other than the first)
% 
% etc.
% 
% Alternative commands are:
% \coverfirstpageheader{LEFT}{CENTER}{RIGHT}
% \coverrunningheader{LEFT}{CENTER}{RIGHT}
% or
% \coverheader{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \coverfirstpageheader{LEFT}{CENTER}{RIGHT}
%          \coverrunningheader{LEFT}{CENTER}{RIGHT}
% 
% Alternative commands are:
% \coverfirstpagefooter{LEFT}{CENTER}{RIGHT}
% \coverrunningfoother{LEFT}{CENTER}{RIGHT}
% or
% \coverfooter{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \coverfirstpagefooter{LEFT}{CENTER}{RIGHT}
%          \coverrunningfoother{LEFT}{CENTER}{RIGHT}

\def\coverfirstpageheader#1#2#3{%
  \def\cov@lhead{#1}%
  \def\cov@chead{#2}%
  \def\cov@rhead{#3}%
}

\def\coverrunningheader#1#2#3{%
  \def\covrun@lhead{#1}%
  \def\covrun@chead{#2}%
  \def\covrun@rhead{#3}%
}

\def\coverheader#1#2#3{%
  \coverfirstpageheader{#1}{#2}{#3}%
  \coverrunningheader{#1}{#2}{#3}%
}

\def\coverfirstpagefooter#1#2#3{%
  \def\cov@lfoot{#1}%
  \def\cov@cfoot{#2}%
  \def\cov@rfoot{#3}%
}

\def\coverrunningfooter#1#2#3{%
  \def\covrun@lfoot{#1}%
  \def\covrun@cfoot{#2}%
  \def\covrun@rfoot{#3}%
}

\def\coverfooter#1#2#3{%
  \coverfirstpagefooter{#1}{#2}{#3}%
  \coverrunningfooter{#1}{#2}{#3}%
}

\def\coverlhead{\@ifnextchar[{\cov@xlhead}{\cov@ylhead}}
\def\cov@xlhead[#1]#2{\def\cov@lhead{#1}\def\covrun@lhead{#2}}
\def\cov@ylhead#1{\def\covrun@lhead{#1}\def\cov@lhead{#1}}

\def\coverchead{\@ifnextchar[{\cov@xchead}{\cov@ychead}}
\def\cov@xchead[#1]#2{\def\cov@chead{#1}\def\covrun@chead{#2}}
\def\cov@ychead#1{\def\covrun@chead{#1}\def\cov@chead{#1}}

\def\coverrhead{\@ifnextchar[{\cov@xrhead}{\cov@yrhead}}
\def\cov@xrhead[#1]#2{\def\cov@rhead{#1}\def\covrun@rhead{#2}}
\def\cov@yrhead#1{\def\covrun@rhead{#1}\def\cov@rhead{#1}}

\def\coverlfoot{\@ifnextchar[{\cov@xlfoot}{\cov@ylfoot}}
\def\cov@xlfoot[#1]#2{\def\cov@lfoot{#1}\def\covrun@lfoot{#2}}
\def\cov@ylfoot#1{\def\covrun@lfoot{#1}\def\cov@lfoot{#1}}

\def\covercfoot{\@ifnextchar[{\cov@xcfoot}{\cov@ycfoot}}
\def\cov@xcfoot[#1]#2{\def\cov@cfoot{#1}\def\covrun@cfoot{#2}}
\def\cov@ycfoot#1{\def\covrun@cfoot{#1}\def\cov@cfoot{#1}}

\def\coverrfoot{\@ifnextchar[{\cov@xrfoot}{\cov@yrfoot}}
\def\cov@xrfoot[#1]#2{\def\cov@rfoot{#1}\def\covrun@rfoot{#2}}
\def\cov@yrfoot#1{\def\covrun@rfoot{#1}\def\cov@rfoot{#1}}


%                 Initialize coverpage head and foot:

\coverlhead{}
\coverchead{}
\coverrhead{}
\coverlfoot{}
\covercfoot{}
\coverrfoot{}




%--------------------------------------------------------------------
%--------------------------------------------------------------------

%                      Headrules and footrules:

\newif\if@headrule
\newif\ifrun@headrule

\def\firstpageheadrule{\@headruletrue}
\def\nofirstpageheadrule{\@headrulefalse}

\def\runningheadrule{\run@headruletrue}
\def\norunningheadrule{\run@headrulefalse}

\def\headrule{\@headruletrue\run@headruletrue}
\def\noheadrule{\@headrulefalse\run@headrulefalse}

\newif\if@footrule
\newif\ifrun@footrule

\def\firstpagefootrule{\@footruletrue}
\def\nofirstpagefootrule{\@footrulefalse}

\def\runningfootrule{\run@footruletrue}
\def\norunningfootrule{\run@footrulefalse}

\def\footrule{\@footruletrue\run@footruletrue}
\def\nofootrule{\@footrulefalse\run@footrulefalse}

%                             Initialize:

\noheadrule
\nofootrule

%                 Cover page headrules and footrules:

\newif\ifcov@headrule
\newif\ifcovrun@headrule

\def\coverfirstpageheadrule{\cov@headruletrue}
\def\nocoverfirstpageheadrule{\cov@headrulefalse}

\def\coverrunningheadrule{\covrun@headruletrue}
\def\nocoverrunningheadrule{\covrun@headrulefalse}

\def\coverheadrule{\cov@headruletrue\covrun@headruletrue}
\def\nocoverheadrule{\cov@headrulefalse\covrun@headrulefalse}

\newif\ifcov@footrule
\newif\ifcovrun@footrule

\def\coverfirstpagefootrule{\cov@footruletrue}
\def\nocoverfirstpagefootrule{\cov@footrulefalse}

\def\coverrunningfootrule{\covrun@footruletrue}
\def\nocoverrunningfootrule{\covrun@footrulefalse}

\def\coverfootrule{\cov@footruletrue\covrun@footruletrue}
\def\nocoverfootrule{\cov@footrulefalse\covrun@footrulefalse}

%                             Initialize:

\nocoverheadrule
\nocoverfootrule

%--------------------------------------------------------------------
%--------------------------------------------------------------------

%                \numpages, \iflastpage, and \oddeven
%     Also: \numpoints, \numquestions, \numparts, and \numsubparts
%                    Also also: \pointsofquestion
%     Also: \numcoverpages and \totalnumpages

% Make the number of pages available as the macro \numpages,
% the number of points as \numpoints,
% the number of questions as \numquestions,
% the number of parts as \numparts, and
% the number of subparts as \numsubparts

% This was previously done with \pageref commands.  When I stopped
% using \pageref for this (in order to make this compatible with
% hyperref.sty), this stuff was created:

% \gdef commands for exam@lastpage, exam@numpoints,
% exam@numbonuspoints, exam@numquestions, exam@numparts,
% exam@numsubparts and exam@numsubsubparts are written to the .aux
% file via \AtEndDocument.

% \gdef commands for pointsofq@i, pointsofq@ii, etc. and
% bonuspointsofq@i, bonuspointsofq@ii, etc.  are written to the .aux
% file as each question is completed (see the definition of the
% questions environment).

% \gdef commands for pointsonpage@i, pointsonpage@ii, etc. and
% bonuspointsonpage@i, bonuspointsonpage@ii, etc. are written to the
% .aux file as we encounter points defined for a later page, and for
% the last such page with AtEndDocument.

\def\numpages{\@ifundefined{exam@lastpage}%
  {\mbox{\normalfont\bf ??}}%
  \exam@lastpage
}% numpages

% Change 2011/04/01: We added a ``0'' in front of the
% mbox when \exam@lastcoverpage isn't defined.  This is
% so that the construction \romannumeral\numcoverpages
% won't generate an error on the first run of latex.
\def\numcoverpages{\@ifundefined{exam@lastcoverpage}%
  {0\mbox{\normalfont\bf ??}}%
  \exam@lastcoverpage
}% numpages

\def\totalnumpages{\@ifundefined{exam@totalpages}%
  {\mbox{\normalfont\bf ??}}%
  \exam@totalpages
}% numpages

\def\numpoints{\@ifundefined{exam@numpoints}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numpoints
}% numpoints
\def\numbonuspoints{\@ifundefined{exam@numbonuspoints}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numbonuspoints
}% numbonuspoints

\def\numquestions{\@ifundefined{exam@numquestions}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numquestions
}% numquestions

\def\numparts{\@ifundefined{exam@numparts}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numparts
}% numparts

\def\numsubparts{\@ifundefined{exam@numsubparts}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numsubparts
}% numsubparts

\def\numsubsubparts{\@ifundefined{exam@numsubsubparts}%
  {\mbox{\normalfont\bf ??}}%
  \exam@numsubsubparts
}% numsubsubparts

\def\pointsofquestion#1{\@ifundefined{pointsofq@\romannumeral #1}%
  {\mbox{\normalfont\bf ??}}%
  {\csname pointsofq@\romannumeral #1\endcsname}%
}% pointsofquestion
\def\bonuspointsofquestion#1{\@ifundefined{bonuspointsofq@\romannumeral #1}%
  {\mbox{\normalfont\bf ??}}%
  {\csname bonuspointsofq@\romannumeral #1\endcsname}%
}% bonuspointsofquestion

% For use in \combinedgradetable and \combinedpointtable, we're
% changing the defintions of \pointsonpage and \bonuspointsonpage
% so that when, e.g.,  pointsonpage@ii is undefined, we just produce
% 0.  This comes up because the final page of the exam may have either
% points with no bonus point or bonus points with no points, in which
% case the combined table will try to list both points and bonus points
% for that last page, and one of those will be undefined.
%
% \def\pointsonpage#1{\@ifundefined{pointsonpage@\romannumeral #1}%
%   {\mbox{\normalfont\bf ??}}%
%   {\csname pointsonpage@\romannumeral #1\endcsname}%
% }% pointsonpage
% \def\bonuspointsonpage#1{\@ifundefined{bonuspointsonpage@\romannumeral #1}%
%   {\mbox{\normalfont\bf ??}}%
%   {\csname bonuspointsonpage@\romannumeral #1\endcsname}%
% }% bonuspointsonpage
%
% spanish.ldf redefines \@roman, so we'll avoid using \roman:
\def\pointsonpage#1{\@ifundefined{pointsonpage@\romannumeral #1}%
  {0}%
  {\csname pointsonpage@\romannumeral #1\endcsname}%
}% pointsonpage
\def\bonuspointsonpage#1{\@ifundefined{bonuspointsonpage@\romannumeral #1}%
  {0}%
  {\csname bonuspointsonpage@\romannumeral #1\endcsname}%
}% bonuspointsonpage


\newif\if@pointschanged
\@pointschangedfalse

\newcommand*{\CheckIfChanged@hlf}[2]{%
  % The first argument is the name of a half counter.
  % The second argument expands to the name (without the escape
  % character, and not assumed to be defined) of the control sequence
  % holding the previous value.
  \@ifundefined{#2}%
    {\global\@pointschangedtrue}%
    {%
    % OK; it's defined.  See if it's changed:
    \begingroup
      \set@hlfcntr{tmp@hlfcntr}{\csname #2\endcsname}%
      \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
      \edef\pt@check{\prtaux@hlfcntr{#1}}%
      \ifx \pt@check \othpt@check
        % Do nothing
      \else
        \global\@pointschangedtrue
      \fi
    \endgroup
    }%
}% CheckIfChanged@hlf


%%%\let\@realenddocument=\enddocument
%%%\def\enddocument{\clearpage
%%%   \if@filesw 
%%%     {\advance\c@page-1 \immediate\write\@mainaux
%%%       {\string\newlabel{@lastpage}{{}{\arabic{page}}}}%
%%%     }
%%%   \fi
%%%   \@realenddocument
%%%}

\AtEndDocument{%
  \clearpage
  \if@filesw
    \advance\c@page-1
    \immediate\write\@mainaux
      {\string\gdef\string\exam@lastpage{\arabic{page}}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@lastcoverpage{\arabic{num@coverpages}}}%
    % We can now trash the value of num@coverpages:
    \addtocounter{num@coverpages}{\value{page}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@totalpages{\arabic{num@coverpages}}}%
    \advance\c@page+1 % In case some other package looks at \c@page
    %
    \immediate\write\@mainaux
        {\string\gdef\string\exam@numpoints{%
                            \prtaux@hlfcntr{numpoints}}}%
    % See if this has changed from the last run of LaTeX:
    \CheckIfChanged@hlf{numpoints}{exam@numpoints}%
    \immediate\write\@mainaux
        {\string\gdef\string\exam@numbonuspoints{%
                            \prtaux@hlfcntr{numbonuspoints}}}%
    % See if this has changed from the last run of LaTeX:
    \CheckIfChanged@hlf{numbonuspoints}{exam@numbonuspoints}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numquestions{\thenumquestions}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numparts{\thenumparts}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numsubparts{\thenumsubparts}}%
    \immediate\write\@mainaux
      {\string\gdef\string\exam@numsubsubparts{\thenumsubsubparts}}%
    \ifnum \thepageof@pagepoints > 0\relax
      \immediate\write\@mainaux
          {\string\gdef\string\pointsonpage@\romannumeral
                          \csname c@pageof@pagepoints\endcsname
             {\prtaux@hlfcntr{@pagepoints}}}%
      % See if this has changed from the last run of LaTeX:
      \CheckIfChanged@hlf{@pagepoints}{pointsonpage@\romannumeral
                          \csname c@pageof@pagepoints\endcsname}%
    \fi
    \ifnum \thepageof@pagebonuspoints > 0\relax
      \immediate\write\@mainaux
          {\string\gdef\string\bonuspointsonpage@\romannumeral
                          \csname c@pageof@pagebonuspoints\endcsname
             {\prtaux@hlfcntr{@pagebonuspoints}}}%
      \CheckIfChanged@hlf{@pagebonuspoints}{bonuspointsonpage@\romannumeral
                          \csname c@pageof@pagebonuspoints\endcsname}%
    \fi
    \immediate\write\@mainaux
      {\string\gdef\string\lastpage@withpoints{\page@withpoints}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{lastpage@withpoints}%
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \edef\othpt@check{\page@withpoints}%
        \edef\pt@check{\lastpage@withpoints}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
    \immediate\write\@mainaux
      {\string\gdef\string\lastpage@withbonuspoints{\page@withbonuspoints}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{lastpage@withbonuspoints}%
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \edef\othpt@check{\page@withbonuspoints}%
        \edef\pt@check{\lastpage@withbonuspoints}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
  \fi
  % Echo numbers of questions, parts, and subparts:
  \typeout{This exam contains \thenumquestions\space questions
    with \thenumparts\space parts, \thenumsubparts\space subparts,
    and \thenumsubsubparts\space subsubparts.}
  % If counting points, echo total points:
  \if@printtotalpoints
    \begingroup
      \def\typ@expnd{%
        \thenumpoints
        \ifnumpoints@half
          \space and a half%
        \fi
      }
      \typeout{This exam has a total of \typ@expnd\space points.}
      \def\typ@expnd{%
        \thenumbonuspoints
        \ifnumbonuspoints@half
          \space and a half%
        \fi
      }
      \typeout{This exam has a total of \typ@expnd\space bonus points.}
    \endgroup
  \fi
  \if@pointschanged
    \ClassWarningNoLine{exam}{Point totals have changed.
               Rerun to get point totals right}%
  \fi
}% AtEndDocument


% We define \iflastpage so that it can safely be used
% in headers and footers:
\def\iflastpage#1#2{%
  \@ifundefined{exam@lastpage}{\def\@@lastpage{-1}}%
          {\edef\@@lastpage{\exam@lastpage}}%
  \ifnum\value{page}=\@@lastpage\relax
    #1%
  \else
    #2%
  \fi
}% iflastpage


% The macro \oddeven takes two arguments.  If the page number is odd,
% then you get the first argument; otherwise, you get the second
% argument.
\def\oddeven#1#2{%
  \ifodd\value{page}%
    #1%
  \else
    #2%
  \fi
}% oddeven



%--------------------------------------------------------------------
%--------------------------------------------------------------------
%                 \ifcontinuation, \ContinuedQuestion,
%                \ifincomplete, and \IncompleteQuestion

% The commands \ifcontinuation, \ContinuedQuestion, \ifincomplete, and
% \IncompleteQuestion assume that there is only one questions
% environment in the entire document.  (Actually, \ContinuedQuestion
% should work even if there are multiple questions environments, but
% none of the other three will work in general.)



% \PgInfo@write, \PgInfo and \PgInfo@get are our replacements
% for \label, \newlabel, and \pageref.  (We're avoiding using
% \label, \newlabel, and \pageref so that we will be compatible
% with hyperref.sty, which redefines those commands.)

% We use \PgInfo, \PgInfo@write, and \PgInfo@get to know on which page
% each question, part, subpart, subsubpart, and choice appears.

% We use \PgInfo@write to write \PgInfo commands to the .aux file.  The
% \PgInfo command takes two arguments: A question (or part, or subpart,
% or subsubpart) label, and the number of the page on which it appears.

% The label for a question is of the form `question@2' (if it's question
% 2).

% The label for a part is of the form `part@2@1' (if it's part a of
% question 2).

% The label for a subpart is of the form `subpart@2@1@3' (if it's
% subpart iii of part a of question 2).

% The label for a subsubpart is of the form `subsubpart@2@1@3@4' (if
% it's subsubpart $\delta$ of subpart iii of part a of question 2).

% Each question, part, subpart, subsubpart, and choice also gets a
% \PgInfo@write command using a label of the form question2@object3 (if
% it's the third object of the second question).

% The \PgInfo command defines a control sequence of the form `Pg@label'
% that expands to the page number for the corresponding question.  For
% example, \PgInfo{subsubpart@2@1@3@4}{7} defines 
%   \csname Pg@subsubpart@2@1@3@4\endcsname 
% to expand to 7.

% The \PgInfo@get{label} command returns the value of the macro Pg@label,
% but it *doesn't* check whether that macro is defined.  Thus, it's
% important to check that the macro Pg@label is defined before giving the
% command \PgInfo@get{label}.



% The token list to a \write command isn't expanded until
% it's shipped out.  Since the argument to PgInfo@write
% generally contains macros, we want to expand those macros
% now, rather than waiting until this is shipped out, at which
% point the macros may have different values.  Thus, we use
% \edef to force expansion of the argument, and we put
% a \noexpand in front of \thepage so that the \thepage
% will not be expanded now.  (This may not get shipped out
% until a later page, and so we want the \thepage to be expanded
% only when it's shipped out.)
% We use the \begingroup \endgroup pair so that our use
% of \reserved@a won't affect its use anywhere else.
\def\PgInfo@write#1{%
  \begingroup
    \edef\reserved@a{\write\@mainaux
      {\string\PgInfo{#1}{\noexpand\thepage}}}%
    \reserved@a
  \endgroup
}

%\PgInfo commands are written to the .aux file by the \PgInfo@write
%command; that's the only place that \PgInfo commands appear.
\def\PgInfo#1#2{\expandafter\gdef\csname Pg@#1\endcsname{#2}}

% Note: PgInfo@get assumes that the control sequence being
% constructed is already defined; you have to make sure of this
% *before* calling \Pginfo@get
\def\PgInfo@get#1{\csname Pg@#1\endcsname}

% \set@counter@to@pageof takes two arguments: The first is the name of a
% counter, and the second (expands to) the label of a question, part,
% subpart, subsubpart, or choice.  If that label exists, then we set the
% counter equal to the page on which the question (or part, etc.)
% appears.  If that label doesn't exist, we set the counter equal to -1.
% (No labels exist on the first run of LaTeX on the file, and if a new
% question (or part, etc.) was created by editing the file, then the
% label will not exist until the run of LaTeX after that.)
\def\set@counter@to@pageof#1#2{%
  \@ifundefined{Pg@#2}%
  {\setcounter{#1}{-1}}%
  {\setcounter{#1}{\csname Pg@#2\endcsname}}%
}


%--------------------------------------------------------------------

% \ifcontinuation#1#2 expands to #2 if either: (1) The current page is
% before the page containing question number 1, or (2) A question begins
% on this page before any part, subpart, subsubpart, or choice begins,
% or (3) The current page is later than a page with the \nomorequestions
% command.  Otherwise, it expands to #1.


\def\ifcontinuation#1#2{%
  % We need to first check whether we're on a page *before* the page on
  % which the first question appears.  If we don't yet know which page
  % has question number 1, then we must be doing an early run of LaTeX,
  % and we'll assume we're not a continuation.
  \expandafter\ifx\csname Pg@question@1\endcsname\relax
    % No page info yet; assume not a continuation
    #2%
  \else
    % Note: The ``\relax'' at the end of the following \ifnum
    % serves an entirely different purpose from the one at the
    % end of the above \expandafter\ifx.  That one (above)
    % is one of the things being compared, whereas the
    % one we're about to use is just to clearly mark the
    % end of the second number being compared by the \ifnum
    % (since it's conceivable that the ``#2'' would begin
    % with a digit).
    \ifnum \thepage < \csname Pg@question@1\endcsname\relax
      % We're before the page with question 1:
      #2%
    \else
      % The current page begins a new question if Contin@\thepage
      % has been defined as a macro that expands to \relax
      % (Note that this is different from if Contin@\thepage
      % has never been defined at all, in which case it will
      % be let equal to \relax (temporarily) by the \csname command.)
      \expandafter\ifx\csname Contin@\thepage\endcsname\ref@relax
        #2%
      \else
        % See if we're after a \nomorequestions command:
        \@ifundefined{Pg@@endquestions}%
        {#1}%
        {\ifnum \thepage > \PgInfo@get{@endquestions}\relax
          % We're after a \nomorequestions:
          #2%
         \else
           % We actually are incomplete:
           #1%
         \fi
        }%
      \fi
    \fi 
  \fi
}

\def\nomorequestions{
  \PgInfo@write{@endquestions}%
}

%--------------------------------------------------------------------
% \ContinuedQuestion is for use in headers and footers, where we can
% assume that \thepage is the number of the page on which we'll
% actually appear.

% \ContinuedQuestion expands to the number of the question that
% continues onto this page, or to -1 if this page begins with a new
% question.

% ACTUALLY: \ContinuedQuestion expands to a positive number if either
% (1) this page doesn't contain the beginning of any question, part,
% subpart, subsubpart, or choice, or (2) this page has a part, subpart,
% subsubpart, or choice that appears before any question.  That means
% that if the current page actually begins with space for a continuation
% of the previous question (but doesn't begin any part, subpart,
% subsubpart, or choice of that question) and then has a question, then
% we'll be asserting that this page begins with a new question, but the
% actual top of the page will begin with some blank space that's
% intended for the previous question.

% \ContinuedQuestion works by examining the value of the macro
% Contin@\thepage.  If this page starts with a question (i.e., if no
% question continues onto this page), then the macro Contin@\thepage
% will be defined, and will expand to `\relax' (and so an \ifx between
% \csname Contin@\thepage\endcsname and \ref@relax will be true).

% If Contin@\thepage is undefined, then when it is used in an \ifx
% command it will be temporarily set equal to \relax (which is
% *different* from being a macro that expands to \relax); in this case,
% there is no question, part, subpart, subsubpart, or choice that begins
% on this page, and so \ContinuedQuestion will be set equal to the last
% question that was begun on a page before this one.

% The last possibility is that this page begins with either a part,
% subpart, subsubpart, or choice.  In this case, Contin@\thepage is
% defined, and it expands to the number of the question that is
% continues onto this page.


\def\ref@relax{\relax}

\def\ContinuedQuestion{%
  \expandafter\ifx\csname Contin@\thepage\endcsname\relax
    % We get here if there's no question, part, subpart,
    % subsubpart, or choice on this page, and so Contin@\thepage has
    % never been defined at all.  In that case, this page
    % continues whichever question was last begun on or 
    % before this page.
    \find@latestques
    \thelatest@ques
  \else
    \expandafter\ifx\csname Contin@\thepage\endcsname\ref@relax
      % We get here if this page begins with a new question,
      % which is why Contin@\thepage has been defined to be
      % a macro that expands to \relax.
      % ACTUALLY: We get here if this page has a question that
      % appears before any part, subpart, subsubpart, or choice.  That
      % means that if the current page actually begins with space
      % for a continuation of the previous question but doesn't begin
      % any part, subpart, subsubpart, or choice of that question, then
      % we'll be asserting that this page begins with a new question,
      % but the actual top of the page will begin with some space
      % that's intended for the previous question.
      -1\relax
    \else
      % We get here if we didn't get anywhere above.  This happens
      % if Contin@\thepage has been defined to be a macro that expands
      % to something other than \relax, in which case it has been
      % defined to be a macro that expands to the number of the
      % question that continues onto this page.
      \csname Contin@\thepage\endcsname
    \fi
  \fi
}

%--------------------------------------------------------------------
% \find@latestques is for use in headers and footers, where we can
% assume that \thepage actually equals the page on which we'll appear.
% We find the last question that was started on or before the current
% page.

\newcounter{latest@ques}

\newcommand\find@latestques{%
  % \find@latestques is for use in headers and footers.
  % \find@latestques will set the counter latest@ques
  % to the number of the last question
  % that was begun on the exam from page 1 through the current
  % page.  This may well be the value of the question counter,
  % but it may be less than that if the page following this one
  % begins a new question and that question beginning was
  % typeset before the present page was shipped out.
  % Note: This macro is called both by \ContinuedQuestion and by
  % \find@quesend, which is why it has to find the last question
  % begun on or before the current page, rather than just before
  % the current page.
  \ifnum 1 > \value{question}\relax
    % Oops; probably because we're before the first question
    % Just set latest@ques to -1:
    \setcounter{latest@ques}{-1}%
  \else
    % If question latest@ques actually begins on this page (rather
    % than on the next page, but early enough on the next page
    % that the counter was advanced before we ran off into the
    % output routine to output the page and set the header and 
    % footer), then that's the correct question number.
    \expandafter\ifx\csname Pg@question@\arabic{question}\endcsname\relax
      % We don't know what page that question is on;
      % this must be an early run, before the aux file
      % is helpful.  Just set it equal to -1 and wait until the next
      % run to get it right.
      \setcounter{latest@ques}{-1}%
    \else
      % We now know that \PgInfo@get can tell us the page number
      % of \arabic{question} and of all earlier questions.
      % Set latest@ques equal to the current question number, and
      % then call \decr@latest@ques to recursively decrement
      % latest@ques as needed to find a question that begins on
      % or before the current page:
      \setcounter{latest@ques}{\value{question}}%
      \decr@latest@ques
    \fi
  \fi
}

\def\decr@latest@ques{%
  % If we get here, then we've already checked that the reference
  % Pg@question@\thelatest@ques is defined at least for a value of
  % \thelatest@ques greater than or equal to it's present value,
  % so we assume it's defined for all lesser values as well:
  \ifnum \thepage < \PgInfo@get{question@\thelatest@ques}\relax
    % Nope; latest@ques starts on a later page
    % Decrement latest@ques and see if that one's right:
    \addtocounter{latest@ques}{-1}%
    \ifnum \thelatest@ques < 1\relax
      \setcounter{latest@ques}{-1}%
      \let\next@dlq=\relax
    \else
      \let\next@dlq=\decr@latest@ques
    \fi
  \else
    % latest@ques starts on this page or earlier, so
    % that's the correct question number!  Exit:
    \let\next@dlq=\relax
  \fi
  \next@dlq
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------
\newcounter{ques@end}
\newcounter{last@object}

\def\find@quesend{%
  % We find the last question started on or before the current page
  % and then find the page containing the last part (or subpart, or
  % subsubpart, or choice) of that question, and set the counter
  % ques@end to that page number.
  % Set latest@ques equal to the correct question number:
  \find@latestques
  \ifnum \value{latest@ques} < 0\relax
    % This must be an early run of LaTeX, before we have
    % \PgInfo commands in the .aux file:
    \setcounter{ques@end}{-1}%
  \else
    % We now know that this question has at least one object (since
    % we know that latest@ques isn't negative).
    % We'll find its highest numbered object by setting last@object
    % equal to 2 and then calling \find@lastobject to recursively
    % test whether that object number exists and, if so, incrementing
    % last@object to test for a higher numbered one:
    \setcounter{last@object}{2}%
    \find@lastobject
    \setcounter{ques@end}{\PgInfo@get{question\thelatest@ques
               @object\thelast@object}}%
  \fi
}% find@quesend

\def\find@lastobject{%
  % We check whether this question has an object numbered last@object
  % and recursively increment last@object to find the highest
  % numbered value for which the object exists:
  \@ifundefined{Pg@question\thelatest@ques @object\thelast@object}%
    {\addtocounter{last@object}{-1}%
      \let\nextfind@lastobject=\relax
    }%
    {\addtocounter{last@object}{1}%
      \let\nextfind@lastobject=\find@lastobject
    }%
  \nextfind@lastobject
}% find@lastobject



%--------------------------------------------------------------------
%--------------------------------------------------------------------
%--------------------------------------------------------------------

\newcounter{incmp@ques}

\def\IncompleteQuestion{%
  \Find@Incmp@ques
  \theincmp@ques
}

\def\Find@Incmp@ques{%
  \iflastpage{\setcounter{incmp@ques}{-1}}{\chk@incomp}%
}
\newcounter{next@ques}
\newcounter{nextq@page}
\def\chk@incomp{%
  \find@quesend
  \ifnum \theques@end > \thepage\relax
    % This question has a part (or sub...) starting on a later page
    \setcounter{incmp@ques}{\value{latest@ques}}%
  \else
    \setcounter{next@ques}{\thelatest@ques}%
    \addtocounter{next@ques}{1}%
    \expandafter\ifx\csname Pg@question@\thenext@ques \endcsname\relax
      % This isn't the last page but there is no next question:
      \setcounter{incmp@ques}{\thelatest@ques}%
    \else
      % This isn't the last page and there is a next question:
      \setcounter{nextq@page}{\PgInfo@get{question@\thenext@ques}}%
      \addtocounter{nextq@page}{-1}%
      \ifnum \thenextq@page > \thepage\relax
        \setcounter{incmp@ques}{\thelatest@ques}%
      \else
        \setcounter{incmp@ques}{-1}%
      \fi
    \fi
  \fi
}

\def\ifincomplete#1#2{%
  \def\incomp@first{#1}%
  \def\incomp@second{#2}%
  \Find@Incmp@ques
  \ifnum \theincmp@ques < 0\relax
    \incomp@second
  \else
        \@ifundefined{Pg@@endquestions}%
        {\incomp@first}%
        {\ifnum \thepage < \PgInfo@get{@endquestions}\relax
           \incomp@first
         \else
           \incomp@second
         \fi
        }%
  \fi
}

%--------------------------------------------------------------------
% These are the commands for dealing with hlfcntr's, i.e., the things
% used to count points.
%
% A point value is a nonnegative integer with an optional half integer.
% A hlfcntr consists of a regular counter together with an \if: If the
% regular counter is called ``counter'', then the \if is called
% ``\ifcounter@half''; it's set true by ``\counter@halftrue'' and set
% false by ``\counter@halffalse''.
%
% The commands:
%
% \new@hlfcntr{countername}
% \set@hlfcntr{countername}{value}
% \copy@hlfcntr{tocounter}{fromcounter}
% \addto@hlfcntr{countername}{value}
% \add@hlfcntrtohlfcntr{getsaddedto}{whatsadded}
% \ifhlfcntr@pos{countername}
% \prtaux@hlfcntr{countername}
% \prt@hlfcntr{countername}
%
% ``value'' can be either a (nonnegative) integer, an integer followed by
% ``\half'', or just plain ``\half''.  (Actually, ``value'' can be empty
% (although the braces must be present), in which case it's interpreted
% as ``0''.)
%
% Examples of valid values:
%   0
%   0\half
%   1
%   1\half
%   2
%   2\half
% etc.

% Note on using ``\global'': LaTeX's \setcounter and \addtocounter
% commands are already \global (i.e., you don't have to say
% ``\global''), but \somethingtrue and \somethingfalse (used to set
% \ifsomething) aren't.  Thus, we need to say ``\global'' when setting
% these things.

% To create a hlfcntr:
\newcommand*\new@hlfcntr[1]{%
  \newcounter{#1}%
  \expandafter\newif\csname if#1@half\endcsname
}% new@hlfcntr


% A scratch hlfcntr:
\new@hlfcntr{tmp@hlfcntr}

\newcommand*\horiz@half{$\frac{1}{2}$}
\newcommand*\slanted@half{%
  $\raise0.6ex\hbox{$\scriptstyle 1$}\kern -.2em/\kern -.2em
     \raise-0.5ex\hbox{$\scriptstyle 2$}$%
}% slanted@half
\newcommand*\useslantedhalf{\global\let\half\slanted@half}
\newcommand*\usehorizontalhalf{\global\let\half\horiz@half}
\newcommand*\half{\slanted@half}


\newcommand*\set@hlfcntr[2]{%
  \begingroup
    \global\csname #1@halffalse\endcsname
    % If there as a `\half' present, it will be executed
    % right after the assignment of the digit part of #2
    % to the counter #1.
    \def\half{%
      \global\csname #1@halftrue\endcsname
    }%
    % We insert a `0' in case there are no digits present:
    % We avoid using \setcounter, because calc.sty redefines
    % \setcounter in a way that conflicts with the \half trick
    % we're using:
    %    \setcounter{#1}{0#2}\relax
    \global\csname c@#1\endcsname 0#2\relax
  \endgroup
}% set@hlfcntr

\newcommand*\copy@hlfcntr[2]{%
  % We set #1 to the value of #2
  \setcounter{#1}{\value{#2}}%
  \csname if#2@half\endcsname
    \global\csname #1@halftrue\endcsname
  \else
    \global\csname #1@halffalse\endcsname
  \fi
}% copy@hlfcntr

\newcommand*\addto@hlfcntr[2]{%
  % We add the valueandhalf #2 to hlfcntr #1
  \begingroup
    \def\half{\add@half{#1}}%
    % We insert a `0' in case there are no digits present:
    % We avoid using \addtocounter, because calc.sty redefines
    % \addtocounter in a way that conflicts with the \half trick
    % we're using:
    %    \addtocounter{#1}{0#2}\relax
    \global\advance\csname c@#1\endcsname 0#2\relax
  \endgroup
}% addto@hlfcntr

\newcommand*\add@hlfcntrtohlfcntr[2]{%
  % We add the hlfcntr #2 to the hlfcntr #1
  \addtocounter{#1}{\value{#2}}%
  \csname if#2@half\endcsname
    \add@half{#1}%
  \fi
}% add@hlfcntrtohlfcntr

\newcommand*\add@half[1]{%
  % We add one half to hlfcntr #1:
  \csname if#1@half\endcsname
    \addtocounter{#1}{1}%
    \global\csname #1@halffalse\endcsname
  \else
    \global\csname #1@halftrue\endcsname
  \fi
}% add@half

\newcounter{ifpos@cntr}
\def\ifhlfcntr@pos#1{%
  % The argument must be a hlfcntr (which, of course,
  % can never be negative); we'll be true if and only if
  % that halfcntr is positive:
  \setcounter{ifpos@cntr}{\value{#1}}%
  \csname if#1@half\endcsname
    \addtocounter{ifpos@cntr}{1}%
  \fi
  \ifnum \value{ifpos@cntr} > 0\relax
}% ifhlfnctr@pos

% \prtaux@hlfcntr is used inside the argument of a \write command for
% writing to the .aux file:
\newcommand*\prtaux@hlfcntr[1]{%
  % We don't want a \relax after the 0 in the following
  % line, because it would sometimes appear in the aux file:
  \ifnum \value{#1} = 0 
    % We have to make the following a macro, because if we
    % don't do this part, the \fi will cause confusion, since
    % there's no \if visible until the \csname is expanded:
    \prtaux@halforzero{#1}%
  \else
    \arabic{#1}%
    % We have to make the following a macro, because if we
    % don't do this part, the \fi will cause confusion, since
    % there's no \if visible until the \csname is expanded:
    \prtaux@halforblank{#1}%
  \fi
}% prtaux@hlfcntr
\newcommand*\prtaux@halforzero[1]{%
  \csname if#1@half\endcsname
    \string\half
  \else
    0%
  \fi
}% prtaux@hlforzero
\newcommand*\prtaux@halforblank[1]{%
  \csname if#1@half\endcsname
    \string\half
  \fi
}% prtaux@halforblank

\newcommand*\prt@hlfcntr[1]{%
  % We don't want a \relax after the 0 in the following
  % line, because it would sometimes appear in the aux file:
  \ifnum \value{#1} = 0 
    % We have to make the following a macro, because if we
    % don't do this part, the \fi will cause confusion, since
    % there's no \if visible until the \csname is expanded:
    \prt@halforzero{#1}%
  \else
    \arabic{#1}%
    % We have to make the following a macro, because if we
    % don't do this part, the \fi will cause confusion, since
    % there's no \if visible until the \csname is expanded:
    \prt@halforblank{#1}%
  \fi
}% prt@hlfcntr
\newcommand*\prt@halforzero[1]{%
  \csname if#1@half\endcsname
    \half
  \else
    0%
  \fi
}% prt@hlforzero
\newcommand*\prt@halforblank[1]{%
  \csname if#1@half\endcsname
    \half
  \fi
}% prt@halforblank

% End of the commands for dealing with hlfcntr's

%--------------------------------------------------------------------
%---------------------------------------------------------------------
%
%                    ***************************
%                    ** QUESTION ENVIRONMENTS **
%                    ***************************
%
%
%

% We define the command \part only inside of a parts environment, so
% that we don't interfere with the meaning of the standard article
% documentclass command \part if that is used inside of a questions
% environment.  The commands \question, \subpart, and \subsubpart are
% defined everywhere inside of a questions environment.  If the user
% accidentally gives a \subpart command outside of a subparts
% environment, then an error will be created.




% We use the counter name `partno' for the parts environment so that
% we will not interfere with the counter `part' used by the article
% document class.

\newcounter{question}
\newcounter{partno}
\newcounter{subpart}
\newcounter{subsubpart}
\newcounter{choice}
\new@hlfcntr{numpoints}
\set@hlfcntr{numpoints}{0}
\new@hlfcntr{numbonuspoints}
\set@hlfcntr{numbonuspoints}{0}
\new@hlfcntr{pointsof@thisquestion}
\set@hlfcntr{pointsof@thisquestion}{0}
\new@hlfcntr{bonuspointsof@thisquestion}
\set@hlfcntr{bonuspointsof@thisquestion}{0}
\newcounter{numquestions}
\newcounter{numparts}
\newcounter{numsubparts}
\newcounter{numsubsubparts}
\newcounter{Curr@Page}

% @pagepoints accumulates the points on a single page:
\new@hlfcntr{@pagepoints}
\set@hlfcntr{@pagepoints}{0}
\new@hlfcntr{@pagebonuspoints}
\set@hlfcntr{@pagebonuspoints}{0}
\newcounter{pageof@pagepoints}
\setcounter{pageof@pagepoints}{0}
\newcounter{pageof@pagebonuspoints}
\setcounter{pageof@pagebonuspoints}{0}

% latest@points is a holding area for points until we know
% whether they'll land on the same page as the points
% currently counted in @pagepoints:
\new@hlfcntr{latest@points}
\set@hlfcntr{latest@points}{0}
\new@hlfcntr{latest@bonuspoints}
\set@hlfcntr{latest@bonuspoints}{0}

% Whenever we meet a new page on which points are defined, we'll
% redefine \page@withpoints to expand to that page.  At the end of the
% document, it will hold the last page that has points, and we'll write
% a \gdef\lastpage@withpoints command to the .aux file.
% We initialize \page@withpoints here:
\def\page@withpoints{0}%
\def\page@withbonuspoints{0}%

% \pageinfo@commands is used by each question, part, subpart, and
% subsubpart to insert into everypar the \PgInfo@write command to put
% its page number into the .aux file, the \PgInfo@get command to read
% the page number into the counter Curr@Page, and to test and set
% \Contin@\theCurr@Page.  \temp@toks is used by part, subpart, and
% subsubpart to append all that to \pageinfo@commands, rather than
% deleting whatever may have been put into \pageinfo@commands by the
% current question and/or part and/or subpart.
\newtoks\pageinfo@commands
\newtoks\temp@toks

% \pagepoint@commands holds the commands to manage the counting of the
% number of points defined on each page.
\newtoks\pagepoint@commands

% \point@toks holds the commands to print the points at the proper
% location on the page (except that it's not used by the \qformat
% option).
\newtoks\point@toks

% We'll use \greeknum to number subsubparts
\def\greeknum#1{\expandafter\lc@greek\csname c@#1\endcsname}
\def\lc@greek#1{%
  \ifcase #1\or $\alpha$\or $\beta$\or $\gamma$\or $\delta$\or
  $\epsilon$\or $\zeta$\or $\eta$\or $\theta$\or $\iota$\or
  $\kappa$\or $\lambda$\or $\mu$\or $\nu$\or $\xi$\or o\or $\pi$\or
  $\rho$\or $\sigma$\or $\tau$\or $\upsilon$\or $\phi$\or $\chi$\or
  $\psi$\or $\omega$\else \@ctrerr
  \fi
}% lc@greek


% The following macros are a variation on a trick from Victor
% Eijkhout's ``TeX by Topic'', page 142:
% Both \prepend@toklist and \append@toklist take two arguments,
% both of which should be token lists.
% \prepend@toklist prepends #2 to #1
% \append@toklist appends #2 to #1

\def\prepend@toklist#1#2{%
  \edef\do@it{\noexpand#1={\the#2\the#1}}%
  \do@it
}% prepend@toklist

\def\append@toklist#1#2{%
  \edef\do@it{\noexpand#1={\the#1\the#2}}%
  \do@it
}% append@toklist


% The command \qformat is provided for the user who wants to
% design a nonstandard question line.  If this command is used,
% then the usual line containing the question number and the beginning
% of the question will be replaced by the line specified by the
% \qformat command, and the question will begin on the following
% line.
% Within the argument of the \qformat command:
% \thequestion will be replaced by the question number, and
% \thepoints will be replaced by ``\@points \@pointname'' if the
% number of points has been specified for this question, and otherwise
% it inserts nothing at all.  (The conditional @placepoints is used to
% determine if there were points specified for this question.)
% The argument to the \qformat command *must* contain some
% stretch, i.e., at least one \hfil or \dotfill or ...
%
% The command \noqformat cancels the effect of \qformat and returns us
% to the default situation.
%
% The commands \bonusqformat and \nobonusformat are analogous.
\newif\if@qformat
\@qformatfalse
\newif\if@bonusqformat
\@bonusqformatfalse

\def\qformat#1{%
  \global\@qformattrue
  \gdef\@questionformat{#1}%
}% qformat
\def\bonusqformat#1{%
  \global\@bonusqformattrue
  \gdef\@bonusquestionformat{#1}%
}% bonusqformat

\newcommand\noqformat{%
  \global\@qformatfalse
}% noqformat
\newcommand\nobonusqformat{%
  \global\@bonusqformatfalse
}% nobonusqformat


% \thepoints is for use in either a \qformat command
% or a \pointformat command (or a \bonusqformat command).
% It needs to have the
% \if@placepoints so that if it's used in a \qformat command
% it won't print anything if there are no points:
\newcommand\thepoints{%
  \if@placepoints
    \if@bonus
      \@points \@bonuspointname
    \else
      \@points \@pointname
    \fi
  \fi
}% thepoints

% \themarginpoints is for use only in a \pointformat command,
% and so it doesn't need the \if@placepoints bit in \thepoints:
\newcommand\themarginpoints{%
  \if@bonus
    \@points \@marginbonuspointname
  \else
    \@points \@marginpointname
  \fi
}% themarginpoints

% We define the \subpart and \subsubpart commands when we enter a
% questions environment (rather than waiting until we enter a subparts
% of subsubparts environment) so that we can signal an error if a
% \subpart or \subsubpart command appears outside of the corresponding
% environment.  (We don't do this for the \part command so that the user
% can use the standard sectioning \part command outside of a parts
% environment.)

% The counter ques@object will count the items in each question, where
% an item is defined as either the question itself, or a part, or a
% subpart, or a subsubpart, or a choice.  This will be used by
% \find@quesend to find the last page occupied by the last question
% begun on or before the current page:
\newcounter{ques@object}

% \first@questionobject will be used by the \question command.
% That is, it will be used only once, but we want to keep its
% definition here, near the definitions of \addquestionobject and
% \questionobject@pluspagecheck.
\newcommand{\first@questionobject}{%
  \setcounter{ques@object}{1}%
  \edef\q@object@label{%
    question\arabic{question}@object\arabic{ques@object}}%
  \PgInfo@write{\q@object@label}%
}% first@questionobject

% \addquestionobject will be used by each part, subpart, and
% subsubpart, and can also be used by the user to mark the end of a
% question that spills over onto the next page without any part,
% subpart, etc. starting on that page:
\newcommand{\addquestionobject}{%
  \addtocounter{ques@object}{1}%
  \edef\q@object@label{%
    question\arabic{question}@object\arabic{ques@object}}%
  \PgInfo@write{\q@object@label}%
}% addquestionobject

% \questionobject@pluspagecheck will be used by each choice.  It uses
% the questionobject to check if we're the first one on the current
% page, since choices don't have labels the way that questions, parts,
% subparts, and subsubparts do (those things use the label to check if
% they're the first thing on the page).
\newcommand{\questionobject@pluspagecheck}{%
  \addtocounter{ques@object}{1}%
  \edef\q@object@label{%
    question\arabic{question}@object\arabic{ques@object}}%
  \PgInfo@write{\q@object@label}%
  \set@counter@to@pageof{Curr@Page}{\q@object@label}%
  \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
    % We're the first \question, \part, \subpart, \subsubpart,
    % or choice on this page:
    \global\expandafter\edef\csname
    Contin@\theCurr@Page\endcsname{\arabic{question}}%
  \fi
}% questionobject@pluspagecheck



% if@bonus will be true when we're doing a bonusquestion or bonuspart
% or etc., and it will also be used also to distinguish between
% \gradetable and \bonusgradetable (and between \pointtable and
% \bonuspointtable, etc.), and also to distinguish between
% \pointsinrange and \bonuspointsinrange:
\newif\if@bonus
\@bonusfalse

% The following are for advanced users who want to customize the list
% parameters (\topsep, \partopsep, \itemsep, \parsep, etc.) for the
% lists that these environments create.  They are all defined to be
% empty, but the user can change them using \renewcommand.
\newcommand\questionshook{}
\newcommand\partshook{}
\newcommand\subpartshook{}
\newcommand\subsubpartshook{}
\newcommand\choiceshook{}
\newcommand\checkboxeshook{}


\newenvironment{questions}{%
  % \@queslevel is used for two purposes:
  % (1) We check that every \question, \part, \subpart, and 
  % \subsubpart command appears inside the appropriate environment,
  % and generate an error if one appears in the wrong place.
  % (2) If a \qformat is being used and if \@queslevel tells us
  % that we're currently processing a question, then we set
  % \global \point@toks={} to avoid setting the points for a 
  % question other than via the qformat command.
  \def\@queslevel{question}%
  \def\titledquestion##1{%
    \@bonusfalse
    \def\thequestiontitle{##1}%
    \process@question
  }%
  \def\bonustitledquestion##1{%
    \@bonustrue
    \def\thequestiontitle{##1}%
    \process@question
  }%
  \def\question{%
    \@bonusfalse
    \def\thequestiontitle{\csname p@question\endcsname
                          \csname thequestion\endcsname}%
    \process@question
  }%
  \def\bonusquestion{%
    \@bonustrue
    \def\thequestiontitle{\csname p@question\endcsname
                          \csname thequestion\endcsname}%
    \process@question
  }%
  \def\process@question{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{question}%
    \addtocounter{numquestions}{1}%
    % Write the sum of points of the previous question (if any)
    % to the .aux file.  (At this point, the question counter
    % has not yet been incremented, so \value{question} is the
    % number of the question that was just completed.)
    \if@filesw
      \ifnum \value{question} > 0\relax
        % First do regular points:
        \immediate\write\@mainaux
          {\string\gdef\string\pointsofq@
            \romannumeral \csname c@question\endcsname
              {\prtaux@hlfcntr{pointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{pointsof@thisquestion}{pointsofq@\romannumeral
                            \csname c@question\endcsname}%
        % Now do bonus points:
        \immediate\write\@mainaux
          {\string\gdef\string\bonuspointsofq@
            \romannumeral \csname c@question\endcsname
              {\prtaux@hlfcntr{bonuspointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{bonuspointsof@thisquestion}%
                           {bonuspointsofq@\romannumeral
                             \csname c@question\endcsname}%
      \fi
    \fi
    \set@hlfcntr{pointsof@thisquestion}{0}%
    \set@hlfcntr{bonuspointsof@thisquestion}{0}%
    % If there was a question with points immediately preceding
    % this question (i.e., there were no parts in the previous
    % question), then @placepoints will still be true, and we need to
    % cancel it.  (We used to do this inside of the \thepoints macro,
    % but that allowed for an error if the user specified points for a
    % question but had a \qformat that didn't mention \thepoints.)  We
    % also set @placepoints to be false when entering a parts
    % environment. 
    \global \@placepointsfalse
    % point@toks will normally be empty at this point, but it might be
    % nonempty if there were points somewhere in the previous question
    % that never made it onto the page because we never entered
    % horizontal mode (perhaps because the user was weird and let the
    % text of a question (or part, etc.) consist entirely of an
    % enumerate environment, or description environment, or etc.).
    \global \point@toks={}%
    % Important: Don't leave any blank lines inside of
    % \pageinfo@commands!!  This token list will be dumped into
    % horizontal mode by \everypar, and so any blank lines will
    % cause paragraph breaks. 
    \pageinfo@commands={%
      \edef\@queslabel{question@\arabic{question}}%
      \PgInfo@write{\@queslabel}%
      \first@questionobject
      % In addition to the \PgInfo@write we use an actual \label
      % command.  We do this in order to make the question numbers in
      % the grade tables into \ref's, so that if the user says
      % \usepackage{hyperref}, those question numbers will be clickable.
      % 
      % A further purpose of these labels (which we actually do for all
      % questions, parts, subparts, and subsubparts) is that if a
      % question (or part, etc.) is, e.g., moved from one page to
      % another, LaTeX will notice this and warn the user that LaTeX
      % must be run one more time to be sure everything is correct.
      % 
      % We need to do this even though we've already included code to
      % check when point totals change because questions (and parts,
      % etc.) know what page they're on from reading the info written to
      % the .aux file on the previous run.  Thus, if a question (or
      % part, etc.) is moved to a different page, then the pointsonpage
      % totals won't notice until the *second* subsequent run of LaTeX,
      % and so there'll be no warning to the user on the *first* run.
      % Including these labels gives the user a warning on that first
      % run.
      %
      % Further futzing required: Since this is being put into the
      % token list \pageinfo@commands, the contents of which won't
      % actually be  executed until we enter horizontal mode (which
      % may well be in the first part of a parts environment), we need
      % to make sure that \@currentlabel is the number of the
      % question:
      \begingroup % to confine the change to \@currentlabel
%        \def\@currentlabel{\csname p@question\endcsname
%                           \csname thequestion\endcsname}%
        \def\@currentlabel{\thequestiontitle}%
        \label{\@queslabel}%
      \endgroup
      \set@counter@to@pageof{Curr@Page}{\@queslabel}%
      \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
        % We're the first \question, \part, \subpart, \subsubpart,
        % or choice on this page:
        \global\expandafter\edef
               \csname Contin@\theCurr@Page\endcsname{\relax}%
      \fi
      \the\pagepoint@commands
      \global \pageinfo@commands={}%
    }% pageinfo@commands
    \ifhmode
      % Remove any skips at the end of the previous paragraph
      % that might cause a blank line, and then end that paragraph:
      \unskip\unskip \par
    \fi
    \@doitem
  }% process@question
  \def\subpart{%
    \@bonusfalse
    \process@subpart
  }%
  \def\bonussubpart{%
    \@bonustrue
    \process@subpart
  }%
  \def\process@subpart{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{subpart}%
    \addtocounter{numsubparts}{1}%
    % Important: Don't leave any blank lines inside of
    % \pageinfo@commands!!  This token list will be dumped into
    % horizontal mode by \everypar, and so any blank lines will
    % cause paragraph breaks. 
    \temp@toks={%
      \edef\@subpartlabel{subpart@\arabic{question}%
        @\arabic{partno}@\arabic{subpart}}%
      \PgInfo@write{\@subpartlabel}%
      \addquestionobject
      % In addition to the \PgInfo@write we use an actual \label
      % command.  We do this in order to make the question numbers in
      % the grade tables into \ref's, so that if the user says
      % \usepackage{hyperref}, those question numbers will be clickable.
      % 
      % A further purpose of these labels (which we actually do for all
      % questions, parts, subparts, and subsubparts) is that if a
      % question (or part, etc.) is, e.g., moved from one page to
      % another, LaTeX will notice this and warn the user that LaTeX
      % must be run one more time to be sure everything is correct.
      % 
      % We need to do this even though we've already included code to
      % check when point totals change because questions (and parts,
      % etc.) know what page they're on from reading the info written to
      % the .aux file on the previous run.  Thus, if a question (or
      % part, etc.) is moved to a different page, then the pointsonpage
      % totals won't notice until the *second* subsequent run of LaTeX,
      % and so there'll be no warning to the user on the *first* run.
      % Including these labels gives the user a warning on that first
      % run.
      \label{\@subpartlabel}%
      \set@counter@to@pageof{Curr@Page}{\@subpartlabel}%
      \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
        % We're the first \question, \part, \subpart, \subsubpart,
        % or choice on this page:
        \global\expandafter\edef\csname
                       Contin@\theCurr@Page\endcsname{\arabic{question}}%
      \fi
      \the\pagepoint@commands
      \global \pageinfo@commands={}%
    }% temp@toks
    \append@toklist \pageinfo@commands \temp@toks
    \ifhmode
      % Remove any skips at the end of the previous paragraph
      % that might cause a blank line, and then end that paragraph:
      \unskip\unskip \par
    \fi
    \@doitem
  }% process@subpart
  \def\subsubpart{%
    \@bonusfalse
    \process@subsubpart
  }%
  \def\bonussubsubpart{%
    \@bonustrue
    \process@subsubpart
  }%
  \def\process@subsubpart{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{subsubpart}%
    \addtocounter{numsubsubparts}{1}%
    % Important: Don't leave any blank lines inside of
    % \pageinfo@commands!!  This token list will be dumped into
    % horizontal mode by \everypar, and so any blank lines will
    % cause paragraph breaks. 
    \temp@toks={%
      \edef\@subsubpartlabel{subsubpart@\arabic{question}%
        @\arabic{partno}@\arabic{subpart}@\arabic{subsubpart}}%
      \PgInfo@write{\@subsubpartlabel}%
      \addquestionobject
      % In addition to the \PgInfo@write we use an actual \label
      % command.  We do this in order to make the question numbers in
      % the grade tables into \ref's, so that if the user says
      % \usepackage{hyperref}, those question numbers will be clickable.
      % 
      % A further purpose of these labels (which we actually do for all
      % questions, parts, subparts, and subsubparts) is that if a
      % question (or part, etc.) is, e.g., moved from one page to
      % another, LaTeX will notice this and warn the user that LaTeX
      % must be run one more time to be sure everything is correct.
      % 
      % We need to do this even though we've already included code to
      % check when point totals change because questions (and parts,
      % etc.) know what page they're on from reading the info written to
      % the .aux file on the previous run.  Thus, if a question (or
      % part, etc.) is moved to a different page, then the pointsonpage
      % totals won't notice until the *second* subsequent run of LaTeX,
      % and so there'll be no warning to the user on the *first* run.
      % Including these labels gives the user a warning on that first
      % run.
      \label{\@subsubpartlabel}%
      \set@counter@to@pageof{Curr@Page}{\@subsubpartlabel}%
      \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
        % We're the first \question, \part, \subpart, \subsubpart,
        % or choice on this page:
        \global\expandafter\edef\csname
                       Contin@\theCurr@Page\endcsname{\arabic{question}}%
      \fi
      \the\pagepoint@commands
      \global \pageinfo@commands={}%
    }% temp@toks
    \append@toklist \pageinfo@commands \temp@toks
    \ifhmode
      % Remove any skips at the end of the previous paragraph
      % that might cause a blank line, and then end that paragraph:
      \unskip\unskip \par
    \fi
    \@doitem
  }% process@subsubpart
  \list{\question@number}%
    {\usecounter{question}%
    % We use the default definition of \makelabel
    % so as not to interfere with \qformat commands.
    % \def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{10.\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \partopsep=0pt
    \questionshook
    }%
  }% End of the first argument of \newenvironment{questions}
  {%
    \endlist
    % Write the number of points of the final question
    % to the .aux file:
    \if@filesw
      \ifnum \value{question} > 0\relax
        % First do the regular points:
        \immediate\write\@mainaux
          {\string\gdef\string\pointsofq@\romannumeral
                                \csname c@question\endcsname
            {\prtaux@hlfcntr{pointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{pointsof@thisquestion}%
                           {pointsofq@\romannumeral
                            \csname c@question\endcsname}%
        % Now do the bonus points:
        \immediate\write\@mainaux
          {\string\gdef\string\bonuspointsofq@\romannumeral
                                \csname c@question\endcsname
            {\prtaux@hlfcntr{bonuspointsof@thisquestion}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{bonuspointsof@thisquestion}%
                           {bonuspointsofq@\romannumeral
                            \csname c@question\endcsname}%
      \fi
    \fi
  }% End of the second argument of \newenvironment{questions}
  
% \question@number is used as the label in the question list (instead
% of \questionlabel) so that if the user uses a \qformat command,
% we'll use the \@questionformat specified by the \qformat command:

\def\question@number{%
  \if@bonus
    \if@bonusqformat
      \makebox[\hsize][s]{\@bonusquestionformat}\hskip-\labelsep
    \else
      \questionlabel
    \fi
  \else
    \if@qformat
      \makebox[\hsize][s]{\@questionformat}\hskip-\labelsep
    \else
      \questionlabel
    \fi
  \fi
}
\newcommand\questionlabel{\thequestion.}
     
% We want the \part command to be defined *only* inside of a parts
% environment, so that the user can use the standard sectioning \part
% command inside of a questions environment (as long as it's outside of
% a parts environment).

\newenvironment{parts}{%
  \def\@queslevel{part}%
  % If the question numbers are being inserted via a \qformat,
  % and if a question is beginning with a parts environment, then
  % we need to enter horizonal mode to get the qformat printed
  % on the page, rather than saving up the question label (and
  % possible points) to be combined with the label of the first
  % part.  (\if@inlabel tells us if we are still waiting to enter
  % horizontal mode after seeing a \question command.)
  \if@bonus
    \if@bonusqformat
      \if@inlabel
        \leavevmode
        \@inlabelfalse
      \fi
      % The following is just in case the question had points,
      % in which case @placepoints will still be true.
      % (We used to do this inside of the \thepoints macro,
      % but that allowed for an error if the user specified points for
      % a question but had a \qformat that didn't mention \thepoints.)
      % We also set @placepoints to be false in the \question command,
      % in case one queation follows a previous one that had no parts.
      \global \@placepointsfalse
    \fi
  \else
    \if@qformat
      \if@inlabel
        \leavevmode
        \@inlabelfalse
      \fi
      % The following is just in case the question had points,
      % in which case @placepoints will still be true.
      % (We used to do this inside of the \thepoints macro,
      % but that allowed for an error if the user specified points for
      % a question but had a \qformat that didn't mention \thepoints.)
      % We also set @placepoints to be false in the \question command,
      % in case one queation follows a previous one that had no parts.
      \global \@placepointsfalse
    \fi
  \fi
  \def\part{%
    \@bonusfalse
    \process@part
  }%
  \def\bonuspart{%
    \@bonustrue
    \process@part
  }%
  \def\process@part{%
    \if@coverpages
      \cover@question@error
    \fi
    \@checkqueslevel{part}%
    \addtocounter{numparts}{1}%
    % Important: Don't leave any blank lines inside of
    % \pageinfo@commands!!  This token list will be dumped into
    % horizontal mode by \everypar, and so any blank lines will
    % cause paragraph breaks. 
    \temp@toks={%
      \edef\@partlabel{part@\arabic{question}@\arabic{partno}}%
      \PgInfo@write{\@partlabel}%
      \addquestionobject
      % In addition to the \PgInfo@write we use an actual \label
      % command.  We do this in order to make the question numbers in
      % the grade tables into \ref's, so that if the user says
      % \usepackage{hyperref}, those question numbers will be clickable.
      % 
      % A further purpose of these labels (which we actually do for all
      % questions, parts, subparts, and subsubparts) is that if a
      % question (or part, etc.) is, e.g., moved from one page to
      % another, LaTeX will notice this and warn the user that LaTeX
      % must be run one more time to be sure everything is correct.
      % 
      % We need to do this even though we've already included code to
      % check when point totals change because questions (and parts,
      % etc.) know what page they're on from reading the info written to
      % the .aux file on the previous run.  Thus, if a question (or
      % part, etc.) is moved to a different page, then the pointsonpage
      % totals won't notice until the *second* subsequent run of LaTeX,
      % and so there'll be no warning to the user on the *first* run.
      % Including these labels gives the user a warning on that first
      % run.
      \label{\@partlabel}%
      \set@counter@to@pageof{Curr@Page}{\@partlabel}%
      \expandafter\ifx\csname Contin@\theCurr@Page\endcsname\relax
        \global\expandafter\edef\csname
            Contin@\theCurr@Page\endcsname{\arabic{question}}%
      \fi
      \the\pagepoint@commands
      \global \pageinfo@commands={}%
    }%
    \append@toklist \pageinfo@commands \temp@toks
    \ifhmode
      % Remove any skips at the end of the previous paragraph
      % that might cause a blank line, and then end that paragraph:
      \unskip\unskip \par
    \fi
    \@doitem
  }% process@part
  \list{\partlabel}%
    {%
    \usecounter{partno}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{(m)\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \topsep=0pt
    \partopsep=0pt
    \partshook
    }%
  }% newenvironment{parts}
  {\endlist}
\newcommand\partlabel{(\thepartno)}
\def\thepartno{\alph{partno}}

\newenvironment{subparts}{%
  \def\@queslevel{subpart}%
  \list{\subpartlabel}%
    {%
    \usecounter{subpart}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{vii.\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \topsep=0pt
    \partopsep=0pt
    \subpartshook
    }%
  }%
  {\endlist}
\newcommand\subpartlabel{\thesubpart.}
\def\thesubpart{\roman{subpart}}

\newenvironment{subsubparts}{%
  \def\@queslevel{subsubpart}%
  \list{\subsubpartlabel}%
    {%
    \usecounter{subsubpart}\def\makelabel##1{\hss\llap{##1}}%
    \settowidth{\leftmargin}{($\psi$)\hskip\labelsep}%
    \labelwidth\leftmargin\advance\labelwidth-\labelsep
    \topsep=0pt
    \partopsep=0pt
    \subsubpartshook
    }%
  }%
  {\endlist}
\newcommand\subsubpartlabel{\thesubsubpart)}
\def\thesubsubpart{\greeknum{subsubpart}}




\pagepoint@commands={%
  \ifhlfcntr@pos{latest@points}%
    % We're putting a question (or part, etc.)
    % with points onto this page: 
    \ifnum \theCurr@Page > \thepageof@pagepoints\relax
      % These points go on a later page than
      % the points currently counted in @pagepoints:
      \ifnum \thepageof@pagepoints = 0\relax
        % Do nothing...
      \else
        \immediate\write\@mainaux
          {\string\gdef\string\pointsonpage@
           \romannumeral \csname c@pageof@pagepoints\endcsname
             {\prtaux@hlfcntr{@pagepoints}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{@pagepoints}{pointsonpage@\romannumeral
                            \csname c@pageof@pagepoints\endcsname}%
      \fi
      % The following is a macro because \theCurr@Page and
      % \thepageof@pagepoints might differ by more than 1:
      \increment@pageof@pagepoints
      % The following label is so that we can make the page
      % numbers in a grade table indexed by page into \pageref's
      % so that \usepackage{hyperref} and pdflatex will
      % make them clickable:
      \label{firstpoints@onpage@\arabic{Curr@Page}}%
    \else
      % These points go on the same page as the points
      % currently counted in @pagepoints:
      \add@hlfcntrtohlfcntr{@pagepoints}{latest@points}%
      \set@hlfcntr{latest@points}{0}%
    \fi
  \fi
  \ifhlfcntr@pos{latest@bonuspoints}%
    % We're putting a question (or part, etc.)
    % with bonus points onto this page: 
    \ifnum \theCurr@Page > \thepageof@pagebonuspoints\relax
      % These bonus points go on a later page than
      % the points currently counted in @pagebonuspoints:
      \ifnum \thepageof@pagebonuspoints = 0\relax
        % Do nothing...
      \else
        \immediate\write\@mainaux
          {\string\gdef\string\bonuspointsonpage@
           \romannumeral \csname c@pageof@pagebonuspoints\endcsname
             {\prtaux@hlfcntr{@pagebonuspoints}}}%
        % See if this has changed from the last run of LaTeX:
        \CheckIfChanged@hlf{@pagebonuspoints}%
                           {bonuspointsonpage@\romannumeral
                            \csname c@pageof@pagebonuspoints\endcsname}%
      \fi
      % The following is a macro because \theCurr@Page and
      % \thepageof@pagebonuspoints might differ by more than 1:
      \increment@pageof@pagebonuspoints
      % The following label is so that we can make the page
      % numbers in a bonus grade table indexed by page into \pageref's
      % so that \usepackage{hyperref} and pdflatex will
      % make them clickable:
      \label{firstbonuspoints@onpage@\arabic{Curr@Page}}%
    \else
      % These points go on the same page as the points
      % currently counted in @pagebonuspoints:
      \add@hlfcntrtohlfcntr{@pagebonuspoints}{latest@bonuspoints}%
      \set@hlfcntr{latest@bonuspoints}{0}%
    \fi
  \fi
}% pagepoint@commands
\def\increment@pageof@pagepoints{%
  \addtocounter{pageof@pagepoints}{1}%
  \ifnum \theCurr@Page > \thepageof@pagepoints\relax
    \immediate\write\@mainaux
        {\string\gdef\string\pointsonpage@
         \romannumeral \csname c@pageof@pagepoints\endcsname{0}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{pointsonpage@\romannumeral
                        \csname c@pageof@pagepoints\endcsname}
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral 
                  \csname c@pageof@pagepoints\endcsname\endcsname}%
        \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
        \def\pt@check{0}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
    \let\next@incr@pageof = \increment@pageof@pagepoints
  \else
    \copy@hlfcntr{@pagepoints}{latest@points}%
    \set@hlfcntr{latest@points}{0}%
    % \page@withpoints will be used to find the last
    % page that has points, which will be written to
    % the .aux file via \AtEndDocument:
    \global\edef\page@withpoints{\thepageof@pagepoints}%
    \let\next@incr@pageof = \relax
  \fi
  \next@incr@pageof
}% increment@pageof@pagepoints
\def\increment@pageof@pagebonuspoints{%
  \addtocounter{pageof@pagebonuspoints}{1}%
  \ifnum \theCurr@Page > \thepageof@pagebonuspoints\relax
    \immediate\write\@mainaux
        {\string\gdef\string\bonuspointsonpage@
         \romannumeral \csname c@pageof@pagebonuspoints\endcsname{0}}%
    % See if this has changed from the last run of LaTeX:
    \@ifundefined{bonuspointsonpage@\romannumeral
                        \csname c@pageof@pagebonuspoints\endcsname}
      {\global\@pointschangedtrue}%
      {%
      % OK; it's defined.  See if it's changed:
      \begingroup
        \set@hlfcntr{tmp@hlfcntr}{\csname bonuspointsonpage@\romannumeral 
                  \csname c@pageof@pagebonuspoints\endcsname\endcsname}%
        \edef\othpt@check{\prtaux@hlfcntr{tmp@hlfcntr}}%
        \def\pt@check{0}%
        \ifx \pt@check \othpt@check
          % Do nothing
        \else
          \global\@pointschangedtrue
        \fi
      \endgroup
      }%
    \let\next@incr@pageof = \increment@pageof@pagebonuspoints
  \else
    \copy@hlfcntr{@pagebonuspoints}{latest@bonuspoints}%
    \set@hlfcntr{latest@bonuspoints}{0}%
    % \page@withbonuspoints will be used to find the last
    % page that has bonus points, which will be written to
    % the .aux file via \AtEndDocument:
    \global\edef\page@withbonuspoints{\thepageof@pagebonuspoints}%
    \let\next@incr@pageof = \relax
  \fi
  \next@incr@pageof
}% increment@pageof@pagebonuspoints






\def\@checkqueslevel#1{%
  \begingroup
    \def\@temp{#1}%
    \ifx\@temp\@queslevel
      % Everything's fine; do nothing.
    \else
      \ClassError{exam}{%
        I found a #1 where I expected to find a
        \@queslevel\MessageBreak
      }{%
        Both #1 and \@queslevel \space can be used only inside the
        correct \MessageBreak \space \space
        environment and outside of any smaller environment
        \MessageBreak
      }%
    \fi
  \endgroup
}

\def\@doitem{\@ifnextchar[{\@readpoints}%
                          {\item@points@pageinfo}%
}

\def\@readpoints[#1]{%
% We use \def for \@points instead of \edef because we don't want
% \half (if present) to be expanded yet, so that the command \points
% can figure out how to deal with it:
  \def\@points{#1}%
  \global \@placepointstrue
  \if@addpoints
    \if@bonus
      \addto@hlfcntr{numbonuspoints}{\@points}%
      \addto@hlfcntr{bonuspointsof@thisquestion}{\@points}%
      % latest@bonuspoints is a holding area for bonus points to be
      % added to @pagepoints after we check whether they're
      % on the same page as the points currently counted
      % by @pagepoints:
      \addto@hlfcntr{latest@bonuspoints}{\@points}%
    \else
      \addto@hlfcntr{numpoints}{\@points}%
      \addto@hlfcntr{pointsof@thisquestion}{\@points}%
      % latest@points is a holding area for points to be
      % added to @pagepoints after we check whether they're
      % on the same page as the points currently counted
      % by @pagepoints:
      \addto@hlfcntr{latest@points}{\@points}%
    \fi
  \fi
  \item@points@pageinfo
}




% Bug fix, 5 April 2004: \item@points@pageinfo
% Appending \point@toks and \pageinfo@commands to \everypar:
% Instead of appending the contents of \point@toks and
% \pageinfo@commands to \everypar using \append@toklist,
% we instead want to append only the two tokens
%   \the\point@toks
% and the two tokens
%   \the\pageinfo@commands
% to \everypar.  We need to do this because if a questions environment
% immediately follows a \section command, then @nobreak will be true,
% and so the \if@nobreak inside of \everypar will *not* execute the
% \everypar={} that we had been counting on to keep the points from
% being inserted a second time in the second paragraph of a question.
% Since we've put the command \global \point@toks={} inside of 
% \point@toks and the command \pageinfo@commands={} inside of
% \pageinfo@commands, when the contents of \point@toks and of
% \pageinfo@commands are executed (when we enter horizontal mode and
% \everypar is dumped in), the contents of \point@toks and
% \pageinfo@commands will be made empty, and so if
% the second paragraph also gets \the\point@toks and
% \the\pageinfo@commands, it won't matter.

\def\item@points@pageinfo{%
  \item
  % Also: We need to do this here, *after* the \item command, rather
  % than inside the macro \@readpoints, because the \item command
  % puts the result of the \qformat command into an \hbox (with the
  % command ``\sbox\@tempboxa{\makelabel{#1}}%''), expanding the
  % argument of \qformat as it does so.  Thus, @placepoints will be
  % true when the argument of \qformat is expanded, and so if the
  % user put a \thepoints command inside that argument it will
  % correctly expand to the number of points.  (When @placepoints is
  % false, \thepoints expands to nothing at all).
  %
  % We also want to define \padded@point@block when @placepoints is
  % true even if qformat and bonusqformat are true just in case the
  % user, for some deranged reason, says \droppoints immediately
  % following a \question.
  %
  \if@placepoints
    % Since we want the user to be able to say \thepoints in the
    % argument to a \pointformat command, we need \@placepointstrue
    % when \point@block is expanded so that \thepoints will actually
    % print something.  (After setting up \point@toks, we do
    % \@placepointsfalse, but \point@block isn't actually expanded
    % until we enter horizontal mode.)  Thus, we define
    % \padded@point@block, and use that instead of \point@block.  We
    % put  \begingroup and \endgroup around this to confine the
    % effect of \@placepointstrue and also to confine the effect of
    % any declarations like, e.g., \bfseries that the user might put
    % in the argument of a \pointformat command.
    %
    % Note: We first tried using an \edef to expand \point@block right
    % here, while @placepoints is true, but that causes problems if
    % the user puts a \boldmath declaration in the argument of a
    % \pointformat command.  Apparently, expanding \boldmath (without 
    % executing anything) gives you bunches of undefined control
    % sequence errors.
    \if@bonus
      \def\padded@point@block{%
        \begingroup
          \@placepointstrue
          \bonuspoint@block
        \endgroup
      }%
    \else
      \def\padded@point@block{%
        \begingroup
          \@placepointstrue
          \point@block
        \endgroup
      }%
    \fi
    % \setup@point@toks puts commands into \point@toks to place
    % \padded@point@block at the correct spot.  It doesn't append
    % anything to \everypar (we do that in this macro, below). 
    %
    % If @qformat is true, and if we're currently doing a question (or
    % if @bonusqformat is true and we're doing a bonusquestion)
    % (rather than a part, subpart, or subsubpart), then we don't want
    % to set the points (if any), since the points of a question will
    % appear only if the user chooses to cause that by putting a
    % \thepoints in the argument of the \qformat command.
    \if@pointsdropped
      % Do nothing!
    \else
      \if@bonus
        \if@bonusqformat
          \ifx\ques@ref\@queslevel
            % Do nothing
          \else
            \setup@point@toks
          \fi
        \else
          \setup@point@toks
        \fi
      \else
        \if@qformat
          \ifx\ques@ref\@queslevel
            % Do nothing
          \else
            \setup@point@toks
          \fi
        \else
          \setup@point@toks
        \fi
      \fi
    \fi
    \global \@placepointsfalse
  \fi
  % We *don't* use \append@toklist; see the Bug fixnote above
  % (Bug fix, 5 April 2004).
  % We can append the tokens ``\the\point@toks'' whether or not we're
  % setting any points because if we're not setting them, \point@toks
  % will be empty.
  % Also: It's important to do this *after* the \item command above,
  % since the \item command discards the previous contents of
  % \everypar.
  % Version 2.218$\beta$, 2007/10/31 changes:
  % Instead of appending
  %   \the \pageinfo@commands \the \point@toks
  % to \everypar, we insert them into the box \@labels.  This corrects
  % the problem that arose when a question (or part, etc.) begins with
  % a list environment (including verbatim, flushleft, center,
  % flushright, and possibly others that are implemented as trivlist
  % environments).  The \item command in those environments throws
  % away the previous contents of \everypar, and so the tokens \the
  % \pageinfo@commands \the \point@toks didn't get inserted where we
  % expected.  List environments *do* preserve the contents of the box
  % \@labels, though.
  \global\setbox\@labels\hbox{\unhbox\@labels
    \the \pageinfo@commands
    \the \point@toks}%
  %   \edef\append@everypar{\noexpand\everypar={\the\everypar
  %                         \noexpand\the \noexpand\pageinfo@commands
  %                         \noexpand\the \noexpand\point@toks}}%
  %   \append@everypar
}







% Initialize \@points:
% (The only reason I think this is necessary is in case the user uses
% a \qformat command, puts \themarginpoints into the format (which is
% *not* the intended use of \themarginpoints), and then doesn't have
% any points for the first question.)
\def\@points{0}


\def\setup@point@toks{%
% We set the token list \point@toks equal to the sequence of commands
% needed to put \padded@point@block at the correct location, followed by the
% tokens ``\global \point@toks={}''.  The \question, \part, \subpart,
% or \subsubpart command then adds the two tokens ``\the\point@toks''
% to \everypar.
%
% Note: It is not the *contents* of \point@toks that is added to
% \everypar; just the two tokens ``\the\point@toks''.  This difference
% is the bug fix of 2 April 2004, described above (the bug was that in
% earlier versions, we used to append the contents).
%
% The result of this is that whenever we finally enter horizontal mode
% (because we finally encountered the text of a question, part,
% subpart, or subsubpart) the contents of \point@toks will be dumped
% into horizontal mode and executed, and so the points will be placed
% and the token list \point@toks will be set to empty.  Thus, in the
% occasional circumstances in which \everypar is *not* set to empty
% after being added to the first paragraph (which occurs when a
% questions environment immediately follows a \section command), and
% so \everypar will still contain ``\the\point@toks'' when it
% encounters a possible second paragraph of the first question, the
% tokens ``\the\point@toks'' will insert an *empty* token list, which
% will do no harm.
%
  \if@pointsinleftmargin
    \point@toks={%
          \llap{\padded@point@block 
                \hskip\@totalleftmargin
                \hskip\marginpointssep
          }%
          \global \point@toks={}%
    }%
  \else
    \if@pointsinrightmargin
      \point@toks={%
            \rlap{\hskip-\@totalleftmargin
                  \hskip\textwidth
                  \hskip\@rightmargin
                  \hskip-\rightpointsmargin
                  \llap{\padded@point@block}%
            }%
            \global \point@toks={}%
      }%
    \else
      % The points just go after the question number:
      \point@toks={%
            \padded@point@block
            \enspace
            \global \point@toks={}%
      }%
    \fi
  \fi
}% setup@point@toks



\def\droppoints{%
  \leavevmode\unskip\nobreak\hfill
  \rlap{\hskip\rightmargin  % Defined by the list environment
        \hskip\@rightmargin % Defined by exam.cls
        \hskip-\rightpointsmargin
        \llap{\padded@point@block}%
  }% rlap
  \par
}


\def\droptotalpoints{%
  \leavevmode\unskip\nobreak\hfill
  \rlap{\hskip\rightmargin  % Defined by the list environment
        \hskip\@rightmargin % Defined by exam.cls
        \hskip-\rightpointsmargin
        \llap{\total@block}%
  }% rlap
  \par
}% droptotalpoints
\def\droptotalbonuspoints{%
  \leavevmode\unskip\nobreak\hfill
  \rlap{\hskip\rightmargin  % Defined by the list environment
        \hskip\@rightmargin % Defined by exam.cls
        \hskip-\rightpointsmargin
        \llap{\bonustotal@block}%
  }% rlap
  \par
}% droptotalbonuspoints

% The following is the default definition;
% it can be changed by a \totalformat command.
\def\total@block{%
  Total for Question \thequestion: \totalpoints\@marginpointname
}% total@block
\def\bonustotal@block{%
  Total for Question \thequestion: \totalbonuspoints\@marginbonuspointname
}% bonustotal@block

\def\totalformat#1{%
  \gdef\total@block{\begingroup #1\endgroup}%
}% totalformat
\def\bonustotalformat#1{%
  \gdef\bonustotal@block{\begingroup #1\endgroup}%
}% bonustotalformat
% The following is for use in the argument to a \totalformat command:
\def\totalpoints{\pointsofquestion{\arabic{question}}}
\def\totalbonuspoints{\bonuspointsofquestion{\arabic{question}}}



% @placepoints is set true when we encounter a question (or part, etc.)
% that has points.  It is set to false (1) when we set \point@toks equal
% to the sequence of commands required to put the properly formatted
% points onto the page (this happens only if @qformat is false or if
% @qformat is true but we're not doing a question), or (2) by a
% \question command or entering a parts environment (since if we're
% doing a question and @qformat is true, we need to leave @placepoints
% true so that the \thepoints command can tell if it should expand to
% points or to nothing, and encountering a \question command or parts
% environment tells us that we no longer have to deal with a possible
% \thepoints, since we won't be expanding a qformat).
\newif\if@placepoints
\@placepointsfalse


% \marginpointssep will be used if the user says
% \pointsinleftmargin.  It will be the distance from whatever encloses
% the points (parentheses, brackets, or a box) to the left margin:
\newlength\marginpointssep
\setlength{\marginpointssep}{5pt}

% \rightpointsmargin will be used if the user says \pointsinrightmargin.
% It will be the distance from whatever encloses the point (parentheses,
% brackets, or a box) to the right edge of the paper:
\newlength\rightpointsmargin
\setlength{\rightpointsmargin}{1cm}


\newif\if@pointsdropped
\newif\if@pointsinleftmargin
\newif\if@pointsinrightmargin
\def\pointsinleftmargin{\global\@pointsinleftmargintrue 
                    \global\@pointsinrightmarginfalse
                    \global\@pointsdroppedfalse
                    \gdef\pt@name{\@marginpointname}%
                    \gdef\bnspt@name{\@marginbonuspointname}}
\def\pointsinrightmargin{\global\@pointsinrightmargintrue
                         \global\@pointsinleftmarginfalse
                         \global\@pointsdroppedfalse
                         \gdef\pt@name{\@marginpointname}%
                         \gdef\bnspt@name{\@marginbonuspointname}}
\def\nopointsinmargin{\global\@pointsinleftmarginfalse
                      \global\@pointsinrightmarginfalse
                      \global\@pointsdroppedfalse
                      \gdef\pt@name{\@pointname}%
                      \gdef\bnspt@name{\@bonuspointname}}
\def\pointsdroppedatright{\global\@pointsdroppedtrue
                          \global\@pointsinleftmarginfalse
                          \global\@pointsinrightmarginfalse
                          \gdef\pt@name{\@marginpointname}%
                          \gdef\bnspt@name{\@marginbonuspointname}}
\let\pointsinmargin\pointsinleftmargin
\let\nopointsinrightmargin\nopointsinmargin
\let\nopointsinleftmargin\nopointsinmargin

\nopointsinmargin


% Will the points be displayed inside parentheses (the default), or
% will they be boxed or bracketed, or customized using pointformat:
\def\boxedpoints{%
  \gdef\point@block{\fbox{\@points\pt@name}}%
  \gdef\bonuspoint@block{\fbox{\@points\bnspt@name}}%
}
\def\noboxedpoints{%
  \gdef\point@block{(\@points\pt@name)}%
  \gdef\bonuspoint@block{(\@points\bnspt@name)}%
}
\def\bracketedpoints{%
  \gdef\point@block{[\@points\pt@name]}%
  \gdef\bonuspoint@block{[\@points\bnspt@name]}%
}
\let\nobracketedpoints=\noboxedpoints

\def\pointformat#1{%
  % We don't have to worry about the user putting things
  % like \bfseries, etc. into \point@block, because
  % \padded@point@block encloses \point@block in a group,
  % which confines the effects of anything here:
  \gdef\point@block{#1}%
}

\def\bonuspointformat#1{%
  % We don't have to worry about the user putting things
  % like \bfseries, etc. into \point@block, because
  % \padded@point@block encloses \point@block in a group,
  % which confines the effects of anything here:
  \gdef\bonuspoint@block{#1}%
}
\def\thebonuspoints{\@points \@bonuspointname}

%Initialize:
\noboxedpoints




\def\pointname#1{\gdef\@pointname{#1}}
\def\bonuspointname#1{\gdef\@bonuspointname{#1}}
% Initialize to leave a space, and then the word `points':
%%\pointname{ points}
% The following improvement was contributed by 
% Mate Wierdl <mw@wierdlmpc.msci.memphis.edu> 
% If the number of points is ``1'', then the default value of
% \pointname will print `` point'' instead of `` points'' (and this
% version of the command doesn't generate an error message if the
% points entry is something other than a number):
% Note the space before the \points in the following; it's
% intentional!)
\pointname{ \points}
\bonuspointname{ \bonuspoints}
\newcommand\point@sing{point}
\newcommand\point@plur{points}
\newcommand\pointpoints[2]{%
  \renewcommand\point@sing{#1}%
  \renewcommand\point@plur{#2}%
}
%\newcommand\bonuspoint@sing{bonus point}
%\newcommand\bonuspoint@plur{bonus points}
\newcommand\bonuspoint@sing{point (bonus)}
\newcommand\bonuspoint@plur{points (bonus)}
\newcommand\bonuspointpoints[2]{%
  \renewcommand\bonuspoint@sing{#1}%
  \renewcommand\bonuspoint@plur{#2}%
}



% The command \points:
% We use \ifthenelse and \equal so that if the user types something
% other than a legit point value, there still won't be any error
% messages.  We rig it so that if the point value looks like it's
% intended to be One or one or ONE, or some strange way of attempting
% one half, then it will expand to the singular value.  Alas, this is
% only useful for English, but I'm hoping few or no users will try doing
% this anyway.

% 0 points, one half point, 1 point, 1 and a half points, etc.:
\newcommand\points{%
  \begingroup
    \let\half=\relax
    \edef\pt@string{\@points}%
    \ifthenelse{\equal{\pt@string}{1} \or \equal{\pt@string}{\half}}
          {\point@sing}{\point@plur}%
  \endgroup
}% \points
\newcommand\bonuspoints{%
  \begingroup
    \let\half=\relax
    \edef\pt@string{\@points}%
    \ifthenelse{\equal{\pt@string}{1} \or \equal{\pt@string}{\half}}
          {\bonuspoint@sing}{\bonuspoint@plur}%
  \endgroup
}% \bonuspoints
%\newcommand\points{%
%  \begingroup
%    \let\half=\relax
%    \edef\pt@string{\@points}%
%    \ifthenelse{\equal{\pt@string}{1} \or \equal{\pt@string}{\half} \or
%      \equal{\pt@string}{0\half} \or \equal{\pt@string}{0 \half}
%      \equal{\pt@string}{one} \or \equal{\pt@string}{One} \or
%      \equal{\pt@string}{ONE}}
%        {\point@sing}{\point@plur}%
%  \endgroup
%}

%\newcommand\points{\ifthenelse{\equal{\@points}{1}}{\point@sing}{\point@plur}}
% If we used the following line instead, then you'd get an error
% message if the point value contained something other than a valid
% integer:
%\pointname{ \ifthenelse{\@points = 1}{point}{points}}

% We used to define a command named \marks that works like \points,
% except that it expands to either ``mark'' or ``marks'', but that
% conflicts with some package or other.  Thus, we'll implement
% \marksnotpoints using the \pointpoints command instead:
\newcommand\marksnotpoints{%
  \pointpoints{mark}{marks}%
  \bonuspointpoints{mark (bonus)}{marks (bonus)}%
}% \marksnotpoints


% \@marginpointname is used in place of \@pointname if any of
% \@pointsinmargin, \@pointsinrightmargin, and \@pointsdropped are
% true:
\def\marginpointname#1{\gdef\@marginpointname{#1}}
\marginpointname{}
\def\marginbonuspointname#1{\gdef\@marginbonuspointname{#1}}
\marginbonuspointname{ (bonus)}


%--------------------------------------------------------------------
%         choices (for multiple choice) and checkboxes


\renewcommand\thechoice{\Alph{choice}}
\newcommand\choicelabel{\thechoice.}

% We will have \@correctchoicetrue when we're printing solutions
% and we're printing the correct choice of a choices or
% oneparchoices environment.
% We'll say \begingroup before saying \@correctchoicetrue
% and we'll say \endgroup at either the next \choice or \correctchoice
% or the end of the choices or oneparchoices environment.
% Thus, we'll never again need to say \@correctchoicefalse
\newif\if@correctchoice
\@correctchoicefalse

\newcommand\CorrectChoiceEmphasis[1]{%
  \def\CorrectChoice@Emphasis{#1}%
}
\CorrectChoiceEmphasis{\bfseries}
\let\correctchoiceemphasis\CorrectChoiceEmphasis

% Note: \do@choice@pageinfo is used in both the choices and
% the checkboxes environments.
\newtoks\choice@toks
\def\do@choice@pageinfo{%
  \choice@toks={%
    \questionobject@pluspagecheck
    \choice@toks={}%
  }%
  % Version 2.217-beta changes:
  % Instead of appending stuff to \everypar, we insert
  % \the \pageinfo@commands and \the \point@toks 
  % into the box \@labels:
  \global\setbox\@labels\hbox{\unhbox\@labels
    \the \choice@toks}%
  %   \edef\append@everypar{\noexpand\everypar={\the\everypar
  %                         \noexpand\the \noexpand\choice@toks}}%
  %   \append@everypar
}% do@choice@pageinfo



% Added 22 April 2004: Increased the \leftmargin by 2.5em,
% so the choices will be visibly indented.
\newenvironment{choices}%
  {\list{\choicelabel}%
     {\usecounter{choice}\def\makelabel##1{\hss\llap{##1}}%
       \settowidth{\leftmargin}{W.\hskip\labelsep\hskip 2.5em}%
       \def\choice{%
         \if@correctchoice
           \endgroup
         \fi
         \item
         \do@choice@pageinfo
       } % choice
       \def\CorrectChoice{%
         \if@correctchoice
           \endgroup
         \fi
         \ifprintanswers
           % We can't say \choice here, because that would
           % insert an \endgroup:
           \begingroup \@correctchoicetrue
           \CorrectChoice@Emphasis
         \fi
         \item
         \do@choice@pageinfo
       } % CorrectChoice
       \let\correctchoice\CorrectChoice
       \labelwidth\leftmargin\advance\labelwidth-\labelsep
       \topsep=0pt
       \partopsep=0pt
       \choiceshook
     }%
  }%
  {\if@correctchoice \endgroup \fi \endlist}

\newenvironment{oneparchoices}%
  {%
    \setcounter{choice}{0}%
    \def\choice{%
      \if@correctchoice \endgroup \fi
      \refstepcounter{choice}%
      \ifnum\value{choice}>1\relax
        \penalty -50\hskip 1em plus 1em\relax
      \fi
      \choicelabel
      % No need to put the following into a token string; we just put
      % the choicelabel onto the page, so we're at the spot whose page
      % number we want to record:
      \questionobject@pluspagecheck
      \nobreak\enskip
    }% choice
    \def\CorrectChoice{%
      \if@correctchoice \endgroup \fi
      \refstepcounter{choice}%
      \ifprintanswers
        \begingroup \@correctchoicetrue 
        \CorrectChoice@Emphasis
      \fi
      \ifnum\value{choice}>1\relax
        \penalty -50\hskip 1em plus 1em\relax
      \fi
      \choicelabel
      % No need to put the following into a token string; we just put
      % the choicelabel onto the page, so we're at the spot whose page
      % number we want to record:
      \questionobject@pluspagecheck
      \nobreak\enskip
    }% CorrectChoice
    \let\correctchoice\CorrectChoice
    \let\par\@empty
    % If we're continuing the paragraph containing the question,
    % then leave a bit of space before the first choice:
    \ifvmode\else\enskip\fi
    \ignorespaces
  }%
  {\if@correctchoice \endgroup \fi}

\newcommand{\checkboxchar}[1]{\def\checkbox@char{#1}}
\newcommand{\checkedchar}[1]{\def\checked@char{#1}}
\checkboxchar{$\bigcirc$}
\checkedchar{$\surd$}

\newenvironment{checkboxes}%
  {\list{\checkbox@char}%
     {%
       \settowidth{\leftmargin}{W.\hskip\labelsep\hskip 2.5em}%
       \def\choice{%
         \if@correctchoice
           \endgroup
         \fi
         \item
         \do@choice@pageinfo
       } % choice
       \def\CorrectChoice{%
         \if@correctchoice
           \endgroup
         \fi
         \ifprintanswers
           % We can't say \choice here, because that would
           % insert an \endgroup:
           \begingroup \@correctchoicetrue
           \CorrectChoice@Emphasis
           \item[\checked@char]
         \else
           \item
         \fi
         \do@choice@pageinfo
       } % CorrectChoice
       \let\correctchoice\CorrectChoice
       \labelwidth\leftmargin\advance\labelwidth-\labelsep
       \topsep=0pt
       \partopsep=0pt
       \checkboxeshook
     }%
  }%
  {\if@correctchoice \endgroup \fi \endlist}

\newenvironment{oneparcheckboxes}%
  {%
    % Although we're not printing numbers for the choices, we use the
    % choice counter to keep track of whether a choice is the first
    % one (in which case we don't leave any additional space) or a
    % later one (in which case we do leave additional space):    
    \setcounter{choice}{0}%
    \def\choice{%
      \if@correctchoice \endgroup \fi
      \stepcounter{choice}%
      \ifnum\value{choice}>1\relax
        \penalty -50\hskip 1em plus 1em\relax
      \fi
      \checkbox@char
      % No need to put the following into a token string; we just put
      % \checkbox@char onto the page, so we're at the spot whose page
      % number we want to record:
      \questionobject@pluspagecheck
      \nobreak\enskip
    }% choice
    \def\CorrectChoice{%
      \if@correctchoice \endgroup \fi
      \stepcounter{choice}%
      \ifprintanswers
        \begingroup \@correctchoicetrue 
        \CorrectChoice@Emphasis
      \fi
      \ifnum\value{choice}>1\relax
        \penalty -50\hskip 1em plus 1em\relax
      \fi
      \ifprintanswers
        \checked@char
      \else
        \checkbox@char
      \fi
      % No need to put the following into a token string; we just put
      % the choicelabel onto the page, so we're at the spot whose page
      % number we want to record:
      \questionobject@pluspagecheck
      \nobreak\enskip
    }% CorrectChoice
    \let\correctchoice\CorrectChoice
    \let\par\@empty
    % If we're continuing the paragraph containing the question,
    % then leave a bit of space before the first choice:
    \ifvmode\else\enskip\fi
    \ignorespaces
  }%
  {\if@correctchoice \endgroup \fi}


%--------------------------------------------------------------------
%             Answer Lines (for short answer questions)

% Note: \ques@ref is also used in \item@points@pageinfo

\def\ques@ref{question}
\def\part@ref{part}
\def\subpart@ref{subpart}
\def\subsubpart@ref{subsubpart}

\newlength\answerlinelength
\newlength\answerskip
\newlength\answerclearance
\setlength\answerlinelength{1in}
\setlength\answerskip{2ex}
\setlength\answerclearance{0.2ex}

\newcommand\answerline[1][{}]{%
  % One optional argument, the default value of which is empty.
  \ifx\@queslevel\ques@ref
    \let\ans@l=\questionlabel
  \else
    \ifx\@queslevel\part@ref
      \let\ans@l=\partlabel
    \else
      \ifx\@queslevel\subpart@ref
        \let\ans@l=\subpartlabel
      \else
        \ifx\@queslevel\subsubpart@ref
          \let\ans@l=\subsubpartlabel
        \else
          % Oops; no question level defined.
          % We must be outide of the questions environment.
          % Just leave out the label, I guess:
          \def\ans@l{}%
        \fi
      \fi
    \fi
  \fi
  \par \nobreak \vskip \answerskip
  \hfill 
  \ifprintanswers
    \ans@l~\hbox to 0pt{\hbox to \answerlinelength{\hrulefill}\hss}%
    \raise \answerclearance\hbox to \answerlinelength{%
      \CorrectChoice@Emphasis \hfil #1\hss}%
  \else
    \ans@l~\hbox to \answerlinelength{\hrulefill}%
  \fi
  \par
}% answerline

%--------------------------------------------------------------------
%                            \fillwithlines


% \fillwithlines takes one argument, which is either a length or \fill,
% and it fills that much vertical space with horizontal lines that run
% the length of the current line.  That is, they extend from the
% current left margin (which depends on whether we're in a question,
% part, subpart, or subsubpart) to the right margin.
%
% The distance between the lines is \linefillheight, whose default value
% is set with the command
%
% \setlength\linefillheight{.25in}
%
% This value can be changed by giving a new \setlength command.
%
% The thickness of the lines is \linefillthickness, whose default value
% is set with the command
%
% \setlength\linefillthickness{.1pt}
%
% This value can be changed by giving a new \setlength command.


\newlength\linefillheight
\newlength\linefillthickness
\setlength\linefillheight{.25in}
\setlength\linefillthickness{0.1pt}

\newcommand\linefill{\leavevmode
    \leaders\hrule height \linefillthickness \hfill\kern\z@}


\def\fillwithlines#1{%
  \begingroup
  \ifhmode
    \par
  \fi
  \hrule height \z@
  \nobreak
  \setbox0=\hbox to \hsize{\hskip \@totalleftmargin
          \vrule height \linefillheight depth \z@ width \z@
          \linefill}%
  % We use \cleaders (rather than \leaders) so that a given
  % vertical space will always produce the same number of lines
  % no matter where on the page it happens to start:
  \cleaders \copy0 \vskip #1 \hbox{}%
  \endgroup
}

%--------------------------------------------------------------------
%                         \fillwithdottedlines


% \fillwithdottedlines is similar to \fillwithlines, except that it
% fills the space with dotted lines (created by \dotfill) rather than
% with solid lines.

% \fillwithdottedlines takes one argument, which is either a length or
% \fill, and it fills that much vertical space with dotted lines that
% run the length of the current line.  That is, they extend from the
% current left margin (which depends on whether we're in a question,
% part, subpart, or subsubpart) to the right margin.
%
% The distance between the lines is \dottedlinefillheight, whose
% default value is set with the command
%
% \setlength\dottedlinefillheight{.25in}
%
% This value can be changed by giving a new \setlength command.

\newlength\dottedlinefillheight
\setlength\dottedlinefillheight{.25in}

\def\fillwithdottedlines#1{%
  \begingroup
  \ifhmode
    \par
  \fi
  \hrule height \z@
  \nobreak
  \setbox0=\hbox to \hsize{\hskip \@totalleftmargin
          \vrule height \dottedlinefillheight depth \z@ width \z@
          \dotfill}%
  % We use \cleaders (rather than \leaders) so that a given
  % vertical space will always produce the same number of lines
  % no matter where on the page it happens to start:
  \cleaders \copy0 \vskip #1 \hbox{}%
  \endgroup
}

%--------------------------------------------------------------------
%                            \makeemptybox

% \makeemptybox takes one argument, which is a length, and it creates
% an empty box of width the length of the current line and of height
% equal to the argument. That is, the box extends from the current
% left margin (which depends on whether we're in a question, part,
% subpart, or subsubpart) to the right margin.

% As of version 2.304, the argument of \makeemptybox can be either
% a length, or \fill, or \stretch{number}.

% \newcommand\makeemptybox[1]{
%   \par
%   \begingroup
%     \setlength{\fboxsep}{0pt}%
%     \framebox[\linewidth]{%
%       \vrule height 0pt depth #1 width 0pt
%     }%
%   \endgroup
% }

\newlength\minboxheight
\setlength\minboxheight{.1in}

\newcommand\makeemptybox[1]{%
  \par
  \hbox to \hsize{\hskip\@totalleftmargin \leaders\hrule\hfill}%
  \nointerlineskip
  \begingroup
    \setbox0=\hbox to \hsize{\hskip\@totalleftmargin
                           \vrule height\minboxheight \hfill \vrule}%
    % The vertical size desired may not be an exact multiple of
    % \minboxheight, and so \cleaders might leave a gap between the
    % vertical lines and the horizontal lines above and below it.
    % Thus, we put a single copy of \box0 immediately below the
    % horizontal line above and we'll also put a single copy of \box0
    % immediately above the horizontal line below.
    \copy0
    \nobreak
    \vskip -\minboxheight
    \cleaders \copy0 \vskip #1
    \vskip -\minboxheight
    \nointerlineskip
    \copy0
  \endgroup
  \nointerlineskip
  \hbox to \hsize{\hskip\@totalleftmargin \leaders\hrule\hfill}%
}

%--------------------------------------------------------------------
%                      \uplevel and \fullwidth
%           and the EnvUplevel and EnvFullwidth environments:

% \uplevel is used to print text at the indentation level of the 
% enclosing environment.  For example, to precede a question with
% directions about how that question should be answered, you would
% say \uplevel{Answer this question correctly.}
% 
% \fullwidth is similar, but uses the full page of text on the page.

% The EnvUplevel environment is similar to the \uplevel command, but it
% has the advantage that you can include verbatim material (using, e.g.,
% the \verb command) in the environment.  (You can't include verbatim
% material in the argument of an \uplevel command.)

% The EnvFullwidth environment is similar to the \fullwidth command, but
% it has the advantage that you can include verbatim material (using,
% e.g., the \verb command) in the environment.  (You can't include
% verbatim material in the argument of an \fullwidth command.)


\long\def\uplevel#1{%
  \par\bigskip
  \vbox{%
    % We entered internal vertical mode, and so we get \parshape=0.
    % We set \leftskip to provide the correct left margin for whatever
    % is in the argument of the \uplevel command:
    \leftskip=\@totalleftmargin
    \advance\leftskip-\leftmargin
    % We adjust \@totalleftmargin and linewidth in case there's a
    % solution environment inside of the argument to the \uplevel:
    \advance\@totalleftmargin-\leftmargin
    \advance\linewidth\leftmargin
    #1%
  }% vbox
  \nobreak
}

\newenvironment{EnvUplevel}
  {\par\bigskip\vbox\bgroup
    % We set \leftskip to provide the correct left margin for whatever
    % is inside of the environment:
    \leftskip=\@totalleftmargin
    \advance\leftskip-\leftmargin
    % We adjust \@totalleftmargin (and linewidth?) in case there's a
    % solution environment inside of the environment:
    \advance\@totalleftmargin-\leftmargin
    \advance\linewidth\leftmargin
  }
  {\egroup\nobreak}


\long\def\fullwidth#1{%
  \par\bigskip
  \vbox{%
    % We entered internal vertical mode, and so we get \parshape=0.
    \leftskip=0pt \rightskip=0pt
    \advance\linewidth\@totalleftmargin
    \@totalleftmargin=0pt
    #1%
  }% vbox
  \nobreak
}

\newenvironment{EnvFullwidth}
  {\par\bigskip\vbox\bgroup
    % We entered internal vertical mode, and so we get \parshape=0.
    \leftskip=0pt \rightskip=0pt
    % We adjust \@totalleftmargin (and linewidth?) in case there's a
    % solution environment inside of the environment:
    \advance\linewidth\@totalleftmargin
    \@totalleftmargin=0pt
  }
  {\egroup\nobreak}


%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%                        ********************
%                        ** GRADING TABLES **
%                        ********************



\newcounter{@iterator}
\newlength\@cellwidth

\def\cellwidth#1{\@cellwidth=#1}
\def\gradetablestretch#1{\def\@gtblstretch{#1}}

% \settabletotalpoints allows the user to specify a total
% number of points to appear in a table that may be different
% from the sum of the points in the table:
\newcommand\prt@tablepoints{\prt@hlfcntr{tbl@points}}
\newcommand\settabletotalpoints[1]{%
  \def\prt@tablepoints{#1}%
}% \settabletotalpoints

% \settabletotalbonuspoints is similar to \settabletotalpoints:
\newcommand\prt@tablebonuspoints{\prt@hlfcntr{tbl@bonuspoints}}
\newcommand\settabletotalbonuspoints[1]{%
  \def\prt@tablebonuspoints{#1}%
}% \settabletotalbonuspoints

% All of the following that begin with `h' are for horizontal tables,
% and all of them that begin with `v' are for vertical tables:
\def\hqword#1{\def\@hqword{#1}}
\def\hpword#1{\def\@hpword{#1}}
\def\hsword#1{\def\@hsword{#1}}
\def\htword#1{\def\@htword{#1}}
\def\hpgword#1{\def\@hpgword{#1}}

\def\vqword#1{\def\@vqword{#1}}
\def\vpword#1{\def\@vpword{#1}}
\def\vsword#1{\def\@vsword{#1}}
\def\vtword#1{\def\@vtword{#1}}
\def\vpgword#1{\def\@vpgword{#1}}


% The following are the versions for bonusgradetable:
\def\bhqword#1{\def\@bhqword{#1}}
\def\bhpword#1{\def\@bhpword{#1}}
\def\bhsword#1{\def\@bhsword{#1}}
\def\bhtword#1{\def\@bhtword{#1}}
\def\bhpgword#1{\def\@bhpgword{#1}}

\def\bvqword#1{\def\@bvqword{#1}}
\def\bvpword#1{\def\@bvpword{#1}}
\def\bvsword#1{\def\@bvsword{#1}}
\def\bvtword#1{\def\@bvtword{#1}}
\def\bvpgword#1{\def\@bvpgword{#1}}

% The following are the versions for combinedgradetable:
\def\chqword#1{\def\@chqword{#1}}
\def\chpword#1{\def\@chpword{#1}}
\def\chbpword#1{\def\@chbpword{#1}}
\def\chsword#1{\def\@chsword{#1}}
\def\chtword#1{\def\@chtword{#1}}
\def\chpgword#1{\def\@chpgword{#1}}

\def\cvqword#1{\def\@cvqword{#1}}
\def\cvpword#1{\def\@cvpword{#1}}
\def\cvbpword#1{\def\@cvbpword{#1}}
\def\cvsword#1{\def\@cvsword{#1}}
\def\cvtword#1{\def\@cvtword{#1}}
\def\cvpgword#1{\def\@cvpgword{#1}}



% Initialize:
\cellwidth{2em}
\gradetablestretch{1.5}

\hqword{Question:}
\hpgword{Page:}
\hpword{Points:}
\hsword{Score:}
\htword{Total}
\vpword{Points}
\vsword{Score}
\vtword{Total:}
\vqword{Question}
\vpgword{Page}

\bhqword{Question:}
\bhpgword{Page:}
\bhpword{Bonus Points:}
\bhsword{Score:}
\bhtword{Total}
\bvqword{Question}
\bvpgword{Page}
\bvpword{Bonus Points}
\bvsword{Score}
\bvtword{Total:}

\chqword{Question:}
\chpgword{Page:}
\chpword{Points:}
\chbpword{Bonus Points:}
\chsword{Score:}
\chtword{Total}
\cvqword{Question}
\cvpgword{Page}
\cvpword{Points}
\cvbpword{Bonus Points}
\cvsword{Score}
\cvtword{Total:}


% The only commands here accessible to the user are \gradetable,
% \bonusgradetable, \combinedgradetable, \pointtable,
% \bonuspointtable, \combinedpointtable, \partialgradetable,
% \partialbonusgradetable, \partialcombinedtable, \partialpointtable,
% \partialbonuspointtable, \partialcombinedpointtable,
% \begingradingrange, \endgradingrange, \pointsinrange, and
% \bonuspointsinrange.

% The possibilities are

%   \gradetable[v][questions]
%   \gradetable[v][pages]
%   \gradetable[h][questions]
%   \gradetable[h][pages]

%   \bonusgradetable[v][questions]
%   \bonusgradetable[v][pages]
%   \bonusgradetable[h][questions]
%   \bonusgradetable[h][pages]

%   \combinedgradetable[v][questions]
%   \combinedgradetable[v][pages]
%   \combinedgradetable[h][questions]
%   \combinedgradetable[h][pages]

%   \pointtable[v][questions]
%   \pointtable[v][pages]
%   \pointtable[h][questions]
%   \pointtable[h][pages]

%   \bonuspointtable[v][questions]
%   \bonuspointtable[v][pages]
%   \bonuspointtable[h][questions]
%   \bonuspointtable[h][pages]

%   \combinedpointtable[v][questions]
%   \combinedpointtable[v][pages]
%   \combinedpointtable[h][questions]
%   \combinedpointtable[h][pages]

%   \partialgradetable{whatever}[v][questions]
%   \partialgradetable{whatever}[v][pages]
%   \partialgradetable{whatever}[h][questions]
%   \partialgradetable{whatever}[h][pages]

%   \partialbonusgradetable{whatever}[v][questions]
%   \partialbonusgradetable{whatever}[v][pages]
%   \partialbonusgradetable{whatever}[h][questions]
%   \partialbonusgradetable{whatever}[h][pages]

%   \partialcombinedgradetable{whatever}[v][questions]
%   \partialcombinedgradetable{whatever}[v][pages]
%   \partialcombinedgradetable{whatever}[h][questions]
%   \partialcombinedgradetable{whatever}[h][pages]

%   \partialpointtable{whatever}[v][questions]
%   \partialpointtable{whatever}[v][pages]
%   \partialpointtable{whatever}[h][questions]
%   \partialpointtable{whatever}[h][pages]

%   \partialbonuspointtable{whatever}[v][questions]
%   \partialbonuspointtable{whatever}[v][pages]
%   \partialbonuspointtable{whatever}[h][questions]
%   \partialbonuspointtable{whatever}[h][pages]

%   \partialcombinedpointtable{whatever}[v][questions]
%   \partialcombinedpointtable{whatever}[v][pages]
%   \partialcombinedpointtable{whatever}[h][questions]
%   \partialcombinedpointtable{whatever}[h][pages]

%   \begingradingrange{whatever}
%   \endgradingrange{whatever}
%
%   \pointsinrange{whatever}
%   \bonuspointsinrange{whatever}
%
% where ``whatever'' is a label chosen by the user.

% If one or both optional arguments are omitted, the defaults are
% `[v]' and `[questions]'.

% \@scorestrue means we're doing \gradetable
% \@scoresfalse mans we're doing \pointtable
\newif\if@scores

% \@partialtrue means we're doing \partialgradetable,
% \partialbonusgradetable, \partialcombinedgradetable,
% \partialpointtable, \partialbonuspointtable, or
% \partialcombinedpointtable:
\newif\if@partial

% \@combinedtrue means we're doing \combinedgradetable
% or \combinedpointtable:
\newif\if@combined

% It's OK to use the counter num@cols as a scratch counter
% in \begingradingrange and \endgradingrange because
% it's only used in typesetting tables:
\def\begingradingrange#1{%
  \setcounter{num@cols}{\value{question}}%
  \addtocounter{num@cols}{1}%
  \immediate\write\@mainaux
  {\string\expandafter\string\gdef
    \string\csname\space tbl@#1@firstq\string\endcsname
      {\arabic{num@cols}}}%
  \write\@mainaux
  {\string\expandafter\string\gdef
    \string\csname\space tbl@#1@firstp\string\endcsname
      {\thepage}}%
}% begingradingrange

\def\endgradingrange#1{%
  \setcounter{num@cols}{\value{question}}%
  \immediate\write\@mainaux
  {\string\expandafter\string\gdef
    \string\csname\space tbl@#1@lastq\string\endcsname
      {\arabic{num@cols}}}%
  \write\@mainaux
  {\string\expandafter\string\gdef
    \string\csname\space tbl@#1@lastp\string\endcsname
      {\thepage}}%
}% endgradingrange




% Now that grading tables may be for only part of the exam,
% we need the counter tbl@points to add up the total points
% for the questions (or pages) that appear on the table:
\new@hlfcntr{tbl@points}

% We'll use the counter tbl@bonuspoints to add up the total bonus
% points for the questions (or pages) that appear on the table:
\new@hlfcntr{tbl@bonuspoints}


\def\partialgradetable#1{%
  \@scorestrue
  \@bonusfalse
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#1}%
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialgradetable

\def\partialbonusgradetable#1{%
  \@scorestrue
  \@bonustrue
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#1}%
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialbonusgradetable

\def\partialcombinedgradetable#1{%
  \@scorestrue
  \@bonusfalse
  \@partialtrue
  \@combinedtrue
  \def\tbl@range{#1}%
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialcombinedgradetable

\def\partialpointtable#1{%
  \@scoresfalse
  \@bonusfalse
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#1}%
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialpointtable

\def\partialbonuspointtable#1{%
  \@scoresfalse
  \@bonustrue
  \@partialtrue
  \@combinedfalse
  \def\tbl@range{#1}%
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialbonuspointtable

\def\partialcombinedpointtable#1{%
  \@scoresfalse
  \@bonusfalse
  \@partialtrue
  \@combinedtrue
  \def\tbl@range{#1}%
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% partialcombinedpointtable

%--------------------------------------------------------------------

\def\gradetable{%
  \@scorestrue
  \@bonusfalse
  \@partialfalse
  \@combinedfalse
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% gradetable

\def\bonusgradetable{%
  \@scorestrue
  \@bonustrue
  \@partialfalse
  \@combinedfalse
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% bonusgradetable

\def\combinedgradetable{%
  \@scorestrue
  \@bonusfalse
  \@partialfalse
  \@combinedtrue
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% bonusgradetable

\def\pointtable{%
  \@scoresfalse
  \@bonusfalse
  \@partialfalse
  \@combinedfalse
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% pointtable

\def\bonuspointtable{%
  \@scoresfalse
  \@bonustrue
  \@partialfalse
  \@combinedfalse
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% bonuspointtable

\def\combinedpointtable{%
  \@scoresfalse
  \@bonusfalse
  \@partialfalse
  \@combinedtrue
  % If the user doesn't include the optional argument
  % choosing between vertical and horizontal,
  % we give them vertical:
  \@ifnextchar[{\i@gtable}{\i@gtable[v]}%
}% bonuspointtable

%--------------------------------------------------------------------

% \i@gtable and \ii@gtable insert any missing optional arguments
% (the defaults being [v] and [questions]) and then make sure
% that the user said \addpoints and that this isn't the
% first run of LaTeX.
% \do@table then branches, depending on whether the user
% selected [questions] or [pages].

\def\i@gtable[#1]{%
  % If the user doesn't include the second optional argument,
  % which chooses between questions and pages,
  % we give them questions:
  \@ifnextchar[{\ii@gtable{#1}}{\ii@gtable{#1}[questions]}%
}
\def\ii@gtable#1[#2]{%
  % We make sure the user said \addpoints, and then make sure
  % that this isn't the first run of LaTeX (by checking that
  % \exam@numpoints is defined).  If both of those are OK,
  % we go on to \do@table to see whether we're doing a table
  % indexed by questions or by pages.
  \if@addpoints
    \@ifundefined{exam@numpoints}%
      {\ClassWarning{exam}%
        {%
          You must run LaTeX again to produce the
            table.\MessageBreak
        }%
        \fbox{Run \LaTeX{} again to produce the table}%
      }%
      {\do@table{#1}{#2}}%
  \else
    \ClassError{exam}{%
      You must give the command \protect\addpoints\MessageBreak
      \space\space in order to create a grade table.\MessageBreak
      }{%
      If you don't give the command \protect\addpoints\MessageBreak
      \space\space then we're not keeping track of point values.
      \MessageBreak
      }%
  \fi
}% ii@gtable


\def\@questionsref{questions}
\def\@pagesref{pages}
\def\do@table#1#2{%
  % The first argument is ``v'' or ``h'';
  % the second argument is ``questions'' or ``pages''.
  % See whether we're doing a table indexed by
  % questions or by pages:
  \begingroup % avoid trouble from using \@temp
    \def\@temp{#2}%
    \ifx\@temp\@questionsref
      \find@qrange{#1}%
    \else
      \ifx\@temp\@pagesref
        \find@prange{#1}%
      \else
        \ClassError{exam}{%
          The second optional argument to a\MessageBreak
           \space\space  grade table or point table command\MessageBreak 
            \space \space must be either `questions' or
            `pages',\MessageBreak
            \space\space not `#2'.\MessageBreak
        }{%
          Grade tables and point tables can be indexed by questions or
          pages;\MessageBreak
          \space\space for others, you're on your own.\MessageBreak
        }%
        \fbox{Error: grade or point table: Invalid second
                          optional argument `#2'.}%
      \fi
    \fi
  \endgroup
}% do@table


\def\range@undefined{%
  \fbox{Warning: grading range `\tbl@range ' not defined;
                               run \LaTeX{} again.}%
  \ClassWarning{exam}{%
    Grading range `\tbl@range ' not defined.\MessageBreak
    \space\space Run LaTeX again to produce the table.\MessageBreak
  }%
}% range@undefined


%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Grade and point tables indexed by question numbers:

% We get to \find@qrange if we know we're doing a table indexed
% by question numbers.  The argument is either ``v'' or ``h''.
% If we're not doing a partial table, then \find@qrange sets
% \tbl@firstq to 1 and \tbl@lastq to \numquestions.  Otherwise,
% \find@qrange makes sure the grading range is defined and that
% its last question isn't before its first question.
% \find@qrange then calls \@tblquestions, passing along the argument
% that is either ``v'' or ``h''.

\def\find@qrange#1{%
  % We're doing a table indexed by question numbers.
  \if@partial
    \@ifundefined{tbl@\tbl@range @firstq}%
      {%
        \range@undefined
      }%
      {%
        \@ifundefined{tbl@\tbl@range @lastq}%
          {%
            \range@undefined
          }%
          {%
            \edef\tbl@firstq{\csname tbl@\tbl@range @firstq\endcsname}%
            \edef\tbl@lastq{\csname tbl@\tbl@range @lastq\endcsname}%
            % Check that firstq precedes or equals lastq:
            \ifnum \tbl@firstq > \tbl@lastq\relax
              \fbox{Error: Grading Range `\tbl@range ':
                      Last question precedes first question.}%
              \ClassError{exam}{%
                In grading range `\tbl@range ',
                                the last question\MessageBreak
                \space\space comes before the first question.\MessageBreak
                }{%
                  \string\begingradingrange \space must precede
                  \string\endgradingrange \space by at
                             least one question.\MessageBreak
                }%
            \else
              \@tblquestions{#1}%
            \fi
          }%
      }%
  \else
    \def\tbl@firstq{1}%
    % \numquestions is always defined, even if this is the first
    % run of LaTeX and \exam@numquestions isn't defined.
    % If it's the first run of LaTeX, then its value isn't useful,
    % but it's never used until a later run (when its value is useful).
    \def\tbl@lastq{\numquestions}%
    \@tblquestions{#1}%
  \fi
}% find@qrange

\def\@tblquestions#1{%
  % \tbl@firstq and \tbl@lastq have already been set.
  % The argument is either ``v'' or ``h', and we branch accordingly.
  \if v#1%
    \@vtblquestions
  \else
    \if h#1%
      \@htblquestions
    \else
      \ClassError{exam}{%
        The first optional argument to \protect\gradetable,\MessageBreak
        \space\space \protect\bonusgradetable,
        \protect\pointtable, or\MessageBreak
        \space\space  \protect\bonuspointtable
        \space must be either `h' or `v'\MessageBreak
      }{%
        Grade tables and point tables can be either horizontal or
        vertical;\MessageBreak
        \space\space no diagonals allowed.\MessageBreak
      }%
      \if@scores
        \if@bonus
          \fbox{Error: bonusgradetable: Invalid first optional argument
                                                        `#1'.}%
        \else
          \fbox{Error: gradetable: Invalid first optional argument
                                                        `#1'.}%
        \fi
      \else
        \if@bonus
          \fbox{Error: bonuspointtable: Invalid first optional argument
                                                    `#1'.}%
        \else
          \fbox{Error: pointtable: Invalid first optional argument
                                                    `#1'.}%
        \fi
      \fi
    \fi
  \fi
}% @tblquestions

%--------------------------------------------------------------------
% Vertical, indexed by question numbers:

\def\@vtblquestions{%
  % The table is vertical and indexed by question numbers.
  % The question range has already been determined.
  % Branch according to whether it's bonus, non-bonus, or combined,
  % and gradetable or pointtable:
  \begingroup
    % Save the current value of question in @iterator, so that
    % we can restore it after doing the table:
    \setcounter{@iterator}{\value{question}}%
    \renewcommand\arraystretch{\@gtblstretch}%
    \if@bonus
      \if@scores
        \@bvgrdtblquestions
      \else
        \@bvpttblquestions
      \fi
    \else
      \if@combined
        \if@scores
          \@cvgrdtblquestions
        \else
          \@cvpttblquestions
        \fi
      \else
        \if@scores
          \@vgrdtblquestions
        \else
          \@vpttblquestions
        \fi
      \fi
    \fi
    % Restore the saved value of question:
    \setcounter{question}{\value{@iterator}}%
  \endgroup
}% @vtblquestions

\def\@cvgrdtblquestions{%
  % Vertical combined gradetable, indexed by questions
  \set@hlfcntr{tbl@points}{0}%
  \set@hlfcntr{tbl@bonuspoints}{0}%
  \begin{tabular}{|c|c|c|c|}
    \hline
    {\@cvqword}& {\@cvpword}& {\@cvbpword}& {\@cvsword}\\
    \hline
    \setcounter{question}{\tbl@firstq}%
    \addtocounter{question}{-1}\do@cvloop
    {\@cvtword}& \prt@tablepoints&
      \prt@tablebonuspoints&
      \hbox to \@cellwidth{\hfill}\\
    \hline
  \end{tabular}%
}
\def\do@cvloop{%
  % \do@cvloop is used by \@cvgrdtblquestions
  \addtocounter{question}{1}%
  \ref{question@\arabic{question}} &
    \pointsofquestion{\arabic{question}}&
    \bonuspointsofquestion{\arabic{question}}&\\
  \hline
  \@ifundefined{pointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@points}
       {\csname pointsofq@\romannumeral \c@question\endcsname}}%
  \@ifundefined{bonuspointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@bonuspoints}
       {\csname bonuspointsofq@\romannumeral \c@question\endcsname}}%
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@cvloop=\do@cvloop
  \else
    \let\next@cvloop=\relax
  \fi
  \next@cvloop
}% do@cvloop


\def\@cvpttblquestions{%
  % Vertical combined pointtable, indexed by questions
  \set@hlfcntr{tbl@points}{0}%
  \set@hlfcntr{tbl@bonuspoints}{0}%
  \begin{tabular}{|c|c|c|}
    \hline
    {\@cvqword}& {\@cvpword}& {\@cvbpword}\\
    \hline
    \setcounter{question}{\tbl@firstq}%
    \addtocounter{question}{-1}\do@cvptloop
    {\@cvtword}& \prt@tablepoints&
      \prt@tablebonuspoints\\
    \hline
  \end{tabular}%
}
\def\do@cvptloop{%
  % \do@cvptloop is used by \@cvpttblquestions
  \addtocounter{question}{1}%
  \ref{question@\arabic{question}} &
    \pointsofquestion{\arabic{question}}&
    \bonuspointsofquestion{\arabic{question}}\\
  \hline
  \@ifundefined{pointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@points}
       {\csname pointsofq@\romannumeral \c@question\endcsname}}%
  \@ifundefined{bonuspointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@bonuspoints}
       {\csname bonuspointsofq@\romannumeral \c@question\endcsname}}%
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@cvptloop=\do@cvptloop
  \else
    \let\next@cvptloop=\relax
  \fi
  \next@cvptloop
}% do@cvptloop


\def\@bvgrdtblquestions{%
  % Vertical bonus gradetable, indexed by questions:
  \set@hlfcntr{tbl@bonuspoints}{0}%
  \begin{tabular}{|c|c|c|}
    \hline
    {\@bvqword}& {\@bvpword}& {\@bvsword}\\
    \hline
    \setcounter{question}{\tbl@firstq}%
    \addtocounter{question}{-1}\do@bvloop
    {\@bvtword}& \prt@tablebonuspoints&\hbox to \@cellwidth{\hfill}\\
    \hline
  \end{tabular}%
}% @bvgrdtblquestions
\def\do@bvloop{%
  % \do@bvloop is used by \@bvgrdtblquestions
  \addtocounter{question}{1}%
  \ref{question@\arabic{question}} &
        \bonuspointsofquestion{\arabic{question}}&\\
  \hline
  \@ifundefined{bonuspointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@bonuspoints}
       {\csname bonuspointsofq@\romannumeral \c@question\endcsname}}%
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@bvloop=\do@bvloop
  \else
    \let\next@bvloop=\relax
  \fi
  \next@bvloop
}% do@bvloop


\def\@bvpttblquestions{%
  % Vertical bonus point table, indexed by questions:
  \set@hlfcntr{tbl@bonuspoints}{0}%
  \begin{tabular}{|c|c|}
    \hline
    {\@bvqword}& {\@bvpword}\\
    \hline
    \setcounter{question}{\tbl@firstq}%
    \addtocounter{question}{-1}\do@bvptloop
    {\@bvtword}& \prt@tablebonuspoints\\
    \hline
  \end{tabular}%
}% @bvpttblquestions
\def\do@bvptloop{%
  % \do@bvptloop is used by \@bvpttblquestions
  \addtocounter{question}{1}%
  \ref{question@\arabic{question}} &
        \bonuspointsofquestion{\arabic{question}}\\
  \hline
  \@ifundefined{bonuspointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@bonuspoints}
       {\csname bonuspointsofq@\romannumeral \c@question\endcsname}}%
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@bvptloop=\do@bvptloop
  \else
    \let\next@bvptloop=\relax
  \fi
  \next@bvptloop
}% do@bvptloop

\def\@vgrdtblquestions{%
  % Vertical non-bonus grade table, indexed by questions:
  \set@hlfcntr{tbl@points}{0}%
  \begin{tabular}{|c|c|c|}
    \hline
    {\@vqword}& {\@vpword}& {\@vsword}\\
    \hline
    \setcounter{question}{\tbl@firstq}%
    \addtocounter{question}{-1}\do@vloop
    {\@vtword}& \prt@tablepoints&\hbox to \@cellwidth{\hfill}\\
    \hline
  \end{tabular}%
}% @vgrdtblquestions
\def\do@vloop{%
  % \do@vloop is used by \@vgrdtblquestions
  \addtocounter{question}{1}%
  \ref{question@\arabic{question}} &
        \pointsofquestion{\arabic{question}}&\\
  \hline
  \@ifundefined{pointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@points}
       {\csname pointsofq@\romannumeral \c@question\endcsname}}%
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@vloop=\do@vloop
  \else
    \let\next@vloop=\relax
  \fi
  \next@vloop
}% do@vloop


\def\@vpttblquestions{%
  % Vertical non-bonus point table, indexed by questions:
  \set@hlfcntr{tbl@points}{0}%
  \begin{tabular}{|c|c|}
    \hline
    {\@vqword}& {\@vpword}\\
    \hline
    \setcounter{question}{\tbl@firstq}%
    \addtocounter{question}{-1}\do@vptloop
    {\@vtword}& \prt@tablepoints\\
    \hline
  \end{tabular}%
}% @vpttblquestions
\def\do@vptloop{%
  % \do@vptloop is used by \@vpttblquestions
  \addtocounter{question}{1}%
  \ref{question@\arabic{question}} &
        \pointsofquestion{\arabic{question}}\\
  \hline
  \@ifundefined{pointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@points}
       {\csname pointsofq@\romannumeral \c@question\endcsname}}%
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@vptloop=\do@vptloop
  \else
    \let\next@vptloop=\relax
  \fi
  \next@vptloop
}% do@vptloop


%--------------------------------------------------------------------
% Horizontal, indexed by question numbers:

\def\@htblquestions{%
  % We get here from \@tblquestions.
  % The table is horizontal and indexed by question numbers.
  % The question range has already been determined.
  % Set num@cols equal to the number of questions on the table, and
  % do either bonus, combined, or non-bonus table, in each case
  % putting in a line for scores only if it's a gradetable:
  \@ifundefined{exam@numquestions}%
  {}%
  {%
    \setcounter{num@cols}{\tbl@lastq}%
    \addtocounter{num@cols}{-\tbl@firstq}%
    \addtocounter{num@cols}{1}%
  }%
  % Do either bonus, combined, or non-bonus table.  In each case, put
  % in a line for scores if it's a gradetable:
  \begingroup
    % Save the current value of question in @iterator, so that
    % we can restore it after doing the table:
    \setcounter{@iterator}{\value{question}}%
    \renewcommand\arraystretch{\@gtblstretch}%
    \if@bonus
      % It's a horizontal bonus table, by questions:
      \begin{tabular}{|l|*{\thenum@cols}{c|}c|}
        \hline
        {\@bhqword}& \setcounter{question}{\tbl@firstq}%
        \addtocounter{question}{-1}\do@qnumloop
        {\@bhtword}\\
        \hline
        \set@hlfcntr{tbl@bonuspoints}{0}%
        {\@bhpword}& \setcounter{question}{\tbl@firstq}%
        \addtocounter{question}{-1}\do@bptloop
        \prt@tablebonuspoints\\
        \hline
        % If it's a grade table, add in the score line:
        \if@scores
          {\@bhsword}& \setcounter{question}{\tbl@firstq}%
          \addtocounter{question}{-1}\do@sloop
          \\
          \hline
        \fi
      \end{tabular}%
    \else
      \if@combined
        % It's a horizontal combined table, by questions:
        \begin{tabular}{|l|*{\thenum@cols}{c|}c|}
          \hline
          {\@chqword}& \setcounter{question}{\tbl@firstq}%
          \addtocounter{question}{-1}\do@qnumloop
          {\@chtword}\\
          \hline
          \set@hlfcntr{tbl@points}{0}%
          {\@chpword}& \setcounter{question}{\tbl@firstq}%
          \addtocounter{question}{-1}\do@ptloop
          \prt@tablepoints\\
          \hline
          \set@hlfcntr{tbl@bonuspoints}{0}%
          {\@chbpword}& \setcounter{question}{\tbl@firstq}%
          \addtocounter{question}{-1}\do@bptloop
          \prt@tablebonuspoints\\
          \hline
          % If it's a grade table, add in the score line:
          \if@scores
            {\@chsword}& \setcounter{question}{\tbl@firstq}%
            \addtocounter{question}{-1}\do@sloop
            \\
            \hline
          \fi
        \end{tabular}%
      \else
        % Horizontal non-bonus table, indexed by question number:
        \set@hlfcntr{tbl@points}{0}%
        \begin{tabular}{|l|*{\thenum@cols}{c|}c|}
          \hline
          {\@hqword}& \setcounter{question}{\tbl@firstq}%
          \addtocounter{question}{-1}\do@qnumloop
          {\@htword}\\
          \hline
          {\@hpword}& \setcounter{question}{\tbl@firstq}%
          \addtocounter{question}{-1}\do@ptloop
          \prt@tablepoints\\
          \hline
          % If it's a grade table, add in the score line:
          \if@scores
            {\@hsword}& \setcounter{question}{\tbl@firstq}%
            \addtocounter{question}{-1}\do@sloop
            \\
            \hline
          \fi
        \end{tabular}%
      \fi
    \fi
    % Restore the saved value of question:
    \setcounter{question}{\value{@iterator}}%
  \endgroup
}% @htblquestions


% \do@qnumloop and \do@sloop are used by non-bonus,
% combined, and bonus tables:
\def\do@qnumloop{%
  \addtocounter{question}{1}%
  \ref{question@\arabic{question}}&
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@qnloop=\do@qnumloop
  \else
    \let\next@qnloop=\relax
  \fi
  \next@qnloop
}% do@qnumloop
\def\do@sloop{%
  \addtocounter{question}{1}%
  \hbox to \@cellwidth{\hfill}&
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@sloop=\do@sloop
  \else
    \let\next@sloop=\relax
  \fi
  \next@sloop
}% do@sloop

%  \do@ptloop is used by combined and non-bonus tables:
\def\do@ptloop{%
  \addtocounter{question}{1}%
  \pointsofquestion{\arabic{question}}&
  \@ifundefined{pointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@points}
       {\csname pointsofq@\romannumeral \c@question\endcsname}}%
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@ptloop=\do@ptloop
  \else
    \let\next@ptloop=\relax
  \fi
  \next@ptloop
}% do@ptloop

%  \do@bptloop is used by bonus and combined tables:
\def\do@bptloop{%
  \addtocounter{question}{1}%
  \bonuspointsofquestion{\arabic{question}}&
  \@ifundefined{bonuspointsofq@\romannumeral \c@question}%
    {}%
    {\addto@hlfcntr{tbl@bonuspoints}
       {\csname bonuspointsofq@\romannumeral \c@question\endcsname}}%
  \ifnum \value{question} < \tbl@lastq\relax
    \let\next@bptloop=\do@bptloop
  \else
    \let\next@bptloop=\relax
  \fi
  \next@bptloop
}% do@bptloop


%--------------------------------------------------------------------
%--------------------------------------------------------------------
% Grade and point tables indexed by page numbers:


% The only pages listed are those on which there are a nonzero number
% of points.  We check pages \tbl@firstp through \tbl@lastp
% Once we've checked that, e.g., \lastpage@withpoints and
% \pointsonpage@\romannumeral{\lastpage@withpoints} are defined, we
% can safely (we think) check \pointsonpage@\romannumeral{n} for all n
% between \tbl@firstp and \tbl@lastp without generating errors.
%
% Actually: Since we added the notion of half points and half counters
% (a long time ago), there won't be any errors even if
% \pointsonpage@\romannumeral{n} isn't defined, since it's tested by the
% lines:
%   \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral
%                          \csname c@@iterator\endcsname\endcsname}%
%   \ifhlfcntr@pos{tmp@hlfcntr}%
% and if 
%   \csname pointsonpage@\romannumeral
%             \csname c@@iterator\endcsname\endcsname
% isn't defined, tmp@hlfcntr gets the value zero (because of the way
% that \set@hlfcntr is written).

% \find@prange makes sure the grading range is defined and that its
% last page isn't before its first page (if it's a partial table).  In
% any case, it then sets \tbl@firstp and \tbl@lastp, and calls
% \@tblpages.

\def\find@prange#1{%
  % We're doing a table indexed by pages.
  % The argument is either ``v'' or ``h''.
  % After determining the first and last page of the range, we
  % call \@tblpages, passing it that argument (i.e., we say
  % \@tblpages{#1}).
  % If not a partial table, we set \tbl@firstp to 1 and \tbl@lastp to
  % the last page with the appropriate points (and so if it's a
  % combined table, it's the last page to have either bonus or
  % non-bonus points).
  \if@partial
    \@ifundefined{tbl@\tbl@range @firstp}%
      {%
        \range@undefined
      }%
      {%
        \@ifundefined{tbl@\tbl@range @lastp}%
          {%
            \range@undefined
          }%
          {%
            \edef\tbl@firstp{\csname tbl@\tbl@range @firstp\endcsname}%
            \edef\tbl@lastp{\csname tbl@\tbl@range @lastp\endcsname}%
            % Check that firstp precedes or equals lastp:
            \ifnum \tbl@firstp > \tbl@lastp\relax
              \fbox{Error: Grading Range `\tbl@range ':
                      Last page precedes first page.}%
              \ClassError{exam}{%
                In grading range `\tbl@range ', the last page\MessageBreak
                \space\space comes before the first page.\MessageBreak
                }{%
                  \string\begingradingrange \space must precede
                  \string\endgradingrange.\MessageBreak
                }%
            \else
              \@tblpages{#1}%
            \fi
          }%
      }%
  \else
    \def\tbl@firstp{1}%
    % \tbl@lastp isn't used on the first run of LaTeX, and
    % \lastpage@withbonuspoints is defined on the second and later runs.
    \def\tbl@lastp{\lastpage@withpoints}%
    \if@bonus
      \def\tbl@lastp{\lastpage@withbonuspoints}%
    \fi
    \if@combined
      \ifnum \lastpage@withbonuspoints > \lastpage@withpoints\relax
        \def\tbl@lastp{\lastpage@withbonuspoints}%
      \fi        
    \fi
    \@tblpages{#1}%
  \fi
}% find@prange


\def\@tblpages#1{%
  % We get here from \find@prange; the argument is either ``v'' or
  % ``h''.
  % Check that there's enough info from the .aux file to do a page
  % indexed grade table.  If so, call \@whichtblpgs{#1}:
  \@ifundefined{lastpage@withpoints}%
    {\ClassWarning{exam}{%
       You must run LaTeX twice more\MessageBreak
       \space\space to produce the table.\MessageBreak}%
       \fbox{Run \LaTeX{} twice more to produce the table}%
    }%
    {%
      \@ifundefined{pointsonpage@\romannumeral
               \csname lastpage@withpoints\endcsname}%
        {\ClassWarning{exam}{%
           You must run LaTeX again\MessageBreak
           \space\space to produce the table.\MessageBreak}%
           \fbox{Run \LaTeX{} again to produce the table}%
        }%
        {%
          \@whchtblpgs#1
        }%
    }%
}% @tblpages

\def\@whchtblpgs#1{%
  % At this point, we know the table is indexed by pages.
  % It can be vertical or horizontal, 
  % grade or point, and bonus or non-bonus.
  % The argument is either ``v'' or ``h''; test it, and branch:
  \if v#1%
    \@vtblpages
  \else
    \if h#1%
      \@htblpages
    \else
      \ClassError{exam}{%
        The first optional argument to
          \protect\gradetable,\MessageBreak 
          \space\space \protect\bonusgradetable,
            \protect\pointtable, or\MessageBreak
          \space\space
          \protect\bonuspointtable \space must be either `h' or
          `v'\MessageBreak
      }{%
        Grade tables and point tables can be either horizontal or
        vertical;\MessageBreak
        \space\space no diagonals allowed.\MessageBreak
      }%
      \if@scores
        \if@bonus
          \fbox{Error: bonusgradetable: Invalid first optional argument
                                                  `#1'.}%
        \else
          \fbox{Error: gradetable: Invalid first optional argument
                                                  `#1'.}%
        \fi
      \else
        \if@bonus
          \fbox{Error: bonuspointtable: Invalid first optional argument
                                                  `#1'.}%
        \else
          \fbox{Error: pointtable: Invalid first optional argument
                                                  `#1'.}%
        \fi
      \fi
    \fi
  \fi
}% \@whchtblpgs

%--------------------------------------------------------------------
% Vertical, indexed by pages:

\def\@vtblpages{%
  % We get here from \@whchtblpgs.
  % At this point, we know it's a vertical table indexed by pages.
  % It can be grade or point, and bonus, non-bonus, or combined.
  \begingroup
    \renewcommand\arraystretch{\@gtblstretch}%
    \if@bonus
      % It's vertical, bonus, by pages, either point or grade:
      \set@hlfcntr{tbl@bonuspoints}{0}%
      \if@scores
        \begin{tabular}{|c|c|c|}
          \hline
          {\@bvpgword}& {\@bvpword}& {\@bvsword}\\
          \hline
          \setcounter{@iterator}{\tbl@firstp}%
          \addtocounter{@iterator}{-1}\pg@bvloop
          {\@bvtword}& \prt@tablebonuspoints&
                              \hbox to \@cellwidth{\hfill}\\
          \hline
        \end{tabular}%
      \else
        \begin{tabular}{|c|c|}
          \hline
          {\@bvpgword}& {\@bvpword}\\
          \hline
          \setcounter{@iterator}{\tbl@firstp}%
          \addtocounter{@iterator}{-1}\pg@ptbvloop
          {\@bvtword}& \prt@tablebonuspoints\\
          \hline
        \end{tabular}%
      \fi
    \else
      \if@combined
        % It's vertical, combined, by pages, either point or grade:
        \set@hlfcntr{tbl@points}{0}%
        \set@hlfcntr{tbl@bonuspoints}{0}%
        \if@scores
          % Combined gradetable, vertical, by pages:
          \begin{tabular}{|c|c|c|c|}
            \hline
            {\@cvpgword}& {\@cvpword}& {\@cvbpword}& {\@cvsword}\\
            \hline
            \setcounter{@iterator}{\tbl@firstp}%
            \addtocounter{@iterator}{-1}\pg@cvloop
            {\@cvtword}& \prt@tablepoints&
              \prt@tablebonuspoints&
              \hbox to \@cellwidth{\hfill}\\
            \hline
          \end{tabular}%
        \else
          % Combined pointtable, vertical, by pages:
          \begin{tabular}{|c|c|c|}
            \hline
            {\@cvpgword}& {\@cvpword}& {\@cvbpword}\\
            \hline
            \setcounter{@iterator}{\tbl@firstp}%
            \addtocounter{@iterator}{-1}\pg@ptcvloop
            {\@cvtword}& \prt@tablepoints&
              \prt@tablebonuspoints\\
            \hline
          \end{tabular}%
        \fi
      \else
        % It's non-bonus, either point or grade:
        \set@hlfcntr{tbl@points}{0}%
        \if@scores
          \begin{tabular}{|c|c|c|}
            \hline
            {\@vpgword}& {\@vpword}& {\@vsword}\\
            \hline
            \setcounter{@iterator}{\tbl@firstp}%
            \addtocounter{@iterator}{-1}\pg@vloop
            {\@vtword}& \prt@tablepoints&\hbox to \@cellwidth{\hfill}\\
            \hline
          \end{tabular}%
        \else
          \begin{tabular}{|c|c|}
            \hline
            {\@vpgword}& {\@vpword}\\
            \hline
            \setcounter{@iterator}{\tbl@firstp}%
            \addtocounter{@iterator}{-1}\pg@ptvloop
            {\@vtword}& \prt@tablepoints\\
            \hline
          \end{tabular}%
        \fi
      \fi
    \fi
  \endgroup
}% @vtblpages


% \pg@ptvloop and \pg@ptvloopline are used only by non-bonus pointtable:
\def\pg@ptvloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \add@hlfcntrtohlfcntr{tbl@points}{tmp@hlfcntr}%
    \pg@ptvloopline
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@pg@ptvloop=\pg@ptvloop
  \else
    \let\next@pg@ptvloop=\relax
  \fi
  \next@pg@ptvloop
}% pg@ptvloop
\def\pg@ptvloopline{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \pageref{firstpoints@onpage@\arabic{@iterator}} &
                         \pointsonpage{\the@iterator}\\
  \hline
}% pg@ptvloopline

% \pg@vloop and \pg@vloopline are used only by non-bonus gradetable:
\def\pg@vloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \add@hlfcntrtohlfcntr{tbl@points}{tmp@hlfcntr}%
    \pg@vloopline
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@pg@vloop=\pg@vloop
  \else
    \let\next@pg@vloop=\relax
  \fi
  \next@pg@vloop
}% pg@vloop
\def\pg@vloopline{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \pageref{firstpoints@onpage@\arabic{@iterator}} &
                         \pointsonpage{\the@iterator}&\\
  \hline
}% pg@vloopline

% \pg@cvloop, \pg@noncvloopline, \check@bnspts, and
% \pg@cvloopline are used only by combined gradetable:
\def\pg@cvloop{%
  \addtocounter{@iterator}{1}%
  % Add the bonus points:
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \add@hlfcntrtohlfcntr{tbl@bonuspoints}{tmp@hlfcntr}%
  % Add the regular points:
  \set@hlfcntr{tmp@hlfcntr}{\csname pointsonpage@\romannumeral
         \csname c@@iterator\endcsname\endcsname}%
  \add@hlfcntrtohlfcntr{tbl@points}{tmp@hlfcntr}%
  % Print a line of the table, if there are points on this page:
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@noncvloopline
  \else
    \check@bnspts
  \fi
  % Do the tail recursion bit:
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@pg@cvloop=\pg@cvloop
  \else
    \let\next@pg@cvloop=\relax
  \fi
  \next@pg@cvloop
}% pg@cvloop
\def\pg@noncvloopline{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \pageref{firstpoints@onpage@\arabic{@iterator}}&
           \pointsonpage{\the@iterator}&
           \bonuspointsonpage{\the@iterator}&\\
  \hline
}% pg@noncvloopline
\def\check@bnspts{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@cvloopline
  \fi
}% check@bnspts
\def\pg@cvloopline{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \pageref{firstbonuspoints@onpage@\arabic{@iterator}}&
           \pointsonpage{\the@iterator}&
           \bonuspointsonpage{\the@iterator}&\\
  \hline
}% pg@cvloopline

% \pg@ptcvloop, \pg@ptnoncvloopline, \check@ptbnspts, and
% \pg@ptcvloopline are used only by combined pointtable:
\def\pg@ptcvloop{%
  \addtocounter{@iterator}{1}%
  % Add the bonus points:
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \add@hlfcntrtohlfcntr{tbl@bonuspoints}{tmp@hlfcntr}%
  % Add the regular points:
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \add@hlfcntrtohlfcntr{tbl@points}{tmp@hlfcntr}%
  % Print a line of the table, if there are points on this page:
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@ptnoncvloopline
  \else
    \check@ptbnspts
  \fi
  % Do the tail recursion bit:
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@pg@ptcvloop=\pg@ptcvloop
  \else
    \let\next@pg@ptcvloop=\relax
  \fi
  \next@pg@ptcvloop
}% pg@ptcvloop
\def\pg@ptnoncvloopline{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \pageref{firstpoints@onpage@\arabic{@iterator}}&
           \pointsonpage{\the@iterator}&
           \bonuspointsonpage{\the@iterator}\\
  \hline
}% pg@ptnoncvloopline
\def\check@ptbnspts{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@ptcvloopline
  \fi
}% check@ptbnspts
\def\pg@ptcvloopline{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \pageref{firstbonuspoints@onpage@\arabic{@iterator}}&
           \pointsonpage{\the@iterator}&
           \bonuspointsonpage{\the@iterator}\\
  \hline
}% pg@ptcvloopline

% \pg@bvloop and \pg@bvloopline are used only by bonus gradetable:
\def\pg@bvloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \add@hlfcntrtohlfcntr{tbl@bonuspoints}{tmp@hlfcntr}%
    \pg@bvloopline
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@pg@bvloop=\pg@bvloop
  \else
    \let\next@pg@bvloop=\relax
  \fi
  \next@pg@bvloop
}% pg@bvloop
\def\pg@bvloopline{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \pageref{firstbonuspoints@onpage@\arabic{@iterator}} &
                         \bonuspointsonpage{\the@iterator}&\\
  \hline
}% pg@bvloopline

% \pg@ptbvloop and \pg@ptbvloopline are used only by bonus pointtable:
\def\pg@ptbvloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \add@hlfcntrtohlfcntr{tbl@bonuspoints}{tmp@hlfcntr}%
    \pg@ptbvloopline
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@pg@ptbvloop=\pg@ptbvloop
  \else
    \let\next@pg@ptbvloop=\relax
  \fi
  \next@pg@ptbvloop
}% pg@ptbvloop
\def\pg@ptbvloopline{%
  % We still don't understand why we need to hide this inside of a
  % macro; there's some weird interaction with the \ifnum checking to
  % see if something is ``>0''; checking that something is ``=0''
  % doesn't cause the ``\ifnum incomplete'' (or whatever) error.
  \pageref{firstbonuspoints@onpage@\arabic{@iterator}} &
                         \bonuspointsonpage{\the@iterator}\\
  \hline
}% pg@ptbvloopline

%--------------------------------------------------------------------
% Horizontal, indexed by pages:

% For a horizontal table, before we begin we need to know how many
% pages there are with points on them:
\newcounter{num@cols}
\def\count@pgswpts{%
  % We're called by \@htblpages.
  % \count@pgswpts is used for horizontal
  % grade tables and point tables,
  % bonus, non-bonus, and combined.
  \setcounter{num@cols}{0}%
  \setcounter{@iterator}{\tbl@firstp}%
  \addtocounter{@iterator}{-1}%
  \if@bonus
    \docount@pgswbpts
  \else
    \if@combined
      \docount@pgswcpts
    \else
      \docount@pgswpts
    \fi
  \fi
}% count@pgswpts

\def\docount@pgswcpts{%
  % Called by \count@pgswpts
  % \docount@pgswcpts is used for combined gradetable.
  % Count the number of pages in range with any kind of point (bonus
  % or non-bonus):
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \addtocounter{num@cols}{1}%
  \else
    \check@bnsptpage
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@docount=\docount@pgswcpts
  \else
    \let\next@docount=\relax
  \fi
  \next@docount
}% docount@pgswcpts
\def\check@bnsptpage{%
  % We don't understand why we need to hide this inside of a macro:
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \addtocounter{num@cols}{1}%
  \fi
}% check@bnsptpage

\def\docount@pgswpts{%
  % Called by \count@pgswpts
  % \docount@pgswpts is used for non-bonus gradetable:
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \addtocounter{num@cols}{1}%
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@docount=\docount@pgswpts
  \else
    \let\next@docount=\relax
  \fi
  \next@docount
}% docount@pgswpts

\def\docount@pgswbpts{%
  % Called by \count@pgswpts
  % \docount@pgswbpts is used for bonusgradetable:
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \addtocounter{num@cols}{1}%
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@docount=\docount@pgswbpts
  \else
    \let\next@docount=\relax
  \fi
  \next@docount
}% docount@pgswbpts

%--------------------------------------------------------------------

\def\@htblpages{%
  % We get here from \@whchtblpgs.
  % Horizontal grade or point table, by pages:
  \begingroup
    \renewcommand\arraystretch{\@gtblstretch}%
    % Set num@cols equal to the number of pages with points (of
    % correct type): 
    \count@pgswpts
    % Suppress ``extra alignment tab'' errors if \thenum@cols = 0:
    \ifnum \thenum@cols = 0\relax
      \setcounter{num@cols}{1}%
    \fi
    \set@hlfcntr{tbl@points}{0}%
    \set@hlfcntr{tbl@bonuspoints}{0}%
    \if@bonus
      % Horizontal bonus grade or point table, by pages:
      \begin{tabular}{|l|*{\thenum@cols}{c|}c|}
        \hline
        {\@bhpgword}& \setcounter{@iterator}{\tbl@firstp}%
                      \addtocounter{@iterator}{-1}\do@bpgnumloop
        {\@bhtword}\\
        \hline
        {\@bhpword}& \setcounter{@iterator}{\tbl@firstp}%
                     \addtocounter{@iterator}{-1}\do@bpgptloop
        \prt@tablebonuspoints\\
        \hline
        % If it's a grade table, do the line for scores:
        \if@scores
          {\@bhsword}& \setcounter{@iterator}{\tbl@firstp}%
                       \addtocounter{@iterator}{-1}\do@bpgsloop
          \\
          \hline
        \fi
      \end{tabular}%
    \else
      \if@combined
        % Horizontal combined grade or point table, by pages:
        \begin{tabular}{|l|*{\thenum@cols}{c|}c|}
          \hline
          {\@chpgword}& \setcounter{@iterator}{\tbl@firstp}%
                        \addtocounter{@iterator}{-1}\do@cpgnumloop
          {\@chtword}\\
          \hline
          {\@chpword}& \setcounter{@iterator}{\tbl@firstp}%
                       \addtocounter{@iterator}{-1}\do@cpgptloop
          \prt@tablepoints\\
          \hline
          {\@chbpword}& \setcounter{@iterator}{\tbl@firstp}%
                       \addtocounter{@iterator}{-1}\do@cbpgptloop
          \prt@tablebonuspoints\\
          \hline
          % If it's a grade table, do the line for scores:
          \if@scores
            {\@chsword}& \setcounter{@iterator}{\tbl@firstp}%
                         \addtocounter{@iterator}{-1}\do@cpgsloop
            \\
            \hline
          \fi
        \end{tabular}%
      \else
        % Horizontal non-bonus grade or point table, by pages:
        \begin{tabular}{|l|*{\thenum@cols}{c|}c|}
          \hline
          {\@hpgword}& \setcounter{@iterator}{\tbl@firstp}%
                       \addtocounter{@iterator}{-1}\do@pgnumloop
          {\@htword}\\
          \hline
          {\@hpword}& \setcounter{@iterator}{\tbl@firstp}%
                      \addtocounter{@iterator}{-1}\do@pgptloop
          \prt@tablepoints\\
          \hline
          % If it's a grade table, do the line for scores:
          \if@scores
            {\@hsword}& \setcounter{@iterator}{\tbl@firstp}%
                        \addtocounter{@iterator}{-1}\do@pgsloop
            \\
            \hline
          \fi
        \end{tabular}%
      \fi
    \fi
  \endgroup
}% @htblpages

%--------------------------------------------------------------------
% \do@pgnumloop, \do@pgptloop, and \do@pgsloop
%  are only for non-bonus gradetable.
% \pg@line is also for combinedgradetable.
\def\do@pgnumloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@line
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@pgnumloop=\do@pgnumloop
  \else
    \let\next@pgnumloop=\relax
  \fi
  \next@pgnumloop
}% \do@pgnumloop
\def\pg@line{%
  % We still don't know why we need to hide this inside of a macro:
  \pageref{firstpoints@onpage@\arabic{@iterator}}&
}% \pg@line

\def\do@pgptloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \add@hlfcntrtohlfcntr{tbl@points}{tmp@hlfcntr}%
    \pgpt@entry
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@pgptloop=\do@pgptloop
  \else
    \let\next@pgptloop=\relax
  \fi
  \next@pgptloop
}% \do@pgptloop
% \pgpt@entry is used by different macros:
\def\pgpt@entry{%
  % We still don't know why we need to hide this inside of a macro:
  \pointsonpage{\the@iterator}&
}% \pgpt@entry

\def\do@pgsloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@sentry
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@pgsloop=\do@pgsloop
  \else
    \let\next@pgsloop=\relax
  \fi
  \next@pgsloop
}% \do@pgsloop
% \pg@sentry is called by several different macros,
% to create different tables:
\def\pg@sentry{%
  % We still don't know why we need to hide this inside of a macro:
  \hbox to \@cellwidth{\hfill}&
}% \pg@sentry

%--------------------------------------------------------------------
% These things are for bonusgradetable:

% \do@bpgnumloop, \do@bpgptloop, \do@bpgsloop,
% and \bpg@sline are only for bonusgradetable.
% \bpg@line is also used for combinedgradetable.
\def\do@bpgnumloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \bpg@line
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@bpgnumloop=\do@bpgnumloop
  \else
    \let\next@bpgnumloop=\relax
  \fi
  \next@bpgnumloop
}% do@bpgnumloop
\def\bpg@line{%
  % We still don't know why we need to hide this inside of a macro:
  \pageref{firstbonuspoints@onpage@\arabic{@iterator}}&
}% bpg@line

\def\do@bpgptloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \add@hlfcntrtohlfcntr{tbl@bonuspoints}{tmp@hlfcntr}%
    \bpgpt@line
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@bpgptloop=\do@bpgptloop
  \else
    \let\next@bpgptloop=\relax
  \fi
  \next@bpgptloop
}% do@bpgptloop
% \bpgpt@line is called by several macros:
\def\bpgpt@line{%
  % We still don't know why we need to hide this inside of a macro:
  \bonuspointsonpage{\the@iterator}&
}% bpgpt@line

\def\do@bpgsloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@sentry
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@bpgsloop=\do@bpgsloop
  \else
    \let\next@bpgsloop=\relax
  \fi
  \next@bpgsloop
}% do@bpgsloop

%--------------------------------------------------------------------
% These things are for combinedgradetable:

% \do@cpgnumloop, \cpg@line, \cbpg@line, \do@cpgptloop, \bpgpt@line,
% \do@cpgsloop, \bpg@sline, and \do@cbpgptloop are only for
% combinedgradetable:
\def\do@cpgnumloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@line
  \else
    \check@bpgpts
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@cpgnumloop=\do@cpgnumloop
  \else
    \let\next@cpgnumloop=\relax
  \fi
  \next@cpgnumloop
}% do@bpgnumloop
\def\check@bpgpts{%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \bpg@line
  \fi
}% check@bpgpts

\def\do@cpgptloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \add@hlfcntrtohlfcntr{tbl@points}{tmp@hlfcntr}%
    \pgpt@entry
  \else
    \check@cbpts
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@cpgptloop=\do@cpgptloop
  \else
    \let\next@cpgptloop=\relax
  \fi
  \next@cpgptloop
}% do@cpgptloop
\def\check@cbpts{%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pgpt@entry
  \fi
}% check@cbpts

\def\do@cbpgptloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \add@hlfcntrtohlfcntr{tbl@bonuspoints}{tmp@hlfcntr}%
    \bpgpt@line
  \else
    \check@cnonpts
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@cbpgptloop=\do@cbpgptloop
  \else
    \let\next@cbpgptloop=\relax
  \fi
  \next@cbpgptloop
}% do@cbpgptloop
\def\check@cnonpts{%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \bpgpt@line
  \fi
}% check@cnonpts

\def\do@cpgsloop{%
  \addtocounter{@iterator}{1}%
  \set@hlfcntr{tmp@hlfcntr}{\pointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@sentry
  \else
    \check@bnsline
  \fi
  \ifnum \the@iterator < \tbl@lastp\relax
    \let\next@cpgsloop=\do@cpgsloop
  \else
    \let\next@cpgsloop=\relax
  \fi
  \next@cpgsloop
}% do@cpgsloop
\def\check@bnsline{%
  \set@hlfcntr{tmp@hlfcntr}{\bonuspointsonpage{\the@iterator}}%
  \ifhlfcntr@pos{tmp@hlfcntr}%
    \pg@sentry
  \fi
}% check@bnsline

%--------------------------------------------------------------------
% \pointsinrange and \bonuspointsinrange:
% We say either \@bonusfalse or \@bonustrue, and then we check it only
% in \do@countloop:
\def\pointsinrange#1{%
  \@bonusfalse
  \def\tbl@range{#1}%
  \@ifundefined{exam@numpoints}%
    {\mbox{\normalfont\bf ??}}%
    {\read@range}%
}% pointsinrange

\def\bonuspointsinrange#1{%
  \@bonustrue
  \def\tbl@range{#1}%
  \@ifundefined{exam@numpoints}%
    {\mbox{\normalfont\bf ??}}%
    {\read@range}%
}% bonuspointsinrange

\def\bad@range{%
  {\mbox{\normalfont\bf ??}}%
  \ClassWarning{exam}{%
    Grading range `\tbl@range ' not defined.\MessageBreak
    \space\space Run LaTeX again.\MessageBreak
  }%
}% bad@range

\def\read@range{%
  \@ifundefined{tbl@\tbl@range @firstq}%
  {%
    \bad@range
  }%
  {%
    \@ifundefined{tbl@\tbl@range @lastq}%
    {%
      \bad@range
    }%
    {%
      \edef\tbl@firstq{\csname tbl@\tbl@range @firstq\endcsname}%
      \edef\tbl@lastq{\csname tbl@\tbl@range @lastq\endcsname}%
      % Check that firstq precedes or equals lastq:
      \ifnum \tbl@firstq > \tbl@lastq\relax
        \fbox{Error: Grading Range `\tbl@range ':
          Last question precedes first question.}%
        \ClassError{exam}{%
          In grading range `\tbl@range ',
          the last question\MessageBreak
          \space\space comes before the first question.\MessageBreak
        }{%
          \string\begingradingrange \space must precede
          \string\endgradingrange \space by at
          least one question.\MessageBreak
        }%
      \else
        \count@pointsinrange
      \fi
    }%
  }%
}% read@range

\def\count@pointsinrange{%
  % Used for both \pointsinrange and \bonuspointsinrange:
  \set@hlfcntr{tbl@points}{0}%
  \setcounter{@iterator}{\tbl@firstq}%
  \addtocounter{@iterator}{-1}\do@countloop
  \prt@hlfcntr{tbl@points}%
}% count@pointsinrange
\def\do@countloop{%
  % We check \if@bonus here when needed:
  \addtocounter{@iterator}{1}%
  \if@bonus
    \@ifundefined{bonuspointsofq@\romannumeral \c@@iterator}%
      {}%
      {\addto@hlfcntr{tbl@points}
         {\csname bonuspointsofq@\romannumeral \c@@iterator\endcsname}}%
  \else
    \@ifundefined{pointsofq@\romannumeral \c@@iterator}%
      {}%
      {\addto@hlfcntr{tbl@points}
         {\csname pointsofq@\romannumeral \c@@iterator\endcsname}}%
  \fi
  \ifnum \value{@iterator} < \tbl@lastq\relax
    \let\next@countloop=\do@countloop
  \else
    \let\next@countloop=\relax
  \fi
  \next@countloop
}% do@countloop



%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%                     ***************************
%                     ** SOLUTION ENVIRONMENTS **
%                     ***************************



% If the documentclass options include ``answers'', then the command
% \printanswerstrue is given at the beginning of the run.

% If the documentclass options include ``noanswers'', then the command
% \printanswersfalse is given at the beginning of the run.

\def\printanswers{\printanswerstrue}
\def\noprintanswers{\printanswersfalse}

% If the documentclass options include ``cancelspace'', then the
% command \cancelspacetrue is given at the beginning of the run.

% If the documentclass options include ``nocancelspace'', then the
% command \cancelspacefalse is given at the beginning of the run.

\def\cancelspace{\cancelspacetrue}
\def\nocancelspace{\cancelspacefalse}

\newcommand\SolutionEmphasis[1]{%
  \def\Solution@Emphasis{#1}%
}
\SolutionEmphasis{}

% If printanswers is true, we print the solution using a TheSolution
% environment.  If printanswers is false and cancelspace is false, we
% insert blank vertical space equal to the optional argument (the
% default value of which is 0pt).
\newenvironment{solution}[1][0pt]%
  {%
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        \penalty 0
        \vspace*{#1}%
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%

% If printanswers is true, we print the solution using a TheSolution
% environment.  If printanswers is false and cancelspace is false,
% we insert an empty box of width the current line width and of
% height equal to the optional argument, which can be a length, or
% \fill, or \stretch{number}.  If the optional argument is omitted,
% then the box is entirely omitted when printanswers is false.
\newenvironment{solutionorbox}[1][-1pt]%
  {%
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        % Note: It's important that the following test be
        % ``\ifdim 0pt > #1'' rather than ``\ifdim #1 < 0pt''
        % That's because if the user says
        % ``\begin{solutionorbox}{\stretch{1}}''
        % (or \stretch{anythingelse}), then this will expand to
        % ``\ifdim 0pt > \z@ plus 1fill\relax''.
        % The \ifdim will be ``\ifdim 0pt > \z@'', and we'll have
        % ``plus 1fill\relax'' left over.  This is OK because if the
        % \ifdim is false, that leftover stuff will be ignored,
        % and it will only be true if the user omitted the optional
        % argument, in which case there's no \stretch and thus no
        % left over part.
        % If we said ``\ifdim #1 < 0pt'', then we'd get an error
        % when the user used \stretch, since the leftover stuff
        % would appear when TeX was looking for <, =, or >.
        \ifdim 0pt > #1
          % do nothing
        \else
          \makeemptybox{#1}%
        \fi
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%
  
% If printanswers is true, we print the solution using a TheSolution
% environment.  If printanswers is false and cancelspace is false,
% we insert lined vertical space equal to the optional argument (the
% default value of which is 0pt).
\newenvironment{solutionorlines}[1][0pt]%
  {%
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        \penalty 0
        \fillwithlines{#1}%
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%
  
% If printanswers is true, we print the solution using a TheSolution
% environment.  If printanswers is false and cancelspace is false,
% we insert dotted lined vertical space equal to the optional
% argument (the default value of which is 0pt).
\newenvironment{solutionordottedlines}[1][0pt]%
  {%
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \ifcancelspace
        % Do nothing
      \else
        \par
        \penalty 0
        \fillwithdottedlines{#1}%
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%

% The environment TheSolution is called from the solution,
% solutionorbox, solutionorlines, and solutionordottedlines
% environments when printanswers is true.  It uses Donald Arseneau's
% framed.sty macros (included at the end of this file) to allow the
% solution to be broken across pages and have each piece enclosed in
% an fbox (or a colorbox, if the user has given the command
% \shadedsolutions), (or no box at all, if the user has given the
% command \unframedsolutions).
% Of course, the user can change TheSolution with a \renewenvironment
% command.
\newcommand{\solutiontitle}{\noindent\textbf{Solution:}\enspace}
\newenvironment{TheSolution}%
  {%
    \vspace{\parskip}%
    % If we don't set \leftskip and \rightskip to 0pt, then if we
    % appear inside of an \uplevel command we'd have indentation
    % inside of the solution box:
    \leftskip=0pt
    \rightskip=0pt
    % If the user said \unframedsolutions, then both
    % \if@framedsolutions and \if@shadedsolutions are false:
    \if@framedsolutions
      % We'll use the default \FrameCommand
    \else
      \if@shadedsolutions
        \def\FrameCommand{\colorbox{SolutionColor}}%
      \else
        % It's \unframedsolutions:
        \def\FrameCommand{}%
      \fi
    \fi
    \MakeFramed{\advance\hsize-\width}%
    \solutiontitle
    \ignorespaces
  }%
  {%
    \unskip
    \endMakeFramed
  }%

\newif\if@framedsolutions
\@framedsolutionstrue
\newif\if@shadedsolutions
\@shadedsolutionsfalse
% If the user said \unframedsolutions, then both
% \if@framedsolutions and \if@shadedsolutions are false.

\def\framedsolutions{\@framedsolutionstrue\@shadedsolutionsfalse}
\def\shadedsolutions{%
  \@ifundefined{definecolor}
  {%
    \ClassError{exam}{%
      You must load the color package with the command\MessageBreak
      \space\space\protect\usepackage{color}\MessageBreak
      in order to use the command \protect\shadedsolutions
      \MessageBreak
      }{%
      This command makes use of the package color.sty,\MessageBreak
      and so you have to load color.sty before your\MessageBreak
      \protect\begin{document} command.\MessageBreak
      }%
  }%
  {%
    \definecolor{SolutionColor}{gray}{0.8}
    \@shadedsolutionstrue
    \@framedsolutionsfalse
  }%
}
\def\unframedsolutions{\@framedsolutionsfalse\@shadedsolutionsfalse}

%--------------------------------------------------------------------
%--------------------------------------------------------------------

% The following stuff is lifted from:
%
% framed.sty   v 0.8a   21-Jul-2003
% Copyright (C) 1992-2003 by Donald Arseneau
% These macros may be freely transmitted, reproduced, or modified
% provided that this notice is left intact.
%
% The modifications I made are marked with ``psh'' in a comment:
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create framed or shaded regions that can break across pages using 
% \begin{framed} ... \end{framed}    -- ordinary frame box (box at margin)
% \begin{shaded} ... \end{shaded}    -- shaded background (into margin)
%    ... leftbar ...                 -- line on left side
% \begin{MakeFramed}{settings} ... \end{MakeFramed}
%                        -- generic frame (for new environments)
%
% The "framed" environment puts the text into "\fbox" with the
% settings "\fboxrule=\FrameRule" and "\fboxsep=\FrameSep".
% You can change these lengths (using "\setlength") and you
% can even change the definition of "\FrameCommand" to use
% much fancier boxes.
%
% In fact, the "shaded" environment just redefines "\FrameCommand"
% to use "\colorbox{shadecolor}" (and you have to define the
% color "shadecolor": \newcolor{shadecolor}...).
%
% A page break is allowed, and even encouraged, before the framed
% environment.  If you want to attach some text (a box title) to the
% frame, then the text should be inserted by \FrameCommand
%
% The contents of the framed regions are restricted: 
% Floats, footnotes, marginpars and head-line entries will be lost.
% (Some of these may be handled in a later version.)
% This package will not work with the page breaking of multicol.sty,
% or other systems that perform column-balancing.
%
% The MakeFramed environment does the work.  Its "settings" argument
% should contain any adjustments to the text width (applied to \hsize,
% and using the "\width" of the frame itself) as well as a `restore' 
% command -- \@parboxrestore or \FrameRestore or something similar.
% 
% Expert commands:
% \MakeFramed, \endMakeFramed: the "MakeFramed" environment
% \FrameCommand: command to draw the frame around its argument
% \FrameRestore: restore some text settings, but fewer than \@parboxrestore
% \FrameRule: length register; \fboxrule for default "framed".
% \FrameSep: length register; \fboxsep for default "framed".
% \FrameHeightAdjust: macro; height of frame above baseline at top of page
% 
% This is still a `pre-production' version because I can think of many
% features/improvements that should be made.  Nevertheless, starting 
% with version 0.5 it should be bug-free.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%psh: Commented out \ProvidesPackage:
%\ProvidesPackage{framed}[2003/07/21 v 0.8a: 
%   framed or shaded text with page breaks]

%psh: Created \saved@totalleftmargin and \@sollistdepth:
\newdimen\saved@totalleftmargin
\newcount\@sollistdepth

\newenvironment{framed}% using default \FrameCommand
  {\MakeFramed {\advance\hsize-\width \FrameRestore}}%
  {\endMakeFramed}

\newenvironment{shaded}{%
  \def\FrameCommand{\colorbox{shadecolor}}%
  \MakeFramed {\FrameRestore}}%
 {\endMakeFramed}

\newenvironment{leftbar}{%
  \def\FrameCommand{\vrule width 3pt \hspace{10pt}}%
  \MakeFramed {\advance\hsize-\width \FrameRestore}}%
 {\endMakeFramed}

\chardef\FrameRestore=\catcode`\| % for debug
\catcode`\|=\catcode`\% % (debug: insert space after backslash)

\def\MakeFramed#1{\par
 % measure added width and height; call result \width and \height
 \setbox\z@\vbox{\vskip-1in \hbox{\hskip-1in 
   \FrameCommand{\hbox{\vrule \@height .7in \@depth.3in \@width 1in}}}%
   \vskip\z@skip}%
 \def\width{\wd\z@}\def\height{\ht\z@}%
 \edef\fb@frw{\the\width}\edef\fb@frh{\the\height}%
 % insert pre-penalties and skips
 \begingroup
 \skip@\lastskip
 \if@nobreak\else 
    \penalty9999 % updates \page parameters
    \ifdim\pagefilstretch=\z@ \ifdim\pagefillstretch=\z@
       \edef\@tempa{\the\skip@}%
       \ifx\@tempa\zero@glue \penalty-30
       \else \vskip-\skip@ \penalty-30 \vskip\skip@
    \fi\fi\fi
    \penalty\z@
    % Give a stretchy breakpoint that will always be taken in preference
    % to the \penalty 9999 used to update page parameters.  The cube root
    % of 10000/100 indicates a multiplier of 0.21545, but the maximum 
    % calculated badness is really 8192, not 10000, so the multiplier
    % is 0.2301. 
    \advance\skip@ \z@ plus-.5\baselineskip
    \advance\skip@ \z@ plus-.231\height
    \advance\skip@ \z@ plus-.231\skip@
    \advance\skip@ \z@ plus-.231\topsep
    \vskip-\skip@ \penalty 1800 \vskip\skip@
 \fi
 \addvspace{\topsep}%
 \endgroup
 % clear out pending page break
 \penalty\@M \vskip 2\baselineskip \vskip\height
 \penalty9999 \vskip -2\baselineskip \vskip-\height
 \penalty9999 % updates \pagetotal
|\message{After clearout, \pagetotal=\the\pagetotal, \pagegoal=\the\pagegoal. }%
 \fb@adjheight 
%psh: Added commands:
  \advance\hsize-\@totalleftmargin
  \saved@totalleftmargin=\@totalleftmargin
  \@totalleftmargin=0pt
  \parshape 0
  \let\@listdepth=\@sollistdepth
  \@sollistdepth=0
  \leftmargin=0pt
%psh: end of added commands
 \setbox\@tempboxa\vbox\bgroup
   #1% Modifications to \hsize (can use \width and \height)
   \textwidth\hsize \columnwidth\hsize
%psh: added one line:
   \linewidth=\hsize
}

\def\endMakeFramed{\par
     \kern\z@ \penalty-100 % put depth into height
 \egroup
 \begingroup \put@frame \endgroup
%psh: Added one line:
 \@totalleftmargin=\saved@totalleftmargin
}

% \put@frame takes the contents of \@tempboxa and puts all, or a piece,
% of it on the page with a frame (\FrameCommand).  It recurses until
% all of \@tempboxa has been used up. (\@tempboxa must have zero depth.)

\def\put@frame{\relax
 \ifdim\pagegoal=\maxdimen \pagegoal\vsize \fi
|   \message{=============== Entering putframe ====================^^J
|     \pagegoal=\the\pagegoal,  \pagetotal=\the\pagetotal. }%
 \ifinner \else
    \dimen@\pagegoal \advance\dimen@-\pagetotal % natural space left on page
  \ifdim\dimen@<2\baselineskip 
|   \message{Page has only \the\dimen@\space room left; eject. }%
    \eject \fb@adjheight \put@frame
  \else % there's appreciable room left on the page
|    \message{\string\pagetotal=\the\pagetotal,
|        \string\pagegoal=\the\pagegoal, 
|        \string\pagestretch=\the\pagestretch,
|        \string\pageshrink=\the\pageshrink,
|        \string\fb@frh=\fb@frh. \space}
|    \message{Box of size \the\ht\@tempboxa\space + \fb@frh}%
     \begingroup % temporarily set \dimen@ to be...
     \advance\dimen@.8\pageshrink  % maximum space available on page
     \advance\dimen@-\fb@frh\relax % space available for frame's contents
     \expandafter\endgroup
     % restore \dimen@ to real room left on page
     \ifdim\dimen@>\ht\@tempboxa % whole box does fit
|       \message{fits in \the\dimen@. }%
     \else % box must be split
|       \message{must be split to fit in \the\dimen@. }%
        \setbox\@tempboxa\vbox{% simulate frame and flexiblity of the page:
           \vskip \fb@frh \@plus\pagestretch \@minus.8\pageshrink
           \kern137sp\kern-137sp\penalty-30
           \unvbox\@tempboxa}%
        \edef\fb@resto@set{\boxmaxdepth\the\boxmaxdepth \splittopskip\the\splittopskip}%
        \boxmaxdepth\z@ \splittopskip\z@
        \setbox\tw@\vsplit\@tempboxa to\dimen@
        \setbox\tw@\vbox{\unvbox\tw@}% natural-sized
|       \message{Box of size \the\ht\@tempboxa\space split to \the\dimen@. 
|          Natural height of split box is \the\ht\tw@. }%
        % If the split-to size > (\vsize-\topskip), then set box to full size
        \begingroup
          \advance\dimen@\topskip
          \expandafter\endgroup
        \ifdim\dimen@>\pagegoal
|         \message{Frame is big -- Use up the full column. }%
          \dimen@ii\pagegoal
          \advance\dimen@ii -\topskip
          \advance\dimen@ii \FrameHeightAdjust\relax
        \else  % suspect this is wrong:
          % If the split-to size > feasible room_on_page, rebox it smaller.
          \advance\dimen@.8\pageshrink
          \ifdim\ht\tw@>\dimen@
|           \message{Box too tall; rebox it to \the\dimen@. }%
            \dimen@ii\dimen@
          \else % use natural size
            \dimen@ii\ht\tw@
          \fi
        \fi
        % Re-box contents to desired size \dimen@ii
        \advance\dimen@ii -\fb@frh
        \setbox\tw@\vbox to\dimen@ii \bgroup
        % remove simulated frame and page flexibility:
        \vskip -\fb@frh \@plus-\pagestretch \@minus-.8\pageshrink
        \unvbox\tw@ \unpenalty\unpenalty
        \ifdim\lastkern=-137sp % whole box went to next page
|          \message{box split at beginning! }%
           \egroup \fb@resto@set \eject % (\vskip for frame size was discarded) 
           \fb@adjheight
        \else %
           \egroup \fb@resto@set
           \ifvoid\@tempboxa % it all fit after all
|             \message{box split at end! }%
              \setbox\@tempboxa\box\tw@
           \else % it really did split
|             \message{box split as expected. Its reboxed height is \the\ht\tw@. }%
              \ifdim\wd\tw@>\z@
%psh: Changed the command that inserts the box:
%     Instead of \centerline, we shift right by \saved@totalleftmargin:
%              \centerline{\FrameCommand{\box\tw@}}%  ??? \centerline bad idea
       \hbox{\hskip \saved@totalleftmargin\FrameCommand{\box\tw@}}%
              \else
|               \message{Zero width means likely blank. Don't frame it (guess)}%
                \box\tw@
              \fi
              \hrule \@height\z@
              \eject
              \fb@adjheight
              \put@frame
  \fi\fi\fi\fi\fi
  \ifvoid\@tempboxa\else
%psh: Changed the command that inserts the box:
%     Instead of \centerline, we shift right by \saved@totalleftmargin:
%    \centerline{\FrameCommand{\box\@tempboxa}}%
    \hbox{\hskip\saved@totalleftmargin\FrameCommand{\box\@tempboxa}}%
    \nointerlineskip \null %{\showoutput \showlists}
    \penalty-30 \vskip\topsep
  \fi}

\def\fb@adjheight{%
  \vbox to\FrameHeightAdjust{}% get proper baseline skip from above.
  \penalty\@M \nointerlineskip
  \vskip-\FrameHeightAdjust
  \penalty\@M} % useful for tops of pages

\edef\zero@glue{\the\z@skip}

\catcode`\|=\FrameRestore

% Provide configuration commands:
\providecommand\FrameCommand{\fboxrule=\FrameRule \fboxsep=\FrameSep \fbox}
\@ifundefined{FrameRule}{\newdimen\FrameRule \FrameRule=\fboxrule}{}
\@ifundefined{FrameSep} {\newdimen\FrameSep  \FrameSep =3\fboxsep}{}

% Height of frame above first baseline when frame starts a page:
\providecommand\FrameHeightAdjust{6pt}

% \FrameRestore has parts of \@parboxrestore.  See how it is used in the 
% "settings" argument of \MakeFrame.  Previous behavior can be restored by 
% using \@parboxrestore there, or redefining:
% \makeatletter \renewcommand\FrameRestore{\@parboxrestore} \makeatother
\def\FrameRestore{%
  \let\if@nobreak\iffalse
  \let\if@noskipsec\iffalse
%  \let\par\@@par  ??
  \let\-\@dischyph
  \let\'\@acci\let\`\@accii\let\=\@acciii
%  \parindent\z@ \parskip\z@skip    Definitely omit!
%  \everypar{}%  ??
  \linewidth\hsize
%  \@totalleftmargin\z@
%  \leftskip\z@skip \rightskip\z@skip \@rightskip\z@skip
%  \parfillskip\@flushglue \lineskip\normallineskip
%  \baselineskip\normalbaselineskip
  \sloppy
%  \let\\\@normalcr
}

%  Compatibility with previous versions (temporary!):
\let\fram@d=\MakeFramed  \let\endfram@d=\endMakeFramed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This ends the stuff that's lifted from:
% % framed.sty   v 0.8a   21-Jul-2003
% % Copyright (C) 1992-2003 by Donald Arseneau


%--------------------------------------------------------------------
%--------------------------------------------------------------------

\endinput
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
