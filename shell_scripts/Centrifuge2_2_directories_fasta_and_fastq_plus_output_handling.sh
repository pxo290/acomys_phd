#!/bin/bash -e
#SBATCH -t 00-23:55
#SBATCH -p ei-largemem
#SBATCH -c 12
#SBATCH -J Centrifuge
#SBATCH --mem=553000
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######SCRIPT######
source package /tgac/software/testing/bin/centrifuge-1.0.3_dm
fastq_directory=$1
fasta_directory=$1/Megahit-output
cd $fastq_directory
fastq_files=$(find . -maxdepth 1 -type f -name "*.fastq" -not -name "*.fasta")
for f in $fastq_files
do
  printf "\nThe following FASTQ file will be run through Centrifuge2:\n$f"
  centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids 33208,33090,554915 --threads 12 --min-hitlen 29 --time --reorder -s $f-centrifuge_solo_scoring.out -S $f-centrifuge_solo_scoring-classified.out --report-file $f-centrifuge_solo_scoring_report.tsv -U $f
  mv $f-centrifuge_solo_scoring_report.tsv $f-centrifuge_solo_scoring_report.txt
  mail -s "Progress Monitoring 85763000" -A $f-centrifuge_solo_scoring_report.txt peter.osborne@earlham.ac.uk <<< "\-\-\ CENTRIFUGE /-/-/ A file was processed through Centrifuge2, the file being "$f""
done
cd $fasta_directory
fasta_files=$(find . -maxdepth 1 -type f -name "*.fasta" -not -name "*.fastq")
for f in $fasta_files
do
  printf "\nThe following FASTA file will be run through Centrifuge2:\n$f"
  centrifuge -f -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids 33208,33090,554915 --threads 12 --min-hitlen 29 --time --reorder -s $f-centrifuge_solo_scoring.out -S $f-centrifuge_solo_scoring-classified.out --report-file $f-centrifuge_solo_scoring_report.tsv -U $f
  mv $f-centrifuge_solo_scoring_report.tsv $f-centrifuge_solo_scoring_report.txt
  mail -s "Progress Monitoring 85763000" -A $f-centrifuge_solo_scoring_report.txt peter.osborne@earlham.ac.uk <<< "\-\-\ CENTRIFUGE /-/-/ A file was processed through Centrifuge2, the file being "$f""
done
####Output Handling####
centrifuge_output_handling () {
  printf "\nThis function will process Centrifuge2 outputs, creating files ready for joining or other analysis.\n"
  working_file=$1
  taxon_level=$2
  file_name="$(basename -- $working_file)"
  awk '/'"$2"'/' $working_file > $file_name-CENTRIFUGE-TEMP-$2.txt
  sed -i -e '1,1d' $file_name-CENTRIFUGE-TEMP-$2.txt
  cut -f 1,6 $file_name-CENTRIFUGE-TEMP-$2.txt > V2-$file_name-CENTRIFUGE-TEMP-$2.txt
  sort -k 1b,1 V2-$file_name-CENTRIFUGE-TEMP-$2.txt > $working_file-$2-only_CENTRIFUGE_sorted.txt
  sed -i -e 's/ /_/g' $working_file-$2-only_CENTRIFUGE_sorted.txt
  rm $file_name-CENTRIFUGE-TEMP-$2.txt && rm V2-$file_name-CENTRIFUGE-TEMP-$2.txt
  set +e
  rm *.txt-e
  set -e
  printf "\nYou worked on the Centrifuge report output file:\n"$working_file"\n\n"
  mail -s "Progress Monitoring 85763000" -A $working_file-$2-only_CENTRIFUGE_sorted.txt peter.osborne@earlham.ac.uk <<< "\-\-\ CENTRIFUGE /-/-/ A Centrifuge2 output file was processed and is attached, the file being "$working_file-$2-only_CENTRIFUGE_sorted.txt""
}
cd $fastq_directory
centrifuge_outputs=$(find . -maxdepth 1 -type f -name "*-centrifuge_solo_scoring_report.tsv" -not -name "*metaphlan*" -not -name "*kraken*" -not -name "*.txt" -not -name "*.sh" -not -name "*.daa")
for f in $centrifuge_outputs
do
  printf "\nWill run centrifuge_output_handling function on Centrifuge2 output file $f\n"
  centrifuge_output_handling $f species
  centrifuge_output_handling $f genus
  centrifuge_output_handling $f family
  centrifuge_output_handling $f order
  centrifuge_output_handling $f class
  centrifuge_output_handling $f phylum
  printf "\nRan centrifuge_output_handling function on Centrifuge2 output file $f\n"
done
cd $fasta_directory
centrifuge_outputs=$(find . -maxdepth 1 -type f -name "*-centrifuge_solo_scoring_report.tsv" -not -name "*metaphlan*" -not -name "*kraken*" -not -name "*.txt" -not -name "*.sh" -not -name "*.daa")
for f in $centrifuge_outputs
do
  printf "\nWill run centrifuge_output_handling function on Centrifuge2 output file $f\n"
  centrifuge_output_handling $f species
  centrifuge_output_handling $f genus
  centrifuge_output_handling $f family
  centrifuge_output_handling $f order
  centrifuge_output_handling $f class
  centrifuge_output_handling $f phylum
  printf "\nRan centrifuge_output_handling function on Centrifuge2 output file $f\n"
done

######NOTES######
#25/05/20
#This script will run Centrifuge2, taking a user provided directory containing
#fastq files and also assumes there will be a directory within the user provided
#one called "Megahit-output" which will contain fasta files. If this won't be
#happening comment out the bit.
#The script then goes into output handling, again assuming that you gave it one
#user input directory with a fasta file subdirectory. To make things neater you
#put the output handling into a function which appears to be working, the script
#runs the function multiple times in each directory to get the sorted and
#filtered taxonomic level results.
