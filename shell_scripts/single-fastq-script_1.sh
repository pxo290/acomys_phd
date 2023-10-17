#!/bin/bash -e
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source switch-institute ei
source fastp-20190305
for i in $raw_input_fastq_files
do
  echo "±±±±±This is what this stage will work on: "$i""
  fastp -i "$i" -o ${i%}_qceed.fq -h ${i%}_qceed.html -j ${i%}.json && echo "±±±±±FastP has been run on "$i""
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that FastP QC of "$i" has been executed.'
  mkdir -p fastp-outputs
  mv -- *{.html,.json} fastp-outputs/
done
echo "±±±±±The first step, the QC with fastp has concluded one way or another"
