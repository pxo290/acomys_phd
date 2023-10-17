#!/bin/bash -eE
#SBATCH -p ei-medium
#SBATCH -J 2023-05-03_orthofinder_strict_bins_only
#SBATCH -c 6
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-03_orthofinder_strict_bins_only-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-03_orthofinder_strict_bins_only-%A.err

#Written on 2023-05-03
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This script will run Orthofinder on the fasta files containing protein sequences from the annotation of the strict bins by Prokka. The hope then is that this will yield
#orthologs which can be aligned to produce a tree for the thesis instead of waiting for SibeliaZ to finish.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-05-03_orthofinder_strict_bins_only.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-05-03_orthofinder_strict_bins_only.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export bins_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/Prokka_outdir"
export input_dir="${bins_dir}/amino_acid_files"
export script_start_time=$(date)
export top_scratch_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch"
export fastme_docker_image="/hpc-home/osbourne/Docker_images/FastME_v2_1_6_4_docker_image.img"

#Sourcing software
source package fc91613f-1095-4f67-b5aa-b86d702b36da #Orthofinder 2.5.4
source package /tgac/software/testing/bin/fastme-2.1.5 #FastME 2.1.5

#Going to the bins directory
cd "$bins_dir"

#Removing the amino acid file directory if it exists, or printing a message and continuing if it doesn't
rm -r "$input_dir" || printf "$input_dir did not already exist\n"
mkdir -m 755 -p "$input_dir"

#Finding the annotation fasta files
target_files=$(find -maxdepth 2 -type f -name "Bin*.faa")

#Copying them into the input directory
for f in $target_files
do
    cp "$f" "$input_dir"
    printf "Copied file:\t$f\n"
done

#Making a scratch directory for the temporary pickle files to be written to
scratch_dir="${top_scratch_dir}/orthofinder_pickles"
rm -r "$scratch_dir" || printf "$scratch_dir did not already exist\n"
mkdir -m 755 -p "$scratch_dir"

#Running the Orthofinder command
#Explaining the flags used
#   -t Number parallel sequence search threads, setting it to number of threads asked for total
#   -p A directory to write the temporary 'pickle' files to, making one in some spare scratch space
#   -n Name to append to the output directory, just giving it a fairly simple name for now
#   -og Stop after inferring orthogroups, doing this for now since it seems to be failing for a lack of FastME despite having a version sourced and the error message suggests this instead
#   -f Input directory containing the files to be analysed
orthofinder -t 6 -p "$scratch_dir" -n "Orthofinder_output" -og -f "$input_dir"

#Removing the scratch directory if it got made
rm -r "$scratch_dir" || printf "$scratch_dir was not deleted at the end of the script, it might never have been made\n"
