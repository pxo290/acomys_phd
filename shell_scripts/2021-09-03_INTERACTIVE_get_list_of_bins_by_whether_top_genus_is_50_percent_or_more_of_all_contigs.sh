#!/bin/bash -eEu
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR


target=$(find -maxdepth 1 -type f -name "*kaiju_output-GENERA.out")
for f in $target
do
  nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}' | sed 's/binned/Bin/g')
  top_genus=$(head -2 "$f" | tail -1 | rev | awk -F ";" '{print $2}' | rev)
  top_genus_abundance=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $2}' | awk -F "." '{print $1}')
  if [[ "$top_genus_abundance" -gt 50 ]]
  then
    printf "$nome\t$top_genus\t$top_genus_abundance\n" >> 2021-09-03_Bins_with_at_least_50_percent_contigs_top_genus.tsv
  elif [[ "$top_genus_abundance" -lt 50 ]]
  then
    printf "$nome\t$top_genus\t$top_genus_abundance\n" >> 2021-09-03_Bins_with_under_50_percent_contigs_top_genus.tsv
  elif [[[ "$top_genus_abundance" -eq 50 ]]
  then
    printf "$nome\t$top_genus\t$top_genus_abundance\n" >> 2021-09-03_Bins_with_at_least_50_percent_contigs_top_genus.tsv
  fi
  printf "\nProcessed file:\t$f"
done
