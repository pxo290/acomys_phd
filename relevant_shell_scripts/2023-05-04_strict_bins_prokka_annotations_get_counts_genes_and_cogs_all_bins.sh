#!/bin/bash -Ee
#SBATCH -t 02-12:30
#SBATCH -p ei-medium
#SBATCH -c 4
#SBATCH -J 2023-05-04_strict_bins_prokka_annotations_get_counts_genes_and_cogs_all_bins
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/slurm_outputs/2023-05-04_strict_bins_prokka_annotations_get_counts_genes_and_cogs_all_bins-%A.out
#SBATCH -e /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/slurm_outputs/2023-05-04_strict_bins_prokka_annotations_get_counts_genes_and_cogs_all_bins-%A.err

#Written on 2023-05-04
#Written by Peter Osborne

#Hastily written and dirty script to get the count of detections in each of the 348 strict bins Prokka annotation output files for all of the
#uniquely detected COGs and genes then write this into two output files.

#Written to be run on the NBI HPC
#Script can be found at: /hpc-home/osbourne/Post-EI_scripts/2023-05-04_strict_bins_prokka_annotations_get_counts_genes_and_cogs_all_bins.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variable
inpdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/Prokka_outdir"

#Going to the input directory
cd "$inpdir"

# #COG counts first
# target_files=$(find -maxdepth 2 -type f -name "Bin*.tsv")
# for f in $target_files
# do
#   bin_name=$(basename "$f" | awk -F ".t" '{print $1}')
#   printf "COG\t$bin_name\n" > "${bin_name}.COG_counts.tsv"
#   out_filer="${bin_name}.COG_counts.tsv"
#   infile="${inpdir}/2023-05-03_all_unique_COGs.txt"
#   while IFS= read -r line
#   do
#     cog_name=$(echo "$line")
#     occurences=$(awk -F "\t" -v coggles="$cog_name" '$6==coggles {print $0}' "$f" | wc -l)
#     occurences=${occurences:="0"}
#     printf "${cog_name}\t${occurences}\n" >> "$out_filer"
#   done < "$infile"
#   printf "Processed file:\t$f\n"
# done

# #Making the combined all COGs results tsv
# printf "COG\n" > 2023-05-04_all_strict_bins_all_unique_COGs_Prokka_counts.txt
# cat 2023-05-03_all_unique_COGs.txt >> 2023-05-04_all_strict_bins_all_unique_COGs_Prokka_counts.txt
# for f in *COG_counts.tsv
# do
#   bin_name=$(basename "$f" | awk -F ".COG" '{print $1}')
#   awk -F "\t" '{print $2}' "$f" > "${bin_name}.just_COG_counts"
# done

# paste -d "\t" 2023-05-04_all_strict_bins_all_unique_COGs_Prokka_counts.txt *.just_COG_counts > zoot.tsv
# rm 2023-05-04_all_strict_bins_all_unique_COGs_Prokka_counts.txt
# mv zoot.tsv 2023-05-04_all_strict_bins_all_unique_COGs_Prokka_counts.txt

# #Cleaning up
# rm *.just_COG_counts
# rm *.COG_counts.tsv

#Now gene counts
target_files=$(find -maxdepth 2 -type f -name "Bin*.tsv")
for f in $target_files
do
  bin_name=$(basename "$f" | awk -F ".t" '{print $1}')
  printf "COG\t$bin_name\n" > "${bin_name}.gene_counts.tsv"
  out_filer="${bin_name}.gene_counts.tsv"
  infile="${inpdir}/2023-05-03_all_unique_genes.txt"
  while IFS= read -r line
  do
    cog_name=$(echo "$line")
    occurences=$(awk -F "\t" -v coggles="$cog_name" '$4==coggles {print $0}' "$f" | wc -l)
    occurences=${occurences:="0"}
    printf "${cog_name}\t${occurences}\n" >> "$out_filer"
  done < "$infile"
  printf "Processed file:\t$f\n"
done

#Making the combined all genes results tsv
printf "Gene\n" > 2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt
cat 2023-05-03_all_unique_genes.txt >> 2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt
for f in *gene_counts.tsv
do
  bin_name=$(basename "$f" | awk -F ".gen" '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${bin_name}.just_gene_counts"
done

paste -d "\t" 2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt *.just_gene_counts > zoot.tsv
rm 2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt
mv zoot.tsv 2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt

#Cleaning up
rm *just_gene_counts
rm *gene_counts.tsv

#Sending them to email
#mail -s '2023-05-04_all_strict_bins_all_unique_COGs_Prokka_counts.txt' -a 2023-05-04_all_strict_bins_all_unique_COGs_Prokka_counts.txt peter.osborne@earlham.ac.uk <<< "File 2023-05-04_all_strict_bins_all_unique_COGs_Prokka_counts.txt should be attached"
mail -s '2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt' -a 2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt peter.osborne@earlham.ac.uk <<< "File 2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt should be attached"