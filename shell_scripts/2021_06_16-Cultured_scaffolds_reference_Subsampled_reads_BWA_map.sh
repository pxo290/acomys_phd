#!/bin/bash -eE
#SBATCH -t 00-12:55
#SBATCH -p ei-largemem
#SBATCH -J Cultured_scaffolds_reference_Subsampled_reads_BWA_map
#SBATCH -c 2
#SBATCH --mem=615gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR


#This script will take 2 user provided PE read files and then run them through
#BWA-mem to produce a sam file, which it will then process with SAMtools to end
#up with a zipped sam file, zipped bam file and unzipped bam file containing the
#reads which mapped to the reference. The output directory and the paths to the
#index fasta file and the directory it is contained within are found in the
#fixed variables below and would need to be altered if you wanted to change them

#Setting the fixed variables
export INDEXDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Cultured_SPADES_assembled_combined_reference"
export INDEXFASTA="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Cultured_SPADES_assembled_combined_reference/2021_06_16-Combined_all_nodes_all_scaffolds_all_SPADES_assembled_Lac_cultures"
export OUTDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Mapping_to_culture_scaffolds_combined"

#Logging the fixed variables
printf "\nThere should be some sensible variables following this:\n$INDEXDIR\n$INDEXFASTA\n$OUTDIR\n"

#Setting the mutable variables and awkwardly trying to make sure it is unzipped and the variables are set with it handling whether it is zipped or not to begin with
holdvar1=$1 && gunzip "$holdvar1" && export INPF1=$(echo "$holdvar1" | awk -F ".gz" '{print $1}') && printf "\nINPF1 is:\t$INPF1\n" || export INPF1=$(echo "$holdvar1") && printf "\nINPF1 was already unzipped, it is:\t$INPF1\n"
holdvar2=$2 && gunzip "$holdvar2" && export INPF2=$(echo "$holdvar2" | awk -F ".gz" '{print $1}') && printf "\nINPF2 is:\t$INPF2\n" || export INPF2=$(echo "$holdvar2") && printf "\nINPF2 was already unzipped, it is:\t$INPF2\n"
export LABEL=$3 && printf "\nA label should have been made, appearing here:\t$LABEL\n" && printf "\nThe two filenames which will be given to the function are:\t$INPF1 for the first read file\nAnd:\t$INPF2 for the second read file\n"

#Since this often breaks, have a loop to get the name for the label if it is empty
if [ -z "${LABEL+x}" ]
then
  printf "\nLabel had not been created for some reason\n"
  export LABEL=$(echo "$INPF1" | awk -F "_" '{print $1}' | awk -F "-" '{print $2}')
  printf "\nShould now have made a label, being:\t$LABEL"
else
  printf "\nLabel had been set correctly:\t$LABEL\n"
fi

#Sourcing necessary software tools
source package /tgac/software/testing/bin/bwa-0.7.7
source package /tgac/software/testing/bin/samtools-1.10

#Defining some functions
failure_function_rezip () {
  cd $READSDIR
  printf "\nFailed to run the BWA-function\n"
  mail -s "Failed to run BWA-mem" peter.osborne@earlham.ac.uk <<< "Failed to produce a sorted.bam file for input file ${label}"
  whereami=$(pwd)
  whenami=$(date)
  what_was_I_doing=$(cat "$BASH_SOURCE" | grep -v EZREMOVEHEADER)
  fail_label=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
  printf "\n$what_was_I_doing\n" >> "${fail_label}_failed_log.txt"
  printf "\nFor some reason I have failed. I was running here:\t$whereami\nI was running now:\t$whenami\nThe email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt\n"
  mail -s "Progress Monitoring 85763000" -a "${fail_label}_failed_log.txt" peter.osborne@earlham.ac.uk <<< "For some reason I have failed. I was running here: $whereami I was running now: $whenami The email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt"
  gzip "$INPF1"
  gzip "$INPF2"
  rm "${fail_label}_failed_log.txt"
}

run_reads_through_bwa-mem () {
  inpf1=$1
  inpf2=$2
  label=$3
  outdir=$4
  origin=$(pwd)
  #Step 1, making a SAM file through the mapping
  printf "\nWill try and run bwa mem on $inpf1 and $inpf2\nDesired output file is:\t${label}_BWA_against_bins.sam\n"
  bwa mem -t 2 -v 2 -a "$INDEXFASTA" "$inpf1" "$inpf2" > "${label}_BWA_against_bins.sam" || printf "\nFailed to make the SAM file for label $label\n"
  sleep 2m
  if [[ -s "${label}_BWA_against_bins.sam" ]]
  then
    sleep 2m
    printf "\nWill try and run samtools quickcheck on input file ${label}_BWA_against_bins.sam\n"
    samtools quickcheck "${label}_BWA_against_bins.sam" && sam_validity_test="P" || sam_vailidity_test="F"
    if [[ $sam_validity_test = "P" ]]
    then
      #Step 2, making a BAM file from the SAM file
      sleep 2m
      printf "\nWill try and run samtools view on ${label}_BWA_against_bins.sam\nDesired output file is:\t${label}_BWA_against_bins.bam\n"
      samtools view -@2 -b -S "${label}_BWA_against_bins.sam" > "${label}_BWA_against_bins.bam" || printf "\nFailed trying to turn the SAM file into a BAM file from ${label}_BWA_against_bins.sam\n"
      samtools quickcheck "${label}_BWA_against_bins.bam" && bam_validity_test="P" || bam_validity_test="F"
      if [[ $bam_validity_test = "P" ]]
      then
        #Step 3, making a mapped reads BAM file from the BAM file
        sleep 2m
        printf "\nWill try and run samtools view on ${label}_BWA_against_bins.bam\nDesired output file is:\t${label}_BWA_against_bins_Mapped.bam\n"
        samtools view -@2 -h -b -F 4 "${label}_BWA_against_bins.bam" > "${label}_BWA_against_bins_Mapped.bam" || printf "\nFailed trying to make a mapped reads BAM from ${label}_BWA_against_bins.bam\n"
        samtools quickcheck ${label}_BWA_against_bins_Mapped.bam && mapped_validity_test="P" || mapped_validity_test="F"
        if [[ $mapped_validity_test = "P" ]]
        then
          #Step 4, this is the end of the success path. All files aside from the mapped bam file will be zipped, all sam and bam files will be moved to the output directory
          sleep 2m
          samtools view -@ 2 -h -b -F 2304 "${label}_BWA_against_bins_Mapped.bam" >> "${label}_BWA_against_bins_Mapped.Only_primary_alignments.bam"
          mv "${label}_BWA_against_bins_Mapped.Only_primary_alignments.bam" "$outdir"
          gzip "${label}_BWA_against_bins_Mapped.bam"
          printf "\nWill try and tidy up by moving ${label}_BWA_against_bins_Mapped.bam.gz to $outdir, then zipping ${label}_BWA_against_bins.bam and ${label}_BWA_against_bins.sam then moving them to $outdir\n"
          mv "${label}_BWA_against_bins_Mapped.bam'gz" "$outdir" || printf "\nFailed line 95, moving ${label}_BWA_against_bins_Mapped.bam to $outdir\n"
          gzip "${label}_BWA_against_bins.bam" || printf "\nFailed line 96, zipping file ${label}_BWA_against_bins.bam\n"
          gzip "${label}_BWA_against_bins.sam" || printf "\nFailed line 97, zipping file ${label}_BWA_against_bins.sam\n"
          mv "${label}_BWA_against_bins.bam.gz" "$outdir" || printf "\nFailed line 98, moving file ${label}_BWA_against_bins.bam.gz to $outdir\n"
          mv "${label}_BWA_against_bins.sam.gz" "$outdir" || printf "\nFailed line 99, moving file ${label}_BWA_against_bins.sam.gz to $outdir\n"
          printf "\nWill wrap up by zipping up original input files again\n"
          gzip "$inpf1" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
          gzip "$inpf2" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
        else
          printf "\nThere was no properly formatted file for ${label}_BWA_against_bins_Mapped.bam found, the bam to mapped bam process likely failed\n"
          printf "Will rezip the input files after failing at some point\n"
          gzip "$inpf1" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
          gzip "$inpf2" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
        fi
      else
        printf "\nThere was no properly formatted file for ${label}_BWA_against_bins.bam found, the sam to bam process likely failed\n"
        printf "Will rezip the input files after failing at some point\n"
        gzip "$inpf1" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
        gzip "$inpf2" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
      fi
    else
      printf "\nNo properly formatted file was found for ${label}_BWA_against_bins.sam, likely the BWA-mem execution failed somehow\n"
      printf "Will rezip the input files after failing at some point\n"
      gzip "$inpf1" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
      gzip "$inpf2" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
    fi
  else
    printf "\nThere is no actual file found for ${label}_BWA_against_bins.sam, the BWA-Mem run did fail somehow\n"
    printf "Will rezip the input files after failing at some point\n"
    gzip "$inpf1" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
    gzip "$inpf2" || printf "\nCouldn't re-zip the input file $inpf1 for some reason\n"
  fi
}

captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  export LOGFILEDIR="/hpc-home/osbourne/WORKING_LOGS"
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tBWA-Mem job.\nI am running at:\t$tick\nI will work on the input files:\t$INPF1 and $INPF2\nI am running in the directory:\t$wobist\nI request the resources:\t00-12:55 on EI-largemem\t2 cores\t615GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: BWA-Mem job. I am running at: "$tick" I will work on the input files $INPF1 and $INPF2. I am running in the directory: $wobist. I request the resources: 00-12:55 on EI-largemem, 2 cores and 615GB\n"
  #Remember to add at the end of the entire script the command below:
  #mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
}

#Executing the functions
captains_log
run_reads_through_bwa-mem "$INPF1" "$INPF2" "$LABEL" "$OUTDIR" || failure_function_rezip
mv "$short_term_appelation-WORKING_LOG.txt" "$LOGFILEDIR"

#04_03_21 - changes from the specific PE script currently in Atom and this directory are removing the -C flag from the bwa mem command and removing -h flag from the samtools view command on line 81, the .sam to .bam conversion
#16_06_21 - Tidied up by quoting variables properly and added the -F 2304 step to get only primary alignments BAM file as well
