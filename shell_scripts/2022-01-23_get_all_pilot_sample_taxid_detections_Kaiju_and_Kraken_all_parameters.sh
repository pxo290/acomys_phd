#!/bin/bash -e
#SBATCH -t 08-12:00
#SBATCH -p ei-long
#SBATCH -c 2
#SBATCH -J 2022-01-23_get_all_pilot_sample_taxid_detections_Kaiju_and_Kraken_all_parameters
#SBATCH --mem=2gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

INPDIRKAIJU="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs"
INPDIRKRAKEN="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output"
OUTPUTDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/results"

cd "$INPDIRKAIJU"
target_files=$(find -maxdepth 1 -type f -name "A*Taxon_names_added.out")
for f in $target_files
do
  awk '$1 == "C" {print $3}' "$f"
done | sort -V | uniq >> 2022_01_23-Kaiju_all_pilot_samples_all_allowed_errors_unique_taxids.txt

cd "$INPDIRKRAKEN"
target_files=$(find -maxdepth 1 -type f -name "A*Classified_Kraken2*conf_score_1.txt")
for f in $target_files
do
  cat "$f" | grep 'taxid' | awk -F "taxid|" '{print $2}' | tr -d "|"
done | sort -V | uniq >> 2022_01_23-Kraken_all_pilot_samples_all_allowed_errors_unique_taxids.txt

cd "$OUTPUTDIR"
cat "${INPDIRKAIJU}/2022_01_23-Kaiju_all_pilot_samples_all_allowed_errors_unique_taxids.txt" "${INPDIRKRAKEN}/2022_01_23-Kraken_all_pilot_samples_all_allowed_errors_unique_taxids.txt" >> 2022_01_23-All_pilot_samples_Kaiju_and_Kraken_all_parameters_all_unique_TaxIDs.txt
