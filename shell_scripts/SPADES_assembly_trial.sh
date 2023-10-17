#!/bin/bash -eE
#SBATCH -t 02-23:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J SPADES_trial
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing SPAdes 3.13.1
source package 3a579940-1cba-4d60-86ef-43b8705935fb

#Setting fixed variables
export LOCALE="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Cleansed_reads"

#Setting mutable variables
export INPF1=$1
export INPF2=$2
export NOME=$3
mkdir "${NOME}_SPAdes_output"
cd "${NOME}_SPAdes_output"
export DESTINATION=$(pwd)
cd "$LOCALE"

#Command executed below
spades.py -1 "$INPF1" -2 "$INPF2" -o "$DESTINATION"
