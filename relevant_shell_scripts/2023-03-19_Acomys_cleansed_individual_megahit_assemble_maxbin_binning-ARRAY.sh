#!/bin/bash -eE
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH --array=1-81%5
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/slurm_outputs/2023-03-21_Acomys_cleansed_individual_megahit_assemble_metabat_binning-ARRAY-%A.out
#SBATCH -e /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/slurm_outputs/2023-03-21_Acomys_cleansed_individual_megahit_assemble_metabat_binning-ARRAY-%A.err

#Written on 2023-03-21
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Array script to use the cleansed but not subsampled Acomys read files, assemble them individually with Megahit and then bin them with MetaBat2.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-03-21_Acomys_cleansed_individual_megahit_assemble_metabat_binning-ARRAY.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export input_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/bbduk_outputs/cleansed_files"
export top_outdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Acomys_cleansed_reads_individual_assemblies_and_bins"
export array_files_list="${input_dir}/2023-03-19_list_paired_readfiles_and_sample_name.tsv"
export top_scratch_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch"
export megahit_docker_image="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/Docker_images/megahit_v1_2_9_docker_image.img" #Megahit v.1.2.9

#Sourcing software
source package 5a1c6a9a-f666-4eaa-9409-3e7435d86406 #CheckM 1.2.0
source package 0a2dffce-c151-4379-abe9-866414c91cd7 #MetaBAT 2.15
source package 222eac79-310f-4d4b-8e1c-0cece4150333 #Minimap2 2.23-41122
source package 758be80b-33cc-495a-9adc-11882ab145b1 #Samtools 1.10

#Writing function to assemble and then bin reads
execute_assemble_and_bin () {
    inpf1="$1"
    inpf2="$2"
    label="$3"
    temp_dir="${top_scratch_dir}/${label}_working_dir"
    mkdir -m 755 -p "$temp_dir"
    assembly_outdir="${top_outdir}/${label}/Megahit_output"
    mkdir -m755 -p "$assembly_outdir"
    #First the assembly with Megahit
    printf "Will assemble read files:\t$inpf1 and $inpf2 with Megahit\nOutput will be written to:\t$assembly_outdir\nOutput will be labelled with:\t$label\nWorking directory will be:\t$temp_dir\n"
    #Explaining flags
    #   --memory    Setting max memory to use as proportion
    #   --num-cpu-threads   Setting max cpu threads to use
    #   --outdir    Output directory
    #   --out-prefix    Output file prefix
    #   --tmp-dir Temporary directory, remember to have a line later deleting this
    #   --k-list    List of kmer sizes, comma separated. Most are taken from https://peerj.com/articles/13084/#materials|methods
    #   -1 & -2 Gives the R1 and R2 files
    singularity exec "$megahit_docker_image" megahit --memory 0.75 --num-cpu-threads 2 --outdir "$assembly_outdir" --out-prefix "${label}.Megahit_output" --tmp-dir "$temp_dir" --k-list 25,43,67,87,101,129,145,255 -1 "$inpf1" -2 "$inpf2"
    printf "Should have assembled read files:\t$inpf1 and $inpf2 with Megahit\nOutput should be written to:\t$assembly_outdir\nOutput should be labelled with:\t$label\nWorking directory was:\t$temp_dir\n"
    #Next up, in order to bin with metabat we need to map the reads used to make the assembly to it.
    #Will use Minimap2 in order to do this - will also use this to only bin with contigs which have at least 1,000bp mapping - following https://peerj.com/articles/13084/#materials|methods again



}

