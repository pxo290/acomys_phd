#!/bin/bash -e
#SBATCH -t 01-12:00
#SBATCH -p ei-largemem
#SBATCH -c 15
#SBATCH -J KrakTest
#SBATCH --mem=750gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#####SCRIPT#####
export rfq1=$1
export rfq2=$2
export user_input_mail=$3
source package /tgac/software/testing/bin/kraken2-2.0.7
#First the old database and then the new
#Define our function
kraken2_run () {
  R1=$1
  R2=$2
  CS=$3
  UIE=$4
  lab=$5
  dab=$6
  printf "\n The confidence score which will be used is: $CS \n"
  printf "\n The database which will be used is: $lab \n"
  kraken2 --paired --db $6 --threads 15 --confidence $CS --unclassified-out ${lab}_Kraken2-Unclassified_confidence_score${CS}_#.txt --classified-out ${lab}_Kraken2-classified_confidence_score${CS}_#.txt $R1 $R2 --report ${lab}_Kraken2_confidence_score_${CS}_report.out
  mv ${lab}_Kraken2_confidence_score_${CS}_report.out ${lab}_Kraken2_confidence_score_${CS}_report.txt
  mail -s "Progress Monitoring 85763000" -a ${lab}_Kraken2_confidence_score_${CS}_report.txt $UIE <<< "Kraken2 report for read files $R1 and $R2 with confidence score $CS is attached"
  rm *__1.txt && rm *__2.txt
}
#Running with new Kraken2 database
kraken2_run $rfq1 $rfq2 0.05 $user_input_mail NEW /ei/public/databases/kraken/2.0.7_refseq-201910
kraken2_run $rfq1 $rfq2 0.10 $user_input_mail NEW /ei/public/databases/kraken/2.0.7_refseq-201910
kraken2_run $rfq1 $rfq2 0.25 $user_input_mail NEW /ei/public/databases/kraken/2.0.7_refseq-201910
kraken2_run $rfq1 $rfq2 0.50 $user_input_mail NEW /ei/public/databases/kraken/2.0.7_refseq-201910
kraken2_run $rfq1 $rfq2 0.75 $user_input_mail NEW /ei/public/databases/kraken/2.0.7_refseq-201910
kraken2_run $rfq1 $rfq2 0.95 $user_input_mail NEW /ei/public/databases/kraken/2.0.7_refseq-201910
kraken2_run $rfq1 $rfq2 1.00 $user_input_mail NEW /ei/public/databases/kraken/2.0.7_refseq-201910

#Running with new Kraken2 database in your scratch
kraken2_run $rfq1 $rfq2 0.05 $user_input_mail SCRATCH /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $rfq1 $rfq2 0.10 $user_input_mail SCRATCH /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $rfq1 $rfq2 0.25 $user_input_mail SCRATCH /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $rfq1 $rfq2 0.50 $user_input_mail SCRATCH /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $rfq1 $rfq2 0.75 $user_input_mail SCRATCH /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $rfq1 $rfq2 0.95 $user_input_mail SCRATCH /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $rfq1 $rfq2 1.00 $user_input_mail SCRATCH /ei/scratch/osbourne/Kraken2_newer_database

#Running with old Kraken2 database
kraken2_run $rfq1 $rfq2 0.05 $user_input_mail OLD /ei/public/databases/kraken/2.0.7_std
kraken2_run $rfq1 $rfq2 0.10 $user_input_mail OLD /ei/public/databases/kraken/2.0.7_std
kraken2_run $rfq1 $rfq2 0.25 $user_input_mail OLD /ei/public/databases/kraken/2.0.7_std
kraken2_run $rfq1 $rfq2 0.50 $user_input_mail OLD /ei/public/databases/kraken/2.0.7_std
kraken2_run $rfq1 $rfq2 0.75 $user_input_mail OLD /ei/public/databases/kraken/2.0.7_std
kraken2_run $rfq1 $rfq2 1.00 $user_input_mail OLD /ei/public/databases/kraken/2.0.7_std
