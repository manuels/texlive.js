# $Id: Makefile 15704 2009-10-08 22:57:44Z karl $
# Makefile for TeX Live documentation.  Public domain.
doc = texlive-en

all: pdf html

env = TEXINPUTS=../texlive-common:../texlive-en:; export TEXINPUTS;

pdf:
	rm -f *.aux *.toc *.lof *.lot *.xref* *.tmp *.out
	$(env) pdflatex '\nonstopmode\def\Status{1}\input $(doc)'
	$(env) pdflatex '\nonstopmode\def\Status{1}\input $(doc)'
	$(env) pdflatex '\nonstopmode\def\Status{1}\input $(doc)'
	$(env) pdflatex '\nonstopmode\def\Status{1}\input $(doc)'

html:
	rm -f *.aux *.toc *.lof *.lot *.xref* *.tmp *.out *.4tc
# this sequence is equivalent to running "ht latex $(doc)".  We do it
# this way so we can \def\Status for the \ifcase in tex-live.sty.
	$(env) latex '\nonstopmode\def\Status{2}\input $(doc)'
	$(env) latex '\nonstopmode\def\Status{2}\input $(doc)'
	$(env) latex '\nonstopmode\def\Status{2}\input $(doc)'
	$(env) latex '\nonstopmode\def\Status{2}\input $(doc)'
	$(env) tex4ht $(doc)
	$(env) t4ht $(doc)

clean:
	rm -f *.aux *.log *.blg *.toc *.out *.lot tex4ht.ps *.4*
	rm -f *.xref* *.lg *.idv *.out *.otc *.tmp tmp.*
	rm -f $(doc).dvi $(doc).ps

realclean: clean
	rm -f $(doc).pdf
	rm -f *.html *.htm $(doc).css *.gif *.jpg
