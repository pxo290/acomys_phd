#!/bin/bash -e
#SBATCH -t 98-20:45
#SBATCH -c 1
#SBATCH -J M4-Plan
#SBATCH --mem=6400
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

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
sed '4,5s/PLACEHOLDER/'$filecount'/' $home_base/Marque3-array_eggnog-mapperV2_blank-Version_2.sh > $home_base/${trimmed_destination}_M3-TEMP1.sh
sed '8,9s@PLACEHOLDER@'$egg_outputs'@' $home_base/${trimmed_destination}_M3-TEMP1.sh > $home_base/${trimmed_destination}_M3-TEMP2.sh
sed '9,10s@PLACEHOLDER@'$egg_errors'@' $home_base/${trimmed_destination}_M3-TEMP2.sh > $home_base/${trimmed_destination}_M3-TEMP3.sh
sed '39,40s@PLACEHOLDER@'$egg_outputs'@' $home_base/${trimmed_destination}_M3-TEMP3.sh > $home_base/${trimmed_destination}_Marque3-OP2-array_eggnog-mapperV2_run.sh
rm $home_base/${trimmed_destination}_M3-TEMP{1,2,3}.sh
sbatch $home_base/${trimmed_destination}_Marque3-OP2-array_eggnog-mapperV2_run.sh
