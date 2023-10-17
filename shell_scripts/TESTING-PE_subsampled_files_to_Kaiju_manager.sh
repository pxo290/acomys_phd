#!/bin/bash -e
#SBATCH -t 10-00:00
#SBATCH -p ei-long
#SBATCH -c 1
#SBATCH -J Mothra
#SBATCH --mem=2gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Sourcing Kaiju
source package /tgac/software/testing/bin/kaiju-1.7.3

#Setting inheritable variables
export REFDBDIR="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
export NODES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
export NAMES="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
export REFDBFILE="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"
export LOGFILEDIR="/hpc-home/osbourne/WORKING_LOGS"
export OUTDIR="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing"

export LOCALE=$(pwd)
touch Samples_submitted_to_Kaiju.txt
touch Samples_analysed_by_Kaiju.txt
export SUBJECT=$(find -maxdepth 3 -type f -name "*_Subsampled_R1.fastq.gz")
export COMPLETED_SAMPLES_FILE=$(find -maxdepth 1 -type f -name "Samples_analysed_by_Kaiju.txt")

for f in $SUBJECT
do
  sbatch TESTING_PE_subsampled_files_Kaiju_analysis.sh $f
  printf "\n$f\n" >> Samples_submitted_to_Kaiju.txt
  sleep 1m
done
