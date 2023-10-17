#!/bin/bash -e
#SBATCH -t 04-12:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2022-03-19_DFAST_on_Acomys_isolate_SPADES_assemblies
#SBATCH --mem=72gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Script written by Peter Osborne
#Written on 2022-03-19

#This script will run DFAST on the assemblies produced by SPADES from the processed
#read files from Acomys faecal sample isolate cultures. It presumes that all the
#relevant fasta files are properly processed

#This script is meant to be run on the NBI HPC

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing DFAST
source /ei/software/staging/CISSUPPORT-13773/stagingloader

#Setting fixed variables
overall_input_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies"

#Writing function
execute_dfast () {
  main_inpdir="$1"
  cd "$main_inpdir"
  work_dir=$(pwd)
  sampleID=$(echo "$main_inpdir" | tr -d "/")
  mkdir "${work_dir}/${sampleID}" || rm -r "${work_dir}/${sampleID}" && mkdir -p "${work_dir}/${sampleID}"
  outdir="${work_dir}/${sampleID}"
  input_file=$(find -maxdepth 1 -type f -name "*-contigs.single_line_fasta.fasta" -printf "%f\n")
  path_to_input_file="${work_dir}/${input_file}"
  printf "\nWill be working on this input file:\t$path_to_input_file\n"
  printf "\nWill be sending output files to this directory:\t$outdir\n"
  output_locus_prefix="${sampleID}_locus-"
  dfast -g "$path_to_input_file" -o "$outdir" --use_original_name t --locus_tag_prefix "$output_locus_prefix" --cpu 2 --force || printf "\nI failed the first time trying to analyse file:\t$path_to_file\nWill try sourcing BLAST directly and running it again\n" && source package d6092385-3a81-49d9-b044-8ffb85d0c446 && dfast -g "$path_to_input_file" -o "$outdir" --use_original_name t --locus_tag_prefix "$output_locus_prefix" --cpu 2 --force
  #Now will go to the output directory and rename all the files found there to
  #have the original bin name in their filename - first in the subdirectories
  cd "${outdir}/ddbj"
  for f in *.*
  do
    mv "$f" "${sampleID}_${f%}"
  done
  cd "${outdir}/genbank"
  for f in *.*
  do
    mv "$f" "${sampleID}_${f%}"
  done
  cd "$outdir"
  for f in *.*
  do
    mv "$f" "${sampleID}_${f%}"
  done
  printf "\nProcessed file:\t$path_to_input_file with DFAST\n"
}

#Exporting the function
export -f execute_dfast

#Going to the overall input directory
cd "$overall_input_dir"

#Will loop over all the directories and execute the function on them
for d in */
do
  printf "\nStarting a DFAST run\n"
  target_dir="$d"
  execute_dfast "$target_dir"
  cd "$overall_input_dir"
  printf "\nFinished a DFAST run\n"
done
