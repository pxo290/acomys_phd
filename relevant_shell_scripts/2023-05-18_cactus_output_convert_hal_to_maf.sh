#!/bin/bash -Ee
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2023-05-18_cactus_output_convert_hal_to_maf
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-18_cactus_output_convert_hal_to_maf-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-18_cactus_output_convert_hal_to_maf-%A.err

#Written on 2023-05-18
#Written by Peter Osborne

#This script will hopefully convert the output of a cactus script to a maf file which can be converted to a fasta file to be used with FastTree.
#Potentially you might be able to conver the maf to a fasta file on the hpc using a script associated with mugsy

#Written to be run on the NBI HPC
#Script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-05-18_cactus_output_convert_hal_to_maf.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/softmasked_files"
export inpf="${inpdir}/Cactus_aln_isolates_and_bins.hal"

#Sourcing software
source package c8a0203d-707a-44e8-acdd-2c6ec17f8d7d #Hal 2.2
source package /tgac/software/testing/bin/fasttree-2.1.11 #FastTree 2.1.11
mugsy_docker_image="/hpc-home/osbourne/Docker_images/mugsy_aligner_v1r2_3_docker_image.img" #Mugsy docker image for Mugsy 1r.2.3

#Going to input directory
cd "$inpdir"

#Making a maf file from the hal file
hal2maf "$inpf" strict_bins_and_isolates_with_cactus_ancestors.maf

#Trying to convert the maf to a fasta
singularity exec "$mugsy_docker_image" maf2fasta.pl < strict_bins_and_isolates_with_cactus_ancestors.maf > strict_bins_and_isolates_with_cactus_ancestors.fasta

#Trying to make a tree from a hopefully produced fasta file
FastTree -gtr -nt strict_bins_and_isolates_with_cactus_ancestors.fasta > strict_bins_and_isolates_with_cactus_ancestors.fasta.FastTree_newick.nwk


