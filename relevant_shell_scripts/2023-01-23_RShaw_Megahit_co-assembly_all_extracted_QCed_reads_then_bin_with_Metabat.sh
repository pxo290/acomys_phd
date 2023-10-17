#!/bin/bash -eE
#SBATCH -t 2-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2023-01-23_RShaw_Megahit_co-assembly_all_extracted_QCed_reads_then_bin_with_Metabat
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-23_RShaw_Megahit_co-assembly_all_extracted_QCed_reads_then_bin_with_Metabat-%A.out
#SBATCH -e /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-23_RShaw_Megahit_co-assembly_all_extracted_QCed_reads_then_bin_with_Metabat-%A.err

#Script written by Peter Osborne - post EI studentship
#Written on 2023-01-23

#Script can be found at: /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/scripts/2023-01-23_RShaw_Megahit_co-assembly_all_extracted_QCed_reads_then_bin_with_Metabat.sh

#In light of the poor quality bins obtained by assembling the reads from each sample individually using SPADES and then
#binning them with Metabat2 this script will instead co-assemble all reads obtained from the samples provided by R. Shaw
#which have passed the FastP QC and been left over after using BBDUK to remove matches to a number of eukaryotic genomes.
#The co-assembly will be carried out using Megahit.

#This script is written to be run on the NBI HPC

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software
export megahit_docker_image="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/Docker_images/megahit_v1_2_9_docker_image.img" #Megahit v.1.2.9
source package 5a1c6a9a-f666-4eaa-9409-3e7435d86406 #CheckM 1.2.0
source package 0a2dffce-c151-4379-abe9-866414c91cd7 #MetaBAT 2.15
source package 222eac79-310f-4d4b-8e1c-0cece4150333 #Minimap2 2.23-41122
source package /tgac/software/testing/bin/samtools-1.10 #Samtools 1.10

#Setting other fixed variables
export inpdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/RShaw_cleansed_reads_all_samples"
export top_outdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting"
export scratch_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch"
export run_ID=$(( uuidgen ; head /dev/urandom | tr -dc A-Za-z0-9 | head -c 6 ) | tr "\n" "_" | tr "-" "_" | sed 's/$/_Coassembly_run/g')

#Important to note is that megahit requires the paired end read files as two comma separated lists, one after each of the two input file
#flags. Therefore it will be necessary to have the input files in variables which are just their names(or paths) separated by commas
#and in the same order for the R1 and R2 across the two variables.

#Will not set a minimum contig size for Megahit to output, will instead remove contigs below 500bp after assembly prior to mapping. Or remove them after binning.

#Defining the co-assembly function
execute_coassembly_megahit () {
    input_R1s="$1"
    input_R2s="$2"
    upper_output_dir="$3"
    mkdir -m 755 -p "${upper_output_dir}/${run_ID}-MEGAHIT_outputs"
    output_dir="${upper_output_dir}/${run_ID}-MEGAHIT_outputs"
    printf "Will use the following R1 reads with Megahit coassembly:\n$input_R1s\n"
    printf "Will use the following R2 reads with Megahit coassembly:\n$input_R2s\n"
    #Note will try using one of the preset parameters, meta-sensitive after the flag --presets
    singularity exec "$megahit_docker_image" megahit --memory 0.95 --num-cpu-threads 2 --out-dir "$output_dir/Megahit" --out-prefix "${run_ID}.Megahit_output" --tmp-dir "$scratch_dir" --presets meta-sensitive -1 "$input_R1s" -2 "$input_R2s"
    printf "Ran Megahit co-assembly. Output fasta files should be in $output_dir\nOutput files should have the prefix:\t${run_ID}.Megahit_output\n"
}

#Exporting the function
export -f execute_coassembly_megahit

#Going to the input file directory
cd "$inpdir"

#Finding all the read one files and putting them into a comma separated list within a variable
export read_1_files=$(find -maxdepth 1 -type f -name "*.QCed.Cleansed.R1.fastq" -not -name "*PRJEB48359*" -printf '%f,' | sort -V | sed 's/,$//g')
export read_2_files=$(find -maxdepth 1 -type f -name "*.QCed.Cleansed.R1.fastq" -not -name "*PRJEB48359*" -printf '%f,' | sort -V | sed 's/Cleansed.R1.fastq/Cleansed.R2.fastq/g' | sed 's/,$//g')

#Running the Megahit coassembly function
execute_coassembly_megahit "$read_1_files" "$read_2_files" "$top_outdir"