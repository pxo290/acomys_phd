#!/bin/bash -e
#SBATCH -t 00-08:00
#SBATCH -c 1
#SBATCH -J EggPrep
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Setting variables
export INPF1=$1 && printf "\nInput file 1 is:\t$INPF1"
export INPF2=$(echo $1 | sed 's/1.fastq/_2.fastq/g') && printf "\nInput file 2 is:\t$INPF2"
export INPDIR=$3 && printf "\nInput directory is:\t$INPDIR"
export LABEL=$4 && printf "\nLabel for directories and files is:\t$LABEL"
export SCRATCHDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/" && printf "\nThe overall scratch directory is:\t$SCRATCHDIR"
export UNIQUE_ID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '') && printf "\nThe unique ID added to these directories and files from this specific run is:\t$UNIQUE_ID\n"
export BLANK_ARRAY_SCRIPT=""

#New feature to hopefully keep a better record of what is happening,where and
#when
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $wobist/${short_term_appelation}-WORKING_LOG.txt
  export CAPNLOG="$wobist/${short_term_appelation}-WORKING_LOG.txt"
  printf "\nI am a:\tEggnog mapper planning and array making job.\nI am running at:\t$tick\nI will work on the input files:\t$INPF1\t$INPF2\nI am running in the directory:\t$wobist\nI request the resources:\t00-08:00\t1 core\t128GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: Eggnog mapper planning and array making job. I am running at: "$tick" I will work on the input files $inpf1 $inpf2 I am running in the directory: $wobist I request the resources: 00-08:00 1 core 128GB"
  sleep 2m
}

#Doing the prep work
captains_log && sleep 2m
cd $SCRATCHDIR
mkdir $UNIQUE_ID-$LABEL
cd $UNIQUE_ID-$LABEL
export WORKDIR=$(pwd) && printf "\nThe working directory for this eggnog run will be:\t$WORKDIR\n" && printf "\nThe working directory for this eggnog run will be:\t$WORKDIR\n" >> $CAPNLOG
scp $INPF1 $WORKDIR
scp $INPF2 $WORKDIR
gunzip *.gz && sleep 2m || sleep 1m && printf "\nThe input files were not zipped when they were copied to the directory:\t$WORKDIR\nTherefore the copies located here have not needed to be unzipped\n"
source package /tgac/software/testing/bin/bbmap-38.06 #BBMap to use reformat.sh and convert fastq to fasta
source package /tgac/software/testing/bin/diamond-0.9.24 #Diamond which will be used by Eggnog-MapperV2 in its execution after this script calls it as an array job

#Getting the two fastq files in the working directory into some variables
export WORKF1=$(find -maxdepth 1 -type f -name "$INPF1" -not -name "$INPF2") && printf "\nThe copied over input file R1 is:\t$WORKF1" >> $CAPNLOG && printf "\nThe copied over input file R1 is:\t$WORKF1"
export WORKF2=$(find -maxdepth 1 -type f -name "$INPF2" -not -name "$INPF1") && printf "\nThe copied over input file R2 is:\t$WORKF2" >> $CAPNLOG && printf "\nThe copied over input file R2 is:\t$WORKF2"

#Defining variable to convert fastq to fasta
convert_fastq () {
  inpf=$1
  label=$2
  uni_id=$3
  read_no=$4
  printf "\nWill be converting the fastq file:\t$inpf to a fasta file.\nThe resulting fasta file will be called:\t$uni_id-${label}-${read_no}\nThe input file should be the first or second read file depending on what appears next:\t$read_no\n"
  printf "\nWill be converting the fastq file:\t$inpf to a fasta file.\nThe resulting fasta file will be called:\t$uni_id-${label}-${read_no}\nThe input file should be the first or second read file depending on what appears next:\t$read_no\n" >> $CAPNLOG
  reformat.sh in=$inpf out=$uni_id-${label}-${read_no}.fasta
}

#Converting the two fastq files
convert_fastq $WORKF1 $LABEL $UNIQUE_ID R1
convert_fastq $WORKF2 $LABEL $UNIQUE_ID R2

#Defining variables for the two fasta files
export FASTFA1=$(find -maxdepth 1 -type f -name "*R1.fasta" -not -name "*.fastq")
export FASTFA2=$(find -maxdepth 1 -type f -name "*R2.fasta" -not -name "*.fastq")

#Making the fasta files into single line versions
for f in $FASTFA1
do
  awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' $f > single_line-$FASTFA1
done
for f in $FASTFA2
do
  awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' $f > single_line-$FASTFA2
done

#Now to split the fasta files into lots with maximum 10,000 sequences in them
source package /tgac/software/testing/bin/seqkit-0.10.0 #Seqkit version 0.10.0
mkdir $FASTFA1-store
mkdir $FASTFA2-store
mv $FASTFA1 $FASTFA1-store
mv $FASTFA2 $FASTFA2-store
cd $FASTFA1-store
for f in *.fasta
do
  seqkit split2 $f -s 10000 -f
  TEMP_count=$(ls -l | wc -l)
  export FASTA1_FILE_COUNT=$(echo "$TEMP_count - 1" | bc)
  printf "\nThe first fasta file, for read 1, has been split into this many 10,000 read containing files\t$FASTA1_FILE_COUNT\n"
done
export FASTA1_DIRECTORY=$(pwd) #Getting this for the array script
cd ..
cd $FASTFA2-store
for f in *.fasta
do
  seqkit split2 $f -s 10000 -f
  TEMP_count=$(ls -l | wc -l)
  export FASTA2_FILE_COUNT=$(echo "$TEMP_count - 1" | bc)
  printf "\nThe second fasta file, for read 2, has been split into this many 10,000 read containing files\t$FASTA2_FILE_COUNT\n"
done
export FASTA2_DIRECTORY=$(pwd) #Getting this for the array script
cd $WORKDIR
scp $BLANK_ARRAY_SCRIPT $WORKDIR
export COPIED_BLANK_ARRAY_SCRIPT=$(find -maxdepth 1 -type f -name "*.sh") #Careful with this



#Return to the input directory before finishing the script and remove the log
#which was made for your own admin and monitoring hpc usage
rm $CAPNLOG
