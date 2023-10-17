#!/bin/bash -e
#SBATCH -t 75-23:59
#SBATCH -c 1
#SBATCH --mem=2gb
#SBATCH -J tax-Journeyman
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --constraint=intel

##This script should do all your processes on the fastq files within a directory
##specified by the user in an array.
##It acts as the planning script which will source the different softwares - apart
##from Diamond, since you use two different versions of it - and run the actual
##array script after counting how many fastq files there are in the user
##specified directory

#These processes are Taxonomic classification, Functional characterisation &
#assembly.
#The tools which will be used are Diamond, Kraken2, Metaphlan2,
#Eggnog-mapperV2, Centrifuge2, Megahit, Metaspades and IDBA-UD

#The breakdown of this process will be:
# 1) Run this script to get the number of fastq files which can be used in all
#    subsequent array scripts
# 2) Run the different taxonomic classification tools using an array script,
#    which will have to call the right version of Diamond to work with MEGAN
#    later (0.9.10)
# 3) Do the functional characterisation using Eggnog-mapperV2, which will need
#    the right version of Diamond sourced for it (0.9.24)
# 4) Do the assembly using whichever(s) of the assemblers works best

#This script should use at most 2GB of memory, 1 core but run for a long time;
#say 75 days to be safe.
#It will also make the directories in which the array outputs will be stored,
#generating the right names for these and then inserting them into the newly
#altered array running scripts

#Starting script
for i in {1..3} ; do echo 'CAUTION!' ; done
echo "WARNING - THIS SCRIPT REQUIRES AND ASSUMES INTERLEAVED FASTQ FILES PRESENT IN THE USER INPUT DIRECTORY"
for i in {1..3} ; do echo 'CAUTION!' ; done
echo "This script is a semi-automated pipeline generator and runner for metagenomic processing of interleaved FASTQ files. It will try and run the following software: FastP, Kraken2, Metaphlan2, Centrifuge2, Diamond (0.9.10)&(0.9.24), MEGAN, Megahit, MetaSpades and IDBA-UD"

home_base=$(pwd) && echo $home_base
#The above is so that it can edit the array script from where it is

destination=$1 && echo $destination
#The above is so that the array script knows where to go when it starts up

export $destination
#The above is to get the 'destination' variable into the array script so it can
#cd into it correctly

cd $1
#Self-evident

echo "Went to directory '$1', will now count the number of fastq files and use this to edit the array script which will run Diamond 0.9.10 on them"
#Making a note of it here, though really would be on the screen

filecount=$(ls *.fastq | wc -l)
#Makes the variable which has the number of fasta files and is used to edit the
#array script

sed '4,5s/PLACEHOLDER/'$filecount'/' $home_base/array_tax_classification-blank.sh > $home_base/array_tax_classification-RUN.sh
#The complex bit, this should put the value found by the file-counting into the
#array script which remains in the original directory, by making a new script
#which is identical except it has the implanted SBATCH array job number flag set

sbatch $home_base/array_tax_classification-RUN.sh
