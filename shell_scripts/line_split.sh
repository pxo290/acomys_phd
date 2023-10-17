#!/bin/bash -e
#SBATCH -t 00-02:30
#SBATCH -c 2
#SBATCH --mem=12gb
#SBATCH -J lineSplit
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######NOTES######
#24/03/20
#This script will take a user input file and split it into individual lines,
#each named filename. The files can then be changed to text files.
#The other user input is the directory where the split files are to be sent.

######SCRIPT######
input_file=$1
output_directory=$2

echo "The user input file is '$1' and the output directory where they will be sent is '$2'"

split -d -l 1 $1 $2/filename

mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ LINE SPLIT /-/-/ The file '$1' has been split into files each containing one line from the original file; these can be found in '$2'."
