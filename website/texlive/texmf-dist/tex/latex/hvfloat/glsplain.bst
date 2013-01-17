% (c) 1998 Jose Luis Diaz, 1999-2002 Jose Luis Diaz and Javier Bezos.
% All Rights Reserved.
%
% This file is part of the gloss distribution release 1.5.2
% --------------------------------------------------------
%
% This file can be redistributed and/or modified under the terms
% of the LaTeX Project Public License Distributed from CTAN
% archives in directory macros/latex/base/lppl.txt; either
% version 1 of the License, or any later version.
%
%% History of v0.1
%% ~~~~~~~~~~~~~~~
%% 1997/06/25 (JLDdA) Original version, by Jose Luis Diaz de Arriba (and an
%%                    unindicted co-conspirator)
%% History of v1.0
%% ~~~~~~~~~~~~~~~
%% 1999/07/29 (JBL)   Rewritten in full. Now it warns if a required field is
%%                    missing, conforms the new gloss.sty syntax, and
%%                    writes headings for each letter. The heading,
%%                    short, and group fiels have been added.
%% History of v1.1-1.4
%% ~~~~~~~~~~~~~~~~~~~
%% 1999/10/10 (JBL)   Lots of changes.
%% History of v.1.5
%% ~~~~~~~~~~~~~~~~
%% 2001/08/02 (JBL)   Added the sort-short field for compatility 
%%                    with glsshort.bst

STRINGS { last.heading s t star.period}

ENTRY
  { word
    sort-word
    definition
    heading
    group
    short
	sort-short
  }
  {}
  { ucword }
  
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {has.period}
{ duplicate$
  add.period$ =
}

FUNCTION {str.length}
{ 't :=
  #0
    { t empty$ not }
    { t #2 global.max$ substring$
	  't :=
	  #1 +
    }
  while$
}


FUNCTION {upper.first}
{ duplicate$
  #1 text.prefix$
  duplicate$
  "u" change.case$
  's :=
  str.length
  #1 + entry.max$ substring$
  s swap$ *
}

FUNCTION {check.required}
{ 's :=
  duplicate$ empty$
    { "Empty " s * " in " * cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {push.sortword}
{ sort-word empty$ 
   { word field.or.null }
   'sort-word
  if$
}

FUNCTION {check.alpha}
{ duplicate$
  purify$
  empty$
    { "Non alphabetical " cite$ *
      " entry without group field" * warning$ }
    'skip$
  if$
}

FUNCTION {push.heading}
{ heading empty$
    { word field.or.null
      #1 text.prefix$
      check.alpha
    }
    'heading
    if$
}

FUNCTION {begin.entry}
{ newline$
  "\begin{glossitem" star.period * write$
  "}{" write$
  cite$ write$
  "}{" write$
  word write$
  "}{" write$
  ucword write$
  "}{" write$
  short field.or.null write$
  "}" write$
  newline$
}

FUNCTION {end.entry}
{ "\end{glossitem" star.period "}" * * write$
  newline$
}

FUNCTION {set.vars}
{ word field.or.null
  "word" check.required
  upper.first
  'ucword := 
}


FUNCTION {glossdef}
{ definition field.or.null
  "definition" check.required
  duplicate$ has.period
    { "*" }
	{ "" }
  if$
  'star.period :=    % definition is stored for later writing
  begin.entry        % this outputs word, ucword, and short
  write$             % writes definition
  end.entry
}

FUNCTION {gd}
{ definition field.or.null
  "definition" check.required
  duplicate$ has.period
    { "*" }
	{ "" }
  if$
  'star.period :=    % definition is stored for later
  begin.entry        % this outputs word, ucword, and short
  write$             % writes definition
  end.entry
}

FUNCTION {default.type} { glossdef }

FUNCTION {presort}
{ set.vars
  push.sortword
  group empty$
    { purify$ "L" }
    'group
  if$                    % sort-word heading
  swap$ *                % heading * sort-word
  "l" change.case$
  'sort.key$ :=
}

FUNCTION {begin.thegloss}
{ "\begin{thegloss}"   
  write$
  newline$
  preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
}

FUNCTION {end.thegloss}
{ newline$
  "\end{thegloss}" write$
  newline$
}

FUNCTION {call.entries}
  { group empty$
      'push.heading
      { heading empty$
          'skip$
          { "Ignoring heading because there is group field in "
            cite$ *
            warning$
          }
        if$
        group
      }
    if$
    "u" change.case$
    duplicate$
    group empty$
      'skip$
      { "$$$$$" * }
    if$
    duplicate$
    last.heading =
      { pop$ pop$ }
      { newline$
		'last.heading :=
        group empty$
          { "\glossheading{" }
          { "\glossgroup{" }
        if$
        swap$ * "}" *
        write$
        newline$
      }
    if$
    call.type$
  }

READ

ITERATE {presort}

SORT

EXECUTE {begin.thegloss}

ITERATE {call.entries}

EXECUTE {end.thegloss}


