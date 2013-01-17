%% letter.bst
%% Copyright 1998-2003 Christophe Geuzaine <geuz@geuz.org>
%
% $Id: letter.bst,v 1.7 2003/09/15 05:40:31 geuzaine Exp $
%
% This program can be redistributed and/or modified under the terms
% of the LaTeX Project Public License distributed from CTAN
% archives in directory macros/latex/base/lppl.txt; either
% version 1 of the License, or (at your option) any later version.
%
% BibTeX bibliography style `letter.bst'
% 'directory' database: all fields
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
    address
      street
      city
      state
      zip
      country
    p.address
      p.street
      p.city
      p.state
      p.zip
      p.country
    r.address
      r.street
      r.city
      r.state
      r.zip
      r.country
    w.title
    w.name
    w.address
      w.street
      w.city
      w.state
      w.zip
      w.country
  }
  {}
  {}

% ------------------------------------------------------------ 
%  G E N E R A L
% ------------------------------------------------------------ 

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

FUNCTION {format.address}
{ address empty$
    { 
      street empty$ city empty$ state empty$ zip empty$ country empty$
      and and and and
        { "" }
        { " \dirnext " 
          street empty$ { "" * } { street " \dirnext " * * } if$
          city empty$ { "" * } { city " " * * } if$
          state empty$ { "" * } { state " " * * } if$
          zip empty$ { "" * } { zip " " * * } if$
          country empty$ { "" * } { country * } if$
        }
      if$
    }
    { " \dirnext " address * }
  if$
}

FUNCTION {format.p.address}
{ p.address empty$
    { 
      p.street empty$ p.city empty$ p.state empty$ p.zip empty$ p.country empty$
      and and and and
        { "" }
        { " \dirnext " 
          p.street empty$ { "" * } { p.street " \dirnext " * * } if$
          p.city empty$ { "" * } { p.city " " * * } if$
          p.state empty$ { "" * } { p.state " " * * } if$
          p.zip empty$ { "" * } { p.zip " " * * } if$
          p.country empty$ { "" * } { p.country * } if$
        }
      if$
    }
    { " \dirnext " p.address * }
  if$
}

FUNCTION {format.r.address}
{ r.address empty$
    { 
      r.street empty$ r.city empty$ r.state empty$ r.zip empty$ r.country empty$
      and and and and
        { "" }
        { " \dirnext " 
          r.street empty$ { "" * } { r.street " \dirnext " * * } if$
          r.city empty$ { "" * } { r.city " " * * } if$
          r.state empty$ { "" * } { r.state " " * * } if$
          r.zip empty$ { "" * } { r.zip " " * * } if$
          r.country empty$ { "" * } { r.country * } if$
        }
      if$
    }
    { " \dirnext " r.address * }
  if$
}

FUNCTION {format.w.title}
{ w.title empty$
    { "" }
    { " \dirnext " w.title * }
  if$
}

FUNCTION {format.w.name}
{ w.name empty$
    { "" }
    { " \dirnext " w.name * }
  if$
}

FUNCTION {format.w.address}
{ w.address empty$
    { 
      w.street empty$ w.city empty$ w.state empty$ w.zip empty$ w.country empty$
      and and and and
        { "" }
        { " \dirnext " 
          w.street empty$ { "" * } { w.street " \dirnext " * * } if$
          w.city empty$ { "" * } { w.city " " * * } if$
          w.state empty$ { "" * } { w.state " " * * } if$
          w.zip empty$ { "" * } { w.zip " " * * } if$
          w.country empty$ { "" * } { w.country * } if$
        }
      if$
    }
    { " \dirnext " w.address * }
  if$
}

% ------------------------------------------------------------ 
%  P E R S O N   E N T R Y  
% ------------------------------------------------------------ 

FUNCTION { person }
{ 
  "\diritem{" write$
  format.name write$
  "}{" write$
  "d." cite$ * write$
  "}" write$

  newline$

  "\diritem{" write$
  "\dirbegin " write$
  format.name write$
  format.p.address write$
  "\dirend " write$
  "}{" write$
  "p." cite$ * write$
  "}" write$

  newline$

  "\diritem{" write$
  "\dirbegin " write$
  format.name write$
  format.r.address write$
  "\dirend " write$
  "}{" write$
  "r." cite$ * write$
  "}" write$

  newline$

  "\diritem{" write$
  "\dirbegin " write$
  format.name write$
  format.w.title write$
  format.w.name write$
  format.w.address write$
  "\dirend " write$
  "}{" write$
  "w." cite$ * write$
  "}" write$

  newline$
}

% ------------------------------------------------------------ 
%  C O M P A N Y   E N T R Y  
% ------------------------------------------------------------ 


FUNCTION { company }
{ 
  "\diritem{" write$
  name write$
  "}{" write$
  "d." cite$ * write$
  "}" write$

  newline$

  "\diritem{" write$
  "\dirbegin " write$
  name write$
  format.address write$
  "\dirend " write$
  "}{" write$
  "p." cite$ * write$
  "}" write$

  newline$

  "\diritem{" write$
  "\dirbegin " write$
  name write$
  format.address write$
  "\dirend " write$
  "}{" write$
  "r." cite$ * write$
  "}" write$

  newline$

  "\diritem{" write$
  "\dirbegin " write$
  name write$
  format.address write$
  "\dirend " write$
  "}{" write$
  "w." cite$ * write$
  "}" write$

  newline$
}

% ------------------------------------------------------------ 
%  P L A C E   E N T R Y  
% ------------------------------------------------------------ 

FUNCTION { place }
{ 
  "\diritem{" write$
  name write$
  "}{" write$
  "d." cite$ * write$
  "}" write$

  newline$

  "\diritem{" write$
  "\dirbegin " write$
  name write$
  format.address write$
  "\dirend " write$
  "}{" write$
  "p." cite$ * write$
  "}" write$

  newline$

  "\diritem{" write$
  "\dirbegin " write$
  name write$
  format.address write$
  "\dirend " write$
  "}{" write$
  "r." cite$ * write$
  "}" write$

  newline$

  "\diritem{" write$
  "\dirbegin " write$
  name write$
  format.address write$
  "\dirend " write$
  "}{" write$
  "w." cite$ * write$
  "}" write$

  newline$
}

% ------------------------------------------------------------ 
%  M A I N 
% ------------------------------------------------------------ 

READ
ITERATE {call.type$}

