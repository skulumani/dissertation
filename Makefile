
TEX = $(wildcard ./tex/*.tex ./tex/appendix/*.tex)
FIGURES = $(wildcard ./figures/* ./tikz/*.tikz)

all: dissertation announcement defense

defense: defense.tex $(wildcard ./tex/defense/*.tex) animation videos
	latexmk -pdf defense

dissertation: dissertation.tex $(TEX) $(FIGURES) 
	pdflatex -shell-escape dissertation
	make -j4 -f dissertation.makefile
	latexmk -pdf dissertation

announcement: announcement.tex abstract.tex
	latexmk -pdf announcement
	latexmk -pdf abstract

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

animation: $(wildcard animation/body/*.png) $(wildcard animation/inertial/*.png)
	wget https://github.com/skulumani/dissertation/releases/download/v1.5.5/animation.tar.gz
	tar xf animation.tar.gz
	rm -f animation.tar.gz

videos: $(wildcard videos/*.mp4)
	wget https://github.com/skulumani/dissertation/releases/download/v1.5.5/videos.tar.gz
	tar xf videos.tar.gz
	rm -f videos.tar.gz
