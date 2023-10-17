#!/bin/bash -e
#SBATCH -t 72-00:00
#SBATCH -p ei-long
#SBATCH -c 1
#SBATCH -J 2023-01-21_Jolytree_min_50_percent_complete_RShaw_bins_plus_10_iMGMC_MAGs_and_12_reference_genomes
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-21_Jolytree_min_50_percent_complete_RShaw_bins_plus_10_iMGMC_MAGs_and_12_reference_genomes-%A.out
#SBATCH -e /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-21_Jolytree_min_50_percent_complete_RShaw_bins_plus_10_iMGMC_MAGs_and_12_reference_genomes-%A.err

#Script written on 2023-01-21
#Written by Peter Osborne

#This script runs JolyTree on 6 medium quality MAGs generated from read data provided by R. Shaw along with 10 high quality MAGs from the iMGMC
#and 12 downloaded reference genomes.

#This script can be found at: /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/scripts/2023-01-21_Jolytree_min_50_percent_complete_RShaw_bins_plus_10_iMGMC_MAGs_and_12_reference_genomes.sh

#This script is meant to be run on the NBI HPC

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing some packages
source package /tgac/software/testing/bin/mash-2.2 #Mash v. 2.2
source package /tgac/software/testing/bin/fastme-2.1.5 #Fastme v. 2.1.5
source package /tgac/software/testing/bin/jdk-9.0.4 #JDK v. 9.0.4

#Setting fixed variables
jolyTree_script="/hpc-home/osbourne/Jolytree_home/JolyTree-master/JolyTree_modify_this_version-V3.sh"
jolyTree_dir="/hpc-home/osbourne/Jolytree_home/JolyTree-master"
outdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/JolyTree_output"
inpdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes"

#Making the variable date label with a unique run ID as well
run_UID_proto=$(( uuidgen ; head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10 ) | tr "\n" "_" | tr "-" "_" | sed "s/$/-${date_var}/g")
string_unique_attachment=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10)
grep -sq "$run_UID_proto" <(ls -l) && run_UID=$(echo "$run_UID_proto" | sed "s/$/${string_unique_attachment}/g") || run_UID="$run_UID_proto"
date_var=$(date | awk -F " " '{print $2"_"$3"_"$6}' | sed "s/$/$run_UID/g")
printf "The label which will be used will be the name of the temporary directory is:\t${date_var}\n"

#Executing the Jolytree script
srun "$jolyTree_script" -i "$inpdir" -s 0.99 -c 0.25 -a 1.5 -b "$date_var" -t 1 -r 500

#Going to the JolyTree script directory which will contain the output files
cd "$jolyTree_dir"

#Finding the output files using the label made earlier
output_files=$(find -maxdepth 1 -type f -name "$date_var*" -printf '%f\n')

#Moving them to the output directory
for f in $output_files
do
  printf "Moving file:\t$f to directory:\t${outdir}\n"
  mv "$f" "$outdir"
done
