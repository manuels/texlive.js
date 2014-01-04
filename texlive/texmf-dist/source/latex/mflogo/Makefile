## Makefile for the installation of the `mflogo' package:
##
## 1999-03-10, Ulrik Vieth <vieth@thphy.uni-duesseldorf.de>
##

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

## Usage:
##
## say 'make' or 'make all' to unpack the macros and typeset
## the documentation
##
## say 'make install' to install the macros and documentation
##


### package specifics (don't change!):

# package name, used in directories
FORMAT  = latex
PACKAGE = mflogo

# file names, used in dependencies

SRCFILES = \
	$(PACKAGE).dtx	\
	$(PACKAGE).ins
TEXFILES = \
	ulogo.fd	\
	$(PACKAGE).sty
DOCFILES = \
	$(PACKAGE).dvi


### customizable variables:

# Where the TeX installation resides:
TEXMF   = `kpsewhich --expand-path='$$TEXMFMAIN'`
#TEXMF  = /usr/local/teTeX/share/texmf

# standard directories
SRCDIR  = $(TEXMF)/source/$(FORMAT)/$(PACKAGE)
TEXDIR  = $(TEXMF)/tex/$(FORMAT)/$(PACKAGE)
DOCDIR  = $(TEXMF)/doc/$(FORMAT)/$(PACKAGE)

# How to install the files:
INSTALL = cp -p
#INSTALL = install -c

# How to cleanup the files:
CLEAN   = rm -f

# How to update the directory database:
TEXHASH = mktexlsr
#TEXHASH = texhash

# How to run LaTeX(2e) for docstrip'ing sources:
DOCSTRIP = yes | latex

# How to run LaTeX(2e) for documentation:
LATEX   = latex


### unpack targets:

default: all
all: make-tex make-doc

make-tex: $(TEXFILES)
make-doc: $(DOCFILES)
.PHONY: make-tex make-doc

$(TEXFILES): $(SRCFILES)
	$(DOCSTRIP) $(PACKAGE).ins

$(DOCFILES): $(SRCFILES) $(TEXFILES)
	$(LATEX) $(PACKAGE).dtx


### install targets:

install: install-tex install-doc post-install
.PHONY:	install

install-tex: $(TEXFILES)
	test -d $(TEXDIR) || mkdir $(TEXDIR)
	(for f in $(TEXFILES); \
	  do $(INSTALL) $$f $(TEXDIR); done)
.PHONY:	install-tex

install-doc: $(DOCFILES)
	test -d $(DOCDIR) || mkdir $(DOCDIR)
	(for f in $(DOCFILES); \
	  do $(INSTALL) $$f $(DOCDIR); done)
.PHONY:	install-doc

# uninstall target:

uninstall:
	(for f in $(TEXFILES); \
	  do $(CLEAN) $(TEXDIR)/$$f; done)
	(for f in $(DOCFILES); \
	  do $(CLEAN) $(DOCDIR)/$$f; done)
.PHONY: uninstall


# Update the directory database:
post-install:
	$(TEXHASH)
.PHONY:	post-install


### clean targets:
clean:
	rm -f *.log *.aux *.toc *.lof *.lot *.bbl *.blg
	rm -f *.idx *.ind *.ilg *.glo *.gls

distclean: clean
	rm -f $(TEXFILES) $(DOCFILES)
