#!/bin/bash -e
#SBATCH -t 00-06:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J GroupfastANI
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script will take a user provided reference genome and path to a directory
#on the command line. It will go to the directory and then run FastANI and so
#compare all the *.fa files in the directory against the reference genome.
#Note that the auto labelling of output can break if the query files have more
#than one .fa in them

#Also this script will break if you run it on the same day more than once unless
#you re-name the output directory

#First source fastANI
source package 7d170f8e-6196-4ce5-81e9-a9800ab05137

#Now define some functions
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tFastANI job.\nI am running at:\t$tick\nI will work on the fasta files found in directory:\t$INPDIR and compare them to reference genome:\t$INPF1\nI am running in the directory:\t$wobist\nI request the resources:\t00-06:00 on EI-medium\t1 cores\t128GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: FastANI job. I am running at: "$tick" I will work on the fasta files found in directory $INPDIR and compare them to reference $INPF1. I am running in the directory: $wobist. I request the resources: 00-06:00 on EI-medium, 1 cores and 128GB\n"
  #Remember to add at the end of the entire script the command below:
  #mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
}

group_fastANI_execution () {
  inpf1=$(readlink -f $1)
  ref_label=$(printf "$1" | awk -F ".fa" '{print $1}' | sed 's/.fna//g')
  inpdir=$2
  cd "$inpdir"
  #Note that the subject files finder below has Bin in it just for your particular use case here, you would get rid of this as needed if the query files don't have it in their file name
  subject_files=$(find -maxdepth 1 -type f -name "*.fa" -name "Bin*" -not -name "$INPF1")
  unique_run_identifier=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
  lambel=$(date | awk -F " " '{print $1,$2,$3,$6}' | sed 's/ /_/g' | tr -d '.')
  limbel=$(printf "${lambel}_${unique_run_identifier}" | tr -d '.')
  mkdir "${limbel}_FastAni_outputs"
  cd "${limbel}_FastAni_outputs"
  destination=$(pwd)
  cd $inpdir
  for f in $subject_files
  do
    linbel=$(basename $f)
    lobel=$(echo "$linbel" | awk -F ".fa" '{print $1}')
    label=$(printf "${lambel}_${lobel}_fastANI_output_against_reference_${ref_label}" | tr -d '.')
    printf "\nWill now run FastANI on query file:\t$f against reference genome:\t$inpf1\n"
    fastANI -q "$f" -r "$inpf1" -o "$label" || fastANI -q $f -r $inpf1 -o $label > ${destination}/$label.txt
    package=$(find -maxdepth 1 -type f -name "*$label*")
    if [[ -s "$package" ]];
    then
      mv $package $destination || printf "\nI failed to move $package to $destination\n"
    else
      printf "\nNo relevant output since the fastANI score was below 70 percent. Output file was made but will now be deleted\n"
      rm $package
    fi
  done
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
export INPDIR=$2
export LOGFILEDIR='/hpc-home/osbourne/WORKING_LOGS'

#Executing functions
captains_log
group_fastANI_execution "$INPF1" "$INPDIR" || failure_state_function
mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
