# ======================================================================
# Makefile
# Copyright (c) Markus Kohm, 2002-2012
#
# This file is part of the LaTeX2e KOMA-Script bundle.
#
# This work may be distributed and/or modified under the conditions of
# the LaTeX Project Public License, version 1.3c of the license.
# The latest version of this license is in
#   http://www.latex-project.org/lppl.txt
# and version 1.3c or later is part of all distributions of LaTeX 
# version 2005/12/01 or later and of this work.
#
# This work has the LPPL maintenance status "author-maintained".
#
# The Current Maintainer and author of this work is Markus Kohm.
#
# This work consists of all files listed in manifest.txt.
# ----------------------------------------------------------------------
# Makefile
# Copyright (c) Markus Kohm, 2002-2012
#
# Dieses Werk darf nach den Bedingungen der LaTeX Project Public Lizenz,
# Version 1.3c, verteilt und/oder veraendert werden.
# Die neuste Version dieser Lizenz ist
#   http://www.latex-project.org/lppl.txt
# und Version 1.3c ist Teil aller Verteilungen von LaTeX
# Version 2005/12/01 oder spaeter und dieses Werks.
#
# Dieses Werk hat den LPPL-Verwaltungs-Status "author-maintained"
# (allein durch den Autor verwaltet).
#
# Der Aktuelle Verwalter und Autor dieses Werkes ist Markus Kohm.
# 
# Dieses Werk besteht aus den in manifest.txt aufgefuehrten Dateien.
# ======================================================================

# ----------------------------------------------------------------------
# Directory with basics
BASEDIR	?= $(PWD)/../../
DOCDIR = $(BASEDIR)doc/
# language
LANGUAGE         = english
LANGUAGESHORTCUT = en
LANGUAGELONG     = english

include $(DOCDIR)Makefile.guide

# ----------------------------------------------------------------------
# NOTE: Remove these rules after real translation of tocbasic.tex 
#       is available.
tocbasic.tex: ../../tocbasic.tex
	if [ -L $@ ] || ! [ -f $@ ]; then $(SYMLINK) $< .; else touch $@; fi

../../tocbasic.tex: ../../tocbasic.dtx
	cd ../.. && tex \\nonstopmode\\input tocbasic.dtx
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# NOTE: Remove these rules after real translation of scrwfile.tex 
#       is available.
scrwfile.tex: ../../scrwfile.tex
	if [ -L $@ ] || ! [ -f $@ ]; then $(SYMLINK) $< .; else touch $@; fi

../../scrwfile.tex: ../../scrwfile.dtx
	cd ../.. && tex \\nonstopmode\\input scrwfile.dtx
# ----------------------------------------------------------------------

#
# end of file `Makefile'
