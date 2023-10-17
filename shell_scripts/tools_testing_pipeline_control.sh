#!/bin/bash -e
#SBATCH -t 07-23:55
#SBATCH -p ei-largemem
#SBATCH -c 10
#SBATCH -J PipeControl
#SBATCH --mem=750000
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######SCRIPT######
printf "\nNote that the directories produced are all named from the first input file - both input files are utilised\n"
export input_file1=$1
export input_file2=$2
export user_input_mail=$3
printf "\nAny correspondence from the script to user will be sent to: $user_input_mail"
export filetype=${input_file1##*.}
export input_directory=$(readlink -f $input_file1)
cd $input_directory
export name_input_file1=$(basename $input_file1)
export name_input_file2=$(basename $input_file2)
mkdir $name_input_file1-work_files
mkdir $name_input_file1-outputs
cd $name_input_file1-outputs
export output_directory=$(pwd)
cd ..
mkdir $name_input_file1-disposal
cd $name_input_file1-disposal
export disposal_directory=$(pwd)
cd ..
cp $input_file1 $name_input_file1-work_files/
cd $input_directory/work_files
export working_file_1=$(find . -maxdepth 1 -type f -name "*$filetype")
export work_directory=$(pwd)
cd $input_directory
cp $input_file2 $work_directory/
cd $work_directory
export working_file_2=$(find . -maxdepth 1 -type f -name "*$filetype" -name -not "$working_file_1")
####### EARLHAM INSTITUTE SPECIFIC COMMANDS FOR SOURCING SOFTWARE PACKAGES #######
source package /tgac/software/testing/bin/fastp-20190305 #This might be deprecated at some point, check the HPC catalogue
source package cab8386a-c777-4936-8411-a6ed2b5e6a20 #BBMAP 38.79
##################################################################################
bbmerge in1=$working_file_1 in2=$working_file_2 out="$name_input_file1"_BBmerged."$filetype" outu="$name_input_file1"_BBUnmerged."$filetype"
export merged_file=$(find . -maxdepth 1 -type f -name "*_BBmerged.*")
fastp -i $merged_file -o ${merged_file%}_FASTP_QC."$filetype" -h $output_directory/${merged_file%}_FASTP_QC.html -j $output_directory/${merged_file%}_FASTP_QC.json
mv $working_file_1 $disposal_directory
mv $working_file_2 $disposal_directory
export stage_2_working_file=$(find . -maxdepth 1 -type f -name "*_FASTP_QC.*")
####### EARLHAM INSTITUTE SPECIFIC COMMANDS FOR SOURCING SOFTWARE PACKAGES #######
source package 96e25c2d-469f-4e46-beed-f2d4c7dae269 #KRAKEN 1.1
source package dd43df1f-7eb2-4011-88fc-c457e801ddd0 #DIAMOND 0.9.29
source package /tgac/software/testing/bin/metaphlan-2f1b17a1f4e9metaphlan2-2.96.1
##################################################################################
metaphlan2_run () {
  input_file=$1
  printf "Will run Metaphlan2 on file: $input_file"
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $input_file --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type $fileEXT > $output_directory/${input_file%}-metaphlan-output.txt
  printf "Ran Metaphlan2 on file: $input_file"
  mail -s "Progress Monitoring 85763000" $user_input_mail <<< "\-\-\ METAPHLAN2 /-/-/ A file was processed through Metaphlan2:"$input_file""
}
metaphlan_output_processing () {
  printf "\nThis function will process Metaphlan2 outputs, creating files ready for joining or other analysis.\n"
  export working_file=$1
  export taxon_level=$2
  export anti_taxon_level=$3
  export metaphlan_identifier=${working_file:0:7}
  awk '!/'"$anti_taxon_level"'__/ && /'"$taxon_level"'__/' $working_file > MET-$taxon_level-TEMP-FILE1.txt
  sed -n -e 's/.*'"$taxon_level"'__//p' MET-$taxon_level-TEMP-FILE1.txt > MET-$taxon_level-TEMP-FILE2.txt
  sort -k 1b,1 MET-$taxon_level-TEMP-FILE2.txt > $output_directory/$working_file-$taxon_level-only_sorted.txt
  mv MET-$taxon_level-TEMP-FILE1.txt $disposal_directory/ && mv MET-$taxon_level-TEMP-FILE2.txt $disposal_directory/
  mail -s "Progress Monitoring 85763000" $user_input_mail -A $output_directory/$working_file-$taxon_level-only_sorted.txt <<< "\-\-\ OUTPUT PROCESSING /-/-/ The processed results for "$working_file" Metaphlan2 analysis at taxonomic level "$taxon_level" are attached."
  printf "\nResults files arranged for joining of the two season samples were prepared from the Metaphlan output file '$working_file'\n"
}
kraken2_run () {
  printf "Will run Kraken2 on file: $1"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 10 $1 --confidence 0.75 --classified-out $output_directory/$1-kraken-classified.out --report $output_directory/$1-kraken-report.out > $output_directory/$1-kraken_report.txt
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ KRAKEN2 /-/-/ A file was processed through Kraken2, the file being "$1""
}
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
  sed 's@nclassified@'Unclassified'@' KRAKEN-$file_name-$2-TEMP_FILE7.txt > $output_directory/$file_name-$2-and_unclassified_sorted.txt
  mv KRAKEN-$file_name-$2-TEMP_FILE* $disposal_directory/
  printf "\nThis worked on the Kraken report output file:\n"$working_file"\n"
  mail -s "Progress Monitoring 85763000" $user_input_mail -A $output_directory/$file_name-$2-and_unclassified_sorted.txt <<< "\-\-\ OUTPUT PROCESSING /-/-/ The processed results for "$working_file" Kraken2 analysis at taxonomic level "$taxon_level" are attached."

}
centrifuge2_run-FASTQ () {
  printf "\nThe following file will be run through Centrifuge2:\n$1"
  centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids 33208,33090,554915 --threads 10 --min-hitlen 29 --time --reorder -s $output_directory/$1-centrifuge_solo_scoring.out -S $output_directory/$1-centrifuge_solo_scoring-classified.out --report-file $output_directory/$1-centrifuge_solo_scoring_report.tsv -U $1
  mv $output_directory/$1-centrifuge_solo_scoring_report.tsv $output_directory/$1-centrifuge_solo_scoring_report.txt
  printf "\nThe following file ran through Centrifuge2:\n$1"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ CENTRIFUGE2 /-/-/ A file was processed through Centrifuge2, the file being "$1""
}
centrifuge2_run-FASTA () {
  printf "\nThe following file will be run through Centrifuge2:\n$1"
  centrifuge -f -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids 33208,33090,554915 --threads 10 --min-hitlen 29 --time --reorder -s $output_directory/$1-centrifuge_solo_scoring.out -S $output_directory/$1-centrifuge_solo_scoring-classified.out --report-file $output_directory/$1-centrifuge_solo_scoring_report.tsv -U $1
  mv $output_directory/$1-centrifuge_solo_scoring_report.tsv $output_directory/$1-centrifuge_solo_scoring_report.txt
  printf "\nThe following file ran through Centrifuge2:\n$1"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ CENTRIFUGE2 /-/-/ A file was processed through Centrifuge2, the file being "$1""
}
centrifuge_output_processing () {
  printf "\nThis function will process Centrifuge2 outputs, creating files ready for joining or other analysis.\n"
  working_file=$1
  taxon_level=$2
  file_name="$(basename -- $working_file)"
  awk '/'"$2"'/' $working_file > $file_name-CENTRIFUGE-TEMP-$2.txt
  sed -i -e '1,1d' $file_name-CENTRIFUGE-TEMP-$2.txt
  cut -f 1,6 $file_name-CENTRIFUGE-TEMP-$2.txt > V2-$file_name-CENTRIFUGE-TEMP-$2.txt
  sort -k 1b,1 V2-$file_name-CENTRIFUGE-TEMP-$2.txt > $output_directory/$working_file-$2-only_CENTRIFUGE_sorted.txt
  sed -i -e 's/ /_/g' $output_directory/$working_file-$2-only_CENTRIFUGE_sorted.txt
  mv $file_name-CENTRIFUGE-TEMP-$2.txt $disposal_directory/ && mv V2-$file_name-CENTRIFUGE-TEMP-$2.txt $disposal_directory/
  set +e
  mv *-CENTRIFUGE-TEMP-* $disposal_directory/
  set -e
  printf "\nYou worked on the Centrifuge report output file:\n"$working_file"\n\n"
  mail -s "Progress Monitoring 85763000" $user_input_mail -A $output_directory/$file_name-$2-and_unclassified_sorted.txt <<< "\-\-\ OUTPUT PROCESSING /-/-/ The processed results for "$working_file" Centrifuge2 analysis at taxonomic level "$taxon_level" are attached."
}
#diamond_run_and_output_process () {

}
case $stage_2_working_file in
  (*.fastq) printf "The input file was a fastq file"
  export fileEXT="fastq"
  metaphlan2_run $stage_2_working_file
  kraken2_run $stage_2_working_file
  centrifuge2_run-FASTQ $stage_2_working_file
  cd $output_directory
  metaphlan_to_process=$(find . -maxdepth 1 -type f -name "*-metaphlan-output.txt")
  metaphlan_output_processing $metaphlan_to_process s t
  metaphlan_output_processing $metaphlan_to_process g s
  metaphlan_output_processing $metaphlan_to_process f g
  metaphlan_output_processing $metaphlan_to_process o f
  metaphlan_output_processing $metaphlan_to_process c o
  metaphlan_output_processing $metaphlan_to_process p c
  kraken_to_process=$(find . -maxdepth 1 -type f -name "*-kraken_report.txt")
  kraken_output_processing $kraken_to_process S
  kraken_output_processing $kraken_to_process G
  kraken_output_processing $kraken_to_process F
  kraken_output_processing $kraken_to_process O
  kraken_output_processing $kraken_to_process C
  kraken_output_processing $kraken_to_process P
  centrifuge_to_process=$(find . -maxdepth 1 -type f -name "-*centrifuge_solo_scoring_report.txt")
  centrifuge_output_handling $centrifuge_to_process species
  centrifuge_output_handling $centrifuge_to_process genus
  centrifuge_output_handling $centrifuge_to_process family
  centrifuge_output_handling $centrifuge_to_process order
  centrifuge_output_handling $centrifuge_to_process class
  centrifuge_output_handling $centrifuge_to_process phylum
  ;;
  (*.fq) printf "The input file was a fastq file"
  export fileEXT="fastq"
  metaphlan2_run $stage_2_working_file
  kraken2_run $stage_2_working_file
  centrifuge2_run-FASTQ $stage_2_working_file
  cd $output_directory
  metaphlan_to_process=$(find . -maxdepth 1 -type f -name "*-metaphlan-output.txt")
  metaphlan_output_processing $metaphlan_to_process s t
  metaphlan_output_processing $metaphlan_to_process g s
  metaphlan_output_processing $metaphlan_to_process f g
  metaphlan_output_processing $metaphlan_to_process o f
  metaphlan_output_processing $metaphlan_to_process c o
  metaphlan_output_processing $metaphlan_to_process p c
  kraken_to_process=$(find . -maxdepth 1 -type f -name "*-kraken_report.txt")
  kraken_output_processing $kraken_to_process S
  kraken_output_processing $kraken_to_process G
  kraken_output_processing $kraken_to_process F
  kraken_output_processing $kraken_to_process O
  kraken_output_processing $kraken_to_process C
  kraken_output_processing $kraken_to_process P
  centrifuge_to_process=$(find . -maxdepth 1 -type f -name "-*centrifuge_solo_scoring_report.txt")
  centrifuge_output_handling $centrifuge_to_process species
  centrifuge_output_handling $centrifuge_to_process genus
  centrifuge_output_handling $centrifuge_to_process family
  centrifuge_output_handling $centrifuge_to_process order
  centrifuge_output_handling $centrifuge_to_process class
  centrifuge_output_handling $centrifuge_to_process phylum
  ;;
  (*.fasta) printf "The input file was a fasta file"
  export fileEXT="fasta"
  metaphlan2_run $stage_2_working_file
  kraken2_run $stage_2_working_file
  centrifuge2_run-FASTA $stage_2_working_file
  cd $output_directory
  metaphlan_to_process=$(find . -maxdepth 1 -type f -name "*-metaphlan-output.txt")
  metaphlan_output_processing $metaphlan_to_process s t
  metaphlan_output_processing $metaphlan_to_process g s
  metaphlan_output_processing $metaphlan_to_process f g
  metaphlan_output_processing $metaphlan_to_process o f
  metaphlan_output_processing $metaphlan_to_process c o
  metaphlan_output_processing $metaphlan_to_process p c
  kraken_to_process=$(find . -maxdepth 1 -type f -name "*-kraken_report.txt")
  kraken_output_processing $kraken_to_process S
  kraken_output_processing $kraken_to_process G
  kraken_output_processing $kraken_to_process F
  kraken_output_processing $kraken_to_process O
  kraken_output_processing $kraken_to_process C
  kraken_output_processing $kraken_to_process P
  centrifuge_to_process=$(find . -maxdepth 1 -type f -name "-*centrifuge_solo_scoring_report.txt")
  centrifuge_output_handling $centrifuge_to_process species
  centrifuge_output_handling $centrifuge_to_process genus
  centrifuge_output_handling $centrifuge_to_process family
  centrifuge_output_handling $centrifuge_to_process order
  centrifuge_output_handling $centrifuge_to_process class
  centrifuge_output_handling $centrifuge_to_process phylum
  ;;
  ;;
  (*.fa) printf "The input file was a fasta file"
  export fileEXT="fasta"
  metaphlan2_run $stage_2_working_file
  kraken2_run $stage_2_working_file
  centrifuge2_run-FASTA $stage_2_working_file
  cd $output_directory
  metaphlan_to_process=$(find . -maxdepth 1 -type f -name "*-metaphlan-output.txt")
  metaphlan_output_processing $metaphlan_to_process s t
  metaphlan_output_processing $metaphlan_to_process g s
  metaphlan_output_processing $metaphlan_to_process f g
  metaphlan_output_processing $metaphlan_to_process o f
  metaphlan_output_processing $metaphlan_to_process c o
  metaphlan_output_processing $metaphlan_to_process p c
  kraken_to_process=$(find . -maxdepth 1 -type f -name "*-kraken_report.txt")
  kraken_output_processing $kraken_to_process S
  kraken_output_processing $kraken_to_process G
  kraken_output_processing $kraken_to_process F
  kraken_output_processing $kraken_to_process O
  kraken_output_processing $kraken_to_process C
  kraken_output_processing $kraken_to_process P
  centrifuge_to_process=$(find . -maxdepth 1 -type f -name "-*centrifuge_solo_scoring_report.txt")
  centrifuge_output_handling $centrifuge_to_process species
  centrifuge_output_handling $centrifuge_to_process genus
  centrifuge_output_handling $centrifuge_to_process family
  centrifuge_output_handling $centrifuge_to_process order
  centrifuge_output_handling $centrifuge_to_process class
  centrifuge_output_handling $centrifuge_to_process phylum
  ;;
  ;;
esac
######NOTES######
#04/06/20
#Hopefully this script will take two PE read files, either fasta or fastq and
#automatically join them, QC them and then run them through a number of
#taxonomic classification tools - as well as process the output files so they
#can be more easily analysed and put into visualisers.
