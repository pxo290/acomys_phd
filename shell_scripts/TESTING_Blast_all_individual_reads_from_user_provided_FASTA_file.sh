#!/bin/bash -e
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J IndyBlast
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
mkdir ${label}_results
cd ${label}_results
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
  blastn -db nt -query "$path_to_file" -evalue 0.001 -task blastn -outfmt 18 -max_target_seqs 1 -sorthits 3 -out $working_dir/${nom}_RESULTS.txt
  #ACCESSION=$(grep -a2 "Accession:" $working_dir/${nom}_RESULTS.txt | tail -1 | awk -F "  " '{print $1}')
  ACCESSION=$(grep -a2 "Accession:" $working_dir/${nom}_RESULTS.txt)
  printf "\n$ACCESSION" >> $working_dir/${label}_identified_species.txt
  rm $working_dir/${nom}_RESULTS.txt
  rm $f
done
printf "\nWork has ended\n"
