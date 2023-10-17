#!/bin/bash -e
#SBATCH -t 00-03:30
#SBATCH -p ei-medium
#SBATCH -c 16
#SBATCH -J TestKAT
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package /tgac/software/testing/bin/kat-2.3.4

export INPF1=$1
export INPF2=$2
export LBEL=$3

kat comp -t 16 -n -o ${LBEL}_ $INPF1 $INPF2
