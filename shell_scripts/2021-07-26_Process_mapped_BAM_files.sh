#!/bin/bash -eE
#SBATCH -t 00-16:50
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-07-26
#Just a quick little script which gets input from a scheduling script and will
#process BAM files to end up with samtools idxstats files for each one in the
#directory.

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

export INPF=$1
export LABEL=$2

samtools view -@ 2 -b -F 2304 "$INPF" >> "${LABEL}-Only_primary.bam"
samtools sort -@ 2 -l 0 -m 4G -O BAM "${LABEL}-Only_primary.bam" >> "${LABEL}-Only_primary-Sorted.bam"
samtools index -@ 2 -b "${LABEL}-Only_primary-Sorted.bam"
samtools idxstats "${LABEL}-Only_primary-Sorted.bam" >> "${LABEL}-Only_primary-Sorted-IDXStats.txt"
