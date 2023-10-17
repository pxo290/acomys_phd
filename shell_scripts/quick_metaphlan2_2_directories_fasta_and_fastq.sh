#!/bin/bash -e
#SBATCH -t 00-00:35
#SBATCH -c 12
#SBATCH -J MetaPhlan2
#SBATCH --mem=122000
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######SCRIPT######
source package /tgac/software/testing/bin/metaphlan-2f1b17a1f4e9
export fastq_directory=$1
export fasta_directory=$2
cd $1
for f in *.fastq
do
  metaphlan_identifier=${f:0:7}
  mkdir $metaphlan_identifier-FASTQ_metahphlan2_results
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type fastq > $metaphlan_identifier-FASTQ_metahphlan2_results/${f%}-metaphlan-output.txt
done
cd $2
for f in *.fasta
do
  metaphlan_identifier=${f:0:7}
  mkdir $metaphlan_identifier-FASTA_metahphlan2_results
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type fasta > $metaphlan_identifier-FASTA_metahphlan2_results/${f%}-metaphlan-output.txt
done
####Output Handling####
cd $1
locale=$(find . -maxdepth 1 -mindepth 1 -type d -printf)
for d in $locale
do
  cd $d
  printf "\nThe output of Metaphlan will now be split into different taxonomic groups.\n"
  export metaphlan_output_file=$(find . -type f -name "*-metaphlan-output.txt")
  for f in $metaphlan_output_file
  do
    metaphlan_identifier=${f:0:7}
    mkdir $metaphlan_identifier-tax_rank_sorted_results
    printf "\nResults files arranged for joining of the two season samples will be prepared from the Metaphlan output file '$f'\n"
    printf "\nThe format of the output will be <genus_species> <relative abundance as %>\n"
    printf "\nSpecies level first\n"
    awk '!/t__/ && /s__/' $f > MET_SPECIES_TEMP_FILE.txt
    sed -n -e 's/.*s__//p' MET_SPECIES_TEMP_FILE.txt > MET_SPECIES_TEMP_FILE2.txt
    sort -k 1b,1 MET_SPECIES_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-SPECIES_only_sorted.txt
    rm MET_SPECIES_TEMP_FILE.txt && rm MET_SPECIES_TEMP_FILE2.txt
    printf "\nGenus level next\n"
    awk '!/s__/ && /g__/' $f > MET_GENUS_TEMP_FILE.txt
    sed -n -e 's/.*g__//p' MET_GENUS_TEMP_FILE.txt > MET_GENUS_TEMP_FILE2.txt
    sort -k 1b,1 MET_GENUS_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-GENUS_only_sorted.txt
    rm MET_GENUS_TEMP_FILE.txt && rm MET_GENUS_TEMP_FILE2.txt
    printf "\nFamily level next\n"
    awk '!/g__/ && /f__/' $f > MET_FAMILY_TEMP_FILE.txt
    sed -n -e 's/.*f__//p' MET_FAMILY_TEMP_FILE.txt > MET_FAMILY_TEMP_FILE2.txt
    sort -k 1b,1 MET_FAMILY_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-FAMILY_only_sorted.txt
    rm MET_FAMILY_TEMP_FILE.txt && rm MET_FAMILY_TEMP_FILE2.txt
    printf "\nOrder level next\n"
    awk '!/f__/ && /o__/' $f > MET_ORDER_TEMP_FILE.txt
    sed -n -e 's/.*o__//p' MET_ORDER_TEMP_FILE.txt > MET_ORDER_TEMP_FILE2.txt
    sort -k 1b,1 MET_ORDER_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-ORDER_only_sorted.txt
    rm MET_ORDER_TEMP_FILE.txt && rm MET_ORDER_TEMP_FILE2.txt
    printf "\nClass level next\n"
    awk '!/o__/ && /c__/' $f > MET_CLASS_TEMP_FILE.txt
    sed -n -e 's/.*c__//p' MET_CLASS_TEMP_FILE.txt > MET_CLASS_TEMP_FILE2.txt
    sort -k 1b,1 MET_CLASS_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-CLASS_only_sorted.txt
    rm MET_CLASS_TEMP_FILE.txt && rm MET_CLASS_TEMP_FILE2.txt
    printf "\nPhylum level last\n"
    awk '!/c__/ && /p__/' $f > MET_PHYLA_TEMP_FILE.txt
    sed -n -e 's/.*p__//p' MET_PHYLA_TEMP_FILE.txt > MET_PHYLA_TEMP_FILE2.txt
    sort -k 1b,1 MET_PHYLA_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-PHYLA_only_sorted.txt
    rm MET_PHYLA_TEMP_FILE.txt && rm MET_PHYLA_TEMP_FILE2.txt
    printf "\nSorted and tidied results files for different taxonomic levels for Metaphlan2 output file '$f' have been made."
  done
  cd ..
done
cd $2
locale=$(find . -maxdepth 1 -mindepth 1 -type d -printf)
for d in $locale
do
  cd $d
  printf "\nThe output of Metaphlan will now be split into different taxonomic groups.\n"
  export metaphlan_output_file=$(find . -type f -name "*-metaphlan-output.txt")
  for f in $metaphlan_output_file
  do
    metaphlan_identifier=${f:0:7}
    mkdir $metaphlan_identifier-tax_rank_sorted_results
    printf "\nResults files arranged for joining of the two season samples will be prepared from the Metaphlan output file '$f'\n"
    printf "\nThe format of the output will be <genus_species> <relative abundance as %>\n"
    printf "\nSpecies level first\n"
    awk '!/t__/ && /s__/' $f > MET_SPECIES_TEMP_FILE.txt
    sed -n -e 's/.*s__//p' MET_SPECIES_TEMP_FILE.txt > MET_SPECIES_TEMP_FILE2.txt
    sort -k 1b,1 MET_SPECIES_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-SPECIES_only_sorted.txt
    rm MET_SPECIES_TEMP_FILE.txt && rm MET_SPECIES_TEMP_FILE2.txt
    printf "\nGenus level next\n"
    awk '!/s__/ && /g__/' $f > MET_GENUS_TEMP_FILE.txt
    sed -n -e 's/.*g__//p' MET_GENUS_TEMP_FILE.txt > MET_GENUS_TEMP_FILE2.txt
    sort -k 1b,1 MET_GENUS_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-GENUS_only_sorted.txt
    rm MET_GENUS_TEMP_FILE.txt && rm MET_GENUS_TEMP_FILE2.txt
    printf "\nFamily level next\n"
    awk '!/g__/ && /f__/' $f > MET_FAMILY_TEMP_FILE.txt
    sed -n -e 's/.*f__//p' MET_FAMILY_TEMP_FILE.txt > MET_FAMILY_TEMP_FILE2.txt
    sort -k 1b,1 MET_FAMILY_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-FAMILY_only_sorted.txt
    rm MET_FAMILY_TEMP_FILE.txt && rm MET_FAMILY_TEMP_FILE2.txt
    printf "\nOrder level next\n"
    awk '!/f__/ && /o__/' $f > MET_ORDER_TEMP_FILE.txt
    sed -n -e 's/.*o__//p' MET_ORDER_TEMP_FILE.txt > MET_ORDER_TEMP_FILE2.txt
    sort -k 1b,1 MET_ORDER_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-ORDER_only_sorted.txt
    rm MET_ORDER_TEMP_FILE.txt && rm MET_ORDER_TEMP_FILE2.txt
    printf "\nClass level next\n"
    awk '!/o__/ && /c__/' $f > MET_CLASS_TEMP_FILE.txt
    sed -n -e 's/.*c__//p' MET_CLASS_TEMP_FILE.txt > MET_CLASS_TEMP_FILE2.txt
    sort -k 1b,1 MET_CLASS_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-CLASS_only_sorted.txt
    rm MET_CLASS_TEMP_FILE.txt && rm MET_CLASS_TEMP_FILE2.txt
    printf "\nPhylum level last\n"
    awk '!/c__/ && /p__/' $f > MET_PHYLA_TEMP_FILE.txt
    sed -n -e 's/.*p__//p' MET_PHYLA_TEMP_FILE.txt > MET_PHYLA_TEMP_FILE2.txt
    sort -k 1b,1 MET_PHYLA_TEMP_FILE2.txt > $metaphlan_identifier-tax_rank_sorted_results/$f-PHYLA_only_sorted.txt
    rm MET_PHYLA_TEMP_FILE.txt && rm MET_PHYLA_TEMP_FILE2.txt
    printf "\nSorted and tidied results files for different taxonomic levels for Metaphlan2 output file '$f' have been made."
  done
  cd ..
done

######NOTES######
#22/05/20
#This script assumes you have a directory which contains FASTQ files, and one
#which has FASTA files in it - you give them both to the script, the FASTQ
#directory being the first argument and the FASTA directory being the second.
#It does the same thing in each of these directories using for loops, so I'll
#just describe it once:
# 1. Gets, hopefully, the first 5 characters of the filename for each one - why
#    this is done by positions 0-7 I don't know.
# 2. It makes a directory which has this string at the start and also includes
#    the relevant filetype in it as well
# 3. It runs Metaphlan2 on the files in the $1 (and later $2) directories, the
#    only difference in these commands being it set to either FASTA or FASTQ
# 4. After both user provided directories have had all the FASTQ/FASTA files
#    processed it switches into handling the generated output files, the point
#    of which is to make files suitable for joining and use in GNUplot
# 5. It will go through each output text file and produce another directory
#    which should also get the name with species, individual number and season
#    though no file type since it isn't necessary here
# 6. Then it will hopefully produce 6 text files for each Metaphlan 2 output,
#    these files will give the relative abundance calculated by the programme
#    for all the hits at that taxonomic level. The end result will be a file of
#    two columns, taxon in the left and value in the right. There must be no
#    spaces within a column, otherwise later joining won't work
# 25/05/20 - Having just done it with the Kraken one, you should consider tidying
# this up using a conserved function and running it in a for loop on each file
# with the different taxonomic level letter codes
