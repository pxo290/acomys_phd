#!/bin/bash -eE
#Below slurm headers are from R. Shaw's script
#SBATCH -p ei-largemem # partition (queue)
#SBATCH --nodelist=n83032 #this version of cactus should run on this node
#SBATCH -N 1 # number of nodes
#SBATCH -c 64 # number of cores
#SBATCH --mem 1024G # memory pool for all cores
#Your headers now apart from TIME_LIMIT_75 which is also from R. Shaw's script
#SBATCH -J 2023-04-07_Cactus_bbmasked_isolate_assemblies_and_bins
#SBATCH --mail-type=begin,end,fail,TIME_LIMIT_75
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-07_Cactus_bbmasked_isolate_assemblies_and_bins-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-07_Cactus_bbmasked_isolate_assemblies_and_bins-%A.err

#Written on 2023-04-07
#Written by Peter Osborne based on and modified from a script written by Rebecca Shaw
#Written to be run on the NBI HPC

#This script should run Cactus on 34 lactic acid bacterial assemblies

#This script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-04-07_Cactus_bbmasked_isolate_assemblies_and_bins.sh

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
top_inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_for_cactus"
masked_fastas_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_and_bins/bbmasked_files"
tree_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_and_bins/JolyTree_output_assemblies_and_bins_only"
working_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_and_bins/cactus_dir"
scratch_directory="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch/cactus"

#Copying all the masked fasta files into the working directory plus renaming the copies so they match the names in the tree file
#which does not have the 'bbmasked' in it in this case
printf "Going to fasta input directory and copying the files to the working directory with their appropriate names\n"
cd "$masked_fastas_dir"
targets=$(find -maxdepth 1 -type f -name "*.BBMasked.fa")
for f in $targets
do
    nome=$(basename "$f" .BBMasked.fa | sed 's/$/.fa/g')
    cat "$f" > "${working_dir}/${nome}"
    printf "Processed file:\t$f prior to running Cactus\n"
done

#Making the variable for the cactus information file
cactus_information_file="${working_dir}/Cactus_info_file_bins_and_assemblies.txt"

#Cactus can't handle the trees produced by Newick directly due to 'internal node labels' which are the numbers between a ) and a :
#These need to be removed in the copying of the newick tree content into the information file. For doing this use Newick Utilities
#to produce a tree without branch lengths which is basically a cladogram.

#Sourcing newick utilities
source package /tgac/software/testing/bin/newick_utils-1.5 #Newick Utilities v.1.5

#Running the command so we can get the tree content without branch lengths and putting it into the cactus information file which we made earlier
printf "Getting the newick tree content without branch lengths and putting it into the cactus information file\n"
cd "$tree_dir"
#Finding the tree file, assuming there is only one
tree_file=$(find -maxdepth 1 -type f -name "*.nwk")

nw_topology "$tree_file" > "$cactus_information_file"

#Going to working directory
printf "Going to the working directory and putting the sample names and absolute paths into the information file, one per line\n"
cd "$working_dir"

#Adding the sample names and file paths to the information file
targets=$(find -maxdepth 1 -type f -name "*.fa")
for f in $targets
do
    sample_name=$(basename "$f" .fa)
    sample_file_basename=$(basename "$f")
    path_to_file="${working_dir}/${sample_file_basename}"
    printf "${sample_name} ${path_to_file}\n" >> "$cactus_information_file"
    printf "Added file:\t$f\tto the Cactus information file\n"
done

#Sourcing cactus
source package afc1a9d3-4ba8-4261-b4b3-e0153b069bf1 #Cactus 2.2.0

#Making the jobstore directory variable
jobstore_dir="${working_dir}/Cactus_jobstore_dir"

#Should already be in the working directory so not needing to go there again before running the command

#Command below is copied from R. Shaw's script except for changing directory names with different variables and the like
cactus --binariesMode local  --cleanWorkDir never --noLinkImports --noMoveExports --maxCores 128 --defaultMemory 2G --maxMemory 1024G --defaultDisk 64G --maxDisk 5120G --workDir ./ "${jobstore_dir}" "${cactus_information_file}" ./Cactus_aln_isolates_and_bins.hal

#Your possibly incorrect modification
#cactus --binariesMode local  --cleanWorkDir never --noLinkImports --noMoveExports --maxCores 128 --defaultMemory 2G --maxMemory 1024G --defaultDisk 64G --maxDisk 5120G --workDir "$scratch_directory" "${jobstore_dir}" "${cactus_information_file}" ./Cactus_aln_isolates_and_bins.hal