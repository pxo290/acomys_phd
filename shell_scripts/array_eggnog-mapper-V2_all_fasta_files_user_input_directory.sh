#!/bin/bash -e
#SBATCH -t 00-23:55
#SBATCH -c 15
#SBATCH --mem=700gb
#SBATCH --array=1-PLACEHOLDER%25
#SBATCH -p ei-largemem
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/OP2eggnog-mapper_outputs/eggnog-mapper_%A_%a.out
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/OP2eggnog-mapper_outputs/eggnog-mapper_%A_%a.err
#SBATCH --constraint=intel

#21/02/20
#This script is built on the bones of one Dave W. sent you, so if it works it is
#thanks to him - remember that.
#Ideally this script will run eggnog-mapperV2 on a bunch of fasta files all at
#the same time using an array. The SBATCH instructions for memory, cores and
#time should be used in all the jobs the array starts. Based on testing with the
#subsampled read file you were using it'll take about 5 hours using 10 cores and
#around 300gb of RAM to complete 10,000 reads using Eggnog-mapperV2. This script
#then should only be run on files which have been split into individual files
#with 10,000 sequences per file maximum.

#I've added in the %250 which should limit the thing to a max of 250 jobs from
#this array running at once

#There is no software being sourced here, you are running a python 2 script on
#all the files from the version of Eggnog-mapperV2 you've installed on your
#scratch directory. MAKE SURE YOU AREN'T USING THE TEST DIAMOND DATABASE AGAIN

#First things then, where are we going and what are going to do
echo "We are headed for '$destination' there to run eggnog-mapperV2 on fasta files in an array"
cd $destination

#Array needs the whole path before the $filename in the array input, so let's
#make a variable to store this in
locale=$(pwd) && echo $locale

#Note the time for posterity
##16/03/20 - Noticed, should have realised immediately, that this value is the
#one stored and then used later on in the emails. You need to make a version of
#this to use in the emails which is made afresh each time and tied to the mail
#commands
clock_check=$(date)
echo "The time is: $clock_check"

#Now for the array style bits
filename=$(ls *.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')

#Now the meat of the array
python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 15 -i $locale/$filename --output $filename-eggnog_mapper-output.fasta --output_dir /ei/scratch/osbourne/interleaved-pilot-fastqs/OP2eggnog-mapper_outputs -m diamond -d none --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data/eggnog_proteins.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "I ran a file through eggnog-mapperV2 as part of an array."

#Let us see how this works, trying it at 17:47 21/02/20

#18:34 02/03/20
#So it seems to have issues if you give it a larger number of potential jobs
#then there are files to be run on. It appeared to keep running and submitting
#jobs even once all the files had been worked on. It also looks like the maximum
#concurrent jobs was never reached, something else was constraining your ability
#to submit jobs. So some changes are going to be made:
#Having checked, there are only 1064 fasta files in the directory you will be
#giving it this first time. So that will be the new max job number, not 1300
##Actually, I'm going to try the new idea of having a separate script run first
##which gets the number of fasta files in the directory and then edits the array
##script to put it in. This is why the array value here is PLACEHOLDER
#Will also be setting the max simultaneous job number to 12 from 250
#Changing mem from 325gb to 480gb
#Changing cores from 10 to 15, both in the array instructions and the script bit
#itself
#Removing all the mail commands to stop getting 000's of emails
#Changing the time from 00-06:35 to 00-00:45 since I don't think any individual
#files actually took more than one hour to run anyway

#Will try it again, same test set of files - the AC19N one

#14:45 09/03/20
#The HPC got shut down for maintenance so I had to interrupt the array before it
#had finished. It seemed to be going alright but I have decided to make some
#modifications to the script. These are:
## each array job now asks for 700GB of memory rather than 480GB
## each array job now asks for 50 minutes of run time rather than 45 - in this
#case because I noticed some of the jobs I cancelled taking longer than 45
## each array job now asks for 20 CPUs instead of 15

#Some of the jobs failed, in fact a fair few of them, by running out of time. I am going to increase the time limit from 55 minutes to 5 hours and 55 minutes, since the slurm emailed job log seems to indicate that some of the jobs ran for 4 hours plus.
#This actually makes sense, since there is no actual computational reason for all the files to take the same length. It will depend on the number of hits found in each file, and this is not random but a biological factor which you can't predict at this point.

#14:41 12/03/20
#A number of the jobs failed by running out of time, even with 5 hours 55 minutes as the allowed time. I am going to increase this to 12 hours and 55 minutes instead, as well as increasing the number of jobs allowed simultaneously
#from 12 (which was a holdover from copying the slurm headers from your diamond script) to 25 - though I suspect you won't have the priority/fairshare to actually run that many at once.
#Note that you were running it on the AR34N files, which were 100,000 reads max per file rather than the 10,000 of the earlier tests with AC19N
