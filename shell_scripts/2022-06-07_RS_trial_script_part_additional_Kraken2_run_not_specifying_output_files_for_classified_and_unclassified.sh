#!/bin/bash -eE
#SBATCH -t 01-10:30
#SBATCH -p ei-largemem
#SBATCH -c 4
#SBATCH -J 2022-06-07_RS_trial_script_part_additional_Kraken2_run_not_specifying_output_files_for_classified_and_unclassified
#SBATCH --mem=725gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Taxonomic_classifier_output/2022-06-07_RS_trial_script_part_additional_Kraken2_run_not_specifying_output_files_for_classified_and_unclassified-%A.out

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

inpdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/QC_and_cleansed_files"

workdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Taxonomic_classifier_output"

cd "$workdir"

krakendir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kraken2"
read1file="${inpdir}/Polecat_R0786-S0015_VWT837_A64353_R1.QCed.Cleansed.fastq"
read2file="${inpdir}/Polecat_R0786-S0015_VWT837_A64353_R2.QCed.Cleansed.fastq"
read1name=$(basename "$read1file" .fastq)
read2name=$(basename "$read2file" .fastq)
krakenoutdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Taxonomic_classifier_output"
samplename="Polecat_R0786-S0015_VWT837_A64353"
confidence_score="0.75"
confidence_score_without_period=$(echo "$confidence_score" | tr -d ".")
printf "\nWill now run Kraken2 on the paired-end fastq files:\t$read1file and $read2file\n"
printf "\nWill use this Kraken2 database directory:\t$krakendir\n"
printf "\nWill use $confidence_score as the confidence score threshold for Kraken2\n"
kraken2 --paired --db "$krakendir" --threads 4 --use-names --confidence "$confidence_score" "$read1file" "$read2file" --report "${krakenoutdir}/${samplename}_Kraken2-${confidence_score_without_period}_report.txt"
