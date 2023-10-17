#!/bin/bash -eE
#SBATCH -t 00-08:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J IndexBamTest
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

record_error_and_rezip() {
  local lineno=$1
  local msg=$2
  printf "\nI encountered an error\n"
  rm "${LABEL}.index" || printf "\nNever even started making the output index file\n"
  echo "Failed at:$lineno$msg"
}

trap 'record_error_and_rezip ${LINENO} "$BASH_COMMAND"' ERR


source package /tgac/software/testing/bin/samtools-1.10

export INPF1=$1
export LOBEL=$(echo "$1" | awk -F ".bam" '{print $1}')
export LABEL=$(printf "${LOBEL}_INDEXED")

samtools index -@ 2 $INPF1
