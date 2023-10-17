#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 24-23:35
#SBATCH -c 2
#SBATCH --mem=750000
#SBATCH -J go_diamond

cd $1
for f in *.fastq
do
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "-|-|-\\\ DIAMOND UPDATE \\\ Diamond will run on '$f'"
  echo "Running Diamond on '$f'"
  diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $f -a ${f%}-diamond-output.daa
  echo "Diamond ran on '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "-|-|-\\\ DIAMOND UPDATE \\\ Diamond ran on '$f'"
done
