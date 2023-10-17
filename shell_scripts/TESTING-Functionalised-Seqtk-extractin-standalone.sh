#!/bin/bash -e
#SBATCH -t 01-20:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J MetaProb
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
export INPF1=$1
export INPF2=$2
export LST1=$3
export LST2=$4
export LABEL=$5
export UIE=$6
export LOCALE=$(pwd)
mkdir $LABEL
cd $LABEL
export BERTH=$(pwd)
cd $LOCALE

source package /tgac/software/testing/bin/seqtk-20150226

run_seqtk_extraction () {
  inpf1=$1
  inpf2=$2
  lst1=$3
  lst2=$4
  label=$5
  berth=$6
  uie=$7
  printf "\n Will get reads from list files $lst1 and $lst2 then use Seqtk to extract them from the read files $inpf1 and $inpf2; output will be in $berth with the name $label \n"
  seqtk subseq $inpf1 $lst1 > $label-Seqtk-extracted_R1.fastq
  seqtk subseq $inpf2 $lst2 > $label-Seqtk-extracted_R2.fastq
  mv $label-Seqtk-extracted_R*.fastq $berth
  printf "\n Got reads from list files $lst1 and $lst2 using Seqtk to extract them from the read files $inpf1 and $inpf2; output is in $berth with the name $label \n"
  mail -s "Progress Monitoring 85763000" $uie <<< "Got reads from list files $lst1 and $lst2 using Seqtk to extract them from the read files $inpf1 and $inpf2; output is in $berth with the name $label"
}

run_seqtk_extraction $INPF1 $INPF2 $LST1 $LST2 $LABEL $BERTH $UIE
