#!/bin/bash -e
#SBATCH -t 1-23:35
#SBATCH -c 2
#SBATCH --mem=600gb
#SBATCH -J dmnd_make
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

cd $1
source diamond-0.9.10
for f in *.gz
do
  gunzip $f
done
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ DIAMOND UPDATE /-/-/ Making amino acid database in '$1'"
diamond makedb --in /ei/scratch/osbourne/RETRO-DIAMOND/nr -d nr
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ DIAMOND UPDATE /-/-/ Made amino acid database in '$1'"
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ DIAMOND UPDATE /-/-/ Making nucleotide database in '$1'"
diamond makedb --in /ei/scratch/osbourne/RETRO-DIAMOND/nt -d nt
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ DIAMOND UPDATE /-/-/ Made nucleotide database in '$1'"
