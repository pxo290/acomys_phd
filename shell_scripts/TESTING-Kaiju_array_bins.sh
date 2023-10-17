#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH --mem=128gb
#SBATCH --array=1-505
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/slurm_outputs_array_runs/Kaiju_%A_%a.out
#SBATCH -e /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/slurm_outputs_array_runs/Kaiju_%A_%a.err

#Sourcing Kaiju
source package /tgac/software/testing/bin/kaiju-1.7.3

#Setting variables
export INPF1=$(ls *.fa | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')
export LABEL=$(echo $INPF1 | sed 's/.fa//g' | sed 's/Bin_/binned_//g')
export REFDBDIR="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
export NODES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
export NAMES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
export REFDBFILE="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"
export OUTDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing"
export LOGFILEDIR="/hpc-home/osbourne/WORKING_LOGS"
#Overall Kaiju directory is:
#/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/Chris_Q-Seb_R-assemblies_and_co-assemblies/99aab1ea-af6a-4ad1-9e88-5e59e4a6815f/coassembly

#Sourcing Kaiju
source package /tgac/software/testing/bin/kaiju-1.7.3

#Defining functions
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tKaiju job.\nI am running at:\t$tick\nI will work on the input file:\t$INPF1\nI am running in the directory:\t$wobist\nI request the resources:\t00-12:00 on EI-medium\t1 core\t32GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: Kaiju job. I am running at: "$tick" I will work on the input file $INPF1. I am running in the directory: $wobist. I request the resources: 00-12:00 on EI-medium, 1 core and 32GB\n"
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
  kaiju -t $refnodes -f $refdbfile -i $inpf1 -o $outdir/${label}_kaiju_output.out -v -a mem
  printf "\nRan Kaiju on input file:\t$inpf1\n"
}

kaiju_output_processing () {
  label=$1
  refdbdir=$2
  refnodes=$3
  refdbfile=$4
  outdir=$5
  refnames=$6
  incoming=$outdir/${label}_kaiju_output.out
  kaiju2table -t $refnodes -n $refnames -r genus -v -p -o $outdir/${label}_kaiju_output-GENERA.out $incoming
  kaiju2table -t $refnodes -n $refnames -r species -v -p -o $outdir/${label}_kaiju_output-SPECIES.out $incoming
  most_common_species=$(head -2 $outdir/${label}_kaiju_output-SPECIES.out | tail -1)
  most_common_genus=$(head -2 $outdir/${label}_kaiju_output-GENERA.out | tail -1)
  mail -s "Kaiju report headline" peter.osborne@earlham.ac.uk <<< "Input read file was: $INPF1 The most common genus found was: $most_common_genus The most common species found was: $most_common_species" || printf "\nFor some reason the email could not be sent by command on line 62.\n"
}

#Doing the work
captains_log && kaiju_execution $INPF1 $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR
kaiju_output_processing $LABEL $REFDBDIR $NODES $REFDBFILE $OUTDIR $NAMES
mv $short_term_appelation-WORKING_LOG.txt $LOGFILEDIR
