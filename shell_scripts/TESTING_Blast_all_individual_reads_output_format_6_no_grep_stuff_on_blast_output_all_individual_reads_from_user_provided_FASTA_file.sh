#!/bin/bash -e
#SBATCH -t 01-08:45
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J Indy6Blast
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script will take a user provided FASTA file and will go through it to get
#the IDs of all the reads in it. Then it will get the sequences for each of the
#reads and put it into a temporary .fa file named after the read ID. It will
#then run this file through BLAST before recording the results of that read in
#a file which will contain the results of all the reads being blasted from the
#original FASTA file.

#PRESUPPOSED INPUT is the .fasta output from Raymond Kiu's BactSpeciesID
#PRESUPPOSED INPUT is named 'NUMBERS-SampleID-OTHER STUFF'

printf "\nI am running this script:TESTING_Blast_all_individual_reads_output_format_6_no_grep_stuff_on_blast_output_all_individual_reads_from_user_provided_FASTA_file.sh\n"

export BLASTDB=$PATH:/ei/public/databases/blast/ncbi/nt_20200707
source package 37f0ffda-9f66-4391-87e2-38ccd398861d #blast+ - 2.10.0+-4
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tBLASTn job.\nI am running at:\t$tick\nI will work on the input file:\t$INPF1\nI am running in the directory:\t$wobist\nI request the resources:\t00-03:30 on EI-medium\t1 core\t128GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a: BLASTn job. I am running at: "$tick" I will work on the input file $inpf1. I am running in the directory: $wobist. I request the resources: 00-03:30 on EI-medium 1 core 128GB"
}
printf "\nStarting script\n"
export INPF1=$1
export label=$(basename $INPF1 | awk -F "-" '{print $2}')
export LOCALE=$(pwd)
mkdir ${label}_results_BLAST_output_formats_6_and_0
cd ${label}_results_BLAST_output_formats_6_and_0
export working_dir=$(pwd)
cd $LOCALE
cp $INPF1 $working_dir
chmod 777 -R $working_dir
cd $working_dir
export inpf1=$(find -maxdepth 1 -type f -name "*.fna")
printf "\nThe file which will actually be worked on is:$inpf1\n"
grep "k" $inpf1 >> ${label}_ID_list.txt
sleep 5s
while IFS= read -r line ; do ident=$(grep "$line" $inpf1 | sed 's/>//g' | sed 's/:/--/g') && sequence=$(grep -a1 "$line" $inpf1 | tail -1) && printf "$line\n$sequence" >> $ident.fasta ; done < ${label}_ID_list.txt
blast_db_dir="/ei/public/databases/blast/ncbi/nt_20200707"
touch ${label}_identified_species.txt
touch ${label}_identified_accessions.txt
captains_log
where_blast_looks=$(blastdbcmd -show_blastdb_search_path)
fasta_files=$(find -maxdepth 1 -type f -name "*.fasta")
#cd $blast_db_dir
where_blast_looks=$(blastdbcmd -show_blastdb_search_path)
printf "\nBlast will look for databases here:\t$where_blast_looks\n"
for f in $fasta_files
do
  path_to_file=$(readlink -f $f)
  nom=$(basename $f | sed 's/.fasta//g')
  #blastn -db nt -query "$path_to_file" -evalue 0.001 -task blastn -outfmt 18 -max_target_seqs 1 -out $working_dir/${nom}_format_18_RESULTS.txt || printf "\nI failed trying to run line 61 of the script\n"
  blastn -db nt -query "$path_to_file" -evalue 0.001 -task blastn -outfmt 6 -max_target_seqs 1 -out $working_dir/${nom}_format_6_RESULTS.txt || printf "\nI failed trying to run line 62 of the script\n"
  blastn -db nt -query "$path_to_file" -evalue 0.001 -task blastn -outfmt 0 -max_target_seqs 1 -out $working_dir/${nom}_format_0_RESULTS.txt || printf "\nI failed trying to run line 63 of the script\n"
  ACCESSION=$(cat $working_dir/${nom}_format_6_RESULTS.txt | awk -F "\t" '{print $2}')
  SPECIES_AND_ACCESSION=$(grep ">" $working_dir/${nom}_format_0_RESULTS.txt | cut -c 13-)
  printf "\n$ACCESSION" >> $working_dir/${label}_identified_accessions.txt
  printf "\n$SPECIES_AND_ACCESSION" >> $working_dir/${label}_identified_species.txt
  #rm $working_dir/${nom}_format_18_RESULTS.txt
  #rm $working_dir/${nom}_format_6_RESULTS.txt
  #rm $working_dir/${nom}_format_0_RESULTS.txt
  rm $f
done
printf "\nWork has ended on input file:\t$INPF1\n"
