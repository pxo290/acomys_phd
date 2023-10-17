#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J BlastN
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
export subjf1=$1
export UIE=$2
export blastDB=/ei/public/databases/blast/ncbi/nt_20200707/nt
export tag=$3
printf "\n Will be using this version of blast: /nbi/software/production/bin/blast+-2.9.0 \n"
source package /nbi/software/production/bin/blast+-2.9.0

run_blast () {
  blDB=$1
  INPF=$2
  uie=$3
  label=$4
  #export BLASTDB=$PATH:~/ei/public/databases/blast/ncbi/nt_20200707
  printf "\n Will run blastn on file: $INPF using blast database file: $blDB labelling the output with: $label and emailing a completion note to: $uie \n"
  blastn -num_threads 2 -outfmt 11 -word_size 5 -db $blDB -query $INPF -out ${label}_blastn_output.txt
  mail -s "Progress Monitoring 85763000" $uie <<< "Ran blastn on file: $INPF using blast database file: $blDB labelling the output with: $label"
}

run_blast $blastDB $subjf1 $UIE $tag

###NOTES###
#24/07/20
#You downloaded https://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nt.gz and will use
#it as the reference database file
