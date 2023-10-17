#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 4
#SBATCH -J Culture_mapping_counts_adjust
#SBATCH --mem=4gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script will loop through samtools idxstats files in the same directory and
#produce new versions named after the same sampleID. The new files will have the
#mapped read segment count scores adjusted for both size of the scaffolds in KBs
#and the library size of the reads. Since the subsampled reads will be either
#the pilot or Novogene sequencing runs the library size will be 4.5 or 8.5 only.
#The script assumes all files are named a certain way for the find functions to
#work and that the directory contains a file listing the pilot run sampleIDs and
#a file which has the name and size of each scaffold in kb.

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Set fixed variables
export LOCALE=$(pwd)
export LIST_FILE="2021_06_19_kilobase_adjusted_scaffold_sizes.txt"
export PILOT_LIST="Pilot_SampleID_list.txt"

#Defining the function
adjust_counts () {
  inpf=$1
  lib_size=$2
  sampleID=$3
  touch "${sampleID}_kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv"
  printf "Scaffolds\t$sampleID\n" > "${sampleID}_kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv"
  while read -r line
  do
    scaffold_name=$(echo "$line" | awk -F "\t" '{print $1}')
    scaffold_size=$(echo "$line" | awk -F "\t" '{print $2}')
    original_score=$(grep "$scaffold_name" "$inpf" | awk -F "\t" '{print $3}')
    kilobase_adjusted_score=$(echo "$original_score / $scaffold_size" | bc -l | awk '{printf "%f", $0}')
    library_adjusted_score=$(echo "$kilobase_adjusted_score / $lib_size" | bc -l | awk '{printf "%f", $0}')
    printf "$scaffold_name\t$library_adjusted_score\n" >> "${sampleID}_kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv"
  done < "$LIST_FILE"
  sleep 1m
}

#Getting the Samtools IDXstats files
target_files=$(find -maxdepth 1 -type f -name "*BWA_against_culture_SPADES_scaffolds_Mapped.Matefixed.Sorted.Only_primary_alignments.IDXstats.txt")

#Running the script
for f in $target_files
do
  printf "\nWill process file:\t$f\n"
  SAMPLEID=$(basename "$f" | awk -F "_" '{print $1}')
  sampleID_check=$(basename "$f" | awk -F "_" '{print $1}' | sed 's/.$//g')
  grep -q "$sampleID_check" "$PILOT_LIST" && lib_check="Y" || lib_check="N"
  if [[ "$lib_check" == "Y" ]]
  then
    printf "\nFile is a pilot sample\n"
    adjust_counts "$f" 4.5 "$SAMPLEID"
  elif [[ "$lib_check" == "N" ]]
  then
    printf "\nFile is not a pilot sample\n"
    adjust_counts "$f" 8.5 "$SAMPLEID"
  else
    printf "\nSomething went wrong when trying to process file:\t$f\n"
  fi
done
