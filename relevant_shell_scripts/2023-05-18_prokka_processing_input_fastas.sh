#!/bin/bash -Ee
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2023-05-18_prokka_processing_input_fastas
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-18_prokka_processing_input_fastas-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-18_prokka_processing_input_fastas-%A.err

#Written on 2023-05-17
#Written by Peter Osborne

#This is a shitty and lazy script which will pre-process all the fasta files for use by Prokka,
#it will make single line versions with shorter fasta headers

#Written to be run on the NBI HPC
#Script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-05-18_prokka_processing_input_fastas-ARRAY.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export bins_inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/bbmasked_fasta_files/Prokka"

#Sourcing Seqtk
source package /tgac/software/testing/bin/seqtk-20150226 #Seqtk 1.0-r77-dirty

#Going to input directory
cd "$bins_inpdir"

#Doing the processing loop
for f in *.fa
do
    bin_file="$f"
    bin_name=$(printf "$bin_file" | awk -F ".BBMa" '{print $1}')
    #Need to make a version with contig headers of under 31 characters in length for Prokka and might as well make it a single line version at the same time
    seqtk seq -l 0 "$bin_file" > "${bin_name}.temp.fa"
    #Now will get all the headers, write these to a file and then replace the headers with new ones with the format >FileID_randomalphanumeric, 10 characters only
    #for the random alphanumeric
    grep '>' "${bin_name}.temp.fa" > "${bin_name}.old_headers.txt"
    cp "${bin_name}.temp.fa" "${bin_name}.fa" 
    while IFS= read -r line
    do
        old_header=$(echo "$line")
        new_header=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${1:-10} | head -n 1)
        sed -i -e "s/${old_header}/>${bin_name}_${new_header}/g" "${bin_name}.fa"
    done < "${bin_name}.old_headers.txt"
    rm "${bin_name}.temp.fa"
    mv "$f" "${f}.deleteable"
    printf "Processed file:\t$f\n"
done
