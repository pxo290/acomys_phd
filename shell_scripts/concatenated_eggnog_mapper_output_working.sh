#!/bin/bash
#SBATCH -t 00-00:35
#SBATCH -c 2
#SBATCH -J EggMapCC
#SBATCH --mem=1200
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

user_email=$1
export work_file=$(find -maxdepth 1 -type f -name "*_eggnog_concatenated.txt")
UE=$user_email
WF=$work_file
for f in $WF
do
  printf "\n Working on file: $f \n"
  export first_base=$(basename $f)
  export sampleID=${first_base:0:5}
  awk -F "\t" '{print $4,$5,$6,$7,$10,$19,$21,$22}' $f > ${sampleID}_condensed_eggnog_output.txt
  printf "\n Worked on file: $f \n"
  mail -s '' -a ${sampleID}_condensed_eggnog_output.txt $UE <<< "File attached"
done
