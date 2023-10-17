#!/bin/bash
#SBATCH -t 9-23:35
#SBATCH -c 2
#SBATCH --mem=556000
#SBATCH -J megahit-31_10_2019
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


#Let us try and automate all this

cd $1
echo "You have moved to '$1' to work with Megahit"

#Note that this version of Megahit is not the one you used before
source package /nbi/software/testing/bin/megahit-1.1.3

#This script assumes the naming conventions of your files follows those generated by the QC and cleansing script, so the QC'ed and cleansed fastq files should have the filename <whatever.fastq>_all_cleansed.fastq
pairedend1=$(find "$(pwd -P)" . -maxdepth 1 -type f -name "*R1.fastq_all*") && for f in $pairedend1 ; do echo -e "'$f'\n" ; done && printf "%s" "$pairedend1" > pair_end_reads_1.txt
pairedend2=$(find "$(pwd -P)" . -maxdepth 1 -type f -name "*R2.fastq_all*") && for f in $pairedend2 ; do echo -e "'$f'\n" ; done && printf "%s" "$pairedend2" > pair_end_reads_2.txt


#Remove the unnecessary lines in the text files
## Obviously this grep only works here in this context, you will need to refine it in some way if you don't completely replace bash for this or think of a better way
grep '/ei*' pair_end_reads_1.txt > purged_paired_end_1.txt && sort purged_paired_end_1.txt > sorted_purged_paired_end_1.txt
grep '/ei*' pair_end_reads_2.txt > purged_paired_end_2.txt && sort purged_paired_end_2.txt > sorted_purged_paired_end_2.txt
rm pair_end_reads_1.txt && rm purged_paired_end_1.txt
rm pair_end_reads_2.txt && rm purged_paired_end_2.txt

megahit -1 sorted_purged_paired_end_1.txt -2 sorted_purged_paired_end_2.txt -o cleansed_megahit_output/ --verbose
