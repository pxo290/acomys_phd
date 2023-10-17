#!/bin/bash -e
#SBATCH -t 00-00:10
#SBATCH -p ei-short
#SBATCH -c 1
#SBATCH -J MegaHit_Controller
#SBATCH --mem=512mb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Written: 2021-04-08
#This is a controlling script which gets all the files which will be submitted to
#an execution script to run Megahit. This script will go through all the R1 files
#in the current directory and use this name to get the R2 file and the unzipped
#file name. It will also set all the fixed variables to be inherited by each of
#the execution scripts

#Setting fixed and inherited variables
export DESTINATION="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output"
export ORIGIN=$(pwd)

#Sourcing Megahit so that all child jobs will have it without having to source
#it each time within them
source package /tgac/software/testing/bin/megahit-1.1.1_dw

#Defining the function which will run on the gzipped R1 files in this directory
#and ultimately set the execution script running with the mutable and inherited
#variables
within_loop_function () {
  export inpf1=$1
  export inpf2=$(basename $inpf1 | sed 's/_R1_/_R2_/g')
  export unzipped_infp1=$(echo $inpf1 | awk -F ".gz" '{print $1}' | awk 'NF')
  export unzipped_infp2=$(echo $inpf2 | awk -F ".gz" '{print $1}' | awk 'NF')
  export label=$(basename $inpf1 | awk -F "-" '{print $4}' | awk -F "." '{print $1}')
  export UED=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
  sbatch --job-name="${UED}_megahit_execution" Megahit_execution.sh $inpf1 || printf "\nI failed to submit the megahit execution script on file:\t$inpf1\tfor some reason\n"
}

#Now that is done, getting the for loop running
targets=$(find -maxdepth 1 -type f -name "*R1_001.fastq.gz")

for f in $targets
do
  printf "\nRunning the function on input file:\t$f\n"
  within_loop_function $f && printf "\nSuccessfully ran the within loop function on input file\n"
  sleep 30s
  printf "\nDone! Moving on to the next R1 file after a 30 second nap\n"
done
