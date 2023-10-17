#!/bin/bash -eE
#SBATCH -t 00-06:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J 2023-01-15_Prokka_annotation_isolate_assembly_trial
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-01-15_Prokka_annotation_isolate_assembly_trial-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-01-15_Prokka_annotation_isolate_assembly_trial-%A.err

#Written on 2023-01-15
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Trial script to annotate cultured isolate assemblies using Prokka instead of DFAST.

#This script can be found on the hpc at:/hpc-home/osbourne/Post-EI_scripts/2023-01-15_Prokka_annotation_isolate_assembly_trial.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed"
inpf="${inpdir}/13A_S1-contigs.fasta.Contigs_min_length_500bp.fa"
outdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Prokka_outdir"
isolate_ID="13A_S1.SPADES_assembly_min_500bp_contigs"

#Sourcing Prokka
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka 1.14.6

#Going to the input directory
cd "$inpdir"

#Running Prokka
prokka --outdir "$outdir" --force --prefix "$isolate_ID" --kingdom Bacteria "$inpf"
