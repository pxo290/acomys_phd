#!/bin/bash -e
#SBATCH -t 94-00:00
#SBATCH -p ei-long
#SBATCH -c 2
#SBATCH -J 2023-04-04_JolyTree_isolate_assemblies_and_bins
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-04_JolyTree_assemblies_bins_references-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-04_JolyTree_assemblies_bins_references-%A.err

#Written on 2023-04-04
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Script to run JolyTree on all fasta assembly files for lactic acid bacterial isolates, all 348 strict bins, 25 high quality iMGMC MAGs and 150 reference genomes/assemblies

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-04-04_JolyTree_assemblies_bins_references.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  rm -r "$output_dir"
  rm -r "$scratch_dir_1"
  rm -r "$scratch_dir_2"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing some packages
source package /tgac/software/testing/bin/mash-2.2 #Mash v. 2.2
source package /tgac/software/testing/bin/fastme-2.1.5 #Fastme v. 2.1.5
source package /tgac/software/testing/bin/jdk-9.0.4 #JDK v. 9.0.4

#Setting fixed variables
main_inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references"
outdir="${main_inpdir}/JolyTree_output_assemblies_and_bins_only"
jolyTree_script="/hpc-home/osbourne/Jolytree_home/JolyTree-master/JolyTree_modify_this_version-V3.sh"
jolyTree_dir="/hpc-home/osbourne/Jolytree_home/JolyTree-master"

#Going to input directory
cd "$main_inpdir"

#Making output directory
mkdir -m 755 -p "$outdir"

#Making the variable date label with a unique run ID as well
date_var_proto=$(date | awk -F " " '{print $2"_"$3"_"$6}')
run_UID_proto=$(( uuidgen ; head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ) | tr "\n" "_" | tr "-" "_" | sed "s/$/-POSBORNE_NOT_COMPRESSED_PROJECT/g")
string_unique_attachment=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10)
grep -sq "$run_UID_proto" <(ls -l) && run_UID=$(echo "$run_UID_proto" | sed "s/$/${string_unique_attachment}/g") || run_UID="$run_UID_proto"
date_var="${date_var_proto}_${run_UID}"
printf "The label which will be used will be the name of the temporary directory is:\t$date_var\n"

#Executing the Jolytree script
srun "$jolyTree_script" -i "$main_inpdir" -s 0.99 -c 0.25 -a 1.5 -b "$date_var" -t 1 -r 500

#Going to the JolyTree script directory which will contain the output files
cd "$jolyTree_dir"

#Finding the output files using the label made earlier
output_files=$(find -maxdepth 1 -type f -name "*$date_var*" -printf '%f\n')

#Moving them to the output directory
for f in $output_files
do
  printf "Moving file:\t$f to directory:\t${outdir}\n"
  mv "$f" "$outdir"
done
