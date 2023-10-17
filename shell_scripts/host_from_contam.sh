#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 1
#SBATCH --mem=550000
#SBATCH -J host_from_contam
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#17/12/19 - taking a productive break from writing the aridity review
#The idea with this script is based on something Wilfried said, about trying to
#get the host genome from the faecal metagenome samples. This is version 1 of
#trying to do this. It simply takes the reads which were removed from the QC'ed
#read files by BBDuk since they matched to either host, human or wheat reference
#genomes.

#This is the very laziest possible way, not even using reads removed for only
#matching the host but also human and wheat. Think of this more as a general
#test of how easy it is to use Minimap2, which I've never used before

#The instructions from the minimap2 site are:
# General usage
# Without any options, minimap2 takes a reference database and a query sequence file as input and produce approximate mapping, without base-level alignment (i.e. no CIGAR), in the PAF format:
#
# minimap2 ref.fa query.fq > approx-mapping.paf
# You can ask minimap2 to generate CIGAR at the cg tag of PAF with:
#
# minimap2 -c ref.fa query.fq > alignment.paf
# or to output alignments in the SAM format:
#
# minimap2 -a ref.fa query.fq > alignment.sam
# Minimap2 seamlessly works with gzip'd FASTA and FASTQ formats as input. You don't need to convert between FASTA and FASTQ or decompress gzip'd files first.
#
# For the human reference genome, minimap2 takes a few minutes to generate a minimizer index for the reference before mapping. To reduce indexing time, you can optionally save the index with option -d and replace the reference sequence file with the index file on the minimap2 command line:
#
# minimap2 -d ref.mmi ref.fa                     # indexing
# minimap2 -a ref.mmi reads.fq > alignment.sam   # alignment
# Importantly, it should be noted that once you build the index, indexing parameters such as -k, -w, -H and -I can't be changed during mapping. If you are running minimap2 for different data types, you will probably need to keep multiple indexes generated with different parameters. This makes minimap2 different from BWA which always uses the same index regardless of query data types.


#Hey, why don't we functionalise this stuff? Always worth being a bit nicer
#minimap2 () {
#  source package /tgac/software/testing/bin/minimap2-r922
#  echo "You are working with '$1' just so you know"
#  echo "You are working with '$2' just so you know"
#  echo "You will make '$3' just so you know"
#  minimap2 -c $1 $2 > $3
#  echo "This should mark the conclusion of the minimap2 run"
#}

#export minimap2
#minimap2

source package /tgac/software/testing/bin/minimap2-r922
#minimap2 -c /ei/scratch/osbourne/RAW-READS/contaminated/DT032-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863964-E3_R1.fastq_contaminated.fastq /hpc-home/osbourne/REFERENCE_GENOMES/mAcoCah1.curated_primary.20181127.fa > AC16J-R1-minimap_to_host-all-contaminants-combined-in-file.paf
minimap2 -a /ei/scratch/osbourne/RAW-READS/contaminated/DT032-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863964-E3_R1.fastq_contaminated.fastq /hpc-home/osbourne/REFERENCE_GENOMES/mAcoCah1.curated_primary.20181127.fa > AC16J-R1-minimap_to_host-all-contaminants-combined-in-file.sam
