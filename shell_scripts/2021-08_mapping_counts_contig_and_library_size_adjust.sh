#!/bin/bash -eE
#SBATCH -t 06-23:45
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH --mem=1gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

export LISTFILE="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021_08_02-All_contigs_and_their_lengths_and_TaxID_and_containing_Bin_tab_separated.tsv"
export PILOT_LIST_FILE="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-07-27_Reads_to_Bins_mapping/Pilot_SampleID_list.txt"
export LOBEL=$1
export INPF=$2

export NOME=$(basename "$INPF" | awk -F "_" '{print $4}' | awk -F "-" '{print $1}' | rev | cut -c 2- | rev)
grep -q "$NOME" "$PILOT_LIST_FILE" && export LIB_SIZE="4.5" && printf "\nFile $inpf represents a pilot sample\n" || export LIB_SIZE="9.5" && printf "\nFile $inpf is not a pilot sample\n"
rm "${LOBEL}_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv" && touch "${LOBEL}_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv" || touch "${LOBEL}_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv"
while read -r line
do
  contig=$(echo "$line" | awk -F "\t" '{print $1}')
  contig_length=$(echo "$line" | awk -F "\t" '{print $2}')
  mapped_segments=$(echo "$line" | awk -F "\t" '{print $3}')
  unmapped_segments=$(echo "$line" | awk -F "\t" '{print $4}')
  kilobase_length=$(echo "$contig_length / 1000" | bc -l)
  kilobase_adjusted_mapped_count=$(echo "$mapped_segments / $kilobase_length" | bc -l)
  kb_and_lib_size_adjusted_count=$(echo "$kilobase_adjusted_mapped_count / $LIB_SIZE" | bc -l)
  printf "$contig,$contig_length,$kb_and_lib_size_adjusted_count,$unmapped_segments\n" >> "${LOBEL}_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv"
done < "$INPF"
