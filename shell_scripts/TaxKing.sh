#!/bin/bash -e
#SBATCH -t 28-23:59
#SBATCH -c 2
#SBATCH --mem=12gb
#SBATCH -J TaxKing
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######NOTES######
#17/03/20
#This is the first script to run when any new batch of fastq files have come in
#and you have interleaved them. It presumes that there are fastq files in the
#directory you are giving it as the first user variable and that they have
#already been interleaved

#This script will run FastP on the files and move the QC'ed fastq files into a
#new directory, which will be where the subsequent scripts will go to so that
#they can do all the taxonomic analysis on them.

######NOTES######
#20/03/20
#The exporting of $centrifuge_hold isn't working, even with || to try and have
#it work with either export $centrifuge_hold or export centrifuge_hold. So the
#plan now is to try and have it write the directory into a text file which is
#called VARIABLE_STORE_1.txt and then later on in the subsequent steps when
#centrifuge_hold is needed it can be made from the line in this file. Just make
#sure that the file is in the right directory, or use relative paths to it so
#you can get the name from it anywhere.

#It might have been actually because it wasn't making the centrifuge_hold directory
#at all to begin with. Noticed the mkdir for it was just 'mkdir' without ''-p -v'
#which the earlier ones had. So I will add these to the making of the directory
#but keep the file making and reading bit I have just added.

#20/03/20 18:00
#So this time the TaxKing and TaxPlan scripts ran without failing, but the array
#script failed. It seems that there are more export issues again so I am going to
#do the echo variables into dedicated text files and then make the variables in
#the subsequent scripts directly from these files. I've renamed the text files
#so that they aren't 'VARIABLE_STORE_1' or the like but instead more decsriptive
#of their actual contents.

######SCRIPT######
#First source FastP
source package /tgac/software/testing/bin/fastp-20190305
home_base=$(pwd)
echo "This script is in: '$home_base' and is where the other scripts this one will call are to be found as well"
#export $home_base || export home_base
echo "You have input the directory: '$1'"
export $1
cd $1
parent_directory=$(pwd)
export $parent_directory || export parent_directory
echo $parent_directory > parent_directory_store.txt
echo $home_base > home_base_store.txt
#Note the current directory, since all the other scripts will be kept here and
#need to be run from here
#This ought to be the directory variables we need for now, so move to the user
#input directory and do the loop for FastP. Then make a directory to put the
#qc'eed files into, store that as a variable and then set things up to run the
#planner script.
interleaved_fastqs=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*.fastq" \))
echo "The fastq files found (which are presumably interleaved) are as follows: '$interleaved_fastqs'"
for i in $interleaved_fastqs
do
  echo "Will run FastP on: '$i'"
  fastp -i $i -o ${i%}_qceed.fastq -h ${i%}_qceed.html -j ${i%}_qceed.json
  echo "Ran FastP on: '$i'"
done
mkdir -p -v $parent_directory/fastp-logs/
mkdir -p -v $parent_directory/qceed-fastqs/
for f in *_qceed.html
do
  mv $f $parent_directory/fastp-logs/
done
for f in *_qceed.json
do
  mv $f $parent_directory/fastp-logs/
done
for f in *_qceed.fastq
do
  mv $f $parent_directory/qceed-fastqs/
done
cd $parent_directory/qceed-fastqs/
working_directory=$(pwd)
export $working_directory || export working_directory
echo $working_directory > working_directory_store.txt
mkdir -p -v $working_directory/centrifuge_results
cd $working_directory/centrifuge_results
centrifuge_hold=$(pwd)
echo $centrifuge_hold > $working_directory/centrifuge_store.txt
centrifuge_store=$(cat $working_directory/centrifuge_store.txt) && echo $centrifuge_store
cd $working_directory
#export $centrifuge_hold || export centrifuge_hold
#Now everything should be set up to run the planner script
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ TAXKING /-/-/ The script '$home_base/TaxKing.sh'ran. It went to the directory provided by the user which was '$parent_directory' where it found the following .fastq files which it ran FastP on: '$interleaved_fastqs' and then moved the resulting qc'eed files into '$working_directory' which is were all the subsequent scripts should head to in order to do their work."
sleep 900 && sbatch $home_base/TaxPlan.sh
