
SRCDIR=babelbib
INSTALLDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/tex/latex/babelbib
DOCDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/doc/latex/babelbib
BSTDIR=`kpsewhich --expand-path='$$TEXMFLOCAL'`/bibtex/bst/babelbib
VERSION=`latex getversion | grep '^VERSION' | sed 's/^VERSION \\(.*\\)\\.\\(.*\\)/\\1_\\2/'`


.SUFFIXES: .sty .ins .dtx .ps .pdf

.ins.sty:
	latex $<

.dtx.pdf:
	pdflatex $<
	pdflatex $<
	makeindex -s gind.ist $(*D)/$(*F)
	makeindex -s gglo.ist -o $(*D)/$(*F).gls $(*D)/$(*F).glo
	pdflatex $<

all: babelbib babelbib.pdf babelbibtest.pdf tugboat-babelbib.pdf

babelbibtest.pdf: babelbibtest.tex babelbibtest.bib babelbib.sty
	pdflatex babelbibtest
	bibtex babelbibtest
	pdflatex babelbibtest
	pdflatex babelbibtest

babelbib: babelbib.sty

tugboat-babelbib.pdf:
	if `test -f "tugboat-babelbib.tex"`; then \
	pdflatex tugboat-babelbib; \
	bibtex tugboat-babelbib; \
	pdflatex tugboat-babelbib; \
	pdflatex tugboat-babelbib; \
	fi


clean:
	@-rm -f *.glo *.gls *.idx *.ilg *.ind *.toc *.log *.aux *.blg *.bbl
	@-rm -f *~

distclean: clean
	@-rm -f babelbib.sty babelbib.pdf babelbib.ps
	@-rm -f babelbibtest.pdf babelbibtest.ps
	@-rm -f *.bdf bab*.bst
	@-rm -f tugboat-babelbib.pdf tugboat-babelbib.bib
	@-rm -rf texmf/

tar:	all clean
	@echo Lege babelbib-$(VERSION).tar.gz an
	-rm -f babelbib-$(VERSION).tar.gz
	tar czCf .. babelbib-$(VERSION).tar.gz \
	  $(SRCDIR)/README \
	  $(SRCDIR)/ChangeLog \
	  $(SRCDIR)/Makefile \
	  $(SRCDIR)/babelbib.dtx \
	  $(SRCDIR)/babelbib.ins \
	  $(SRCDIR)/babelbib.pdf \
	  $(SRCDIR)/babelbibtest.tex \
	  $(SRCDIR)/babelbibtest.bib \
	  $(SRCDIR)/getversion.tex \
	  $(SRCDIR)/tugboat-babelbib.pdf
	rm -f getversion.log


zip:	texlive
	-@rm -f babelbib-$(VERSION).zip
	zip -r babelbib-$(VERSION).zip texmf
	rm -rf texmf
	rm -f getversion.log


texlive:	all tugboat-babelbib.pdf clean
	rm -rf texmf
	mkdir -p texmf/tex/latex/babelbib/
	mkdir -p texmf/doc/latex/babelbib/
	mkdir -p texmf/source/latex/babelbib/
	mkdir -p texmf/bibtex/bst/babelbib/
	cp *.sty *.bdf texmf/tex/latex/babelbib/
	cp babelbib.pdf README ChangeLog babelbibtest.tex texmf/doc/latex/babelbib/
	cp babelbibtest.bib tugboat-babelbib.pdf texmf/doc/latex/babelbib/
	cp babelbib.dtx babelbib.ins texmf/source/latex/babelbib/
	cp Makefile getversion.tex texmf/source/latex/babelbib/
	cp *.bst texmf/bibtex/bst/babelbib/


install: all
	if [ ! -d $(INSTALLDIR) ]; then mkdir -p $(INSTALLDIR); fi
	if [ ! -d $(DOCDIR) ]; then mkdir -p $(DOCDIR); fi
	if [ ! -d $(BSTDIR) ]; then mkdir -p $(BSTDIR); fi
	install -m644 babelbib.sty $(INSTALLDIR)
	install -m644 *.bdf $(INSTALLDIR)
	install -m644 *.bst $(BSTDIR)
	install -m644 babelbib.pdf $(DOCDIR)
	texhash


babelbib.sty: babelbib.ins babelbib.dtx

