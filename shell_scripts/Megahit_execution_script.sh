#!/bin/bash -e
#SBATCH -t 02-12:30
#SBATCH -c 1
#SBATCH -p ei-medium
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --nice=250

#Written: 2021-04-08
#This is a dumb script which takes all input and variables from the controlling
#script which set it running and runs input PE read files through Megahit to
#assemble them

#Defining a failure rezip function so the files will be rezipped if the megahit
#step fails
fail_rezip () {
  gzip $unzinpf1
  gzip $unzinpf2
  printf "\nI failed to run Megahit on input files:\t$unzinpf1 and $unzinpf2\n"
}

#Checking the inherited variables in case of error later
printf "\nVariable DESTINATION is:\t$DESTINATION\n"
printf "\nVariable ORIGIN is:\t$ORIGIN\n"

#Unzipping the input files
gunzip $inpf1
gunzip $inpf2

#Using the inherited unzipped file names to make nice variables to track through
#Megahit
unzinpf1="$unzipped_infp1"
unzinpf2="$unzipped_infp2"

#Running Megahit
megahit -1 $unzinpf1 -2 $unzinpf2 --k-max 145 --k-min 15 --k-step 6 --verbose -o "${DESTINATION}/${label}_megahit_output" --memory 0.99 --num-cpu-threads 2 || fail_rezip

#Re-zipping the files here if Megahit worked
gzip $unzinpf1
gzip $unzinpf2

#Re-naming the output since the script doesn't correctly name it
cd "$DESTINATION"
target=$(find -maxdepth 1 -type f -name "final.contigs.fa")
for f in $target
do
  mv "$f" "${label}_megahit_assembly.fa"
  printf "\nRenamed file:\t$f\n"
  printf "\nNow called:\t${label}_megahit_assembly.fa\n"
done
cd "$ORIGIN"
