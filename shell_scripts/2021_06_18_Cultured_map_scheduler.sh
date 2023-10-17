#!/bin/bash -eE
#SBATCH -t 00-06:55
#SBATCH -p ei-medium
#SBATCH -J Schedule_culture_mapping
#SBATCH -c 1
#SBATCH --mem=1gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*_Subsampled_R1.fastq.gz")
for f in $target
do
  read1=$(basename "$f")
  read2=$(basename "$f" | sed 's/_Subsampled_R1/_Subsampled_R2/g')
  label=$(basename "$f" | awk -F "-" '{print $2}' | awk -F "_" '{print $1}')
  printf "\nWill submit files:\t$read1 and $read2 with label $label\n"
  sbatch 2021_06_18_Cultured_scaffolds_reference_subsampled_BWA_map.sh "$read1" "$read2" "$label"
  sleep 2m
done
