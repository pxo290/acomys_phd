#!/bin/bash -eE
#SBATCH -t 06-20:30
#SBATCH -p ei-medium
#SBATCH -N 1
#SBATCH -c 12
#SBATCH -J Prog_Cact-Culture_and_MIGA_alignments
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021_06_23
#Seems to need a text file containing the paths to a newick tree of, and then all
#the sequence files

failure_catch() {
  local lineno=$1
  local msg=$2
  rm -r "$WORKDIR" || echo ""
  rm -r "$JOBSTORE" || echo ""
  printf "\nDeleting directories made by failed Cactus job at: $JOBSTORE && $WORKDIR"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing Progressive Cactus
#Original version of Cactus I think: source package d74fad02-7303-47df-a9e7-d6ffd027d766
#source package /tgac/software/testing/bin/progressiveCactus-0.0
source package a00dddb9-29d9-4e2f-9f65-1ac69f1ce3e4

#Setting fixed variables
export UIE=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 18)
export lobel=$(date | awk -F " " '{print $6"_"$3"_"$2}')
export LABEL=$(printf "${UIE}_${lobel}-")
export LOCALE=$(pwd)
cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch
mkdir "${LABEL}Cactus_working_dir"
cd "${LABEL}Cactus_working_dir"
export WORKDIR=$(pwd)
cd "$LOCALE"
export JOBSTORE="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/${LABEL}Progressive_Cactus_jobstore"

#Setting mutable variables
export LIST_FILE=$1

#Executing Progressive Cactus
#runProgressiveCactus.sh --logDebug --logFile="$LOCALE/${LABEL}Progressive_Cactus_log_file.txt" --stats "$LIST_FILE" "$WORKINGDIR"
cactus --batchSystem Slurm --binariesMode local --maxCores 12 --maxMemory 256G --workDir "$WORKDIR" --defaultDisk 5G "$JOBSTORE" "$LIST_FILE" "${LABEL}cactus_run_culture_SPADES_assemblies_nearest_relatives_MIGA_and_representatives.hal"
