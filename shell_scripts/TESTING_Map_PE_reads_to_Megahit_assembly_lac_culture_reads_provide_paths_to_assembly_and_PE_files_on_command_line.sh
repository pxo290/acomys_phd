#!/bin/bash -eE
#SBATCH -t 00-12:55
#SBATCH -p ei-largemem
#SBATCH -J RRSpecBWA
#SBATCH -c 2
#SBATCH --mem=615gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Written  2021-04-12
#This is an ugly script which will do a couple of things
# 1. Copy the megahit assembly made from some PE reads
# 2. Map the reads to this copy using BWA
# 3. Analyse the mapping

#First things first is to get the assembly and reads provided on the command line
#this time for the sake of laziness when writing this code

#User provided variables, paths to the files
export MEGAHIT_ASSEMBLY=$1
export inpf1=$2
export inpf2=$3

#Making a label for use throughout
export LABEL=$(basename "$MEGAHIT_ASSEMBLY" | awk -F "_R1" '{print $1}')
export label="$LABEL"

#Getting where we are
export LOCALE=$(pwd)

#Getting where we will end up
export DESTINATION="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/BWA_outputs"

#Sourcing software needed
source package /tgac/software/testing/bin/bwa-0.7.7
source package /tgac/software/testing/bin/samtools-1.10
source package /tgac/software/testing/bin/bedtools-2.30.0

#Making a copy of the assembly for safetys' sake and indexing
cp "$MEGAHIT_ASSEMBLY" "${LOCALE}/${LABEL}Megahit_assembly_for_mapping_reference.fa"
bwa index -p "${LABEL}_for_mapping_reference_INDEXED" "${LOCALE}/${LABEL}Megahit_assembly_for_mapping_reference.fa"

#Writing the mapping stage
bwa mem -t 2 -v 2 -a "${LABEL}_for_mapping_reference_INDEXED" "$inpf1" "$inpf2" > ${label}_BWA_reads_mapped_to_assembly.sam

#Using Samtools to check a valid .sam file has been made
samtools quickcheck "${label}_BWA_reads_mapped_to_assembly.sam" && sam_validity_test="P" || sam_validity_test="F"

#Using this check as a pass fail for moving on further
if [[ "$sam_validity_test" = "P" ]]
then
  printf "\nMade a good .sam file:\t${label}_BWA_reads_mapped_to_assembly.sam\n"
elif [[ "$sam_validity_test" = "F" ]]
then
  printf "\nDid not make a good .sam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
else
  printf "\nSomething else odd happened when trying to make a good .sam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
fi

#Since you should only be here if the .sam is properly formatted, lets make it into a much smaller .bam file
samtools view -@2 -b -S "${label}_BWA_reads_mapped_to_assembly.sam" > "${label}_BWA_reads_mapped_to_assembly.bam"

#Using Samtools to check a valid .bam file has been made
samtools quickcheck "${label}_BWA_reads_mapped_to_assembly.bam" && sam_validity_test2="P2" || sam_validity_test2="F2"

#Using this check as a pass fail for moving on further
if [[ "$sam_validity_test2" = "P2" ]]
then
  printf "\nMade a good .bam file:\t${label}_BWA_reads_mapped_to_assembly.bam\n"
  printf "\nWe don't need the .sam file anymore"
  rm "${label}_BWA_reads_mapped_to_assembly.sam"
elif [[ "$sam_validity_test2" = "F2" ]]
then
  printf "\nDid not make a good .bam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
else
  printf "\nSomething else odd happened when trying to make a good .bam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
fi

#Now making the useful .bam files
#First only mapping reads (excluding reads with flag 4, which are unmapped)
samtools view -@2 -b -F 4 "${label}_BWA_reads_mapped_to_assembly.bam" > "${label}_BWA_reads_mapped_to_assembly.MAPPED.bam"

#Now quickly checking this MAPPED.bam file's validity
samtools quickcheck "${label}_BWA_reads_mapped_to_assembly.MAPPED.bam" && sam_validity_test3="P3" || sam_validity_test3="F3"

#Using this check as a pass fail for moving on further
if [[ "$sam_validity_test3" = "P3" ]]
then
  printf "\nMade a good mapped reads only .bam file:\t${label}_BWA_reads_mapped_to_assembly.MAPPED.bam\n"
  printf "\nWe don't need the original .bam file to be readily accessible anymore"
  gzip "${label}_BWA_reads_mapped_to_assembly.bam"
elif [[ "$sam_validity_test3" = "F3" ]]
then
  printf "\nDid not make a good mapped reads only .bam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
else
  printf "\nSomething else odd happened when trying to make a good mapped reads only .bam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
fi

#Now on to the processing steps of the mapped bam file
#Pretty much all of this is just adapted from this - http://userweb.eng.gla.ac.uk/umer.ijaz/bioinformatics/BWA_tutorial.pdf
#First up is making a genome length file
samtools view -H "${label}_BWA_reads_mapped_to_assembly.MAPPED.bam" | perl -ne 'if ($_ =~ m/^\@SQ/) { print $_ }' | perl -ne 'if ($_ =~ m/SN:(.+)\s+LN:(\d+)/) { print $1, "\t", $2, "\n"}' > "${LABEL}_lengths.genome"
#Now we need to sort the MAPPED.bam file
samtools sort -m 100G "${label}_BWA_reads_mapped_to_assembly.MAPPED.bam" > "${label}_BWA_reads_mapped_to_assembly.MAPPED.SORTED.bam"
#Again, do a quick check that this is still a nicely formatted bam file
samtools quickcheck "${label}_BWA_reads_mapped_to_assembly.MAPPED.SORTED.bam" && sam_validity_test4="P4" || sam_validity_test3="F4"
if [[ "$sam_validity_test4" = "P4" ]]
then
  printf "\nMade a good sorted, mapped reads only .bam file:\t${label}_BWA_reads_mapped_to_assembly.MAPPED.SORTED.bam\n"
  printf "\nWe don't need the unsorted, mapped .bam file to be readily accessible anymore"
  gzip "${label}_BWA_reads_mapped_to_assembly.MAPPED.bam"
elif [[ "$sam_validity_test4" = "F4" ]]
then
  printf "\nDid not make a good sorted, mapped reads only .bam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
else
  printf "\nSomething else odd happened when trying to make a good mapped reads only .bam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
fi
#Now using this to get the per-base coverage
bedtools genomecov -ibam "${label}_BWA_reads_mapped_to_assembly.MAPPED.SORTED.bam" -d -g "${LABEL}_lengths.genome" > "${label}_mapped_sorted.bam.perbase.cov"
#Now fetching only those positions where there is greater than 0 coverage
awk -F"\t" '$3>0{print $1}' "${label}_mapped_sorted.bam.perbase.cov" | sort | uniq -c > "${label}.mapped.bam.perbase.cov.count"
#Now calculate the proportions for the contigs to the bins
while IFS=$'\t' read -r -a myArray; do echo -e "${myArray[0]},$(echo "scale=5;"$(awk -v pattern="${myArray[0]}" '$2==pattern{print $1}' "${label}.mapped.bam.perbase.cov.count")"/"${myArray[1]} | bc ) "; done < "${LABEL}_lengths.genome" > "${LABEL}.mapped.bam.genomeproportion"
#Identify any contigs which had a mapping proportion greater than 0.99
awk -F "," '$NF>0.99{print $0}' "${LABEL}.mapped.bam.genomeproportion" >> "${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_greater_0_point_99.txt"

#Tidying up
targets=$(find -maxdepth 1 -type f -name "${LABEL}_for_mapping_reference_INDEXED*")
for f in $targets
do
  printf "\nRemoving this file:\t$f\n"
  rm $f
done
gzip "${LABEL}Megahit_assembly_for_mapping_reference.fa"
mv "${LABEL}Megahit_assembly_for_mapping_reference.fa.gz" "$DESTINATION"
targets1=$(find -maxdepth 1 -type f -name "*$LABEL*" -name "*.bam*")
for f in $targets1
do
  printf "\nMoving this file:\t$f\n"
  printf "\nTo here:\t$DESTINATION\n"
  mv "$f" "$DESTINATION"
done
targets2=$(find -maxdepth 1 -type f -name "*$LABEL*" -not -name "*.fastq*")
for f in $targets2
do
  printf "\nMoving this file:\t$f\n"
  printf "\nTo here:\t$DESTINATION\n"
  mv "$f" "$DESTINATION"
done
