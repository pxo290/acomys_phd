#!/bin/bash -eEu
#SBATCH -t 00-10:45
#SBATCH -p ei-medium
#SBATCH -J Collect_counts_to_TaxIDs_all_samples
#SBATCH -c 1
#SBATCH --mem=1gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-08-04
#Note that if a contig is associated with more than one TaxID this script should
#pick the largest one - it uses tail -1 to do this. This is not necessarily all
#that smart scientifically but it should correspond with a lower ranking TaxID,
#i.e. a species instead of genus or the like. This is done to simplify the script
#and make sure that there are actually the summed mapped read segment counts for
#them.

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

subjects=$(find -maxdepth 1 -type f -name "*-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv")
for f in $subjects
do
  sbatch Collect_counts_to_TaxIDs_all_samples-Execution.sh "$f"
  sleep 30s
  printf "\nSubmitted file:\t$f\n"
done
