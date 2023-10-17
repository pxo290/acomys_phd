#!/bin/bash -e
#SBATCH -t 00-06:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J sortmeRNA
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Note that the $REFPATH should always be something like SILVA_138_SSURef_tax_silva.fasta,SILVA_138_SSURef_tax_silva-INDEX.idx

###SCRIPT###
export INPF1=$1
export UIE=$2
export REFPATH=$3
export locale=$(pwd)
export lazlab=$4
export TEMPDIR_NOM=$(shuf -i 1-1000000000 -n 1)
mkdir $locale/${TEMPDIR_NOM}_sortmeRNA_working_directory
cd $locale/${TEMPDIR_NOM}_sortmeRNA_working_directory
export TEMPDIR=$(pwd)
cd $locale

printf "\n Input file is: $INPF1 \n"
printf "\n User provided email is: $UIE \n"
printf "\n The path to the reference database which will be used is: $REFPATH \n"
printf "\n The label which will be attached to the output files is: $lazlab \n"
printf "\n The working directory which this run of sortmeRNA will use is: $TEMPDIR \n"

source package /tgac/software/testing/bin/sortmerna-3.0.3 #SortmeRNA version used to make the database
printf "\n Have sourced SortmeRNA version 3.03 \n"

run_sortmerna () {
  inpf=$1
  uie=$2
  refpath=$3
  label=$4
  tempdir=$5
  printf "\n Will run sortmeRNA with default parameters on input file $inpf using reference database $refpath and labelling the output with $label \n"
  sortmerna --ref $refpath --reads $inpf --aligned ${label}_SortmeRNA_output --log -d "$tempdir"
  mail -s "Progress Monitoring 85763000" $uie <<< "Ran sortmerna on input file $inpf using reference database $refpath and labelling the output with $label"
}

run_sortmerna $INPF1 $UIE $REFPATH $lazlab $TEMPDIR
