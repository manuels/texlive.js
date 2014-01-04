# $Id: //depot/Master/texmf-dist/doc/pdftex/base/pdftex-pdfkeys/Makefile#1 $

SOURCE		= pdftex-pdfkeys
PDFLATEX	= pdflatex
THUMBPDF	= thumbpdf
BIBTEX  	= bibtex

SRCS	= ${SOURCE}.tex fdl.tex

##########################################################
# Rules

all: ${SOURCE}.pdf

${SOURCE}.bbl: ${SOURCE}.tex
	${PDFLATEX} ${SOURCE}.tex
	${BIBTEX} ${SOURCE}

${SOURCE}.pdf: ${SRCS} ${SOURCE}.bbl
	${PDFLATEX} ${SOURCE}.tex
	${PDFLATEX} ${SOURCE}.tex
	${THUMBPDF} ${SOURCE}.pdf
	${PDFLATEX} ${SOURCE}.tex

clean:
	rm -f *.aux *.blg *.log *.lot *.ilg *.toc *.gls *.glo *.idx *.ind *.brf *.out *.tpt *.inc

realclean: clean
	rm -f *.tex *.drv *.dvi *.pdf
