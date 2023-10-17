#!/bin/bash -e
#SBATCH -t 01-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Kaiju_megahit_assemblies_Lac_cultured
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Written: 2021-04-12
#This script goes into subdirectories to find Megahit assemblies matching a set
#naming convention and then runs Kaiju on them. It should then use the output
#from Kaiju to get some useful information from them in a more human readable
#format

#Setting global variables
export REFDBDIR="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
export NODES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
export NAMES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
export REFDBFILE="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"
export LOGFILEDIR="/hpc-home/osbourne/WORKING_LOGS"
export LOCALE=$(pwd)

#Sourcing software
source package /tgac/software/testing/bin/kaiju-1.7.3

#Checking global variables
printf "\nREFDBDIR is\t$REFDBDIR\n"
printf "\nNODES is\t$NODES\n"
printf "\nNAMES is\t$NAMES\n"
printf "\nREFDBFILE is\t$REFDBFILE\n"
printf "\nLOGFILEDIR is\t$LOGFILEDIR\n"
printf "\nLOCALE is\t$LOCALE\n"

#Defining functions
kaiju_execution () {
  inpf1=$1
  lobel=$2
  refdbdir=$3
  refnodes=$4
  refdbfile=$5
  outdir=$6
  printf "\nWill run Kaiju on the input assmebly FA file:\t$inpf1"
  kaiju -t $refnodes -f $refdbfile -v -a greedy -i $inpf1 -o ${lobel}_kaiju_output.out
  mv ${label}_kaiju_output.out $outdir
}

kaiju_output_processing_1 () {
  label=$1
  refdbdir=$2
  refnodes=$3
  refdbfile=$4
  outdir=$5
  refnames=$6
  incoming=${label}_kaiju_output.out
  kaiju2table -t $refnodes -n $refnames -r species -v -p -o ${label}_kaiju_output-SPECIES.tsv $incoming
  kaiju2table -t $refnodes -n $refnames -r genus -v -p -o ${label}_kaiju_output-GENERA.tsv $incoming
  kaiju2table -t $refnodes -n $refnames -r family -v -p -o ${label}_kaiju_output-FAMILY.tsv $incoming
  kaiju2table -t $refnodes -n $refnames -r order -v -p -o ${label}_kaiju_output-ORDER.tsv $incoming
  kaiju2table -t $refnodes -n $refnames -r class -v -p -o ${label}_kaiju_output-CLASS.tsv $incoming
  kaiju2table -t $refnodes -n $refnames -r phylum -v -p -o ${label}_kaiju_output-PHYLA.tsv $incoming
}

kaiju_output_processing_2 () {
  label=$1
  tax_level=$2
  outdir=$3
  inpf=${label}_kaiju_output.out
  tx_level_viral_contigs=$(grep "Viruses" ${label}_kaiju_output-${tax_level}.out | awk -F "\t" '{print $2}')
  tx_level_unclassified_contigs=$(tail -1 ${label}_kaiju_output-${tax_level}.out | awk -F "\t" '{print $2}')
  tx_level_oddly_unclassified=$(grep "cannot be assigned to a (non-viral)" ${label}_kaiju_output-${tax_level}.out | awk -F "\t" '{print $2}')
  printf "\nViruses:\t$tx_level_viral_contigs" >> ${label}_${tax_level}_Kaiju_summary.txt
  printf "\nUnclassified contigs:\t$tx_level_unclassified_contigs" >> ${label}_${tax_level}_Kaiju_summary.txt
  printf "\nUnable to classify (to non-virus) contigs:\t$tx_level_oddly_unclassified" >> ${label}_${tax_level}_Kaiju_summary.txt
  tx_level_bacterial_contigs=$(echo "100 - ("$tx_level_viral_contigs" + "$tx_level_unclassified_contigs" + "$tx_level_oddly_unclassified")" | bc)
  printf "\nBacterial contigs:\t$tx_level_bacterial_contigs\n" >> ${label}_${tax_level}_Kaiju_summary.txt &&
  kaiju-addTaxonNames -t $NODES -n $NAMES -i ${label}_kaiju_output.out -u -r kingdom,phylum,class,order,family,genus,species -o ${label}_kaiju_output.names_added.out
}


failure_function_rezip () {
  printf "\nFailed to run the either the Kaiju or Kaiju ouput processing functions\n"
  mail -s "Failed to run Kaiju or kaiju processing" peter.osborne@earlham.ac.uk <<< "Failed to either run Kaju or kaiju outpur processing for input file $failure_link"
  whereami=$(pwd)
  whenami=$(date)
  what_was_I_doing=$(cat "$BASH_SOURCE" | grep -v EZREMOVEHEADER)
  fail_label=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
  printf "\n$what_was_I_doing\n" >> ${fail_label}_failed_log.txt
  printf "\nFor some reason I have failed. I was running here:\t$whereami\nI was running now:\t$whenami\nThe email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt\n"
  mail -s "Progress Monitoring 85763000" -a ${fail_label}_failed_log.txt peter.osborne@earlham.ac.uk <<< "For some reason I have failed. I was running here: $whereami I was running now: $whenami The email will have the text of what was being done in this script in the attached file ${fail_label}_failed_log.txt"
  gzip $failure_link
  rm ${fail_label}_failed_log.txt
}

#Making the loop to find the assemblies

targets=$(find -maxdepth 2 -type f -name "*megahit_output.fa")
for f in $targets
do
  export label=$(basename $f | awk -F "_" '{print $1"_"$2}') || printf "\nFailed line 100\n"
  export true_name=$(basename $f) || printf "\nFailed line 101\n"
  export containing_dir=$(dirname $f | awk -F "/" '{print $2}') || printf "\nFailed line 102\n"
  export failure_link=$(realpath $f) || printf "\nFailed line 103\n"
  cd $containing_dir || printf "\nFailed line 104\n"
  mkdir -p "${label}_Kaiju_output" || printf "\nFailed line 105\n"
  cd ${label}_Kaiju_output || printf "\nFailed line 106\n"
  export destination_dir=$(pwd) || printf "\nFailed line 107\n"
  cd .. || printf "\nFailed line 108\n"
  kaiju_execution $true_name $label $REFDBDIR $NODES $REFDBFILE $destination_dir || failure_function_rezip
  cd $destination_dir
  kaiju_output_processing_1 $label $REFDBDIR $NODES $REFDBFILE $destination_dir $NAMES || failure_function_rezip
  kaiju_output_processing_2 $label species $destination_dir || failure_function_rezip
  kaiju_output_processing_2 $label genus $destination_dir || failure_function_rezip
  kaiju_output_processing_2 $label family $destination_dir || failure_function_rezip
  kaiju_output_processing_2 $label order $destination_dir || failure_function_rezip
  kaiju_output_processing_2 $label class $destination_dir || failure_function_rezip
  kaiju_output_processing_2 $label phylum $destination_dir || failure_function_rezip
  cd $LOCALE
done
