#!/bin/bash -e
#SBATCH -t 00-00:15
#SBATCH -c 1
#SBATCH -J MH-Plan
#SBATCH --mem=1280
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --profile=all

######NOTES######
#20/04/20
#This is a more contemporary script which will set up the array script to run
#Megahit on a bunch of fasta files within a directory.
#It will work the same way as the eggnog-mapper planner script in getting the
#number of fasta files in the directory and their names, then populating the
#run script based off the blank version; which will remain unchanged. This
#planning script is meant to be a lot more resource efficient than the older
#eggnog-mapper ones since it runs for much less time and uses less memory.
#It will source megahit and define then export the necessary variables for the
#planner script, which it will then call.
#In part this script was made since you didn't have a megahit script which was
#for interleaved files, nor one which could handle direct input of fasta files
#or used relative paths.
#Interestingly, the version of Megahit used in your older scripts, megahit-1.1.3
#is no longer on the cluster for some reason. Instead this script will use
#megahit-1.1.1_dw though if this proves a 'bad' version I will download and set
#up the latest version for myself on the HPC and use it in this script instead.
#Note that megahit needs a text file as input which contains a comma separated
#list of the input files

######SCRIPT######
source package /tgac/software/testing/bin/megahit-1.1.1_dw
export home_base=$(pwd)
printf "The directory in which all the associated scripts for this process either are, or will be made, is: $home_base"
export destination=$1
echo $destination
printf
cd $1
export trimmed_destination=${PWD##*/}
echo "Went to directory '$1', will now count the number of fasta files and use this to edit the array script which will run eggnog-mapperV2 on them"
filecount=$(ls *.fasta | wc -l)
export subject_files=$(find . -maxdepth 1 -type f -name "*.fasta" -not -name "*.fastq" -not -name "*.daa")
printf "The files which will be worked on are as follows:"
printf "\n$subject_files"
mkdir -p megahit_output
cd $1/megahit_output
export megahitted=$(pwd)
printf "The output directory for the megahit processes is: $megahitted"
cd $1
sed '4,5s/PLACEHOLDER/'$filecount'/' $home_base/2020Megahit_run-BLANK.sh > $home_base/${trimmed_destination}_Megahit-TEMP1.sh
sed '8,9s@PLACEHOLDER@'$megahitted'@' $home_base/${trimmed_destination}_Megahit-TEMP1.sh > $home_base/${trimmed_destination}_Megahit-TEMP2.sh
sed '9,10s@PLACEHOLDER@'$megahitted'@' $home_base/${trimmed_destination}_Megahit-TEMP2.sh > $home_base/${trimmed_destination}_Megahit-TEMP3.sh
