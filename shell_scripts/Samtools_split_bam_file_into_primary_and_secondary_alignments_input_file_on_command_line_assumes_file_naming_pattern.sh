#!/bin/bash -eE
#SBATCH -t 00-01:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J SplitAlignments
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

record_error_and_rezip() {
  local lineno=$1
  local msg=$2
  printf "\nI encountered an error\n"
  echo "Failed at:$lineno$msg"
}

trap 'record_error_and_rezip ${LINENO} "$BASH_COMMAND"' ERR

export INPF1=$1
export LOBEL=$(echo "$1" | awk -F ".MAPPED.SORTED.bam" '{print $1}')


split_out_alignments () {
  inpf1=$1
  alignment_check=$2
  output_lobel=$3
  if [[ "$alignment_check" == "Primary" ]]
  then
    output_label=$(echo "${output_lobel}_PRIMARY_alignments_only")
    samtools view -F 256 -h "$inpf1" > "${output_label}.bam"
    printf "\nMade file:\t${output_label}.bam which should contain only primary alignments from input file:\t$inpf1\n"
    printf "\nWill now check if the output BAM file exists.\n"
    ls "${output_label}.bam" | grep -q "${output_label}.bam" && printf "\nIt does exist" && exist_check="Y" || printf "\nIt doesn't exist for some reason\n"
    if [[ "$exist_check" == "Y" ]]
    then
      printf "\n${output_label}.bam exists\nNow to check it is a correctly formatted BAM file.\n"
      samtools quickcheck "${output_label}.bam" && printf "\nIt is correctly formatted\n" || printf "\nIt is not correctly formatted.\n"
    else
      printf "\nSomething odd happened which meant it went wrong in an unexpected way\n"
    fi
  elif [[ "$alignment_check" == "Secondary" ]]
  then
    output_label=$(echo "${output_lobel}_SECONDARY_alignments_only")
    samtools view -f 256 -h "$inpf1" > "${output_label}.bam"
    printf "\nMade file:\t${output_label}.bam which should contain only secondary alignments from input file:\t$inpf1\n"
    printf "\nWill now check if the output BAM file exists.\n"
    ls "${output_label}.bam" | grep -q "${output_label}.bam" && printf "\nIt does exist" && exist_check="Y" || printf "\nIt doesn't exist for some reason\n"
    if [[ "$exist_check" == "Y" ]]
    then
      printf "\n${output_label}.bam exists\nNow to check it is a correctly formatted BAM file.\n"
      samtools quickcheck "${output_label}.bam" && printf "\nIt is correctly formatted\n" || printf "\nIt is not correctly formatted.\n"
    else
      printf "\nSomething odd happened which meant it went wrong in an unexpected way\n"
    fi
  else
    printf "\nSomething very strange went on and apparently neither Primary or Secondary were actually given to the function\n"
  fi
}

split_out_alignments "$INPF1" Primary "$LOBEL"
split_out_alignments "$INPF1" Secondary "$LOBEL"
