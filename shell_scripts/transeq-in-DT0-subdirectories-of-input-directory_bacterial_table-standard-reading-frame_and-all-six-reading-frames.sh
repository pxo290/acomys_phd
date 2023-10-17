#!/bin/bash -e
#SBATCH -t 1-23:35
#SBATCH -c 1
#SBATCH --mem=125000
#SBATCH -J Transeq_reads
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package /tgac/software/testing/bin/emboss-6.6.0
#Getting what we need
cd $1
#Since the subdirectories are in a larger one you can just give it
input_directories=$(find . -maxdepth 1 \( -type d -name "*DT0*" \))
#Easier than a loop into directories and then subloop within them
export raw_input_directories
#Probably redundant but just in case
echo "These are the directories to be worked on: "$input_directories""
#Always nice to see what it worked on
for d in $input_directories
do
  cd "$d"
  echo "±±±±±You are working here $d"
  for f in *.fasta ; do transeq -sequence $f -outseq ${f%}-translated-bacterial-table_reading_frame_1.faa -frame 1 -table 11 && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Translation of '$f' has been completed' ; done
  for f in *.fasta ; do transeq -sequence $f -outseq ${f%}-translated-bacterial-table_all_reading_frames.faa -frame 6 -table 11 && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Translation of '$f' has been completed' ; done
  mv *.faa /ei/scratch/osbourne/translated-to-amino-acids
  cd ..
done
