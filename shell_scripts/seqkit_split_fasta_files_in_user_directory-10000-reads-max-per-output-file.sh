#!/bin/bash -e
#SBATCH -t 00-05:35
#SBATCH -c 1
#SBATCH --mem=12000
#SBATCH -J seqkit_split
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script goes to the user specified directory and then employs seqkit
#to split the file into indivdiual files each of which contains at most 10,000
#reads

source package /tgac/software/testing/bin/seqkit-0.10.0
cd $1
for f in *.fasta
do
  echo "Splitting file '$f' into files of 10,000 reads at most"
  seqkit split2 $f -s 10000 -f
  echo "Split file '$f' into files of 10,000 reads at most"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ SEQKIT UPDATE /-/-/ In directory '$1' the fasta file '$f' has been broken into fasta files with at most 10,000 reads per output file."
done
