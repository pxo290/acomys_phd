#!/bin/bash -e
#SBATCH -t 03-18:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J ContBin
#SBATCH --mem=300gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package 78cb9518-255c-4d1c-9fb1-99a61123483c

clean1=$1
lbel=$2
locale=$(pwd)
run_metaprob () {
  inpf1=$(readlink -f $1)
  label=$2
  arrivals=$3
  printf "\n This script will run Metaprob on the following input file: $inpf1 \n"
  printf "\n File will be labelled with $lbel \n"
  printf "\n Graph type is 0 \n"
  mkdir -p Contig_Metaprob_output
  cd $locale/Contig_Metaprob_output
  landing=$(pwd)
  cd $locale
  MetaProb -pi $inpf1 -dirOutput $landing -graphType 0
  metaprobed=$(find -maxdepth 1 -type f -name "Metaprob_output*")
  for f in $metaprobed
  do
    printf "\n Will rename file from $f to ${label}-Metaprob_output-$f \n"
    front_company=$(basename $f)
    mv $f $landing/${label}-Metaprob_output_$front_company
  done
}

run_metaprob $clean1 $lbel $locale
