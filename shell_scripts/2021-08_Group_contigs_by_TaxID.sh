#!/bin/bash -eExu
#SBATCH -t 08-12:30
#SBATCH -p ei-long
#SBATCH -c 1
#SBATCH -J Group_contigs_by_TaxID
#SBATCH --mem=2gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting file which will be searched here
export TARGET="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021_08_02-All_contigs_and_their_lengths_and_TaxID_and_containing_Bin_tab_separated.tsv"
#Setting the input file which has the list of unique contigs here
export UNIQUE_TAXID_LIST_FILE="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021-08-04_unique_TaxIDs_from_all_classified_contigs.txt"

#Also putting in the number of contigs here for use in the calculation later
export contig_total="132973"

while read -r line
do
  TaxID=$(echo "$line")
  associated_contigs=$(grep -w "$TaxID" "$TARGET" | awk -F "\t" '{print $1}' | tr "\n" "\t")
  printf "$TaxID\t$associated_contigs\n" >> 2021-08-04_Unique_TaxIDs_and_their_associated_contigs.tsv
  number_of_associated_contigs=$(echo "$associated_contigs" | tr "\t" "\n" | wc -l)
  percent_of_all_contigs_associated=$(echo "($number_of_associated_contigs / $contig_total) * 100 | bc -l")
  printf "TaxID:\t$TaxID had this many associated contigs:\t$number_of_associated_contigs\tand has this percent of all contigs associated with it:\t$percent_of_all_contigs_associated\n"
done < "$UNIQUE_TAXID_LIST_FILE"
