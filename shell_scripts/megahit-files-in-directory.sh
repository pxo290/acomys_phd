#!/bin/bash -e
#SBATCH -t 06-00:59
#SBATCH -c 6
#SBATCH -p ei-largmem
#SBATCH -J T_Megahit
#SBATCH --mem=650gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --profile=all

###SCRIPT###

source package /tgac/software/testing/bin/megahit-1.1.1_dw

export DEST=$1
export UEI=$2
cd $DEST
export WFS=$(find -maxdepth 1 -type f -name "*.fasta" -not -name "*.fastq")

mkdir -p Megahit_output
cd Megahit_output
export OTD=$(pwd)
cd $DEST

#Defining Megahit function for merged read files or otherwise single FASTA file
MEGH () {
  printf "\n Will run Megahit on the input file: $1"
  printf "\n Will be naming the output based on the first 5 characters of the initial file name."
  export 1stB=$(basename $f)
  export SID=${1stB:0:5}
  megahit -r $1 -o $2 --k-max 145 --k-min 15 --k-step 6 --verbose -out-prefix $SID --memory 0.99 --num-cpu-threads 6
  printf "\n Ran Megahit on the input file: $1"
  printf "\n Output files will be found at: $2/$SID"
  mail -s "Megahit assembly of $1" $3 <<< "Megahit has assembled FASTA file: $1 and the output of this is found at: $2/$SID"
}

for f in $WFS
do
  MEGH $f $DEST $UEI
done
