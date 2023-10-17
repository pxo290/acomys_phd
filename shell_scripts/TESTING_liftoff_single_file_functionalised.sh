#!/bin/bash -eE
#SBATCH -t 02-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J LiftOff_Test
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software
source package /tgac/software/testing/bin/liftoff-git_278
#Minimap sourcing might not be necessary so I am going to hash it out now
#source package /tgac/software/testing/bin/minimap2-r974

run_liftoff () {
  printf "\nWill run the Liftoff function\n"
  inpf=$1
  ref_geno=$2
  ref_anno=$3
  lobel1=$(basename "$inpf" | awk -F "_" '{print $1"_"$2}')
  lobel2=$(basename "$ref_geno")
  lobel3=$(basename "$ref_anno")
  lobel4=$(date | awk -F " " '{print $2"_"$3"_"$6}')
  label=$(printf "${lobel1}_Liftoff_output_from_reference_genome_${lobel2}_and_annotation_file_${lobel3}_${lobel4}")
  printf "\nSince there should not be a database file already, you will be making one by giving liftoff the -g flag pointing to the reference genome GFF file\n"
  printf "\nIn the testing I am using the --infer_genes flag, which may not be correct\n"
  liftoff -g "$ref_anno" -o "${label}_liftoff_final_output" -u "${label}_liftoff_unmapped_features_output" -dir "${label}_intermediate_files" -p 2 -infer_genes "$inpf" "$ref_geno"
  printf "\nCompleted Liftoff run on input file:\t$inpf1\nThis was mapped against reference genome:\t$ref_geno\nThe annotation file used was:\t$ref_anno\n"
}

#Getting the overall variables to run through the function
export INPF1=$1
export REF_GENOME=$2
export REF_ANNO=$3

run_liftoff "$INPF1" "$REF_GENOME" "$REF_ANNO"
