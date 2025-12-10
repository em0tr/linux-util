NAME=main

.PHONY: all

all: clean $(NAME).pdf

$(NAME).pdf: $(NAME).tex $(NAME).bib
	latexmk -pdf $(NAME)

clean:
	latexmk -C $(NAME)
	rm -f *.aux *.bbl *.blg *-blx.bib *.log *.out *.run.xml *.toc *.bcf *~
	rm -f *.nlo *.ist *.nls *.ilg *.fls *.fdb*

disclean: clean
	rm -f $(NAME).pdf
	rm -rf auto/ _region_*

