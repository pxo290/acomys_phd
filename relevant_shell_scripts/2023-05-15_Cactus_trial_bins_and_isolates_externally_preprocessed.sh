#!/bin/bash -eE
#Below slurm headers are from R. Shaw's script
#SBATCH -p ei-largemem # partition (queue)
#SBATCH --nodelist=n83032 #this version of cactus should run on this node
#SBATCH -N 1 # number of nodes
#SBATCH -c 64 # number of cores
#SBATCH --mem 1024G # memory pool for all cores
#Your headers now apart from TIME_LIMIT_75 which is also from R. Shaw's script
#SBATCH -J 2023-05-15_Cactus_trial_bins_and_isolates_externally_preprocessed
#SBATCH --mail-type=begin,end,fail,TIME_LIMIT_75
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-15_V2_Cactus_trial_bins_and_isolates_externally_preprocessed-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-15_V2_Cactus_trial_bins_and_isolates_externally_preprocessed-%A.err

#Written on 2023-05-15
#Written by Peter Osborne based on and modified from a script written by Rebecca Shaw
#Written to be run on the NBI HPC

#This script should run Cactus on 34 lactic acid bacterial assemblies and 348 strict bin fasta files

#This script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-05-15_V2_Cactus_trial_bins_and_isolates_externally_preprocessed.sh

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  mail -s 'Error trap cactus email attempt' -a /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-15_V2_Cactus_trial_bins_and_isolates_externally_preprocessed-%A.err peter.osborne@earlham.ac.uk <<< "Maybe there will be a file attached"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/softmasked_files"
inform_file="${inpdir}/Cactus_info_file_bins_and_assemblies.txt"
scratch_directory="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch/cactus"
working_dir="${scratch_directory}/cactus"

#Sourcing cactus
source package afc1a9d3-4ba8-4261-b4b3-e0153b069bf1 #Cactus 2.2.0

#Making the jobstore directory variable
jobstore_dir="${working_dir}/Cactus_jobstore_dir"
rm -r "$jobstore_dir" || printf "Jobstore not already present\n"

#Going to input directory
cd "$inpdir"

#Running Cactus
cactus --binariesMode local --cleanWorkDir never --noLinkImports --noMoveExports --maxCores 64 --defaultMemory 2G --maxMemory 1024G --defaultDisk 64G --maxDisk 512G "${jobstore_dir}" "${inform_file}" Cactus_aln_isolates_and_bins.hal

#Attempt 2 - note that the above jobstore rm has been hashed and the flags:
#   --restart and --retryCount 3 have been added
#cactus --restart --retryCount 3 --binariesMode local --cleanWorkDir never --noLinkImports --noMoveExports --maxCores 64 --defaultMemory 2G --maxMemory 1024G --defaultDisk 64G --maxDisk 512G "${jobstore_dir}" "${inform_file}" Cactus_aln_isolates_and_bins.hal
