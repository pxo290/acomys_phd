#!/bin/bash -e
#SBATCH -t 00-6:00
#SBATCH -p ei-largemem
#SBATCH -c 2
#SBATCH -J BBMask
#SBATCH --mem=825gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
export INPF1=$1
export UIE=$2
export LABEL=$3
export locale=$(pwd)
export lazlab="BBMasked"

source package /tgac/software/testing/bin/bbmap-38.06

mkdir ${LABEL}_BBMasked
cd ${LABEL}_BBMasked
export destination=$(pwd)
cd $locale

run_BBMask () {
  inpf=$1
  uie=$2
  landing=$3
  lazy=$4
  printf "\n Will run BBMask on provided FASTQ file $inpf \n"
  printf "\n The default entropy value used here is 0.7, the window size for entropy calculation is the default 80, the kmer size for repeat detection is the default (5 I believe) and the kmer size for entropy calulation is also the default which (I believe) is 5 \n"
  bbmask.sh in=$inpf qin=auto out=${lazy}_${inpf}.fastq overwrite=f threads=2 lowercase=t -Xmx420g -Xms255g
  printf "\n Ran BBMask on provided FASTQ file $inpf \n"
  mail -s "Progress Monitoring 85763000" $uie <<< "Ran BBMask using default settings on fastq file: $inpf"
  mv ${lazy}_${inpf}.fastq $landing
}

run_BBMask $INPF1 $UIE $destination $lazlab
