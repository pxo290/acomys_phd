#!/bin/bash -eE
#SBATCH -p ei-medium
#SBATCH -J 2023-05-13_Mugsy_isolates_only_trial
#SBATCH -c 1
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-13_Mugsy_isolates_only_trial-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-13_Mugsy_isolates_only_trial-%A.err

#Written on 2023-05-13
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Trial script to run Mugsy on isolate assemblies, SibeliaZ already worked on these but need to see if the Mugsy tool itself is broken
#since it has failed twice running on the strict bins only.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-05-13_Mugsy_isolates_only_trial.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-05-13_Mugsy_isolates_only_trial.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes"
export output_dir="${isolates_dir}/Mugsy_isolates_only_output"
export script_start_time=$(date)
mugsy_docker_image="/hpc-home/osbourne/Docker_images/mugsy_aligner_v1r2_3_docker_image.img"

#Going to input directory
cd "$isolates_dir"

#Removing and then remaking the output directory
rm -r "$output_dir" || printf "Output directory did not already exist\n"
mkdir -m 777 -p "$output_dir"

#Going to input directory
cd "$isolates_dir"

#Making the single contig per file versions of the fasta file and putting them in the output/working directory
export target_assemblies=$(find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa" -printf '%f\n')
for f in $target_assemblies
do
  assembly_name=$(basename "$f" | awk -F "-" '{print $1}')
  printf ">$assembly_name\n" > "${output_dir}/${assembly_name}.Mugsy.isolates_only.Single_contig.fa"
  grep -v ">" "$f" | tr -d "\n" | sed 's/$/\n/g' >> "${output_dir}/${assembly_name}.Mugsy.isolates_only.Single_contig.fa"
done

#Going to the output/working directory
cd "${output_dir}"

#Running Mugsy using the docker image and the command you found online
singularity exec "$mugsy_docker_image" mugsy \
    --directory "${output_dir}" \
    --prefix Isolates_only \
    *.fa