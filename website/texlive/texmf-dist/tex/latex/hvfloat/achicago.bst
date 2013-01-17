%^^A* legal notices
% \iffalse
%
%   This program is part of the Frankenstein bundle for LaTeX.  
%
%   Copyright 1995-2001 Matt Swift <swift@alum.mit.edu>.
%
%   This file contains both the code and documentation for the
%   achicago BibTeX style.  It will work ONLY if it is placed in a
%   proper directory.  Files called README, INSTALL, achicago.tex
%   and achicago.ins should have also been distributed to you
%   with this file.  See them for more information on how to typeset
%   the documentation with LaTeX and how to generate a version of this
%   file that will work faster than this one.
%
%   This program is free software; you may redistribute it and/or
%   modify it under the conditions of the LaTeX Project Public
%   License, either version 1.2 or (at your option) any later version.
%   The latest version of this license is in
%   http://www.latex-project.org/lppl.txt, and version 1.2 or later is
%   part of all distributions of LaTeX version 1999/12/01 or later.
%
%   This program is distributed in the hope that it will be useful,
%   but without any warranty; without even the implied warranty of
%   merchantability or fitness for a particular purpose.  See the
%   LaTeX Project Public License for more details.
%
% \fi  
%
%^^A* checks
%
%^^A NOTE:  The character table, with two %'s, will get written to all files.
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
%
% \CheckSum{46}
%
%^^A** new macros
% \newlet    \entry\WrapquotesIN
% \newcommand*\field [1] {{\textitswitch\WrapquotesIN{#1}}}
% \newlet    \gvar\texttt  ^^A global variable
% \newlet    \evar\texttt  ^^A entry  variable
% \newcommand*\function [1] {\texttt{\bfseries #1}}
% \newcommand\stack [2] {\par{\ttfamily #1 $\mapsto$ #2}\par}
% \newcommand\defentrytype [3] {Required: #1\par Optional: #2\par#3}
% \newcommand*\builtin [1] {\code{#1}\$}
%
% \todo{explain conventions; put some in \package{compsci}}
%
%^^A** nocites
% \nocite{*} ^^A FIX remove for distribution
% \nocite {abrams:natural}
% \nocite {ackerley:beckett:augustine}
% \nocite {amiran:beckett:wandering}
% \nocite {bair:beckett:bio}
% \nocite {beckett:cspr}
% \nocite {beckett:godot}
% \nocite {beckett:letter:yellow}
% \nocite {beckett:notebook:krapp,beckett:notebook:godot,^^A
%          beckett:notebook:endgame,beckett:notebook:happy}
% \nocite {beckett:yellow}
% \nocite {blake:job}
% \nocite {bloom:anxiety:1}
% \nocite {bloom:beckett:trilogyintro}
% \nocite {borges:ficciones}
% \nocite {brater:beckett:why}
% \nocite {bryden:beckett:god}
% \nocite {bryden:beckett:smiles}
% \nocite {buning:beckett:via}
% \nocite {burrows:beckett:interview}
% \nocite {calder:beckett:bair}
% \nocite {carey:beckett:introjoyce}
% \nocite {carey:beckett:pieta}
% \nocite {carroll:dante:purgatorio,dante:mandelbaum:purgatorio,%
%          dante:ciardi:purgatorio,vernon:dante:purgatorio}
% \nocite {carroll:dante:purgatorio}
% \nocite {cassedy:group}
% \nocite {chambers-murray}
% \nocite {chicago:14}
% \nocite {coetzee:beckett:revisions,stevenson:beckett:lobster}
% \nocite {coetzee:beckett:revisions}
% \nocite {cohn:beckett:play}
% \nocite {common-prayer}
% \nocite {companion:mind,gleitman:psych}
% \nocite {companion:mind}
% \nocite {copleston:phil:cusa}
% \nocite {copleston:phil:pseudo}
% \nocite {cronin:beckett:modernist}
% \nocite {culik:beckett:math}
% \nocite {culik:beckett:watt}
% \nocite {dante:ciardi:paradiso}
% \nocite {dante:ciardi:purgatorio}
% \nocite {dante:mandelbaum:purgatorio}
% \nocite {dearlove:beckett:residual}
% \nocite {donne:paradoxes}
% \nocite {driver:beckett:madeleine}
% \nocite {ellis:beckett:surds}
% \nocite {ellmann:joyce}
% \nocite {empson:ambiguity}
% \nocite {euclid:elements:brit}
% \nocite {farrow:beckett:art}
% \nocite {federman:beckett:works}
% \nocite {fergusson:dante:purgatorio}
% \nocite {fletcher:beckett:art}
% \nocite {freud:btpp:norton}
% \nocite {frye:anatomy:bate}
% \nocite {gardner:circus:cyclic}
% \nocite {gascoigne:works:posies}
% \nocite {gates:beckett:goon}
% \nocite {gleitman:psych}
% \nocite {gontarski:beckett:undoing}
% \nocite {green:beckett:augustine}
% \nocite {green:beckett:niente}
% \nocite {greene:repentance}
% \nocite {harper:beckett:irish,zurbrugg:beckett:irish,^^A
%          harrington:beckett:local,obrien:beckett:country}
% \nocite {harvey:beckett:poet}
% \nocite {heraclitus:kirk:cosmic}
% \nocite {hill:vaughan}
% \nocite {hobson:beckett:year}
% \nocite {hopkins:gardner}
% \nocite {iser:beckett:negativity}
% \nocite {israel:beckett:bair}
% \nocite {james:principles}
% \nocite {jewinski:beckett:epiphany}
% \nocite {jones:beckett:murphy}
% \nocite {joyce:kershner:portrait}
% \nocite {joyce:ulysses:gabler}
% \nocite {joyce:wake}
% \nocite {juliet:beckett:conversations}
% \nocite {jung:psych-lit}
% \nocite {jung:tav:3}
% \nocite {jung:tav}
% \nocite {kennedy:beckett:murphy}
% \nocite {kenner:beckett:study}
% \nocite {kenner:beckett:syntax}
% \nocite {knowlson:beckett:frescoes}
% \nocite {knowlson:beckett:life}
% \nocite {koffka:gestalt}
% \nocite {krance:beckett:physics}
% \nocite {kroll:beckett:bel}
% \nocite {lakoff:johnson,lakoff:women,johnson:body}
% \nocite {lees:beckett:music}
% \nocite {levy:beckett:conv}
% \nocite {lippman:beckett:noti}
% \nocite {lodge:beckett:ping}
% \nocite {marculescu:beckett:solipsism}
% \nocite {mchugh:wake}
% \nocite {mcmillan:beckett:allegory}
% \nocite {merwin:ladders}
% \nocite {milton:riverside:paralost}
% \nocite {miskinis:beckett:recurrrence}
% \nocite {montgomery:beckett:quantum}
% \nocite {mood:beckett:system}
% \nocite {murphy:beckett:criticism}
% \nocite {niven:numbers}
% \nocite {norton:english}
% \nocite {obrien:beckett:country}
% \nocite {obrien:dreamforward}
% \nocite {ohara:beckett:jung:jobs,ohara:beckett:freud:jobs}
% \nocite {ohara:beckett:valery}
% \nocite {opie:nursery}
% \nocite {ovid:loeb}
% \nocite {perkins:romantic}
% \nocite {pilling:beckett:companion}
% \nocite {posnock:beckett:valery}
% \nocite {princeton:poetics}
% \nocite {rabinovitz:beckett:aphorisms}
% \nocite {rabinovitz:beckett:development,rabinovitz:beckett:innovation}
% \nocite {rabinovitz:beckett:development}
% \nocite {rabinovitz:beckett:innovation}
% \nocite {rabinovitz:beckett:psych}
% \nocite {random,OED:2,heritage,webster:3}
% \nocite {random}
% \nocite {renaud:beckett:mag}
% \nocite {ricks:beckett:dying}
% \nocite {rudin:math:analysis}
% \nocite {sacks:wife}
% \nocite {scruton:beckett:descartes}
% \nocite {segre:beckett:ping}
% \nocite {sharp:folksongs}
% \nocite {shenker:beckett:moody}
% \nocite {shimony:newphys}
% \nocite {smith:beckett:aporia}
% \nocite {stern:beckett:inter}
% \nocite {stevenson:beckett:lobster}
% \nocite {swift:tub}
% \nocite {topsfield:beckett:humour}
% \nocite {unger:ayer:exist}
% \nocite {vernon:dante:purgatorio}
% \nocite {webster:3}
% \nocite {winston:beckett:footnote}
% \nocite {wolfson:religion:history}
% \nocite {wolosky:beckett:mysticism}
% \nocite {work:folksongs}
% \nocite {zeifman:beckett:religion}
% \nocite{acheson:beckett:murphy}
% \nocite{anspaugh:beckett:faith}
% \nocite{bair:beckett:bio}
% \nocite{beckett:pricks}
% \nocite{carey:beckett:joyce}
% \nocite{cohn:beckett:collection}
% \nocite{common-prayer}
% \nocite{connor:beckett:animals}
% \nocite{davies:beckett:ideal}
% \nocite{eliot:middlemarch:random}
% \nocite{farrow:beckett:art}
% \nocite{freud:btpp:norton}
% \nocite{harvey:beckett:poet}
% \nocite{joyce:dubliners}
% \nocite{juliet:beckett:conversations}
% \nocite{jung:tav}
% \nocite{kroll:beckett:bel}
% \nocite{linden:herbert}
% \nocite{mccarthy:beckett:essays}
% \nocite{mcmillan:beckett:allegory}
% \nocite{melville:dick:newberry}
% \nocite{murphy:beckett:criticism}
% \nocite{norton:modern}
% \nocite{obrien:beckett:country}
% \nocite{obrien:dreamforward}
% \nocite{pilling:beckett:before}
% \nocite{putnam:beckett:caravan}
% \nocite{rabinovitz:beckett:aphorisms}
% \nocite{rabinovitz:beckett:development}
% \nocite{rabinovitz:beckett:innovation}
% \nocite{random}
% \nocite{ricks:beckett:dying}
% \nocite{scruton:beckett:descartes}
% \nocite{stern:beckett:inter}
% \nocite{whitman:leaves:norton}
%
%^^A** abstract
% \begin{abstract}
%   \manual bibliography style \BibTeX{} macros.
% \end{abstract}
% \tableofcontents
%
% \part{Discussion}
%
% \caveat{The dox are spotty for this bibstyle---sorry!  This is a pretty
% stable style, however.  I've included almost my entire test cases.  If you're
% puzzled, you may compare \file{frankenstein.bib} with what you see in the
% References section at the end of this document.  Or please write me.}
%
% Reference list ordering: alphabetical by author or whatever passes for author
% in the absence of one.
%
% \section{Pros and cons of this style}
%
%   See a discussion in the documentation for the \package{achicago} package.
%
% \section{User documentation}
%
% \AddToCheckSum{-10} ^^A In this file we don't have the usual 5 version \defs
% \AddToCheckSum{-2}  ^^A Subtract two more for the \initelyHavECitationS def
% \AddToCheckSum{-24} ^^A Sum of 17 and 7 in part-3.dtx
% 
% No bibstyle is going to elgantly handle everything while using them in a way
% that's at all compatible with the majority of existing bibstyles out there.
% And it's not clear that such a bibstyle would be worth the effort to write
% and learn to use properly.  The time would be better spent, I think, writing
% some macros to make inserting hand-done exceptions seamlessly into the
% bibliography, so that the whole process could remain clean and automatic.
%
% For the sceptical, and for your entertainment, an example.  I wanted to a
% cite a certain paper by Freud in my dissertation.  The cited paper has a
% title, date of first publication, and chapter number; I read this paper in a
% volume of Freud's papers with a title, volume editor, volume date, publisher,
% reprint date, and reprint publisher; this volume has a number in a series of
% publications (The International Psycho-Analytic Library) with a series
% editor; and also this volume has a volume number within a multivolume work
% with its own title (\book{Collected Papers}) and (supervising)
% translator.  Readers honestly don't need all that information, but each one
% of those 15 pieces of information might be highly important for another
% citation, for which only two or three pieces of information were relevant or
% available.  No one needs to write a bibstyle that handles it all, so at
% several places, the fields are assumed to be used for either one thing or
% another.  For example, \field{series} \emph{either} contains the title of the
% inclusive multivolume work \emph{or} the series.  When, as rarely happens, a
% volume is part of both at once, you have to give up one or the other.
%
% \caveat{This is a complex bibstyle and the number of potential cases is very
% high.  Please check your output, and write me with cases that are not set
% according to \manual percepts.  Please refer to \manual whenever
% possible.}
%
% \todo{star the new fields.}
%
% \newcommand\deffield [2] {#1&#2\\}
% \DeleteShortVerb{\|}
% \begin{longtable}{|lp{3.5in}|}
%
% \larger\bfseries entry type & \larger\bfseries\hfil description\\\hline\endhead
% \hline\caption{Entry types.} \endfoot
%
% address & Address of publisher of \emph{cited} edition, whether a reprint or
% not. \\

% annotation & A complete paragraph or more. \\

% author & \\

% bookauthor & Book's author whenever \field{author} is referring to the author of a
% part of the book.  Usually an \entry{inbook} or \entry{incollection} entry refers to a
% book with an editor but no author, but in the case of introductions etc.\ you
% have an author for each.\\

% booktitle & Book's title whenever \field{title} is referring to a part of the
% book. \\

% chapter & The \field{title} names the \field{chapter}th part of the book.  One expects to
% have nonempty \field{booktitle}.  See also \field{type}. \\

% edition & Edition information to be given after the book's title, which is
% \field{booktitle} if that is nonempty and \field{title} otherwise.  Example:
% \code{2d~ed., 2~vols. in 1~book} \\

% editor & \\

%                       & NOTE all f* and o* fields are only going to apply
% to \entry{book}, \entry{incollection}, \entry{inbook} entries.
% FIX: check -- booklet? etc. \\

% faddress & Address of publisher of first-published edition.  Not used unless
% \field{fyear} is nonempty. \\

% flanguage & Language of first-published edition.  Not used unless
% \field{translator} or \field{fyear} is nonempty. \\

% fpublisher & Publisher of first-published edition.  Not used unless \field{fyear}
% is nonempty. \\

% ftitle & Title of first-published edition (probably in \field{flanguage}).  Not
% used unless \field{fyear} is nonempty. \\

% fyear & Publication date of first-published edition. \\

% howpublished & \\

% illustrator & For \entry{book} entries only.  When the author or editor
% illustrates, use a construction like \code{{the editor} and others}. \\

% institution & For thesis entries only.  FIX check \\

% journal & For \entry{article} entries only. \\

% key & often default with empty author, editor, organization \\

% month & For \entry{journal} entries, also season, e.g., Winter \\

% note & Begins its own block, so capitalize.  Concluding puctuation is
% supplied automatically if not given in the field. \\

% number & For \entry{journal} entry, number of the journal (if no \field{volume}) or
% number within the volume.  For \entry{book} entry, number of the book in the
% \field{series}.  Makes sense only when \field{series} is a series rather than the title
% of a multivolume work. \\

% oaddress & For a reprint, address of ORIGINAL publisher. \\

% opublisher & For a reprint, publisher of ORIGINAL edition.  A nonempty
% value implies the cited edition IS a reprint (and so must have \field{oyear}). \\

% organization & \\

% oyear & For a reprint, publication date of ORIGINAL edition A nonempty
% value implies the cited edition IS a reprint (and so OUGHT TO have
% \field{opublisher}). The value will almost always differ from \field{year}.  \\

% pages & \\

% publisher & Publisher of the cited edition. \\

% school & \\

% series & Series to which \field{title} belongs, or title of a multivolume work
% where the volumes have their own titles given in \field{booktitle} or \field{title}. \\

% seriesedition & Edition information to be given after \field{series}.  Makes
% sense only when \field{series} is the title of a multivolume work with titled
% volumes.  In the entry for the multivolume work, that is, when \field{series}
% and \field{title} are identical, use \field{seriesedition} not
% \field{edition}. See also \field{edition}.  Consequence of disobeying last is
% when references are less than min-crossrefs (i.e., no separate entry for the
% multivolume work) you get the edition information for the multivolume work
% appearing after the title of the component volume.  Note: you can't really
% get away with putting a series editor here.  I think you'd have to use the
% \field{note} field for that; or we could make yet another field. \\

% title & \\

% translator & For \entry{book} entries only, the translator(s).  See also
% \field{flanguage}.  When the author or editor translates, use a construction like
% \code{{the editor} and others}. \\

% type & For \entry{inbook} entries, the value overrides \code{Chapter}.  When
% \field{type} is empty you get \code{Chapter~<chapter> of}.  FIX: CHECK: For *-thesis
% entries, gives thesis-type word, e.g.  \code{Master's Thesis}. \\

% volume & For \entry{journal} entry, it's volume.  For \entry{book} entry, its number in
% the \field{series}, or its volume number in a multivolume book. \\

% year & Year of publication of cited edition, whether a reprint or not. \\

% yearcomp & Year work composed.  For \entry{book} entry only (so far).\\
% \end{longtable}
% \MakeShortVerb{\|}
%
% \StopEventually{}
%
% \part{Implementation}
%
% \section{Version control}
%
%
% ^^A NOTE: We have to compensate for the above backslashes, which are not
% ^^A       actually in the .dtx file the author works on, by adding to the
% ^^A       CheckSum.
%%
% \AddToCheckSum{17}^^A `dtx-update-checksum' automatically handles this.
% \AddToCheckSum{7}^^A The half a macrocode env. at the top is missed, however...
% \AddToCheckSum{10}^^A ... and so are the 5 \defs from the .dtx file 
%                   ^^A     that precede it.
% \IfCitations {%
%   \AddToCheckSum{2}^^A When \initelyHavECitationS is defined in
% }                  ^^A the .dtx file, we need 2 more in the CheckSum.
%
% Version information:
%    \begin{macrocode}^^A Keep the /^ %% \def\file.../ beginning exact!

 %% A BibTeX bibliography style
 %%    conforming to the Chicago Manual's A style
 %%       but with B style author-date citations
 %%          by Matt Swift <swift@alum.mit.edu>
 %%
 %% \def\fileinfo{A Chicago Manual BibTeX style}
 %% \def\DoXPackageS {longtable}
 %% \def\initelyHavECitationS {}
 %% \def\fileversion{v1}
 %% \def\filedate{2001/08/31}
 %% \def\docdate{2001/08/31}
 %%

%    \end{macrocode}
%
% \section{Implementation}
%   \subsection{Define fields and variables}
%
%     \subsubsection{Global variables}
%
% \gvar{output.state} will have one of the four scalar values
% \gvar{before.all}, \gvar{mid.sentence}, \gvar{after.sentence}, and
% \gvar{after.block}, telling us where we are in producing the entry.
%
% \bst{Achicago} uses only \term{blocks}, not \term{sentences}, to delimit
% units in the bibentry (some other bibstyles use both).  The
% \package{achicago} package defines \cs\newblock to add a very small and
% rubber amount of horizontal space, relaxing somewhat the \cs\frenchspacing in
% effect.  I have not removed the programming structures that distinguish
% sentences and blocks, but I have not concerned myself with them either;
% anyone wishing to revise this style to begin using them should check their
% work carefully.
%    \begin{macrocode}
INTEGERS { output.state before.all mid.sentence after.sentence after.block }
%    \end{macrocode}
%
% The entry variable \evar{principal-type} will have one of the five scalar
% values \gvar{author.ptype}, \gvar{editor.ptype}, \gvar{organization.ptype},
% \gvar{key.ptype}, and \gvar{emergency.ptype}, telling us what type of
% information is in the principal field.  See also the discussion of
% \function{key.special.p}.
%    \begin{macrocode}
INTEGERS { author.ptype editor.ptype organization.ptype key.ptype
           emergency.ptype }
%    \end{macrocode}
%
% These are used during the forward and reverse passes to hold information
% about the previously-processed record.
%    \begin{macrocode}
INTEGERS { last.year.tag.num }
STRINGS  { last.leaditem last.label.and.year following.year.label.tag }
%    \end{macrocode}
%
% These variables are used locally within various functions or function groups,
% where their particular use is documented.
%
% \todo{document which if any are used in a nonlocal way}
%
% \caveat{Suspect a conflict among these scratch variables if a strange problem
% occurs!  I think \gvar{u} is the only one that will hold its value past an
% \function{output}.}
%    \begin{macrocode}
INTEGERS { j nameptr namesleft numnames len }
STRINGS  { s t u v w }
%    \end{macrocode}
%
%     \subsubsection{Bibfields}
% The list of fields that will be examined in database records, if they exist.
% Fields in the \ext{bib} database not on this list will be ignored.  Not every
% entry type makes use of every field.  Each entry type function below lists
% its required, optional, and ignored fields.  Expected use of these fields is
% documented above in the user documentation.
%    \begin{macrocode}
ENTRY
  { address
    annotation
    author
    bookauthor
    booktitle 
    chapter   
    edition   
    editor
    faddress
    flanguage
    fpublisher
    ftitle     
    fyear      
    howpublished
    illustrator
    institution
    journal    
    key        
    month      
    note                      
    number     
    oaddress   
    opublisher 
    organization
    oyear       
    pages
    publisher   
    school
    series      
    seriesedition
    title        
    translator   
    type         
    volume       
    year         
    yearcomp     
  }
%    \end{macrocode}
%
% Entry variables have a per-record value but are not initialized from a field.
%
% The integer \evar{principal-type} will contain one of the scalars
% \gvar{author.ptype}, \gvar{editor.ptype}, etc.\ (see their declarations above
% for further information).  \evar{principal-type} is set in the function
% \function{set.principal-field.principal-type}.
%    \begin{macrocode}
  { principal-type }
%    \end{macrocode}
%
% The strings \evar{label}, \evar{year.label} and \evar{year.label.tag} are
% used to construct the citation (the running text at the location of the
% user's \cs\cite command).  In most cases, \evar{label} will contain a string
% derived from the \evar{principal-field} (see \function{make.label}).
%    \begin{macrocode}
  { label
%    \end{macrocode}
%
% \evar{year.label} will contain a string representing the date.  It's not
% necessarily the same as \field{year} (see \function{make.year.label}).
% \evar{year.label.tag} will either be empty or be a lower-case letter, as
% determined in the forward and reverse passes.
%    \begin{macrocode}
    year.label year.label.tag
%    \end{macrocode}
%
% \evar{principal-field} will contain one of the fields, depending on entry
% type and what fields are nonempty (see
% \function{set.principal-field.principal-type}).
%
% In most cases, \evar{leaditem} will contain the \evar{principal-field}
% properly formatted for apearance at the beginning of the bibliography entry
% (see \function{make.leaditem}).  When it is identical to the previous entry's
% \evar{leaditem}, it will be wrapped in \cs\SCduplicate by the forward and
% reverse passes.
%    \begin{macrocode}
    principal-field
    leaditem
}
%    \end{macrocode}
%
%   \subsection{Define macros}
%
% These are macro abbreviations required by convention in every bibstyle.  The
% user can redefine them with \texttt{@STRING} declarations in the \ext{bib}
% database.
%    \begin{macrocode}
MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}
%    \end{macrocode}
%
%   \subsection{Debugging functions}
%
% \begin{macro}{debugval}
% \begin{macro}{debugmsg}
%   \mbox{}
%    \begin{macrocode}
FUNCTION {debugval}
{  ": [" *
  swap$ *    %$
  "] in " * cite$ *    %$
  top$      %$
}
  
FUNCTION {debugmsg}
{  " in " * cite$ * top$
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%  
%   \subsection{Initialization functions}
%
% \begin{macro}{init.scalars}
%   This should be called before any processing begins.
%    \begin{macrocode}
FUNCTION {init.scalars}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=

  #0 'author.ptype :=
  #1 'editor.ptype :=
  #2 'organization.ptype :=
  #3 'key.ptype :=
  #4 'emergency.ptype :=
}
%    \end{macrocode}
% \end{macro}
%
%   \subsection{Boolean logic}
%
% \begin{macro}{not}
% \begin{macro}{and}
% \begin{macro}{or}
%   \mbox{}
%    \begin{macrocode}
FUNCTION {not}
{   { #0 
    }
    { #1 
    }
  if$                 %$
}

FUNCTION {and}
{   'skip$            %$
    { pop$            %$
      #0 
    }
  if$                 %$
}

FUNCTION {or}
{   { pop$            %$
      #1 
    }
    'skip$            %$
  if$                 %$
}
%    \end{macrocode}
%  \end{macro}
%  \end{macro}
%  \end{macro}
%
%   \subsection{Constant functions}
%
%  \begin{macro}{comma}
%  \begin{macro}{period}
%  \begin{macro}{hyphen}
%  \begin{macro}{colon}
%  \begin{macro}{space}
%  \begin{macro}{delimiter.name-part}
%  \begin{macro}{delimiter.name}
%  \begin{macro}{delimiter.sub-sortkey}
%  \begin{macro}{tie}
%  \begin{macro}{etal}
%  \begin{macro}{unidentified}
% These definitions are made so that later functions are easier to read and so
% that adapting this bibstyle to another language will be simpler.
%
% The reason these are functions not macros is so the user cannot change them.
%    \begin{macrocode}
FUNCTION {comma}
{ ","
}

FUNCTION {period}
{ "."
}

FUNCTION {hyphen}
{ "-"
}

FUNCTION {colon}
{ ":"
}

FUNCTION {space}
{ " "
}

FUNCTION {delimiter.name-part}
{ "  "
}

FUNCTION {delimiter.name}
{ "   "
}

FUNCTION {delimiter.sub-sortkey}
{ "    "
}

FUNCTION {tie}
{ "~"
}

FUNCTION {etal}
{ " et~al."
}
%    \end{macrocode}
% Below, we need to be able to set a string to a value which would never be
% generated from any string in a bibliography database.  It's safe to assume
% that this string is such a one.
%    \begin{macrocode}
FUNCTION {unidentified} 
{ "HiGHlY*Peco@lIEr" 
}
%    \end{macrocode}
%  \end{macro}
%  \end{macro}
%  \end{macro}
%  \end{macro}
%  \end{macro}
%  \end{macro}
%  \end{macro}
%  \end{macro}
%  \end{macro}
%
%   \subsection{Output functions}
%
% The \function{output} function automatically handles interunit punctuation.
%
% \function{output} should be called with a string and a punctuation mark on
% the stack.  The punctuation mark is what should \emph{precede} the string in
% the case the string begins in the middle of a sentence.  Strings which begin
% sentences are preceded by periods.  Strings which begin a new block are
% preceded by periods and the \cs\newblock command.  (It makes no sense for a
% string to begin at the end of a sentence.)
%
% Calls to \function{output.internal} leave the string on the stack until the
% next time \function{output.internal} is called, when it will get written.
% The function \function{output.begin} puts an empty string on the stack, and
% should be called before beginning any series of calls to \function{output}.
% \function{output.end} cleans up and should be called at the conclusion of a
% series of calls to \function{output}.
%
%  \begin{macro}{output.begin}
% Prepare for a series of calls to \function{output}.  Put an empty string on the
% stack and set \gvar{output.state} to \gvar{before.all}.
%    \begin{macrocode}
FUNCTION{output.begin}
{ ""
  before.all 'output.state :=
}
%    \end{macrocode}
%  \end{macro}
%
%  \begin{macro}{output.end}
% Conclude a series of calls to \function{output}.   Simply calls \builtin{write}.
%    \begin{macrocode}
FUNCTION {output.end}
{ write$               %$
}
%    \end{macrocode}
%  \end{macro}
%
%  \begin{macro}{new.block}
% Begin a new block.
%    \begin{macrocode}
FUNCTION {new.block}
{ output.state before.all =
    'skip$                  %$
    { after.block 'output.state := 
    }
  if$                       %$
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{new.sentence}
% Begin a new sentence.  FIX: hmm, wouldn't we want to put a TeX command here
% for intersentence space now?  Why do we mess with the usual spacefactor for
% periods anyway?  When in bibliogrphies are the usual TeX rules not going to
% be what we want, and give too much space after a period?  answer: when a
% lowercase letter followed by period, in e.g. sec. 2 and so on.  often
% bibstyle will put tie there, but sometimes not I think, so need to have that
% be not an intersentence space.  well, if i start using sentences instead of
% blocks, I think perhaps doing the same hskip after a sentence with a new
% command \cs\newsentence perhaps as in \cs\newblock would be the right thing
% to do.
%    \begin{macrocode}
FUNCTION {new.sentence}
{ output.state before.all = output.state after.block = or
    'skip$              %$
    { after.sentence 'output.state := 
    }
  if$              %$
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{output.internal}
% \cs\stack{punct string/entry(nonnull)}{null}
%    \begin{macrocode}
FUNCTION {output.internal}
{ 's :=     % s := string/entry(nonnull)
  space * 't :=     % t := punctuation + space
  output.state mid.sentence =
    { t * write$               %$
    }
    { output.state after.block =
        { add.period$ write$
          newline$              %$
          "\newblock " write$              %$
        }
        { output.state before.all =
            'write$              %$
%    \end{macrocode}
% Final case is \gvar{output.state} = `after.sentence', which means we just add a
% period,  but no newline or \cs\newblock command.
%    \begin{macrocode}
            { add.period$ space * write$
            }
          if$              %$
        }
      if$              %$
%    \end{macrocode}
% We are now mid-sentence, whether we were before or not. 
%    \begin{macrocode}
      mid.sentence 'output.state :=
    }
  if$              %$
%    \end{macrocode}
% The actual string given to `output.internal' is left on the stack here for
% next time we call `output.internal' or `output.end', whichever comes next.
%    \begin{macrocode}
  s
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{output}
% \cs\stack{string/entry punct}{either null OR punct string/entry(nonnull)}
%
% Check if string/entry is null.  If it's null do nothing.  If it's nonempty
% call \function{output.internal} on it with the given punctuation.
%    \begin{macrocode}
FUNCTION {output}
{ swap$ duplicate$ empty$
    { pop$
      pop$              %$
    }
    'output.internal
  if$              %$
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{output.bibitem}
% The optional argument to \cs\bibitem will be made the definition of
% \cname{b@foo} where |foo| is the \builtin{cite} key.  \cname{b@foo} will be
% executed by all the various citing commands with a definition of \cs\SCcite
% that is appropriate to each citing command.
%
% The \env{thebibliography} environment actually ignores the optional argument
% to \cs\bibitem.  The environment sets the formatting so that the first part
% of the main entry hangs out to the left and looks like a label.
%
% The unexpandable protection is necessary, instead of a simple protection, in
% order to work with \package{newclude}'s \option{tag} option.
%
% I guess we use \builtin{write} for each part instead of catenating them and using a
% single \builtin{write} in case the catenation gets longer than \BibTeX{} can
% handle.  I don't know, this is how I found it.  It seems like catenation and
% a single call to \builtin{write} would be faster. FIX.
%    \begin{macrocode}
FUNCTION {output.bibitem}
{ newline$                 %$
  "\bibitem[\UnexpandableProtect\SCcite{" write$          %$
  label write$           %$
  "}{" write$                  %$
  year.label year.label.tag * write$        %$
  "}]{" write$             %$
  cite$ write$                    
  "}" write$               %$
  newline$            %$
}
%    \end{macrocode}
% \end{macro}
%
%   \subsection{Simple auxiliary functions}
%
%  \begin{macro}{field.or.null}
% \cs\stack{field literal}{field contents or null string if the field was
% missing}
%    \begin{macrocode}
FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$             %$
      "" 
    }
    'skip$             %$
  if$                  %$
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{italicize}
%  \cs\stack{string or entry}{string}
%
% Italicize the top string on the stack and provide italic corrections.  Null
% goes to null.  We want to explicitly italicize rather than use \cs\emph,
% since semantic emphasis might be indicated in some other way in the document,
% e.g., slanted type.
%    \begin{macrocode}
FUNCTION {italicize}
{ duplicate$ empty$
    { pop$              %$
      "" 
    }
    { "\textitswitch{" swap$ * "}" *       %$
    }
  if$                       %$
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{parenthesize}
%    \cs\stack{string-or-entry:S}{"(" + S + ")"}
%    \begin{macrocode}
FUNCTION {parenthesize}
{ duplicate$ empty$
    { pop$            %$
      ""
    }
    { "(" swap$ * ")" *         %$
    }
  if$                           %$
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{format.clip}
% \cs\stack{string}{string} FIX: the difference between \builtin{entry.max} and
% \builtin{global.max}: max for an entry string, max for a global string.
%
% \begin{macro}{format.clip}
% \cs\stack{string-S}{string-S-possibly-shortened}
%
%   Clips a string down to the smaller of \builtin{entry.max} and \builtin{global.max}.
%    \begin{macrocode}
FUNCTION {format.clip}
{ #1 entry.max$ substring$ 
  #1 global.max$ substring$
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{format.sortify.clip}
% \builtin{purify}, downcase, and clip a string on the stack.
% \cs\stack{\meta{string}}{\meta{string}}
%    \begin{macrocode}
FUNCTION {format.sortify.clip}
{ % duplicate$ "sinful" debugval %$
  purify$                   %$
%  duplicate$ "  pure" debugval %$
  "l" change.case$                   %$
  format.clip
%  duplicate$ "humble" debugval %$
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{check.empty}
% \cs\stack{S warning}{S}
% Issues warning if the string is empty.
%    \begin{macrocode}
FUNCTION {check.empty}
{ 't := 
  duplicate$ empty$
    { "empty " t * " in " * cite$ * warning$ 
    }
    'skip$                              %$
  if$                              %$
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{multipage.p}
% \cs\stack{nothing}{\#0 or \#1}
%
% Set \gvar{t} to \field{pages}.  Look at \gvar{t} character by character for a
% hyphen, comma, or plus.  If we find one, return true immediately; else return
% false.
%    \begin{macrocode}
FUNCTION {multipage.p}
{ pages 't :=
  #0 'j :=
  % WHILE
  {   j not
      t empty$ not            %$
    and
  }
    { t #1 #1 substring$                %$
        duplicate$ hyphen =                  %$
          swap$ duplicate$ comma =
          swap$ "+" =                       %$
        or
      or
        { #1 'j := 
        }
        { t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
  j
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{format.n.dashify}
% \cs\stack{string}{string}
%
% Make single-dashes into double-dashes.
%    \begin{macrocode}
FUNCTION {format.n.dashify}
{ 't :=
  ""
  % WHILE
  { t empty$ not }                %$
    { t #1 #1 substring$ hyphen =                %$
        { t #1 #2 substring$ "--" = not                %$
            { "--" *
	      t #2 global.max$ substring$ 't :=
	    }
	    { % WHILE
              { t #1 #1 substring$ hyphen = }                %$
		{ hyphen *
		  t #2 global.max$ substring$ 't :=
		}
	      while$                %$
	    }
	  if$                %$
        }
        { t #1 #1 substring$ *                %$
          t #2 global.max$ substring$ 't :=
        }
      if$                %$
    }
  while$                                  %$
}
%    \end{macrocode}
% \end{macro}
%  
%  \begin{macro}{tie.or.space.connect}
% \cs\stack{string string}{string}
%
% If the second string has less than 5 characters, the two are tied together,
% otherwise they are catenated with a space between them.
%    \begin{macrocode}
FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #5 <
    { tie
    }
    { space 
    }
  if$
  swap$ * *
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{either.or.check}
% \cs\stack{msg field}{null}
% If field is not empty, give a warning appropriate for saying this field and
% an already-existing field can't be both used in the same entry. 
%    \begin{macrocode}
FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ 
    }
  if$
}
%    \end{macrocode}
% \end{macro}
%
%   \subsection{Queue functions START FIXING DOX HERE}
%
% Queue functions expect a string on the stack.  If it is empty, and the field
% for which the function is named is noempty, the string will be replaced with
% that field. (e.g., \function{author.q} will put \field{author} on the stack
% if \field{author} is nonempty and the \function{author.q} was passed an empty
% string).  A chain of queue functions must begin with something on the stack,
% adn will leave the first nonempty field named in the chain on the stack.
%
% Queue functions also increment an integer variable, 'j, whenever they are
% passed an empty string.  At the end of the queue, 'j tells us which function
% in the queue contributed the string that results at the end of the queue,
% starting with zero for the first queue function after \function{start.a.q}.
% In order for this to work, queue functions must always be called in the same
% order: \field{author} ('\#0') \field{editor} (`\#1'), \field{organization}
% (`\#2'), and \field{key} (`\#3').  For entry types where a certain field
% should not appear in the queue, use `blank.q' in its place in the order.
%
% The value of \gvar{j} is consulted when setting \evar{leaditem}, but not in
% other cases where queue functions are used
%
% \function{start.a.q} must begin a queue.  It initializes \gvar{j} and passes
% an empty string to the first queue function.
% \begin{macro}{start.a.q}
%    \begin{macrocode}
FUNCTION {start.a.q}
{ #-1 'j :=
  ""
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{inc.j}    
% \begin{macro}{key.q}    
% \begin{macro}{organization.q}    
% \begin{macro}{editor.q}    
% \begin{macro}{author.q}    
% \begin{macro}{blank.q}    
% \mbox{}
%    \begin{macrocode}
FUNCTION {inc.j}
{ j #1 + 'j := 
}

FUNCTION {key.q}
{ duplicate$ empty$
    { pop$           %$
      key field.or.null
      inc.j
    }
    'skip$             %$
  if$                  %$
}

FUNCTION {organization.q}
{ duplicate$ empty$
    { pop$                  %$
      organization field.or.null
      inc.j
    }
    'skip$                    %$
  if$                       %$
}

FUNCTION {editor.q}
{ duplicate$ empty$
    { pop$                       %$
      editor field.or.null
      inc.j
    }
    'skip$                       %$
  if$                       %$
}

FUNCTION {author.q}
{ duplicate$ empty$
    { pop$                       %$
      author field.or.null
      inc.j
    }
    'skip$                       %$
  if$                       %$
}

FUNCTION {blank.q}
{ duplicate$ empty$
    'inc.j
    'skip$                       %$
  if$                       %$
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
%
% \begin{macro}{check.q}
% \cs\stack{string-S warning-string}{string-S}
%
% This should be the final queue command, though it is not a true queue
% command, since an extra warning string should be on the top of the stack
% above the string that has passed along the queue.  The warning string should
% be an English disjunctive list of the queue commands that have come before
% it, so the user can tell which fields are missing.  For example ``author,
% organization, or key'' if the queue has been \function{author.q} 'blank.q'
% `organization.q' \function{key.q}.
% 
% If the queue string is empty, \function{check.q} issues the warning and puts on the
% stack an emergency string of the \LaTeX{} key
% (i.e., \builtin{cite}), which should allow \BibTeX{} to proceed.
%    \begin{macrocode}
FUNCTION {check.q}
{ 't :=
  duplicate$ empty$
    { pop$                              %$
      cite$ format.clip 'u :=           %$
      "Need " t * " in " * cite$ * "; using:  " * u * warning$
      u
      inc.j
    }
    'skip$                              %$
  if$                              %$
}    
%    \end{macrocode}
% \end{macro}
%
%   \subsection{Format functions dox}
%
% The format functions modify a string on the stack.  They make no warnings,
% produce no output, and place no spaces or punctuation before or after their
% string, just modify it somehow.
%
%   \subsection{Format names functions}
%
% \begin{macro}{format.names.for.label}
% Format string on stack it to produce something appropriate for \evar{label}.
%
% Comma usage examples in the \manual: ``A et al.''\ and ``A, B, et al.''
%
% The \manual recommends for labels: use up to 3 names, and above 3 use 1st +
% etal.  When this would lead to ambiguity, use one of 3 solns: use all names,
% use as many as needed to disambiguate, or include a (short) title to
% disambiguate: (Zipursky et al., \textitswitch{Brief Title}, 1988).
%
% The \manual does not appear to distinguish between ``et al.''\ and ``and
% others''.  It's possible to change the logic here to distinguish between the
% cases where the bibstyle is truncating the list of authors, and the case
% where ``and others'' appears in the \ext{bib} file.  But I'm not doing that
% now.
%
% Labels:
% \begin{center}
% \begin{tabular}{ll}%% FIX: this stuff not implemented yet
%   1 author            & Foo                  \\
%   2 authors           & Foo and Bar          \\
%   3 authors           & Foo, Bar, and Baz    \\
%   4+ authors          & Foo et al.           \\
%   1+ author ``and others'' & Foo et al.      \\
%^^A  FIX? 1 author ``and others'' & Foo et al.      \\
%^^A 2 authors ``and others'' & Foo, Bar, et al. \\
% \end{tabular}
% \end{center}
%
% This function is probably more general than it needs to be, but it's a nice model.
%    \begin{macrocode}
FUNCTION {format.names.for.label}
{ 's :=
  s num.names$ 'numnames :=                                   %$
  s #1 "{vv~}{ll}" format.name$                                 %$
    s numnames "{ff}{vv}{ll}{jj}" format.name$ "others" =    %$
    numnames #3 >
  or
    % more than 3 names, or final name is "others"
    { etal *
    }
    { numnames #1 - 'namesleft :=
      #2 'nameptr :=
	% WHILE
	{ namesleft #0 > }
	{ nameptr numnames =
	    % we're on the final name (and it's not "others")
	    { numnames #2 >
		{ comma *
		}
		'skip$        %$
	      if$        %$
	      " and " * s nameptr "{vv~}{ll}" format.name$ *     %$
	    }
	    % we're not on the final name (in this case: 2d of 3 names)
	    { comma * space *
	      s nameptr "{vv~}{ll}" format.name$ *        %$
	    }
	  if$          %$
	  nameptr #1 + 'nameptr :=
	  namesleft #1 - 'namesleft :=
	}
      while$             %$
    }
  if$                    %$
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
% \begin{macro}{format.names.lastfirst}
% Pop a string containing a name list.  Push a string with the first author
% last-name-first and subsequent authors first-name-first.
%    \begin{macrocode}
FUNCTION {format.names.lastfirst}
{ 's :=
  s num.names$ 'numnames :=    % numnames = num.name$(s);
  numnames 'namesleft :=
  #1 'nameptr :=               % nameptr = 1;
    % WHILE
    { namesleft #0 > }
    { nameptr #1 =
        { s nameptr "{vv~}{ll}{, jj}{, ff}" format.name$                %$
        }
        { comma * 
          s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=           %$
          nameptr numnames = 
            % final name
            { t "others" =
                { etal * 
                }
                { " and " * t * 
                }
              if$                  %$
            }
            % names both precede and follow this name
            { space * t * 
            }
          if$                  %$
        }
      if$                  %$
      nameptr #1 + 'nameptr :=          % nameptr += 1;
      namesleft #1 - 'namesleft :=      % namesleft =- 1;
    }
  while$                     %$
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{format.names.firstfirst}
% Same as \function{format.names.lastfirst} but all names are first name first.
%    \begin{macrocode}
FUNCTION {format.names.firstfirst}
{ 's :=
  s num.names$ 'numnames :=    % numnames = num.name$(s);
  numnames 'namesleft :=
  #1 'nameptr :=               % nameptr = 1;
    % WHILE
    { namesleft #0 > }
    { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=                   %$
      nameptr #1 =
        't
        { nameptr numnames =
            % final name
            { numnames #2 >
                { comma * 
                }
                'skip$                  %$
              if$                  %$
              t "others" =
                { etal * 
                }
                { " and " * t * 
                }
              if$                  %$
            }
            % names both precede and follow this name
            { comma * space * t * 
            }
          if$                  %$
        }
      if$                  %$
      nameptr #1 + 'nameptr :=          % nameptr += 1;
      namesleft #1 - 'namesleft :=      % namesleft =- 1;
    }
  while$                   %$
}
%    \end{macrocode}
% \end{macro}
%
%   \subsection{Make functions}
%
% Make functions expect nothing on the stack, and leave one string there.  Any
% side effects of setting global variables are noted in the comments.  If a
% nonempty string cannot be made due to lack of the right fields, leave an
% empty one on the stack.
%
%  \begin{macro}{make.annotation}
% Annotations can be omitted by nullifying the \env{SCannotation} environment.
%    \begin{macrocode}
FUNCTION {make.annotation}
{ annotation empty$       %$
    { ""
    }
    { "\begin{SCannotation}"
      annotation *
      "\end{SCannotation}" *
    }
  if$           %$
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{make.edition}
% We use some logic here because we want to use the \field{seriesedition} for the
% \field{edition} in certain cases.
%    \begin{macrocode}
FUNCTION {make.edition}
{ edition empty$                  %$
    { seriesedition empty$ not series field.or.null title field.or.null = and             %$
        { seriesedition
        }
        { ""
        }
      if$                                    %$
    }
    { edition
    }
  if$                                        %$
}
%    \end{macrocode}
% \end{macro}
%
%  \begin{macro}{make.year.month}
%  \begin{macro}{make.year.nomonth}
%  Make a year string.  We don't we use \evar{year.label} because that string is
%  sterilized to make it appropriate for use in running text in citations (and
%  for sorting I think); in the bibliography entry, we can be a little more
%  lax, accepting special characters, and text that is not simply four
%  numerals.
%    \begin{macrocode}
FUNCTION {make.year.month}
  { year empty$                  %$
      { ""
      }
      { year year.label.tag *
	month empty$                  %$
	  'skip$                  %$
	  { comma * space * month *
          }
	if$                  %$
      }
    if$                                      %$
}
FUNCTION {make.year.nomonth}
{ year empty$                                %$
    { ""
    }
    { year year.label.tag *
    }
  if$                                        %$
}
%    \end{macrocode}
%  \end{macro}
%  \end{macro}
%
%  \begin{macro}{make.year.or.oyear.month}
% Push a string with year information.  If \field{oyear} is empty, call
% \function{make.year.month}.  Warn in the almost-certainly-erroneous case of
% an \field{oyear} without a \field{year}.
%    \begin{macrocode}
FUNCTION {make.year.or.oyear.month}
{ oyear empty$                  %$
    { make.year.month
    }
    { year empty$                  %$
        { "oyear without year in " cite$ * warning$
        }
        'skip$                  %$
      if$                  %$
      oyear year.label.tag *
      month empty$                  %$
        'skip$                  %$
	{ comma * space * month *
        }
      if$                  %$
    }
  if$                    %$
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{make.leaditem.with.tags}
% Push \evar{leaditem} and if it's an editor, include a nice taggy.
%    \begin{macrocode}
FUNCTION {make.leaditem.with.tags}
{ leaditem
  principal-type editor.ptype =
    { editor num.names$ #1 >         %$
	{ ",~eds." * 
	}
	{ ",~ed." * 
	}
      if$                  %$
    }
    'skip$                 %$
  if$                 %$
}
%    \end{macrocode}
%  \end{macro}
%
%  \begin{macro}{make.editors.secondary}
% Give editors' names when not for the leaditem.
%    \begin{macrocode}
FUNCTION {make.editors.secondary}
{ editor empty$                  %$
    { "" 
    }
    { output.state after.sentence = 
      output.state after.block = or
        { "E"
        }
        { "e"
        }
      if$                  %$
      "dited by " * editor format.names.firstfirst * 
    }
  if$                                        %$
}
%    \end{macrocode}
%  \end{macro}
%
%  \begin{macro}{make.bookauthors.secondary}
% This is for making authors' names that follow a title.  When we use this, we
% are only going to be interested in the \field{bookauthor}.
%    \begin{macrocode}
FUNCTION {make.bookauthors.secondary}
{ bookauthor empty$                  %$
    { "" 
    }
    {   output.state after.sentence = 
        output.state after.block =
      or
        { "B"
        }
        { "b"
        }
      if$                  %$
      "y " * bookauthor format.names.firstfirst * 
    }
  if$                  %$
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{make.translators}
% \begin{macro}{make.illustrators}
% Translators and illustrators are always secondary, until I write some extensions.
%    \begin{macrocode}
FUNCTION {make.translators}
{ translator empty$                  %$
    { "" 
    }
    {   output.state after.sentence = 
        output.state after.block =
      or
        { "T"
        }
        { "t"
        }
      if$                  %$
      "ranslated " *
      flanguage empty$                  %$
        'skip$                  %$
        { "from the " * flanguage * space *
        }
      if$                  %$
      "by " * translator format.names.firstfirst *
    }
  if$                  %$
}

FUNCTION {make.illustrators}
{ illustrator empty$                  %$
    { "" 
    }
    {   output.state after.sentence = 
        output.state after.block =
      or
        { "I"
        }
        { "i"
        }
      if$                  %$
      "llustrated by " * illustrator format.names.firstfirst *
    }
  if$                  %$
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
%  \begin{macro}{make.booktitle.ital}
%  \begin{macro}{make.title.ital}
%  \begin{macro}{make.as.ftitle.ital}
%    FIX: multilingual
%    \begin{macrocode}
FUNCTION {make.title.ital}
{ title field.or.null italicize
}

FUNCTION {make.booktitle.ital}
{ booktitle field.or.null italicize
}

FUNCTION {make.as.ftitle.ital}
{ ftitle empty$                  %$
    { ""
    }
    { "as " ftitle italicize *
    }
  if$                  %$
}
%    \end{macrocode}
%  \end{macro}
%  \end{macro}
%  \end{macro}
%
% \begin{macro}{make.title.inquotes}
% Put the title in quotes on the stack.  \cs\Wrapquotes is going to properly
% handle punctuation that follows the closing quotation marks by sucking it
% inside the quotes.  FIX: make generic function format.wrapquotes? like
% format.emphasize?  FIX: make all those function that transform a string on
% the stack into ``format'' functions.
%    \begin{macrocode}
FUNCTION {make.title.inquotes}  
{ title empty$               %$
    { "" 
    }
    { 
      "\Wrapquotes{" title * "}" * 
    }   
  if$                                  %$
}
%    \end{macrocode}
% \end{macro}
%    
%    \begin{macrocode}
FUNCTION {make.pages}
{ pages empty$               %$
    { "" 
    }
    { pages format.n.dashify
    }
  if$                                     %$
}
%    \end{macrocode}
%
% \begin{macro}{make.vol.series.num.month.pages}
%
% For articles, the number of cases to handle these fields is very large: 32 to
% do it properly!  These cases could perhaps be collapsed, but it is going to
% be much easier to read here and to maintain if we do it brutishly by
% elaborating each case.  The only exception I've made is when two adjacent
% leaves are very similar.  The way I've laid out this funciton here, adjacent
% leaves are going to be the pairs of cases with and without a nonempty
% \field{pages}.
%
% There are 5 relevant fields, each of which can be empty or not ($2^5 =
% 32$). In the comments below, I mark each case with a series of 1 to 5 letters
% represent the cases where that field is nonempty: |V| for \field{volume}, |S|
% for \field{series}, |N| for \field{number}, |M| for \field{month}, and |P|
% for \field{pages}.  Thus, the case marked with the comment |SMP| is the one
% where the \field{series}, \field{month}, and \field{pages} fields are
% nonempty, and \field{volume} and \field{number} are empty.
%
% FIX: when I use \function{make.pages} in this function, it's slightly inefficient,
% since \function{make.pages} does a check for empty pages which is unnecessary here.
%
% FIX: this does not yet handle entries with nonempty \field{series}.
%
% FIX: go through and combine adjacent leaves.
%
% We could really put the punctuation that should precede this unit right at
% the beginning of the string we're making here, but let's conform better to
% the conventions and put this in the scratch variable 'u instead.  I don't
% think this function will ever get called at any time other than mid-sentence,
% after the journal title, but who knows.  So a call to this function should
% look like:
% \begin{codeexample}
%   make.vol.series.num.month.pages u output
% \end{codeexample}
% Remember that when \function{output.internal} writes the punctuation, it adds a space
% following, so it is unnecessary to begin the string this function returns
% with a space.  (Occasionally below, we want (and produce) a colon followed by
% no space; we can do this because we are directly creating this string, not
% using the \function{output} routine.)
%    \begin{macrocode}
FUNCTION {make.vol.series.num.month.pages}
{ volume empty$                   %$
    { series empty$                   %$
        { number empty$                   %$
	    { month empty$                   %$
		{ pages empty$                   %$
                    % none of VSNMP
		    { space 'u :=
                      ""
		    }
                    % P
		    { comma 'u :=
                      multipage.p
                        { "pp." pages format.n.dashify
			}
                        { "p." pages
			}
                      if$                   %$
                      tie.or.space.connect
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
                    % M
		    { comma 'u :=
                      month
		    }
                    % MP
		    { comma 'u :=
                      month comma * space * make.pages *
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	    { month empty$                   %$
		{ pages empty$                   %$
                    % N
		    { comma 'u :=
                      "no." number tie.or.space.connect
		    }
		    % NP
		    { comma 'u :=
                      "no." number colon * make.pages * tie.or.space.connect
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % NM
		    { comma 'u :=
                      "no." number tie.or.space.connect
                      space * month parenthesize *
		    }
		    % NMP
		    { comma 'u :=
                      "no." number tie.or.space.connect
                      space * month parenthesize *
                      colon * space * make.pages *
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	  if$                   %$
        }
        { number empty$                   %$
	    { month empty$                   %$
		{ pages empty$                   %$
		    % S
		    { 
		    }
		    % SP
		    {
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % SM
		    {
		    }
		    % SMP
		    {
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	    { month empty$                   %$
		{ pages empty$                   %$
		    % SN
		    {
		    }
		    % SNP
		    {
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % SNP
		    {
		    }
		    % SNMP
		    {
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	  if$                   %$
        }
      if$                   %$
    }
    { series empty$                   %$
        { number empty$                   %$
	    { month empty$                   %$
		{ pages empty$                   %$
		    % V
		    { comma 'u :=
                      "vol." volume tie.or.space.connect
		    }
		    % VP
		    { space 'u :=
                      volume colon * make.pages *
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % VM
		    { comma 'u :=
                      "vol." volume tie.or.space.connect
                      space * month parenthesize *
		    }
		    % VMP
		    { space 'u :=
                      volume space *
                      month parenthesize * colon * space * make.pages *
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	    { month empty$                   %$
		{ pages empty$                   %$
		    % VN
		    { space 'u :=
                     volume ", no." number tie.or.space.connect *
		    }
		    % VNP
		    { space 'u :=
                      volume space * 
                      number parenthesize * colon * space * make.pages *
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % VNM
		    { space 'u :=
                      volume ", no." number tie.or.space.connect *
                      space * month parenthesize *
		    }
		    % VNMP
		    { space 'u :=
                      volume space * number parenthesize * colon * space *
                      make.pages * space * month parenthesize *
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	  if$                   %$
        }
        { number empty$                   %$
	    { month empty$                   %$
		{ pages empty$                   %$
		    % VS
		    { 
		    }
		    % VSP
		    {
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % VSM
		    {
		    }
		    % VSMP
		    {
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	    { month empty$                   %$
		{ pages empty$                   %$
		    % VSN
		    {
		    }
		    % VSNP
		    {
		    }
		  if$                   %$
		}
		{ pages empty$                   %$
		    % VSNM
		    {
		    }
		    % VSNMP
		    {
		    }
		  if$                   %$
		}
	      if$                   %$
	    }
	  if$                   %$
        }
      if$                   %$
    }
  if$                                            %$
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{make.crossref}
%    \begin{macrocode}
FUNCTION {make.crossref}
{ "\citeNP{" crossref * "}" *
}
%    \end{macrocode}
% \end{macro}
%
%  \begin{macro}{output.series.number}
% Outputs the number with appropriate capitalization.  Warns if we also have
% nonempty \field{seriesedition}.
%    \begin{macrocode}
FUNCTION {output.series.number}
{ series empty$                   %$
    { number empty$                   %$
        { ""
        }
        { "Can't use `number' without `series' in " cite$ * warning$
          "" 
        }
      if$                   %$
    }
    { number empty$                   %$
	{ series
          seriesedition empty$                   %$
            'skip$                   %$
            { comma output
              new.block
              seriesedition
            }
          if$                   %$
	}
	{ series space * 
          "no." *
	  number tie.or.space.connect    
	 "number and seriesedition" seriesedition either.or.check
	}
      if$                   %$
    }
  if$                                         %$
  comma output
}
%    \end{macrocode}
%  \end{macro}
%
% \begin{macro}{output.volume.series}
%  The \field{series} is not required.   FIX: why do we output stuff here?
%  can't we use a make function like elsewhere?
%    \begin{macrocode}
FUNCTION {output.volume.series}
{ volume empty$                   %$
    { ""
    }
    { "Volume" volume tie.or.space.connect
      series empty$                   %$
        'skip$                   %$
        { " of " * series italicize * 
          seriesedition empty$                   %$
            'skip$                   %$
            { comma output
              new.block
              seriesedition
            }
          if$                   %$
        }
      if$                   %$
      "volume and number" number either.or.check
    }
  if$                   %$
  comma output
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{make.chapter.of}
% To say for example ``Part 3'' instead of ``Chapter 3'', put ``Part'' into the
% \field{type} field, and the number and the preposition into the \field{chapter} field,
% e.g., ``3 of''.   A tie is automatically put in between the \field{type} field
% and the \field{chapter} field in this case.  We can't make a decision based on the
% length of the \field{chapter} field when it's going to contain the preposition.
%
% OK, putting the preposition in the chapter field doesn't work out when you do
% crossreferences.  So let's try ``of'' as a general preposition.
%    \begin{macrocode}
FUNCTION {make.chapter.of}
{ chapter empty$        %$
    { ""
    }
    { type empty$        %$
        { "Chapter" 
        }
        { type "t" change.case$         %$
        }
      if$        %$
      chapter tie.or.space.connect
      " of " *
    }
  if$                   %$
}
%    \end{macrocode}
% \end{macro}
%    
% \begin{macro}{make.chapter}
%    \begin{macrocode}
FUNCTION {make.chapter}
{ chapter empty$                   %$
    { ""
    }
    { type empty$                   %$
        { "Chapter"
        }
        { type "t" change.case$                   %$
        }
      if$                   %$
      chapter tie.or.space.connect
    }
  if$                   %$
}
%    \end{macrocode}
% \end{macro}
% 
% \begin{macro}{make.number.tr}
% \mbox{}
%    \begin{macrocode}
FUNCTION {make.number.tr}
{ type empty$                   %$
    { "Technical Report" 
    }
    { type "t" change.case$                    %$
    }
  if$                   %$
  number empty$                   %$
    'skip$                   %$
    { number tie.or.space.connect 
    }
  if$                   %$
}
%    \end{macrocode}
% \end{macro}
%
%   \subsection{Label and principal field functions}
%
% \begin{macro}{calc.labels}
% \begin{macro}{set.principal-field.principal-type}
%   Set \evar{label} and \evar{year.label} from the original
%   database.  Set \evar{leaditem}.  For reference from above: \field{author}
%   ('\#0') \field{editor} (`\#1'), \field{organization} (`\#2'), and
%   \field{key} (`\#3').
%
% FIX: NOTE: the entry-type functions (and specifically its subroutines like
% make.authors) are going to assume that bibentry contains the right field as
% calculated by 
%
% format the string on the stack based on the GLOBAL (not entry) variable
% j (= bibentry.type)
%%
% confusion here over terminology.  bibentry and leaditem are the same thing,
% but it is also the basis for calculating the label.
% let's call the most important field for each type the PRINCIPAL field.  this
% will be put into the lead position in the bibentry and also be massaged into
% the label.
%% FIX: new idea, start using it
% leaves a string on the stack based on TYPE; the string is the first non-empty
% relevant field for the type, or an emergency substitution as supplied by
% \function{check.q}.  FIX: end.the.q?  would emergency be a 5th type that the
% format.principal-field functions should recognize?
%
% Yes, \function{check.q} will put full cite-string on as emergency and set 
% \evar{principal-type} accordingly.
%
% FIX: ensure proper warnings if we are not getting something good in
% principal-field.
% 
%    \begin{macrocode}
FUNCTION {set.principal-field.principal-type}
{   type$ "book" =               %$
    type$ "inbook" =               %$
  or
    { start.a.q 
      author.q
      editor.q
      blank.q 
      key.q 
      "author, editor, or key for entry type " type$ * check.q          %$
    }
    { type$ "proceedings" =                   %$
        { start.a.q
          blank.q
          editor.q
          organization.q
          key.q
          "editor, organization, or key for entry type " type$ * check.q    %$
        }
        { type$ "manual" =                   %$
            { start.a.q
              author.q
              blank.q
              organization.q
              key.q
              "author, organization, or key for entry type " type$ * check.q   %$
            }
            % for all other entry types
            { start.a.q
              author.q
              blank.q
              blank.q
              key.q
              "author or key for entry type " type$ * check.q       %$
            }
          if$                   %$
        }
      if$                   %$
    }
  if$                   %$
  'principal-field :=
  j 'principal-type :=
}

% TRUE if we've got \evar{principal-type} of \gvar{organization.ptype} and
% nonempty \field{key} and entry type of \entry{manual} or \entry{proceedings}.
FUNCTION {key.special.p}
{       type$ "manual" =             %$
	type$ "proceedings" =        %$
      or
      principal-type organization.ptype =
    and
    key empty$ not                 %$
  and
}

FUNCTION {make.leaditem}
{ key.special.p
    % is \field{key} all-caps?
    { key duplicate$ "u" change.case$ =
        % if so, key is assumed to be an acronym FIX; should I warn what we're doing?
        { key " (" * organization * ")" *
        }
        % if not, key is assumed to be an initial prefix (abbreviation) of organization
        % for use only in the label
        { organization
        }
      if$                   %$
    }
    { principal-field
	principal-type author.ptype =
	principal-type editor.ptype =
      or
	{ format.names.lastfirst
	}
	% organization, key, or emergency ptype
	'skip$               %$
      if$                   %$
    }
  if$              %$
}

FUNCTION {make.label.from.principal-field}
{ principal-field
    principal-type author.ptype =
    principal-type editor.ptype =
  or
    { format.names.for.label
    }
    % organization, key, or emergency
    'skip$               %$
  if$                   %$
}

FUNCTION {make.label}
{ key.special.p
    { key
    }
    { make.label.from.principal-field
    }
  if$               %$
}
%    \end{macrocode}
%
% \begin{macro}{format.names.for.sort}
% \cs\stack{\meta{list of names}}{\meta{list of names suitable for sorting}}
%
% FIX: add dox here about how bibtex sorts, and the spaces strategy.
%
% \begin{tabular}{lp{1in}}
% 1 & between tokens of a name part (word-by-word method; only after first-name's initials
% in letter-by-letter) \\
% 2 & between name-parts in a name (but consider `von' and `last' one name-part) \\
% 3 & between names in a name list \\
% 4 & between other sort levels, such as names and years \\
% \end{tabular}
% We don't bother to \function{format.sortify.clip}, just do that once before assignment to
% the sort.key.
%
% \manual specifies all names should be given in the bibliography.  FIX ref.
% So the \manual doesn't tell us how to handle the conventional ``and others''
% that might be in the database.  We handle it by proceeding on the assumption
% that ``and others'' always means the total names are more than 3, so we want
% to alphabetize these entries after all those with 1, 2, or~3 names.  We do
% this by turning ``and others'' into a pseudo-name that will sort later than
% any real name (i.e., we insert a lot of z's).
%
% The commented-out format is doing word-by-word alphabetization as defined
% \manualref{17.97} with the exception of hyphens.  \builtin{purify} turns
% hyphens into spaces, so hyphens are word boundaries, unlike slashes and
% apostrophes, which are suppressed.  The \manual says hyphens should be
% supressed like slashes and apostrophes, so we need to remove them with
% \function{format.dehyphen} before we \builtin{purify}.
%
% The \manual prefers letter-by-letter alphabetization, which is what the
% active code below does.  We suppress spaces between tokens of a name part.
% We need to remove hyphens as explained above.
%
% NOTE: We could therefore change our delimiters all down by one, since single space
% delimters are no longer used, but I think there is no harm in starting with a
% 2-space delimiter, and this lets us change back and forth easily.
%
% FIX: \manualref{17.100} names with initials in place of given names should
% precede those names which are spelled out.  ``J. Robert'' before ``James N.''
% and ``K. T.'' before ``Keven S.''.  This is not consistent with the
% letter-by-letter method (it is with word-by-word).  So, we want to insert a
% space after first-name tokens of length 1.  How do we do that!?
%
% FIX: do we need special handling for names with Saint, Mac, Mc, and M'
% \manualref{17.107--109}?
%    \begin{macrocode}

% FIX: NOTE: \builtin{empty} returns TRUE if string contains no non-whitespace chars
% FIX: other whitespace to check for?

% pop string, push its length not counting special chars as one char
FUNCTION {length}
{ 'u :=
%  u "taking length of" debugval
  #0 'len :=
  % WHILE
  { u "" = not }
    { len #1 + 'len :=
      u #2 global.max$ substring$ 'u :=
    }
  while$         %$
  len
%  len int.to.str$ "      length is" debugval    %$
}


% FIX: a special+ char begins with a |{\| and continues through the next |}|.
% \BibTeX{}'s ``special character'' is the same but only at brace level~0.
% When we're stepping through a string, and we don't keep track of the brace
% level, then those functions that recognize special chars are not going to
% know the brace level, they will see every special+ char as a special char.

% pop string, push its first char counting special chars as one char
% treat braces normally unless they are the start of a special char
%
% don't use \function{and} here for efficiency
FUNCTION {head}
{ 'w :=
  w #1 #1 substring$      %$
  duplicate$ "{" =       %$
    { w #2 #1 substring$ "\" =      %$
        { pop$       %$
          w #1 text.prefix$     %$
        }
        'skip$   %$
      if$       %$
    }
    'skip$      %$
  if$        %$
}

% FIX: using `and' and `or' requires calculation of both where nested branches
% would not; see where this will help.

% pop string, push string without its first char, counting special chars as one char
FUNCTION {behead}
{ 'u :=
%  u "beheading before" debugval
    u
    u head length #1 +
    global.max$            %$
  substring$      %$
%  duplicate$ "beheading  after" debugval    %$
}

FUNCTION {behead.t}
{ t behead 't :=
}

FUNCTION {format.dehyphen}
{ 't :=
%  t "dehyphen before" debugval
  ""
  % WHILE
  { t "" = not }
    { t head
      duplicate$ hyphen =         %$
        { pop$                    %$
        }
        { *
        }
      if$                %$
      behead.t
    }
  while$                                  %$
%  duplicate$ "dehyphen after" debugval    %$
}

% \builtin{text.length}: replace string on stack with its length, special chars count
% as 1 char, don't count braces.

% \builtin{text.prefix}: like \builtin{substring} but count special chars as 1 char, don't
% count braces, and supply a missing closing brace for a special-char.  also,
% have to always start at \#1.

% FIX: does \manual intend to skip over en-dash and em-dash?  these could occur
% in titles.  For the moment I will remove them too, but not in special chars.
% look at \function{format.n.dashify} to be able to distinguish hyphens from
% the dashes.

FUNCTION {format.dehyphen.dewhitespace}
{ 't :=
%  t "dehyphen.dewhitespace before" debugval
  ""
  % WHILE
  { t "" = not }
    { t head
      duplicate$                  %$
        duplicate$ hyphen =       %$
        swap$ empty$
      or
        { pop$                    %$
        }
        { *
        }
      if$                %$
      behead.t
    }
  while$                                  %$
%  duplicate$ "dehyphen.dewhitespace after" debugval          %$
}

FUNCTION {format.names.for.sort}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=                  %$
  numnames 'namesleft :=
  % WHILE
  { namesleft #0 > }
    {
      % NOTE: order or name-parts ought to follow that used for leaditem
      % word-by-word alphabetization:
%      s nameptr "{vv{ } }{ll{ }}{  jj{ }}{  ff{ }}" format.name$                  %$  
      % letter-by-letter alphabetization, no attention to initials:
%      s nameptr "{vv{}}{ll{}}{  jj{}}{  ff{}}" format.name$                  %$  

      % letter-by-letter alphabetization, with first initials exception:

      s nameptr "{vv{}}{ll{}}{  jj{}}" format.name$         %$

      % Each first-name token of the form of an initial ("L.") will be followed by a
      % space but other spaces will be removed.

      % Algorithm: step through looking for space, which terminates name tokens,
      % adding non-spaces to an accumulator on the stack as we go.
      % When we find a space, look at the accumulator (a whole name token).
      % If it's length is 2 and 2d char is a period, we've got an initial, so
      % add the space to the accumulator.  If not, throw away the space
      % and step on looking for another name.
      
      % FIX: would it be simpler to replace periods with spaces?
      %      would a period ever appear in a first-name when not an initial?
      %      Rev.?  Col.?  These should be alphabetized as spelled out, prob.
      %      but need to check \manual

%      duplicate$ "beginning of initials funniness; last-part is" debugval %$

      s nameptr "{ff{ } }" format.name$ 't :=      %$
      % t is "F1 F2 F3 ... FN " or empty

%      t "initial t" debugval

      t empty$       %$
        'skip$       %$
        { delimiter.name-part *
          ""        % accumulator
          % WHILE
          { t "" = not }
            { t head
%              duplicate$ "stepping. t is [" t * "] and head is" * debugval %$
              duplicate$ empty$
                % last char will always be a space
                % accumulator contains whole name token
                { pop$       %$  throw space away for now; top of stack is now accumulator
%                  duplicate$ "found a space; accumulator is" debugval %$
                  duplicate$ %$
                    duplicate$ text.length$ #2 =        %    2 chars long
                    swap$ behead head period =          %$   2d char is period    
                  and
                    % name token in accumulator is an initial, so add a space to it
                    { space *
%                      duplicate$ "found an initial" debugval %$
                    }
                    % name token in accumulator is not an initial
                    'skip$      %$
                  if$        %$
                  % in either case, concatenate the accumulator the name on the
                  % stack and initialize it again
%                  duplicate$ "adding to name" debugval %$
                  * ""
                }
                % accumulator contains partial name token
                % add t's head (not a space) to accumulator
                { *
                }
              if$         %$
              behead.t
            }
          while$            %$
          % we always end up with an empty string on the stack
          pop$     %$
%          duplicate$ "formatted first-name is" debugval %$
%          s nameptr "{ff}{vv}{ll}{jj}" format.name$ "it came from" debugval %$
        }
      if$      %$
%      duplicate$ "end of initials funniness; stack has" debugval             %$

      format.dehyphen
      't :=
      % t now contains one name of a namelist
      nameptr #1 =      
        { t
        }
        { delimiter.name *
	    nameptr numnames =
            t "others" =
          and
            { "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" *
            }
            { t *
            }
          if$                  %$
        }
      if$                  %$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$                  %$
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
% \end{macro}
%  \end{macro}
%  \end{macro}
%
% FIX: should be able to share code with \function{make.leaditem.with.tags}
%
% We don't bother to \function{format.sortify.clip}, just do that once before assignment to
% the \field{sort.key\$}.
%    \begin{macrocode}
FUNCTION {make.principal-field.for.sort}  % FIX: note: leaditem must already be set
{   principal-type author.ptype =
    principal-type editor.ptype =
  or
    { principal-field format.names.for.sort
    }
    { principal-type emergency.ptype =
        { principal-field
        }
        % organization.ptype, key.ptype, including both key.special cases
        % leaditem is the same as principal-field except in the key.special
        % cases, when we do want the leaditem not the principal-field
	{ leaditem	  
	  % letter-by-letter alphabetization:
          format.dehyphen.dewhitespace
        }
      if$           %$
    }
  if$            %$
}
%    \end{macrocode}
%
%   \subsection{Begin and end entries}
%
%  \begin{macro}{begin.entry}
%  Begin an entry.
%    \begin{macrocode}
FUNCTION {begin.entry}
{ output.begin
  output.bibitem
}
%    \end{macrocode}
%  \end{macro}
%
%  \begin{macro}{finish.entry}
% Conclude an entry.
% \cs\stack{string}{null}
%    \begin{macrocode}
FUNCTION {finish.entry}
{ add.period$                      %$
  output.end
  newline$                         %$
  make.annotation write$           %$
}
%    \end{macrocode}
%  \end{macro}
%
%   \subsection{Entry types}
%
%     \subsubsection{Article}
%
% \begin{macro}{article}
% An article from a journal or magazine.  Required: \field{author},
% \field{title}, \field{journal}, \field{year}.  Optional: \field{volume},
% \field{number}, \field{pages}, \field{month}, \field{note}.  Title quoted.
%
% FIX: this is not true any more. hmm, which warnings to give?  Warnings given
% for no \field{pages}; no \field{volume} or \field{number}; and \field{number}
% but no \field{volume}.  It's a drag, but the latter warning should remain
% there. The reason is that this bibstyle will produce a very misleading entry
% if you mistakenly omit the volume and give a number for a journal.
%
% FIX: this is the old def of article, following output of title through end of
% crossref conditional.
% \begin{codeexample}
%       volume field.or.null
% %    \end{macrocode}
% %  One item (the volume) is on the stack now. Each of the four cases in the
% %  following conditionals should leave a second item on the stack.
% %    \begin{macrocode}
%       number empty$                   %$
%         { volume empty$                   %$
%             { "empty volume and number in " cite$ * warning$
%               ""
%             }
%             { colon
%             }
%           if$                   %$
%         }
%         { volume empty$                   %$
%             { "number but no volume in " cite$ * warning$
% %    \end{macrocode}
% % FIX when a journal has no volume but a number, there should be a comma after
% % the journal, a space and then ``no. n:ppp''.  But we have already said
% % ``space output'' after the journal name, no doubt.  So we have to make this
% % decision earlier.
% %    \begin{macrocode}
%               "\unskip, no." tie * number * colon *
%             }
%             { "(" number * ")" * tie.or.space.connect
% %    \end{macrocode}
% % FIX: I don't think this is handling the case without pages right -- there
% % will be a colon with nothing following.  I could save either colon or
% % colon+space in a variable, and slap it on before the pages if there are pages
% % and leave it off if there are no pages.  Hmm, no: see \manaul 15.215
% % for how to handle missing pages.  Not easy.
% %
% % Now there's just one item (the volume) on the stack, so leave the following
% % as the second item.
% %    \begin{macrocode}
%               colon space *
%             }
%           if$
%         }
%       if$ *
%       make.pages "pages" check.empty * 
%       space output
%       month parenthesize space output
% \end{codeexample}
%
%  A crossref from an article says ``See this, pages xxx.''  See \manual 16:107
% for this peculiar bit about the spacing after the colon.
%    \begin{macrocode}
FUNCTION {article}
{ begin.entry
  make.leaditem.with.tags space output
  new.block
  make.year.nomonth "year" check.empty space output
  new.block
  make.title.inquotes "title" check.empty space output
  new.block
  crossref empty$                              %$
    { journal italicize "journal" check.empty space output
      series empty$                              %$
        'skip$                              %$
%    \end{macrocode}
% FIX: take this out when we finish \function{make.vol.series}.
%    \begin{macrocode}
        { "Achicago can not yet handle nonempty series! in " cite$ * warning$
        }
      if$                              %$
      volume empty$ number empty$ month empty$ pages empty$ and and and
        { "empty volume, number, month, and pages in " cite$ * warning$
        }
        'skip$                              %$
      if$                              %$
%    \end{macrocode}
% See definition of \function{make.vol.series.num.month.pages} for why we set
% \gvar{u} in that function.
%    \begin{macrocode}
      make.vol.series.num.month.pages u output
    }
%    \end{macrocode}
% Unusual case where you are probably citing one journal issue and numerous
% articles within it, so you have one entry for the issue itself, and others
% referring to it.  Perhaps there are other cases, but I think what's right
% here is to give the crossref and only the pages.
%    \begin{macrocode}
    { "In " make.crossref * space output
      make.pages "pages" check.empty comma output
    }
  if$                              %$
  new.block
  note space output
  finish.entry
}
%    \end{macrocode}
% \end{macro}
%
%     \subsubsection{Book}
%
% \begin{macro}{book}
%   \mbox{}
%    \begin{macrocode}
FUNCTION {book}
{ begin.entry
  make.leaditem.with.tags comma output
  new.block
  make.year.or.oyear.month "year" check.empty comma output 
  new.block
  make.title.ital "title" check.empty comma output
  new.block
  make.edition comma output
  new.block
  crossref empty$                              %$
    { volume empty$                              %$
        { output.series.number
        }
        { output.volume.series
        }
      if$                              %$
      editor empty$ author empty$ or
        'skip$                              %$
        { new.block
          make.editors.secondary comma output
        }
      if$                  %$
      new.block
      make.translators comma output
      new.block
      make.illustrators comma output
      new.block
      oyear empty$                              %$
        { address comma output
          publisher "publisher" check.empty colon output
        }
        { oaddress comma output
          opublisher "opublisher" check.empty colon output
          new.block
          "Reprint" comma output
          address field.or.null comma output
          publisher "publisher" check.empty
          address empty$                              %$
            { comma
            }
            { colon
            }
          if$                  %$
          output
          year "year" check.empty comma output          
        }
      if$                              %$
    }
    { volume empty$                              %$
        { "In "
        }
        { "Volume" volume tie.or.space.connect
          " of " *
        }
      if$                      %$
      make.crossref * comma output
    }
  if$                              %$
  new.block
  yearcomp empty$                              %$
    'skip$                              %$
    { "Composed in " yearcomp *
      comma output
      new.block
    }
  if$                              %$
%    \end{macrocode}
% The \field{fyear} must be nonempty to get any information about the first-published
% edition, 
%
% The \field{fpublisher}, \field{faddress}, and \field{flanguage} can be empty in any
% combination.  They are all ignored if \field{fyear} is empty, except for possibly
% \field{flanguage}, which will be given with the translator if \field{translator} is
% nonempty.
%    \begin{macrocode}
  fyear empty$
    'skip$
    { "First published "
      translator empty$ flanguage empty$ not and
        { "in " * flanguage * space *
        }
        'skip$
      if$
%    \end{macrocode}
% If \field{ftitle} is empty, there will be a harmless? extra space.
% FIX: surely i can fix that...
%    \begin{macrocode}
      make.as.ftitle.ital * space output
      faddress empty$ fpublisher empty$ not and
        { "by "
        }
        { "in "
        }
      if$                  %$
      space output
      faddress space output
      fpublisher
      faddress empty$                  %$
        { space
        }
        { colon
        }
      if$                  %$
      output
      fyear
      faddress empty$ fpublisher empty$ and
        { space
        }
        { comma
        }
      if$ output                  %$
      new.block
    }
  if$                                        %$
  note comma output
  finish.entry
}
%    \end{macrocode}
% \end{macro}
%
%     \subsubsection{Inbook}
%
% \begin{macro}{inbook}
% \manual doesn't seem to recognize parts of a book without their own titles.
% We make up our own version, moving the chapter and page information from the
% end of the \field{booktitle} to the beginning.
%    \begin{macrocode}
FUNCTION {inbook}
{ begin.entry
  make.leaditem.with.tags comma output
  new.block
  make.year.or.oyear.month "year" check.empty comma output
  new.block
%    \end{macrocode}
%  We store an extra copy of \function{make.chapter.of} in the variable\gvar{u} here, so
%  that we know whether to put pages or not after the \field{title} sentence
%  (with editors, and so on).
%    \begin{macrocode}
  crossref empty$            %$
    { make.chapter.of
      duplicate$ 'u :=              %$
      duplicate$ empty$
        { pop$                  %$
          pages empty$                  %$
            { "empty chapter, type, and pages in " cite$ * warning$ 
              "In "
            }
            { "Pages " make.pages * " in " *
            }
          if$                  %$
        }
        'skip$                  %$
      if$                  %$
      comma output
      make.title.ital "title" check.empty space output
      make.bookauthors.secondary comma output
      make.editors.secondary comma output
      volume empty$                  %$
        { output.series.number
        }
        { output.volume.series
        }
      if$                  %$
      make.edition comma output
%    \end{macrocode}
%  Here we branch again on the contents of \function{make.chapter.of}.  If it is not
%  empty, then we go ahead and \function{make.pages}.  If it is empty we don't, because
%  this means that if \field{pages} were given, they have already been put earlier.
%    \begin{macrocode}
      u empty$                  %$
        'skip$                  %$
        { make.pages comma output
        }
      if$                  %$
      new.block
      make.translators comma output
      new.block
      make.illustrators comma output
      new.block
      oyear empty$                  %$
        { address comma output
          publisher "publisher" check.empty colon output
        }
        { oaddress comma output
          opublisher "opublisher" check.empty colon output
          new.block
          "Reprint" comma output
          address field.or.null comma output
          publisher "publisher" check.empty
          address empty$                  %$
            { comma
            }
            { colon
            }
          if$                  %$
          output
          year "year" check.empty comma output          
        }
      if$                  %$
    }
    % crossref not empty
    { "In " make.crossref * comma output
      make.chapter comma output
      make.pages comma output
      chapter empty$ pages empty$ and
        { "empty chapter and pages in " cite$ * warning$
        }
        'skip$                  %$
      if$                  %$
    }
  if$                  %$
  new.block
  note comma output
  finish.entry
}
%    \end{macrocode}
% \end{macro}
%
%     \subsubsection{Incollection}
%
% \begin{macro}{incollection}
% \mbox{}
%    \begin{macrocode}
FUNCTION {incollection}
{ begin.entry
  make.leaditem.with.tags comma output
  new.block
  make.year.or.oyear.month "year" check.empty space output
  new.block
% FIX: use \field{type} to say what kind of title this is? e.g., play, poem,
% chapter, story?
  make.title.inquotes "title" check.empty space output
  new.block
  crossref empty$                  %$
    { make.chapter.of duplicate$ empty$
        { pop$                  %$
          "In "
        }
        'skip$                        %$
      if$                  %$
      space output
      make.booktitle.ital "booktitle" check.empty space output
      make.bookauthors.secondary comma output
      make.editors.secondary comma output
      volume empty$                  %$
        { output.series.number
        }
        { output.volume.series
        }
      if$                  %$
      make.edition comma output
% FIX: do I need this?  I don't for copleston:cusa
%      make.year.or.oyear.month "year" check.empty comma output
      make.pages comma output
      chapter empty$ type empty$ and pages empty$ and                  %$
        { "empty chapter, type, and pages in " cite$ * warning$
        }
        'skip$                          %$
      if$                  %$
      new.block
      make.translators space output
      new.block
      make.illustrators space output
      new.block
      oyear empty$                  %$
        { address space output
          publisher "publisher" check.empty colon output
        }
        { oaddress space output
          opublisher "opublisher" check.empty colon output
          new.block
          "Reprint" comma output
          address comma output
          publisher "publisher" check.empty
          address empty$                  %$
            { comma
            }
            { colon
            }
          if$                  %$
          output
          year comma output          
        }
      if$                  %$
    }
    % crossref not empty
    { new.block
      "In " make.crossref * space output
      make.chapter comma output
      make.pages comma output
      chapter empty$ pages empty$ and
        { "empty chapter and pages in " cite$ * warning$
        }
        'skip$                  %$
      if$                  %$
    }
  if$                  %$
  new.block
  note space output
  finish.entry
}
%    \end{macrocode}
% \end{macro}
%
%     \subsubsection{Majorthesis}
%
% \begin{macro}{format.thesis}
% \begin{macro}{thesis}
% \begin{macro}{phdthesis}
% \begin{macro}{mastersthesis}
% \begin{macro}{majorthesis}
% \begin{macro}{minorthesis}
% Theses are all set in the same way, with a different type name.  An entry
% with entry type \entry{thesis} ought to have a nonempty \field{type}.  The other four
% alias entry types simply supply an explicit value for \field{type}, which are
% overridden by a nonempty \field{type}.
%
% FIX The \field{type} field should be hooked into a variable and done with the
% \package{babel} package: \cs\majorthesisname and so on.
%    \begin{macrocode}
FUNCTION {format.thesis}
{ 'v :=
  begin.entry
  make.leaditem.with.tags comma output
  new.block
  make.year.month "year" check.empty space output
  new.block
  make.title.inquotes "title" check.empty space output
  new.block
  v "type" check.empty space output
  school "school" check.empty comma output
  address comma output
  new.block
  note space output
  finish.entry
}
FUNCTION {thesis}
{ type field.or.null format.thesis 
}
FUNCTION{mastersthesis}
{ type empty$               %$
    { "Master's thesis"
    }
    { type
    }
  if$               %$
  format.thesis
}
FUNCTION {minorthesis}
{ mastersthesis
}
FUNCTION {phdthesis}
{ type empty$               %$
    { "Ph.D.~diss."
    }
    { type
    }
  if$               %$
  format.thesis
}
FUNCTION {majorthesis}
{ phdthesis
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
%
%     \subsubsection{Manual}
%
% \begin{macro}{manual}
% Technical documentation.  Required: \field{title} (italicized).  Optional:
% \field{author} or \field{organization} or \field{key}, \field{address},
% \field{edition}, \field{month}, \field{year}, \field{note}.  Logic:
% \evar{leaditem} is first nonempty field of \field{author},
% \field{organization}, and \field{key}.  Subsequent nonempty fields in that
% list are ignored.  Special case: when \evar{principal-field} is
% \field{organization} and \field{key} is nonempty, use \field{key} for the
% label instead of \field{organization}.
%
%    \begin{macrocode}
FUNCTION {manual}
{ begin.entry
  make.leaditem.with.tags space output
  new.block
  make.year.month space output
  new.block
  make.title.ital "title" check.empty comma output
  new.block
  make.edition comma output
  new.block
  address space output
  organization colon output
  new.block
  note space output
  finish.entry
}
%    \end{macrocode}
% \end{macro}
%
%     \subsubsection{Booklet}
%
% \begin{macro}{booklet}
% A work that is printed and bound, but without a named publisher or sponsoring
% institution.  Required: \field{title}.  Optional: \field{author}, \field{howpublished},
% \field{address}, \field{month}, \field{year}, \field{note}.  Title is quoted.  \field{key} used if \field{author}
% is empty.
%    \begin{macrocode}
FUNCTION {booklet}
{ begin.entry
  make.leaditem.with.tags comma output
  new.block
  make.year.month space output
  new.block
  make.title.inquotes "title" check.empty comma output
  new.block
  howpublished space output
  address comma output
  new.block
  note space output
  finish.entry
}
%    \end{macrocode}
% \end{macro}
%
%     \subsubsection{Inproceedings}
%
% \begin{macro}{inproceedings}
% \begin{macro}{conference}
% An article in a conference proceedings.  Required: \field{author},
% \field{title}, \field{booktitle}, \field{year}.  Optional: \field{editor},
% \field{volume} or \field{number}, \field{series}, \field{pages},
% \field{address}, \field{month}, \field{organization}, \field{publisher},
% \field{note}.  \field{key} used where \field{author} empty.  Title quoted.
%    \begin{macrocode}
FUNCTION {inproceedings}
{ begin.entry
  make.leaditem.with.tags comma output
  new.block
  make.year.month "year" check.empty space output
  new.block
  make.title.inquotes "title" check.empty space output
  new.block
  crossref empty$                  %$
    { make.editors.secondary space output
      make.booktitle.ital "booktitle" check.empty comma output
      volume empty$                  %$
        { output.series.number
        }
        { output.volume.series
        }
      if$                  %$
      make.edition comma output
      new.block
      organization space output
      address comma output
      publisher colon output
      make.pages comma output
    }
    { "In " make.crossref * space output
      make.chapter comma output
      make.pages comma output
      chapter empty$ pages empty$ and
        { "empty chapter and pages in " cite$ * warning$
        }
        'skip$                  %$
      if$                  %$
    }
  if$                  %$
  new.block
  note space output
  finish.entry
}
FUNCTION {conference} 
{ inproceedings
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
%     \subsubsection{Proceedings}
%
% \begin{macro}{proceedings}
% The proceedings of a conference.  Required: \field{title}, \field{year}.
% Optional: \field{editor}, \field{volume} or \field{number}, \field{series},
% \field{address}, \field{month}, \field{organization}, \field{publisher},
% \field{note}.  If \field{editor} empty, use \field{organization} for
% \evar{leaditem}.  For label, like type manual, use nonempty \field{key} for
% the label instead of \field{organization}.  Title italicized.
%    \begin{macrocode}
FUNCTION {proceedings}
{ begin.entry
  make.leaditem.with.tags space output
  new.block
  make.year.month "year" check.empty space output
  new.block
  make.title.ital "title" check.empty comma output
  new.block
  make.edition comma output
  new.block
  volume empty$               %$
    { output.series.number
    }
    { output.volume.series
    }
  if$               %$
  new.block
  organization space output
  address comma output
  publisher colon output
  new.block
  note comma output
  finish.entry
}
%    \end{macrocode}
% \end{macro}
%
%     \subsubsection{Misc}
% Required: \emph{none}.  The rest are optional.  \field{leaditem} is
% \field{author} or \field{key} if empty.  \field{year} with \field{month}.
% Then \field{title}, quoted.  Then \field{howpublished}.  Then \field{note}.
%    \begin{macrocode}
FUNCTION {misc}
{ begin.entry
  make.leaditem.with.tags comma output
  new.block
  make.year.month space output
  new.block
  title space output
  new.block
  howpublished comma output
  new.block
  note space output
  finish.entry
}
%    \end{macrocode}
%
%     \subsubsection{Techreport}
%
% \begin{macro}{techreport}
% A report published by a school or other institution, usually numbered within
% a series.  Required: \field{author}, \field{title}, \field{institution},
% \field{year}.  Optional: \field{type}, \field{number}, \field{address},
% \field{month}, \field{note}.  \field{key} used when \field{author} empty.
%    \begin{macrocode}
FUNCTION {techreport}
{ begin.entry
  make.leaditem.with.tags comma output
  new.block
  make.year.month "year" check.empty comma output
  new.block
  make.title.inquotes "title" check.empty comma output
  new.block
  make.number.tr comma output
  institution "institution" check.empty comma output
  address comma output
  new.block
  note comma output
  finish.entry
}
%    \end{macrocode}
% \end{macro}
%
%     \subsubsection{Unpublished}
%
% \begin{macro}{unpublished}
% A document having an author and title, but not formally published.  Required:
% \field{author}, \field{title}, \field{note}.  Optional: \field{month},
% \field{year}.  Uses \field{key} for no \field{author}.
%    \begin{macrocode}
FUNCTION {unpublished}
{ begin.entry
  make.leaditem.with.tags comma output
  new.block
  make.year.month space output
  new.block
  make.title.inquotes "title" check.empty space output
  new.block
  note "note" check.empty space output
  finish.entry
}
%    \end{macrocode}
% \end{macro}
%
%     \subsubsection{Default}
%
% \begin{macro}{default.type}
%   I think \BibTeX{} is hardwired to look for this name.
%    \begin{macrocode}
FUNCTION {default.type} 
{ misc }
%    \end{macrocode}
% \end{macro}
%
%   \subsection{Sorting}
%
% \begin{macro}{chop.word}
% \cs\stack{\meta{string} \meta{num} \meta{string}}{\meta{string}}
% \begin{verbatim}
% stack: S n T
%
% if S = substr(1,n,T)
%    then substr(n+1, max, T)
%    else S
%
% if T begins with S, then chop it off the beginning of T.
% \end{verbatim}
% I guess we don't bother calculating the length for efficiency's sake.
%    \begin{macrocode}
FUNCTION {chop.word}
{ 't :=
  'len :=
  t #1 len substring$ =               %$
    { t len #1 + global.max$ substring$
    }
    { t
    }
  if$               %$
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{make.title.for.sort}
% We don't bother to \function{format.sortify.clip}, just do that once before assignment to
% the sort.key.
%    \begin{macrocode}
FUNCTION {make.title.for.sort}
{ title field.or.null
  't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
% letter-by-letter alphabetization:
  format.dehyphen.dewhitespace
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{presort}
%
% Set \evar{label}, \evar{year.label}, \evar{leaditem}.  Set \field{sort.key\$}
% to \evar{leaditem} + \evar{year.label} + title suitably massaged.
%
% Note that \evar{year.label.tag} is not set yet; it will be set in stages in
% \function{forward.pass.add.bcds} and \function{reverse.pass.add.as}.
%    \begin{macrocode}
FUNCTION {presort}
{ set.principal-field.principal-type

%  "principals set for " cite$ * debugmsg        %$
  make.leaditem
  'leaditem :=

%  "leaditem set for " cite$ * debugmsg       %$
  make.label
  'label :=

%  "label set for " cite$ * debugmsg            %$
  oyear empty$                   %$
    { year
    }
    { oyear
    }
  if$                   %$
% FIX: substring or text.prefix?  if purify removes special chars then no diff.
  field.or.null purify$ #-1 #4 substring$
  'year.label :=
}

FUNCTION {sortkey<-label+year+principal+title}
{ label
  delimiter.sub-sortkey *
  year.label *
  delimiter.sub-sortkey *
  make.principal-field.for.sort *
  delimiter.sub-sortkey *
  make.title.for.sort *
  format.sortify.clip
  'sort.key$ :=                  %$
}

FUNCTION {sortkey<-principal+year+year-tag}
{ make.principal-field.for.sort
  delimiter.sub-sortkey *
  year.label *
% FIX if year.label is ever going to be a variable length, need some padding here?
  year.label.tag *
  format.sortify.clip
  'sort.key$ :=                  %$
}

FUNCTION {presort.&.sortkey<-label+year+principal+title}
{ presort
%  "presort done for " cite$ * debugmsg      %$
  sortkey<-label+year+principal+title
%  "sortkey set to label+year+principal+title for " cite$ * debugmsg       %$
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{initialize.sorting-gvars}
%   \mbox{}
%    \begin{macrocode}
FUNCTION {initialize.sorting-gvars}
{ unidentified 'last.leaditem :=
  unidentified 'last.label.and.year :=
  "" 'following.year.label.tag :=
  #0 'last.year.tag.num :=
}
%    \end{macrocode}
% \end{macro}
%
% \section{Disambiguating citations and sorting the bibliography}
%
% The initial calculation of citations can result in
% ambiguous labels for some entries.  Two kinds of ambiguities can result:
%
% \begin{description}
%   \item[same principal] 
%     These are disambiguated by adding a unique lowercase letter to the end of
%     the citations for each entry in the ambiguous set: (Smith 1980a) and
%     (Smith 1980b); (Smith et~al. 1970a), (Smith et~al. 1970b).  The order of
%     the letters corresonds to the order of their appearance in the
%     bibliography (see below).
%   \item[different principal]
%
%     Different principals can have be (initially) given the same label in two
%     cases: (1) the principals include 4 or more names and the initial names
%     share a surname, and (2) the principals include the same number $n<4$ of
%     names and both the initial names and each of the subsequent names when
%     present share a surname.  In each case, the entries must also have the
%     same year+tag, that is, the same year \emph{including} any lowercase
%     letters that might have been added.  In both cases, ambiguous labels are
%     disambiguated by adding first initials to those names which differ in the
%     first name: (P.~Smith 1980), (M.~Smith 1980); (Green, Z.~Black, and Meyer
%     1980), (Green, B.~Black, and Meyer 1980); (Benson, Brown, Gray, White,
%     B.~Black, and Griscom 1900), (Benson, H.~Brown, Gray, White, Z.~Black,
%     and Griscom 1900).  When even first initials aren't enough to
%     disambiguate, full names are used: (John~D.\ Smith 1990), (John~Q.\ Smith
%     1990); etc.
%
% \end{description}
% 
% FIX: current behavior disambiguates all ambiguous citations by means of the
% lowercase letter.  ``A, B, C, and D 1999'' together with ``A, B, C, and E
% 1999'' are going to resolve to ``A et al 1999a'' and 1999b.  This nicely
% avoids disambiguation, but not what the Manual specifies.
%
% FIX: current behavior is going to disambiguate citations that are ambiguous
% because authors share last but differ in first names by means of the
% lowercase letter: ``Aa 1999'' and ``Ab 1999'' become ``Aa 1999a'' and ``Ab
% 1999b'' (where `A' stands for last name, and the `a' right after it is the
% unmentioned first name).  The Manual, however, specifies (16.3)
% disambiguating by using first initials in the label, such as ``M. Brown
% 1999''.
%
% add.bcds: work on getting the right \evar{year.label.tag}.  Compare current
% entry's \evar{label} plus \evar{year.label} to the last entry's, which is
% stored in the global string variable \gvar{last.label.and.year}.  If they are
% the same, increment global integer variable \gvar{last.year.tag.num} and set
% \evar{year.label.tag} to the $n$th lowercase letter, where $n$ is
% \gvar{last.year.tag.num}.  If they are not the same, set
% \gvar{last.label.and.year} to the current \evar{label} plus \evar{year.label}, set
% \evar{year.label.tag} to empty string, and set \gvar{last.year.tag.num} to~0.
%
% After add.bcds pass, \evar{year.label.tag} will be blank for all first
% entries of an ambiguous series, and ``b,'' ``c,'' etc.\ for second entries,
% third entries, and so on. The ``a'''s will be added in the right places by
% the reverse.pass.add.as function.
%
% Handle duplicate \evar{leaditem}s.  Compare current entry's
% \evar{leaditem} with the last entry's, which is stored in the global string
% variable \gvar{last.leaditem}.  When they are the same, wrap the current
% entry's \evar{leaditem} in \cs\SCduplicate.
%    \begin{macrocode}
FUNCTION {forward.pass.wrap.dupe.leaditems}
{ leaditem
  duplicate$ last.leaditem =                  %$
    % we add the brace pair at the end because this forces add.period$ to add a  %$
    % period after it.  FIX: if we ever want \SCdup to actually print its
    % argument, we must get it to print its argument minus any final period.
    { "\SCduplicate{" swap$ * "{}}" * 'leaditem :=                  %$
    }
    { 'last.leaditem :=
    }
  if$                  %$
}
FUNCTION {forward.pass.add.bcds}
{ label year.label * format.clip
  duplicate$ last.label.and.year =                  %$
    % same as previous entry
    { pop$                  %$
      last.year.tag.num #1 + 'last.year.tag.num :=
      last.year.tag.num int.to.chr$ 'year.label.tag :=                  %$
    }
    % different from previous entry
    { "a" chr.to.int$ 'last.year.tag.num :=                  %$
      "" 'year.label.tag :=
      'last.label.and.year := 
    }
  if$                  %$
}
% FIX: use a minimum of entry-variables to hold 'last' things.
% FIX: change `last' to 'prev' where appropriate.  what about vars that might
% be used going forward and back?  always use `prev'?

%    \end{macrocode}
%
% \begin{macro}{reverse.pass.add.as}
%   Pass through the entries in reverse order.  Set current
%   \evar{year.label.tag} to ``a'' on entries that precede ones with ``b''s.
%   Set \evar{following.year.label.tag} to the current \evar{year.label.tag}.
%    \begin{macrocode}
FUNCTION {reverse.pass.add.as}
{ following.year.label.tag "b" =
    { "a" 'year.label.tag := 
    }
    'skip$                  %$
  if$                  %$
  year.label.tag 'following.year.label.tag :=
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{begin.bib}
% \begin{macro}{end.bib}
%   These two functions are called to begin and end the entire bibliography. 
%    \begin{macrocode}
FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$                  %$
    { preamble$ write$ newline$                  %$
    }
  if$                  %$
  "\begin{thebibliography}{}" write$ newline$
}
FUNCTION {end.bib}
{ newline$                  %$
  "\end{thebibliography}" write$ newline$
}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
%   \subsection{Actions}
%
% This is the main subroutine which calls all the others.
%    \begin{macrocode}
READ

EXECUTE {init.scalars}

ITERATE {presort.&.sortkey<-label+year+principal+title}
SORT 

EXECUTE {initialize.sorting-gvars}

% add in "b"'s etc.
ITERATE {forward.pass.add.bcds}
% add in "a"'s
REVERSE {reverse.pass.add.as}

ITERATE{sortkey<-principal+year+year-tag}
SORT 

EXECUTE {initialize.sorting-gvars}
ITERATE {forward.pass.wrap.dupe.leaditems}


EXECUTE {begin.bib}
ITERATE {call.type$}                  %$
EXECUTE {end.bib}
%    \end{macrocode}
%
% \Finale
