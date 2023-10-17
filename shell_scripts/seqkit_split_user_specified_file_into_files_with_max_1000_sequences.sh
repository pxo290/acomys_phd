#!/bin/bash -e
#SBATCH -t 00-05:35
#SBATCH -c 1
#SBATCH --mem=12000
#SBATCH -J seqkit_split
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script uses Seqkit to split a fasta or fastq file into smaller parts by
#number of sequences each file can have as a maximum
#E.g. a file with 525 sequences split into files with a max of 100 sequences
#will make 5 files with 100 sequences and 1 with 25

source package /tgac/software/testing/bin/seqkit-0.10.0

#Here it splits the user input file into files which each can only contain a
#max of 1000 sequences - sequences NOT nucleotides
seqkit split2 $1 -s 1000 -f
