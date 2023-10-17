#!/bin/bash -e
#SBATCH -t 21-22:45
#SBATCH -p ei-largemem
#SBATCH -c 20
#SBATCH --mem=600gb
#SBATCH --array=1-12%12
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/subsampled-fastqs/fastq_copies/output_files/output_%A_%a.out
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/subsampled-fastqs/fastq_copies/error_files/error_%A_%a.err
#SBATCH --constraint=intel

#The DIAMOND and MEGAN stuff are things done by Jose, he is the one who figured
#out what versions in which combination work

#Getting the right version
source package /tgac/software/testing/bin/diamond-0.9.10

#Going where we are going
echo "We are headed for $1 there to run Diamond on fastq files in an array"
cd $1
destination=$1
export destination
filename=$(ls *.fastq | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')
locale=$(pwd)

#Grouping our files
to_work_files=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*.fastq" \))

#Doing a little check on everything
echo "The files which should be processed during the array run are: "
echo $to_work_files

#Now the meat of the array - running retro diamond
diamond blastx -p 10 -d /ei/scratch/osbourne/RETRO-DIAMOND/nr.dmnd -q $locale/$filename -o ${filename%}-diamond-output.daa -f 100 && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ DIAMOND UPDATE /-/-/ Ran diamond 0.9.10 on '$filename'"
