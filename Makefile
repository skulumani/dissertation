
TEX = $(wildcard ./tex/*.tex ./tex/appendix/*.tex)
FIGURES = $(wildcard ./figures/* ./tikz/*.tikz)

all: dissertation announcement defense

defense: defense.tex $(wildcard ./tex/defense/*.tex)
	latexmk -pdf defense

dissertation: disseration.tex $(TEX) $(FIGURES)
	pdflatex -shell-escape disseration
	make -j4 -f disseration.makefile
	latexmk -pdf -g dissertation

announcement: announcement.tex abstract.tex
	latexmk -gg announcement
	latexmk -gg abstract

tikz: dissertation.makefile $(FIGURES)
	make -j4 -f dissertation.makefile

deep_clean:
	latexmk -C
	rm -f ./build/*.pdf ./build/*.dep ./build/*.log ./build/*.md5 ./build/*.dpth
	rm -f ./*.auxlock ./*.bib ./*.blb

clean:
	latexmk -c
	rm -f ./build/*.dep ./build/*.log ./build/*.md5 ./build/*.dpth
	rm -f ./*.auxlock ./*.bib ./*.blb

