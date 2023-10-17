#!/bin/bash -e
#SBATCH -t 00-03:45
#SBATCH -p ei-medium
#SBATCH -c 4
#SBATCH -J MapMurBiobank
#SBATCH --mem=248gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export read_file1=$1
export read_file2=$2
#export UIE=$3
export UIE=peter.osborne@earlham.ac.uk
export locale=$(pwd)
export corename=$(basename $read_file1)
export metagenome_label=${corename:0:5}
mkdir -p ${metagenome_label}_RESULTS
source package /tgac/software/testing/bin/bbmap-38.06
export subj_files=$(find -maxdepth 1 -type f -name "*.fna")
bbmap_run () {
  printf "\n Will run bbmap \n"
  reference=$1 && printf "\n Provided reference genomes are: $reference \n"
  RFQ1=$2 && printf "\n First read file is: $RFQ1 \n"
  RFQ2=$3 && printf "\n Second read file is: $RFQ2 \n"
  lab=$5 && printf "\n Label which will be used with output is: $lab \n"
  letterbox=$6
  reference_label=$4 && printf "\n Reference label which will be used with output is: $reference_label \n"
  mkdir $locale/${lab}_RESULTS/${lab}_${reference_label}
  bbmap.sh ref="$reference" in=$RFQ1 in2=$RFQ2 k=15 slow=t threads=4 nodisk=t outm=$locale/${metagenome_label}_RESULTS/${lab}_${reference_label}/${lab}_matching_${reference_label}_reads statsfile=$locale/${metagenome_label}_RESULTS/${lab}_${reference_label}/${lab}__${reference_label}_stats.txt -Xmx246g -Xms232g
  printf "\n Ran BBMap on $RFQ1 and $RFQ2 using reference(s) $reference and labelling output $lab \n"
  mail -s "Progress Monitoring 85763000" $letterbox <<< "Ran BBMap on $RFQ1 and $RFQ2 using reference(s) $reference and labelling output $lab"
}
touch ${metagenome_label}_RESULTS/${metagenome_label}_combined_results.txt
touch ${metagenome_label}_RESULTS/${metagenome_label}_combined_matching_percentage_baseline.txt
for f in $subj_files
do
  TV1=$f
  TV2=$(basename $TV1)
  label=${TV2%.*}
  printf "\n Executing BBMap mapping function, mapping read files $read_file1 and $read_file2 to reference genome $f \n"
  bbmap_run $f $read_file1 $read_file2 $label $metagenome_label peter.osborne@earlham.ac.uk
  printf "\n Executed BBMap mapping function \n"
done
export results_files=$(find -maxdepth 3 -type f -name "*_stats.txt" -name "*$metagenome_label*")
for f in $results_files
do
  printf "\n Genome is: $f \n" >> ${metagenome_label}_RESULTS/${metagenome_label}_combined_results.txt
  cat $f >> ${metagenome_label}_RESULTS/${metagenome_label}_combined_results.txt
  printf "\n Genome is: $f \n" >> ${metagenome_label}_RESULTS/${metagenome_label}_combined_matching_percentage_baseline.txt
  grep "mated pairs" $f >> ${metagenome_label}_RESULTS/${metagenome_label}_combined_matching_percentage_baseline.txt
done
