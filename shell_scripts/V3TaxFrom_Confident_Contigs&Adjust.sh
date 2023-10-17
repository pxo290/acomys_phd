#!/bin/bash -eE
#SBATCH -t 03-18:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J V3TaxFrom_Confident_Contigs&Adjust
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
export library_size_adjustment=$2 && echo "$library_size_adjustment"
export runtag=$(date | awk -F " " '{print $2"_"$3"_"$6}' | sed -e 's/^/Collected_results_table_/g') && echo "$runtag"
export locale=$(pwd) && echo "$locale"

#Doing the job
target=$1
echo "$target" || printf "\nThe target variable is empty for some reason\n"
printf "\n$target\n"
for f in $target
do
  export subject_file=$(basename "$f")
  export unique_sample_tag=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64)
  printf "\nWill work through file:\t$f\n"
  lobel=$(basename "$f" | awk -F "_" '{print $1}') || echo "Failed line 31"
  label=$(printf "${unique_sample_tag}_Confident_contigs_${runtag}_${lobel}") || echo "Failed line 32"
  printf "Microorganism\t$lobel" > "${label}_collected_taxon_scores-V3.txt" || echo "Failed line 33"
  while read -r line
  do
    taxon=$(printf "$line") && printf "\nThe taxon now will be:\t$taxon\n" || echo "Failed line 36"
    contigs=$(grep "£${taxon}@" 2021_05_18_Kaiju_score_over_50_unique_taxons_and_their_contigs.txt | awk -F "@" '{print $2}' | tr "," "\n" | sort -V | tr "\n" "," | sed 's/,*$//g') || echo "Failed line 37"
    number_of_contigs=$(echo "$contigs" | tr "," "\n" | wc -l) && echo "There are this many contigs for taxon $taxon: $number_of_contigs"
    printf "\nLine 39 thinks the contigs are as follows:\t$contigs\n-_-_-_-_-_-_-_-\n"
    sleep 10s
    while IFS="," read -ra contig_array
    do
      for i in "${contig_array[@]}"
      do
        printf "\nFor the Taxon:\t$taxon\nThis is a contig apparently:\t$i\n"
        score=$(grep -w "$i" "$subject_file" | awk -F "\t" '{print $2}' | awk '{printf "%f", $0}')
        taxfilename=$(printf "$taxon" | sed 's/ /_/g')
        printf "$i\t$score\n" >> "${label}_${taxfilename}_TEMP_ARRAY_FILE-V3.txt"
      done
    done <<< "$contigs"
    summed_score=$(cat "${label}_${taxfilename}_TEMP_ARRAY_FILE-V3.txt" | awk -F "\t" '{print $2}' | awk 'NF' | paste -s -d+ - | bc -l) && printf "\nThe summed_score is:\t$summed_score\n" || echo "Failed line 51"
    adjusted_score=$(echo "$summed_score / $library_size_adjustment" | bc -l) && printf "\nThe adjusted_score is:\t$adjusted_score\n" || echo "Failed line 52"
    printf "\n$taxon\t$adjusted_score" >> "${label}_collected_taxon_scores-V3.txt" && printf "\nFor:\t$taxon\tThe final kilobase and library size adjusted summed contig score for Samtools idxstats mapping is:\t$adjusted_score" || echo "Failed line 53"
    rm "${label}_${taxfilename}_TEMP_ARRAY_FILE-V3.txt" || echo "Failed line 54"
  done < 2021_05_18_Kaiju_score_over_50_unique_taxons_only.txt || echo "Failed line 55"
  printf "\nProcessed file:\t$f\n"
done
