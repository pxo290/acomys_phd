#!/bin/bash -e
#SBATCH -t 00-20:45
#SBATCH -c 1
#SBATCH -J MetEuk
#SBATCH -p ei-medium
#SBATCH --mem=6000
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######NOTES######
#01/05/20
#This script is just testing to see how/if MetaEuk can work on the cluster

######SCRIPT######
cd /ei/scratch/osbourne/MetaEuk
export PATH=$(pwd)/metaeuk/bin/:$PATH
mkdir -p testing_results
metaeuk easy-predict /ei/scratch/osbourne/interleaved-pilot-fastqs/subsampled-fastqs/TEMP-fastqs/AC16J-BBMap-interleaved.fastq_qceed.fastq-reformat-subsampled-75pc-5000000-bases/Megahit-output/AC16J-BBMap-interleaved.fastq_qceed.fastq-reformat-subsampled-75pc-5000000-bases-Megahit_assembled.fasta /ei/scratch/osbourne/MetaEuk/Lactobacillus_helveticus_strain_LZ-R-5_complete_genome-Translated.faa predsResultProteins.fas testing_results/
