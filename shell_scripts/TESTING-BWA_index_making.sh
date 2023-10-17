#!/bin/bash -e
#SBATCH -t 00-08:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J BWA-Index
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#18/02/21
#Script should go through all fasta files in target directory and produce BWA
#index files from them which it puts in destination directory
#It will concatenate all the fasta files, and use this to make the index

#Sourcing software
source package /tgac/software/testing/bin/bwa-0.7.7
#Samtools might not actually be relevant, putting the source command here for now and hashing it out
#source package /tgac/software/testing/bin/samtools-1.9

#Defining constant variables
export DESTINATION='/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/BWA-testing'
export FILESUFFIX='fasta'

#Defining changeable variables
export LOCALE=$(pwd) && printf "\nLocale is:\t$LOCALE\n"
export INPDIR=$1 && printf "\nINPDIR is:\t$INPDIR\n"
export NOTE=$(date | awk -F " " '{print $1,$2,$3,$6}' | sed 's/ /_/g') && printf "\nNOTE is:\t$NOTE\n"
export LABEL=$(echo "${NOTE}_BWA_INDEX_CONCATENATED_FASTA_FILES") && printf "\nLABEL is:\t$LABEL\n"

#Defining function
make_index_from_concatenated_files () {
  label=$1
  outdir=$2
  inpdir=$pwd
  printf "\nWill make a concatenated file from input fasta files in directory:\t$inpdir\n"
  cat *.fa >> ${label}.fa
  mv ${label}.fa $outdir
  cd $outdir
  bwa index -a bwtsw -p $label ${label}.fa
  printf "\nProduced BWA index from concatenated FASTA files originating from index:\t$inpdir\n"
}

#Executing script
cd $INPDIR
make_index_from_concatenated_files $LABEL $DESTINATION
