#!/bin/bash -e
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source megahit-1.0.2
echo "±±±±±Starting the Megahit assembly of the files."
for f in *_human_cleansed.fa
do
  echo "±±±±±This is what this stage will work on: "$f""
  mkdir -p megahit-outputs
  megahit --6 $f -o $PWD/megahit-outputs/${f%}-megahitted && echo \
  "±±±±±The megahit assembly of $f has been completed." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Megahit has run on '$f' .'
done
echo "±±±±±The sixth step, the megahit assembly of the cleansed reads, has concluded one way or another."
