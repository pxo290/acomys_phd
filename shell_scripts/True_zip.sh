#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J True_Zip
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export target=$(find -maxdepth 3 -type f -name "*_Subsampled_R1.fastq")
for f in $target
do
  printf "\nFound this unzipped file:\t$f\n"
  gzip -f $f
  printf "\nZipped up this file:\t$f\n"
done
export subject=$(find -maxdepth 3 -type f -name "*_Subsampled_R2.fastq")
for f in $subject
do
  printf "\nFound this unzipped file:\t$f\n"
  gzip -f $f
  printf "\nZipped up this file:\t$f\n"
done
sleep 5m
sbatch TEMP_Copying_PE_subsampled_reads_to_Kaiju_directory.sh
