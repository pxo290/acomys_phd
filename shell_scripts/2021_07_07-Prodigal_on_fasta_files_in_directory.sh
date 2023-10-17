#!/bin/bash -eE
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Prodigal_Cultures
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  rm -r "$WORKINGDIR" || echo ""
  rm -r "$JOBSTORE" || echo ""
  printf "\nDeleting directories made by failed Cactus job at: $JOBSTORE && $WORKDIR"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing Prodigal
source package /tgac/software/testing/bin/prodigal-2.60
