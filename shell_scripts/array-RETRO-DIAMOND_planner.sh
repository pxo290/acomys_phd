#!/bin/bash -e
#SBATCH -t 00-00:05
#SBATCH -c 1
#SBATCH --mem=640

#This script should be used in combination with array_RETRO-DIAMOND_user_input_raw.sh
#which it gives the direction and max job count to.
#It will need some variable storing though since it moves around the place a bit
#and will be calling the newly created array script itself

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

sed '4,5s/PLACEHOLDER/'$filecount'/' $home_base/RETRO-DIAMOND_run_megan_user_input_directory.sh > $home_base/array_RETRO-DIAMOND_user_input_run.sh
#The complex bit, this should put the value found by the file-counting into the
#array script which remains in the original directory, by making a new script
#which is identical except it has the implanted SBATCH array job number flag set

sbatch $home_base/array_RETRO-DIAMOND_user_input_run.sh
