#!/bin/bash -eE
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2023-03-21_merge_Acomys_mOTUs_profiles
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/slurm_outputs/2023-03-21_merge_Acomys_mOTUs_profiles-%A.out
#SBATCH -e /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/slurm_outputs/2023-03-21_merge_Acomys_mOTUs_profiles-%A.err

#Written on 2023-03-21
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Script to merge mOTUs profiles generated for Acomys cleansed, NOT subsampled, read files.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-03-21_merge_Acomys_mOTUs_profiles.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export input_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads/all_plain_profiles"
export output_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads/merged_acomys_full_profiles"
export motus_database="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/db_mOTU"

#Setting semi-fixed variable, in this case the label you want the output to have
export output_label="2023_03_21-All_cleansed_Acomys_reads_plus_public_mouse_profile"

#Sourcing mOTUs - using the CiS provided version not the docker image you found
source /nbi/software/staging/RCSUPPORT-1582/stagingloader #mOTUs v3.0.3

#Writing the mOTUs merge function, though not really necessary as a function
execute_motus_merge () {
    inpdir="$1"
    outdir="$2"
    label="$3"
    #Doing the taxonomic profiles merging
    printf "Will merge mOTUs taxonomic profiles found in directory:\t$inpdir\nOutput will be written to:\t$outdir\nOutput will be labelled with:\t$label\n"
    #Will also use the public, mouse profile as well
    printf "In addition to the profiles in $inpdir will also merge with the public mouse gut profile provided by the authors of mOTUs\n"
    #Flags are default with the meanings:
        #   -d  Merge all profiles in this directory
        #   -a  Add the indicated pre-computed profiles, in this case mouse
        #   -v  Set the verbosity level to '3' which corresponds to 'message'
        #   -o Give output file name
    motus merge -d "$inpdir" -a mouse -v 3 -o "${outdir}/${label}.tsv" -db "$motus_database"
    printf "Merged mOTUs taxonomic profiles found in directory:\t$inpdir\nOutput should be written to:\t$outdir\nOutput should be labelled with:\t$label\n"
}

#Exporting the function
export -f execute_motus_merge

#Running the function
execute_motus_merge "$input_dir" "$output_dir" "$output_label"