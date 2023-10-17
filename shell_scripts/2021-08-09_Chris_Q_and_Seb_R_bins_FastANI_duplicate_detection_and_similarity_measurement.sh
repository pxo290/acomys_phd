#!/bin/bash -eE
#SBATCH -t 03-12:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Fast_ANI_duplicate_detection
#SBATCH --mem=24gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-08-09
#This version has been modified to run on all the bins from Chris Q and Seb R
#It has also had the error fixed in which each file would be compared to itself
#even though the script was meant to stop this from happening.
#The running time and memory have been increased as well.

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
  outdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/FastANI_all_against_all"
  printf "\nWill run FastANI on input file:\t$query\n"
  fastANI -q "$query" --rl "$ref_list" -o "${label}_Bins_against_all_Bins_FastANI_results.txt"
  mv "${label}_Bins_against_all_Bins_FastANI_results.txt" "$outdir"
  printf "\nRan FastANI on input file:\t$query\n"
}

#Making the loop and getting/making the pieces needed
targets=$(find -maxdepth 1 -type f -name "Bin*.fa")
for f in $targets
do
  inpf=$(basename "$f")
  nome=$(basename "$f" | awk -F ".fa" '{print $1}')
  subjects=$(find -maxdepth 1 -type f -name "Bin*.fa" -not -name "$nome*")
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
