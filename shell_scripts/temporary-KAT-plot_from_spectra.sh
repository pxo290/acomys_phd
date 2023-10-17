#!/bin/bash -e
#SBATCH -t 00-04:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J SeasonKAT
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

for f in *.mx ; do nome=$(echo $f | awk -F "-" '{print $1}') && kat plot spectra-mx -o ${nome}_kmer_multiplicity_plot.svg -x 400 -i $f && printf "\nMade graph using $f\n" && sleep 3s ; done
