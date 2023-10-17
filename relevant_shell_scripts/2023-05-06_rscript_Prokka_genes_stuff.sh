#!/bin/bash -eE
#SBATCH -p ei-medium
#SBATCH -J 2023-05-06_rscript_Prokka_genes_stuff
#SBATCH -c 1
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-06_rscript_Prokka_genes_stuff-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-06_rscript_Prokka_genes_stuff-%A.err

#Written on 2023-05-06
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This script will hopefully run an R script on the Prokka gene annotations data.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-05-06_rscript_Prokka_genes_stuff.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-05-06_rscript_Prokka_genes_stuff.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Going to working directory
cd "/hpc-home/osbourne/R_session_stuff"

singularity exec --overlay /hpc-home/osbourne/Docker_images/2023_04_25-POsborne_R_overlay_thesis_corrections.img /ei/software/containers/5e4fe75c-b9b4-4951-89ad-7431eaa78f97/5e4fe75c-b9b4-4951-89ad-7431eaa78f97.img Rscript prokkaGeneAnnotationsRScript.r
