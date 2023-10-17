#!/bin/bash -e
#SBATCH -t 00-12:55
#SBATCH -p ei-largemem
#SBATCH -c 2
#SBATCH -J BWA-Al
#SBATCH --mem=615gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script should align PE read files provided by the user in directories
#(script should identify the files and get the pairings right) against the index
#contained in the fixed variable directory

#For portability you would switch the fixed variables
#Also this script assumes the read files are zipped

#Note start time
commenced=$(date) && printf "\n$commenced\n"

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
  #Now to get the different R1 files which will be used for everything else
  cd $inpdir
  #Lower loop keeps breaking and it seems to be on the unzipping files when they are needed, so just putting in a terribly inefficient unzip everything loop first
  for f in *.gz ; do gunzip $f ; done || printf "\nEven the dumb unzip loop failed\n"
  #first_reads=$(find -maxdepth 1 -type f -name "*Subsampled_R1.fastq.gz")
  first_reads=$(find -maxdepth 1 -type f -name "*Subsampled_R1.fastq")
  for f in $first_reads
  do
    cd $inpdir || printf "\nCommand to cd into the input directory (containing reads) failed\n"
    printf "\nA first read file is:\t$f\n"
    raw_name=$(basename $f) && printf "\nLine 47 worked\n"
    second_read=$(echo "$raw_name" | sed 's/R1/R2/g') && printf "\nLine 48 worked\n"
    printf "\nThe pairing should be as follows:\t$raw_name and $second_read\n" && printf "\nLine 49 worked\n"
    label=$(echo "$raw_name" | awk -F "-" '{print $2}' | awk -F "_" '{print $1,$2}' | sed 's/ /_/g') && printf "\nLine 50 worked\n"
    #gunzip $raw_name || printf "\nThe first read was already unzipped\n"
    #gunzip $second_read || printf "\nThe second read was already unzipped\n"
    #inpf1=$(echo $raw_name | awk -F ".gz" '{print $1}')
    #inpf2=$(echo $second_read | awk -F ".gz" '{print $1}')
    inpf1=$(find -maxdepth 1 -type f -name "$raw_name" -not -name "*.gz") && printf "\nLine 55 worked\n"
    inpf2=$(find -maxdepth 1 -type f -name "$second_read" -not -name "*.gz") && printf "\nLine 56 worked\n"
    printf "\nAll the steps to get the two files ready and associated in the for loop should now be complete\n" && printf "\nLine 57 worked\n"
    printf "\nWill now run BWA-MEM on input files:\t$inpf1 and $inpf2\n" && printf "\nLine 58 worked\n"
    bwa mem -t 2 -v 3 -C -a $indexfasta $inpf1 $inpf2 | samtools sort -@2 -o ${label}_BWA_against_bins.bam && printf "\nLine 59 worked\n" && mail -s "BWA-Report" peter.osborne@earlham.ac.uk <<< "Successfully produced file: ${label}_BWA_against_bins.bam"
    mv ${label}_BWA_against_bins.bam $outdir && printf "\nLine 60 worked\n"
    #gzip $inpf1 || printf "\nFile $inpf1 was already zipped again somehow\n"
    #gzip $inpf2 || printf "\nFile $inpf2 was already zipped again somehow\n"
    #cd $outdir && printf "\nLine 63 worked\n"
    #goodcheck=$(find -maxdepth 1 -type f -name "${label}_BWA_against_bins.sam") && printf "\nLine 64 worked\n"
    #headcheck=$(head -1 $goodcheck) && printf "\nLine 65 worked\n"
    #if [ -n "$headcheck" ];
    #then
      #printf "\nAn output file with the right name is detected in the right output directory\n"
      #gzip ${label}_BWA_against_bins.sam
    #else
      #printf "\n---\tFAILED TO MAKE MEANINGFUL OUTPUT\t---\n"
    #fi
    #cd $locale || printf "\nCan't cd to $locale, maybe we never left?\n"
  done
  #Now adding in a re-zip loop at the end again
  for f in *.fastq ; do gzip $f ; done
}

failure_function_rezip () {
  cd $READSDIR
  printf "\nFailed to run the BWA-function\n"
  mail -s "Failed to run BWA-mem" peter.osborne@earlham.ac.uk <<< "Failed to produce a sorted.bam file for input file ${label}"
  for f in *.fastq ; do gzip $f ; done
}

#Now execute the function
run_reads_through_bwa-mem $READSDIR $INDEXDIR $INDEXFASTA $OUTDIR || failure_function_rezip

#Note end time
terminated=$(date) && printf "\n$terminated"
