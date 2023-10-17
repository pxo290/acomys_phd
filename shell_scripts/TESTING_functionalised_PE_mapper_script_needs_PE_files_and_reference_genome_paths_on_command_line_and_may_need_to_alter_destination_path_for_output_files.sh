#!/bin/bash -eE
#SBATCH -t 01-12:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J BWA-Map
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Written  2021-05-01
#Hopefully a more concise script which is being written to map the Lac culture
#reads against reference genomes downloaded from NCBI for the species which was
#the classification for the most contigs made by Megahit when it assembled the
#reads

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software
source package /tgac/software/testing/bin/bwa-0.7.7
source package /tgac/software/testing/bin/samtools-1.10

#Defining constant variables
export DESTINATION='/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reads_mapped_to_reference_of_most_likely_species_from_Kaiju_analysis_of_megahit_assembly'

#Defining functions
map_that () {
  inpf1=$1
  inpf2=$2
  export reference_genome=$3
  export sampleID=$4
  export reference_name=$5
  printf "\nWill run input files:\t$inpf1 and $inpf2 through BWA MEM\n"
  bwa mem -t 2 -v 2 -a "$reference_genome" "$inpf1" "$inpf2" > "${sampleID}_mapped_to_${reference_name}.sam"
  samtools view -@ 2 -S -b "${sampleID}_mapped_to_${reference_name}.sam" > "${sampleID}_mapped_to_${reference_name}.bam"
  samtools quickcheck "${sampleID}_mapped_to_${reference_name}.bam" && printf "\n${sampleID}_mapped_to_${reference_name}.bam\tIs a good BAM file\n" && sort_that_bam "${sampleID}_mapped_to_${reference_name}.bam" && rm "${sampleID}_mapped_to_${reference_name}.sam" || printf "\n${sampleID}_mapped_to_${reference_name}.bam\tIs not right for some reason\n"
}

sort_that_bam () {
  inpf1=$1
  printf "\nWill sort the bam file:\t$inpf1\n"
  samtools sort -@ 2 -O BAM -l 0 -m 128G --reference "$reference_genome" "$inpf1" -o "${inpf1}.sorted.bam"
  samtools quickcheck "${inpf1}.sorted.bam" && printf "\n${inpf1}.sorted.bam\tIs a good sorted BAM\n" && index_that_bam "${inpf1}.sorted.bam" || printf "\n${inpf1}.sorted.bam\tIs a bad sorted BAM\n"
}

index_that_bam () {
  inpf1=$1
  printf "\nWill index the bam file:\t$inpf1\n"
  samtools index -b -@ 2 "$inpf1" "${inpf1}_INDEXED" && printf "\nSuccessfully indexed BAM file:\t$inpf1\n" && filter_that_bam "${sampleID}_mapped_to_${reference_name}.bam"
}

filter_that_bam () {
  inpf1=$1
  printf "\nWill go through the bam file:\t$inpf1\nWill try and extract only those which are primary alignments first\n"
  samtools view -h -@ 2 -F 256 -o "${inpf1}.sorted.bam.primary_alignments_only.bam" "$inpf1"
  samtools quickcheck "${inpf1}.sorted.bam.primary_alignments_only.bam" && printf "\n${inpf1}.sorted.bam.primary_alignments_only.bam\tIs a good BAM file containing only primary alignments\n" && second_sort_and_index_that_bam "${inpf1}.sorted.bam.primary_alignments_only.bam" || printf "\n${inpf1}.sorted.bam.primary_alignments_only.bam\tIs not a good primary alignments only bam file\n"
  printf "\nWill now try and get the other filtering which might be useful, using filtering -F 248\n"
  samtools view -h -@ 2 -F 248 -o "${inpf1}.sorted.bam.248_filtered_alignments_only.bam" "$inpf1"
  samtools quickcheck "${inpf1}.sorted.bam.248_filtered_alignments_only.bam" && printf "\n${inpf1}.sorted.bam.248_filtered_alignments_only.bam\tIs a correctly formatted BAM at least\n" && second_sort_and_index_that_bam "${inpf1}.sorted.bam.248_filtered_alignments_only.bam" || printf "\n${inpf1}.sorted.bam.248_filtered_alignments_only.bam\tIs not a good BAM file\n"

}

second_sort_and_index_that_bam () {
  inpf1=$1
  printf "\nWill sort then index input file:\t$inpf1\n"
  samtools sort -@ 2 -O BAM -l 0 -m 14G --reference "$reference_genome" "$inpf1" -o "${inpf1}.second_sorted.bam"
  samtools index -b -@ 2 "${inpf1}.second_sorted.bam" "${inpf1}_SECOND_INDEXED"
  samtools quickcheck "${inpf1}.second_sorted.bam" && printf "\n${inpf1}.second_sorted.bam\tIs a good sorted BAM file\n" && stat_that_bam "${inpf1}.second_sorted.bam" || printf "\n${inpf1}.second_sorted.bam\tIs not a correctly formatted BAM file\n"
}

stat_that_bam () {
  inpf1=$1
  printf "\nWill use samtools idxstats to get information on the mapping of the reads to the reference genome\n"
  samtools idxstats -@2 "$inpf1" > "${inpf1}.idxstats.txt"
}

#Executing script
INPF1=$1
INPF2=$(basename "$INPF1" | sed 's/R1_001/R2_001/g')
REFGENOME=$2
SAMPLEID=$(basename "$INPF1" | awk -F "PID-0578-r-" '{print $2}' | awk -F "_" '{print $1"_"$2}')
REFNAME=$(basename "$REFGENOME" | awk -F "." '{print $1}') || REFNAME=$(basename "$REFGENOME")
map_that "$INPF1" "$INPF2" "$REFGENOME" "$SAMPLEID" "$REFNAME"

target=$(find -maxdepth 1 -type f -name "*$sampleID*" -and -name "*.bam*")
for f in $target
do
  printf "\nWill move file:\t$f\tTo directory:\t$DESTINATION\n"
  mv "$f" "$DESTINATION"
done
