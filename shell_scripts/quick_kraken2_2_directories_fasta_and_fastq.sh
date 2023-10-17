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
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 10 $f --confidence 0.75 --classified-out $f-kraken-classified.out --report $f-kraken-report.out > $f-kraken_output.txt
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ KRAKEN2 /-/-/ A file was processed through Eggnon-mapperV2, the file being "$f""
done
cd $fastq_directory
fastq_files=$(find . -maxdepth 1 -type f -name "*.fastq" -not -name "*.fasta")
for f in $fastq_files
do
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --fastq-input --threads 10 $f --confidence 0.75 --classified-out $f-kraken-classified.out --report $f-kraken-report.out > $f-kraken_output.txt
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ KRAKEN2 /-/-/ A file was processed through Eggnon-mapperV2, the file being "$f""
done
####Output Handling####
kraken_output_processing () {
  printf "\nThis function will process Kraken2 outputs, creating files ready for joining or other analysis.\n"
  working_file=$1
  taxon_level=$2
  awk 'gsub(/ +/," ")' $1 > KRAKEN_$1_$2_TEMP_FILE.txt
  tr -s " " < KRAKEN_$1_$2_TEMP_FILE.txt > KRAKEN_$1_$2_TEMP_FILE2.txt
  awk '$4=="'$2'"' KRAKEN_$1_$2_TEMP_FILE2.txt > KRAKEN_$1_$2_TEMP_FILE3.txt
  awk '$4=="U"' KRAKEN_$1_$2_TEMP_FILE2.txt >> KRAKEN_$1_$2_TEMP_FILE3.txt
  sed -i.bak 's/^ *//g' KRAKEN_$1_$2_TEMP_FILE3.txt
  cut -f 2,6 KRAKEN_$1_$2_TEMP_FILE3.txt > KRAKEN_$1_$2_TEMP_FILE4.txt
  sed -i.bak 's/ /_/g' KRAKEN_$1_$2_TEMP_FILE4.txt
  awk ' { t = $1; $1 = $2; $2 = t; print; } ' KRAKEN_$1_$2_TEMP_FILE4.txt > KRAKEN_$1_$2_TEMP_FILE5.txt
  sort -k 1b,1 KRAKEN_$1_$2_TEMP_FILE5.txt > KRAKEN_$1_$2_TEMP_FILE6.txt
  sed -i.bak 's/^.\{1\}//' KRAKEN_$1_$2_TEMP_FILE6.txt
  #sed -i.bak 's/_/ /g' TEMP_FILE6.txt
  sed 's/^[ \t]*//' KRAKEN_$1_$2_TEMP_FILE6.txt > KRAKEN_$1_$2_TEMP_FILE7.txt
  sed 's@nclassified@'Unclassified'@' KRAKEN_$1_$2_TEMP_FILE7.txt > $working_file-$2_and_unclassified_sorted.txt
  rm *TEMP_FILE* && set +e && rm *.bak
  printf "\nThis worked on the Kraken report output file:\n"$working_file"\n"
}
cd "$fasta_directory"
kraken_outputs=$(find . -maxdepth 1 -type f -name "*-kraken_output.txt" -not -name "*metaphlan*" -not -name "*centrifuge*")
for f in *_kraken-report.out
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
cd "$fastq_directory"
kraken_outputs=$(find . -maxdepth 1 -type f -name "*-kraken_output.txt" -not -name "*metaphlan*" -not -name "*centrifuge*")
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
