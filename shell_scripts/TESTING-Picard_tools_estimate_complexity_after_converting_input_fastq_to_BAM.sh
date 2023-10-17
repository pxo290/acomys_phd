#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J MakeitSo
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


#Notes
#This script takes two PE fastq files, then will convert them to an unpaired
#BAM file using PicardTools. It then analyses the BAM file, also using
#PicardTools to estimate the complexity of the sequencing library which produced
#the reads

#Sourcing the tool
source package /tgac/software/testing/bin/picardtools-2.1.1

#Setting the variables and doing prep work
export RAW_INPF1=$1
gunzip $RAW_INPF1 || printf "\nRead file 1 was not zipped, so doesn't need unzipping\n"
export INPF2_NAME=$(echo $RAW_INPF1 | sed 's/R1/R2/g') #This may not even be necessary, but what the hell
gunzip $RAW_INPF2 || printf "\nRead file 2 was not zipped, so doesn't need unzipping\n"
export SAMPLEID=$(basename $RAW_INPF1 | awk -F "_" '{print $1}')

#Defining the log function
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tPicardTools FastQ to BAM, and then library complexity estimation job.\nI am running at:\t$tick\nI will work on the input files:\t$RAW_INPF1 and $RAW_INPF2\nI am running in the directory:\t$wobist\nI request the resources:\t00-12:00 on EI-medium\t1 core\t256GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: PicardTools FastQ to BAM, and then library complexity estimation job. I am running at: "$tick" I will work on the input files $RAW_INPF1 and $RAW_INPF2. I am running in the directory: $wobist. I request the resources: 00-12:00 on EI-medium 1 core 256GB"
}

#Defining the fastq-->Bam conversion function
conver_fastq () {
  inpf1=$1
  inpf2=$2
  sample_id=$3
  locale=$(pwd)
  mkdir $sample_id-PicardTools_output
  cd $sample_id-PicardTools_output
  output_dir=$(pwd)
  cd $locale
  printf "\nI will convert PE Fastq files:\t$inpf1 and $inpf2\nI will convert them into a BAM file\nI will put the output BAM file here:\t$output_dir\nI will be working in this directory:\t$locale\n"
  printf "\nI am going to use the PicardTools function FasqToSam\n"
  java -jar picard.jar FastqToSam F1=$inpf1 F2=$inpf2 O=${sample_id}-unaligned_read_pairs.bam SM=

}

#Defining the complexity checking function
