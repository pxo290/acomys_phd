#!/bin/bash -eE
#SBATCH -t 02-23:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J get_species_level_taxa_from_all_bins
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR


while read -r line ; do taxid="$line" && taxon=$(cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '"$taxid"') print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}') && printf "£$taxid@$taxon\n" >> 2021_05_27_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt ; done < 2021_05_27_all_unique_taxIDs_at_species_level_for_all_contigs_across_all_bins.txt
