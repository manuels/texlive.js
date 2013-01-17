% This software is based on previous APA formats as explained below. The
% changes made to produce the mslapa format were originally made by Michael S.
% Landy in 1994 and are public domain. The copyright and licensing of the file
% as a whole also depends on the copyright and licensing of the original code.
% Further details may be found below.
% This statement added 2008/11/25 by Clea F. Rees in an attempt to make the
% situation a little clearer following communication with Michael S. Landy.
%$$$ mslapa.bst $$$
%
% Slightly modified version by Michael Landy - 7/29/94
% This file should be used with style `mslapa.sty'
%
% This pair of files automates most (although not all) of the bibliographic
% and citation formatting of APA (American Psychological Association) style.
% The various citations formats that you want are things like:
% 1	`in the work of Landy (1985, 1989a,b)'
% 2	`in the work of Landy, Dosher and Sperling (1989)'
% 3	`in the work of Landy and colleagues (1989)'
% 4	`it has been shown (Landy, 1989) that ...'
% 5	`it has been shown (Landy, 1989a, 1990; Sperling, 1991) that ...'
% 6	`it has been shown (Landy, Dosher & Sperling, 1989a) that ...'
% 7	`it has been shown (Landy et al., 1989a) that ...'
% 8	`it has been shown (e.g., Landy et al., 1989a) that ...'
% 9	`it has been shown (see, e.g., Landy et al., 1989a, for discussion) ...'
%
% These are achieved by a number of citation macros:
%
%	\cite(PRENOTE)[NOTE]{KEY1,KEY2} - for cases 4, 5 and 6
%	\shortcite(PRENOTE)[NOTE]{KEY1,KEY2} - for case 7, 8 and 9
%	\citeyear(PRENOTE)[NOTE]{KEY1,KEY2} - for cases 1, 2 and 3
%
% Note that PRENOTE will be put in the parentheses preceding the citations
% (and followed by a blank), and NOTE will follow the citations (preceded by
% a comma).  Both PRENOTE and NOTE are (independently) optional arguments.
% Thus, number 8 above was produced by
%
%		\shortcite(e.g.,){LANDYETAL89A},
%
% and number 9 was produced by
%
%		\shortcite(see, e.g.,)[for discussion]{LANDYETAL89A}.
%
% \shortcite will use `et al.' for all citations of 3 or more authors.  If
% you have a string of citations with more than one citation of 3 or more
% authors, and you want some of those to have et al. and others to be spelled
% out, then you will have to use \nocite{KEY1,KEY2} and format the citation
% yourself by hand:
%
%	`it has been shown (Landy, Dosher & Sperling, 1989a; Sperling et al.,
%	1990\nocite{LANDETAL89A,SPERETAL90}) that ...'
%
% There are also macros which insert only the author text without the year
% (\fullciteA and \shortciteA), although it's not clear to me where one would
% want to use that.  If you want to format things in any other way, you are
% stuck formatting the citation yourself, e.g.:
%
%	In 1989, Landy and colleagues\nocite{LANDETAL89} discovered...
%
% The style macros for cite/shortcite/citeyear will lay things out as
% described above, so that if two citations in a row have the same authors,
% the authors are listed once, and if the same year as well, only the letter
% names are added (as in 1989a,b).  The algorithm recognizes that the form
% `Landy et al.' can refer to any articles with 3 or more authors beginning
% with Landy, and hence all such cited articles require letters after the year
% (just in case you happen to cite them using `et al.').  The letters are
% added in such a way that the citation letters for a given shortauthor/year
% combination appear in order in the references section.  Also, in the reference
% section, and author such as `von Helmholtz' will be alphabetized under H
% and printed as `von Helmholtz, H. (1866). ...'.  If you prefer to
% alphabetize this under V you can either put the name in braces {von Helmholtz}
% in your bibliography file (to make it look like a last name), or you can
% alter the function `sort.format.names' below as indicated in the comment to
% be found there.
%
% Things this style won't do for you:
%
%	Citations come out in the order you put them in the argument
%	to cite/shortcite/citeyear.  So, if you want them sorted a
%	particular way (alphabetically within year or vice versa), you have
%	to do that yourself.
%
%	APA specifies that full author order should be used the first time
%	a reference is cited, and et al. (for 3 or more authors) thereafter.
%	You have to do this yourself by using \cite or \citeyear the first
%	time and \shortcite thereafter.
%
%
% BibTeX `mslapa' style file for BibTeX version 0.99c, LaTeX version 2.09
% Place it in a file called mslapa.bst in the BibTeX search path.  
% (Placing it in the same directory as the LaTeX document should also work.)
% Support for named citations is provided by mslapa.sty

% This version was made by modifying the master file made by
% Oren Patashnik (PATASHNIK@SCORE.STANFORD.EDU), and the 'named' BibTeX
% style of Peter F. Patel-Schneider.

% Copyright (C) 1985, all rights reserved.
% Copying of this file is authorized only if either
% (1) you make absolutely no changes to your copy, including name, or
% (2) if you do make changes, you name it something other than 'newapa.bst'.
% There are undoubtably bugs in this style.  If you make bug fixes,
% improvements, etc.  please let me know.  My e-mail address is:
%    spencer@cgrg.ohio.state.edu or 71160.3141@compuserve.com
%
% This style was made from 'plain.bst', 'named.bst', and 'apalike.bst', 
% with lots of tweaking to make it look like APA style, along with tips 
% from Young Ryu and Brian Reiser's modifications of 'apalike.bst'.
%
%   Reference list ordering: alphabetical by author or whatever passes
%    for author in the absence of one.
%
% The LaTeX style has to have the following (these are far simplified from
% what's in mslapa.sty):
%
%     \let\@internalcite\cite
%     \def\fullcite{\def\citeauthoryear##1##2##3##4{##1, ##3##4}\@internalcite}
%     \def\fullciteA{\def\citeauthoryear##1##2##3##4{##1}\@internalcite}
%     \def\shortcite{\def\citeauthoryear##1##2##3##4{##2, ##3##4}\@internalcite}
%     \def\shortciteA{\def\citeauthoryear##1##2##3##4{##2}\@internalcite}
%     \def\citeyear{\def\citeauthoryear##1##2##3##4{##3##4}\@internalcite}
%

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
%   month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
  }
  {}
  { label1 label2 extra.label sort.label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t u }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    { output.state before.all =
        'write$
        { add.period$ " " * write$ }
      if$
    }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {special.output.nonnull}
{ 's :=
  output.state mid.sentence =
    { "  " * write$ }
    { output.state after.block =
        { ": " write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { ": " * write$
		    }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output.nonnull.colon}
{ 's :=
  output.state mid.sentence =
    { ": " * write$ }
    { output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    { output.state before.all =
        'write$
        { add.period$ " " * write$ }
      if$
    }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output.nonnull.space}
{ 's :=
  output.state mid.sentence =
    { "\ " * write$ }
    { output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    { output.state before.all =
        'write$
        { add.period$ " " * write$ }
      if$
    }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {special.output}
{ duplicate$ empty$
    'pop$
    'special.output.nonnull
  if$
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.check.colon}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull.colon
  if$
}

FUNCTION {output.check.space}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull.space
  if$
}

FUNCTION {output.year.check}
{ year empty$
     { "empty year in " cite$ * warning$ }
     { write$
        " (" year * extra.label * ")" *
        mid.sentence 'output.state :=
     }
  if$
}

FUNCTION {output.bibitem}
{ newline$

  "\bibitem[\protect\citeauthoryear{" write$
  label1 write$
  "}{" write$
  label2 write$
  "}]{" write$

  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
    'skip$
    { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {underline}
{ duplicate$ empty$
  { pop$ "" }
  { "\underline{" swap$ * "}" * }
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

FUNCTION {emphasize.space}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "\/}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=               % nameptr = 1;
  s num.names$ 'numnames :=    % numnames = num.name$(s);
  numnames 'namesleft :=
    { namesleft #0 > }

    { s nameptr "{vv~}{ll}{, jj}{, f.}" format.name$ 't :=

      nameptr #1 >
        { namesleft #1 >
              { ", " * t * }
               { % numnames #2 >
                  %   { "," * }
                   %  'skip$
                  % if$
                  t "others" =
                        { " et~al." * }
%                       { " and " * t * }
%                       { ", \& " * t * }
                        { " \& " * t * }
                      if$
                }
               if$
             }
            't
        if$
        nameptr #1 + 'nameptr :=          % nameptr += 1;
        namesleft #1 - 'namesleft :=      % namesleft =- 1;
    }
  while$
}

FUNCTION {format.names.fml}
{ 's :=
  #1 'nameptr :=               % nameptr = 1;
  s num.names$ 'numnames :=    % numnames = num.name$(s);
  numnames 'namesleft :=
    { namesleft #0 > }

    { s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ 't :=

      nameptr #1 >
        { namesleft #1 >
              { ", " * t * }
               { % numnames #2 >
                    % { "," * }
                    % 'skip$
                  % if$
                  t "others" =
                        { " et~al." * }
%                        { " and " * t * }
                        { " \& " * t * }
                      if$
                }
               if$
             }
            't
        if$
        nameptr #1 + 'nameptr :=          % nameptr += 1;
        namesleft #1 - 'namesleft :=      % namesleft =- 1;
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.key}
{ empty$
    { key field.or.null }
    { "" }
  if$
}

FUNCTION {format.editors.fml}
{ editor empty$
    { "" }
    { editor format.names.fml
      editor num.names$ #1 >
    { " (Eds.)" * }
    { " (Ed.)" * }
      if$
    }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
    { " (Eds.)" * }
    { " (Ed.)" * }
      if$
    }
  if$
}

FUNCTION {format.editors.dot}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
    { " (Eds.)." * }
    { " (Ed.)." * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

% Note that the APA style requres case changes
% in article titles. The following does not
% change cases. If you perfer it, uncomment the
% following and comment out the above.

%FUNCTION {format.title}
%{ title empty$
%    { "" }
%    { title }
%  if$
%}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
    { t #1 #2 substring$ "--" = not
        { "--" *
          t #2 global.max$ substring$ 't :=
        }
        {   { t #1 #1 substring$ "-" = }
        { "-" *
          t #2 global.max$ substring$ 't :=
        }
          while$
        }
      if$
    }
    { t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
      if$
    }
  while$
}

FUNCTION {format.btitle}
{ edition empty$
  { title emphasize }
  { title empty$
    { title emphasize }
    { "{\em " title * "\/} (" * edition * " Ed.)" * }
% msl 9/94 - deleted `.' after `Ed.)'
    if$
  }
  if$
}

FUNCTION {format.emphasize.booktitle}
{ edition empty$
  { booktitle emphasize }
  { booktitle empty$
    { booktitle emphasize }
    { "{\em " booktitle * "\/} (" * edition * " Ed.)" * }
% msl 9/94 - deleted `.' after `Ed.)'
    if$
  }
  if$
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "Volume" volume tie.or.space.connect
      series empty$
        'skip$
        { " of " * series emphasize * }
      if$
      "Volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
    { series field.or.null }
    { output.state mid.sentence =
        { "number" }
        { "Number" }
      if$
      number tie.or.space.connect
      series empty$
        { "there's a number but no series in " cite$ * warning$ }
        { " in " * series * }
      if$
    }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { edition "l" change.case$ " edition" * }
        { edition "t" change.case$ " edition" * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
    { #1 'multiresult := }
    { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
  { "" }
  { pages multi.page.check
%    { "pages" pages n.dashify tie.or.space.connect }
%    { "page" pages tie.or.space.connect }
	{ " (pp.\" pages n.dashify tie.or.space.connect }
	{ " (p.\" pages tie.or.space.connect }
% msl 10/94 - added blank before `('s
% msl 9/94 - changed `pp.' to `p.' for single page references
    if$
	")" *
% msl 9/94 - deleted `.' after `)'
  }
  if$
}

% By Young (and Spencer)
FUNCTION {format.vol.num.pages}
{ number empty$
    { volume empty$
       { "" }
       { "{\em " volume * "}" * }
      if$
    }
    { volume empty$
       {"there's a number but no volume in " cite$ * warning$
        "{\em (" number * ")}" * }
       { "{\em " volume * "(" * number * ")}" * }
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
      { pop$ format.pages }
      { ", " * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "chapter" }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
  { "" }
  { editor empty$
    { "In " format.emphasize.booktitle * }
    { "In " format.editors * ", " * format.emphasize.booktitle * }
    if$
  }
  if$
}

FUNCTION {format.in.ed.booktitle.incoll}
{ booktitle empty$
  { "" }
  { editor empty$
    { "In " format.emphasize.booktitle * }
    { "In " format.editors.fml * ", " * format.emphasize.booktitle * }
    if$
  }
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ "In"
  "\cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
    'skip$
    { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
        { " et~al." * }
        { " and " * editor #2 "{vv~}{ll}" format.name$ * }
      if$
    }
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "Volume" volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
    { series empty$
        { "need editor, key, or series for " cite$ * " to crossref " *
          crossref * warning$
          "" *
        }
        { "{\em " * series * "\/}" * }
      if$
    }
    { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ "In"
  " \cite{" * crossref * "}" *
}

FUNCTION {article}
{ output.bibitem
  format.authors 
  "author" output.check
  author format.key output          % added
  output.year.check                 % added
  new.block
  format.title 
  "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      number empty$ volume empty$ and
	{ format.pages * }
	{ format.vol.num.pages output }
      if$
% msl 10/94 - if pages with no volume, get rid of extra `,' before `(pp. 1-5)'
    }
    { format.article.crossref output.nonnull
      format.pages *
% msl 10/94 - use `*' instead of `output' so `(pp. 1-5)' isn't preceded by
% a comma
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors.dot 
	  "author and editor" output.check }
    { format.authors 
	  output.nonnull
      crossref missing$
    	{ "author and editor" editor either.or.check }
    	'skip$
      if$
    }
  if$
  output.year.check       % added
  new.block
  format.btitle 
  "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      address output
      publisher "publisher" output.check.colon
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
%  format.edition output
  new.block
  note output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  author format.key output          % added
  output.year.check                 % added
  new.block
  format.title 
  "title" output.check
  new.block
  howpublished output
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors.dot 
      "author and editor" output.check 
    }
    { format.authors output.nonnull
      crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
      if$
    }
  if$
  output.year.check                 % added
  new.block
  format.btitle 
  "title" output.check
  crossref missing$
    { format.bvolume output
      chapter empty$
	{format.pages *}
	{format.chapter.pages output}
      if$
      chapter empty$ pages empty$ and
	{"empty chapter and pages in " cite$ * warning$}
	'skip$
      if$
% msl 10/94 - changed above so don't get extra `,' before `(pp. 1-5)'
      new.block
      format.number.series output
      new.sentence
      address output
      publisher 
      "publisher" output.check.colon
    }
    { chapter empty$
	{format.pages *}
	{format.chapter.pages output}
      if$
      chapter empty$ pages empty$ and
	{"empty chapter and pages in " cite$ * warning$}
	'skip$
      if$
% msl 10/94 - changed above so don't get extra `,' before `(pp. 1-5)'
      new.block
      format.book.crossref output.nonnull
    }
  if$
%  format.edition output
  new.block
  note output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors
  "author" output.check
  author format.key output       % added
  output.year.check              % added
  new.block
  format.title 
  "title" output.check
  new.block
  crossref missing$
  { format.in.ed.booktitle.incoll 
    "booktitle" output.check.colon
    format.bvolume output
    format.number.series output
%   format.chapter.pages special.output
    chapter empty$
	{format.pages *}
	{format.chapter.pages special.output}
    if$
    chapter empty$ pages empty$ and
	{"empty chapter and pages in " cite$ * warning$}
	'skip$
    if$
% msl 10/94 - changed above so don't get extra `,' before `(pp. 1-5)'
    new.sentence
    address output
    publisher "publisher" output.check.colon
  }
  { format.incoll.inproc.crossref 
	output.nonnull
    chapter empty$
	{format.pages *}
	{format.chapter.pages output}
    if$
    chapter empty$ pages empty$ and
	{"empty chapter and pages in " cite$ * warning$}
	'skip$
    if$
% msl 10/94 - changed above so don't get extra `,' before `(pp. 1-5)'
  }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors 
  "author" output.check
  author format.key output            % added
  output.year.check                   % added
  new.block
  format.title 
  "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle 
	  "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages *
% msl 10/94 - use `*' instead of `output' so `(pp. 1-5)' isn't preceded by
% a comma
%     address output
%     new.sentence
%     organization output
%     publisher output
      new.sentence
      address output
      publisher "publisher" output.check.colon
% msl 10/94 - changed to APA standard
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages *
% msl 10/94 - use `*' instead of `output' so `(pp. 1-5)' isn't preceded by
% a comma
    }
  if$
  new.block
  note output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  format.authors output
  author format.key output          % added
  output.year.check                 % added
  new.block
  format.btitle 
  "title" output.check
  organization address new.block.checkb
% Reversed the order of "address" and "organization", added the ":".
  address output
  organization "organization" output.check.colon
%  address output
%  ":" output
%  organization output
%  format.edition output
  new.block
  note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors 
  "author" output.check
  author format.key output          % added
  output.year.check                 % added
  new.block
  format.title 
  "title" output.check
  new.block
  "Master's thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  author format.key output            % added
  output.year.check                   % added
  title howpublished new.block.checkb
  format.title output
  new.block
  howpublished output
  new.block
  note output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors 
  "author" output.check
  author format.key output            % added
  output.year.check                   % added
  new.block
  format.btitle 
  "title" output.check
  new.block
  "PhD thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors.dot output.nonnull }
  if$
  author format.key output             % added
  output.year.check                    % added
  new.block
  format.btitle 
  "title" output.check
  format.bvolume output
  format.number.series output
  organization output
  new.sentence
  address output
  publisher "publisher" output.check.colon
  new.block
  note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors 
  "author" output.check
  author format.key output             % added
  output.year.check                    % added
  new.block
  format.title 
  "title" output.check
  new.block
  format.tr.number output.nonnull
  institution 
  "institution" output.check
  address output
  new.block
  note output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors 
  "author" output.check
  author format.key output              % added
  output.year.check                      % added
  new.block
  format.title 
  "title" output.check
  new.block
  note "note" output.check
  fin.entry
}

FUNCTION {default.type} { misc }

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

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {ai} {"Artificial Intelligence"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

INTEGERS { fullptr numfull fullsleft }

STRINGS { u1 u2 }

FUNCTION {my.full.label}
{ 
% Initialize 'u1','u2','s'.
  "" 'u1 :=                                       
  "" 'u2 :=                     
  's :=                      

% Initialize 'fullptr','numfull','fullsleft'.
  #1 'fullptr :=                         
  s num.names$ 'numfull :=   
  numfull 'fullsleft :=          

% enter the while loop which generates the first-citation information.
% while we have names left, 
%     format the next name
%   if this is the next-to-last name, tack the ampersand on the end
%   else if this isn't the last name, tack the comma on the end.
%   concatenate the next name onto the first-citation string.
%   update the counters.

  { fullsleft #0 > }
  { s fullptr "{vv~}{ll}" format.name$ 'u1 :=  
     fullsleft #2 =
       { u1 " \& " * 'u1 := }
      { fullsleft #2 > 
           { u1 ", " * 'u1 := }
           'skip$
         if$
        }
    if$
     u2 u1 * 'u2 :=
     fullptr #1 + 'fullptr :=         
     fullsleft #1 - 'fullsleft :=  
  }
  while$

% push 'u2' onto the stack -- our first-citation information.
  u2        
}

FUNCTION {format.lab.names}
{ 's :=                             
  s #1 "{vv~}{ll}" format.name$        
  s num.names$ duplicate$
  #2 >                                
     { pop$ " et~al." * }            
     { #2 <
          'skip$
          { s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
                { "et~al. " * }
%               { " and " * s #2 "{vv~}{ll}" format.name$ * }
                { " \& " * s #2 "{vv~}{ll}" format.name$ * }
             if$
            }
       if$
     }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
          { cite$ #1 #3 substring$ }
         'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.label}
{ editor empty$
    { key empty$
          { cite$ #1 #3 substring$ }
          'key
        if$
     }
     { editor format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
          { key empty$
               { cite$ #1 #3 substring$ }
             'key
           if$
         }
          { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {grab.author.editor.key}
{ author empty$
    { editor empty$
          { key empty$
               { cite$ #1 #3 substring$ }
             'key
           if$
         }
          { editor }
      if$
    }
    { author }
  if$
}

FUNCTION {calc.label}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
          'editor.key.label
          'author.key.label
        if$
    }
  if$
  duplicate$    

% msl 10/94 - sort on author or editor if there is no author
  grab.author.editor.key my.full.label  % generate the first-citation info

  'label1 :=
  "}{" *
%  year field.or.null purify$ #-1 #4 substring$ *  
% msl 12/94 - allow year specifications for translations like `1906/1966'
  year field.or.null *  
  'label2 :=
% msl 12/94 - allow year specifications for translations like `1906/1966'
%  year field.or.null purify$ #-1 #4 substring$ *
  year field.or.null *
  sortify 'sort.label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
          { "   " * }
         'skip$
      if$
      s nameptr "{ll{ }}{vv{ } }{  f{ }}{  jj{ }}" format.name$ 't :=
% use next line instead of previous to let
% `von Helmholtz' be alphabetized under V rather than H
%     s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
          { "et al" * }
          { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
          { "to sort, need author or key in " cite$ * warning$
              ""
         }
         { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.sort}
{ editor empty$
    { key empty$
         { "to sort, need editor or key in " cite$ * warning$
           ""
         }
         { key sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
         { key empty$
             { "to sort, need author, editor, or key in " cite$ * warning$
               ""
             }
             { key sortify }
           if$
         }
         { editor sort.format.names }
      if$
   }
   { author sort.format.names }
  if$
}

FUNCTION {presort}
{ calc.label
% Michael Landy - reworked this to use the short citation format
% (e.g. `Name et al.') as the major sort key, and then the same order as
% used in the final output within that
  sort.label sortify
  "    "
  *
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
          'editor.sort
          'author.sort
      if$
    }
  if$
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT   % by sort.label, full author list, title --- for final label calculation

STRINGS { last.label next.extra }

INTEGERS { last.extra.num }

FUNCTION {initialize.extra.label.stuff}
{ #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'last.extra.num :=
}

% Michael Landy - modified to use sort.label for the matching
FUNCTION {forward.pass}
{ last.label sort.label =
     { last.extra.num #1 + 'last.extra.num :=
       last.extra.num int.to.chr$ 'extra.label :=
     }
     { "a" chr.to.int$ 'last.extra.num :=
       "" 'extra.label :=
       sort.label 'last.label :=
    }
  if$
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
     'skip$
  if$
  label2 "}{" * extra.label * 'label2 :=   
  extra.label 'next.extra :=
}

EXECUTE {initialize.extra.label.stuff}

ITERATE {forward.pass}

REVERSE {reverse.pass}

% Michael Landy - changed to use long authors as major sort key instead of label
FUNCTION {bib.sort.order}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
          'editor.sort
          'author.sort
      if$
    }
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {bib.sort.order}

SORT             % by long authors, year, title --- giving final bib. order.

FUNCTION {begin.bib}

{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{}" write$ newline$
}


EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}

