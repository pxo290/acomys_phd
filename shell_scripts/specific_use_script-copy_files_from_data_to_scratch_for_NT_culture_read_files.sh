#!/bin/bash -e
#SBATCH -t 00-08:30
#SBATCH -p ei-medium
#SBATCH -J Copy_culture_reads
#SBATCH -c 1
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export DESTINATION="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads"
export ORIGIN=$(pwd)

#Written: 2021-04-08
#This script will copy the gzipped fastq files generated from the cultures sent
#for sequencing by Nancy Teng from the data directory over to a nice safe place
#in the scratch for working on without harming the original read files

targets=$(find -maxdepth 2 -type f -name "*.fastq.gz")
for f in $targets
do
  printf "\nWill copy file:\t$f\n"
  printf "\nOutput directory for the copy will be:\t$DESTINATION\n"
  current_file_path=$(readlink -f $f)
  printf "\nThe path to the original file is:\t$current_file_path\n"
  scp $f $DESTINATION
  sleep 30s
  printf "\nCopied file:\t$f\tto directory\t$DESTINATION\tand slept for 30 seconds\n"
done
