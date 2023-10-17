#!/bin/bash -eE
#SBATCH -t 00-02:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J 2023-03-19_MOTUs_trial
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/slurm_outputs/2023-03-19_MOTUs_trial-%A.out
#SBATCH -e /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/slurm_outputs/2023-03-19_MOTUs_trial-%A.err

#Written on 2023-03-19
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Trial script to run mOTUS on cleansed but not subsampled Acomys read files, presumably to detect taxa in the reads.

#This script can be found on the hpc at:/hpc-home/osbourne/Post-EI_scripts/2023-03-19_MOTUs_trial.sh

#Setting fixed variables
export motus_image="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/motus_v3_0_3_1_docker_image.img"
export motus_database="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/db_mOTU"
export input_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/bbduk_outputs/cleansed_files"
export top_outdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads"

#Defining mOTUs function
execute_motus () {
    #This function will run mOTUs using a docker image on two, PE read file inputs
    inpf1="$1"
    inpf2="$2"
    label="$3"
    mkdir -m 755 -p "${top_outdir}/${label}-mOTUs_output"
    outdir="${top_outdir}/${label}-mOTUs_output"
    printf "Will run mOTUs on input files:\t$inpf1 and $inpf2\nWill write output to:\t$outdir\nOutput files should have the label:\t$label\n"
    #Using the Profile command with the following flags
    #   -n  Setting sample name
    #   -db Setting path to database
    #   -t Setting number of threads
    #   -v  Setting 'verbosity' to level 3, 'message'
    #   -o  Setting output file name
    #   -u  Telling it to print full name of the species
    #   -p  Telling it to print NCBI identifiers
    #   -q  Telling it to print the full rank taxonomy
    #   Default flags are being used otherwise, including the number of marker genes cutoff being set to the option '3' which is the flag between the two extreme options
    singularity exec "$motus_image" motus profile -f "$inpf1" -r "$inpf2" -n "$label" -db "$motus_database" -t 1 -v 3 -o "${outdir}/${label}.mOTUs_output.tsv" -u -p -q
    printf "Ran mOTUs on input files:\t$inpf1 and $inpf2\nWrote output to:\t$outdir\nOutput files should have the label:\t$label\n"
    #Now will get all the results for more than 0% abundance
    #Note that the abundances are in column 4 because of the flags you used putting other values in columns 2 and 3, without them
    #the abundances would be in column 2 of a two column output file
    output_file="${outdir}/${label}.mOTUs_output.tsv"
    printf "Will get non-zero abundances from output file:\t$output_file\n"
    awk -F "\t" '$4 > 0 {print $0}' "$output_file" > "${outdir}/${label}.mOTUs_output.Non_zero_abundances.tsv"
}

#Exporting the function
export -f execute_motus

#Going to the input directory
cd "$input_dir"

#Executing the function - using hardcoded values for the trial
execute_motus AR27J.QCed.Cleansed.R1.fq AR27J.QCed.Cleansed.R2.fq AR27J