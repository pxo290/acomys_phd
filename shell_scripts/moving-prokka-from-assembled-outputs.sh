#!/bin/bash -e
#SBATCH -t 0-03:35
#SBATCH -c 4
#SBATCH --mem=64000
#SBATCH -J transfering
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

cd $1

desireddirectories=$(find . -maxdepth 1 \( -type d -name "*prokka-results*" \))
echo "This is what I found "$desireddirectories" when looking"

for d in $desireddirectories
do
  cd $d
  for f in *-prokka-results*
  do
    scp $f /hpc-home/osbourne/TEMP && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that '$f' has been moved from '$d' to your home directory.'
  done
  cd ..
done
