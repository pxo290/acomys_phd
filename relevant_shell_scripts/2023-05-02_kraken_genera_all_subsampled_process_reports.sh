#!/bin/bash -eE
#SBATCH -p ei-medium
#SBATCH -J 2023-05-02_kraken_genera_all_subsampled_process_reports
#SBATCH -c 1
#SBATCH --mem=18gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-02_kraken_genera_all_subsampled_process_reports-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-02_kraken_genera_all_subsampled_process_reports-%A.err

#Written on 2023-05-02
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-05-02_kraken_genera_all_subsampled_process_reports.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-05-02_kraken_genera_all_subsampled_process_reports.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
top_outdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files"
export script_start_time=$(date)

#Going to directory
cd "$top_outdir"

#Doing the work
target_files=$(find -maxdepth 1 -type f -name "*Kaiju2table_0_errors_allowed-genus_level_results.tsv" -not -name "*_pilot_sample.*")
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  host=$(echo "$sampleID" | tr -d "JN0-9")
  season=$(echo "$sampleID" | tr -d "ARC0-9")
  host_by_season=$(echo "$sampleID" | tr -d "0-9")
  printf "Genus\t${sampleID}\n" > "${sampleID}.phyla.txt"
  output_file="${sampleID}.phyla.txt"
  while IFS= read -r line
  do
    phylum=$(echo "$line")
    rel_abun=$(awk -F "\t" -v lobel="$phylum" '$5==lobel {print $2;exit}' "$f")
    rel_abun=${rel_abun:="0"}
    printf "${phylum}\t${rel_abun}\n" >> "${sampleID}.phyla.txt"
  done < "2023-05-01_list_all_unique_genera_detected.txt"
  printf "Host\t${host}\n" >> "$output_file"
  printf "Month\t${season}\n" >> "$output_file"
  printf "Host.x.season\t${host_by_season}\n" >> "$output_file"
  printf "Processed file:\t$f\n"
done
printf "Genus\n" > genus_list.txt
cat "2023-05-01_list_all_unique_genera_detected.txt" >> genus_list.txt
printf "Host\nMonth\nHost.x.month\n" >> genus_list.txt
for f in *phyla.txt
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}.temporog.txt"
done
paste -d "\t" genus_list.txt *.temporog.txt > "2023-05-01_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads.tsv"
rm genus_list.txt
rm *.temporog.txt
rm *.phyla.txt
printf "Finished now\n"
