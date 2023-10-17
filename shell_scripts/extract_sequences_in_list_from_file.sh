#!/bin/bash -e
#SBATCH -t 01-10:00
#SBATCH -p ei-medium
#SBATCH -c 6
#SBATCH -J SeqExtract
#SBATCH --mem=450gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

list_file=$1
read_file=$2

touch extracted_reads_${read_file}_${list_file}.fastq
output=extracted_reads_${read_file}_${list_file}.fastq

grep -f $list_file -A 3 $read_file >> $output
sed -i -e 's#--##' $output
