#!/bin/bash
#SBATCH -p ei-medium
#SBATCH -c 8
#SBATCH --constraint=intel
#SBATCH --mem=50GB
#SBATCH --mail-type=end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script will use the older versions of Diamond (0.9.10) and MEGAN (6.10.2)
#which Jose has managed to get working so you can actually meganise the .daa
#files at the end, making them much more useful and MEGAN actually worthwhile
#Make sure to thank him and Nasmille for their help and sharing the scripts,
#the script sharing will mean having to make sure you reference him whenever you
#show anything using DIAMOND and MEGAN

source diamond-0.9.10
