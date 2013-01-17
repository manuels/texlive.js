%% address-ldif.bst
%% Copyright 2003 Christophe Geuzaine <geuz@geuz.org>
%
% $Id: address-ldif.bst,v 1.7 2003/09/16 07:18:07 geuzaine Exp $
%
% This program can be redistributed and/or modified under the terms
% of the LaTeX Project Public License distributed from CTAN
% archives in directory macros/latex/base/lppl.txt; either
% version 1 of the License, or (at your option) any later version.
%
% BibTeX bibliography style `address-ldif.bst'
% 'directory' database: all fields
% 
% This is definitively a hack... To get a working ldif file if the bib
% file contains special characters (ISO Latin 1, etc.) you must
% convert the output bbl file to UTF8. You can do it e.g. with the
% following C code (found on the web, don't know who wrote it):
%
%  /* Read Latin-1 (ISO-8859-1) characters from stdin, convert them
%     to UTF-8, and write the converted characters to stdout.
%     UTF-8 is defined by RFC 2044.
%  */
%  #include <errno.h>
%  #include <stdio.h>
%  
%  int
%  main (int argc, char** argv)
%  {
%      register int c;
%      while ((c = getchar()) != EOF) {
%          if ((c & 0x80) == 0) {
%              putchar (c);
%          } else {
%              putchar (0xC0 | (0x03 & (c >> 6)));
%              putchar (0x80 | (0x3F & c));
%          }
%      }
%      if ( ! feof (stdin)) {
%          errno = ferror (stdin);
%          perror (argv[0]);
%      }
%      return 0;
%  }
%

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
      s nameptr "{ff{ } }{vv{ } }{ll{ }}{, jj{ }}"  format.name$ 't :=
      nameptr #1 >
	{ namesleft #1 >
	    { ", " * t * }
	    { " and " * t * }
	  if$
	}
	't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.first.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { 
      s nameptr "{ff{ }}"  format.name$ 't :=
      nameptr #1 >
	{ namesleft #1 >
	    { ", " * t * }
	    { " and " * t * }
	  if$
	}
	't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.last.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { 
      s nameptr "{vv{ } }{ll{ }}{, jj{ }}"  format.name$ 't :=
      nameptr #1 >
	{ namesleft #1 >
	    { ", " * t * }
	    { " and " * t * }
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
    { "cn: " name format.names * }
  if$
}

FUNCTION {format.first.name}
{ name empty$
    { "" }
    { "givenName: " name format.first.names * }
  if$
}

FUNCTION {format.last.name}
{ name empty$
    { "" }
    { "sn: " name format.last.names * }
  if$
}

FUNCTION {format.simple.name}
{ name empty$
    { "" }
    { "cn: " name * }
  if$
}

FUNCTION {format.simple.last.name}
{ name empty$
    { "" }
    { "sn: " name * }
  if$
}

FUNCTION {format.nickname}
{ nickname empty$
    { "" }
    { "xmozillanickname: " nickname * }
  if$
}

FUNCTION {format.birthday}
{ birthday empty$
    {  
       birthyear empty$
        { "" }
        { "custom1: birthyear=" birthyear * }
      if$
    }
    { "custom1: birthday=" birthday format.dates * }
  if$
}

FUNCTION {format.address}
{ address empty$
    { 
      % ugly, but we need a new line after each field
      street  empty$ { skip$ } { "postalAddress: " street * output } if$
      city    empty$ { skip$ } { "l: " city *  output } if$
      state   empty$ { skip$ } { "st: " state *  output } if$
      zip     empty$ { skip$ } { "postalCode: " zip *  output } if$
      country empty$ { skip$ } { "c: " country *  output } if$
      ""
    }
    { "postalAddress: " address * }
  if$
}

FUNCTION {format.account}
{ account empty$
    { "" }
    { "custom2: account=" account * }
  if$
}

FUNCTION {format.phone}
{ phone empty$
    { "" }
    { "telephoneNumber: " phone * }
  if$
}

FUNCTION {format.cellular}
{ cellular empty$
    { "" }
    { "mobile: " cellular * }
  if$
}

FUNCTION {format.fax}
{ fax empty$
    { "" }
    { "facsimileTelephoneNumber: " fax * }
  if$
}

FUNCTION {format.email}
{ email empty$
    { "" }
    { "mail: " email * }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { "workurl: " url * }
  if$
}

FUNCTION {format.p.address}
{ p.address empty$
    { 
      % ugly, but we need a new line after each field
      p.street  empty$ { skip$ } { "homePostalAddress: " p.street * output } if$
      p.city    empty$ { skip$ } { "mozillaHomeLocalityName: " p.city * output } if$
      p.state   empty$ { skip$ } { "mozillaHomeState: " p.state * output } if$
      p.zip     empty$ { skip$ } { "mozillaHomePostalCode: " p.zip * output } if$
      p.country empty$ { skip$ } { "mozillaHomeCountryName: " p.country * output } if$
      ""
    }
    { "homePostalAddress: " p.address * }
  if$
}

FUNCTION {format.p.phone}
{ p.phone empty$
    { "" }
    { "homePhone: " p.phone * }
  if$
}

FUNCTION {format.p.cellular}
{ p.cellular empty$
    { "" }
    { "mobile: " p.cellular * }
  if$
}

FUNCTION {format.p.fax}
{ p.fax empty$
    { "" }
    { "facsimileTelephoneNumber: " p.fax * }
  if$
}

FUNCTION {format.p.email}
{ p.email empty$
    { "" }
    { "mail: " p.email * }
  if$
}

FUNCTION {format.p.url}
{ p.url empty$
    { "" }
    { "homeurl: " p.url * }
  if$
}

FUNCTION {format.p.account}
{ p.account empty$
    { "" }
    { "custom2: account=" p.account * }
  if$
}

FUNCTION {format.r.address}
{ r.address empty$
    { 
      % ugly, but we need a new line after each field
      r.street  empty$ { skip$ } { "homePostalAddress: " r.street * output } if$
      r.city    empty$ { skip$ } { "mozillaHomeLocalityName: " r.city * output } if$
      r.state   empty$ { skip$ } { "mozillaHomeState: " r.state * output } if$
      r.zip     empty$ { skip$ } { "mozillaHomePostalCode: " r.zip * output } if$
      r.country empty$ { skip$ } { "mozillaHomeCountryName: " r.country * output } if$
      ""
    }
    { "homePostalAddress: " r.address * }
  if$
}

FUNCTION {format.r.phone}
{ r.phone empty$
    { "" }
    { "homePhone: " r.phone * }
  if$
}

FUNCTION {format.r.cellular}
{ r.cellular empty$
    { "" }
    { "mobile: " r.cellular * }
  if$
}

FUNCTION {format.r.fax}
{ r.fax empty$
    { "" }
    { "facsimileTelephoneNumber: " r.fax * }
  if$
}

FUNCTION {format.r.email}
{ r.email empty$
    { "" }
    { "mail: " r.email * }
  if$
}

FUNCTION {format.r.url}
{ r.url empty$
    { "" }
    { "homeurl: " r.url * }
  if$
}

FUNCTION {format.r.account}
{ r.account empty$
    { "" }
    { "custom2: account=" r.account * }
  if$
}

FUNCTION {format.w.title}
{ w.title empty$
    { "" }
    { "title: " w.title * }
  if$
}

FUNCTION {format.w.name}
{ w.name empty$
    { "" }
    { "o: " w.name * }
  if$
}

FUNCTION {format.w.address}
{ w.address empty$
    { 
      % ugly, but we need a new line after each field
      w.street  empty$ { skip$ } { "postalAddress: " w.street * output } if$
      w.city    empty$ { skip$ } { "l: " w.city * output } if$
      w.state   empty$ { skip$ } { "st: " w.state * output } if$
      w.zip     empty$ { skip$ } { "postalCode: " w.zip * output } if$
      w.country empty$ { skip$ } { "c: " w.country * output } if$
      ""
    }
    { "postalAddress: " w.address * }
  if$
}

FUNCTION {format.w.phone}
{ w.phone empty$
    { "" }
    { "telephoneNumber: " w.phone * }
  if$
}

FUNCTION {format.w.cellular}
{ w.cellular empty$
    { "" }
    { "mobile: " w.cellular * }
  if$
}

FUNCTION {format.w.fax}
{ w.fax empty$
    { "" }
    { "facsimileTelephoneNumber: " w.fax * }
  if$
}

FUNCTION {format.w.email}
{ w.email empty$
    { "" }
    { "mail: " w.email * }
  if$
}

FUNCTION {format.w.url}
{ w.url empty$
    { "" }
    { "workurl: " w.url * }
  if$
}

FUNCTION {format.w.account}
{ w.account empty$
    { "" }
    { "custom2: account=" w.account * }
  if$
}

FUNCTION {format.note}
{ note empty$
    { "" }
    { "description: " note * }
  if$
}

% ------------------------------------------------------------ 
%  P E R S O N   E N T R Y  
% ------------------------------------------------------------ 

FUNCTION { person }
{ 
  "objectclass: top" output
  "objectclass: person" output
  "objectclass: organizationalPerson" output
  "objectclass: inetOrgPerson" output
  "objectclass: mozillaAbPersonObsolete" output

  format.first.name output
  format.last.name output
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

  newline$
}

% ------------------------------------------------------------ 
%  C O M P A N Y   E N T R Y  
% ------------------------------------------------------------ 

FUNCTION { company }
{ 
  "objectclass: top" output
  "objectclass: person" output
  "objectclass: organizationalPerson" output
  "objectclass: inetOrgPerson" output
  "objectclass: mozillaAbPersonObsolete" output

  format.simple.last.name output
  format.simple.name output
  format.address output
  format.phone output
  format.cellular output
  format.fax output
  format.email output
  format.url output
  format.account output
  format.note output

  newline$
}

% ------------------------------------------------------------ 
%  P L A C E   E N T R Y  
% ------------------------------------------------------------ 

FUNCTION { place }
{ 
  "objectclass: top" output
  "objectclass: person" output
  "objectclass: organizationalPerson" output
  "objectclass: inetOrgPerson" output
  "objectclass: mozillaAbPersonObsolete" output

  format.simple.last.name output
  format.simple.name output
  format.address output
  format.phone output
  format.cellular output
  format.fax output
  format.note output

  newline$
}

% ------------------------------------------------------------ 
%  M A I N 
% ------------------------------------------------------------ 

READ
EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}
