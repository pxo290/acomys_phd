#!/bin/bash -eE
#SBATCH -t 00-08:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J QUASTmeta
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing QUAST, which has MetaQUAST within it
source package /tgac/software/testing/bin/quast-5.0.2
