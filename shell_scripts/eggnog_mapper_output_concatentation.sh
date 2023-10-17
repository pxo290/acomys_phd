#!/bin/bash -e
cd $1
# export subject_file=$1
# export linecount=$(wc -l $subject_file)
export first_file=$(find . -maxdepth 1 -type f -name "*.part_001.fasta*")
# echo $first_file
export first_base=$(basename $first_file)
# echo $first_base
export sampleID=${first_base:0:4}
# echo $sampleID
export annotation_file_count=$(ls -1 *fasta-eggnog_mapper-output.emapper.annotations | wc -l)
# echo $annotation_file_count
export final_file=$(find . -maxdepth 1 -type f -name "*.part_$annotation_file_count.fasta*")
# echo $final_file
export final_base=$(basename $final_file)
# echo $final_base
export first_file=$(find . -maxdepth 1 -type f -name "*.part_001.fasta*")
# echo $first_file
export final_file=$(find . -maxdepth 1 -type f -name "*.part_$annotation_file_count.fasta*")
# echo $final_file
# export all_other_files=$(find . -maxdepth 1 -type f -not -name $first_base -not -name $final_base -name "*fasta-eggnog_mapper-output.emapper.annotations")
touch "$sampleID"_Eggnog_outputs.txt
first_linecount=$(wc -l $first_file) && echo $first_linecount
first_endpoint=$(("$first_linecount"-3)) && echo $first_endpoint
sed -n "4,$first_endpoint p" $first_file > "$sampleID"_Eggnog_outputs.txt
# for f in $all_other_files
# do
#   linecount=$(wc -l $f)
#   echo $linecount
#
