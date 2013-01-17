%% DINAT.BST   Version 2.5   2000-11-14 
%% (c) Helge Baumann   email:Helge.Baumann@gmx.de
%%------------------------------------------------------------------------------
%% For use with BibTeX version 0.99a or later.
%%------------------------------------------------------------------------------
%% Copying of this file is authorized only if either
%% (1) you make absolutely no changes to your copy, including name, or
%% (2) if you do make changes, you name it something other than dinat.bst, 
%% natdin.bst, plain.bst, unsrt.bst, alpha.bst, and abbrv.bst.
%% This restriction helps ensure that all standard styles are identical.
%%------------------------------------------------------------------------------
%% This is a full author-year citation style bibliography. As such, it is
%% non-standard LaTeX, and requires the natbib-package by Patrick W. Daly,
%% version 7 or higher to function properly.
%% It should be used with the following configuration in natbib.cfg:
%% \newcommand{\bibstyle@dinat}%
%%     {\bibpunct{(}{)}{;}{a}{}{,~}%
%%      \gdef\NAT@biblabelnum##1{\textbf{##1}}}
%%------------------------------------------------------------------------------
%% The form of the \bibitem entries is
%%   \bibitem[Jones u. a.(1990)Jones, Baker und Smith]{key}...
%% If there are more [Jones u. a. 1990], a single character is added to 
%% the year like in [Jones u.a.(1990{\natexlab{a}})Jones, Baker und Smith].
%% The resulting bibliography entry is
%%   \textsc{Jones}, \textsc{Baker} und \textsc{Smith} ...
%% The \cite command functions as follows:
%%   \cite{key}                ==>>  Jones u. a. (1990)
%%   \cite[chap. 2]{key}       ==>>  (Jones u. a. 1990, chap. 2)
%%   \cite[e.g.][]{key}        ==>>  (e.g. Jones u. a. 1990)
%%   \cite[e.g.][p. 32]{key}   ==>>  (e.g. Jones u. a. p. 32)
%%   \citep{key}               ==>>  (Jones u. a. 1990)
%%   \citep*{key}              ==>>  (Jones, Baker und Smith 1990)
%%   \citet{key}               ==>>  Jones u. a. (1990)
%%   \citet*{key}              ==>>  Jones, Baker und Smith (1990)
%%   \citeauthor{key}          ==>>  Jones u. a.
%%   \citeauthor*{key}         ==>>  Jones, Baker und Smith
%%   \citeyear{key}            ==>>  1990
%%------------------------------------------------------------------------------
%% This bibliography style file is intended for texts in german.
%% It draws up bibliographies in accordance with the german DIN 1505, 
%% part 2 and 3, as discribed in the german text
%% http://www.fh-hamburg.de/pers/Lorenzen/tum/litverz.ps
%%------------------------------------------------------------------------------
%% This style is based on the natdin.bst style.
%% The intention for designing a new style for the same result 
%% were the many bugs and the poor design of the original style.
%% So i simplified the programming and add some comments for rework.
%% The names of the functions were changed to reflect their functionality:
%%   out.*:    write the top of the stack to the bbl-file
%%   format.*: format the top of the stack
%%   push.*:   put one item on top of the stack
%%------------------------------------------------------------------------------
%% There are some non standard fields for most entries:
%%   isbn: international book number
%%   issn: internation journal number
%%   url: for electronic published documents or additional information
%%        if there is no publisher and address, the url is used instead,
%%        else it acts like a additional note
%%   urldate: the date of the access to the url
%%------------------------------------------------------------------------------
%% Author(s):
%%   HB: Helge Baumann, helge.baumann@gmx.de
%%------------------------------------------------------------------------------
%% History:
%%   (only main changes are listed, for others see the webpage)
%%   2000-04-10 (HB): Initial release
%%   2000-04-18 (HB): Version 1.1:
%%                      corrected some typos and oversights
%%                      minor changes in output
%%   2000-04-25 (HB): Version 1.2:
%%                      dinat only: added \natexlab
%%                      using full key/cite for label
%%   2000-05-02 (HB): Version 2.0:
%%                      added urldate for date of visit
%%                      added labels in bibliography, so the seperate 
%%                        style dinnat.bst is not needed anymore
%%   2000-05-09 (HB): Version 2.1:
%%                      removed blanc in bibpunct
%%                      put text ("u.\,a." ...) in functions
%%                      rebuild some push functions
%%                      changed \cite to \citep
%%                      removed push.crossref.editor (not used)
%%   2000-07-12 (HB): version 2.2:
%%                      added push.crossref
%%                      changed many crossrefs
%%                      corrected typos
%%                      put \, in curly braces
%%   2000-10-03 (HB): version 2.3:
%%                      changed remaining "u.~a."
%%                      added \labelsep behind dinatlabel
%%                      added mastersthesis again, keeping (wrong) 
%%                        masterthesis (sorry for that)
%%                      minor changes in proceedings
%%   2000-11-05 (HB): version 2.4:
%%                      improved inbook
%%                      removed extra period from proceedings
%%                      added missing colon in misc
%%                      improved name formatting
%%                      removed long dashes from ISBN/ISSN
%%                      restructured format.dashes
%%   2000-11-14 (HB): version 2.5:
%%                      always use key for label if present
%%------------------------------------------------------------------------------


%%------------------------------------------------------------------------------
%% push standard text items on top of the stack
%%------------------------------------------------------------------------------
FUNCTION {push.bd}        { "Bd." }
FUNCTION {push.diplom}    { "Diplomarbeit" }
FUNCTION {push.disser}    { "Dissertation" }
FUNCTION {push.forschung} { "Forschungsbericht" }
FUNCTION {push.hrsg}      { "Hrsg." }
FUNCTION {push.in}        { "In:" }
FUNCTION {push.isbn}      { "ISBN" }
FUNCTION {push.issn}      { "ISSN" }
FUNCTION {push.kap}       { "Kap." }
FUNCTION {push.nr}        { "Nr." }
FUNCTION {push.sn}        { "S" }
FUNCTION {push.s}         { "S." }
FUNCTION {push.siehe}     { "Siehe" }
FUNCTION {push.ua}        { "u.\,a." }
FUNCTION {push.und}       { "und" }
FUNCTION {push.url.name}  { "URL" }
FUNCTION {push.veranst}   { "Veranst." }
FUNCTION {push.von}       { "von" }
FUNCTION {push.zugriff}   { "Zugriffsdatum" }

FUNCTION {push.cite}      { "\citep" }


%%------------------------------------------------------------------------------
%% Definitions for every bibliography entry
%%------------------------------------------------------------------------------
ENTRY
  % fields (crossref is default)
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    isbn
    issn
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
    url
    urldate
    volume
    year
  }
  % INTEGERS
  {}
  % STRINGS (sort.key$ is default)
  { label extra.label sort.label short.list dinat.label }

  
%%------------------------------------------------------------------------------
%% required macros for abbr. names of month
%%------------------------------------------------------------------------------
MACRO {jan} {"Januar"}

MACRO {feb} {"Februar"}

MACRO {mar} {"M\^^b{a}rz"}

MACRO {apr} {"April"}

MACRO {may} {"Mai"}

MACRO {jun} {"Juni"}

MACRO {jul} {"Juli"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"Oktober"}

MACRO {nov} {"November"}

MACRO {dec} {"Dezember"}


%%------------------------------------------------------------------------------
%% macros for common journals
%%------------------------------------------------------------------------------
MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}


%%------------------------------------------------------------------------------
%% for debugging (not used)
%%------------------------------------------------------------------------------
FUNCTION {show}
% show quoted top of stack
{ duplicate$ "::::  `" swap$ * "'" * top$
}

FUNCTION {show.stack}
% show and clear whole stack
{ "STACK====================================================================="
  top$
  stack$
  "ENDSTACK=================================================================="
  top$
}


%%------------------------------------------------------------------------------
%% logical functions
%%------------------------------------------------------------------------------
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   { skip$ }
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    { skip$ }
  if$
}


%%------------------------------------------------------------------------------
%% variables for the recent output state
%%------------------------------------------------------------------------------
INTEGERS { output.state 
           before.all 
	   mid.sentence 
	   after.sentence 
	   after.block
	   colon.after 
	   period.dash }

FUNCTION {init.state.consts}
% initialisation of the state variables
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
  #4 'colon.after :=
  #5 'period.dash :=
}

FUNCTION {set.period.dash}
% set ". -- "
{ output.state before.all =
    { skip$ }
    { period.dash 'output.state := }
  if$
}

FUNCTION {set.period.dash.check} 
% only if not empty
{ empty$ 
    { skip$ }
    { set.period.dash }
  if$
}

FUNCTION {set.colon.after}
% set ": "
{ output.state before.all =
    { skip$ }
    { colon.after 'output.state := }
  if$
}

FUNCTION {new.sentence}
% set ". "
{ output.state before.all =
     { skip$ }
     { after.sentence 'output.state := }
  if$
}

FUNCTION {new.sentence.check}
% only if not empty
{ empty$
    { skip$ }
    { new.sentence }
  if$
}

FUNCTION {part.of.sentence}
% set ", "
{ output.state before.all =
     { skip$ }
     { mid.sentence 'output.state := }
  if$
}


%%------------------------------------------------------------------------------
%% output lines to bbl. file
%%------------------------------------------------------------------------------
STRINGS { h s t u v } 

FUNCTION {out.block}
% writes the second but last element with seperator
{ 's :=
  output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    { output.state before.all =
        { write$ }
        { output.state colon.after =
            { ": " * write$
              newline$
              "\newblock " write$
            }
            { output.state period.dash =
                { ". -- " * write$
                  newline$
                  "\newblock " write$
                }
                { output.state mid.sentence =
                    { ", " * write$ }
                    { write$ 
                      newline$
                      "\newblock " write$ 
                    }
                  if$
                }
              if$
            }
          if$
        } 
      if$
      after.block 'output.state :=
    }
  if$ 
  s 
}

FUNCTION {out}
% write only if not empty
{ duplicate$ empty$
    { pop$ }
    { out.block }
  if$
}

FUNCTION {out.check.required}
% write if not empty, else drop warning
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    { out.block }
  if$
}

FUNCTION {out.check.din}
% write if not empty, else drop note
{ 't :=
  duplicate$ empty$
    { pop$ "DIN: empty " t * " in " * cite$ * top$ }
    { out.block }
  if$
}


%%------------------------------------------------------------------------------
%% format entries for full author/editor citations
%%------------------------------------------------------------------------------
INTEGERS { nameptr namesleft pos len } 

FUNCTION {format.full.names}
% format all names
{ 's :=
  ""
  #1 'nameptr :=
  s num.names$ 'namesleft :=
  { namesleft #0 > } % while
    { s nameptr "{vv~}{ll}" format.name$ 't :=
      nameptr #1 =
        { % first name
	  t *
        }
        { namesleft #1 =
            { % last name
	      t "others" =
                { " " * push.ua * }
                { " " * push.und * " " * t * }
              if$
            }
            { % other names
	      ", " * t * 
	    } 
          if$
        }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$ % { namesleft #0 > }
}

FUNCTION {key.full}
{ key empty$
    { cite$ }
    { key }
  if$
}

FUNCTION {author.key.full}
{ author empty$
    { key.full }
    { author format.full.names }
  if$
}

FUNCTION {editor.key.full}
{ editor empty$
    { key.full }
    { editor format.full.names }
  if$
}

FUNCTION {author.editor.key.full}
{ author empty$
    { editor.key.full }
    { author format.full.names }
  if$
}

FUNCTION {make.full.names}
{ type$ "book" =
  type$ "inbook" =
  or
    { author.editor.key.full }
    { type$ "proceedings" =
        { editor.key.full }
        { author.key.full }
      if$
    }
  if$
}


%%------------------------------------------------------------------------------
%% write bibentry to bbl. file
%%------------------------------------------------------------------------------
FUNCTION {out.bibitem.start}
% start of entry
{ newline$
  "\bibitem[" label * ")" * 
  make.full.names 
  duplicate$ short.list =
    { pop$ }
    { * }
  if$
  "]{" * cite$ * "}" * 
  write$
  newline$
  "\dinatlabel{" dinat.label * "} " * 
  write$
  ""
  before.all 'output.state :=
}

FUNCTION {out.bibitem.end}
% end of entry
{ write$
  newline$
}


%%------------------------------------------------------------------------------
%% format text
%%------------------------------------------------------------------------------
FUNCTION {format.emphasize}
% emphasize top of stack
{ duplicate$ empty$
    { pop$ "" }
    { "\emph{" swap$ * "}" * }
  if$
}

FUNCTION {format.smallcaps}
% top of stack in small caps
{ duplicate$ empty$
    { pop$ "" }
    { "\textsc{" swap$ * "}" * }
  if$
}

FUNCTION {format.dashes}
% replace single dashes (-) with tex-styled dashes (--)
{ 't :=
  ""
  { t empty$ not } % while$
    { t #1 #2 substring$ "--" =
        { { t #1 #1 substring$ "-" = }
            { "-" *
              t #2 global.max$ substring$ 't :=
            }
          while$
        }
        { t #1 #1 substring$ "-" =
            { "--" * }
            { t #1 #1 substring$ * }
          if$
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$ % { t empty$ not }
}


%%------------------------------------------------------------------------------
%% manipulte entries on the stack
%%------------------------------------------------------------------------------
FUNCTION {tie.or.space.connect}
% connect two top items with space or ~, if second is shorter than 3
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {push.field.or.null}
% push an empty item on the stack if it's a missing entry
{ duplicate$ empty$
    { pop$ "" }
    { skip$ }
  if$
}


%%------------------------------------------------------------------------------
%% format text on stack
%%------------------------------------------------------------------------------
STRINGS { hrsg }

FUNCTION {format.names}
% format all names on top of stack
{ 's :=
  ""
  #1 'nameptr :=
  s num.names$ 'namesleft :=
  { namesleft #0 > } % while names left
     { % first get last name in small caps
       s nameptr "{ll}" format.name$ 't :=
       t format.smallcaps 't :=
       % second get all first names
       s nameptr "{, ff}" format.name$ 'u := 
       u text.length$ 'len := 
       #1 'pos :=
       "" 'v :=
       { pos len < } % while
          { u pos #1 substring$ "~" = 
              { v "" =
                  { u #1 pos #1 - substring$ 'v := }
                  { skip$ }
                if$
		% cut second and more first names
                v u pos #2 substring$ * "." * 'v := 
              }
              { skip$ }
            if$
            pos #1 + 'pos :=
          }
       while$ % { pos len < }
       v "" =
         { u 'v := }
	 { skip$ }
       if$
       % third get all "von"
       s nameptr "{ vv}" format.name$ 'u :=
       % put it all together
       t v * u * hrsg * 't :=
       
       nameptr #1 =
         { %first name
	   t *
         }
         { namesleft #1 =
             { % last name
	       t "others" format.smallcaps = 
               t "others" format.smallcaps hrsg * = 
               or
                 { " " * push.ua * }
                 { "~; " * t * }
               if$
             }
             { % other names
	       "~; " * t * 
	     }
           if$
         }
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$ % { namesleft #0 > }
  "" 'hrsg :=
}


%%------------------------------------------------------------------------------
%% push formatted or empty field(s) on top of the stack
%%------------------------------------------------------------------------------
FUNCTION {push.authors}
% format author names
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {push.editors}
% format editor names
{ editor empty$
    { "" } 
    { " (" push.hrsg * ")" * 'hrsg := 
      editor format.names
    }
  if$
} 

FUNCTION {push.authors.editors}
% format author and/or editor names
{ author empty$
    { push.editors }
    { push.authors
      editor empty$
        { skip$ }
        { "~; " * push.editors * }
      if$
    }
  if$
}


FUNCTION {push.organization}
% format organization
{ organization empty$
    { "" }
    { organization
      " (" * push.veranst * ")" *
    }
  if$
}

FUNCTION {push.title}
% title as in entry
{ title empty$
    { "" }
    { title }
  if$
}

FUNCTION {push.url}
% prefixed with "URL" and special formatting
{ url empty$
    { "" }
    { push.url.name " \url{" * url * "}" * 
      urldate empty$
        { skip$ }
	{ ". -- " * push.zugriff * ": " * urldate * }
      if$
    }
  if$
}

FUNCTION {push.date}
% format: month year
{ year empty$
    { month empty$
        { "" }
        { "there's a month but no year in " cite$ * warning$
          month
        }
      if$
    }
    { month empty$
        { year }
        { month " " * year * }
      if$
    }
  if$
}

FUNCTION {push.address.publisher.year}
% the whole imprint
{ address empty$
    { publisher empty$
        { url empty$
            { year empty$ 
                { "no publisher, address, url or date in " cite$ * warning$
                  "" }
                { push.date } 
              if$
            }
            { "no proper publisher, using url in " cite$ * warning$
              push.url
              year empty$
                { skip$ }
                { ", " * push.date * }
              if$
            }
          if$
        }
        { publisher 
	  year empty$
            { "there's a publisher but no year in " cite$ * warning$ }
            { ", " * push.date * }
          if$
        }
      if$
    }
    { address
      publisher empty$
        { "there's an address but no publisher in " cite$ * warning$ }
        { "~: " * publisher * }
      if$
      year empty$
	{ skip$ }
	{ ", " * push.date * }
      if$
    }
  if$
}

FUNCTION {push.btitle}
% the booktitle
{ title empty$
    { "" }
    { title format.emphasize }
  if$
}

FUNCTION {push.btitle.vol}
% booktitle in multivolume works
{ number empty$
    { series empty$
        { push.btitle
	  volume empty$
            { skip$ }
            { ". " * push.bd * volume tie.or.space.connect }
          if$
        }
        { volume empty$
            { push.btitle }
            { series format.emphasize ". " * 
	      push.bd * volume tie.or.space.connect 
	      ": " * push.btitle *  
	    } 
          if$
        }
      if$
    }
    { push.btitle }
  if$
}

FUNCTION {push.article.in.journal}
% source of article
{ journal empty$
    { "" }
    { author missing$
      title missing$
      and
        { journal format.emphasize }
        { push.in " " * journal format.emphasize * }
      if$
    }
  if$
}

FUNCTION {push.series.number}
% series and number like DIN
{ volume empty$
    { series empty$
        { number empty$
	    { "" }
	    { "there's a number but no series in " cite$ * warning$ 
	      "(" number * ")" * }
	  if$
	}
	{ "(" series *
	  number empty$
	    { skip$ }
	    { number tie.or.space.connect }
	  if$
	  ")" * 
	}
      if$
    }
    { series empty$
        { "" }
        { type$ "proceedings" =
            { "(" series * 
	      number empty$ 
                { skip$ }
                { number tie.or.space.connect }
              if$ 
	      ")" * 
            }
            { "" }
          if$
        }
      if$
    }
  if$
}

FUNCTION {push.misc.series}
% series in MISC
{ series empty$
    { "" }
    { "(" series * ")" * }
  if$
}

FUNCTION {push.edition}
% like in entry
{ edition empty$
    { "" }
    { edition } 
  if$
}

FUNCTION {push.isbn.issn}
% preceeded with ISSN/ISBN
{ isbn empty$
     { issn empty$
          { "" }
          { push.issn " " * issn * }
       if$
     }
     { push.isbn " " * isbn * }
  if$
}

FUNCTION {push.pages.book}
% as length of a book
{ pages empty$
    { "" } 
    { pages format.dashes "~" * push.sn * }
  if$
}

FUNCTION {push.pages}
% as part of a book
{ pages empty$
    { "" }
    { push.s "~" * pages format.dashes * } 
  if$
}

FUNCTION {push.vol.year.num.pages}
% for journals etc.
{ volume push.field.or.null
  year empty$
    { "there's no year in " cite$ * warning$ }
    { duplicate$ empty$
        { pop$ "(" }
	{ " (" * }
      if$
      year * ")" * 
    }
  if$
  month empty$
    { skip$ }
    { duplicate$ empty$
        { pop$ month }
        { ", " * month * }
      if$
    }
  if$
  number empty$
    { skip$ }
    { duplicate$ empty$
        { pop$ push.nr }
        { ", " * push.nr * }
      if$
      "~" * number *
    }
  if$
  pages empty$
    { skip$ }
    { duplicate$ empty$
        { skip$ }
        { ", " *
	  title missing$
            { push.pages.book * }
            { push.pages * }
          if$ 
        }
      if$
    }
  if$
}

FUNCTION {push.chapter.pages}
% chapter and pages
{ chapter empty$
    { push.pages }
    { type empty$
        { push.kap }
        { type }
      if$
      chapter tie.or.space.connect
      pages empty$
        { skip$ }
        { ", " * push.pages * }
      if$
    }
  if$
}

FUNCTION {push.in.ed.booktitle}
% main title and volume
{ booktitle empty$
    { "" }
    { push.in " " * 
      editor empty$
        { skip$ }
        { push.editors * ": " * }
      if$
      booktitle format.emphasize * 
      volume empty$
        { skip$ }
        { " " * push.bd * "~" * volume * }
      if$
    }
  if$
}

FUNCTION {push.mastersthesis.type}
% type of a mastersthesis
{ type empty$
    { push.diplom }
    { type }
  if$
}

FUNCTION {push.phdthesis.type}
% type of a phdthesis
{ type empty$
    { push.disser }
    { type }
  if$
}

FUNCTION {push.tr.number}
% type and number of a technical report
{ number empty$
    { " " }
    { "(" number * "). " * }
  if$
  "-- " *
  type empty$
    { push.forschung * }
    { type * }
  if$
}

FUNCTION {push.article.crossref}
% article from a journal
{ key empty$
    { journal empty$
        { "need key or journal for " cite$ * " to crossref " * crossref *
          warning$
          ""
        }
        { push.in " " * journal format.emphasize * }
      if$
    }
    { push.in " " * key * }
  if$
  " " * push.cite * "{" * crossref * "}" *
  pages empty$
    { skip$ }
    { ", " * push.pages * }
  if$
}

FUNCTION {push.book.crossref}
% crossreference in BOOKs
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      push.siehe
    }
    { ". -- " push.bd * "~" * volume *
      " " * push.von * 
    }
  if$
  " " * push.cite * "{" * crossref * "}" * 
}

FUNCTION {push.incoll.inproc.crossref}
% crossreference with In:
{ editor empty$
  editor push.field.or.null author push.field.or.null =
  or
    { key empty$
        { booktitle empty$
            { push.siehe }
            { push.in " " * booktitle format.emphasize * "." * }
          if$
        }
        { push.in }
      if$
    }
    { push.in }
  if$
  " " * push.cite * "{" * crossref * "}" *
  chapter empty$
    { skip$ }
    { ", " *
      type empty$
        { push.kap * }
        { type * }
      if$
      chapter tie.or.space.connect
    }
  if$
  pages empty$
    { skip$ }
    { ", " * push.pages * }
  if$
}

FUNCTION {push.crossref}
% a simple crossref
{ crossref empty$
    { "" }
    { push.siehe " " * push.cite * "{" * crossref * "}" * }
  if$
}


%%------------------------------------------------------------------------------
%% functions for the different entries 
%%------------------------------------------------------------------------------
FUNCTION {article}
% required: author, title, journal, year
% optional: volume, number, pages, month, note, url, issn
{ out.bibitem.start
  push.authors "author" out.check.required
  set.colon.after
  push.title "title" out.check.required
  crossref missing$
    { push.article.in.journal out.block 
      new.sentence 
      push.vol.year.num.pages out
    }
    { push.article.crossref out.block }
  if$
  url set.period.dash.check
  push.url out
  note set.period.dash.check
  note out
  issn set.period.dash.check
  push.isbn.issn out
  out.bibitem.end
}

FUNCTION {book}
% required: author/editor, title, publisher, year
% optional: volume oder number, series, address, edition, pages, month, 
%           note, url, isbn
{ out.bibitem.start
  author empty$
    { push.editors "author and editor" out.check.required }
    { push.authors.editors out.block }
  if$
  set.colon.after
  crossref missing$
    { push.btitle.vol }
    { push.btitle }
  if$ 
  "title" out.check.required
  push.edition out 
  push.address.publisher.year "publisher" out.check.required
  new.sentence
  crossref missing$
    { push.series.number out }
    { push.book.crossref out.block }
  if$
  pages set.period.dash.check
  push.pages.book out 
  address empty$
  publisher empty$
  and
    { skip$ }
    { url set.period.dash.check
      push.url out
    }
  if$
  note set.period.dash.check
  note out 
  isbn set.period.dash.check
  push.isbn.issn out
  out.bibitem.end
}

% booklet see below

% conference see below

FUNCTION {inbook}
% required: author/editor, title, chapter/pages, publisher, year
% optional: volume oder number, series, type, address, month, note, url, isbn
{ out.bibitem.start
  author empty$
    { push.editors "author and editor" out.check.required }
    { push.authors out.block }
  if$
  set.colon.after
  push.btitle.vol "title" out.check.required
  push.chapter.pages out
  crossref missing$
    { push.in.ed.booktitle "booktitle" out.check.required
      address empty$
        { part.of.sentence
	  push.address.publisher.year out
	}
	{ push.address.publisher.year "publisher" out.check.required }
      if$
      new.sentence
      series empty$
        { skip$ }
        { push.series.number out }
      if$
      part.of.sentence
      address empty$
      publisher empty$
      and
        { skip$ }
        { url set.period.dash.check
          push.url out
        }
      if$
    }
    { push.crossref out.block   
      url set.period.dash.check
      push.url out
    }
  if$
  note set.period.dash.check
  note out 
  isbn set.period.dash.check
  push.isbn.issn out
  out.bibitem.end
}

FUNCTION {incollection}
% required: author, title, booktitle, publisher, year
% optional: editor, volume oder number, series, type, chapter, 
%           pages, address, edition, month, note, url
{ out.bibitem.start
  push.authors "author" out.check.required
  set.colon.after
  push.title "title" out.check.required
  crossref missing$
    { push.in.ed.booktitle "booktitle" out.check.required
      push.edition out
      push.address.publisher.year "publisher" out.check.required
      new.sentence
      push.series.number out
      part.of.sentence
      push.chapter.pages "pages" out.check.required
      address empty$
      publisher empty$
      and
        { skip$ }
        { url set.period.dash.check
          push.url out
        }
      if$
    }
    { push.incoll.inproc.crossref out.block 
      url set.period.dash.check
      push.url out
    }
  if$
  note set.period.dash.check
  note out 
  isbn set.period.dash.check
  issn set.period.dash.check
  push.isbn.issn out
  out.bibitem.end
}

FUNCTION {inproceedings}
% required: author, title, booktitle, year
% optional: editor, volume oder number, series, pages, address, month, 
%           organization, publisher, note, url
{ out.bibitem.start
  push.authors "author" out.check.required
  set.colon.after
  push.title "title" out.check.required
  crossref missing$
    { push.in.ed.booktitle "booktitle" out.check.required
      address empty$
        { organization new.sentence.check
          push.organization out
          part.of.sentence
          push.address.publisher.year out
        }
        { push.address.publisher.year "publisher" out.check.required }
      if$
      new.sentence
      series empty$
        { skip$ }
        { push.series.number out }
      if$
      part.of.sentence
      push.pages "pages" out.check.required
      address empty$
      publisher empty$
      and
        { skip$ }
        { url set.period.dash.check
          push.url out
        }
      if$
    }
    { push.incoll.inproc.crossref out.block 
      url set.period.dash.check
      push.url out
    }
  if$
  note set.period.dash.check
  note out 
  isbn set.period.dash.check
  issn set.period.dash.check
  push.isbn.issn out
  out.bibitem.end
}

FUNCTION {manual}
% required: title
% optional: author, organization, address, edition, month, year, note, url
{ out.bibitem.start
  author empty$
    { organization empty$
        { title empty$
	    { skip$ }
            { push.btitle "title" out.check.required }
          if$
        }
	{ push.organization out.block
          set.colon.after
          push.btitle "title" out.check.required
	}
      if$
    }
    { push.authors out.block 
      set.colon.after
      push.btitle "title" out.check.required
    }
  if$
  push.edition "edition" out.check.required
  author empty$
    { organization empty$
	{ address out
          part.of.sentence
	}
	{ skip$ }
      if$
    }
    { address ": " * push.organization * out
      part.of.sentence
    }
  if$
  push.date out
  pages set.period.dash.check
  push.pages.book out
  url set.period.dash.check
  push.url out
  note set.period.dash.check
  note out
  out.bibitem.end
}

FUNCTION {mastersthesis}
% required: author, title, school, year
% optional: type, address, month, note, url
{ out.bibitem.start
  push.authors "author" out.check.required
  set.colon.after
  push.btitle "title" out.check.required
  address out
  part.of.sentence 
  school "school" out.check.required
  part.of.sentence
  push.mastersthesis.type out.block
  part.of.sentence
  push.date "year" out.check.required
  pages set.period.dash.check
  push.pages.book out
  url set.period.dash.check
  push.url out
  note set.period.dash.check
  note out
  out.bibitem.end
}

FUNCTION {misc}
% required: 
% optional: author, title, howpublished, month, year, note, url
{ out.bibitem.start
  note empty$
    { title empty$ 
        { skip$ }
        { push.authors.editors out.block
	  set.colon.after
          push.btitle out
          howpublished out
          push.date out 
	  push.crossref out
          url set.period.dash.check
          push.url out
        } 
      if$
    }
    { note #1 #4 substring$ "u" change.case$ "NORM" =
        { note out 
	  part.of.sentence 
          push.date out 
          push.title format.emphasize out
	  push.crossref out
        }
        { author empty$
            { editor empty$
                { organization empty$
                    { skip$ }
                    { push.organization out.block 
                      set.colon.after 
                    }
                  if$
                } 
                { push.editors push.organization * out.block 
                  set.colon.after 
	        }
              if$
            } 
            { push.authors.editors out.block
              set.colon.after 
	    }
          if$
          push.btitle out
	  push.crossref out
          howpublished out
          push.date out 
          new.sentence
          push.misc.series out
          url set.period.dash.check
          push.url out
          note set.period.dash.check
          note out
        }
      if$
    }
  if$
  out.bibitem.end
}

FUNCTION {phdthesis}
% required: author, title, school, year
% optional: type, address, month, note, url
{ out.bibitem.start
  push.authors "author" out.check.required
  set.colon.after
  push.btitle "title" out.check.required
  address out
  part.of.sentence 
  school "school" out.check.required
  part.of.sentence
  push.phdthesis.type out.block
  part.of.sentence
  push.date "year" out.check.required
  pages set.period.dash.check
  push.pages.book out
  url set.period.dash.check
  push.url out
  note set.period.dash.check
  note out
  out.bibitem.end
}

FUNCTION {proceedings}
% required: title, year
% optional: editor, volume oder number, series, address, month, 
%           organization, publisher, note, url
{ out.bibitem.start
  editor empty$
    { push.organization }
    { push.editors
      organization empty$
        { skip$ }
	{ "~; " * push.organization * }
      if$ 
    }
  if$
  out.block
  set.colon.after
  push.btitle "title" out.check.required
  volume empty$
    { skip$ } 
    { push.bd "~" * volume format.emphasize * out.block }
  if$
  push.address.publisher.year "publisher" out.check.required
  push.series.number out
  pages set.period.dash.check
  push.pages.book out
  address empty$
  publisher empty$
  and
    { skip$ }
    { url set.period.dash.check
      push.url out
    }
  if$
  note set.period.dash.check
  note out 
  isbn set.period.dash.check
  issn set.period.dash.check
  push.isbn.issn out
  out.bibitem.end
}

FUNCTION {techreport}
% required: author, title, institution, year
% optional: type, number, address, month, note, url
{ out.bibitem.start
  author empty$
    { push.editors "author and editor" out.check.required }
    { push.authors.editors out.block }
  if$
  set.colon.after
  push.title "title" out.check.required
  institution empty$
     { skip$ }
     { institution new.sentence.check
       "/ " institution * out.block 
     }
  if$
  push.address.publisher.year out
  number new.sentence.check
  push.tr.number "number" out.check.required
  pages set.period.dash.check
  push.pages.book out
  address empty$
  publisher empty$
  and
    { skip$ }
    { url set.period.dash.check
      push.url out
    }
  if$
  note "note" out.check.required
  isbn set.period.dash.check
  issn set.period.dash.check
  push.isbn.issn out
  out.bibitem.end
}

FUNCTION {booklet} 
% required: title
% optional: author, howpublished, address, month, year, note, url
{ misc % so far
}

FUNCTION {conference} 
% required: author, title, note
% optional: month, year, url
{ inproceedings % like stated in BibTeXing by O. Patashnik
}

FUNCTION {masterthesis}
% required: author, title, school, year
% optional: type, address, month, note, url
{ mastersthesis % just because of a typo in former version
}

FUNCTION {unpublished} 
% required: author, title, note
% optional: month, year, url
{ misc % so far
}

FUNCTION {default.type} 
% all other types
{ misc
}


%%------------------------------------------------------------------------------
%% for producing the labels
%%------------------------------------------------------------------------------
FUNCTION {sortify}
% simplify for sorting
{ purify$
  "l" change.case$
}

FUNCTION {chop.word}
% cut a word
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    { s }
  if$
}

FUNCTION {chop.article}
% cut article from a word
{ 't :=
  "A " #2
    "An " #3
      "Der " #4
        "Die " #4
          "Das " #4
            "Ein " #4
              "Eine " #5 
                  "The " #4 t chop.word
               chop.word
             chop.word
           chop.word
         chop.word
       chop.word
    chop.word
  chop.word
}


FUNCTION {format.lab.names}
% format names for the label
{ 's :=
  s #1 "{vv~}{ll}" format.name$
  s num.names$ duplicate$
  #2 >
    { pop$ " " * push.ua * }
    { #2 <
        { skip$ }
        { s #2 "{ll}" format.name$ "others" =
            { " " * push.ua * }
            { " " * push.und * " " * s #2 "{vv~}{ll}" format.name$ * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {author.label}
% label from key or author
{ key empty$
    { author empty$
        { cite$ }
        { author format.lab.names }
      if$
    }	
    { key }
  if$
}

FUNCTION {author.editor.label}
% label from key, author or editor
{ key empty$
    { author empty$
        { editor empty$
	    { cite$ }
	    { editor format.lab.names }
	  if$  
        }
        { author format.lab.names }
      if$
    }
    { key }
  if$
}

FUNCTION {author.organization.label}
% label from key, author or organization
{ key empty$
    { author empty$
        { organization empty$
	    { cite$ }
	    { organization chop.article }
	  if$  
        }
        { author format.lab.names }
      if$
    }
    { key }
  if$
}

FUNCTION {editor.organization.label}
% label from key, editor or organization
{ key empty$
    { editor empty$
	{ organization empty$
	    { cite$ }
	    { organization chop.article }
	  if$
	}
        { editor format.lab.names }
      if$
    }
    { key }
  if$
}

FUNCTION {calc.short.authors}
% make short label (only first author)
{ type$ "book" =
  type$ "inbook" =
  or
    { author.editor.label }
    { type$ "proceedings" =
	{ editor.organization.label }
	{ type$ "manual" =
	    { author.organization.label }
	    { author.label }
	  if$
	}
      if$
    }
  if$
  'short.list :=
}

FUNCTION {calc.label}
% make a full label
{ calc.short.authors
  short.list "(" *
  year push.field.or.null format.dashes * 'label :=
  short.list " " *
  year push.field.or.null format.dashes * 'dinat.label :=  
  label sortify 'sort.label :=
}


%%------------------------------------------------------------------------------
%% sorting
%%------------------------------------------------------------------------------
FUNCTION {sort.format.names}
% format names for sorting
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'namesleft :=
  { namesleft #0 > } % while
     { nameptr #1 =
         { skip$ }
         { "   " * }
       if$
       s nameptr "{ll{ }}{  ff{ }}{ vv{ }}{  jj{ }}" format.name$ 't :=
       namesleft #1 = 
       t "others" = 
       and
	 { "[" * push.ua * "]" * }
         { t sortify * }
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
     }
  while$ % { namesleft #0 > }
}

FUNCTION {sort.format.title}
% format title for sorting (without article)
{ chop.article
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
% author or key for sorting
{ key empty$
    { author empty$
	{ "to sort, need author or key in " cite$ * warning$
	  ""
	}
	{ author sort.format.names }
      if$
    }
    { key sortify }
  if$
}

FUNCTION {author.editor.sort}
% author, editor or key for sorting
{ key empty$
    { author empty$
	{ editor empty$
	    { "to sort, need author, editor, or key in " cite$ * warning$
	      ""
	    }
	    { editor sort.format.names }
	  if$
	}
	{ author sort.format.names }
      if$
    }
    { key sortify }
  if$
}

FUNCTION {author.organization.sort}
% author, organization or key for sorting
{ key empty$
    { author empty$
	{ organization empty$
	    { "to sort, need author, organization, or key in " cite$ * warning$
	      ""
	    }
	    { organization chop.article sortify }
	  if$
	}
	{ author sort.format.names }
      if$
    }
    { key sortify }
  if$
}

FUNCTION {editor.organization.sort}
% editor, organization or key for sorting
{ key empty$
    { editor empty$
	{ organization empty$
	    { "to sort, need editor, organization, or key in " cite$ * warning$
	      ""
	    }
	    { organization chop.article sortify }
	  if$
	}
	{ editor sort.format.names }
      if$
    }
    { key sortify }
  if$
}

FUNCTION {presort}
% first sort 
{ calc.label
  sort.label
  "    " *
  type$ "book" =
  type$ "inbook" =
  or
    { author.editor.sort }
    { type$ "proceedings" =
	{ editor.organization.sort }
	{ type$ "manual" =
	    { author.organization.sort }
	    { author.sort }
	  if$
	}
      if$
    }
  if$
  "    " *
  year push.field.or.null sortify *  
  "    " *
  title push.field.or.null sort.format.title *
  #1 entry.max$ substring$
  'sort.label :=
  sort.label *
  #1 entry.max$ substring$
  'sort.key$ :=
}

STRINGS { last.label next.extra }

INTEGERS { last.extra.num label.count }

FUNCTION {initialize.label}
{ "" 'last.label :=
  #0 'label.count :=
}

FUNCTION {forward.pass}
% find maximum additional character for identical labels
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  label.count #1 + 'label.count :=
}

FUNCTION {reverse.pass}
% add additional characters to identical labels
{ next.extra "b" =
    { "a" 'extra.label := }
    { skip$ }
  if$
  extra.label 'next.extra :=
  extra.label empty$
    { "" }
    { "{\natexlab{" extra.label * "}}" * }
  if$
  'extra.label :=
  label extra.label * 'label :=
  dinat.label extra.label * 'dinat.label :=
}

FUNCTION {bib.sort.order}
{ sort.label 'sort.key$ :=
}


%%------------------------------------------------------------------------------
%% making the bbl. file
%%------------------------------------------------------------------------------
FUNCTION {begin.bib}
% beginning of the file
{ preamble$ empty$
    { skip$ }
    { preamble$ 
      write$ 
      newline$ 
    }
  if$
  "\begin{thebibliography}{" label.count int.to.str$ * "}" *
  write$ 
  newline$
  "% this bibliography was produced with the style dinat.bst v2.5"
  write$ 
  newline$
  "\makeatletter"
  write$ 
  newline$
  "\newcommand{\dinatlabel}[1]%" 
  write$ 
  newline$
  "{\ifNAT@numbers\else\NAT@biblabelnum{#1}\hspace{2\labelsep}\fi}"
  write$ 
  newline$
  "\makeatother"
  write$ 
  newline$
  "\expandafter\ifx\csname natexlab\endcsname\relax\def\natexlab#1{#1}\fi"
  write$ 
  newline$
  "\expandafter\ifx\csname url\endcsname\relax\def\url#1{\texttt{#1}}\fi"
  write$ 
  newline$
}

FUNCTION {end.bib}
% end of the bbl. file
{ newline$
  "\end{thebibliography}" write$ newline$
}


%%------------------------------------------------------------------------------
%% processing the .bib file
%%------------------------------------------------------------------------------
READ

ITERATE {presort}

SORT

EXECUTE {initialize.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

ITERATE {bib.sort.order}

SORT

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

EXECUTE {end.bib}
