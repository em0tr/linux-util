NAME := main

# Default to pdflatex. Override using LATEXMK_ENGINE_FLAG=-xelatex or other compiler
LATEXMK_ENGINE_FLAG ?= -pdf
LATEXMK_SHELL_ESCAPE ?= -shell-escape
LATEXMK_SILENT ?= -silent

.PHONY = all clean disclean

all: clean $(NAME).pdf

$(NAME).pdf: $(NAME).tex
	latexmk $(LATEXMK_SILENT) $(LATEXMK_ENGINE_FLAG) $(LATEXMK_SHELL_ESCAPE) $(NAME)

clean:
	latexmk -c $(NAME)
	rm -f *.aux *.bbl *.blg *-blx.bib *.log *.out *.run.xml *.toc *.bcf *~
	rm -f *.nlo *.ist *.nls *.ilg *.fls *.fdb* *.pyg
	rm -rf _minted-main/

disclean: clean
	rm -rf auto/ _region_*

