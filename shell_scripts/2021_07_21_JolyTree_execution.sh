#!/bin/bash -eE
#SBATCH -t 14-12:30
#SBATCH -p ei-long
#SBATCH -c 1
#SBATCH -J JolyTree_execution_contigs
#SBATCH --mem=12gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-07-06
#Note this differs from the 2021-07-06 version by decreasing the memory request
#from 16GB to 12GB, correcting the number of threads to 1 from 4 with the -t flag,
#by decreasing the proportion of the average genome size used for sketch size
#setting from 0.99 to 0.85, raising the cutoff for correcting evolutionary
#distances from 0.05 to 0.075 and by decreasing the number of steps when
#performing the ratchet-based BME tree search from 500 to 250.

#Hopefully this will be a happy medium between the original working script and
#the 2021-07-06 versions.

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
srun JolyTree_modify_this_version-V3.sh -i "$INPDIR" -s 0.85 -c 0.075 -b "$LABEL" -t 1 -r 250
