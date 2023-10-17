#!/bin/bash
#SBATCH -t 0-00:27
#SBATCH -c 2
#SBATCH --mem=6000
#SBATCH -J CL_fq2fa
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script works on the assumption that the fastq file is correctly formatted
#So the quality score lines don't start with an @

input_fastq=$1
output_fastq=$2

echo "You are turning the fastq file $1 into the fasta file $2"
sed '/^@/!d;s//>/;N' $1 > $2
