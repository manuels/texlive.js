% $StyleId: cweb.doc,v 3.6 1995/11/30 15:44:53 schrod Exp $
%----------------------------------------------------------------------
% Written by Joachim Schrod <schrod@iti.informatik.th-darmstadt.de>.
% Copyright conditions see below (GPL).

%
% LaTeX class cweb
% support for LaTeX markup in CWEB sources
%
% [LaTeX in MAKEPROG]
% (history at end)

% If you have received this style file without the user manual (in the
% file cweb-user.dvi or the respective LaTeX file), it's incomplete and
% near to useless. If it was given to you as something that you shall
% use as an author -- complain bitterly to your provider. You need the
% documentation and you have a right on it! (Below you can find info
% where to get the reference version.)




%%%%
%%%%
%%%% These TeX macros were documented with the documentation system
%%%% MAKEPROG and automatically converted to the current form.
%%%% If you have MAKEPROG available you may transform it back to
%%%% the original input: Remove every occurence of three percents
%%%% and one optional blank from the beginning of a line and remove
%%%% every line which starts with four percents.  The following lex
%%%% program will do this:
%%%%
%%%%	%%
%%%%
%%%%	^%%%\ ?   ;
%%%%	^%%%%.*\n ;
%%%%
%%%%	If you just want to print the documentation you may fetch
%%%% the archive print-makeprog.tar.Z from ftp.th-darmstadt.de (directory
%%%% pub/tex/latex). It contains *all* used styles -- but beware, they
%%%% may not be in a documented form...
%%%%
%%%%
%%% \documentclass{progltx}

%%% \usepackage{cweb-doc}		% document-specific markup
%%% \usepackage{fullpage}


%%% \RCS $StyleRevision: 3.6 $
%%% \RCS $StyleDate: 1995/11/30 15:44:53 $


%%% \begin{document}


%%% \title{The \texttt{cweb} Class\\
%%%     {\large (Implementation)}%
%%%     }
%%% \author{%			% LaTeX does not discard unnecessary glue...
%%%     Joachim Schrod%
%%%     \thanks{%
%%% 	\protect\raggedright
%%% 	TU~Darmstadt, Computer Science Department, WG Systems Programming,
%%% 	Alexanderstr.~10, D-64283~Darmstadt, Germany.
%%% 	Email: \texttt{jschrod@acm.org}%
%%% 	}%
%%%     }
%%% \date{%
%%%     Revision \RCSStyleRevision\\
%%%     (as of \RCSStyleDate)%
%%%     }

%%% \maketitle


%%% % doesn't work with progltx yet
%%% %\tableofcontents



%%% % ------------------------------------------------------------
%%% %
%%% % subdocument: The user interface of cweb.cls
%%% %

%%% \input{cweb-user}

%%% %
%%% % ------------------------------------------------------------
%%% %
%%% % subdocument: The internal interface
%%% %

%%% \input{cweb-conf}

%%% %
%%% % ------------------------------------------------------------




%%% \chap Implementation.

%%% This implementation must typeset complete files output by \cweave{}.
%%% Large parts of this task are available from the module \pkg{cwebbase}.
%%% It remains mainly to implement document-level markup and front and
%%% back matter (table of contents, index, etc.) In particular, the back
%%% matter material is not trivial; its tags are behind |\end{document}|,
%%% we have to read carefully behind the end of our \cweb{} document to
%%% detect if we have to typeset them at all.


%%% \sect This module reserves the namespace |cweb|.

%%% \beginprog
\ifx \cweb@loaded\undefined
    \def\cweb@loaded{$StyleRevision: 3.6 $}
\else
    \PackageWarningNoLine{cweb}%
        {Some other package already uses namespace `cweb'}
\fi
%%% \endprog


%%% \sect Let's identify this class.

%%% \noindent The code below is explained in the implementation
%%% documentation of the \pkg{rcs} package.

%%% \beginprog
\begingroup
    \def\RCSClass#1#2 $#3: #4 #5\endRCS $#6: #7 #8\endRCS{%
	\def\date{#4}\def\id{v#7}%
	\ProvidesClass{#1}[\date\space\id\space #2]%
	}

  \RCSClass{cweb}{LaTeX markup for CWEB sources}
  $StyleDate: 1995/11/30 15:44:53 $: 9999/00/00 \endRCS
  $StyleRevision: 3.6 $: 0.0 \endRCS
\endgroup
%%% \endprog


%%% \sect This module is from a supported bundle. Send bug reports,
%%% comments and repairs.

%%% The reference version may be retrieved via anonymous ftp from
%%% |ftp.th-darmstadt.de| [130.83.47.112], directory
%%% |pub/programming/literate-programming/c.c++/|. It's
%%% placed there as a gzipped tar file. (The information on the IP~number
%%% is dated August~29,~1995.
%%% It might have changed, although this is very unlikely. Use
%%% your friendly nameserver.)


%%% \sect This is freely distributable software; you can redistribute it
%%% and/or modify it under the terms of the GNU General Public License as
%%% published by the Free Software Foundation; either version~2 of the
%%% License, or (at your option) any later version.

%%% This software is distributed in the hope that it will be useful, but
%%% \textbf{without any warranty}; without even the implied warranty of
%%% \textbf{merchantability} or \textbf{fitness for a particular purpose}.
%%% See the GNU General Public License for more details.

%%% You should have received a copy of the GNU General Public License in
%%% the file |License| along with this package; if not, write to the Free
%%% Software Foundation, Inc., 675~Mass Ave, Cambridge, MA~02139,~USA.


%%% \sect Before we start we declare some shorthands for category codes.
%%% By declaring the underscore~`(|_|)' as letter we can use it in our
%%% macros. (I agree with \textsc{D.~Knuth} that
%%% |\identifier_several_words_long| is more readable than
%%% |\IdentifierSeveralWordsLong| and in every case better than |\p@@@s|.)

%%% As this is a \LaTeX{} style file the at sign is a letter anyhow; so
%%% we can use the ``private'' \LaTeX{} macros; and with the underscore we
%%% can make our own macros more readable.  But as we have to restore this
%%% category code at the end of this macro file we store its former value
%%% in the control sequence |\CatUsCode|. This method is better than to
%%% use a group because not all macros have to be defined global this way.

%%% Since somebody might use more styles from me, this cseqs might be
%%% defined already.

%%% \beginprog
\ifx \CatEscape\undefined
    \chardef\CatEscape=0
    \chardef\CatOpen=1
    \chardef\CatClose=2
    \chardef\CatIgnore=9
    \chardef\CatLetter=11
    \chardef\CatOther=12
    \chardef\CatActive=13		% is defined in Plain already

    \chardef\CatUsCode=\catcode`\_
\fi

\catcode`\_=\CatLetter			% top level macro file
%%% \endprog


%%% \sect Problems over problems with different \LaTeX{} versions. I have
%%% decided that I will take the same stand as the \LaTeX{} team: I will
%%% only support the last two official \LaTeX{} versions, folks who run
%%% older software might need to upgrade.

%%% The implementation will use `star'-forms of \LaTeX{}'s command
%%% definition macros. They were introduced with \LaTeX{}
%%% \mbox{$\langle$1994/12/01$\rangle$}.

%%% Currently (as of 07 Nov 95), 1995/06/01 is the most recent version.
%%% I want to use a features introduced with that version: |\newif| is not
%%% outer any more. So I check here for the version and supply the new
%%% definition if necessary.

%%% \beginprog
\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\@ifl@t@r \fmtversion{1995/06/01}{}% else
    {
	\@namedef{newif}#1{%
	    \count@\escapechar \escapechar\m@ne
	    \let#1\iffalse
	    \@if#1\iftrue
	    \@if#1\iffalse
	    \escapechar\count@
	    }
	\def\@if#1#2{%
	    \expandafter\def
	        \csname \expandafter\@gobbletwo\string#1%
		    \expandafter\@gobbletwo\string#2\endcsname {%
		\let#1#2%
		}%
	    }
    }
%%% \endprog




%%% \chap Options.

%%% Our options are of the ``keyword-value'' category. We realize them by
%%% the \pkg{keyvald} package, an enhancement of the \pkg{keyval} package
%%% from the Graphics bundle that supports defaulting for unknown keys.

%%% \begin{fixme}
%%%   Most of the code below should be extracted and moved to a
%%%   \pkg{keyvalx} package (or a new version of \pkg{keyval}). In
%%%   particular, support for package/class option processing, enumeration
%%%   values, and set values for keyword options.
%%% \end{fixme}

%%% |\ProcessKeyValOptions| may be used instead of |\ProcessOptions|, it
%%% takes the keyval set identifier as argument. At the end it evaluates
%%% and resets a hook. That hook may be used at option definition to
%%% define further dependencies. (E.g., enabling that option implies
%%% enabling an other option, too.)
%%% %
%%% \begin{fixme}
%%%   Like |\ProcessOptions|, I define |\@curroptions|, since I don't know
%%%   if that's needed later. The only place where it could been needed is
%%%   in the check for unprocessed options.
%%% \end{fixme}

%%% \beginprog
\RequirePackage{keyvald}

\let\ProcessKeyValOptionsHook\empty
\providecommand*\ProcessKeyValOptions[1]{%
    \edef\@curroptions{\@ptionlist{\@currname.\@currext}}%
    \edef\next{\noexpand\setkeys{#1}{\@curroptions}}%
    \next
    \ProcessKeyValOptionsHook
    \let\ProcessKeyValOptionsHook\empty
    }
%%% \endprog


%%% \sect The enumeration option |structure| selects hierarchic~(0) or
%%% flat~(1) structure. The predefined value is `hierarchic', there is no
%%% default. The option value is bound to |\cweb@structure|.

%%% \beginprog
%% \define@key@enum{cweb}{structure}{hierarchic,flat}[hierarchic]
\@namedef{KV@cweb@structure@enum:hierarchic}{0 }	% <-- space!
\@namedef{KV@cweb@structure@enum:flat}{1 }		% <-- space!
\define@key{cweb}{structure}{%
    \expandafter\let \expandafter\@tempa
    	    \csname KV@cweb@structure@enum:#1\endcsname % \relax if undefined
    \ifx \@tempa\relax
        \PackageError{cweb}%
	    {%
		Invalid value `#1' for option structure%
	    }{%
Possible valid values are `hierarchic' and `flat'.\MessageBreak
The predefined value is `hierarchic'.\MessageBreak
There's no default value, you have to specify one.%
	    }%
    \else
	\let\cweb@structure\@tempa
    \fi
    }
\setkeys{cweb}{structure=hierarchic}
%%% \endprog


%%% \sect With the set option |suppress| one can select suppression of
%%% different document parts: |changehints| suppresses output of hints
%%% that a changefile was involved, |unchanged| output of unchanged
%%% chunks, |index| and |reflist| output of index and reference list, and
%%% |format| output of `|@f|' directives.

%%% The predefined value is no suppression. There is no default value.
%%% %
%%% \begin{fixme}
%%%   Shouldn't I supply a default value? `|{index,reflist}|'?
%%% \end{fixme}

%%% Set options are represented by flags named
%%% |@cweb@|\<option>|@|\<value>|@|.

%%% \beginprog
%% \define@key@set{cweb}{suppress}{changehints,unchanged,index,reflist,format}
\@for \@tempa :=changehints,unchanged,index,reflist,format\do {%
    \expandafter\newif \csname if@cweb@suppress@\@tempa @\endcsname
    \csname @cweb@suppress@\@tempa @false\endcsname
    }%
\define@key{cweb}{suppress}{%
    \@for \@tempa :=#1\do {%
	\expandafter\let \expandafter\@tempb
		\csname @cweb@suppress@\@tempa @true\endcsname
	%% \relax if undefined
	\ifx \@tempb\relax
	    \PackageError{cweb}%
		{%
		    Invalid value `#1' for set option suppress%
		}{%
Possible valid values are `changehints', `unchanged',\MessageBreak
or a comma-separated list of these words enclosed in braces.\MessageBreak
Specified values are turned on, you can't turn them off.\MessageBreak
No value is on initially.\MessageBreak
There's no default value, you have to specify one.%
		}%
	\else
	    \@tempb
	\fi
	}%
    }

\g@addto@macro\ProcessKeyValOptionsHook{%
    \if@cweb@suppress@unchanged@
	\@cweb@suppress@changehints@true
    \fi
    }
%%% \endprog


%%% \sect The base document class may be specified by the option
%%% |baseclass|.

%%% \beginprog
\def\CwebBaseClass{article}
\define@key{cweb}{baseclass}[report]{\def\CwebBaseClass{#1}}
%%% \endprog


%%% \sect Language-specific adaptions are stored in files
%%% \texttt{cwbl-{\it language}.sty}. They may be accessed as packages or
%%% by the |language| option that takes the \textit{language} as value. We
%%% have to require the respective package at the end of the class, then
%%% all cseqs with default names are defined and may be overwritten.

%%% For some languages, we provide Babel-compatible option names, to ease
%%% the usage of global class options taken up by other packages (like
%%% \pkg{varioref}), too.

%%% \beginprog
\def\cweb_set_language#1{%
    \IfFileExists{cwbl-#1.sty}{%
      %% true
	\RequirePackage{cwbl-#1}%
      }{%
      %% false
	\ClassError{cweb}{Language `#1' is unknown.}{%
Language definitions are stored in files `cwbl-<language>.sty'.\MessageBreak
I could not locate the file `cwbl-#1.sty'. If you didn't make a%
\MessageBreak
typo, please check if there is such a file in a directory searched\MessageBreak
by LaTeX.%
	    }%
	}%
    }

\define@key{cweb}{language}{\AtEndOfClass{\cweb_set_language{#1}}}

\define@key{cweb}{german}[]{\setkeys{cweb}{language=german}}
\define@key{cweb}{french}[]{\setkeys{cweb}{language=french}}
\define@key{cweb}{italian}[]{\setkeys{cweb}{language=italian}}
%%% \endprog




%%% \chap Configuration, inheritance, and aggregation.

%%% This chapter sets up access to other modules, therefore we restore the
%%% original catcodes for the time being.

%%% \beginprog
\catcode`\_=\CatUsCode
%%% \endprog


%%% \sect As usual, we provide the possibility to configure this class.

%%% \beginprog
\InputIfFileExists{cweb.cfg}{%
	\typeout{******************************************^^J%
		 *^^J%
		 * Using local configuration file cweb.cfg^^J%
		 *^^J%
		 ******************************************%
		 }%
    }{}
%%% \endprog


%%% \sect Inherit article class.

%%% \beginprog
\ifx \CwebBaseClass\undefined
    \def\CwebBaseClass{article}
\fi
\define@key{cweb}*[]{\PassOptionsToClass{\KV@key}{\CwebBaseClass}}
\ProcessKeyValOptions{cweb}
\LoadClass{\CwebBaseClass}
%%% \endprog


%%% \sect OK, now comes our own code; switch on again our lexical
%%% conventions.

%%% \beginprog
\catcode`\_=\CatLetter
%%% \endprog




%%% \chap Typesetting \cweave{} output.

%%% This task has been out-sourced to an other module, \pkg{cwebbase}. As
%%% mentioned at the start of the implementation, there remain mainly some
%%% bigger tasks, they will be implemented in further sections below. For
%%% the most part, the necessary preconditions are actually our class
%%% option definitions, we don't have to do anything. (Gosh, what a
%%% coincidence. :--) We need to tell \pkg{cwebbase}, that it should use
%%% class warnings on problems.

%%% \beginprog
\let\cweb_warning=\ClassWarningNoLine
\input{cwebbase}
%%% \endprog


%%% \sect But there remain also some small things to be done right now:
%%% For flat structure, the counter |secnumdepth| must be set to~11, then
%%% we want to number chunks in the whole document.

%%% \beginprog
\ifcase \cweb@structure
    %% hierarchic
  \or
    %% flat
    \setcounter{secnumdepth}{11}
\fi
%%% \endprog


%%% \sect \pkg{cwebbase} uses |\part|, |\chapter| (if bound), and
%%% |\section|.  We have no use for any other section division that came
%%% from the base class, let's discard the standard ones.

%%% \beginprog
\let\subsection\undefined
\let\subsubsection\undefined
\let\paragraph\undefined
\let\subparagraph\undefined
%%% \endprog




%%% \chap Table of contents.

%%% The table of contents features only sections, chunks don't have
%%% titles, after all. Titles are indented proportionally to the rank,
%%% with an basic indentation of |\CwebTocIndent|. An entry on major
%%% ranks may be differentiated by layout instead of indentation, as it's
%%% done in standard \LaTeX{} classes, too.

%%% The counter |\CwebTocIndentMaxLevel| constitutes an upper limit for a
%%% recognized indent (concerning indentation, that is).

%%% \beginprog
\newdimen\CwebTocIndent
	\CwebTocIndent=1.5em
\newcount\CwebTocIndentMaxLevel
	\CwebTocIndentMaxLevel=6	% increase indentation if <= max level
%%% \endprog


%%% \sect For hierarchic structure, we can ignore chunk entries
%%% completely, but have to supply a bunch of definitions for entries of
%%% type `|section|$l$'.  But for flat structure, sections are passed as
%%% chunks, too.  Then the current rank is stored in the title, as
%%% |\cwbbRank{|$r$|}|.  These differences are so large that we'll have
%%% to make a very large |\ifcase|, over many chunks in this macro source
%%% file. Let's start with the hierarchic stuff.

%%% \beginprog
\ifcase \cweb@structure
    %% hierarchic
    \def\l@chunk#1#2{}
%%% \endprog


%%% \sect Let's assume that we're subclassed from one of \LaTeX{}'s
%%% standard classes; otherwise this stuff must be redefined, too. They
%%% indent |\section| entries always by the same amount (1.5\,em), our
%%% layout must fit to that.

%%% If we have chapters, they are also indented by 1.5\,em and
%%% distinguished by layout. The first minor section starts on rank~3 and
%%% is placed on level~2, it should be indented larger. Let's simply add
%%% 1.5\,em for each rank, that makes 3\,em for sections of type
%%% |section2|. I.e., we use $f=l$ as a factor for our basic indentation.

%%% If we don't have chapters, the first minor section starts on rank~2
%%% and is placed also on level~2, it should be indented like sections
%%% (1.5\,em), as it will be in another layout. I.e., we use $f=l-1$ as
%%% the indentation factor.

%%% The actual definitions are generated in a loop. `|\l@section|$l$'
%%% expands to `|\cweb@toc_entry{|$l$|}|'. The indentation will be
%%% computed within that macro.

%%% \beginprog
    \count@=2
    \@whilenum \count@<11 \do {
	\expandafter\edef \csname l@section\number\count@\endcsname{%
	    \noexpand\cweb@toc_entry{\number\count@}%
	    }
	\advance \count@ by 1
	}
%%% \endprog


%%% \sect A toc entry may be produced by |\@dottedtocline|. That cseq
%%% needs the level (to decide if that entry is produced after all), the
%%% entry indentation, the inner-entry indentation used for the number,
%%% entry text, and page number.

%%% As explained above, we use an indentation of $f \cdot
%%% |\CwebTocIndent|$, if the level is not larger than
%%% |\CwebTocIndentMaxLevel|. Otherwise we use the indentation of that
%%% level.

%%% Each entry is kind of an item with the number as the label. We need an
%%% inner-entry indentation to be used for subsequent lines within this
%%% entry. If a number is specified, it's tagged by |\numberline| in the
%%% entry text. With a proper local definition and a pro-forma evaluation
%%% of the text, we get at the width of the number (with a fitting space
%%% for separation to text) and can use that as the inner-entry
%%% indentation.

%%% \beginprog
    \def\cweb@toc_entry#1#2{%		% #3 (page) will follow
	%% \count@ == factor for basic indentation
	%%	      min(#1,TocIndentMaxRank) - correct_level
	\ifnum #1>\CwebTocIndentMaxLevel
	    \count@\CwebTocIndentMaxLevel
	\else
	    \count@ #1			% <-- space!
	\fi
	\ifx \chapter\undefined
	    \advance \count@\m@ne
	\fi
	%% \dimen@ == inner-entry indentation
	%% 	      width of number & space, if existing
	\begingroup
	    \global\dimen@ \z@		% assert value
	    \def\numberline##1{\settowidth{\global\dimen@}{##1\enskip}}%
	    \setbox\z@ \hbox{#2}%	% evaluates \numberline if specified
	\endgroup
	\@dottedtocline
		{#1}%			% level
		{\count@ \CwebTocIndent}% % basic indent
		\dimen@			% num width
		{#2}%			% entry; page will follow
	}
%%% \endprog


%%% \sect We're done with toc configuration for hierarchic structure,
%%% since entry definitions for |chapter| and |section| types exist
%%% already. Let's turn over to the flat structure.

%%% \beginprog
  \or
    %% flat
%%% \endprog


%%% \sect The section rank determines how they are featured in the table.
%%% Titles on rank~0 are typeset boldface, other titles are dotted
%%% contents lines in roman.

%%% The rank is specified within the title, i.e., in the
%%% first argument to |\l@chunk|, as an argument for the |\cwbbRank| tag.
%%% With an appropriate definition we might set |\count@| to the
%%% respective value. If it is not set, an explicite invocation of
%%% |\section| or |\addcontentsline| is responsible for this entry. Then
%%% we assume that the rank is~0.

%%% \beginprog
    \def\l@chunk#1{%			% page will be processed later
	\count@\@ne			% default value of group level
	\begingroup
	    \let\numberline\@gobble	% width not known yet
	    \def\cwbbRank##1{\global\count@ ##1\relax}%
	    \setbox\z@ \hbox{#1}%
	\endgroup
	\ifnum \count@=\z@
	    \let\next\cweb@bold_toc_line
	\else
	    \let\next\cweb@normal_toc_line
	\fi
	\next{#1}%
	}
%%% \endprog


%%% \sect A boldface line is typeset similar to the definition of
%%% |\@dottedtocline|, only with fewer parameters. It takes two
%%% parameters, the entry and the page number.

%%% \beginprog
    \def\cweb@bold_toc_line#1#2{%
	\addpenalty{\@secpenalty}%
	\addvspace{1em plus\p@}%
	\begingroup
	    \noindent \bf
	    \hangindent\CwebTocIndent
	    \rightskip\@tocrmarg  \parfillskip -\rightskip
	    \interlinepenalty\@M
	    \@tempdima\CwebTocIndent	% for \numberline
	    #1\nobreak\hfill \hbox to\@pnumwidth{\hss #2}%
	    \par
	\endgroup
	}
%%% \endprog


%%% \sect A normal line uses |\@dottedtocline| like the hierarchic stuff.
%%% Rank~1 shall still be on the same level as the bold toc line, so we
%%% have to use $r-1$ as the proportional factor for |\CwebTocIndent|.

%%% \beginprog
    \def\cweb@normal_toc_line#1{%	% page will be processed later
	\edef\next{\noexpand\@dottedtocline{\the\count@}}% % toc entry level
	\ifnum \count@>\CwebTocIndentMaxLevel
	    \count@ \CwebTocIndentMaxLevel
	\fi
	\advance\count@\m@ne		% group level -= 1
        \next{\count@\CwebTocIndent}%	% basic indent
	     \CwebTocIndent		% numwidth
	     {#1}%			% entry
	}
%%% \endprog


%%% \sect The first argument of |\@dottedtocline| is used to specify a
%%% depth of the issued entry. All entries with a depth larger than
%%% |tocdepth| are discarded. We typeset all entries, our |tocdepth|
%%% value is the largest possible section level.

%%% \beginprog
    \setcounter{tocdepth}{10}
%%% \endprog


%%% \sect That's it. Close our distinction between hierarchic and flat
%%% structure.

%%% \beginprog
\fi
%%% \endprog




%%% \chap The end of the document.

%%% The end of a \cweave{} document is a rather complicated thing. It is
%%% described in detail in the \cweave{} interface specification, we repeat the
%%% most important points shortly.
%%% %
%%% \begin{itemize}

%%% \item The user has issued an |\end{document}| tag in the documentation
%%% part of the last chunk.

%%% This tag is therefore part of a chunk, the chunk end (i.e., the
%%% |\fi| cseq) does appear later in the document. Particularly, this
%%% means that at the accurence of this tag there is still an open |\if|.

%%% \item Between the |\end{document}| and the |\fi| a lot of text may
%%% come which must be ignored. Within this text no |\fi| is allowed.

%%% \item After the |\fi| the document may be finished by |\end|.
%%% (Then the |-x| option of \cweave{} was used.)

%%% Or additional information about the whole document is added: An
%%% optional tag |\ch|, two mandatory tags |\inx\fin|, and another
%%% optional tag |\con|.

%%% \end{itemize}

%%% Btw, the last chunk is marked as changed if any changefile entry has
%%% been applied in the document. (In Plain \cweb{} that chunk is
%%% colloquially used as the introduction to the index, and that shall be
%%% printed always.) If we suppress unchanged chunks, the last
%%% chunk will therefore always be processed, independent if it was really
%%% changed or not. Yet another reason to use a whole chunk just for
%%% |\end{document}|.

%%% We'll use a the following approach for the implementation of the
%%% iidentifier index and the refinement list (remember that we do not
%%% produce a table of contents): We will check if there is any of these
%%% two lists available. The available ones are typeset. Then we'll
%%% finish the document. This functionality will be bound to |\fin|.
%%% |\inx| will be simply a no-op. |\con| will never be reached, so we
%%% don't have to cope with it.


%%% \sect With the introduction of an end-document hook in \LaTeXe{}, one
%%% might have hoped that we can utilize that hook for our task. But this
%%% is not possible: We don't want to add some additional actions
%%% \emph{into} the end-document handling, we want to look ahead and issue
%%% lots of commands \emph{before} the end-document handling has happened.
%%% (If you know \TeX{} by heart, you may skip the rest of the explanation
%%% and go to the next chunk.)

%%% As a macro language, \TeX{}'s cseqs take those tokens as arguments
%%% that are behind them in the token stream. The token stream is
%%% initially the document source, evaluation of a macro pushes its
%%% expansion (a token list) on front of the stream. I.e., the evaluation
%%% of |\end| will push the expansion on the token stream before
%%% |\enddocument| is even looked at. And |\enddocument| will also push
%%% its expansion before the hook is evaluated.

%%% If we would allow |\enddocument| to push its expansion, all these
%%% tokens have to be evaluated after we have typeset the backmatter --
%%% after all, we need a proper document end, don't we?  One would need to
%%% skip over them, look at and eventually evaluate tokens that come
%%% behind (from the initial document stream, the document source), and
%%% then evaluate the skipped tokens. That's too hairy, we don't know
%%% exactly how many tokens to skip, this is probable to change in future
%%% \LaTeX{} revisions, etc.

%%% The pushed tokens from |\end| don't pose so much problems. As
%%% |\enddocument| will terminate the document processing, they are not
%%% evaluated anyhow, we can just throw them away. And |\end| has changed
%%% only once in the last few years, so it seems to be a stable macro --
%%% necessary as we need to know its expansion for propper skipping.

%%% A very first consequence of the demand to process tokens after
%%% |\end{document}| is that we have to save the ``standard'' \LaTeX{}
%%% document termination, since we will execute that later.

%%% \beginprog
\let\cweb@save@enddocument=\enddocument
%%% \endprog


%%% \sect When we encounter |\end{document}| we have to skip tokens
%%% until we reach a |\fi|. Then we establish the correct
%%% environment for the material behind.

%%% The skip itself is actually a bit difficil, so we'll look at it more
%%% closely. |\enddocument| is executed within |\end|. As mentioned above,
%%% the original
%%% definition of |\enddocument| cheats, it terminates \LaTeX{} before
%%% the rest of |\end| is executed. |\end| first checks if we're in
%%% the correct current environment, then it establishs the end
%%% processing for paragraph building environments, closes the
%%% group---each environment is in its own group, executes the end
%%% processing established before, and it may ignore following white
%%% space.

%%% The |document| pseudo-environment is different in that it isn't in a
%%% group. I.e., we have to open a group which can be closed by |\end|
%%% afterwards. The environment check will be done in this group. With
%%% |\aftergroup| we establish a macro which will skip the rest of the
%%% |\end| processing. This processing is not needed anyhow: |document|
%%% is no paragraph building environment and the following white space is
%%% ignored by ourselves. Since |document| is no paragraph building
%%% environment, the end processing described above is empty, i.e., not
%%% existant. Then come a few tokens which ignore the white space. One of
%%% these tokens is a |\fi|, so we have to skip them first separately.
%%% They are discarded by |\cweb@skip_end|, we can start to look
%%% for our |\fi| afterwards.

%%% If |\end{document}| is the first (i.e., the only) text in this chunk
%%% we discard the chunk start marker. This is possible since it isn't set
%%% until now, it's in the |\everypar| token register. Of course, then we
%%% have to do the house keeping work stored in |\everypar| ourselves.

%%% \beginprog
\def\enddocument{%
    \if@noskipsec
	\global\everypar{}%
	\global\@noskipsecfalse
	\global\@nobreakfalse
	\global\clubpenalty\@clubpenalty
    \fi
    \begingroup
	\aftergroup\cweb@skip_end
    }
%%% \endprog


%%% \sect Let's make sure that the expansion of |\end| is the one that we
%%% expect. Then we can define |\cweb@skip_end| appropriately, we have to
%%% skip 5~tokens.

%%% \beginprog
\CheckCommand*\end[1]{%
  \csname end#1\endcsname\@checkend{#1}%
  \expandafter\endgroup\if@endpe\@doendpe\fi
% 1         2      3            4            5
  \if@ignore\global\@ignorefalse\ignorespaces\fi}

\def\cweb@skip_end#1#2#3#4#5{\cweb@check_fi}
%%% \endprog


%%% \sect |\cweb@check_fi| gets the next token, and invokes
%%% |\cweb@do_check_fi| who really checks it. If this token is |\fi| we
%%% can prepare to finish our document. Otherwise we have to check the
%%% next token.

%%% Of course, first the token we have checked already must be discarded.
%%% Therefore we insert the followup action by |\afterassignment|. It's
%%% important that the assignment gets \emph{only} the next token, we
%%% have to supply both the equals sign and the optional blank which are
%%% allowed between the both arguments to |\let|.

%%% \beginprog
\def\cweb@check_fi{%
    \futurelet\next \cweb@do_check_fi
    }
\def\cweb@do_check_fi{%
    \ifx \next\fi
	\afterassignment\cweb@finish
    \else
	\afterassignment\cweb@check_fi
    \fi
    \let\next=			% <-- blank!!
    }
%%% \endprog


%%% \sect When we found the |\fi|, we also discard it. But we're still
%%% within a chunk, i.e., there is an open |\if|. So we must supply the
%%% |\fi|.

%%% \TeX{}nical note: |\next| is now equivalent to |\fi|. It must not be
%%% used within a loop where it denotes the tail recursion's action. I.e.,
%%% code like
%%%  %
%%% \begin{verbatim}
%%%     \ifx \foo\bar
%%%         \let\next\relax
%%%     \else
%%%         \let\next\continue
%%%     \fi
%%%     \next
%%% \end{verbatim}
%%%  %
%%% will fail. This trap is closed by a redefinition of |\next|.

%%% The output of all following lists may be suppressed by some option.
%%% That is tested at the place where the respective list shall be
%%% produced.

%%% All following lists are typeset in CR state.

%%% \beginprog
\def\cweb@finish{%
    \fi
    \let\next\relax
    \let\ch\cweb@changed_list
    \let\inx\relax
    \let\fin\cweb@end_document
    \let\end\cweb@save@enddocument
    \cwbb@CR
    }
%%% \endprog


%%% \sect The following lists are started with unnumbered section
%%% divisions. They are either chapters or sections.

%%% \beginprog
\ifx \chapter\undefined
    \let\CwebListSectionDiv=\section
\else
    \let\CwebListSectionDiv=\chapter
\fi
\def\CwebListSection{\CwebListSectionDiv*}
%%% \endprog


%%% \sect The list of changed chunks is a cross reference list, (nearly)
%%% like all others at the end of a chunk. The only difference is that
%%% we do not show changeflags any more---each chunk number in this list
%%% carries a change flag by definition.

%%% \TeX{}nical note: The redefinition of |\*| is part of the second
%%% argument of |\CwebCrossRef|. It is \emph{not} a global redefinition.

%%% \beginprog
\def\CwebCRChanged{%
    \CwebCrossRef{The following chunks were changed by the change file:}%
    }
\def\CwebChangedListName{Changed Chunks}

\if@cweb@suppress@changehints@
    \def\cweb@changed_list#1.{}
\else
    \def\cweb@changed_list{%
	\CwebListSection{\CwebChangedListName}%
	\@mkboth{\uppercase{\CwebChangedListName}}%
		{\uppercase{\CwebChangedListName}}%
	\message{\CwebChangedListName}%
	\let\CwebCRSize\relax
	\CwebCRChanged \let\*\relax
	}
\fi
%%% \endprog


%%% \sect As outlined above, we want to check if there are any entries in
%%% the identifier index or the refinement list. The former is stored in
%%% the file |\jobname.idx|, the latter in the file |\jobname.scn|.

%%% We write a macro |\cweb@if_file_not_empty| that's like |\IfFileExists|.

%%% \beginprog
\def\cweb@end_document{%
    \cweb@if_file_not_empty{\jobname.idx}{%
	\if@cweb@suppress@index@ \else
	    \CwebIdIndex
	\fi
	}{}%
    \cweb@if_file_not_empty{\jobname.scn}{%
	\if@cweb@suppress@reflist@ \else
	    \CwebRefList
	\fi
	}{}%
    \cweb@save@enddocument
    }
%%% \endprog


%%% \sect The paragraph layout for both the index and the refinement list
%%% is much the same, it is taken from Plain \cweb{}: Each entry is a
%%% paragraph, nearly no skip between the paragraphs (just a bit to
%%% prevent underfull vboxes), no paragraph indentation, ragged right.
%%% Overfull hboxes in the lists don't make sense, so we prevent them. And
%%% we don't allow hyphenation.

%%% \beginprog
\def\cweb@list_par_layout{%
    \parskip \z@ plus .5\p@
    \parindent\z@
    \rightskip \z@ plus 2.5em
    \tolerance\@M \hyphenpenalty\@M
    }
%%% \endprog


%%% \sect We consider a file as ``not empty'' if (1)~the file exists,
%%% (2)~is not empty, and (3)~has a non-empty line at the very front.  (In
%%% fact, an empty line at the front means that there should not be
%%% anything behind it---but we can't test this portably.)

%%% |\cweb@if_file_not_empty| tests the property, it's parametrized by the
%%% file name and gets passed actions for the true and the false case.

%%% We open the file first. Then we check if it doesn't exist or if it's
%%% empty, both conditions deliver true on |\ifeof|; in this case we
%%% pretend that there was an empty line. (The \LaTeX{} kernel already
%%% once provided a macro for an empty line, |\@defpar|, we repeat that
%%% definition here since it was discarded there.) Otherwise we read the
%%% first line. At this state, the emptiness of the first line is
%%% equivalent to the non-availability of entries, we can easily construct
%%% an appropriate macro call to set the flag.

%%% \beginprog
\def\@defpar{\par}
\def\cweb@if_file_not_empty#1#2#3{%
    \openin\@inputcheck #1\relax
    \ifeof \@inputcheck
	\let\next\@defpar
    \else
	\read\@inputcheck to \next
    \fi
    \closein\@inputcheck
    \ifx \next\@defpar
        \def\reserved@a{#3}%
    \else
        \def\reserved@a{#2}%
    \fi
    \reserved@a
    }
%%% \endprog


%%% \sect The identifier index is available in the file |\jobname.idx|.
%%% The setup for the index is a mixture of the |theindex| environment of
%%% the \cls{article} class and DEK's index macros. It's typeset in two
%%% columns; the user may specify an introductionary text for the index
%%% by |\cwebIndexIntro|. If there is any introductionary text we add a
%%% medium skip below.

%%% For the index, |\parfillskip| set in such a way that almost empty
%%% lines are avoided.

%%% Before we read in this file, we have to bind the special cseqs used
%%% therein.

%%% \begin{fixme}
%%%   \LaTeX{} feature or bug? The optional argument of |\twocolumn| is
%%%   typeset as a vbox, therefore the space at top of the section heading
%%%   is not discarded at the top of a page. But we know that |\twocolumn|
%%%   will start a page in any case, we must prevent the addition of this
%%%   space. Looking in the source, we see that setting the flag
%%%   |@nobreak| will prevent this addition, let's do that as a
%%%   workaround. File a \LaTeX{} bug report?
%%% \end{fixme}

%%% \begin{fixme}
%%%   Surprise: If |@nobreak| is set \emph{and} if there are no index
%%%   entries, |\twocolumn| will drop its optional argument. (That
%%%   happened to be noticed when there was an error in
%%%   |\cweb@if_file_not_empty|.) File a \LaTeX{} bug report?
%%% \end{fixme}

%%% \begin{fixme}
%%%   If |\CwebListSection| is a chapter tag of the standard classes, that
%%%   macro will check if it's in twocolumn mode and will try to set
%%%   itself at the top of the current page in full width, as it would
%%%   have been given in an optional argument of |\twocolumn|. As the
%%%   method that optional argument uses (a float) must not be nested, we
%%%   must prevent this to happen. We set the |@twocolumn| flag to false,
%%%   chapter macros will then think they're evaluated in a one-column
%%%   document.  It's debatable if that is a kludge or even \emph{the}
%%%   solution -- after all, within the optional argument we aren't in
%%%   twocolumn mode any more. File a \LaTeX{} bug report?
%%% \end{fixme}

%%% \beginprog
\newtoks\cwebIndexIntro
	\cwebIndexIntro={}
\def\CwebIdIndex{%
    %% two column format
    \columnseprule\z@
    \columnsep 35\p@			% value is from article.sty
    %% introduction of index
    \twocolumn[%
	\cwbb@tex
	\@nobreaktrue			% don't add space in front of section
	\@twocolumnfalse		% \CwebListSection might be \chapter
	\CwebListSection{\indexname}%
	\edef\intro{\the\cwebIndexIntro}% % is a local def
	\ifx \intro\empty
	\else
	    \the\cwebIndexIntro\unskip
	    \par\medskip
	\fi
	]%
    \@mkboth{\uppercase{\indexname}}{\uppercase{\indexname}}%
    \message{\indexname:}%	% tell the user what we're doing
    %% paragraph layout
    \cweb@list_par_layout
    \parfillskip \z@ plus .6\hsize
    %% bindings
    \let\I\CwebIndexEntry
    \let\[\CwebIndexDeclared
    \let\*\cwbb@change_flag
    %% read the index
    \CwebReadIndex
    }
\def\CwebReadIndex{\@input{\jobname.idx}}
%%% \endprog


%%% \sect An index entry is typeset with the same hanging indentation like
%%% a cross reference list.

%%% The entry is tagged with |\.|, if it was entered by the \cweb{}
%%% operator~`|@.|'. Then it shall be typeset as a string. But an indexed
%%% name may also want to use |\.| as an accent. This is the same
%%% situation as we had at the refinement names (in module
%%% \pkg{cwebbase}), where we introduced |\cwbb@check_dot| to handle this
%%% case. The same minor restriction as there holds here, a refinement
%%% name may not consist of a single dot-accented expression. (|@:|~helps
%%% in this singular case.)

%%% \beginprog
\def\CwebIndexEntry#1, {%
    \par
    \hangindent\CwebNumberListHangindent
    \leavevmode
    \cwbb@check_dot{#1}:\quad
    }
%%% \endprog


%%% \sect The chunks where identifiers are declared are noted with
%%% underlined numbers. We also must not forget the default declaration of
%%% |\9|, the tag for the user definable index layout.

%%% \beginprog
\def\CwebIndexDeclared#1]{$\underline{#1}$}
\def\9#1{}
%%% \endprog


%%% \sect The list of the refinement names is available in the file
%%% |\jobname.scn|. The layout is taken from the plain version: ragged
%%% right, each entry is a paragraph, the different cross reference
%%% categories are separated by a quad.

%%% We must initialize our whole paragraph layout, as the index might have
%%% been suppressed and no initialization has happened there then. If
%%% there was an index, it changed |\parfillskip| and |\*|, let's restore it.

%%% \beginprog
\def\CwebRefListName{List of Refinements}

\def\CwebRefList{%
    %% paragraph layout: like in index, but
    \onecolumn
    \cweb@list_par_layout
    \parfillskip\@flushglue		% must be reset before section heading
    \CwebListSection{\CwebRefListName}%
    \@mkboth{\uppercase{\CwebRefListName}}%
	    {\uppercase{\CwebRefListName}}%
    \message{\CwebRefListName:}%
    %% different bindings
    \def\I{\par \hangindent\CwebNumberListHangindent}%
    \def\CwebCrossRef##1##2.{\quad {\reset@font\footnotesize ##1~##2.}}%
    \let\Q\CwebXRCite
    \let\Qs\CwebXRCites
    \let\U\CwebXRUse
    \let\Us\CwebXRUses
    \let\*\cwbb@change_flag
    %% Read the list, allow configuration first.
    \csname CwebRefListHook\endcsname
    \CwebReadPPList
    }
\def\CwebReadPPList{\@input{\jobname.scn}}
%%% \endprog


%%% \sect Extra definitions for the sake of internationalization.

%%% \beginprog
\def\CwebXRCite{\CwebCrossRef{Cited in chunk}}
\def\CwebXRCites{\CwebCrossRef{Cited in chunks}}
\def\CwebXRUse{\CwebCrossRef{Used in chunk}}
\def\CwebXRUses{\CwebCrossRef{Used in chunks}}
%%% \endprog



%%% \chap The end.

%%% Well, after all we're finished with this class. We must not forget to
%%% restore the underscore catcode.

%%% \beginprog
\catcode`\_=\CatUsCode

\endinput
%%% \endprog


%%% \sect I would like to thank those who helped me to improve this module.
%%% % In particular, XXX provided XXXsubstantial parts of the code.

%%% \textsc{Michael M\"uller} and \textsc{Zden\v{e}k Wagner} did thorough
%%% checks that helped me to improve the alpha test version.


%%% 
%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% \vskip \PltxPreSectSkip

%%% \begin{rcslog}
%%% $StyleLog: cweb.doc,v $
%%% \Revision 3.6 1995/11/30 15:44:53 schrod
%%% Still didn't work with version \mbox{$\langle$1994/12/01$\rangle$},
%%% the copy of |\newif| was not complete.\\
%%% Problem reported by Michael Seel \path|<seel@mpi-sb.mpg.de>|.

%%% \Revision 3.5 1995/11/20 22:34:18 schrod
%%% Add language support.\\
%%% Triggered by Christian Kumpf \path|<smurf@igd.fhg.de>| and Andreas
%%% Scherer \path|<scherer@physik.rwth-aachen.de>|.

%%% Use my `official' (ACM) email address.

%%% \Revision 3.4 1995/11/07 17:55:18 schrod
%%%     \LaTeX{} \cweb{} should work at least with the last two \LaTeX{}
%%% versions; make it work with the previous-to-last one, version
%%% \mbox{$\langle$1994/12/01$\rangle$}. For that, one has to install the
%%% \mbox{$\langle$1995/06/01$\rangle$} (non-outer) definition of
%%% |\newif|, and |\hb@xt@| must not be used.\\
%%% Problem reported by Laurent Desnogues
%%% \path|<laurent.desnogues@aiguemarine.unice.fr>| and somebody else (XXX
%%% -- add name).

%%% \Revision 3.3 1995/09/17 14:15:36 schrod
%%% Initialize list paragraph layout in refinement list, too. With the
%%% introduction of index suppression, the initialization -- located in
%%% the index code -- might have been skipped.

%%% \Revision 3.2 1995/09/15 10:22:59 schrod
%%% The \cls{cweb} class needs at least \LaTeX{} version
%%% \mbox{$\langle$1994/12/01$\rangle$}.\\
%%% Problem reported by John S. Robinson \path|jsrobin@umiacs.umd.edu|.

%%% \Revision 3.1 1995/09/12 23:00:48 schrod
%%% Moved all code that does the actual typesetting of \cweave{} tags and
%%% is therefore also needed for a |cweb| environment. It's now an own
%%% module named \pkg{cwebbase}.

%%% \Revision 2.8 1995/09/12 11:44:33 schrod
%%% Standard base classes with chapters (i.e., report \& book) produced an
%%% error at the start of the index: |\chapter| may not be called in the
%%% optional argument of |\twocolumn|. Add a workaround to |\twocolumn|.\\
%%% Problem reported by Christopher Higgins \path|<C.Higgins@cit.gu.edu.au>|.

%%% \Revision 2.7 1995/08/29 17:32:36 schrod
%%% Add hook for refinement list.

%%% Allow internationalization of refinement list.\\
%%% (Problem reported by Christian Kumpf \path|<kumpf@igd.fhg.de>|.)

%%% Cweb bundle, version 1.0.

%%% \Revision 2.6 1995/08/29 15:19:50 schrod
%%% Added (hint to non-existence of) description of the internal interface.

%%% \Revision 2.5 1995/08/29 02:07:26 schrod
%%% Discard dependencies on 10\,pt fonts.

%%% Support suppression of format directives.

%%% \Revision 2.4 1995/08/27 19:31:43 schrod
%%% Discard superfluous space at the top of index. Spacing in refinement
%%% heading was wrong. Repair test on empty auxilliary files. Make
%%% section heading for index and refinement list divisions (more)
%%% configurable. Suppression of index and reference list is supported.

%%% Make configuration of change flag easier.

%%% Put section title of changed chunks list in marks, and tell the user
%%% that it got typeset.

%%% \Revision 2.3 1995/08/27 17:24:46 schrod
%%% Make usage of baseclass with chapters work.

%%% \Revision 2.2 1995/08/27 13:26:22 schrod
%%% Add possibility to suppress change hints. Suppression of unchanged
%%% chunks suppress change hints as well, they are meaningless as all
%%% printed chunks are changed by definition.

%%% Realize dependencies in options by |\ProcessKeyValOptionsHook|.
%%% Illegal values for enumeration options don't alter the current value
%%% any more.

%%% List of changed chunks is an unnumbered section now.

%%% \Revision 2.1 1995/08/25 19:11:18 schrod
%%% Add keyword-value option style, with new \pkg{keyvald} package.

%%% Hierarchic strucutures are supported now, in addition to the flat
%%% structure of the beta-test version. One can choose with an option. For
%%% that step, the terminology was cleaned up, too: Chunks are not named
%%% sections any more. (That change involved reimplementation of almost
%%% all the structure and toc stuff.)

%%% The chunk number supplied by \cweave{} is used now, not some computed
%%% number. Change flags are printed, too.

%%% One can suppress output of unchanged sections.

%%% One can select the baseclass with an option. That may be used to use
%%% \cls{report} or \cls{book} to get chapter-style layout. Of course,
%%% using an arbitrary baseclass is dangerous, it must conform to the
%%% conventions of \LaTeX{} standard classes.

%%% \Revision 1.13 1995/08/08 00:14:29 schrod
%%% Updated to \LaTeXe{}, the |cweb| style is now a document class. Used
%%% my standard templates for that, no changes in functionality.

%%% \Revision 1.12  1993/08/10  14:15:43  schrod
%%% New page on main section only if group level $<$ |\cwebSecNoEject|.
%%% Default for the latter is 3.

%%% Document that logos will not be defined in this style file.

%%% Copy of plain macros for |\CwebNumber| does not work. Repaired the
%%% most important one (subscript must be accessed via |\sb|).
%%% Incompatibility to NFSS will be addressed later.\\
%%% (Problems reported by Zden\v{e}k Wagner \path|<wagner@csearn.bitnet>|.)

%%% \Revision 1.11  1993/08/10  11:21:07  schrod
%%% Reference to section number does not render a period after the
%%% number any more.

%%% \Revision 1.10  1993/08/09  20:08:20  schrod
%%% |\cweb@cweave_bindings| is now a no-op if \cweave{} bindings are in
%%% effect already.\\
%%% (Problem reported by Michael M\"uller \path|<mimu@mpi-sb.mpg.de>|.)

%%% \Revision 1.9  1993/08/09  18:05:28  schrod
%%% Left shift operator wasn't defined correctly.\\
%%% (Problem reported by Michael M\"uller \path|<mimu@mpi-sb.mpg.de>|.)

%%% \Revision 1.8  1993/06/15  15:22:30  schrod
%%% \textbf{Version 0.2:} Moved from |pub/incoming| to official place, in
%%% Literate Programming Archive.

%%% \Revision 1.7  1993/06/15  13:25:48  schrod
%%% First attempt to make it a style: |article| is imported. Warns the
%%% user if he tries to use |cweb| as a style option.

%%% \Revision 1.6  1993/06/15  08:49:23  schrod
%%% |\cweb@check_dot| must not evaluate its argument in an |\edef|, this
%%% causes problems if a |\PB| is within. Now I try hard not to evaluate any
%%% tokens outside of my control.

%%% Can use |\@defpar| for an empty line in |\cweb@has_entries|, don't
%%% need an own macro.

%%% \Revision 1.5  1993/06/14  17:50:30  schrod
%%% Handle a missing |\con|: |\inx| and |\con| are now never looked at.
%%% Instead |\fin| checks for the existence of the lists and typeset them
%%% if there are entries available.

%%% \Revision 1.4  1993/06/14  15:54:18  schrod
%%% Made it work with older versions of \LaTeX{}, too. The |\enddocument|
%%% implementation of cweb.sty depends on the |\end| implementation; check
%%% if the current implementation is one we know of (currently: 91-01-14
%%% and 92-03-25).\\
%%% (Problem reported by Michael M\"uller \path|<mimu@mpi-sb.mpg.de>|.)

%%% Add FSA diagram about processing states. CR state is also switched
%%% to from \TeX{} state (that happens with |\ch| at the document end).

%%% \Revision 1.3  1993/05/13  17:51:21  schrod
%%% Refinements may also be filenames (`|@(|'). Then the complete name
%%% consists of a |\.| macro call, which is handled now.\\
%%% (Problem reported by Michael M\"uller \path|<mimu@mpi-sb.mpg.de>|.)

%%% Made the detection of `|@.|' index entries more robust.

%%% \Revision 1.2  1993/05/12  18:28:59  schrod
%%% Adapted to recent changes of \cweave{} (of April 93):

%%% Main sections have a group level, represented in the table of
%%% contents. This changed the complete implementation of section tags.

%%% New C token cseqs: |\Z| and |\MRL|, implemented as |\CwebLe| and
%%% |\CwebCombinedOp|.

%%% \Revision 1.1  1993/04/09  15:00:37  schrod
%%% Initial revision

%%% \end{rcslog}



%%% \end{document}


%%% 
%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Local Variables:
%%% mode: LaTeX
%%% TeX-brace-indent-level: 4
%%% indent-tabs-mode: t
%%% TeX-auto-untabify: nil
%%% TeX-auto-regexp-list: LaTeX-auto-regexp-list
%%% compile-command: "make cweb.cls"
%%% End:
