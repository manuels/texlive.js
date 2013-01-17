% ======================================================================
% scrstrop.inc
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
% This work consists of all files listed in manifest.txt.
% ----------------------------------------------------------------------
% scrstrop.inc
% Copyright (c) Markus Kohm, 2002-2012
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
% Dieses Werk besteht aus den in manifest.txt aufgefuehrten Dateien.
% ======================================================================
%
% This file will be included at end of every KOMA-Script 
% docstrip batch file.
%

% ---------- end of docstrip -----------------------------------------

\ifToplevel{%
  \Msg{************************************************************}
  \Msg{*}
  \Msg{* KOMA-Script}
  \Msg{* a versatile LaTeX2e bundle}
  \Msg{*}
  \ifbeta
    \Msg{* THIS IS A BETA VERSION. YOU SHOULD NOT INSTALL OR USE IT!}
    \Msg{* THERE MAY BE A LOT OF BUGS AT THIS VERSION!}
    \Msg{* PLEASE INSTALL THE RELEASE YOU CAN FIND AT CTAN!}
  \else
    \Msg{* To finish the installation you have to move some}
    \Msg{* files into a directory searched by TeX.}
    \Msg{* See INSTALL.TXT (english) or INSTALLD.TXT (german)}
    \Msg{* for additional information.}
    \Msg{*}
    \ifx\idocfiles\empty\else
      \Msg{* You may also produce the implementation documentation,}
      \Msg{* but you don't need. To produce it, run file(s)}
      \Msg{* \idocfiles}
      \Msg{* through LaTeX after finishing the installation.}
      \Msg{*}
    \fi
    \Msg{* You will find the manual reading `README' (English),}
    \Msg{* or `koma-script.pdf'.}
    \Msg{*}
    \Msg{* Happy TeXing}
  \fi
  \Msg{*}
  \Msg{************************************************************}
}

\endinput

%%% Local Variables:
%%% mode: latex
%%% End:
