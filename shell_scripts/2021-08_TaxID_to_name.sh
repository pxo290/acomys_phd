#!/bin/bash -eE
#SBATCH -t 04-12:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J TaxID_to_name
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

touch 2021-08-08_TaxIDs_to_names.txt

while read -r line
do
  taxid=$(echo "$line")
  scientific_name=$(cat Kaiju_1.7.3_names.dmp | awk '{if ($1 == '"$taxid"') print $0;}' | grep 'scientific name' | awk -F "|" '{print $2}' | tr -d "\t")
  printf "@$scientific_name@\t$taxid\n" >> 2021-08-08_TaxIDs_to_names.txt
  echo "Processed taxid: $taxid"
done < 2021-08-06_Useful_taxids.txt
