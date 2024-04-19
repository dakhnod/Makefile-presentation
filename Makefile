.PHONY: init clean

init: build/presentation.zip

build:
	mkdir build

build/tree.pdf: tree.tex build/
	pdflatex --output-directory=build tree.tex

build/tree.jpg: build/tree.pdf build/
	magick -density 300 build/tree.pdf build/tree.jpg

build/presentation.pdf: build/tree.jpg Makefile title.txt build/
	magick \
	build/tree.jpg \
	-pointsize 200 \
	-annotate +600+300 @title.txt \
	-strokewidth 10 -stroke black -fill transparent \
	-draw "path 'M 1200,1000 L 1200,2000 L 1400,1800 M 1200,2000 L 1000,1800'" \
	-fill black -stroke transparent -pointsize 50 \
	-annotate +100+2200 @Makefile \
	build/presentation.pdf

build/presentation.zip: Makefile build/presentation.pdf title.txt build/tree.jpg build/tree.pdf tree.tex
	zip build/presentation.zip $^

clean:
	rm -rf build/
