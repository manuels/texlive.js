%%
%% This is file `adrconv.bst',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% adrconv.dtx  (with options: `bst,conv')
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
  { adr.char }
INTEGERS { cur.adr.char }
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
{ adr.char chr.to.int$ cur.adr.char >
  { newline$ "\adrchar{" adr.char "}" * * write$ newline$
    adr.char chr.to.int$ 'cur.adr.char :=
  }
  'skip$
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
    key empty$
      { "" }
      { key }
    if$
    "}" * * write$ newline$
}
FUNCTION{presort}
{
  sortas empty$
  { name empty$
    { organization empty$
      { key empty$
        { "No name, organization, or key to sort " cite$ * warning$
          "???"
        }
        { key }
        if$
      }
      { organization }
      if$
    }
    { name #1 "{ll},{f }{v }{, j}" format.name$ }
    if$
  }
  { sortas }
  if$
  duplicate$
  'sort.key$ :=
  #1 #1 substring$
  'adr.char :=
}
READ
ITERATE {presort}
SORT
FUNCTION {begin.bib}
{
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  #0 'cur.adr.char :=
}
EXECUTE {begin.bib}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$ }
EXECUTE {end.bib}
