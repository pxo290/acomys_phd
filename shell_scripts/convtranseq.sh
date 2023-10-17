#!/bin/bash -e
#SBATCH -t 3-23:35
#SBATCH -c 1
#SBATCH --mem=256000
#SBATCH -J convtranseq
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script will take a user input directory, go to it and convert any
#fastq files it finds into fasta files. It will then make amino acid versions
#of these fasta files, .faa files

#Sourcing in the attic
source package /tgac/software/testing/bin/bbmap-38.06
source package /tgac/software/testing/bin/emboss-6.6.0

#Making a note of where we are going
echo "This script will go to '$1' and produce fasta files from fastq files it finds there. It will then make amino acid file conversions of these fasta files"

#Going to our user directory
cd $1

#Making a fastq-storing variable and having a prevention for using diamond
#generated files
basket_of_files=$(find . -maxdepth 1 \( -type f -name "*.fastq" -not -name "*diamond*" \))

#Making two directories, one to store the fasta files and one to store the amino
#acid files after producing them
mkdir fasta_file_versions
mkdir amino_acid_file_versions

#First conversion step, fastq to fasta
for f in $basket_of_files
do
  echo "Will make a fasta version of fastq file '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Will make a fasta version of the fastq file '$f'."
  reformat.sh in=$f out=${f%}-fasta_version.fa && echo "Made a fasta version of fastq file '$f'" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Made a fasta version of the fastq file '$f'."
done

#Next make a nice variable to store the fasta files in so we can work only on
#them
bushel_of_files=$(find . -maxdepth 1 \( -type f -name "*-fasta_version.fa" -not -name "*.fastq" \))

#Second conversion step
for f in $bushel_of_files
do
  echo "Will use transeq to make an amino acid translation of fasta file '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Will use transeq to make an amino acid translation of fasta file '$f'."
  transeq -sequence $f -outseq ${f%}-translated-bacterial-table_reading_frame_1.faa -frame 1 -table 11 && echo "Used transeq to make an amino acid translation of fasta file '$f'" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Used transeq to make an amino acid translation of fasta file '$f'."
done

#Finally, tidy up by moving the files into the right directories
mv *-fasta_version.fa fasta_file_versions/
mv *-translated-bacterial-table_reading_frame_1.faa amino_acid_file_versions/
