#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 3
#SBATCH --mem=800000
#SBATCH -J PL-host_from_contam
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
