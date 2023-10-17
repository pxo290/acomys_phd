#!/bin/bash -e
export locale=$(pwd)
touch $locale/NCBI_accessions_for_download.txt
export destiny="$locale/NCBI_accessions_for_download.txt"
for d in *_results_BLAST_output_formats_6_and_0
do
  cd $d
  for f in *format_6_RESULTS.txt
  do
    export accession=$(cat $f | awk -F "\t" '{print $2}')
    printf "\n$accession" >> $destiny
    printf "\nGot accession from file:\t$f"
  done
  cd $locale
done

#04/01/21
#This script to run in an interactive session on the cluster must be kept in and
#run from the directory which contains the subdirectories made by the BLAST
#script you made. It will go into these directories and get the NCBI accession
#from the output format type 6 file made for each of the reads, then will put
#them all into a single file back in the directory from which it was set running
