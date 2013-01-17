%%
%% This is file `databib.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% datatool.dtx  (with options: `databib.bst')
%% 
%%  datatool.dtx
%%  Copyright 2009 Nicola Talbot
%% 
%%  This work may be distributed and/or modified under the
%%  conditions of the LaTeX Project Public License, either version 1.3
%%  of this license of (at your option) any later version.
%%  The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%%  and version 1.3 or later is part of all distributions of LaTeX
%%  version 2005/12/01 or later.
%% 
%%  This work has the LPPL maintenance status `maintained'.
%% 
%%  The Current Maintainer of this work is Nicola Talbot.
%% 
%%  This work consists of the files datatool.dtx and datatool.ins and the derived files datatool.sty, datapie.sty, dataplot.sty, databar.sty, databib.sty, databib.bst, person.sty.
%% 
%% load student information from file "students.csv"
%% Iterate through the student database:
%% Define "anon":
%% Do the letter:
%% Undefine "anon":

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
    isbn
    doi
    pubmed
    url
    abstract
    file
  }
  {}
  { label }

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
          output.state before.all =
            {
       "%" * write$
               newline$
            }
    { newline$
              %add.period$ " " * write$
            }
  if$
  %    if$
  %    mid.sentence 'output.state :=
  %  }
  %if$
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
    {
      output.nonnull
    }
  if$
}

FUNCTION {output.bibitem}
{ "\DTLnewbibrow" write$
  newline$
  "\DTLnewbibitem {CiteKey}{" write$
  cite$ write$
  "}%" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ "%" *
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
    { "{\em " swap$ * "}" * }
  if$
}

FUNCTION {group}
{ duplicate$ empty$
    { pop$ "" }
    { "{" swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{
  's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    {
      %s nameptr "{vv,}{ll,}{jj,}{ff}" format.name$ 't :=
      "{" *
      s nameptr "{vv}" format.name$ 't :=
       t * "}" *
      "{" *
      s nameptr "{ll}" format.name$ 't :=
       t * "}{" *
      s nameptr "{jj}" format.name$ 't :=
       t * "}" *
      "{" *
      s nameptr "{ff}" format.name$ 't :=
       t * "}" *
      s nameptr "" format.name$ 't :=
      namesleft #1 >
        { "," * }
        { }
      if$
      nameptr #1 >
{
          t *
}
't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  "}" *
}

FUNCTION {format.authors}
{
  author empty$
    { "" }
    { author
      "\DTLnewbibitem {Author}{" write$
      format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor
      "\DTLnewbibitem {Editor}{" write$
      format.names
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    {
      "\DTLnewbibitem {Title}"
      title "t" change.case$ group *
    }
  if$
}

FUNCTION {format.howpublished}
{ howpublished empty$
    { "" }
    {
      howpublished
      "\DTLnewbibitem {HowPublished}" swap$ group *
    }
  if$
}

FUNCTION {format.organization}
{ organization empty$
    { "" }
    {
      organization
      "\DTLnewbibitem {Organization}" swap$ group *
    }
  if$
}

FUNCTION {format.institution}
{ institution empty$
    { "" }
    {
      institution
      "\DTLnewbibitem {Institution}" swap$ group *
    }
  if$
}

FUNCTION {format.key}
{ key empty$
    { "" }
    {
      key
      "\DTLnewbibitem {Key}" swap$ group *
    }
  if$
}

FUNCTION {format.note}
{ note empty$
    { "" }
    {
      note
      "\DTLnewbibitem {Note}" swap$ group *
    }
  if$
}

FUNCTION {format.isbn}
{ isbn empty$
    { "" }
    {
      isbn
      "\DTLnewbibitem {ISBN}" swap$ group *
    }
  if$
}

FUNCTION {format.doi}
{ doi empty$
    { "" }
    {
      doi
      "\DTLnewbibitem {DOI}" swap$ group *
    }
  if$
}

FUNCTION {format.pubmed}
{ pubmed empty$
    { "" }
    {
      pubmed
      "\DTLnewbibitem {PubMed}" swap$ group *
    }
  if$
}

FUNCTION {format.abstract}
{ abstract empty$
    { "" }
    {
      abstract
      "\DTLnewbibitem {Abstract}" swap$ group *
    }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    {
      url
      "\DTLnewbibitem {Url}" swap$ group *
    }
  if$
}

FUNCTION {format.file}
{ file empty$
    { "" }
    {
      file
      "\DTLnewbibitem {File}" swap$ group *
    }
  if$
}

FUNCTION {format.address}
{ address empty$
    { "" }
    {
      address
      "\DTLnewbibitem {Address}" swap$ group *
    }
  if$
}

FUNCTION {format.school}
{ school empty$
    { "" }
    {
      school
      "\DTLnewbibitem {School}" swap$ group *
    }
  if$
}

FUNCTION {format.publisher}
{ publisher empty$
    { "" }
    {
      publisher
      "\DTLnewbibitem {Publisher}" swap$ group *
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
         "\DTLnewbibitem {Month}" *
  month group
}
      if$
    }
    { month empty$
{  }
{ "\DTLnewbibitem {Month}{" * month * "}" * }
      if$
      "\DTLnewbibitem {Year}{" * year * "}"
    }
  if$
}

FUNCTION {format.btitle}
{ title
  "\DTLnewbibitem {Title}{" swap$ *
  "}" *
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
    {
      "\DTLnewbibitem {Volume}{" volume * "}" *
      series empty$
'skip$
{
          "\DTLnewbibitem {Series}" * series group *
        }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
{
          %series field.or.null group
           series empty$
             { "" }
             { "\DTLnewbibitem {Series}" * series group }
           if$
        }
{
          "\DTLnewbibitem {Number}" number group *
  series empty$
    { "there's a number but no series in " cite$ * warning$ }
    { "\DTLnewbibitem {Series}{" * series * "}" * }
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
    {
      "\DTLnewbibitem {Edition}"
      edition "l" change.case$ group *
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
{ "\DTLnewbibitem {Pages}" pages n.dashify
          group * }
{ "\DTLnewbibitem {Pages}" pages
           group *}
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{
  volume empty$
  { "" }
  {
    "\DTLnewbibitem {Volume}{" volume * "}" *
  }
  if$
  number empty$
    'skip$
    { "\DTLnewbibitem {Number}{" number * "}\relax " * *
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
{ "\DTLnewbibitem {Pages}" * pages n.dashify group * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
{ "\DTLnewbibitem {Type}{chapter}" }
{ "\DTLnewbibitem {Type}" type "l" change.case$ group *}
      if$
      "\DTLnewbibitem {Chapter}{" * chapter * "}" *
      pages empty$
'skip$
{ format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    {
      "\DTLnewbibitem {BookTitle}" booktitle group *
      editor empty$
      {}
      {
         "\DTLnewbibitem {Editor}{" *
         editor format.names *
      }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
      "\DTLnewbibitem {Type}" swap$ group *
    }
  if$
}

FUNCTION {format.tr.number}
{
  type empty$
    { "\techreportname " }
     'type
  if$
  number empty$
    { "t" change.case$ "\DTLnewbibitem {Type}" swap$ group *}
    { "\DTLnewbibitem {Type}" swap$ group *
      "\DTLnewbibitem {Number}" *
      number group * }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
{ "need key or journal for " cite$ * " to crossref " * crossref *
  warning$
  ""
}
{
          "\DTLnewbibitem {Journal}" journal group *
        }
      if$
    }
    {
      ""
    }
  if$
  "\DTLnewbibitem {CrossRef}{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ format.editors
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
    }
    {
      "\DTLnewbibitem {Volume}"
      volume group *
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
    {
              "\DTLnewbibitem {Series}{" * series *
              "}" *
            }
  if$
}
{ ""
        }
      if$
    }
    {
      format.crossref.editor *
    }
  if$
  "\DTLnewbibitem {CrossRef}{" * crossref * "}" *
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
    { "\DTLnewbibitem {BookTitle}{" booktitle * "}" * }
  if$
}
{ "" }
      if$
    }
    {
       "\DTLnewbibitem {Editor}{" *
       editor format.names
    }
  if$
  "\DTLnewbibitem {CrossRef}{" * crossref * "}" *
}

FUNCTION {article}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{article}%" write$
  newline$
  format.authors "author"
  output.check
  format.title "title" output.check
  new.block
  crossref missing$
    {
      "\DTLnewbibitem {Journal}" *
      journal group "journal" output.check
      format.vol.num.pages output
      format.date "year" output.check
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{book}%" write$
  newline$
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
{ "author and editor" editor either.or.check
        }
'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      %new.sentence
      format.publisher "publisher" output.check
      format.address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{booklet}%" write$
  newline$
  format.authors output
  new.block
  format.title "title" output.check
  howpublished address new.block.checkb
  format.howpublished output
  format.address output
  format.date output
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{inbook}%" write$
  newline$
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
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      format.publisher "publisher" output.check
      format.address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{incollection}%" write$
  newline$
  format.authors "author" output.check
  format.title "title" output.check
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      format.publisher "publisher" output.check
      format.address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{inproceedings}%" write$
  newline$
  format.authors "author" output.check
  format.title "title" output.check
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      address empty$
{ %organization publisher new.sentence.checkb
  format.organization write$
  format.publisher output
}
{ format.address write$
  new.sentence
  format.organization output
  format.publisher output
}
      if$
      format.date "year" output.check
    }
    {
      format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{manual}%" write$
  newline$
  author empty$
    { organization empty$
'skip$
{ format.organization output
  format.address output
}
      if$
    }
    { format.authors output }
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
    { %organization address new.block.checkb
      format.organization output
      format.address output
    }
  if$
  format.edition output
  format.date output
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{mastersthesis}%" write$
  newline$
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  "\DTLnewbibitem {Type}{\mscthesisname }"
  format.thesis.type output.nonnull
  format.school "school" output.check
  format.address output
  format.date "year" output.check
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{misc}%" write$
  newline$
  format.authors output
  title howpublished new.block.checkb
  format.title output
  %howpublished new.block.checka
  format.howpublished output
  format.date output
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
  empty.misc.check
}

FUNCTION {phdthesis}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{phdthesis}%" write$
  newline$
  format.authors "author" output.check
  new.block
  format.btitle "title" output.check
  new.block
  "\DTLnewbibitem {Type}{\phdthesisname }"
  format.thesis.type output.nonnull
  format.school "school" output.check
  format.address output
  format.date "year" output.check
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{proceedings}%" write$
  newline$
  editor empty$
    { format.organization output }
    { format.editors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
{ publisher new.sentence.checka }
{ organization publisher new.sentence.checkb
  format.organization output
}
      if$
      format.publisher output
      format.date "year" output.check
    }
    { format.address output
      format.date "year" output.check
      new.sentence
      editor empty$
'skip$
{ format.organization output }
      if$
      format.publisher output
    }
  if$
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{techreport}%" write$
  newline$
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  format.institution "institution" output.check
  format.address output
  format.date "year" output.check
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  "\DTLnewbibitem {EntryType}{unpublished}%" write$
  newline$
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  format.key output
  format.note output
  format.isbn output
  format.doi output
  format.pubmed output
  format.url output
  format.abstract output
  format.file output
  format.date output
  fin.entry
}

FUNCTION {default.type} { misc }

MACRO {jan} {"\DTLmonthname{01}"}

MACRO {feb} {"\DTLmonthname{02}"}

MACRO {mar} {"\DTLmonthname{03}"}

MACRO {apr} {"\DTLmonthname{04}"}

MACRO {may} {"\DTLmonthname{05}"}

MACRO {jun} {"\DTLmonthname{06}"}

MACRO {jul} {"\DTLmonthname{07}"}

MACRO {aug} {"\DTLmonthname{08}"}

MACRO {sep} {"\DTLmonthname{09}"}

MACRO {oct} {"\DTLmonthname{10}"}

MACRO {nov} {"\DTLmonthname{11}"}

MACRO {dec} {"\DTLmonthname{12}"}

MACRO {acmcs} {"\DTLacmcs "}

MACRO {acta} {"\DTLacta "}

MACRO {cacm} {"\DTLcacm "}

MACRO {ibmjrd} {"\DTLibmjrd "}

MACRO {ibmsj} {"\DTLibmsj "}

MACRO {ieeese} {"\DTLieeese "}

MACRO {ieeetc} {"\DTLieeetc "}

MACRO {ieeetcad} {"\DTLieeetcad "}

MACRO {ipl} {"\DTLipl "}

MACRO {jacm} {"\DTLjacm "}

MACRO {jcss} {"\DTLjcss "}

MACRO {scp} {"\DTLscp "}

MACRO {sicomp} {"\DTLsicomp "}

MACRO {tocs} {"\DTLtocs "}

MACRO {tods} {"\DTLtods "}

MACRO {tog} {"\DTLtog "}

MACRO {toms} {"\DTLtoms "}

MACRO {toois} {"\DTLtoois "}

MACRO {toplas} {"\DTLtoplas "}

MACRO {tcs} {"\DTLtcs "}

READ

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
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{
}

EXECUTE {end.bib}
