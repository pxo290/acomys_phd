#!/bin/bash -eE
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Written  2021-04-09
#This script unzips some PE fastq files and then runs them through FastP, saving
#the output as QC'ed versions; it then zips back up the read files again

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Fixed variables
export ORIGIN=$(pwd)
export DESTINATION="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/FastP_output"

#Sourcing FastP
source package /tgac/software/testing/bin/fastp-20190305

#Defining the functions which will be used

prior_rezip () {
  unzipped_files=$(find -maxdepth 1 -type f -name "*.fastq" -not -name "*.gz")
  for f in $unzipped_files
  do
    gzip $f
  done
}

failure_rezip () {
  cd "$ORIGIN" || printf "\nRunning the failure rezip function, we are already in the right directory\n"
  gzip "$uzinpf1"
  gzip "$uzinpf2"
}

run_Fastp () {
  inp1=$1
  inp2=$2
  lab=$3
  destination=$4
  cd "$destination"
  mkdir "${label}_Fastp_output"
  cd "${label}_Fastp_output"
  destiny=$(pwd)
  cd "$ORIGIN"
  printf "\nRunning the FastP function now on input files:\t$inp1\t$inp2\n"
  printf "\nUsing default settings with the addition of the flag to detect adapters for PE reads\n"
  fastp -i $inp1 -I $inp2 -o "${lab}_FastP_R1.fastq" -O "${lab}_FastP_R2.fastq" -V --detect_adapter_for_pe --json "${lab}_FastP.json" --html "${lab}_FastP.html"
  mv "${lab}_FastP_R1.fastq" "$destiny"
  mv "${lab}_FastP_R2.fastq" "$destiny"
  mv "${lab}_FastP.json" "$destiny"
  mv "${lab}_FastP.html" "$destiny"
  printf "\nRan the FastP command, hopefully successfully, on input files:\t$inp1\t$inp2\n"
}

#Making and running the loop
prior_rezip || printf "\nThe files were zipped up correctly, as expected. No need to rezip them again just to immediately unzip them\n"
target=$(find -maxdepth 1 -type f -name "*R1_001.fastq.gz")
for f in $target
do
  export inpf1=$(basename $f) || printf "\nFailed on line 61\n"
  export inpf2=$(echo "$inpf1" | sed 's/_R1_/_R2_/g') || printf "\nFailed on line 62\n"
  export uzinpf1=$(echo "$inpf1" | awk -F ".gz" '{print $1}' | awk 'NF') || printf "\nFailed on line 63\n"
  export uzinpf2=$(echo "$inpf2" | awk -F ".gz" '{print $1}' | awk 'NF') || printf "\nFailed on line 64\n"
  lobel=$(basename "$inpf1" | awk -F "-" '{print $4}' | awk -F "." '{print $1}') || printf "\nFailed on line 65\n"
  export label=$(printf "${lobel}_Fastp") || printf "\nFailed on line 66\n"
  gunzip $inpf1 || printf "\nFailed on line 67\n"
  gunzip $inpf2 || printf "\nFailed on line 68\n"
  run_Fastp $uzinpf1 $uzinpf2 $label $DESTINATION || failure_rezip
  printf "\nRan the Fastp function on input files:\t$inpf1 and $inpf2\n" || printf "\nFailed on line 70\n"
done
