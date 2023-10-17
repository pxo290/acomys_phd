#!/bin/bash -eE
#SBATCH -t 02-23:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J cleanse_cultures_Neg_control
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing BBMap for BBDuk
source package cab8386a-c777-4936-8411-a6ed2b5e6a20

#Locking in fixed variables
NEGATIVE_1="PID-0578-r-Neg_S30_R1_001.fastq"
NEGATIVE_2="PID-0578-r-Neg_S30_R2_001.fastq"
NEGATIVE_MATCHING_READ_DIRECTORY="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Negative_control_matching_reads"

#Defining function
cleanse_negative_control_matches () {
  inpf1=$1
  inpf2=$2
  nome=$3
  printf "\nWill pass PE read files:\t$inpf1 and $inpf2 through BBDuk\n"
  printf "\nFirst run\n"
  bbduk.sh in="$inpf1" in2="$inpf2" ref="$NEGATIVE_1" out="TEMP_CLEANSE_1_${nome}_cleansed_R1.fastq" out2="TEMP_CLEANSE_1_${nome}_cleansed_R2.fastq" outm="${nome}_matching_NEG_control_read_file_1_R1.fastq" outm2="${nome}_matching_NEG_control_read_file_1_R2.fastq"
  printf "\nSecond run\n"
  bbduk.sh in="$inpf1" in2="$inpf2" ref="$NEGATIVE_2" out="${nome}_cleansed_R1.fastq" out2="${nome}_cleansed_R2.fastq" outm="${nome}_matching_NEG_control_read_file_2_R1.fastq" outm2="${nome}_matching_NEG_control_read_file_2_R2.fastq"
  rm "TEMP_CLEANSE_1_${nome}_cleansed_R1.fastq"
  rm "TEMP_CLEANSE_1_${nome}_cleansed_R2.fastq"
  mv "${nome}_matching_NEG_control_read_file_1_R1.fastq" "$NEGATIVE_MATCHING_READ_DIRECTORY"
  mv "${nome}_matching_NEG_control_read_file_1_R2.fastq" "$NEGATIVE_MATCHING_READ_DIRECTORY"
  mv "${nome}_matching_NEG_control_read_file_2_R1.fastq" "$NEGATIVE_MATCHING_READ_DIRECTORY"
  mv "${nome}_matching_NEG_control_read_file_2_R2.fastq" "$NEGATIVE_MATCHING_READ_DIRECTORY"
  printf "\nSubmitted files:\t$inpf1 and $inpf2 to BBDuk. Reads which matched the negative control read files have been moved to directory:\t$NEGATIVE_MATCHING_READ_DIRECTORY\n"
}

#Making loop to execute the function
target=$(find -maxdepth 1 -type f -name "*_R1_001.fastq.gz" -not -name "*Neg_S30*")
for f in $target
do
  gzinpf1=$(basename "$f")
  gzinpf2=$(basename "$f" | sed 's/_R1_/_R2_/g')
  gunzip "$gzinpf1"
  gunzip "$gzinpf2"
  INPF1=$(echo "$gzinpf1" | awk -F ".g" '{print $1}')
  INPF2=$(echo "$gzinpf2" | awk -F ".g" '{print $1}')
  NOME=$(basename "$f" | awk -F "-" '{print $4}' | awk -F "_" '{print $1"_"$2}')
  printf "\nWill put files:\t$INPF1 and $INPF2 through the BBDUK function\n"
  cleanse_negative_control_matches "$INPF1" "$INPF2" "$NOME"
  printf "\nLoop will move on from here\n"
done
