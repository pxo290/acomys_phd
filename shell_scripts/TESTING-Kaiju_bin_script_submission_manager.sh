#!/bin/bash -e
#SBATCH -t 10-00:00
#SBATCH -p ei-long
#SBATCH -c 1
#SBATCH -J Mothra
#SBATCH --mem=2gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export LOCALE=$(pwd)
touch Bins_submitted_to_Kaiju.txt
touch Bins_analysed_by_Kaiju.txt
export SUBJECT=$(find -maxdepth 1 -type f -name "Bin*" -name "*.fa")

for f in $SUBJECT
do
  sbatch TESTING_kaiju.sh $f
  printf "\n$f\n" >> Bins_submitted_to_Kaiju.txt
  sleep 2m
done
