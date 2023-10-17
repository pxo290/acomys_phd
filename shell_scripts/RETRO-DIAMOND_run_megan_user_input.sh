#!/bin/bash -e
#SBATCH -t 00-21:45
#SBATCH -c 10
#SBATCH --mem=511gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --constraint=intel

#03/03/20
#This script is somewhat based on the one Jose De-Vega sent you, and hopefully
#it will run Meganiser on the .daa files in the user input directory given on
#the command line
cd $1
source package /tgac/software/testing/bin/MEGAN-6.10.2
for i in *.daa
do
  daa-meganizer -i ${i} -fun 'EGGNOG INTERPRO2GO SEED' -a2t /ei/scratch/osbourne/2nd_Nr_database/prot_acc2tax-Jul2019X1.abin -a2eggnog /ei/scratch/osbourne/2nd_Nr_database/acc2eggnog-Jul2019X.abin -a2interpro2go /ei/scratch/osbourne/2nd_Nr_database/acc2interpro-Jul2019X.abin -a2seed /ei/scratch/osbourne/2nd_Nr_database/acc2seed-May2015XX.abin
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ MEGANISER UPDATE /-/-/ Meganiser has run on .daa file '$i'"
done
