NAME := main

# Output name (without .pdf). Defaults to the source name.
JOBNAME ?= $(NAME)

# Default to pdflatex. Override using LATEXMK_ENGINE_FLAG=-lualatex to use LuaLaTeX.
LATEXMK_ENGINE_FLAG ?= -pdf
LATEXMK_SHELL_ESCAPE ?= -shell-escape
LATEXMK_SILENT ?= -silent

.PHONY: all clean distclean

all: clean $(JOBNAME).pdf

$(JOBNAME).pdf: $(NAME).tex
	latexmk $(LATEXMK_SILENT) $(LATEXMK_ENGINE_FLAG) $(LATEXMK_SHELL_ESCAPE) -jobname=$(JOBNAME) $(NAME)

clean:
	latexmk -c -jobname=$(JOBNAME) $(NAME)
	# Clean PDF files from sections/ subdirectory
	rm -rf sections/*.pdf
	# Clean minted caches
	find . -type d -name "_minted-*" -exec rm -rf {} +
	# Clean auxiliary files
	find . -type f \( -name "*.aux" -o -name "*.log" -o -name "*.toc" -o \
	    -name "*.out" -o -name "*.gz" -o -name "*.bbl" -o -name "*.blg" -o -name "*.run.xml" \
	    -o -name "*.bcf" -o -name "*.fls" -o -name "*.fdb*" -o -name "*.pyg" \
	    -o -name "*~" \) -not -path "*/.git/*" -exec rm -f {} +
	rm -rf _minted-main/ auto/ _region_*

disclean: clean
	rm -rf auto/ _region_*

