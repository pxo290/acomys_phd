#!/bin/bash -e
#SBATCH -t 00-12:55
#SBATCH -p ei-largemem
#SBATCH -c 2
#SBATCH --mem=615gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script should align PE read files provided by the user in directories
#(script should identify the files and get the pairings right) against the index
#contained in the fixed variable directory

#For portability you would switch the fixed variables
#Also this script assumes the read files are unzipped

holdvar1=$1 && export INPF1=$(basename $holdvar1)
export INPF2=$(echo "$INPF1" | sed 's/R1/R2/g') && force_unzip=$(find -maxdepth 1 -type f -name "*.gz" -a -name "*$INPF1*" -o -name "*$INPF2*") && printf "\nFound a file which still needs unzipping:\t$force_unzip\n" && for f in $force_unzip ; do printf "\nTurns out a file needed to be unzipped still, $f will be unzipped\n" && target_file=$(basename $f) && gunzip "$target_file" ; done
export LABEL=$(echo "$INPF1" | awk -F "-" '{print $2}' | awk -F "_" '{print $1}') && printf "\nA label should have been made, appearing here:\t$LABEL\n" && printf "\nThe two filenames which will be given to the function are:\t$INPF1 for the first read file\nAnd:\t$INPF2 for the second read file\n"

#Note start time
sleep 2m && commenced=$(date) && printf "\n$commenced\n"

#Sourcing software
source package /tgac/software/testing/bin/bwa-0.7.7
source package /tgac/software/testing/bin/samtools-1.9

#Setting fixed variables
export INDEXDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/BWA-testing"
export READSDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing"
export INDEXFASTA="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/BWA-testing/Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_FILES"
export OUTDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/BWA_Subsampled_reads_alignment_output"

printf "\nThere should be some sensible variables following this:\n$INDEXDIR\n$READSDIR\n$INDEXFASTA\n$OUTDIR\n"

#Defining functions
run_reads_through_bwa-mem () {
  inpdir=$1
  indexdir=$2
  indexfasta=$3
  outdir=$4
  locale=$(pwd)
  first_reads=$5
  second_read=$6
  #raw_name=$7
  #Now to get the different R1 files which will be used for everything else
  cd $inpdir
  for f in $first_reads
  do
    cd $inpdir || printf "\nCommand to cd into the input directory (containing reads) failed, maybe we were already there?\n"
    printf "\nA first read file is:\t$f\n"
    printf "\nThe pairing should be as follows:\t$first_reads and $second_read\n" && printf "\nLine 51 worked\n"
    label=$LABEL && printf "\nLine 52 worked\n"
    printf "\nThe label is as follows:\t$label\n"
    printf "\nAll the steps to get the two files ready and associated in the for loop should now be complete\n" && printf "\nLine 54 worked\n"
    printf "\nWill now run BWA-MEM on input files:\t$first_reads and $second_read\n" && printf "\nLine 55 worked\n"
    bwa mem -t 2 -v 2 -C -a "$indexfasta" "$first_reads" "$second_read" > ${label}_BWA_against_bins.sam && printf "\nLine 56 worked\n"
    if [[ -s "${label}_BWA_against_bins.sam" ]]
    then
      samtools quickcheck ${label}_BWA_against_bins.sam && bam_validity_test="P" || bam_vailidity_test="F"
      if [[ $bam_validity_test = "P" ]]
      then
        mv ${label}_BWA_against_bins.sam "$outdir" && printf "\nLine 59 worked\n" || printf "\nFailed to move file to output directory, failing on line 59\n"
        printf "\nWill rezip file $first_reads\n" && gzip "$first_reads"
        printf "\nWill rezip file $second_read\n" && gzip "$second_read"
        origin=$(pwd)
        cd "$outdir" || printf "\nFailed on line 63\n"
        samtools view -@1 -h -b -S "${label}_BWA_against_bins.sam" > ${label}_BWA_against_bins.bam || printf "\nFailed on line 64, did not produce file:\t${label}_BWA_against_bins.bam\n"
        if [[ -s "${label}_BWA_against_bins.bam" ]]
        then
          printf "\nWill zip the ${label}_BWA_against_bins.sam file now we have made ${label}_BWA_against_bins.bam\n"
          gzip "${label}_BWA_against_bins.sam"
          printf "\nSince we have a .bam file made, we will extract the sequences which mapped to the reference\n"
          samtools view -@1 -b -F 4 "${label}_BWA_against_bins.bam" > "${label}_BWA_against_bins_Mapped.bam" || printf "\nFailed on line 70, trying to make a mapped reads BAM file\n"
          if [[ -s "${label}_BWA_against_bins_Mapped.bam" ]]
          then
            printf "\nWill zip file ${label}_BWA_against_bins.bam since we have made ${label}_BWA_against_bins_Mapped.bam\n"
            gzip "${label}_BWA_against_bins.bam" || printf "\nFailed on line 74\n"
          else
            printf "\nHave not produced a proper file for ${label}_BWA_against_bins_Mapped.bam\n"
          fi
        else
          printf "\nFailed to produce proper file for ${label}_BWA_against_bins.bam\n"
        fi
      else
        printf "\nFailed at some point in producing an appropriate output file:\t${label}_BWA_against_bins.sam\n"
        gzip "$first_reads"
        gzip "$second_read"
      fi
    else
      printf "\nFailed to make any sam output file for ${label}_BWA_against_bins.sam\n"
      gzip "$first_reads"
      gzip "$second_read"
    fi
  done
}

failure_function_rezip () {
  cd $READSDIR
  printf "\nFailed to run the BWA-function\n"
  mail -s "Failed to run BWA-mem" peter.osborne@earlham.ac.uk <<< "Failed to produce a sorted.bam file for input file ${label}"
  whereami=$(pwd)
  whenami=$(date)
  what_was_I_doing=$(cat "$BASH_SOURCE" | grep -v EZREMOVEHEADER)
  fail_label=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
  printf "\n$what_was_I_doing\n" >> ${fail_label}_failed_log.txt
  printf "\nFor some reason I have failed. I was running here:\t$whereami\nI was running now:\t$whenami\nThe email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt\n"
  mail -s "Progress Monitoring 85763000" -a ${fail_label}_failed_log.txt peter.osborne@earlham.ac.uk <<< "For some reason I have failed. I was running here: $whereami I was running now: $whenami The email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt"
  gzip $INPF1
  gzip $INPF2
  rm ${fail_label}_failed_log.txt
}

#Now execute the function
run_reads_through_bwa-mem $READSDIR $INDEXDIR $INDEXFASTA $OUTDIR $INPF1 $INPF2 || failure_function_rezip

#Note end time
terminated=$(date) && printf "\n$terminated"
