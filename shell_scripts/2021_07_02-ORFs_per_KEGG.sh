#!/bin/bash -eE
#SBATCH -t 00-04:00
#SBATCH -p ei-medium
#SBATCH -J ORFs_per_KEGG
#SBATCH -c 1
#SBATCH --mem=2gb
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
  kog=$(echo "$line" | tr "\t" "\n" | head -1 | grep -v "k141")
  count_of_kog=$(echo "$line" | tr "\t" "\n" | grep -c "k141")
  printf "$kog\t$count_of_kog\n" >> 2021_07_02-Number_of_ORFS_as_contigs_for_each_KO_from_all_bins.tsv
done < map_KEGG_to_orfs.tsv
