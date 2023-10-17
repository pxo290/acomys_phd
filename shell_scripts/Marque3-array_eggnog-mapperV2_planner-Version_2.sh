#!/bin/bash -e
#SBATCH -t 00-00:10
#SBATCH -c 1
#SBATCH -J M3-Plan
#SBATCH --mem=6400
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######NOTES######
#!!!! RUN THIS SCRIPT FROM YOUR SCRATCH SCRIPTS DIRECTORY !!!!
#12/05/20
#Added a mail command here so it should let you know when and what script it ends
#up submitting, also shortend the time requested for this job considerably,
#it had been 98 days with the plan that it would be modified to have some kind
#of monitoring system and launch the jobs as and when they all finish, so it
#would need to be running in the background for as long as all the running jobs.
#Unless/until you add in this functionality, it only needs a minute or two to
#do the counting and 'sed-ing' of the modified running scripts before submitting
#them

#01/05/20
#You made some changes to the running script, which are detailed there. To note
#here is that the if system in the running script didn't work, it just ran the
#whole thing again even with a successful run having been completed and the
#greps working to detect the ending pattern when tested on the command line. I
#think this is because the mkdir commands here use the -p flag which overwrites
#existing directories with that name. So, since I don't want this script to fail
#making the directories if they already exist, since all the sed'ing steps in
#the running script come after the making of directories I need to get rid of
#the -p flag from the mkdir bits in this script; but without having the entire
#script fail if the directories exist already. So I am going to leave the -e
#bit at the top, as a matter of form, but later on in this script add in the
#line 'set +e' which should mean it doesn't error out if a step fails, which the
#mkdir command will do if the directory already exists without the -p flag

#28/04/20
#Added some lines of notes to the blank run script so have to change the line
#values here for the various 'sed' commands (I'm not sure why they were wrong)
#These are going from:
# 60,61 to 66,67
# 81,82 to 87,88
# 92,93 to 98,99

#17/04/20
#Making a little change to this and the array scripts. The medium term plan is
#to make a 'smart script' version of this which will be able to resubmit files
#which take too long and fail because of exceeding the time limit in the array
#job. As a part of preparing for this, and for making this script more useful
#when it comes to recording info on the work it does you've added a step here:
# touch $egg_outputs/${trimmed_destination}-output_log.txt
#The idea then is that each array job, if it succeeds will printf append into
#this file the original fasta file it ran on, so you can have a log of what
#worked first time round
#You've also added a couple of other things, such as setting the variables which
#are made from commands to be exported as well

#14/04/20
#This is a copy over of most the script from array_eggnog-mapperV2_planner-Version.sh
#with some edits made after the other version failed due to run time being
#exceeded in some of the files. See the Marque3 blank script for the changes
#made in that file.
#The reasons for these changes are that a number, about 30, of the files which
#were 100,000 reads per file, took too long to run and exceeded the max run time
#on the array jobs. So, for now I have made versions of the fasta files which
#only have 5,000 reads per file. The array job script has been changed so it
#uses less memory -due to comments made about my use of the largemem queue at EI-
#Has a 2 week run time per job and increases the maximum number of array jobs
#which can run simultaneously. Hopefully this will work out as quicker overall
#and mean all the jobs actually get completed. Longer term you will need a better
#solution, probably something which monitors the output of the original array job
#submission and can submit files which take too long to a new array job made up
#of only those files and has more cores or memory, but with a much longer run time.
#In terms of changes to this script, the name of the blank array scripts has been
#changed to the Marque3 version and the max run time of this script increased to
#98 days from 30
#It should now also tidy up the scripts directory by removing all the temporary
#scripts it makes before running the final one

#27/03/20
#This script is meant to be used when you have directories which contain single
#line FASTA files; so all the bases for a read on a single line not all the
#reads on a single line.
#It will go to the directory and do a couple of things:
# 1. Get the directory name and path to it to store as a variable
# 2. Get the directory name specifically and store it as a separate variable
# 3. Get the number of fasta files in the directory
# 4. Make two directories in the input directory to act as the error and output
#    destination for the array processes
# 5. Make a new version of the array_eggnog-mapperV2_blank-Version_2.sh script
#    which has the max number of jobs replaced with the value in the variable
#    storing the number of fasta files in the directory, has the name of the
#    directory in the script name to distinguish it
# 6. Sbatch submits the newly created script which will run Eggnogg-MapperV2 on
#    the user input directory

#27/03/20 - 17:53
#Script failed during testing with 'sed: -e expression #1, char 21: unknown option to `s''
#Looking online this seems to be because the delimiters you were using in the
#sed, between the different bits of the command, were / which also appear in the
#variable you were looking to insert. So in the two sed's where you are putting
#in the path I have replaced the / with @ which should still work as delimiters
#18:01
#Now having the error: 'sed: -e expression #1, char 158: unterminated `s' command'
#From looking online this seems to be another delimiter error, where this time
#it doesn't see a final delimiter. I think I need to replace the third / in the
#command after the variable being inserted with @ as well.

######SCRIPT######
set +e
source package /tgac/software/testing/bin/diamond-0.9.24
home_base=$(pwd) && echo $home_base
destination=$1 && echo $destination
export destination
export home_base
cd $1
export trimmed_destination=${PWD##*/}
echo "Went to directory '$1', will now count the number of fasta files and use this to edit the array script which will run eggnog-mapperV2 on them"
filecount=$(ls *.fasta | wc -l)
mkdir $destination/Eggnog-mapper_outputs
cd $destination/Eggnog-mapper_outputs
export egg_outputs=$(pwd)
cd $1
mkdir $destination/Eggnog-mapper_errors
cd $destination/Eggnog-mapper_errors
export egg_errors=$(pwd)
cd $destination
sed '4,5s/PLACEHOLDER/'$filecount'/' $home_base/Marque3-array_eggnog-mapperV2_blank-Version_2.sh > $home_base/${trimmed_destination}_M3-TEMP1.sh
sed '8,9s@PLACEHOLDER@'$egg_outputs'@' $home_base/${trimmed_destination}_M3-TEMP1.sh > $home_base/${trimmed_destination}_M3-TEMP2.sh
sed '9,10s@PLACEHOLDER@'$egg_errors'@' $home_base/${trimmed_destination}_M3-TEMP2.sh > $home_base/${trimmed_destination}_M3-TEMP3.sh
sed '66,67s@PLACEHOLDER@'$egg_outputs'@' $home_base/${trimmed_destination}_M3-TEMP3.sh > $home_base/${trimmed_destination}_M3-TEMP4.sh
sed '87,88s@PLACEHOLDER@'$egg_outputs'@' $home_base/${trimmed_destination}_M3-TEMP4.sh > $home_base/${trimmed_destination}_M3-TEMP5.sh
sed '98,99s@PLACEHOLDER@'$egg_outputs'@' $home_base/${trimmed_destination}_M3-TEMP5.sh > $home_base/${trimmed_destination}_Marque3-OP2-array_eggnog-mapperV2_run.sh
rm $home_base/${trimmed_destination}_M3-TEMP{1,2,3,4,5}.sh
touch $egg_outputs/${trimmed_destination}-output_log.txt
job_ident=$(sacct -n -X --format jobid --name M3-Plan)
printf "For the scripts run by planning script active on slurm as jobid: $job_ident the following fasta files have successfully been proccessed:\n" >> $egg_outputs/${trimmed_destination}-output_log.txt
sbatch $home_base/${trimmed_destination}_Marque3-OP2-array_eggnog-mapperV2_run.sh && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPERV2 /-/-/ The script "$home_base/${trimmed_destination}_Marque3-OP2-array_eggnog-mapperV2_run.sh" has been submitted."
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Will run eggnog mapper on the fasta files contained within $destination"
