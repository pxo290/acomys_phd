#!/bin/bash -e
#SBATCH -t 00-00:42
#SBATCH -c 1
#SBATCH --mem=4000
#SBATCH -J pressing_fastas
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This little script will go through all the fasta files in the directory
#given by the user and turn multi-line fasta files into ones with reads only on
#one line each

#Go where we are going and say why
cd $1
echo "We are going to the directory '$1' where we will turn all fasta files which have reads spread across multiple lines into ones with reads only on a single line each."
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ FASTA UPDATE /-/-/ We are bound for '$1' there to make single-line per read fasta files from multiple-line per read fasta files."

#Make a variable to store the fasta files in and exclude anything else which might be there
basket_of_files=$(find . -maxdepth 1 \( -type f -name "*.fasta" -not -name "*.daa" -not -name "*.sam" -not -name "*.fastq" \))

#Make a loop to do the work on
for f in $basket_of_files
do
  awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' $f > ${f%}-single-line.fasta && echo "Fasta file '$f' is now a single-line per read fasta file." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ FASTA UPDATE /-/-/ In directory '$1' the fasta file '$f' has been made into a single-line per read fasta file."
done

#Single line version below if needed
#basket_of_files=$(find . -maxdepth 1 \( -type f -name "*.fasta" -not -name "*.daa" -not -name "*.sam" -not -name "*.fastq" \)) && for f in $basket_of_files ; do awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' $f > ${f%}-single-line.fasta && echo "Fasta file '$f' is now a single-line per read fasta file." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ FASTA UPDATE /-/-/ In directory '$1' the fasta file '$f' has been made into a single-line per read fasta file." ; done
