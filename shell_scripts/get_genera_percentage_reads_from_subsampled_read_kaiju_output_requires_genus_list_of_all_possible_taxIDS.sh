#!/bin/bash -e
#SBATCH -t 00-05:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J genus_compare
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#24/03/21
#This script has some hard coded stuff in it, but it will go through genera level
#Kaiju ouput in the same directory and use a list of all detected genera across
#all samples to try and make a matrix containing all the % of reads matching each
#genus in the PE sample for each genus in the list.

#If you need to make the file long_list_genera.txt use following command:
#for f in *_kaiju_output-GENERA.out ; do cat $f | grep -v "percent" | grep -v "^Viruses$" | grep -v "^cannot be assigned to a (non-viral) genus$" | head -n -1 | awk -F "\t" '{print $4}' ; done | sed 's/[A-Za-z]*//g' | awk 'NF' | sort -V | uniq >> long_list_genera.txt
#This will have produced the long list which has all the unique genera taxIDS
#found across all the kaiju genera outputs

touch all_samples_all_genera_taxIDs_kaiju_percentage_detection.txt
printf "Genera\n" >> all_samples_all_genera_taxIDs_kaiju_percentage_detection.txt
cat long_list_genera.txt >> all_samples_all_genera_taxIDs_kaiju_percentage_detection.txt
for f in *_kaiju_output-GENERA.out
do
  lobel=$(basename $f | awk -F "_" '{print $1}')
  printf "\n$lobel"
  touch ${lobel}_all_genera_taxIDs_percentages_only.txt
  printf "$lobel" >> ${lobel}_all_genera_taxIDs_percentages_only.txt
  while read -r line
  do
    if grep -q "\b$line\b" $f
    then
      found_percent=$(cat $f | awk '{if ($4 == '"$line"') print $0;}' | awk -F "\t" '{print $2}')
      printf "\n$found_percent" >> ${lobel}_all_genera_taxIDs_percentages_only.txt
      printf "\n$line\t$found_percent"
    else
      found_percent="0"
      printf "\n$found_percent" >> ${lobel}_all_genera_taxIDs_percentages_only.txt
      printf "\n$line\t$found_percent"
    fi
  done < long_list_genera.txt
  sleep 3s
  list_length=$(wc -l ${lobel}_all_genera_taxIDs_percentages_only.txt)
  printf "\n$label list of percentages is this long:\t$list_length"
  if [[ "$list_length" > "4652" ]]
  then
    printf "\nFAILED on sample from $label\tList is too LONG\n"
  elif [[ "$list_length" < "4651" ]]
  then
    printf "\nFAILED on sample from $label\tList is too SHORT\n"
  else
    printf "\nPASSED on sample from $label\tList should be the right length\n"
  fi
done
paste all_samples_all_genera_taxIDs_kaiju_percentage_detection.txt *_all_genera_taxIDs_percentages_only.txt >> Percentage_reads_all_samples_all_genera_kaiju.txt
sleep 5s
mail -s "Genera TaxIDs and percentages from Kaiju" -a Percentage_reads_all_samples_all_genera_kaiju.txt peter.osborne@earlham.ac.uk <<< "File should be attached as indicated"
export origin_point=$(pwd)
mkdir TEMPORARY_OUTPUT_FROM_GENUS_COMPARE
cd TEMPORARY_OUTPUT_FROM_GENUS_COMPARE
export destination_point=$(pwd)
cd $origin_point
mv *_all_genera_taxIDs_percentages_only.txt $destination_point
mv all_samples_all_genera_taxIDs_kaiju_percentage_detection.txt $destination_point
