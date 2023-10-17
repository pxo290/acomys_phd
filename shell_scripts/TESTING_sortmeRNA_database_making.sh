#!/bin/bash -e
#SBATCH -t 00-16:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J SilvaDBmake
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package /tgac/software/testing/bin/sortmerna-3.0.3 #SortmeRNA
# locale=$(pwd)
# mkdir TRANSIT
# cd TRANSIT/
# holding=$(pwd)
# cd $locale
indexdb --ref /ei/scratch/osbourne/BactspeciesID/SILVA_138_SSURef_tax_silva.fasta,/ei/scratch/osbourne/BactspeciesID/SILVA_138_SSURef_tax_silva-INDEX.idx -m 256000 -v #-tmpdir "$holding"
