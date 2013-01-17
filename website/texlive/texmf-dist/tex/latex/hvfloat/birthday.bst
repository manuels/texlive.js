%% birthday.bst
%% Copyright 1998-2003 Christophe Geuzaine <geuz@geuz.org>
%
% $Id: birthday.bst,v 1.6 2003/09/14 09:47:49 geuzaine Exp $
%
% This program can be redistributed and/or modified under the terms
% of the LaTeX Project Public License distributed from CTAN
% archives in directory macros/latex/base/lppl.txt; either
% version 1 of the License, or (at your option) any later version.
%
% BibTeX bibliography style `birthday.bst'
% 'directory' database: only birthday field
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
    birthday
    birthyear
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

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

% ------------------------------------------------------------ 
%  S O R T I N G   F U N C T I O N S
% ------------------------------------------------------------ 

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

FUNCTION {sort.day}
{  
 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  skip$
  s nameptr "{ll{}}{ff{}}" format.name$ 't :=
  t sortify *
  #1 global.max$ substring$
}


FUNCTION {birthday.sort}
{ type$ "person" =
    { birthday empty$
       { "" }
       { birthday sort.day }
     if$ }
    { "" }
  if$
}

FUNCTION {presort}
{ birthday.sort
  " "
  *
  #1 entry.max$ substring$
  'sort.key$ :=
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
    
% CUSTOM you shoudn't change this, but rather redefine the command \Dirbirthday.

    { namesleft #0 > }
    { s nameptr "{ff}" format.name$ 't :=
      s nameptr "{ll}" format.name$ 'u :=

      nameptr #1 >
	{ namesleft #1 >
	    { ", \dirbira{" * t * "}{" * u * "}" *  }
	    { " {\dirandf} \dirbira{" * t * "}{" * u * "}" *  }
	  if$
	}
	{ "\dirbira{" t * "}{" * u * "}" * }
      if$

      numaux #0 > not
        { }
        { birthyear nameptr "{ll}" format.name$ 'v := 
          "\dirbiya{" * v * "}" * }
      if$

      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
      numaux #1 - 'numaux :=
    }
  while$
}

FUNCTION {format.years}
{
 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    
    { namesleft #0 > }
    { s nameptr "{ll}" format.name$ 't :=
      nameptr #1 >
	{ namesleft #1 >
	    { ", \dirbyra{" * t * "}" *  }
	    { " {\dirandf} \dirbyra{" * t * "}" *  }
	  if$
	}
	{ "\dirbyra{" t * "}" * }
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

FUNCTION {format.birthday.flag}
{ birthyear empty$ not
  birthday empty$ not
  or
    { "\dirbirf " }
    { "" }
  if$
}

FUNCTION {format.birthday}
{ birthday empty$
    {  
       birthyear empty$
        { "" }
        { birthyear format.years }
      if$
    }
    { birthday format.dates }
  if$
}

% ------------------------------------------------------------ 
%  P E R S O N   E N T R Y  
% ------------------------------------------------------------ 


FUNCTION { person }
{ 
  birthday empty$ not
    { newline$

      "\diritem[" write$
      format.birthday.flag write$
      format.birthday write$
      "]{" write$
      "d." cite$ * write$
      "}\dirgroup" write$
      newline$
      "\dirblock" write$
      newline$

      format.name output 

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

