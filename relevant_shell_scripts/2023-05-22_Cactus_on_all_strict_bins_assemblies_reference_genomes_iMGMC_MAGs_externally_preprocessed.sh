#!/bin/bash -eE
#Below slurm headers are from R. Shaw's script
#SBATCH -p ei-largemem # partition (queue)
#SBATCH --nodelist=n83032 #this version of cactus should run on this node
#SBATCH -N 1 # number of nodes
#SBATCH -c 64 # number of cores
#SBATCH --mem 1024G # memory pool for all cores
#Your headers now apart from TIME_LIMIT_75 which is also from R. Shaw's script
#SBATCH -J 2023-05-22_Cactus_on_all_strict_bins_assemblies_reference_genomes_iMGMC_MAGs_externally_preprocessed
#SBATCH --mail-type=begin,end,fail,TIME_LIMIT_75
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-22_Cactus_on_all_strict_bins_assemblies_reference_genomes_iMGMC_MAGs_externally_preprocessed-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-22_Cactus_on_all_strict_bins_assemblies_reference_genomes_iMGMC_MAGs_externally_preprocessed-%A.err

#Written on 2023-05-15
#Written by Peter Osborne based on and modified from a script written by Rebecca Shaw
#Written to be run on the NBI HPC

#This script should run Cactus on all fasta files used, all the strict bins, all the good assemblies and all external references/MAGs

#This script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-05-22_Cactus_on_all_strict_bins_assemblies_reference_genomes_iMGMC_MAGs_externally_preprocessed.sh

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/softmasked_and_min_contig_files"
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
cactus --binariesMode local --cleanWorkDir never --noLinkImports --noMoveExports --maxCores 64 --defaultMemory 2G --maxMemory 1024G --defaultDisk 64G --maxDisk 512G "${jobstore_dir}" "${inform_file}" Cactus_aln_everything.hal

#Sourcing Hal
source package c8a0203d-707a-44e8-acdd-2c6ec17f8d7d #Hal 2.2
halStats --tree Cactus_aln_everything.hal > /hpc-home/osbourne/2023-05-22_cactus_on_everything_tree.nwk

halStats --genomes Cactus_aln_everything.hal | tr " " "\n" | sort -V > /hpc-home/osbourne/2023-05-22_cactus_on_everything_list_genomes.txt
