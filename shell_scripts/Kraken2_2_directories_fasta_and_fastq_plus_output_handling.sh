#!/bin/bash -e
#SBATCH -t 00-23:55
#SBATCH -c 10
#SBATCH -J Krak2
#SBATCH --mem=253000
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######SCRIPT######
source package /tgac/software/testing/bin/kraken2-2.0.7
fastq_directory=$1
fasta_directory=$1/Megahit-output
cd $fasta_directory
fasta_files=$(find . -maxdepth 1 -type f -name "*.fasta" -not -name "*.fastq")
for f in $fasta_files
do
  printf "\nWill run:\nKraken2\non file:\n$f"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 10 $f --confidence 0.75 --classified-out $f-kraken-classified.out --report $f-kraken-report.out > $f-kraken_output.txt
  mail -s "Progress Monitoring 85763000" -A $f-kraken_output.txt peter.osborne@earlham.ac.uk <<< "\-\-\ KRAKEN2 /-/-/ A file was processed through Kraken2, the file being "$f""
  printf "\nRan:\nKraken2\non file:\n$f"
done
cd $fastq_directory
fastq_files=$(find . -maxdepth 1 -type f -name "*.fastq" -not -name "*.fasta")
for f in $fastq_files
do
  printf "\nWill run:\nKraken2\non file:\n$f"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --fastq-input --threads 10 $f --confidence 0.75 --classified-out $f-kraken-classified.out --report $f-kraken-report.out > $f-kraken_output.txt
  mail -s -A $f-kraken_output.txt "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ KRAKEN2 /-/-/ A file was processed through Kraken2, the file being "$f""
  printf "\nRan:\nKraken2\non file:\n$f"
done
####Output Handling####
kraken_output_processing () {
  printf "\nThis function will process Kraken2 outputs, creating files ready for joining or other analysis.\n"
  working_file=$1
  taxon_level=$2
  file_name="$(basename -- $working_file)"
  cat $1 > holding.txt
  awk 'gsub(/ +/," ")' holding.txt > KRAKEN-$file_name-$2-TEMP_FILE.txt
  tr -s " " < KRAKEN-$file_name-$2-TEMP_FILE.txt > KRAKEN-$file_name-$2-TEMP_FILE2.txt
  awk '$4=="'$2'"' KRAKEN-$file_name-$2-TEMP_FILE2.txt > KRAKEN-$file_name-$2-TEMP_FILE3.txt
  awk '$4=="U"' KRAKEN-$file_name-$2-TEMP_FILE2.txt >> KRAKEN-$file_name-$2-TEMP_FILE3.txt
  sed -i -e 's/^ *//g' KRAKEN-$file_name-$2-TEMP_FILE3.txt
  cut -f 2,6 KRAKEN-$file_name-$2-TEMP_FILE3.txt > KRAKEN-$file_name-$2-TEMP_FILE4.txt
  sed -i -e 's/ /_/g' KRAKEN-$file_name-$2-TEMP_FILE4.txt
  awk ' { t = $1; $1 = $2; $2 = t; print; } ' KRAKEN-$file_name-$2-TEMP_FILE4.txt > KRAKEN-$file_name-$2-TEMP_FILE5.txt
  sort -k 1b,1 KRAKEN-$file_name-$2-TEMP_FILE5.txt > KRAKEN-$file_name-$2-TEMP_FILE6.txt
  sed -i -e 's/^.\{1\}//' KRAKEN-$file_name-$2-TEMP_FILE6.txt
  #sed -i.bak 's/_/ /g' TEMP_FILE6.txt
  sed 's/^[ \t]*//' KRAKEN-$file_name-$2-TEMP_FILE6.txt > KRAKEN-$file_name-$2-TEMP_FILE7.txt
  sed 's@nclassified@'Unclassified'@' KRAKEN-$file_name-$2-TEMP_FILE7.txt > $file_name-$2-and_unclassified_sorted.txt
  rm KRAKEN-$file_name-$2-TEMP_FILE*
  printf "\nThis worked on the Kraken report output file:\n"$working_file"\n"
  mail -s "Progress Monitoring 85763000" -A $file_name-$2-and_unclassified_sorted.txt peter.osborne@earlham.ac.uk <<< "\-\-\ KRAKEN2 /-/-/ Attached is some sorted and analysis ready Kraken2 output "$file_name-$2-and_unclassified_sorted.txt""
}
cd $fasta_directory
kraken_outputs=$(find . -maxdepth 1 -type f -name "*fasta-kraken-report.out" -not -name "*metaphlan*" -not -name "*centrifuge*" -not -name "*.sh" -not -name "*.daa")
for f in $kraken_outputs
do
  printf "\nWill run kraken_output_processing function on Kraken2 output file $f\n"
  kraken_output_processing $f S
  kraken_output_processing $f G
  kraken_output_processing $f F
  kraken_output_processing $f O
  kraken_output_processing $f C
  kraken_output_processing $f P
  printf "\nRan kraken_output_processing function on Kraken2 output file $f\n"
done
cd $fastq_directory
kraken_outputs=$(find . -maxdepth 1 -type f -name "*fastq-kraken-report.out" -not -name "*metaphlan*" -not -name "*centrifuge*" -not -name "*.sh" -not -name "*.daa")
for f in $kraken_outputs
do
  printf "\nWill run kraken_output_processing function on Kraken2 output file $f\n"
  kraken_output_processing $f S
  kraken_output_processing $f G
  kraken_output_processing $f F
  kraken_output_processing $f O
  kraken_output_processing $f C
  kraken_output_processing $f P
  printf "\nRan kraken_output_processing function on Kraken2 output file $f\n"
done

######NOTES######
#25/05/20
#This script will run Kraken2 using, at the moment, the old database for it on
#EI - taking a user provided directory containing fastq files and also assumes
#there will be a directory within the user provided one called "Megahit-output"
#which will contain fasta files. If this won't be happening comment out the bit
#you don't need - bearing in mind that the Kraken commands specify which type of
#input file they are expecting and so if you are giving it just one type in a
#directory you'll need to change some things.
#The script then goes into output handling, again assuming that you gave it one
#user input directory with a fasta file subdirectory. To make things neater you
#put the output handling into a function which appears to be working, the script
#runs the function multiple times in each directory to get the sorted and
#filtered taxonomic level results.
