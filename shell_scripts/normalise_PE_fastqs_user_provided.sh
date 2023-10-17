#!/bin/bash -e
#SBATCH -t 00-10:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Normalise
#SBATCH --mem=12gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

inpf1=$1
inpf2=$2
inpdir=$3
lobel=$4
label1=
label2=
locale=$(pwd)
outdir=""
source package /tgac/software/testing/bin/bbmap-38.06
