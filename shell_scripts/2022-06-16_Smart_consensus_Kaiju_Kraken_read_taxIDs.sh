#!/bin/bash -e
#SBATCH -t 21-12:30
#SBATCH -p ei-long
#SBATCH -c 1
#SBATCH -J 2022-06-16_Smart_consensus_Kaiju_Kraken_read_taxIDs
#SBATCH --mem=64mb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-06-16_Smart_consensus_Kaiju_Kraken_read_taxIDs-%A.out
#SBATCH -e /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-06-16_Smart_consensus_Kaiju_Kraken_read_taxIDs-%A.err

#Script written on 2022-06-16
#Written by Peter Osborne

#This script will go through some Kraken and Kaiju classification results for some
#Polecat Kaiju and Kraken reads to try and create a conservative consensus.
#It uses lists of taxIDs identified by each, with Kraken taxIDs being considered
#the most reliable.

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
inpdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Taxonomic_classifier_output"
kraken_classified_reads="${inpdir}/2022-06-16_all_reads_classified_by_kraken_075_min_confidence_list_reads.txt"
kaiju_ouptut_file="${inpdir}/Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out"
kraken_classified_file="${inpdir}/Classified_Kraken2_Polecat_R0786-S0015_VWT837_A64353_R1.QCed.Cleansed.075_conf_score_1.txt"
kraken_unclassified_file="${inpdir}/Unclassified_Kraken2_Polecat_R0786-S0015_VWT837_A64353_R1.QCed.Cleansed.075_conf_score_1.txt"
taxids_kraken_detected="${inpdir}/2022-06-13_Kraken_detected_TaxIDs_list.txt"
taxids_kaiju_detected_kraken_not="${inpdir}/2022-06-13_Kaiju_taxIDs_NOT_detected_by_Kraken.txt"
