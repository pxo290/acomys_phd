#!/bin/bash -e
######SCRIPT######
working_file=$1
printf "\nThis will work on the Centrifuge report output file:\n"$working_file"\n"
awk '/species/' $working_file > TEMP_FILE.txt
sed -i -e '1,1d' TEMP_FILE.txt
cut -f 1,6 TEMP_FILE.txt > TEMP_FILE2.txt
sort -k 1b,1 TEMP_FILE2.txt > $working_file-species_only_sorted.txt
sed -i -e 's/ /_/g' $working_file-species_only_sorted.txt
rm TEMP_FILE.txt && rm TEMP_FILE2.txt
printf "\nYou worked on the Centrifuge report output file:\n"$working_file"\n"
######NOTES######
#BIG NOTE!! FOR SLURM VERSION, DON'T NEED THE '-e' FLAG IN SED. OSX DOES SO WAS NECESSARY FOR TESTING
#THIS SCRIPT IS A LOCAL ONLY VERSION USED IN TESTING AND FOR EXPLANATION LATER
#20/05/20
#A dirty solution to the joining issues, in which it was matching any strings
#in the line including genus names with all the different species including
#ones which aren't actually shared, is to replace all spaces in the file with
#underscores

#19/05/20
#This script does a few things
# 1. This deals with centrifuge report output, so it first gets only lines which
#    have a species level classification, but no lower classification and puts
#    these into a temporary file
# 2. Then it eliminates the headers you don't need
# 3. Then removes all the other columns you don't need, leaving just the species
#    and the unique read count classified to that taxon
# 4. Then it cleans up the temporary files
