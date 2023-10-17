#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -c 6
#SBATCH -p ei-medium
#SBATCH -J Duk_mgHG
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --nice=250

printf "\nThis script assumes an input file which is an interleaved FASTQ PE file\n"

#Sourcing BBDuk
source package /tgac/software/testing/bin/bbmap-38.06

#Setting and checking variables
export INPF=$1
export LABEL=$2
export READLENGTH=$(head -1 $INPF | awk -F "length=" '{print $2}')
export READCOUNT=$(grep -c "@" $INPF)
export BEAR_REF1='/ei/scratch/osbourne/ANDEAN_BEAR_PREP/bear_genomes/ASIATIC_BLACK_BEAR_REFERENCE-GCA_009660055.1_ASM966005v1_genomic.fna'
export BEAR_REF2='/ei/scratch/osbourne/ANDEAN_BEAR_PREP/bear_genomes/AMERICAN_BLACK_BEAR_REFERENCE-GCA_003344425.1_ASM334442v1_genomic.fna'
printf "\nThe read file input is:\t$INPF\n"
printf "\nThe label which will be applied to the output is:\t$LABEL\n"
printf "\nThe read length of the input read file is:\t$READLENGTH\n"
printf "\nThe number of reads in the input read file is:\t$READCOUNT\n"
printf "\nThe first bear reference genome, the Asiatic black bear is:\t$BEAR_REF1\n"
printf "\nThe second bear reference genome, the American black bear is:\t$BEAR_REF2\n"

#Making a nice little function
printf "\nDefining function to run BBDuk\n"
run_BBDuk () {
  inpf=$1
  label=$2
  readlength=$3
  bear_ref=$4
  printf "\nThe input file is:\t$inpf"
  printf "\nThe label for output is:\t$label"
  printf "\nThe read length used for kmer matching here is:\t$readlength"
  printf "\nThe bear reference genome used is:\t$bear_ref"
  printf "/nNOTE - The matching reads will be renamed to the same name as the sequence in the reference which they match\n"
  srun bbduk.sh -Xmx204g -Xms128g -prealloc -in=$inpf -fbm=f -interleaved=t ref=$bear_ref outm=${label}_bear_reference_hitting.fastq out=${label}_bear_reference_NOT_hitting.fastq overwrite=t rename=t k=$readlength stats=${label}_bear_reference_comparison_stats.txt || printf "\nIf you are seeing this, $inpf was analysed against reference genome $bear_ref with kmers of length $readlength UNSUCCESSFULLY\n"
}

#Running the function on the input using the two different reference genomes
run_BBDuk $INPF $LABEL-bear_ref1 $READLENGTH $BEAR_REF1 && sleep 5m && printf "\nIf you are seeing this, $INPF was sent to be analysed against reference genome $BEAR_REF1 with kmers of length $READLENGTH successfully\n"
run_BBDuk $INPF $LABEL-bear_ref2 $READLENGTH $BEAR_REF2 && sleep 5m && printf "\nIf you are seeing this, $INPF was sent to be analysed against reference genome $BEAR_REF2 with kmers of length $READLENGTH successfully\n"
