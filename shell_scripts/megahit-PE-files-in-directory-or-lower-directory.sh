#!/bin/bash -e
#SBATCH -t 00-06:59
#SBATCH -c 6
#SBATCH -p ei-medium
#SBATCH -J T_Megahit
#SBATCH --mem=250gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --nice=250

export INPF1=$1
export INPF2=$2
export UIE=peter.osborne@earlham.ac.uk
source package /tgac/software/testing/bin/megahit-1.1.1_dw
export locale=$(pwd)
export prefix=$(basename $INPF1)
export label=${prefix:0:10}

printf "\n -+-+-+-+ \n"
printf "\n The first input file is: $INPF1 \n"
printf "\n The second input file is: $INPF2 \n"
printf "\n The User Input Email is: $UIE \n"
printf "\n Work will take place in this directory: $locale \n"
printf "\n The label which will be used with the output is: $label \n"

run_megahit () {
  inpf1=$1
  inpf2=$2
  uie=$3
  lbl=$4
  vicinity=$5
  printf "\n Will run megahit to assemble the metagenome from input files $inpf1 and $inpf2 \n"
  megahit -1 $inpf1 -2 $inpf2 --k-max 145 --k-min 15 --k-step 6 --verbose -o $vicinity/${lbl}_Megahit_assemblies --memory 0.99 --num-cpu-threads 6
  printf "\n Ran megahit and assembled the metagenome from input files $inpf1 and $inpf2 \n"
  mail -s "Progress Monitoring 85763000" $uie <<< "Ran megahit and assembled the metagenome from input files $inpf1 and $inpf2"
}

run_megahit $INPF1 $INPF2 $UIE $label $locale
