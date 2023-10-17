#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J Dustmasker
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
export INPF1=$1
export UIE=$2
export LABEL=$3
export locale=$(pwd)
source package d6092385-3a81-49d9-b044-8ffb85d0c446 #BLAST+ 2.9.0 which contains Dustmasker
mkdir ${LABEL}_dusted
cd ${LABEL}_dusted
export destination=$(pwd)
cd $locale
run_dustmasker () {
  inpf=$1
  uie=$2
  landing=$3
  printf "\n Will run Dustmasker using default values on fasta file: $inpf \n"
  dustmasker -in "$inpf" -out "${inpf}"_Dustmasked -window 64 -level 20 -linker 1 -infmt fasta -outfmt fasta -parse_seqids
  printf "\n Ran Dustmasker using default values on fasta file: $inpf \n"
  mv "${inpf}"_Dustmasked* $landing
  mail -s "Progress Monitoring 85763000" $uie <<< "Ran Dustmasker using default settings on fasta file: $inpf \n"
}

run_dustmasker $INPF1 $UIE $destination
