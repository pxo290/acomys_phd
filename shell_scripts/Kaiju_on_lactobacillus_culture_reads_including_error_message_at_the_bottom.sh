#!/bin/bash -e
#SBATCH -t 01-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Lac_Kaiju_reads
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

targets=$(find -maxdepth 1 -type f -name "*R1_001.fastq")
for f in $targets
do
  destination="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Kaiju_on_reads_output"
  inpf1=$(basename $f) && printf "\n$inpf1 is inpf1\n"
  inpf2=$(echo $inpf1 | sed 's/_R1_/_R2_/g') && printf "\n$inpf2 is inpf2\n"
  label=$(echo $inpf1 | awk -F "_R1" '{print $1}' | awk -F "-" '{print $4}') && printf "\n$label is label\n"
  origin=$(pwd) && printf "\n$origin is origin\n"
  cd $destination
  mkdir "${label}_Kaiju_output"
  cd "${label}_Kaiju_output"
  output_dir=$(pwd) && printf "\n$output_dir is output_dir\n"
  cd $origin
  refnodes="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
  refdbfile="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
  refdbnames="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
  refdbfile="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"
  kaiju -t $refnodes -f $refdbfile -v -a greedy -i $inpf1 -j $inpf2 -o "${output_dir}_${label}_Kaiju_output.out" || printf "\nFailed on line:\t27\n"
  cd $output_dir
  kaiju2table -t "$refnodes" -n "$refnames" -r species -v -p -o "${label}_Kaiju_output_SPECIES.out" "${label}_Kaiju_output.out" || printf "\nFailed on line:\t29\n"
  kaiju-addTaxonNames -t "$refnodes" -n "$refnames" -i "${label}_kaiju_output.out" -u -r kingdom,phylum,class,order,family,genus,species -o "${label}_kaiju_output.names_added.out" || printf "\nFailed on line:\t30\n"
  cd $origin
done

# PID-0578-r-41C_S8_R1_001.fastq is inpf1
#
# PID-0578-r-41C_S8_R2_001.fastq is inpf2
#
# 41C_S8 is label
#
# /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads is origin
#
# /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Kaiju_on_reads_output/41C_S8_Kaiju_output is output_dir
# 21:38:40 Reading database
#  Reading taxonomic tree from file /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp
#  Reading index from file /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi
# Output file: /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Kaiju_on_reads_output/41C_S8_Kaiju_output_41C_S8_Kaiju_output.out
# 21:40:32 Start classification using 1 threads.
# 21:44:49 Finished.
# Error: Please specify the rank (phylum, class, order, family, genus, or species) with the -r option.
#
# Kaiju 1.7.3
# Copyright 2015-2020 Peter Menzel, Anders Krogh
# License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
#
# Usage:
#    kaiju2table -t nodes.dmp -n names.dmp -r species -o kaiju.table input1.tsv [input2.tsv ...]
#
# Mandatory arguments:
#    -o FILENAME   Name of output file.
#    -t FILENAME   Name of nodes.dmp file
#    -n FILENAME   Name of names.dmp file.
#    -r STRING     Taxonomic rank, must be one of: phylum, class, order, family, genus, species
#
# Optional arguments:
#    -m FLOAT      Number in [0, 100], denoting the minimum required percentage for the taxon (except viruses) to be reported (default: 0.0)
#    -c INT        Integer number > 0, denoting the minimum required number of reads for the taxon (except viruses) to be reported (default: 0)
#    -e            Expand viruses, which are always shown as full taxon path and read counts are not summarized in higher taxonomic levels.
#    -u            Unclassified reads are not counted for the total reads when calculating percentages for classified reads.
#    -p            Print full taxon path.
#    -l            Print taxon path containing only ranks specified by a comma-separated list,
#                  for example: superkingdom,phylum,class,order,family,genus,species
#    -v            Enable verbose output.
#
# Only one of the options -m and -c may be used at a time.
#
# Failed on line:	29
# Error: Please specify the location of the input file, using the -i option.
#
# Kaiju 1.7.3
# Copyright 2015-2020 Peter Menzel, Anders Krogh
# License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
#
# Usage:
#    kaiju-addTaxonNames -t nodes.dmp -n names.dmp -i kaiju.out -o kaiju-names.out
#
# Mandatory arguments:
#    -i FILENAME   Name of input file
#    -o FILENAME   Name of output file. If not specified, output will be printed to STDOUT.
#    -t FILENAME   Name of nodes.dmp file
#    -n FILENAME   Name of names.dmp file.
#
# Optional arguments:
#    -u            Unclassified reads are not contained in the output.
#    -p            Print full taxon path.
#    -r            Print taxon path containing only ranks specified by a comma-separated list,
#                  for example: superkingdom,phylum,class,order,family,genus,species
#    -v            Enable verbose output.
#
#
# Failed on line:	30
