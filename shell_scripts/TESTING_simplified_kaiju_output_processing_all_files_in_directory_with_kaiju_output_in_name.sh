#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Kaiju_output_processing
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

refnodes="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
refdbfile="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
refdbnames="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
refdbfile="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"

source package /tgac/software/testing/bin/kaiju-1.7.3

targets=$(find -maxdepth 1 -type f -name "*_Kaiju_output.out")
for f in $targets
do
  printf "\nOperating on file:\t$f\n"
  label=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  kaiju-addTaxonNames -t "$refnodes" -n "$refdbnames" -i "$f" -r phylum,class,order,family,genus,species -v -o "${label}_kaiju_output.names_added.txt"
  kaiju2table -t "$refnodes" -n "$refdbnames" -r species -v -p -o "${label}_kaiju_output.Kaiju_2_table_output_SPECIES.txt" "$f"
  kaiju2table -t "$refnodes" -n "$refdbnames" -r genus -v -p -o "${label}_kaiju_output.Kaiju_2_table_output_GENERA.txt" "$f"
  kaiju2table -t "$refnodes" -n "$refdbnames" -r family -v -p -o "${label}_kaiju_output.Kaiju_2_table_output_FAMILY.txt" "$f"
done
