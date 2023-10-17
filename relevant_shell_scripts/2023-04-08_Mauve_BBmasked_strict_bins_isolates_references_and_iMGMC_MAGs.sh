#!/bin/bash -eE
#SBATCH -p ei-largemem
#SBATCH -J 2023-04-08_Mauve_BBmasked_strict_bins_isolates_references_and_iMGMC_MAGs
#SBATCH -c 1
#SBATCH --mem=1024gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-08_Mauve_BBmasked_strict_bins_isolates_references_and_iMGMC_MAGs-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-08_Mauve_BBmasked_strict_bins_isolates_references_and_iMGMC_MAGs-%A.err

#Written on 2023-04-08
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This script will take 552 fasta files which are the hardmasked fasta files for 348 metagenomic bins from Chris Q and Seb R, 34 assemblies made from
#isolated lactic acid bacteria, 25 high quality iMGMC MAGs, 80 reference genomes/assemblies based on mOTUS analysis of the Acomys reads, 23 reference genomes/assemblies
#picked based on the GTDB-TK classifications of the isolate assemblies and 45 reference genomes/assemblies based on the results from a publication
#studying the metagenome of 5 arid rodents. It will make single contig versions of these files, add the sample name as the header for each contig,
#combine them all into a single multifasta file and then try and run Mauve on this file.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-04-08_Mauve_BBmasked_strict_bins_isolates_references_and_iMGMC_MAGs.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  rm -r "$output_dir" || echo ""
  rm -r "$scratch_dir_1" || echo ""
  rm -r "$scratch_dir_2" || echo ""
  cd "$isolates_dir"
  rm *.temp.fa || echo ""
  rm "${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.fa" || echo ""
  rm "${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.COPY.fa" || echo ""
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/bbmasked_fasta_files"
export top_scratch_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch"
export scratch_dir_1="${top_scratch_dir}/Mauve_scratch_3" #Numbered 3 and 4 here to avoid conflict with the mauve script doing the isolates and bins which use 1 and 2
export scratch_dir_2="${top_scratch_dir}/Mauve_scratch_4"
export output_dir="${isolates_dir}/Mauve_output"
export jolytree_tree="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/4_Apr_2023_f0d552b1_dda5_4f24_a03e_d1eacc03384e_SkjKWbSpk3DIosZW-POSBORNE_NOT_COMPRESSED_PROJECT.nwk"

#Going to input directory
cd "$isolates_dir"

#Removing and then remaking the output directory
rm -r "$output_dir" || printf "Output directory did not already exist\n"
mkdir -m 755 -p "$output_dir"

#Removing and then remaking the two scratch directories
rm -r "$scratch_dir_1" || printf "$scratch_dir_1 did not already exist\n"
rm -r "$scratch_dir_2" || printf "$scratch_dir_2 did not already exist\n"
mkdir -m 755 -p "$scratch_dir_1"
mkdir -m 755 -p "$scratch_dir_2"

#Sourcing Mauve
#source /ei/software/staging/RCSUPPORT-1759/stagingloader #Mauve 2.4.0.r4736
source package /tgac/software/testing/bin/mauve-2.4.0 #Mauve 2.4.0

#Setting downloaded Mauve Docker image
mauve_docker_image="/hpc-home/osbourne/Docker_images/mauve_aligner_v2_4_0_docker_image.img"

#Going to input directory
cd "$isolates_dir"

#Making the list of assemblies in a space delimited list to put into the Mauve aligner command
#export target_assemblies=$(find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa" -printf '%f\n' | tr "\n" " " | awk '{$1=$1};1')

#Making a combined single line fasta file containing the entire masked genomes, each concatenated into a single contig and then combined into the file
export target_assemblies=$(find -maxdepth 1 -type f -name "*.BBMasked.fa" -printf '%f\n')
for f in $target_assemblies
do
  assembly_name=$(basename "$f" | awk -F ".BBMas" '{print $1}')
  printf ">$assembly_name\n" > "${isolates_dir}/${assembly_name}.temp.fa"
  grep -v ">" "$f" | tr -d "\n" | sed 's/$/\n/g' >> "${isolates_dir}/${assembly_name}.temp.fa"
done

#Merging them all into a single multi-fasta file - this is a loose and dangerous command
cat *.temp.fa > "${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.fa"

#Making a backup copy of this file in case you want to inspect it or try with Muscle
cp "${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.fa" "${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.COPY.fa"

#Giving it to a shorter named variable
export inpf="${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.fa"

#Removing the temporary fasta files
deletion_targets=$(find -maxdepth 1 -type f -name "*.temp.fa" -not -name "*.BBMasked.fa")
for f in $deletion_targets
do
    printf "Removing temporary fasta file:\t$f\n"
    rm "$f"
done

#Running Mauve on this file
progressiveMauve --debug --input-guide-tree="$jolytree_tree" --output="${output_dir}/All_hardmasked_isolate_assemblies_mauve_aligner.mauve" --output-guide-tree="${output_dir}/All_hardmasked_isolate_assemblies_mauve_aligner.mauve_guide_tree.nwk" --scratch-path-1="$scratch_dir_3" --scratch-path-2="$scratch_dir_4" "$inpf"

#singularity exec "$mauve_docker_image" progressiveMauve --debug --input-guide-tree="$jolytree_tree" --output="${output_dir}/All_hardmasked_isolate_assemblies_mauve_aligner.mauve" --output-guide-tree="${output_dir}/All_hardmasked_isolate_assemblies_mauve_aligner.mauve_guide_tree.nwk" --scratch-path-1="$scratch_dir_3" --scratch-path-2="$scratch_dir_4" "$inpf"
