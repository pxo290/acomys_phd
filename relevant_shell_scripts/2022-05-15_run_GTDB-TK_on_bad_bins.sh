#!/bin/bash -e
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2022-05-15_run_GTDB-TK_on_bad_bins
#SBATCH --mem=412gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Written on 2023-05-15
#Written by Peter Osborne

#Script will hopefully run gtdb-tk on the bad bins, the ones you didn't use, since they whinged about that in the viva and want it as a correction.
#Written for use on the NBI HPC

#This script can be found at: /hpc-home/osbourne/Post-EI_scripts/2022-05-15_run_GTDB-TK_on_bad_bins.sh

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf  "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing GTDB-TK
source package 45db4679-d5ad-48f7-9498-4954fc88ab1d #GTDB-tk 1.7.0

#Setting an environmental variable that it needs, which is the location of the
#downloaded and unpacked database files
export GTDBTK_DATA_PATH=/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/gtdb_tk_database/release202

#Setting some fixed variables
isolates_dir="/hpc-home/osbourne/bad_bins"
top_outdir="${isolates_dir}/GTDB-TK_output"
top_tempdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch/gtdbtk"

#Making the temp dir
rm -r "$top_tempdir" || printf "Temp dir did not already exist\n"
mkdir -m 755 -p "$top_tempdir"

#Making a random number value for the de_novo workflow
random_seed_num=$(head /dev/urandom | tr -dc 0-9 | head -c 3)

#First, the classify_wf workflow
printf "\nStarting a classify_wf workflow with GTDB-TK on all isolates in the directory:\t$isolates_dir\n"
gtdbtk classify_wf --genome_dir "$isolates_dir" --out_dir "${top_outdir}/classify_wf" --cpus 2 -x fa --min_perc_aa 10 --min_af 0.65 --tmpdir "$top_tempdir" --scratch_dir "$top_tempdir"
printf "\nFinished a classify_wf workflow with GTDB-TK on all isolates in the directory:\t$isolates_dir\n"

#Now the de_novo_wf workflow
printf "\nStarting a de_novo workflow with GTDB-TK on all isolates in the directory:\t$isolates_dir\nWill use random seed:\t$random_seed_num\n"
gtdbtk de_novo_wf --genome_dir "$isolates_dir" --bacteria --outgroup_taxon p__Proteobacteria --out_dir "${top_outdir}/de_novo_wf" --cpus 2 -x fa --min_perc_aa 10 --tmpdir "$top_tempdir" --rnd_seed "$random_seed_num"
printf "\nFinished a de_novo workflow with GTDB-TK on all isolates in the directory:\t$isolates_dir\nUsed random seed:\t$random_seed_num\n"

#Note that you need to provide a phylum outgroup taxon for the de_novo_wf workflow
#I am going to try the phylum Proteobacteria.
