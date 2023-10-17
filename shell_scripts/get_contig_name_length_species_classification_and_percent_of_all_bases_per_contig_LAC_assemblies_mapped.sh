#!/bin/bash -eE
#SBATCH -t 00-00:20
#SBATCH -p ei-short
#SBATCH -J Lac_culture_contig_class_size_mapping_confidence
#SBATCH -c 1
#SBATCH --mem=4gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  rm "TEMP_${label}_poor_confidence_contigs.txt"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

for f in *poor_confidence_mapping.txt
do
  label=$(basename "$f" | awk -F "_poor" '{print $1}') || echo "Skip fail"
  cat "$f" | awk -F "," '{print $1}' >> "TEMP_${label}_poor_confidence_contigs.txt" || echo "Skip fail"
  relevant_kaiju_file=$(find -maxdepth 1 -type f -name "*$label*" -name "*.names_added.out") || echo "Skip fail"
  relevant_assembly_file=$(find -maxdepth 1 -type f -name "*$label*" -name "*Megahit_assembly_for_mapping_reference.fa.gz") || echo "Skip fail"
  total_bases_in_assembly=$(zcat "$relevant_assembly_file" | grep 'len' | awk -F "len=" '{print $2}' | paste -sd+ - | bc -l) || echo "Skip fail"
  printf "Contig\tConfidence\tSpecies_of_contig_from_Kaiju\tContig_length\tPercent_assebly_bases_in_contig" >> "${label}_poor_contigs_confidence_and_species.txt" || echo "Skip fail"
  while read -r line
  do
    contig_name="$line" || echo "Skip fail"
    contig_confidence_mapping=$(grep -w "$line" "$f" | awk -F "," '{print $2}') || echo "Skip fail"
    contig_length=$(zcat "$relevant_assembly_file" | grep -w ">$line" | awk -F "len=" '{print $2}') || echo "Skip fail"
    contig_species=$(grep -w "$line" "$relevant_kaiju_file" | rev | awk -F ";" '{print $2}' | rev) || echo "Skip fail"
    contig_percent_assembly_bases=$(echo "($contig_length / $total_bases_in_assembly) * 100" | bc -l | awk '{printf "%f", $0}') || echo "Skip fail"
    if [ -z "$contig_species" ]
    then
      contig_species="Unclassified" || echo "Skip fail"
      printf "\n$contig_name\t$contig_confidence_mapping\t$contig_species\t$contig_length\t$contig_percent_assembly_bases" >> "${label}_poor_contigs_confidence_and_species.txt" || echo "Skip fail"
    else
      if [ "$contig_species" = "NA" ]
      then
        contig_species2=$(grep -w "$line" "$relevant_kaiju_file" | rev | awk -F ";" '{print $3}' | rev | sed 's/^[[:space:]]*//')
        printf "\n$contig_name\t$contig_confidence_mapping\t$contig_species2\t$contig_length\t$contig_percent_assembly_bases" >> "${label}_poor_contigs_confidence_and_species.txt" || echo "Skip fail"
      else
        printf "\n$contig_name\t$contig_confidence_mapping\t$contig_species\t$contig_length\t$contig_percent_assembly_bases" >> "${label}_poor_contigs_confidence_and_species.txt" || echo "Skip fail"
      fi
    printf "\n$contig_name\t$contig_confidence_mapping\t$contig_species\t$contig_length\t$contig_percent_assembly_bases"
    fi
  done < "TEMP_${label}_poor_confidence_contigs.txt" || echo "Skip fail"
  rm "TEMP_${label}_poor_confidence_contigs.txt" || echo "Skip fail"
done
