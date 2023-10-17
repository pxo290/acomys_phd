#!/bin/bash -e
#SBATCH -t 21-22:45
#SBATCH -p ei-largemem
#SBATCH -c 20
#SBATCH --mem=600gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
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

#Note the time for posterity
##16/03/20 - Noticed, should have realised immediately, that this value is the
#one stored and then used later on in the emails. You need to make a version of
#this to use in the emails which is made afresh each time and tied to the mail
#commands
clock_check=$(date)
echo "The time is: $clock_check"

#Grouping our files
to_work_files=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*.fastq" -name "AC16N-BBMap-interleaved.fastq_qceed*" \))

#Doing a little check on everything
echo "The files which should be processed during the array run are: "
echo $to_work_files

#Now the meat of the array - running retro diamond
for f in $to_work_files
do
  echo "Starting diamond run at: $clock_check"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ DIAMOND UPDATE /-/-/ Will run diamond 0.9.10 on '$f' beginning at $clock_check"
  diamond blastx -p 10 -d /ei/scratch/osbourne/RETRO-DIAMOND/nr.dmnd -q $f -o ${f%}-diamond-output.daa -f 100
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ DIAMOND UPDATE /-/-/ Ran diamond 0.9.10 on '$f' finishing at $clock_check"
done
