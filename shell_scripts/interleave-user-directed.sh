#!/bin/bash -e
#SBATCH -t 00-23:35
#SBATCH -c 1
#SBATCH --mem=96000
#SBATCH -J interleave_fastq
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script goes to the user input directory and then uses two paired end read
#fastq files from the user to interleave them using BBTools reformat.sh
#BBMap - Bushnell B. - https://sourceforge.net/projects/bbmap/

#The most contemporary version of BBMap on the Earlham Institute HPC is sourced
#13/02/20
source package /tgac/software/testing/bin/bbmap-38.06

#Record of when script was run is made
log_time=$(date '+%d/%m/%Y %H:%M:%S')
echo "This script is running at '$log_time'"

#Moves to user selected directory
cd $1

#The two files which are to be interleaved are shown
echo "The two files to be interleaved are '$1' and '$2'"
reformat.sh in1=$1 in2=$2 out=interleaved.fasta
