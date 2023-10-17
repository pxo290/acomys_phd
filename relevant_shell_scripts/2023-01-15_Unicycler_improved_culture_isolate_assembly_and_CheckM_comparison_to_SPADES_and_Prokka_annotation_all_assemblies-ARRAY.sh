#!/bin/bash -Ee
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH --array=1-26%2
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-01-15_Unicycler_improved_culture_isolate_assembly_and_CheckM_comparison_to_SPADES_and_Prokka_annotation_all_assemblies-ARRAY-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-01-15_Unicycler_improved_culture_isolate_assembly_and_CheckM_comparison_to_SPADES_and_Prokka_annotation_all_assemblies-ARRAY-%A.err

#Written on 2023-01-15
#Written by Peter Osborne

#Written to be run on the NBI HPC

#This script is an array job which does a couple of things in one script. It first produces a Unicycler assembly of QC'ed and cleansed reads
#from bacterial isolates obtained by Nancy Teng in 2021 at QIB using LAB selective media, then it makes a version of this assembly which only
#contains contigs at least 500bp in size. It then runs CheckM to compare the two different Unicycler assembly versions along with the original
#SPADES produced assembly from the same reads; the SPADES assembly having also been filtered to only contain contigs at least 500bp in size. After
#this it annotates all the assemblies using Prokka - previously the SPADES assemblies had only been annotated with DFAST. There are 34 isolates which
#were used in the thesis, including ones from a study of Apodemus by Magdalena Kujawska of QIB, however this script only runs with the Acomys samples
#used in the thesis after QC and uniqueness checking, 26 in total.

#This script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-01-15_Unicycler_improved_culture_isolate_assembly_and_CheckM_comparison_to_SPADES_and_Prokka_annotation_all_assemblies-ARRAY.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export top_outdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch/Unicycler_and_Prokka"
export destination_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/Unicycler_and_Prokka"
export processed_spades_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed"
export reads_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/cleansed_acomys_isolates"
#Not smart, but there are already a few files you can use as the array input file, so will just use one of them
export array_files_list="${processed_spades_dir}/2023-01-16_just_Acomys_assemblies_basename_list_file.txt"

#Sourcing software
source package 0869fa97-4854-4287-9b69-145d1e0ec6c4 #Unicycler 0.49
source package 5a1c6a9a-f666-4eaa-9409-3e7435d86406 #CheckM 1.2.0
source package /tgac/software/testing/bin/bbmap-38.06 #BBMap 38.06
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka 1.14.6

#Writing the function to do the various tasks
execute_unicycler_and_prokka () {
    isolateID="$1"
    spades_assembly="$2"
    inpf1="$3"
    inpf2="$4"
    upper_outdir="$5"
    printf "####\n"
    printf "Working on files for isolate ID:\t$isolateID\n"
    printf "SPADES 500bp min contig size assembly file is:\t$spades_assembly\n"
    printf "Read files are:\t$inpf1 and $inpf2\n"
    printf "Output should be found in directory:\t${upper_outdir}/${isolateID}-Unicycler_and_Prokka\n"
    printf "####\n"
    mkdir -m 755 -p "${upper_outdir}/${isolateID}-Unicycler_and_Prokka"
    outdir="${upper_outdir}/${isolateID}-Unicycler_and_Prokka"
    #Running Unicycler
    printf "Will run Unicycler using input read files:\t$inpf1 and $inpf2\n"
    unicycler -1 "$inpf1" -2 "$inpf2" -o "$outdir" --threads 2 --mode normal --verbosity 2
    cd "$outdir"
    for f in *
    do
        mv "$f" "${isolateID}-Unicycler_output.${f%}"
        printf "Renamed file:\t$f to ${isolateID}-Unicycler_output.${f%}\n"
    done
    #Adding useful information to the Unicycler assembly fasta file
    sed -i -e "s/>/>Contig_/g" "${isolateID}-Unicycler_output.assembly.fasta"
    sed -i -e "s/ length=/ ${isolateID} length=/g" "${isolateID}-Unicycler_output.assembly.fasta"
    unicycler_fasta="${outdir}/${isolateID}-Unicycler_output.assembly.fasta"
    #Making a 500bp minimum contig size version of the assembly
    reformat.sh in="$unicycler_fasta" out="${outdir}/${isolateID}-Unicycler_output.500bp_min_size_contigs.assembly.fasta"
    #Copying in the SPADES assembly, the 500bp min contig size version
    cp "$spades_assembly" "$outdir"
    spades_assembly_old_name=$(basename "$spades_assembly")
    #Need to add the .fasta extension to the copied in spades assembly
    mv "${outdir}/${spades_assembly_old_name}" "${outdir}/${spades_assembly_old_name}.fasta"
    #Running CheckM on the various fasta files
    checkm lineage_wf -t 2 -x fasta "$outdir" "$outdir"
    target_lineage_file=$(find -maxdepth 1 -type f -name "*lineage*.ms" -printf '%f\n')
    qa_output_file_dir="$outdir"
    checkm qa -o 2 -f "${outdir}/${isolateID}.CheckM.tsv" "$target_lineage_file" "$qa_output_file_dir"
    #Running Prokka on the different fasta files
    #target_files=$(find -maxdepth 1 -type f -name "*${isolateID}*.fasta" -or -name "*${isolateID}*Contigs*.fa" -printf '%f\n')
    target_files=$(find -maxdepth 1 -type f -name "*.fasta")
    for f in $target_files
    do
        working_fasta="$f"
        fasta_variant=$(basename "$f")
        printf "Running Prokka on input file:\t$fasta_variant\n"
        printf "Output files can be found in:\t${outdir}/Prokka_output-${fasta_variant}\n"
        printf "Output files will have the prefix:\t${isolate_ID}-Prokka_output-${fasta_variant}\n"
        prokka --outdir "${outdir}/Prokka_output-${fasta_variant}" --prefix "${isolate_ID}-Prokka_output-${fasta_variant}" --kingdom Bacteria "$working_fasta"
    done
    #Will now gzip all files before moving the directory from the scratch to the data one
    targets_to_zip=$(find -maxdepth 4 -type f)
    for f in $targets_to_zip
    do
        printf "Will zip file:\t$f\n"
        gzip "$f"
    done
    #Will now move the output directory to the data top output directory from the scratch version
    cd "$destination_dir"
    mv "$outdir" "$destination_dir"
    printf "####\n"
    printf "Worked on files for isolate ID:\t$isolateID\n"
    printf "SPADES 500bp min contig size assembly file was:\t$spades_assembly\n"
    printf "Read files were:\t$inpf1 and $inpf2\n"
    printf "Output should be ready in directory:\t${upper_outdir}/${isolateID}-Unicycler_and_Prokka\n"
    printf "####\n"
}

#Exporting the function
export -f execute_unicycler_and_prokka

#Going to the top output directory
cd "$top_outdir"

#Doing the array stuff - note that the reads bit depends on the files being named in a specific way and in the right directory, it is not smart or adaptive in any way
inpf=$(sed -n "$SLURM_ARRAY_TASK_ID"p "$array_files_list")
isolate_ID=$(echo "$inpf" | awk -F "-" '{print $1}')
processed_spades_assembly=$(echo "${processed_spades_dir}/${inpf}")
reads_1="${reads_dir}/${isolate_ID}.QCed.Cleansed.R1.fq"
reads_2="${reads_dir}/${isolate_ID}.QCed.Cleansed.R2.fq"

#Running the function
execute_unicycler_and_prokka "$isolate_ID" "$processed_spades_assembly" "$reads_1" "$reads_2" "$top_outdir"


