#!/bin/bash -e
#SBATCH -t 01-10:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Tst_MtProb
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
export INPF1=$1
export INPF2=$2
export UIE=$3
export LABEL=$4
export LOCALE=$(pwd)
printf "\n First PE input fastq file is: $INPF1 \n"
printf "\n Second PE input fastq file is: $INPF2 \n"
printf "\n User input email address is: $UIE \n"
printf "\n The label used to make the output directory and label the output files is: $LABEL \n"
printf "\n The directory which this script is launched from and which contains the input files is: $LOCALE \n"

mkdir -p $LOCALE/$LABEL
cd $LOCALE/$LABEL && BERTH=$(pwd)
cd $LOCALE

source package 78cb9518-255c-4d1c-9fb1-99a61123483c

run_metaprob () {
  inpf1=$1
  inpf2=$2
  label=$3
  uie=$4
  berth=$5
  #spec_count=$6
  printf "\n Will be running Metaprob on input PE fastq files $inpf1 and $inpf2 with the output sent to output directory $berth \n"
  printf "\n Default values and settings will be used as listed in the documentation \n"
  pathinpf1=$(readlink -f $inpf1)
  pathinpf2=$(readlink -f $inpf2)
  MetaProb -pi $pathinpf1 $pathinpf2 -dirOutput $berth -graphType 0
  printf "\n Ran Metaprob on input PE fastq files $inpf1 and $inpf2 with the output being sent to output directory $berth \n"
  outputted=$(find -maxdepth 1 -type f -name "*$label*")
  for f in $outputted
  do
    printf "\n Moving file $f to directory $berth \n"
    mv $f $berth
  done
  mail -s "Progress Monitoring 85763000" $uie <<< "Ran Metaprob on input PE fastq files $inpf1 and $inpf2 with the output being sent to output directory $berth"
}

run_metaprob $INPF1 $INPF2 "$LABEL" $UIE $BERTH

###NOTES
#26/08/20
#So this script has been superseeded by the script called Metaprob_PE_and_output
#_processing_and_output_concatenation.sh which works to do the binning and then
#as the name suggests it will (if it works) extract all the sequences in each
#bin from the read files using Seqtk. This script now remains as it does not
#take a user provided expected number of bins so will use the default; which
#seems to be calculated automatically.

#19/08/20
#It worked originally, you just had to think about it afterwards. The program
#does not do anything with the reads it bins - just lists all reads in each
#PE read file and the bin it thinks they should go in. This means you can use
#some awk and sed'ing to get list files containing all the read names for each
#bin then use Seqtk to put extract them from the original PE read files. You can
#then concatenate them all together to make two PE read files for each bin from
#the sample. Note that adding the -numSp flag and giving it a number appears to
#function as setting the number of bins you expect as a maximum; since with it
#set to 30 the two different samples you ran with it got 30 bins. It might be
#worth rewriting the function so it can take the flag and it can have different
#values for it. It also now seems to be making an info file which has the name
# {$label}binning.info with the actual value for the label in it naturally. This
#file also gives the cluster (bin) ID and the number of sequences assigned to it
#along with other useful information.

#18/08/20 - Took 1 day 2 hours to run on one of the pilot paired read files
#which had been through QC and cleansing, it produced 4 CSV files, 2 for each
#PE input file. They are clusters and groups respectively. The slurm output file
#indicates it identified 64 clusters and the number of reads in each. What it
#doesn't seem to have done is actually pull out the reads into the clusters.
#This may be an issue with not putting in, so leaving it to default, the number
#of species expected flag; which is -numSp and defaults to 2. I will try and
#increase this to 30 and see what happens. I will also add in the only create
#groups flag, -mg , to see what that does as well. Also modified the line being
#given to the function as originally it just had $LABEL rather than what it says
#now which should put an underscore in after the provided label character.
