################################################################
# Prolog transaction proposal
# Author:    Jan Wielemaker. jan@swi-prolog.org
################################################################

.SUFFIXES: .tex .dvi .doc .pl

DOCTOTEX=$(HOME)/src/pl-devel/man/doc2tex
LATEX=latex
DOC=quasiquoting
TEX=$(DOC).tex
PDF=$(DOC).pdf
HTML=$(DOC).html
RUNTEX=$(HOME)/src/pl-devel/man/runtex

################################################################
# Documentation
################################################################

all:		$(TEX) pdf

doc:		$(PDF) $(HTML)
pdf:		$(PDF)
html:		$(HTML)

$(HTML):	$(TEX)
		latex2html $(DOC)
		mv html/index.html $@

$(PDF)::
		$(RUNTEX) --pdf $(DOC)

$(TEX):		$(DOCTOTEX)

.doc.tex:
		$(DOCTOTEX) $*.doc > $*.tex
.pl.tex:
		$(PLTOTEX) $*.pl > $*.tex

zip::
		zip $(DOC).zip $(DOC).tex $(DOC).bbl llncs.cls $(DOC).pdf

zipall::
		zip $(DOC).zip $(DOC).tex $(DOC).doc $(DOC).bib $(DOC).bbl llncs.cls $(DOC).pdf Makefile

################################################################
# Clean
################################################################

clean:
		rm -f $(TEX)
		$(RUNTEX) --clean $(DOC)
