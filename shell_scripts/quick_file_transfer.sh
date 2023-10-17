#!/bin/bash -e
#SBATCH -t 00-00:25
#SBATCH -c 2
#SBATCH -J filetrans
#SBATCH --mem=24000
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######NOTES######
#03/05/20
#A quick and dirty script to transfer some files

######SCRIPT######
fastq_directory=$1
fasta_directory=$1/Megahit-output
cd $fasta_directory
for f in *.fastq-metaphlan-output.txt
do
  scp $f /hpc-home/osbourne/for_noga
done
# for f in *kraken-report.out
# do
#   scp $f /hpc-home/osbourne/for_noga
# done
# for f in *centrifuge_solo_scoring_report.tsv
# do
#   scp $f /hpc-home/osbourne/for_noga
# done
cd $fastq_directory
for f in .fastq-metaphlan-output.txt
do
  scp $f /hpc-home/osbourne/for_noga
done
# for f in *kraken-report.out
# do
#   scp $f /hpc-home/osbourne/for_noga
# done
# for f in *centrifuge_solo_scoring_report.tsv
# do
#   scp $f /hpc-home/osbourne/for_noga
# done
