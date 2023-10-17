#!/bin/bash -e
#SBATCH -t 30-20:45
#SBATCH -c 1
#SBATCH --mem=6400
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######NOTES######
#!!!! RUN THIS SCRIPT FROM YOUR SCRATCH SCRIPTS DIRECTORY !!!!
#27/03/20
#This script is meant to be used when you have directories which contain single
#line FASTA files; so all the bases for a read on a single line not all the
#reads on a single line.
#It will go to the directory and do a couple of things:
# 1. Get the directory name and path to it to store as a variable
# 2. Get the directory name specifically and store it as a separate variable
# 3. Get the number of fasta files in the directory
# 4. Make two directories in the input directory to act as the error and output
#    destination for the array processes
# 5. Make a new version of the array_eggnog-mapperV2_blank-Version_2.sh script
#    which has the max number of jobs replaced with the value in the variable
#    storing the number of fasta files in the directory, has the name of the
#    directory in the script name to distinguish it
# 6. Sbatch submits the newly created script which will run Eggnogg-MapperV2 on
#    the user input directory

#27/03/20 - 17:53
#Script failed during testing with 'sed: -e expression #1, char 21: unknown option to `s''
#Looking online this seems to be because the delimiters you were using in the
#sed, between the different bits of the command, were / which also appear in the
#variable you were looking to insert. So in the two sed's where you are putting
#in the path I have replaced the / with @ which should still work as delimiters
#18:01
#Now having the error: 'sed: -e expression #1, char 158: unterminated `s' command'
#From looking online this seems to be another delimiter error, where this time
#it doesn't see a final delimiter. I think I need to replace the third / in the
#command after the variable being inserted with @ as well.

######SCRIPT######
source package /tgac/software/testing/bin/diamond-0.9.24
home_base=$(pwd) && echo $home_base
destination=$1 && echo $destination
export destination
export home_base
cd $1
trimmed_destination=${PWD##*/}
echo "Went to directory '$1', will now count the number of fasta files and use this to edit the array script which will run eggnog-mapperV2 on them"
filecount=$(ls *.fasta | wc -l)
mkdir -p $destination/Eggnog-mapper_outputs
cd $destination/Eggnog-mapper_outputs
egg_outputs=$(pwd)
cd $1
mkdir -p $destination/Eggnog-mapper_errors
cd $destination/Eggnog-mapper_errors
egg_errors=$(pwd)
cd $destination
sed '4,5s/PLACEHOLDER/'$filecount'/' $home_base/array_eggnog-mapperV2_blank-Version_2.sh > $home_base/${trimmed_destination}_TEMP.sh
sed '8,9s@PLACEHOLDER@'$egg_outputs'@' $home_base/${trimmed_destination}_TEMP.sh > $home_base/${trimmed_destination}_TEMP2.sh
sed '9,10s@PLACEHOLDER@'$egg_errors'@' $home_base/${trimmed_destination}_TEMP2.sh > $home_base/${trimmed_destination}_TEMP3.sh
sed '27,28s@PLACEHOLDER@'$egg_outputs'@' $home_base/${trimmed_destination}_TEMP3.sh > $home_base/${trimmed_destination}_OP2-array_eggnog-mapperV2_run.sh
sbatch $home_base/${trimmed_destination}_OP2-array_eggnog-mapperV2_run.sh
