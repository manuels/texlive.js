% \iffalse meta-comment
%
% Copyright 1993 1994 1995 1996 1997 1998 1999
% The LaTeX3 Project and any individual authors listed elsewhere
% in this file. 
% 
% This file is part of the Standard LaTeX `MFNFSS Bundle'.
% --------------------------------------------------------
% 
% This file may be distributed under the terms of the LaTeX Project
% Public License, as described in lppl.txt in the base LaTeX distribution.
% Either version 1.0 or, at your option, any later version.
% 
% \fi

README for the `mfnfss' bundle  (December 1995)
=============================

This `bundle' consists of LaTeX2e packages written and supported by
members of the LaTeX3 Project Team.

The documented source code of each package is in a file with extension
`.dtx'.  Running LaTeX on the various files with extension `.ins' will
produce all the package files, and some associated files.

So you should first process, e.g., oldgerm.ins:

  latex oldgerm.ins

The files with extensions `.sty' and `.fd' should then be moved to a
directory on LaTeX's standard input path.

Documentation for the individual packages may then be
obtained by running LaTeX on the `.dtx' files.

For example:

  latex oldgerm.dtx

will produce the file oldgerm.dvi, documenting the oldgerm package.


***NOTE****
Copyright is maintained on each of these packages by the author(s)
of the package. 

Unless otherwise mentioned in the package file, all the packages in
this bundle are released under the restrictions detailed below. 

The file manifest.txt contains a list of the main files in the
distribution together with a short summary of each file.


Reporting Bugs
==============

If you wish to report a problem or bug in any of these packages,
use the latexbug.tex program that comes with the standard LaTeX
distribution.  Please ensure that you enter `3' when prompted with a
menu of categories, so that the message will be automatically
forwarded to the appropriate part of our database.

When reporting bugs, please produce a small test file that shows the
problem, and ensure that you are using the current version of the
package, and of the base LaTeX software.


Distribution of unchanged versions
==================================
  
  Redistribution of unchanged files is allowed provided that this
  readme file is included and all the files for a package are
  distributed together.

  The individual packages may bear additional restrictions on
  modification and distribution which supersede these
  general conditions.

Generation and distribution of changed versions
===============================================

  The generation of changed versions of the files included in these
  packages is allowed under the restrictions listed in the file
  legal.txt in the base LaTeX distribution.  In particular you should: 

  - rename the file before you make any changes to it.  

  - change the error report address so that we do not get sent error
    reports for files *not* maintained by us.


  The distribution of changed versions of the files included in these
  packages is allowed under the restrictions listed in the file
  legal.txt in the base LaTeX distribution.  In particular you should: 

  - also distribute the unmodified version of the file.
