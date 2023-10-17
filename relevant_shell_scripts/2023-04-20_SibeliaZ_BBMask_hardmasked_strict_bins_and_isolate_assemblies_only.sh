#!/bin/bash -eE
#SBATCH -p ei-largemem
#SBATCH -J 2023-04-20_SibeliaZ_BBMask_hardmasked_strict_bins_and_isolate_assemblies_only
#SBATCH -c 1
#SBATCH --mem=1000gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-20_SibeliaZ_BBMask_hardmasked_strict_bins_and_isolate_assemblies_only-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-20_SibeliaZ_BBMask_hardmasked_strict_bins_and_isolate_assemblies_only-%A.err

#Written on 2023-04-20
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This script will run on 375 fasta files from high quality metagenomic bins and LAB isolate assemblies.
#It will make single contig versions of these files, add the sample name as the header for each contig,
#combine them all into a single multifasta file and then run SibeliaZ on this file. Note that the output of this will be a MAF file which needs to
#be converted to a fasta file for use with FastTree, there are ways which this could be done on a good cluster but for now you are using a tool on
#galaxy at: https://usegalaxy.org/?tool_id=MAF_To_Fasta1&version=1.0.1 using the output option for 'One Sequence per Species'.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-04-20_SibeliaZ_BBMask_hardmasked_strict_bins_and_isolate_assemblies_only.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-04-20_SibeliaZ_BBMask_hardmasked_strict_bins_and_isolate_assemblies_only.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/bbmasked_fasta_files"
export output_dir="${isolates_dir}/SibeliaZ_output_bins_and_assemblies_only"
export bins_and_isolates_list="${isolates_dir}/2023-04-20_list_bins_and_isolates.txt"
export script_start_time=$(date)

#Going to input directory
cd "$isolates_dir"

#Removing and then remaking the output directory
rm -r "$output_dir" || printf "Output directory did not already exist\n"
mkdir -m 777 -p "$output_dir"

#Sourcing SibeliaZ
source package 49b478df-13ab-4e82-bb29-f4d57dc3cd02 #Sibeliaz 1.0.0

#Going to input directory
cd "$isolates_dir"

#Making the single contig per file versions of the fasta file and putting them in the output/working directory
while IFS= read -r line
do
  fasta_name=$(echo "$line")
  fasta_file="${isolates_dir}/${fasta_name}"
  assembly_name=$(echo "$line" | awk -F ".BBMasked" '{print $1}')
  printf ">$assembly_name\n" > "${output_dir}/${assembly_name}.bins_and_isolates_only.fa"
  cat "$fasta_file" | grep -v ">" | tr -d "\n" | sed 's/$/\n/g' >> "${output_dir}/${assembly_name}.bins_and_isolates_only.fa"
done < "$bins_and_isolates_list"

#Going to the output/working directory
cd "${output_dir}"

#So in spite of what they say on their user guide it seems that they need a multifasta input file rather than being given multiple different
#fasta files as arguments, so will do that here and provide it as the input
cat *.bins_and_isolates_only.fa > "SibeliaZ.all_hardmasked_bins_and_isolates.Multifasta_for_alignment.fa"

#Removing the files not needed any more
rm *.bins_and_isolates_only.fa

#Finding all the files and putting them into a variable which is their basenames separated by spaces for SibeliaZ
export inpf="${output_dir}/SibeliaZ.all_hardmasked_bins_and_isolates.Multifasta_for_alignment.fa"

#Running SibeliaZ using default flags for the most part.
#Explaination of flags:
#   -k 15 -- default recommend value for Bacteria, sets order of de Bruijn graph being used and must be an odd number
#   -a 1800 -- is a fiddly thing which really requires you to know how many copies of a gene you would expect in each genome and then multiplying
#             that by the number of genomes being assessed and then multiplying that by 2. For now you are using 348 fasta files so setting this to more than
#             doule the number of files
#   -b 200 -- default value, bubble size threshold for graph analysis
#   -m 50 -- default value, minimum length of locally-collinear blocks for them to be used
#   -t 1 -- number of threads to use, set to 1 here since you only ask for 1 in the slurm headers
#   -f 612 -- memory allocation for the Bloom filter used by the graph constructor, setting it here to 256gb
sibeliaz -k 15 -b 200 -m 50 -a 1800 -t 1 -f 256 "$inpf"
