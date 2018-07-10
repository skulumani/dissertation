
MAIN=dissertation
TEX = $(wildcard ./tex/*.tex ./tex/appendix/*.tex)
FIGURES = $(wildcare ./figures/* ./tikz/*.tikz)

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(TEX) $(FIGURES)
	latexmk -pdf $(MAIN)

clean:
	latexmk -CA
	rm -f ./build/*.pdf ./build/*.dep ./build/*.log ./build/*.md5 ./build/*.dpth
	rm -f ./*.auxlock ./*.bib ./*.blb
