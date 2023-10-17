#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -c 6
#SBATCH -p ei-medium
#SBATCH -J Duk_mgHG
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --nice=250

export LOCALE=$(pwd)
export INPF1=$1
export INPF2=$2
export LABEL=$3
export HOST=$4
mkdir $LABEL-BBDuk_host_matching_only
cd $LABEL-BBDuk_host_matching_only
export DESTINY=$(pwd)
cd ..
source package /tgac/software/testing/bin/bbmap-38.06
if [ "$HOST" = "AC" ]
then
  export HOST_SPECIES="/hpc-home/osbourne/REFERENCE_GENOMES/mAcoCah1.curated_primary.20181127.fa"
  printf "\n Host species check indicates the host species is $HOST_SPECIES and the relevant host genome file should have been chosen \n"
elif [ "$HOST" = "AR" ]
then
  export HOST_SPECIES="/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa"
  printf "\n Host species check indicates the host species is $HOST_SPECIES and the relevant host genome file should have been chosen \n"
else
  printf "\n You need to enter either AC or AR depending on which the host species is \n"
fi

printf "\nDefining function to run BBDuk\n"
run_BBDuk () {
  inpf1=$1
  inpf2=$2
  label=$3
  host_ref=$4
  destiny=$5
  printf "\nThe first input file is:\t$inpf1"
  printf "\nThe second input file is:\t$inpf2"
  printf "\nThe label for output is:\t$label"
  printf "\nThe host reference genome used is:\t$host_ref"
  printf "/nNOTE - The matching reads will be renamed to the same name as the sequence in the reference which they match\n"
  srun bbduk.sh -Xmx204g -Xms128g -prealloc in=$inpf1 in2=$inpf2 -fbm=f ref=$host_ref outm=$DESTINY/${label}_host_reference_hitting_.fastq rename=f overwrite=t k=31 mcf=0.75 stats=$DESTINY/${label}_host_reference_comparison_stats.txt bhist=$DESTINY/${label}_base_composition_histogram.txt || printf "\nIf you are seeing this, $inpf was analysed against reference genome $host_ref with kmers of length 31 UNSUCCESSFULLY\n"
  srun bbduk.sh -Xmx204g -Xms128g -prealloc in=$inpf1 in2=$inpf2 -fbm=f ref=$host_ref outm=$DESTINY/${label}_host_reference_hitting_NO_MIN_KMER_PERCENTAGE_COVER.fastq overwrite=t rename=t k=31 stats=$DESTINY/${label}_host_reference_comparison_stats_NO_MIN_KMER_PERCENTAGE_COVER.txt || printf "\nIf you are seeing this, $inpf was analysed against reference genome $host_ref with kmers of length 31 UNSUCCESSFULLY\n"
}

run_BBDuk $INPF1 $INPF2 $LABEL $HOST_SPECIES $DESTINY
