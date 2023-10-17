#!/bin/bash -e
#SBATCH -t 00-04:00
#SBATCH -p ei-medium
#SBATCH -c 10
#SBATCH -J TaxPipe
#SBATCH --mem=130gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###Note that this does work on ei-largemem with 650GB, but I am seeing if it can be made more efficient
###The time limit and memory requests are suitable for two PE files of about 6.5 million reads which are each 1.5GB in size

printf "\nStarting script\n"
export read_file_1=$1
export read_file_2=$2
export user_input_mail=$3
export MDN=$4
export HomeD=$(pwd)

printf "\nSome details for the log.\n"
printf "\nThe first read file was: $read_file_1\n"
printf "\nThe second read file was: $read_file_1\n"
printf "\nThe email address provided was: $user_input_mail\n"
printf "\nThe name which will be given to the files and directory made from the reads is: $MDN\n"
printf "\nAll work will take place in the directory this script is in, the end result here should simply be a directory called: {$MDN}_processed\n"

printf "\nLaying foundations\n"
mkdir -p ${MDN}_processed
cd ${MDN}_processed/
export works_dir=$(pwd)
cd ..
source package /tgac/software/testing/bin/fastp-20190305

printf "\nRunning FASTP for QC\n"
fastp -i $1 -I $2 -o ${1}_QCed1.fastq -O ${2}_QCed2.fastq -h ${MDN}_Fastp.html -j ${MDN}_Fastp.json
export fastp_html=$(find -maxdepth 1 -type f -name "${MDN}_Fastp.html")
mail  -s "Progress Monitoring 85763000" -a $fastp_html "$user_input_mail" <<< "Html FastP result file for the read files $read_file_1 and $read_file_2 is attached"
export RFQ1=$(find -maxdepth 1 -type f -name "${1}_QCed1.fastq")
export RFQ2=$(find -maxdepth 1 -type f -name "${2}_QCed2.fastq")
mv ${MDN}_Fastp.json $works_dir
mv ${MDN}_Fastp.html $works_dir

printf "\nRunning Metaphlan2 on $RFQ1 and $RFQ2 \n"
mkdir -p $works_dir/Metaphlan2
source package /tgac/software/testing/bin/metaphlan-2.0 #Metaphlan
srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py "$RFQ1","$RFQ2" --bowtie2out HOLDINGBOWTIE2_${read_file_1}_and_${read_file_2}.txt --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type fastq > ${MDN}_Metaphlan2-output.txt
mv ${MDN}_Metaphlan2-output.txt $works_dir/Metaphlan2/
rm HOLDINGBOWTIE2_${read_file_1}_and_${read_file_2}.txt #This has to be done else the next run demands it as an input or it being deleted
mail -s "Progress Monitoring 85763000" -a $works_dir/Metaphlan2/${MDN}_Metaphlan2-output.txt "$user_input_mail" <<< "Metahphan2 results file for read files $read_file_1 and $read_file_2 is attached"

printf "\nRunning Metaphlan2 with the profile relative abundances and estimate number of reads coming from each clade mode \n"
srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py -t rel_ab_w_read_stats "$RFQ1","$RFQ2" --bowtie2out HOLDINGBOWTIE2_${read_file_1}_and_${read_file_2}.txt --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type fastq > ${MDN}_abundance_and_read_counts-Metaphlan2-output.txt
mv ${MDN}_abundance_and_read_counts-Metaphlan2-output.txt $works_dir/Metaphlan2/
mail -s "Progress Monitoring 85763000" -a $works_dir/Metaphlan2/${MDN}_abundance_and_read_counts-Metaphlan2-output.txt "$user_input_mail" <<< "Metahphan2 results file for read files $read_file_1 and $read_file_2 hopefully giving relative abundance and estimated read counts is attached."

printf "\nRunning Kraken2 on $RFQ1 and $RFQ2 \n"
source package /tgac/software/testing/bin/kraken2-2.0.7 #Kraken2
mkdir -p $works_dir/Kraken2
printf "\nDefining function for Kraken2 run with different confidence scores.\n"
kraken2_run () {
  R1=$1
  R2=$2
  CS=$3
  mdn=$4
  printf "\n The confidence score which will be used is: $CS \n"
  kraken2 --paired --db /ei/public/databases/kraken/2.0.7_std --threads 10 --confidence $CS --unclassified-out ${mdn}_Kraken2-Unclassified_confidence_score${CS}_#.txt --classified-out ${mdn}_Kraken2-classified_confidence_score${CS}_#.txt $R1 $R2 --report ${mdn}_Kraken2_confidence_score_${CS}_report.out
  mv ${mdn}_Kraken2_confidence_score_${CS}_report.out ${mdn}_Kraken2_confidence_score_${CS}_report.txt
  mail -s "Progress Monitoring 85763000" -a ${mdn}_Kraken2_confidence_score_${CS}_report.txt "$user_input_mail" <<< "Kraken2 report for read files $R1 and $R2 with confidence score $CS is attached"
  mv ${mdn}_Kraken2_confidence_score_${CS}_report.txt $works_dir/Kraken2
  mv ${mdn}_Kraken2-classified_confidence_score${CS}_* $works_dir/Kraken2
  mv ${mdn}_Kraken2-Unclassified_confidence_score${CS}_* $works_dir/Kraken2
}
printf "\nRunning Kraken2 with different confidence scores \n"
kraken2_run $RFQ1 $RFQ2 1.00 $MDN
kraken2_run $RFQ1 $RFQ2 0.95 $MDN
kraken2_run $RFQ1 $RFQ2 0.75 $MDN
kraken2_run $RFQ1 $RFQ2 0.50 $MDN
kraken2_run $RFQ1 $RFQ2 0.25 $MDN
kraken2_run $RFQ1 $RFQ2 0.10 $MDN
kraken2_run $RFQ1 $RFQ2 0.05 $MDN

printf "\nRunning Centrifuge2 on $RFQ1 and $RFQ2 \n"
source package /tgac/software/testing/bin/centrifuge-1.0.3_dm #Centrifuge
mkdir -p $works_dir/Centrifuge2
printf "\nDefining function for Centrifuge run with excluded taxa, these should be provided to this function in the 4th position as comma separated list of taxids from the Centrifuge database.\n"
centrifuge_excluding () {
  R1=$1
  R2=$2
  MHL=$3
  ETX=$4
  printf "\nThe following taxIDs are being excluded: $ETX \n"
  centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids $ETX --threads 10 --min-hitlen $MHL --time --reorder -S ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}.out --un-conc PAIRS_NON_CONCORDANT_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}.out --al-conc PAIRS_CONCORDANT_Min_once_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}.out  --report-file ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}_REPORT.tsv -1 $R1 -2 $R2
  mv ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}_REPORT.tsv ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}_REPORT.txt
  mail -s "Progress Monitoring 85763000" -a ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}_REPORT.txt "$user_input_mail" <<< "Centrifuge2 report for read files $R1 and $R2 is attached, parameters were exclusion of taxa: $ETX and minimum required hit length of: $MHL"
  mv ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}_REPORT.txt $works_dir/Centrifuge2/
  mv ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}.out $works_dir/Centrifuge2/
  mv PAIRS_NON_CONCORDANT_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}.{1..2}.out $works_dir/Centrifuge2/
  mv PAIRS_CONCORDANT_Min_once_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}.{1..2}.out $works_dir/Centrifuge2/
}

printf "\nNote that whilst I would like the Centrifuge metrics file, to know exactly how many reads it actually analyses, the flag to make the metrics file is bugged so you end up with an empty report file when you ask for the report in the same command. The report is much more useful for you now, later on the solution might be to make another function for both the excluding and inclusive runs which just asks for the metrics file.\n"

printf "\nDefining function for Centrifuge run without excluded taxa.\n"
centrifuge_inclusive () {
  R1=$1
  R2=$2
  MHL=$3
  centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --threads 10 --min-hitlen $MHL --time --reorder -S ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}.out --un-conc PAIRS_NON_CONCORDANT_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}.out --al-conc PAIRS_CONCORDANT_Min_once_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}.out --report-file ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_REPORT.tsv -1 $R1 -2 $R2
  mv ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_REPORT.tsv ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_REPORT.txt
  mail -s "Progress Monitoring 85763000" -a ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_REPORT.txt "$user_input_mail" <<< "Centrifuge2 report for read files $R1 and $R2 is attached with minimum required hit length of: $MHL"
  mv ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_REPORT.txt $works_dir/Centrifuge2/
  mv ${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}.out $works_dir/Centrifuge2/
  mv PAIRS_NON_CONCORDANT_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}.{1..2}.out $works_dir/Centrifuge2/
  mv PAIRS_CONCORDANT_Min_once_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}.{1..2}.out $works_dir/Centrifuge2/
}

printf "\nRunning Centrifuge with different minimum hit lengths and excluded taxIDs.\n"
centrifuge_excluding $RFQ1 $RFQ2 29 33208,33090,554915
centrifuge_excluding $RFQ1 $RFQ2 15 33208,33090,554915
centrifuge_excluding $RFQ1 $RFQ2 50 33208,33090,554915
centrifuge_excluding $RFQ1 $RFQ2 75 33208,33090,554915
centrifuge_excluding $RFQ1 $RFQ2 120 33208,33090,554915
printf "\nRunning Centrifuge with different minimum hit lengths and NO excluded taxIDs.\n"
centrifuge_inclusive $RFQ1 $RFQ2 29
centrifuge_inclusive $RFQ1 $RFQ2 15
centrifuge_inclusive $RFQ1 $RFQ2 50
centrifuge_inclusive $RFQ1 $RFQ2 75
centrifuge_inclusive $RFQ1 $RFQ2 120

printf "\nDefining function for Centrifuge output processing.\n"
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
  mail -s "Progress Monitoring 85763000" -a $working_file-$2-only_CENTRIFUGE_sorted.txt $user_input_mail <<< "\-\-\ CENTRIFUGE /-/-/ A Centrifuge2 output file was processed and is attached, the file being "$working_file-$2-only_CENTRIFUGE_sorted.txt""
}
cd $works_dir/Centrifuge2/
printf "\n Running centrifuge output handling function on the products of this script"
# export centrifuge_reports=$(find -maxdepth 1 -type f -name "*_REPORT.txt" -name "*_Centrifuge2_*")
export centrifuge_reports=$(find -maxdepth 1 -type f -name "*.txt") #BE CAUTIOUS WITH THIS - CONSIDER USING ABOVE MORE DISCERNING FIND
for f in $centrifuge_reports
do
  printf "Will process this Centrifuge report output file: $f"
  centrifuge_output_handling $f species
  centrifuge_output_handling $f genus
  centrifuge_output_handling $f family
  centrifuge_output_handling $f order
  centrifuge_output_handling $f class
  centrifuge_output_handling $f phylum
done
export procent=$(find -maxdepth 1 -type f -name "*-only_CENTRIFUGE_sorted.txt")

printf "\nDefining function for Kraken output processing.\n"
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
  mail -s "Progress Monitoring 85763000" -a $file_name-$2-and_unclassified_sorted.txt $user_input_mail <<< "\-\-\ KRAKEN2 /-/-/ Attached is some sorted and analysis ready Kraken2 output "$file_name-$2-and_unclassified_sorted.txt""
}
cd $works_dir/Kraken2
printf "\n Running kraken output handling function on the products of this script"
# export kraken_reports=$(find -maxdepth 1 -type f -name "*_report.txt" -name "*Kraken2*")
export kraken_reports=$(find -maxdepth 1 -type f -name "*.txt") #BE CAUTIOUS WITH THIS - CONSIDER USING ABOVE MORE DISCERNING FIND
for f in $kraken_reports
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
export krakproc=$(find -maxdepth 1 -type f -name "*-and_unclassified_sorted.txt")

printf "\nDefining function for Metaphlan output processing.\n"
metaphlan_output_processing () {
  printf "\nThis function will process Metaphlan2 outputs, creating files ready for joining or other analysis.\n"
  export working_file=$1
  export taxon_level=$2
  export anti_taxon_level=$3
  export metaphlan_identifier=${working_file:0:7}
  awk '!/'"$anti_taxon_level"'__/ && /'"$taxon_level"'__/' $working_file > MET-$taxon_level-TEMP-FILE1.txt
  sed -n -e 's/.*'"$taxon_level"'__//p' MET-$taxon_level-TEMP-FILE1.txt > MET-$taxon_level-TEMP-FILE2.txt
  sort -k 1b,1 MET-$taxon_level-TEMP-FILE2.txt > $working_file-$taxon_level-only_sorted.txt
  rm MET-$taxon_level-TEMP-FILE1.txt && rm MET-$taxon_level-TEMP-FILE2.txt
  printf "\nProcessed Metaphlan output file '$working_file'\n"
  mail -s "Progress Monitoring 85763000" -a $working_file-$taxon_level-only_sorted.txt $user_input_mail <<< "\-\-\ METAPHLAN2 /-/-/ Here are processed Metaphlan2 output files:"$working_file-$taxon_level-only_sorted.txt""
}
cd $works_dir/Metaphlan2/
printf "\n Running metaphlan output handling function on the products of this script"
# export metaphlan_reports=$(find -maxdepth 1 -type f -name "*_Metaphlan2-output.txt")
export metaphlan_reports=$(find -maxdepth 1 -type f -name "*.txt") #BE CAUTIOUS WITH THIS - CONSIDER USING ABOVE MORE DISCERNING FIND
for f in $metaphlan_reports
do
  printf "\nWill run metaphlan_output_processing function on Metaphlan2 output file $f\n"
  metaphlan_output_processing $f s t
  metaphlan_output_processing $f g s
  metaphlan_output_processing $f f g
  metaphlan_output_processing $f o f
  metaphlan_output_processing $f c o
  metaphlan_output_processing $f p c
  printf "\nWill run metaphlan_output_processing function on Metaphlan2 output file $f\n"
done
export promet=$(find -maxdepth 1 -type f -name "*-only_sorted.txt")

printf "\n Getting the read counts for the original PE read files and the QC'ed versions.\n"
touch ${MDN}_original_read_counts.txt
touch ${MDN}_QCed_read_counts.txt
cd $HomeD
mkdir -p ${MDN}_DEPARTURES
cd ${MDN}_DEPARTURES
export DPL=$(pwd)
cd ..

printf "\n The read count for file $read_file_1 is: " >> ${MDN}_original_read_counts.txt && grep -c "@" $read_file_1 >> ${MDN}_original_read_counts.txt
printf "\n The read count for file $read_file_2 is: " >> ${MDN}_original_read_counts.txt && grep -c "@" $read_file_2 >> ${MDN}_original_read_counts.txt
scp ${MDN}_original_read_counts.txt ${MDN}_DEPARTURES
mv ${MDN}_original_read_counts.txt $works_dir
printf "\n The read count for file $RFQ1 is: " >> ${MDN}_QCed_read_counts.txt && grep -c "@" $RFQ1 >> ${MDN}_QCed_read_counts.txt
printf "\n The read count for file $RFQ2 is: " >> ${MDN}_QCed_read_counts.txt && grep -c "@" $RFQ2 >> ${MDN}_QCed_read_counts.txt
scp ${MDN}_QCed_read_counts.txt ${MDN}_DEPARTURES
mv ${MDN}_QCed_read_counts.txt $works_dir

printf "\nTarballing and emailing all results files to input address without the default filtering subject line you use.\n"

cd $works_dir/Centrifuge2/
for f in $centrifuge_reports
do
  printf "\n Copying $f to the departures lounge, $DPL"
  scp $f $DPL/
done
for f in $procent
do
  printf "\n Copying $f to the departures lounge, $DPL"
  scp $f $DPL/
done
scp PAIRS_NON_CONCORDANT_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}.{1..2}.out $DPL/
scp PAIRS_CONCORDANT_Min_once_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}_taxa_excluded_${ETX}.{1..2}.out $DPL/
scp PAIRS_NON_CONCORDANT_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}.{1..2}.out $DPL/
scp PAIRS_CONCORDANT_Min_once_ALIGNMENT_${MDN}_Centrifuge2_solo_scoring-min_hitlen_${MHL}.{1..2}.out $DPL/

cd $works_dir/Kraken2
for f in $kraken_reports
do
  printf "\n Copying $f to the departures lounge, $DPL"
  scp $f $DPL/
done
for f in $krakproc
do
  printf "\n Copying $f to the departures lounge, $DPL"
  scp $f $DPL/
done
# scp ${mdn}_Kraken2-classified_confidence_score${CS}_* $DPL
# scp ${mdn}_Kraken2-Unclassified_confidence_score${CS}_* $DPL
cd $works_dir/Metaphlan2/
for f in $metaphlan_reports
do
  printf "\n Copying $f to the departures lounge, $DPL"
  scp $f $DPL/
done
for f in $promet
do
  printf "\n Copying $f to the departures lounge, $DPL"
  scp $f $DPL/
done

cd $DPL/
rm *__2.txt-*
rm *__1.txt-*
rm *.1.out
rm *.2.out
rm *__2.txt.out
rm *__1.txt.out
find -maxdepth 1 -type f -empty -delete
cd ..
tar -czf ${MDN}_taxonomic_results_tables.tar.gz $HomeD/${MDN}_DEPARTURES/ && mail -s "$MDN taxonomy results - reports" -a ${MDN}_taxonomic_results_tables.tar.gz "$user_input_mail" <<< "Attached is a compressed directory which contains the taxonomic classification report files for analysis of PE read files $read_file_1 and $read_file_2 . Note that these files do not include the actual reads and the matches detected, those can be found in the other output files within the directories for each tool found in the overarching results directory at ${MDN}_processed"

printf "\n Tidying up after myself \n"
#rm ${MDN}_taxonomic_results_tables.tar.gz
mv $RFQ1 ${MDN}_processed
mv $RFQ2 ${MDN}_processed
mv HOLDINGBOWTIE2_${read_file_1}_and_${read_file_2}.txt ${MDN}_processed
#rm -r ${MDN}_DEPARTURES/

printf "\nSome details for the log.\n"
printf "\nThe first read file was: $read_file_1\n"
printf "\nThe second read file was: $read_file_1\n"
printf "\nThe email address provided was: $user_input_mail\n"
printf "\nThe name which will be given to the files and directory made from the reads is: $MDN\n"
printf "\nAll work will take place in the directory this script is in, the end result here should simply be a directory called: {$MDN}_processed\n"


printf "Not a bad job of it I think. All finished.\n"
