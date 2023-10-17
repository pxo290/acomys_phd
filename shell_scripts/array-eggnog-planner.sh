#!/bin/bash -e
#SBATCH -t 30-20:45
#SBATCH -c 1
#SBATCH --mem=6400

#This script should be used in combination with array_eggnog-mapperV2_all_fasta_files_user_input_directory.sh
#which it gives the direction and max job count to.
#It will need some variable storing though since it moves around the place a bit
#and will be calling the array script itself

#Also adding in this to call the version of diamond it uses in case you had
#sourced another one in the tab where you set the script running\
source package /tgac/software/testing/bin/diamond-0.9.24

home_base=$(pwd) && echo $home_base
#The above is so that it can edit the array script from where it is

destination=$1 && echo $destination
#The above is so that the array script knows where to go when it starts up

export destination
export home_base
#The above is to get the 'destination' variable into the array script so it can
#cd into it correctly

cd $1
#Self-evident

echo "Went to directory '$1', will now count the number of fasta files and use this to edit the array script which will run eggnog-mapperV2 on them"
#Making a note of it here, though really would be on the screen

filecount=$(ls *.fasta | wc -l)
#Makes the variable which has the number of fasta files and is used to edit the
#array script

sed '4,5s/PLACEHOLDER/'$filecount'/' $home_base/OP2-array_eggnog-mapperV2_blank.sh > $home_base/OP2-array_eggnog-mapperV2_run.sh
#The complex bit, this should put the value found by the file-counting into the
#array script which remains in the original directory, by making a new script
#which is identical except it has the implanted SBATCH array job number flag set

sbatch $home_base/OP2-array_eggnog-mapperV2_run.sh
#Hopefully now this will submit the new array script to slurm with all the right
#values and variables in place
