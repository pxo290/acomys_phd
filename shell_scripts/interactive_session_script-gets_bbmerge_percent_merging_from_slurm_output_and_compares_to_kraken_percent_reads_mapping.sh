#!/bin/bash -e

export locale=$(pwd)
touch percent_reads_merged_versus_percent_reads_kraken_identifies.txt
printf "Percentage Reads merged by BBMerge\tPercentage Reads identified by Kraken2" > percent_reads_merged_versus_percent_reads_kraken_identifies.txt
export link_to_log=$(readlink -f $locale/percent_reads_merged_versus_percent_reads_kraken_identifies.txt)
subject=$(find -maxdepth 1 -type f -name "slurm-32*" -name "*.out")
#for f in slurm-32*
for f in $subject
do
  nom=$(grep "Will merge" $f | awk -F "\t" '{print $2}' | awk -F "and" '{print $1}' | awk -F "_" '{print $1}' | awk -F "-" '{print $2}')
  printf "\nThe name obtained from the slurm output file is:\t$nom\n"
  ID=$(grep "Will merge" $f | awk -F "\t" '{print $2}' | awk -F "and" '{print $1}' | awk -F "_" '{print $1}' | awk -F "-" '{print $1}')
  printf "\nThe ID obtained from the slurm output file is:\t$ID\n"
  percent_reads_merging=$(grep "Joined" $f | awk -F "\t" '{print $3}' | sed 's/%//g') && printf "\nThe percent of reads which merged was:\t$percent_reads_merging\n"
  if [ -z "${percent_reads_merging}" ]
  then
    printf "\nThere was an error getting the percentage reads mapping\n"
    percent_reads_merging="n/a"
  fi
  directory_name=$(printf "$ID-$nom")
  printf "\nThe directory name being used in the find command is:$ID-$nom\n"
  target_directory=$(find -maxdepth 1 -type d -name "*$directory_name")
  cd $target_directory/Kraken2_output || printf "\nCouldn't cd into the Kraken2 output directory by using command cd $<target_directory>/Kraken2_output/\n"
  right_sheet=$(find -maxdepth 1 -type f -name "*_Kraken2-confidence_score_0.10_report.txt")
  if [ -z "${right_sheet}" ]
  then
    printf "\nThere is no appropriate Kraken2 output file for some reason\n"
    classified_reads="N/A"
  elif [ -n "${right_sheet}" ]
  then
    printf "\nThe Kraken2 output file to be used is:\t$right_sheet\n"
    classified_reads=$(grep "root" $right_sheet | awk -F " " '{print $1}') && printf "\nThe percent of reads which Kraken could map was:\t$classified_reads\n"
  else
    printf "\nSomething odd happened\n"
    classified_reads="Odd error"
  fi
  printf "\n$percent_reads_merging\t$classified_reads" >> $link_to_log
  cd $locale
  sleep 3s
done
