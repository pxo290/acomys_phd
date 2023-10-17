#!/bin/bash -e
#SBATCH -t 00-03:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J @PLACEHOLDER@
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export DESTINATION=$1
export INPF1=$2
export INPF2=$3
export LBEL=$4

source package /tgac/software/testing/bin/bbmap-38.06

run_BBMerge () {
  destination=$1
  inpf1=$2
  inpf2=$3
  label=$4
  cd $destination
  gunzip *.gz || printf "\nThere were no zipped files present\n"
  rm $label-unmerged-R1.fastq || printf "\nThere was no pre-existing file from an older run\n"
  printf "\nWill merge the two files:\t$inpf1 and $inpf2\n"
  bbmerge.sh in1=$inpf1 in2=$inpf2 interleaved=false out=$label-merged.fastq out1=$label-unmerged-R1.fastq out2=$label-unmerged-R2.fastq || mail -s 'Progress Monitoring 85763000' peter.osborne@earlham.ac.uk <<< "FAILED to run BBMerge on input files: $inpf1 and $inpf2 located at $destination"
  mail -s 'Progress Monitoring 85763000' peter.osborne@earlham.ac.uk <<< "Ran BBMerge on input files: $inpf1 and $inpf2 located at $destination" || printf "\nCouldn't send email for some reason\n"
}

run_BBMerge $DESTINATION $INPF1 $INPF2 $LBEL
