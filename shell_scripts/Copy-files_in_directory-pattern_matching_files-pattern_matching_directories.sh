#!/bin/bash -e
#SBATCH -t 01-12:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Move_files
#SBATCH --mem=164gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export destination=$1
export pattern_hit=$2
export target_pattern=$3

cd /hpc-home/osbourne/TEMP
for d in $pattern_hit*
do
  cd $d
  scp *$target_pattern $destination
  cd ..
done
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Copied all files in directories in which the directory name matched the pattern $pattern_hit* and the files within these matched the pattern *$target_pattern. The files have been copied to $destination"
