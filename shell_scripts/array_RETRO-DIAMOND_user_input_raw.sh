#!/bin/bash -e
#SBATCH -t 00-21:45
#SBATCH -c 10
#SBATCH --mem=511gb
#SBATCH --array=1-PLACEHOLDER%12
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/diamond_outputs/diamond_%A_%a.out
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/diamond_outputs/diamond_%A_%a.err
#SBATCH --constraint=intel

#03/03/20
#The array components are built on the bones of one Dave W. sent you, so if it works it is
#thanks to him - remember that.
#The DIAMOND and MEGAN stuff are things done by Jose, he is the one who figured
#out what versions in which combination work

#Getting the right versions
source package /tgac/software/testing/bin/diamond-0.9.10

#Going where we are going
echo "We are headed for '$destination' there to run Diamond on fastq files in an array"
cd $destination

#Array needs the whole path before the $filename in the array input, so let's
#make a variable to store this in
locale=$(pwd) && echo $locale

#Note the time for posterity
clock_check=$(date)
echo "The time is: $clock_check"

#Now for the array style bits
filename=$(ls *.fastq | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')

#Now the meat of the array - running retro diamond
diamond blastx -p 10 -d /ei/scratch/osbourne/RETRO-DIAMOND -q $locale/$filename -o $filename-diamond-output.daa -f 100
