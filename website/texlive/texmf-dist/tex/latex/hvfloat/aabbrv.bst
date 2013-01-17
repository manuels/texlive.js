% BibTeX bibliography style `AABBRV'
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
volume
year
}
{}
{ label }
INTEGERS { output.state before.all mid.sentence after.sentence after.block 
continue.sentence }
FUNCTION {init.state.consts}
{ #0 'before.all :=
#1 'mid.sentence :=
#2 'after.sentence :=
#3 'after.block :=
#4 'continue.sentence :=
}
STRINGS { s t }
FUNCTION {output.nonnull}
{ 's :=
output.state continue.sentence =
{ " " * write$ }
{ output.state mid.sentence =
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
}
if$
continue.sentence 'output.state :=
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
FUNCTION {output.bibitem}
{ newline$
"\bibitem{" write$
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
FUNCTION {new.clause}
{ output.state after.sentence =
'skip$
{ output.state after.block =
'skip$
{ output.state before.all =
'skip$
{ mid.sentence 'output.state := }
if$
}
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
FUNCTION {new.clause.checka}
{ empty$
'skip$
'new.clause
if$
}
FUNCTION {new.clause.checkb}
{ empty$
swap$ empty$
and
'skip$
'new.clause
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
{ "\abtype{2}{" swap$ * "}" * }	
if$
}
FUNCTION {capitalize}
{ duplicate$ empty$
{ pop$ "" }
{ "\abtype{0}{" swap$ * "}" * }	
if$
}
FUNCTION {boldface}
{ duplicate$ empty$
{ pop$ "" }
{ "\abtype{3}{" swap$ * "}" * }	
if$
}
FUNCTION {quote}
{ duplicate$ empty$
{ pop$ "" }
{ "\abtype{1}{" swap$ * "}" * }	
if$
}
FUNCTION {parentheses}
{ duplicate$ empty$
{ pop$ "" }
{ "\abtype{5}{" swap$ * "}" * }	
if$
}
INTEGERS { nameptr namesleft numnames }
FUNCTION {format.names}
{ 's :=
#1 'nameptr :=
s num.names$ 'numnames :=
numnames 'namesleft :=
{ namesleft #0 > }
{ s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ 't :=
nameptr #1 >
{ namesleft #1 >
{ ", " * t * }
{ numnames #2 >
{ "\abphrase{1}" * }	
'skip$
if$
t "others" =
{ "\abphrase{2}" * }		
{ "\abphrase{0}" * t * }	
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
{ author format.names capitalize }
if$
}
FUNCTION {format.editors}
{ editor empty$
{ "" }
{ editor format.names capitalize
editor num.names$ #1 >
{ "\abphrase{3}" * }	
{ "\abphrase{4}" * }	
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
month parentheses
}
if$
}
{ month empty$
{ year parentheses }
{ month " " * year * parentheses }
if$
}
if$
}
FUNCTION {format.btitle}
{ title quote
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
{ "\abphrase{8}" volume tie.or.space.connect	
series empty$
'skip$
{ "\abphrase{5}" * series quote * }	
if$
"volume and number" number either.or.check
}
if$
}
FUNCTION {format.number.series}
{ volume empty$
{ number empty$
{ series field.or.null }
{ output.state mid.sentence = output.state continue.sentence = or
{ "\abphrase{10}" }	
{ "\abphrase{11}" }	
if$
number tie.or.space.connect
series empty$
{ "there's a number but no series in " cite$ * warning$ }
{ "\abphrase{6}" * series * }	
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
{ output.state mid.sentence = output.state continue.sentence = or
{ edition "l" change.case$ "\abphrase{12}" * }	
{ edition "t" change.case$ "\abphrase{12}" * }	
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
{ "\abphrase{13}" pages n.dashify tie.or.space.connect }	
{ "\abphrase{14}" pages tie.or.space.connect }			
if$
}
if$
}
FUNCTION {format.vol.num.pages}
{ volume field.or.null boldface
number empty$
'skip$
{ "\abtype{4}{" number * "}" * *	
volume empty$
{ "there's a number but no volume in " cite$ * warning$ }
'skip$
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
{ "\abphrase{15}" }	
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
{ "\abphrase{7}" booktitle quote * }				
{ "\abphrase{7}" format.editors * ", " * booktitle quote * }	
if$
}
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
{ "\abphrase{16}" }	
'type
if$
number empty$
{ "t" change.case$ }
{ number tie.or.space.connect }
if$
}
FUNCTION {format.article.crossref}
{ key empty$
{ journal empty$
{ "need key or journal for " cite$ * " to crossref " * crossref *
warning$
""
}
{ "\abphrase{7}" journal emphasize * }	
if$
}
{ "\abphrase{7}" key * }	
if$
" \cite{" * crossref * "}" *
}
FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
editor num.names$ duplicate$
#2 >
{ pop$ "\abphrase{2}" * }	
{ #2 <
'skip$
{ editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
{ "\abphrase{2}" * }					 
{ "\abphrase{0}" * editor #2 "{vv~}{ll}" format.name$ * } 
if$
}
if$
}
if$
}
FUNCTION {format.book.crossref}
{ volume empty$
{ "empty volume in " cite$ * "'s crossref of " * crossref * warning$
"\abphrase{7}"				
}
{ "\abphrase{9}" volume tie.or.space.connect	
"\abphrase{5}" *				
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
{ series quote * }
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
{ editor empty$
editor field.or.null author field.or.null =
or
{ key empty$
{ booktitle empty$
{ "need editor, key, or booktitle for " cite$ * " to crossref " *
crossref * warning$
""
}
{ "\abphrase{7}" booktitle quote * }	
if$
}
{ "\abphrase{7}" key * }	
if$
}
{ "\abphrase{7}" format.crossref.editor * }	
if$
" \cite{" * crossref * "}" *
}
FUNCTION {article}
{ output.bibitem
format.authors "author" output.check
new.block
format.title "title" output.check
new.block
crossref missing$
{ journal emphasize "journal" output.check
format.vol.num.pages output
format.date "year" output.check
}
{ format.article.crossref output.nonnull
new.clause
format.pages output
}
if$
new.block
note output
fin.entry
}
FUNCTION {book}
{ output.bibitem
author empty$
{ format.editors "author and editor" output.check }
{ format.authors output.nonnull
crossref missing$
{ "author and editor" editor either.or.check }
'skip$
if$
}
if$
new.block
format.btitle "title" output.check
crossref missing$
{ new.clause
format.bvolume output
new.block
format.number.series output
new.sentence
publisher "publisher" output.check
address new.clause.checka
address output
}
{ new.block
format.book.crossref output.nonnull
}
if$
edition new.clause.checka
format.edition output
format.date "year" output.check
new.block
note output
fin.entry
}
FUNCTION {booklet}
{ output.bibitem
format.authors output
new.block
format.title "title" output.check
howpublished address new.block.checkb
howpublished output
address new.clause.checka
address output
format.date output
new.block
note output
fin.entry
}
FUNCTION {inbook}
{ output.bibitem
author empty$
{ format.editors "author and editor" output.check }
{ format.authors output.nonnull
crossref missing$
{ "author and editor" editor either.or.check }
'skip$
if$
}
if$
new.block
format.btitle "title" output.check
new.clause
crossref missing$
{ format.bvolume output
new.clause
format.chapter.pages "chapter and pages" output.check
new.block
format.number.series output
new.sentence
publisher "publisher" output.check
address new.clause.checka
address output
}
{ format.chapter.pages "chapter and pages" output.check
new.block
format.book.crossref output.nonnull
}
if$
edition new.clause.checka
format.edition output
format.date "year" output.check
new.block
note output
fin.entry
}
FUNCTION {incollection}
{ output.bibitem
format.authors "author" output.check
new.block
format.title "title" output.check
new.block
crossref missing$
{ format.in.ed.booktitle "booktitle" output.check
new.clause
format.bvolume output
new.clause
format.number.series output
new.clause
format.chapter.pages output
new.sentence
publisher "publisher" output.check
address new.clause.checka
address output
edition new.clause.checka
format.edition output
format.date "year" output.check
}
{ format.incoll.inproc.crossref output.nonnull
new.clause
format.chapter.pages output
}
if$
new.block
note output
fin.entry
}
FUNCTION {inproceedings}
{ output.bibitem
format.authors "author" output.check
new.block
format.title "title" output.check
new.block
crossref missing$
{ format.in.ed.booktitle "booktitle" output.check
volume new.clause.checka
format.bvolume output
number series new.clause.checkb
format.number.series output
pages new.clause.checka
format.pages output
address empty$
{ organization publisher new.sentence.checkb
organization output
publisher new.clause.checka
publisher output
format.date "year" output.check
}
{ new.clause
address output.nonnull
format.date "year" output.check
new.sentence
organization output
new.clause
publisher output
}
if$
}
{ format.incoll.inproc.crossref output.nonnull
new.clause
format.pages output
}
if$
new.block
note output
fin.entry
}
FUNCTION {conference} { inproceedings }
FUNCTION {manual}
{ output.bibitem
author empty$
{ organization empty$
'skip$
{ organization output.nonnull
new.clause
address output
}
if$
}
{ format.authors output.nonnull }
if$
new.block
format.btitle "title" output.check
author empty$
{ organization empty$
{ address new.block.checka
address output
}
'skip$
if$
}
{ organization address new.block.checkb
organization output
address new.clause.checka
address output
}
if$
edition new.clause.checka
format.edition output
format.date output
new.block
note output
fin.entry
}
FUNCTION {mastersthesis}
{ output.bibitem
format.authors "author" output.check
new.block
format.title "title" output.check
new.block
"\abphrase{17}" format.thesis.type output.nonnull	
new.clause
school "school" output.check
address new.clause.checka
address output
format.date "year" output.check
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
howpublished output
format.date output
new.block
note output
fin.entry
empty.misc.check
}
FUNCTION {phdthesis}
{ output.bibitem
format.authors "author" output.check
new.block
format.btitle "title" output.check
new.block
"\abphrase{18}" format.thesis.type output.nonnull	
new.clause
school "school" output.check
address new.clause.checka
address output
format.date "year" output.check
new.block
note output
fin.entry
}
FUNCTION {proceedings}
{ output.bibitem
editor empty$
{ organization output }
{ format.editors output.nonnull }
if$
new.block
format.btitle "title" output.check
volume new.clause.checka
format.bvolume output
number series new.clause.checkb
format.number.series output
address empty$
{ editor empty$
{ publisher new.sentence.checka }
{ organization publisher new.sentence.checkb
organization output
publisher new.clause.checka
}
if$
publisher output
format.date "year" output.check
}
{ new.clause
address output.nonnull
format.date "year" output.check
new.sentence
editor empty$
'skip$
{ organization output
new.clause
}
if$
publisher output
}
if$
new.block
note output
fin.entry
}
FUNCTION {techreport}
{ output.bibitem
format.authors "author" output.check
new.block
format.title "title" output.check
new.block
format.tr.number output.nonnull
new.clause
institution "institution" output.check
address new.clause.checka
address output
format.date "year" output.check
new.block
note output
fin.entry
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
MACRO {jan} {"\abmonth{1}"}
MACRO {feb} {"\abmonth{2}"}
MACRO {mar} {"\abmonth{3}"}
MACRO {apr} {"\abmonth{4}"}
MACRO {may} {"\abmonth{5}"}
MACRO {jun} {"\abmonth{6}"}
MACRO {jul} {"\abmonth{7}"}
MACRO {aug} {"\abmonth{8}"}
MACRO {sep} {"\abmonth{9}"}
MACRO {oct} {"\abmonth{10}"}
MACRO {nov} {"\abmonth{11}"}
MACRO {dec} {"\abmonth{12}"}
MACRO {first}   {"\abedition{1}"}
MACRO {second}  {"\abedition{2}"}
MACRO {third}   {"\abedition{3}"}
MACRO {fourth}  {"\abedition{4}"}
MACRO {fifth}   {"\abedition{5}"}
MACRO {sixth}   {"\abedition{6}"}
MACRO {seventh} {"\abedition{7}"}
MACRO {eighth}  {"\abedition{8}"}
MACRO {ninth}   {"\abedition{9}"}
MACRO {tenth}   {"\abedition{10}"}
MACRO {section}   {"\abchapter{0}"}
MACRO {paragraph} {"\abchapter{1}"}
MACRO {appendix}  {"\abchapter{2}"}
MACRO {part}      {"\abchapter{3}"}
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
{ "   " * }
'skip$
if$
s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't :=
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
ITERATE {presort}
SORT
STRINGS { longest.label }
INTEGERS { number.label longest.label.width }
FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
#1 'number.label :=
#0 'longest.label.width :=
}
FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
number.label #1 + 'number.label :=
label width$ longest.label.width >
{ label 'longest.label :=
label width$ 'longest.label.width :=
}
'skip$
if$
}
EXECUTE {initialize.longest.label}
ITERATE {longest.label.pass}
FUNCTION {begin.bib}
{
"\newif\ifabfull\abfullfalse" write$ newline$
preamble$ empty$
'skip$
{ preamble$ write$ newline$ }
if$
"\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.state.consts}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$
"\end{thebibliography}" write$ newline$
}
EXECUTE {end.bib}
