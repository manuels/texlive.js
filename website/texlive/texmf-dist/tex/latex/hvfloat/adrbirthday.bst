%%
%% This is file `adrbirthday.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% adrconv.dtx  (with options: `bst,birthday')
%% Copyright 2006, 2010 Axel Kielhorn
%% 
%% This file will generate fast loadable files from adrconv.dtx when
%% run through LaTeX or TeX.
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%% 
%% This file is part of the adrconv bundle.
%% 
%% The adrconv bundle consists at least of the files adrconv.dtx,
%% adrconv.ins and adrguide.tex.
%% 
%% adrguide.dtx
%% Copyright 2006, 2010 Axel Kielhorn
ENTRY
  { name
   sortas
    title
    organization
    city
    zip
    country
    street
    phone
    mobile
    fax
    url
    email
    note
    key
    birthday
    nbirthday
  }
  {}
  { b.month }
STRINGS { cur.month num.index alpha.index }
FUNCTION {get.names}
{ name empty$
   { organization empty$
      { "{}{}" }
      { organization "{}" * }
     if$
   }
   { "{" name #1 "{ll}" format.name$ "}" * *
     "{" name #1 "{ff}{ vv}" format.name$ "}" * * *
   }
   if$
}
FUNCTION {print.adrchr}
{ b.month cur.month =
  'skip$
  { newline$ "\adrchar{\convdate{" b.month "}}" * * write$ newline$
    b.month 'cur.month :=
  }
  if$
}
FUNCTION{format.phone.and.mobile}
{ phone empty$
    {
      mobile empty$
        { "" }
        { mobile }
      if$
    }{
      mobile empty$
        { phone }
        { phone "\\" mobile * * }
      if$
    }
  if$
}
FUNCTION{address}
{
  nbirthday empty$
  'skip$
  {
    print.adrchr
    "\adrentry" write$
    get.names write$ newline$
    "{"
    street empty$
      { "" * }
      { street " \\ " * *}
    if$
    zip empty$
      { "" * }
      { zip " " * *}
    if$
    city empty$
    { "" * }
    { city * }
    if$
    "}{" *
    format.phone.and.mobile
    "}" * *
    email empty$
      { "{}" * }
      { "{" email "}" * * * }
    if$
     organization empty$
      { "{}" * }
      { "{" organization "}" * * *}
     if$
    note empty$
      { "{}" * }
      { "{" note "}" * * * }
    if$
    "{"  *
    birthday empty$
      { "" }
      { birthday }
    if$
    "}{" * *
    key empty$
      { "" }
      { key }
    if$
    "}" * * write$ newline$
  }
  if$
}
FUNCTION{presort}
{ nbirthday empty$
  { "" }
  { nbirthday }
  if$
  duplicate$
  'sort.key$ :=
  #1 #2 substring$
  'b.month :=
}
READ
ITERATE {presort}
SORT
FUNCTION {begin.bib}
{
  "\def\convdate#1{\ifcase#1 \or 1 \or 2 \or 3 \or 4 \or 5 "
  "\or 6 \or 7 \or 8 \or 9 \or 10 \or 11 \or 12 \fi}" * 'num.index :=
  "\def\convdate#1{\ifcase#1 \or Januar \or Februar \or "
  " M{^^b a}rz \or April \or Mai \or Juni \or Juli "
  "\or August \or September \or Oktober \or November \or Dezember \fi}"
  * * 'alpha.index :=
  alpha.index write$
  newline$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "00" 'cur.month :=
}
EXECUTE {begin.bib}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$ }
EXECUTE {end.bib}
