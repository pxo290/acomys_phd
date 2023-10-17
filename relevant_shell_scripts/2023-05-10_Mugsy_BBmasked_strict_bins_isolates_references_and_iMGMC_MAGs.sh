#!/bin/bash -eE
#SBATCH -p ei-largemem
#SBATCH -J 2023-05-10_Mugsy_BBmasked_strict_bins_isolates_references_and_iMGMC_MAGs
#SBATCH -c 1
#SBATCH --mem=675gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-10_V3_Mugsy_BBmasked_strict_bins_isolates_references_and_iMGMC_MAGs-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-10_V3_Mugsy_BBmasked_strict_bins_isolates_references_and_iMGMC_MAGs-%A.err

#Written on 2023-05-10
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This script will take 552 fasta files which are the hardmasked fasta files for 348 metagenomic bins from Chris Q and Seb R, 34 assemblies made from
#isolated lactic acid bacteria, 25 high quality iMGMC MAGs, 80 reference genomes/assemblies based on mOTUS analysis of the Acomys reads, 23 reference genomes/assemblies
#picked based on the GTDB-TK classifications of the isolate assemblies and 45 reference genomes/assemblies based on the results from a publication
#studying the metagenome of 5 arid rodents. It will make single contig versions of these files, add the sample name as the header for each contig
#and then run Mugsy to align them all .

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-05-10_V3_Mugsy_BBmasked_strict_bins_isolates_references_and_iMGMC_MAGs.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/bbmasked_fasta_files"
export top_scratch_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch"
export output_dir="${top_scratch_dir}/V3_Mugsy_everything_aligning_output"

#Going to input directory
cd "$isolates_dir"

#Removing and then remaking the output directory
rm -r Mugsy_everything_aligning_output || printf "Isolate directory did not have a directory named after the final output dir\n"
rm -r "$output_dir" || printf "Output directory did not already exist\n"
mkdir -m 777 -p "$output_dir"

#Setting the Mugsy docker image
mugsy_docker_image="/hpc-home/osbourne/Docker_images/mugsy_aligner_v1r2_3_docker_image.img"

#Making a combined single line fasta file containing the entire masked genomes, each concatenated into a single contig and then combined into the file
export target_assemblies=$(find -maxdepth 1 -type f -name "*.BBMasked.fa" -printf '%f\n')
for f in $target_assemblies
do
  assembly_name=$(basename "$f" | awk -F ".BBMas" '{print $1}')
  printf ">$assembly_name\n" > "${output_dir}/${assembly_name}.fa"
  grep -v ">" "$f" | tr -d "\n" | sed 's/$/\n/g' >> "${output_dir}/${assembly_name}.fa"
done

#Going to output/working directory
cd "$output_dir"

#Running Mugsy using the docker image and the command you found online
singularity exec "$mugsy_docker_image" mugsy \
    --directory "${output_dir}" \
    --prefix V3_Aligning_everything \
    *.fa

#Trying to copy the output directory from scratch to the isolates directory and printing a message if this fails
cd "$top_scratch_dir"
cp -r V3_Mugsy_everything_aligning_output "$isolates_dir" || printf "Failed to copy the output directory from $top_scratch_dir to the intended destination of $isolates_dir for some reason\n"