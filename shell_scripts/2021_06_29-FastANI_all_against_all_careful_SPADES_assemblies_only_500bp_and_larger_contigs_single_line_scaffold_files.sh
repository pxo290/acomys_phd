#!/bin/bash -eE
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Fast_ANI_duplicate_detection
#SBATCH --mem=12gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-06-29

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing FastANI
source package 7d170f8e-6196-4ce5-81e9-a9800ab05137

#Defining function
run_FastANI () {
  query=$1
  ref_list=$2
  label=$3
  printf "\nWill run FastANI on input file:\t$query\n"
  fastANI -q "$query" --rl "$ref_list" -o "${label}_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only_FastANI_output.txt"
  printf "\nRan FastANI on input file:\t$query\n"
}

#Making the loop and getting/making the pieces needed
targets=$(find -maxdepth 1 -type f -name "*SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fasta")
for f in $targets
do
  inpf=$(basename "$f")
  nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  subjects=$(find -maxdepth 1 -type f -name "*SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fasta" -not -name "$nome")
  for f in $subjects
  do
    ref_file=$(basename "$f")
    printf "$ref_file\n" >> "${nome}_exclusion_list.txt"
  done
  ref_number=$(wc -l "${nome}_exclusion_list.txt")
  printf "\nFile $inpf will be compared to: $ref_number other files\n"
  run_FastANI "$inpf" "${nome}_exclusion_list.txt" "$nome"
  rm "${nome}_exclusion_list.txt"
done
