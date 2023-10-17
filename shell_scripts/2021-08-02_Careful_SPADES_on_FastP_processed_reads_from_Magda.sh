#!/bin/bash -eE
#SBATCH -t 02-23:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J SPADES_en_mass
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-08-02
#Just edited it so that the find command will work with the FastP output files
#from Magda's reads since there wasn't a negative control to use for cleansing,
#so the input files for this script didn't have 'cleansed' in their names.

#2021-06-28
#Script will go through all the PE fastq files in the same directory which match
#the find in the TARGET setting and then use it to get the other PE file which
#goes with it, make a directory named after it and indicating it will contain
#the SPADES output. Then it will run SPADES with the careful flag on the two
#input files. After that it should go into the output directory and rename any
#fasta files with the label based on the input files so they aren't just called
#scaffolds.fasta and contigs.fasta. It doesn't rename any more of the files.

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Defining SPADES function
run_SPADES () {
  inpf1=$1
  inpf2=$2
  label=$3
  outdir=$4
  printf "\nWill run SPADES with input files:\t$inpf1 and $inpf2\n"
  printf "\nLabel to be used is:\t$label\n"
  printf "\nOutput directory will be:\t$outdir\n"
  spades.py --careful -t 1 -m 510 -1 "$inpf1" -2 "$inpf2" -o "$outdir"
  cd "$outdir"
  old_named=$(find -maxdepth 1 -type f -name "*.fasta")
  for f in $old_named
  do
    new_name=$(basename "$f" | sed "s/^/${label}-/g")
    mv "$f" "$new_name"
  done
  cd "$LOCALE"
  printf "Used SPADES with the careful flag on input files:\t$inpf1 and $inpf2\n"
}

#Sourcing SPAdes 3.13.1
source package 3a579940-1cba-4d60-86ef-43b8705935fb

#Setting fixed variables
export LOCALE=$(pwd)

#Getting first read files
export TARGETS=$(find -maxdepth 1 -type f -name "*Fastp_FastP_R1.fastq")

#Looping through to get the files and names needed for the function
for f in $TARGETS
do
  INPF1=$(basename "$f")
  INPF2=$(basename "$f" | sed 's/Fastp_FastP_R1/Fastp_FastP_R2/g')
  LABEL=$(basename "$f" | awk -F "_" '{print $1"_"$2}' | sed 's/$/_SPADES_careful_assembly/g')
  mkdir -p "$LABEL"
  cd "$LABEL"
  OUTDIR=$(pwd)
  cd "$LOCALE"
  run_SPADES "$INPF1" "$INPF2" "$LABEL" "$OUTDIR"
done
