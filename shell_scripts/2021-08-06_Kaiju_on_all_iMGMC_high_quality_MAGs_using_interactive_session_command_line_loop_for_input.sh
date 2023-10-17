#!/bin/bash -eE
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J KAIJU!
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-08-06
#Tidied up the original version by removing all the || printf fail bits and putting
#in the failure catch function and the right setting for bash. Also changed the
#outdir to the right place for this run on the iMGMC high quality representative
#MAGs and removed the email command. Also made sure that all variables were quoted
#in the commands

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting variables
export INPF1=$1
export LABEL=${INPF1%.fa}
export REFDBDIR="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
export NODES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
export NAMES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
export REFDBFILE="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"
export OUTDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output"
export LOGFILEDIR="/hpc-home/osbourne/WORKING_LOGS"

#Sourcing Kaiju
source package /tgac/software/testing/bin/kaiju-1.7.3

#Defining functions
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo "$RANDOM")
  touch "$short_term_appelation-WORKING_LOG.txt"
  printf "\nI am a:\tKaiju job.\nI am running at:\t$tick\nI will work on the input file:\t$INPF1\nI am running in the directory:\t$wobist\nI request the resources:\t00-12:00 on EI-medium\t1 core\t128GB\n" >> "$short_term_appelation-WORKING_LOG.txt"
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a "$short_term_appelation-WORKING_LOG.txt" peter.osborne@earlham.ac.uk <<< "I am a: Kaiju job. I am running at: "$tick" I will work on the input file $INPF1. I am running in the directory: $wobist. I request the resources: 00-12:00 on EI-medium, 1 core and 128GB\n"
  #Remember to add at the end of the entire script the command below:
  #mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
}

kaiju_execution () {
  inpf1=$1
  label=$2
  refdbdir=$3
  refnodes=$4
  refdbfile=$5
  outdir=$6
  printf "\nWill run Kaiju on input file:\t$inpf1\n"
  #Note, running Kaiju here in mem mode which is not the default; greedy is default. Should mean less memory usage with fewer hits
  kaiju -t "$refnodes" -f "$refdbfile" -v -a mem -i "$inpf1" -o "$outdir/${label}_kaiju_output.out"
  printf "\nRan Kaiju on input file:\t$inpf1\n"
}

kaiju_output_processing () {
  label=$1
  refdbdir=$2
  refnodes=$3
  refdbfile=$4
  outdir=$5
  refnames=$6
  incoming="$outdir/${label}_kaiju_output.out"
  kaiju2table -t "$refnodes" -n "$refnames" -r genus -o "$outdir/${label}_kaiju_output-GENERA.out" "$incoming" -v -p
  kaiju2table -t "$refnodes" -n "$refnames" -r species -o "$outdir/${label}_kaiju_output-SPECIES.out" "$incoming" -v -p
  most_common_species=$(head -2 "$outdir/${label}_kaiju_output-SPECIES.out" | tail -1)
  most_common_genus=$(head -2 "$outdir/${label}_kaiju_output-GENERA.out" | tail -1)
}

#Doing the work
captains_log && kaiju_execution "$INPF1" "$LABEL" "$REFDBDIR" "$NODES" "$REFDBFILE" "$OUTDIR"
kaiju_output_processing "$LABEL" "$REFDBDIR" "$NODES" "$REFDBFILE" "$OUTDIR" "$NAMES"
mv "$short_term_appelation-WORKING_LOG.txt" "$LOGFILEDIR"
