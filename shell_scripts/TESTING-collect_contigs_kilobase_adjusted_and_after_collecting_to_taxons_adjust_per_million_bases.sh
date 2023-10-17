#!/bin/bash -eE
#SBATCH -t 03-18:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J TaxFromContigs&Adjust
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Set fixed variables
#First library size adjustment is for the newer samples, second is for the pilot samples.
#Hash out the one which is not needed
#export library_size_adjustment='8.5' && echo "$library_size_adjustment"
export library_size_adjustment='4.5' && echo "$library_size_adjustment"
export runtag=$(date | awk -F " " '{print $2"_"$3"_"$6}' | sed -e 's/^/Collected_results_table_/g') && echo "$runtag"
export locale=$(pwd) && echo "$locale"
#export contigs_2_taxons_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304/taxons_and_their_contigs.txt"

#Doing the job
#Hash out the sample nome when not doing the pilot samples, and use the 2nd target find.
#If doing the pilot samples you will use the sample_nome and 1st target find. You have to give it the species and individual on the command line though in that case
export sample_nome=$1
target=$(find -maxdepth 2 -type f -name "*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -and -name "$sample_nome*")
#target=$(find -maxdepth 2 -type f -name "*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -not -name "AC16*" -not -name "AC18*" -not -name "AC19*" -not -name "AR27*" -not -name "AR29*" -not -name "AR34*")
echo "$target" || printf "\nThe target variable is empty for some reason\n"
printf "\n$target\n"
for f in $target
do
  printf "\nWill work through file:\t$f\n"
  lobel=$(basename "$f" | awk -F "_" '{print $1}')
  #If doing pilot samples use the first label variable and hash out the second.
  #If doing the non-pilot samples then use the second label variable and hash out the first
  label=$(printf "${runtag}_${lobel}_PILOT_SAMPLE_4500000_read_size_library")
  label=$(printf "${runtag}_${lobel}")
  printf "Microorganism\t$lobel" > "${label}_collected_taxon_scores.txt"
  while read -r line
  do
    taxon=$(printf "$line") || echo "Failed line 37"
    contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," "\n") || echo "Failed line 38"
    summed_score=$(grep "$contigs" "$f" | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l) || echo "Failed line 39"
    adjusted_score=$(echo "$summed_score / $library_size_adjustment" | bc -l) || echo "Failed line 40"
    printf "\n$taxon\t$adjusted_score" >> "${label}_collected_taxon_scores.txt" || echo "Failed line 41"
  done < all_unique_taxons_incluing_unclassified_from_all_contigs_across_all_bins_list.square_and_curly_brackets_removed.txt
done
