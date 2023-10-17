#!/bin/bash -e
#SBATCH -t 01-12:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J HostFind
#SBATCH --mem=132gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package /tgac/software/testing/bin/bbmap-38.06 #BBMap (for use of BBDuk and BBTools)

bbduk_run () {
  cd $ARRIVALS
  inpf1=$1
  inpf2=$2
  host=$3
  human=$4
  uie=$5
  label=$6
  arrivals=$7
  mkdir BBDuk_outputs
  cd BBDuk_outputs
  mkdir Contaminant_matching
  mkdir Cleansed
  cd Contaminant_matching
  contam_dir=$(pwd)
  cd ..
  cd Cleansed
  cleansed_dir=$(pwd)
  cd $arrivals
  printf "\n Running qc'ed files $inpf1 and $inpf2 through BBDUK to remove host and human mapping reads."
  printf "\n Host genome which will be used is: $host"
  printf "\n Human genome which will be used is: $human"
  printf "\n Emails will be sent to user-provided address at: $uie"
  printf "\n Output files will be named with this: $label"
  srun bbduk.sh -Xmx128g -Xms55g -prealloc in=$inpf1 in2=$inpf2 ref=$host,$human outm=${label}_host_or_human_matching.fastq out=${label}-cleansed_1.fastq out2=${label}-cleansed_2.fastq overwrite=t stats=$contam_dir/${label}_host_comparison_stats.txt
  scp $arrivals/${label}-cleansed_1.fastq $cleansed_dir/
  scp $arrivals/${label}-cleansed_2.fastq $cleansed_dir/
  mv ${label}_host_or_human_matching.fastq $contam_dir/
  }
bbduk_run $1 $2 $3 $4 $5 $6 $7

cd $ARRIVALS
