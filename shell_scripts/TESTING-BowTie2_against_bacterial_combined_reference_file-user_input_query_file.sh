#!/bin/bash -e
#SBATCH -t 00-05:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J BowedTie
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script should try and map a user input read file to a specific reference
#fasta file.

#Sourcing Bowtie2
source package /nbi/software/production/bin/bowtie2-2.1.0

#Setting fixed variables
export REFSTORE='/ei/scratch/osbourne/genomes/bacterial_genomes' && printf "\n$REFSTORE\n" || printf "\nLine 17 failed\n"
export REFGENOME_INDEX='bacterial_combined_reference' && printf "\n$REFGENOME_INDEX\n" || printf "\nLine 18 failed\n"

#Setting mutable variables - note that INPF1 will break if there are multiple files with _R1.fastq in the directory
export LOCALE=$(pwd) && printf "\n$LOCALE\n" || printf "\nLine 21 failed\n"
#export MINPF1=$1 && printf "\n$MINPF1\n" || printf "\nLine 22 failed\n"
export INPF1=$(ls -d -1 $PWD/** | grep "_R1.fastq") && printf "\n$INPF1\n" || printf "\nLine 23 failed\n"
export INPF2=$(printf "$INPF1" | sed 's/_R1/_R2/g') && printf "\n$INPF2\n" || printf "\nLine 24 failed\n"
export LABEL=$1 && printf "\n$LABEL\n" || printf "\nLine 25 failed\n"

#Defining the bowtie2 execution function
run_bowtie2 () {
  inpf1=$1 && printf "\n$inpf1\n" || printf "\nLine 29 failed\n"
  inpf2=$2 && printf "\n$inpf2\n" || printf "\nLine 30 failed\n"
  locale=$3 && printf "\n$locale\n" || printf "\nLine 31 failed\n"
  refgenomedir=$4 && printf "\n$refgenomedir\n" || printf "\nLine 32 failed\n"
  refgenomename=$5 && printf "\n$refgenomename\n" || printf "\nLine 33 failed\n"
  label=$6 && printf "\n$label\n" || printf "\nLine 34 failed\n"
  printf "\Will run Bowtie2 on input files:\t$inpf1 and\t$inpf2\nThe reference genome index is named:\t$refgenomename and can be found in:\t$refgenomedir\nOutput files will be labelled with:\t$label\n"
  cd $refgenomedir
  printf "\nDefault settings will be used\n"
  bowtie2 -x $refgenomename -1 $inpf1 -2 $inpf2 -S $locale/$label.sam
  #Note that the above command will work on FASTQ input, if input is FASTA needs the flag -f ahead of the input files
  printf "\nRan Bowtie2\n"
  cd $locale
  bowtie2_output=$(find -maxdepth 1 -type f -name "*$label*")
  for f in $bowtie2_output ; do gzip $f && printf "\nCompressed file: $f\n" ; done

}

#Defining the log making function
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tBowtie2 job.\nI am running at:\t$tick\nI will work on the input files:\t$INPF1 and $INPF2\nI am running in the directory:\t$wobist\nI request the resources:\t00-05:00 on EI-medium\t1 core\t128GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: Bowtie2 job. I am running at: "$tick" I will work on the input files $INPF1 and $INPF2. I am running in the directory: $wobist. I request the resources: 00-05:00 on EI-medium, 1 core and 128GB\n"
}

#Executing the function
captains_log && sleep 15s
run_bowtie2 $INPF1 $INPF2 $LOCALE $REFSTORE $REFGENOME_INDEX $LABEL
cd $LOCALE
sleep 10s
rm $short_term_appelation-WORKING_LOG.txt
