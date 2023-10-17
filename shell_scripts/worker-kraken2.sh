#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 2
#SBATCH --mem=750000
#SBATCH -J go_krak

cd $1
for f in *.fastq
do
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "-|-|-\\\ KRAKEN2 UPDATE \\\ Kraken2 will run on '$f'"
  echo "Running Kraken2 on '$f'"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 "$f" --classified-out ${f%}_kraken-classified.out --report ${f%}_kraken-report.out > ${f%}_kraken_output.txt \
  echo "Kraken2 analysis of '$f' has been completed."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Kraken2 has run on '$f'.'
done
