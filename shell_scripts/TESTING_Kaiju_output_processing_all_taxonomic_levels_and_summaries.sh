#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#nOTE
#This script will work on the assumption that it is in a directory containing
#Kaiju output files with the naming convention <whatever ID>_kaiju_output.out
#It will then go through all these output files and use the kaiju2table tool
#to pull out the results for all taxonomic levels from species-phylum. It will
#make directories which it will store the output files in.

#Setting fixed variables
export REFDBDIR="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
export NODES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
export NAMES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
export REFDBFILE="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"
export LOGFILEDIR="/hpc-home/osbourne/WORKING_LOGS"
export ORIGIN_POINT=$(pwd)

#Sourcing software
source package /tgac/software/testing/bin/kaiju-1.7.3

#Defining functions
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tKaiju2table job.\nI am running at:\t$tick\nI will work on the input file:\t$INPF\nI am running in the directory:\t$wobist\nI request the resources:\t00-12:00 on EI-medium\t1 core\t32GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: Kaiju2table job. I am running at: "$tick" I will work on the input file $INPF. I am running in the directory: $wobist. I request the resources: 00-12:00 on EI-medium, 1 core and 32GB\n"
  #Remember to add at the end of the entire script the command below:
  #mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
}

kaiju_output_processing_1 () {
  incoming=$1
  label=$2
  refdbdir=$3
  refnodes=$4
  refdbfile=$5
  outdir=$6
  refnames=$7
  tax_level=$8
  kaiju2table -t $refnodes -n $refnames -r "$tax_level" -v -p -o ${label}_kaiju_output-${tax_level}.out $incoming
  mv ${label}_kaiju_output-${tax_level}.out $outdir
  kaiju_output_processing_2 ${label}_kaiju_output-${tax_level}.out $label $tax_level $outdir
}

kaiju_output_processing_2 () {
  inpf=$1
  label=$2
  tax_level=$3
  outdir=$4
  cd $outdir
  tx_level_viral_reads=$(grep "Viruses" ${label}_kaiju_output-${tax_level}.out | awk -F "\t" '{print $2}')
  tx_level_unclassified_reads=$(tail -1 ${label}_kaiju_output-${tax_level}.out | awk -F "\t" '{print $2}')
  tx_level_oddly_unclassified=$(grep "cannot be assigned to a (non-viral)" ${label}_kaiju_output-${tax_level}.out | awk -F "\t" '{print $2}')
  printf "\nViruses:\t$tx_level_viral_reads" >> ${label}_${tax_level}_Kaiju_summary.txt
  printf "\nUnclassified reads:\t$tx_level_unclassified_reads" >> ${label}_${tax_level}_Kaiju_summary.txt
  printf "\nUnable to classify (to non-virus) reads:\t$tx_level_oddly_unclassified" >> ${label}_${tax_level}_Kaiju_summary.txt
  tx_level_bacterial_reads=$(echo "100 - ("$tx_level_viral_reads" + "$tx_level_unclassified_reads" + "$tx_level_oddly_unclassified")" | bc)
  printf "\nBacterial reads:\t$tx_level_bacterial_reads\n" >> ${label}_${tax_level}_Kaiju_summary.txt
  cd $ORIGIN_POINT
}

#Executing the functions in a for loop and making the variables they need to work
for f in *_kaiju_output.out
do
  export LABEL=$(basename $f | awk -F "_" '{print $1}')
  mkdir -p "${LABEL}_all_tax_levels_Kaiju_output"
  cd ${LABEL}_all_tax_levels_Kaiju_output
  export OUTDIR=$(pwd)
  cd $ORIGIN_POINT
  export INPF=$f
  captains_log
  kaiju_output_processing_1 $f $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR $NAMES species
  kaiju_output_processing_1 $f $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR $NAMES genus
  kaiju_output_processing_1 $f $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR $NAMES family
  kaiju_output_processing_1 $f $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR $NAMES order
  kaiju_output_processing_1 $f $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR $NAMES class
  kaiju_output_processing_1 $f $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR $NAMES phylum
  cd $ORIGIN_POINT
  mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
done
