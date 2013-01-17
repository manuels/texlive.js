%%
%% This is file `opcit.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% opcit.dtx  (with options: `bst')
%% Part of the `opcit' project: bibliographical references as footnotes.
%% 
%% Copyright 2006 Federico Garcia
%% 
ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    hereafter
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    urldate
    volume
    year
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence
      after.block quoted.state period.state }

STRINGS { s t last.authors quotes }

FUNCTION {init.state.consts}
{ #0 'period.state :=
  #0 'before.all :=
  "" 'last.authors :=
  "" 'quotes :=
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
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

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION{format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ff }{vv~}{ll}{,~jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { numnames #2 >
                { "," * }
                'skip$
            if$
            t "others" =
                { " et~al." * }
                { " and " * t * }
            if$
            }
          if$
        }
        't
     if$
     nameptr #1 + 'nameptr :=
     namesleft #1 - 'namesleft :=
   }
   while$
}

FUNCTION {format.swap.names}
{ 's :=
  s num.names$ 'numnames :=
  "\SwapNames{" s #1 "{ff}" format.name$
  duplicate$ #-1 #1 substring$
  "." =
    { #1 'period.state := }
    'skip$
  if$
  * "}{" *
  s #1 "{vv~}{ll}" format.name$ * "}" *
  s #1 "{, jj}" format.name$ *
  numnames #3 >
    { " et~al." * #1 'period.state := }
    { numnames #1 >
        { #2 'nameptr :=
            numnames #1 - 'namesleft :=
                { namesleft #0 > }
                { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=
                    namesleft #1 >
                        { ", " * t * }
                        { " and " * t * }
                    if$
                    nameptr #1 + 'nameptr :=
                    namesleft #1 - 'namesleft :=
                }
                while$
        }
        'skip$
      if$
    }
  if$
}

FUNCTION {format.authors}
{   author empty$
    { ""
      "" 'last.authors :=
    }
    { author format.names
      last.authors =
        { "\sameauthors" }
        { before.all output.state =
            { author format.swap.names }
            { author format.names }
          if$ }
      if$
      author format.names 'last.authors :=
    }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { before.all output.state =
        { editor format.swap.names }
        { editor format.names }
      if$
    }
  if$
}

FUNCTION {format.editors.ed}
{ editor empty$
    { "" }
    { before.all output.state =
        { editor format.swap.names }
        { editor format.names }
      if$
      editor num.names$ #1 >
        { " (eds.)" * }
        { " (ed.)" * }
      if$
      #0 'period.state :=
    }
  if$
}

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

FUNCTION {format.date}
{ year empty$
    { month empty$
        { "" }
        { "there's a month but no year in " cite$ * warning$
          "\toomit[month]{" month * " }" *
        }
      if$
    }
    { month empty$
        'year
        { "\toomit[month]{" month * " }" * year * }
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

FUNCTION{either.warning}
{   empty$
        'pop$
        { "can't use both " swap$ * " fields in " * cite$  * warning$ }
    if$
}
FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "\bibcase volume" volume tie.or.space.connect
      series empty$
        'skip$
        { " of " * series emphasize * }
      if$
      "volume and number" number either.warning
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series empty$
            { "" }
            { ", series " * series * "" }
          if$
        }
        { "\bibcase number"
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

INTEGERS { multiresult}

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
        { "\toomit[pages]{\bibcase " swap$ * pages n.dashify tie.or.space.connect "}" * }
        { "\toomit[pages]{\bibcase " swap$ * pages tie.or.space.connect "}" * }
      if$
    }
  if$
}

FUNCTION {format.vol.num.date.pages}
{ volume empty$
    'skip$
    { volume }
  if$
  number empty$
    'skip$
    { "/" number *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        { * }
      if$
    }
  if$
  " (" * format.date * ")" *
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ "" format.pages * }
        { ": " format.pages * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    { pages empty$
        { "" }
        { ": " format.pages }
      if$
    }
    { "\newblock\bibpunctuation "
      type empty$
        { "\bibcase chapter" * }
        { type "l" change.case$ * }
      if$
      chapter tie.or.space.connect
      pages empty$
    'skip$
    { ", pages " * format.pages * }
      if$
    }
  if$
}

FUNCTION{get.lastnames}
{ 's :=
  s num.names$ 'numnames :=
  s #1 "{vv~}{ll}" format.name$
  numnames #3 >
    { " et~al." * }
    { numnames #1 >
        { #2 'nameptr :=
            numnames #1 - 'namesleft :=
                { namesleft #0 > }
                { s nameptr "{vv~}{ll}" format.name$ 't :=
                    namesleft #1 >
                        { ", " * t * }
                        { " and " * t * }
                    if$
                    nameptr #1 + 'nameptr :=
                    namesleft #1 - 'namesleft :=
                }
                while$
        }
        'skip$
      if$
    }
  if$
}

FUNCTION {make.address.publisher.year}
{   ""
    address empty$
        'skip$
        { address * }
    if$
    publisher empty$
        'skip$
        { address empty$
            { publisher * }
            { ": " * publisher * }
        if$
        }
    if$
    format.date duplicate$ "" =
        'pop$
        { swap$ duplicate$ "" =
            { * }
            { swap$ ", " swap$ *  * }
        if$}
    if$
    duplicate$ "" =
        'skip$
        { "\bibparenthesis{" swap$ * "}" * }
    if$
}

FUNCTION {make.url}
{   "\url{" url * "}" *
    urldate empty$
        { "there is url but no urldate in " cite$ * warning$ }
        { " (accessed " * urldate * ")" * }
    if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ "}" * write$
  ""
  newline$
  "\biblastnames{" write$
  author empty$
    { editor empty$
        { organization empty$
            { "no last names in " cite$ * warning$ }
            { organization }
            if$
        }
        { editor get.lastnames
          editor num.names$ #1 >
            { " (eds.)" * }
            { " (ed.)" * }
          if$
        }
      if$
    }
    { author get.lastnames }
    if$
  "}" * write$
  before.all 'output.state :=
}

FUNCTION{output.start}
{   hereafter empty$
        'skip$
        { "\bibhereafter{{\noexpand\em " write$ hereafter "}}" * write$ }
        if$
    newline$
    "\opcitstart " write$
}

FUNCTION{output.as.block}
{   duplicate$ "" =
        'pop$
        { period.state #1 =
            { "\GobbleOrNot" #0 'period.state := }
            { "" }
          if$
          "\bibpunctuation" * quotes * write$ newline$ "\newblock " swap$ * write$
          #1 'output.state :=
        }
    if$
    "" 'quotes :=
}

FUNCTION{output.omitted}
{  't :=
   duplicate$ "" =
      { pop$ }
      { "\toomit[" t * "]{\bibpunctuation\bibcase " * swap$ * "}" * write$ }
   if$
}

FUNCTION {fin.entry}
{  write$
   note empty$ {""} {note} if$ "note" output.omitted
   "\opcitend" write$
   newline$
}

FUNCTION{empty.warning}
{   't :=
    duplicate$ empty$
        { pop$ "empty " t * " in " * cite$ * warning$ ""}
        'skip$
    if$
}

FUNCTION{empty.chapter.and.pages.warning}
{  't :=
   chapter empty$
      { pages empty$
         { pop$ "empty " t * " in " * cite$ * warning$ "" }
         'skip$
        if$
      }
      'skip$
   if$

}

FUNCTION{book}
{   output.bibitem
    output.start
    author empty$
        { format.editors.ed "author and editor" empty.warning write$ }
        { format.authors "author and editor" editor either.warning write$ }
    if$
    title emphasize "title" empty.warning output.as.block
    edition empty$
        'skip$
        { "\bibcase " edition * " edition" * output.as.block }
    if$
    howpublished missing$
        'skip$
        { "\bibcase " howpublished * output.as.block }
    if$
    format.bvolume "volume" output.omitted
    format.number.series "number" output.omitted
    make.address.publisher.year write$
    url empty$
        'skip$
        { make.url output.as.block }
    if$
    fin.entry
}

FUNCTION{article}
{   output.bibitem
    output.start
    format.authors "author" empty.warning write$
    "``" title * "title" empty.warning output.as.block "''" 'quotes :=
    howpublished empty$
        'skip$
        { "\bibpunctuation'' \newblock\toomit[howpublished]{\bibcase
            " howpublished  * write$
          "}" 'quotes :=
        }
    if$
    journal emphasize "journal" empty.warning
    " " * format.vol.num.date.pages "year" empty.warning * output.as.block
    url empty$
        'skip$
        { make.url output.as.block }
    if$
    fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  output.start
  format.authors "author" empty.warning write$
  "``" title * "title" empty.warning output.as.block "''" 'quotes :=
  "\bibcase in " output.as.block
  crossref empty$
    'skip$
    { "\bibincite{" crossref * "}" * write$ }
  if$
  "{" write$
  editor empty$
    'skip$
    { format.editors.ed ", " * write$ }
  if$
  booktitle emphasize "booktitle" empty.warning write$
  edition empty$
    'skip$
    { "\bibcase " edition * " edition" * output.as.block }
  if$
  make.address.publisher.year write$
  url empty$
      'skip$
      { make.url output.as.block }
  if$
  "}" write$
  format.chapter.pages write$
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  output.start
  author empty$
      { format.editors.ed "author and editor" empty.warning write$ }
      { format.authors "author and editor" editor either.warning write$ }
  if$
  "``" title * "title" empty.warning output.as.block "''" 'quotes :=
  chapter empty$
    'skip$
    { type empty$
      { "\bibcase chapter "  chapter *  }
      { "\bibcase " type * " " * chapter * }
      if$
    }
  if$
  pages empty$
      'skip$
      { chapter empty$
        { "\bibcase pages" pages n.dashify tie.or.space.connect }
        { "\toomit[pages]{ (pages" * pages n.dashify tie.or.space.connect ")}" * }
        if$
      }
  if$
  "chapter and pages" empty.warning
  " of " *
  crossref empty$
    { booktitle emphasize * "booktitle" empty.warning
      edition empty$
         'skip$
         { ", " * edition "l" change.case$ * " edition" * }
      if$
      howpublished missing$
        'skip$
        { ", " * howpublished * }
      if$
      output.as.block
      make.address.publisher.year write$
    }
    { "\bibincitestar{" * crossref * "}{" * booktitle emphasize * "}" * output.as.block }
  if$
  fin.entry
}

FUNCTION{phdthesis}
{ output.bibitem
  output.start
  format.authors "author" empty.warning write$
  title emphasize "title" empty.warning
  "\bibparenthesis{Ph.\,D.\ diss\GobbleOrNot.}" * output.as.block
  address empty$
    { "" }
    { address ": " * }
  if$
  school "school" empty.warning * output.as.block
  month empty$
    { "" }
    { month " " * }
  if$
  year "year" empty.warning * output.as.block
  fin.entry
}

FUNCTION{mastersthesis}
{ output.bibitem
  output.start
  format.authors "author" empty.warning write$
  title emphasize "title" empty.warning
  "\bibparenthesis{M.\,A.\ thesis}" * output.as.block
  address empty$
    { "" }
    { address ": " * }
  if$
  school "school" empty.warning * output.as.block
  month empty$
    { "" }
    { month " " * }
  if$
  year "year" empty.warning * output.as.block
  fin.entry
}

FUNCTION{proceedings}
{   output.bibitem
    output.start
    editor empty$
        { organization "editor and organization" empty.warning write$ }
        { format.editors.ed "editor" empty.warning write$ }
    if$
    title emphasize "title" empty.warning output.as.block
    format.bvolume "volume" output.omitted
    format.number.series "number" output.omitted
    make.address.publisher.year write$
    fin.entry
}

FUNCTION {booklet}
{ book }

FUNCTION {inproceedings}
{ output.bibitem
  output.start
  format.authors "author" empty.warning write$
  "``" title * "title" empty.warning output.as.block "''" 'quotes :=
  "\bibcase in " output.as.block
  crossref empty$
    'skip$
    { "\bibincite{" crossref * "}" * write$ }
  if$
  "{" booktitle emphasize * "booktitle" empty.warning write$
  editor empty$
    { organization "editor and organization" empty.warning output.as.block }
    { ", edited by " format.editors * write$ }
  if$
  make.address.publisher.year write$
  "}" write$
  format.chapter.pages write$
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  output.start
  format.authors "author" empty.warning write$
  title output.as.block
  howpublished missing$
    'skip$
    { howpublished output.as.block }
  if$
  format.date output.as.block
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

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { " " * }
        'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
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

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
    { key empty$
        { "to sort, need author, organization, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
    { key empty$
        { "to sort, need editor, organization, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
    'editor.organization.sort
    { type$ "manual" =
        'author.organization.sort
        'author.sort
      if$
    }
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
FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\newBibCommand{\bibparenthesis[1]}{ (#1)}{. \newblock #1}" write$ newline$
  "\newBibCommand{\bibincite[2]}{\recover@last\@nameuse{@#1}}{#2}" write$ newline$
  "\newBibCommand{\bibincitestar[2]}{\recover@last " write$ newline$
  "     \@nameuse{#1@star}}{#2}" write$ newline$
  "\newBibCommand{\SwapNames[2]}{#1 #2}{#2, #1}" write$ newline$
  "\newBibCommand{\GobbleOrNot}{\relax}{\newblock\@gobble}" write$ newline$
  "\begin{thebibliography}{}"   write$ newline$
}
ITERATE {presort}

SORT

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
