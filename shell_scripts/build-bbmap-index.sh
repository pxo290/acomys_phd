#!/bin/bash -e
#SBATCH -t 14-23:35
#SBATCH -c 1
#SBATCH --mem=475000
#SBATCH -J build-bbmap-index
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


#Getting the software
source package /tgac/software/testing/bin/bbmap-38.06

#Going to the user specified directory
cd $1

#Making a catch-all variable containing all fasta and fastq files present here
genefiles=$(find "$(pwd)" . -maxdepth 1 -type f -name "*.fa" -or -name "*.fastq" -or -name "*.fq" -or -name "*.fna")
echo "The files which will be worked on are as follows: '$genefiles'"
for f in $genefiles
do
  echo "-/-/-/-/-/-/-/Running BBMap to make an index of '$f' now."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Will run BBMap to make an index of '$f'."
  bbmap.sh in=$f ref=${f%}-BBMap-reference.fa
  echo "-/-/-/-/-/-/-/Ran BBMap and made an index of '$f' ."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran BBMap and made an index of '$f'."
done
