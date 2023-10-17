#!/bin/bash -Ee
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH --array=1-34%15
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-02-21_Prokka_annotation_isolate_assemblies_ARRAY%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-02-21_Prokka_annotation_isolate_assemblies_ARRAY%A.err

#Written on 2023-02-21
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This is an array script which will run Prokka on the 34 isolate assemblies produced using SPADES from Acomys and Apodemus faecal samples,
#after processing to try and ensure that all contigs in the assemblies have a minimum size of 500bp. All assemblies are included except for
#S125 which is too contaminated. This means that ANI similarity filtering is not taken into account and there will be annotated isolates
#which have ANI similarities of over 99.9%

#This script can be found on the hpc at:/hpc-home/osbourne/Post-EI_scripts/2023-02-21_Prokka_annotation_isolate_assemblies_ARRAY.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export assemblies_inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed"
export top_outdir="${assemblies_inpdir}/Prokka_outdir"
export array_files_list="${assemblies_inpdir}/2023-02-21_list_basenames_all_noncontaminated_assemblies.txt"

#Sourcing Prokka
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka 1.14.6

#Defining Prokka function
execute_prokka () {
    assembly_file="$1"
    assembly_name=$(printf "$assembly_file" | awk -F "-" '{print $1}' | sed 's/$/-min_contig_length_500bp/')
    topoutdir="$2"
    mkdir -m 755 -p "${topoutdir}/${assembly_name}-Prokka_output"
    outdir="${topoutdir}/${assembly_name}-Prokka_output"
    printf "Will run Prokka on input file:\t$assembly_file\nOutput will be written to:\t$outdir\n"
    prokka --outdir "$outdir" --force --prefix "$assembly_name" --kingdom Bacteria "$assembly_file"
    printf "Ran Prokka on input file:\t$assembly_file\nOutput should be written in:\t$outdir\n"
}

#Exporting the Prokka function
export -f execute_prokka

#Going to the input directory
cd "$assemblies_inpdir"

#Doing the array stuff
inpf=$(sed -n "$SLURM_ARRAY_TASK_ID"p "$array_files_list")

#Running the function
execute_prokka "$inpf" "$top_outdir"
