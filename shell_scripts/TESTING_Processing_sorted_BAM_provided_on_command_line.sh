#!/bin/bash -e
#SBATCH -t 02-00:21
#SBATCH -p ei-medium
#SBATCH -J BAM_process
#SBATCH -c 1
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Set fixed variables
export GENOMECOVERAGEFILE="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/bam_stuff_testing/genome_lengths_all_bins.genome"
export BIN_KAIJU_OUTPUT_DB="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/binned_fastas_Kaiju_raw"
export KAIJU_NAMES_FILE="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"

#Sourcing software
source package /tgac/software/testing/bin/samtools-1.10
source package /tgac/software/testing/bin/bedtools-2.30.0

#Set mutable variables
export INPF1=$1
export LABEL=$(basename $INPF1 | awk -F "_" '{print $1}')
export ORIGIN=$(pwd)

#Defining functions
process_BAM_files () {
  inpf1=$1
  label=$2
  origin=$3
  printf "\nWill use Bedtools on input file:\t$inpf1\tto make the file:\t${label}_mapped_sorted.bam.perbase.cov\n"
  bedtools genomecov -ibam "$inpf1" -d -g "$GENOMECOVERAGEFILE" > "${label}_mapped_sorted.bam.perbase.cov"
  printf "\nWill now use some bash to get only positions in ${label}_mapped_sorted.bam.perbase.cov with greater than 0 coverage\n"
  awk -F"\t" '$3>0{print $1}' "${label}_mapped_sorted.bam.perbase.cov" | sort | uniq -c > "${label}_mapped_sorted.bam.perbase.cov.count"
  printf "\nWill now use some more bash to calculate the proportion of each read from all the bins which mapped at least once is covered by the mapping to the reads\n"
  while IFS=$'\t' read -r -a myArray
  do
    echo -e "${myArray[0]},$(echo "scale=5;"$(awk -v pattern="${myArray[0]}" '$2==pattern{print $1}' ${label}_mapped_sorted.bam.perbase.cov.count)"/"${myArray[1]} | bc ) "
  done < "$GENOMECOVERAGEFILE" > ${label}_mapped_sorted.bam.perbase.cov.count.genomeproportion
  printf "\nNow making a note of how many reads from the bins did actually have some level of mapping to the reads\n"
  awk -F "," '{sum+=$NF} END{print "Total reads covered:"sum}' ${label}_mapped_sorted.bam.perbase.cov.count.genomeproportion
  printf "\nNow will use some bash to get the bin reads which mapped to the sample reads at a proportion of 0.99 or lower\n"
  awk -F "," '$NF<=0.99{print $0}' ${label}_mapped_sorted.bam.perbase.cov.count.genomeproportion >> ${label}__bins_mapping_proportion_point_99_or_below.txt
  printf "\nNow will use some bash to get the bin reads which mapped to the sample reads at a proportion of greater than 0.99\n"
  awk -F "," '$NF>0.99{print $0}' ${label}_mapped_sorted.bam.perbase.cov.count.genomeproportion >> ${label}_bins_mapping_proportion_point_99_above.txt
  printf "\nNow trying to do the complicated summary of the greater than 0.99 mapping reads by getting the proportion mapped, read name, bin the read is from, length of the read overall, TaxID from Kaiju and species name from Kaiju after trying to get it using the TaxID\n"
  printf "Proportion of read mapping\tRead name\tBin read is from\tLength of read\tKaiju TaxID\tKaiju species\n" >> ${label}_bins_mapping_proportion_point_99_above_DETAILED.txt
  while read -r line
  do
    read_name=$(echo "$line" | awk -F "," '{print $1}')
    origin=$(pwd)
    cd "$BIN_KAIJU_OUTPUT_DB"
    bin_containing_read=$(grep "$read_name" *_kaiju_output.out | awk -F "kaiju" '{print $1}' | sed 's/binned/Bin/g' | awk -F "_" '{print $1,$2}' | sed 's/ /_/g')
    TAXID_matching=$(grep "$read_name" *_kaiju_output.out | awk -F "\t" '{print $3}')
    science_name=$(cat "$KAIJU_NAMES_FILE" | awk '{if ($1 == '"$TAXID_matching"') print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}')
    cd $origin
    proportion_mapped=$(echo "$line" | awk -F "," '{print $2}')
    read_size=$(grep "\b$read_name\b" genome_lengths_all_bins.genome | awk -F "\t" '{print $2}')
    printf "\n$proportion_mapped\t$read_name\t$bin_containing_read\t$read_size\t$TAXID_matching\t$science_name"
  done < ${label}__bins_mapping_proportion_point_99_or_below.txt >> ${label}_bins_mapping_proportion_point_99_above_DETAILED.txt
  printf "\nShould have finished all the processing of input file $inpf1\n"
  printf "\nIn the finished version this script will delete all the files created after the initial sorted, mapped BAM file aside from the >99 and <99 proportion text files\n"
}

#Execute functions
process_BAM_files $INPF1 $LABEL $ORIGIN
