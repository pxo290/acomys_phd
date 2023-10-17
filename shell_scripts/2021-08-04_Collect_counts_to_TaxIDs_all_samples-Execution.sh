#!/bin/bash -eEu
#SBATCH -t 00-06:45
#SBATCH -p ei-medium
#SBATCH -J Collect_counts_to_TaxIDs_all_samples-Execution
#SBATCH -c 1
#SBATCH --mem=2gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-08-04
#Note that if a contig is associated with more than one TaxID this script should
#pick the largest one - it uses tail -1 to do this. This is not necessarily all
#that smart scientifically but it should correspond with a lower ranking TaxID,
#i.e. a species instead of genus or the like. This is done to simplify the script
#and make sure that there are actually the summed mapped read segment counts for
#them.

export INPF=$1

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

while read -r line
do
  contig=$(echo "$line" | awk -F "," '{print $1}')
  contig_length=$(echo "$line" | awk -F "," '{print $2}')
  adjusted_mapped_read_segment_count=$(echo "$line" | awk -F "," '{print $3}')
  unmapped_read_segment_count=$(echo "$line" | awk -F "," '{print $4}')
  taxid=$(grep -w "$contig" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021-08-04_Unique_TaxIDs_and_their_associated_contigs.tsv | awk -F "\t" '{print $1}' | tail -1)
  count_taxid=$(echo "$taxid" | wc -l)
  if [[ "$count_taxid" == "0" ]]
  then
    backup_taxid="0"
    #printf "$backup_taxid\t$adjusted_mapped_read_segment_count\n" >> "${INPF%}.TEMP.tsv"
    echo "$taxid was one with multiple contigs, but was always the lower value taxid so never selected by the script"
  elif [[ "$count_taxid" == "1" ]]
  then
    printf "$taxid\t$adjusted_mapped_read_segment_count\n" >> "${INPF%}.TEMP.tsv"
  fi
done < "$INPF"
while read -r line
do
  TaxID=$(echo "$line")
  grep -wq "$TaxID" 2021-08-06_Bad_TaxIDs_list.txt && bad_taxID_check="Y" || bad_taxID_check="N"
  if [[ "$bad_taxID_check" == "Y" ]]
  then
    echo "$taxid was one with multiple contigs, but was always the lower value taxid so never selected by the script"
  elif [[ "$bad_taxID_check" == "N" ]]
  then
    collected_adjusted_counts_for_TaxID=$(grep -w "$TaxID" "${INPF%}.TEMP.tsv" | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l | awk '{printf "%f", $0}')
    printf "$TaxID\t$collected_adjusted_counts_for_TaxID\n" >> "${INPF%}.TaxID_collected_contig_and_library_size_adjusted_scores.tsv"
  fi
done < 2021-08-04_all_unique_TaxIDs_from_all_consensus_contigs.txt
rm "${INPF%}.TEMP.tsv"
