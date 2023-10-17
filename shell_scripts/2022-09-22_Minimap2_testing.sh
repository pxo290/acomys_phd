#!/bin/bash -eE
#SBATCH -t 01-12:30
#SBATCH -p ei-medium
#SBATCH -c 4
#SBATCH -J 2022-09-22_Minimap2_testing
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/slurm_outputs/2022-09-22_Minimap2_testing-%A.out
#SBATCH -e /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/slurm_outputs/2022-09-22_Minimap2_testing-%A.err

#Quick testing script to see if the assembly produced from some Capybara reads can
#even be mapped to

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing Minimap2
source package 222eac79-310f-4d4b-8e1c-0cece4150333 #Minimap2 version 2.24-41122

#Setting fixed variables
inpdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch/5b42a12a_71c6_485e_ad4a_931e6e8b90f7_VgGbMBVxmxLHDkpM-Thu_22_Sep_2022-WORKING-SRR11852046-Capybara"
inpf1="${inpdir}/5b42a12a_71c6_485e_ad4a_931e6e8b90f7_VgGbMBVxmxLHDkpM-Thu_22_Sep_2022.QCed.Cleansed.R1.fastq"
inpf2="${inpdir}/5b42a12a_71c6_485e_ad4a_931e6e8b90f7_VgGbMBVxmxLHDkpM-Thu_22_Sep_2022.QCed.Cleansed.R2.fastq"
assembly="${inpdir}/SPADES_output/"

#Going to input directory
cd "$inpdir"

#Doing the work
minimap2 -a -x sr -t 4 "$assembly" "$inpf1" "$inpf2" > "${inpdir}/Dedicated_minimap2_testing_script.sam"
