#!/bin/bash -eE
#SBATCH -t 01-20:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Clustalw
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing clustalw
source package /tgac/software/testing/bin/clustalw-2.1

#Defining some variables
export UIE=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 18)
export lobel=$(date | awk -F " " '{print $6"_"$3"_"$2}')
export LABEL=$(printf "${UIE}_${lobel}-Clustal")
export LOCALE=$(pwd)

#Making the input file for ClustalW
touch "${LABEL}_Clustal_input_file.txt"

#Writing the input file for ClustalW
printf "2\n" >> "${LABEL}_Clustal_input_file.txt"


#Setting ClustalW going with the input file containing all the desired buttons to push
clustalw < "${LABEL}_Clustal_input_file.txt"
