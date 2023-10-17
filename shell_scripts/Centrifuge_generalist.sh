#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 1-23:35
#SBATCH -c 1
#SBATCH --mem=650000
#SBATCH -J Centrifuge_generalist
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script is meant to take advantage of how imprecise Centrifuge is to try
#and find reads which might be worth looking into mapping to the host genome
#The idea is to use it to see what it classifies as Eukaryotic and then see
#how those reads map to the host and the three other contaminant/eukaryote
#genomes you are using, Human, Wheat and Mus musculus

#Stage 1, get Centrifuge sourced
source package /tgac/software/testing/bin/centrifuge-1.0.3

#Stage 2, have it run on all the fastq files in the directory apart from the raw
#paired end read files. Use a find with some filters to make a variable storing
#the ones to work on in it

cd /ei/scratch/osbourne/host-finding
submitted_files=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*.fastq*" -not -name "*.txt" -not -name "*.out" -not -name "*E3*" \))
echo "You will be working on '$submitted_files' in this run using Centrifuge."

for f in $submitted_files
do
  centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --host-taxids 10067 --min-hitlen 29 --reorder -s ${f%}-centrifuge_solo_scoring.out -S ${f%}-centrifuge_solo_scoring-classified.out -U $f && mv *.tsv /ei/scratch/osbourne/host-finding/centrifuge-reports
  cd /ei/scratch/osbourne/host-finding/centrifuge-reports
  rename -v 's/centrifuge_report.tsv/${f%}-centrifuge_solo_scoring-report.tsv' centrifuge_report.tsv
  cd ..
done

#Couple of things to note. The '--min-hitlen 29' means that partial lengths
#must be greater than 29. The '-k 1' means it only finds 1 primary assignment
#which is a holdover from doing it earlier when testing it as a tool for classi
#-fcation; this could be increased in the future. The '--host-taxids 10067' is
#using the taxid in the database for the Acomys genus to try and make the tool
#favour this classification and those which descend from it
