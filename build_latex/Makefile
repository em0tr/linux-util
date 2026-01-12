NAME := main

# Default to pdflatex. Override using LATEXMK_ENGINE_FLAG=-xelatex or other compiler
LATEXMK_ENGINE_FLAG ?= -pdf

.PHONY = all clean disclean

all: clean $(NAME).pdf

$(NAME).pdf: $(NAME).tex $(NAME).bib
	latexmk $(LATEXMK_ENGINE_FLAG) $(NAME)

clean:
	latexmk -C $(NAME)
	rm -f *.aux *.bbl *.blg *-blx.bib *.log *.out *.run.xml *.toc *.bcf *~
	rm -f *.nlo *.ist *.nls *.ilg *.fls *.fdb*

disclean: clean
	rm -rf auto/ _region_*

