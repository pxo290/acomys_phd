#!/bin/bash -e
#SBATCH -t 7-23:59
#SBATCH -p ei-largemem
#SBATCH -c 12
#SBATCH --mem=530gb
#SBATCH -J Array_Meganise
#SBATCH --array=1-12
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/qceed-fastqs/meganised/meganised_%A_%a.out
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/qceed-fastqs/meganised/meganised_%A_%a.err
#SBATCH --constraint=intel

cd $1
source package /tgac/software/testing/bin/MEGAN-6.10.2
locale=$(pwd)
filename=$(ls *.daa | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')
JAVA_OPTS="-XX:+UseSerialGC" daa-meganizer -i $locale/$filename -fun 'EGGNOG INTERPRO2GO SEED' -a2t /ei/scratch/osbourne/2nd_Nr_database/prot_acc2tax-Jul2019X1.abin -a2eggnog /ei/scratch/osbourne/2nd_Nr_database/acc2eggnog-Jul2019X.abin -a2interpro2go /ei/scratch/osbourne/2nd_Nr_database/acc2interpro-Jul2019X.abin -a2seed /ei/scratch/osbourne/2nd_Nr_database/acc2seed-May2015XX.abin && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ MEGANISATION /-/-/ Meganisation of a .daa file has been completed."
