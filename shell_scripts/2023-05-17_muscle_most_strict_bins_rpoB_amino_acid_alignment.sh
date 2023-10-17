#!/bin/bash -eE
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J 2023-05-17_muscle_most_strict_bins_rpoB_amino_acid_alignment
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-17_muscle_most_strict_bins_rpoB_amino_acid_alignment-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-17_muscle_most_strict_bins_rpoB_amino_acid_alignment-%A.err

#Written on 2023-05-17
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Script will hopefully take the multi-fasta file containing all the rpoB amino acid sequences for those bins which had them and then
#submitting that to MUSCLE. It will then try and run Fasttree on the, hopefully, generated alignment to produce a Newick tree
#which can be uploaded to ITOL.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-05-17_muscle_most_strict_bins_rpoB_amino_acid_alignment.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "This was a run of the script:\t/hpc-home/osbourne/Post-EI_scripts/2023-05-17_muscle_most_strict_bins_rpoB_amino_acid_alignment.sh\nIt started running around:\t$script_start_time\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software
source package 37d8f236-f284-42fc-adfd-20a34f7d7b5c #MUSCLE 3.8.1551
source package /tgac/software/testing/bin/fasttree-2.1.11 #Fasttree 2.1.11


#Setting fixed variables
export input_dir="/hpc-home/osbourne"
export input_file="${input_dir}/2023-05-17_all_rpoB_AA_sequences.faa"
export script_start_time=$(date)

#Going to input directory
cd "$input_dir"

#Running the Muscle command
muscle -physout "${input_file}.Sequential_phylip.phy" -phyiout "${input_file}.Interleaved_phylip.phy" -fastaout "${input_file}.Muscle_alignment.fa" -in "${input_file}"

#Not actually sure that the fasta output file will be generated so will check if it exists and if not run the command again but without
#the other output files and just redirecting the output to a multifasta file without using flags
if [ ! -f "${input_file}.Muscle_alignment.fa" ]
then
    #There isn't a multi fasta file containing the alignment so will run Muscle again and this time just redirect the output
    printf "There isn't a multi fasta file containing the alignment so will run Muscle again and this time just redirect the output\n"
    muscle -in "${input_file}" > "${input_file}.Muscle_alignment.fa"
else
    #There already is a multi fasta file containing the alignment so no need to do anything more
    printf "There is a multi fasta file containing the alignment so will do nothing more with Muscle\n"
fi

#Running FastTree on the multi fasta alignment output file
FastTree -gtr -nt "${input_file}.Muscle_alignment.fa" > "${input_file}.Muscle_alignment.fa.FastTree.nwk"
