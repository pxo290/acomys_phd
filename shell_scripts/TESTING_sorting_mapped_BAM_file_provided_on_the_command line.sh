#!/bin/bash -e
#SBATCH -t 00-02:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#22/03/21
#This script should take a mapped BAM file provided on the command line and then
#sort it with Samtools to produce a sorted BAM file. For future reference, you
#would need to alter the label if statement check unless all your labels in the
#future happen to have 4 characters (excluding end of line ones)

#Temporary note - /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/bam_stuff_testing

#Sourcing necessary software tools
source package /tgac/software/testing/bin/samtools-1.10
source package /tgac/software/testing/bin/bam2fastq-1.1.0
source package /tgac/software/testing/bin/bedtools-2.30.0

#Defining functions
failure_function_rezip () {
  cd $READSDIR
  printf "\nFailed to run the BAM sorting function\n"
  mail -s "Failed to run Samtools sort" peter.osborne@earlham.ac.uk <<< "Failed to produce a sorted.bam file for input file ${label}"
  whereami=$(pwd)
  whenami=$(date)
  what_was_I_doing=$(cat "$BASH_SOURCE" | grep -v EZREMOVEHEADER)
  fail_label=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
  printf "\n$what_was_I_doing\n" >> ${fail_label}_failed_log.txt
  printf "\nFor some reason I have failed. I was running here:\t$whereami\nI was running now:\t$whenami\nThe email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt\n"
  mail -s "Progress Monitoring 85763000" -a ${fail_label}_failed_log.txt peter.osborne@earlham.ac.uk <<< "For some reason I have failed. I was running here: $whereami I was running now: $whenami The email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt"
  rm ${fail_label}_failed_log.txt
  rm $short_term_appelation-WORKING_LOG.txt
}

captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  export LOGFILEDIR="/hpc-home/osbourne/WORKING_LOGS"
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tSamtools sort job.\nI am running at:\t$tick\nI will work on the input file:\t$INPF1\nI am running in the directory:\t$wobist\nI request the resources:\t00-02:00 on EI-medium\t1 core\t16GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: Samtools sort job. I am running at: "$tick" I will work on the input file $INPF1. I am running in the directory: $wobist. I request the resources: 00-02:00 on EI-medium, 1 cores and 16GB\n"
  #Remember to add at the end of the entire script the command below:
  #mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
}

sort_BAM_file () {
  inpf=$1
  label=$2
  printf "\nWill use Samtools sort on:\t$inpf\n"
  samtools sort -l 0 -m 15G -O BAM -o ${label}_mapped_sorted.bam $inpf || printf "\nError encountered\n"
  if [[ -s "${label}_mapped_sorted.bam" ]]
  then
    printf "\nSorted BAM file has been made from $inpf\nWill next check if it is correctly formatted\n"
    samtools quickcheck ${label}_mapped_sorted.bam && printf "\nFile:\t${label}_mapped_sorted.bam\tis correctly formatted\n" || printf "\nFile:\t${label}_mapped_sorted.bam\tis not correctly formatted\n"
  else
    printf "\nSorted BAM file has not been made from $inpf\n"
  fi
}

#Doing the prep work for function execution
export INPF1=$1
export LABEL=$(basename $INPF1 | awk -F "_" '{print $1}')
LABEL_SIZE_CHECK=$(printf "$LABEL" | wc -c)

#Executing the functions if the label has been made correctly
if [[ "$LABEL_SIZE_CHECK" -gt "5" ]]
then
  printf "\nThe label isn't right, not running functions\n"
  printf "\nDue to label not being made correctly did not try and make a sorted BAM file from input:\t$INPF1\n"
  failure_function_rezip
else
  printf "\nStarting the functions as expected with input file:\t$INPF1\n"
  #Here is the actual start of the proper execution of the script
  captains_log
  sort_BAM_file $INPF1 $LABEL || failure_function_rezip
  printf "Should have produced sorted BAM file from:\t$INPF1\n"
  mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
fi
