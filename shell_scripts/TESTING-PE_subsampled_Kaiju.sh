#!/bin/bash -e
#SBATCH -t 01-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Kaiju?
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Sourcing Kaiju
source package /tgac/software/testing/bin/kaiju-1.7.3

#Setting variables
export ZINPF1=$1
export ZINPF2=$(echo $ZINPF1 | sed 's/_R1.fastq/_R2.fastq/g')
export LABEL=$(echo $ZINPF1 | awk -F "-" '{print $2}' | awk -F "_" '{print $1}')
#export REFDBDIR="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
#export NODES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
#export NAMES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
#export REFDBFILE="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"
#export LOGFILEDIR="/hpc-home/osbourne/WORKING_LOGS"
#export OUTDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing"

#Checking inherited variables
printf "\nREFDBDIR is\t$REFDBDIR\n"
printf "\nNODES is\t$NODES\n"
printf "\nNAMES is\t$NAMES\n"
printf "\nREFDBFILE is\t$REFDBFILE\n"
printf "\nLOGFILEDIR is\t$LOGFILEDIR\n"
printf "\nOUTDIR is\t$OUTDIR\n"
printf "\nCOMPLETED_SAMPLES_FILE is\t$COMPLETED_SAMPLES_FILE\n"
printf "\nLOCALE is\t$LOCALE\n"

#Defining functions
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tKaiju job.\nI am running at:\t$tick\nI will work on the input files:\t$INPF1 and $INPF2\nI am running in the directory:\t$wobist\nI request the resources:\t01-12:00 on EI-medium\t1 core\t256GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: Kaiju job. I am running at: "$tick" I will work on the input files $INPF1 and $INPF2. I am running in the directory: $wobist. I request the resources: 01-12:00 on EI-medium, 1 core and 256GB\n"
  #Remember to add at the end of the entire script the command below:
  #mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
}

kaiju_execution () {
  inpf1=$1
  inpf2=$2
  label=$3
  refdbdir=$4
  refnodes=$5
  refdbfile=$6
  outdir=$7
  printf "\nWill run Kaiju on the input PE read files:\t$inpf1 and $inpf2\n"
  kaiju -t $refnodes -f $refdbfile -v -a mem -i $inpf1 -j $inpf2 -o $LOCALE/${label}_kaiju_output.out
}

kaiju_output_processing () {
  label=$1
  refdbdir=$2
  refnodes=$3
  refdbfile=$4
  outdir=$5
  refnames=$6
  incoming=$OUTDIR/${label}_kaiju_output.out
  kaiju2table -t $refnodes -n $refnames -r genus -v -p -o $outdir/${label}_kaiju_output-GENERA.out $incoming
  kaiju2table -t $refnodes -n $refnames -r species -v -p -o $outdir/${label}_kaiju_output-SPECIES.out $incoming
  most_common_species=$(head -2 $OUTDIR/${label}_kaiju_output-SPECIES.out | tail -1)
  most_common_genus=$(head -2 $OUTDIR/${label}_kaiju_output-GENERA.out | tail -1)
  #mv $incoming $outdir
  #mv ${label}_kaiju_output-GENERA.out $outdir
  #mv ${label}_kaiju_output-SPECIES.out $outdir
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Input read files were: $ZINPF1 and $ZINPF2\nThe most common genus found was:$most_common_genus\nThe most common species found was:$most_common_species" || printf "\nFor some reason the email could not be sent by command on line 60.\n"
}

#First, unzip the input files
gunzip $ZINPF1
gunzip $ZINPF2
#Now make these into variables for providing to the Kaiju execution function
export PINPF1=$(echo "$ZINPF1" | sed 's/.gz//g') || printf "\nFile 1 was already unzipped\n"
export PINPF2=$(echo "$ZINPF2" | sed 's/.gz//g') || printf "\nFile 2 was already unzipped\n"

#Now copy the files to the Kaiju subsampled input directory
scp $PINPF1 $OUTDIR
scp $PINPF2 $OUTDIR

#Now rezip the files
gzip $PINPF1 || printf "\nFor some reason the files $INPF1 couldn't be zipped back up\n"
gzip $PINPF2 || printf "\nFor some reason the files $INPF2 couldn't be zipped back up\n"

#Now go to the Kaiju directory and find the copied over files
cd $OUTDIR
export INPF1=$(echo "$ZINPF1" | sed 's/.gz//g') || printf "\nFile 1 was already unzipped\n"
export INPF2=$(echo "$ZINPF2" | sed 's/.gz//g') || printf "\nFile 2 was already unzipped\n"

#Now execute the functions
captains_log && kaiju_execution $INPF1 $INPF2 $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR
kaiju_output_processing $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR $NAMES

#Now storing the input files again by zipping them
gzip $INPF1 || printf "\nFor some reason the files $INPF1 couldn't be zipped back up\n"
gzip $INPF2 || printf "\nFor some reason the files $INPF2 couldn't be zipped back up\n"

#Noting that this file has been analysed in the completed files list created by
#the managing script
printf "$ZINPF1\n" >> $COMPLETED_SAMPLES_FILE

#Finishing up by removing the working log from here and sending it to the store in your home directory
mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
