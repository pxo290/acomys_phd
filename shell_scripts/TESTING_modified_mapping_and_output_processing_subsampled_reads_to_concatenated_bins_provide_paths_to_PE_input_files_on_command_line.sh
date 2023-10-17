#!/bin/bash -eE
#SBATCH -t 01-16:55
#SBATCH -p ei-medium
#SBATCH -J Modded_SpecBWA_SAMPLES
#SBATCH -c 2
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Written  2021-04-18
#This is an ugly script which will do a couple of things
# 1. Copy the concatenated bin fasta file and index it
# 2. Map the reads to this copy using BWA
# 3. Analyse the mapping

#Setting the trap condition, which will be an error. We want the trap being triggered
#to execute a function to rezip the input files after they had been unzipped
record_error_and_rezip() {
  local lineno=$1
  local msg=$2
  printf "\nI encountered an error\n" && cd $LOCALE
  printf "\nWill rezip input files\n"
  sobjects=$(find -maxdepth 1 -type f -name "$inpf1" -o -name "$inpf2")
  for f in $sobjects ; do printf "\nWill rezip file:\t$f\n" && gzip "$f" || printf "\nFile:\t$f\twas already zipped\n" ; done
  subjects=$(find -maxdepth 1 -type f -name "${LABEL}_for_mapping_reference_INDEXED*")
  for f in $subjects
  do
    printf "\nRemoving this file:\t$f\n"
    rm $f
  done
  danger_close=$(find -maxdepth 1 -type f -name "*$LABEL*" -not -name "*.gz" -not -name "*.fastq")
  for f in $danger_close
  do
    printf "\nRemoving this file:\t$f\n"
    rm $f
  done && echo && echo && echo && printf "\n-_-_-_-_-_-_-_-"
  echo "Failed at:$lineno$msg"
}

trap 'record_error_and_rezip ${LINENO} "$BASH_COMMAND"' ERR

#Now to get the bin, and then the reads provided on the command line
#this time for the sake of laziness when writing this code

#User provided variables, paths to the files
export MEGAHIT_ASSEMBLY="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/Kaiju_testing/BWA-testing/Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_FILES.fa"
export inpf1=$1
export inpf2=$2

#Making a label for use throughout
export LABEL=$(basename "$inpf1" | awk -F "-" '{print $2}' | awk -F "_R1" '{print $1}')
export label="$LABEL"

#Getting where we are
export LOCALE=$(pwd)

#Getting where we will end up
export DESTINATION="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index"

#Sourcing software needed
source package /tgac/software/testing/bin/bwa-0.7.7
source package /tgac/software/testing/bin/samtools-1.10
source package /tgac/software/testing/bin/bedtools-2.30.0

#Making a copy of the assembly for safetys' sake and indexing
cp "$MEGAHIT_ASSEMBLY" "${LOCALE}/${LABEL}_Megahit_assembly_for_mapping_reference.fa"
bwa index -p "${LABEL}_for_mapping_reference_INDEXED" "${LOCALE}/${LABEL}_Megahit_assembly_for_mapping_reference.fa"

###TURNS OUT THAT BWA CAN HANDLE ZIPPED INPUT FILES SO THERE IS NO NEED TO UNZIP THEM
###USEFUL SINCE THIS BIT BELOW KEEPS BREAKING IN DIFFERENT WAYS
#Checking if read files are zipped and unzipping them if they are
# basename "$inpf1" | grep -q ".gz" && inpf1_zip_check="Y" || inpf1_zip_check="N"
# basename "$inpf2" | grep -q ".gz" && inpf2_zip_check="Y" || inpf2_zip_check="N"
# if [ "$inpf1_zip_check" = "Y" ]
# then
#   printf "\nFirst PE read file was zipped, will unzip it\n"
#   unzipnf1=$(basename "$inpf1" | awk -F ".gz" '{print $1}' | awk 'NF')
#   gunzip "$inpf1"
#   export inpf1=$(printf "$unzipnf1")
#   printf "\nNow the variable inpf1 should be unzipped, check it is here:\t$inpf1\n"
# else
#   printf "\nFirst input read file was not zipped\n"
# fi
# if [ "$inpf2_zip_check" = "Y" ]
# then
#   printf "\nSecond PE read file was zipped, will unzip it\n"
#   unzipnf2=$(basename "$inpf2" | awk -F ".gz" '{print $1}' | awk 'NF')
#   gunzip "$inpf2"
#   export inpf2=$(printf "$unzipnf2")
#   printf "\nNow the variable inpf2 should be unzipped, check it is here:\t$inpf2\n"
# else
#   printf "\nSecond input read file was not zipped\n"
# fi
###
###
#Writing the mapping stage
bwa mem -t 2 -v 2 -a "${LABEL}_for_mapping_reference_INDEXED" "$inpf1" "$inpf2" > ${label}_BWA_reads_mapped_to_bins.sam

#Using Samtools to check a valid .sam file has been made
samtools quickcheck "${label}_BWA_reads_mapped_to_bins.sam" && sam_validity_test="P" || sam_validity_test="F"

#Using this check as a pass fail for moving on further
if [[ "$sam_validity_test" = "P" ]]
then
  printf "\nMade a good .sam file:\t${label}_BWA_reads_mapped_to_bins.sam\n"
elif [[ "$sam_validity_test" = "F" ]]
then
  printf "\nDid not make a good .sam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
else
  printf "\nSomething else odd happened when trying to make a good .sam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
fi

#Since you should only be here if the .sam is properly formatted, lets make it into a much smaller .bam file
samtools view -@2 -b -S "${label}_BWA_reads_mapped_to_bins.sam" > "${label}_BWA_reads_mapped_to_assembly.bam"

#Using Samtools to check a valid .bam file has been made
samtools quickcheck "${label}_BWA_reads_mapped_to_assembly.bam" && sam_validity_test2="P2" || sam_validity_test2="F2"

#Using this check as a pass fail for moving on further
if [[ "$sam_validity_test2" = "P2" ]]
then
  printf "\nMade a good .bam file:\t${label}_BWA_reads_mapped_to_assembly.bam\n"
  printf "\nWe don't need the .sam file anymore"
  rm "${label}_BWA_reads_mapped_to_bins.sam"
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
  gzip "${label}_BWA_reads_mapped_to_assembly.bam" && printf "\nFinished zipping up ${label}_BWA_reads_mapped_to_assembly.bam\n"
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
samtools view -H "${label}_BWA_reads_mapped_to_assembly.MAPPED.bam" | perl -ne 'if ($_ =~ m/^\@SQ/) { print $_ }' | perl -ne 'if ($_ =~ m/SN:(.+)\s+LN:(\d+)/) { print $1, "\t", $2, "\n"}' > "${LABEL}_lengths.genome" && printf "\nMade the file:\t${LABEL}_lengths.genome\n"
#Now we need to sort the MAPPED.bam file
samtools sort -m 100G "${label}_BWA_reads_mapped_to_assembly.MAPPED.bam" > "${label}_BWA_reads_mapped_to_assembly.MAPPED.SORTED.bam" && printf "\Made the file:\t${label}_BWA_reads_mapped_to_assembly.MAPPED.SORTED.bam\n"
#Again, do a quick check that this is still a nicely formatted bam file
samtools quickcheck "${label}_BWA_reads_mapped_to_assembly.MAPPED.SORTED.bam" && sam_validity_test4="P4" || sam_validity_test3="F4"
if [[ "$sam_validity_test4" = "P4" ]]
then
  printf "\nMade a good sorted, mapped reads only .bam file:\t${label}_BWA_reads_mapped_to_assembly.MAPPED.SORTED.bam\n"
  printf "\nWe don't need the unsorted, mapped .bam file to be readily accessible anymore"
  gzip "${label}_BWA_reads_mapped_to_assembly.MAPPED.bam" && printf "\nZipped up the file:\t${label}_BWA_reads_mapped_to_assembly.MAPPED.bam\n"
elif [[ "$sam_validity_test4" = "F4" ]]
then
  printf "\nDid not make a good sorted, mapped reads only .bam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
else
  printf "\nSomething else odd happened when trying to make a good mapped reads only .bam file trying to map $inpf1 and $inpf2 to ${LABEL}_for_mapping_reference.fa\n"
  exit 1
fi
#Now using this to get the per-base coverage
bedtools genomecov -ibam "${label}_BWA_reads_mapped_to_assembly.MAPPED.SORTED.bam" -d -g "${LABEL}_lengths.genome" > "${label}_mapped_sorted.bam.perbase.cov" && printf "\nMade the file:\t${label}_mapped_sorted.bam.perbase.cov\n" || printf "\nFailed on line 180\n"
#Now fetching only those positions where there is greater than 0 coverage
awk -F "\t" '$3>0{print $1}' "${label}_mapped_sorted.bam.perbase.cov" | sort | uniq -c > "${label}.mapped.bam.perbase.cov.count" && printf "\nMade file:\t${label}.mapped.bam.perbase.cov.count\n" || printf "\nFailed on line 182\n"
#Now calculate the proportions for the contigs to the bins
while IFS=$'\t' read -r -a myArray; do echo -e "${myArray[0]},$(echo "scale=5;"$(awk -v pattern="${myArray[0]}" '$2==pattern{print $1}' "${label}.mapped.bam.perbase.cov.count")"/"${myArray[1]} | bc ) "; done < "${LABEL}_lengths.genome" > "${LABEL}.mapped.bam.genomeproportion" && printf "\nMade file:\t${LABEL}.mapped.bam.genomeproportion\n" || printf "\nFailed on line 184\n"

#Modified version 2021-19-04
#while IFS=$'\t' read -r -a myArray; do echo -e "${myArray[0]},$(echo "scale=5;"$(awk -v pattern="${myArray[0]}" '$2==pattern{print $1}' ${label}.mapped.bam.perbase.cov.count)"/"${myArray[1]} | bc ) "; done < "${LABEL}_lengths.genome" > "${LABEL}.mapped.bam.genomeproportion" && printf "\nMade file:\t${LABEL}.mapped.bam.genomeproportion\n" || printf "\nFailed on line 187\n"

#Pull out the contigs which didn't match but which are in the genome proportion file anyway since it was made using the lengths of all contigs
grep -v '\,[0-9.]' "${LABEL}.mapped.bam.genomeproportion" >> "${LABEL}_non_mapping_contigs_from_genome_lengths_file.txt" && printf "\nMade file:\t${LABEL}_non_mapping_contigs_from_genome_lengths_file.txt\n"
#Make a file which only contains contigs that did actually map from the genome lengths file
grep '\,[0-9.]' "${LABEL}.mapped.bam.genomeproportion" >> "${LABEL}_mapped_sorted_BAM_contigs_mapping_any_proportion.txt" && printf "\nMade file:\t${LABEL}_mapped_sorted_BAM_contigs_mapping_any_proportion.txt\n"
#Make a file which only contains contigs which mapped entirely to the reads
grep '\,1.' "${LABEL}.mapped.bam.genomeproportion" >> "${LABEL}_mapped_sorted_BAM_contigs_mapping_entire_contig.txt" || printf "\nEither there were no absolute mapping reads, or something else went wrong\n"
cp "${LABEL}_mapped_sorted_BAM_contigs_mapping_entire_contig.txt" "${LABEL}_absolute_confidence_mapping.txt"
#Identify any contigs which had a mapping proportion greater than or equal to 0.99 but less than 1
awk -F "," '($NF>=0.99 && $NF<1.00){print $0}' "${LABEL}.mapped.bam.genomeproportion" >> "${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_greater_than_or_equal_to_0_point_99.txt" && printf "\nMade file:\t${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_greater_than_or_equal_to_0_point_99.txt\n" || printf "\nFailed on line 197\n"
cp "${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_greater_than_or_equal_to_0_point_99.txt" "${LABEL}_high_confidence_mapping.txt"
#Identify any contigs which had a mapping proportion greater than or equal to 0.75 but less than 0.99
awk -F "," '($NF>=0.75 && $NF<0.99){print $0}' "${LABEL}.mapped.bam.genomeproportion" >> "${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_between_point_75_and_99.txt" && printf "\nMade file:\t${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_between_point_75_and_99.txt\n" || printf "\nFailed on line 200\n"
cp "${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_between_point_75_and_99.txt" "${LABEL}_medium_confidence_mapping.txt"
#Identify any contigs which had a mapping proportion below 0.75 but did actually map
awk -F "," '($NF<0.75){print $0}' "${LABEL}_mapped_sorted_BAM_contigs_mapping_any_proportion.txt" >> "${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_below_point_75.txt" && printf "\nMade file:\t${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_below_point_75.txt\n"
cp "${LABEL}_mapped_sorted_BAM_contigs_mapping_proportion_below_point_75.txt"  "${LABEL}_poor_confidence_mapping.txt"
#Tidying up
targets=$(find -maxdepth 1 -type f -name "${LABEL}_for_mapping_reference_INDEXED*")
for f in $targets
do
  printf "\nRemoving this file:\t$f\n"
  rm $f
done
gzip "${LABEL}_Megahit_assembly_for_mapping_reference.fa"
mv "${LABEL}_Megahit_assembly_for_mapping_reference.fa.gz" "$DESTINATION"
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
#Last tidying stage since I've noticed that the largest file by far in the output
#is the perbase coverage file
cd "$DESTINATION"
targets3=$(find -maxdepth 1 -type f -name "${label}_mapped_sorted.bam.perbase.cov" -not -name "*.count" -not -name "*.gz")
for f in $targets3
do
  printf "\nWill gzip this file:\t$f\n"
  gzip "$f"
done
