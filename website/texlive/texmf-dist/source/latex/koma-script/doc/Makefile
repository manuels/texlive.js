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
BASEDIR	?= $(PWD)/../
export BASEDIR

# ----------------------------------------------------------------------
# All directories with Makefiles
SUBDIRS = english ngerman

# ----------------------------------------------------------------------
# Default rules
.PHONY:	default clean default_local install_local \
	uninstall_local clean_local dist_local \
	distclean_local maintainclean_local

# Recursive make function
ifdef SUBDIRS
define make_recursive
	for dir in $(SUBDIRS); \
	do \
	    $(MAKE) -C $$dir $@ || exit $$?; \
	done
endef
else
define make_recursive
endef
endif

default: default_local

clean:	 clean_local

# Load variable definitions
include $(BASEDIR)Makefile.baseinit
include Makefile.latexinit

# Temporary folder, used to create distribution.
# Same folder with postfix "-maintain" will be used to create maintain-
# distribution.
ifdef DISTDIR
export DISTDIR := $(DISTDIR)/doc
endif
ifdef MAINTAINDIR
export MAINTAINDIR := $(MAINTAINDIR)/doc
endif
ifdef INSTALLSRCDIR
export INSTALLSRCDIR := $(INSTALLSRCDIR)/doc
endif

# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# List of all Makefiles
MAKE_FILES	= Makefile Makefile.latexinit Makefile.guide

# ----------------------------------------------------------------------
MISC_SRC	= $(MAKE_FILES)

STATIC_DOC_SRC  = koma-script.html

STATIC_DOC_LINKS= komascript.html komascr.html \
		  scrbook.html scrreprt.html scrartcl.html scrlttr2.html \
		  typearea.html scrpage2.html scraddr.html scrlfile.html \
		  scrwfile.html \
		  scrtime.html scrdate.html tocbasic.html scrbase.html

DOC_SRC		= scrguide.cls scrguide.ist scrguide.gst \
	          guide.tex guide.bib plength.dtx \
		  linkalias.tex

STATIC_DOC      = $(STATIC_DOC_SRC) $(STATIC_DOC_LINKS)

DIST_SRC	= $(MISC_SRC) $(DOC_SRC) $(STATIC_DOC_SRC)

DIST_FILES	= $(DIST_SRC) $(STATIC_DOC_LINKS)

BIN_DIR         = bin

BIN_FILES       = $(BIN_DIR)/genhtmlidx.pl $(BIN_DIR)/genindex.pl

MAINTAIN_FILES	= $(DIST_FILES)
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# local rules
prepare_local: $(STATIC_DOC_LINKS)

default_local: $(STATIC_DOC)
	$(make_recursive)

$(STATIC_DOC_LINKS): $(STATIC_DOC_SRC)
	$(SYMLINK) $< $@

install_local: $(DIST_FILES)
	@if ! $(MKDIR) $(INSTALLSRCDIR) || \
	    ! $(MKDIR) $(INSTALLSRCDIR)/$(BIN_DIR) || \
	    ! $(MKDIR) $(INSTALLDOCDIR) ; then \
	    echo '--------------------------------------------------'; \
	    echo '| Cannot install to' $(INSTALLSRCDIR) or $(INSTALLSRCDIR)/$(BIN_DIR) or $(INSTALLDOCDIR)!; \
	    echo '| You should try:'; \
	    echo '|     sudo "make install"'; \
	    echo '--------------------------------------------------'; \
	    exit 1; \
	fi
	$(INSTALL) $(DIST_SRC) $(INSTALLSRCDIR)
	$(foreach file,$(STATIC_DOC),$(SYMLINK) ../../../../doc/latex/koma-script/$(file) $(INSTALLSRCDIR)/$(file);)
	$(INSTALLEXECUTABLE) $(BIN_FILES) $(INSTALLSRCDIR)/$(BIN_DIR)
	$(INSTALL) $(STATIC_DOC) $(INSTALLDOCDIR)
	$(make_recursive)
	$(SECHO) ------------------------------------------------------------
	$(SECHO) Installed files at $(INSTALLSRCDIR):
	$(SECHO) $(DIST_SRC)
	$(SECHO) ------------------------------------------------------------
	$(SECHO) Installed files at $(INSTALLSRCDIR)/$(BIN_DIR):
	$(SECHO) $(BIN_FILES)
	$(SECHO) ------------------------------------------------------------
	$(SECHO) Installed files at $(INSTALLDOCDIR):
	$(SECHO) $(STATIC_DOC)
	$(SECHO) ------------------------------------------------------------
	$(SECHO) Links at $(INSTALLSRCDIR):
	$(SECHO) $(SATIC_DOC)
	$(SECHO) ------------------------------------------------------------


uninstall_local:
	@if [ -d $(INSTALLSRCDIR) ]; then \
	    $(RM) -v $(foreach file,$(DIST_SRC),$(INSTALLSRCDIR)/$(file)); \
	    if [ ls $(INSTALLSRCDIR) > /dev/null 2>&1; then \
	        $(RMDIR) -v $(INSTALLSRCDIR); \
	    else \
	        echo "$(INSTALLSRCDIR) not empty!"; \
	    fi; \
	else \
	    echo "$(INSTALLSRCDIR) not found --> nothing to uninstall!"; \
	fi
	@if [ -d $(INSTALLDOCDIR) ]; then \
	    $(RM) -v $(foreach file,$(STATIC_DOC),$(INSTALLDOCDIR)/$(file)); \
	else \
	    echo "$(INSTALLDOCDIR) not found --> nothing to uninstall!"; \
	fi
	$(make_recursive)

clean_local:
	$(make_recursive)

dist_local: $(DIST_FILES)
	-$(RMDIR) $(DISTDIR)
	$(MKDIR) $(DISTDIR)
	$(MKDIR) $(DISTDIR)/$(BIN_DIR)
	$(CP) $(DIST_FILES) $(DISTDIR)
	$(CP) $(BIN_FILES) $(DISTDIR)/$(BIN_DIR)
	$(make_recursive)

maintain_local:
	-$(RMDIR) $(MAINTAINDIR)
	$(MKDIR) $(MAINTAINDIR)
	$(MKDIR) $(MAINTAINDIR)/$(BIN_DIR)
	$(CP) $(MAINTAIN_FILES) $(MAINTAINDIR)
	$(CP) $(BIN_FILES) $(MAINTAINDIR)/$(BIN_DIR)
	$(make_recursive)

distclean_local:
	$(make_recursive)

maintainclean_local:
	$(SRM) ChangeLog.svn ChangeLog.bak $(STATIC_DOC_LINKS)
	$(make_recursive)

edit:
	$(EDITOR) guide.tex
