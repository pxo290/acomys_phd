#!/bin/bash -e

#This goes through all the .gff files in the current directory and shows any lines which contain 'stress', including where it is in a larger word and irrespective of case
for f in *.gff ; do echo "This is file '$f' and you are looking at it" && awk '/stress/' $f ; done
#This does the same thing but reroutes the output from the screen to the text document it has made, in practice you should have it clearer where the different file outputs are using more symbols in the echo
for f in *.gff ; do echo "This is file '$f' and you are looking at it" && awk '/stress/' $f ; done > stress_awk.txt
