#!/bin/bash -e
#SBATCH -t 00-00:50
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J NamePlace
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export species_list=$1
label=$(echo $species_list | awk -F "_" '{print $1,$2}' | sed 's/ /_/g')
# while IFS= read -r line ; do
#   line_no=$(grep -n "$line" Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_FILES.fa | awk -F ":" '{print $1}')
#   for f in $line_no
#   do
#     printf "\n$f is the line number in the label file to replace\n"
#     #sed -i -e "${f}s/0/$label/g" labels.txt
#     #sed -i "${f}s/0/$label/g" labels.txt >> "${label}_modified_label_list.txt"
#     #sed -i "${f}s/0/$label/g" labels.txt > TEMP_1_labels.txt
#     #sed "${f}s/.*/$label/g" labels.txt > TEMP_1_labels.txt
#     #sed -i "${f}s/placeholder/$label/g" labels.txt
#     #sed -i "${f}s/placeholder/$label/g" new_labels.txt
#     awk "NR==$f { sub( "placeholder", $label) }" new_labels.txt
#     printf "\nInserted text:$label\tat position: $f"
#   done
# done < $species_list

while IFS= read -r line ; do
  line_no=$(grep -n "$line" Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_FILES.fa | awk -F ":" '{print $1}')
  printf "$line_no" >> temporary_bin_number.txt
done < $species_list
while IFS= read -r line ; do
  sed -i "${line}s/placeholder/Lactobacillus animalis/g" new_labels.txt
done < temporary_bin_number.txt
rm temporary_bin_number.txt
