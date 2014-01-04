ENTRY
  {
 name
 status
 abstract
 texlive
 author
 ctan
 keywords
 version
 also
 modified
  }
  {}                                    % no integer entry variables
  { label extra.label sort.label }      % label entry variables


STRINGS { s t a.name }


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

INTEGERS { nameptr namesleft numnames }


FUNCTION {TexIndex} { 
  texlive empty$
   { }
   { "\bibitem{" cite$ * "}" * write$
     cite$ "&" * write$
     status "&" * write$ 
     texlive "&" * write$ 
     newline$
     abstract write$
     newline$
    }
  if$
 }


READ

ITERATE {call.type$}

