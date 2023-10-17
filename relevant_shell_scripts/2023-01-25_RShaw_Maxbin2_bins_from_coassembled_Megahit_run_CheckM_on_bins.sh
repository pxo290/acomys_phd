#!/bin/bash -eE
#SBATCH -t 2-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2023-01-25_RShaw_Maxbin2_bins_from_coassembled_Megahit_run_CheckM_on_bins
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-25_RShaw_Maxbin2_bins_from_coassembled_Megahit_run_CheckM_on_bins-%A.out
#SBATCH -e /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-25_RShaw_Maxbin2_bins_from_coassembled_Megahit_run_CheckM_on_bins-%A.err

#Script written by Peter Osborne - post EI studentship
#Written on 2023-01-25

#Script can be found at: /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/scripts/2023-01-25_RShaw_Maxbin2_bins_from_coassembled_Megahit_run_CheckM_on_bins.sh

#Quick script to run CheckM on the bins produced by MaxBin2 from an assembly made by Megahit from coassembling reads provided by R. Shaw after processing.

#This script is written to be run on the NBI HPC

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software
source package 5a1c6a9a-f666-4eaa-9409-3e7435d86406 #CheckM 1.2.0

#Setting fixed variables
inpdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/Maxbin_output/e7199858_b7f4_4319_b735_fae760f50479_HwrGl6_Coassembly_run-MaxBin2"
scratch_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch"

#Writing the CheckM function
execute_checkm_bins () {
    bins_dir="$1"
    mkdir -m 755 -p "${scratch_dir}/CheckM_output"
    export checkm_outdir="${scratch_dir}/CheckM_output"
    printf "Will run CheckM on the bin files in directory:\t$bins_dir\n"
    printf "Output will be written to directory:\t$checkm_outdir\n"
    #Running CheckM, a two stage process - note the -x flag here depends on the bins having the specific extension .fasta
    checkm lineage_wf -t 2 -x fasta "$bins_dir" "$checkm_outdir"
    cd "$checkm_outdir"
    #Next steps
    target_lineage_file=$(find -maxdepth 2 -type f -name "*lineage*.ms")
    #target_lineage_file=$(find -maxdepth 1 -type f -name "*lineage*.ms" -printf '%f\n')
    qa_output_file_dir="$checkm_outdir"
    checkm qa -o 2 -f "${checkm_outdir}/CheckM.tsv" "$target_lineage_file" "$qa_output_file_dir"
    cd "$inpdir"
    cp -r "$checkm_outdir" "$inpdir"
    rm -r "$checkm_outdir"
    printf "Ran CheckM on the bin files in directory:\t$bins_dir\n"
    printf "Output should be written in directory:\t$checkm_outdir\n"
}

#Export the function
export -f execute_checkm_bins

#Going to the input directory
cd "$inpdir"

#Running the function
execute_checkm_bins "$inpdir"