#!/bin/bash -e
#SBATCH -t 00-10:30
#SBATCH -p ei-largemem
#SBATCH -c 5
#SBATCH -J Kraken2
#SBATCH --mem=910gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export input_file=$1
export UIE=$2
export BERTH=$3
export works_dir=$(pwd)

###KRAKEN2 ANALYSIS
source package /tgac/software/testing/bin/kraken2-2.0.7
mkdir -p $works_dir/$BERTH
printf "\nDefining function for Kraken2 run with different confidence scores and designated database.\n"
kraken2_run () {
  INPF=$1
  CS=$2
  uie=$3
  DBLAB=$4
  DBPATH=$5
  printf "\n The confidence score which will be used is: $CS \n"
  printf "\n The database which will be used is: $DBLAB \n"
  kraken2 --use-names --db $DBPATH --threads 5 --confidence $CS --unclassified-out $works_dir/$BERTH/${INPF}_$BERTH-Unclassified_confidence_score_${CS}_database_${DBLAB}.txt --classified-out $works_dir/$BERTH/${INPF}_$BERTH-classified_confidence_score_${CS}_database_${DBLAB}.txt $INPF --report $works_dir/$BERTH/${INPF}_$BERTH_confidence_score_${CS}_database_${DBLAB}_report.out
  mv $works_dir/$BERTH/${INPF}_$BERTH_confidence_score_${CS}_database_${DBLAB}_report.out $works_dir/$BERTH/${INPF}_$BERTH_confidence_score_${CS}_database_${DBLAB}_report.txt
  printf "\n Analysed file $INPF with $BERTH using the database $DBPATH and a confidence score of $CS naming the resulting files with $DBLAB"
}
printf "\n Running the Kraken2 analysis function with the newer database for confidence scores above 0.5 \n"
kraken2_run $input_file 1.00 peter.osborne@earlham.ac.uk NEWDB /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $input_file 0.95 peter.osborne@earlham.ac.uk NEWDB /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $input_file 0.75 peter.osborne@earlham.ac.uk NEWDB /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $input_file 0.50 peter.osborne@earlham.ac.uk NEWDB /ei/scratch/osbourne/Kraken2_newer_database

printf "\n Running the Kraken2 analysis function with the older database for confidence scores above 0.5 \n"
kraken2_run $input_file 1.00 peter.osborne@earlham.ac.uk OLDDB /ei/public/databases/kraken/2.0.7_std
kraken2_run $input_file 0.95 peter.osborne@earlham.ac.uk OLDDB /ei/public/databases/kraken/2.0.7_std
kraken2_run $input_file 0.75 peter.osborne@earlham.ac.uk OLDDB /ei/public/databases/kraken/2.0.7_std
kraken2_run $input_file 0.50 peter.osborne@earlham.ac.uk OLDDB /ei/public/databases/kraken/2.0.7_std

printf "\n Running the Kraken2 analysis function with the newer database for confidence scores below 0.5 \n"
kraken2_run $input_file 0.25 peter.osborne@earlham.ac.uk NEWDB /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $input_file 0.10 peter.osborne@earlham.ac.uk NEWDB /ei/scratch/osbourne/Kraken2_newer_database
kraken2_run $input_file 0.05 peter.osborne@earlham.ac.uk NEWDB /ei/scratch/osbourne/Kraken2_newer_database

printf "\n Running the Kraken2 analysis function with the older database for confidence scores below 0.5 \n"
kraken2_run $input_file 0.25 peter.osborne@earlham.ac.uk OLDDB /ei/public/databases/kraken/2.0.7_std
kraken2_run $input_file 0.10 peter.osborne@earlham.ac.uk OLDDB /ei/public/databases/kraken/2.0.7_std
kraken2_run $input_file 0.05 peter.osborne@earlham.ac.uk OLDDB /ei/public/databases/kraken/2.0.7_std

printf "\nDefining function for Kraken2 newer database-derived output processing.\n"
kraken_output_processing () {
  printf "\nThis function will process Kraken2 outputs, creating files ready for joining or other analysis.\n"
  working_file=$1
  taxon_level=$2
  user_input_mail=$3
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
  mail -s "Progress Monitoring 85763000" -a $file_name-$2-and_unclassified_sorted.txt $user_input_mail <<< "\-\-\ KRAKEN2 /-/-/ Attached is some sorted and analysis ready $BERTH output "$file_name-$2-and_unclassified_sorted.txt""
}
cd $works_dir/$BERTH
printf "\n Running kraken output handling function on the products of this script"
export newer_kraken_reports=$(find -maxdepth 1 -type f -name "*.txt" -not -name "*OLDER*") #BE CAUTIOUS WITH THIS - CONSIDER USING ABOVE MORE DISCERNING FIND
for f in $newer_kraken_reports
do
  printf "\nWill run kraken_output_processing function on Kraken2 output file $f\n"
  kraken_output_processing $f S $UIE
  kraken_output_processing $f G $UIE
  kraken_output_processing $f F $UIE
  kraken_output_processing $f O $UIE
  kraken_output_processing $f C $UIE
  kraken_output_processing $f P $UIE
  printf "\nRan kraken_output_processing function on Kraken2 output file $f\n"
done
export newer_krakproc=$(find -maxdepth 1 -type f -name "*NEWDB*" -name "*_report.txt" -not -name "*OLDDB*")

printf "\nDefining function for Kraken2 older database-derived output processing.\n"
old_kraken_output_processing () {
  printf "\nThis function will process Kraken2 outputs, creating files ready for joining or other analysis.\n"
  working_file=$1
  taxon_level=$2
  user_input_mail=$3
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
  sed 's@nclassified@'Unclassified'@' KRAKEN-$file_name-$2-TEMP_FILE7.txt > $file_name-$2-and_unclassified_sorted_OLDER_DATABASE.txt
  rm KRAKEN-$file_name-$2-TEMP_FILE*
  printf "\nThis worked on the Kraken report output file:\n"$working_file"\n"
  mail -s "Progress Monitoring 85763000" -a $file_name-$2-and_unclassified_sorted_OLDER_DATABASE.txt $user_input_mail <<< "\-\-\ KRAKEN2 /-/-/ Attached is some sorted and analysis ready $BERTH output "$file_name-$2-and_unclassified_sorted_OLDER_DATABASE.txt""
}
printf "\n Running kraken output handling function on the products of this script"
# export kraken_reports=$(find -maxdepth 1 -type f -name "*_report.txt" -name "*$BERTH*")
export older_kraken_reports=$(find -maxdepth 1 -type f -name "*OLDDB*" -name "*_report.txt" -not -name "*NEWDB*") #BE CAUTIOUS WITH THIS - CONSIDER USING ABOVE MORE DISCERNING FIND
for f in $older_kraken_reports
do
  printf "\nWill run kraken_output_processing function on Kraken2 output file $f\n"
  old_kraken_output_processing $f S $UIE
  old_kraken_output_processing $f G $UIE
  old_kraken_output_processing $f F $UIE
  old_kraken_output_processing $f O $UIE
  old_kraken_output_processing $f C $UIE
  old_kraken_output_processing $f P $UIE
  printf "\nRan kraken_output_processing function on Kraken2 output file $f\n"
done
