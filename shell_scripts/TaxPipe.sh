#!/bin/bash -e
#SBATCH -t 05-23:55
#SBATCH -p ei-largemem
#SBATCH -c 10
#SBATCH -J TaxPipe
#SBATCH --mem=750000
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#####SCRIPT#####
printf "\nStarting script\n"
export read_file_1=$1
export read_file_2=$2
export user_input_mail=$3
export home_directory=$(pwd)
export this_JOBID=$(sacct -n -X --format jobid --name TaxPipe)
# touch $this_JOBIDinformation.txt
# read_count () {
#   grep "@" $1
#   counted_reads=$(grep "@" $1)
#   printf "The read count for file $1 is: $counted_reads /n"
# }
# #export readsize=
# read_count $read_file_1 > ${this_JOBID}_information.txt
# read_count $read_file_2 >> ${this_JOBID}_information.txt
# export watching_eye=$(cat eye.txt)
# mail -s "Progress Monitoring 85763000" -a ${this_JOBID}_information.txt "$user_input_mail" <<< "$watching_eye \n The job $this_JOBID will process and taxonomically classify the files: $read_file_1 and $read_file_2 . It will merge them, run the merged file through QC, subsample it to a uniform read count of 4000000 reads and then pass it through Metaphlan2, Kraken2 and Centrifuge2."
printf "\nStarting script\n" > ${read_file_1}_starting_script.dat
##########SOURCING TOOLS##########
printf "\nSourcing tools\n"
printf "\nSourcing tools\n" > ${read_file_1}_sourcing_script.dat
source package /tgac/software/testing/bin/fastp-20190305 #This might be deprecated at some point, check the HPC catalogue
source package /tgac/software/testing/bin/bbmap-38.06
source package /tgac/software/testing/bin/metaphlan-2.0 #Metaphlan
source package /tgac/software/testing/bin/kraken2-2.0.7 #Kraken2
source package /tgac/software/testing/bin/centrifuge-1.0.3_dm #Centrifuge
##########SETTING UP##########
printf "\nMaking directories\n"
printf "\nMaking directories\n" > ${read_file_1}_setting_up_script.dat
mkdir -p $home_directory/${read_file_1}-fastp-outputs
mkdir -p $home_directory/${read_file_1}-bbmerge-outputs
mkdir -p $home_directory/${read_file_1}-metaphlan2-output
mkdir -p $home_directory/${read_file_1}-kraken2-output
mkdir -p $home_directory/${read_file_1}-centrifuge-output
mkdir -p $home_directory/${read_file_1}-EMPTY-diamond-output
mkdir -p $home_directory/${read_file_1}-job_log
##########MERGE BBTOOLS##########
printf "\nMerging PE read files $read_file_1 and $read_file_2\n"
printf "\nMerging PE read files $read_file_1 and $read_file_2\n" > ${read_file_1}_merging_script.dat
bbmerge.sh in1=$read_file_1 in2=$read_file_2 out=$home_directory/${read_file_1}-bbmerge-outputs/${read_file_1%}_BBmerged.fastq outu=$home_directory/${read_file_1}-bbmerge-outputs/${read_file_1%}_BBUnmerged.fastq
##########FASTP##########
printf "\nRunning FASTP on $home_directory/${read_file_1}-bbmerge-outputs/${read_file_1%}_BBmerged.fastq \n"
printf "\nRunning FASTP on $home_directory/${read_file_1}-bbmerge-outputs/${read_file_1%}_BBmerged.fastq \n" > ${read_file_1}_FASTP_script.dat
TEMPHOLDER1=$home_directory/${read_file_1}-bbmerge-outputs/${read_file_1%}_BBmerged.fastq
fastp -i $TEMPHOLDER1 -o ${TEMPHOLDER1}_Fastp_QC.fastq -h ${TEMPHOLDER1}_Fastp_QC.html -j ${TEMPHOLDER1}_Fastp_QC.json
cd $home_directory/${read_file_1}-bbmerge-outputs
mv *Fastp_QC* $home_directory/${read_file_1}-fastp-outputs
cd $home_directory/${read_file_1}-fastp-outputs
TEMPHOLDER1_5=$(find -type f -maxdepth 1 -name "*_Fastp_QC.fastq")
#read_count $home_directory/${read_file_1}-fastp-outputs/${TEMPHOLDER1_5}_Fastp_QC.fastq >> $home_directory/${this_JOBID}_information.txt
#mail -s "Progress Monitoring 85763000" -a ${this_JOBID}_information.txt -a $home_directory/${read_file_1}-fastp-outputs/${TEMPHOLDER1}_Fastp_QC.html "$user_input_mail" <<< "$watching_eye \n The job $this_JOBID details are attached, as is the html FastP result file for the merged read file from $read_file_1 and $read_file_2"
##########SUBSAMPLE BBTOOLS##########
printf "\nSubsampling $TEMPHOLDER1_5 to file with 7,000,000 reads\n"
printf "\nSubsampling $TEMPHOLDER1_5 to file with 7,000,000 reads\n" > ${read_file_1}_subsample_script.dat
reformat.sh in=$TEMPHOLDER1_5 out=$home_directory/${read_file_1}-bbmerge-outputs/${TEMPHOLDER1_5}_bbmerge_subsampled_4000000_reads.fastq reads=4000000 samplerate=1 int=t
cd $home_directory/${read_file_1}-bbmerge-outputs
export TEMPHOLDER2=$(find -maxdepth 1 -type f -name "*_bbmerge_subsampled_4000000_reads.fastq")
printf "\n The file which everything now will work on for taxonomic classification is:\n $TEMPHOLDER2 \n"
##########METAPHLAN2##########
printf "\nRunning Metaphlan2 on $TEMPHOLDER2 \n"
printf "\nRunning Metaphlan2 on $TEMPHOLDER2 \n" > ${read_file_1}_metaphlan2_script.dat
srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $TEMPHOLDER2 --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type fastq > $home_directory/${read_file_1}-metaphlan2-output/${TEMPHOLDER2}_Metaphlan2-output.txt
cd $home_directory/${read_file_1}-metaphlan2-output
metaphlan2_output=$(find -maxdepth 1 -type f -name "*_Metaphlan2-output.txt")
mail -s "Progress Monitoring 85763000" -a $metaphlan2_output "$user_input_mail" <<< "$watching_eye \n The job $this_JOBID has run Metaphlan2 on file $TEMPHOLDER2 and the results are attached"
##########KRAKEN2##########
cd $home_directory/${read_file_1}-bbmerge-outputs
printf "\nRunning Kraken2 on $TEMPHOLDER2 in three different ways\n"
printf "\nRunning Kraken2 on $TEMPHOLDER2 in three different ways\n" > ${read_file_1}_kraken2_script.dat
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 10 $TEMPHOLDER2 --confidence 0.75 --classified-out ${TEMPHOLDER2}_Kraken2-classified_confidence_score_075.out --report ${TEMPHOLDER2}_Kraken2-classified_confidence_score_075-report.out
mv ${TEMPHOLDER2}_Kraken2-classified_confidence_score_075-report.out $home_directory/${read_file_1}-kraken2-output/${TEMPHOLDER2}_Kraken2-classified_confidence_score_075-report.txt
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 10 $TEMPHOLDER2 --confidence 0.50 --classified-out ${TEMPHOLDER2}_Kraken2-classified_confidence_score_050.out --report ${TEMPHOLDER2}_Kraken2-classified_confidence_score_075-report.out
mv ${TEMPHOLDER2}_Kraken2-classified_confidence_score_075-report.out $home_directory/${read_file_1}-kraken2-output/${TEMPHOLDER2}_Kraken2-classified_confidence_score_050-report.txt
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 10 $TEMPHOLDER2 --classified-out ${TEMPHOLDER2}_Kraken2-no_added-classified_confidence_score.out --report ${TEMPHOLDER2}_Kraken2-no_added-classified_confidence_score-report.out
mv ${TEMPHOLDER2}_Kraken2-no_added-classified_confidence_score-report.out $home_directory/${read_file_1}-kraken2-output/${TEMPHOLDER2}_Kraken2-no_added-classified_confidence_score-report.txt
mail -s "Progress Monitoring 85763000" -a $home_directory/${read_file_1}-kraken2-output/${TEMPHOLDER2}_Kraken2-classified_confidence_score_075-report.txt -a $home_directory/${read_file_1}-kraken2-output/${TEMPHOLDER2}_Kraken2-classified_confidence_score_050-report.txt -a $home_directory/${read_file_1}-kraken2-output/${TEMPHOLDER2}_Kraken2-no_added-classified_confidence_score-report.txt "$user_input_mail" <<< "$watching_eye \n The job $this_JOBID has run Kraken2 on file $TEMPHOLDER2 and the result files are attached."
##########CENTRIFUGE2##########
cd $home_directory/${read_file_1}-bbmerge-outputs
printf "\nRunning Centrifuge2 on $TEMPHOLDER2 in 8 ways\n"
printf "\nRunning Centrifuge2 on $TEMPHOLDER2 in 8 ways\n" > ${read_file_1}_centrifuge2_script.dat
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --threads 10 --min-hitlen 29 --time --reorder -s ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-no_tax_exclusions.out -S ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-no_tax_exclusions-classified.out --report-file ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-no_tax_exclusions_report.tsv -U $TEMPHOLDER2
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids 33208,33090,554915 --threads 10 --min-hitlen 29 --time --reorder -s ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-taxa_excluded_Animalia_Plantae_Amoebozoa.out -S ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-taxa_excluded_Animalia_Plantae_Amoebozoa.out --report-file ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-taxa_excluded_Animalia_Plantae_Amoebozoa_report.tsv -U $TEMPHOLDER2
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --threads 10 --min-hitlen 15 --time --reorder -s ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-no_tax_exclusions.out -S ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-no_tax_exclusions-classified.out --report-file ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-no_tax_exclusions_report.tsv -U $TEMPHOLDER2
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids 33208,33090,554915 --threads 10 --min-hitlen 15 --time --reorder -s ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-taxa_excluded_Animalia_Plantae_Amoebozoa.out -S ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-taxa_excluded_Animalia_Plantae_Amoebozoa.out --report-file ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-taxa_excluded_Animalia_Plantae_Amoebozoa_report.tsv -U $TEMPHOLDER2
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --threads 10 --min-hitlen 50 --time --reorder -s ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-no_tax_exclusions.out -S ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-no_tax_exclusions-classified.out --report-file ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-no_tax_exclusions_report.tsv -U $TEMPHOLDER2
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids 33208,33090,554950 --threads 10 --min-hitlen 50 --time --reorder -s ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-taxa_excluded_Animalia_Plantae_Amoebozoa.out -S ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-taxa_excluded_Animalia_Plantae_Amoebozoa.out --report-file ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-taxa_excluded_Animalia_Plantae_Amoebozoa_report.tsv -U $TEMPHOLDER2
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --threads 10 --min-hitlen 75 --time --reorder -s ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-no_tax_exclusions.out -S ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-no_tax_exclusions-classified.out --report-file ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-no_tax_exclusions_report.tsv -U $TEMPHOLDER2
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids 33208,33090,554975 --threads 10 --min-hitlen 75 --time --reorder -s ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-taxa_excluded_Animalia_Plantae_Amoebozoa.out -S ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-taxa_excluded_Animalia_Plantae_Amoebozoa.out --report-file ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-taxa_excluded_Animalia_Plantae_Amoebozoa_report.tsv -U $TEMPHOLDER2
mv ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-no_tax_exclusions_report.tsv $home_directory/${read_file_1}-centrifuge-output/${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-no_tax_exclusions_report.txt
mv ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-taxa_excluded_Animalia_Plantae_Amoebozoa_report.tsv $home_directory/${read_file_1}-centrifuge-output/${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_29-taxa_excluded_Animalia_Plantae_Amoebozoa_report.txt
mv ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-no_tax_exclusions_report.tsv $home_directory/${read_file_1}-centrifuge-output/${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-no_tax_exclusions_report.txt
mv ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-taxa_excluded_Animalia_Plantae_Amoebozoa_report.tsv $home_directory/${read_file_1}-centrifuge-output/${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_15-taxa_excluded_Animalia_Plantae_Amoebozoa_report.txt
mv ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-no_tax_exclusions_report.tsv $home_directory/${read_file_1}-centrifuge-output/mv ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-no_tax_exclusions_report.txt
mv ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-taxa_excluded_Animalia_Plantae_Amoebozoa_report.tsv $home_directory/${read_file_1}-centrifuge-output/${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_50-taxa_excluded_Animalia_Plantae_Amoebozoa_report.txt
mv ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-no_tax_exclusions_report.tsv $home_directory/${read_file_1}-centrifuge-output/${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-no_tax_exclusions_report.txt
mv ${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-taxa_excluded_Animalia_Plantae_Amoebozoa_report.tsv $home_directory/${read_file_1}-centrifuge-output/${TEMPHOLDER2}_Centrifuge2_solo_scoring-min_hitlen_75-taxa_excluded_Animalia_Plantae_Amoebozoa_report.txt
####################CENTRIFUGE2 REPORT EMAILING LOOP####################
cd $home_directory/${read_file_1}-centrifuge-output/
for f in *.txt
do
  mail -s "Progress Monitoring 85763000" -a $f "$user_input_mail" <<< "$watching_eye \n The job $this_JOBID has run Centrifuge2 on file $TEMPHOLDER2 and the results files are attached."
done
##########OUTPUT PROCESSING##########
set +e
####################CENTRIFUGE2####################
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
for f in *.txt
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
####################KRAKEN2####################
cd $home_directory/${read_file_1}-kraken2-output/
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
for f in *-report.txt
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
####################METAPHLAN2####################
cd $home_directory/${read_file_1}-metaphlan2-output/
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
  printf "\nResults files arranged for joining of the two season samples were prepared from the Metaphlan output file '$working_file'\n"
  mail -s "Progress Monitoring 85763000" -A $working_file-$taxon_level-only_sorted.txt peter.osborne@earlham.ac.uk <<< "\-\-\ METAPHLAN2 /-/-/ Here are processed Metaphlan2 output files:"$working_file-$taxon_level-only_sorted.txt""
}
for f in *_Metaphlan2-output.txt
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
#####CLEANING UP#####
cd $home_directory/
mv *.dat $home_directory/${read_file_1}-job_log
mkdir -p $home_directory/${read_file_1}-outputs
mv $home_directory/${read_file_1}-fastp-outputs $home_directory/${read_file_1}-outputs
mv $home_directory/${read_file_1}-bbmerge-outputs $home_directory/${read_file_1}-outputs
mv $home_directory/${read_file_1}-metaphlan2-output $home_directory/${read_file_1}-outputs
mv $home_directory/${read_file_1}-kraken2-output $home_directory/${read_file_1}-outputs
mv $home_directory/${read_file_1}-centrifuge-output $home_directory/${read_file_1}-outputs
mv $home_directory/${read_file_1}-EMPTY-diamond-output $home_directory/${read_file_1}-outputs
mv $home_directory/${read_file_1}-job_log $home_directory/${read_file_1}-outputs
