#!/bin/bash -eE
#SBATCH -t 00-02:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J 2023-03-18_VirSorter_isolate_trial
#SBATCH --mem=3gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-03-18_VirSorter_isolate_trial-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-03-18_VirSorter_isolate_trial-%A.err

#Written on 2023-03-18
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Trial script to detect viral genomes from assemblies made from lactic acid bacteria isolates then do a quality check on any obtained.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-03-18_VirSorter_isolate_trial.sh

#Note that if you downloaded the reference database and uncompressed it yourself it will be missing the file <where you put the database>/checkv-db-v1.5/genome_db/checkv_reps.dmnd
#You make this using Diamond with the command: diamond makedb --in checkv_reps.faa --db checkv_reps after sourcing Diamond

#Sourcing software
source package 7a6ee408-8bf5-4cb5-9853-16d5ad415e8f #VirSorter2 v.2.1 - detect DNA and RNA viral genomes from sample
source package 583ccd01-1b80-4f0b-9027-b4abdd958a9d #CheckV v1.0.1 - assess Viral genomes

#Setting fixed variables
export assemblies_inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed"
export top_outdir="${assemblies_inpdir}/VirSorter2_output"
export checkv_database="/hpc-home/osbourne/CheckV_database_v1_5/checkv-db-v1.5"
#export array_files_list="${assemblies_inpdir}/2023-02-21_list_basenames_all_noncontaminated_assemblies.txt"

#Defining VirSorter2 and CheckV function
execute_viral_detect_and_check () {
    #This function will run VirSorter 2 on an input assembly file then CheckV on the output fasta file
    #Virsorter 2 first
    assembly_file="$1"
    assembly_name=$(printf "$assembly_file" | awk -F "-" '{print $1}' | sed 's/$/-min_contig_length_500bp/')
    topoutdir="$2"
    mkdir -m 755 -p "${topoutdir}/${assembly_name}-VirSorter2_output"
    outdir="${topoutdir}/${assembly_name}-VirSorter2_output"
    mkdir -m 755 "${outdir}/${assembly_name}-VirSorter2_workdir"
    working_dir="${outdir}/${assembly_name}-VirSorter2_workdir"
    printf "Will analyse file:\t$assembly_file\nOutput will be written to:\t$outdir\nOutput will be labelled:\t$assembly_name\n"
    #Default settings are used apart from the following flags
    #   -j  Max number of parallel jobs allowed set to 1
    #   --high-confidence-only Set to true
    #   --tmpdir    Provides working directory
    #   --rm-tmpdir Removes working directory at the end
    #   --verbose   Set to true
    virsorter run -w "$outdir" -i "$assembly_file" -j 1 -l "$assembly_name" --high-confidence-only --tmpdir "$working_dir" --rm-tmpdir --verbose
    printf "Analysed file:\t$assembly_file\nOutput should be written to:\t$outdir\nOutput should be labelled:\t$assembly_name\n"
    #The --rm-tmpdir flag doesn't delete the directory so will do that now
    rm -r "$working_dir"
    #Now the CheckV bit, input file for this should be in the output directory
    #It should be called <label you used>-final-viral-combined.fa, but will need to
    #do something here so it only runs if the file exists
    viral_assembly="${outdir}/${assembly_name}-final-viral-combined.fa"
    mkdir -m 755 -p "${topoutdir}/${assembly_name}-VirSorter2_output/CheckV_outdir"
    checkv_outdir="${topoutdir}/${assembly_name}-VirSorter2_output/CheckV_outdir"
    printf "Will run CheckV on viral reads file $viral_assembly if it exists\n"
    if [[ -f "$viral_assembly" && -s "$viral_assembly" ]]
    then
        printf "File $viral_assembly exists and will be analysed with CheckV\n"
        #Default settings are used apart from the following flags
        #   --remove_tmp    To remove intermediate files at the end
        #   -t  Sets number of threads to be used by Prodigal and Diamond to 1
        #   -d Setting path to the copy of the CheckV database you downloaded
        checkv end_to_end "$viral_assembly" "$checkv_outdir" -d "$checkv_database" --remove_tmp -t 1
        printf "Ran CheckV on file:\t$viral_assembly\nOutput should be in:\t$checkv_outdir\n"
        #Need to add the label to the files produced by CheckV
        printf "Adding the assembly label to the CheckV output files\n"
        cd "$checkv_outdir"
        target_files=$(find -maxdepth 1 -type f -printf '%f\n')
        for f in $target_files
        do
            mv "$f" "${assembly_name}.${f%}"
        done        
    else
        printf "$assembly_file did not produce file of any possible viral reads\nNothing to run CheckV on\n"
    fi
}

#Exporting VirSorter2 function
export -f execute_viral_detect_and_check

#Going to input directory
cd "$assemblies_inpdir"

#Doing the trial run with one assembly file
export input_file="16bA_S19-contigs.fasta.Contigs_min_length_500bp.fa"
execute_viral_detect_and_check "$input_file" "$top_outdir"