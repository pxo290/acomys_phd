#!/bin/bash -eE
#SBATCH -t 00-16:00
#SBATCH -p ei-medium
#SBATCH -J KOGs_for_each_ORF
#SBATCH -c 2
#SBATCH --mem=4gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

while read -r line
do
  contig=$(echo "$line")
  associated_KOG_ID=$(grep "$contig" map_KEGG_to_orfs.tsv | awk -F "\t" '{print $1}')
  no_associated_KOGs=$(echo "$associated_KOG_ID" | wc -l)
  if [[ "$no_associated_KOGs" -gt 1 ]]
  then
    printf "$contig\n" >> 2021_07_02_contigs_with_multiple_KOGs.txt
  else
    associated_KOG_name=$(grep "$associated_KOG_ID" 2021_07_02_all_KOs_and_their_names.txt | awk -F "\t" '{print $2}')
    printf "$contig\t$associated_KOG_ID\t$associated_KOG_name\n" >> 2021_07_02_contigs_with_single_KOGs.txt
  fi
done < 2021_07_02-all_ORFs_as_contigs.txt
