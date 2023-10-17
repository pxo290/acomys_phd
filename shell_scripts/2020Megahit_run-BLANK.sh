#!/bin/bash -e
#SBATCH -t 07-23:55
#SBATCH -c 2
#SBATCH --mem=225gb
#SBATCH --array=1-PLACEHOLDER%12
#SBATCH -p ei-long
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o PLACEHOLDER/eggnog-mapper_%A_%a.out
#SBATCH -o PLACEHOLDER/eggnog-mapper_%A_%a.err
#SBATCH --profile=all
#SBATCH --nice=250

######NOTES######

######SCRIPT######
