#!/bin/bash -eE
#SBATCH -p ei-largemem
#SBATCH -J 2023-04-17_Sibeliaz_isolates_trial
#SBATCH -c 1
#SBATCH --mem=612gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-17_Sibeliaz_isolates_trial-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-17_Sibeliaz_isolates_trial-%A.err

#Written on 2023-04-17
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Trial script to run SibeliaZ on isolate assemblies. Note that it no longer has a manually provided time limit so will be the default of the ei-medium queue.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-04-17_Sibeliaz_isolates_trial.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-04-17_Sibeliaz_isolates_trial.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes"
export output_dir="${isolates_dir}/SibeliaZ_output"
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
export target_assemblies=$(find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa" -printf '%f\n')
for f in $target_assemblies
do
  assembly_name=$(basename "$f" | awk -F "-" '{print $1}')
  printf ">$assembly_name\n" > "${output_dir}/${assembly_name}.isolates_only.Single_contig.fa"
  grep -v ">" "$f" | tr -d "\n" | sed 's/$/\n/g' >> "${output_dir}/${assembly_name}.isolates_only.Single_contig.fa"
done

#Going to the output/working directory
cd "${output_dir}"

#So in spite of what they say on their user guide it seems that they need a multifasta input file rather than being given multiple different
#fasta files as arguments, so will do that here and provide it as the input
cat *.isolates_only.Single_contig.fa > "SibeliaZ.all_hardmasked_isolates.Multifasta_for_alignment.fa"

#Removing the files not needed any more
rm *.isolates_only.Single_contig.fa

#Finding all the files and putting them into a variable which is their basenames separated by spaces for SibeliaZ
export inpf="${output_dir}/SibeliaZ.all_hardmasked_isolates.Multifasta_for_alignment.fa"

#Running SibeliaZ using default flags for the most part.
#Explaination of flags:
#   -k 15 -- default recommend value for Bacteria, sets order of de Bruijn graph being used and must be an odd number
#   -a 300 -- double the default, is a fiddly thing which really requires you to know how many copies of a gene you would expect in each genome and then multiplying
#             that by the number of genomes being assessed and then multiplying that by 2. For now just using double the default value of 150 which they say was
#             optimized for mammalian genomes
#   -b 200 -- default value, bubble size threshold for graph analysis
#   -m 50 -- default value, minimum length of locally-collinear blocks for them to be used
#   -t 1 -- number of threads to use, set to 1 here since you only ask for 1 in the slurm headers
#   -f 256 -- memory allocation for the Bloom filter used by the graph constructor, setting it here to half the total memory requested in slurm headers
sibeliaz -k 15 -b 200 -m 50 -a 300 -t 1 -f 256 "$inpf"

