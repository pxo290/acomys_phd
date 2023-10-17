#!/bin/bash -e
#SBATCH -t 01-20:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J MetaProb
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
export INPF1=$1
export INPF2=$2
export UIE=$3
export LABEL=$4
export SPECIES_COUNT=$5
export LOCALE=$(pwd)
printf "\n First PE input fastq file is: $INPF1 \n"
printf "\n Second PE input fastq file is: $INPF2 \n"
printf "\n User input email address is: $UIE \n"
printf "\n The label used to make the output directory and label the output files is: $LABEL \n"
printf "\n The number of bins which will be made is: $SPECIES_COUNT \n"
printf "\n The directory which this script is launched from and which contains the input files is: $LOCALE \n"

mkdir -p $LOCALE/$LABEL
cd $LOCALE/$LABEL
BERTH=$(pwd)
cd $LOCALE

source package 78cb9518-255c-4d1c-9fb1-99a61123483c
source package /tgac/software/testing/bin/seqtk-20150226

run_metaprob () {
  inpf1=$1
  inpf2=$2
  label=$3
  uie=$4
  berth=$5
  bin_count=$6
  printf "\n Will be running Metaprob on input PE fastq files $inpf1 and $inpf2 with the output sent to output directory $berth \n"
  printf "\n Graph type is 0 and max cluster (bin) number is: $bin_count \n"
  pathinpf1=$(readlink -f $inpf1)
  pathinpf2=$(readlink -f $inpf2)
  MetaProb -pi $pathinpf1 $pathinpf2 -dirOutput $berth -graphType 0 -numSp "$bin_count"
  printf "\n Ran Metaprob on input PE fastq files $inpf1 and $inpf2 with the output being sent to output directory $berth \n"
  outputted=$(find -maxdepth 1 -type f -name "*$label*")
  for f in $outputted
  do
    printf "\n Moving file $f to directory $berth \n"
    mv $f $berth
  done
  mail -s "Progress Monitoring 85763000" $uie <<< "Ran Metaprob on input PE fastq files $inpf1 and $inpf2 with the output being sent to output directory $berth"
}

extract_reads () {
  subject=$1
  input_file1=$2
  input_file2=$3
  uie=$4
  wo_bist=$(pwd)
  read_file1=$(readlink -f $input_file1)
  read_file2=$(readlink -f $input_file2)
  clusters_file=$(find -maxdepth 1 -type f -name "*_1.fastq.clusters.csv" -name "*$LABEL*")
  clusters_file_2=$(find -maxdepth 1 -type f -name "*_2.fastq.clusters.csv" -name "*$LABEL*")
  grep "," $subject | tr -d 'abcdefghijklmnopqrstuvwxyzC  (__):' | sed '1d' | awk -F ',' '{print $1}' > ${LABEL}_bins_numbers.txt
  mv ${LABEL}_bins_numbers.txt ${LABEL}_bins_numbers_R1.txt
  scp ${LABEL}_bins_numbers_R1.txt ${LABEL}_bins_numbers_R2.txt
  sed -i -e 's#^#1,#' ${LABEL}_bins_numbers_R1.txt
  sed -i -e 's#^#2,#' ${LABEL}_bins_numbers_R2.txt
  while IFS= read -r line ; do touch "$line"_R1.lst && grep -w "$line" $clusters_file >> "$line"_R1.lst ; done < ${LABEL}_bins_numbers_R1.txt
  while IFS= read -r line ; do touch "$line"_R2.lst && grep -w "$line" $clusters_file_2 >> "$line"_R2.lst ; done < ${LABEL}_bins_numbers_R2.txt
  for f in *,*.lst ; do mv -- "$f" "${f//*,/}" ; done
  for f in *_*.lst ; do sed -i -e 's/@//' $f ; done
  for f in *_R1.lst ; do awk -F '/' '{print $1}' $f > ${f%}_correct_read_names-R1.lst ; done
  for f in *_R2.lst ; do awk -F '/' '{print $1}' $f > ${f%}_correct_read_names-R2.lst ; done
  for f in *_correct_read_names-R1.lst ; do sed -i -e 's#$#/1#' $f ; done
  for f in *_correct_read_names-R2.lst ; do sed -i -e 's#$#/2#' $f ; done
  waste=$(find -maxdepth 1 -type f -name "*.lst" -not -name "*correct_read_names*")
  for f in $waste ; do printf "\n Deleting intermediate file $f \n" && rm $f ; done
  for f in *_correct_read_names-R1.lst ; do seqtk subseq $read_file1 $f > $BERTH/${f%}_${LABEL}_reads_for_bin_R1.fastq ; done
  for f in *_correct_read_names-R2.lst ; do seqtk subseq $read_file2 $f > $BERTH/${f%}_${LABEL}_reads_for_bin_R2.fastq ; done
  mail -s "Progress Monitoring 85763000" $uie <<< "Extracted the reads for each group/bin made by MetaProb from sequences in "$read_file1" and "$read_file2" the outputs from which can be found in "$wo_bist""
  rubbish=$(find -maxdepth 1 -type f -name "*.lst")
  for f in $rubbish ; do printf "\n Deleting the final list file $f which contained reads from the input file in the relevant bin \n" && rm $f ; done
}

run_metaprob $INPF1 $INPF2 "$LABEL" $UIE $BERTH "$SPECIES_COUNT"

cd "$BERTH"
info_file=$(find -maxdepth 1 -type f -name "*.info") && printf "\n Info file is: $info_file \n"
extract_reads $info_file $INPF1 $INPF2 $UIE



##Prior failures below for record keeping

# process_metaprob_output () {
#   subject=$1
#   clusters_file=$(find -maxdepth 1 -type f -name "*_1.fastq.clusters.csv" -name "*$LABEL*")
#   grep "," $subject | tr -d 'abcdefghijklmnopqrstuvwxyzC  (__):' | sed '1d' | awk -F ',' '{print $1}' > ${LABEL}_bins_numbers.txt
#   sed -i -e 's#^#,#' ${LABEL}_bins_numbers.txt
#   while IFS= read -r line ; do touch ${line}_bin_reads_1.txt && grep "/1,$line" $clusters_file >> ${line}_bin_reads_1.txt ; done < $subject
#   clusters_file_2=$(find -maxdepth 1 -type f -name "*_2.fastq.clusters.csv" -name "*$LABEL*")
#   while IFS= read -r line ; do touch ${line}_bin_reads_2.txt && grep "/2,$line" $clusters_file >> ${line}_bin_reads_2.txt ; done < $subject
#   for f in *,* ; do mv -- "$f" "${f//,/}" ; done
#   for f in *_bin_reads*.txt ; do sed -i -e 's/..$//' $f && mv $f ${f%}.lst ; done
#   export PE1_reads=$(find -maxdepth 1 -type f -name "*.lst" -name "*_bin_reads_1*")
#   export PE2_reads=$(find -maxdepth 1 -type f -name "*.lst" -name "*_bin_reads_2*")
# }

#seqtk_run () {
  # subject=$1
  # clusters_file=$(find -maxdepth 1 -type f -name "*_1.fastq.clusters.csv" -name "*$LABEL*")
  # clusters_file_2=$(find -maxdepth 1 -type f -name "*_2.fastq.clusters.csv" -name "*$LABEL*")
  # grep "," $subject | tr -d 'abcdefghijklmnopqrstuvwxyzC  (__):' | sed '1d' | awk -F ',' '{print $1}' > ${LABEL}_bins_numbers.txt
  # mv ${LABEL}_bins_numbers.txt ${LABEL}_bins_numbers_R1.txt
  # scp ${LABEL}_bins_numbers_R1.txt ${LABEL}_bins_numbers_R2.txt
  # sed -i -e 's#^#1,#' ${LABEL}_bins_numbers_R1.txt
  # sed -i -e 's#^#2,#' ${LABEL}_bins_numbers_R2.txt
  # touch ${LABEL}_bin_reads_1.txt
  # touch ${LABEL}_bin_reads_2.txt
  # while IFS= read -r line ; do grep "$line" $clusters_file >> ${LABEL}_bin_reads_1.txt ; done < ${LABEL}_bins_numbers_R1.txt
  # while IFS= read -r line ; do grep "$line" $clusters_file_2 >> ${LABEL}_bin_reads_2.txt ; done < ${LABEL}_bins_numbers_R2.txt
  # for f in *_R*.txt ; do sed -i -e 's/..$//' $f && mv $f ${f%}.lst ; done
#}
