#!/bin/bash -eE
#SBATCH -p ei-medium
#SBATCH -J 2023-04-18_FastTree_BBMask_hardmasked_isolates_only
#SBATCH -c 1
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-18_FastTree_BBMask_hardmasked_isolates_only-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-04-18_FastTree_BBMask_hardmasked_isolates_only-%A.err

#Written on 2023-04-18
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This script should run FastTree on a multifasta file made by converting a maf file using Galaxy's MAF_to_fasta tool with the MAF
#itself being the result of a SibeliaZ alignment run on 33 Lactic Acid Bacteria assemblies.

#This script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-04-18_FastTree_BBMask_hardmasked_isolates_only.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-04-18_FastTree_BBMask_hardmasked_isolates_only.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
inp_dir="/hpc-home/osbourne"
inpf="${inp_dir}/SibeliaZ_all_BBMasked_hardmasked_isolates_aligned.Galaxy_MAF_to_FASTA_single_sequence_per_species.fasta"
export script_start_time=$(date)

#Sourcing FastTree
source package /tgac/software/testing/bin/fasttree-2.1.11

#Going to the input directory
cd "$inp_dir"

#Running the command
FastTree -gtr -nt "${inpf}" > "${inpf}.FastTree_newick.nwk"

