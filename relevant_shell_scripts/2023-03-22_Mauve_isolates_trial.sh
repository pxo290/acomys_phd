#!/bin/bash -eE
#SBATCH -p ei-largemem
#SBATCH -J 2023-03-22_Mauve_isolates_trial
#SBATCH -c 1
#SBATCH --mem=1024gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-03-22_Mauve_isolates_trial-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-03-22_Mauve_isolates_trial-%A.err

#Written on 2023-03-22
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Trial script to run Mauve on isolate assemblies. Note that it no longer has a manually provided time limit so will be the default of the largemem queue.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-03-22_Mauve_isolates_trial.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-03-22_Mauve_isolates_trial.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
  #rm -r "$output_dir"
  #rm -r "$scratch_dir_1"
  #rm -r "$scratch_dir_2"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes"
export top_scratch_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch"
export scratch_dir_1="${top_scratch_dir}/Mauve_scratch_1"
export scratch_dir_2="${top_scratch_dir}/Mauve_scratch_2"
export output_dir="${isolates_dir}/Mauve_output"
export script_start_time=$(date)

#Going to input directory
cd "$isolates_dir"

#Removing and then remaking the output directory
rm -r "$output_dir" || printf "Output directory did not already exist\n"
mkdir -m 777 -p "$output_dir"

#Removing and then remaking the two scratch directories
rm -r "$scratch_dir_1" || printf "$scratch_dir_1 did not already exist\n"
rm -r "$scratch_dir_2" || printf "$scratch_dir_2 did not already exist\n"
mkdir -m 755 -p "$scratch_dir_1"
mkdir -m 755 -p "$scratch_dir_2"

#Sourcing Mauve
#source /ei/software/staging/RCSUPPORT-1759/stagingloader #Mauve 2.4.0.r4736

#Sourcing a version of hwloc on the HPC to try and get around the recurrent error
#source package /tgac/software/production/bin/hwloc-1.8 #hwloc 1.8

#Sourcing a version of prokka which might have glibc
#source package 999eb878-6c39-444e-a291-e2e0a86660e6 #Prokka 1.13.3

#Setting downloaded Mauve Docker image
mauve_docker_image="/hpc-home/osbourne/Docker_images/mauve_aligner_v2_4_0_docker_image.img"

#Going to input directory
cd "$isolates_dir"

#Making a combined single line fasta file containing the entire masked genomes, each concatenated into a single contig and then combined into the file
export target_assemblies=$(find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa" -printf '%f\n')
for f in $target_assemblies
do
  assembly_name=$(basename "$f" | awk -F "-" '{print $1}')
  printf ">$assembly_name\n" > "${isolates_dir}/${assembly_name}.isolates_only.temp.fa"
  grep -v ">" "$f" | tr -d "\n" | sed 's/$/\n/g' >> "${isolates_dir}/${assembly_name}.isolates_only.temp.fa"
done

#Merging them all into a single multi-fasta file - this is a loose and dangerous command
cat *.isolates_only.temp.fa > "${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.Mauve_isolates_only.fa"

#Giving it to a shorter named variable
export inpf="${isolates_dir}/Combined_single_contigs_single_line_multi_fasta_from_each_isolate_assembly_combined.Mauve_isolates_only.fa"

#Removing the temporary files - dangerously loose command here
rm *.isolates_only.temp.fa

#Running Mauve on this file
cd "$output_dir"
#progressiveMauve --debug --output="${output_dir}/All_hardmasked_isolate_assemblies_mauve_aligner.mauve" --scratch-path-1="$scratch_dir_1" --scratch-path-2="$scratch_dir_2" "$inpf" || fail_check="Y"
singularity exec "$mauve_docker_image" progressiveMauve --debug --output="${output_dir}/All_hardmasked_isolate_assemblies_mauve_aligner.mauve" --scratch-path-1="$scratch_dir_1" --scratch-path-2="$scratch_dir_2" "$inpf" || fail_check="Y"

#Premptively writing then hashing out this line which might be less likely to crash
#singularity exec "$mauve_docker_image" progressiveMauve --mums --no-weight-scaling --skip-refinement --skip-gapped-alignment --disable-cache --no-recursion --debug --output="${output_dir}/All_hardmasked_isolate_assemblies_mauve_aligner.mauve" --scratch-path-1="$scratch_dir_1" --scratch-path-2="$scratch_dir_2" "$inpf" || fail_check="Y"

#Trying now to just run it without the output flag and just redirecting the output using the variable
#set above if the command failed
if [[ "$fail_check" == "Y" ]]
then
  cd "$output_dir"
  #progressiveMauve --debug --scratch-path-1="$scratch_dir_1" --scratch-path-2="$scratch_dir_2" "$inpf" > "${output_dir}/All_hardmasked_isolate_assemblies_mauve_aligner.mauve"
  singularity exec "$mauve_docker_image" progressiveMauve --debug --scratch-path-1="$scratch_dir_1" --scratch-path-2="$scratch_dir_2" "$inpf" > "${output_dir}/All_hardmasked_isolate_assemblies_mauve_aligner.mauve"
else
  printf "It seemed to have worked the first time\n"
fi

