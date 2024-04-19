#/bin/bash

mkdir build 

pdflatex --output-directory=build tree.tex

magick -density 300 build/tree.pdf build/tree.jpg

magick \
build/tree.jpg \
-pointsize 200 \
-annotate +600+300 @title.txt \
-strokewidth 10 -stroke black -fill transparent \
-draw "path 'M 1200,1000 L 1200,2000 L 1400,1800 M 1200,2000 L 1000,1800'" \
-fill black -stroke transparent -pointsize 50 \
-annotate +100+2200 @Makefile \
build/presentation.pdf