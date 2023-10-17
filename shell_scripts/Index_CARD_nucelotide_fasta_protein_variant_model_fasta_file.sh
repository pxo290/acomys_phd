#!/bin/bash -eE
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH --mem=64gb
#SBATCH -J Index_CARD_nucelotide_fasta_protein_variant_model_fasta_file
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-08-02
#Quick and dirty little script which will go into the directory provided with $1
#and then make a set of BWA index files with any fasta file within it, getting
#the name for all output from the fasta file itself

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing BWA
source package /tgac/software/testing/bin/bwa-0.7.7

#Printing what we are going to do
printf "Quick and dirty little script which will go into the directory provided\non the command line and then make a set of BWA index files with any fasta file within it,\ngetting the name for all output from the fasta file itself\n"

#Getting the directory from the command line and moving into it
export TARGETDIR=$1
cd "$TARGETDIR"

#Getting our catch all fasta file variable made
export FASTA_FILES=$(find -maxdepth 1 -type f -name "*.fasta")

#Looping through them and making the indexes
for f in $FASTA_FILES
do
  label=$(basename "$f" | rev | cut -c 7- | rev)
  printf "\nIndexing file:\t$f\n"
  printf "\nLabel will be:\t$label\n"
  bwa index -a is -p "$label" "$f"
done
