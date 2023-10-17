#!/bin/bash -e
#SBATCH -t 72-00:00
#SBATCH -p ei-long
#SBATCH -c 1
#SBATCH -J 2023-04-04_JolyTree_isolate_assemblies_500bp_min_size_contigs
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-04_JolyTree_isolate_assemblies_500bp_min_size_contigs-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-04_JolyTree_isolate_assemblies_500bp_min_size_contigs-%A.err

#Written on 2023-04-04
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Script to run JolyTree on all fasta assembly files for lactic acid bacterial isolates

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-04-04_JolyTree_isolate_assemblies_500bp_min_size_contigs.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  rm -r "$output_dir"
  rm -r "$scratch_dir_1"
  rm -r "$scratch_dir_2"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR
