% ======================================================================
% scrstrip.inc
% Copyright (c) Markus Kohm, 2002-2012
%
% This file is part of the LaTeX2e KOMA-Script bundle.
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, version 1.3c of the license.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX 
% version 2005/12/01 or later and of this work.
%
% This work has the LPPL maintenance status "author-maintained".
%
% The Current Maintainer and author of this work is Markus Kohm.
%
% In particular, NO PERMISSION is granted to modify the contents of this
% file since it contains the legal notices that are placed in the files
% it generates.
%
% This work consists of all files listed in manifest.txt.
% ----------------------------------------------------------------------
% scrstrip.inc
% Copyright (c) Markus Kohm, 2002-2012
%
% Diese Datei ist Teil des LaTeX2e-KOMA-Script-Pakets.
%
% Dieses Werk darf nach den Bedingungen der LaTeX Project Public Lizenz,
% Version 1.3c, verteilt und/oder veraendert werden.
% Die neuste Version dieser Lizenz ist
%   http://www.latex-project.org/lppl.txt
% und Version 1.3c ist Teil aller Verteilungen von LaTeX
% Version 2005/12/01 oder spaeter und dieses Werks.
%
% Dieses Werk hat den LPPL-Verwaltungs-Status "author-maintained"
% (allein durch den Autor verwaltet).
%
% Der Aktuelle Verwalter und Autor dieses Werkes ist Markus Kohm.
%
% Als Besonderheit: Es NICHT GESTATTET den Inhalt dieser Datei zu 
% aendern, da sie rechtliche Hinweise enthaelt, die in die erzeugten
% Dateien eingefuegt werden.
% 
% Dieses Werk besteht aus den in manifest.txt aufgefuehrten Dateien.
% ======================================================================
%
% This file will be included at startup of every KOMA-Script 
% docstrip batch file.
%

% ---------- start of docstrip -----------------------------------------

\let\ifbeta=\iffalse

\ifToplevel{\ifx\generate\undefined
    \Msg{************************************************************}
    \Msg{*}
    \Msg{* This installation requires docstrip version 2.3c or}
    \Msg{* later, but an old version of docstrip has been input.}
    \Msg{* You have to update docstrip and maybe LaTeX first!}
    \Msg{*}
    \Msg{************************************************************}
    \errhelp{Install a new version of docstrip.}
    \errmessage{Old docstrip in input path}
    \batchmode
    \csname @@end\endcsname
  \fi
  \Msg{************************************************************}
  \Msg{*}
  \Msg{* KOMA-Script}
  \Msg{* a versatile LaTeX2e bundle}
  \Msg{*}
  \Msg{* This is `\batchfile', a batchfile to unpack some or all}
  \Msg{* parts of KOMA-Script. See `liesmich.txt' (german) or}
  \Msg{* `readme.txt' (english) for additional information.}
  \Msg{*}
  \Msg{* If some - maybe old - files of KOMA-Script are already}
  \Msg{* installed, you will be ask, if it is allowed to overwrite}
  \Msg{* them. Answering `yes' doesn't mean, that `\batchfile'}
  \Msg{* WILL overwrite such files. It means only, that}
  \Msg{* `\batchfile' or installation MAY overwrite them.}
  \Msg{*}
  \Msg{************************************************************}
}

% ---------- some docstrip switchs -------------------------------------

\ifToplevel{%
  \keepsilent
  \askforoverwritefalse
%  \askforoverwritetrue
%  \ifx\askonceonly\undefined\else\askonceonly\fi
}

% ---------- validity --------------------------------------------------
\ifToplevel{%
  \let\manifest\inFile
  \Msg{* Testing validity of KOMA-Script distribution:}
  \def\readloop{%
    \ifeof\manifest\else
      \read\manifest to \manifestfile\relax
      \ifx\manifestfile\empty
      \else
        \openin\inputcheck \manifestfile\relax
        \ifeof\inputcheck
          \@addto\missingfiles{\comma\manifestfile}%
          \def\comma{,^^J\noexpand\spaces}%
        \fi
        \closein\inputcheck
      \fi
      \expandafter\readloop
    \fi
  }%
  \begingroup
    \endlinechar=256
    \let\missingfiles\empty
    \let\comma\empty
    \openin\manifest manifest.txt\relax
    \readloop
    \closein\manifest
    \ifx\missingfiles\empty
      \Msg{* KOMA-Script distribution seams to be valid.}%
    \else
      \edef\cmp{doc/scrguien.pdf\comma doc/scrguien.html\comma
        doc/scrguide.pdf\comma doc/scrguide.html}%
      \ifx\missingfiles\cmp
        \Msg{* KOMA-Script distribution may be valid.}%
        \Msg{* WARNING: Manuals not found but needed for a legal 
          distribution!}%
      \else
        \def\spaces{\space\space\space\space\space}%
        \edef\spaces{* \spaces\spaces\spaces}%
        \Msg{* Missing files: \missingfiles.}%
        \Msg{* This seams not to be a valid KOMA-Script distribution.}%
        \Msg{* You should not try to install this!}%
        \errhelp{You should ask your distributor for a valid and legal
          KOMA-Script distribution.}%
        \errmessage{Validity test of KOMA-Script distribution failed}%
        \batchmode
        \csname @@end\endcsname
      \fi
    \fi
  \endgroup
}

% ---------- defining preambles ----------------------------------------

\preamble

Copyright (c) 1994-2012
Markus Kohm and any individual authors listed elsewhere in this file.

This file was generated from file(s) of the KOMA-Script bundle.
---------------------------------------------------------------

It may be distributed under the conditions of the 
LaTeX Project Public License in the version distributed together
with KOMA-Script, see file `lppl.txt' or `lppl-de.txt'.

This file may only be distributed together with a copy of the
KOMA-Script bundle.  You may however distribute the 
KOMA-Script bundle without all such generated files.  See also
`lppl.txt' or `lppl-de.txt' for additional information.

The list of files belonging to KOMA-Script distribution is given in
the file `manifest.txt'.  See also `lppl.txt' or `lppl-de.txt' for 
additional information.

If this file is a beta version, you may not be allowed to distribute 
it.  Look at the comments below to see if this is the case.

English and German manuals are part of KOMA-Script bundle. 
----------------------------------------------------------

See `README'.

The KOMA-Script bundle (but maybe not this file) was based upon the
LaTeX 2.09 Script family created by Frank Neukam 1993 and the LaTeX2e
standard classes created by The LaTeX3 Project 1994-1996.  You may
find a complete unmodified copy of LaTeX2e at 
<http://www.ctan.org/pub/tex-archive/macros/latex/base/>.

\endpreamble

\endinput

%%% Local Variables:
%%% mode: latex
%%% End:
