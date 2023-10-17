#!/bin/bash -e
#SBATCH -t 06-00:59
#SBATCH -c 6
#SBATCH -p ei-medium
#SBATCH -J T_Megahit
#SBATCH --mem=350gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --profile=all
#SBATCH --nice=250

######NOTES######
#27/04/20
#Found out that only one node on the medium queue had 750gb to use, so the jobs
#for this script were going to be stuck pending for a long time. Made some
#changes today:
# 1) Increased max run time to 6 days and 59 minutes from 2 days and 59 minutes
# 2) Increased number of cores to 6 from 4
# 3) Decreased memory requested to 350GB from 750GB
# 4) Increased the max memory request in the megahit instructions themselves to
#    0.99 - so 99% of the 350GB

#21/04/20
#This quick script is just meant to get the subsampled fastq files from your
#pilot study queued up on the cluster to go through assembly using Megahit.
#Since Megahit takes as all the files to be worked on, separated by commas you
#need to put these files into some text files then get a variable from this and
#have this in the bit running the actual job itself
#You make some changes to the default paramaters, the ones to do with kmer size


######SCRIPT######
printf "I am going to the directory: $1 \n"
printf "There I am going to put the paths to all fastq files into a text document.\n"
printf "These will then be fed to Megahit as input for assembly using default settings.\n"
# source package /tgac/software/testing/bin/megahit-1.1.1_dw
cd $1
export working_directory=$(pwd)
export trimmed_destination=${PWD##*/}
export filess=$(realpath *.fastq)
printf "The files which will be assembled are: $filess"
for f in *.fastq
do
  echo $f >> $working_directory/holding.txt
done
sed -i 's/bases.fastq/bases.fastq,/g' $working_directory/holding.txt
cat $working_directory/holding.txt | tr -d '\n' > $working_directory/working.txt
export inputs=$(<$working_directory/working.txt)
source package /tgac/software/testing/bin/megahit-1.1.1_dw
for f in *.fastq
do
  megahit --12 $f --k-max 145 --k-min 15 --k-step 6 --verbose -o $working_directory/Megahit-output/ --memory 0.99 --num-cpu-threads 6
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ MEGAHIT /-/-/ Megahit has run on "$f" which was found in "$working_directory" just so you know"
done
# megahit --12 $inputs --k-max 145 --k-min 15 --k-step 6 --verbose --out-dir $working_directory/Megahit-output --memory 0.95 --num-cpu-threads 4
