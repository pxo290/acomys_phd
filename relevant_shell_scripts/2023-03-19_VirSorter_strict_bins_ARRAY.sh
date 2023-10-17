#!/bin/bash -eE
#SBATCH -t 00-18:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH --array=1-348%10
#SBATCH --mem=24gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/slurm_outputs/2023-03-19_VirSorter_strict_bins_ARRAY-%A.out
#SBATCH -e /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/slurm_outputs/2023-03-19_VirSorter_strict_bins_ARRAY-%A.err

#Written on 2023-03-19
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Array script to detect viral genomes from 348 strict bins produced by Chris Q and Seb R.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-03-19_VirSorter_strict_bins_ARRAY.sh

#Note that if you downloaded the reference database and uncompressed it yourself it will be missing the file <where you put the database>/checkv-db-v1.5/genome_db/checkv_reps.dmnd
#You make this using Diamond with the command: diamond makedb --in checkv_reps.faa --db checkv_reps after sourcing Diamond

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software
source package 7a6ee408-8bf5-4cb5-9853-16d5ad415e8f #VirSorter2 v.2.1 - detect DNA and RNA viral genomes from sample
source package 583ccd01-1b80-4f0b-9027-b4abdd958a9d #CheckV v1.0.1 - assess Viral genomes

#Setting fixed variables
export checkv_database="/hpc-home/osbourne/CheckV_database_v1_5/checkv-db-v1.5"
export bins_inpdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes"
export array_files_list="${bins_inpdir}/list_basenames_all_strict_bins.txt"
export top_outdir="${bins_inpdir}/VirSorter2_output"

#Defining VirSorter2 and CheckV function
execute_viral_detect_and_check () {
    #This function will run VirSorter 2 on an input bin file then CheckV on the output fasta file
    #Virsorter 2 first
    bin_file="$1"
    bin_name=$(printf "$bin_file" | awk -F ".f" '{print $1}')
    topoutdir="$2"
    outdir="${topoutdir}/${bin_name}-VirSorter2_output"
    rm -r "$outdir" || printf "Output directory:\t$outdir did not already exist\n"
    mkdir -m 755 -p "${topoutdir}/${bin_name}-VirSorter2_output"
    working_dir="${outdir}/${bin_name}-VirSorter2_workdir"
    rm -r "$working_dir" || printf "Working directory:\t$working_dir did not already exist\n"
    mkdir -m 755 "${outdir}/${bin_name}-VirSorter2_workdir"
    #Setting a file in which failures and successes will be written to
    out_state_file="${top_outdir}/Outcomes_file.txt"
    printf "Will analyse file:\t$bin_file\nOutput will be written to:\t$outdir\nOutput will be labelled:\t$bin_name\n"
    #Default settings are used apart from the following flags
    #   -j  Max number of parallel jobs allowed set to 2
    #   --high-confidence-only Set to true
    #   --tmpdir    Provides working directory
    #   --rm-tmpdir Removes working directory at the end
    #   --verbose   Set to true
    virsorter run -w "$outdir" -i "$bin_file" -j 2 -l "$bin_name" --high-confidence-only --tmpdir "$working_dir" --rm-tmpdir --verbose || printf "FAILED TO RUN VIRSORTER ON:\t$bin_file\n" >> "$out_state_file"
    printf "Analysed file:\t$bin_file\nOutput should be written to:\t$outdir\nOutput should be labelled:\t$bin_name\n"
    #The --rm-tmpdir flag doesn't delete the directory so will do that now
    rm -r "$working_dir"
    #Printing success to outcomes file
    printf "Ran virsorter on:\t$bin_file\n" >> "$out_state_file"
    #Now the CheckV bit, input file for this should be in the output directory
    #It should be called <label you used>-final-viral-combined.fa, but will need to
    #do something here so it only runs if the file exists
    viral_bin="${outdir}/${bin_name}-final-viral-combined.fa"
    mkdir -m 755 -p "${topoutdir}/${bin_name}-VirSorter2_output/CheckV_outdir"
    checkv_outdir="${topoutdir}/${bin_name}-VirSorter2_output/CheckV_outdir"
    printf "Will run CheckV on viral reads file $viral_bin if it exists\n"
    if [[ -f "$viral_bin" && -s "$viral_bin" ]]
    then
        printf "File $viral_bin exists and will be analysed with CheckV\n"
        #Default settings are used apart from the following flags
        #   --remove_tmp    To remove intermediate files at the end
        #   -t  Sets number of threads to be used by Prodigal and Diamond to 2
        #   -d Setting path to the copy of the CheckV database you downloaded
        checkv end_to_end "$viral_bin" "$checkv_outdir" -d "$checkv_database" --remove_tmp -t 2
        printf "Ran CheckV on file:\t$viral_bin\nOutput should be in:\t$checkv_outdir\n"
        printf "Ran CheckV on any files generated for assembly:\t$bin_file\n" >> "$out_state_file"
        #Need to add the label to the files produced by CheckV
        printf "Adding the bin label to the CheckV output files\n"
        cd "$checkv_outdir"
        target_files=$(find -maxdepth 1 -type f -printf '%f\n')
        for f in $target_files
        do
            mv "$f" "${bin_name}.${f%}"
        done        
    else
        printf "$bin_file did not produce file of any possible viral reads\nNothing to run CheckV on\n"
        printf "$bin_file did not produce file of any possible viral reads\nNothing to run CheckV on\n" >> "$out_state_file"
    fi
}

#Exporting VirSorter2 function
export -f execute_viral_detect_and_check

#Going to input directory
cd "$bins_inpdir"

#Doing the array bits
inpf=$(sed -n "$SLURM_ARRAY_TASK_ID"p "$array_files_list")

#Executing the function
execute_viral_detect_and_check "$inpf" "$top_outdir"