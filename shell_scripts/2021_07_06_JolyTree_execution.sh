#!/bin/bash -eE
#SBATCH -t 02-06:30
#SBATCH -p ei-medium
#SBATCH -c 4
#SBATCH -J JolyTree_execution_contigs
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-07-06
#Note this differs from the 2021_06_14 version by increasing the proportion of
#the average genome size used for sketch size setting from 0.75 to 0.99,
#lowering the cutoff for correcting evolutionary distances from the default of
#0.1 to 0.05 and by increasing the number of steps when performing the ratchet-
#based BME tree search from the default of 100 to 500

#It also makes some other changes, removing a redundant and hashed out line of
#code left over from testing, changing to run on the EI medium queue and
#reducing the max run time from 21 days to 6 and a half hours.

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing some packages
source package /tgac/software/testing/bin/mash-2.2
source package /tgac/software/testing/bin/fastme-2.1.5
source package /tgac/software/testing/bin/jdk-9.0.4

#Getting the input directory off the command line
export INPDIR=$1
export UIE=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16)
export LABEL=$(date | awk -F " " '{print $2"_"$3"_"$6}' | sed "s/$/${UIE}_JolyTree_run_Careful_SPADES_assembly_cultures_scaffolds_and_closest_and_representatives/g")
export PATH=$PATH:</hpc-home/osbourne/Jolytree_home/REQ-master/src/REQ.jar

#Running the command
srun JolyTree_modify_this_version-V3.sh -i "$INPDIR" -s 0.99 -c 0.05 -b "$LABEL" -t 4 -r 500
