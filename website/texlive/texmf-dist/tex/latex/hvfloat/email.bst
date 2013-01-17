%% email.bst
%% Copyright 1998-2003 Christophe Geuzaine <geuz@geuz.org>
%
% $Id: email.bst,v 1.6 2003/09/14 09:47:49 geuzaine Exp $
%
% This program can be redistributed and/or modified under the terms
% of the LaTeX Project Public License distributed from CTAN
% archives in directory macros/latex/base/lppl.txt; either
% version 1 of the License, or (at your option) any later version.
%
% BibTeX bibliography style `email.bst'
% 'directory' database: only email field
%
% The parts you may want to customize are labeled with "CUSTOM"
%

INTEGERS { nameptr namesleft numnames numaux len }
STRINGS { s t u v }

% ------------------------------------------------------------ 
%  E N T R I E S
% ------------------------------------------------------------ 

ENTRY
  { name
    email
    p.email
    r.email
    w.email
  }
  {}
  {}

% ------------------------------------------------------------ 
%  G E N E R A L
% ------------------------------------------------------------ 

FUNCTION {output}
{  's :=
   s empty$
    {}
    { s write$
      newline$
      "\dirblock" write$
      newline$      
    }
   if$  
}

FUNCTION {output.flag}
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

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}


% ------------------------------------------------------------ 
%  S O R T I N G   F U N C T I O N S
% ------------------------------------------------------------ 

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

FUNCTION {sort.names}
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


FUNCTION {sort.raw.names}
{ 't :=
  "A " #2 "L'" #2
  "An " #3 "Au " #3 "Le " #3 "La " #3
  "The " #4 "Les " #4 "Aux " #4
  t 
  chop.word chop.word 
  chop.word chop.word chop.word chop.word 
  chop.word chop.word chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {name.sort}
{ name empty$
    { " Name field missing in entry '" cite$ * "'" * warning$ "" }
    { name sort.names }
  if$
}

FUNCTION {raw.name.sort}
{ name empty$
    { " Name field missing in entry '" cite$ * "'" * warning$ "" }
    { name sort.raw.names }
  if$
}

FUNCTION {presort}
{ type$ "company" =
  type$ "place" =
  or
    { raw.name.sort }
    { name.sort }
  if$
  " "
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

FUNCTION {format.first.letter}
{ type$ "company" =
  type$ "place" =
  or
    { raw.name.sort }
    { name.sort }
  if$
  #1 #1 substring$ 
}


% ------------------------------------------------------------ 
%  P R E -   A N D   P O S T -   H E A D E R S 
% ------------------------------------------------------------ 

FUNCTION {begin.bib}
{ "\begin{thephonebook}" write$ 
  newline$
}

FUNCTION {end.bib}
{ newline$
  "\end{thephonebook}" write$ 
  newline$
}

% ------------------------------------------------------------ 
%  F O R M A T S 
% ------------------------------------------------------------ 

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { 
% CUSTOM uncomment one of the following lines to have the behaviour on the right
      s nameptr "{ff }{vv }{ll}{, jj}"  format.name$ 't := % Christophe de Geuzaine, jr
%     s nameptr "{f. }{vv }{ll}{, jj}"  format.name$ 't := % C. de Geuzaine, jr
%     s nameptr "{vv }{ll}{ f.}{, jj}"  format.name$ 't := % de Geuzaine C., jr
%     s nameptr "{vv }{ll}{, ff}{, jj}" format.name$ 't := % de Geuzaine, Christophe, jr

      nameptr #1 >
	{ namesleft #1 >
	    { ", " * t * }
	    { " {\dirandf} " * t * }
	  if$
	}
	't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.name}
{ name empty$
    { "" }
    { name format.names }
  if$
}

FUNCTION {format.email}
{ email empty$
    { "" }
    { "\diremaa{" email "}" * * }
  if$
}

FUNCTION {format.p.flag}
{ p.email empty$ not
    { "\dirprif " }
    { "" }
  if$
}

FUNCTION {format.p.email}
{ p.email empty$
    { "" }
    { "\dirpemaa{" p.email "}" * * }
  if$
}

FUNCTION {format.r.flag}
{ r.email empty$ not
    { "\dirresf " }
    { "" }
  if$
}

FUNCTION {format.r.email}
{ r.email empty$
    { "" }
    { "\dirremaa{" r.email "}" * * }
  if$
}

FUNCTION {format.w.flag}
{ w.email empty$ not
    { "\dirworf " }
    { "" }
  if$
}

FUNCTION {format.w.email}
{ w.email empty$
    { "" }
    { "\dirwemaa{" w.email "}" * * }
  if$
}

% ------------------------------------------------------------ 
%  P E R S O N   E N T R Y  
% ------------------------------------------------------------ 

FUNCTION { person }
{ 
  p.email empty$ not
  r.email empty$ not
  w.email empty$ not
  or or 
    { newline$

      "\dircheck{" write$
      format.first.letter write$
      "}" write$
      newline$

      "\diritem[" write$
      format.name write$
      "]{" write$
      "d." cite$ * write$
      "}\dirgroup" write$
      newline$
      "\dirblock" write$
      newline$

      format.p.flag output.flag
      format.p.email output

      format.r.flag output.flag
      format.r.email output

      format.w.flag output.flag
      format.w.email output 

     "\direndgroup" write$
      newline$
      }
    { }
  if$
}

% ------------------------------------------------------------ 
%  C O M P A N Y   E N T R Y  
% ------------------------------------------------------------ 


FUNCTION { company }
{ 
  email empty$ not
    { newline$

      "\dircheck{" write$
      format.first.letter write$
      "}" write$
      newline$

      "\diritem[" write$
      name write$
      "]{" write$
      "d." cite$ * write$
      "}\dirgroup" write$
      newline$
      "\dirblock" write$
      newline$      

      format.email output 

      "\direndgroup" write$
      newline$
      }
    { }
  if$
}

% ------------------------------------------------------------ 
%  P L A C E   E N T R Y  
% ------------------------------------------------------------ 


FUNCTION { place }
{ 
}

% ------------------------------------------------------------ 
%  M A I N 
% ------------------------------------------------------------ 

READ
ITERATE {presort}
SORT
EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}
