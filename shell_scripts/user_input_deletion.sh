#!/bin/bash -e
#SBATCH -t 00-22:30
#SBATCH -c 4
#SBATCH --mem=16gb
#SBATCH -J lineSplit
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######NOTES######
#24/03/20
#This script will go to a user input directory and delete files listed by the
#user, with a wildcard after their input.

######SCRIPT######
user_directory=$1
to_go=$2

echo "You are going to delete files in '$1', those files being those which match '$2' with a wildcard ending."
cd $1
mail -s "URGENT - Deletion" peter.osborne@earlham.ac.uk <<< "\-\-\ DELETION /-/-/ In directory '$1' you will be deleting files which match '$2'* unless you go and stop this script in the next 15 minutes."
sleep 15m
rm $to_go*
