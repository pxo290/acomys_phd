#!/bin/bash -e
#SBATCH -t 0-00:10
#SBATCH -c 1
#SBATCH --mem=125
#SBATCH -J gff-info
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

cd $1

desireddirectories=$(find . -maxdepth 1 \( -type d -name "*prokka-results*" -not -name "*modified*" \))
for d in $desireddirectories
do
  cd $d
  for f in *.gff
  do
    echo "You are going to get the counts for CDS, rRNA and tRNA from file '$f' in that order"
    echo "The CDS count:" && grep -c 'CDS' $f
    echo "The rRNA count:" && grep -c 'rRNA' $f
    echo "The tRNA count:" && grep -c 'tRNA' $f
    echo "Those were the numbers for '$f', giving the counts of CDS, rRNA and tRNA found by Prokka."
    echo "------------------------------------------------------------"
    awk '/CDS/' $f > ${f%}-CDS-only.gff
      for f in *-CDS-only.gff
      do
        echo "Here are the counts for '$f' CDS breakdown"
        echo "The hypothetical protein count:" && grep -c 'hypothetical protein' $f
        echo "The similar to an AA sequence in the database count:" && grep -c 'similar to AA sequence' $f
        echo "Predicted proteins from protein motif count:" && grep -c 'protein motif' $f
        echo "Those were the numbers of different CDS types for '$f' in the awk'ed file"
        echo "<><><><><><><><><><><><><><><><><><><><><><>"
      done
  done
  cd ..
done
