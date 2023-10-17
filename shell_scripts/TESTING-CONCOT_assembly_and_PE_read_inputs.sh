#!/bin/bash -e
#SBATCH -t 00-16:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Tst_CONCOT
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source /ei/software/staging/CISSUPPORT-11501/stagingloader
