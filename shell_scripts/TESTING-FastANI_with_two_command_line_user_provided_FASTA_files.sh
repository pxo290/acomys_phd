#!/bin/bash -e
#SBATCH -t 00-02:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J fastANI
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script will take two user provided input fasta files and run fastANI with
#them. The first input file will be the reference, the second will be the query

#First source fastANI
source package 7d170f8e-6196-4ce5-81e9-a9800ab05137

#Now define some functions
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tFastANI job.\nI am running at:\t$tick\nI will work on the input files:\t$INPF1 and $INPF2\nI am running in the directory:\t$wobist\nI request the resources:\t00-02:00 on EI-medium\t1 core\t32GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: FastANI job. I am running at: "$tick" I will work on the input files $INPF1 and $INPF2. I am running in the directory: $wobist. I request the resources: 00-02:00 on EI-medium, 1 core and 32GB\n"
  #Remember to add at the end of the entire script the command below:
  #mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
}

fastANI_execution () {
  inpf1=$1
  inpf2=$2
  lobel=$3
  limbel=$(date | awk -F " " '{print $1,$2,$3,$6}' | sed 's/ /_/g')
  label=$(printf "${limbel}_${lobel}_fastANI_output")
  outdir=$(pwd)
  printf "\nWill run FastANI on two input files:\t$inpf1\t$inpf2\n"
  fastANI -q "$inpf2" -r "$inpf1" --visualize -o "$label"

}

failure_state_function () {
  whereami=$(pwd)
  whenami=$(date)
  what_was_I_doing=$(cat "$BASH_SOURCE" | grep -v EZREMOVEHEADER)
  fail_label=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
  printf "\n$what_was_I_doing\n" >> ${fail_label}_failed_log.txt
  printf "\nFor some reason I have failed. I was running here:\t$whereami\nI was running now:\t$whenami\nThe email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt\n"
  mail -s "Progress Monitoring 85763000" -a ${fail_label}_failed_log.txt peter.osborne@earlham.ac.uk <<< "For some reason I have failed. I was running here: $whereami I was running now: $whenami The email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt"
  rm ${fail_label}_failed_log.txt
}

#Getting the fixed variables
export INPF1=$1
export INPF2=$2
export LABEL=$(echo "$INPF2" | awk -F ".fa" '{print $1}')
export LOGFILEDIR='/hpc-home/osbourne/WORKING_LOGS'

captains_log
fastANI_execution "$INPF1" "$INPF2" "$LABEL" || failure_state_function
mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
