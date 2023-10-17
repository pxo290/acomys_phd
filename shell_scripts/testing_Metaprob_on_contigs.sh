#!/bin/bash -e
#SBATCH -t 00-16:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J MetProCont
#SBATCH --mem=300gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


source package 78cb9518-255c-4d1c-9fb1-99a61123483c

export inpf1=$1
export INPF1=$(readlink -f $inpf1)
export label=$2
mkdir Metaprob_contig_run_test
export locale=$(pwd)
cd Metaprob_contig_run_test
export destination=$(pwd)
cd $locale

MetaProb -si $INPF1 -dirOutput $destination -graphType 1 -feature 2 || printf "\nFailed to run this command MetaProb -si $INPF1 -dirOutput $destination -graphType 1 -feature 2\n"
