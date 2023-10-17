#!/bin/bash -eE
#SBATCH -t 00-20:30
#SBATCH -p ei-medium
#SBATCH -n 12
#SBATCH -J Raxml_Cultures_and_references
#SBATCH --mem=15gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-07-05

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing RaxML-NG version 0.9.0
source package 7b014e53-984f-4a0d-8b31-13d189fef2fd

#Setting mutable variable
export INPF=$1
printf "\nWill make and then set the seed value for this run\n"
export SEED_NUM=$(echo $RANDOM)
#Note that bits below assume you are using a phylip file which still has the
#unique run ID from being made by Mauve at the start of the filename
export UIE=$(basename "$INPF" | awk -F "_" '{print $1}')
export lobel=$(date | awk -F " " '{print $6"_"$3"_"$2}')
export LABEL=$(printf "${UIE}_${lobel}")

printf "\nWill run RaxML-NG 0.9.0 using input Phylip file:\t$INPF\n"
raxml-ng --all --msa-format PHYLIP --data-type DNA --msa "$INPF" --tree rand{20} --bs-trees 500 --log INFO --seed "$SEED_NUM" --threads 12
