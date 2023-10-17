#!/bin/bash
#SBATCH -t 0-23:35
#SBATCH -c 6
#SBATCH --mem=256000
#SBATCH -J diamond-db_s
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


source diamond-0.9.24

cd /ei/scratch/osbourne/M5nr/
diamond makedb --in /ei/scratch/osbourne/M5nr/md5nr.fa -d nr
