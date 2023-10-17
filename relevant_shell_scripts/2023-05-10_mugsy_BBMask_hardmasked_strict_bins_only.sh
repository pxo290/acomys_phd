#!/bin/bash -eE
#SBATCH -p ei-medium
#SBATCH -J V4Mugsy_2023-05-10_mugsy_BBMask_hardmasked_strict_bins_only
#SBATCH -c 1
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-10_V4_mugsy_BBMask_hardmasked_strict_bins_only-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-10_V4_mugsy_BBMask_hardmasked_strict_bins_only-%A.err

#Written on 2023-05-10
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This script will run on 348 fasta files from high quality metagenomic bins. It will make single contig versions of these files, add the sample name as the header for each contig,
#then run Mugsy on the files. 

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-05-10_V4_mugsy_BBMask_hardmasked_strict_bins_only.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-05-10_V4_mugsy_BBMask_hardmasked_strict_bins_only.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
  #rm -r "$output_dir"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/bbmasked_fasta_files"
export output_dir="${isolates_dir}V4_Mugsy_output_bins_only"
export script_start_time=$(date)

#Going to input directory
cd "$isolates_dir"

#Removing and then remaking the output directory
rm -r "$output_dir" || printf "Output directory did not already exist\n"
mkdir -m 777 -p "$output_dir"

#Setting the Mugsy docker image
mugsy_docker_image="/hpc-home/osbourne/Docker_images/mugsy_aligner_v1r2_3_docker_image.img"

#Going to input directory
cd "${isolates_dir}"

#Making the single contig per file versions of the fasta file and putting them in the output/working directory
export target_assemblies=$(find -maxdepth 1 -type f -name "Bin*.BBMasked.fa" -printf '%f\n')
for f in $target_assemblies
do
  assembly_name=$(basename "$f" | awk -F ".BBMasked" '{print $1}')
  printf ">$assembly_name\n" > "${output_dir}/${assembly_name}.bins_only.fa"
  grep -v ">" "$f" | tr -d "\n" | sed 's/$/\n/g' >> "${output_dir}/${assembly_name}.bins_only.fa"
done

#Going to the output/working directory
cd "${output_dir}"

#Running Mugsy using the docker image and the command you found online
singularity exec "$mugsy_docker_image" mugsy \
    --directory "${output_dir}" \
    --prefix Strict_bins \
    *.fa