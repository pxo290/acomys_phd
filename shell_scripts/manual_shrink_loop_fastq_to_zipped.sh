#!/bin/bash -e
#SBATCH -t 01-24:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Shrink
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

moment=$(date | sed 's/ /_/g' | awk -F "_" '{print $1,$2,$3,$6}' | sed 's/ /_/g')
touch ${moment}_file_shrinking_log.txt
target=$(find -maxdepth 3 -type f -name "*.fastq")
for f in $target
do
  printf "\nA file being shrunk through gzipping is:\t$f\n"
  printf "\nA file being shrunk through gzipping is:\t$f\n" >> ${moment}_file_shrinking_log.txt
  gzip $f
  printf "\nA file shrunk through gzipping was:\t$f\n"
  printf "\nA file shrunk through gzipping was:\t$f\n" >> ${moment}_file_shrinking_log.txt
done
