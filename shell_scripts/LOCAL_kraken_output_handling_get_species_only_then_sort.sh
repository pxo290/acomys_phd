#!/bin/bash -e

######SCRIPT######
working_file=$1
printf "\nThis will work on the Kraken report output file:\n"$working_file"\n"
awk 'gsub(/ +/," ")' $working_file > TEMP_FILE.txt
tr -s " " < TEMP_FILE.txt > TEMP_FILE1_25.txt
awk '$4=="S"' TEMP_FILE1_25.txt > TEMP_FILE2.txt
awk '$4=="U"' TEMP_FILE1_25.txt >> TEMP_FILE2.txt
sed -i.bak 's/^ *//g' TEMP_FILE2.txt
cut -f 2,6 TEMP_FILE2.txt > TEMP_FILE4.txt
sed -i.bak 's/ /_/g' TEMP_FILE4.txt
awk ' { t = $1; $1 = $2; $2 = t; print; } ' TEMP_FILE4.txt > TEMP_FILE5.txt
sort -k 1b,1 TEMP_FILE5.txt > TEMP_FILE6.txt
sed -i.bak 's/^.\{1\}//' TEMP_FILE6.txt
#sed -i.bak 's/_/ /g' TEMP_FILE6.txt
sed 's/^[ \t]*//' TEMP_FILE6.txt > TEMP_FILE7.txt
sed 's@nclassified@'Unclassified'@' TEMP_FILE7.txt > $working_file-species_only_sorted.txt
rm TEMP_FILE* && set +e && rm *.bak
printf "\nThis worked on the Kraken report output file:\n"$working_file"\n"

######NOTES######
#BIG NOTE! FOR SLURM VERSION, DON'T NEED THE '.bak' ON THE -i IN SED, WAS NEEDED FOR TESTING ON OSX
#THIS SCRIPT IS A LOCAL ONLY VERSION USED IN TESTING AND FOR EXPLANATION LATER
#20/05/20
#Holy shit this took far too long, you really need to get better at planning;
#way too much time spent correcting issues caused by attempts to solve other
#issues. Still, it is now done.
#This script will take a kraken2 report output .tsv and get all the species
#level classifications (along with the unclassified) and the count of reads that
#map to the clade rooted in that taxon. It gets rid of leading spaces in the
#columns, rearranges them so the name comes first and (to make sorting possible)
#replaces the space between the words of the name with underscores
