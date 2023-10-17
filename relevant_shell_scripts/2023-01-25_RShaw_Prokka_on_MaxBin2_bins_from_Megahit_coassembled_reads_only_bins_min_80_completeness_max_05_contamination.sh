#!/bin/bash -eE
#SBATCH -t 2-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2023-01-25_RShaw_Prokka_on_MaxBin2_bins_from_Megahit_coassembled_reads_only_bins_min_80_completeness_max_05_contamination
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-25_RShaw_Prokka_on_MaxBin2_bins_from_Megahit_coassembled_reads_only_bins_min_80_completeness_max_05_contamination-%A.out
#SBATCH -e /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-25_RShaw_Prokka_on_MaxBin2_bins_from_Megahit_coassembled_reads_only_bins_min_80_completeness_max_05_contamination-%A.err

#Script written by Peter Osborne - post EI studentship
#Written on 2023-01-25

#Script can be found at: /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/scripts/2023-01-25_RShaw_Prokka_on_MaxBin2_bins_from_Megahit_coassembled_reads_only_bins_min_80_completeness_max_05_contamination.sh

#Quick script to run Prokka on those bins produced by MaxBin2 from an assembly made by Megahit from coassembling reads provided by R. Shaw after processing
#which had a maximum of 5% contamination and a minimum completeness of 80%.

#This script is written to be run on the NBI HPC

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka 1.14.6

#Setting fixed variables
inpdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/Maxbin_output/e7199858_b7f4_4319_b735_fae760f50479_HwrGl6_Coassembly_run-MaxBin2"
bins_list="${inpdir}/CheckM_bins_over_80_percent_completeness_under_5_percent_contamination.txt"
scratch_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch"

#Making the overall output directory
mkdir -m 755 -p "${inpdir}/Prokka_bins_min_80_completeness_max_05_contamination"
export outdir="${inpdir}/Prokka_bins_min_80_completeness_max_05_contamination"

#Writing the Prokka annotation function
execute_prokka_bins_annotation () {
    input_bin="$1"
    bin_name=$(basename "$input_bin")
    prokka_outdir="$2"
    printf "Will run Prokka on the bin file:\t$input_bin\n"
    printf "Output will be written to directory:\t$prokka_outdir\n"
    prokka --outdir "$prokka_outdir" --force --prefix "$bin_name" --kingdom Bacteria "$input_bin"
    printf "Ran Prokka on the bin file:\t$input_bin\n"
    printf "Output should be written in directory:\t$prokka_outdir\n"
}

#Exporting the function
export -f execute_prokka_bins_annotation

#Going to the input directory
cd "$inpdir"

#Looping through the list of read files and running the function on them
while IFS= read -r line
do
    bin_file=$(echo "$line" | sed 's/$/.fasta/g')
    execute_prokka_bins_annotation "$bin_file" "$outdir"
done < "$bins_list"