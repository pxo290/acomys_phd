#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 0-20:01
#SBATCH -c 8
#SBATCH --mem=556000
#SBATCH -J CD-Hit
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
