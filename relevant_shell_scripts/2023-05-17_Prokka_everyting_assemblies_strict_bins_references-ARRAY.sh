#!/bin/bash -Ee
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH --array=1-552%15
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-17_Prokka_everyting_assemblies_strict_bins_references-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-17_Prokka_everyting_assemblies_strict_bins_references-%A.err

#Written on 2023-05-17
#Written by Peter Osborne

#This is an array script which will run Prokka on everything you might want to make a tree of, all the isolate assemblies, the strict bins
#and the reference genomes you are using.

#Written to be run on the NBI HPC
#Script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-05-17_Prokka_everyting_assemblies_strict_bins_references-ARRAY.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export bins_inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/bbmasked_fasta_files"
export top_outdir="${bins_inpdir}/Prokka_on_everything"

#Going to the input directory
cd "$bins_inpdir"

#Making the list file
find -maxdepth 1 -type f -name "*.fa" -printf '%f\n' | sort -V > "${bins_inpdir}/2023-05-17_list_all_fasta_files.txt"
export array_files_list="${bins_inpdir}/2023-05-17_list_all_fasta_files.txt"

#Making the top output directory
mkdir -m 755 -p "$top_outdir"

#Sourcing tools
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka 1.14.6
source package /tgac/software/testing/bin/seqtk-20150226 #Seqtk 1.0-r77-dirty

#Defining Prokka function
execute_prokka () {
    bin_file="$1"
    bin_name=$(printf "$bin_file" | awk -F ".BBMa" '{print $1}')
    topoutdir="$2"
    mkdir -m 755 -p "${topoutdir}/${bin_name}-Prokka_output"
    outdir="${topoutdir}/${bin_name}-Prokka_output"
    printf "Will run Prokka on input file:\t$bin_file\nOutput will be written to:\t$outdir\n"
    prokka --outdir "$outdir" --force --prefix "$bin_name" --kingdom Bacteria "${bin_name}.fa"
    #Removing the temporary files
    rm "${bin_name}.temp.fa"
    rm "${bin_name}.fa"
    rm "${bin_name}.old_headers.txt"
    cat "${outdir}/${$bin_name}.changed_headers_old_and_new.tsv" >> "${top_outdir}/2023-05-17_all_changed_headers.tsv"
    printf "Ran Prokka on input file:\t$bin_file\nOutput should be written in:\t$outdir\n"
}

#Exporting the Prokka function
export -f execute_prokka

#Doing the array stuff
inpf=$(sed -n "$SLURM_ARRAY_TASK_ID"p "$array_files_list")

#Running the function
execute_prokka "$inpf" "$top_outdir"
