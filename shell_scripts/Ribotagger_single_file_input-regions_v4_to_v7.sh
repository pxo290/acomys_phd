#!/bin/bash -e
#SBATCH -t 00-06:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Ribotagger
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
export INPF1=$1
export OUTNOM=$2
export UIE=$3
export LOCALE=$(pwd)
mkdir $LOCALE/$OUTNOM
cd $LOCALE/$OUTNOM
export BERTH=$(pwd)
cd $LOCALE

run_ribotagger () {
  inpf1=$1
  outnom=$2
  uie=$3
  berth=$4
  varreg=$5
  printf "\n Will run Ribotagger on input file $inpf1 which will be sent to $berth looking for region $varreg \n"
  srun /ei/scratch/osbourne/Ribotagger/ribotagger-master/ribotagger/ribotagger.pl -no-eukaryota -filetype fasta -region $varreg -i $inpf1 -o $berth/${outnom}_${varreg}
  printf "\n Ran Ribotagger on input file $inpf1 which was sent to $berth and searched for region $varreg \n"
  mail -s "Progress Monitoring 85763000" $uie <<< "Ran Ribotagger on input files $inpf1 and $inpf2 which was sent to $berth and searched for region $varreg"
}

run_ribotagger $INPF1 $OUTNOM $UIE $BERTH v4
run_ribotagger $INPF1 $OUTNOM $UIE $BERTH v5
run_ribotagger $INPF1 $OUTNOM $UIE $BERTH v6
run_ribotagger $INPF1 $OUTNOM $UIE $BERTH v7
