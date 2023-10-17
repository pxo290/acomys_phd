#!/bin/bash -e
#SBATCH -t 00-06:59
#SBATCH -c 6
#SBATCH -p ei-medium
#SBATCH -J T_Megahit
#SBATCH --mem=250gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --nice=250

export RFQ1=$1
export RFQ2=$2
export UIE=$3
source package /tgac/software/testing/bin/megahit-1.1.1_dw
export locale=$(pwd)
export prefix=$(basename $RFQ1)
export label=${prefix:0:10}
megahit -1 $RFQ1 -2 $RFQ2 --k-max 145 --k-min 15 --k-step 6 --verbose -o $locale/${label}_Megahit_assemblies --memory 0.99 --num-cpu-threads 6
mail -s "$label Megahit assembly" $UIE <<< "The Megahit assembly of files: $RFQ1 and $RFQ2 has been completed."
