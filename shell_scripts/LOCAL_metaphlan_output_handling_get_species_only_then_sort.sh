#!/bin/bash -e
######SCRIPT######
working_file=$1
printf "\nYou\nare\nworking\non\nthis\nfile\n"$working_file""
awk '!/t__/ && /s__/' $working_file > TEMP_FILE.txt
sed -n -e 's/.*s__//p' TEMP_FILE.txt > TEMP_FILE2.txt
sort -k 1b,1 TEMP_FILE2.txt > $working_file-species_only_sorted.txt
rm TEMP_FILE.txt && rm TEMP_FILE2.txt
printf "\nYou\nworked\non\nthis\nfile\n"$working_file""

######NOTES######
#19/05/20
#THIS SCRIPT IS A LOCAL ONLY VERSION USED IN TESTING AND FOR EXPLANATION LATER
#This script does a few things
# 1. This deals with metaphlan report output, so it first gets only lines which
#    have a species level classification, but no lower classification (called
#    t__ in Metaphlan output) and puts these into a temporary file
# 2. Then it prints text only after the s__ in the file into a new temporary
#    file - this gets rid of all the preceeding taxonomic groups which are in
#    each line of the metaphlan report
# 3. Then it sorts this temportary file on the contents of the first column, so
#    here the species name, putting these into a file named from the original
#    input file
# 4. Then it cleans up the temporary files
