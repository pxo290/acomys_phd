#!/bin/bash -eE
#SBATCH -p ei-largemem
#SBATCH -c 1
#SBATCH -J 2022-04-16_MUSCLE_isolates_only_entire_genomes_single_line_contigs_combined_file
#SBATCH --mem=1024gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2022-04-16_MUSCLE_isolates_only_entire_genomes_single_line_contigs_combined_file-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2022-04-16_MUSCLE_isolates_only_entire_genomes_single_line_contigs_combined_file-%A.err

#Written on 2023-04-16
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Trial script to run MUSCLE on isolate assemblies. This script attempts to align the entire genome/file for all the isolates using MUSCLE,
#it does this by concatenating all the contigs in each assembly into one and then combining the resulting single contig files into one
#multi-fasta file and submitting that to MUSCLE. It will then try and run Fasttree on the, hopefully, generated alignment to produce a Newick tree
#which can be uploaded to ITOL.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2022-04-16_MUSCLE_isolates_only_entire_genomes_single_line_contigs_combined_file.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "This was a run of the script:\t/hpc-home/osbourne/Post-EI_scripts/2022-04-16_MUSCLE_isolates_only_entire_genomes_single_line_contigs_combined_file.sh\nIt started running around:\t$script_start_time\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software
source package 37d8f236-f284-42fc-adfd-20a34f7d7b5c #MUSCLE 3.8.1551
source package /tgac/software/testing/bin/fasttree-2.1.11 #Fasttree 2.1.11


#Setting fixed variables
export isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes"
export output_dir="${isolates_dir}/MUSCLE_output"
export script_start_time=$(date)

#Going to input directory
cd "$isolates_dir"

#Removing and then remaking the output directory
rm -r "$output_dir" || printf "Output directory did not already exist\n"
mkdir -m 755 -p "$output_dir"

#Making a combined single line fasta file containing the entire masked genomes, each concatenated into a single contig and then combined into the file
export target_assemblies=$(find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa" -printf '%f\n')
for f in $target_assemblies
do
  assembly_name=$(basename "$f" | awk -F "-" '{print $1}')
  printf ">$assembly_name\n" > "${isolates_dir}/${assembly_name}.muscle_only.temp.fa"
  grep -v ">" "$f" | tr -d "\n" | sed 's/$/\n/g' >> "${isolates_dir}/${assembly_name}.muscle_only.temp.fa"
done

#Merging them all into a single multi-fasta file - this is a loose and dangerous command
cat *.muscle_only.temp.fa > "${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.MUSCLE.fa"

#Giving it to a shorter named variable
export inpf="${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.MUSCLE.fa"

#Removing the temporary files - dangerously loose command here
rm *.muscle_only.temp.fa

#Running the Muscle command
muscle -physout "${inpf}.Sequential_phylip.phy" -phyiout "${inpf}.Interleaved_phylip.phy" -fastaout "${inpf}.Muscle_alignment.fa" -in "${inpf}"

#Not actually sure that the fasta output file will be generated so will check if it exists and if not run the command again but without
#the other output files and just redirecting the output to a multifasta file without using flags
if [ ! -f "${inpf}.Muscle_alignment.fa" ]
then
    #There isn't a multi fasta file containing the alignment so will run Muscle again and this time just redirect the output
    printf "There isn't a multi fasta file containing the alignment so will run Muscle again and this time just redirect the output\n"
    muscle -in "${inpf}" > "${inpf}.Muscle_alignment.fa"
else
    #There already is a multi fasta file containing the alignment so no need to do anything more
    printf "There isn't a multi fasta file containing the alignment so will run Muscle again and this time just redirect the output\n"
fi

#Running FastTree on the multi fasta alignment output file
FastTree -gtr -nt "${inpf}.Muscle_alignment.fa" > "${inpf}.Muscle_alignment.fa.FastTree.nwk"
