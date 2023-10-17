#!/bin/bash -e
#SBATCH -t 00-06:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J ExtractContigs
#SBATCH --mem=1gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
export INPF1=$1
export UIE=$2
export LABEL=$3
export FASTA_KEY=$4
export locale=$(pwd)

source package /tgac/software/testing/bin/seqtk-20150226

export TEMPNOM="${LABEL}_${INPF1}"
mkdir -p ${LABEL}_Extracted_Contigs
cd ${LABEL}_Extracted_Contigs
export WAREHOUSE=$(pwd)
mkdir Under_1kb_long
cd Under_1kb_long
export SMALL=$(pwd)
cd $WAREHOUSE
mkdir 1kb_to_50kb_long
cd 1kb_to_50kb_long
export MEDIUM=$(pwd)
cd $WAREHOUSE
mkdir Over_50kb_long
cd Over_50kb_long
export LARGE=$(pwd)
cd $locale

grep "$FASTA_KEY" $INPF1 | sort -V -k 4 > ${TEMPNOM}_all_contigs.txt
cat ${TEMPNOM}_all_contigs.txt | awk -F ' ' '{print $1}' | tr -d '>' > ${TEMPNOM}_contig_names.lst

extract_contigs () {
  inpf1=$1
  uie=$2
  label=$3
  lst_file=$4
  warehouse=$5
  small=$6
  medium=$7
  large=$7
  printf "\n Will go through assembled metagenome $inpf1 and get out all the contigs identified in file $lst_file \n"
  while IFS= read -r line ; do touch $warehouse/"$line"_contig_TRANSIENT.lst && printf "$line" > $warehouse/"$line"_contig_TRANSIENT.lst && export contname=$line ; done < $lst_file
  cd $warehouse
  #export transient_files=$(find -maxdepth 1 -type f -name "*_contig_TRANSIENT.lst")
  for f in *.lst
  do
    linename=$(cat "$f")
    printf "\n Will get the contig called $linename from the assembly and extract it into a fasta file called ${linename}_${label}_contig.fa \n"
    seqtk subseq $locale/$inpf1 $f > $warehouse/${linename}_${label}_contig.fa
    export outcome="$warehouse/${linename}_${label}_contig.fa"
    printf "\n Will now try and sort the fasta file into one of three directories depending on its length \n"
    export longiness=$(grep "len" "$outcome" | awk -F ' ' '{print $4}' | sed -r 's/len=+//g')
    if [[ "$longiness" -lt 1000 ]]
    then
      printf "\n The contig is less than 1,000 bases long so will be moved to $small"
      mv $outcome $small
    elif [[ "$longiness" -gt 50000 ]]
    then
      printf "\n The contig is more than (or exactly) 50,000 bases long so will be moved to $large \n"
      mv $outcome $large
    elif [[ "$longiness" -le 50000 ]]
    then
      printf "\n The contig is more than (or exactly) 1,000 but less than 50,000 bases long so will be moved to $medium \n"
      mv $outcome $medium
    else
      printf "\n Something odd here, either then contig has a length of 0 or the litle bit of awk and sed meant to get the length as a number on its own has failed \n"
    fi
    printf "\n Will now delete the .lst file used in this loop run, which was $f to avoid clogging the directory \n"
    rm $f
    printf "\n Got the contig called $linename from the assembly and extracted it into the fasta file called ${linename}_${label}_contig.fa \n"
  done
}

printf "\n Will now execute the function to remove and hopefully correctly label and pare out the contigs \n"
extract_contigs $INPF1 $UIE $LABEL $locale/${TEMPNOM}_contig_names.lst $WAREHOUSE $SMALL $MEDIUM $LARGE

mail -s "Progress Monitoring 85763000" $UIE <<< "Got the contigs from assembled metagenome $INPF1 and put them into individual fasta files."
