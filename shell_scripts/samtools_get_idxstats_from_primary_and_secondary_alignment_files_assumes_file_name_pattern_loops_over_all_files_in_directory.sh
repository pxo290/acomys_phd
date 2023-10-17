#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J SplitAlignments
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


source package /tgac/software/testing/bin/samtools-1.10
target=$(find -maxdepth 1 -type f -name "*Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only.bam")
for f in $target
do
  printf "\nWorking on file:\t$f\n"
  out_name=$(basename "$f" | awk -F ".bam" '{print $1}')
  samtools idxstats "$f" > "${out_name}_idxstats.txt" || printf "\nFailed while working on file:\t$f for some reason\n"
done

targets=$(find -maxdepth 1 -type f -name "*Subsampled_BWA_reads_mapped_to_assembly_SECONDARY_alignments_only.bam")
for f in $targets
do
  printf "\nWorking on file:\t$f\n"
  out_name=$(basename "$f" | awk -F ".bam" '{print $1}')
  samtools idxstats "$f" > "${out_name}_idxstats.txt" || printf "\nFailed while working on file:\t$f for some reason\n"
done
