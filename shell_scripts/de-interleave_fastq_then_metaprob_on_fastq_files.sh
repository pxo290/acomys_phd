#!/bin/bash -e
#SBATCH -t 00-16:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J MetaProb
#SBATCH --mem=300gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package 78cb9518-255c-4d1c-9fb1-99a61123483c
source package /tgac/software/testing/bin/bbmap-38.06

run_metaprob () {
  inpf1=$(readlink -f $1)
  inpf2=$(readlink -f $2)
  label=$3
  arrivals=$(pwd)
  printf "\n This script will run Metaprob on the following input file: $inpf1 \n"
  printf "\n Files will be labelled with $lbel \n"
  printf "\n Graph type is 0 \n"
  mkdir Metaprob_output
  cd $arrivals/Metaprob_output
  landing=$(pwd)
  cd $arrivals
  MetaProb -pi $inpf1 $inpf2 -dirOutput $landing -graphType 0 -feature 1
  metaprobed=$(find -maxdepth 1 -type f -name "Metaprob_output*")
  for f in $metaprobed
  do
    printf "\n Will rename file from $f to ${label}-Metaprob_output-$f \n"
    front_company=$(basename $f)
    mv $f $landing/${label}-Metaprob_output_$front_company
  done
}
export port=$(pwd)
export clean1=$(readlink -f $1)
export prefix=$(basename $clean1)
export lbel=${prefix:0:10}

reformat.sh in=$clean1 out1=$lbel-R1.fastq out2=$lbel-R2.fastq
workfile1=$(readlink -f $lbel-R1.fastq)
workfile2=$(readlink -f $lbel-R2.fastq)
run_metaprob $workfile1 $workfile2 $lbel
rm $workfile1 && rm $workfile2
