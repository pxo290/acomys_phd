#!/bin/bash -eE
#SBATCH -t 03-18:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J V2TaxFromContigs&Adjust
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Set fixed variables
export library_size_adjustment='8.5' && echo "$library_size_adjustment"
export runtag=$(date | awk -F " " '{print $2"_"$3"_"$6}' | sed -e 's/^/Collected_results_table_/g') && echo "$runtag"
export locale=$(pwd) && echo "$locale"
#export contigs_2_taxons_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304/taxons_and_their_contigs.txt"

#Doing the job
target=$(find -maxdepth 1 -type f -name "*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -not -name "AC16*" -not -name "AC18*" -not -name "AC19*" -not -name "AR27*" -not -name "AR29*" -not -name "AR32*")
#target=$(find -maxdepth 2 -type f -name "*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -not -name "AC16*" -name "AC18*" -name "AC19*" -name "AR27*" -name "AR29*" -name "AR32*")
#target=$(find -maxdepth 2 -type f -name "*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt")
echo "$target" || printf "\nThe target variable is empty for some reason\n"
printf "\n$target\n"
for f in $target
do
  export subject_file=$(basename "$f")
  printf "\nWill work through file:\t$f\n"
  lobel=$(basename "$f" | awk -F "_" '{print $1}') || echo "Failed line 33"
  label=$(printf "${runtag}_${lobel}") || echo "Failed line 34"
  printf "Microorganism\t$lobel" > "${label}_collected_taxon_scores-V2.txt" || echo "Failed line 35"
  while read -r line
  do
    taxon=$(printf "$line") && printf "\nThe taxon now will be:\t$taxon\n" || echo "Failed line 38"
    #contigs=$(grep "£${taxon}@" 2021_05_13_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs_pound_sign_start_of_each_line.txt | awk -F "@" '{print $2}' | tr "," " " | sort -V | uniq | tr "\n" " ") || echo "Failed line 39"
    contigs=$(grep "£${taxon}@" 2021_05_13_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs_pound_sign_start_of_each_line.txt | awk -F "@" '{print $2}' | tr "," "\n" | sort -V | tr "\n" ",") || echo "Failed line 40"
    number_of_contigs=$(echo "$contigs" | tr "," "\n" | wc -l) && echo "There are this many contigs for taxon $taxon: $number_of_contigs"
    printf "\nLine 41 thinks the contigs are as follows:\t$contigs\n-_-_-_-_-_-_-_-\n"
    sleep 10s
    #while IFS=" " read -ra contig_array
    while IFS="," read -ra contig_array
    do
      for i in "${contig_array[@]}"
      do
        #contiger=$(printf "$i")
        printf "\nFor the Taxon:\t$taxon\nThis is a contig apparently:\t$i\n"
        score=$(grep -w "$i" "$subject_file" | awk -F "\t" '{print $2}' | awk '{printf "%f", $0}')
        taxfilename=$(printf "$taxon" | sed 's/ /_/g')
        printf "$i\t$score\n" >> "${label}_${taxfilename}_TEMP_ARRAY_FILE-V2.txt"
      done
    done <<< "$contigs"
    summed_score=$(cat ${label}_${taxfilename}_TEMP_ARRAY_FILE-V2.txt | awk -F "\t" '{print $2}' | awk 'NF' | paste -s -d+ - | bc -l) || echo "Failed line 56"
    adjusted_score=$(echo "$summed_score / $library_size_adjustment" | bc -l) || echo "Failed line 57"
    printf "\n$taxon\t$adjusted_score" >> "${label}_collected_taxon_scores-V2.txt" || echo "Failed line 58"
    rm "${label}_${taxfilename}_TEMP_ARRAY_FILE-V2.txt" || echo "Failed line 59"
  done < all_unique_taxons_incluing_unclassified_from_all_contigs_across_all_bins_list.square_and_curly_brackets_removed.txt || echo "Failed line 60"
  printf "\nI will wait here for 10 minutes. REMOVE THIS LINE IN FINAL SCRIPT!\n" && sleep 10m
done
