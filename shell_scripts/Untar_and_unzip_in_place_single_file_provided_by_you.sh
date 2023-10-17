#!/bin/bash -e
#SBATCH -t 00-03:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J DeTarUnZip
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export INPF1=$1
printf "\nWill untar and gunzip file:\t$INPF1\n" && tar xvfz $INPF1 && mail -s "Untar'ed and unzipped file" peter.osborne@earlham.ac.uk <<< "Unzipped and untar'ed the file $INPF1"
printf "\nUnzipped and untar'ed the file $INPF1\n"
