#!/bin/bash -eE
#SBATCH -t 01-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH --array=1-81%8
#SBATCH --mem=18gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/slurm_outputs/2023-03-19_MOTUs_ARRAY-%A.out
#SBATCH -e /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/slurm_outputs/2023-03-19_MOTUs_ARRAY-%A.err

#Written on 2023-03-19
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Array script to run mOTUS on cleansed but not subsampled Acomys read files, to detect taxa in the reads.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-03-19_MOTUs_ARRAY.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export motus_image="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/motus_v3_0_3_1_docker_image.img"
export motus_database="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/db_mOTU"
export input_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/bbduk_outputs/cleansed_files"
export top_outdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads"
export array_files_list="${input_dir}/2023-03-19_list_paired_readfiles_and_sample_name.tsv"
export labels_with_R1_counts="${input_dir}/2022_10_08_list_R1_read_counts_with_IDs.tsv"
export all_profiles_outdir="${top_outdir}/all_plain_profiles"
#The array list file has the basenames for the R1 file, the R2 file and then the sample name in that order in a row which is tab delimited.

#Sourcing the CiS temp mOTUs version
source /nbi/software/staging/RCSUPPORT-1582/stagingloader

#Defining mOTUs function
execute_motus () {
    #This function will run mOTUs using a docker image on two, PE read file inputs
    inpf1="$1"
    inpf2="$2"
    label="$3"
    outdir="${top_outdir}/${label}-mOTUs_output"
    #Adding in a step to remove the output directory to save time having to delete them myseylf while testing
    rm -r "$outdir" || printf "${outdir} did not already exist\n"
    mkdir -m 755 -p "${top_outdir}/${label}-mOTUs_output"
    printf "Will run mOTUs on input files:\t$inpf1 and $inpf2\nWill write output to:\t$outdir\nOutput files should have the label:\t$label\n"
    plain_outdir="$4"
    mkdir -p -m 755 "$plain_outdir"
    export r1_read_count=$(awk -F "\t" -v label="$label" '$1 == label {print $2}' "$labels_with_R1_counts")
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
    singularity exec "$motus_image" motus profile -f "$inpf1" -r "$inpf2" -n "$label" -db "$motus_database" -t 2 -v 3 -o "${outdir}/${label}.mOTUs_output.tsv" -u -p -q
    printf "Ran mOTUs on input files:\t$inpf1 and $inpf2\nWrote output to:\t$outdir\nOutput files should have the label:\t$label\n"
    #Now will get all the results for more than 0% abundance
    #Note that the abundances are in column 4 because of the flags you used putting other values in columns 2 and 3, without them
    #the abundances would be in column 2 of a two column output file
    output_file="${outdir}/${label}.mOTUs_output.tsv"
    printf "Will get non-zero abundances from output file:\t$output_file\n"
    awk -F "\t" '$4 > 0 {print $0}' "$output_file" > "${outdir}/${label}.mOTUs_output.Non_zero_abundances.tsv"
    #Adding in a 'plain' run without any of my option flags since the merge command failed with my attempt
    printf "Will now run again but this time with the baseline settings apart from the output name and the database flags\n"
    singularity exec "$motus_image" motus profile -f "$inpf1" -r "$inpf2" -n "$label" -db "$motus_database" -t 2 -o "${outdir}/${label}.mOTUs_output.PLAIN.tsv"
    #To save some time will also copy the plain output to the directory you made containing all the profiles
    cp "${outdir}/${label}.mOTUs_output.PLAIN.tsv" "$plain_outdir"
    #Now will run using the CiS version and producing the same two types of files as earlier but reporting read counts instead of relative abundances
    printf "Will now run mOTUs reporting read counts instead of relative abundances on input files:\t$inpf1 and $inpf2\nWill write output to:\t$outdir\nOutput files should have the label:\t$label\n"
    #Difference is using the installed version not your docker image and using the -c flag to report counts
    motus profile -f "$inpf1" -r "$inpf2" -n "$label" -db "$motus_database" -t 2 -v 3 -o "${outdir}/${label}.mOTUs_output.Read_counts.tsv" -u -p -q -c
    #Now the plain version using read counts
    printf "Will now run the count reporting version again but this time with the baseline settings apart from the output name and the database flags\n"
    motus profile -f "$inpf1" -r "$inpf2" -n "$label" -db "$motus_database" -t 2 -o "${outdir}/${label}.mOTUs_output.PLAIN.Read_counts.tsv" -c
    #Now want to get a file which reports the read counts of the plain version as a percentage of the entire reads from R1
    printf "Now reporting the read counts as a percentage of total reads for those taxa with detected hits\n"
    grep -v 'consensus' "${outdir}/${label}.mOTUs_output.Non_zero_abundances.tsv" > "${outdir}/${label}.TEMP.tsv"
    printf "#mOTU\tconsensus_taxonomy\tNCBI_tax_id\t${label}\n" > "${outdir}/${label}.Non_zero_taxa.Read_counts_as_percentage_total_reads.tsv"
    while IFS= read -r line
    do
      contents=$(echo "$line" | awk -F "\t" '{print $1"\t"$2"\t"$3"\t"}')
      reads_raw=$(echo "$line" | awk -F "\t" '{print $4}')
      reads_percentage=$(echo "($reads_raw / $r1_read_count) * 100" | bc -l)
      printf "${contents}\t${reads_percentage}\n" >> "${outdir}/${label}.Non_zero_taxa.Read_counts_as_percentage_total_reads.tsv"
    done < "${outdir}/${label}.TEMP.tsv"
    #Deleting temporary file
    rm "${outdir}/${label}.TEMP.tsv"
    #Now just making a file which has the details necessary for making a figure showing the percentage of all reads it could classify by host, month and host x month
    all_reads_classified_count=$(awk -F "\t" '$4 > 0 {print $0}' "${outdir}/${label}.mOTUs_output.Read_counts.tsv" | grep -v -e "$label" -e 'unassigned' | awk -F "\t" '{print $4}' | paste -sd+ | bc -l)
    unassigned_reads_count=$(awk -F "\t" '$4 > 0 {print $0}' "${outdir}/${label}.mOTUs_output.Read_counts.tsv" | grep -v "$label"| awk -F "\t" '{print $4}' | paste -sd+ | bc -l)
    just_classified_read_count_percent_of_total=$(echo "($all_reads_classified_count / $r1_read_count) * 100 " | bc -l)
    total_percent_reads_inc_unclassified=$(echo "($unassigned_reads_count / $r1_read_count) * 100 " | bc -l)
    printf "Including unassigned reads\tExcluding unassigned reads\n" > "${outdir}/${label}.Percentages_of_total.txt"
    printf "${total_percent_reads_inc_unclassified}\t${just_classified_read_count_percent_of_total}\n" >> "${outdir}/${label}.Percentages_of_total.txt"
}

#Exporting the function
export -f execute_motus

#Going to the input directory
cd "$input_dir"

#Doing the array bit
input_line=$(sed -n "$SLURM_ARRAY_TASK_ID"p "$array_files_list")
input_R1=$(echo "$input_line" | awk -F "\t" '{print $1}')
input_R2=$(echo "$input_line" | awk -F "\t" '{print $2}')
input_label=$(echo "$input_line" | awk -F "\t" '{print $3}')

#Executing the function
execute_motus "$input_R1" "$input_R2" "$input_label" "$all_profiles_outdir"