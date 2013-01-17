%% address-vcard.bst
%% Copyright 2003-2004 Christophe Geuzaine <geuz@geuz.org>
%
% $Id: address-vcard.bst,v 1.9 2004/01/10 06:45:16 geuzaine Exp $
%
% This program can be redistributed and/or modified under the terms
% of the LaTeX Project Public License distributed from CTAN
% archives in directory macros/latex/base/lppl.txt; either
% version 1 of the License, or (at your option) any later version.
%
% BibTeX bibliography style `address-vcard.bst'
% 'directory' database: all fields
% 
% This is definitively a hack... It assumes the character encoding to
% be ISO Latin 1. Multi-name entries are not treated entirely
% correctly due to limitations in the vCard spec.
%
% Also, bibtex splits lines automatically in the output file, which
% can cause alignment problems (and apparently encoding problems with
% Apple's address book application). You can e.g. fix bibtex's output 
% with awk:
%
% awk "!/^  /{ buf[i++] = $0; }
%      /^  /{ buf[i-1] = buf[i-1] substr($0,2,length($0)-1) }
%      END{ for(j=0;j<i;j++) print buf[j] }" file.bbl

INTEGERS { nameptr namesleft numnames numaux len }
STRINGS { s t u v }

% ------------------------------------------------------------ 
%  E N T R I E S
% ------------------------------------------------------------ 

ENTRY
  { name
    nickname
    birthday
    birthyear
    address % if empty, use street, city, ...
      street
      city
      state
      zip
      country
    phone
    cellular
    fax
    email
    url
    account
    p.address % if empty, use p.street, p.city, ...
      p.street
      p.city
      p.state
      p.zip
      p.country
    p.phone
    p.cellular
    p.fax
    p.email
    p.url
    p.account
    r.address % if empty, use r.street, r.city, ...
      r.street
      r.city
      r.state
      r.zip
      r.country
    r.phone
    r.cellular
    r.fax
    r.email
    r.url
    r.account
    w.title
    w.name
    w.address % if empty, use w.street, w.city, ...
      w.street
      w.city
      w.state
      w.zip
      w.country
    w.phone
    w.cellular
    w.fax
    w.email
    w.url
    w.account
    note
  }
  {}
  { 
  }

% ------------------------------------------------------------ 
%  G E N E R A L
% ------------------------------------------------------------ 

FUNCTION {output}
{  's :=
   s empty$
    {}
    { s write$
      newline$
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

% ------------------------------------------------------------ 
%  P R E -   A N D   P O S T -   H E A D E R S 
% ------------------------------------------------------------ 

FUNCTION {begin.bib}
{ 
}

FUNCTION {end.bib}
{ 
}

% ------------------------------------------------------------ 
%  G E N E R A L   F O R M A T T I N G   F U N C T I O N S 
% ------------------------------------------------------------ 

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { 
      % "Clinton; Bill (with Hillary Rodham, Chelsee and Christophe Geuzaine)"
      nameptr #1 >
        { s nameptr "{ff }{vv }{ll}{\, jj}"  format.name$ 't := }
        { s nameptr "{vv{ } }{ll{ }}{;ff{ }}{\, jj{ }}" format.name$ 't := }
      if$
      nameptr #1 >
	{ 
          nameptr #2 =
	    { " (with " * t * }
	    {
              namesleft #1 >
	        { ", " * t * }
                { " and " * t * }
              if$
	     }
	  if$
          namesleft #1 =
            { ")" * }
            { }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.dates}
{
 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=

    birthyear empty$
      { #0 'numaux := }
      { birthyear num.names$ 'numaux := 
        numnames numaux =
         { }
         { " birthdays and birthyears don't match in entry '" cite$ * "'" * warning$ }
       if$
      }
    if$
    
    { namesleft #0 > }
    { s nameptr "{ff}" format.name$ 't :=
      s nameptr "{ll}" format.name$ 'u :=

      numaux #0 > not
        { }
        { birthyear nameptr "{ll}" format.name$ 'v := 
          v * "-" * }
      if$

      nameptr #1 >
        { ";" * u * "-" * t * }
	{ u "-" * t * }
      if$

      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
      numaux #1 - 'numaux :=
    }
  while$
}

% ------------------------------------------------------------ 
%  V C A R D   F I E L D   F O R M A T S
% ------------------------------------------------------------ 

FUNCTION {format.name}
{ name empty$
    { "" }
    { "N;charset=iso-8859-1:" name format.names * }
  if$
}

FUNCTION {format.simple.name}
{ name empty$
    { "" }
    { "N;charset=iso-8859-1:" name ";" * * }
  if$
}

FUNCTION {format.nickname}
{ nickname empty$
    { "" }
    { "NICKNAME;charset=iso-8859-1:" nickname * }
  if$
}

FUNCTION {format.birthday}
{ birthday empty$
    {  
       birthyear empty$
        { "" }
        { "BDAY;value=date:" birthyear * }
      if$
    }
    { "BDAY;value=date:" birthday format.dates * }
  if$
}

FUNCTION {format.address}
{ address empty$
    { 
      street empty$ city empty$ state empty$ zip empty$ country empty$
      and and and and
        { "" }
        { "ADR;type=WORK;charset=iso-8859-1:;;"
           street  empty$ { "" } { street } if$ * ";" *
           city    empty$ { "" } { city } if$ * ";" *
           state   empty$ { "" } { state } if$ * ";" *
           zip     empty$ { "" } { zip } if$ * ";" *
           country empty$ { "" } { country } if$ *
        }
      if$
    }
    { "ADR;type=WORK;charset=iso-8859-1:;;" address * ";;;;" * }
  if$
}

FUNCTION {format.account}
{ account empty$
    { "" }
    { "ACCOUNT:" account * }
  if$
}

FUNCTION {format.phone}
{ phone empty$
    { "" }
    { "TEL;type=WORK:" phone * }
  if$
}

FUNCTION {format.cellular}
{ cellular empty$
    { "" }
    { "TEL;type=CELL:" cellular * }
  if$
}

FUNCTION {format.fax}
{ fax empty$
    { "" }
    { "TEL;type=FAX:" fax * }
  if$
}

FUNCTION {format.email}
{ email empty$
    { "" }
    { "EMAIL:" email * }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { "URL:" url * }
  if$
}

FUNCTION {format.p.address}
{ p.address empty$
    { 
      p.street empty$ p.city empty$ p.state empty$ p.zip empty$ p.country empty$
      and and and and
        { "" }
        { "ADR;type=HOME;charset=iso-8859-1:;;"
           p.street  empty$ { "" } { p.street } if$ * ";" *
           p.city    empty$ { "" } { p.city } if$ * ";" *
           p.state   empty$ { "" } { p.state } if$ * ";" *
           p.zip     empty$ { "" } { p.zip } if$ * ";" *
           p.country empty$ { "" } { p.country } if$ *
        }
      if$
    }
    { "ADR;type=HOME;charset=iso-8859-1:;;" p.address * ";;;;" * }
  if$
}

FUNCTION {format.p.phone}
{ p.phone empty$
    { "" }
    { "TEL;type=HOME:" p.phone * }
  if$
}

FUNCTION {format.p.cellular}
{ p.cellular empty$
    { "" }
    { "TEL;type=CELL:" p.cellular * }
  if$
}

FUNCTION {format.p.fax}
{ p.fax empty$
    { "" }
    { "TEL;type=FAX;type=HOME:" p.fax * }
  if$
}

FUNCTION {format.p.email}
{ p.email empty$
    { "" }
    { "EMAIL;type=HOME:" p.email * }
  if$
}

FUNCTION {format.p.url}
{ p.url empty$
    { "" }
    { "URL;type=HOME:" p.url * }
  if$
}

FUNCTION {format.p.account}
{ p.account empty$
    { "" }
    { "ACCOUNT;type=HOME:" p.account * }
  if$
}

FUNCTION {format.r.address}
{ r.address empty$
    { 
      r.street empty$ r.city empty$ r.state empty$ r.zip empty$ r.country empty$
      and and and and
        { "" }
        { "ADR;type=HOME;charset=iso-8859-1:;;"
           r.street  empty$ { "" } { r.street } if$ * ";" *
           r.city    empty$ { "" } { r.city } if$ * ";" *
           r.state   empty$ { "" } { r.state } if$ * ";" *
           r.zip     empty$ { "" } { r.zip } if$ * ";" *
           r.country empty$ { "" } { r.country } if$ *
        }
      if$
    }
    { "ADR;type=HOME;charset=iso-8859-1:;;" r.address * ";;;;" * }
  if$
}

FUNCTION {format.r.phone}
{ r.phone empty$
    { "" }
    { "TEL;type=HOME:" r.phone * }
  if$
}

FUNCTION {format.r.cellular}
{ r.cellular empty$
    { "" }
    { "TEL;type=CELL:" r.cellular * }
  if$
}

FUNCTION {format.r.fax}
{ r.fax empty$
    { "" }
    { "TEL;type=FAX;type=HOME:" r.fax * }
  if$
}

FUNCTION {format.r.email}
{ r.email empty$
    { "" }
    { "EMAIL;type=HOME:" r.email * }
  if$
}

FUNCTION {format.r.url}
{ r.url empty$
    { "" }
    { "URL;type=HOME:" r.url * }
  if$
}

FUNCTION {format.r.account}
{ r.account empty$
    { "" }
    { "ACCOUNT;type=HOME:" r.account * }
  if$
}

FUNCTION {format.w.title}
{ w.title empty$
    { "" }
    { "TITLE;charset=iso-8859-1:" w.title * }
  if$
}

FUNCTION {format.w.name}
{ w.name empty$
    { "" }
    { "ORG;charset=iso-8859-1:" w.name * }
  if$
}

FUNCTION {format.w.address}
{ w.address empty$
    { 
      w.street empty$ w.city empty$ w.state empty$ w.zip empty$ w.country empty$
      and and and and
        { "" }
        { "ADR;type=WORK;charset=iso-8859-1:;;"
           w.street  empty$ { "" } { w.street } if$ * ";" *
           w.city    empty$ { "" } { w.city } if$ * ";" *
           w.state   empty$ { "" } { w.state } if$ * ";" *
           w.zip     empty$ { "" } { w.zip } if$ * ";" *
           w.country empty$ { "" } { w.country } if$ *
        }
      if$
    }
    { "ADR;type=WORK;charset=iso-8859-1:;;" w.address * ";;;;" * }
  if$
}

FUNCTION {format.w.phone}
{ w.phone empty$
    { "" }
    { "TEL;type=WORK:" w.phone * }
  if$
}

FUNCTION {format.w.cellular}
{ w.cellular empty$
    { "" }
    { "TEL;type=CELL:" w.cellular * }
  if$
}

FUNCTION {format.w.fax}
{ w.fax empty$
    { "" }
    { "TEL;type=FAX;type=WORK:" w.fax * }
  if$
}

FUNCTION {format.w.email}
{ w.email empty$
    { "" }
    { "EMAIL;type=WORK:" w.email * }
  if$
}

FUNCTION {format.w.url}
{ w.url empty$
    { "" }
    { "URL;type=WORK:" w.url * }
  if$
}

FUNCTION {format.w.account}
{ w.account empty$
    { "" }
    { "ACCOUNT;type=WORK:" w.account * }
  if$
}

FUNCTION {format.note}
{ note empty$
    { "" }
    { "NOTE;charset=iso-8859-1:" note * }
  if$
}

% ------------------------------------------------------------ 
%  P E R S O N   E N T R Y  
% ------------------------------------------------------------ 

FUNCTION { person }
{ 
  "BEGIN:VCARD" output
  "VERSION:3.0" output

  format.name output
  format.nickname output
  format.birthday output

  format.p.address output
  format.p.phone output
  format.p.cellular output
  format.p.fax output
  format.p.email output
  format.p.url output
  format.p.account output

  format.r.address output
  format.r.phone output
  format.r.cellular output
  format.r.fax output
  format.r.email output
  format.r.url output
  format.r.account output

  format.w.title output
  format.w.name output
  format.w.address output
  format.w.phone output
  format.w.cellular output
  format.w.fax output
  format.w.email output
  format.w.url output
  format.w.account output

  format.note output

  "END:VCARD" output
}

% ------------------------------------------------------------ 
%  C O M P A N Y   E N T R Y  
% ------------------------------------------------------------ 

FUNCTION { company }
{ 
  "BEGIN:VCARD" output
  "VERSION:3.0" output

  format.simple.name output
  format.address output
  format.phone output
  format.cellular output
  format.fax output
  format.email output
  format.url output
  format.account output
  format.note output

  "END:VCARD" output
}

% ------------------------------------------------------------ 
%  P L A C E   E N T R Y  
% ------------------------------------------------------------ 

FUNCTION { place }
{ 
  "BEGIN:VCARD" output
  "VERSION:3.0" output

  format.simple.name output
  format.address output
  format.phone output
  format.cellular output
  format.fax output
  format.note output

  "END:VCARD" output
}

% ------------------------------------------------------------ 
%  M A I N 
% ------------------------------------------------------------ 

READ
EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}
