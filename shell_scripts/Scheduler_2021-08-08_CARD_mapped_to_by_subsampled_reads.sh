#!/bin/bash -eE
#SBATCH -t 00-16:50
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Scheduler_2021-08-08_CARD_mapped_to_by_subsampled_reads
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

origin_point=$(pwd)
cd $1
for f in *.gz
do
  gunzip "$f" && printf "\nUnzipped file:\t$f\n"
done
for f in *_Subsampled_R1.fastq
do
  job_name=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
  first_read=$(basename $f)
  second_read=$(echo "$first_read" | sed 's@_R1@_R2@g')
  lobel=$(echo "$second_read" | awk -F "_" '{print $1}' | awk -F "-" '{print $2}')
  label=$(printf "2021_07_27-$lobel")
  sbatch --job-name="$job_name" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-02_BWA_map_subsampled_reads_against_CARD-nucleotide_fasta_protein_variant_model-EXECUTION.sh "$first_read" "$second_read" "$label" && printf "\nSubmitted newer BWA-mem job for file:\t$f\nUsing input files:\t$first_read and $second_read\nWith label:\t$label\n"
done
