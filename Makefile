
MAIN=dissertation
TEX = $(wildcard ./tex/*.tex ./tex/appendix/*.tex)
FIGURES = $(wildcare ./figures/* ./tikz/*.tikz)

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(TEX) $(FIGURES)
	latexmk -pdf $(MAIN)

tikz: $(MAIN).makefile $(FIGURES)
	make -j4 -f $(MAIN).makefile

clean:
	latexmk -C
	rm -f ./build/*.pdf ./build/*.dep ./build/*.log ./build/*.md5 ./build/*.dpth
	rm -f ./*.auxlock ./*.bib ./*.blb
