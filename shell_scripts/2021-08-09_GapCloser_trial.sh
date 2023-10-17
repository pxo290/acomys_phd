#!/bin/bash -eE
#SBATCH -t 03-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J GapCloser_trial
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-08-09
#This is a test run, so the values picked for the flags in GapCloser are random


failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing GapCloser
source package /tgac/software/production/bin/gapcloser-1.12

#Running GapCloser
GapCloser -b S121_gapcloser_trial_config_file.txt -a S121_Fastp_SPADES_careful_assembly-scaffolds.fasta.500bp_min_length_contigs_only.fasta -l 150 -p 31 -t 2 -o S121_SPADES_careful_assembly-scaffolds.fasta.500bp_min_length_contigs_only.fasta.GapCloser_output.fa
