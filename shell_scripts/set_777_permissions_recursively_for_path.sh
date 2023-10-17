#!/bin/bash -e
#SBATCH -t 00-00:45
#SBATCH -c 1
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######NOTES######
#This script will set universal permissions for the directory path given by the
#user as the first variable.

######SCRIPT######
printf "Universal permissions will be set for files and directories recursively along path $1"
chmod 777 -R $1
