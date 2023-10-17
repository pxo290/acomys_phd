#!/bin/bash -e
#SBATCH -t 01-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Setting variables
export ZINPF1=$1
export ZINPF2=$(echo $ZINPF1 | sed 's/_R1.fastq/_R2.fastq/g')
export LABEL=$(echo $ZINPF1 | awk -F "-" '{print $2}' | awk -F "_" '{print $1}')
export REFDBDIR="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
export NODES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
export NAMES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
export REFDBFILE="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"
export LOGFILEDIR="/hpc-home/osbourne/WORKING_LOGS"
export OUTDIR=$(pwd)

#Sourcing software
source package /tgac/software/testing/bin/kaiju-1.7.3

#Checking inherited variables
printf "\nREFDBDIR is\t$REFDBDIR\n"
printf "\nNODES is\t$NODES\n"
printf "\nNAMES is\t$NAMES\n"
printf "\nREFDBFILE is\t$REFDBFILE\n"
printf "\nLOGFILEDIR is\t$LOGFILEDIR\n"
printf "\nOUTDIR is\t$OUTDIR\n"
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
  kaiju -t $refnodes -f $refdbfile -v -a mem -i $inpf1 -j $inpf2 -o ${label}_kaiju_output.out
}

kaiju_output_processing () {
  label=$1
  refdbdir=$2
  refnodes=$3
  refdbfile=$4
  outdir=$5
  refnames=$6
  incoming=$OUTDIR/${label}_kaiju_output.out
  kaiju2table -t $refnodes -n $refnames -r genus -v -p -o ${label}_kaiju_output-GENERA.out $incoming
  kaiju2table -t $refnodes -n $refnames -r species -v -p -o ${label}_kaiju_output-SPECIES.out $incoming
  most_common_species=$(head -2 $OUTDIR/${label}_kaiju_output-SPECIES.out | tail -1)
  most_common_genus=$(head -2 $OUTDIR/${label}_kaiju_output-GENERA.out | tail -1)
  ###EVERYTHING ABOVE HERE CONFIRMED TO WORK IN THIS FUNCTION AS OF 13_03_21
  #Species results handling
  species_viral_reads=$(grep "Viruses" ${label}_kaiju_output-SPECIES.out | awk -F "\t" '{print $2}')
  species_unclassified_reads=$(tail -1 ${label}_kaiju_output-SPECIES.out | awk -F "\t" '{print $2}')
  species_oddly_unclassified=$(grep "cannot be assigned to a (non-viral) species" ${label}_kaiju_output-SPECIES.out | awk -F "\t" '{print $2}')
  printf "\nViruses:\t$species_viral_reads" >> ${label}_SPECIES_Kaiju_summary.txt
  printf "\nUnclassified reads:\t$species_unclassified_reads" >> ${label}_SPECIES_Kaiju_summary.txt
  printf "\nUnable to classify (to non-virus) reads:\t$species_oddly_unclassified" >> ${label}_SPECIES_Kaiju_summary.txt
  species_bacterial_reads=$(echo "100 - ("$species_viral_reads" + "$species_unclassified_reads" + "$species_oddly_unclassified")" | bc)
  printf "\nBacterial reads:\t$species_bacterial_reads\n" >> ${label}_SPECIES_Kaiju_summary.txt
  awk -F "\t" '{print $NF}' ${label}_kaiju_output-SPECIES.out | grep -v "Viruses" | grep -v "cannot" | grep -v "file" | head -n -1 >> ${label}_TEMPORARY_SPECIES_LISTING.txt
  while read -r line ; do printf "$line" | sed 's/;/£/g' | sed 's/.\{1\}$//' | awk -F "£" '{print $NF}' ; done < ${label}_TEMPORARY_SPECIES_LISTING.txt > ${label}_SMARTER_TEMPORARY_SPECIES_LISTING.txt
  touch ${label}_species_and_percentage_reads_detected.txt
  while read -r line
  do
    percentage=$(grep "$line" ${label}_kaiju_output-SPECIES.out | awk -F "\t" '{print $2}')
    if (( $(grep -c . <<<"$percentage") > 1 ))
    then
      summed=$(echo "$percentage" | paste -s -d+ - | bc)
      printf "\n$line\t$summed" >> ${label}_species_and_percentage_reads_detected.txt
    else
      printf "\n$line\t$percentage" >> ${label}_species_and_percentage_reads_detected.txt
    fi
  done < ${label}_SMARTER_TEMPORARY_SPECIES_LISTING.txt
  rm ${label}_SMARTER_TEMPORARY_SPECIES_LISTING.txt
  rm ${label}_TEMPORARY_SPECIES_LISTING.txt
  #Genera results handling
  genus_viral_reads=$(grep "Viruses" ${label}_kaiju_output-GENERA.out | awk -F "\t" '{print $2}')
  genus_unclassified_reads=$(tail -1 ${label}_kaiju_output-GENERA.out | awk -F "\t" '{print $2}')
  genus_oddly_unclassified=$(grep "cannot be assigned to a (non-viral) genus" ${label}_kaiju_output-GENERA.out | awk -F "\t" '{print $2}')
  printf "\nViruses:\t$genus_viral_reads" >> ${label}_GENERA_Kaiju_summary.txt
  printf "\nUnclassified reads:\t$genus_unclassified_reads" >> ${label}_GENERA_Kaiju_summary.txt
  printf "\nUnable to classify (to non-virus) reads:\t$genus_oddly_unclassified" >> ${label}_GENERA_Kaiju_summary.txt
  genus_bacterial_reads=$(echo "100 - ("$genus_viral_reads" + "$genus_unclassified_reads" + "$genus_oddly_unclassified")" | bc)
  printf "\nBacterial reads:\t$genus_bacterial_reads\n" >> ${label}_GENERA_Kaiju_summary.txt
  awk -F "\t" '{print $NF}' ${label}_kaiju_output-GENERA.out | grep -v "Viruses" | grep -v "cannot" | grep -v "file" | head -n -1 >> ${label}_TEMPORARY_GENERA_LISTING.txt
  while read -r line ; do printf "$line" | sed 's/;/£/g' | sed 's/.\{1\}$//' | awk -F "£" '{print $NF}' ; done < ${label}_TEMPORARY_GENERA_LISTING.txt > ${label}_SMARTER_TEMPORARY_GENERA_LISTING.txt
  touch ${label}_genera_and_percentage_reads_detected.txt
  while read -r line
  do
    percentage=$(grep "$line" ${label}_kaiju_output-GENERA.out | awk -F "\t" '{print $2}')
    if (( $(grep -c . <<<"$percentage") > 1 ))
    then
      summed=$(echo "$percentage" | paste -s -d+ - | bc)
      printf "\n$line\t$summed" >> ${label}_genera_and_percentage_reads_detected.txt
    else
      printf "\n$line\t$percentage" >> ${label}_genera_and_percentage_reads_detected.txt
    fi
  done < ${label}_SMARTER_TEMPORARY_GENERA_LISTING.txt
  rm ${label}_SMARTER_TEMPORARY_GENERA_LISTING.txt
  rm ${label}_TEMPORARY_GENERA_LISTING.txt
}

failure_function_rezip () {
  printf "\nFailed to run the either the Kaiju or Kaiju ouput processing functions\n"
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

#First, unzip the input files
gunzip $ZINPF1 || printf "\nFile:\t$ZINPF1\twas already unzipped\n"
gunzip $ZINPF2 || printf "\nFile:\t$ZINPF2\twas already unzipped\n"

#Now go to the Kaiju directory and find the copied over files
export INPF1=$(echo "$ZINPF1" | sed 's/.gz//g') || printf "\nFile 1 was already unzipped\n"
export INPF2=$(echo "$ZINPF2" | sed 's/.gz//g') || printf "\nFile 2 was already unzipped\n"

#Now execute the functions
captains_log
kaiju_execution $INPF1 $INPF2 $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR || failure_function_rezip
kaiju_output_processing $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR $NAMES || failure_function_rezip

#Now storing the input files again by zipping them
gzip $INPF1 || printf "\nFor some reason the files $INPF1 couldn't be zipped back up\n"
gzip $INPF2 || printf "\nFor some reason the files $INPF2 couldn't be zipped back up\n"

#Finishing up by removing the working log from here and sending it to the store in your home directory
mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
