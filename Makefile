
MAIN=dissertation
TEX := $(shell find tex/*.tex tex/appendix/*.tex ./*.sty -type -f)
FIGURES := $(shell find figures/* tikz/* -type -f)

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(TEX) $(FIGURES)
	latexmk -pdf $(MAIN)

clean:
	latexmk -CA 
	rm -f ./build/*.pdf ./build/*.dep ./build/*.log ./build/*.md5 ./build/*.dpth
	rm -f ./*.auxlock ./*.bib ./*.blb
