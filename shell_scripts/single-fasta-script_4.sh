#!/bin/bash -e
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source kraken2-2.0.7
echo "±±±±±Starting the Kraken2 run on the files."
export human_cleansed_files
echo "±±±±±Kraken2 will run on these files: "$human_cleansed_files""
for i in $human_cleansed_files
do
  echo "±±±±±This is what this stage will work on: $i"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 6 "$i" --classified-out ${i%}_kraken-classified.out --report ${i%}_kraken-report.out \
  && echo "±±±±±Kraken2 analysis of '$i' has been completed." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Kraken2 has run on '$i'.'
  mkdir -p kraken2-output
  kraken2output=$(find . -maxdepth 1 \( -type f -name "*.out" \))
done
for f in $kraken2output
do
  cat $f > ${f%}_text.txt
done
mv *.txt kraken2-output
echo "±±±±±The fourth step, the Kraken2 taxonomic analysis has concluded one way or another."
