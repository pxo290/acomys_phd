#!/bin/bash
#SBATCH -p ei-largemem
#SBATCH -t 3-23:35
#SBATCH -c 2
#SBATCH --mem=650000
#SBATCH -J bowtie2_build
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script will make indexes for the reference genomes which are going to be
#used by bowtie2 when using it for alignment/mapping

#Source up in the attic
source package /nbi/software/production/bin/bowtie2-2.1.0

#Go where we need to for the files
cd

#Make the bowtie2 indexes
