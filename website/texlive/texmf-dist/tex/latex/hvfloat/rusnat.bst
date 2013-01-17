%%
%% This is file `rusnat.bst', part of `shipunov' bundle.
%% Author: Alexey B. Shipunov (plantago@herba.msu.ru)
%% Version 1.1., 2008/02/11
%% 

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    howpublished
    journal
    key
    month
    note
    number
    part
    pages
    publisher
    responsible
    series
    title
    type
    url
    volume
    year
  }
  {}
  { label extra.label sort.label short.list }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { add.period$ " " * write$ }
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

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\EM " swap$ * "}" * }
  if$
}

FUNCTION {paren}
{ duplicate$ empty$
    { pop$ "" }
    { "(" swap$ * ")" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ll~}{ff}{ vv}{ jj}" format.name$ 't :=
       nameptr #1 >
	{ namesleft #1 >
	    { ", " * t * }
	    { t "others" =
		{ ", et~al." * }
                { ", " * t * }
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

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names emphasize }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { responsible empty$
      { title }
      { title " \allowbreak\newblock/ " * responsible * }
    if$
    }
  if$
}

FUNCTION {format.title.non.r}
{ title empty$
    { "" }
    { title }
  if$
}

FUNCTION {format.btitle}
{ booktitle empty$
    { "" }
    { responsible empty$
      { booktitle }
      { booktitle " \allowbreak\newblock/ " * responsible * }
    if$
    }
  if$
}

FUNCTION {format.full.names}
{'s :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{f.~}{vv~}{ll}{ jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
	    { t "others" =
		{ ", et~al." * }
                { ", " * t * }
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

FUNCTION {author.key.full}
{ author empty$
    { key empty$
         { cite$ #1 #3 substring$ }
          'key
      if$
    }
    { author format.full.names }
  if$
}

FUNCTION {make.full.names}
{ type$ "article" =
    'author.key.full
    'author.key.full
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  ")" make.full.names duplicate$ short.list =
     { pop$ }
     { * }
   if$
  "]{" * write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
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
{ year duplicate$ empty$
    { "empty year in " cite$ * "; set to ????" * warning$
       pop$ "????" }
    'skip$
  if$
  month empty$
    'skip$
    { month
      " " * swap$ *
    }
  if$
  extra.label *
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {format.bvolume.part.num}
{ volume empty$
    { "" }
    { add.period$ " " volume * }
  if$
  part empty$
  'skip$
  { volume empty$
     { "there's a part but no volume in " cite$ * warning$ }
     { ", " * part * }
     if$
     }
  if$
  number empty$
  'skip$
  { volume empty$
     { "there's a number but no volume in " cite$ * warning$ }
     { ", " * number * }
     if$
     }
  if$
}

FUNCTION {format.series}
{ series empty$
    { "" }
    { series paren }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { edition }
  if$
}

FUNCTION {format.address.how.date}
{ address empty$
    { format.date }
    { howpublished empty$
        { address ", " * format.date * }
        { address ": " * howpublished * ", " * format.date * }
      if$
    }
  if$
}

FUNCTION {format.address.pub.date}
{ address empty$
    { format.date }
    { publisher empty$
        { address ", " * format.date * }
        { address ": " * publisher * ", " * format.date * }
      if$
    }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { "{URL: \catcode`\/13\let/\slash\tt " url * "}" * }
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
        { "" pages n.dashify tie.or.space.connect }
        { "" pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ number empty$
    { volume empty$
        { "need volume or number in " cite$ * warning$
          ""
        }
        { volume }
      if$
    }
    { volume empty$
        { number }
        { volume ", " * number * }
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { add.period$ " " * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "" }
        { type }
      if$
      chapter tie.or.space.connect
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.title.sl.journal}
{ format.title
  journal empty$
    { " \allowbreak\newblock// " }
    { " \allowbreak\newblock// " * journal * }
  if$
}

FUNCTION {format.title.sl.btitle}
{ format.title.non.r
  booktitle empty$
    { " \allowbreak\newblock// " }
    { " \allowbreak\newblock// " * format.btitle * }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title.sl.journal "title and journal" output.check
  series output
  format.date "year" output.check
  format.vol.num.pages "pages" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  format.bvolume.part.num output
  new.sentence
  format.address.pub.date output
  format.edition output
  format.pages "pages" output.check
  new.block
  format.series output
  new.block
  note output
  fin.entry
}

FUNCTION {booklet} { book }

FUNCTION {inbook}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title.sl.btitle "title and booktitle" output.check
  format.bvolume.part.num output
  new.sentence
  format.address.pub.date output
  format.edition output
  format.chapter.pages "pages" output.check
  new.block
  format.series output
  new.block
  note output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title.sl.btitle "title and booktitle" output.check
  format.bvolume.part.num output
  new.sentence
  format.address.pub.date output
  format.edition output
  format.chapter.pages "pages" output.check
  new.block
  format.series output
  new.block
  note output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title.sl.btitle "title and booktitle" output.check
  format.bvolume.part.num output
  format.address.pub.date output
  format.pages "pages" output.check
  new.block
  format.series output
  new.block
  note output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual} { book }

FUNCTION {mastersthesis} { book }

FUNCTION {phdthesis} { book }

FUNCTION {proceedings} { book }

FUNCTION {techreport} { book }

FUNCTION {www}
{ output.bibitem
  format.authors output
  format.title output
  format.url "url" output.check
  format.date output
  new.block
  note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  format.address.how.date output
  format.pages output
  new.block
  note output
  fin.entry
  empty.misc.check
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  note "note" output.check
  format.date output
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"I"}

MACRO {feb} {"II"}

MACRO {mar} {"III"}

MACRO {apr} {"IV"}

MACRO {may} {"V"}

MACRO {jun} {"VI"}

MACRO {jul} {"VII"}

MACRO {aug} {"VIII"}

MACRO {sep} {"IX"}

MACRO {oct} {"X"}

MACRO {nov} {"XI"}

MACRO {dec} {"XII"}

READ

FUNCTION {sortify}
{ purify$
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

FUNCTION {format.lab.names}
{ 's :=
  s #1 "{ll}{ vv}" format.name$
  s num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
        'skip$
        { s #2 "{ll~}{ff}{ vv}{ jj}" format.name$ "others" =
            { " et~al." * }
            { ", " * s #2 "{ll}{ vv}" format.name$ * }
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
        { key #3 text.prefix$ }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {calc.short.authors}
{ type$ "article" =
    'author.key.label
    'author.key.label
  if$
  'short.list :=
}

FUNCTION {calc.label}
{ calc.short.authors
  short.list
  "("
  *
  year duplicate$ empty$
     { pop$ "????" }
     'skip$
  if$
  *
  'label :=
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
      s nameptr "{ll{ } }{ff{ }}{ vv{ }}{ jj{ }}" format.name$ 't :=
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

FUNCTION {presort}
{ calc.label
  label sortify
  "    "
  *
  type$ "article" =
    'author.sort
    'author.sort
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
  'sort.label :=
  sort.label *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label last.label next.extra }

INTEGERS { longest.label.width last.extra.num number.label }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
  #0 'number.label :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  number.label #1 + 'number.label :=
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ empty$
    'skip$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
  label extra.label * 'label :=
}

EXECUTE {initialize.longest.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {bib.sort.order}
{ sort.label  'sort.key$ :=
}

ITERATE {bib.sort.order}

SORT

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{" number.label int.to.str$ * "}" *
  write$ newline$
  "\providecommand{\natexlab}[1]{#1}"
  write$ newline$
  "\providecommand{\EM}{\em}"
  write$ newline$
  "\providecommand{\RNtxt}{\relax}"
  write$ newline$
  "\RNtxt{}"
  write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
%% End of file `RUSNAT.BST'
