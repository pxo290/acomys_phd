#!/bin/bash -e
#SBATCH -t 00-05:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Sci_name_Get
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

rm TEMP_TAX_IDS.txt || printf "\nAlready removed\n"
rm scientific_names_list.txt || printf "\nAlready removed\n"
cat Percentage_reads_all_samples_all_genera_kaiju.txt | awk -F "\t" '{print $1}' >> TEMP_TAX_IDS.txt
while read -r line
do
  true_name=$(cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '"$line"') print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}')
  printf "\n$line\tIS\t$true_name" | awk -F "\t" '{print $3}' | awk 'NF' >> scientific_names_list.txt
done < TEMP_TAX_IDS.txt
rm TEMP_TAX_IDS.txt


while read -r line
do
  if grep -q "\b$line\b" AC40J_kaiju_output-GENERA.out
  then
    found_percent=$(cat AC40J_kaiju_output-GENERA.out | awk '{if ($4 == '"$line"') print $0;}' | awk -F "\t" '{print $2}')
    printf "\nFound:\t$line\t$found_percent"
  else
    found_percent="0"
    printf "\nFound:\t$line\t$found_percent"
  fi
done < long_list_genera.txt

for f in *_kaiju_output-GENERA.out ; do basename $f | awk -F "_" '{print $1}' && cat $f | grep -v "Candidatus" | grep -v "Eukaryota" | grep -v "percent" | grep -v "^Viruses$" | grep -v "^cannot be assigned to a (non-viral) genus$" | head -n -1 | awk -F "\t" '{print $5}' | awk -F ";" '{print $7}' | wc -l ; done >> excluding_fungi.txt

cat AC40J_kaiju_output-GENERA.out | grep -v "percent" | grep -v "^Viruses$" | grep -v "^cannot be assigned to a (non-viral) genus$" | head -n -1 | awk -F "\t" '{print $4,$3}'

for f in *_kaiju_output-GENERA.out ; do cat $f | grep -v "percent" | grep -v "^Viruses$" | grep -v "^cannot be assigned to a (non-viral) genus$" | head -n -1 | awk -F "\t" '{print $4}' ; done | sed 's/[A-Za-z]*//g' | awk 'NF' | sort -V | uniq >> long_list_genera.txt

1578

33951
434

1139933 1578
cat names.dmp | awk '{if ($1 == "1578") print $0;}'



cat names.dmp | awk '{if ($1 == "434") print $0;}'

cat names.dmp | awk '{if ($1 == "100") print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}'

cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == "1578") print $0;}'

for f in *_kaiju_output-GENERA.out ; do cat $f | grep -v "percent" | grep -v "^Viruses$" | grep -v "^cannot be assigned to a (non-viral) genus$" | wc -l ; done

/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp

for f in *_kaiju_output-SPECIES.out ; do cat $f | grep -v "percent" | grep -v "^Viruses$" | grep -v "^cannot be assigned to a (non-viral) species$" | head -n -1 | awk -F "\t" '{print $4}' ; done | sed 's/[A-Za-z]*//g' | awk 'NF' | sort -V | uniq >> long_list_species.txt


1263026

15.704388	68	1262907	cellular organisms;Bacteria;Terrabacteria group;Tenericutes;Mollicutes;Mycoplasmatales;Mycoplasmataceae;Mycoplasma;environmental samples;Mycoplasma sp. CAG:877;

2732487
cat *kaiju_output-SPECIES.out | grep -v "percent" | grep -v "^Viruses$" | grep -v "^cannot be assigned to a (non-viral) species$" | grep -v "^unclassified$" | sed 's/[A-Za-z]*//g' | awk 'NF' |  wc -l


awk -F "," '{sum+=$NF} END{print "Total genomes covered:"sum}' AC6J_mapped_sorted.bam.genomeproportion

awk -F "," '$NF<=0.99{print $0}' AC6J_mapped_sorted.bam.genomeproportion

k141_10792606

while read -r line
do
  read_name=$(echo "$line" | awk -F "," '{print $1}')
  origin=$(pwd)
  cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/binned_fastas_Kaiju_raw
  bin_containing_read=$(grep "$read_name" *_kaiju_output.out | awk -F "kaiju" '{print $1}' | sed 's/binned/Bin/g' | awk -F "_" '{print $1,$2}' | sed 's/ /_/g')
  TAXID_matching=$(grep "$read_name" *_kaiju_output.out | awk -F "\t" '{print $3}')
  science_name=$(cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '"$TAXID_matching"') print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}')
  cd $origin
  proportion_mapped=$(echo "$line" | awk -F "," '{print $2}')
  read_size=$(grep "\b$read_name\b" genome_lengths_all_bins.genome | awk -F "\t" '{print $2}')
  printf "\n$proportion_mapped\t$read_name\t$bin_containing_read\t$read_size\t$TAXID_matching\t$science_name"
done < AC6J_bins_mapping_proportion_point_99_above.txt

printf "Bin name\tRead count\tBase count\tClassified read percentage all reads\tClassified read count\tUnclassified read percentage of all reads\tUnclassified read count\tUnidentified read percentage\tUnidentified read count\tLargest percentage TaxID scientific name\tLargest percentage TaxID actual percentage\tLargest percentage TaxID actual read count\n" >> detailed_bin_notes.tsv
output_file=$(find -maxdepth 1 -type f -name "detailed_bin_notes.tsv")
for f in *.fa
do
  origin=$(pwd)
  label=$(basename $f | awk -F "." '{print $1}')
  read_count=$(grep -c ">" $f)
  basecount=$(grep -v ">" $f | awk 'NF' | wc -c)
  species_file_directory="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/binned_fastas_Kaiju_Species"
  species_file_label=$(echo $label | sed 's/Bin/binned/g')
  output_file_name=$(readlink -f $output_file)
  sci_name_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Kaiju_TaxIDS_and_scientific_names_entire_database.txt"
  cd $species_file_directory
  species_file_name="${species_file_label}_kaiju_output-SPECIES.out"
  classified_read_percentage=$(cat $species_file_name | grep -v "percent" | grep -v "^Viruses$" | grep -v "cannot be assigned to a (non-viral) species" | head -n -1 | awk -F "\t" '{print $2}' | paste -sd+ - | bc)
  classified_read_count=$(cat $species_file_name | grep -v "percent" | grep -v "^Viruses$" | grep -v "cannot be assigned to a (non-viral) species" | head -n -1 | awk -F "\t" '{print $3}' | paste -sd+ - | bc)
  unclassified_read_percentage=$(tail -1 $species_file_name | awk -F "\t" '{print $2}')
  unclassified_read_count=$(tail -1 $species_file_name | awk -F "\t" '{print $3}')
  classified_but_unidentified_read_percentage=$(grep "cannot be assigned to a" $species_file_name | awk -F "\t" '{print $2}')
  classified_but_unidentified_read_count=$(grep "cannot be assigned to a" $species_file_name | awk -F "\t" '{print $3}')
  largest_TAXID=$(head -2 $species_file_name | grep -v "percent" | awk -F "\t" '{print $4}')
  largest_science_name=$(cat $sci_name_file | awk '{if ($1 == '"$largest_TAXID"') print $0;}' | awk -F "\t" '{print $2}')
  largest_species_percentage_reads=$(head -2 $species_file_name | grep -v "percent" | awk -F "\t" '{print $2}')
  largest_species_read_count=$(head -2 $species_file_name | grep -v "percent" | awk -F "\t" '{print $3}')
  cd $origin
  printf "$label\t$read_count\t$basecount\t$classified_read_percentage\t$classified_read_count\t$unclassified_read_percentage\t$unclassified_read_count\t$classified_but_unidentified_read_percentage\t$classified_but_unidentified_read_count\t$largest_science_name\t$largest_species_percentage_reads\t$largest_species_read_count\n" >> $output_file_name
done


cat detailed_bin_notes.tsv | awk -F "\t" '{print $1,$2,$3}' | sed 's/ /\t/g' >> bins_read_count_to_base_count.tsv && mail -s 'bins_read_count_to_base_count.tsv' -a bins_read_count_to_base_count.tsv peter.osborne@earlham.ac.uk <<< "" && rm bins_read_count_to_base_count.tsv
cat detailed_bin_notes.tsv | awk -F "\t" '{print $1,$5}' | sed 's/ /\t/g' >> bins_species_count.tsv && mail -s 'bins_species_count.tsv' -a bins_species_count.tsv peter.osborne@earlham.ac.uk <<< "" && rm bins_species_count.tsv

cat detailed_bin_notes.tsv | awk -F "\t" '{print $1,$4,$6,$8}' | sed 's/ /\t/g' >> bins_percent_reads_classified_unclassified_unidentified.tsv && mail -s 'bins_percent_reads_classified_unclassified_unidentified.tsv' -a bins_percent_reads_classified_unclassified_unidentified.tsv peter.osborne@earlham.ac.uk <<< "" && rm bins_percent_reads_classified_unclassified_unidentified.tsv

#Just an example of how you would put tabs in the output of awk, so the fields you have awked out are separated by tabs in the output

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/genomes_from_Nancy_Teng_and_David_Baker_Lactobacillus_culturing_from_pilot_samples/QIB-Nancy-Teng-210326

TTATTTGACAGGTGGTTCAGACCTGTCTTTTTTTATTTTATCACATAAAAAAAGCAAAATCGGCCCAAAAAGTGTGAGCAGTGTGAGTTTATTGTATTCACACTCTTGCAGTTTTGGCGGGGGCTGTTTGCCGTAGCTCAGCCCCCGCG


#Get the distribution of read lengths in a fastq file
awk 'NR%4 == 2 {lengths[length($0)]++} END {for (l in lengths) {print l, lengths[l]}}' PID-0578-r-13A_S1_R2_001.fastq

fastp -i PID-0578-r-13A_S1_R1_001_COPY.fastq -I PID-0578-r-13A_S1_R2_001_COPY.fastq --detect_adapter_for_pe

awk 'NR%4 == 2 {lengths[length($0)]++} END {for (l in lengths) {print l, lengths[l]}}' PID-0578-r-13A_S1_R2_001.fastq | sort -V -k1 | tail -1

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas

#!/bin/bash -e
printf "Bin_name\tTotal_bases\tLongest_contig_length\tPercentage_bases_in_longest_contig\tLongest_contig_name\n" >> bases_and_longest_contigs_in_Bins.txt
for f in *.fa
do
  bin_name=$(basename $f | awk -F ".fa" '{print $1}')
  total_bases=$(grep "len" $f | awk -F "len=" '{print $2}' | sort -V | paste -sd+ - | bc)
  longest_contig=$(grep "len" $f | awk -F "len=" '{print $2}' | sort -V | tail -1)
  longest_contig_name=$(grep "len" $f | awk -F " " '{print $4"\t"$1}' | sed 's/len=//g' | sort -V -k1 | tail -1 | awk -F ">" '{print $2}')
  proportion_bases_in_longest_contig=$(echo "($longest_contig / $total_bases) * 100" | bc -l)
  printf "$bin_name\t$total_bases\t$longest_contig\t$proportion_bases_in_longest_contig\t$longest_contig_name\n" >> bases_and_longest_contigs_in_Bins.txt
done

mail -s 'Bases in longest contigs per bin' -a bases_and_longest_contigs_in_Bins.txt peter.osborne@earlham.ac.uk <<< "File should be attached as indicated"


Bin_c64	811193	201483	24.83786225965953848200	k141_12995632

target=$(find -maxdepth 2 -type f -name "*.gz" -name "*R1*") && for f in $target ; do basename $f | awk -F ".fastq" '{print $1}' && awk 'NR%4 == 2 {lengths[length($0)]++} END {for (l in lengths) {print l, lengths[l]}}' $f ; done



geom_point(data = PID.0578.r.16aB_S25_R1_001.read_lengths_and_occurences_of_that_length, aes(x = PID.0578.r.16aB_S25_R1_001.read_lengths_and_occurences_of_that_length$read_length, y = PID.0578.r.16aB_S25_R1_001.read_lengths_and_occurences_of_that_length$count, color="orange"))


binned_m927_kaiju_output-SPECIES.out

1898203

k141_10283936

grep "len" Bin_m1050.fa | awk -F "len=" '{print $2}' | awk 'NF' | paste -sd+ - | bc


binned_m1050_kaiju_output.out 2320088
cat binned_m1050_kaiju_output.out | awk '{if ($3 == "2320088") print $0}' | awk -F "\t" '{print $2}'

for f in *.fa ; do nome=$(basename $f | awk -F ".fa") && printf "$nome\n" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/binned_fastas_Kaiju_Species
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/binned_fastas_Kaiju_raw
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas
binned_m935_kaiju_output-SPECIES.out
binned_c438_kaiju_output.out
Bin_c251.fa

printf "Bin_name\tTotal_bases_in_bin\tPercent_bases_in_MAS_contigs\nPercent_bases_in_longest_contig\n" >> total_bases_to_percent_MAS_bases.txt
for f in *-SPECIES.out
do
  origin=$(pwd) && printf "\nI am here:\t$origin\n"
  bin_name=$(basename $f | awk -F "_" '{print $1,$2}' | sed 's/binned /Bin_/g' | awk 'NF') && printf "\nBin name is:\t$bin_name\n"
  FINDING_NAME=$(basename $f | sed 's/-SPECIES//g' | awk 'NF') && printf "\nFinding name is:\t$FINDING_NAME\n"
  MAS_TAXID=$(head -2 $f | tail -1 | awk -F "\t" '{print $4}') && printf "\nMAS TAXID is:\t$MAS_TAXID"
  cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/binned_fastas_Kaiju_raw || printf "\nCouldn't switch to raw kaiju output directory\n"
  TARGET_RAW=$(find -maxdepth 1 -type f -name "$FINDING_NAME" | awk -F "./" '{print $2}') && printf "\nTarget raw is:\t$TARGET_RAW\n"
  MATCHING_READS=$(cat "$TARGET_RAW" | awk '{if ($3 == '"$MAS_TAXID"') print $0;}' | awk -F "\t" '{print $2}') && printf "\nMatching reads are:\t$MATCHING_READS\n"
  cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas || printf "\nCouldn't switch to the bin directory\n"
  TARGET_BIN=$(find -maxdepth 1 -type f -name "$bin_name.fa") && printf "\nTarget bin is:\t$TARGET_BIN\n"
  BASES_IN_LONGEST_CONTIG=$(grep "len" $TARGET_BIN | awk -F "len=" '{print $2}' | awk 'NF' | sort -n | tail -1)
  total_bases=$(grep "len" $TARGET_BIN | awk -F "len=" '{print $2}' | awk 'NF' | paste -sd+ - | bc) && printf "\nThe total bases in the bin is:\t$total_bases\n"
  percent_bases_in_longest_contig=$(echo "($BASES_IN_LONGEST_CONTIG / $total_bases) * 100" | bc -l | awk '{printf "%f", $0}')
  TEMP_UID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16) && printf "\nTemporary UID is:\t$TEMP_UID\n"
  printf "$MATCHING_READS" >> ${TEMP_UID}_matching_reads.txt
  touch ${TEMP_UID}_matching_read_lengths.txt
  while read -r line
  do
    read_name=$(echo "$line") && printf "\nread_name is:\t$read_name\n"
    length_of_matching_read=$(grep "$read_name" $TARGET_BIN | awk -F "len=" '{print $2}' | awk 'NF') && printf "\nlength_of_matching_read is:\t$length_of_matching_read\n"
    printf "$length_of_matching_read\n" >> ${TEMP_UID}_matching_read_lengths.txt
  done < ${TEMP_UID}_matching_reads.txt
  NUMBER_BASES_IN_MAS_MATCHING_READS=$(cat ${TEMP_UID}_matching_read_lengths.txt | paste -sd+ - | bc) && printf "\nThe number of bases in all the MAS matching contigs is:\t$NUMBER_BASES_IN_MAS_MATCHING_READS\n"
  percent_total_bases_in_MAS_matching_reads=$(echo "($NUMBER_BASES_IN_MAS_MATCHING_READS / $total_bases) * 100" | bc -l | awk '{printf "%f", $0}') && printf "\nThe percent of bases in MAS matching contigs of the total bases in the bin is:\t$percent_total_bases_in_MAS_matching_reads\n"
  rm ${TEMP_UID}_matching_reads.txt && rm ${TEMP_UID}_matching_read_lengths.txt || printf "\nFailed on line 211\n"
  cd $origin || printf "\nFailed on line 212\n"
  printf "$bin_name\t$total_bases\t$percent_total_bases_in_MAS_matching_reads\t$percent_bases_in_longest_contig\n" >> total_bases_to_percent_MAS_bases.txt || printf "\nFailed on line 213\n"
done || printf "\nFailed on line 214\n"


cat binned_m1050_kaiju_output.out | awk '{if ($3 == "2320088") print $0}' | awk -F "\t" '{print $2}'
awk '{if ($1 == '"$largest_TAXID"') print $0;}'
echo "($longest_contig / $total_bases) * 100" | bc -l


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output

target=$(find -maxdepth 2 -type f -name "*.fa") && for f in $target ; do nome=$(readlink -f $f | awk -F "/" '{print $8}') && mv $f ${nome}.fa ; done

target=$(find -maxdepth 1 -type f -name "*.fa") && for f in $target ; do destination=$(readlink -f $f | awk -F "/" '{print $8}' | awk -F "." '{print $1}') && mv $f $destination ; done

fastp -i Testing_R1.fastq -I Testing_R2.fastq --detect_adapter_for_pe


target=$(find -maxdepth 1 -type f -name "*R1_001.fastq.gz") && for f in $target ; do inpf1=$(basename "$f" | awk -F "") && inpf2=$(basename "$inpf1" | sed 's/_R1_/_R2_/g') && uzinpf1=$(echo "$inpf1" | awk -F ".gz" '{print $1}' | awk 'NF') && uzinpf2=$(echo "$inpf2" | awk -F ".gz" '{print $1}') && lobel=$(basename "$inpf1" | awk -F "-" '{print $4}' | awk -F "." '{print $1}') && export label=$(printf "${lobel}_Fastp") ; done

target=$(find -maxdepth 2 -type f -name "*.fa") && for f in $target ; do nome=$(basename $f | awk -F "_meg" '{print $1}') && contig_sizes=$(grep "len" $f | awk -F "len=" '{print $2}' | sort -V) && printf "\n$nome\n$contig_sizes\n" ; done


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output/16bE_S23_R1_001_megahit_output
16bE_S23_R1_001_megahit_output.fa

targets=$(find -maxdepth 2 -type f -name "*_megahit_output.fa") && for f in $targets ; do nome=$(basename $f | awk -F "_R1_" '{print $1}') && printf "$nome\n" ; done


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output/41A_S6_R1_001_megahit_output

Lacticaseibacillus_brantae_genomic.fna


targets=$(find -maxdepth 1 -type f -name "*R1_001.fastq")
for f in $targets
do
  destination="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Kaiju_on_reads_output"
  inpf1=$(basename $f)
  inpf2=$(echo $inpf1 | sed 's/_R1_/_R2_/g')
  label=$(echo $inpf1 | awk -F "_R1" '{print $1}' | awk -F "-" '{print $4}')
  origin=$(pwd)
  cd $destination
  mkdir "${label}_Kaiju_output"
  cd "${label}_Kaiju_output"
  output_dir=$(pwd)
  cd $origin
  refnodes="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
  refdbfile="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk"
  refdbnames="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
  refdbfile="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"
  kaiju -t $refnodes -f $refdbfile -v -a greedy -i $inpf1 -j $inpf2 -o "${label}_Kaiju_output.out"
  mv ${label}_Kaiju_output.out $output_dir
  cd $output_dir
  kaiju2table -t $refnodes -n $refnames -r species -v -p -o ${label}_Kaiju_output_SPECIES.out ${label}_Kaiju_output.out
  kaiju-addTaxonNames -t $refnodes -n $refnames -i ${label}_kaiju_output.out -u -r kingdom,phylum,class,order,family,genus,species -o ${label}_kaiju_output.names_added.out
  cd $origin
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output/39B_S15_R1_001_megahit_output
2379857 total bases
k145_4 - 315
k145_12 - 1329
k145_34 - 287
k145_57 - 324
k145_68 - 443
k145_83 - 930
k145_148 - 310
k145_188 - 300
k145_198 - 344
k145_200 - 399

104940


target=$(find -maxdepth 2 -type f -name "*_megahit_output.fa")
for f in $target
do
  label=$(basename "$f" | awk -F "_" '{print $1,$2}' | sed 's/ /_/g')
  total_bases=$(grep "len" "$f" | awk -F "len=" '{print $2}' | sort -n | paste -sd+ - | bc -l)
  longest_contig_length=$(grep "len" "$f" | awk -F "len=" '{print $2}' | sort -V | tail -1)
  longest_contig_name=$(grep "$longest_contig_length" "$f" | awk -F " " '{print $1}' | awk -F ">" '{print $2}')
  percent_bases_in_longest_contig=$(echo "($longest_contig_length / $total_bases) * 100" | bc -l | awk '{printf "%f", $0}')
  printf "\n$label\t$percent_bases_in_longest_contig\n" || printf "\nFailed on line 6\n"
done

41A_S6	45.790581 k145_23 Lactobacillus brantae
41C_S8	30.137202 k145_18 Pediococcus pentosaceus

source package /tgac/software/production/bin/gapcloser-1.12

PID-0578-r-16bA_S19_R1_001.fastq

sbatch TESTING_BWA_map_reads_to_megahit_assemblies_give_paths_to_reads_and_assembly_on_command_line.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output/16bA_S19_R1_001_megahit_output/16bA_S19_R1_001_megahit_output.fa /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/PID-0578-r-16bA_S19_R1_001.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/PID-0578-r-16bA_S19_R2_001.fastq

printf "Sample\tPercent_reads_in_PE_file_classified_as_genus_Lactobacillus\n" >> percent_reads_classed_genus_Lactobacillus_each_sample.txt && for f in *table_output_GENERA.txt ; do nom=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && lac_gen_percent_reads=$(grep "cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;" $f | awk -F "\t" '{print $2}') && total_read_no=$(cat "$f" | awk -F "\t" '{print $3}' | grep -v "reads" | awk 'NF' | sort -V | paste -sd+ - | bc -l) && printf "$nom\t$lac_gen_percent_reads\t$total_read_no\n" >> percent_reads_classed_genus_Lactobacillus_each_sample.txt ; done

printf "Sample\tNumber_unique_species_detected\tTotal_reads_in_file\tDifference_in_percent_reads_classified_between_first_and_second_most_abundant_species" >> unique_species_detected_by_Kaiju_all_samples.txt && for f in *2_table_output_SPECIES.txt ; do species_detections=$(cat "$f" | awk -F "\t" '{print $4}' | grep -v "NA" | grep -v "tax" | sort -V | uniq | wc -l) && nom=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && total_read_no=$(cat "$f" | awk -F "\t" '{print $3}' | grep -v "reads" | awk 'NF' | sort -V | paste -sd+ - | bc -l) && most_to_second_read_diff=$(head -3 $f | grep -v "file" | awk -F "\t" '{print $2}' | awk 'NF' | paste -sd+ - | bc -l) && printf "\n$nom\t$species_detections\t$total_read_no\t$most_to_second_read_diff" >> unique_species_detected_by_Kaiju_all_samples.txt ; done


printf "Bin_name\tUnidentified_contigs\tSpecies_classified_contigs" >> all_bins_classified_versus_unclassified_contig_percentages.tsv
for f in *kaiju_output-SPECIES.out
do
  nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}' | sed 's/binned/Bin/g')
  cannot_classify=$(tail -2 "$f" | grep "cannot" | awk -F "\t" '{print $2}')
  unclassifiable=$(tail -1 "$f" | awk -F "\t" '{print $2}')
  unidentified_contig_percentage=$(echo "$cannot_classify + $unclassifiable" | bc -l)
  classifiable_reads=$(head -n -1 "$f" | grep -v "file" | grep -v "cannot be assigned to a (non-viral) species" | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  printf "\n$nome\t$unidentified_contig_percentage\t$classifiable_reads" >> all_bins_classified_versus_unclassified_contig_percentages.tsv
done

printf "Bin_name\tTotal_contigs\tSpecies_classified_contigs_percent" >> all_bins_number_contigs_to_percent_contigs_classified_to_species_level_by_kaiju.tsv
for f in *kaiju_output-SPECIES.out
do
  nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}' | sed 's/binned/Bin/g')
  total_contigs=$(cat "$f" | awk -F "\t" '{print $3}' | grep -v "reads" | awk 'NF' | paste -sd+ - | bc -l)
  classifiable_reads=$(head -n -1 "$f" | grep -v "file" | grep -v "cannot be assigned to a (non-viral) species" | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  printf "\n$nome\t$total_contigs\t$classifiable_reads" >> all_bins_number_contigs_to_percent_contigs_classified_to_species_level_by_kaiju.tsv
done


AC6J - 1421 contigs map over .99 to reads (or vice versa)
AC6J - 10183 contigs over 0.75 but below 0.99 to reads (or vice versa)
AC6J - 121367 contigs below 0.75 to reads (or vice versa)
132973 contigs in the reference fasta

AC6J mapping
Mapping	Contigs	Percent_of_all_bin_contigs
Over .99	1421	1.068637994
0.75 to 0.99	10183	7.657945598
Below 0.75	121367	91.27191234
Mystery	2	0.001504065

AR47N mapping
High conf (99%+) - 1946 - 1.463454987102645
Medium conf (75-99%) - 9572 - 7.198453821452475
Low conf (<75%) - 121454 - 91.337339159077407
Mystery - 1 - 0.0007520325

k141_11756006

131552
awk -F "," '$NF>0.99{print $0}'
awk -F "," '($NF<0.99 && $NF>=0.75){print $0}'
cat AC6J_bins_mapping_proportion_point_99_or_below.txt | grep -v "Bin" | awk -F "," '($NF<0.99 && $NF>=0.75){print $0}'

for f in *_kaiju_output-GENERA.out ; do head -3 $f | grep -v "file" | awk -F "\t" '{print $2}' ; done

#!/bin/bash -e
printf "Bin\tUnclassified_or_viral_contigs_as_percent\tViral_contigs_as_percent\tMost_abundant_genus_as_percent\t2nd_most_abundant_genus_as_percent\tDifference_between_most_and_second_most_abundant_genera_as_percent\tContigs_in_bin" >> all_bins_genus_level_info_classified_unclassified_viral_most_and_second_most_abundant_contig_number.txt
for f in *_kaiju_output-GENERA.out
do
  nom=$(basename "$f" | awk -F "_" '{print $1"_"$2}' | sed 's/binned/Bin/g')
  unclassified_percent=$(tail -1 "$f" | awk -F "\t" '{print $2}')
  cannot_assign_to_non_viral_genus=$(tail -2 "$f" | head -1 | awk -F "\t" '{print $2}')
  viral_classification=$(tail -3 "$f" | head -1 | awk -F "\t" '{print $2}')
  unclassified_or_viral=$(echo "$unclassified_percent + $cannot_assign_to_non_viral_genus + $viral_classification" | bc -l | awk '{printf "%f", $0}')
  most_abundant_genus_percent=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $2}')
  second_mas_percent=$(head -3 "$f" | tail -1 | awk -F "\t" '{print $2}')
  diff_in_percent_mas_and_2nd_mas=$(echo "$most_abundant_genus_percent - $second_mas_percent" | bc -l | awk '{printf "%f", $0}')
  contig_count=$(cat "$f" | grep -v "file" | awk -F "\t" '{print $3}' | awk 'NF' | paste -sd+ - | bc -l)
  printf "\n$nom\t$unclassified_or_viral\t$viral_classification\t$most_abundant_genus_percent\t$second_mas_percent\t$diff_in_percent_mas_and_2nd_mas\t$contig_count" >> all_bins_genus_level_info_classified_unclassified_viral_most_and_second_most_abundant_contig_number.txt
done


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output

-----

13B_S2
Mapping Contigs Percent
High  104 89.655172413793103
Medium  10  8.620689655172414
Low 2 1.724137931034483

116 contigs in reference assembly

-----

cat 13B_S2.mapped.bam.perbase.cov.count| awk -F "," '($NF<0.99 && $NF>=0.75){print $0}'

printf "Sample\tContigs_in_assembly"
target=$(find -maxdepth 2 -type f -name "*_megahit_output.fa")
for f in $target
do
  nom=$(basename "$f" | awk -F "_R1_" '{print $1}')
  contig_count=$(grep -c ">" "$f")
  printf "\n$nom\t$contig_count"
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Kaiju_on_reads_output
16aD_S27_kaiju_output.Kaiju_2_table_output_GENERA.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output
39B_S15_kaiju_output-GENERA.tsv
printf "Sample\tPercent_reads_classified_as_old_Lactobacillus" && for f in *GENERA.txt ; do nom=$(basename "$f" | awk -F "_kaiju_output" '{print $1}') && lactobacillus_genus_count=$(grep "cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus" "$f" | awk -F "\t" '{print $2}') && printf "\n$nom\t$lactobacillus_genus_count" ; done

target=$(find -maxdepth 3 -type f -name "*kaiju_output-GENERA.tsv") && printf "Sample\tPercent_contigs_classified_as_old_Lactobacillus" && for f in $target ; do nom=$(basename "$f" | awk -F "_kaiju_output" '{print $1}') && lactobacillus_genus_count=$(grep "cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus" "$f" | awk -F "\t" '{print $2}') && printf "\n$nom\t$lactobacillus_genus_count" ; done

cat binned_c40_kaiju_output.out | awk '{if ($1 == "C") print $0}' |


for f in *kaiju_output.out ; do nom=$(basename "$f") && classified_contigs=$(cat "$f" | awk '{if ($1 == "C") print $0}' | wc -l) && printf "\n$nom\t$classified_contigs" ; done
#kaiju raw output only has unique contigs I think in it, which is good
for f in *kaiju_output.out ; do nom=$(basename "$f") && all_reads=$(cat "$f" | awk -F "\t" '{print $2}' | wc -l) && unique_reads=$(cat "$f" | awk -F "\t" '{print $2}' | sort -V | uniq | wc -l) && printf "\n$nom\t$all_reads\t$unique_reads" && if [ "$all_reads" = "$unique_reads" ] ; then printf "\tEQUAL" ; else printf "\tFAILED" ; fi ; done


while read -r line
do
  contig_name=$(printf "$line" | awk -F "\t" '{print $1}')
  taxid=$(printf "$line" | awk -F "\t" '{print $2}')
  #sci_name=$(cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '"$taxid"') print $0}' | grep "scientific name" | awk -F "\t" '{print $4}')
  sci_name=$(cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '"$taxid"') print $0}' | grep "scientific name" | awk -F "|" '{print $2}' | awk 'NF')
  printf "$contig_name\t$sci_name\t\n" >> all_kaiju_classified_contigs_scientific_name_all_taxonomic_levels.txt
done < Classified_by_Kaiju_contigs_across_all_bins_name_and_classified_TaxID.txt

/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp
awk '{if ($1 == '"$largest_TAXID"') print $0;}' | awk -F "\t" '{print $2}'
k141_12816749	171549	|	Bacteroidales	|		|	scientific name	|
printf "\nk141_12816749	171549	|	Bacteroidales	|		|	scientific name	|"


trial_array=(1 2 "three" 4 "the last number") && printf "\n${trial_array[3,0]}\n"
trial_array=(1 2 "three" 4 "the last number") && trial_variable="2" && printf "\n${trial_array[$trial_variable]}\n"
trial_array=(1 "blargfh" 3 4 5 6 7 8 "nine" 10 11) && for t in "${trial_array[@]}" ; do printf "\n$t\n" ; done
trial_array=(1 "blargfh" 3 4 5 6 7 8 "nine" 10 11) && for i in "${!trial_array[@]}" ; do echo "${trial_array[$i]}" ; done
trial_array=(1 2 3 4 5 6 7 8 9 10 11) && for i in "${!trial_array[@]}" ; do echo "${trial_array[$i]}" ; done

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/Kaiju_testing/binned_fastas_Kaiju_raw

target=$(find -maxdepth 3 -type f -name "final.contigs.fa") && for f in $target ; do realpath "$f" ; done

target=$(find -maxdepth 1 -type d -name "*_megahit_output") && for d in $target ; do basename "$d" && rm -r "$d" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing

TESTING_modified_mapping_and_output_processing_subsampled_reads_to_concatenated_bins_provide_paths_to_PE_input_files_on_command_line.sh

sbatch TESTING_modified_mapping_and_output_processing_subsampled_reads_to_concatenated_bins_provide_paths_to_PE_input_files_on_command_line.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing/10060-AR24J_Subsampled_R1.fastq.gz /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing/10060-AR24J_Subsampled_R2.fastq.gz
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing

for f in AC15N_Subsampled.mapped.bam.perbase.cov.coun* ; do nom=$(basename "$f") && path_to=$(readlink -f "$f" | sed "s@$nom@@g") && printf "\n$nom\n$path_to\n" ; done

sbatch TESTING_modified_mapping_and_output_processing_subsampled_reads_to_concatenated_bins_provide_paths_to_PE_input_files_on_command_line.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing/9458-AC15N_Subsampled_R1.fastq.gz /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing/9458-AC15N_Subsampled_R2.fastq.gz

#!/bin/bash -eE
trap "record_error" ERR
record_error () {
  printf "\nI failed because a variable was empty, reporting due to the trap\n"
}
zootaloors

targets=$(find -maxdepth 3 -type f -name "*R1_001_megahit_assembly.fa") && for f in $targets ; do readlink -f "$f" ; done

128196 times where it does map
132973 contigs total
4246 syntax errors

grep -v '\,.0' AC15N_Subsampled.mapped.bam.genomeproportion | grep -v '\,.[0-9]' | grep -v '\,1.' | wc -l #finds the syntax errors, which are contigs appearing here which apparently didn't map at all but have no numerical value

k141_8806410,

grep '[,]$' AC15N_Subsampled.mapped.bam.genomeproportion

[0-9]
grep -v '\,.0' AC15N_Subsampled.mapped.bam.genomeproportion | grep -v '\,.[0-9]' | grep -v '\,1.'
k141_4226219
k141_10777298
k141_359718
k141_3973226
k141_6602386

grep -v '\,.[0-9]' AC15N_Subsampled.mapped.bam.genomeproportion | grep -v '\,1.' | wc -l

k141_10778808,1.00000 2054 k141_10778808 Bin_c0.fa:>k141_10778808 flag=0 multi=2.8097 len=2054
k141_11755833,1.00000 2836 k141_11755833  >k141_11755833 flag=0 multi=67.4531 len=2836
k141_13389689,1.00000 2523 k141_13389689  >k141_13389689 flag=0 multi=90.0000 len=2523
k141_4286800,1.00000 2658 k141_4286800  >k141_4286800 flag=0 multi=90.0000 len=2658

128727 + 4246

awk -F "," '($NF>=0.99 && $NF<1.00){print $0}' AC15N_Subsampled.mapped.bam.genomeproportion

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}

trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR


target=$(find -maxdepth 2 -type f -name "*_kaiju_output-SPECIES.tsv") && for f in $target ; do cp "$f" /hpc-home/osbourne/LAC_Cultures_BWA_assembly_counts_and_proportions ; done

grep "len" 13A_S1_R1_001_megahit_assembly.fa | awk -F "len=" '{print $2}' | sort -V | paste -sd+ - | bc -l

contig_list=$(grep "Lactobacillus reuteri" 18E_S13_kaiju_output.names_added.out | awk -F "\t" '{print $2}' | paste -sd " " -) && contig_array=("$contig_list") && echo ${contig_array[*]}
k145_74

#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

printf "Sample\tMAS\tTotal_contigs\tTotal_bases\tTotal_contigs_classified_as_MAS\tPercent_bases_in_longest_contigs\tPercent_bases_in_MAS_contigs\tOver_50_percent_bases_in_longest_contig\tOver_50_percent_bases_in_MAS_contigs\n"
target=$(find -maxdepth 3 -type f -name "*001_megahit_assembly.fa")
for f in $target
do
  locale=$(pwd)
  assembly_file="$f"
  sample_name=$(basename "$f" | awk -F "_R1" '{print $1}')
  total_contigs=$(grep 'len' "$f" | wc -l)
  species_file=$(find -maxdepth 4 -type f -name "*$sample_name*" -name "*kaiju_output-SPECIES.tsv")
  most_common_species_classification=$(head -2 "$species_file" | tail -1 | rev | awk -F ";" '{print $2}' | rev)
  most_common_species_taxid=$(head -2 "$species_file" | tail -1 | awk -F "\t" '{print $4}')
  total_contigs_classified_as_most_common_species=$(head -2 "$species_file" | tail -1 | awk -F "\t" '{print $3}')
  total_bases=$(grep 'len' "$f" | awk -F "len=" '{print $2}' | sort -V | paste -sd+ - | bc -l)
  longest_contig_length=$(grep 'len' "$f" | awk -F "len=" '{print $2}' | sort -V | tail -1)
  kaiju_output_file_with_names_added=$(find -maxdepth 4 -type f -name "*$sample_name*" -name "*kaiju_output.names_added.out")
  contigs_classified_as_most_common_species=$(grep "$most_common_species_classification" "$kaiju_output_file_with_names_added" | awk -F "\t" '{print $2}')
  printf "$contigs_classified_as_most_common_species" >> "$locale/TEMP_${sample_name}_most_abundant_species_contigs.txt"
  #printf "\nHere are the contigs classified as most abundant:\t$contigs_classified_as_most_common_species\n"
  while IFS= read -r line
  do
    #grep "$line" $assembly_file | awk -F "len=" '{print $2}' >> "TEMP_${sample_name}_MAS_contigs_lengths.txt"
    contig_length=$(grep -w "$line" "$assembly_file" | awk -F "len=" '{print $2}')
    printf "$contig_length\n" >> "$locale/TEMP_${sample_name}_MAS_contigs_lengths.txt"
    #printf "\n$line is this long:\t$contig_length\n"
    #grep "$line" $f | awk -F "len=" '{print $2}' >> "TEMP_${sample_name}_MAS_contigs_lengths.txt"
  done < "$locale/TEMP_${sample_name}_most_abundant_species_contigs.txt"
  bases_in_contigs_classified_as_most_abundant=$(cat "$locale/TEMP_${sample_name}_MAS_contigs_lengths.txt" | paste -sd+ - | bc -l)
  #printf "\nThere are this many bases in the MAS contigs:\t$bases_in_contigs_classified_as_most_abundant\n"
  percent_bases_in_longest_contig=$(echo "($longest_contig_length / $total_bases) * 100" | bc -l)
  percent_bases_in_MAS_contigs=$(echo "($bases_in_contigs_classified_as_most_abundant / $total_bases) * 100" | bc -l)
  if (( $(echo "$percent_bases_in_longest_contig >= 50" | bc -l) ))
  then
    export longest_contig_over_50_percent_bases_check="Y"
  else
    export longest_contig_over_50_percent_bases_check="N"
  fi
  if (( $(echo "$percent_bases_in_MAS_contigs >= 50" | bc -l) ))
  then
    export MAS_contigs_over_50_percent_bases_check="Y"
  else
    export MAS_contigs_over_50_percent_bases_check="N"
  fi
  printf "$sample_name\t$most_common_species_classification\t$total_contigs\t$total_bases\t$total_contigs_classified_as_most_common_species\t$percent_bases_in_longest_contig\t$percent_bases_in_MAS_contigs\t$longest_contig_over_50_percent_bases_check\t$MAS_contigs_over_50_percent_bases_check\n"
  rm "$locale/TEMP_${sample_name}_most_abundant_species_contigs.txt" || echo
  rm "$locale/TEMP_${sample_name}_MAS_contigs_lengths.txt" || echo
done

target=$(find -maxdepth 6 -type f -name "*kaiju_output.names_added.out") && for f in $target ; do cp "$f" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/BWA_outputs && printf "\nCopied file:$f\n" ; done
k145_99 13A_S1_kaiju_output.names_added.out

#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  rm "TEMP_${label}_absolute_confidence_contigs.txt"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

for f in *absolute_confidence_mapping.txt
do
  label=$(basename "$f" | awk -F "_absolute" '{print $1}') || echo "Skip fail"
  cat "$f" | awk -F "\t" '{print $1}' >> "TEMP_${label}_absolute_confidence_contigs.txt" || echo "Skip fail"
  relevant_kaiju_file=$(find -maxdepth 1 -type f -name "*$label*" -name "*.names_added.out") || echo "Skip fail"
  relevant_assembly_file=$(find -maxdepth 1 -type f -name "*$label*" -name "*Megahit_assembly_for_mapping_reference.fa.gz") || echo "Skip fail"
  total_bases_in_assembly=$(zcat "$relevant_assembly_file" | grep 'len' | awk -F "len=" '{print $2}' | paste -sd+ - | bc -l) || echo "Skip fail"
  printf "Contig\tConfidence\tSpecies_of_contig_from_Kaiju\tContig_length\tPercent_assebly_bases_in_contig" >> "${label}_absolute_contigs_confidence_and_species.txt" || echo "Skip fail"
  while read -r line
  do
    contig_name="$line" || echo "Skip fail"
    contig_confidence_mapping=$(grep -w "$line" "$f" | awk -F "," '{print $2}') || echo "Skip fail"
    contig_length=$(zcat "$relevant_assembly_file" | grep -w ">$line" | awk -F "len=" '{print $2}') || echo "Skip fail"
    contig_species=$(grep -w "$line" "$relevant_kaiju_file" | rev | awk -F ";" '{print $2}' | rev) || echo "Skip fail"
    contig_percent_assembly_bases=$(echo "($contig_length / $total_bases_in_assembly) * 100" | bc -l | awk '{printf "%f", $0}') || echo "Skip fail"
    if [ -z "$contig_species" ]
    then
      contig_species="Unclassified" || echo "Skip fail"
      printf "\n$contig_name\t$contig_confidence_mapping\t$contig_species\t$contig_length\t$contig_percent_assembly_bases" >> "${label}_absolute_contigs_confidence_and_species.txt" || echo "Skip fail"
    else
      if [ "$contig_species" = "NA" ]
      then
        contig_species2=$(grep -w "$line" "$relevant_kaiju_file" | rev | awk -F ";" '{print $3}' | rev | sed 's/^[[:space:]]*//')
        printf "\n$contig_name\t$contig_confidence_mapping\t$contig_species2\t$contig_length\t$contig_percent_assembly_bases" >> "${label}_absolute_contigs_confidence_and_species.txt" || echo "Skip fail"
      else
        printf "\n$contig_name\t$contig_confidence_mapping\t$contig_species\t$contig_length\t$contig_percent_assembly_bases" >> "${label}_absolute_contigs_confidence_and_species.txt" || echo "Skip fail"
      fi
    printf "\n$contig_name\t$contig_confidence_mapping\t$contig_species\t$contig_length\t$contig_percent_assembly_bases"
    fi
  done < "TEMP_${label}_absolute_confidence_contigs.txt" || echo "Skip fail"
  rm "TEMP_${label}_absolute_confidence_contigs.txt" || echo "Skip fail"
done

k145_90

16bB_S20

16bC_S21
k145_4


AC6J needs rerun
AC16J needs rerun

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch

sbatch V2_TESTING_modified_mapping_and_output_processing_subsampled_reads_to_concatenated_bins_provide_paths_to_PE_input_files_on_command_line.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing/12684-AC16J_Subsampled_R1.fastq.gz /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing/12684-AC16J_Subsampled_R2.fastq.gz

for i in {1..60} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && sleep 2m && printf "\n-_-_-_-_-_-_-" ; done

samtools idxstats AC6J_Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only.bam | sort -Vr -k3 > AC6J_Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only.bam_sorted.txt

for f in *Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only.bam ; do label=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && hits=$(grep -c 'k141_14366499' "$f") && printf "\n$label\t$hits\n" ; done

for f in *Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only.bam ;
k141_14366499

samtools idxstats AR41N_Subsampled_BWA_reads_mapped_to_assembly_SECONDARY_alignments_only.bam | sort -V -k 3 | awk -F "\t" '{if ($3 == '0') print $0;}'

#!/bin/bash -e
source package /tgac/software/testing/bin/samtools-1.10
targets=$(find -maxdepth 1 -type f -name "*Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only.bam")
for f in $targets
do
  out_name=$(basename "$f" | awk -F ".bam" '{print $1}')
  samtools idxstats "$f" > "${out_name}_idxstats.txt"
done

133074 contigs in concatenated bins file
6357 unique taxids in concatenated bins file

k141_11123955

k141_8947455

head -n -1 AC16J_Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only_idxstats.txt | awk -F "\t" '{print $1"\t"$3}' | sort -V -r -k1 >> trial_1.txt
head -n -1 AC16N_Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only_idxstats.txt | awk -F "\t" '{print $1"\t"$3}' | sort -V -r -k1 >> trial_2.txt

cat AR38J_TEMP_sorted_contig_mapping_counts.txt | awk -F "\t" '{print $1}' | paste -sd"\t" - >> contigs_as_columns_sorted.txt

for f in *TEMP_sorted_contig_mapping_counts.txt ; do mappings=$(cat "$f" | awk -F "\t" '{print $2}' | paste -sd"\t") && printf "\n$mappings" >> contigs_as_columns_sorted.txt ; done
cat AR38J_TEMP_sorted_contig_mapping_counts.txt | awk -F "\t" '{print $2}' | paste -sd"\t"

kaiju on concatenated all contigs all bins fasta:
98% classified with default (65) match score
96% classified with 85 match score
94% classified with 100 match score
100% classified with 25 match score

Default match score:
132973 contigs
1669 unclassified
1669 unique taxa identified

cat Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_names_added.txt | awk -F "\t" '{print $2"\t"$5"\t"$8}' | sed 's/,//g' | awk 'NF' >> all_contigs_taxid_and_assigned_taxon.txt


k141_14366499	1897040	Bacteroidales bacterium 52_46

/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp

sbatch Eggnog_mapper_basic_script_test.sh 13A_S1_R1_001_megahit_assembly.fa

awk -F "\t" '{if ($3 == '0') print $0;}'

sed 's/\t/\tUnclassified at any level/g'

1669

cat Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_names_added.txt | awk -F "\t" '{print $2"\t"$8}' | sed 's/\t$/\tUnclassified at any level/g' | sort -V -k1

while IFS= read -r line
do
  taxon_occurences=$(grep -wFc "$taxon" Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified.txt)
  printf "\n$taxon\t$taxon_occurences"
done < Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Unique_taxons_only_list.txt


grep -wE "^Bacteria" Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Taxons_and_contigs_matching_them.txt | grep -P "Bacteria\t"

#!/bin/bash -e
while IFS= read -r line
do
  taxon="$line"
  contigs=$(grep -wE "$taxon$" Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified.txt | awk -F "\t" '{print $1}' | paste -sd"\t" -)
  printf "$taxon\t$contigs\n"
done < Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Unique_taxons_only_list.txt

# taxon="Bacteria" && contigs=$(grep -wE "$taxon$" Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified.txt | awk -F "\t" '{print $1}' | paste -sd"\t" -) && printf "\n$taxon\t$contigs\n"
#
# '(^|\s)\Bacteroides(?=\s|$)'
#
# grep -P 'Bacteroides(?=\s|$)' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified.txt
#
# taxon="Bacteria" && letter_count=$(echo "$taxon" | wc -c) && grep -F "$taxon" Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_TAXONS_first_then_contigs_tab_delimited.txt | awk -F "\t" '{print $1}' | wc -c
# awk '$1==\ABacteria\z' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified.txt
#
# awk '$4 ~ /\/foo$/ { print $1 }'
# awk '$1 ~ /Bacteria$/' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_TAXONS_first_then_contigs_tab_delimited.txt
# awk '$1 ~ Bacteria\t' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_TAXONS_first_then_contigs_tab_delimited.txt
#
# awk '$1 == Bacteria\t {print $0}' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_TAXONS_first_then_contigs_tab_delimited.txt
# /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch
#
# sed -n 's/$/@@@/' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified.txt
# awk '$1 ~ /Bacteria$/' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified.txt
# grep -E '(^|\s)bacterium@@@' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_TRIPLE_AT_SIGN_LINE_ENDING_CONTIGS_FIRST.txt
# grep -E '(^|\t)bacterium@@@' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_TRIPLE_AT_SIGN_LINE_ENDING_CONTIGS_FIRST.txt
# grep $'\t''bacterium@@@' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_TRIPLE_AT_SIGN_LINE_ENDING_CONTIGS_FIRST.txt
# sed 's/$/@@@/g' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified.txt >> Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_TRIPLE_AT_SIGN_LINE_ENDING_CONTIGS_FIRST.txt
#
# grep $'\t'' [Eubacterium] sulci@@@' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_TRIPLE_AT_SIGN_LINE_ENDING_CONTIGS_FIRST.txt
# cat Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified.txt | tr -d "(){}[]"
#
# grep '(^|\s)Eubacterium$' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_ALL_BRACKETS_REMOVED.txt
#
# sed 's/\t/@@@@/g' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_Kaiju_output_default_match_score_Contigs_and_taxons_including_completely_unclassified_ALL_BRACKETS_REMOVED.txt | grep -E '@@@@Eubacterium$'

target=$(head -3 only_unique_taxons_brackets_stripped.txt | tail -1) && grep "@@@@$target"'$' 4AT_sign_delimited_all_contigs_all_taxons_contigs_first.txt | awk -F "@@@@" '{print $1}' | paste -sd"\t" -
#!/bin/bash -e
while IFS= read -r line
do
  taxon="$line"
  contigs=$(grep "@@@@$taxon"'$' 4AT_sign_delimited_all_contigs_all_taxons_contigs_first.txt | awk -F "@@@@" '{print $1}' | paste -sd"\t" -)
  printf "\n$taxon\t$contigs"
done < only_unique_taxons_brackets_stripped.txt

head -1 all_contigs_all_samples_mapping_should_have_right_count_for_each_contig.txt | sed $'s/\t/\\\n/g' | grep -F 'N'

#!/bin/bash -e

while IFS= read -r line
do
  label=$()
  contig=$(echo "$line" | awk -F "\t" '{print $1}' | awk 'NF')
  number_mapped_read_segments=$(echo "$line" | awk -F "\t" '{print $3}' | awk 'NF')
  taxon=$(grep -Fw "$contig" TRIAL_output_taxons_and_all_matching_contigs.txt | awk -F "\t" '{print $1}')
  printf "$taxon\t$number_mapped_read_segments\n"
done < AC7N_Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only_idxstats.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch

#!/bin/bash -eE
#SBATCH -t 04-12:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J TaxCollect
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only_idxstats.txt")
for f in $target
do
  export outflow=$(basename "$f" | awk -F "_" '{print $1"_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt"}')
  while IFS= read -r line
  do
    taxon="$line"
    count=$(grep -F "$line" AR10J_subsampled_BWA_mapped_primary_alignments_only_idxstats_contig_to_taxon_conversion.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
    printf "$taxon\t$count\n" | sort -V -k1
  done < all_unique_taxons_brackets_removed_from_names.txt > "$outflow"
  printf "\nWorked through input file:\t$f\n"
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Primary_alignment_files


#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

tax_list=$(cat all_unique_taxons_brackets_removed_from_names.txt | paste -sd"," -)
printf "Sample,$tax_list" >> taxons_as_columns.csv
target=$(find -maxdepth 1 -type f -name "*subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt")
for f in $target
do
  sample=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  tax_mapping=$(cat "$f" | awk -F "\t" '{print $2}' | paste -sd",")
  printf "\n$sample,$tax_mapping" >> taxons_as_columns.csv
  printf "\nWorked through file:\t$f\n"
done



#!/bin/bash -eE
#SBATCH -t 04-12:30
#SBATCH -p ei-medium
#SBATCH -c 4
#SBATCH -J TaxCollect
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*subsampled_BWA_mapped_primary_alignments_only_idxstats_contig_to_taxon_conversion.txt")
for f in $target
do
  export outflow=$(basename "$f" | awk -F "_" '{print $1"_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt"}')
  while IFS= read -r line
  do
    taxon="$line"
    count=$(grep -F "$line" "$f" | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
    printf "$taxon\t$count\n" >> "$outflow"
  done < all_unique_taxons_brackets_removed_from_names.txt
  printf "\nWorked through input file:\t$f\n"
done

export inpf1=$1
export output=$2
while IFS= read -r line
do
  taxon="$line"
  count=$(grep -F "$line" "$inpf1" | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  printf "$taxon\t$count\n" >> "$output"
done < all_unique_taxons_brackets_removed_from_names.txt
printf "\nWorked through input file:\t$inpf1\n"


target=$(find -maxdepth 1 -type f -name "*subsampled_BWA_mapped_primary_alignments_only_idxstats_contig_to_taxon_conversion.txt") && for f in $target ; do outflow=$(basename "$f" | awk -F "_" '{print $1"_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt"}') && sbatch slurmy_collecting_taxon_counts.sh "$f" "$outflow" && printf "\nSubmitted job on file:\t$f\n" && sleep 1.5s ; done


#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR
list_taxons=$(cat AC11J_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt | awk -F "\t" '{print $1}' | paste -sd"," -)
printf "Samples,$list_taxons"
for f in *subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt
do
  sample_name=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  contig_counts=$(cat "$f" | awk -F "\t" '{print $2}' | paste -sd"," -)
  printf "\n$sample_name,$contig_counts"
done


target=$(find -maxdepth 1 -type f -name "*subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt") && for f in $target ; do sampleID=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && counts=$(cat "$f" | awk -F "\t" '{print $2}') && printf "$sampleID\n$counts\n" >> "${sampleID}_sample_ID_header_counts_single_column.txt" ; done


AC5J_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt
AC5J_subsampled_sample_ID_header_counts_single_column.txt

paste -d ',' taxons_as_rows_just_taxons.txt *subsampled_sample_ID_header_counts_single_column.txt

#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

printf "Taxa\tAC_total_count\tAR_total_count" >> total_counts_each_taxon_all_samples_per_host_species.txt

while IFS= read -r line
do
  taxon="$line"
  total_count_AR=$(grep -F "$taxon" AR*_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  total_count_AC=$(grep -F "$taxon" AC*_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  printf "\n$taxon\t$total_count_AC\t$total_count_AR" >> total_counts_each_taxon_all_samples_per_host_species.txt
done < all_unique_taxons_brackets_removed_from_names.txt

#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

printf "Taxa\tJune_total_count\tNovember_total_count" >> total_counts_each_taxon_all_samples_per_season.txt

while IFS= read -r line
do
  taxon="$line"
  total_count_June=$(grep -F "$taxon" *J_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  total_count_November=$(grep -F "$taxon" *N_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  printf "\n$taxon\t$total_count_June\t$total_count_November" >> total_counts_each_taxon_all_samples_per_season.txt
done < all_unique_taxons_brackets_removed_from_names.txt


#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

printf "Taxa\tAC_June_total_count\tAC_November_total_count\tAR_June_total_count\tAR_November_total_count" >> total_counts_each_taxon_all_samples_per_host_and_season.txt

while IFS= read -r line
do
  taxon="$line"
  total_count_AC_June=$(grep -F "$taxon" AC*J_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  total_count_AC_Nov=$(grep -F "$taxon" AC*N_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  total_count_AR_June=$(grep -F "$taxon" AR*J_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  total_count_AR_Nov=$(grep -F "$taxon" AR*N_subsampled_BWA_mapped_primary_alignments_only_idxstats_collected_taxon_counts.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l)
  printf "\n$taxon\t$total_count_AC_June\t$total_count_AC_Nov\t$total_count_AR_June\t$total_count_AR_Nov" >> total_counts_each_taxon_all_samples_per_host_and_season.txt
done < all_unique_taxons_brackets_removed_from_names.txt

target=$(find -maxdepth 3 -type f -name "*eggnog_mapper_output.emapper.*") && for f in $target ; do printf "\n$f\n" && rm "$f" && printf "\nRemoved file:\t$f\n" ; done

target=$(find -maxdepth 4 -type f -name "*kaiju_output-SPECIES.tsv") && for f in $target ; do sample=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && species=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $5}' | rev | awk -F ";" '{print $2}' | rev) && printf "\n$sample\t$species" ; done >> Most_common_species_by_Kaiju.txt

to download
Bifidobacterium_pseudolongum.fna.gz  https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/282/915/GCF_002282915.1_ASM228291v1/GCF_002282915.1_ASM228291v1_genomic.fna.gz
Lactobacillus_helveticus.fna.gz  https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/849/915/GCF_002849915.1_ASM284991v1/GCF_002849915.1_ASM284991v1_genomic.fna.gz
Lactobacillus_kefiranofaciens.fna.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/656/585/GCF_014656585.1_ASM1465658v1/GCF_014656585.1_ASM1465658v1_genomic.fna.gz
Lactobacillus_murinus.fna.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/436/015/GCF_001436015.1_ASM143601v1/GCF_001436015.1_ASM143601v1_genomic.fna.gz
Lactobacillus_pontis.fna.gz  https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/428/965/GCF_009428965.1_ASM942896v1/GCF_009428965.1_ASM942896v1_genomic.fna.gz
Lactobacillus_reuteri.fna.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/015/377/805/GCF_015377805.1_ASM1537780v1/GCF_015377805.1_ASM1537780v1_genomic.fna.gz
Lactobacillus_rhamnosus.fna.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/848/015/GCF_002848015.1_ASM284801v1/GCF_002848015.1_ASM284801v1_genomic.fna.gz
Lactobacillus_vaginalis.fna.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/009/362/935/GCF_009362935.1_ASM936293v1/GCF_009362935.1_ASM936293v1_genomic.fna.gz
Pediococcus_pentosaceus.fna.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/014/505/GCF_000014505.1_ASM1450v1/GCF_000014505.1_ASM1450v1_genomic.fna.gz

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reference_genomes_to_map_to

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done


grep 'len' Fri_19_Feb_2021_BWA_INDEX_CONCATENATED_FASTA_FILES.fa | awk -F " " '{print $1"\t"$4}' | sed 's/>//g' | sed 's/len=//g' | sort -V -k1 >> contigs_and_their_lengths.txt

#!/bin/bash -eE
#SBATCH -t 00-01:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Kilobase_map_count_adjustment
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

for f in *Subsampled_BWA_reads_mapped_to_assembly_PRIMARY_alignments_only_idxstats.txt
do
  sample=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  while IFS= read -r line
  do
    contig=$(echo "$line" | awk -F "\t" '{print $1}')
    length=$(echo "$line" | awk -F "\t" '{print $2}')
    count=$(grep -wF "$contig" "$f" | awk -F "\t" '{print $3}')
    modified_length=$(echo "$length / 1000" | bc -l)
    kilobase_adjusted_map_count=$(echo "$count / $modified_length" | bc -l)
    printf "$contig\t$kilobase_adjusted_map_count\n" >> "${sample}_kilobase_adjusted_contig_mapping_scores.txt"
  done < contigs_and_their_lengths.txt
done


mv *Subsampled_BWA_reads_mapped_to_assembly_NEO_exclude_flags_2304_alignments_only.bam Neo_primary_alignments_avoid_flags_256_AND_248

#!/bin/bash -eE
#SBATCH -t 00-04:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Kilobase_map_count_adjustment
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR
source package /tgac/software/testing/bin/samtools-1.10

for f in *Subsampled_BWA_reads_mapped_to_assembly_NEO_exclude_flags_2304_alignments_only.bam ; do nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && samtools idxstats "$f" > "${nome}_idxstats.txt" && printf "\nWorked through file $f\n" && sleep 2s ; done


#!/bin/bash -eE
#SBATCH -t 00-14:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J Kilobase_map_count_adjustment
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR
source package /tgac/software/testing/bin/samtools-1.10
for f in *.bam
do
  locale=$(pwd)
  refgenomename=$(basename "$f" | awk -F "_" '{print $5"_"$6}' | awk -F "." '{print $1}')
  cd ..
  refgenomeNOTE=$(find -maxdepth 3 -type f -name "$refgenomename*" -name "*.fna" -not -name "*.fna.*")
  refgenomePATH=$(realpath "$refgenomeNOTE")
  cd "$locale"
  lobel=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  whenitbe=$(date | awk -F " " '{print $1"_"$2"_"$3"_"$6}')
  label=$(printf "${lobel}_${whenitbe}")
  samtools view -h -@ 2 -F 2304 -o "${label}_excluding_reads_flagged_to_2304.bam" "$f"
  samtools sort -@ 2 -O BAM -l 0 -m 14G "${label}_excluding_reads_flagged_to_2304.bam" -o "${label}_excluding_reads_flagged_to_2304_sorted.bam"
  samtools index -b -@ 2 "${label}_excluding_reads_flagged_to_2304_sorted.bam" "${label}_excluding_reads_flagged_to_2304_INDEXED"
  samtools idxstats -@2 "${label}_excluding_reads_flagged_to_2304_sorted.bam" > "${label}_excluding_reads_flagged_to_2304_sorted.bam.idxstats.txt"
done


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Assemblies


grep -P '(^|\s)\Kk141_65(?=\s|$)'
grep "\b"
awk '\tk141_65\t' < taxons_and_their_contigs.txt
grep "k141_65 $(printf '\t')" < taxons_and_their_contigs.txt

grep -F $'\tk141_65\t' taxons_and_their_contigs.txt

sed -i $'s/\t/@/g'

grep 'k141_65\>'

grep 'Bacteroidales[[:cntrl:]]*$'


#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

while read -r line
do
  taxon=$(printf "$line")
  contigs=$(grep "$line[[:cntrl:]]*$" SAFEGUARD.V2_all_kaiju_classified_contigs_scientific_name_all_taxonomic_levels.txt.SAFEGUARD | awk -F "\t" '{print $1}' | paste -sd, -)
  printf "\n$taxon\t$contigs" >> taxa_and_their_contigs_comma_separated_contig_only_unique_taxons_from_all_classified_contigs_across_all_bins.txt
done < only_unique_taxons_from_all_classified_contigs_across_all_bins.txt

cat SAFEGUARD.V2_all_kaiju_classified_contigs_scientific_name_all_taxonomic_levels.txt.SAFEGUARD | awk -F "\t" '{print $1"\t"$3}' >> all_contigs_taxon_or_unclassified.txt && cat Unclassified_by_Kaiju_contigs_across_all_bins.txt | sed 's/$/\tUnclassified/g' >> all_contigs_taxon_or_unclassified.txt

k141_9137563		Terrabacteria group
k141_13537227	Unclassified

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Primary_alignment_files

./AC5N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

grep 'Abditibacterium utsteinense' all_contigs_taxon_or_unclassified.txt

grep 'k141_4896423' AC5N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

all_contigs_taxon_or_unclassified.square_and_curly_brackets_removed.txt
all_unique_taxons_incluing_unclassified_from_all_contigs_across_all_bins_list.square_and_curly_brackets_removed.txt
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885


#!/bin/bash -eE
#SBATCH -t 07-00:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J Prokka
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Getting the software
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885

#Set u for fail if unset variables
set -u

export LOCALE=$(pwd) && printf "\nLOCALE is:\t$LOCALE\n"
export TARGETS=$(find -maxdepth 3 -type f -name "*megahit_assembly.fa")
for f in $TARGETS
do
  export INPF1=$(basename "$f")
  export LOCATION=$(dirname "$f" | awk -F "./" '{print $2}')
  export LABEL=$(basename "$INPF1" | awk -F "_R1" '{print $1}')
  cd "$LOCATION"
  printf "\nWill run file:\t$INPF1\nThrough Prokka\n"
  #Note that the --metagenome flag is for highly fragmented genomes apparently so might not be the right call here but trying it anyway
  prokka --outdir "${LOCATION}/Prokka" --prefix "${LABEL}_prokka_output" --cpus 2 --kingdom 'Bacteria' --metagenome "$INPF1" || printf "\n$INPF1\tWouldn't have worked as it is one of the empty files you didn't bother filtering out\n"
  cd "$LOCALE"
done


target=$(find -maxdepth 5 -type f -name "*prokka_output*") && for f in $target ; do cp "$f" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output/Prokka_predicted_gene_fasta_files ; done

ANKMAENP_00490
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Megahit_output/Prokka_predicted_gene_fasta_files

13B_S2_prokka_output.faa
IFHMNJLB_00847
sed '/\>IFHMNJLB_00847/,/\>IFHMNJLB_00848/p' 13B_S2_prokka_output.faa

MIITIITFIIVFGILVLVHEYGHYYFAKRAGILVREFSIGMGPKIWWKRKNGTTYTIRIL
PLGGYVRLAGADDEDQDELKPGTPLTIQLNDHDQVTSINASDKTTLFQGIPLQLVACDLE
NDLWIKGYVNGDENELKVYQVDHDAMIIERDGTEVQIAPRDVQFRSASLPARMMTNFAGP
MNNFILSLLVFIILGFTLPGVPTNSNQLGEVKAGSVAAQAGLVAGDRIIKVNQQRVNNWT
DLSTTISSKPGKQVMVTYKRDSQVHRTKLTPKAVERGHQKVGQIGIIEQQQTSMAARINF
GWQQFVQAGTLIFSVLGHMFTHGFSLNDLGGPVAIYAGTSQATSLGINGVLNFLALLSIN
LGIVNLLPIPALDGGKLLLNIIEAIIRRPIPEKAEGIVTMIGFLILLTLMVLVTWNDIQR
YFIR

tr '\n'
tr '\n' ','
sed '/\^>/,/\^>/' 13B_S2_prokka_output.faa
sed -E "/\^>/,/\^>/" 13B_S2_prokka_output.faa

awk '/>/,/>/' 13B_S2_prokka_output.faa
awk '/>/{a=1}/>/{print;a=0}a' 13B_S2_prokka_output.faa

awk '/IFHMNJLB_02308/{a=1}/IFHMNJLB_02309/{print;a=0}a' 13B_S2_prokka_output.faa
awk '/IFHMNJLB_02268/{a=1}/IFHMNJLB_02269/{print;a=0}a' 13B_S2_prokka_output.faa | sed \$d

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304


target=$(find -maxdepth 4 -type f -name "*AC18N_Subsampled_R1.fastq.gz") && for f in "$target" ; do zcat "$f" | grep -c '@' ; done

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

13A_S1 megahit assembly most common kaiju species is Lactobacillus_kefiranofaciens
https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/656/585/GCF_014656585.1_ASM1465658v1/GCF_014656585.1_ASM1465658v1_genomic.gff.gz

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Liftoff

ruby -rcsv -e 'puts CSV.parse(STDIN).transpose.map &:to_csv' < kilobase_and_library_size_adjusted_samtools_idxstats_results_all_samples_excluding_pilot.csv > TRANSPOSED_kilobase_and_library_size_adjusted_samtools_idxstats_results_all_samples_excluding_pilot.csv

first_row=$(cat First_row_unqiue_taxons.csv) && printf "$first_row\n" >> bash_made_transposed_csv_excluding_pilot_samples.csv && for f in TRANSPOSED_Collected_results_table_10_May_2021_*_collected_taxon_scores.txt.only_counts_same_order_as_initial_file.txt.csv ; do therow=$(cat "$f") && printf "$therow\n" >> bash_made_transposed_csv_excluding_pilot_samples.csv ; done

for f in Collected_results_table_12_May_2021_*_collected_taxon_scores.txt ; do sampleid=$(head -1 "$f" | awk -F "\t" '{print $2}' | awk 'NF') && cat "$f" | awk -F "\t" '{print $2}' >> "${sampleid}_pilot_sample_single_column_counts_only_same_order.txt" ; done

grep "Absicoccus porci[[:cntrl:]]*$" all_contigs_taxon_or_unclassified.square_and_curly_brackets_removed.txt

while read -r line ; do taxon=$(echo "$line") && contig_collection=$(grep "$line[[:cntrl:]]*$" all_contigs_taxon_or_unclassified.square_and_curly_brackets_removed.txt | awk -F "\t" '{print $1}' | tr "\n" "," | sed 's/,$/\n/') && printf "\n$taxon\t$contig_collection" >> 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt ; done < 2021_05_21_unique_taxons_list_square_and_curly_brackets_removed.txt
while read -r line ; do taxon=$(echo "$line") && contig_collection=$(grep "$line[[:cntrl:]]*$" all_contigs_taxon_or_unclassified.square_and_curly_brackets_removed.txt | awk -F "\t" '{print $1}' | tr "\n" "," | sed 's/,$/\n/') && printf "\n$taxon\t$contig_collection" ; done < 2021_05_21_unique_taxons_list_square_and_curly_brackets_removed.txt

sed -i 's/.$/X/' filename
grep "Absicoccus porci[[:cntrl:]]*$" all_contigs_taxon_or_unclassified.square_and_curly_brackets_removed.txt | awk -F "\t" '{print $1}' | tr "\n" "," | sed 's/,$/\n/'

k141_14238530

taxon="Bacteroidales bacterium 55_9" && contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," "\n") && echo "$contigs"

taxon="bacterium" && contigs=grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," "\n") && echo "$contigs"

taxon="bacterium" && contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," "\n") && summed_scores=$(grep "$contigs" AR46N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt | awk -F "\t" '{print $2}' | paste -sd+ - | bc -l) && echo "$summed_scores"

taxon="bacterium" && contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," "\n") && IFS="\n" read -a contigs_array <<< $contigs && for i "${contigs_array[@]}" ; do contiger=$(echo "$i") && score=$(grep "$contiger" AR46N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt | awk -F "\t" '{print $2}') && printf "$contiger\t$score" ; done
taxon="bacterium" && contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}') && IFS="," read -a contigs_array <<< $contigs && for i ${contigs_array[@]} ; do contiger=$(echo "$i") && score=$(grep "$contiger" AR46N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt | awk -F "\t" '{print $2}') && printf "$contiger\t$score" ; done

taxon="bacterium" && contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | paste -sd"\n" | tr "," "\n") && contigs_array=(`echo ${contigs}` | tr "\n" " "); && for i "${contigs_array[@]}" ; do contiger=$(echo "$i") && score=$(grep "$contiger" AR46N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt | awk -F "\t" '{print $2}') ; done

taxon="bacterium" && contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," " " | tr "\n" " ") && echo "$contigs" && contigs_array=(`echo ${contigs}`) && for i "${contigs_array[@]}" ; do contiger=$(echo "$i") && score=$(grep "$contiger" AR46N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt | awk -F "\t" '{print $2}') ; done

taxon="bacterium" && contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," " " | tr "\n" " ") && echo "$contigs" && contigs_array=(`echo ${contigs}`) && echo "My array: ${contigs_array[@]}"

taxon="bacterium" && contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," " ") && declare -a arr=( $contigs ) && while IFS=' ' do ; for i in "${arr[*]}" ; do printf "\nHere is a contig:\t$i\n" ; done ; done

#!/bin/bash -eE
#SBATCH -t 00-00:25
#SBATCH -p ei-short
#SBATCH -c 1
#SBATCH -J excess_names_array_test
#SBATCH --mem=4gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

taxon="bacterium"
contigs=$(grep "${taxon}@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," "\n" | sort -V | uniq | tr "\n" " ")
IFS=" " read -a contig_array <<< $contigs
while IFS=" " read -ra contig_array
do
  for i in "${contig_array[@]}"
  do
    contiger=$(echo "$i")
    score=$(grep -w "$contiger" AR46N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt | awk -F "\t" '{print $2}' | awk '{printf "%f", $0}')
    printf "$contiger\t$score\n" >> TEMP_ARRAY_TESTING_FILE.txt
  done
done <<< "$contigs"
#summed_score=$(cat TEMP_ARRAY_TESTING_FILE.txt | paste -s -d+ - | bc -l)
summed_score=$(cat TEMP_ARRAY_TESTING_FILE.txt | awk -F "\t" '{print $2}' | awk 'NF' | paste -s -d+ - | bc -l)
printf "$taxon\t$summed_score\n"
mail -s "Hopeful output" peter.osborne@earlham.ac.uk <<< "This will hopefully be a number:  $summed_score"
#rm TEMP_ARRAY_TESTING_FILE.txt

awk '{s+=$1} END {printf "%.0f", s}' TEMP_ARRAY_TESTING_FILE.txt

grep "bacterium@" 2021_12_05_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs.txt | awk -F "@" '{print $2}' | tr "," "\n" | sort -V | uniq | tr "\n" " "

taxon="Absicoccus porci" && grep "£$taxon@" 2021_05_13_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs_pound_sign_start_of_each_line.txt | awk -F "@" '{print $2}' | tr "," "\n" | sort -V | uniq | tr "\n" " "

AR9N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

#!/bin/bash -eE
#SBATCH -t 00-04:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Non-array_collect_taxons_trial
#SBATCH --mem=4gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

while read -r line
do
  contig=$(printf "$line" | awk -F "\t" '{print $1}')
  kb_adjusted_score=$(printf "$line" | awk -F "\t" '{print $2}')
  taxon=$(grep -w "$contig" 2021_05_13_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs_pound_sign_start_of_each_line.txt | awk -F "@" '{print $1}' | head -1 | sed 's/£//g')
  printf "$taxon\t$contig\t$kb_adjusted_score\n" >> Dumb_temp_file_working_test.txt
done < AR9N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt
while read -r line
do
  taxon=$(printf "$line" | sed 's/£//g' | sed 's/@//g')
  library_size_adjustment="8.5"
  all_taxa_scores=$(grep "$taxon" Dumb_temp_file_working_test.txt | awk -F "\t" '{print $3}')
  taxon_file_name=$(printf "$taxon" | sed 's/ /__/g')
  printf "$all_taxa_scores" >> "${taxon_file_name}_TEMPORARY_DUMB_TESTING_FILE.TXT"
  summed_score=$(cat "${taxon_file_name}_TEMPORARY_DUMB_TESTING_FILE.TXT" | awk 'NF' | paste -s -d+ - | bc -l)
  adjusted_score=$(echo "$summed_score / $library_size_adjustment" | bc -l)
  printf "\n$taxon\t$adjusted_score"
  rm "${taxon_file_name}_TEMPORARY_DUMB_TESTING_FILE.TXT"
done < 2021-05-13_unique_taxa_list_pound_sign_at_start_at_sign_at_end.txt

tail Collected_results_table_13_May_2021_AC5N_collected_taxon_scores.txt
Bacteroides sp. CAG:714
Bacteroides sp. CAG:754
Bacteroides sp. CAG:770
Bacteroides sp. CAG:927
Bacteroides sp. CAG:1060
Bacteroides sp. CAG:1060_57_27
Bacteroides sp. CAG:1076
Bacteroides sp. CBA7301
Bacteroides sp. CF01-10NS
Bacteroides sp. D2

rm: cannot remove ‘Collected_results_table_13_May_2021_AC5N__TEMP_ARRAY_FILE.txt’: No such file or directory
There are this many contigs for taxon Bacteroidetes bacterium HGW-Bacteroidetes-9: 1

Line 41 thinks the contigs are as follows:	k141_12203087
-_-_-_-_-_-_-_-/opt/slurm/data/slurmd/job35767041/slurm_script: line 29: k141_12203087 : No such file or directory
cat: Collected_results_table_13_May_2021_AC5N__TEMP_ARRAY_FILE.txt: No such file or directory
(standard_in) 1: syntax error
rm: cannot remove ‘Collected_results_table_13_May_2021_AC5N__TEMP_ARRAY_FILE.txt’: No such file or director

awk '/k141_114,/' 2021_05_13_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs_pound_sign_start_of_each_line.txt

grep -w "k141_114" AR47N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

Abditibacterium utsteinense	.18659329411764705882

grep -w "k141_4896423" AC5N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

grep 'Abditibacterium utsteinense' 2021_05_13_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs_pound_sign_start_of_each_line.txt

#!/bin/bash -eE
#SBATCH -t 00-02:25
#SBATCH -p ei-short
#SBATCH -c 1
#SBATCH -J collect_convert_scheduler
#SBATCH --mem=2gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target1=$(find -maxdepth 1 -type f -name "*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -not -name "AC16*" -not -name "AC18*" -not -name "AC19*" -not -name "AR27*" -not -name "AR29*" -not -name "AR32*" -not -name "AC5N*")
for f in $target1
do
  printf "\nSubmitting file:\t$f\n"
  sbatch execute_collect_and_library_adjust_script.sh "$f" 8.5
  sleep 5s
  printf "\nSubmitted file:\t$f\n"
done
target2=$(find -maxdepth 1 -type f -name "AC16*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -or -name "AC18*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -or -name "AC19*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -or -name "AR27*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -or -name "AR29*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -or -name "AR32*_Subsampled_kilobase_adjusted_contig_mapping_scores.txt")
for f in $target2
do
  printf "\nSubmitting file:\t$f\n"
  sbatch execute_collect_and_library_adjust_script.sh "$f" 4.5
  sleep 5s
  printf "\nSubmitted file:\t$f\n"
done

binned_m89_kaiju_output-SPECIES.out 65


while read -r line ; do bin=$(grep -w "$line" *kaiju_output-SPECIES.out | awk -F "_kaij_output-SPECIES" '{print $1}' | sed 's/binned_/Bin_/g' | awk -F "_" '{print $1"_"$2}') && percent=$(grep "$line" *kaiju_output-SPECIES.out | awk -F "\t" '{print $2}') && printf "$bin\t$percent\t$line\n" ; done < majority_classifications_species_level_kaiju

#!/bin/bash -eE
#SBATCH -t 00-04:25
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J kaiju_species_bins_check
#SBATCH --mem=6gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

for f in *kaiju_output-SPECIES.out
do
  bin=$(basename "$f" | awk -F "_" '{print $1"_"$2}' | sed 's/binned/Bin/g')
  printf "Microbial_species\tPercent_classified_by_Kaiju\n" >> "${bin}_percent_contigs_classified_from_most_species.txt"
  while read -r line
  do
    species=$(printf "$line")
    grep -q ";$line;" "$f" && prescheck="Y" || prescheck="N"
    if [[ "$prescheck" == "N" ]]
    then
      percentage="0"
    elif [[ "$prescheck" == "Y" ]]
    then
      percentage=$(grep ";$line;" "$f" | awk -F "\t" '{print $2}')
    fi
    printf "$species\t$percentage\n" >> "${bin}_percent_contigs_classified_from_most_species.txt"
  done < majority_classifications_species_level_kaiju.txt
done

cat Bin_*_percent_contigs_classified_from_most_species.txt | awk -F "\t" '$2>0{print $0}'

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/


wc -l *_Collected_results_table_15_May_2021*_collected_taxon_scores-V2.txt
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && wc -l *_Collected_results_table_16_May_2021*_collected_taxon_scores-V3.txt && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
Paenibacillus sp. yr247	0
bacterium 336/3 k141_10163643

echo tZLexVZAAbYGzjPEV9aqt3Du7K0WVo9OovfUjLh3IR7zWIIbJ94QA6MIoGSMV6vi_Collected_results_table_15_May_2021_AC23N_collected_taxon_scores-V2.txt | cut -c 66-

for f in *_Collected_results_table_15_May_2021*_collected_taxon_scores-V2.txt ; do newnome=$(echo "$f" | cut -c 66-) && printf "\n$newnome\n" && mv "$f" "$newnome" ; done

wc -l Collected_results_table_15_May_2021*_collected_taxon_scores-V2.txt

Collected_results_table_15_May_2021_AR9J_collected_taxon_scores-V2.txt

#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR
for f in Collected_results_table_15_May_2021*_collected_taxon_scores-V2.txt
do
  sampleID=$(echo "$f" | awk -F "_" '{print $7}')
  kilobase_score_file=$(find -maxdepth 1 -type f -name "${sampleID}_Subsampled_kilobase_adjusted_contig_mapping_scores.txt")
  kb_score_file=$(basename "$kilobase_score_file")
  contig="k141_10163643"
  kb_score=$(grep -w "$contig" "$kb_score_file" | awk -F "\t" '{print $2}' | awk 'NF')
  if [ "$kb_score" = "0" ]
  then
    library_size_score=$(echo "$kb_score")
    printf "\n$sampleID\t$library_size_score\n"
  elif [ "$kb_score" != "0" ]
  then
    kbscore=$(echo "$kb_score" | awk '{printf "%f", $0}')
    grep -q "$sampleID" pilot_samples_list.txt && library_size="4.5" || library_size="8.5"
    library_size_score=$(echo "$kbscore / $library_size" | bc -l | awk '{printf "%f", $0}')
    printf "\n$sampleID\t$library_size_score\n"
  fi
done

grep -w 'k141_10163643' *_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304


grep -w 'Eubacterium siraeum 70' 2021_05_13_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs_pound_sign_start_of_each_line.txt

grep -w 'Eubacterium siraeum 70/3' all_unique_taxons_incluing_unclassified_from_all_contigs_across_all_bins_list.square_and_curly_brackets_removed.txt

grep -w 'Eubacterium siraeum 70*' all_unique_taxons_incluing_unclassified_from_all_contigs_across_all_bins_list.square_and_curly_brackets_removed.txt

grep 'Eubacterium siraeum 70' 2021_05_13_Contigs_for_each_unqiue_taxon_curly_and_square_brackets_removed.txt.at_sign_replacing_tab_separating_taxon_from_contigs_pound_sign_start_of_each_line.txt

grep 'Eubacterium siraeum 70' all_unique_taxons_incluing_unclassified_from_all_contigs_across_all_bins_list.square_and_curly_brackets_removed.txt

Eubacterium siraeum 70/3
for f in *_Collected_results_table_15_May_2021_*_collected_taxon_scores-V2.txt.SAFEGUARD ; do file_lines=$(cat "$f" | wc -l) && useful_lines=$(cat "$f" | awk -F "\t" '{print $2}' | awk 'NF' | wc -l) && printf "For file: $f\tUseful lines is:\t$useful_lines\n" ; done

cat all_unique_taxons_incluing_unclassified_from_all_contigs_across_all_bins_list.square_and_curly_brackets_removed.txt | tr -d '[:punct:]' > all_unique_taxons_incluing_unclassified_from_all_contigs_across_all_bins_list.all_punctuation_removed.txt

cat 2021_05_16_Contigs_for_each_unqiue_taxon_words_in_place_of_commas_pound_signs_and_at_signs.txt | tr -d '[:punct:]'
| sed 's/£/STARTOFLINE/g' | sed 's/@/CONTIGBEGIN/g' | sed 's/,/COMMAWASHERE/'

line="bacterium" && grep -w "$line" all_contigs_taxon_or_unclassified.all_punctuation_removed.txt

grep 'Cloacimonetes' all_unique_taxons_incluing_unclassified_from_all_contigs_across_all_bins_list.square_and_curly_brackets_removed.txt

cat all_contigs_taxon_or_unclassified.all_punctuation_removed.txt | sed 's#\t#£#g' | sed 's/£/@/g' > 2021_05_16-All_contigs_and_their_taxon_no_punctuation_in_taxon_at_sign_separates_contig_then_taxon.txt

#!/bin/bash -eE
#SBATCH -t 00-04:25
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J V3_collect_contigs_to_taxons
#SBATCH --mem=6gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR
while read -r line
do
  taxon=$(echo "$line")
  contigs=$(grep "@$taxon$" 2021_05_16-All_contigs_and_their_taxon_no_punctuation_in_taxon_at_sign_separates_contig_then_taxon.txt | awk -F "@" '{print $1}' | tr "\n" "," | sed 's/,*$//g')
  printf "\n$taxon@$contigs\n" >> 2021_05_16-All_taxons_and_their_contigs_at_sign_between_taxa_and_contigs_commas_between_contigs.txt
done < 2021_05_16_all_unique_taxa_punctuation_removed.txt

2021_05_16-All_contigs_and_their_taxon_no_punctuation_in_taxon_at_sign_separates_contig_then_taxon.txt
taxon="Actinomycetaceae" && contigs=$(grep "@$taxon$" 2021_05_16-All_contigs_and_their_taxon_no_punctuation_in_taxon_at_sign_separates_contig_then_taxon.txt | awk -F "@" '{print $1}' | tr "\n" "," | sed 's/,*$//g') && printf "\n$taxon@$contigs\n"


grep "k141340823" AC11J_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

grep -w "$i" "$subject_file"

sed -i -e 's/k141/k141_/g' 2021_05_16-All_taxons_and_their_contigs_at_sign_between_taxa_and_contigs_commas_between_contigs.txt.Taxons_all_start_with_pound_sign.txt

awk '/Aquimarina/{ print NR; exit }' n4yhhZkjl9wmALCQz9RnLcp7EPjQRY8TOEdbbD5RChxqt1fmgNPgvO8F1pEDstoz_Collected_results_table_16_May_2021_AR47N_collected_taxon_scores-V3.txt

sed '446q;d' Collected_results_table_16_May_2021_*_collected_taxon_scores-V3.txt

sed -i '446d' TESTING-line_removals.txt

awk '/Bacillus sp J37/{ print NR; exit }' TESTING-line_removals.txt
sed '608q;d' TESTING-line_removals.txt
sed -i '608d' TESTING-line_removals.txt
awk '/Bdellovibrionales bacterium GWA24915/{ print NR; exit }' TESTING-line_removals.txt
sed '860q;d' TESTING-line_removals.txt
sed -i '860d' TESTING-line_removals.txt
awk '/Fibrobacter sp UWB2/{ print NR; exit }' TESTING-line_removals.txt
sed '2685q;d' TESTING-line_removals.txt
sed -i '2685d' TESTING-line_removals.txt
awk '/Globicatella sulfidifaciens/{ print NR; exit }' TESTING-line_removals.txt
sed '3007q;d' TESTING-line_removals.txt
sed -i '3007d' TESTING-line_removals.txt
awk '/Lachnospiraceae bacterium OF0933XD/{ print NR; exit }' TESTING-line_removals.txt
sed '3383q;d' TESTING-line_removals.txt
sed -i '3383d' TESTING-line_removals.txt
awk '/Roseburia sp AF428/{ print NR; exit }' TESTING-line_removals.txt
sed '5019q;d' TESTING-line_removals.txt
sed -i '5019d' TESTING-line_removals.txt

#!/bin/bash -eE
#SBATCH -t 00-04:25
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J average_adjusted_counts_by_host_and_season
#SBATCH --mem=6gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

for f in Collected_results_table_16_May_2021_*_collected_taxon_scores-V3.txt
do
  nome=$(basename "$f")
  cp "$f" "${nome}.modded.txt"
  sed -i '446d' "${nome}.modded.txt"
  sed -i '608d' "${nome}.modded.txt"
  sed -i '860d' "${nome}.modded.txt"
  sed -i '2685d' "${nome}.modded.txt"
  sed -i '3007d' "${nome}.modded.txt"
  sed -i '3383d' "${nome}.modded.txt"
  sed -i '5019d' "${nome}.modded.txt"
done

for f in Collected_results_table_16_May_2021_*_collected_taxon_scores-V3.txt.modded.txt ; do nome=$(basename "$f") && cat "$f" | awk -F "\t" '{print $2}' > "${nome}.just_counts_as_column.txt" && cat "${nome}.just_counts_as_column.txt" | tr "\n" "," > "${nome}.just_counts_as_row.csv" ; done

2021_05_17-Moxtfied_just_taxons_right_order_single_row_comma_separated.csv

cat Collected_results_table_16_May_2021_*_collected_taxon_scores-V3.txt.modded.txt.just_counts_as_row.csv
for f in Collected_results_table_16_May_2021_*_collected_taxon_scores-V3.txt.modded.txt.just_counts_as_row.csv ; do content=$(cat "$f") && printf "\n$content" >> 2021_05_17-Modified_just_taxons_right_order_single_row_comma_separated.csv ; done
awk '{print NF}' 2021_05_17-Modified_just_taxons_right_order_single_row_comma_separated.csv | sort -nu | tail -n 1

for f in Collected_results_table_16_May_2021_*_collected_taxon_scores-V3.txt.modded.txt ; do nome=$(basename "$f" | awk -F "_" '{print $7}') && cp "$f" "${nome}_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt" ; done

2021_05_17-Modified_just_taxons_right_order_list.txt

#!/bin/bash -eE
#SBATCH -t 00-04:25
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J average_adjusted_counts_by_host_and_season
#SBATCH --mem=6gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR
#printf "Microorganism,ACJ,ACN,ARJ,ARN\n" >> 2021_05_17-All_taxa_adjusted_scores_by_host_species_and_season.csv
printf "Microorganism,ACJ\n" >> 2021_05_17-All_taxa_adjusted_scores_ONLY_ACJ_samples.csv
printf "Microorganism,ACN\n" >> 2021_05_17-All_taxa_adjusted_scores_ONLY_ACN_samples.csv
printf "Microorganism,ARJ\n" >> 2021_05_17-All_taxa_adjusted_scores_ONLY_ARJ_samples.csv
printf "Microorganism,ARN\n" >> 2021_05_17-All_taxa_adjusted_scores_ONLY_ARN_samples.csv
while read line
do
  taxon=$(echo "$line")
  ACJ_divisor="22"
  ACN_divisor="17"
  ARJ_divisor="21"
  ARN_divisor="19"
  ACJ_counts=$(grep "£$line@" AC*J_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt | awk -F "@" '{print $2}' | paste -sd + - | bc -l | awk '{printf "%f", $0}')
  ACN_counts=$(grep "£$line@" AC*N_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt | awk -F "@" '{print $2}' | paste -sd + - | bc -l | awk '{printf "%f", $0}')
  ARJ_counts=$(grep "£$line@" AR*J_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt | awk -F "@" '{print $2}' | paste -sd + - | bc -l | awk '{printf "%f", $0}')
  ARN_counts=$(grep "£$line@" AR*N_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt | awk -F "@" '{print $2}' | paste -sd + - | bc -l | awk '{printf "%f", $0}')
  ACJ_average=$(echo "$ACJ_counts / $ACJ_divisor" | bc -l | awk '{printf "%f", $0}') && printf "$taxon,$ACJ_average\n" >> 2021_05_17-All_taxa_adjusted_scores_ONLY_ACJ_samples.csv
  ACN_average=$(echo "$ACN_counts / $ACN_divisor" | bc -l | awk '{printf "%f", $0}') && printf "$taxon,$ACN_average\n" >> 2021_05_17-All_taxa_adjusted_scores_ONLY_ACN_samples.csv
  ARJ_average=$(echo "$ARJ_counts / $ARJ_divisor" | bc -l | awk '{printf "%f", $0}') && printf "$taxon,$ARJ_average\n" >> 2021_05_17-All_taxa_adjusted_scores_ONLY_ARJ_samples.csv
  ARN_average=$(echo "$ARN_counts / $ARN_divisor" | bc -l | awk '{printf "%f", $0}') && printf "$taxon,$ARN_average\n" >> 2021_05_17-All_taxa_adjusted_scores_ONLY_ARN_samples.csv
  #printf "$taxon,$ACJ_average,$ACN_average,$ARJ_average,$ARN_average\n" >> 2021_05_17-All_taxa_adjusted_scores_by_host_species_and_season.csv
done < TEMP_2021_05_17-Modified_just_taxons_right_order_list.txt

for f in *_kaiju_output.out ; do cat "$f" | awk -F "\t" '{print $4}' | sort -V ; done
for f in *_kaiju_output.out ; do cat "$f" | awk -F "\t" '($4>50){print $0}' ; done

for f in *_kaiju_output.out ; do export nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}' | sed 's/binned/Bin/g') && contigs_over_50_score=$(cat "$f" | awk -F "\t" '($4>50){print $2"\t"$4"\t"$3}' | sed "s/$/\t$nome/g") && printf "$contigs_over_50_score\n" >> 2021_05_18_All_bins_contigs_scoring_over_50_contig_then_score_then_bin_then_TaxID_tab_separated.tsv ; done


awk -F "," '($NF<0.99 && $NF>=0.75){print $0}'

AR30J_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

inpf1="AR30J_Subsampled_kilobase_adjusted_contig_mapping_scores.txt" && while read -r line ; do contig=$(echo "$line" | awk -F "\t" '{print $1}') && contig_score=$(grep -w "$contig" "$inpf1" | awk -F "\t" '{print $2}') && printf "$contig\t$contig_score\n" ; done < 2021_05_18_All_bins_contigs_scoring_over_50_contig_then_bin.tsv

2021_05_16-All_taxons_and_their_contigs_at_sign_between_taxa_and_contigs_commas_between_contigs.txt.Taxons_all_start_with_pound_sign.txt

grep -w "k141_16272664" 2021_05_16-All_taxons_and_their_contigs_at_sign_between_taxa_and_contigs_commas_between_contigs.txt.Taxons_all_start_with_pound_sign.txt | awk -F "@" '{print $1}' | sed 's/£//g'

2021_05_18_All_bins_contigs_scoring_over_50_contig_then_bin.tsv
while read -r line ; do contig=$(echo "$line" | awk -F "\t" '{print $1}') && taxon=$(grep -w "$contig" 2021_05_16-All_taxons_and_their_contigs_at_sign_between_taxa_and_contigs_commas_between_contigs.txt.Taxons_all_start_with_pound_sign.txt | awk -F "@" '{print $1}' | sed 's/£//g') && printf "$contig\t$taxon\n" >> 2021_05_18_Kaiju_score_over_50_contigs_and_their_taxons_tab_separated_contigs_then_taxons.tsv ; done < 2021_05_18_All_bins_contigs_scoring_over_50_contig_then_bin.tsv

2021_05_18_Kaiju_score_over_50_contigs_and_their_taxons_tab_separated_contigs_then_taxons.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304
AC7N_Subsampled_kilobase_adjusted_contig_mapping_scores.txt
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
cat 2021_05_18_Kaiju_score_over_50_contigs_and_their_taxons_tab_separated_contigs_then_taxons.tsv | sed 's/$/£/g' | tr "\t" "@" >> 2021_05_18_Kaiju_score_over_50_contigs_and_their_taxons_tab_separated_contigs_then_taxons_at_sign_after_contig_before_taxon_pound_sign_after_taxon.txt

while read -r line ; do taxon=$(echo "$line") && contig=$(grep "@$taxon£" 2021_05_18_Kaiju_score_over_50_contigs_and_their_taxons_tab_separated_contigs_then_taxons_at_sign_after_contig_before_taxon_pound_sign_after_taxon.txt | awk -F "@" '{print $1}' | paste -sd, -) && printf "£$taxon@$contig\n" ; done < 2021_05_18_Kaiju_score_over_50_unique_taxons_only.txt

2021_05_18_V3TaxFrom_Confident_Contigs_and_adjust.sh

13A_S1	493713
13B_S2	447111
13C_S3	70
13D_S4	502597
13E_S5	468072
16aA_S24	486611
16aB_S25	539635
16aC_S26	514699
16aD_S27	472203
16aE_S28	524512
16aF_S29	448402
16bA_S19	678715
16bB_S20	603296
16bC_S21	483120
16bD_S22	530232
16bE_S23	512497
18A_S9	356074
18B_S10	528679
18C_S11	539
18D_S12	582117
18E_S13	586322
39A_S14	530534
39B_S15	307007
39C_S16	586554
39D_S17	668193
39E_S18	565006
41A_S6	511905
41B_S7	500295
41C_S8	50175407-
Neg_S30	48


cat 18D_S12_kaiju_output.Kaiju_2_table_output_SPECIES.txt | awk -F "\t" '{print $2"\t"$5}'

for f in *_kaiju_output.Kaiju_2_table_output_SPECIES.txt ; do mas=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $5}' | rev | awk -F ";" '{print $2}' | rev) && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$mas\n" ; done
for f in *_kaiju_output.Kaiju_2_table_output_SPECIES.txt ; do mas=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $2}') && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$mas\n" ; done

for f in *kaiju_output.Kaiju_2_table_output_GENERA.txt ; do mas=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $5}' | rev | awk -F ";" '{print $2}' | rev) && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$mas\n" ; done
for f in *kaiju_output.Kaiju_2_table_output_GENERA.txt ; do mas=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $2}') && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$mas\n" ; done

kaiju_output.Kaiju_2_table_output_FAMILY.txt
for f in *kaiju_output.Kaiju_2_table_output_FAMILY.txt ; do mas=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $5}' | rev | awk -F ";" '{print $2}' | rev) && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$mas\n" ; done

18D_S12_kaiju_output.Kaiju_2_table_output_SPECIES.txt

13A_S1	Lactobacillus kefiranofaciens
13B_S2	Lactobacillus reuteri
13C_S3	Lactobacillus reuteri
13D_S4	Lactobacillus reuteri
13E_S5	Lactobacillus reuteri
16aA_S24	Gardnerella vaginalis
16aB_S25	Lactobacillus kefiranofaciens
16aC_S26	Lactobacillus reuteri
16aD_S27	Gardnerella vaginalis
16aE_S28	Lactobacillus reuteri
16aF_S29	Lactobacillus pontis
16bA_S19	Lactobacillus amylolyticus
16bB_S20	Lactobacillus kefiranofaciens
16bC_S21	Lactobacillus reuteri
16bD_S22	Lactobacillus reuteri
16bE_S23	Lactobacillus reuteri
18A_S9	Bifidobacterium pseudolongum
18B_S10	Lactobacillus reuteri
18C_S11	Lactobacillus hamsteri
18D_S12	Lactobacillus kefiranofaciens
18E_S13	Lactobacillus reuteri
39A_S14	Lactobacillus reuteri
39B_S15	Bifidobacterium pseudolongum
39C_S16	Lactobacillus helveticus
39D_S17	Lactobacillus helveticus
39E_S18	Lactobacillus reuteri
41A_S6	Lactobacillus selangorensis
41B_S7	Lactobacillus murinus
41C_S8	Pediococcus pentosaceus
Neg_S30	Lactobacillus reuteri

cat 16bE_S23_kaiju_output.Kaiju_2_table_output_SPECIES.txt | grep -v 'file' | grep -v "Viruses" | grep -v "cannot be assigned"
./16bE_S23_Kaiju_output_16bE_S23_Kaiju_output.out	27.875090	142859	NA	cannot be assigned to a (non-viral) species
tail 16bE_S23_kaiju_output.Kaiju_2_table_output_GENERA.txt

for f in *kaiju_output.Kaiju_2_table_output_FAMILY.txt ; do nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && unclassified=$(tail -1 "$f" | awk -F "\t" '{print $2}') && cannot_be_assigned=$(grep 'cannot be assigned' "$f" | awk -F "\t" '{print $2}') && printf "$nome\t$unclassified\t$cannot_be_assigned\n" ; done

for f in *kaiju_output.Kaiju_2_table_output_FAMILY.txt ; do tail -2 "$f" ; done

for f in *_kaiju_output.Kaiju_2_table_output_SPECIES.txt ; do nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && line_count=$(wc -l "$f") && species_num=$(echo "$line_count - 4" | bc -l) && printf "$nome\t$species_num\n" ; done

for f in *kaiju_output.Kaiju_2_table_output_GENERA.txt ; do mas=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $5}' | rev | awk -F ";" '{print $2}' | rev) && mag=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $2}') && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$mas\t$mag\n" ; done

13A_S1	Lactobacillus	74.006355
13B_S2	Lactobacillus	71.337547
13C_S3	Lactobacillus	61.428570
13D_S4	Lactobacillus	70.978935
13E_S5	Lactobacillus	69.163292
16aA_S24	Lactobacillus	47.900684
16aB_S25	Lactobacillus	77.419548
16aC_S26	Lactobacillus	70.499069
16aD_S27	Lactobacillus	42.305107
16aE_S28	Lactobacillus	70.519455
16aF_S29	Lactobacillus	77.628113
16bA_S19	Lactobacillus	70.183655
16bB_S20	Lactobacillus	77.227097
16bC_S21	Lactobacillus	69.926308
16bD_S22	Lactobacillus	71.699936
16bE_S23	Lactobacillus	70.900513
18A_S9	Bifidobacterium	83.711250
18B_S10	Lactobacillus	72.271454
18C_S11	Lactobacillus	70.500931
18D_S12	Lactobacillus	73.443657
18E_S13	Lactobacillus	71.632141
39A_S14	Lactobacillus	72.303001
39B_S15	Bifidobacterium	84.132286
39C_S16	Lactobacillus	79.210434
39D_S17	Lactobacillus	83.071060
39E_S18	Lactobacillus	46.918262
41A_S6	Lactobacillus	47.486938
41B_S7	Lactobacillus	55.227016
41C_S8	Pediococcus	90.005463
Neg_S30	Lactobacillus	75.000000

for f in *Confident_contigs_Collected_results_table_18_May_2021_*_collected_taxon_scores-V3.txt ; do nome=$(basename "$f" | cut -c 66-) && mv "$f" "$nome" ; done

Confident_contigs_Collected_results_table_18_May_2021_*_collected_taxon_scores-V3.txt.just_counts_single_column.txt

for f in *Confident_contigs_Collected_results_table_18_May_2021_*_collected_taxon_scores-V3.txt ; do cat "$f" | awk -F "\t" '{print $2}' >> "${f%}.just_counts_single_column.txt" ; done
for f in *Confident_contigs_Collected_results_table_18_May_2021_*_collected_taxon_scores-V3.txt ; do cat "$f" | awk -F "\t" '{print $2}' | tr "\n" "," >> "${f%}.just_counts_single_row.csv" ; done

Confident_contigs_Collected_results_table_18_May_2021_*_collected_taxon_scores-V3.txt.just_counts_single_row.csv >> 2021_05_19_Confident_contigs_all_samples_kilobase_and_library_size_adjusted_scores_all_unique_taxa-ROWS_for_taxa_counts.csv

2021_05_19_Confident_contigs_after_collection_unique_taxons_list_only_COLUMN.txt
2021_05_19_Confident_contigs_after_collection_unique_taxons_list_only_ROW.csv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads

wc -l *Wed_5_May_2021_excluding_reads_flagged_to_2304_sorted.bam.idxstats.txt - third tab is number of mapped segments

13A_S1_eggnog_mapper_output.emapper.annotations
13A_S1_R1_001_megahit_assembly.fa

target=$(find -maxdepth 2 -type f -name "*R1_001_megahit_assembly.fa") && for f in $target ; do contig_count=$(grep -c ">" "$f") && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$contig_count\n" ; done
target=$(find -maxdepth 2 -type f -name "*eggnog_mapper_output.emapper.annotations") && for f in $target ; do predicted_gene_count=$(grep -c "k" "$f") && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$predicted_gene_count\n" ; done

target=$(find -maxdepth 1 -type f -name "*prokka_output.fna") && for f in $target ; do predicted_gene_count=$(grep -c ">k" "$f") && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$predicted_gene_count\n" ; done

target=$(find -maxdepth 2 -type f -name "*eggnog_mapper_output.emapper.annotations") && for f in $target ; do cat "$f" | awk -F "\t" '{print $6}' | awk 'NF'; done

target=$(find -maxdepth 2 -type f -name "*eggnog_mapper_output.emapper.annotations") && for f in $target ; do predicted_gene_count=$(cat "$f" | awk -F "\t" '{print $6}' | grep -v 'Preferred' | awk 'NF' | wc -l) && nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "$nome\t$predicted_gene_count\n" ; done

target=$(find -maxdepth 2 -type f -name "*eggnog_mapper_output.emapper.annotations") && for f in $target ; do nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && printf "Predicted_named_protein\t$nome\n" >> "${nome}_predicted_named_protein_count.tsv" && while read -r line ; do protein=$(echo "$line") && grep -q "$protein" "$f" && count=$(grep -wc "$protein" "$f") || count="0" && printf "$protein\t$count\n" >> "${nome}_predicted_named_protein_count.tsv" ; done < unique_named_proteins_from_eggnog_mapper_annotations_of_assemblies.txt ; done

for f in *_predicted_named_protein_count.tsv ; do cat "$f" | awk -F "\t" '{print $2}' > "${f%}.only_counts.txt" ; done

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

tnp3503b,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,0,0,15,0,0,0,0,0,0
ltrA_1,0,5,1,1,3,0,1,1,2,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,2,0,0,0
infB,0,2,1,0,0,0,0,0,4,0,0,0,1,0,3,1,2,0,0,1,7,1,0,1,0,0,0,0

10 or over
tnp3503b - Transposase IS3503b
fhaB - filamentous hemagglutinin/adhesin
infB - translation initiation factor IF-2
amyE - Alpha amylase
ltrA_1 - Group II intron reverse transcriptase/maturase
XK27_01125 - transposase
pgi - Glucose-6-phosphate isomerase
hsdS - Type-1 restriction enzyme EcoKI specificity protein

5 or over
rnr
tlpA2
fas
isp2
cotH
fliD
scrK

locale=$(pwd) && target=$(find -maxdepth 2 -type f -name "*eggnog_mapper_output.emapper.annotations") && for f in $target ; do cp "$f" "$locale" ; done
6501 GO terms
897 unique ones
#1221 free text descriptions, 319 unique - though this doesn't actually mean anything since 'Uncharacterised protein' can be different things with the same label

*Wed_5_May_2021_excluding_reads_flagged_to_2304_sorted.bam.idxstats.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reads_mapped_to_reference_of_most_likely_species_from_Kaiju_analysis_of_megahit_assembly

/ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/OUTPUTS

2021_05_19_Confident_contigs_after_collection_unique_taxons_list_only_ROW.csv
2021_05_19_Confident_contigs_all_samples_kilobase_and_library_size_adjusted_scores_all_unique_taxa-ROWS_for_taxa_counts.csv

for f in Confident_contigs_Collected_results_table_18_May_2021_*_collected_taxon_scores-V3.txt.just_counts_single_row.csv ; do sed -i 's/,$/\,\n/g' "$f" ; done

IJG

13A_S1	Lactobacillus kefiranofaciens
13B_S2	Lactobacillus reuteri
13C_S3	Virus
13D_S4	Lactobacillus reuteri
13E_S5	Lactobacillus reuteri
16aA_S24	Lactobacillus reuteri
16aB_S25	Lactobacillus kefiranofaciens
16aC_S26	Lactobacillus reuteri
16aD_S27	Lactobacillus vaginalis
16aE_S28	Lactobacillus reuteri
16aF_S29	Lactobacillus pontis
16bA_S19	Lactobacillus helveticus
16bB_S20	Lactobacillus kefiranofaciens
16bC_S21	Lactobacillus reuteri
16bD_S22	Lactobacillus reuteri
16bE_S23	Lactobacillus reuteri
18A_S9	Bifidobacterium pseudolongum
18B_S10	Lactobacillus reuteri
18C_S11	Virus
18D_S12	Lactobacillus kefiranofaciens
18E_S13	Lactobacillus reuteri
39A_S14	Lactobacillus reuteri
39B_S15	Bifidobacterium pseudolongum
39C_S16	Lactobacillus helveticus
39D_S17	Lactobacillus helveticus
39E_S18	Lactobacillus reuteri
41A_S6	Lactobacillus rhamnosus
41B_S7	Lactobacillus murinus
41C_S8	Pediococcus pentosaceus

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reference_genomes_to_map_to/Lactobacillus_helveticus.fna

fastANI -o 39C_S16_to_Lactobacillus_helveticus.txt -r /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reference_genomes_to_map_to/Lactobacillus_helveticus.fna -q 39C_S16_R1_001_megahit_assembly.fa

for f in *.fa ; do nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && nume=$(basename "$f") && grep -q "$nume" assemblies_and_closest_hit_by_kaiju_path_to_reference.txt && reference_file=$(grep "$nume" assemblies_and_closest_hit_by_kaiju_path_to_reference.txt | awk -F " " '{print $2}') && fastANI -o "${nome}_fastANI_output.txt" -r "$reference_file" -q "$f" && printf "\nPut file:\t$f\nThrough FastANI to reference file:\t$reference_file\n" ; done

18E_S13_kaiju_output-SPECIES.tsv

target=$(find -maxdepth 5 -type f -name "*kaiju_output-SPECIES.tsv") && for f in $target ; do name=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && mas_percent=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $2}') && printf "$name\t$mas_percent\n" ; done | sort -V

41B_S7	Lactobacillus murinus
39B_S15	Bifidobacterium pseudolongum
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Assemblies/41B_S7_R1_001_megahit_assembly.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Assemblies/39B_S15_R1_001_megahit_assembly.fa

sbatch TESTING_Liftoff.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Assemblies/41B_S7_R1_001_megahit_assembly.fa /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reference_genomes_to_map_to/Lactobacillus_murinus.fna Lactobacillus_murinus_annotation_from_NCBI_GCF_001436015.1_ASM143601v1_genomic.gff

sbatch TESTING_Liftoff.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Assemblies/39B_S15_R1_001_megahit_assembly.fa /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reference_genomes_to_map_to/Bifidobacterium_pseudolongum.fna Bifidobacterium_pseudolongum_annotation_from_NCBI_GCF_002282915.1_ASM228291v1_genomic.gff

sbatch TESTING_Liftoff.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Assemblies/18A_S9_R1_001_megahit_assembly.fa /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reference_genomes_to_map_to/Bifidobacterium_pseudolongum.fna Bifidobacterium_pseudolongum_annotation_from_NCBI_GCF_002282915.1_ASM228291v1_genomic.gff


sbatch TESTING_Liftoff.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Assemblies/39B_S15_R1_001_megahit_assembly.fa /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reference_genomes_to_map_to/Lactobacillus_murinus.fna Lactobacillus_murinus_annotation_from_NCBI_GCF_001436015.1_ASM143601v1_genomic.gff
sbatch TESTING_Liftoff.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Assemblies/41B_S7_R1_001_megahit_assembly.fa /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Reference_genomes_to_map_to/Bifidobacterium_pseudolongum.fna Bifidobacterium_pseudolongum_annotation_from_NCBI_GCF_002282915.1_ASM228291v1_genomic.gff

16bD_S22_R1_001_megahit_assembly.fa

>k145_1 flag=1 multi=1.0000 len=329

target=$(find -maxdepth 2 -type f -name "*R1_001_megahit_assembly.fa") && for f in $target ; do nume=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && contig_count=$(grep -c '>k' "$f") && bases_in_assembly=$(grep 'len' "$f" | awk -F "len=" '{print $2}' | paste -sd+ - | bc -l) && longest_contig_length=$(grep 'len' "$f" | awk -F "len=" '{print $2}' | sort -V | tail -1) && printf "$nume\t$longest_contig_length\n" ; done
Main genome scaffold N/L50:

target=$(find -maxdepth 2 -type f -name "*R1_001_megahit_assembly.fa") && for f in $target ; do nume=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && N50=$(srun stats.sh "$f" | grep 'Main genome scaffold N/L50:' | awk -F "\t" '{print $2}') && printf "$nume\t$N50\n" ; done

target=$(find -maxdepth 2 -type f -name "*R1_001_megahit_assembly.fa") && for f in $target ; do nume=$(basename "$f" | awk -F "_" '{print $1"_"$2}') && lowest_name=$(basename "$f") && location=$(realpath "$f" | sed "s/$lowest_name//g" | sed 's/.$//') && printf "$nume\t$location\n" ; done

printf "Contig\tTaxID\tLength_of_match\n" >> Contigs_taxIDs_length_of_match.txt
cat *kaiju_output.out | awk -F "\t" '{print $2"\t"$3"\t"$4}' | sort -V -k3 | awk 'NF' >> Contigs_taxIDs_length_of_match.txt

cat *kaiju_output.out | grep -c "k141"

2430 13A_S1_Liftoff_output_from_reference_genome_Lactobacillus_kefiranofaciens.fna_and_annotation_file_Lactobacillus_annotation_from_NCBI_GCF_014656585.1_ASM1465658v1_genomic.gff_12_May_2021_liftoff_final_output
   3024 18A_S9_Liftoff_output_from_reference_genome_Bifidobacterium_pseudolongum.fna_and_annotation_file_Bifidobacterium_pseudolongum_annotation_from_NCBI_GCF_002282915.1_ASM228291v1_genomic.gff_21_May_2021_liftoff_final_output
   3027 39B_S15_Liftoff_output_from_reference_genome_Bifidobacterium_pseudolongum.fna_and_annotation_file_Bifidobacterium_pseudolongum_annotation_from_NCBI_GCF_002282915.1_ASM228291v1_genomic.gff_21_May_2021_liftoff_final_output
      6 39B_S15_Liftoff_output_from_reference_genome_Lactobacillus_murinus.fna_and_annotation_file_Lactobacillus_murinus_annotation_from_NCBI_GCF_001436015.1_ASM143601v1_genomic.gff_21_May_2021_liftoff_final_output
      6 41B_S7_Liftoff_output_from_reference_genome_Bifidobacterium_pseudolongum.fna_and_annotation_file_Bifidobacterium_pseudolongum_annotation_from_NCBI_GCF_002282915.1_ASM228291v1_genomic.gff_21_May_2021_liftoff_final_output
   3658 41B_S7_Liftoff_output_from_reference_genome_Lactobacillus_murinus.fna_and_annotation_file_Lactobacillus_murinus_annotation_from_NCBI_GCF_001436015.1_ASM143601v1_genomic.gff_21_May_2021_liftoff_final_output


grep 'Bacteroidales bacterium 52_46' all_contigs_taxon_or_unclassified.txt
only_unique_taxons_from_all_classified_contigs_across_all_bins.txt
Contigs_taxIDs_length_of_match.txt

target=$(find -maxdepth 3 -type f -name "short_summary.specific.*") && for f in $target ; do cat "$f" ; done

grep "unclassified$" *kaiju_output-SPECIES.out
grep "cannot be assigned to a (non-viral) species" *kaiju_output-SPECIES.out

while read -r line ; do contig_number=$(grep -c "@$line@" 2021_05_25_All_bins_contigs_scoring_over_50_contig_then_score_then_bin_then_TaxID_at_sign_separated.txt) && printf "$line,$contig_number\n" >> 2021_05_25_confident_contigs_TAXID_to_number_of_contigs_assigned_them.csv ; done < confident_contigs_unique_taxids.txt

cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '2005473') print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}'
1239
2320112
2006847
879566
2498093
1898207
186803
541000
1485
2320088
1235800
2320100
131109
239759

while read -r line ; do taxid="$line" && taxon=$(cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '"$taxid"') print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}') && printf "$taxid\t$taxon\n" ; done < remaining_top_20_contig_taxids.txt


cat *kaiju_output-SPECIES.out | awk -F "\t" '{print $4}' | grep -v 'NA' | grep -v 'taxon_id' | awk 'NF'
binned_m881_kaiju_output-SPECIES.out

target=$(find -maxdepth 1 -type f -name "*kaiju_output-SPECIES.out") && for f in $target ; do bin=$(basename "$f" | awk -F "_" '{print $1"_"$2}' | sed 's/binned/Bin/g') && content=$(cat "$f")

while read -r line ; do taxid="$line" && taxon=$(cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '"$taxid"') print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}') && printf "$taxid\t$taxon\n" ; done < 2021_05_27_all_unique_taxIDs_at_species_level_for_all_contigs_across_all_bins.txt


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/results/OUTPUTS/Subsampling_for_analysis
20885-AC6N_Subsampled_R1.fastq.gz
20885-AC6N_Subsampled_R2.fastq.gz


cat *_species_and_percentage_reads_detected.txt | grep -v "percent" | awk 'NF' | awk -F "\t" '{print $1}' | sort -V | uniq | wc -l

2021_05_27_PUNCTUATION_REMOVED_pound_sign_at_start_at_sign_at_end_of_taxa_all_unique_taxa_from_kaiju_analysis_of_reads.txt

2021_05_27_all_unique_taxa_from_kaiju_analysis_of_reads.txt

grep -P 'bacterium\t' *_species_and_percentage_reads_detected.txt

#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J get_species_level_taxa_from_all_bins
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  deletion_target=$(find -maxdepth 1 -type f -name "*_percent_reads_classified_for_all_unique_taxa.txt")
  for f in $deletion_target ; do printf "\nRemoving file:\t$f\n" && rm "$f" ; done
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*_species_and_percentage_reads_detected.txt")
for f in $target
do
  export nome=$(basename "$f" | awk -F "_" '{print $1}' | sed 's/$/_subsampled_to_uniform_depth/g')
  printf "$nome,Percent_reads_classified\n" > "${nome}_percent_reads_classified_for_all_unique_taxa.txt"
  while read -r line
  do
    taxon=$(printf "$line")
    grep -Pq "^$line\t" "$f" && percent_reads_classified=$(grep -P "^$line\t" "$f" | awk -F "\t" '{print $2}') || percent_reads_classified="0"
    printf "$taxon,$percent_reads_classified\n" >> "${nome}_percent_reads_classified_for_all_unique_taxa.txt"
  done < 2021_05_27_all_unique_taxa_from_kaiju_analysis_of_reads.txt
done
/hpc-home/osbourne/Subsampled_reads_Kaiju_input

2021_05_27_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt
AR20N_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt
2021_05_27_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt

2021_05_27_PUNCTUATION_REMOVED_FROM_SPECIES_NAMES_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt
cat 2021_05_27_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt | awk -F "@" '{print $2}' | tr -d '[:punct:]' >> 2021_05_27_PUNCTUATION_REMOVED_FROM_SPECIES_NAMES_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt

AR20N_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt

while read -r line ; do species=$(printf "$line") && count=$(grep "£$species@" AR20N_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt | awk -F "@" '{print $2}') && printf "$species,$count\n" ; done < 2021_05_27_PUNCTUATION_REMOVED_FROM_SPECIES_NAMES_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt

#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J get_species_level_only_counts_from_kilobase_and_library_size_adjusted_count_file
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  deletion_target=$(find -maxdepth 1 -type f -name "*_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted.txt")
  for f in $deletion_target ; do printf "\nRemoving file:\t$f\n" && rm "$f" ; done
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt")
for f in $target
do
  export nome=$(basename "$f" | awk -F "_" '{print $1}')
  printf "Species,$nome\n" > "${nome}_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted.txt"
  while read -r line
  do
    species=$(printf "$line")
    grep -Pq "£$line@" "$f" && count=$(grep "£$species@" "$f" | awk -F "@" '{print $2}') || count="0"
    printf "$species,$count\n" >> "${nome}_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted.txt"
  done < 2021_05_27_PUNCTUATION_REMOVED_FROM_SPECIES_NAMES_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt
done

while read -r line ; do grep -q "$line" 2021_05_19_Confident_contigs_after_collection_unique_taxons_list_only_COLUMN.txt && printf "$line\n" || echo "" | awk 'NF' ; done < 2021_05_27_PUNCTUATION_REMOVED_FROM_SPECIES_NAMES_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt

2021_05_27_PUNCTUATION_REMOVED_FROM_SPECIES_NAMES_confident_contigs_species_level_only.txt


#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J confident_contig_only_species_from_mapping_to_bins
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  deletion_target=$(find -maxdepth 1 -type f -name "*_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted.txt")
  for f in $deletion_target ; do printf "\nRemoving file:\t$f\n" && rm "$f" ; done
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt")
for f in $target
do
  export nome=$(basename "$f" | awk -F "_" '{print $1}')
  printf "Species,$nome\n" > "${nome}_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted_CONFIDENT_CONTIGS.txt"
  while read -r line
  do
    species=$(printf "$line")
    grep -Pq "£$line@" "$f" && count=$(grep "£$species@" "$f" | awk -F "@" '{print $2}') || count="0"
    printf "$species,$count\n" >> "${nome}_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted_CONFIDENT_CONTIGS.txt"
  done < 2021_05_27_PUNCTUATION_REMOVED_FROM_SPECIES_NAMES_confident_contigs_species_level_only.txt
done


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304
2021_05_27_get_species_level_counts_from_contig_and_kilobase_adjusted_counts.sh
2021_05_27_get_species_level_counts_from_contig_and_kilobase_adjusted_counts_CONFIDENT_CONTIGS_ONLY.sh


cat AR46N_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted_CONFIDENT_CONTIGS.txt | awk -F "," '{print $1}'

2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted_CONFIDENT_CONTIGS_just_the_species.txt

for f in *2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted_CONFIDENT_CONTIGS.txt ; do nome=$(basename "$f" | awk -F "_" '{print $1}') && cat "$f" | awk -F "," '{print $2}' >> "${nome}_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted_CONFIDENT_CONTIGS-JUST_COUNTS.txt" ; done


cat AR45J_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted.txt | awk -F "," '{print $1}' > 2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted_just_the_species.txt

2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted_just_the_species.txt

for f in *2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted.txt ; do nome=$(basename "$f" | awk -F "_" '{print $1}') && cat "$f" | awk -F "," '{print $2}' >> "${nome}_2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted-JUST_COUNTS.txt" ; done

2021_05_27_species_level_only_mapping_counts_kilobase_and_library_size_adjusted_just_the_species.txt

[Ruminococcus] faecis

target=$(find -maxdepth 1 -type f -name "*_species_and_percentage_reads_detected.txt") && for f in $target ; do cat "$f" | awk 'NF' | sed 's/^/£/g' | tr "\t" "@" | grep -v "£taxon_nam@percent" >> "${f%}.pound_sign_at_start_of_line_and_at_sign_between_taxon_and_percent_reads.txt" ; done

#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J get_species_level_taxa_from_all_bins
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
[osbourne@EI-HPC interactive Subsampled_reads_Kaiju_input]$ cat 2021_05_27_get_percent_reads_classified_for_all_unique_taxa_from_all_reads_in_each_subsampled_read_kaiju_species_level_output.sh

#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J get_species_level_taxa_from_all_bins
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  deletion_target=$(find -maxdepth 1 -type f -name "*_percent_reads_classified_for_all_unique_taxa.txt")
  for f in $deletion_target ; do printf "\nRemoving file:\t$f\n" && rm "$f" ; done
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*species_and_percentage_reads_detected.txt.pound_sign_at_start_of_line_and_at_sign_between_taxon_and_percent_reads.txt")
for f in $target
do
  export nome=$(basename "$f" | awk -F "_" '{print $1}' | sed 's/$/_subsampled_to_uniform_depth/g')
  printf "$nome,Percent_reads_classified\n" > "${nome}_percent_reads_classified_for_all_unique_taxa.txt"
  while read -r line
  do
    taxon=$(printf "$line")
    grep -Pq "£$line@" "$f" && percent_reads_classified=$(grep -P "£$line@" "$f" | awk -F "@" '{print $2}') || percent_reads_classified="0"
    printf "$taxon,$percent_reads_classified\n" >> "${nome}_percent_reads_classified_for_all_unique_taxa.txt"
  done < 2021_05_27_all_unique_taxa_from_kaiju_analysis_of_reads.txt
done

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
AC11J	AC11N	AC12J	AC14J	AC14N	AC15J	AC15N	AC16J	AC16N	AC18J	AC18N	AC19J	AC22J	AC23J	AC23N	AC25J	AC25N	AC28J	AC28N	AC32J	AC32N	AC33J	AC33N	AC35J	AC36J	AC36N	AC37J	AC37N	AC40J	AC40N	AC44J	AC44N	AC4J	AC5J	AC5N	AC6J	AC6N	AC7N	AC8J	AR10J	AR10N	AR13J	AR1J	AR1N	AR20J	AR20N	AR21J	AR21N	AR24J	AR26J	AR26N	AR27J	AR27N	AR29J	AR29N	AR2J	AR2N	AR30J	AR30N	AR31J	AR34J	AR34N	AR38J	AR3N	AR41N	AR42J	AR42N	AR43J	AR43N	AR45J	AR45N	AR46J	AR46N	AR47J	AR47N	AR48J	AR48N	AR9J	AR9N

MultiSimplex 2.0. Grabitech Solutions AB, Sundvall, Sweden, 2000; software available at http://www.multisimplex.com.

grep 'torques' AC6N_species_and_percentage_reads_detected.txt.pound_sign_at_start_of_line_and_at_sign_between_taxon_and_percent_reads.txt
[Ruminococcus] torques CAG:61

*_species_and_percentage_reads_detected.txt

cat 2021_05_27_all_unique_taxa_from_kaiju_analysis_of_reads.txt | tr -d '[:punct:]' > 2021_06_03_all_unique_taxa_punctuation_removed.txt

target=$(find -maxdepth 1 -type f -name "*_species_and_percentage_reads_detected.txt") && for f in $target ; do taxa_minus_punctuation=$(cat "$f" | awk -F "\t" '{print $1}' | grep -v "taxon_nam" | awk 'NF' | tr -d '[:punct:]' | sed 's/^/£/g') && sampleID=$(basename "$f" | awk -F "_" '{print $1}') && counts=$(cat "$f" | awk -F "\t" '{print $2}' | grep -v 'percent' | awk 'NF') && printf "$taxa_minus_punctuation" >> "${sampleID}_just_taxa.txt" && printf "${counts}" >> "${sampleID}_just_counts.txt" && paste -d '@' "${sampleID}_just_taxa.txt" "${sampleID}_just_counts.txt" >> ${sampleID}_no_punctuation_taxa_and_counts_at_sign_between_taxon_and_count_pound_sign_at_start.txt && rm "${sampleID}_just_taxa.txt" && rm "${sampleID}_just_counts.txt" && printf "\nProcessed files for sampleID:\t$sampleID\n" ; done


2021_06_03_all_unique_taxa_punctuation_removed.txt

#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J get_species_level_taxa_from_all_bins
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  deletion_target=$(find -maxdepth 1 -type f -name "*_percent_reads_classified_for_all_unique_taxa.txt")
  for f in $deletion_target ; do printf "\nRemoving file:\t$f\n" && rm "$f" ; done
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*_no_punctuation_taxa_and_counts_at_sign_between_taxon_and_count_pound_sign_at_start.txt")
for f in $target
do
  export nome=$(basename "$f" | awk -F "_" '{print $1}' | sed 's/$/_subsampled_to_uniform_depth/g')
  printf "$nome,Percent_reads_classified\n" > "${nome}_percent_reads_classified_for_all_unique_taxa.txt"
  printf "$nome\n" > "${nome}_just_percent_reads_classified_for_all_unique_taxa_in_same_order_as_list_file.txt"
  while read -r line
  do
    taxon=$(printf "$line")
    grep -Pq "£$line@" "$f" && percent_reads_classified=$(grep -P "£$line@" "$f" | awk -F "@" '{print $2}') || percent_reads_classified="0"
    printf "$taxon,$percent_reads_classified\n" >> "${nome}_percent_reads_classified_for_all_unique_taxa.txt"
    printf "$percent_reads_classified\n" >> "${nome}_just_percent_reads_classified_for_all_unique_taxa_in_same_order_as_list_file.txt"
  done < 2021_06_03_all_unique_taxa_punctuation_removed.txt
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304

cat 2021_05_27_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt | awk -F "@" '{print $2}' | tr -d '[:punct:]' >> 2021_06_03_all_taxa_for_species_level_kaiju_classification.txt

2021_06_03_all_taxa_for_species_level_kaiju_classification.txt

Buchnera aphidicola
target="Nitrosomonadales bacterium Swamp67" && "£$target@" AC5J_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt

target=$(find -maxdepth 1 -type f -name "*_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt") && for f in $target ; do sampleID=$(basename "$f" | awk -F "_" '{print $1}') && printf "Microorganism,$sampleID\n" >> "${sampleID}_2021_06_03_species_level_taxa_and_counts.csv" && while read -r line ; do taxon=$(echo "$line") && grep -q "£$taxon@" "$f" && taxon_and_count=$(grep "£$taxon@" "$f" | tr "@" "," | sed 's/£//g') && printf "$taxon_and_count\n" >> "${sampleID}_2021_06_03_species_level_taxa_and_counts.csv" || printf "$taxon,0" >> "${sampleID}_2021_06_03_species_level_taxa_and_counts.csv" ; done < 2021_06_03_all_taxa_for_species_level_kaiju_classification.txt ; done

target=$(find -maxdepth 1 -type f -name "*_modified_V3_collected_and_kilobase_and_library_adjusted_taxa_and_counts_pound_sign_first_at_sign_between_taxon_and_count.txt") && for f in $target ; do sampleID=$(basename "$f" | awk -F "_" '{print $1}') && printf "Microorganism,$sampleID\n" >> "${sampleID}_2021_06_03_species_level_taxa_and_counts.csv" && while read -r line ; do taxon=$(echo "$line") && grep -q "£$taxon@" "$f" && taxon_and_count=$(grep "£$taxon@" "$f" | tr "@" "," | sed 's/£//g') && printf "$taxon_and_count\n" >> "${sampleID}_2021_06_03_species_level_taxa_and_counts.csv" || printf "$taxon,0" >> "${sampleID}_2021_06_03_species_level_taxa_and_counts.csv" ; done < 2021_06_03_all_taxa_for_species_level_kaiju_classification.txt ; done

head -n -1 *kaiju_output-SPECIES.out | grep -v 'taxon_id' | grep -v 'Viruses' | grep -v 'cannot be assigned' | awk -F "\t" '{print $2}' | awk 'NF'
head -n -1 *kaiju_output-SPECIES.out | grep 'cannot be assigned'

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
2021_06_03_all_bins_all_taxids_pound_sign_at_start_at_sign_at_end.txt

while read -r line ; do taxid=$(echo "$line") && taxid_occurrence=$(grep -c "£$taxid@" 2021_06_03_all_bins_all_taxids_pound_sign_at_start_at_sign_at_end.txt) && printf "$taxid\t$taxid_occurrence\n" ; done < 2021_06_03_all_bins_only_unique_taxids.txt

2021_06_03_all_unique_taxids_count_occurence_across_all_bins.tsv

while read -r line ; do taxid=$(echo "$line" | awk -F "\t" '{print $1}') && taxon=$(grep "£$taxid@" 2021_05_27_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt | awk -F "@" '{print $2}' | tr -d '[:punct:]') && printf "$line\t$taxon\n" ; done < 2021_06_03_all_unique_taxids_count_occurence_across_all_bins.tsv > 2021_06_03_all_unique_taxids_count_occurence_across_all_bins_and_the_taxon_name.tsv

while read -r line ; do taxid=$(echo "$line" | awk -F "\t" '{print $1}') && occurences=$(grep "£$taxid@" 2021_06_03_all_taxids_all_bins_and_percent_reads_pound_sign_at_start_at_sign_between_taxid_and_percent_reads.txt | awk -F "@" '{print $2}' | tr "\n" "\t") && printf "$line\t$occurences\n" ; done < 2021_06_03_all_unique_taxids_count_occurence_across_all_bins_and_the_taxon_name.tsv > 2021_06_03_all_unique_taxids_count_occurence_across_all_bins_and_the_taxon_name_and_each_percent_contig_classification.tsv

mail -s '2021_06_03_all_unique_taxids_count_occurence_across_all_bins_and_the_taxon_name_and_average_percent_contigs_classified_as_that_taxon_across_all_bins' -a 2021_06_03_all_unique_taxids_count_occurence_across_all_bins_and_the_taxon_name_and_average_percent_contigs_classified_as_that_taxon_across_all_bins.tsv peter.osborne@earlham.ac.uk <<< "File 2021_06_03_all_unique_taxids_count_occurence_across_all_bins_and_the_taxon_name_and_average_percent_contigs_classified_as_that_taxon_across_all_bins.tsv should be attached"

grep '2498093' *kaiju_output-SPECIES.out

cat *kaiju_output-SPECIES.out | grep -v "file" | grep -v "cannot" | grep -v "Viruses" | awk -F "\t" '{print 4}' | grep -wc "1898203"

40100 2021_06_03_all_unique_taxa_punctuation_removed.txt

1898203

#!/bin/bash -eE

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  deletion_target=$(find -maxdepth 1 -type f -name "*_percent_reads_classified_for_all_unique_taxa.txt")
  for f in $deletion_target ; do printf "\nRemoving file:\t$f\n" && rm "$f" ; done
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*_no_punctuation_taxa_and_counts_at_sign_between_taxon_and_count_pound_sign_at_start.txt" -not -name "AC6J*")
for f in $target
do
  export nome=$(basename "$f" | awk -F "_" '{print $1}' | sed 's/$/_subsampled_to_uniform_depth/g')
  printf "$nome,Percent_reads_classified\n" #> "${nome}_percent_reads_classified_for_all_unique_taxa.txt"
  printf "$nome\n" #> "${nome}_just_percent_reads_classified_for_all_unique_taxa_in_same_order_as_list_file.txt"
  while read -r line
  do
    taxon=$(printf "$line")
    grep -Pq "£$line@" "$f" && percent_reads_classified=$(grep -P "£$line@" "$f" | awk -F "@" '{print $2}') || percent_reads_classified="0"
    printf "$taxon,$percent_reads_classified\n" #>> "${nome}_percent_reads_classified_for_all_unique_taxa.txt"
    printf "$percent_reads_classified\n" #>> "${nome}_just_percent_reads_classified_for_all_unique_taxa_in_same_order_as_list_file.txt"
  done < 2021_06_03_all_unique_taxa_punctuation_removed.txt
done

k141_11123955 2005473
cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '2005473') print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}'

source package /tgac/software/testing/bin/samtools-1.10

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304

samtools AC16N_Subsampled_BWA_reads_mapped_to_assembly_NEO_exclude_flags_2304_alignments_only.bam

for f in *_Subsampled_idxstats.txt ; do nome=$(basename "$f" | awk -F "_" '{print $1}') && printf "$nome\n" > "${nome}_2021_06_04_contig_mapping_counts_contig_alone.txt" && head -n -1 "$f" | awk -F "\t" '{print $3}' >> "${nome}_2021_06_04_contig_mapping_counts_contig_alone.txt" ; done

#!/bin/bash -eE

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
  deletion_target=$(find -maxdepth 1 -type f -name "*_percent_reads_classified_for_all_unique_taxa.txt")
  for f in $deletion_target ; do printf "\nRemoving file:\t$f\n" && rm "$f" ; done
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

awk '
{
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' 2021_06_04_all_contigs_all_samples_mapped_segment_counts-COPY.csv >> 2021_06_04_ROWS_all_contigs_all_samples_mapped_segment_counts.csv

echo "AC11J AC11N AC12J AC14J AC14N AC15J AC15N AC16J AC16N AC18J AC18N AC19J AC22J AC23J AC23N AC25J AC25N AC28J AC28N AC32J AC32N AC33J AC33N AC35J AC36J AC36N AC37J AC37N AC40J AC40N AC44J AC44N AC4J AC5J AC5N AC6J AC6N AC7N AC8J AR10J AR10N AR13J AR1J AR1N AR20J AR20N AR21J AR21N AR24J AR26J AR26N AR27J AR27N AR29J AR29N AR2J AR2N AR30J AR30N AR31J AR34J AR34N AR38J AR3N AR41N AR42J AR42N AR43J AR43N AR45J AR45N AR46J AR46N AR47J AR47N AR48J AR48N AR9J AR9N" | tr -d '[0123456789]' | tr " " "\t"

2021-06-07
 -U $f
sbatch TESTING_script_for_Silvia.sh PID-0578-r-Neg_S30_R1_001.fastq.gz PID-0578-r-Neg_S30_R2_001.fastq.gz Silvia_script_test

source package /tgac/software/testing/bin/phylophlan-3.0

source package /tgac/software/testing/bin/mash-2.2
#source package /tgac/software/testing/bin/fastme-2.1.5

/hpc-home/osbourne/Jolytree_home/REQ-master/src/REQ.jar
/hpc-home/osbourne/Jolytree_home/REQ-master/src/REQ.java

#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J library_adjust_all_contigs
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -not -name "AC16*" -not -name "AC18*" -not -name "AC19*" -not -name "AR27*" -not -name "AR29*" -not -name "AR34*") && for f in $target ; do basename "$f" ; done
for f in $target
do
  nome=$(basename "$f" | awk -F "_" '{print $1}')
  printf "Sample\t$nome\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  while read -r line
  do
    contig=$(echo "$line" | awk -F "\t" '{print $1}')
    cont_score=$(echo "$line" | awk -F "\t" '{print $2}')
    library_size="8.5"
    adjusted_score=$(echo "$cont_score / $library_size" | bc -l)
    printf "$contig\t$adjusted_score\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  done < "$f"
  printf "Sequence_run\tNovogene\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  host=$(echo "$nome" | cut -c1-2)
  printf "Host\t$host\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  season=$(echo "$nome" | rev | cut -c1-1)
  printf "Season\t$season" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  host_by_season=$(echo "$nome" | tr -d '[0123456789]')
  printf "Host_by_season\t$host_by_season\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
done


#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J library_adjust_all_contigs
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

inputname=$1
target=$(find -maxdepth 1 -type f -name "*Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -and -name "$inputname*") && for f in $target ; do basename "$f" ; done
for f in $target
do
  nome=$(basename "$f" | awk -F "_" '{print $1}')
  printf "Sample\t$nome\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  while read -r line
  do
    contig=$(echo "$line" | awk -F "\t" '{print $1}')
    cont_score=$(echo "$line" | awk -F "\t" '{print $2}')
    library_size="4.5"
    adjusted_score=$(echo "$cont_score / $library_size" | bc -l)
    printf "$contig\t$adjusted_score\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  done < "$f"
  printf "Sequence_run\tPilot\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  host=$(echo "$nome" | cut -c1-2)
  printf "Host\t$host\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  season=$(echo "$nome" | rev | cut -c1-1)
  printf "Season\t$season" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  host_by_season=$(echo "$nome" | tr -d '[0123456789]')
  printf "Host_by_season\t$host_by_season\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
done

AC12J

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

k141_16009809

AC12J

AR26J

#!/bin/bash -eE
#SBATCH -t 03-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J library_adjust_all_contigs
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

inputname=$1
target=$(find -maxdepth 1 -type f -name "*Subsampled_kilobase_adjusted_contig_mapping_scores.txt" -and -name "$inputname*") && for f in $target ; do basename "$f" ; done
for f in $target
do
  nome=$(basename "$f" | awk -F "_" '{print $1}')
  printf "Sample\t$nome\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  while read -r line
  do
    contig=$(echo "$line" | awk -F "\t" '{print $1}')
    cont_score=$(echo "$line" | awk -F "\t" '{print $2}')
    library_size="8.5"
    adjusted_score=$(echo "$cont_score / $library_size" | bc -l)
    printf "$contig\t$adjusted_score\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  done < "$f"
  printf "Sequence_run\tPilot\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  host=$(echo "$nome" | cut -c1-2)
  printf "Host\t$host\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  season=$(echo "$nome" | rev | cut -c1-1)
  printf "Season\t$season\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
  host_by_season=$(echo "$nome" | tr -d '[0123456789]')
  printf "Host_by_season\t$host_by_season\n" >> "${nome}_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv"
done


AR26J_Subsampled_kilobase_adjusted_contig_mapping_scores.txt
132973 AR26J_Subsampled_kilobase_adjusted_contig_mapping_scores.txt
132973 AC12J_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

cat AR26J_Subsampled_kilobase_adjusted_contig_mapping_scores.txt | awk -F "\t" '{print $2}' >> AR26J_TEMP_just_kilobase_adjusted_contigs.txt && lib_size="8.5" && while read -r line ; do count=$(echo "$line") && if [[ "$count" == 0 ]]; then export adjusted_count="0" ; else export adjusted_count=$(echo "$count / $lib_size" | bc -l) ; fi && printf "$adjusted_count\n" ; done < AR26J_TEMP_just_kilobase_adjusted_contigs.txt


#!/bin/bash -eE
#SBATCH -t 00-23:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J library_adjust_all_contigs
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

printf "AR26J\n" >> AR26J_TEMP_library_size_adjusted_counts_alone.txt
export lib_size="8.5"
while read -r line
do
  count=$(echo "$line")
  if [[ "$count" == "0" ]]
  then
    printf "0\n" >> AR26J_TEMP_library_size_adjusted_counts_alone.txt
  else
    export adjusted_count=$(echo "$count / $lib_size" | bc -l)
    printf "$adjusted_count\n" >> AR26J_TEMP_library_size_adjusted_counts_alone.txt
  fi
done < AR26J_TEMP_just_kilobase_adjusted_contigs.txt
printf "Novogene\n" >> AR26J_TEMP_library_size_adjusted_counts_alone.txt
printf "AR\n" >> AR26J_TEMP_library_size_adjusted_counts_alone.txt
printf "J\n" >> AR26J_TEMP_library_size_adjusted_counts_alone.txt
printf "ARJ\n" >> AR26J_TEMP_library_size_adjusted_counts_alone.txt

cat AR26J_Subsampled_kilobase_adjusted_contig_mapping_scores.txt | awk -F "\t" '{print $2}' >> AR26J_TEMP_just_kilobase_adjusted_contigs.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch


AC12J_Subsampled_kilobase_adjusted_contig_mapping_scores.txt

#!/bin/bash -eE
#SBATCH -t 00-23:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J library_adjust_all_contigs
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

printf "AC12J\n" >> AC12J_TEMP_library_size_adjusted_counts_alone.txt
export lib_size="8.5"
while read -r line
do
  count=$(echo "$line")
  if [[ "$count" == "0" ]]
  then
    printf "0\n" >> AC12J_TEMP_library_size_adjusted_counts_alone.txt
  else
    export adjusted_count=$(echo "$count / $lib_size" | bc -l)
    printf "$adjusted_count\n" >> AC12J_TEMP_library_size_adjusted_counts_alone.txt
  fi
done < AC12J_TEMP_just_kilobase_adjusted_contigs.txt
printf "Novogene\n" >> AC12J_TEMP_library_size_adjusted_counts_alone.txt
printf "AC\n" >> AC12J_TEMP_library_size_adjusted_counts_alone.txt
printf "J\n" >> AC12J_TEMP_library_size_adjusted_counts_alone.txt
printf "ACJ\n" >> AC12J_TEMP_library_size_adjusted_counts_alone.txt


AR26J_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv

paste -d "\t" TEMP_contigs_and_row_names.txt AR26J_TEMP_library_size_adjusted_counts_alone.txt >> AR26J_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv

paste -d "\t" TEMP_contigs_and_row_names.txt AC12J_TEMP_library_size_adjusted_counts_alone.txt >> AC12J_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv

target=$(find -maxdepth 1 -type f -name "*_2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv.SAFEGUARD") && for f in $target ; do cat "$f" | awk -F "\t" '{print $2}' >> "${f%}.just_numbers.txt" ; done

2021_06_09_rownames.txt

paste -d "," 2021_06_09_rownames.txt *2021_06_07_all_sample_all_contig_kilobase_and_library_size_adjusted.tsv.SAFEGUARD.just_numbers.txt >> 2021_06_09_all_samples_all_contigs_kilobase_and_library_size_adjusted_last_bits_are_strings_for_ID_host_etc.csv

target=$(find -maxdepth 1 -type f -name "*Subsampled_kilobase_adjusted_contig_mapping_scores.txt") && for f in $target ; do nome=$(basename "$f" | awk -F "_" '{print $1}') && cat "$f" | awk -F "\t" '{print $2}' >> "${nome}_kilobase_adjusted_only.txt" ; done

target=$(find -maxdepth 1 -type f -name "*_kilobase_adjusted_only.txt") && for f in $target ; do nome=$(basename "$f" | awk -F "_" '{print $1}') && cat "$f" | awk -F "\t" '{print $2}' >> "${nome}_kilobase_adjusted_only.txt" ; done


#!/bin/bash -eE
#SBATCH -t 00-23:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J split_individual_contigs
#SBATCH --mem=16gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*_kilobase_adjusted_only.txt" -and -name "$inputname*")
for f in $target
do
  nome=$(basename "$f" | awk -F "_" '{print $1}')
  printf "$nome\n" >> "${nome}_library_size_adjusted.txt"
  while read -r line
  do
    cont_score=$(echo "$line")
    library_size="8.5"
    adjusted_score=$(echo "$cont_score / $library_size" | bc -l | awk '{printf "%f", $0}')
    printf "$adjusted_score\n" >> "${nome}_library_size_adjusted.txt"
  done < "$f"
  printf "Novogene\n" >> "${nome}_library_size_adjusted.txt"
  host=$(echo "$nome" | cut -c1-2)
  printf "$host\n" >> "${nome}_library_size_adjusted.txt"
  season=$(echo "$nome" | rev | cut -c1-1)
  printf "$season\n" >> "${nome}_library_size_adjusted.txt"
  host_by_season=$(echo "$nome" | tr -d '[0123456789]')
  printf "$host_by_season\n" >> "${nome}_library_size_adjusted.txt"
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304/2021_06_09-working
/hpc-home/osbourne/Jolytree_home/JolyTree-master/All_bins_copies
/hpc-home/osbourne/Jolytree_home
/hpc-home/osbourne/Jolytree_home/JolyTree-master/TESTING_bins_dir
source package /tgac/software/testing/bin/phylophlan-3.0
/hpc-home/osbourne/Jolytree_home/JolyTree-master/Individual_contigs
source package /tgac/software/testing/bin/mash-2.2
source package /tgac/software/testing/bin/fastme-2.1.5

/hpc-home/osbourne/Jolytree_home/REQ-master/src/REQ.jar
/hpc-home/osbourne/Jolytree_home/REQ-master/src/REQ.java

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/results/OUTPUTS/Mapping_BAM_files

#!/bin/bash -eE
#SBATCH -t 00-23:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J split_individual_contigs
#SBATCH --mem=6gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

while read -r line
do
  contig_name=$(echo "$line")
  contig_details=$(grep -w "$line" *.fa | awk -F ":" '{print $2}')
  contig_content=$(grep -wa1 "$line" *.fa | tail -1 | awk -F "-" '{print $2}')
  printf "$contig_details\n$contig_content" >> "${contig_name}.sole_contig.fa"
  mv "${contig_name}.sole_contig.fa" /hpc-home/osbourne/Jolytree_home/JolyTree-master/Individual_contigs
done < 2021_06_09_list_of_all_contigs_all_bins.txt

#!/bin/bash -eE
#SBATCH -t 02-23:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Tidy_shift
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

target=$(find -maxdepth 5 -type f -name "*.bam.gz" -not -name "*.txt*")
for f in $target
do
  printf "\nWill move file:\t$f\tTo data\n"
  mv "$f" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/results/OUTPUTS/Mapping_BAM_files
  printf "\nMoved file:\t$f\tTo data\n"
done

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

nano ~/.bash_profile
export PATH=$PATH:</hpc-home/osbourne/Jolytree_home/REQ-master/src/REQ.jar
source package /tgac/software/testing/bin/jdk-9.0.4
REQ=REQ;

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304/2021_06_09-working
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas

sed 's/$/Sequence_run\nHost\nMonth\nHost_by_season/g'

paste -d "," Contigs_and_row_names.txt *_library_size_adjusted.txt >> 2021_06_10_all_samples_all_contigs_kilobase_and_library_size_adjusted.csv

2021-06-11

/hpc-home/osbourne/Jolytree_home/JolyTree-master

2021_05_27_all_taxa_for_species_level_kaiju_classification_pound_sign_then_TaxID_then_at_sign_then_species.txt
most_abundant_species.txt

for f in *_library_size_adjusted.txt ; do nome=$(basename "$f" | awk -F "_" '{print $1}') && cat "$f" | tr "\n" "," | sed 's/,$/\n/g' > "${nome}.single_row.csv" ; done

/hpc-home/osbourne/Jolytree_home/JolyTree-master/Culture_SPADES_assemblies
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch

target=$(find -maxdepth 2 -type f -name "*Kaiju_output.out") && for f in $target ; do kaiju2table -t /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp -n /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp -r species -o "${f%}.table.tsv" "$f" ; done

kaiju2table -t /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp -n /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp -r species -o output_file.tsv 18E_S13_Kaiju_output.out

target=$(find -maxdepth 3 -type f -name "*Kaiju_output.out.table.tsv") && for f in $target ; do cp "$f" Kaiju_results/ ; done

2021-06-19
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Mapping_to_culture_scaffolds_combined

while read -r line ; do scaffold_name=$(echo "$line" | awk -F "\t" '{print $1}') && scaffold_size=$(echo "$line" | awk -F "\t" '{print $2}') && kilobase_adjusted_size=$(echo "($scaffold_size / 1000)" | bc -l | awk '{printf "%f", $0}') && printf "$scaffold_name\t$kilobase_adjusted_size\n" >> 2021_06_19_kilobase_adjusted_scaffold_sizes.txt ; done < 2021_06_18_all_scaffolds_names_and_sizes_sizes_tab_separated_from_name.tsv

2021-06-20
for f in *kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv ; do sampleID=$(basename "$f" | awk -F "_" '{print $1}') && cat "$f" | awk -F "\t" '{print $2}' >> "${sampleID}_just_adjusted_counts.txt" ; done

AC15N_kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv

2021_06_20-just_sample_names.txt

AR45N_kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv

target=$(find -maxdepth 1 -type f -name "*kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv") && for f in $target ; do nome=$(basename "$f" | awk -F "_" '{print $1}') && printf "Culture\t$nome\n" >> "${nome}_per_culture_mapped_read_segment_counts_combined_for_all_scaffolds_subsampled_read_files.tsv" && while read -r line ; do samplename=$(echo "$line") && sum_for_sample=$(grep "$samplename" "$f" | awk -F "\t" '{print $2}' | paste -sd+ | bc -l) && printf "$samplename\t$sum_for_sample\n" >> "${nome}_per_culture_mapped_read_segment_counts_combined_for_all_scaffolds_subsampled_read_files.tsv" ; done < 2021_06_20-just_sample_names.txt ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Mapping_to_culture_scaffolds_combined

/tgac/software/testing/bin/core/../..//mauve/2.4.0/x86_64/lib/

Works on interactive - progressiveMauve Lactobacillus_amylolyticus_DSM_11664_firmicutes_GCF_0001784751_ASM17847v1_genomic.fa Lactobacillus_gallinarum_DSM_10532__JCM_2011_firmicutes_ASM143497v1_GCF_0014349751_ASM143497v1_genomic.fa

progressiveMauve --output=trial_output.mauve trial_1.fa trial_1.sslist trial_2.fa trial_2.sslist trial_3.fa trial_3.sslist
progressiveMauve --output=trial_output.mauve trial_1.fa othershit1 trial_2.fa othershit2 trial_3.fa othershit3

2021-06-23

source package /tgac/software/testing/bin/mauve-2.3.1
progressiveMauve --output=Testing.mauve /hpc-home/osbourne/Jolytree_home/JolyTree-master/Culture_SPADES_assembly_scaffolds_and_MIGA_closest_hits/trial_1.fa /hpc-home/osbourne/Jolytree_home/JolyTree-master/Culture_SPADES_assembly_scaffolds_and_MIGA_closest_hits/trial_2.fa

2021-06-25
source package /tgac/software/testing/bin/raxml-8.2.12
raxmlHPC -h

2021-06-28
for f in *.fa ; do bin_name=$(basename "$f" | awk -F ".f" '{print $1}') && contigs=$(grep ">" "$f" | awk -F " " '{print $1}' | sed 's/>//g' | sed "s/$/@\t$bin_name/g") && printf "$contigs\n" ; done | awk 'NF' >> /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304/2021_06_09-working/2021_06_28_all_contigs_and_their_bins.txt

2021-06-29
targets=$(find -maxdepth 2 -type f -name "*_SPADES_careful_assembly-scaffolds.fasta") && for f in $targets ; do cp "$f" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Cleansed_reads/All_careful_scaffolds && echo "Copied file: $f" ; done

perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' in.fasta > out.fasta

source package /tgac/software/testing/bin/bbmap-38.06
reformat.sh in=13A_S1_SPADES_careful_assembly-scaffolds-Single_line.fasta out=13A_S1_SPADES_careful_assembly-scaffolds-Single_line-500bp_and_over.fasta minlength=500
for f in *.fasta ; do nome=$(basename "$f" | sed 's/-scaffolds/-scaffolds-Single_line/g') && reformat.sh in="$f" out="$nome" minlength=500 && sleep 3s ; done
for f in *Over_500bp_only.fasta ; do nome=$(basename "$f" | sed 's/-scaffolds-/-scaffolds-Single_line-/g') && perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' "$f" > "$nome" && sleep 2s ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/Cleansed_reads/All_careful_scaffolds
https://github.com/raymondkiu/bioinformatics-tools

tail -n+2

16aC_S26_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fasta	13E_S5_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fasta	99.9708	701	721

unique_KEGG_KOs_and_their_names.tsv
contigs_KEGG_best_hits.tsv
2988356 kegg hits total

#!/bin/bash -eE
#SBATCH -t 00-08:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J KO_Count
#SBATCH --mem=1gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

keg_total="2988356" && while read -r line ; do kog=$(echo "$line" | awk -F "\t" '{print $1}') && functio=$(echo "$line" | awk -F "\t" '{print $2}') && occurence=$(grep -wc "$kog" contigs_KEGG_best_hits.tsv) && proportion=$(echo "($occurence / $keg_total) * 100" | bc -l) && printf "$kog\t$occurence\t$proportion\t$functio\n" >> 2021_06_29_Occurence_and_proportion_of_all_KEG_hits_for_each_KO.tsv ; done < unique_KEGG_KOs_and_their_names.tsv

K02004

2021-07-02
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/Chris_Q-Seb_R-assemblies_and_co-assemblies/99aab1ea-af6a-4ad1-9e88-5e59e4a6815f/coassembly/annotation

2021-07-05
cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304/2021_06_09-working
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
source package 7b014e53-984f-4a0d-8b31-13d189fef2fd
raxml-ng --check --msa-format PHYLIP --msa XnIM7xSHMGoEf61NWq_2021_Jun_30_Mauve_output.phy --model GTR+G

/hpc-home/osbourne/Mauve_careful_SPADES_assembly_only_over_500bp_contigs/mugsy_x86-64-v1r2.3
Parsing sequences for 18C_S11_SPADES_careful_assembly_scaffolds_Single_line_Over_500bp_only  num_seqs:1
Parsing sequences for GCF_000014505_1_ASM1450v1_genomic_Single_line  num_seqs:1
Parsing sequences for GCF_002282915_1_ASM228291v1_genomic_Single_line  num_seqs:1
Parsing sequences for GCF_009428965_1_ASM942896v1_genomic_Single_line  num_seqs:1
Parsing sequences for GCF_014656585_1_ASM1465658v1_genomic_Single_line  num_seqs:3
Parsing sequences for GCF_016127775_1_ASM1612777v1_genomic_Single_line  num_seqs:2
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch

2021-07-06
DngiKTgkbeqJzFd3ML_2021_Jul_6_Mugsy_run.maf
msaconverter.py
source package 7b014e53-984f-4a0d-8b31-13d189fef2fd
raxml-ng --check --msa DngiKTgkbeqJzFd3ML_2021_Jul_6_Mugsy_run.phy --model GTR+G --prefix T1
raxml-ng --parse --msa-format PHYLIP --msa DngiKTgkbeqJzFd3ML_2021_Jul_6_Mugsy_run.phy --model GTR+G --prefix T2
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Mugsy
XnIM7xSHMGoEf61NWq_2021_Jun_30_Mauve_output.xmfa
python3 msaconverter.py -i DngiKTgkbeqJzFd3ML_2021_Jul_6_Mugsy_run.maf -o DngiKTgkbeqJzFd3ML_2021_Jul_6_Mugsy_run.fasta -p maf -q fasta
source package /tgac/software/testing/bin/phast-1.3
phyloFit --tree 6_Jul_20215GYnHI3Sh9Abrj4b_JolyTree_run_Careful_SPADES_assembly_cultures_scaffolds_and_closest_and_representatives.nwk --out-root DngiKTgkbeqJzFd3ML_2021_Jul_6_Mugsy_run_with_6_Jul_2021_5GYnHI3Sh9Abrj4b_JolyTree_run_Careful_SPADES_assembly_cultures_scaffolds_and_closest_and_representatives --msa-format MAF --log --msa DngiKTgkbeqJzFd3ML_2021_Jul_6_Mugsy_run.maf > phylofit_trial_all_default_settings.mod
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

old_nam=$(echo "$line" | awk -F " " '{print $1}') && new_nam=$(echo "$line" | awk -F " " '{print $2}') && sed -i -e "s/$new_nam/$old_nam/g" modified_tree_2.nwk ; done < tree_conversion_list.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304/2021_06_09-working
while read -r line ; do oldname=$(echo "$line" | awk -F " " '{print $1}' | awk -F ".fa" '{print $1}') && newname=$(echo "$line" | awk -F " " '{print $2}') && sed -i -e "s/$oldname/$newname/g" negative_values_changed_to_1-7_Jul_20215Wk8Os5ymLPiz4SR_JolyTree_run_Careful_SPADES_assembly_cultures_scaffolds_and_closest_and_representatives.nwk || echo "" ; done < list_of_downloaded_files_and_their_identities.txt

2021-07-07
while read -r line ; do kog=$(echo "$line" | awk -F "\t" '{print $1}') && countof=$(echo "$line" | awk -F "\t" '{print $2}') && nameof=$(grep "$kog" 2021_07_02_all_KOs_and_their_names.txt | awk -F "\t" '{print $2}') && printf "$kog\t$countof\t$nameof\n" ; done < 2021_07_02-Number_of_ORFS_as_contigs_for_each_KO_from_all_bins.tsv | sort -k2 -V > 2021_07_07_all_unique_KOs_and_count_and_name.tsv

2021-07-08
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka version 1.14.6
/hpc-home/osbourne/Jolytree_home/JolyTree-master/2021_07_07_restricted_set_of_files_for_Jolytree

2021-07-09
for f in *genomic.fna ; do new_name=$(head -1 "$f" | sed 's/>//g' | sed 's/,//g' | sed 's/ /_/g' | sed 's/=//g') && printf "$new_name\n" && mv "$f" "${new_name}.fa" ; done

mv: cannot move ‘GCF_011304595.1_ASM1130459v1_genomic.fna’ to ‘NZ_CP034997.1_Lactiplantibacillus_plantarum_strain_LS/07_chromosome_complete_genome.fa’: No such file or directory

tree_conversion_list.txt

modified_tree.nwk

while read -r line ; do new_name=$(echo "$line" | awk -F " " '{print $1}') && old_name=$(echo "$line" | awk -F " " '{print $2}') && sed -i -e "s/$old_name/$new_name/g" modified_tree.nwk ; done < tree_conversion_list.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_and_all_Lactobacillaceae_refseq

2021-07-11
contigs_KEGG_best_hits.tsv
Contigs_and_row_names.txt
2021_07_11-Unique_contigs_list.txt
true_name=$(cat /tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp | awk '{if ($1 == '"$line"') print $0;}' | grep "scientific name" | awk -F "\t" '{print $3}')
2021_07_11-contigs_KEGG_best_hits-tabs_replaced_with_at_signs_spaces_replaced_with_underscores.txt

2021-07-12
k141_761
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/Chris_Q-Seb_R-assemblies_and_co-assemblies/99aab1ea-af6a-4ad1-9e88-5e59e4a6815f/coassembly
k141_15672231_1
while read -r line ; do contig=$(printf "${line}_") && best_hit_for_contig=$(grep "$contig" contigs_KEGG_best_hits.tsv | sort -k4 -V | tail -1 | awk -F "\t" '{print $1"\t"$6}') && printf "$best_hit_for_contig\n" | awk 'NF' >> 2021_07_12-Best_hit_actual_unique_contigs.tsv ; done < 2021_07_11-Unique_contigs_list.txt

2021-07-13
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_and_all_Lactobacillaceae_refseq
cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Smart_mapping_subsampled_reads_to_bin_concatenated_index/Neo_primary_alignments_avoid_flags_2304/2021_06_09-working
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

/hpc-home/osbourne/Comprehensive_Antibiotic_Resistance_Database_April_2021_V_3.1.2/nucleotide_fasta_rRNA_gene_variant_model.fasta

2021-07-21
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references

2021-07-25
for f in *SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa ; do nome=$(basename "$f" | awk -F "_" '{print $1"_"$2"_"$3}') && cat "$f" | sed "s/>/>$nome-/g" >> 2021_07_25-SPADES_cultures_unique_combined_reference.fasta ; done
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_07_25-SPADES_cultures_unique_combined_reference
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_07_25-SPADES_cultures_unique_combined_reference
2021_07_25-SPADES_cultures_unique_combined_reference

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_07_25-SPADES_cultures_unique_combined_reference

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Subsampled_testing

2021-07-26
samtools view -@1 -b -F 2304 AC44J_BWA_against_bins_Mapped.bam >> AC44J_BWA_against_bins_Mapped-Only_primary.bam
samtools sort -@1 -l 0 -m 1G -O BAM AC44J_BWA_against_bins_Mapped-Only_primary.bam >> AC44J_BWA_against_bins_Mapped-Only_primary-Sorted.bam
samtools index -@ 1 -b AC44J_BWA_against_bins_Mapped-Only_primary-Sorted.bam
samtools idxstats AC44J_BWA_against_bins_Mapped-Only_primary-Sorted.bam

39B_S15_SPADES-NODE_92_length_563_cov_18.537402

list_of_all_contigs_in_combined_reference.txt
while read -r line ; do contig=$(echo "$line") && length=$(echo "$line" | awk -F "_" '{print $6}') && printf "\n$contig\t$length" >> list_with_contigs_then_lengths_tab_separated.tsv ; done < list_of_all_contigs_in_combined_reference.txt
Pilot_SampleID_list.txt
AC16
AC18
AC19
AR27
AR29
AR34
list_with_contigs_then_lengths_tab_separated.tsv

for f in *kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv ; do sampleID=$(basename "$f" | awk -F "_" '{print $1}') && total_possible_contigs_to_map_to=$(head -n -1 "$f" | grep 'SPADES' | wc -l) && actual_mapped_contigs=$(head -n -1 "$f" | grep 'SPADES' | awk -F "\t" '($NF>0){print $0}' | wc -l) && printf "\n$sampleID\t$total_possible_contigs_to_map_to\t$actual_mapped_contigs" ; done


cat AR9J_kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv | head -n -1 | grep 'SPADES' | awk -F "\t" '($NF==0){print $0}'

2021_07_26-Contigs_from_combined_unique_cultures_over_500bp_in_size_combined_reference_which_some_samples_did_not_map_to.txt

2021_07_26-Kilobase_and_library_size_adjusted_contig_mapping_scores_mapping_subsampled_reads_to_combined_unique_original_cultures_contigs_only_larger_than_500bp.csv

while read -r line ; do grep "$line" *kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv ; done < 2021_07_26-Contigs_from_combined_unique_cultures_over_500bp_in_size_combined_reference_which_some_samples_did_not_map_to.txt

2021_07_26-Contigs_from_combined_unique_cultures_over_500bp_in_size_combined_reference_which_some_samples_did_not_map_to.txt

while read -r line ; do contig=$(echo "$line") && samples_found_in=$(grep -c "$line" 2021_07_26-Contigs_from_combined_unique_cultures_over_500bp_in_size_combined_reference_which_some_samples_did_not_map_to-AND_occurences.txt) && printf "$contig\t$samples_found_in\n" ; done < 2021_07_26-Contigs_from_combined_unique_cultures_over_500bp_in_size_combined_reference_which_some_samples_did_not_map_to.txt

list_of_all_contigs_in_combined_reference.txt

while read -r line ; do contig=$(echo "$line") && samples_mapping=$(grep "$line" *kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv | awk -F "\t" '($NF>0){print $0}' | wc -l) && printf "$contig\t$samples_mapping\n" ; done < list_of_all_contigs_in_combined_reference.txt
for f in *_kilobase_and_library_size_adjusted_mapped_segment_read_counts.tsv ; do nome=$(basename "$f" | awk -F "_" '{print $1}') && cat "$f" | awk 'NF' | awk -F "\t" '{print $2}' >> "${nome}_just_counts_ready_for_merging.txt" && printf "\nProcessed file:\t$f" ; done

echo "AC11J	AC11N	AC12J	AC14J	AC14N	AC15J	AC15N	AC16J	AC16N	AC18J	AC18N	AC19J	AC22J	AC23J	AC23N	AC25J	AC25N	AC28J	AC28N	AC32J	AC32N	AC33J	AC33N	AC35J	AC36J	AC36N	AC37J	AC37N	AC40J	AC40N	AC44J	AC44N	AC4J	AC5J	AC5N	AC6J	AC6N	AC7N	AC8J	AR10J	AR10N	AR13J	AR1J	AR1N	AR20J	AR20N	AR21J	AR21N	AR24J	AR26J	AR26N	AR27J	AR27N	AR29J	AR29N	AR2J	AR2N	AR30J	AR30N	AR31J	AR34J	AR34N	AR38J	AR3N	AR41N	AR42J	AR42N	AR43J	AR43N	AR45J	AR45N	AR46J	AR46N	AR47J	AR47N	AR48J	AR48N	AR9J	AR9N" | sed 's/AR//g' | sed 's/AC//g' | tr -d '[0123456789]' | tr " " "\t"

Original_cultures_only_500bp_and_larger_contigs-Closest_MIGA_hits.txt

while read -r line ; do taxon=$(echo "$line" | awk -F "\t" '{print $2}') && ident=$(echo "$line" | awk -F "\t" '{print $1}') && sed -i -e "s/$ident/$taxon/g" TRANSPOSED_trimmed_names_2021_07_26-Contigs_from_combined_unique_cultures_over_500bp_in_size_combined_reference-all_contigs_kilobase_and_library_size_adjusted_mapped_segment_read_counts.csv || printf "\nNothing there for ident:\t$ident\n" ; done < Cultures_and_closest_match_from_MIGA.txt

2021-07-27
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_original_cultures_after_under_500bp_filtering_and_duplicate_removal
short_summary.generic.bacteria_odb10.13B_S2_BUSCO_output.txt.txt
target=$(find -maxdepth 3 -type f -name "short_summary.generic.bacteria_*" -a -name "*_BUSCO_output.txt.txt") && for f in $target ; do sampleID=$(basename "$f" | awk -F "odb10." '{print $2}' | awk -F "_" '{print $1"_"$2}') && completeness=$(cat "$f" | grep "C:" | awk -F "S" '{print $1}' | cut -c2- | tr -d "[]:%" | cut -c2-) && printf "\n$sampleID,$completeness" >> 2021_07_27-BUSCO_scores_for_original_culture_assemblies_only_contigs_larger_than_500bp-Completeness_percentages.csv ; done
LIFCKDEM_00001
DJOLKKHL_00001
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-07-27_Reads_to_Bins_mapping

2021-07-28
/nbi/software/testing/kraken/1.1/arrivals
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/genomes_from_Nancy_Teng_provided_by_Magda_Kujawska-2021-07-27
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/genomes_from_Nancy_Teng_provided_by_Magda_Kujawska-2021-07-27

#!/bin/bash -eE
#SBATCH -t 00-01:50
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Scheduler_BAM_processing
#SBATCH --mem=4gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-07-26
#Just submits each of the mapped bam files mapping the name filter in the find
#command to scripts which filter, sort, index and then get the stats for them.

source package /tgac/software/testing/bin/samtools-1.7

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*_Mapped.bam")
for f in $target
do
  subject=$(basename "$f")
  job_name=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ; echo '' | sed 's/$/-BAM_processing/g')
  label=$(basename "$f" | awk -F "-" '{print $1"_"$2}' | awk -F "_" '{print $1"_"$2"_"$3"_"$4}')
  sbatch --job-name="$job_name" 2021-07-26_Process_mapped_BAM_files.sh "$subject" "$label"
  printf "\nSubmitted file:\t$subject\n"
  sleep 3s
done

2021_07_27-AC28N_BWA_against_bins_Mapped.bam

2021-08-02
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-07-27_Reads_to_Bins_mapping
grep '>' *.fa | awk -F " " '{print $1"\t"$4}' | tr -d ">" | sed 's/len=//g' | awk -F ":" '{print $2}' >> 2021_08_02-All_contigs_and_their_lengths_tab_separated.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021_08_02-All_contigs_and_their_lengths_tab_separated.tsv
k141_14674324
grep 'k141_14674324' *_kaiju_output.out

while read -r line ; do contig=$(echo "$line" | awk -F "\t" '{print $1}') && TaxID=$(grep "$contig" *_kaiju_output.out | awk -F ":" '{print $2}' | awk -F "\t" '{print $3}') && containing_bin=$(grep "$contig" *_kaiju_output.out | awk -F ":" '{print $1}' | sed 's/binned/Bin/g' | awk -F "_" '{print $1"_"$2}') && printf "$line\t$TaxID\t$containing_bin\n" ; done < /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021_08_02-All_contigs_and_their_lengths_tab_separated.tsv
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/FastP_output/Magda_prodvided_cultures/all_QCed_fastq_files

2021_08_02-All_contigs_and_their_lengths_tab_separated.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Comprehensive_Antibiotic_Resistance_Database_April_2021_V_3.1.2/Subsampled_reads_mapping
CARD-nucleotide_fasta_protein_variant_model
CARD-nucleotide_fasta_protein_variant_model.fasta

CARD-concatenated_fasta_all_models.fasta

sbatch --dependency=afterok:37485854 2021_08_02-Map_subsampled_reads_to_CARD_scheduler_script.sh Subsampled_reads

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

2021-08-03
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021_08_02-All_contigs_and_their_lengths_and_TaxID_and_containing_Bin_tab_separated.tsv
k141_11744694	10526	2	Bin_m994
k141_4886867	7502	2088	Bin_m994
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-07-27_Reads_to_Bins_mapping

S127_Fastp_SPADES_careful_assembly-scaffolds.fasta
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/FastP_output/Magda_prodvided_cultures/all_QCed_fastq_files/all_careful_SPADES_assemblies

2021-08-04
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/FastP_output/Magda_prodvided_cultures/all_QCed_fastq_files/all_careful_SPADES_assemblies
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references

2021_07_27_AC33N-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv
sed -i '$ d' foo.txt

filename="example.txt"

file_size="$(stat --format=%s "$filename")"
trim_count="$(tail -n1 "$filename" | wc -c)"
end_position="$(echo "$file_size - $trim_count" | bc)"

dd if=/dev/null of="$filename" bs=1 seek="$end_position"

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-07-27_Reads_to_Bins_mapping
2021-08-04_unique_TaxIDs_from_all_classified_contigs.txt
2021_08_02-All_contigs_and_their_lengths_and_TaxID_and_containing_Bin_tab_separated.tsv
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021-08-04_Unique_TaxIDs_and_their_associated_contigs.tsv

while read -r line
do
  contig=$(echo "$line" | awk -F "," '{print $1}')
  contig_length=$(echo "$line" | awk -F "," '{print $2}')
  adjusted_mapped_read_segment_count=$(echo "$line" | awk -F "," '{print $3}')
  unmapped_read_segment_count=$(echo "$line" | awk -F "," '{print $4}')
  taxid=$(grep -w "$contig" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021-08-04_Unique_TaxIDs_and_their_associated_contigs.tsv | awk -F "\t" '{print $1}')
  printf "$taxid\t$adjusted_mapped_read_segment_count\n"
done < $1


while read -r line ; do contig=$(echo "$line" | awk -F "," '{print $1}') && taxids=$(grep -w "$contig" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/2021-08-04_Unique_TaxIDs_and_their_associated_contigs.tsv | awk -F "\t" '{print $1}' | wc -l) && printf "$contig\t$taxids\n" ; done < 2021_07_27_AC14J-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv

2021-08-05
1177
2021_07_27_AR34J-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv.TaxID_collected_contig_and_library_size_adjusted_scores.tsv

Taxa possibly with no contigs:
1177
258
262
487
685
840
peter.osborne@earlham.ac.uk
S128 - MK provided isolate, NT cultured, SPADES careful assembled, contig min size 500bp
awk '{printf "%f", $0}')

trial_taxid="262" && grep -q "$trial_taxid" 2021-08-06_Bad_TaxIDs_list.txt && echo "Is a bad contig" || echo "Is not a bad contig"


2021-08-06
2729598
2729626
2732487

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-07-27_Reads_to_Bins_mapping
for f in *.fa ; do oldname=$(basename "$f") && newname=$(echo "$oldname" | sed 's/^/iMGMC_high_quality_representative_MAG_/g') && echo "$newname" && mv "$f" "$newname" ; done

2021-08-06_Useful_taxids.txt
2021_07_27_AR9N-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv.TaxID_collected_contig_and_library_size_adjusted_scores.tsv
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output

2021-08-07
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output/./iMGMC_high_quality_representative_MAG_extra-SRR1703492.71_kaiju_output.out	95.121948	39	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output/./iMGMC_high_quality_representative_MAG_extra-SRR6032582.32_kaiju_output.out	78.313255	65	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output/./iMGMC_high_quality_representative_MAG_extra-SRR6032585.9_kaiju_output.out	100.000000	223	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output/./iMGMC_high_quality_representative_MAG_extra-SRR6032586.18_kaiju_output.out	92.156860	47	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output/./iMGMC_high_quality_representative_MAG_extra-SRR6216947.8_kaiju_output.out	95.000000	38	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output/./iMGMC_high_quality_representative_MAG_extra-SRR8581397.1_kaiju_output.out	100.000000	55	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output/./iMGMC_high_quality_representative_MAG_single-China_8-7_110307.17_kaiju_output.out	89.743591	35	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/dereplicated_genomes/Kaiju_output/./iMGMC_high_quality_representative_MAG_single-China_S-Fe4_120413.52_kaiju_output.out	92.465752	135	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;

iMGMC_high_quality_representative_MAG_extra-SRR2665308.7_kaiju_output.out

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/./binned_c1617_kaiju_output.out	92.647057	63	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/./binned_c634_kaiju_output.out	86.770424	446	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/./binned_c770_kaiju_output.out	95.061729	77	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/./binned_c951_kaiju_output.out	91.162788	196	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/./binned_m1122_kaiju_output.out	72.222221	52	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/./binned_m1301_kaiju_output.out	100.000000	27	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/./binned_m1485_kaiju_output.out	95.238098	40	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/./binned_m372_kaiju_output.out	95.161285	177	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/./binned_m780_kaiju_output.out	90.000000	99	1578	cellular organisms;Bacteria;Terrabacteria group;Firmicutes;Bacilli;Lactobacillales;Lactobacillaceae;Lactobacillus;

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references

2021-08-08
/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp
cat Kaiju_1.7.3_names.dmp | awk '{if ($1 == '2489218') print $0;}' | head -1 | awk -F "|" '{print $2}' | tr -d "\t"
2021-08-06_Useful_taxids.txt

2021-08-09
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references

[S121_FastP_SPADES_careful_min_contig_length_500_bp]
q1=/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/FastP_output/Magda_prodvided_cultures/all_QCed_fastq_files/S121_Fastp_FastP_R1.fastq
q2=/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/FastP_output/Magda_prodvided_cultures/all_QCed_fastq_files/S121_Fastp_FastP_R2.fastq

S121_Fastp_SPADES_careful_assembly-scaffolds.fasta.500bp_min_length_contigs_only.fasta

2021-08-06_Combined_contig_and_library_size_adjusted_taxid_summed_mapped_read_segment_counts.csv

2021-08-09_Combined_contig_and_library_size_adjusted_Taxa_names_summed_mapped_read_segment_counts.csv
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/All_cultures_for_FastANI

2021-08-18
S123_Fastp_SPADES_careful_assembly-scaffolds.fasta.500bp_min_length_contigs_only.fasta
for f in *Fastp_SPADES_careful_assembly-scaffolds.fasta.500bp_min_length_contigs_only.fasta ; do file_name=$(basename "$f" | awk -F "_" '{print $1}') && cat "$f" | sed "s/>/>$file_name-/g" >> 2021-08-18_Magda_provided_cultures_combined_reference_fasta_only_contigs_over_500bp_all_cultures.fa && printf "\n$file_name" ; done

2021-08-18_Magda_provided_cultures_combined_reference_fasta_only_contigs_over_500bp_all_cultures.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Culture_reads/FastP_output/Magda_prodvided_cultures/all_QCed_fastq_files/all_careful_SPADES_assemblies
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Magda_provided_culture_mapping_reference

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Magda_provided_culture_mapping_reference
2021-08-18_Magda_provided_cultures_combined_reference_fasta_only_contigs_over_500bp_all_cultures.fa
2021-08-18_Magda_provided_cultures_combined_reference_fasta_only_contigs_over_500bp_all_cultures

2021-08-18
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-18-Mapping_to_Magda_provided_culture_assemblies_contigs_min_size_500bp
2021_07_27-AC4J_BWA_against_Magda_cultures_Mapped.bam
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-18-Mapping_to_Magda_provided_culture_assemblies_contigs_min_size_500bp
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Magda_provided_culture_mapping_reference/2021-08-18_Magda_provided_cultures_combined_reference_fasta_only_contigs_over_500bp_all_cultures-Individual_contigs-Includes_lengths.tsv

#Put zero ahead of period for bc calculations = awk '{printf "%f", $0}'

grep 'S128-NODE_15_length_45252_cov_44.198893' *.csv

2021-08-18_Magda_provided_isolates_SPADES_assemblies_combined_Contigs_min_size_500bp.txt

for f in *-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv ; do nome=$(basename "$f" | awk -F "_" '{print $4}' | awk -F "-" '{print $1}') && touch "2021-08-18_${nome}-contig_and_library_size_adjusted_mapped_read_segment_counts_in_order.txt" && printf "$nome\n" > "2021-08-18_${nome}-contig_and_library_size_adjusted_mapped_read_segment_counts_in_order.txt" && cat "$f" | awk -F "," '{print $3}' >> "2021-08-18_${nome}-contig_and_library_size_adjusted_mapped_read_segment_counts_in_order.txt" && echo "Processed file $nome" ; done

2021-08-19
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-19-Combined_all_cultures_both_Magda_provided_and_Acomys_SPADES_careful_assemblies_reference
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-19-Combined_all_cultures_both_Magda_provided_and_Acomys_SPADES_careful_assemblies_reference/2021-08-19_Combined_all_cultures_both_Magda_provided_and_Acomys_SPADES_careful_assemblies_reference.fasta

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-19-Combined_all_cultures_both_Magda_provided_and_Acomys_SPADES_careful_assemblies_reference

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-19-Combined_all_cultures_both_Magda_provided_and_Acomys_SPADES_careful_assemblies_reference
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-19-Combined_all_cultures_both_Magda_provided_and_Acomys_SPADES_careful_assemblies_reference/2021-08-19_Combined_all_cultures_both_Magda_provided_and_Acomys_SPADES_careful_assemblies_reference.fasta
2021-08-18_BWA-mem_mapping_to_combined_All_cultures_both_host_sets_SPADES_assemblies_contigs_min_size_500bp-Execution.sh

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-18-Mapping_to_Magda_provided_culture_assemblies_contigs_min_size_500bp

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-08-19_Mapping_subsampled_reads_to_reference_made_from_all_isolates_both_source_sets
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

for f in *Only_primary-Sorted-IDXStats.txt ; do sed -i '$ d' "$f" && printf "\nProcessed file:\t$f" ; done

for f in *-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv ; do nome=$(basename "$f" | awk -F "_" '{print $4}' | awk -F "-" '{print $1}') && printf "$nome\n" >> "2021-08-20_${nome}-just_adjusted_counts.txt" && cat "$f" | awk -F "," '{print $3}' >> "2021-08-20_${nome}-just_adjusted_counts.txt" && printf "\nProcessed file:$nome" ; done

2021-08-20_just_all_contigs_in_order.txt

2021-08-20
S121-NODE_22_length

cah-contigs = 2:869
rus-contigs = 870:1309
LI/uk-contigs= 1310:2489

2021-08-23
sort | uniq -c | grep '^\s*3\s' | sed 's/^\s*[0-9]*\s*//' for triplicates; replace "3" with any N for N-plicates

>gb|HG738867|-|2786398-2788945|ARO:3003900|Escherichia coli CyaA with mutation conferring resistance to fosfomycin [Escherichia coli str. K-12 substr. MC4100]

2021-08-23-CARD_mapping_execution.sh

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

2021-08-24
2021-08-24_2nd_attempt_CARD_mapping_script-Execution.sh

2021-09-01
cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch
2021_08_02-All_contigs_and_their_lengths_and_TaxID_and_containing_Bin_tab_separated.tsv

k141_14366499	6747	2489215	Bin_c0

2021-09-01_all_contigs_length_containing_bin.txt

trial="Bin_m994"

while read -r line ; do bin=$(printf "$line") && contigs=$(grep -w "$bin" 2021-09-01_all_contigs_length_containing_bin.txt | awk -F "," '{print $1}' | tr "\n" ",") && printf "\n$bin,$contigs" >> 2021-09-01_all_bins_and_their_contigs.csv ; done < isolate_bins_trial.txt

2021_07_27_*-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv

2021_07_27_AR26N-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv

Bin_m994

2021-09-02
2021_07_27_AR42N-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv.bin_collected_contig_and_library_size_adjusted_scores.tsv

2021_07_27_*-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv.bin_collected_contig_and_library_size_adjusted_scores.tsv

for f in 2021_07_27_*-Only_primary-Sorted-IDXStats.txt_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv.bin_collected_contig_and_library_size_adjusted_scores.tsv ; do nome=$(basename "$f" | awk -F "_" '{print $4}' | awk -F "-" '{print $1}') && printf "$nome\n" > "${nome}-just_summed_bin_counts.txt" && cat "$f" | awk -F "\t" '{print $2}' >> "${nome}-just_summed_bin_counts.txt" ; done

list_of_bins_in_order.txt
-just_summed_bin_counts.txt

paste -d "," list_of_bins_in_order.txt *-just_summed_bin_counts.txt
AR9J = Bin_m1981	25.952724

2021-09-03
cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch
*kaiju_output-GENERA.out
binned_m1226_kaiju_output-SPECIES.out
*kaiju_output-SPECIES.out

target=$(find -maxdepth 1 -type f -name "*kaiju_output-SPECIES.out")
for f in $target
do
  nome=$(basename "$f" | awk -F "_" '{print $1"_"$2}' | sed 's/binned/Bin/g')
  top_species=$(head -2 "$f" | tail -1 | rev | awk -F ";" '{print $2}' | rev)
  top_species_abundance=$(head -2 "$f" | tail -1 | awk -F "\t" '{print $2}')
  if [[ "$top_species_abundance" -ge 50 ]]
  then
    printf "$nome\t$top_species\t$top_species_abundance\n" >> 2021-09-03_Bins_with_at_least_50_percent_contigs_top_species.tsv
  elif [[ "$top_species_abundance" -lt 50  ]]
  then
    printf "$nome\t$top_species\t$top_species_abundance\n" >> 2021-09-03_Bins_with_under_50_percent_contigs_top_species.tsv
  fi
  printf "\nProcessed file:\t$f"
done

while read -r line ; do bin=$(echo "$line") && grep -wq "$bin" 2021-09-03_Bins_with_at_least_50_percent_contigs_top_species.tsv && checked="Y" || checked="N" && if [[ "$checked" == "Y" ]] ; then taxon=$(grep -w "$bin" 2021-09-03_Bins_with_at_least_50_percent_contigs_top_species.tsv | awk -F "\t" '{print $2}') && printf "\n$taxon" ; fi ; done < 2021-09-03_Bins_with_at_least_50_percent_contigs_top_species.tsv

2021-09-08
cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch
nano 2021-09-08_ggbetweenstats_command_with_placeholder.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/binned_fastas_Kaiju_Species

Bin_m837
Bin_c498
Bin_m1254
Bin_c1138
Bin_m1050
while read -r line ; do bin=$(echo "$line") && cat 2021_09_08_build_dataframe_in_R_of_P_values_from_wilcox_tests_for_summing_by_bins_subsampled_reads_mapping_to_Bins_contig_and_library_size_adjusted_mapping_scores.txt | sed "s/PLACEHOLDER/$bin/g" >> 2021_09_08_list_of_R_commands_Wilcox_tests_all_bins_summed_by_bins.txt ; done < list_of_bins.txt

_bin_name

while read -r line ; do bin=$(echo "$line") && printf "rm(${bin}_bin_name)\n" ; done < list_of_bins.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/2021-07-27_Reads_to_Bins_mapping/2021-09-09_unique_taxa.txt

2021-09-13
108070 2021-09-13-R_script_summed_to_taxa_wilcox_tests_just_across_hosts_and_across_seasons_no_combined_factors_multi_line_script_NO_figures.txt
while read -r line ; do taxon=$(echo "$line") && cat 2021-09-13_PLACEHOLDER_R_script_summed_by_taxa_only_across_hosts_and_across_season_comparisons_not_combination_of_factors_NO_figures.txt | sed "s/PLACEHOLDER/$taxon/g" >> 2021-09-13-R_script_summed_to_taxa_wilcox_tests_just_across_hosts_and_across_seasons_no_combined_factors_multi_line_script_NO_figures.txt ; done < 2021-09-10_unique_taxa_R_readable_version_2.txt
Nitrosomonadales.bacterium.Swamp67_AC_counts


2021-09-13_R_script_summed_to_taxa_foldchange_and_logratios_just_host_vs_host_and_season_vs_season_log1p_transformed_contig_and_library_size_adjusted_mapping_scores_paired_samples_no_pilots.txt
while read -r line ; do taxon=$(echo "$line") && cat 2021-09-13_PLACEHOLDER_R_script_summed_to_taxa_foldchange_and_logratios_just_host_vs_host_and_season_vs_season_log1p_transformed_contig_and_library_size_adjusted_mapping_scores_paired_samples_no_pilots.txt | sed "s/PLACEHOLDER/$taxon/g" >> 2021-09-13_R_script_summed_to_taxa_foldchange_and_logratios_just_host_vs_host_and_season_vs_season_log1p_transformed_contig_and_library_size_adjusted_mapping_scores_paired_samples_no_pilots.txt ; done < 2021-09-10_unique_taxa_R_readable_version_2.txt

2021-09-13_PLACEHOLDER_R_script_summed_to_taxa_foldchange_and_logratios_just_host_vs_host_and_season_vs_season_log1p_transformed_contig_and_library_size_adjusted_mapping_scores_paired_samples_no_pilots.txt

2021-12-31
/hpc-home/osbourne/2021_12_31-Paper_1-Chapter_1_scripts

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/human_mock

Human reference downloaded from: https://ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh38_latest/refseq_identifiers/GRCh38_latest_genomic.fna.gz

head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8
2021-12-31_pilot_read_files_RAW_read_counts_per_file.csv
2022-01-01_pilot_read_files_QCed_read_counts_per_file.csv
for f in *.fq ; do filenome=$(basename "$f") && readcount=$(grep -c "@" "$f") && printf "${filenome},${readcount}\n" >> 2022-01-01_pilot_read_files_QCed_read_counts_per_file.csv ; done
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

nome=$(basename AC19N-Acah-3258STDY6863972-E3_R2.QCed.fq | awk -F "-" '{print $2}') && case "$nome" in "Arus"|"Acah") echo "Is one of these species" ;; *)echo "Is NOT one of these species" ;; esac

nome=$(basename AC19N-Acah-3258STDY6863972-E3_R2.QCed.fq | awk -F "-" '{print $2}') && case "$nome" in "Arus") echo "Is an Acomys russatus sample" ;; "Acah") echo "Is an Acomys cahirinus sample" ;; *) echo "Is NOT one of these species" ;; esac

nome=$(basename AR27J-Arus-3258STDY6863967-E3_R1.QCed.fq | awk -F "-" '{print $2}') && case "$nome" in "Arus") echo "Is an Acomys russatus sample" ;; "Acah") echo "Is an Acomys cahirinus sample" ;; *) echo "Is NOT one of these species" ;; esac

2022-01-01
994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.fq
994_LIB8395_LDI7034_NoIndex_L001_R2.QCed.fq

for f in 994*.Cleansed.fq ; do filenome=$(basename "$f") && readcount=$(grep -c '@' "$f") && printf "${filenome},${readcount}\n" >> 2022-01-01_human_mock_microbiome_community_QCed_and_contaminant_removed_read_counts_per_file.csv ; done

2022-01-02
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases
https://kaiju.binf.ku.dk/database/kaiju_db_nr_euk_2021-02-24.tgz
https://genome-idx.s3.amazonaws.com/kraken/k2_pluspf_20210517.tar.gz
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/metaphlan3

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju

testing_1000_reads_from_AC19N_R1.fastq
testing_1000_reads_from_AC19N_R2.fastq

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju
kaijudir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju" && kaiju -t "${kaijudir}/nodes.dmp" -f "${kaijudir}/kaiju_db_nr_euk.fmi" -i testing_1000_reads_from_AC19N_R1.fastq -j testing_1000_reads_from_AC19N_R2.fastq -a mem -X -v

export PATH="$PATH:/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kraken2"

export KRAKEN2_DB_PATH="/home/user/my_kraken2_dbs:/data/kraken2_dbs:"

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/metaphlan3

bowtie2-build –threads 4 -f /storage/work/epb5360/miniconda3/lib/python3.7/site-packages/metaphlan/metaphlan_databases/mpa_v30_CHOCOPhlAn_201901.fna /storage/work/epb5360/miniconda3/lib/python3.7/site-packages/metaphlan/metaphlan_databases/mpa_v30_CHOCOPhlAn_201901
source package d2bf4021-3bcf-4ed3-9bf9-ef792cfc9579 #bowtie2 2.3.4.3


/tgac/software/testing/kraken2/2.0.8.r7127273/x86_64/bin/kraken2-inspect

Your db trial
1000 sequences (0.25 Mbp) processed in 0.092s (648.7 Kseq/m, 162.10 Mbp/m).
  14 sequences classified (1.40%)
  986 sequences unclassified (98.60%)

Normal EI one
1000 sequences (0.25 Mbp) processed in 0.166s (362.0 Kseq/m, 90.45 Mbp/m).
  24 sequences classified (2.40%)
  976 sequences unclassified (97.60%)

2022-01-03
AR27N-Arus-3258STDY6863973_Classified_Kraken2.066_conf_score_1.txt.gz
AR27N-Arus-3258STDY6863973_Classified_Kraken2.066_conf_score_2.txt
AR27N-Arus-3258STDY6863973_Unclassified_Kraken2.066_conf_score_1.txt.gz
AR27N-Arus-3258STDY6863973_Unclassified_Kraken2.066_conf_score_2.txt.gz

AR27N-Arus-3258STDY6863973_Classified_Kraken2.066_conf_score_1.txt

2022-01-04
AC18N
@HS31_23164:5:2315:14191:93494/2
HS31_23164:5:1101:10796:2525

if [[ "$read_1_reads" == "$read_2_reads" ]] ; then echo "All is well" ; else echo "Reads do not match exactly" ; fi

case "$hostcheck" in
  "Acah")
  printf "\nQCed read files are:\t$read1file\t$read2file\n"
  printf "\nFiles are from an Acomys cahirinus sample"
  printf "\nWill run files through BBDuk"
  srun bbduk.sh -Xmx120g -Xms55g -prealloc in="$read1file" in2="$read2file" ref="$HUMANREF","$ACOCAHREF" outm="${REPORTOUTDIR}/${samplename}-BBDuk_contaminants.fq" out="${OUTDIR}/${read1name}.Cleansed.fq" out2="${OUTDIR}/${read2name}.Cleansed.fq" overwrite=t stats="${REPORTOUTDIR}/${samplename}-BBDuk_stats.txt"
  printf "\nRan files:\t$read1file\t$read2file\tthrough BBDuk against human and Acomys cahirinus reference genomes\n"
  ;;
  "Arus")
  printf "\nQCed read files are:\t$read1file\t$read2file\n"
  printf "\nFiles are from an Acomys russatus sample"
  printf "\nWill run files through BBDuk"
  srun bbduk.sh -Xmx120g -Xms55g -prealloc in="$read1file" in2="$read2file" ref="$HUMANREF","$ACORUSREF" outm="${REPORTOUTDIR}/${samplename}-BBDuk_contaminants.fq" out="${OUTDIR}/${read1name}.Cleansed.fq" out2="${OUTDIR}/${read2name}.Cleansed.fq" overwrite=t stats="${REPORTOUTDIR}/${samplename}-BBDuk_stats.txt"
  printf "\nRan files:\t$read1file\t$read2file\tthrough BBDuk against human and Acomys russatus reference genomes\n"
  ;;
  *)
  printf "\nThe filenames do not contain an indicator of which Acomys host species they are from\n"
  sleep 5m
  exit 1
esac

ERROR WITH:	AC16N - not same reads in R1 and R2 of sample in qced, cleansed and subsampled files

QCed files have same number of reads in R1 and R2
Cleansed files have same number of reads in R1 and R2
Subsampled have the same number of reads

if cmp -s 994_LIB8395_LDI7034_NoIndex_L001_list_of_R1_reads.txt 994_LIB8395_LDI7034_NoIndex_L001_list_of_R2_reads.txt ; then echo "The two files are the same" ; else echo "The two files are not the same, they differ somewhere" ; fi

diff 994_LIB8395_LDI7034_NoIndex_L001_list_of_R1_reads.txt 994_LIB8395_LDI7034_NoIndex_L001_list_of_R2_reads.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY

2022-01-05
@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835
@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835 1:N:0: kraken:taxid|1279

@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835
C	HWI-M01013:67:000000000-A97VR:1:1101:14722:1835	1280	102	1280,	EOR40545.1,	DQTHGDVMKFDCSHRVFL,

17.30	2344385	2344383	S	1063	                Cereibacter sphaeroides


@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835 1:N:0: kraken:taxid|1279

0.03	3841	1795	G1	909768	                Acinetobacter calcoaceticus/baumannii complex

HWI-M01013:67:000000000-A97VR:1:1101:19455:2151

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/results


LC_ALL=C fgrep -f AC16N-QCed.Cleansed.Subsampled.All_read_names.txt /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/AC16N-Acah-3258STDY6863970_Classified_Kraken2.066_conf_score_1.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/AC16N-Acah-3258STDY6863970_Classified_Kraken2.066_conf_score_1.txt

LC_ALL=C awk '$1 == "@HS31_23164:5:2302:9068:95787/1" {print $0}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/AC16N-Acah-3258STDY6863970_Classified_Kraken2.066_conf_score_1.txt

source package /tgac/software/testing/bin/gnuparallel-20180222

HS31_23164:5:2302:9068:95787

LC_ALL=C awk '$1 == "@HS31_23164:5:2302:9068:95787/1" {print $0}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/AC16N-Acah-3258STDY6863970_Classified_Kraken2.066_conf_score_1.txt

#estimated_reads_mapped_to_known_clades:15720250 - so basically 62 percent by Metaphlan
fgrep -c '@' 994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.fq
25300269


HWI-M01013:67:000000000-A97VR:1:1101:14722:1835

2022-01-10
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
13471723 classified human mock reads by kaiju

4450000 reads in subsampled files

HS31_23164:5:2306:10426:57579

awk '$2 == "HS31_23164:5:2306:10426:57579" {print $1,$2,$3}' AR27N-Arus-3258STDY6863973.Kaiju_output.out
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/AR27N-Arus-3258STDY6863973.Kaiju_output.out

AR27N-QCed.Cleansed.Subsampled.All_read_names.txt

while read -r line ; do readname="${line:1}" && awk -v readnome="$readname" '$2 == readnome {print $1,$2,$3}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/AR27N-Arus-3258STDY6863973.Kaiju_output.out ; done < AR27N-QCed.Cleansed.Subsampled.All_read_names.txt

| sed 's@$@/1@g'

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/AR27N-Arus-3258STDY6863973_Classified_Kraken2.066_conf_score_1.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/AR27N-Arus-3258STDY6863973_Unclassified_Kraken2.066_conf_score_1.txt
AR27N-QCed.Cleansed.Subsampled.All_read_names.txt

while read -r line ; do readname="${line}/1" && awk -v readnome="$readname" '$1 == readnome {print $0;}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/AR27N-Arus-3258STDY6863973_Classified_Kraken2.066_conf_score_1.txt ; done < AR27N-QCed.Cleansed.Subsampled.All_read_names.txt

while read -r line ; do readname="${line}/1" && awk -v readnome="$readname" '$1 == readnome { print $0 }' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/AR27N-Arus-3258STDY6863973_Unclassified_Kraken2.066_conf_score_1.txt ; done < AR27N-QCed.Cleansed.Subsampled.All_read_names.txt

@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835
@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835
awk -v readnome="@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835" '$1 == readnome {print $3}' Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.066_conf_score_1.txt.Just_reads_and_classified_taxIDs.txt | awk -F "|" '{print $2}'
awk -v readnome="@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835" '$1 == readnome {print $3}' Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.066_conf_score_1.txt.Just_reads_and_classified_taxIDs.txt | awk -F "|" '{print $2}'

taxid=$(awk -v readnome="@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835" '$1 == readnome {print $3}' Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.066_conf_score_1.txt.Just_reads_and_classified_taxIDs.txt | awk -F "|" '{print $2}') && echo "$taxid"
taxid=$(awk -v readnome="@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835" '$1 == readnome {print $3}' Unclassified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.066_conf_score_1.txt.Just_reads_and_classified_taxIDs.txt | awk -F "|" '{print $2}') && [ -z "$taxid" ] && taxid="0" && echo "$taxid" || echo "$taxid"

taxid=$(awk -v readnome="@HWI-M01013:67:000000000-A97VR:1:1101:14722:1835" '$1 == readnome {print $3}' Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.066_conf_score_1.txt.Just_reads_and_classified_taxIDs.txt | awk -F "|" '{print $2}') && [ -z "$taxid" ] && taxid="0" && echo "$taxid" || echo "$taxid"


C HWI-M01013:67:000000000-A97VR:1:1101:19056:4084 543
U HWI-M01013:67:000000000-A97VR:1:1101:18216:4089 0
classified=$(awk -v readnome="HWI-M01013:67:000000000-A97VR:1:1101:14722:1835" '$2 == readnome' 994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output.out.Just_classification_state_read_name_and_TaxID.out) && [ -z "$classified" ] && classifiable="NO" || classifiable="YES" && echo "$classifiable"


2022-01-17
for f in *BBDuk_stats.txt ; do samplename=$(basename "$f" | awk -F "-" '{print $1}') && percent_matched_reads=$(grep 'Matched' "$f" | awk -F "\t" '{print $3}') && printf "${samplename}t${percent_matched_reads}\n" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references

Bin_c13.fa
Bin_m89.fa

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY


for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

2022-01-18
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_0_errors_allowed.out
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_0_allowed_errors.out

2022-01-19
find ~+ -type f -name "filename"
KRAKEN_OUTPUT_FILES=$(find ~+ -maxdepth 1 -type f -name "Classified*994_LIB8395_LDI7034*1.txt") && kraken_readname="@HWI-M01013:67:000000000-A97VR:1:2115:21288:15090" && for f in $KRAKEN_OUTPUT_FILES ; do looping_through_file=$(basename "$f") && confidence_score=$(basename "$f" | awk -F "Cleansed." '{print $2}' | awk -F "_conf_score" '{print $1}') && kraken_classified=$(awk -v readnume="$kraken_readname" '$1 == readnume {print $3;exit}' "$looping_through_file" | awk -F "|" '{print $2}') && [ -z "$kraken_classified" ] && kraken_classification="0" || kraken_classification="$kraken_classified" && printf "$confidence_score\t$kraken_classification\n" ; done

@HWI-M01013:67:000000000-A97VR:1:1101:13122:1961

KRAKEN_OUTPUT_FILES=$(find ~+ -maxdepth 1 -type f -name "Classified*994_LIB8395_LDI7034*1.txt") && kraken_readname="@HWI-M01013:67:000000000-A97VR:1:1101:13122:1961" && for f in $KRAKEN_OUTPUT_FILES ; do looping_through_file=$(basename "$f") && confidence_score=$(basename "$f" | awk -F "Cleansed." '{print $2}' | awk -F "_conf_score" '{print $1}') && kraken_classified=$(awk -v readnume="$kraken_readname" '$1 == readnume {print $3;exit}' "$looping_through_file" | awk -F "|" '{print $2}') && [ -z "$kraken_classified" ] && kraken_classification="0" || kraken_classification="$kraken_classified" && printf "$confidence_score\t$kraken_classification\n" ; done

source package /tgac/software/testing/bin/gnuparallel-20180222

cat AC19N-Acah-3258STDY6863972_Kraken2-conf_050_report.txt | sort -zV | parallel -0 -n4 --dryrun --pipepart awk

cat AC19N-Acah-3258STDY6863972_Kraken2-conf_050_report.txt | sort -zV | parallel -0 -n4 --dryrun --pipepart command taxon=$(echo "{}" | awk -F "\t" '{print $6}') && printf "\n$taxon"

cat AC19N-Acah-3258STDY6863972_Kraken2-conf_050_report.txt | xargs -P 2 taxon=$(echo "{}" | awk -F "\t" '{print $6}') && printf "\n$taxon"

2022-01-20
input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY/994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names.txt" && "$input_file" parallel command grep {} 994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output* | awk -F "\t" '{print $1}'

input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY/994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names.txt" && parallel -a "$input_file" 'echo Looking with read {} ; grep {} 994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output* | awk -F "\t" '{print $1}''

input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY/994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names.txt" && parallel -a "$input_file" -I% --max-args 1 --max-args

input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY/994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names.txt" && parallel -k --max-args 1 readname="{1}" && kaiju_readname="${readname:1}" && taxid=$(awk -v readnome="$kaiju_readname" '$2 == readnome {print $3;exit}' kaiju_file) && printf "\n$readname\t$taxid\n" < "$input_file"

kaiju_file=input_file="994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_0_allowed_errors.Taxon_names_added.out" && "/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY/994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names.txt" && parallel -j+0 -a "$input_file" command 'readname={} && kaiju_readname=${readname:1} && taxid=$(awk -v readnome="$kaiju_readname" '$2 == readnome {print $3;exit}' "$kaiju_file") && printf "$readname\t$taxid\n"'

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs

input_file="994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_0_allowed_errors.Taxon_names_added.out" && "/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY/994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names.txt" && parallel -j+0 -a "$input_file" command 'readname={} && kaiju_readname=${readname:1} && taxid=$(awk -v readnome="$kaiju_readname" '$2 == readnome {print $3;exit}' "$kaiju_file") && printf "$readname\t$taxid\n"'

kaiju_file="994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_5_allowed_errors.Taxon_names_added.out" && input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY/994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names.txt" &&

EXAMPLE: Rewriting a for-loop and a while-read-loop
       for-loops like this:

         (for x in `cat list` ; do
           do_something $x
         done) | process_output

       and while-read-loops like this:

         cat list | (while read x ; do
           do_something $x
         done) | process_output

       can be written like this:

         cat list | parallel do_something | process_output

For example: Find which host name in a list has IP address 1.2.3 4:

  cat hosts.txt | parallel -P 100 host | grep 1.2.3.4

If the processing requires more steps the for-loop like this:

  (for x in `cat list` ; do
    no_extension=${x%.*};
    do_step1 $x scale $no_extension.jpg
    do_step2 <$x $no_extension
  done) | process_output

and while-loops like this:

  cat list | (while read x ; do
    no_extension=${x%.*};
    do_step1 $x scale $no_extension.jpg
    do_step2 <$x $no_extension
  done) | process_output

can be written like this:

  cat list | parallel "do_step1 {} scale {.}.jpg ; do_step2 <{} {.}" |\
    process_output

If the body of the loop is bigger, it improves readability to use a function:

  (for x in `cat list` ; do
    do_something $x
    [... 100 lines that do something with $x ...]
  done) | process_output

  cat list | (while read x ; do
    do_something $x
    [... 100 lines that do something with $x ...]
  done) | process_output

can both be rewritten as:

  doit() {
    x=$1
    do_something $x
    [... 100 lines that do something with $x ...]
  }
  export -f doit
  cat list | parallel doit

#!/bin/bash -eE
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY/994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names.txt"
export kaiju_input_file="994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_5_allowed_errors.Taxon_names_added.out"
get_taxid() {
  kaiju_readname="${1:1}"
  taxid=$(awk -v readnome="$kaiju_readname" '$2 == readnome {print $3;exit}' "$kaiju_input_file")
  printf "The read is:\t$kaiju_readname\t$taxid\tthere should have been a number before this bit of text\n"
}
export -f get_taxid
cat "$input_file" | parallel -j+0 get_taxid

work_files=$(find ~+ -maxdepth 1 -type f -name "*994_LIB8395_LDI7034*") && echo "$work_files" | parallel -j+0 subject_file=$(basename {}) && taxid=$(awk -v nome="@HWI-M01013:67:000000000-A97VR:1:1101:13122:1961" '$2 == readnome {print $3;exit}' "$subject_file") ; printf "\n$subject_file\t$taxid\n"

work_files=$(find ~+ -maxdepth 1 -type f -name "*994_LIB8395_LDI7034*") && echo "$work_files" | parallel -j+0 'subject_file=$(basename {}) && taxid=$(awk -v nome="HWI-M01013:67:000000000-A97VR:1:1101:12947:1874" '$2 == readnome {print $3;exit}' "$subject_file") ; printf "\n$subject_file\t$taxid"'

work_files=$(find ~+ -maxdepth 1 -type f -name "*994_LIB8395_LDI7034*") && echo "$work_files" | parallel --dryrun -j+0 "subject_file=$(basename {}) && taxid=$(awk -v nome="HWI-M01013:67:000000000-A97VR:1:1101:12947:1874" '$2 == readnome {print $3;exit}' {}) && printf "\n$subject_file\t$taxid""

2022-01-21
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files
source package /tgac/software/testing/bin/gnuparallel-20180222
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs
AC16N-Acah-3258STDY6863970.Kaiju_output_0_errors_allowed.Taxon_names_added.out
AC16N-Acah-3258STDY6863970.Kaiju_output_1_errors_allowed.Taxon_names_added.out
AC16N-Acah-3258STDY6863970.Kaiju_output_2_errors_allowed.Taxon_names_added.out
AC16N-Acah-3258STDY6863970.Kaiju_output_3_errors_allowed.Taxon_names_added.out
AC16N-Acah-3258STDY6863970.Kaiju_output_4_errors_allowed.Taxon_names_added.out
AC16N-Acah-3258STDY6863970.Kaiju_output_5_errors_allowed.Taxon_names_added.out
AC16N-Acah-3258STDY6863970.Kaiju_output_10_errors_allowed.Taxon_names_added.out
AC16N-Acah-3258STDY6863970.Kaiju_output_20_errors_allowed.Taxon_names_added.out

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output
AC16N-Acah-3258STDY6863970_Unclassified_Kraken2.095_conf_score_1.txt.gz
AC16N-Acah-3258STDY6863970_Classified_Kraken2.095_conf_score_1.txt.gz

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/results

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/WORKING_DIRECTORY

AC16N-QCed.Cleansed.Subsampled.All_read_names.txt

i=$((i+1))
((i=i+1))
let "i=i+1"

reads_counted="0" && for i in {1..10} ; do sleep 5s && reads_counted=$(($reads_counted + 1)) && echo "We have counted this many reads: $reads_counted" ; done

2022-01-21_Controller_script-Pilot_samples_get_taxids_Kaiju_Kraken_multiple_parameter_runs.sh

ls -lhtr /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/AR34J-Arus-3258STDY6863969.Kaiju_output_4_errors_allowed.Taxon_names_added.out

HS31_23164:5:1101:8142:2269

AR34J-Kaiju_and_Kraken_multiple_parameter_runs_all_reads_TaxID.csv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output

AR34J
@HS31_23164:5:1101:10521:2743 is list of reads format

HS31_23164:5:1101:8142:2269 is in AR34J-Arus-3258STDY6863969_Classified_Kraken2.075_conf_score_1.txt

AR34J-Arus-3258STDY6863969_Classified_Kraken2.075_conf_score_1.txt

AR34J-Kaiju_and_Kraken_multiple_parameter_runs_all_reads_TaxID.csv

awk -v readnome="@HS31_23164:5:1101:8142:2269/1" '$2 == readnome {print $3;exit}' "AR34J-Arus-3258STDY6863969_Classified_Kraken2.075_conf_score_1.txt"

AR34J-Arus-3258STDY6863969_Classified_Kraken2.075_conf_score_1.txt
kaiju_readname="HS31_23164:5:1101:8142:2269" && looping_through_file="AR34J-Arus-3258STDY6863969_Classified_Kraken2.075_conf_score_1.txt" && taxid=$(awk -v readnome="$kaiju_readname" '$2 == readnome {print $3;exit}' "$looping_through_file") && echo "$taxid"

3:49:5
3:49:6

2022-01-23
25300269 reads in qced and cleansed mock human community

target_files=$(find -maxdepth 1 -type f -name "994_LIB8395_LDI7034_NoIndex*" -printf '%f\n') && original_reads="25300269" && for f in $target_files ; do errors_allowed=$(echo "$f" | awk -F "Kaiju_output_" '{print $2}' | awk -F "_allowed" '{print $1}') && echo "$errors_allowed" && classified_reads=$(awk '{print $1}' "$f" | grep -c "C") && printf "\n$errors_allowed\t$classified_reads" ; done

taxid=$(awk -v readnome="$kaiju_readname" '$2 == readnome {print $3;exit}' "$looping_through_file")
$(awk '$1 == "C" {print $1}' "$f" | wc -l)



target_files=$(find -maxdepth 1 -type f -name "AC*_4_errors_allowed.Taxon_names_added.out") && for f in $target_files ; do classified_reads=$(awk -v statos="C" '$1 == statos {print $1}' "$f" | wc -l) && echo "$classified_reads" ; done

AR29J-Arus-3258STDY6863968_Classified_Kraken2.095_conf_score_1.txt

target_files=$(find -maxdepth 1 -type f -name "AC*Classified_Kraken2.095_conf_score_1.txt") && for f in $target_files ; do classified_reads=$(grep -c 'taxid' "$f") && echo "$classified_reads" ; done

target_files=$(find -maxdepth 1 -type f -name "*J*_0_errors_allowed.Taxon_names_added.out") && for f in $target_files ; do classified_reads=$(awk -v statos="C" '$1 == statos {print $1}' "$f" | wc -l) && echo "$classified_reads" ; done

target_files=$(find -maxdepth 1 -type f -name "*J*Classified_Kraken2.095_conf_score_1.txt") && for f in $target_files ; do classified_reads=$(grep -c 'taxid' "$f") && echo "$classified_reads" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas
Bin_c24.fa

2244
/ei/software/staging/CISSUPPORT-13773/stagingloader
dfast -g /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas/Bin_c24.fa -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Kaiju_testing/Bin_fastas --use_original_name t --cpu 2 --use_locustag_as_gene_id

2022-01-26
source /ei/software/staging/CISSUPPORT-13773/stagingloader
/ei/software/staging/CISSUPPORT-13773/x86_64/bin
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/databases/dfast_2022_01_26

wget https://github.com/nigyta/dfast_core/archive/x.x.x.tar.gz

export PATH=$PATH:/hpc-home/osbourne/TEMP-DFAST/dfast_core-1.2.15/bin

export PATH=$PATH:/hpc-home/osbourne/TEMP-DFAST/dfast_core-1.2.15/dfast
export PATH=$PATH:/hpc-home/osbourne/TEMP-DFAST/dfast_core-1.2.15/scripts/dfast_file_downloader.py

export PATH=$PATH:/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/databases

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/databases/dfast_2022_01_26/protein

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/databases/dfast_2022_01_26/protein/DFAST-default.faa

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/databases/dfast_2022_01_26/protein/DFAST-default.ref

/hpc-home/osbourne/GHOSTX-TEMP/ghostx-1.3.7/src/ghostx
ghostx
dfast --config

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs
2022_01_23-Kaiju_all_pilot_samples_all_allowed_errors_unique_taxids.txt

awk -v taxid="2809243" '$1 == taxid {print $3;exit}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp

awk -v taxid="2809243" '$1 == taxid {print $3}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp

awk -v taxid="2" '$1 == taxid {print $3;exit}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp

taxid_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp" && while read -r line ; do taxid=$(echo "$line") && taxon=$(awk -v taxid="$taxid" '$1 == taxid {print $3;exit}' "$taxid_file") && printf "$taxid\t$taxon\n" ; done < 2022_01_23-Kaiju_all_pilot_samples_all_allowed_errors_unique_taxids.txt

awk -v taxid="146" '$1 == taxid {print $3;exit}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp

taxid_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp" && while read -r line ; do taxid=$(echo "$line") && taxon=$(awk -v taxid="$taxid" '$1 == taxid {print $3}' "$taxid_file") && number_taxid_lines=$(echo "$taxon" | wc -l) && if [[ "$number_taxid_lines" -gt "1" ]] ; then taxon_final=$(echo "$taxon" | awk -F "\t" '{print $3}') ; else taxon_final=$(echo "$taxon") ; fi && printf "$taxid\t$taxon_final\n" ; done < 2022_01_23-Kaiju_all_pilot_samples_all_allowed_errors_unique_taxids.txt

#!/bin/bash -e
taxid_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
input_list="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/2022_01_23-Kaiju_all_pilot_samples_all_allowed_errors_unique_taxids.txt"

while read -r line
do
  taxid=$(echo "$line")
  taxon=$(awk -v taxid="$taxid" '$1 == taxid {print $0}' "$taxid_file")
  number_taxid_lines=$(echo "$taxon" | wc -l)
  if [[ "$number_taxid_lines" -eq "1" ]]
  then
    taxon_final=$(echo "$taxon" | awk -F "\t" '{print $3}')
  else
    taxon_final=$(echo "$taxon" | grep 'scientific name' | awk -F "\t" '{print $3}')
  fi
  printf "$taxid\t$taxon_final\n"
done < "$input_list"

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kraken2

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output
2022_01_23-Kraken_all_pilot_samples_all_allowed_errors_unique_taxids.txt

1578

awk -v taxid="2809243" '$5 == taxid {print $6;exit}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kraken2/inspect.txt

2022-01-28
TARGET_FILES=$(find -maxdepth 1 -type f -name "*.Taxon_names_added.out" -not -name "TEMP*" -printf '%f\n') && for f in $TARGET_FILES ; do input_kaiju_file="$f" && name_check="${input_kaiju_file:0:1}" && if [[ "$name_check" == "9" ]] ; then stotus="Human_mock" ; else stotus=$(echo "$input_kaiju_file" | awk -F "-" '{print $1}') ; fi && printf "\n$f\t--\t--\t$stotus" ; done

slurm-43189472.out to zip

slurm-43416452.out

2022-01-21_V4_human_mock_taxids_for_classifiers_different_parameters.sh

HS31_23164:5:1101:7410:3933


2022-01-29
AC16J-Kaiju2table_0_errors_allowed-class_level_results.tsv
AC16J-Kaiju2table_0_*

for f in AC16J-Kaiju2table_0_* ; do taxon_level=$(basename "$f" | awk -F "-" '{print $3}' | awk -F "_" '{print $1}') && percent_unassigned=$(grep 'cannot be assigned' "$f" | awk -F "\t" '{print $2}') && printf "$taxon_level\t$percent_unassigned\n" ; done

awk -F- -v keysInOrder="phylum,class,order,family,genus,species"

2022-01-30
for f in AR34J-Kaiju2table_3_* ; do taxon_level=$(basename "$f" | awk -F "-" '{print $3}' | awk -F "_" '{print $1}') && percent_unassigned=$(grep 'cannot be assigned' "$f" | awk -F "\t" '{print $2}') && printf "$taxon_level\t$percent_unassigned\n" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/Kaiju_short_or_report_file_versions


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs

Reordered_kaiju_outputs_multiple_errors_allowed_all_samples

for f in AC19N-Acah-3258STDY6863972.Kaiju_output* ; do nome=$(basename "$f") && outputdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/Reordered_kaiju_outputs_multiple_errors_allowed_all_samples" && cat "$f" | sort -k2 -h >> "${outputdir}/${nome}.Reordered.csv" && echo "Processed file: $f" ; done

grep -n 'HS31_23164:5:2316:9986:97912' AC19N-Acah-3258STDY6863972.Kaiju_output_0_errors_allowed.Taxon_names_added.out.Reordered.csv
HS31_23164:5:2316:9986:97912

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/Kaiju_short_or_report_file_versions

2022-01-31
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju

2022-02-02

awk -F "\t" '{print $3}' 994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_4_allowed_errors.Taxon_names_added.out > TOMBAL_TEMP_FILE.txt && while read -r line ; do taxid=$(echo "$line") && grep -q "$taxid" TOMBAL_TEMP_FILE.txt && presence="1" || presence="0" && printf "$taxid\t$presence\n" ; done < human_mock_known_TaxIDs.txt && rm TOMBAL_TEMP_FILE.txt

2022-02-03
#Kaiju species level output files have 4 exteraneous lines when trying to work out how many species detections were made in the report file
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/Kaiju_short_or_report_file_versions
printf "20 errors\n" && while read -r line ; do taxid="$line" && grep -wq "$taxid" Human_mock-Kaiju2table_20_errors_allowed-species_level_results.tsv && presence="Yes" || presence="No" && printf "$taxid\t$presence\n" ; done < human_mock_known_TaxIDs.txt | sort -k1 -V

for f in Human_mock-Kaiju2table_*_errors_allowed-species_level_results.tsv ; do errors_allowed=$(basename "$f" | awk -F "_" '{print $3}') && printf "Errors allowed: $errors_allowed\n" && while read -r line ; taxid="$line" && occurence=$(awk -v taxid="$taxid" -F "\t" '$4 == taxid {print $0}' "$f" | wc -l) && printf "$taxid\t$occurence\n" ; done <  human_mock_known_TaxIDs.txt | sort -k1 -V ; done

2022-02-07
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/PRJEB32890_files

https://ftp.ncbi.nlm.nih.gov/genomes/refseq/vertebrate_mammalian/Mus_musculus/reference/GCF_000001635.27_GRCm39/GCF_000001635.27_GRCm39_genomic.fna.gz

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/GCF_000001635.27_GRCm39_genomic.Mus_musculus.fna

2022-02-09
export kaiju_taxa_array=("phylum" "class" "order" "family" "genus" "species") && kaiju_database_directory="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju" && kaiju_nodes="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/nodes.dmp" && kaijudbfile="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/kaiju_db_nr_euk.fmi" && kaiju_names="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp" && /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/Kaiju_short_or_report_file_versions && for

2022-02-10
SRR9205148_R1.fastq
SRR9205148_R2.fastq

SRR9205149_R1.fastq
SRR9205149_R2.fastq
sbatch --dependency=afterok:44843231 2022-02-10_classify_multiple_parameters_metaphlan_kaiju_kraken_processed_PRJNA540893_files.sh
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/PRJNA540893_files

44843231

2022-02-11
for f in SRR9205148.Kaiju_output_*_allowed_errors.Taxon_names_added.out ; do errsallowed=$(basename "$f" | awk -F "Kaiju_output_" '{print $2}' | awk -F "_allowed_errors" '{print $1}') && classified=$(awk -F "\t" '{print $1}' "$f" | grep -c "C") && printf "$errsallowed\t$classified\n" ; done

QCed.Cleansed.Subsampled.fq

for f in A*-E3_R1.QCed.Cleansed.Subsampled.fq ;do sampleid=$(basename "$f" | awk -F "-" '{print $1}') && readcount=$(grep -c "^@HS" "$f") && printf "$sampleid\t$readcount\n" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references
Bin_*.fa

source /ei/software/staging/CISSUPPORT-13773/stagingloader
dfast

dfast -g <path to genome> -o <path to output directory> --use_original_name t --locus_tag_prefix <locus tag prefix> --cpu <number of cpus to use>

/hpc-home/osbourne/DFAST_testing

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

2022-02-12
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping

bins_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references" && find -maxdepth 1 -type f -path "$bins_dir/*" -name "Bin*.fa"

xargs -a file -I{} -d'\n' command --option {} other args

xargs -a List_of_bins_paths.txt -I {} -d '\n' printf "\n{}\tXARGS insert here\n"

2022-02-13

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/Bin_c557-DFAST_output
application.log
Blastp version could not be determined. Aborted...
find -maxdepth 2 -type f -name "application.log"

target_files=$(find -maxdepth 2 -type f -name "application.log") && for f in $target_files ; do grep -q "Aborted" "$f" && printf "$f" | awk -F "./" '{print $2}' | awk -F "-DFAST" '{print $1}' | sed "s/$/.fa/g" | sed "s@^@/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references/@g" || echo "" ; done
target_foles=$(grep -q "Aborted" "$f")
for f in $target_foles ; do binname=$(echo "$f" | awk -F "./" '{print $2}' | awk -F "-DFAST" '{print $1}' | sed "s/$/.fa/g" | sed "s@^@/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references/@g") && echo "$binname" ; done

bins_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references" && workingdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping" && cd "$bins_dir" && temp_var_this_dir=$(pwd) && for f in Bin*.fa ; do nome=$(basename "$f") && printf "${temp_var_this_dir}/${nome}\n" && done > "${workingdir}/List_of_bins_paths.txt"

#!/bin/bash -e
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

for f in *.out
do
  grep -q "Blastp version could not be determined. Aborted..." "$f" && failcheck="1" || failcheck="0"
  if [[ "$failcheck" -eq "1" ]]
  then
    failed_bin_name=$(head "$f" | grep 'Will process this file with DFAST:' | awk -F "\t" '{print $2}')
    printf "\n$failed_bin_name"
  elif [[ "$failcheck" -eq "0" ]]
  then
    echo ""
  else
    echo ""
  fi
done

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins

ls -lhtr /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping

find -maxdepth 2 -type f -name "application.log" | awk -F "-" '{print $1}' | sed "s@./@@g" > /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/2022-02-14_Failed_bins_list.txt

while read -r line ; do bin_name="$line" && bin_path=$(grep -w "$bin_name" List_of_bins_paths.txt) && printf "$bin_path\n" >> 2022-02-14_Failed_bin_paths_list.txt ; done < 2022-02-14_Failed_bins_list.txt

2022-02-14
./16aD_S27_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa
All your assembled genomes have SPADES in the name

source package bceb1286-ad72-4764-aaf7-111f51a37080 #CheckM 1.1.2

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/array_based_per_read_taxIDs

cat AC16J-QCed.Cleansed.Subsampled.All_read_names.txt | xargs -d '\n' -L 100 printf

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/array_based_per_read_taxIDs

bins_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references" && workingdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping" && cd "$bins_dir" && temp_var_this_dir=$(pwd) && for f in *SPADES* ; do nome=$(basename "$f") && printf "${temp_var_this_dir}/${nome}\n" ; done > "${workingdir}/List_of_isolate_megahit_assembly_paths.txt"

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

362 failed before
185 failed after

find -maxdepth 2 -type f -name "application.log" -not -name "Bin*" | awk -F "-" '{print $1}' | sed "s@./@@g" > /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/2022-02-14_Failed_bins_list.txt
while read -r line ; do bin_name="$line" && bin_path=$(grep -w "$bin_name" List_of_bins_paths.txt) && printf "$bin_path\n" >> 2022-02-14_Failed_bin_paths_list.txt ; done < 2022-02-14_Failed_bins_list.txt

2022-02-15
find -maxdepth 2 -type f -name "application.log" -not -name "Bin*" | awk -F "-" '{print $1}' | sed "s@./@@g" > /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/2022-02-14_Failed_bins_list.txt
cat 2022-02-14_Failed_bins_list.txt | sed "s@^@/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references/@g" | sed "s/$/.fa" > 2022-02-14_Failed_bin_paths_list.txt

while read -r line ; do target_path=$(echo "$line") && sbatch 2022-02-14_Failed_bin_paths_list.txt "$target_path" && printf "\nSubmitted job on file:\t$target_path\n" && sleep 5s ; done < 2022-02-14_Failed_bin_paths_list.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/PRJEB7759_files

new_name="ERR675515_1.fastq"

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/PRJEB7759_files

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping

45015198

2022-02-16
SRR9205149
SRR9205148
find -maxdepth 2 -type f -name "*SRR920514*" -print0 | xargs -0 rm -i


target_files=$(find -maxdepth 2 -type f -name "*.gff") && for f in $target_files ; do read_ID=$(grep 'product=')

printf "Read_ID\tBin\tLength\n" > 2022_02_16-All_reads_list_ID_bin_they_contain_length.tsv

target_files=$(find -maxdepth 1 -type f -name "Bin*.fa")
for f in $target_files ; do containing_bin=$(basename "$f" | awk -F)

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references/2022-02-16_all_Read_names_only.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Bins_cultures_MAGs_and_references/2022_02_16-All_reads_list_ID_bin_they_contain_length.tsv

split 994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names.txt -l 2711 --verbose -d -e 994_LIB8395_LDI7034_NoIndex-Human_mock-QCed.Cleansed.All_read_names_SPLIT_LIST_

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reads_list_files_human_mock

head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32

for f in *SPLIT_LIST* ; do output_string=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32) && sbatch --job-name="${output_string}_human_mock_taxid_search" 2022-02-16_human_mock_all_reads_kaiju_and_kraken_all_parameters_TaxIDs_to_be_submitted_by_for_loop_on_list_files.sh "$f" "$output_string" && echo "Submitted file: $f with output string: $output_string" && sleep 3s ; done

slurm-45047400.out

for f in *ERR675515* ; do errors_allowed=$(basename "$f" | awk -F "_" '{print $3}') && classified_reads=$(awk -F "\t" -v status="C" '$1 == status {print $0}' "$f" | wc -l) && printf "$errors_allowed\t$classified_reads\n" ; done < sort -V -k1

2022-02-18

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins

target_files=$(find -maxdepth 2 -type f -name "*.gff") && for f in $target_files ; do read_ID=$(grep 'product=') ; done

2022-02-21

export species_taxids=("470" "1660" "1396" "821" "1520" "1299" "1351" "562" "210" "1596" "1639" "487" "1747" "287" "1063" "1280" "1282" "1311" "1309" "1313") && for i in "${species_taxids[@]}" ; do taxid="$i" && grep -wq "$taxid" 994_LIB8395_LDI7034_NoIndex_L001_Metaphlan2-output_abundance_and_read_counts.txt && printf "TaxID:\t$i\tis present\n" ; done
export genus_taxids=("469" "2529408" "1386" "909656" "1485" "1298" "1350" "561" "209" "1578" "1637" "482" "1912216" "286" "1653176" "1279" "1301") && for i in "${genus_taxids[@]}" ; do taxid="$i" && grep -wq "$taxid" 994_LIB8395_LDI7034_NoIndex_L001_Metaphlan2-output_abundance_and_read_counts.txt && printf "TaxID:\t$i\tis present\n" ; done

input_fole="994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_0_allowed_errors.Taxon_names_added.out" && export species_taxids=("470" "1660" "1396" "821" "1520" "1299" "1351" "562" "210" "1596" "1639" "487" "1747" "287" "1063" "1280" "1282" "1311" "1309" "1313") && for i in "${species_taxids[@]}" ; do taxid="$i" && relevant_input=$(cat "$input_fole" | awk -F "\t" '{print $3}') && grep -wq "$taxid" "$relevant_input" && printf "TaxID:\t$i\tis present\n" ; done


input_fole="994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_10_allowed_errors.Taxon_names_added.out" && export species_taxids=("470" "1660" "1396" "821" "1520" "1299" "1351" "562" "210" "1596" "1639" "487" "1747" "287" "1063" "1280" "1282" "1311" "1309" "1313") && for i in "${species_taxids[@]}" ; do taxid="$i" && cat "$input_fole" | awk -F "\t" '{print $3}' > TEMP_working_file.txt && grep -wq "$taxid" TEMP_working_file.txt && printf "TaxID:\t$i\tis present\n" && rm TEMP_working_file.txt ; done | wc -l

input_fole="temp_hum_krak_taxids.txt" && export species_taxids=("470" "1660" "1396" "821" "1520" "1299" "1351" "562" "210" "1596" "1639" "487" "1747" "287" "1063" "1280" "1282" "1311" "1309" "1313") && for i in "${species_taxids[@]}" ; do taxid=$(echo "$i") && grep -m1 -q "$taxid" "$input_fole" && printf "TaxID:\t$i\tis present\n" ; done | wc -l

grep 'taxid' Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.095_conf_score_1.txt | awk -F "|" '{print $2}' | sort -n | uniq > temp_hum_krak_taxids.txt

2022-02-22
working_dir=$(pwd) && input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.095_conf_score_1.txt" && grep 'taxid' "$input_file" | awk -F "|" '{print $2}' | sort -V | uniq > "${working_dir}/2022_02_22_temporary_file_unique_mock_taxids.txt"

while read -r line ; do taxid="$line" && grep -qw "$taxid" 2022-02-22_all_unique_taxids_all_members_human_mock_genera_including_subspecies_from_NCBI.txt && printf "$taxid\tis a genus or below good hit\n" || echo "" ; done < 2022_02_22_temporary_file_unique_mock_taxids.txt | awk 'NF' | wc -l

2022-02-22_all_unique_taxids_species_level_and_below_human_mock_from_NCBI.txt

while read -r line ; do taxid="$line" && grep -qw "$taxid" 2022-02-22_all_unique_taxids_species_level_and_below_human_mock_from_NCBI.txt && printf "$taxid\tis a species or below good hit\n" || echo "" ; done < 2022_02_22_temporary_file_unique_mock_taxids.txt | awk 'NF' | wc -l

working_dir=$(pwd) && input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.010_conf_score_1.txt" && grep 'taxid' "$input_file" | awk -F "|" '{print $2}' | sort -V | uniq > "${working_dir}/2022_02_22_temporary_file_unique_mock_taxids.txt"

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

wc -l 2022_02_22_temporary_file_unique_mock_taxids.txt
rm 2022_02_22_temporary_file_unique_mock_taxids.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_0_allowed_errors.Taxon_names_added.out

working_dir=$(pwd) && input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_20_allowed_errors.Taxon_names_added.out" && awk -v stotus="C" -F "\t" '$1 == stotus {print $3}' "$input_file" | sort -V | uniq > "${working_dir}/2022_02_22_temporary_file_unique_mock_taxids.txt"
cat 994_LIB8395_LDI7034_NoIndex_L001_Metaphlan2-output_abundance_and_read_counts.txt | awk -F "\t" '{print $2}' | awk -F "|" '{print $NF}' | sort -V | uniq | grep -v "-" | grep -v "e" | wc -l

working_dir=$(pwd) && input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/metaphlan_outputs/994_LIB8395_LDI7034_NoIndex_L001_Metaphlan2-output_abundance_and_read_counts.txt" && cat "$input_file" | awk -F "\t" '{print $2}' | awk -F "|" '{print $NF}' | sort -V | uniq | grep -v "-" | grep -v "e" > "${working_dir}/2022_02_22_temporary_file_unique_mock_taxids.txt"

2022-02-23
working_dir=$(pwd) && input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.010_conf_score_1.txt" && grep 'taxid' "$input_file" | awk -F "|" '{print $2}' | sort -V | uniq > "${working_dir}/2022_02_22_temporary_file_unique_mock_taxids.txt"
while read -r line ; do taxid="$line" && grep -qw "$taxid" 2022-02-23_all_unique_taxids_all_members_human_mock_genera_including_subspecies_from_NCBI.txt && printf "$taxid\tis a genus or below good hit\n" || echo "" ; done < 2022_02_22_temporary_file_unique_mock_taxids.txt | awk 'NF' | wc -l
while read -r line ; do taxid="$line" && grep -qw "$taxid" 2022-02-22_all_unique_taxids_species_level_and_below_human_mock_from_NCBI.txt && printf "$taxid\tis a species or below good hit\n" || echo "" ; done < 2022_02_22_temporary_file_unique_mock_taxids.txt | awk 'NF' | wc -l
rm 2022_02_22_temporary_file_unique_mock_taxids.txt

working_dir=$(pwd) && input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_20_allowed_errors.Taxon_names_added.out" && awk -v stotus="C" -F "\t" '$1 == stotus {print $3}' "$input_file" | sort -V | uniq > "${working_dir}/2022_02_22_temporary_file_unique_mock_taxids.txt"
while read -r line ; do taxid="$line" && grep -qw "$taxid" 2022-02-23_all_unique_taxids_all_members_human_mock_genera_including_subspecies_from_NCBI.txt && printf "$taxid\tis a genus or below good hit\n" || echo "" ; done < 2022_02_22_temporary_file_unique_mock_taxids.txt | awk 'NF' | wc -l
while read -r line ; do taxid="$line" && grep -qw "$taxid" 2022-02-22_all_unique_taxids_species_level_and_below_human_mock_from_NCBI.txt && printf "$taxid\tis a species or below good hit\n" || echo "" ; done < 2022_02_22_temporary_file_unique_mock_taxids.txt | awk 'NF' | wc -l
rm 2022_02_22_temporary_file_unique_mock_taxids.txt

2022-02-27
/ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/RAW_read_run_results/metaphlan
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads/PRESERVED_PILOT_RAW_READS
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads/raw_data

for f in *.fastq ; do filenome=$(basename "$f") && read_count=$(grep -c "^@" "$f") && printf "$filenome\t$read_count\n" ; done | sort -V > 2022-02-27_read_counts_per_file.tsv

for f in *1.fq.gz ; do filenome=$(basename "$f") && read_count=$(zcat "$f" | grep -c "^@") && printf "$filenome\t$read_count\n" ; done | sort -V > 2022-02-27_read_counts_per_file.tsv

while read -r line ; do reads=$(echo "$line" | awk -F "\t" '{print $2}') && sample=$(echo "$line" | awk -F "\t" '{print $1}' | awk -F "-" '{print $4}') && printf "$sample\t$reads\n" ; done < 2022-02-27_read_counts_per_file.tsv

while read -r line ; do sangid=$(echo "$line" | awk -F " " '{print $1}') && export sampleID=$(echo "$line" | awk -F " " '{print $2}') && target_files=$(find -maxdepth 1 -type f -name "*$sangid*" -printf '%f\n') && for f in $target_files ; do nome=$(basename "$f") && replaceable=$(echo "$nome" | awk -F "-" '{print $4}') && newnome=$(echo "$nome" | sed "s/$replaceable/$sampleID/g") && printf "Will replace $f with $newnome\n" && mv "$f" "$newnome" ; done ; done < Sanger_ID_to_individual_and_season.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads/raw_data

sampleIDs=$(ls -l *.fq.gz | awk -F " " '{print $9}' | awk -F "_" '{print $1}' | sort -V | uniq) && for string in $sampleIDs ; do occurences=$(ls -l *1.fq.gz | grep "$string" | wc -l) && printf "$string\t$occurences\n" ; done

AC33N	2

994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_0_allowed_errors.Taxon_names_added.out
awk -F "\t" -v taxid="1063" '$3 == taxid {print $0}' 994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_0_allowed_errors.Taxon_names_added.out | wc -l
1422584

head Human_mock-Kaiju2table_0_errors_allowed-species_level_results.tsv
1470365

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs

current_dir=$(pwd) && target_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs" && cd "$target_dir" && for f in 994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_*_allowed_errors.Taxon_names_added.out ; do allowed_errors=$(basename "$f" | awk -F "_" '{print $7}') && unique_taxids=$(awk -F "\t" '{print $3}' "$f" | sort -V | uniq |wc -l) && awk -F "\t" '{print $3}' "$f" | sort -V | uniq > "${current_dir}/2022_02_28-Kaiju_human_mock_${allowed_errors}_allowed_errors_unique_taxids.txt" && taxids_more_10_reads=$(awk '$1 > 10 {print $0}' "${current_dir}/2022_02_28-Kaiju_human_mock_${allowed_errors}_allowed_errors_unique_taxids.txt" | wc -l) && printf "$allowed_errors\t$unique_taxids\t$taxids_more_10_reads\n" ; done && cd "$current_dir"

current_dir=$(pwd) && target_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs" && for f in "${target_dir}"/994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_*_allowed_errors.Taxon_names_added.out ; do allowed_errors=$(basename "$f" | awk -F "_" '{print $7}') && unique_taxids=$(awk -F "\t" '{print $3}' "$f" | sort -V | uniq |wc -l) && awk -F "\t" '{print $3}' "$f" | sort -V | uniq > "${current_dir}/2022_02_28-Kaiju_human_mock_${allowed_errors}_allowed_errors_unique_taxids.txt" && while read -r line ; do taxid=$(echo "$line") && taxid_occurrence=$(awk -F "\t" -v taxid="$taxid" '$3 == taxid {print $0}' "$f" | wc -l) && printf "$taxid\t$taxid_occurrence\n" >> "${current_dir}/2022_02_28-Kaiju_human_mock_${allowed_errors}_allowed_errors_unique_taxids_with_occurence.txt" ; done < "${current_dir}/2022_02_28-Kaiju_human_mock_${allowed_errors}_allowed_errors_unique_taxids.txt" && taxids_more_10_reads=$(awk '$1 > 10 {print $0}' "${current_dir}/2022_02_28-Kaiju_human_mock_${allowed_errors}_allowed_errors_unique_taxids_with_occurence.txt" | wc -l) && printf "$allowed_errors\t$unique_taxids\t$taxids_more_10_reads\n" ; done && rm "${current_dir}/2022_02_28-Kaiju_human_mock_${allowed_errors}_allowed_errors_unique_taxids_with_occurence.txt"

human_mock_known_TaxIDs.txt

countervari="0" && while read -r line ; do grep -q "$line" 2022_02_28-Kaiju_human_mock_0_allowed_errors_unique_taxids.txt && countervari=$(expr $countervari + 1) ; done < /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/Kaiju_short_or_report_file_versions/human_mock_known_TaxIDs.txt && echo "$countervari"

2022-03-01
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/DFAST_isolate_output/S123_Fastp_SPADES_careful_assembly-scaffolds-DFAST_output

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/DFAST_isolate_output/S123_Fastp_SPADES_careful_assembly-scaffolds-DFAST_output
source package /tgac/software/testing/bin/genometools-1.5.10

source package /tgac/software/testing/bin/gffread-0.11.4
gffread -T -o
gffread -T S123_Fastp_SPADES_careful_assembly-scaffolds_genome.gff -o S123_Fastp_SPADES_careful_assembly-scaffolds_genome.gtf

hslO

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/DFAST_isolate_output

overall_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/DFAST_isolate_output/" && target_files=$(find -maxdepth 2 -type f -name "*.gff") && for f in $target_files ; do nome=$(basename "$f") && containing_dir=$(echo "$f" | awk -F "/" '{print $2}') && newname=$(echo "$nome" | sed 's/gff/gtf/g') && printf "Will make a .gtf from input gff file:\t$nome\n" && gffread -T "$f" -o "${overall_dir}${containing_dir}/${newname}" && printf "Made a .gtf version of input file:\t$nome\n" ; done

target_files=$(find -maxdepth 2 -type f -name "*statistics.txt") && for f in $target_files ; do grep 'Number of CDSs' "$f" ; done

grep 'Number of CDSs' *.txt | awk -F "\t" '{print $2}'

k141_8190544	MetaGeneAnnotator	CDS	1192	2073	.	+	0	ID=MGA_2;product=phosphoribosylaminoimidazole-succinocarboxamide synthase;inference=COORDINATES:ab initio prediction:MetaGeneAnnotator,similar to AA sequence:UniProtKB:Q74BF0;translation=MENTDFKPVKEGKVREVYDAGDCMIITATDRISAFDHILKNKITGKGRVLTQMSKFWFDYTRDVVPNHMLSVDTADMPEFFRQKRFDGNSMKCRKLAMLPIECIVRGYITGSGWESYQKDGSVCGVRLPEGLKESDRLPEPVYTPTTKAELGLHDEHITYEESVDILEKIYPGKGAEYAARIKDCTLALYKKCEKYALKKGIIIADTKFEFGLDEAGSVVLGDEMLTPDSSRFWPLAGYEPGKSQPSFDKQFVRDWLKANPDSDYLLPEEIIDKTVQKYEEAFELLTGKKIDR;locus_tag=Bin_c1039_locus-_00010;gene=purC;EC_number=6.3.2.6;note=Q74BF0 phosphoribosylaminoimidazole-succinocarboxamide synthase (Geobacter sulfurreducens PCA) [pid:50.8%25%2C q_cov:97.6%25%2C s_cov:97.0%25%2C Eval:3.0e-79],COG:COG0152:PurC Phosphoribosylaminoimidazole-succinocarboxamide synthase [Category:F%2C Aligned:7-288%2C Eval:8.7e-82%2C score:244.4],MGA_2

locus_tag=Bin_c1039_locus-_00010

grep -a1 'Bin_c1039_locus-_00010' *.faa

Bin_c1039_locus-_12900
grep 'Bin_c1039_locus-_12910' *.faa
Bin_c1039_locus-_12920

grep 'k141' *.gff

k141_11555299	MetaGeneAnnotator	CDS	1310	1891	.	-	0	ID=MGA_1657;product=signal peptidase I;inference=COORDINATES:ab initio prediction:MetaGeneAnnotator,similar to AA sequence:UniProtKB:A0A0H3MU09;translation=MSKEELNVPSIELLEAELKREQYKTSYGRILRSTVFLLLVVAAAAVLIAMLLLPVLQVGGTSMTESLQDKDIVVAVSGNQYKTGDIIAFYYNNNILIKRVIAKAGDWVDIDRDGNVFVNDRQMEEPYVSDKAFGECNIDLPYQVPDGKCFVMGDHRATSIDSRNTSVGCVSGDMIVGRIVFRVWPFSDIGLLD;locus_tag=Bin_c1039_locus-_12900;EC_number=3.4.21.89;note=A0A0H3MU09 signal peptidase I (Streptococcus suis BM407) [pid:45.2%25%2C q_cov:96.4%25%2C s_cov:94.9%25%2C Eval:2.6e-49],MGA_1657
k141_11555299	MetaGeneAnnotator	CDS	1888	2352	.	-	0	ID=MGA_1658;product=hypothetical protein;inference=COORDINATES:ab initio prediction:MetaGeneAnnotator;translation=MTEKELRKLRRQDLLQLLLAQGKETAALQEAFEERGGKLQETQETVERLKAKLDEKDALIEKLKQRLDQKDAAIHGLRVEMEKWRSSRSIELKEAGSIAMAALKLNGVFDAAQRAADQYLFNIKRMYGGEANGGNRQAGTLREETKTDRIEEGT;locus_tag=Bin_c1039_locus-_12910;note=MGA_1658
k141_11555299	MetaGeneAnnotator	CDS	2622	3473	.	-	0	ID=MGA_1659;product=integrase;inference=COORDINATES:ab initio prediction:MetaGeneAnnotator,similar to AA sequence:RefSeq:WP_008764673.1;translation=MGEQKINKGEMLSYFARELKENEKSPATIGKYVRDAERFMEFTGENGAVTKEIVIAYKQYLAERYAVSSANSMLAALNCFLRIIGCGDCAVKFFKVQPTTFRARERELTREEYIRLVEAAKRKGKKCLSLIMQTICATGIRISELPFITAESLHTRRAQVSLKGKTRTVLLPAELCRELEKYVRERGIRSGSVFITRNGKALDRSNILHEMKFLCKEAGVETNKVFPHNLRHLFALTYYQAQRDICHLADLLGHSNINTTRIYTIASSEEQEQQIDGLGLLLL;locus_tag=Bin_c1039_locus-_12920;note=WP_008764673.1 integrase (Bacteroides thetaiotaomicron VPI-5482) [pid:31.1%25%2C q_cov:94.0%25%2C s_cov:98.1%25%2C Eval:1.6e-29],Domain:cl28330:XerC Integrase [Replication%2C recombination and repair%2C Mobilome: prophages%2C transposons]. The phage integrase family describes a number of recombinases with tyrosine active sites that transiently bind covalently to DNA. Many are associated with mobile DNA elements%2C including phage%2C transposons%2C and phase variation loci. This model represents XerD%2C one of two closely related chromosomal proteins along with XerC (TIGR02224). XerC and XerD are site-specific recombinases which help resolve chromosome dimers to monomers for cell division after DNA replication. In species with a large chromosome and with homologs of XerD on other replicons%2C the chomosomal copy was preferred for building this model. This model does not detect all XerD%2C as some apparent XerD examples score below the trusted and noise cutoff scores. XerC and XerD interact with cell division protein FtsK. [DNA metabolism%2C DNA replication%2C recombination%2C and repair] [Superfamily%2C Aligned:10-264%2C Eval:2.6e-24%2C score:96.5],MGA_1659

k141_11555299	MetaGeneAnnotator	CDS	2622	3473	.	-	0	ID=MGA_1659;product=integrase;inference=COORDINATES:ab initio prediction:MetaGeneAnnotator,similar to AA sequence:RefSeq:WP_008764673.1;translation=MGEQKINKGEMLSYFARELKENEKSPATIGKYVRDAERFMEFTGENGAVTKEIVIAYKQYLAERYAVSSANSMLAALNCFLRIIGCGDCAVKFFKVQPTTFRARERELTREEYIRLVEAAKRKGKKCLSLIMQTICATGIRISELPFITAESLHTRRAQVSLKGKTRTVLLPAELCRELEKYVRERGIRSGSVFITRNGKALDRSNILHEMKFLCKEAGVETNKVFPHNLRHLFALTYYQAQRDICHLADLLGHSNINTTRIYTIASSEEQEQQIDGLGLLLL;locus_tag=Bin_c1039_locus-_12920;note=WP_008764673.1 integrase (Bacteroides thetaiotaomicron VPI-5482) [pid:31.1%25%2C q_cov:94.0%25%2C s_cov:98.1%25%2C Eval:1.6e-29],Domain:cl28330:XerC Integrase [Replication%2C recombination and repair%2C Mobilome: prophages%2C transposons]. The phage integrase family describes a number of recombinases with tyrosine active sites that transiently bind covalently to DNA. Many are associated with mobile DNA elements%2C including phage%2C transposons%2C and phase variation loci. This model represents XerD%2C one of two closely related chromosomal proteins along with XerC (TIGR02224). XerC and XerD are site-specific recombinases which help resolve chromosome dimers to monomers for cell division after DNA replication. In species with a large chromosome and with homologs of XerD on other replicons%2C the chomosomal copy was preferred for building this model. This model does not detect all XerD%2C as some apparent XerD examples score below the trusted and noise cutoff scores. XerC and XerD interact with cell division protein FtsK. [DNA metabolism%2C DNA replication%2C recombination%2C and repair] [Superfamily%2C Aligned:10-264%2C Eval:2.6e-24%2C score:96.5],MGA_1659

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
>MGA_1657|Bin_c1039_locus-_12900 signal peptidase I
MADITLDGCGLFTSTGIPNIFIDKYMTNANGEFVKIYLYLLRCMNLNKQACTISELADTFEHTEKDILRALTYWEKMRLLRLEYDKNHEVSGILLQIPESEAFSRPKEPAQDTAPSASCAKDKKNTEYTLEQLEDFRKDESVQEVLFITENYLGRTLNSTDIQTILYWYDGLRFSADLIEYLVETCISNGHTSLRYMDKIALAWAGANITTVAQAKQEHSLHHQDTYAVMKAFGISGRNLISSELSAIRKWTGPYALSMDIIREACRRTIAATGKASFEYADTILTNWHKSNVHNLSDIVKLDAAHQKSRATAKNRETAPRSAAQNRFNNFPQRTYNYDQLEKQLLNTTH

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins

while read -r line ; do readname="$line" && target_files=$(find -maxdepth 2 -type f -name "*.gff") && for f in $target_files ; do grep "$readname"

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/Bin_c35-DFAST_output

AC4N

find -maxdepth 1 -type f -name "*AC4N*merged*" -prune -o -name "*AC4N*"

find -maxdepth 1 -type f -name "*AC4N*" -not -name "*merged*"

find -maxdepth 1 -type f -name "*AC4N*1.fq" -not -name "*merged*" -printf '%f\n' -exec cat > "AC4N_multiple_samples_merged_R_1.fq" {} +

fastp -i AC14N_multiple_samples_merged_R_1.fq -I AC14N_multiple_samples_merged_R_2.fq -o temp_AC1N_merged_R1.fastq -O temp_AC1N_merged_R2.fastq --dont_overwrite -V

grep 'locus_tag' ./Bin_m870-DFAST_output/Bin_m870_genome.gff | wc -l

grep 'k141_14366499' ./*/*.gff

read_name="k141_14366499" && containing_bin=$(grep "$read_name" ./*/*.gff | awk -F ":" '{print $1}' | awk -F "/" '{print $3}' | awk -F "_" '{print $1"_"$2}' | sort -V | uniq) && possible_products=$(grep "$read_name" ./*/*.gff | awk -F "product=" '{print $2}' | awk -F ";" '{print $1}' | awk 'NF' | tr "\n" "," | sed "s/,$//g") && inference_source=$(grep "$read_name" ./*/*.gff | awk -F "inference=" '{print $2}' | awk -F ":" '{print $1" "$2}' | awk 'NF' | tr "\n" "," | sed "s/,$//g") && locus_tags=$(grep "$read_name" ./*/*.gff | awk -F "locus_tag" '{print $2}' | awk -F ";" '{print $1}' | awk 'NF' | tr "\n" "," | sed "s/,$//g") && potential_gene_name=$(grep "$read_name" ./*/*.gff | awk -F "gene=" '{print $2}' | awk -F ";" '{print $1}' | awk 'NF' | tr "\n" "," | sed "s/,$//g") && printf "$read_name\t$containing_bin\t$possible_products\t$potential_gene_name\t$locus_tags\t$inference_source\n"

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads

2022-02-02

k141_2953801

read_name="k141_6220171" && containing_bin=$(grep "$read_name" ./*/*.gff | awk -F ":" '{print $1}' | awk -F "/" '{print $3}' | awk -F "_" '{print $1"_"$2}' | sort -V | uniq) && possible_products=$(grep "$read_name" ./*/*.gff | awk -F "product=" '{print $2}' | awk -F ";" '{print $1}' | awk 'NF' | tr "\n" "," | sed "s/,$//g") && inference_source=$(grep "$read_name" ./*/*.gff | awk -F "inference=" '{print $2}' | awk -F ":" '{print $1" "$2}' | awk 'NF' | tr "\n" "," | sed "s/,$//g") && locus_tags=$(grep "$read_name" ./*/*.gff | awk -F "locus_tag" '{print $2}' | awk -F ";" '{print $1}' | awk 'NF' | tr "\n" "," | sed "s/,$//g") && potential_gene_name=$(grep "$read_name" ./*/*.gff | awk -F "gene=" '{print $2}' | awk -F ";" '{print $1}' | awk 'NF' | tr "\n" "," | sed "s/,$//g") && printf "$read_name\t$containing_bin\t$possible_products\t$potential_gene_name\t$locus_tags\t$inference_source\n"

k141_11756006	Bin_c0	phosphoribosylamine--glycine ligase,hypothetical protein	purD	=Bin_c0_locus-_18870,=Bin_c0_locus-_18880	COORDINATES ab initio prediction,COORDINATES ab initio prediction
grep -A 1 'Bin_c0_locus-_18870' ./*/*.faa
./Bin_c0-DFAST_output/Bin_c0_protein.faa-MNILLLGSGGRESALAWKMSQSPLVDNLYIAPGNGGTAQYGKNVALSPLDFDSIGRFVAENAIDMIVPGNEDPLVAGIYDHFAGSGILVAGPSKAGAALEGSKDFAKAFMSRHGIPTARYQSFTAETVEDGYRFLESLQAPYVLKADGLAAGKGVLIIDSLDEAKAALAEMLGGMFGQSSATVVIEEFLSGIECSVFVLTDGNGGYRVLPVAKDYKRIGEGETGLNTGGMGAVSPVVFADDEFMAKVDSRIIRPTIDGLKKESITYRGFIFLGLINVGGEPMVIEYNVRMGDPETEAVMLRVDSDLVALLKAAAQGDLGELPLEISPKAAVTVMLVSGGYPGSYQKGKAISIDGVVEESIIFHAGTKVDDNGQLVTSGGRVMSVSSMADTVAEALEKSYRTASKVAFEGKNMRRDIGRDLLSLEASK

target_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.010_conf_score_1.txt" && while read -r line ; do taxid="$line" && search_taxid="taxid|${taxid}" && occurrence=$(grep -wc "$search_taxid" "$target_file") && printf "$taxid\t$occurrence\n" ; done < 2022_03_01-Kraken_human_mock_010_confidence_score_unique_taxids.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/accessory_or_support_files

2022-02-02_detailed_name_taxids_human_mock_known_members.tsv
grep -v -f <(gen_exclusions.sh) /var/log/admin.log

grep -v -f <(cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $5}') ./2022-02-22_all_unique_taxids_species_level_and_below_human_mock_from_NCBI.txt

species_taxids=$(cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $3}') && grep -v

grep -v -f <(cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $5}') tempor.txt

grep -wv -f <(cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $3}') 2022-02-23_all_unique_taxids_all_members_human_mock_genera_including_subspecies_from_NCBI.txt > tomper.txt

grep -wv -f <(cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $5}' | grep -v "E") tomper.txt > 2022-03-02_genera_level_taxids_excluding_exact_known_subspecies_or_strain_taxids_and_taxids_of_overall_species.txt

cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $5}' | grep -v "E" > 2022-03-02_exact_strain_taxIDs_only_not_species_or_any_other_strains.txt

grep -c -f <(cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $5}' | grep -v "E") /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.010_conf_score_1.txt

teesting.txt

grep -wc -f <(cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $5}' | grep -v "E") /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt

43622

grep -wc '400667' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt

grep -w -f <(cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $5}' | grep -v "E") /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt | sort -V | uniq | wc -l
2022-03-02_exact_species_taxIDs_only_not_exact_strains_or_any_other_strains.txt
grep -w -f <(cat 2022-03-02_exact_species_taxIDs_only_not_exact_strains_or_any_other_strains.txt) /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt | sort -V | uniq | wc -l

species_taxIDs=$(grep -w -f <(cat 2022-03-02_exact_species_taxIDs_only_not_exact_strains_or_any_other_strains.txt) /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt | sort -V | uniq | wc -l) && exact_taxIDs=$(grep -w -f <(cat 2022-03-02_exact_strain_taxIDs_only_not_species_or_any_other_strains.txt) /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt | sort -V | uniq | wc -l) && combined_taxids=$(echo "{$species_taxIDs + $exact_taxIDs}" | bc -l) && echo "$combined_taxids"

species_taxIDs=$(grep -w -f <(cat 2022-03-02_exact_species_taxIDs_only_not_exact_strains_or_any_other_strains.txt) /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt | sort -V | uniq | wc -l) && exact_taxIDs=$(grep -w -f <(cat 2022-03-02_exact_strain_taxIDs_only_not_species_or_any_other_strains.txt) /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt | sort -V | uniq | wc -l) && combined_taxids="${species_taxIDs} ${exact_taxIDs}" && echo "$combined_taxids"

species_taxIDs=$(cat 2022-03-02_exact_species_taxIDs_only_not_exact_strains_or_any_other_strains.txt) && exact_taxIDs=$(cat 2022-03-02_exact_strain_taxIDs_only_not_species_or_any_other_strains.txt) && combined_taxids=$(echo "${species_taxIDs} ${exact_taxIDs}" | tr " " "\n") && echo "$combined_taxids"

goodish_reads=$(grep -wc -f <(cat 2022-03-02_exact_strain_taxIDs_only_not_species_or_any_other_strains.txt 2022-03-02_exact_species_taxIDs_only_not_exact_strains_or_any_other_strains.txt) /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt) && echo "$goodish_reads"


goodish_reads=$(grep -wc -f <(cat 2022-03-02_exact_strain_taxIDs_only_not_species_or_any_other_strains.txt 2022-03-02_exact_species_taxIDs_only_not_exact_strains_or_any_other_strains.txt 2022-03-02_species_level_taxids_excluding_exact_known_subspecies_or_strain_taxids_and_taxids_of_overall_species.txt 2022-03-02_genera_level_taxids_excluding_exact_known_subspecies_or_strain_taxids_and_taxids_of_overall_species.txt) /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies/teesting.txt) && echo "$goodish_reads"

2022-03-03
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
declare -p

target_sampleIDs=$(find -maxdepth 1 -type f -name "*merged*.fq" -printf "%f\n" | awk -F "_" '{print $1}' | sort -V | uniq) && for string in $target_sampleIDs ; do somple="$string" && target_files=$(find -maxdepth 1 -type f -name "*$somple*" -not -name "*merged*") && for f in $target_files ; do mv "$f" novogene_merged_where_multiple_runs_same_samples && echo "Moved file: $f" ; done ; done

sed -i -e '1s/^/task goes here\n/' AC14N_multiple_samples_merged_R_1.fq

AC14N_multiple_samples_merged_R_1.fq

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads

cat AC14N_FDSW202491273-1r_HHGCHDSXY_L3_1.fq AC14N_FDSW202491273-1r_HCHTTDSXY_L4_1.fq > /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads/AC14N_multiple_samples_merged_R_1.fq
cat AC14N_FDSW202491273-1r_HHGCHDSXY_L3_2.fq AC14N_FDSW202491273-1r_HCHTTDSXY_L4_2.fq > /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads/AC14N_multiple_samples_merged_R_2.fq

sbatch 2022-03-03_run_fastp_on_Acomys_read_files_pilot_and_novogene_ones.sh

sed -i -e '1,2d' *merged*.fq

cat AC14N_FDSW202491273-1r_HHGCHDSXY_L3_1.fq AC14N_FDSW202491273-1r_HCHTTDSXY_L4_1.fq > AC14N_multiple_samples_merged_R_1.fq
cat AC14N_FDSW202491273-1r_HHGCHDSXY_L3_2.fq AC14N_FDSW202491273-1r_HCHTTDSXY_L4_2.fq > AC14N_multiple_samples_merged_R_2.fq

cat AC4N_FDME202491265-1a_HCLJNDSXY_L3_1.fq AC4N_FDME202491265-1a_H7YJTDSXY_L3_1.fq > AC14N_multiple_samples_merged_R_1.fq
cat AC4N_FDME202491265-1a_HCLJNDSXY_L3_2.fq AC4N_FDME202491265-1a_H7YJTDSXY_L3_2.fq > AC14N_multiple_samples_merged_R_2.fq


AC4N
AC6N
AC15N
AC23N
AC28N
AC33N
AC36N
AC37N
AC40N
AC44N
AR1N
AR3N
AR10N
AR20N
AR21N
AR26N
AR30N
AR38J
AR41N
AR42N
AR43N
AR45N
AR46N
AR47N
AR48N

45403286

sbatch --dependency=afterok:45403369 2022-03-03_run_fastp_on_Acomys_read_files_pilot_and_novogene_ones.sh

2022-03-04
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

target_files=$(find -maxdepth 1 -type f -name "*R1.fq" -print '%f\n') && for f in $target_files ; do r1=$(echo "$f") && r2=$(echo "$r1" | sed 's/R1.fq/R2.fq/g') && sampleid=$(echo "$r1" | awk -F "_" '{print $1}') && echo "First read is $r1 Second read is $r2 Sample ID is $sampleid" ; done

target_files=$(find -maxdepth 1 -type f -name "*R1.fq" -printf '%f\n') && for f in $target_files ; do r1=$(echo "$f") && r2=$(echo "$r1" | sed 's/R1.fq/R2.fq/g') && sampleid=$(echo "$r1" | tr "-" "_" | awk -F "_" '{print $1}') && species="${sampleid:0:2}" && echo "First read is $r1 Second read is $r2 Sample ID is $sampleid Host species is $species" ; done

AR9J_FDME202491231-1a_H7YJTDSXY_L3_1.QCed.R1.fq
AR9J_FDME202491231-1a_H7YJTDSXY_L3_1.QCed.R2.fq

input_R1="AC4N_multiple_samples_merged_R_1.QCed.R1.fq" && lane_change_name_1="L3_" && lane_change_name_2="L4_" && if grep -q "$lane_change_name_1" <<< "$input_R1" ; then input_R2=$(echo "$input_R1" | sed 's/L3_1/L3_2/g' | sed 's/R1.fq/R2.fq/g') ; elif grep -q "$lane_change_name_2" <<< "$input_R1" ; then input_R2=$(echo "$input_R1" | sed 's/L4_1/L4_2/g' | sed 's/R1.fq/R2.fq/g') ; else input_R2=$(echo "$input_R1" | sed 's/R1.fq/R2.fq/g') ; fi && echo "$input_R2"

AR27N-Arus-3258STDY6863973-E3_R1.QCed.R1.fq

AR27N-Arus-3258STDY6863973-E3_R1.QCed.R2.fq

2022-02-06

printf "Sample ID\tPercent reads matching to contaminant genomes\n" >> 2022-02-06_percent_reads_matching_contaminant_genomes_all_sampleIDs.txt && for f in *.txt ; do sampleid=$(basename "$f" | awk -F "." '{print $1}') && contam=$(grep 'Matched' "$f" |  awk -F "\t" '{print $3}' | tr -d "%") && printf "$sampleid\t$contam\n" ; done >> 2022-02-06_percent_reads_matching_contaminant_genomes_all_sampleIDs.txt

2022-02-06_percent_reads_matching_contaminant_genomes_all_sampleIDs.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/bbduk_outputs/cleansed_files

echo $(zcat yourfile.fastq.gz|wc -l)/4|bc

printf "Sample ID\tNumber of reads in QCed and cleansed R1 file\n" >> 2022-03-06_number_of_reads_in_QCed_and_cleansed_R1_read_file_all_sampleIDs.tsv && for f in *R1.fq ; do sampleid=$(basename "$f" | awk -F "." '{print $1}') && number_of_lines=$(wc -l "$f" | awk -F " " '{print $1}') && readcount=$(echo "$number_of_lines / 4" | bc) && printf "$sampleid\t$readcount\n" >> 2022-03-06_number_of_reads_in_QCed_and_cleansed_R1_read_file_all_sampleIDs.tsv ; done

printf "Sample ID\tNumber of reads in QCed and cleansed R1 file\n" >> 2022-03-06_number_of_reads_in_QCed_and_cleansed_R1_read_file_all_sampleIDs.tsv && for f in *R1.fq ; do sampleid=$(basename "$f" | awk -F "." '{print $1}') && number_of_lines=$(wc -l "$f" | awk -F " " '{print $1}') && readcount=$(echo "$number_of_lines / 4" | bc -l) && printf "$sampleid\t$readcount\n" ; done

pilot_individuals_array=("AC16" "AC18" "AC19" "AR27" "AR29" "AR32") && for i in "${pilot_individuals_array[@]}" ; do find -maxdepth 1 -type f -name "*R1.fq" -not -name "$i*" -printf '%f\n' ; done | sort -V | uniq

readarray -t non_pilot_array_R1_files < <(for i in "${pilot_individuals_array[@]}" ; do find -maxdepth 1 -type f -name "*R1.fq" -not -name "$i*" -printf '%f\n' ; done | sort -V | uniq) && for i in "${non_pilot_array_R1_files[@]}" ; do echo "$i" ; done


target_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies" && current_dir=$(pwd) && for f in "${target_dir}"/Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.*_conf_score_1.txt ; do confidence_score=$(basename "$f" | awk -F "." '{print $4}' | awk -F "_" '{print $1}') &&   grep 'taxid' "$f" | awk -F "taxid" '{print $2}' | tr -d "|" | sort -V > "${current_dir}/2022_03_03-Kraken_human_mock_${confidence_score}_confidence_score_ALL_taxids.txt" && while read -r line ; do printable_taxid=$(echo "$line") && taxid_occurrence=$(grep -cw "$printable_taxid" "${current_dir}/2022_03_03-Kraken_human_mock_${confidence_score}_confidence_score_ALL_taxids.txt") && printf "$printable_taxid\t$taxid_occurrence\n" >> "${current_dir}/2022_03_03-Kraken_human_mock_${confidence_score}_confidence_score_unique_taxids_with_occurence.txt" ; done < "${current_dir}/2022_03_03-Kraken_human_mock_${confidence_score}_confidence_score_unique_taxids.txt" ; done
#erh
2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt

taxids_more_than_minimum_read_count=$(awk '$1 > '"100"' {print $0}' "2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt" | wc -l)

cat 2022_03_03-Kraken_human_mock_095_confidence_score_unique_taxids_with_occurence.txt | awk -F " " '$2 > 100' | wc -l

2022-03-09
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/AC16J_pilot_sample_.Kaiju_output_1_allowed_errors.out.gz

2022-03-12

gzip 2022-03-08_classify_multiple_parameters_metaphlan_kaiju_kraken_all_processed_Acomys_files_pilot_and_Novogene.PARTIALLY_SUCCESSFUL_RUN-Pilot_samples_only.slurm-45555842.out

target_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Chris_and_Seb_bins_fasta_files" && while read -r line ; do target_file="$line" && cp "$target_file" "$target_dir" && printf "Copied file:\t$target_file\n" ; done < List_of_bins_paths.txt
target_files=$(find -maxdepth 3 -type f -name "*.fastq.gz") && for f in $target_files ; do echo "Will unzip file: $f" && gunzip "$f" && echo "Unzipping done" ; done

target_dir="" && target_files=$(find -maxdepth 3 -type f -name "*.fastq") && for f in $target_files ; do

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Chris_and_Seb_bins_fasta_files
2022_03_12-Concatenated_CQ_and_SR_bins.fa

PID-0678-890_S125_R1_001.fastq  PID-0678-890_S125_R2_001.fastq
PID-0578-r-18A_S9_R1_001.fastq  PID-0578-r-18A_S9_R2_001.fastq
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
find -maxdepth 1 -type f -not -name "S1*"

2022-03-13
AC4N.QCed.Cleansed.Subsampled.R1.fq

diff AC4N_R1_reads_list.txt AC4N_R2_reads_list.txt > Differences_AC4N_R1_to_R2.txt

diff -y AC4N_R1_reads_list.txt AC4N_R2_reads_list.txt > Differences_AC4N_R1_to_R2.txt

grep "^@A" AR43J.QCed.Cleansed.Subsampled.R1.fq | awk -F " " '{print $1}' > AR43J_R1_reads.txt
grep "^@A" AR43J.QCed.Cleansed.Subsampled.R2.fq | awk -F " " '{print $1}' > AR43J_R2_reads.txt

diff -q AR43J_R1_reads.txt AR43J_R2_reads.txt

for f in *R1.fq* ; do sampleID=$(basename "$f" | awk -F "." '{print $1}') && grep "^@A" "$f" | awk -F " " '{print $1}' > "${sampleID}.R1.reads_list.txt" && echo "Processed $f" ; done
for f in *R2.fq* ; do sampleID=$(basename "$f" | awk -F "." '{print $1}') && grep "^@A" "$f" | awk -F " " '{print $1}' > "${sampleID}.R2.reads_list.txt" && echo "Processed $f" ; done

grep "^@A" AC4J.QCed.Cleansed.R1.fq | awk -F " " '{print $1}' > AC4J_R1_reads_list.txt
grep "^@A" AC4J.QCed.Cleansed.R2.fq | awk -F " " '{print $1}' > AC4J_R2_reads_list.txt

grep "^@A" AC4N.QCed.Cleansed.R1.fq | awk -F " " '{print $1}' > AC4N_R1_reads_list.txt
grep "^@A" AC4N.QCed.Cleansed.R2.fq | awk -F " " '{print $1}' > AC4N_R2_reads_list.txt

grep "^@A" AC4J_FDME202491227-1a_HCJKCDSXY_L3_1.QCed.R1.fq | awk -F " " '{print $1}' > AC4J_R1_reads_list.txt
grep "^@A" AC4J_FDME202491227-1a_HCJKCDSXY_L3_2.QCed.R1.fq | awk -F " " '{print $1}' > AC4J_R2_reads_list.txt

grep "^@A" AC4N_multiple_samples_merged_R_1.fq | awk -F " " '{print $1}' > AC4N_R1_reads_list.txt
grep "^@A" AC4N_multiple_samples_merged_R_2.fq | awk -F " " '{print $1}' > AC4N_R2_reads_list.txt

grep "^@A" AC14N_multiple_samples_merged_R_1.fq | awk -F " " '{print $1}' > AC14N_R1_reads_list.txt && grep "^@A" AC14N_multiple_samples_merged_R_2.fq | awk -F " " '{print $1}' > AC14N_R2_reads_list.txt

grep "^@A"

zcat AC4N_FDME202491265-1a_HCLJNDSXY_L3_1.fq.gz | grep "^@A" | awk -F " " '{print $1}' > AC4N_R1_reads_list.txt && zcat AC4N_FDME202491265-1a_HCLJNDSXY_L3_2.fq.gz | grep "^@A" | awk -F " " '{print $1}' > AC4N_R2_reads_list.txt

grep "^@A" AR21N_multiple_samples_merged_R_1.fq | awk -F " " '{print $1}' > AR21N_R1_reads_list.txt && grep "^@A" AR21N_multiple_samples_merged_R_2.fq | awk -F " " '{print $1}' > AR21N_R2_reads_list.txt

grep "^@A" AC4J.QCed.Cleansed.Subsampled.R1.fq.UNSORTED | awk -F " " '{print $1}' > AC4J_R1_reads_list.txt && grep "^@A" AC4J.QCed.Cleansed.Subsampled.R2.fq.UNSORTED | awk -F " " '{print $1}' > AC4J_R2_reads_list.txt && diff -q AC4J_R2_reads_list.txt AC4J_R1_reads_list.txt && rm AC4J_R2_reads_list.txt && rm AC4J_R1_reads_list.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads/samples_with_multiple_runs

while read -r line ; do sampleID="$line" && number_files=$(ls -l "${sampleID}"*.gz | wc -l) && target_files=$(find -maxdepth 1 -type f -name "$sampleID*.gz" -printf '%f\n') && if [[ "$number_files" -gt "2" ]] ; then for f in $target_files ; do cp "$f" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads/samples_with_multiple_runs ; done ; else printf "\nSample:\t$sampleID\thas only two files\n" ; fi ; done < 2022-03-13_list_unique_sampleIDs.txt

  AC4N not same
  AR48N not same
  AC40N not same
  AC36N not same
  AR20N not same
  AR3N not same
  AR42N not same
  AC33N not same
  AR10N not same
  AR26N not same
  AR45N not same
  AC28N not same
  AC44N not same

AC4N
AC6N
AC14N
AC15N
AC23N
AC25N
AC28N
AC33N
AC36N
AC37N
AC40N
AC44N
AR1N
AR3N
AR10N
AR20N
AR21N
AR26N
AR30N
AR38J
AR41N
AR42N
AR43N
AR45N
AR46N
AR47N
AR48N

AR20N_multiple_samples_merged_R_1.QCed.R1.fq

AR48N_multiple_samples_merged_R_1.fq

grep "^@A" AR48N_multiple_samples_merged_R_1.fq | awk -F " " '{print $1}' > AR48N_R1_reads_list.txt && grep "^@A" AR48N_multiple_samples_merged_R_2.fq | awk -F " " '{print $1}' > AR48N_R2_reads_list.txt


2022-03-14
for f in *_multiple_samples_merged_R_1.fq ; do r1f="$f" && r2f=$(basename "$f" | sed 's/_R_1.fq/_R_2.fq/g') && r1_reads=$(grep "^@A" "$r1f" | head -10 | awk -F " " '{print $1}') && r2_reads=$(grep "^@A" "$r2f" | head -10 | awk -F " " '{print $1}') && sampleID=$(basename "$f" | awk -F "_" '{print $1}') && printf "SAMPLE:\t$sampleID\n$r1_reads\t$r2_reads\n" ; done

45613424

sbatch --dependency=afterok:45613424 2022-03-04_host_and_human_cleanse_with_BBDuk_QCed_Acomys_Novogene_and_pilot_files.sh

45613444

sbatch --dependency=afterok:45613444 2022-03-06_Subsample_QCed_and_cleansed_Acomys_files_two_sizes_for_pilot_or_novogene_sequence_runs.sh

45613463

sbatch --dependency=afterok:45613463 2022-03-08_classify_multiple_parameters_metaphlan_kaiju_kraken_all_processed_Acomys_files_pilot_and_Novogene.sh

2022-03-15
current_dir=$(pwd) && target_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/human_only_file_copies" && for f in "${target_dir}"/994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_*_allowed_errors.Taxon_names_added.out ; do allowed_errors=$(basename "$f" | awk -F "_" '{print $7}') && unique_taxids=$(awk -F "\t" '$1 == "C" {print $3}' "$f" | sort -V | uniq) && printf "$unique_taxids" > "${current_dir}/2022_03_01-Kaiju_human_mock_${allowed_errors}_allowed_errors_unique_taxids.txt" ; done

current_dir=$(pwd) && target_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output/human_only_file_copies" && for f in "${target_dir}"/Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.*_conf_score_1.txt ; do confidence_score=$(basename "$f" | awk -F "." '{print $4}' | awk -F "_" '{print $1}') && unique_taxids=$(grep 'taxid' "$f" | awk -F "taxid" '{print $2}' | tr -d "|" | sort -V | uniq) && printf "$unique_taxids" > "${current_dir}/2022_03_03-Kraken_human_mock_${confidence_score}_confidence_score_unique_taxids.txt" && echo "Done one round" ; done

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

for f in *allowed_errors_unique_taxids.txt ; do while read -r line ; do taxid="$line" && grep -q "$taxid" "$f" || printf "\nTaxid:\t$taxid is absent from file:\t$f" ; done < 2022-03-02_exact_strain_taxIDs_only_not_species_or_any_other_strains.txt ; done
confidence_score_unique_taxids.txt
for f in *confidence_score_unique_taxids.txt ; do while read -r line ; do taxid="$line" && grep -q "$taxid" "$f" || printf "\nTaxid:\t$taxid is absent from file:\t$f" ; done < 2022-03-02_exact_strain_taxIDs_only_not_species_or_any_other_strains.txt ; done

2022-03-17
sbatch 2022-03-17_BWA_map_subsampled_processed_acomys_reads_to_concatenated_bins_reference_fasta.sh AC16J.QCed.Cleansed.Subsampled.R1.fq AC16J.QCed.Cleansed.Subsampled.R2.fq
45671931

18C_S11
source package /tgac/software/testing/bin/seqtk-20150226

while read -r line
 do
   contig=$(echo "$line" | awk -F "\t" '{print $1}')
   contig_length=$(echo "$line" | awk -F "\t" '{print $2}')
   mapped_segments=$(echo "$line" | awk -F "\t" '{print $3}')
   unmapped_segments=$(echo "$line" | awk -F "\t" '{print $4}')
   kilobase_length=$(echo "$contig_length / 1000" | bc -l)
   kilobase_adjusted_mapped_count=$(echo "$mapped_segments / $kilobase_length" | bc -l)
   kb_and_lib_size_adjusted_count=$(echo "$kilobase_adjusted_mapped_count / $LIB_SIZE" | bc -l | awk '{printf "%f", $0}')
   printf "$contig,$contig_length,$kb_and_lib_size_adjusted_count,$unmapped_segments\n" >> "${LOBEL}_only_primary_mapping_contig_size_and_library_size_adjusted_mapped_read_counts_with_contig_lengths_and_unmapped_read_segment_counts.csv"
 done < "${label}-Only_primary-Sorted-IDXStats.txt"
}

export NOME=$(basename "$inpf" | awk -F "_" '{print $1}' | awk -F "-" '{print $2}')
 grep -q "$NOME" "$PILOT_LIST_FILE" && export LIB_SIZE="4.5" && printf "\nFile $inpf represents a pilot sample\n" || export LIB_SIZE="9.5" && printf "\nFile $inpf is not a pilot sample\n"

export pilot_array=("AC16J AC16N AC18J AC18N AC19J AC19N AR27J AR27N AR29J AR29N AR34J AR34N")
for i in "${kraken_conf_score_array[@]}"

2022-03-18

for f in *R1.fq ; do sampleID=$(basename "$f" | awk -F "." '{print $1}') && for i in "${pilot_array[@]}" ; do echo "$i" | grep -q "$sampleID" && echo "File $f is a pilot file" || echo "" ; done ; done

AC25J.QCed.Cleansed.Subsampled.R1.fq
30400000 / 4 = 7600000

sbatch TEMP_get_counts_R1_files_in_directory.sh /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/seqtk_outputs
sbatch TEMP_get_counts_R1_files_in_directory.sh /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/bbduk_outputs/cleansed_files
sbatch TEMP_get_counts_R1_files_in_directory.sh /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/fastp_outputs


export pilot_array=("AC16J AC16N AC18J AC18N AC19J AC19N AR27J AR27N AR29J AR29N AR34J AR34N")
for i in "${pilot_individuals_array[@]}" ; do ls "$i"* ; done

3930648167255573

target_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/seqtk_outputs" && for i in "${pilot_individuals_array[@]}" ; do input_file_R1=$(ls -l $i* | head -1 | awk -F " " '{print $9}') && r1_file="$input_file_R1" && sampleID=$(basename "$r1_file" | awk -F "." '{print $1}') && r2_file=$(echo "$r1_file" | sed 's/R1.fq/R2.fq/g') && final_depth="4460000" && random_seed="3930648167255573" && seqtk sample -s"$random_seed" "$r1_file" "$final_depth" > "${target_dir}/${sampleID}.QCed.Cleansed.Subsampled.R1.fq" && echo "Processed file $input_file_R1" && seqtk sample -s"$random_seed" "$r2_file" "$final_depth" > "${target_dir}/${sampleID}.QCed.Cleansed.Subsampled.R2.fq" && echo "Processed file $input_file_R2" ; done

.96268153823077043627

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
k141_4280248 0
k141_9129933 0
AC16J_BWA_against_concatenated_bins.Mapped.Sorted.Only_reads.IDX_stats.txt

k141_15347541

k141_11756006	2597	3

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
45702045


2022-03-19
this failed before, trying again
sbatch 2022-03-17_BWA_map_subsampled_processed_acomys_reads_to_concatenated_bins_reference_fasta.sh AC4N.QCed.Cleansed.Subsampled.R1.fq AC4N.QCed.Cleansed.Subsampled.R2.fq
slurm-45704743.out

2022-03-20
k141_5539950	0.471187
k141_5539950	2234	8	0

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_reference_files/2022-03-18_all_contigs_and_lengths.tsv

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Chris_and_Seb_bins_fasta_files

grep -w 'k141_5539950' Bin*.fa | awk -F ":" '{print $1}' | sed 's/.fa//g'

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/2022_03_02_Bin_reads_DFAST_output_limited_information_including_genes_products_locus_tags.txt
grep -w 'k141_5539950' 2022_03_02_Bin_reads_DFAST_output_limited_information_including_genes_products_locus_tags.txt | awk -F "\t" '{print $3}' | awk 'NF'
grep -w 'k141_9129933' 2022_03_02_Bin_reads_DFAST_output_limited_information_including_genes_products_locus_tags.txt | awk -F "\t" '{print $3}'

grep -w 'k141_5539950' 2022_03_02_Bin_reads_DFAST_output_limited_information_including_genes_products_locus_tags.txt | awk -F "\t" '{print $4}' | awk 'NF'

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/concatenated_bin_fasta_file_results/kaiju/2022-03-12_Concatenated_bins_fasta_file_analysis.Kaiju_output_1_allowed_errors.Taxon_names_added.out
grep -w 'k141_5539950' 2022-03-12_Concatenated_bins_fasta_file_analysis.Kaiju_output_1_allowed_errors.Taxon_names_added.out | awk -F "\t" '{print $3}' | awk 'NF'
grep -w 'k141_5539950' 2022-03-12_Concatenated_bins_fasta_file_analysis.Kaiju_output_1_allowed_errors.Taxon_names_added.out | awk -F "\t" '{print $8}'

trial=$(grep -w 'k141_5539950' 2022-03-12_Concatenated_bins_fasta_file_analysis.Kaiju_output_1_allowed_errors.Taxon_names_added.out | awk -F "\t" '{print $8}' | tr ";$" "@") && trod="${trial##*;}" && echo "$trod"

trial=$(grep -w 'k141_5539950' 2022-03-12_Concatenated_bins_fasta_file_analysis.Kaiju_output_1_allowed_errors.Taxon_names_added.out | awk -F "\t" '{print $8}' | rev | cut -f2 -d ";" | rev | sed "s/^ //g") && echo "$trial"

grep -w 'k141_14913039' 2022-03-12_Concatenated_bins_fasta_file_analysis.Kaiju_output_1_allowed_errors.Taxon_names_added.out | awk -F "\t" '{print $3}' | awk 'NF'
grep -w 'k141_14913039' 2022-03-12_Concatenated_bins_fasta_file_analysis.Kaiju_output_1_allowed_errors.Taxon_names_added.out | awk -F "\t" '{print $8}'

k141_14913039

grep -w 'k141_14913039' 2022_03_02_Bin_reads_DFAST_output_limited_information_including_genes_products_locus_tags.txt | awk -F "\t" '{print $3}' | awk 'NF'
grep -w 'k141_14913039' 2022_03_02_Bin_reads_DFAST_output_limited_information_including_genes_products_locus_tags.txt | awk -F "\t" '{print $3}'

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results
/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/template_reads_list.tsv


target_files=$(find -maxdepth 2 -type f -name "*BWA_against_concatenated_bins.Mapped.Sorted.Only_reads.IDX_stats.Contig_size_and_library_size_adjusted.tsv") && for f in $target_files ; do container=$(echo "$f" | awk -F "/" '{print $1"/"$2}') && sampleID=$(echo "$container" | awk -F "/" '{print $2}') && printf "$sampleID\n" > "${container}/${sampleID}.Just_adjusted_mapping_scores_in_order.tsv" && cat "$f" | awk -F "\t" '{print $1}' >> "${container}/${sampleID}.Just_adjusted_mapping_scores_in_order.tsv"

template_file="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/template_reads_list.tsv" && target_files=$(find -maxdepth 2 -type f -name "*BWA_against_concatenated_bins.Mapped.Sorted.Only_reads.IDX_stats.Contig_size_and_library_size_adjusted.tsv") && for f in $target_files ; do container=$(echo "$f" | awk -F "/" '{print $1"/"$2}') && sampleID=$(echo "$container" | awk -F "/" '{print $2}') && cat "$f" | awk -F "\t" '{print $1}' >> "${container}/${sampleID}.Just_adjusted_mapping_scores_file_reads_in_order.tsv" && diff -q "${container}/${sampleID}.Just_adjusted_mapping_scores_file_reads_in_order.tsv" "$template_file" && printf "\n$sampleID reads list is same\n" && rm "${container}/${sampleID}.Just_adjusted_mapping_scores_file_reads_in_order.tsv" ; done

thisdir=$(pwd) && target_files=$(find -maxdepth 2 -type f -name "*BWA_against_concatenated_bins.Mapped.Sorted.Only_reads.IDX_stats.Contig_size_and_library_size_adjusted.tsv") && for f in $target_files ; do container=$(echo "$f" | awk -F "/" '{print $1"/"$2}') && sampleID=$(echo "$container" | awk -F "/" '{print $2}') && printf "$sampleID\n" > "${container}/${sampleID}.Just_adjusted_mapping_scores_in_order.tsv" && cat "$f" | awk -F "\t" '{print $2}' >> "${container}/${sampleID}.Just_adjusted_mapping_scores_in_order.tsv" && cp "${container}/${sampleID}.Just_adjusted_mapping_scores_in_order.tsv" "$thisdir" ; done

2022-03-21
k141_10000100

input_file="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_reference_files/2022-03-18_all_contigs_and_lengths.tsv" && output_file="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_reference_files/2022-03-20_contigs_and_their_bin_list.tsv" && while read -r line ; do contig=$(echo "$line" | awk -F "\t" '{print $1}') && bin=$(grep -w "$line" /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Chris_and_Seb_bins_fasta_files/Bin*.fa | awk -F ":" '{print $1}' | awk -F "/" '{print $8}' | sed 's/.fa//g' | awk 'NF') && printf "$contig\t$bin\n" >> "$output_file" ; done < "$input_file"

for f in Bin*.fa ; do bin_name=$(basename "$f" | awk -F ".f" '{print $1}') && reads=$(grep ">k141" "$f" | awk -F " " '{print $1}' | tr -d ">" | sed "s/$/\t$bin_name/g") && printf "$reads\n" ; done | sort -h -k1

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_reference_files

grep -v < <(cat 2022-03-21_list_unique_genes_from_DFAST.txt) 2022-03-21_list_unique_DFAST_products.txt

grep -v < <(while read -r line ; do echo "$line" ; done < 2022-03-21_list_unique_genes_from_DFAST.txt) 2022-03-21_list_unique_DFAST_products.txt | sort -V | uniq

grep -v < <(while read -r line ; do echo "$line" ; done < 2022-03-21_list_unique_DFAST_products.txt) 2022-03-21_list_unique_genes_from_DFAST.txt | sort -V | uniq

while read -r line ; do thingy="$line" && fgrep -q "$thingy" 2022-03-21_list_unique_genes_from_DFAST.txt && printf "$thingy\n" ; done < 2022-03-21_list_unique_DFAST_products.txt | sort -V | uniq > genes_list_2.txt

while read -r line ; do thingy="$line" && fgrep -q "$thingy" 2022-03-21_list_unique_genes_from_DFAST.txt && printf "$thingy\n" ; done < 2022-03-21_list_unique_DFAST_products.txt | sort -V | uniq

target_files=$(find -maxdepth 2 -type f -name "*.faa") && for f in $target_files ; do grep '>' "$f" ; done

target_files=$(find -maxdepth 2 -type f -name "*.faa") && for f in $target_files ; do grep '>' "$f" | awk -v n=2 -F " " '{ for (i=n; i<=NF; i++) printf "%s%s", $i, (i<NF ? OFS : ORS)}' ; done

target_files=$(find -maxdepth 2 -type f -name "*.faa") && for f in $target_files ; do grep '>' "$f"; done | grep -w "MgtE"

target_files=$(find -maxdepth 2 -type f -name "*.faa") && for f in $target_files ; do grep '>' "$f" | awk -v n=2 -F " " '{ for (i=n; i<=NF; i++) printf "%s%s", $i, (i<NF ? OFS : ORS)}' ; done | sort -V | uniq | sed 's/%/ (percent sign) /g' | tr '[]' '()'

input_file="2022-02-16_all_Read_names_only.txt" && while read -r line ; do contig="$line" && loci=$(grep "$contig" ./*/*.gff | awk -F "locus_tag=" '{print $2}' | awk -F ";" '{print $1}' | awk 'NF' | tr "\n" "," | head -c-1) && for i in $loci ; do grep "$i" */*.faa | awk -v n=2 -F " " '{ for (i=n; i<=NF; i++) printf "%s%s", $i, (i<NF ? OFS : ORS)}' ; done ; done

./configure && make && make install
/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results
/hpc-home/osbourne/datamash/datamash-1.7/datamash

grep "k141_10000100" ./*/*.gff | awk -F "score:" '{print $2}' | awk -F "]" '{print $1}' | awk 'NF' | sort -h | tail -1

best_score=$(grep "k141_10000100" ./*/*.gff | awk -F "score:" '{print $2}' | awk -F "]" '{print $1}' | awk 'NF' | sort -h | tail -1) && echo "$best_score" && best_score_locus=$(grep "score:${best_score}" ./*/*.gff | grep "k141_10000100" | awk -F "locus_tag=" '{print $2}' | awk -F ";" '{print $1}') && echo "$best_score_locus" && best_score_product=$(fgrep "$best_score_locus" ./*/*.faa | awk -F "${best_score_locus} " '{print $2}') && echo "$best_score_product"
298.3

while read -r line ; do contig="$line" && best_score=$(grep "$contig" ./*/*.gff | awk -F "score:" '{print $2}' | awk -F "]" '{print $1}' | awk 'NF' | sort -h | tail -1) && best_score_locus=$(grep "score:${best_score}" ./*/*.gff | grep "$contig" | awk -F "locus_tag=" '{print $2}' | awk -F ";" '{print $1}') && best_score_product=$(fgrep "$best_score_locus" ./*/*.faa | awk -F "${best_score_locus} " '{print $2}') && printf "$contig\t$best_score\t$best_score_locus\t$best_score_product\n" ; done < 2022-02-16_all_Read_names_only.txt

while read -r line ; do contig="$line" && best_score=$(grep "$contig" ./*/*.gff | awk -F "score:" '{print $2}' | awk -F "]" '{print $1}' | awk 'NF' | sort -h | tail -1 | awk 'NF') && if [[ -z "$best_score" ]] ; then echo "$contig has nothing" ; else best_score_locus=$(grep "score:${best_score}" ./*/*.gff | grep "$contig" | awk -F "locus_tag=" '{print $2}' | awk -F ";" '{print $1}') && best_score_product=$(fgrep "$best_score_locus" ./*/*.faa | awk -F "${best_score_locus} " '{print $2}') && printf '%s\n' "$contig@$best_score@$best_score_locus@$best_score_product£" | tr "@" "\t" | tr "£" "\n" | awk 'NF' ; fi ; done < 2022-02-16_all_Read_names_only.txt

readarray -t contigs < <(grep -w 'Bin_m273' 2022-03-21_contigs_and_their_bins.tsv | awk -F "\t" '{print $1}') && for i in "${contigs[@]}" ; do read="$i" && count=$(grep -w "$read" /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/AR24J/AR24J_BWA_against_concatenated_bins.Mapped.Sorted.Only_reads.IDX_stats.Contig_size_and_library_size_adjusted.tsv | awk -F "\t" '{print $2}') && echo "$count" ; done | paste -sd + | bc -l

while read -r line ; do bin="$line" && readarray -t contigs < <(grep -w "$bin" 2022-03-21_contigs_and_their_bins.tsv | awk -F "\t" '{print $1}') && for i in "${contigs[@]}" ; do read="$i" && count=$(grep -w "$read" /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/AR24J/AR24J_BWA_against_concatenated_bins.Mapped.Sorted.Only_reads.IDX_stats.Contig_size_and_library_size_adjusted.tsv | awk -F "\t" '{print $2}') && echo "$count" ; done | ( read bin_count; paste -sd + | bc -l) && printf "$bin\t$bin_count\n" ; done < 2022-03-21_list_unique_bins.txt

2022-03-23
for f in *-2022-03-21_kilobase_and_library_size_adjusted_per_bin_summed_mapping_scores.tsv ; do sampleID=$(basename "$f" | awk -F "-" '{print $1}') && printf "$sampleID\n" > "${sampleID}.Just_adjusted_mapping_scores_in_same_order_as_bins.tsv" && cat "$f" | awk -F "\t" '{print $2}' >> "${sampleID}.Just_adjusted_mapping_scores_in_same_order_as_bins.tsv" && echo "Processed file for sample: $sampleID" ; done

list_just_bins_in_same_order.tsv

paste -d "\t" list_just_bins_in_same_order.tsv *Just_adjusted_mapping_scores_in_same_order_as_bins.tsv > 2022-03-23_contig_and_library_size_adjusted_summed_to_bins_mapping_counts_all_samples.tsv

for f in *-2022-03-21_kilobase_and_library_size_adjusted_per_Kaiju_taxid_summed_mapping_scores.tsv ; do sampleID=$(basename "$f" | awk -F "-" '{print $1}') && printf "$sampleID\n" > "${sampleID}.Just_adjusted_mapping_scores_in_same_order_as_Kaiju_taxids.tsv" && cat "$f" | awk -F "\t" '{print $2}' >> "${sampleID}.Just_adjusted_mapping_scores_in_same_order_as_Kaiju_taxids.tsv" && echo "Processed file for sample: $sampleID" ; done

paste -d "\t" list_just_taxids_in_same_order.tsv *Just_adjusted_mapping_scores_in_same_order_as_Kaiju_taxids.tsv > 2022-03-23_contig_and_library_size_adjusted_summed_to_Kaiju_taxids_mapping_counts_all_samples.tsv

/hpc-home/osbourne/datamash/datamash-1.7/datamash transpose ./2022-03-23_contig_and_library_size_adjusted_summed_to_bins_mapping_counts_all_samples.tsv

cat 2022-03-23_contig_and_library_size_adjusted_summed_to_bins_mapping_counts_all_samples.tsv | /hpc-home/osbourne/datamash/datamash-1.7/datamash transpose

2807577

2022-03-24
/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/gtdb_tk_database

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/gtdb_tk_database

gtdbtk_data.tar.gz

2022-03-25
/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/GTDB-TK_testing_dir

countup="0" && while read -r line ; do echo "Count: $countup" && let "countup+=1" && grep -wq "$line" slurm-46009786.out || echo "$line is absent from the slurm output" ; done < /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/template_reads_list.tsv

slurm-46009786.out

countup="0" && while read -r line ; do echo "Count: $countup" && let "countup+=1" && grep -wq "$line" /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/template_reads_list.tsv || echo "$line is absent from the list of reads file in the other directory" ; done < list_of_reads_only_from_slurm_output_file_for_find_highest_scoring_product_per_read.txt

Bin_c1043_locus-_22230

grep -A 1 -B 1 'Bin_c1043_locus-_22230' slurm-46009786.out

k141_14210847	187.8	Bin_c1043_locus-_22180
Bin_c1043_locus-_22230
k141_11602491 has nothing

Bin_c101_locus-_19160
grep -A 1 -B 1 'Bin_c101_locus-_19160' slurm-46009786.out

k141_3002235	442.4	Bin_c101_locus-_19150
Bin_c101_locus-_19160
k141_12803244	46.8%2C C-term missing	Bin_c101_locus-_28460	IS110 family transposase

thing1=$(grep 'score:442.4' ./*/*.gff | grep 'k141_3002235' | awk -F "locus_tag=" '{print $2}' | awk -F ";" '{print $1}' | wc -l) && if [ "$thing1" -eq "1" ] ; then echo "It is one" ;  elif [ "$thing1" > "1" ] ; then echo "It is bigger than one" ; else echo "Fuck this" ; fi

2022-03-26
13A_S1-contigs.fasta

2022-03-28
2022/03/28 15:36:09 Reference file (/opt/anaconda_dfast/opt/dfast-1.2.15/db/protein/DFAST-default.ref) does not exist. Aborting...

2022-03-29
sstat --format=MaxRSS -j <job_id>

2022-03-30
dfast_file_downloader.py --dbroot /tmp/dfastrefs_osbourne --protein dfast
dfast_file_downloader.py --dbroot /tmp/dfastrefs_osbourne --cdd Cog --hmm TIGR

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/databases/dfast_2022-03-30

Submitted batch job 46167257

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/DFAST_output

awk -F "\t" '$2 > 0 {print $2}' Human_mock_Metaphlan2-output_raw_marker_counts.txt | grep -v 'M' | paste -sd+ | bc -l

awk -F "\t" '$2 > 0 {print $2}' ERR3357615_Metaphlan2-output_raw_marker_counts.txt | grep -v 'M' | paste -sd+ | bc -l


for f in *_Metaphlan2-output_raw_marker_counts.txt ; do sampleID=$(basename "$f" | awk -F "_" '{print $1}') && num_marker_hits=$(awk -F "\t" '$2 > 0 {print $2}' "$f" | grep -v 'M' | paste -sd+ | bc -l) && printf "$sampleID\t$num_marker_hits\n" ; done | sort -h -k2

2022-04-01
"$exact_taxIDs_list_file"

while read -r line ; do taxid="$line" && awk -F "\t" -v taxid="$taxid" '$1 != taxid {print $0}' 2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt ; done < "$exact_taxIDs_list_file"

while read -r line ; do taxid="$line" && awk -F "\t" -v taxid="$taxid" '$1 != taxid {print $0}' 2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt ; done < "$exact_taxIDs_list_file" | sort | uniq | paste -sd+ | bc -l

while read -r line ; do taxid="$line" && awk -F "\t" -v taxid="$taxid" '$1 != taxid {print $2}' 2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt ; done < "$fuzzy_false_positives_file" | sort | uniq | paste -sd+ | bc -l

while read -r line ; do taxid="$line" && awk -F "\t" -v taxid="$taxid" '$1 != taxid {print $2}' 2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt ; done < "$clear_false_positives_file" | sort | uniq | paste -sd+ | bc -l

while read -r line ; do taxid="$line" && awk -F "\t" -v taxid="$taxid" '$1 == taxid {print $0}' 2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt ; done < "$exact_taxIDs_list_file" | awk -F "\t" '{print $2}' | paste -sd+ | bc -l

while read -r line ; do taxid="$line" && awk -F "\t" -v taxid="$taxid" '$1 == taxid {print $0}' 2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt ; done < "$exact_species_taxIDs_list_file" | awk -F "\t" '{print $2}' | paste -sd+ | bc -l

while read -r line ; do taxid="$line" && awk -F "\t" -v taxid="$taxid" '$1 == taxid {print $0}' 2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt ; done < "$fuzzy_false_positives_file" | awk -F "\t" '{print $2}' | paste -sd+ | bc -l

while read -r line ; do taxid="$line" && awk -F "\t" -v taxid="$taxid" '$1 == taxid {print $0}' 2022_03_03-Kraken_human_mock_010_confidence_score_unique_taxids_with_occurence.txt ; done < "$clear_false_positives_file" | awk -F "\t" '{print $2}' | paste -sd+ | bc -l

2022-04-04
inpf="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kaiju_outputs/multiple_error_allowances_outputs/human_only_file_copies/994_LIB8395_LDI7034_NoIndex_L001.Kaiju_output_0_allowed_errors.Taxon_names_added.out" && while read -r line ; do taxid="$line" && occurrence=$(awk -F "\t" -v taxid="$taxid" '$3 == taxid {print $3}' "$inpf" | wc -l) && printf "$taxid\t$occurrence\n" && printf "$taxid\t$occurrence\n" >> "2022-04-04_Kaiju_0_errors_allowed_unique_taxIDs_detected_and_occurence.tsv" ; done < 2022_03_01-Kaiju_human_mock_0_allowed_errors_unique_taxids.txt

cat SRR9205149_Kraken2-010_report.txt | awk -F "\t" '{print $1"\t"$6}' | sed 's/^ *//g' | tr -s " "

2022-04-05
grep ">" ./*/*.faa | cut -d " " -f 2-

grep  "ABC transporter" ./*/*.faa | cut -d " " -f 2- | fgrep "^ABC transporter$"
enoyl-[acyl-carrier-protein] reductase [NADH]
grep  "enoyl-[acyl-carrier-protein] reductase [NADH]" ./*/*.faa | cut -d " " -f 2- | fgrep "^enoyl-[acyl-carrier-protein] reductase [NADH]$"

fgrep  "enoyl-[acyl-carrier-protein] reductase [NADH]" ./*/*.faa | cut -d " " -f 2- | awk -v product="enoyl-[acyl-carrier-protein] reductase [NADH]" '$1 == product {print $0}'

2022-04-05_list_all_unique_products_found_all_faa_files.txt

target_files=$(find -maxdepth 2 -type f -name "*.faa") && for f in $target_files ; do sampleID=$(basename "$f" | awk -F "-" '{print $1}' | tr -d "." | tr -d "/") && printf "Products\t$sampleID\n" > "2022-04-05_${sampleID}_all_possible_faa_products_counts.tsv" && products_list="2022-04-05_list_all_unique_products_found_all_faa_files.txt" && while read -r line ; do product="$line" && occurrence=$(fgrep "$product" "$f" | cut -d " " -f 2- | awk -v product="$product" '$0 == product' | wc -l) && printf "$product\t$occurrence\n" >> "2022-04-05_${sampleID}_all_possible_faa_products_counts.tsv" ; done < "$products_list" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/Host_genome_from_metagenomes
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

2022-03-22_all_contigs_with_DFAST_identified_products_highest_scoring_product_per_bin_with_score_and_locus.tsv
#110495 contigs had at least one identified product with a discrete highest score from dfast
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/2022-03-22_all_contigs_with_DFAST_identified_products_highest_scoring_product_per_bin_with_score_and_locus.tsv
#4706 of them are unique

molecular chaperone DnaJ

2022-04-05_all_contigs_with_DFAST_identified_products_highest_scoring_product_per_bin_ONLY_unique_products_found.txt

while read -r line ; do product="$line" && contigs=$(awk -F "\t" -v product="$product" '$4 == product {print $1}' 2022-03-22_all_contigs_with_DFAST_identified_products_highest_scoring_product_per_bin_with_score_and_locus.tsv | tr "\n" "," | sed "s/,$//g") && printf "$product\t$contigs\n" >> 2022-04-05_all_unique_higest_scoring_DFAST_products_all_bins_list_of_all_contigs_per_product.tsv && num_contigs_to_product=$(awk -F "\t" -v product="$product" '$4 == product {print $1}' 2022-03-22_all_contigs_with_DFAST_identified_products_highest_scoring_product_per_bin_with_score_and_locus.tsv | wc -l) && printf "$product\t$num_contigs_to_product\n" >> 2022-04-05_all_unique_higest_scoring_DFAST_products_all_bins_number_of_contigs_per_product.tsv && echo "Processed product: $product It has: $num_contigs_to_product contigs" ; done < 2022-04-05_all_contigs_with_DFAST_identified_products_highest_scoring_product_per_bin_ONLY_unique_products_found.txt

3D-(3,5/4)-trihydroxycyclohexane-1,2-dione acylhydrolase (decyclizing)

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/2022-04-05_all_unique_higest_scoring_DFAST_products_all_bins_list_of_all_contigs_per_product.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/Host_genome_from_metagenomes/non-Acomys_reference_genomes_from_refseq

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/Host_genome_from_metagenomes/non-Acomys_reference_genomes_from_refseq

2022-04-07
MGA_2145

2022-04-08
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-14_CheckM_on_culture_assemblies.sh

cat 2022-04-08_CheckM_all_isolates_min_500bp_contig_size_QA_check_output.out | sed "s/^  //g" | sed 's/ \+ /\t/g' | grep -v -- "--"
-printf '%f\n'

2022-04-09
./All_cultures_for_FastANI/S124_Fastp_SPADES_careful_assembly-scaffolds-FastANI_output.txt

for f in 13A_S1_FastANI_output.txt ; do high_score=$(head -1 "$f" | awk -F "\t" '{print $3}') && high_isolate=$(head -1 "$f" | awk -F "\t" '{print $2}' | awk -F "-" '{print $1}') && over_99=$(awk -F "\t" '$3 > 99 {print $0}' "$f" | wc -l) && printf "$high_score\t$high_isolate\t$over_99\n" ; done

2022-04-05_13A_S1_all_possible_faa_products_counts.tsv.only_number_detections.txt
614

awk -v numb="614" -F "\t" '$2 == numb' 2022-04-05_13A_S1_all_possible_faa_products_counts.tsv

2022-04-05_S126_all_possible_faa_products_counts.tsv.only_number_detections.txt

for f in *all_possible_faa_products_counts.tsv.only_number_detections.txt ; do highest_count=$(sort -V "$f" | grep -v "S" | tail -1) && other_file=$(basename "$f" | sed 's/.only_number_detections.txt//g') && most_common=$(awk -F "\t" -v numb="$highest_count" '$2 == numb' "$other_file") && sampleID=$(basename "$f" | sed 's/2022-04-05_//g' | sed 's/_all_possible_faa_products_counts.tsv.only_number_detections.txt//g') && printf "$sampleID\t$most_common\n" ; done

for f in *all_possible_faa_products_counts.tsv.only_number_detections.txt ; do highest_count=$(sort -V "$f" | grep -v "S" | tail -2 | head -1) && other_file=$(basename "$f" | sed 's/.only_number_detections.txt//g') && most_common=$(awk -F "\t" -v numb="$highest_count" '$2 == numb' "$other_file") && sampleID=$(basename "$f" | sed 's/2022-04-05_//g' | sed 's/_all_possible_faa_products_counts.tsv.only_number_detections.txt//g') && printf "$sampleID\t$most_common\n" ; done

for f in *all_possible_faa_products_counts.tsv.only_number_detections.txt ; do sampleID=$(basename "$f" | sed 's/2022-04-05_//g' | sed 's/_all_possible_faa_products_counts.tsv.only_number_detections.txt//g') && things=$(grep -v "0" "$f" | wc -l) && printf "$sampleID\t$things\n" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/DFAST_output
Bin_c40

while read -r line ; do bin_here=$(echo "$line" | awk -F "\t" '{print $2}') && grep -wq "$bin_here" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/2022-04-10_list_bins_contamination_over_5_percent.txt || printf "$line\n" ; done < /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_reference_files/2022-03-21_contigs_and_their_bins.tsv

while read -r line ; do bin_here=$(echo "$line" | awk -F "\t" '{print $2}') && grep -wq "$bin_here" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/2022-04-10_list_bins_contamination_over_5_percent.txt && printf "$line\n" ; done < /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_reference_files/2022-03-21_contigs_and_their_bins.tsv > 2022-04-11_list_all_bins_WITH_5_percent_or_greater_contamination_and_individual_contigs_in_them.tsv

2022-04-11
AR27N-2022-03-21_kilobase_and_library_size_adjusted_per_bin_summed_mapping_scores.tsv
Bin_c17	23.003160

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/2022-04-10_list_bins_contamination_over_5_percent.txt
AC14N-2022-03-21_kilobase_and_library_size_adjusted_per_bin_summed_mapping_scores.tsv
bad_bins="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/2022-04-10_list_bins_contamination_over_5_percent.txt" && for f in *2022-03-21_kilobase_and_library_size_adjusted_per_bin_summed_mapping_scores.tsv ; do sampleID=$(basename "$f" | awk -F "-" '{print $1}') && printf "Bins\t$sampleID\n" > "${sampleID}.only_good_bins_mapping_score_kilobase_and_library_size_adjusted_per_bin_summed_coverage.tsv" && cat "$f" | grep -vw -f <(cat "$bad_bins") | sort -V -k1 >> "${sampleID}.only_good_bins_mapping_score_kilobase_and_library_size_adjusted_per_bin_summed_coverage.tsv" && awk -F "\t" '{print $2}' "${sampleID}.only_good_bins_mapping_score_kilobase_and_library_size_adjusted_per_bin_summed_coverage.tsv" > "${sampleID}.only_good_bins_mapping_score_kilobase_and_library_size_adjusted_per_bin_summed_coverage.Just_mapping_counts_in_same_order_as_file.tsv" && printf "\nProcessed file:\t$f\n" ; done

while read -r line ; do contig=$(echo "$line" | awk -F "\t" '{print $1}') && bin=$(echo "$line" | awk -F "\t" '{print $2}') && grep -wq "$bin" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/2022-04-10_list_bins_contamination_over_5_percent.txt && printf "$contig\t$bin\n" >> 2022-04-11_bins_with_GREATER_than_5_percent_contamination_and_their_contigs.tsv ; done < /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_reference_files/2022-03-21_contigs_and_their_bins.tsv

2022-04-11_all_unique_higest_scoring_DFAST_products_only_bins_under_5_percent_contamination_all_contigs_per_product.tsv
awk 'NF > 1' infile

2022-04-12
4706 2022-04-05_all_unique_higest_scoring_DFAST_products_all_bins_list_of_all_contigs_per_product.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/2022-04-05_all_unique_higest_scoring_DFAST_products_all_bins_list_of_all_contigs_per_product.tsv

while read -r line ; do product=$(echo "$line" | awk -F "\t" '{print $1}') && contig_count=$(echo "$line" | awk -F "\t" '{print $2}' | tr -cd "k" | wc -c) && printf "$product\t$contig_count\n" ; done < /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/2022-04-05_all_unique_higest_scoring_DFAST_products_all_bins_list_of_all_contigs_per_product.tsv > 2022-04-12_count_contigs_per_product_all_bins_only_highest_scoring_unique_product.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/2022-04-12_count_contigs_per_product_all_bins_only_highest_scoring_unique_product.tsv
110495
while read -r line ; do product=$(echo "$line" | awk -F "\t" '{print $1}') && contig_count=$(echo "$line" | awk -F "\t" '{print $2}' | tr -cd "k" | wc -c) && printf "$product\t$contig_count\n" ; done < 2022-04-11_all_unique_higest_scoring_DFAST_products_only_bins_under_5_percent_contamination_all_contigs_per_product.tsv > 2022-04-12_count_contigs_per_product_only_bins_with_under_5_percent_contamination_only_highest_scoring_unique_product.tsv
k141_10128912

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results/2022-04-10_list_bins_contamination_over_5_percent.txt

2022-04-12_temp.tsv
2022-04-12_temp_bad_contigs.txt
k141_10571191
k141_1057040

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins
2022-04-12_temp.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/Host_genome_from_metagenomes/non-Acomys_reference_genomes_from_refseq

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/GTDB-TK_outputs/classify_wf

classify/gtdbtk.bac120.summary.tsv
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Chris_and_Seb_bins_fasta_files/CheckM_output/2022-04-10_all_bins_CheckM_results_without_header.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins

while read -r line ; do product=$(echo "$line" | awk -F "\t" '{print $1}') && contigs=$(echo "$line" | awk -F "\t" '{print $2}' | tr "," "\n" | awk 'NF' | wc -l) && printf "$product\t$contigs\n" && printf "$product\t$contigs\n" >> 2022-04-13_all_products_all_bins_product_and_contig_counts_to_them.tsv ; done < 2022-04-05_all_unique_higest_scoring_DFAST_products_all_bins_list_of_all_contigs_per_product.tsv

2022-04-12_temp.tsv

while read -r line ; do product=$(echo "$line" | awk -F "\t" '{print $1}') && contigs=$(echo "$line" | awk -F "\t" '{print $2}' | tr "," "\n" | awk 'NF' | wc -l) && printf "$product\t$contigs\n" && printf "$product\t$contigs\n" >> 2022-04-13_all_products_all_GOOD_bins_product_and_contig_counts_to_them.tsv ; done < 2022-04-12_temp.tsv

printf "Good bins only\tBad bins as well\n" > 2022-04-13_differences_between_contig_counts_per_product_good_and_bad_bins.txt && diff -y 2022-04-13_all_products_all_GOOD_bins_product_and_contig_counts_to_them.tsv 2022-04-13_all_products_all_bins_product_and_contig_counts_to_them.tsv >> 2022-04-13_differences_between_contig_counts_per_product_good_and_bad_bins.txt

k141_16026380	Bin_c730
1,4-alpha-glucan branching enzyme GlgB
797.3
Bin_c64-DFAST_output

grep 'k141_16026380' ./*/*.gff | awk -F "\t" '{print $4"\t"$5}'

2022-04-11_list_all_bins_under_5_percent_contamination_and_individual_contigs_in_them.tsv
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins
95026 2022-04-13_all_contigs_good_bins_which_have_a_single_unique_highest_scoring_product.txt

while read -r line
do
  contig=$(echo "$line" | awk -F "\t" '{print $1}')
  bin=$(echo "$line" | awk -F "\t" '{print $2}')
  product=$(grep "$contig" 2022-04-12_temp.tsv | awk -F "\t" '{print $1}')
  high_score=$(grep "$contig" ./*/*.gff | awk -F "score:" '{print $2}' | awk -F "]" '{print $1}' | awk 'NF' | sort -V | tail -1)
  product_start_point=$(grep "$contig" ./*/*.gff | grep "score:$high_score" | awk -F "\t" '{print $4}')
  product_end_point=$(grep "$contig" ./*/*.gff | grep "score:$high_score" | awk -F "\t" '{print $5}')
  product_gene_length=$(echo "$product_end_point - $product_start_point" | bc -l)
  printf "$contig\t$bin\t$product\t$high_score\t$product_start_point\t$product_end_point\t$product_gene_length\n"
done

contig="k141_16026380" && bin="Bin_c730" && product=$(grep "$contig" 2022-04-12_temp.tsv | awk -F "\t" '{print $1}') && high_score=$(grep "$contig" ./*/*.gff | awk -F "score:" '{print $2}' | awk -F "]" '{print $1}' | awk 'NF' | sort -V | tail -1) && product_start_point=$(grep "$contig" ./*/*.gff | grep "score:$high_score" | awk -F "\t" '{print $4}') && product_end_point=$(grep "$contig" ./*/*.gff | grep "score:$high_score" | awk -F "\t" '{print $5}') && product_gene_length=$(echo "$product_end_point - $product_start_point" | bc -l) && printf "$contig\t$bin\t$product\t$high_score\t$product_start_point\t$product_end_point\t$product_gene_length\n"

k141_5627014
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins

for f in Bin*.fa ; do binID=$(basename "$f" | awk -F ".f" '{print $1}') && grep ">" "$f" | awk -F " " '{print $1}' | tr -d ">" | sed "s/^/$binID /g" | tr " " "\t" ; done > 2022-04-13_all_contigs_all_bins.tsv

for f in Bin*.fa ; do binID=$(basename "$f" | awk -F ".f" '{print $1}') && contigs=$(grep ">" "$f" | awk -F " " '{print $1}' | tr -d ">" | sed "s/$/") && echo "$contigs $binID" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Chris_and_Seb_bins_fasta_files/2022-04-13_all_contigs_all_bins.tsv

2022-04-13_bins_less_than_5_percent_contamination_and_their_contigs.tsv

2022-03-22_all_contigs_with_no_DFAST_identified_products.tsv

while read -r line ; do grep -w "$line" 2022-03-22_all_contigs_with_no_DFAST_identified_products.tsv ; done < temp_good_contigs_list.txt | wc -l
k141_6190646

2022-04-14

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/2022-04-14_bins_which_are_less_than_5_percent_contaminated_AND_at_least_80_percent_completeness.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files

#SBATCH -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/array_ouputs_and_errors/2022-04-14_get_highest_scoring_product_each_contig_from_CQ_and_SR_bins_less_than_5_percent_contamination%A.out
#SBATCH -e /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/V2-DFAST_results_Chris_and_Seb_bins/array_ouputs_and_errors/2022-04-14_get_highest_scoring_product_each_contig_from_CQ_and_SR_bins_less_than_5_percent_contamination%A.err

46914909_15+

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs

while read -r line ; do bin_name="$line" && cp -r "${bin_name}-DFAST_output" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs && echo "Copied DFAST directory for bin: $bin_name" ; done < 2022-04-14_bins_which_are_less_than_5_percent_contaminated_AND_at_least_80_percent_completeness.txt

2022-04-15

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/temp_scripts_dir

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/seqtk_outputs

for f in *Subsampled.R1.fq ; do r1file=$(basename "$f") && r2file=$(echo "$r1file" | sed 's/.Subsampled.R1.fq/.Subsampled.R2.fq/g') && sbatch /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/temp_scripts_dir/2022-04-14_BWA_map_subsampled_processed_acomys_reads_to_concatenated_GOOD_bins_reference_fasta.sh "$r1file" "$r2file" && printf "\nSubmitted job on files:\t$r1file and $r2file\n" && sleep 3s ; done

2022-04-16
target_files=$(find -maxdepth 1 -type f -name "*.fa" -not -name "*concatenated*") && for f in $target_files ; do binID=$(basename "$f" | awk -F ".f" '{print $1}') && grep ">" "$f" | awk -F " " '{print $1}' | tr -d ">" | sed "s/^/$binID /g" | tr " " "\t" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/2022-04-16_all_bins_less_5_percent_contamination_minimum_80_percent_completeness_list_bins_with_contigs.tsv

inpdir=$(pwd) && printf "Bin\tNumber of contigs\tTotal number products found\tTotal number unique products found\n" > "2022-04-16_all_GOOD_bins_contig_count_and_DFAST_output_total_products_found_including_multiple_products_per_contig_and_total_unique_products_found.tsv" && for d in Bin* ; do cd "$d" && bin_ID=$(echo "$d" | awk -F "-" '{print $1}') && contig_count=$(grep -c ">k" *_genome.fna) && products=$(grep ">" *.faa | cut -d " " -f 2-) && products_count=$(grep ">" *.faa | wc -l) && unique_products_count=$(grep ">" *.faa | cut -d " " -f 2- | sort -h | uniq | wc -l) && unique_products=$(grep ">" *.faa | cut -d " " -f 2- | sort -h | uniq) && printf "$bin_ID\t$contig_count\t$products_count\t$unique_products_count\n" >> "${inpdir}/2022-04-16_all_GOOD_bins_contig_count_and_DFAST_output_total_products_found_including_multiple_products_per_contig_and_total_unique_products_found.tsv" && printf "Processed directory:\t$bin_ID\n" && cd "$inpdir" ; done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC40N

samtools view -b -h AC40N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam "k141_8134441:300-1000"

k141_8134441
8699 9937
23850 24866
samtools depth -r k141_8134441:8699-9937 AC40N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam
samtools depth -r k141_8134441:23850-24866 AC40N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam
source package /tgac/software/testing/bin/subread-1.6.0
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Bin_c1000-DFAST_output/Bin_c1000_genome.gff
featureCounts -O -t CDS -g ID -a /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Bin_c1000-DFAST_output/Bin_c1000_genome.gff -o featureCounts_test_Bin_c1000_genome_gff_CDS AC40N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam

while read -r line ; do product="$line" && contigs=$(awk -F "\t" -v product="$product" '$4 == product {print $1}' 2022-04-14_all_contigs_with_DFAST_identified_products_highest_scoring_product_per_bin_with_score_and_locus.tsv | sort -h | tr "\n" "," | sed "s/,$//g") && printf "$product\t$contigs\n" && printf "$product\t$contigs\n" >> 2022-04-16_all_unique_products_DFAST_analysis_GOOD_bins_single_highest_scoring_per_contig_products_to_contigs.txt ; done < 2022-04-16_all_GOOD_bins_unique_single_highest_scoring_products_per_contig_for_all_contigs_with_single_highest_scoring_product.txt

while read -r line ; do product="$line" && contigs_count=$(awk -F "\t" -v product="$product" '$4 == product {print $1}' 2022-04-14_all_contigs_with_DFAST_identified_products_highest_scoring_product_per_bin_with_score_and_locus.tsv | wc -l) && printf "$product\t$contigs_count\n" && printf "$product\t$contigs_count\n" >> 2022-04-16_all_unique_products_DFAST_analysis_GOOD_bins_single_highest_scoring_per_number_of_contigs_to_product.txt ; done < 2022-04-16_all_GOOD_bins_unique_single_highest_scoring_products_per_contig_for_all_contigs_with_single_highest_scoring_product.txt


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/2022-04-14_all_contigs_with_DFAST_identified_products_highest_scoring_product_per_bin_with_score_and_locus.tsv

2022-04-17
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch
cat temp_classifications_list.txt | grep "Genus" | cut -d " " -f 2- | sort -h | uniq | grep -v -f temp_exclusion_list.txt | sed 's/^/^"/g' | sed 's/$/"$/g' | tr -d "^$" | tr "\n" "," | sed "s/,/, /g"

cat temp_classifications_list.txt | grep "Genus" | cut -d " " -f 2- | sort -h | uniq | grep -f temp_exclusion_list.txt | sed 's/^/^"/g' | sed 's/$/"$/g' | tr -d "^$" | tr "\n" "," | sed "s/,/, /g"

2022-04-17_all_samples_mapping_to_completeness_min_80_percent_contamination_under_5_percent_concatenated_bins_summed_by_single_highest_scoring_product_per_contig_unique_products_from_DFAST_kilobase_and_library_size_adjusted.tsv
2022-04-17_TRANSPOSED_all_samples_mapping_to_completeness_min_80_percent_contamination_under_5_percent_concatenated_bins_summed_by_single_highest_scoring_product_per_contig_unique_products_from_DFAST_kilobase_and_library_size_adjusted

2022-04-18
while read -r line ; do bin_name="$line" && bin_size=$(grep ">" "${line}.fa" | awk -F "len=" '{print $2}' | awk 'NF' | paste -sd+ | bc -l) && printf "$bin_name\t$bin_size\n" ; done < 2022-04-16_list_of_just_bin_names.txt
while read -r line ; do bin_name="$line" && bin_size=$(grep ">" "${line}.fa" | awk -F "len=" '{print $2}' | awk 'NF' | paste -sd+ | bc -l) && contigs_count=$(grep -c ">" "${line}.fa") && contig_avg_size=$(echo "$bin_size / $contigs_count" | bc -l) && printf "$bin_name\t$bin_size\t$contigs_count\t$contig_avg_size\n" ; done < 2022-04-16_list_of_just_bin_names.txt

Periplasmic serine endoprotease
DegP


2022-04-20
source package /tgac/software/testing/bin/subread-1.6.0
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Bin_c1000-DFAST_output/Bin_c1000_genome.gff
featureCounts -O -t CDS -g ID -a /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Bin_c1000-DFAST_output/Bin_c1000_genome.gff -o featureCounts_test_Bin_c1000_genome_gff_CDS AC40N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files

$ awk 1 *.fasta > largefile.fasta

awk 1 ./*/*.gff > /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files/2022-04-20_concatenated_all_good_bins_DFAST_output_GFF_files.gff
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files/2022-04-20_concatenated_all_good_bins_DFAST_output_GFF_files.gff

k141_9791998

featureCounts -O -t CDS -g ID -a /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files/2022-04-20_concatenated_all_good_bins_DFAST_output_GFF_files.gff -o 2022-04-20_AC40N_concatenated_GFF_file_trial.txt AC40N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam

MGA_9
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC40N
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC40N

featureCounts -O -t CDS -g ID -a /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Bin_c1005-DFAST_output/Bin_c1005_genome.gff -o 2022-04-20_AC40N_Bin_c1005_GFF_file_trial.txt AC40N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Bin_c1005-DFAST_output/Bin_c1005_genome.gff

awk -F "\t" -v contig="k141_9791998" '$1 == contig {print $0}' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files/2022-04-20_concatenated_all_good_bins_DFAST_output_GFF_files.gff | awk -F "\t" '{print $1"\t"$4"\t"$5"\t"$9}' | awk -F ";" '{print $1"\t"$2}'

bin_name=$(basename *.gff | awk -F "_gen" '{print $1}') && cat *.gff | grep "ID=MGA" | awk -F "\t" '{print $1"\t"$4"\t"$5"\t"$9}' | awk -F ";" '{print $1"\t"$2}' | sed "s/^/$bin_name\\t/g"

outdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files" && inpdir=$(pwd) && target_dirs=$(find -maxdepth 1 -type d -name "Bin_*-DFAST_output" -printf '%f\n') && for d in $target_dirs ; do cd "$d" && bin_name=$(basename *.gff | awk -F "_gen" '{print $1}') && cat *.gff | grep "ID=MGA" | awk -F "\t" '{print $1"\t"$4"\t"$5"\t"$9}' | awk -F ";" '{print $1"\t"$2}' | sed 's/product=//g' | sed "s/^/$bin_name\\t/g" | awk 'NF' > "${outdir}/2022-04-20_${bin_name}_all_contigs_all_products_bin_name_start_and_end_sites_as_well_as_product.tsv" && printf "Processed directory:\t$d\n" && cd "$inpdir" ; done

awk 1 *end_sites_as_well_as_product.tsv > 2022-04-20_combined_all_contigs_all_products_GFF_details_bin_contig_start_end_sites_useless_ID_product_name.tsv


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files/2022-04-20_combined_all_contigs_all_products_GFF_details_bin_contig_start_end_sites_useless_ID_product_name.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC40N/all_bins_feature_count_outputs

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/2022-04-20_list_of_paths_to_all_bin_GFF_files.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC40N/AC40N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam

while read -r line ; do bin_path="$line" && bin_name=$(basename "$bin_path" | awk -F ".g" '{print $1}') && featureCounts -O -t CDS -g ID -a "$bin_path" -o "${bin_name}-DFAST_GFF_feature_count_output.tsv" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC40N/AC40N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam && printf "Processed bin:\t$bin_name through featureCounts\n" ; done < /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/2022-04-20_list_of_paths_to_all_bin_GFF_files.txt

Program:featureCounts Strand

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC40N/all_bins_feature_count_outputs/2022-04-21_combined_feature_count_outputs_only_mapping_hits.tsv

Warning: failed to find the gene identifier attribute in the 9th column of the provided GTF file.
The specified gene identifier attribute is 'ID'
The attributes included in your GTF annotation are 'ID=MGA_1033;product=hypothetical protein;inference=COORDINATES:ab initio prediction:MetaGeneAnnotator;translation=MAKRKEATKKQKDYAASIAKVLNIKLPEENTSAAYRDFIEKNQERFSQSRVQAVHYTDEQIARANAVDILDYARSQGLELKKDGKDYRVKNYSGGFIITPEKNNWNWFDGNIGGGVVRLCMFLENKTWQEAVGTLLNEDMEPIRRRPDWKPVEEPPKEFHLPERNNTNKHVYAYLTKTRGIDTEIVKKMLDQGYIYENQKRSCVFVGRDKEGVPRHASVRSTNTVGDAYKKDVSGSQKKFSFSVHGTSGVLNVFEAPIDALSHMSLQKLQGKPINDSYVALGGVTDKALEQYLEDHKDIRQITVCTDGDEAGERAAERIQEKYGTDFEIVRERSLHKDFNEDLVVIMQEENFKRNLHEVVAGKSRVSDSILIGKTPNILVVCGAVEGVDFTISKTVIDKCTRPEIRDADGKLTGKTGHGLTEEQLYSALMNVKEPVMVLKGNRENSLVVVTEYPDDKSRPIVVSVVLDKKSGRTRINNVSSVYGRDKFEEYLGRQIQADNILAFDNKKAEPLLQPIGKWYPKRGEVFSYDATIAYSMKSVKKNASQSERIQAAIESTADYVDPGIGFTAVATGDMPAGTKYRIVTYGENGKLVPYQENPTIYSDRAEVEAYLEEHKDRLESIDYDDIVYQAGKKIADYNLKQRQRIEEGLHSFQFDEDGYLHFSITVNDYDYDGLYRIYAPADGPNRELVSIDNGQGEPFFKENWELIRQHLEQYVNEHPEIGPDGEEIPREKASVYCEWSEHDAFEEGKVYSVFEFDRLMEQSDTEWIELRQQEREQYGEDAYEELYKRNLPQHQTYAKTKYTVFVPGMTELTLRQNIGDGLGGMIDFVRTTTHKHYADPLETVIGKEKEAAAEKNFVEQDDKVLEEKNDLYVLAESISDFFHDCDLYIQQNHGTFNDIISHSVDVEDILEDILDGSYFEEYLNDIRNRLEFIEKFSDYSNGEAELIQKGQETFNNLENLYQNLIKDMEIQDKLLQDKKKELVQDEKEMEMAVNEGIISDTDQTFVLTGAKVSTEMQDIISRLNTGEKVTIDEINATKEIQYCRSIADNGRETYLLDGRTDKQNQVMEYMENLGSASGHLDKDGKMIYDGDVKKGNRLDIVIGLPGAGKSSALVNVISQEFHSKVIDNDMAKEQFTEYQNGLGAKLVHTESQMVCEKVFAKSIMNGENLVVPKVGSNSDKLIEKTISKAKQFGYDINVHFVDLERDKALGRMLGRLISDGRFLDPALIDKYCPDKNNLCEQSYEVLKTNELINGYSRWDNNVAKGEQPFMVENHNLTGEYINNARVKEKGVVDNDRIELRNNRDSEQGISENDGEHGRMGEPSIGGVYENGTGSLSGRSRSFPEGGEPVREEKSVEIKEQETEVVDNDVAKKENLVKQQGIPGYQKGTPAKDLKIGDVVVWNSGVTSEVVGFESSKTGKTIVFQMKSTEDGVIRERRMKDGTLVVVQEKENTEPNESEKIEKNDTAKKENDERTVQLLKDKDIHYETYNHATQKQIAYAKKIAEALKVDLPEEATKESYKSFISEYQEAFSQNSNPLIEKEAGAYHYKDYLDMVTQDGSKLKDVPKENYTDELLLAAVSNWGAAIQFIPEENVTKEIAMASVRQYGLNLKHIPAEFRNEEICIAAYISSSGKSLRYTPGGIKTQVKEQGQKQLAENNNANPNTKRQMEVERLQKQGQEWVSQIDNMLKEHETDPEAMIEDIVFASKFYRYSTRNIQLMVRQNPGITYVASASAFEKMGYHVKENETPMLGRVPVYAKYITNEKEERVYSWNYTPEIRQKLKEGTLTEEQAVRKFQFVAAFFDISQTDCPAEDYPSVFHMGVPSELHQEAFDAMKEFAESLGFKVMVTDLKSISLRGSCEPDKKIIRINDKLESTMALSTLCHEIAHGIIHTSENSAKMSTAQKECEADVMDVMLESSLGLPINESRRDHLFNSFNVYKKEQATKEHPYEVTLEKLIDRVQKDVFRPYAEDINSYLDRHLPAEGIQNEKAAEEVIKNIALLDSVYETNHRDYIDGKNELFDVGRMKRYQELYQKTKEEYRLNNSFVPKLAVFSREYNLYDVQPIDEMTAGLLKASPEAITSDILPAYVGEGDVIALKENVLENSKLYQVTGNGLKEITQTQQEEFVKSFLENKINCGFSAVTEYECIDNLLQNDINLEPEMMKRYDHLCETFGFPKNVVTDSSMQLMARINLATEGLSRNNRELIAEYVFRTGNFKKAEQYAEKLENEPEITKKLLQEMKLVDSYKYMLWTIAEYENSNAVPKENRITTGAYNTSAIPVLSDNVHSLSQINESFLLIRKHASPESIKYYAIARNKDGYRIAYVELNEYQPEITYSAVTFADYEEAKQFYNQYLETSNSRLVDETQVDELVVLEHKENQVALSDITTIGKTIASQKHQYKEPGMSEEGALELLRLDIRNEYPDIRPIEPAETDHEIQVLKDFKTRISSYGEEHFIELCNLEDFTDTTVMDESIQLAGWLTEQKDALDNINITGMDDVKRCVNAALECSVTAADIEQAFNVIDSAVLSAEFSGLETEFEGFEEYNNVLGTLKASRVAPDKFCYANYDAAPAPFLYTSDQAGNIYRKSLRNEWTDSVQELHTRLKENGYEICTSFDDFKAYAVNNRLGIMNAPEKEKNEAYIRILESTSDMLPKDCILSIYDFKNTMDKLYSGSMDFHEDITYKLVTRKDQEIHSYIDTYSGNSEQNVFEQLYSKVQEPELSKVISRQYYQDQVNFNENHLLRPLMVQLKKQQKPVEDSEELNALMNSNDKLKEEIKKLDLSPADAELLKLNAGNIQTEQIANIARQQQMDQQIKQQKVRNQQQMELAI;locu'

||    Features : 2839                                                         ||
||    Meta-features : 2839                                                    ||
||    Chromosomes/contigs : 123                                               ||
||                                                                            ||
|| Process BAM file /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/s ... ||
||    Paired-end reads are included.                                          ||
||    Assign reads to features...                                             ||
||    Total reads : 8101505                                                   ||
||    Successfully assigned reads : 10585 (0.1%)                              ||
||    Running time : 0.40 minutes                                             ||
||                                                                            ||
||                         Read assignment finished.                          ||
||                                                                            ||
|| Summary of counting results can be found in file "Bin_c241-DFAST_GFF_feat  ||
|| ure_count_output.tsv.summary"                                              ||
||                                                                            ||
\\===================== http://subread.sourceforge.net/ ======================//

Processed bin:	Bin_c241 through featureCounts

2022-04-24
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files/2022-04-20_combined_all_contigs_all_products_GFF_details_bin_contig_start_end_sites_useless_ID_product_name.tsv
AC6J_all_good_bins_mapping_featureCount_analysis_output_only_mapping_lengths_above_0.tsv
MGA_25	k141_7435507	26640	27665	-	1026	8

2022-04-25

grep 'k141_14434205' ./*/*.gff | grep 'MGA_2207'

contig_lengths_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/2022-04-14_concatenated_low_contamination_high_completeness_bins-List_of_contigs_and_their_lengths.tsv"
contig_lengths_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/2022-04-14_concatenated_low_contamination_high_completeness_bins-List_of_contigs_and_their_lengths.tsv"

while read -r line
do
  mapping_count_unadjusted=$(printf "$line" | awk -F "\t" '{print $7}')
  contig=$(printf "$line" | awk -F "\t" '{print $2}')
  dfast_ID=$(printf "$line" | awk -F "\t" '{print $1}')
  containing_bin=$(grep "$contig" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Bin*/*.gff | grep "$dfast_ID" | awk -F ":" '{print $1}' | cut -d "/" -f 10 | awk -F "-" '{print $1}' | head -1)
  product=$(grep -whn "$dfast_ID" "/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/${containing_bin}-DFAST_output/${containing_bin}_protein.faa" | cut -d " " -f2-)
  contig_length=$(awk -v contig="$contig" -F "\t" '$1 == contig {print $2}' "$contig_lengths_file")
  contig_size_kb=$(echo "$contig_length / 1000" | bc -l)
  lib_size="7.6"
  adjusted_mapping_1=$(echo "$mapping_count_unadjusted / $contig_size_kb" | bc -l)
  adjusted_mapping_2=$(echo "$adjusted_mapping_1 / $lib_size" | bc -l)
  printf "$contig\t$product\t$adjusted_mapping_2\t$dfast_ID\t$containing_bin\n"
done < AC35J_all_good_bins_mapping_featureCount_analysis_output_only_mapping_lengths_above_0.tsv

contig_lengths_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/2022-04-14_concatenated_low_contamination_high_completeness_bins-List_of_contigs_and_their_lengths.tsv" && while read -r line ; do mapping_count_unadjusted=$(printf "$line" | awk -F "\t" '{print $7}') && contig=$(printf "$line" | awk -F "\t" '{print $2}') && dfast_ID=$(printf "$line" | awk -F "\t" '{print $1}') && containing_bin=$(grep "$contig" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Bin*/*.gff | grep "$dfast_ID" | awk -F ":" '{print $1}' | cut -d "/" -f 10 | awk -F "-" '{print $1}' | head -1) && product=$(grep -whn "$dfast_ID" "/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/${containing_bin}-DFAST_output/${containing_bin}_protein.faa" | cut -d " " -f2-) && contig_length=$(awk -v contig="$contig" -F "\t" '$1 == contig {print $2}' "$contig_lengths_file") && contig_size_kb=$(echo "$contig_length / 1000" | bc -l) && lib_size="7.6" && adjusted_mapping_1=$(echo "$mapping_count_unadjusted / $contig_size_kb" | bc -l) && adjusted_mapping_2=$(echo "$adjusted_mapping_1 / $lib_size" | bc -l) && printf "$contig\t$product\t$adjusted_mapping_2\t$dfast_ID\t$containing_bin\n" ; done < AC35J_all_good_bins_mapping_featureCount_analysis_output_only_mapping_lengths_above_0.tsv


grep 'k141_14434205' ./*/*.gff | grep 'ID=MGA_2207'

grep 'k141_14434205' /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Bin*/*.gff | grep 'ID=MGA_2207' | awk -F ":" '{print $1}' | cut -d "/" -f 10 | awk -F "-" '{print $1}'

k141_7435507 MGA_11 Bin_c1000

grep 'k141_7435507' ./*/*.gff | grep -w 'ID=MGA_11'

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC35J/featureCounts_output

sbatch 2022-04-25_new_adjustment_and_association_TEST_SCRIPT.sh

while read -r line ; do start_point=$(echo "$line" | awk -F "\t" '{print $3}') && end_point=$(echo "$line" | awk -F "\t" '{print $4}') && gene_length=$(echo "$end_point - $start_point" | bc -l) && echo "$line" | sed "s/$/\t$gene_length/g" >> 2022-04-25_combined_all_contigs_all_products_GFF_details_bin_contig_start_end_sites_product_name_DFAST_ID_and_length.tsv ; done < 2022-04-20_combined_all_contigs_all_products_GFF_details_bin_contig_start_end_sites_useless_ID_product_name.tsv

source package /tgac/software/testing/bin/bedtools-2.30.0

2022-04-26
find . -name ".svn" -exec rm -r "{}" \;

find -maxdepth 2 -type d -name "featureCounts_output" -exec rm -r "{}" \;


contig_lengths_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/2022-04-14_concatenated_low_contamination_high_completeness_bins-List_of_contigs_and_their_lengths.tsv" && inpf="2022-04-20_combined_all_contigs_all_products_GFF_details_bin_contig_start_end_sites_useless_ID_product_name.tsv" && while read -r line ; do bin=$(echo "$line" | cut -f 1) && contig=$(echo "$line" | cut -f 2) && dfast_ID=$(echo "$line" | cut -f 5) && name=$(echo "$line" | cut -f 6) && prod_start=$(echo "$line" | cut -f 3) && prod_end=$(echo "$line" | cut -f 4) && prod_length=$(echo "$prod_end - $prod_start" | bc -l) && contig_length=$(awk -F "\t" -v contig="$contig" '$1 == contig {print $2}' "$contig_lengths_file") && echo "$name@$prod_length@$contig_length@$dfast_ID@$contig@$bin@$prod_start@$prod_end" | tr "@" "\t" >> 2022-04-26_all_products_good_contigs_details_including_product_lengths.tsv && echo "$name@$prod_length@$contig_length@$dfast_ID@$contig@$bin@$prod_start@$prod_end" | tr "@" "\t" ; done < "$inpf"

hypothetical protein	554	191264	MGA_2	k141_7435507	Bin_c1000	85	639

source package /tgac/software/testing/bin/bedtools-2.30.0

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC40N

2022-04-27
if [[ $(pwd) != "/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins" ]] ; then echo "Is not there" ; else echo "It is there" ; fi

numb1="1" && numb2="3" && line_num=$(echo "$numb1 + $numb2" | bc -l) && if [[ $(ls -l | wc -l) < "$lin_num" ]] ; then echo "Fewer than $line_num lines" ; else echo "More than $line_num lines" ; fi

AR27J

2022-04-28
_bedtools_genomeCov_mapping_to_GOOD_bins.tsv

2022-04-29
head /dev/urandom | tr -dc A-Za-z0-9 | head -c 128 | grep -q -- $(ls -l)

thing=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 128 | grep -q -- $(ls -l)) && echo "$thing"

thing=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 128 | grep -sq -- $(ls -l) | xargs -r sed "s/^/B/g") && echo "$thing"

head /dev/urandom | tr -dc A-Za-z0-9 | head -c 128 | grep -sq -- <(ls -l) || ( read thing ; echo "$thing"; ) && echo "This is thing:$thing"

genus_and_below_match_taxID_total_reads=$(grep -wc -f <(cat "$clear_false_positives_file") "${current_dir}/2022_03_03-Kraken_human_mock_${confidence_score}_confidence_score_ALL_taxids.txt")

2022-05-04
source package 70b0e328-5a66-4c7c-971b-b2face8a50d4 #mummer 3.23
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/18B_S10-contigs.fasta.Contigs_min_length_500bp.fa /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/18E_S13-contigs.fasta.Contigs_min_length_500bp.fa

target_files=$(find -maxdepth 1 -type f -name "*Contigs*.fa" -not -name "S125*") && for f in $target_files ; do self_name=$(basename "$f") && my_path=$(realpath "$f") && other_files=$(find -maxdepth 1 -type f -name "*Contigs*.fa" -not -name "*$self_name*" -or -name "S125*") && for ug in $other_files ; do readlink -f "$ug" | sed "s@^@$my_path @g" ; done ; done >> 2022-05-04_all_paths_non_contaminated_isolates_all_samples_MUMmer_alignment_individual_alignments_against_all_except_self.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed
2022-05-04_all_paths_non_contaminated_isolates_all_samples_MUMmer_alignment_individual_alignments_against_all_except_self.txt

while read -r line ; do rf1=$(awk -F " " '{print $1}' "$line") && rf2=$(awk -F " " '{print $2}' "$line") && echo "Submitting files $rf1 and $rf2" && sbatch 2022-05-03_NUCmer_from_MUMmer_alignment_single_pairs_isolate_SPADES_assemblies_min_500bp_contig_size_provide_file_paths_on_command_line.sh "$rf1" "$rf2" && sleep 3s ; done < /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/2022-05-04_all_paths_non_contaminated_isolates_all_samples_MUMmer_alignment_individual_alignments_against_all_except_self.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/2022-05-04_all_paths_non_contaminated_isolates_all_samples_MUMmer_alignment_individual_alignments_against_all_except_self.txt


2022-05-05
/hpc-home/osbourne/to_make_local
target_files=$(find -maxdepth 2 -type f -name "*_against_*.mummerplot_aignment_output.ps") && for f in $target_files ; do printf "Copying file:\t$f\n" && cp "$f" /hpc-home/osbourne/to_make_local && printf "Done\n" ; done

2022-05-11
Cactus error
Traceback (most recent call last):
  File "/opt/software/conda_env/bin/cactus", line 11, in <module>
    load_entry_point('progressiveCactus==1.0', 'console_scripts', 'cactus')()
  File "/opt/software/conda_env/lib/python2.7/site-packages/cactus/progressive/cactus_progressive.py", line 520, in main
    halID = toil.start(RunCactusPreprocessorThenProgressiveDown(options, project, memory=configWrapper.getDefaultMemory()))
  File "/opt/software/conda_env/lib/python2.7/site-packages/toil/common.py", line 722, in start
    self._batchSystem = self.createBatchSystem(self.config)
  File "/opt/software/conda_env/lib/python2.7/site-packages/toil/common.py", line 872, in createBatchSystem
    return batchSystemClass(**kwargs)
  File "/opt/software/conda_env/lib/python2.7/site-packages/toil/batchSystems/abstractGridEngineBatchSystem.py", line 295, in __init__
    self.maxCPU, self.maxMEM = self.obtainSystemConstants()
  File "/opt/software/conda_env/lib/python2.7/site-packages/toil/batchSystems/slurm.py", line 233, in obtainSystemConstants
    lines = subprocess.check_output(['sinfo', '-Nhe', '--format', '%m %c']).split('\n')
  File "/opt/software/conda_env/lib/python2.7/subprocess.py", line 216, in check_output
    process = Popen(stdout=PIPE, *popenargs, **kwargs)
  File "/opt/software/conda_env/lib/python2.7/subprocess.py", line 394, in __init__
    errread, errwrite)
  File "/opt/software/conda_env/lib/python2.7/subprocess.py", line 1047, in _execute_child
    raise child_exception
OSError: [Errno 2] No such file or directory
slurmstepd: error: *** JOB 47412449 ON t384n7 CANCELLED AT 2022-05-08T01:30:26 DUE TO TIME LIMIT ***

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/MUMmer_output/13E_S5_against_16aC_S26/13E_S5_against_16aC_S26.coords

grep 'NODE_10_length_56437_cov_37.806747' *.fa

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/MUMmer_output/13E_S5_against_16aC_S26/13E_S5_against_16aC_S26.mummerplot_percent_coverage_output.ps

2022-05-13
/hpc-home/osbourne/to_make_local
cp 41B_S7_against_S122.delta /hpc-home/osbourne/to_make_local

2022-05-14
ERROR: ld.so: object '/lib64/liblzma.so.5' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.
ERROR: ld.so: object '/lib64/liblzma.so.5' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.
[2022-05-14T11:21:06+0000] [MainThread] [W] [toil.common] Length of workDir path "/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Cactus_output/working_or_temp_dir" is 249 characters.  Consider setting a shorter path with --workPath or setting TMPDIR to something like "/tmp" to avoid overly long paths.
Traceback (most recent call last):
  File "/usr/local/bin/cactus", line 8, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.6/dist-packages/cactus/progressive/cactus_progressive.py", line 406, in main
    runCactusProgressive(options)
  File "/usr/local/lib/python3.6/dist-packages/cactus/progressive/cactus_progressive.py", line 412, in runCactusProgressive
    with Toil(options) as toil:
  File "/usr/local/lib/python3.6/dist-packages/toil/common.py", line 766, in __enter__
    jobStore.resume()
  File "/usr/local/lib/python3.6/dist-packages/toil/jobStores/fileJobStore.py", line 112, in resume
    raise NoSuchJobStoreException(self.jobStoreDir)
toil.jobStores.abstractJobStore.NoSuchJobStoreException: The job store '/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/14_May_2022-YcCGimqW0ueGpBjPR20UCUadPeFYiBGG32ZLsgktpE3WgVTFjKfi5DvkVxqhzGzFaf90UnoiHPvS5M7gP1XK55NsTbhQgK21UerOXtdCqrg0edZCHlSpQ4vbZMuv8CB5-progressive_cactus_jobstore' does not exist, so there is nothing to restart.

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting
https://ftp.ncbi.nlm.nih.gov/genomes/refseq/vertebrate_mammalian/Mustela_putorius/representative/GCF_011764305.1_ASM1176430v1.1/GCF_011764305.1_ASM1176430v1.1_genomic.fna.gz

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references

https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/434/405/GCF_001434405.1_ASM143440v1/GCF_001434405.1_ASM143440v1_genomic.fna.gz
Ligilactobacillus_apodemi_DSM_16634_equals_JCM_16172
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP047141.1_Ligilactobacillus_animalis_strain_P38_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP039849.1_Ligilactobacillus_animalis_strain_LL1_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP065723.1_Pediococcus_pentosaceus_strain_FDAARGOS_873_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP065967.1_Pediococcus_pentosaceus_strain_FDAARGOS_1011_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP045530.1_Limosilactobacillus_pontis_strain_LP475_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP041676.1_Limosilactobacillus_reuteri_strain_LL7_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Ligilactobacillus_apodemi_DSM_16634_equals_JCM_16172-GCF_001434405.1_ASM143440v1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP045033.1_Lactobacillus_kefiranofaciens_subsp._kefiranofaciens_strain_LKK75_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP020457.1_Lactobacillus_amylolyticus_strain_L6_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP042387.1_Leuconostoc_lactis_strain_CBA3625_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP040374.1_Lactiplantibacillus_plantarum_subsp._plantarum_strain_BNH17_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/NZ_CP029684.2_Oenococcus_sicerae_strain_UCMA15228_chromosome_complete_genome.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_bifidum_NCIMB_41171_GCF_000273525.1_PB_Bifi_bifi_NCIMB_41171_V1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_gallicum_DSM_20093_equals_LMG_11596_GCF_000741205.1_Bifgalcum_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Lactobacillus_gallinarum_GCF_002160635.1_ASM216063v1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_porcinum_DSM_17755_GCF_000771045.1_DSM-17755_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_breve_GCF_001281425.1_ASM128142v1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_ruminantium_GCF_019042115.1_ASM1904211v1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Ligilactobacillus_apodemi_DSM_16634_equals_JCM_16172-GCF_001434405.1_ASM143440v1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_angulatum_dsm_20098_equals_JCM_7096_GCF_001025155.1_ASM102515v1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_saguini_GCF_017378515.1_ASM1737851v1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_animalis_subsp_lactis_BLC1_GCF_000224965.2_ASM22496v2_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_thermophilum_GCF_002846655.1_ASM284665v1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_bifidum_NCIMB_41171_GCF_000273525.1_PB_Bifi_bifi_NCIMB_41171_V1_genomic.fna
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references/Bifidobacterium_gallicum_DSM_20093_equals_LMG_11596_GCF_000741205.1_Bifgalcum_genomic.fna

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references

S123-contigs.fasta.Contigs_min_length_500bp.fa

target_files=$(find -maxdepth 1 -type f -name "S12*-contigs.fasta.Contigs_min_length_500bp.fa") && for f in $target_files ; do label=$(basename "$f" | awk -F "-" '{print $1}') && sed -i -e "s/>/>${label}-/g" "$f" && printf "\nProcessed file:\t$f\n" ; done

awk 1 S12{1,3,4,6,7,8}* > LI_or_UK_concatenated_fasta_files/2022-05-15_all_LI_or_UK_isolate_SPADEs_assemblies_minimum_contig_size_500bp_excluding_S122_concatenated.fa

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/LI_and_UK_cultures_with_some_reference_genomes/LI_or_UK_concatenated_fasta_files/2022-05-15_all_LI_or_UK_isolate_SPADEs_assemblies_minimum_contig_size_500bp_excluding_S122_concatenated.fa /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/LI_and_UK_cultures_with_some_reference_genomes/S122-contigs.fasta.Contigs_min_length_500bp.fa


2022-05-15_RS_Polecat_R0786-S0015_VWT837_A64353_Megahit_min_contig_size_1kb_VizBin_manually_picked_cluster_06.fa

2022-05-16
#Below from Rebecca Shaw concerning running Cactus
so what I did with my genomes is transfer them across to the scratch on the largemem node I was using
13:59
so that is something you can think about to avoid getting out of mem errors
14:00
unless that is what you are already doing
14:00
but Will seemed to think that cactus was tripping up on itself until we moved them onto the scratch
14:01
and then you can have your job store there instead of in your directory, but your outfield in your directory so you can keep track of how its progressing
14:01
*outfiles
14:02

2022-05-18
S128-contigs.fasta.Contigs_min_length_500bp.fa_out.unpadded.fasta - have
S128-contigs.fasta.Contigs_min_length_500bp_out.unpadded.fasta - want
S128-contigs.fasta.Contigs_min_length_500bp.fa - basename of input assembly file

awk '$2>300000000{for(i=3;i<=NF;i++)$i="XXXX"}1' file

awk '$'

awk '{for(i=2;i<=NF;i++) if($i>=2)$i="m"}1' 2022-05-19_RS_test_tsv.tsv | column -t > tester.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

2022-05-20
cp: cannot stat ‘S128_assembly_assembly/S128_assembly_d_results/S128_assembly_out.unpadded.fasta’: No such file or directory
S128_assembly.fasta_out_S128_assembly.unpadded.fasta #- have this
S128_assembly_out.unpadded.fasta #- need this

S128_assembly_out.unpadded.fasta’: No such file or directory
S128_out_S128_assembly.unpadded.fasta #-Have this

2022-05-22
cp: cannot stat ‘S128_assembly_assembly/S128_assembly_d_results/S128_assembly_out.unpadded.fasta’: No such file or directory
source package /tgac/software/testing/bin/krona-2.7
AR30N_Kraken2-050_report.txt

ktImportTaxonomy -m 3 -t 5 AR30N_Kraken2-050_report.txt -o /hpc-home/osbourne/AR30N_Kraken2-050_report.html

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/all_assemblies_plus_reference_genomes

2022-05-23
cp: cannot stat ‘S128_assembly_assembly/S128_assembly_d_results/S128_assembly_out.unpadded.fasta’: No such file or directory

sed 's/).*:/bloom/'
2022-05-23_paths_to_JolyTree_newick_file_and_fasta_files.txt
for f in *.fa ; do nome=$(basename "$f" | sed "s/.fa$//") && pathto=$(realpath "$f") && printf "${nome} ${pathto}\n" >> 2022-05-23_paths_to_JolyTree_newick_file_and_fasta_files.txt ; done
NW_025421298.1 Mustela putorius furo isolate JIRA1106 unplaced genomic scaffold
GL896898

JIRA1106

/hpc-home/osbourne/to_make_local

2022-05-25
singularity exec 2022-05-25_docker_maxbin2_image_by_pegi3s.img run_MaxBin.pl
seqtk seq -l0 Polecat_R0786-S0015_VWT837_A64353_metaSPADES_assembly.Contigs_min_length_500bp.fa > Polecat_R0786-S0015_VWT837_A64353_metaSPADES_assembly.Contigs_min_length_500bp.single_line.fa

2022-05-27
https://data.gtdb.ecogenomic.org/releases/release202/202.0/auxillary_files/gtdbtk_r202_data.tar.gz

2022-05-30
source package 8d5e6fe6-0b34-4ff4-a645-0fe3209c0f75 #Circlator - but needs long reads

2022-05-31
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/outputs/kraken_outputs/multiple_confidence_scores_output

export conf_scores_array=("010" "025" "050" "066" "075" "095")
for i in "${conf_scores_array[@]}"
do
  conf_score="$i"
  classified_file=$(find -maxdepth 1 -type f -name "Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.QCed.Cleansed.${conf_score}_conf_score_1.txt")
  total_reads="13553639"
  classified_reads_lines=$(wc -l "$classified_file" | awk -F " " '{print $1}')
  classified_reads_file=$(echo "$classified_reads_lines / 4" | bc -l)
  unclassified_reads=$(echo "$total_reads - $classified_reads_file" | bc -l)
  printf "$conf_score\t$classified_reads_file\t$unclassified_reads\n"
done

2022-06-01
targets=$(find -maxdepth 1 -type f -name "ERR*Kaiju_output_*_allowed_errors.Taxon_names_added.out" -not -name "SRR9*" -printf "%f\n")
for f in $targets
do
  export sampleID=$(basename "$f" | awk -F "." '{print $1}')
  export allowed_errors=("0" "1" "2" "3" "4" "5" "10" "20")
  for i in "${allowed_errors[@]}"
  do
    allowed_error="$i"
    target_file=$(find -maxdepth 1 -type f -name "${sampleID}.Kaiju_output_${allowed_error}_allowed_errors.Taxon_names_added.out" -not -name "*SRR9*")
    unclassified_reads=$(awk -F "\t" -v classed="U" '$1 == classed {print $1}' "$target_file" | wc -l)
    printf "$sampleID\t$allowed_error\t$unclassified_reads\n"
  done
done | sort -k 1 -h

targets=$(find -maxdepth 1 -type f -name "AR*Kaiju_output_*_errors_allowed.Taxon_names_added.out" -printf "%f\n")
for f in $targets
do
  export sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  export allowed_errors=("0" "1" "2" "3" "4" "5" "10" "20")
  for i in "${allowed_errors[@]}"
  do
    allowed_error="$i"
    target_file=$(find -maxdepth 1 -type f -name "${sampleID}*Kaiju_output_${allowed_error}_errors_allowed.Taxon_names_added.out")
    unclassified_reads=$(awk -F "\t" -v classed="U" '$1 == classed {print $1}' "$target_file" | wc -l)
    printf "$sampleID\t$allowed_error\t$unclassified_reads\n"
  done
done | sort -k 1 -h

targets=$(find -maxdepth 1 -type f -name "AC*Kaiju_output_*_errors_allowed.Taxon_names_added.out" -printf "%f\n")
for f in $targets
do
  export sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  export allowed_errors=("0" "1" "2" "3" "4" "5" "10" "20")
  for i in "${allowed_errors[@]}"
  do
    allowed_error="$i"
    target_file=$(find -maxdepth 1 -type f -name "${sampleID}*Kaiju_output_${allowed_error}_errors_allowed.Taxon_names_added.out")
    unclassified_reads=$(awk -F "\t" -v classed="U" '$1 == classed {print $1}' "$target_file" | wc -l)
    printf "$sampleID\t$allowed_error\t$unclassified_reads\n"
  done
done | sort -k 1 -h


2022-06-03
heream="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/pilot_read_files"
for f in *R1.fq
do
  nome=$(basename "$f")
  nume=$(echo "$nome" | sed "s/-E3_R1/-E3_R2/g")
  sampid=$(echo "$nome" | awk -F "-" '{print $1}')
  printf "${heream}/${nome}\t${heream}/${nume}\t$sampid\n"
done

heream=$(pwd)
for f in *_1.fastq
do
  nome=$(basename "$f")
  nume=$(echo "$nome" | sed "s/_1/_2/g")
  sampid=$(echo "$nome" | awk -F "_" '{print $1}')
  printf "${heream}/${nome}\t${heream}/${nume}\t$sampid\n"
done

2022-06-05
ls -lhtr Classified*010_conf_score_1* | awk -F " " '{print $9}' | sed "s/^/@/g" | sed "s/$/@/g" | tr '@' '"' | tr "\n" " "
export file_array=("AC16J_Metaphlan2-output_abundance_and_read_counts.txt" "AC16N_Metaphlan2-output_abundance_and_read_counts.txt" "AC18J_Metaphlan2-output_abundance_and_read_counts.txt" "AC18N_Metaphlan2-output_abundance_and_read_counts.txt" "AC19J_Metaphlan2-output_abundance_and_read_counts.txt" "AC19N_Metaphlan2-output_abundance_and_read_counts.txt" "AR27J_Metaphlan2-output_abundance_and_read_counts.txt" "AR27N_Metaphlan2-output_abundance_and_read_counts.txt" "AR29J_Metaphlan2-output_abundance_and_read_counts.txt" "AR29N_Metaphlan2-output_abundance_and_read_counts.txt" "AR34J_Metaphlan2-output_abundance_and_read_counts.txt" "AR34N_Metaphlan2-output_abundance_and_read_counts.txt" "Human_mock_Metaphlan2-output_abundance_and_read_counts.txt" "ERR675515_Metaphlan2-output_abundance_and_read_counts.txt" "ERR675516_Metaphlan2-output_abundance_and_read_counts.txt" "ERR3357615_Metaphlan2-output_abundance_and_read_counts.txt" "ERR3357616_Metaphlan2-output_abundance_and_read_counts.txt")
for i in "${file_array[@]}"
do
  inpf="$i"
  nome=$(basename "$inpf" | awk -F "_" '{print $1}')
  estimated_reads=$(grep "estimated_reads_mapped_to_known_clades" "$inpf" | awk -F ":" '{print $2}')
  printf "$nome\t$estimated_reads\n"
done

export file_array=("AC16J.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AC16N.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AC18J.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AC18N.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AC19J.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AC19N.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AR27J.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AR27N.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AR29J.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AR29N.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AR34J.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "AR34N.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "Human_mock.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "ERR675515.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "ERR675516.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "ERR3357615.Kaiju_output_20_allowed_errors.Taxon_names_added.out" "ERR3357616.Kaiju_output_20_allowed_errors.Taxon_names_added.out")
for i in "${file_array[@]}"
do
  inpf="$i"
  nome=$(basename "$inpf" | awk -F "." '{print $1}')
  classified_reads=$(awk -F "\t" -v class_state="C" '$1 == class_state {print $1}' "$inpf" | wc -l)
  printf "$nome\t$classified_reads\n"
done

export file_array=("Classified_Kraken2_AC16J-Acah-3258STDY6863964-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AC16N-Acah-3258STDY6863970-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AC18J-Acah-3258STDY6863965-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AC18N-Acah-3258STDY6863971-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AC19J-Acah-3258STDY6863966-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AC19N-Acah-3258STDY6863972-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AR27J-Arus-3258STDY6863967-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AR27N-Arus-3258STDY6863973-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AR29J-Arus-3258STDY6863968-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AR29N-Arus-3258STDY6863974-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AR34J-Arus-3258STDY6863969-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_AR34N-Arus-3258STDY6863975-E3_R1.fq.010_conf_score_1.txt.gz" "Classified_Kraken2_994_LIB8395_LDI7034_NoIndex_L001_R1.fastq.010_conf_score_1.txt.gz" "Classified_Kraken2_ERR675515_1.fastq.010_conf_score_1.txt.gz" "Classified_Kraken2_ERR675516_1.fastq.010_conf_score_1.txt.gz" "Classified_Kraken2_ERR3357615_1.fastq.010_conf_score_1.txt.gz" "Classified_Kraken2_ERR3357616_1.fastq.010_conf_score_1.txt.gz")
for i in "${file_array[@]}"
do
  inpf="$i"
  nome=$(basename "$inpf" | awk -F "_" '{print $3}' | sed 's/994/Human/g')
  classified_reads=$(zcat "$inpf" | grep -c "kraken:taxid")
  printf "$nome\t$classified_reads\n"
done

export file_array=("AR27J-Arus-3258STDY6863967-E3_R1.fq" "AR34J-Arus-3258STDY6863969-E3_R1.fq" "AR29J-Arus-3258STDY6863968-E3_R1.fq" "AC19J-Acah-3258STDY6863966-E3_R1.fq" "AR29N-Arus-3258STDY6863974-E3_R1.fq" "AC18J-Acah-3258STDY6863965-E3_R1.fq" "AC19N-Acah-3258STDY6863972-E3_R1.fq" "AR27N-Arus-3258STDY6863973-E3_R1.fq" "AC16J-Acah-3258STDY6863964-E3_R1.fq" "AC16N-Acah-3258STDY6863970-E3_R1.fq" "AC18N-Acah-3258STDY6863971-E3_R1.fq" "AR34N-Arus-3258STDY6863975-E3_R1.fq")
for i in "${file_array[@]}"
do
  inpf="$i"
  nome=$(basename "$inpf" | awk -F "." '{print $1}')
  proto_reads=$(wc -l "$inpf" | awk -F " " '{print $1}')
  reads=$(echo "$proto_reads / 4" | bc -l)
  printf "$nome\t$reads\n"
done

2022-06-07
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/metaphlan
non_pilot_files=$(find -maxdepth 1 -type f -name "*Metaphlan2-output_abundance_and_read_counts.txt" -not -name "*_pilot_sample*")
stuff=$(for f in $non_pilot_files
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  reads_in_original="7600000"
  metaphlan_estimated_reads_mapped=$(grep 'estimated_reads_mapped_to_known_clades' "$f" | awk -F ":" '{print $2}')
  percent_reads_in_original_in_metaphlan_estimated_classified=$(echo "($metaphlan_estimated_reads_mapped / $reads_in_original)*100" | bc -l)
  printf "$sampleID\t$percent_reads_in_original_in_metaphlan_estimated_classified\n"
done)
printf "$stuff" | grep -v 'syntax' | awk 'NF'

pilot_files=$(find -maxdepth 1 -type f -name "*Metaphlan2-output_abundance_and_read_counts.txt" -and -name "*_pilot_sample*")
stuff=$(for f in $pilot_files
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  reads_in_original="4460000"
  metaphlan_estimated_reads_mapped=$(grep 'estimated_reads_mapped_to_known_clades' "$f" | awk -F ":" '{print $2}')
  percent_reads_in_original_in_metaphlan_estimated_classified=$(echo "($metaphlan_estimated_reads_mapped / $reads_in_original)*100" | bc -l)
  printf "$sampleID\t$percent_reads_in_original_in_metaphlan_estimated_classified\n"
done)
printf "$stuff" | grep -v 'syntax' | awk 'NF'

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kraken

for f in *_report.txt
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  min_confi=$(basename "$f" | awk -F "-" '{print $2}' | awk -F "_" '{print $1}')
  unclassified_read_percent_from_kraken_report=$(head -1 "$f" | awk -F "\t" '{print $1}')
  bacteria_classified_read_percent=$(awk -F "\t" -v target="    Bacteria" '$6 == target {print $1}' "$f")
  printf "$sampleID\t$min_confi\t$unclassified_read_percent_from_kraken_report\t$bacteria_classified_read_percent\n"
done

for f in *R1.fq ; do sampleID=$(basename "$f" | awk -F "." '{print $1}') && read_count=$(echo "$(wc -l "$f" | awk -F " " '{print $1}') / 4" | bc -l) && printf "$sampleID\t$read_count\n" ; done

non_pilot_targets=$(find -maxdepth 1 -type f -name "*llowed_errors.Taxon_names_added.out*" -not -name "*_pilot_sample*")
for f in $non_pilot_targets
do
  reads_in_original="7600000"
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  allowed_errors=$(basename "$f" | awk -F "_allowed_" '{print $1}' | awk -F "_" '{print $3}')
  basename "$f" | grep -q ".gz" && zip_check="Y" || zip_check="N"
  if [[ "$zip_check" == "Y" ]]
  then
    classified_reads=$(zcat "$f" | awk -F "\t" -v status="C" '$1 == status {print $1}' | grep -v "U" | wc -l)
    unclassified_reads=$(zcat "$f" | awk -F "\t" -v status="U" '$1 == status {print $1}' | grep -v "C" | wc -l)
    percent_reads_classified=$(echo "($classified_reads / $reads_in_original)*100 | bc -l")
    printf "$sampleID\t$allowed_errors\t$classified_reads\t$unclassified_reads\t$percent_reads_classified\n"
  elif [[ "$zip_check" == "N" ]]
  then
    classified_reads=$(awk -F "\t" -v status="C" '$1 == status {print $1}' "$f" | grep -v "U" | wc -l)
    unclassified_reads=$(awk -F "\t" -v status="U" '$1 == status {print $1}' "$f" | grep -v "C" | wc -l)
    percent_reads_classified=$(echo "($classified_reads / $reads_in_original)*100 | bc -l")
    printf "$sampleID\t$allowed_errors\t$classified_reads\t$unclassified_reads\t$percent_reads_classified\n"
  fi
done

pilot_targets=$(find -maxdepth 1 -type f -name "*_pilot_sample*llowed_errors.Taxon_names_added.out*")
for f in $pilot_targets
do
  reads_in_original="4460000"
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  allowed_errors=$(basename "$f" | awk -F "_allowed_" '{print $1}' | awk -F "_" '{print $3}')
  basename "$f" | grep -q ".gz" && zip_check="Y" || zip_check="N"
  if [[ "$zip_check" == "Y" ]]
  then
    classified_reads=$(zcat "$f" | awk -F "\t" -v status="C" '$1 == status {print $1}' | grep -v "U" | wc -l)
    unclassified_reads=$(zcat "$f" | awk -F "\t" -v status="U" '$1 == status {print $1}' | grep -v "C" | wc -l)
    percent_reads_classified=$(echo "($classified_reads / $reads_in_original)*100 | bc -l")
    printf "$sampleID\t$allowed_errors\t$classified_reads\t$unclassified_reads\t$percent_reads_classified\n"
  elif [[ "$zip_check" == "N" ]]
  then
    classified_reads=$(awk -F "\t" -v status="C" '$1 == status {print $1}' "$f" | grep -v "U" | wc -l)
    unclassified_reads=$(awk -F "\t" -v status="U" '$1 == status {print $1}' "$f" | grep -v "C" | wc -l)
    percent_reads_classified=$(echo "($classified_reads / $reads_in_original)*100 | bc -l")
    printf "$sampleID\t$allowed_errors\t$classified_reads\t$unclassified_reads\t$percent_reads_classified\n"
  fi
done

grep -v -e 'Will' -e 'sequences' -e 'database' 2022-06-07_RS_trial_script_part_additional_Kraken2_run_not_specifying_output_files_for_classified_and_unclassified-48119804.out | awk 'NF' > Polecat_R0786-S0015_VWT837_A64353_Kraken2-075.outfile.out

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Taxonomic_classifier_output

source package /tgac/software/testing/bin/kaiju-1.7.3

kaiju_database_directory="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju"
kaiju_nodes="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/nodes.dmp"
kaijudbfile="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/kaiju_db_nr_euk.fmi"
kaiju_names="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"

sort -k2,2 Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out > Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out
sed -i -e "s/taxid//g" Polecat_R0786-S0015_VWT837_A64353_Kraken2-075.outfile.out
cat Polecat_R0786-S0015_VWT837_A64353_Kraken2-075.outfile.out | tr -d "()" > temp.txt
sort -k2,2 temp.txt > temp.txt.sorted.out

awk '{gsub("[[:alpha:]]", "", $3); print}' < temp.txt.sorted.out > temp2.txt.sorted.out

kaiju-mergeOutputs -i Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out -j temp2.txt.sorted.out -o Polecat_R0786-S0015_VWT837_A64353_merged_kaiju_and_kraken_outputs.out -c lca -t "$kaiju_nodes"

A00478:208:HY5VJDSX2:3:1101:10013:5024

grep 'A00478:208:HY5VJDSX2:3:1101:10013:5024' Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out
grep 'A00478:208:HY5VJDSX2:3:1101:10013:5024' temp2.txt.sorted.out

2022-06-09
cp: cannot stat 'Polecat_R0786-S0015_VWT837_A64353_bin_01_assembly/Polecat_R0786-S0015_VWT837_A64353_bin_01_d_results/Polecat_R0786-S0015_VWT837_A64353_bin_01_out.unpadded.fasta': No such file or directory
Polecat_R0786-S0015_VWT837_A64353_bin_01_out.unpadded.fasta
Polecat_R0786-S0015_VWT837_A64353_out_ReferenceStrain.unpadded.fasta

Looking for files named in data ...### fasta::Polecat_R0786-S0015_VWT837_A64353_bin_01.fasta ###fasta###

cp: cannot stat 'Polecat_R0786-S0015_VWT837_A64353_bin_01_assembly/Polecat_R0786-S0015_VWT837_A64353_bin_01_d_results/Polecat_R0786-S0015_VWT837_A64353_bin_01_out.unpadded.fasta': No such file or directory

2022-06-12
cat Polecat_R0786-S0015_VWT837_A64353_Kraken2-075.outfile.out | awk -F "\t" '{print $1"\t"$2"\t"$3"\t"$4}' | sort -k2,2 | column -t

source package /tgac/software/testing/bin/kaiju-1.7.3
kaiju_database_directory="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju"
kaiju_nodes="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/nodes.dmp"
kaijudbfile="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/kaiju_db_nr_euk.fmi"
kaiju_names="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
kaiju-mergeOutputs -i Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out -j sorted_taxids_only_temp_krak_75_percent.tsv -o Polecat_R0786-S0015_VWT837_A64353_merged_kaiju_and_kraken_outputs.out -c lca -t "$kaiju_nodes"

awk -F "\t" '{print $2}' Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out > 2022-06-12_list_all_read_IDs.txt

#Kraken file is not properly formatted, some lines still have part of taxa names in
#third column
while read -r line
do
  readID="$line"
  kaiju_taxID=$(awk -F "\t" -v readID="$readID" '$2 == readID {print $3}' Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out)
  kraken_taxID=$(awk -F "\t" -v readID="$readID" '$2 == readID {print $3}' sorted_taxids_only_temp_krak_75_percent.tsv)
  proto_kaiju_score=$(awk -F "\t" -v readID="$readID" '$2 == readID {print $4}' Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out)
  if [ -z "$proto_kaiju_score" ]
  then
    kaiju_score="0"
  else
    kaiju_score="$proto_kaiju_score"
  fi

  printf "$"

source package 9020df39-c4ad-402b-b299-896159114bd7
merge_metaphlan_tables.py *read_counts.txt > 2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/metaphlan

BootStrap: docker
From: biobakery/hclust2:1.0.0_3d589ab

BootStrap: docker
From: biobakery/workflows:latest

2022-06-12_BioBakery_workflows_latest.def

2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.def
sudo singularity build 2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.img 2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.def
sudo singularity build 2022-06-12_BioBakery_workflows_latest.img 2022-06-12_BioBakery_workflows_latest.def

/hpc-home/osbourne/2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.img
singularity exec "$maxbin2_docker_image" run_MaxBin.pl -contig "$contig_file" -reads "$read_file_1" -reads2 "$read_file_2" -min_contig_length 1000 -out "${output_directory}/${sampleID}.MaxBin2_output"

singularity exec /hpc-home/osbourne/2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.img hclust2.py -i 2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt -o test.png --skip_rows 1 --ftop 50 --f_dist_f correlation --s_dist_f braycurtis --cell_aspect_ratio 9 -s --fperc 99 --flabel_size 4 --metadata_rows 2,3,4 --legend_file HMP.sqrt_scale.legend.png --max_flabel_len 100 --metadata_height 0.075 --minv 0.01 --no_slabels --dpi 300 --slinkage complete
singularity exec /hpc-home/osbourne/2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.img hclust2.py -i 2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt -o test.png --skip_rows 1 --ftop 50 --f_dist_f correlation --s_dist_f braycurtis --cell_aspect_ratio 9 -s --fperc 99 --flabel_size 4 --legend_file HMP.sqrt_scale.legend.png --max_flabel_len 100 --metadata_height 0.075 --minv 0.01 --no_slabels --dpi 300 --slinkage complete

singularity exec /hpc-home/osbourne/2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.img hclust2.py -i 2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt -o test.png --skip_rows 1 --ftop 50 --f_dist_f correlation --s_dist_f braycurtis --cell_aspect_ratio 9 -s --fperc 99 --flabel_size 4 --max_flabel_len 100 --minv 0.01 --no_slabels --dpi 300 --slinkage complete
cp 2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt working_2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt

cut -d $'\t' -f2 --complement working_2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt > 2_working_2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt
singularity exec /hpc-home/osbourne/2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.img hclust2.py --in 2_working_2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt -l --out test.png

singularity exec /hpc-home/osbourne/2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.img hclust2.py -i 2_working_2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt -o test.svg --skip_rows 1 --ftop 50 --f_dist_f correlation --s_dist_f braycurtis --cell_aspect_ratio 9 -s --fperc 99 --flabel_size 4 --metadata_rows 2,3,4 --legend_file HMP.sqrt_scale.legend.svg --max_flabel_len 100 --metadata_height 0.075 --minv 0.01 --no_slabels --dpi 300 --slinkage complete

2022-06-13
@A00478:208:HY5VJDSX2:3:1101:15709:1204
2022-06-13_Unclassified_Kraken_75_percent_conf_ReadIDs_Polecat_R0786-S0015_VWT837_A64353.txt

test_thing1="@A00478:208:HY5VJDSX2:3:1101:15709:1204"
test_thing=$(printf "$test_thing1" | tr -d "@")
awk -F "\t" -v readID="$test_thing" '$2 == readID {print $3;}' Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out

while read -r line
do
  proto_krak_uncl_readID="$line"
  krak_uncl_readID=$(printf "$proto_krak_uncl_readID" | tr -d "@")
  kaiju_taxID=$(awk -F "\t" -v readID="$krak_uncl_readID" '$2 == readID {print $3;}' Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out)
  printf "$krak_uncl_readID\t$kaiju_taxID\n"
done < 2022-06-13_Unclassified_Kraken_75_percent_conf_ReadIDs_Polecat_R0786-S0015_VWT837_A64353.txt

singularity exec /hpc-home/osbourne/2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.img hclust2.py -i 2_working_2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt -o test.svg --skip_rows 1 --ftop 10 --f_dist_f correlation --s_dist_f braycurtis --cell_aspect_ratio 9 -s --fperc 99 --flabel_size 4 --metadata_rows 2,3,4 --legend_file test.sqrt_scale.legend.png --max_flabel_len 100 --metadata_height 0.075 --minv 0.01 --no_slabels --dpi 300 --slinkage complete
singularity exec /hpc-home/osbourne/2022-06-12_BioBakery_hclust2_v_1.0.0_3d589ab.img hclust2.py --in 2_working_2022-06-12_all_samples_processed_subsampled_read_files_merged_Metaphlan_outputs.txt -l --out test.svg --ftop 10 --f_dist_f correlation --s_dist_f braycurtis --cell_aspect_ratio 9 -s --fperc 99 --flabel_size 4 --legend_file test.sqrt_scale.legend.svg --max_flabel_len 100 --metadata_height 0.075 --minv 0.01 --no_slabels --dpi 300 --slinkage complete

grep -wc <(cat 2022-06-13_Kraken_detected_TaxIDs_list.txt) 2022-06-13_Kaiju_detected_TaxIDs_list.txt

grep -wc -f 2022-06-13_Kraken_detected_TaxIDs_list.txt 2022-06-13_Kaiju_detected_TaxIDs_list.txt

while read -r line
do
  krak_taxid="$line"
  awk -v taxid="$krak_taxid" '$0 == taxid {print $0;}' 2022-06-13_Kaiju_detected_TaxIDs_list.txt
done < 2022-06-13_Kraken_detected_TaxIDs_list.txt

grep -wv -f 2022-06-13_Kraken_taxIDs_detected_by_Kaiju.txt 2022-06-13_Kraken_detected_TaxIDs_list.txt

while read -r line
do
  krak_taxid="$line"
  awk -v taxid="$krak_taxid" '$0 == taxid {print $0;}' 2022-06-13_Kraken_detected_TaxIDs_list.txt
done < 2022-06-13_Kaiju_detected_TaxIDs_list.txt

grep -wv -f 2022-06-13_Kaiju_taxIDs_detected_by_Kraken.txt 2022-06-13_Kaiju_detected_TaxIDs_list.txt


2022-06-14
BootStrap: docker
From: biobakery/workflows:latest

BootStrap: docker
From: combinelab/salmon:latest

sudo singularity build 2022-06-12_BioBakery_workflows_latest.img 2022-06-12_BioBakery_workflows_latest.def

printf "Read_ID\tKraken_taxID\tKaiju_taxID\n" > 2022-06-16_reads_classified_by_Kraken_taxIDs_against_Kaiju_taxIDs.tsv
while read -r line
do
  readID="$line"
  kraken_taxID=$(grep -w "$readID" Classified_Kraken2_Polecat_R0786-S0015_VWT837_A64353_R1.QCed.Cleansed.075_conf_score_1.txt | awk -F "|" '{print $2}')
  kaiju_taxID=$(awk -F "\t" -v read_ID="$readID" '$2 == read_ID {print $3}' Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out)
  printf "$readID\t$kraken_taxID\t$kaiju_taxID\n" >> 2022-06-16_reads_classified_by_Kraken_taxIDs_against_Kaiju_taxIDs.tsv
done < 2022-06-16_all_reads_classified_by_kraken_075_min_confidence_list_reads.txt

printf "Kaiju_taxID\tNumber_reads_assigned\n" > 2022-06-16_Kaiju_read_classifications_not_in_Kraken_number_reads_assigned.tsv
while read -r line
do
  taxID="$line"
  number_assigned_reads_Kaiju=$(awk -F "\t" -v taxid="$taxID" '$3 == taxid {print $3}' Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out | wc -l)
  printf "$taxID\t$number_assigned_reads_Kaiju\n" >> 2022-06-16_Kaiju_read_classifications_not_in_Kraken_number_reads_assigned.tsv
done < 2022-06-13_Kaiju_taxIDs_NOT_detected_by_Kraken.txt

printf "Kraken_taxID\tKaiju_Number_reads_assigned\n" > 2022-06-16_Kraken_taxIDs_also_found_Kaiju_number_reads_assigned_by_Kaiju.tsv
while read -r line
do
  taxID="$line"
  number_assigned_reads_Kaiju=$(awk -F "\t" -v taxid="$taxID" '$3 == taxid {print $3}' Polecat_R0786-S0015_VWT837_A64353.Kaiju_output_1_allowed_errors.Taxon_names_added.out.SORTED.out | wc -l)
  printf "$taxID\t$number_assigned_reads_Kaiju\n" >> 2022-06-16_Kraken_taxIDs_also_found_Kaiju_number_reads_assigned_by_Kaiju.tsv
done < 2022-06-13_Kraken_taxIDs_detected_by_Kaiju.txt

2022-06-17
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kraken

conf_score="075"
target_files=$(find -maxdepth 1 -type f -name "*-${conf_score}_report.txt" -printf "%f\n")
for f in $target_files
do
  cat "$f" | awk -F "\t" '{print $6}' >> "${conf_score}_temp_all_taxa_detected_report.txt"
done
cat "${conf_score}_temp_all_taxa_detected_report.txt" | sort -h | uniq > "${conf_score}_temp_all_unique_taxa_detected_report.txt"
while read -r line
do
  taxon="$line"
  trimmed_taxon=$(echo "$taxon" | xargs)
  printf "$trimmed_taxon\n" >> "${conf_score}_temp_trimmed_all_unique_taxa_detected_report.txt"
done < "${conf_score}_temp_all_unique_taxa_detected_report.txt"
cat "${conf_score}_temp_trimmed_all_unique_taxa_detected_report.txt" | sort -h | uniq > "${conf_score}_trimmed_all_unique_taxa_detected_report.txt"
rm "${conf_score}_temp_all_unique_taxa_detected_report.txt"
rm "${conf_score}_temp_all_taxa_detected_report.txt"
rm "${conf_score}_temp_trimmed_all_unique_taxa_detected_report.txt"

010_trimmed_all_unique_taxa_detected_report.txt
grep -w "Duncaniella$" *-095_report.txt | tr -s " " | awk -v taxon="Duncaniella" '{if ()}'
grep -w "Duncaniella$" *-095_report.txt |

conf_score="010"
target_files=$(find -maxdepth 1 -type f -name "*-${conf_score}_report.txt" -printf "%f\n")
detected_taxa_file=$(find -maxdepth 1 -type f -name "${conf_score}_trimmed_all_unique_taxa_detected_report.txt" -printf "%f\n")
for f in $target_files
do
  proto_subject_file=$(basename "$f")
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  awk -F "\t" '{print $1"\t"$6}' "$proto_subject_file" | tr -s " " | sed "s/^ //g" | sed "s/\t /\t/g" > "${sampleID}_${conf_score}_temp_file.tsv"
  subject_file="${sampleID}_${conf_score}_temp_file.tsv"
  touch "${sampleID}_${conf_score}_all_potential_taxa_Kraken_report_percentages.tsv"
  output_table="${sampleID}_${conf_score}_all_potential_taxa_Kraken_report_percentages.tsv"
  printf "Taxa\t$sampleID\n" > "$output_table"
  while read -r line
  do
    taxon="$line"
    grep -qw "${taxon}$" "$subject_file" && presence="1" || presence="0"
    if [[ "$presence" == 1 ]]
    then
      percent_from_report=$(awk -F "\t" -v taxon="$taxon" '$2 == taxon {print $1}' "$subject_file")
    elif [[ "$presence" == 0 ]]
    then
      percent_from_report="0"
    fi
    printf "$taxon\t$percent_from_report\n" >> "$output_table"
  done < "$detected_taxa_file"
  printf "Processed file:\t$subject_file\n"
  rm "$subject_file"
  how_many_lines_in_output=$(wc -l "$output_table")
  printf "${sampleID}\t${conf_score}\t${how_many_lines_in_output}\n" >> "2022-06-18_${conf_score}_number_lines_output_files.tsv"
done
target_files_2=$(find -maxdepth 1 -type f -name "*${conf_score}_all_potential_taxa_Kraken_report_percentages.tsv" -printf "%f\n")
for f in $target_files_2
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}_${conf_score}_temp_just_percents.txt"
done
sed -i '1s/^/Taxa\n/' "${conf_score}_trimmed_all_unique_taxa_detected_report.txt"
paste -d "\t" "${conf_score}_trimmed_all_unique_taxa_detected_report.txt" *_"${conf_score}"_temp_just_percents.txt > "${conf_score}_min_confidence_all_processed_subsampled_samples_Kraken_all_potential_taxa_percentages_from_report_file.tsv"
rm *_"${conf_score}"_temp_just_percents.txt
rm *_"${conf_score}"_all_potential_taxa_Kraken_report_percentages.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kraken

2022-06-18
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files

066 - AR43J extra line
050 - AR43J, AC32J and AC37J extra line
025 - 3 have two extra lines, 13 have one extra line
010 - majority have extra lines

unclassified Lachnoclostridium
AC14J
025
AC14J_Kraken2-025_report.txt

AR48N_Kraken2-095_report.txt | awk -F "\t" '{print $5}'

conf_score="010"
for f in *"-${conf_score}_report.txt"
do
  cat "$f" | awk -F "\t" '{print $5}'
done | sort -h | uniq > "${conf_score}_all_unique_TaxIDs.txt"

conf_score="050"
target_files=$(find -maxdepth 1 -type f -name "*-${conf_score}_report.txt" -printf "%f\n")
detected_taxa_file=$(find -maxdepth 1 -type f -name "${conf_score}_all_unique_TaxIDs.txt" -printf "%f\n")
for f in $target_files
do
  proto_subject_file=$(basename "$f")
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  awk -F "\t" '{print $1"\t"$5}' "$proto_subject_file" | tr -s " " > "${sampleID}_${conf_score}_temp_file.tsv"
  subject_file="${sampleID}_${conf_score}_temp_file.tsv"
  touch "${sampleID}_${conf_score}_all_potential_taxids_Kraken_report_percentages.tsv"
  output_table="${sampleID}_${conf_score}_all_potential_taxids_Kraken_report_percentages.tsv"
  printf "Taxa\t$sampleID\n" > "$output_table"
  while read -r line
  do
    taxon="$line"
    grep -qw "${taxon}$" "$subject_file" && presence="1" || presence="0"
    if [[ "$presence" == 1 ]]
    then
      percent_from_report=$(awk -F "\t" -v taxon="$taxon" '$2 == taxon {print $1}' "$subject_file")
    elif [[ "$presence" == 0 ]]
    then
      percent_from_report="0"
    fi
    printf "$taxon\t$percent_from_report\n" >> "$output_table"
  done < "$detected_taxa_file"
  printf "Processed file:\t$subject_file\n"
  rm "$subject_file"
  how_many_lines_in_output=$(wc -l "$output_table")
  printf "${sampleID}\t${conf_score}\t${how_many_lines_in_output}\n" >> "2022-06-18_${conf_score}_number_lines_output_files.tsv"
done
target_files_2=$(find -maxdepth 1 -type f -name "*${conf_score}_all_potential_taxids_Kraken_report_percentages.tsv" -printf "%f\n")
for f in $target_files_2
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}_${conf_score}_temp_just_percents.txt"
done
sed -i '1s/^/Taxid\n/' "${conf_score}_all_unique_TaxIDs.txt"
paste -d "\t" "${conf_score}_all_unique_TaxIDs.txt" *_"${conf_score}"_temp_just_percents.txt > "${conf_score}_min_confidence_all_processed_subsampled_samples_Kraken_all_potential_taxid_percentages_from_report_file.tsv"
rm *_"${conf_score}"_temp_just_percents.txt
rm *_"${conf_score}"_all_potential_taxids_Kraken_report_percentages.tsv

awk -F "\t" -v taxid="20" '$5 != taxid {print "0"}' *_Kraken2-095_report.txt
awk -F "\t" -v taxid="20" '$5 == taxid {print $1}' *_Kraken2-095_report.txt | tr -d " "

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files

2022-06-20
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kraken
for f in *_report.txt ; do awk -F "\t" '{print $4"\t"$5}' "$f" ; done | sort -h -k2 | uniq > 2022-06-20_all_unique_taxids_all_reports_and_phylogenetic_rank_abbreviation.tsv

remove the word 'taxid' from the top of all the unique taxid lists for each conf score

while read -r line
do
  taxid="$line"
  phylo_level=$(awk -F "\t" -v tax_id="$taxid" '$2 == tax_id {print $1}' 2022-06-20_all_unique_taxids_all_reports_and_phylogenetic_rank_abbreviation.tsv)
  printf "$taxid\t$phylo_level\n"
done < 095_all_unique_TaxIDs.txt

while read -r line
do
  taxid="$line"
  proto_taxon=$(awk -F "\t" -v tax_id="$taxid" '$5 == tax_id {print $6}' *Kraken2-010_report.txt | sort -h | uniq)
  taxon=$(echo "$proto_taxon" | xargs)
  printf "$taxon\n"
done < 010_all_unique_TaxIDs.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files

awk -F "\t" -v tax_id="11" '$5 == tax_id {print $6}' *Kraken2-095_report.txt | sort -h | uniq

awk -F "\t" -v tax_id="2826938" '$5 == tax_id {print $6}' *Kraken2-095_report.txt

2022-06-21
AR27N_pilot_sample.Kaiju2table_4_errors_allowed-genus_level_results.tsv
AR48N.Kaiju2table_5_errors_allowed-class_level_results.tsv

errors_allowed="5"
target_files=$(find -maxdepth 1 -type f -name "*Kaiju2table_${errors_allowed}_errors_allowed-*_level_results.tsv" -printf "%f\n")
export phylo_array=("phylum" "class" "order" "family" "genus" "species")
for f in $target_files
do
  for i in "${phylo_array[@]}"
  do
    export taxa_level="$i"
    proto_subject_file=$(find -maxdepth 1 -type f -name "*Kaiju2table_${errors_allowed}_errors_allowed-${taxa_level}_level_results.tsv" -printf "%f\n")
    for f in $proto_subject_file
    do
      subject_file=$(basename "$f")
      awk -F "\t" '{print $4}' "$subject_file" | tr -dc "0123456789" | awk 'NF' >> "2022-06-21_all_unique_taxIDs_kaiju_${errors_allowed}_errors_allowed_${taxa_level}_TEMP.txt"
    done
    printf "Processed all files for taxonomic level:\t$taxa_level\n"
  done
  cat "2022-06-21_all_unique_taxIDs_kaiju_${errors_allowed}_errors_allowed_${taxa_level}_TEMP.txt" | sort -h | uniq > "2022-06-21_all_unique_taxIDs_kaiju_${errors_allowed}_errors_allowed_${taxa_level}.txt"
  rm 2022-06-21_all_unique_taxIDs_kaiju_${errors_allowed}_errors_allowed_*_TEMP.txt
done

pilot_individuals_array=("AC16" "AC18" "AC19" "AR27" "AR29" "AR32")
"${file_array[@]}"

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files/

2022-06-22
cat *Kaiju2table_20_errors_allowed-species_level_results.tsv | awk -F "\t" '{print $4}' | awk 'NF' | sort -h | uniq | grep -v "NA" | grep -v "taxon_id" > 2022-06-22_

errors_allowed="20"
taxa_level="species"
target_files=$(find -maxdepth 1 -type f -name "*Kaiju2table_${errors_allowed}_errors_allowed-${taxa_level}_level_results.tsv" -printf "%f\n")
output_file="2022_06_22_${errors_allowed}_errors_allowed_${taxa_level}_results_all_unique_taxa.txt"
for f in $target_files
do
  subject_file=$(basename "$f")
  cat "$subject_file" | awk -F "\t" '{print $4}' | grep -v "NA" | grep -v "taxon_id" | awk 'NF' | sort -h >> "${output_file}.TEMP"
  printf "Processed file:\t$subject_file\n"
done
cat "${output_file}.TEMP" | grep -v "NA" | grep -v "taxon_id" | tr -d "[:alpha:]" | tr -d "[:punct:]" | awk 'NF' | sort -h | uniq > "$output_file"
rm "${output_file}.TEMP"

export phylo_array=("phylum" "class" "order" "family" "genus" "species")
errors_allowed="0"
for i in "${phylo_array[@]}"
do
  taxa_level="$i"
  target_files=$(find -maxdepth 1 -type f -name "*Kaiju2table_${errors_allowed}_errors_allowed-${taxa_level}_level_results.tsv" -printf "%f\n")
  output_file="2022_06_22_${errors_allowed}_errors_allowed_${taxa_level}_results_all_unique_taxa.txt"
  for f in $target_files
  do
    subject_file=$(basename "$f")
    cat "$subject_file" | awk -F "\t" '{print $4}' | grep -v "NA" | grep -v "taxon_id" | awk 'NF' | sort -h >> "${output_file}.TEMP"
    printf "Processed file:\t$subject_file\n"
  done
  cat "${output_file}.TEMP" | grep -v "NA" | grep -v "taxon_id" | tr -d "[:alpha:]" | tr -d "[:punct:]" | awk 'NF' | sort -h | uniq > "$output_file"
  rm "${output_file}.TEMP"
done

export phylo_array=("phylum" "class" "order" "family" "genus" "species")
errors_allowed="0"
for i in "${phylo_array[@]}"
do
  taxa_level="$i"
  target_files=$(find -maxdepth 1 -type f -name "*Kaiju2table_${errors_allowed}_errors_allowed-${taxa_level}_level_results.tsv" -not -name "*taxIDs*" -printf "%f\n")
  taxid_list_file="2022_06_22_${errors_allowed}_errors_allowed_${taxa_level}_results_all_unique_taxa.txt"
  for f in $target_files
  do
    subject_files=$(find -maxdepth 1 -type f -name "*Kaiju2table_${errors_allowed}_errors_allowed-${taxa_level}_level_results.tsv" -not -name "*taxIDs*" -printf "%f\n")
    for f in $subject_files
    do
      proto_sampleID=$(basename "$f")
      pre_sampleID="${proto_sampleID::5}"
      sampleID=$(echo "$pre_sampleID" | tr -dc "[:alnum:]")
      output_file="${sampleID}_Kaiju2table_${errors_allowed}_errors_allowed_unique_taxIDs_${taxa_level}_level_results.tsv"
      printf "$sampleID\n" > "$output_file"
      working_file="${sampleID}_Kaiju2table_${errors_allowed}_errors_allowed-${taxa_level}_level_only_percentages_TEMP.tsv"
      awk -F "\t" '{print $2"\t"$4}' "$proto_sampleID" | grep -v "NA" | grep -v "taxon_id" | tr -d "[:alpha:]" | awk 'NF' > "$working_file"
      while read -r line
      do
        taxid="$line"
        grep -qw "$taxid" "$working_file" && presence="1" || presence="0"
        if [[ "$presence" == 1 ]]
        then
          percent_from_report=$(awk -F "\t" -v taxid="$taxid" '$2 == taxid {print $1}' "$working_file" | tr -d "\t")
        elif [[ "$presence" == 0 ]]
        then
          percent_from_report="0"
        fi
        printf "$taxon\t$percent_from_report\n" >> "$output_file"
      done < "$taxid_list_file"
    done
    printf "Processed file:\t$proto_sampleID\n"
  done
  printf "Processed file:\t$proto_sampleID\n"
  rm "$working_file"
done





export phylo_array=("phylum" "class" "order" "family" "genus" "species")
errors_allowed="0"
for i in "${phylo_array[@]}"
do
  export taxa_level="$i"
  target_files=$(find -maxdepth 1 -type f -name "*Kaiju2table_${errors_allowed}_errors_allowed-${taxa_level}_level_results.tsv" -not -name "*taxIDs*" -printf "%f\n")
  taxid_list_file="2022_06_22_${errors_allowed}_errors_allowed_${taxa_level}_results_all_unique_taxa.txt"
  for f in $target_files
  do
    proto_sampleID=$(basename "$f")
    pre_sampleID="${proto_sampleID::5}"
    sampleID=$(echo "$pre_sampleID" | tr -dc "[:alnum:]")
    output_file="${sampleID}_Kaiju2table_${errors_allowed}_errors_allowed_unique_taxIDs_${taxa_level}_level_results.tsv"
    printf "$sampleID\n" > "$output_file"
    working_file="${sampleID}_Kaiju2table_${errors_allowed}_errors_allowed-${taxa_level}_level_only_percentages_TEMP.tsv"
    awk -F "\t" '{print $2"\t"$4}' "$proto_sampleID" | grep -v "NA" | grep -v "taxon_id" | tr -d "[:alpha:]" | awk 'NF' > "$working_file"
    while read -r line
    do
      taxid="$line"
      grep -qw "$taxid" "$working_file" && presence="1" || presence="0"
      if [[ "$presence" == 1 ]]
      then
        percent_from_report=$(awk -F "\t" -v taxid="$taxid" '$2 == taxid {print $1}' "$working_file" | tr -d "\t")
      elif [[ "$presence" == 0 ]]
      then
        percent_from_report="0"
      fi
      printf "$percent_from_report\n" >> "$output_file"
    done < "$taxid_list_file"
    printf "Processed file:\t$proto_sampleID\n"
    rm "$working_file"
  done
  printf "Processed all files with error allowance:\t$errors_allowed at taxa level:\t$taxa_level\n"
done

rm *_Kaiju2table_0_errors_allowed_unique_taxIDs_phylum_level_results.tsv

  proto_subject_file=$(basename "$f")
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  awk -F "\t" '{print $1"\t"$5}' "$proto_subject_file" | tr -s " " > "${sampleID}_${conf_score}_temp_file.tsv"
  subject_file="${sampleID}_${conf_score}_temp_file.tsv"
  touch "${sampleID}_${conf_score}_all_potential_taxids_Kraken_report_percentages.tsv"
  output_table="${sampleID}_${conf_score}_all_potential_taxids_Kraken_report_percentages.tsv"
  printf "Taxa\t$sampleID\n" > "$output_table"
  while read -r line
  do
    taxon="$line"
    grep -qw "${taxon}$" "$subject_file" && presence="1" || presence="0"
    if [[ "$presence" == 1 ]]
    then
      percent_from_report=$(awk -F "\t" -v taxon="$taxon" '$2 == taxon {print $1}' "$subject_file")
    elif [[ "$presence" == 0 ]]
    then
      percent_from_report="0"
    fi
    printf "$taxon\t$percent_from_report\n" >> "$output_table"
  done < "$detected_taxa_file"
  printf "Processed file:\t$subject_file\n"
  rm "$subject_file"
  how_many_lines_in_output=$(wc -l "$output_table")
  printf "${sampleID}\t${conf_score}\t${how_many_lines_in_output}\n" >> "2022-06-18_${conf_score}_number_lines_output_files.tsv"
done
target_files_2=$(find -maxdepth 1 -type f -name "*${conf_score}_all_potential_taxids_Kraken_report_percentages.tsv" -printf "%f\n")
for f in $target_files_2
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}_${conf_score}_temp_just_percents.txt"
done
sed -i '1s/^/Taxid\n/' "${conf_score}_all_unique_TaxIDs.txt"
paste -d "\t" "${conf_score}_all_unique_TaxIDs.txt" *_"${conf_score}"_temp_just_percents.txt > "${conf_score}_min_confidence_all_processed_subsampled_samples_Kraken_all_potential_taxid_percentages_from_report_file.tsv"
rm *_"${conf_score}"_temp_just_percents.txt
rm *_"${conf_score}"_all_potential_taxids_Kraken_report_percentages.tsv

2022-06-24
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R2.fastq

2022-06-24
sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R2.fastq

sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R2.fastq

sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R2.fastq

2022-06-28
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs

cat 2022-04-20_concatenated_all_good_bins_DFAST_output_GFF_files.gff | grep "product=" | awk -F "product=" '{print $2}' | awk -F ";inf" '{print $1}' | sort -h | uniq > 2022-06-28_presumptive_list_all_unique_product_names_including_single_hypothetical_protein.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins

AC7N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.Only_reads.IDX_stats.txt

thisdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*BWA_against_concatenated_GOOD_bins.Mapped.Sorted.Only_reads.IDX_stats.txt")
for f in $target_files
do
  sampleid=$(basename "$f" | awk -F "_" '{print $1}')
  output_file="${thisdir}/${sampleid}_just_counts_in_order.txt"
  printf "$sampleid\n" > "$output_file"
  cat "$f" | awk -F "\t" '{print $3}' >> "$output_file"
  printf "Processed file:\t$f\n"
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files/2022-06-28_presumptive_list_all_unique_product_names_including_single_hypothetical_protein.txt

thisdir=$(pwd)
list_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files/2022-06-28_presumptive_list_all_unique_product_names_including_single_hypothetical_protein.txt"
target_files=$(find -maxdepth 2 -type f -name "Bin_*_genome.gff")
for f in $target_files
do
  bin_id=$(basename "$f" | awk -F "_gen" '{print $1}')
  grep "ID=" "$f" | awk -F ";product=" '{print $2}' | awk -F ";inference" '{print $1}' | sort -h > "${thisdir}/TEMP_${bin_id}_searching_file.tsv"
  while read -r line
  do
    product="$line"
    product_count=$(awk -v product="$product" '$0 == product {print $0}' "${thisdir}/TEMP_${bin_id}_searching_file.tsv" | wc -l)
    echo "$product££$product_count" >> "${thisdir}/${bin_id}_simple_counts_unique_products.tsv"
  done < "$list_file"
  sed -i -e "s/££/\t/g" "${thisdir}/${bin_id}_simple_counts_unique_products.tsv"
  printf "Processed file:\t$f\n"
done

2022-06-29
cat temp_bins_list.txt | sed "s/^/c(/g" | sed "s/$/),/g" | tr "\n" " "
temp_bins_list.txt
2022-06-29_bash_placeholder_kruskal_wallis_R_script_contig_and_library_size_adjusted_not_transformed_summed_mapping_counts.txt

while read -r line
do
  bin_name="$line"
  cat 2022-06-29_bash_placeholder_kruskal_wallis_R_script_contig_and_library_size_adjusted_not_transformed_summed_mapping_counts.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-06-29_kruskal_wallis_R_script_contig_and_library_size_adjusted_not_transformed_summed_mapping_counts.R

2022-06-30
cp: cannot stat ‘/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Assembly_output/Polecat_R0786-S0013_VWT770_A64351/Polecat_R0786-S0013_VWT770_A64351_Contigs_500bp.Single_line.fa’: No such file or directory

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Assembly_output/Polecat_R0786-S0013_VWT770_A64351/Polecat_R0786-S0013_VWT770_A64351_Contigs_500bp.single_line.fa
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Assembly_output/Polecat_R0786-S0013_VWT770_A64351/Polecat_R0786-S0013_VWT770_A64351_Contigs_500bp.Single_line.fa
Polecat_R0786-S0013_VWT770_A64351_Contigs_500bp.single_line.fa

sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R2.fastq
sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R2.fastq
sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R2.fastq

2022-07-01
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins

outdir=$(pwd)
subject_files=$(find -maxdepth 2 -type f -name "*_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.Only_reads.IDX_stats.Contig_size_and_library_size_adjusted.tsv")
list_file="2022-06-28_list_all_contigs_in_same_order_as_mapped_to_them.txt"
for f in $subject_files
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  printf "$sampleID\n" > "${outdir}/${sampleID}_temp_contigs_lib_contig_size_adjusted.tsv"
  awk -F "\t" '{print $2}' "$f" >> "${outdir}/${sampleID}_temp_contigs_lib_contig_size_adjusted.tsv"
  printf "Done with file:\t$f\n"
done
paste -d "\t" "$list_file" *_temp_contigs_lib_contig_size_adjusted.tsv > 2022-07-01_all_subsampled_contig_level_library_and_contig_size_adjusted_mapped_segment_counts.tsv
rm *_temp_contigs_lib_contig_size_adjusted.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Assembly_output/Polecat_R0786-S0016_VWT860_A64354

while read -r line
do
  contig_name="$line"
  cat placeholder_rscript_contig_level_kilobase_and_lib_size_adjusted_not_log1p_transformed.txt | sed "s/PLACEHOLDER/$contig_name/g"
done < 2022-06-28_list_all_contigs_in_same_order_as_mapped_to_them.txt > 2022-07-01_kruskal_wallis_R_script_contig_and_library_size_adjusted_not_transformed_contig_level_mapping_counts.R

2022-07-04
target_files=$(find -maxdepth 1 -type f -name "*contigs.fasta.Contigs_min_length_500bp.fa" -not -name "S12*")
for f in $target_files
do
  sample_ID=$(basename "$f" | awk -F "-contigs" '{print $1}')
  cat "$f" | sed "s/^>/>$sample_ID-/g" > "${sample_ID}.labelled_temp.fa"
done
sleep 3s
awk 1 *.labelled_temp.fa > "2022-04-07_all_isolate_assemblies_contigs_under_500bp_removed.fa"
rm *.labelled_temp.fa

sbatch /hpc-home/osbourne/2022_03_16-Paper_3-Chapter_4_scripts/2022-07-04_Minimap2_Bins_mapping_to_isolates.sh Bin_m522.fa

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files

target_files=$(find -maxdepth 1 -type f -name "Bin_m5*" -printf "%f\n")
for f in $target_files
do
  sbatch /hpc-home/osbourne/2022_03_16-Paper_3-Chapter_4_scripts/2022-07-04_Minimap2_Bins_mapping_to_isolates.sh "$f"
  printf "Submitted job on file:\t$f\n"
  sleep 5s
done

2022-07-05
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/bwa_accessory_files
sbatch /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/temp_scripts_dir/2022-07-04_BWA_mem_Bins_mapping_to_isolates.sh Bin_c1158.fa

PLACEHOLDER_foldchange_rscript.txt
temp_bins_list.txt
while read -r line
do
  bin_name="$line"
  cat PLACEHOLDER_foldchange_rscript.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-07-06_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_foldchange_and_negative_log10_pvalues_rscript.R

2022-07-06
nano PLACEHOLDER_medians_foldchange_rscript.txt
while read -r line
do
  bin_name="$line"
  cat PLACEHOLDER_medians_foldchange_rscript.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-07-06_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_logfoldchange_of_median_values_and_negative_log10_pvalues_rscript.R

printf "rm(list=ls(pattern='Bin_m*'))\nrm(list=ls(pattern='Bin_c*'))\n" >> 2022-07-06_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_logfoldchange_of_median_values_and_negative_log10_pvalues_rscript.R

while read -r line
do
  bin_name="$line"
  cat PLACEHOLDER_geometric_means_foldchange_rscript.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-07-06_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_logfoldchange_of_geometric_mean_values_and_negative_log10_pvalues_rscript.R
printf "rm(list=ls(pattern='Bin_m*'))\nrm(list=ls(pattern='Bin_c*'))\n" >> 2022-07-06_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_logfoldchange_of_geometric_mean_values_and_negative_log10_pvalues_rscript.R

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes

sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R2.fastq
sbatch 2022-06-24_RS_trial_workflow_capybara_version.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852046_1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852046_2.fastq

2022-07-07
48675212
https://ftp.ncbi.nlm.nih.gov/genomes/refseq/plant/Fragaria_vesca/representative/GCF_000184155.1_FraVesHawaii_1.0/GCF_000184155.1_FraVesHawaii_1.0_genomic.fna.gz
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes

sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R2.fastq
sleep 5s
sbatch 2022-06-24_RS_trial_workflow_capybara_version.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852046_1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852046_2.fastq
sleep 5s
sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R2.fastq
sleep 5s
sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R2.fastq

./*/*/*-Megahit_assembly.fa
gzip ./*/*/*-Megahit_assembly.fa
/hpc-home/osbourne/2022-07-07_project__scratch_dir_memory_usage.txt

while read -r line
do
  bin_name="$line"
  cat PLACEHOLDER_manual_logfoldchange_means_rscript.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-07-07_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_manual_logfoldchange_mean_values_and_negative_log10_pvalues_rscript.R
printf "rm(list=ls(pattern='Bin_m*'))\nrm(list=ls(pattern='Bin_c*'))\n" >> 2022-07-07_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_manual_logfoldchange_mean_values_and_negative_log10_pvalues_rscript.R

while read -r line
do
  bin_name="$line"
  cat PLACEHOLDER_log1p_combined_script_arithmetic_geometric_means_and_median.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-07-07_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_manual_log1pfoldchange_arithemetic_and_geometric_mean_values_and_median_and_negative_log10_pvalues_rscript.R
printf "rm(list=ls(pattern='Bin_m*'))\nrm(list=ls(pattern='Bin_c*'))\n" >> 2022-07-07_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_manual_log1pfoldchange_arithemetic_and_geometric_mean_values_and_median_and_negative_log10_pvalues_rscript.R

#Season bins, geometric means, -log10p BH pvalue over -log10(0.05) and log1pfold effect over 1 or below -1
Bin_m1474 - d__Bacteria;p__Bacteroidota;c__Bacteroidia;o__Bacteroidales;f__Rikenellaceae;g__Rikenella;s__
Bin_m1569 - d__Bacteria;p__Actinobacteriota;c__Actinomycetia;o__Actinomycetales;f__Bifidobacteriaceae;g__Bifidobacterium;s__

#Host bins, geometric means, -log10p BH pvalue over -log10(0.05) and log1pfold effect over 1
Bin_c745 - d__Bacteria;p__Bacteroidota;c__Bacteroidia;o__Bacteroidales;f__Muribaculaceae;g__CAG-485;s__
Bin_c1000 - d__Bacteria;p__Firmicutes_A;c__Clostridia;o__Oscillospirales;f__Acutalibacteraceae;g__Eubacterium_R;s__
Bin_c1199 - d__Bacteria;p__Bacteroidota;c__Bacteroidia;o__Bacteroidales;f__Muribaculaceae;g__CAG-485;s__
Bin_c1500 - d__Bacteria;p__Bacteroidota;c__Bacteroidia;o__Bacteroidales;f__Muribaculaceae;g__CAG-873;s__
Bin_c1673 - d__Bacteria;p__Bacteroidota;c__Bacteroidia;o__Bacteroidales;f__Muribaculaceae;g__Paramuribaculum;s__
Bin_c1687 - d__Bacteria;p__Bacteroidota;c__Bacteroidia;o__Bacteroidales;f__Muribaculaceae;g__CAG-485;s__
Bin_m522 - d__Bacteria;p__Bacteroidota;c__Bacteroidia;o__Bacteroidales;f__Muribaculaceae;g__Paramuribaculum;s__
Bin_m1066 - d__Bacteria;p__Firmicutes_A;c__Clostridia;o__Oscillospirales;f__Ruminococcaceae;g__Ruminiclostridium_E;s__
Bin_m1648 - d__Bacteria;p__Firmicutes_A;c__Clostridia;o__Oscillospirales;f__Ruminococcaceae;g__;s__

#Host bins, geometric means, -log10p BH pvalue over -log10(0.05) and log1pfold effect below -1
Bin_c892 - d__Bacteria;p__Firmicutes_A;c__Clostridia;o__Lachnospirales;f__Lachnospiraceae;g__CAG-95;s_
Bin_m1093 - d__Bacteria;p__Campylobacterota;c__Campylobacteria;o__Campylobacterales;f__Helicobacteraceae;g__Helicobacter_C;s__
Bin_m1122 - d__Bacteria;p__Firmicutes;c__Bacilli;o__Lactobacillales;f__Lactobacillaceae;g__Lactobacillus;s__

while read -r line
do
  bin="$line"
  binID=$(grep -w "$bin" gtdbtk.bac120.summary.tsv | awk -F "\t" '{print $2}')
  printf "$bin - $binID\n"
done < 2022-07-07-TEMP_list_bins_host_significant_and_bigish_fold_change.txt

FileNotFoundError: [Errno 2] No such file or directory: '/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/QC_and_cleansed_files/SRR11852046_1.fastq__QC_and_cleanse_file_outputs/Capybara_SRR11852046_R1.QCed.Cleansed.fastq'
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/QC_and_cleansed_files/SRR11852046_1.fastq__QC_and_cleanse_file_outputs/Capybara_SRR11852046_R1.QCed.Cleansed.fastq
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/QC_and_cleansed_files/SRR11852046_1.fastq__QC_and_cleanse_file_outputs/Capybara_SRR11852046_R2.QCed.Cleansed.fastq


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/QC_and_cleansed_files/SRR11852046_1.fastq__QC_and_cleanse_file_outputs/Capybara_SRR11852046_R1.QCed.Cleansed.fastq
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/QC_and_cleansed_files/SRR11852046_1.fastq__QC_and_cleanse_file_outputs/Capybara_SRR11852046_1.fastq__R1.QCed.Cleansed.fastq

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch
gzip ./2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/fastp_outputs/*.fq

2022-07-08
while read -r line
do
  bin_name="$line"
  cat PLACEHOLDER_log2_add_one_combined_script_arithmetic_geometric_means_and_median.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-07-08_all_subsampled_read_files_mapping_strict_bins_contig_and_lib_size_adjusted_manual_log2_add_one_fold_change_arithemetic_and_geometric_mean_values_and_median_and_negative_log10_pvalues_rscript.R

while read -r line
do
  bin="$line"
  binID=$(grep -w "$bin" gtdbtk.bac120.summary.tsv | awk -F "\t" '{print $2}')
  printf "$bin - $binID\n"
done < 2022-07-08-TEMP_list_bins_host_significant_and_bigish_fold_change.txt

BootStrap: docker
From: nanozoo/maxbin2:latest

sudo singularity build 2022-07-08_MaxBin2_from_Nanozoo_dockerhub.img 2022-07-08_Nanozoo_dockerhub_MaxBin2.def

2022-07-08_pegi3s_dockerhub_MaxBin2.def
BootStrap: docker
From: pegi3s/maxbin2:latest

sudo singularity build 2022-07-08_MaxBin2_from_pegi3s_dockerhub.img 2022-07-08_pegi3s_dockerhub_MaxBin2.def

2022-07-09
sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0016_VWT860_A64354_1_HY5VJDSX2_CTTCGTTCT-CTTCGTTCT_L003_R2.fastq
sleep 5s
sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R2.fastq
sleep 5s
sbatch 2022-06-24_RS_trial_workflow.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0013_VWT770_A64351_1_HY5VJDSX2_ACCGGTAGT-ACCGGTAGT_L003_R2.fastq
sleep 5s
sbatch 2022-06-24_RS_trial_workflow_capybara_version.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852046_1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852046_2.fastq
sleep 5s
sbatch 2022-06-24_RS_trial_workflow_capybara_version.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852052_1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852052_2.fastq
sleep 5s
sbatch 2022-06-24_RS_trial_workflow_capybara_version.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852083_1.fastq /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/SRR11852083_2.fastq

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files

mkdir /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Just_cultures_and_references

echo "1 2 3 4 5 6 7 8 9 10" | xargs shuf -n1 -e
echo "1 2 3 4 5 6 7 8 9 10" | xargs shuf -n3 -e
echo "1 2 3 4 5 6 7 8 9 10" | xargs shuf -n3

find -maxdepth 1 -type f -name "*.fa" -not -name "*Bin*" -not -name "S12*" -not -name "*careful*" | wc -l
631
find -maxdepth 1 -type f -name "*.fa" -not -name "*Bin*" -not -name "S12*" -not -name "*careful*" | xargs shuf -n100 -e >> TEMP_selected_files_list.txt

while read -r line
do
  fasta_file="$line"
  cp "$line" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes
  printf "Copied file:\t$fasta_file\n"
done < TEMP_selected_files_list.txt
sleep 5s
rm TEMP_selected_files_list.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Chris_and_Seb_bins_fasta_files/CheckM_output

2022-07-10
while read -r line
do
  bin_name="$line"
  contamination=$(grep -w "$bin_name" 2022-04-10_all_bins_CheckM_results_without_header.tsv | awk -F "\t" '{print $13}')
  completeness=$(grep -w "$bin_name" 2022-04-10_all_bins_CheckM_results_without_header.tsv | awk -F "\t" '{print $12}')
  printf "$bin_name\t$completeness\t$contamination\n"
done < 2022-07-10_temp_bin_list.txt

if [ -s SRR11852083_Contigs_500bp.single_line.fa ]
then
  echo "File is not empty"
else
  echo "File is empty"
fi

if [ -s warnings.log ]
then
  echo "File is not empty"
else
  echo "File is empty"
fi

2022-07-11
while read -r line
do
  bin="$line"
  binID=$(grep -w "$bin" gtdbtk.bac120.summary.tsv | awk -F "\t" '{print $2}')
  printf "$bin - $binID\n"
done < temp_bins_list.txt

while read -r line
do
  bin="$line"
  binID=$(grep -w "$bin" gtdbtk.bac120.summary.tsv | awk -F "\t" '{print $2}')
  printf "$bin\t$binID\n"
done < /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/2022-04-16_list_of_just_bin_names.txt

2022-07-12
source package 4b6bf359-4248-4ed8-b256-c511a7134dcd #ETE-Toolkit 3.1.2

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fastani_output
for f in *FastANI_matches_over_99_percent.txt ; do cat "$f" | sed "s/$/\n/g" ; done | grep -v 'concatenated'

2022-07-13
while read -r line
do
  bin_name="$line"
  cat PLACEHOLDER_geometric_mean_mappings_BH_corrected_pvalues_log2_plus_one_fold_changes_GTDB_TK_taxonomy_all_combined_output_R_script.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-07-08_geometric_mean_mappings_BH_corrected_pvalues_log2_plus_one_fold_changes_GTDB_TK_taxonomy_all_combined_output_R_script.R

PLACEHOLDER_geometric_mean_mappings_BH_corrected_pvalues_log2_plus_one_fold_changes_GTDB_TK_taxonomy_all_combined_output_R_script.txt

2022-07-14
while read -r line
do
  bin_name=$(printf "$line" | awk -F "\t" '{print $1}')
  bin_gtdbtk_family=$(printf "$line" | awk -F "\t" '{print $2}' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}')
  bin_gtdbtk_genus=$(printf "$line" | awk -F "\t" '{print $2}' | awk -F ";g__" '{print $2}' | awk -F ";s__" '{print $1}' | awk 'NF')
  if [[ -z "$bin_gtdbtk_genus" ]]
  then
    printf "$bin_name\tFamily_$bin_gtdbtk_family\n"
  elif ! [[ -z "$bin_gtdbtk_genus" ]]
  then
    printf "$bin_name\tGenus_$bin_gtdbtk_genus\n"
  fi
done < 2022-07-11_all_strict_bins_and_GTDB-TK_taxonomy.txt > 2022-07-14_all_strict_bins_and_either_family_or_genus_if_classified_by_GTDB-TK.tsv

while read -r line
do
  bin_name=$(printf "$line" | awk -F "\t" '{print $1}')
  bin_classification=$(printf "$line" | awk -F "\t" '{print $2}')
  sed -i -e "s/$bin_name/${bin_classification}-${bin_name}/g" editable_tree_all_strict_bins_some_references.nwk
  printf "Converted $bin_name to ${bin_classification}-${bin_name}\n"
done < 2022-07-14_all_strict_bins_and_either_family_or_genus_if_classified_by_GTDB-TK.tsv

cp 11_Jul_2022-5WVSw49utZwD70mi.nwk editable_tree_all_strict_bins_some_references.nwk

editable_tree_all_strict_bins_some_references.nwk
cp editable_tree_all_strict_bins_some_references.nwk 2022-07-14_strict_bins_family_or_genus_GTDB-TK_classification_and_100_reference_genomes_JolyTree_tree.nwk

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/GTDB-TK_outputs/classify_wf/classify

while read -r line
do
  bin_name=$(printf "$line" | awk -F "\t" '{print $1}')
  bin_full_tax=$(grep -w "$bin_name" gtdbtk.bac120.summary.tsv | awk -F "\t" '{print $2}')
  bin_gtdbtk_family=$(printf "$bin_full_tax" | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}')
  bin_gtdbtk_genus=$(printf "$bin_full_tax" | awk -F ";g__" '{print $2}' | awk -F ";s__" '{print $1}')
  if [[ -z "$bin_gtdbtk_genus" ]]
  then
    printf "${bin_name}\t${bin_full_tax}\tFamily_${bin_gtdbtk_family}\n"
  elif ! [[ -z "$bin_gtdbtk_genus" ]]
  then
    printf "${bin_name}\t${bin_full_tax}\tGenus_${bin_gtdbtk_genus}\n"
  fi
done < strict_bins.txt | sort -V -k1 > /hpc-home/osbourne/2022-07-14_all_strict_bins_GTDB-TK_full_taxonomy_and_ACTUAL_family_or_genus.tsv

details_file="2022-07-13_geometric_means_all_values_different_things_and_taxID.tsv"
while read -r line
do
  bin_name=$(printf "$line" | awk -F "\t" '{print $1}')
  bin_full_tax=$(printf "$line" | awk -F "\t" '{print $2}')
  bin_short_tax=$(printf "$line" | awk -F "\t" '{print $3}')
  bin_AC_mean=$(awk -F "\t" -v target="$bin_name" '$1 == target {print $2}' "$details_file")
  bin_AR_mean=$(awk -F "\t" -v target="$bin_name" '$1 == target {print $3}' "$details_file")
  AC_AR_BH=$(awk -F "\t" -v target="$bin_name" '$1 == target {print $4}' "$details_file")
  AC_AR_log2=$(awk -F "\t" -v target="$bin_name" '$1 == target {print $5}' "$details_file")
  J_mean=$(awk -F "\t" -v target="$bin_name" '$1 == target {print $6}' "$details_file")
  N_mean=$(awk -F "\t" -v target="$bin_name" '$1 == target {print $7}' "$details_file")
  J_N_BH=$(awk -F "\t" -v target="$bin_name" '$1 == target {print $8}' "$details_file")
  J_N_log2=$(awk -F "\t" -v target="$bin_name" '$1 == target {print $9}' "$details_file")
  printf "$bin_name\t$bin_AC_mean\t$bin_AR_mean\t$AC_AR_BH\t$AC_AR_log2\t$J_mean\t$N_mean\t$J_N_BH\t$J_N_log2\t$bin_short_tax\t$bin_full_tax\tEND OF LINE\n"
done < 2022-07-14_all_strict_bins_GTDB-TK_full_taxonomy_and_ACTUAL_family_or_genus.tsv

2022-07-15
11_Jul_2022-5WVSw49utZwD70mi.nwk
nano AC_enriched_significant_bins_list.txt
nano AR_enriched_significant_bins_list.txt
nano Nov_enriched_significant_bins_list.txt

cp 11_Jul_2022-5WVSw49utZwD70mi.nwk editable_tree.nwk

while read -r line
do
  bin_name="$line"
  bin_short_taxa=$(awk -F "\t" -v bin_name="$bin_name" '$1 == bin_name {print $11}' 2022-07-14_geometric_means_all_values_different_things_and_taxID.tsv | tr -d '""')
  sed -i -e "s/${bin_name}/Cahirinus_enriched_${bin_short_taxa}_${bin_name}/g" editable_tree.nwk
done < AC_enriched_significant_bins_list.txt

while read -r line
do
  bin_name="$line"
  bin_short_taxa=$(awk -F "\t" -v bin_name="$bin_name" '$1 == bin_name {print $11}' 2022-07-14_geometric_means_all_values_different_things_and_taxID.tsv | tr -d '""')
  sed -i -e "s/${bin_name}/Russatus_enriched_${bin_short_taxa}_${bin_name}/g" editable_tree.nwk
done < AR_enriched_significant_bins_list.txt

while read -r line
do
  bin_name="$line"
  bin_short_taxa=$(awk -F "\t" -v bin_name="$bin_name" '$1 == bin_name {print $11}' 2022-07-14_geometric_means_all_values_different_things_and_taxID.tsv | tr -d '""')
  sed -i -e "s/${bin_name}/November_enriched_${bin_short_taxa}_${bin_name}/g" editable_tree.nwk
done < Nov_enriched_significant_bins_list.txt

2022-07-15_modified_names
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/GTDB-TK_outputs/classify_wf/classify

cp AC_enriched_significant_bins_list.txt /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/
cp AR_enriched_significant_bins_list.txt /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/
cp Nov_enriched_significant_bins_list.txt /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs
*_simple_counts_unique_products.tsv
2022-07-15_list_all_potential_products.txt

while read -r line
do
  subj_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs"
  bin_name="$line"
  bin_file="${subj_dir}/${bin_name}_simple_counts_unique_products.tsv"
  cat "$bin_file" | awk -F "\t" '{print $2}' > "${bin_name}_Nov_temp.txt"
done < Nov_enriched_significant_bins_list.txt
paste -d "\t" "${subj_dir}/2022-07-15_list_all_potential_products.txt" *_Nov_temp.txt > 2022-07-15_all_November_significant_and_meaningful_bins_unique_potential_products_count.tsv
rm *_Nov_temp.txt

while read -r line
do
  subj_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs"
  bin_name="$line"
  bin_file="${subj_dir}/${bin_name}_simple_counts_unique_products.tsv"
  cat "$bin_file" | awk -F "\t" '{print $2}' > "${bin_name}_AC_temp.txt"
done < AC_enriched_significant_bins_list.txt
paste -d "\t" "${subj_dir}/2022-07-15_list_all_potential_products.txt" *_AC_temp.txt > 2022-07-15_all_Acomys_cahirinus_significant_and_meaningful_bins_unique_potential_products_count.tsv
rm *_AC_temp.txt

while read -r line
do
  subj_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs"
  bin_name="$line"
  bin_file="${subj_dir}/${bin_name}_simple_counts_unique_products.tsv"
  cat "$bin_file" | awk -F "\t" '{print $2}' > "${bin_name}_AR_temp.txt"
done < AR_enriched_significant_bins_list.txt
paste -d "\t" "${subj_dir}/2022-07-15_list_all_potential_products.txt" *_AR_temp.txt > 2022-07-15_all_Acomys_russatus_significant_and_meaningful_bins_unique_potential_products_count.tsv
rm *_AR_temp.txt

mail -s '2022-07-15_all_Acomys_russatus_significant_and_meaningful_bins_unique_potential_products_count' -a 2022-07-15_all_Acomys_russatus_significant_and_meaningful_bins_unique_potential_products_count.tsv peter.osborne@earlham.ac.uk <<< "File 2022-07-15_all_Acomys_russatus_significant_and_meaningful_bins_unique_potential_products_count.tsv should be attached"

/ei/software/testing/kraken/Ferr_Pol_2022-07-15

2022-07-16
nano array_test.txt
mapfile -t test_array < array_test.txt
echo "${#test_array[@]}"
printf "${test_array[*]}\n"

mapfile -t trial_array < tester.txt
printf "${trial_array[*]}\n" | tr " " ","

source package 7d170f8e-6196-4ce5-81e9-a9800ab05137
fastANI -q Bin_m419.fa -r Bin_m959.fa -o Bin_m419_and_Bin_m959_fastANI_output.txt -t 2

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting

https://hub.docker.com/r/cabanaonline/enveomics/tags
https://github.com/Ecogenomics/GTDBTk

2022-07-18
source package /tgac/software/testing/bin/emboss-6.6.0
needle -asequence Bin_m419.fna -bsequence Bin_m959.fna -brief Y -outfile Bin_m419_and_Bin_m959_NEEDLE_align

while read -r line
do
  bin_name="$line"
  cat 2022-07-18_Kruskal_test_PLACEHOLDER_r_script.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-07-18_kruskal_tests_only_novogene_paired_samples_summed_to_bins_contig_and_library_size_adjusted_R_script.R

while read -r line
do
  bin_name="$line"
  cat 2022-07-18_only_novogene_paired_samples_species_and_season_detailed_table_maker_corrected_pvalues_fold_change_PLACEHOLDER.txt | sed "s/PLACEHOLDER/$bin_name/g"
done < temp_bins_list.txt > 2022-07-18_only_novogene_paired_samples_species_and_season_detailed_table_maker_corrected_pvalues_fold_change_R_script.R

while read -r line ; do bin_name="$line" && awk -F "\t" -v binid="$bin_name" '$1 == binid {print $2}' gtdbtk.bac120.summary.tsv ; done < strict_bins.txt | sort -V | uniq | awk -F ";o__" '{print $2}' | awk -F ";f__" '{print $1}' | uniq | wc -l
while read -r line ; do bin_name="$line" && awk -F "\t" -v binid="$bin_name" '$1 == binid {print $2}' gtdbtk.bac120.summary.tsv ; done < strict_bins.txt | sort -V | uniq | awk -F ";g__" '{print $2}' | awk -F ";s__" '{print $1}' | uniq | wc -l
d__Bacteria;p__Firmicutes_A;c__Clostridia;o__Oscillospirales;f__CAG-272;g__UMGS1312;s__

while read -r line
do
  bin_id=$(printf "$line" | awk -F "\t" '{print $1}')
  bin_taxa=$(printf "$line" | awk -F "\t" '{print $3}')
  sed -i -e "s/${bin_id}/${bin_id}_${bin_taxa}/g" editable_tree_all_strict_bins_some_references.nwk
done < 2022-07-14_all_strict_bins_GTDB-TK_full_taxonomy_and_ACTUAL_family_or_genus.tsv

2022-07-19
2022-07-19_species_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv

cat 2022-07-19_species_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}'

cat 2022-07-19_species_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | uniq | wc -l

awk -F "\t" '$5 > 1 {print $0}' 2022-07-19_species_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | uniq | wc -l
awk -F "\t" '$5 < -1 {print $0}' 2022-07-19_species_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | uniq | wc -l
awk -F "\t" '$5 > 1 {print $0}' 2022-07-19_season_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | uniq | wc -l

awk -F "\t" '$5 > 1 {print $0}' 2022-07-19_species_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | uniq > AR_increased_families.txt
awk -F "\t" '$5 < -1 {print $0}' 2022-07-19_species_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | uniq > AC_increased_families.txt
awk -F "\t" '$9 > 1 {print $0}' 2022-07-19_season_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | uniq > Nov_increased_families.txt

while read -r line
do
  taxon="$line"
  occurrence=$(awk -F "\t" '$5 > 1 {print $0}' 2022-07-19_species_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | grep -c "$taxon")
  printf "$taxon\t$occurrence\n"
done < AR_increased_families.txt
while read -r line
do
  taxon="$line"
  occurrence=$(awk -F "\t" '$5 < -1 {print $0}' 2022-07-19_species_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | grep -c "$taxon")
  printf "$taxon\t$occurrence\n"
done < AC_increased_families.txt
while read -r line
do
  taxon="$line"
  occurrence=$(awk -F "\t" '$9 > 1 {print $0}' 2022-07-19_season_effect_bins_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | awk -F "\t" '{print $10}' | grep -v 'Taxonomy' | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | sort -V | grep -c "$taxon")
  printf "$taxon\t$occurrence\n"
done < Nov_increased_families.txt

Bin_c302-Kaiju2table_1_errors_allowed-family_level_results.tsv

for f in *-Kaiju2table_1_errors_allowed-family_level_results.tsv
do
  nome=$(basename "$f" | awk -F "-" '{print $1}')
  most_common_family=$(head -2 "${nome}-Kaiju2table_1_errors_allowed-family_level_results.tsv" | tail -1 | awk -F "\t" '{print $2"\t"$5}')
  printf "$nome\t$most_common_family\n"
done | sort -V -k1 > 2022-07-19_all_bins_most_common_family_and_percent_reads_classified.tsv

while read -r line
do
  bin="$line"
  kaiju_results=$(awk -F "\t" -v binID="$bin" '$1 == binID {print $0}' 2022-07-19_all_bins_most_common_family_and_percent_reads_classified.tsv)
  printf "$kaiju_results\n"
done < /hpc-home/osbourne/2022-07-19_list_bins_AC_increased_significant_and_fold_change_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | grep -v "name" | awk 'NF' > 2022-07-19_AC_up_bins_Kaiju_family_most_common_classification_only_paired_novogene_summed_to_bin_contig_and_lib_size_adjusted_strict_bins.tsv

while read -r line
do
  bin="$line"
  kaiju_results=$(awk -F "\t" -v binID="$bin" '$1 == binID {print $0}' 2022-07-19_all_bins_most_common_family_and_percent_reads_classified.tsv)
  printf "$kaiju_results\n"
done < /hpc-home/osbourne/2022-07-19_list_bins_AR_increased_significant_and_fold_change_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | grep -v "name" | awk 'NF' > 2022-07-19_AR_up_bins_Kaiju_family_most_common_classification_only_paired_novogene_summed_to_bin_contig_and_lib_size_adjusted_strict_bins.tsv

while read -r line
do
  bin="$line"
  kaiju_results=$(awk -F "\t" -v binID="$bin" '$1 == binID {print $0}' 2022-07-19_all_bins_most_common_family_and_percent_reads_classified.tsv)
  printf "$kaiju_results\n"
done < /hpc-home/osbourne/2022-07-19_list_bins_November_increased_significant_and_fold_change_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv | grep -v "name" | awk 'NF' > 2022-07-19_November_up_bins_Kaiju_family_most_common_classification_only_paired_novogene_summed_to_bin_contig_and_lib_size_adjusted_strict_bins.tsv


while read -r line
do
  subj_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs"
  bin_name="$line"
  bin_file="${subj_dir}/${bin_name}_simple_counts_unique_products.tsv"
  cat "$bin_file" | awk -F "\t" '{print $2}' > "${bin_name}_Nov_temp.txt"
done < /hpc-home/osbourne/2022-07-19_list_bins_November_increased_significant_and_fold_change_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv
paste -d "\t" "${subj_dir}/2022-07-15_list_all_potential_products.txt" *_Nov_temp.txt > 2022-07-19_all_November_significant_and_meaningful_bins_unique_potential_products_count.tsv
rm *_Nov_temp.txt

while read -r line
do
  subj_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs"
  bin_name="$line"
  bin_file="${subj_dir}/${bin_name}_simple_counts_unique_products.tsv"
  cat "$bin_file" | awk -F "\t" '{print $2}' > "${bin_name}_AC_temp.txt"
done < /hpc-home/osbourne/2022-07-19_list_bins_AC_increased_significant_and_fold_change_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv
paste -d "\t" "${subj_dir}/2022-07-15_list_all_potential_products.txt" *_AC_temp.txt > 2022-07-19_all_AC_significant_and_meaningful_bins_unique_potential_products_count.tsv
rm *_AC_temp.txt

while read -r line
do
  subj_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs"
  bin_name="$line"
  bin_file="${subj_dir}/${bin_name}_simple_counts_unique_products.tsv"
  cat "$bin_file" | awk -F "\t" '{print $2}' > "${bin_name}_AR_temp.txt"
done < /hpc-home/osbourne/2022-07-19_list_bins_AR_increased_significant_and_fold_change_only_paired_novogene_summed_bins_library_and_contig_adjusted_geometric_means_all_values_different_things_and_taxID.tsv
paste -d "\t" "${subj_dir}/2022-07-15_list_all_potential_products.txt" *_AR_temp.txt > 2022-07-19_all_AR_significant_and_meaningful_bins_unique_potential_products_count.tsv
rm *_AR_temp.txt

for f  in *_just_counts_in_order.txt
do
  sample=$(basename "$f" | awk -F "_" '{print $1}')
  mapping=$(cat "$f" | grep -v "A" | paste -sd + | bc -l)
  printf "$sample\t$mapping\n"
done | sort -V -k2

*_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.Only_reads.IDX_stats.txt

targets=$(find -maxdepth 2 -type f -name "*_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.Only_reads.IDX_stats.txt")
for f in $targets
do
  bin_name=$(basename "$f" | awk -F "_" '{print $1}')
  mapping=$(awk -F "\t" '{print $3}' "$f" | paste -sd + | bc -l)
  printf "${bin_name}\t${mapping}\n"
done | sort -V -k1

samtools view -c -F 260 AC14N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam.gz

bamtools filter -in AC14N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam -out bamtools_test.bam -tag "NH:>1"

samtools view -bq 1 AC14N_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam > unique.bam

samtools index -@ 2 -b unique.bam
samtools idxstats unique.bam

awk '{s++}END{print s/4}' AC14N.QCed.Cleansed.Subsampled.R1.fq

back_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins"
target_dirs=$(find -maxdepth 1 -type d -name "A*")
for d in $target_dirs
do
  go_to="$d"
  cd "$go_to"
  object_file=$(find -maxdepth 1 -type f -name "*_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam")
  for f in $object_file
  do
    sampleID=$(basename "$f" | awk -F "_" '{print $1}')
    samtools view -@ 2 -b -F 256 -F 272 -F 2048 -F 2064 "$f" > "${sampleID}_2022-07-18_only_unique_mappings_sorted.bam"
    samtools index -@ 2 "${sampleID}_2022-07-18_only_unique_mappings_sorted.bam"
    samtools idxstats "${sampleID}_2022-07-18_only_unique_mappings_sorted.bam" > temp.tsv
    head -n -1 temp.tsv > "${sampleID}_2022-07-18_only_unique_mappings_sorted.IDXstats.tsv"
    printf "Processed file:\t$f\n"
  done
  cd "$back_dir"
done

find -maxdepth 1 -type d -name "A*" | while read dir ; do
  cd "$dir"
  object_file=$(find -maxdepth 1 -type f -name "*_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam")
  for f in $object_file
  do
    sampleID=$(basename "$f" | awk -F "_" '{print $1}')
    samtools view -@ 2 -b -F 256 -F 272 -F 2048 -F 2064 "$f" > "${sampleID}_2022-07-18_only_unique_mappings_sorted.bam"
    samtools index -@ 2 "${sampleID}_2022-07-18_only_unique_mappings_sorted.bam"
    samtools idxstats "${sampleID}_2022-07-18_only_unique_mappings_sorted.bam" > "${sampleID}_temp.tsv"
    head -n -1 temp.tsv > "${sampleID}_2022-07-18_only_unique_mappings_sorted.IDXstats.tsv"
    printf "Processed file:\t$f\n"
    rm "${sampleID}_temp.tsv"
  done
  cd "$back_dir"
done

find ~+ -maxdepth 1 -type d -name "A*" > 2022-07-19_list_output_directories_to_work_in.txt

while read -r line
do
  target_dir="$line"
  cd "$target_dir"
  object_file=$(find -maxdepth 1 -type f -name "*_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam")
  for f in $object_file
  do
    sampleID=$(basename "$f" | awk -F "_" '{print $1}')
    samtools view -@ 2 -b -F 256 -F 272 -F 2048 -F 2064 "$f" > "${sampleID}_2022-07-18_only_unique_mappings_sorted.bam"
    samtools index -@ 2 "${sampleID}_2022-07-18_only_unique_mappings_sorted.bam"
    samtools idxstats "${sampleID}_2022-07-18_only_unique_mappings_sorted.bam" > "${sampleID}_temp.tsv"
    head -n -1 "${sampleID}_temp.tsv" > "${sampleID}_2022-07-18_only_unique_mappings_sorted.IDXstats.tsv"
    printf "Processed file:\t$f\n"
    rm "${sampleID}_temp.tsv"
  done
  cd "$"
done < 2022-07-19_list_output_directories_to_work_in.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/

2022-07-20

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR30J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR41N
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC7N
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC18N
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC5J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR9N
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR27J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC33J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR46J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR24J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR9J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC4J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR1J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC25J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC22J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR43J
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC44N
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AC19N

targets=$(find -maxdepth 2 -type f -name "*_2022-07-18_only_unique_mappings_sorted.IDXstats.tsv")
for f in $targets
do
  bin_name=$(basename "$f" | awk -F "_" '{print $1}')
  mapping=$(awk -F "\t" '{print $3}' "$f" | paste -sd + | bc -l)
  printf "${bin_name}\t${mapping}\n"
done | sort -V -k1

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins
2022-06-28_list_all_contigs_in_same_order_as_mapped_to_them.txt

2022-07-21
https://scilifelab.figshare.com/ndownloader/articles/16677252/versions/1

AR3N.Library_and_contig_size_adjusted_counts.Unique_mappings_only.Strict_bins_only.tsv

AC36N-2022-07-21_kilobase_and_library_size_adjusted_per_GOOD_bin_summed_UNIQUE_mapping_scores.Just_scores_in_same_order.tsv.Original


targets=$(find -maxdepth 1 -type f -name "*Library_and_contig_size_adjusted_counts.Unique_mappings_only.Strict_bins_only.tsv")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  ls -lhtr *Original | grep "$sampleID" || printf "Missing files for:\t$sampleID\n"
done
Submitted batch job 49097016
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins

2022-07-25
source package /tgac/software/testing/bin/salmon-0.14.1
salmon index -t 2022-04-14_concatenated_low_contamination_high_completeness_bins.fa -i 2022-04-14_concatenated_low_contamination_high_completeness_bins.Salmon_index -k 31

2022-07-26
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR9J/AR9J_BWA_against_concatenated_GOOD_bins.Mapped.Sorted.bam.gz

sbatch 2022-07-26_Salmon_quantify_BAM_sorted_not_just_unique_mappings_subsampled_reads_to_concatenated_strict_bins.sh /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_processed_samples_to_only_good_bins/AR9J/AR9J_BWA_against_concatenated_GOOD_bins.Mapped.bam.gz AR9J

*BWA_against_concatenated_GOOD_bins.Mapped.bam.gz
find -maxdepth 2 -type f -name "*BWA_against_concatenated_GOOD_bins.Mapped.bam.gz" -printf "%f\n" | sort -V > "${inpdir}/2022-07-21_list_adjusted_unique_mappings_counts_files.txt"

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

find -maxdepth 2 -type f -name "*BWA_against_concatenated_GOOD_bins.Mapped.bam.gz" -printf "%f\n" -exec readlink -f {} \; | sort -V

2022-07-28
k141_14434205
grep 'k141_14434205' ./*/*.gff
AC25J_Salmon_quantification_unsorted_all_reads_including_multiple_mapping.sf
awk -F "\t" '{print $1}' ./AC25J_Salmon_quantification/AC25J_Salmon_quantification_unsorted_all_reads_including_multiple_mapping.sf > 2022-07-28_list_contigs_in_same_order.txt
targets=$(find -maxdepth 2 -type f -name "*_Salmon_quantification_unsorted_all_reads_including_multiple_mapping.sf")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  printf "$sampleID\n" > "${sampleID}_just_TPM_counts.txt"
  awk -F "\t" '{print $4}' "$f" > "${sampleID}_just_TPM_counts_TEMP.txt"
  tail -n +2 "${sampleID}_just_TPM_counts_TEMP.txt" >> "${sampleID}_just_TPM_counts.txt"
  rm "${sampleID}_just_TPM_counts_TEMP.txt"
done
paste -d "\t" 2022-07-28_list_contigs_in_same_order.txt *_just_TPM_counts.txt > 2022_07_28-all_subsampled_files_Salmon_TPM_gc_and_seq_bias_correction.tsv
rm *_just_TPM_counts.txt

2022-07-29
2022-07-28_all_subsampled_files_Salmon_TPM_gc_and_seq_bias_correction.tsv
/hpc-home/osbourne
2022-07-28_melted_transposed_all_subsampled_files_Salmon_TPM_gc_and_seq_bias_correction.tsv

strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_kruskal_test_script_placeholder.txt
while read -r line
do
  contig_name="$line"
  cat strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_kruskal_test_script_placeholder.txt | sed "s/PLACEHOLDER/${contig_name}/g" >> 2022_07_29_strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_kruskal_test_EXECUTION_rscript.R
done < 2022-07-28_list_contigs_in_same_order.txt

❓ 0 R 4.0.3-1                         ID = 5e4fe75c-b9b4-4951-89ad-7431eaa78f97
/hpc-home/osbourne
2022-07-28_list_contigs_in_same_order.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/2022-04-16_all_bins_less_5_percent_contamination_minimum_80_percent_completeness_list_bins_with_contigs.tsv

AC11N_Salmon_quantification_unsorted_all_reads_including_multiple_mapping.sf

awk -F "\t" '{print $1"\t"$4}' AC11N_Salmon_quantification_unsorted_all_reads_including_multiple_mapping.sf | grep -v "Name" | sort -k1 -V

replace contig name with bin in temp file then sum tpms
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

target_files=$(find -maxdepth 2 -type f -name "AC11N_Salmon_quantification_unsorted_all_reads_including_multiple_mapping.sf")
bins_list_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/2022-04-16_all_bins_less_5_percent_contamination_minimum_80_percent_completeness_list_bins_with_contigs.tsv"
updir=$(pwd)
unique_bins_list="/hpc-home/osbourne/2022-07-29_list_all_strict_bins.txt"
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  awk -F "\t" '{print $1"\t"$4}' "$f" | grep -v "TPM" | sort -V -k1 > "${updir}/${sampleID}.temp.contigs_and_tpms.tsv"
  while read -r line
  do
    contig=$(echo "$line" | awk -F "\t" '{print $1}')
    tpm=$(echo "$line" | awk -F "\t" '{print $2}')
    bin_match=$(awk -F "\t" -v contig="$contig" '$2 == contig {print $1}' "$bins_list_file")
    printf "${bin_match}\t${tpm}\n" >> "${updir}/${sampleID}.temp.bins_and_tpms.tsv"
  done < "${updir}/${sampleID}.temp.contigs_and_tpms.tsv"
  while read -r line
  do
    bin_name="$line"
    bin_tpm_summed=$(awk -F "\t" -v bin="$bin_name" '$1 == bin {print $2}' "${updir}/${sampleID}.temp.bins_and_tpms.tsv" | paste -sd + | bc -l | awk '{printf "%f", $0}')
    printf "$bin_name\t$bin_tpm_summed\n"
  done < unique_bins_list | sort -V -k1 > "${updir}/${sampleID}.Salmon_TPMs_summed_to_bins.Strict_bins.Subsampled_reads.All_mappings.tsv"
  rm "${updir}/${sampleID}.temp.contigs_and_tpms.tsv"
  rm "${updir}/${sampleID}.temp.bins_and_tpms.tsv"
done

sed '1270089q;d' 2022_07_29_strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_kruskal_test_EXECUTION_rscript.R

sed '1270089s/SEASON/HOST/g' 2022_07_29_strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_kruskal_test_EXECUTION_rscript.R
awk 'NR == 1270089 { sub("SEASON", "HOST") }' 2022_07_29_strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_kruskal_test_EXECUTION_rscript.R

write.table(`2022_07_29_Salmon_TPMs_GC_and_seq_bias_flags_on_strict_bin_contigs_subsampled_reads_only_novogene_paired_HOST_kruskal_test_pvalues`, "2022_07_29_Salmon_TPMs_GC_and_seq_bias_flags_on_strict_bin_contigs_subsampled_reads_only_novogene_paired_HOST_kruskal_test_pvalues.tsv", sep="\t", row.names=FALSE)

sed -i -e '1270089d' 2022_07_29_strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_kruskal_test_EXECUTION_rscript.R

2022-07-31
target_files=$(find -maxdepth 2 -type f -name "AC28J_Salmon_quantification_unsorted_all_reads_including_multiple_mapping.sf")
bins_list_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/2022-04-16_all_bins_less_5_percent_contamination_minimum_80_percent_completeness_list_bins_with_contigs.tsv"
updir=$(pwd)
unique_bins_list="/hpc-home/osbourne/2022-07-29_list_all_strict_bins.txt"
target_files=$(find -maxdepth 2 -type f -name "AC28J_Salmon_quantification_unsorted_all_reads_including_multiple_mapping.sf")
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  printf "Sample ID is:\t$sampleID\nFile being worked on is:\t$f\n"
  awk -F "\t" '{print $1"\t"$4}' "$f" | grep -v "TPM" | sort -V -k1 > "${updir}/${sampleID}.temp.contigs_and_tpms.tsv"
  while read -r line
  do
    contig=$(echo "$line" | awk -F "\t" '{print $1}')
    tpm=$(echo "$line" | awk -F "\t" '{print $2}')
    bin_match=$(awk -F "\t" -v contig="$contig" '$2 == contig {print $1}' "$bins_list_file")
    printf "${bin_match}\t${tpm}\n" >> "${updir}/${sampleID}.temp.bins_and_tpms.tsv"
  done < "${updir}/${sampleID}.temp.contigs_and_tpms.tsv"
  printf "Bin\t${sampleID}\n" > "${updir}/${sampleID}.Salmon_TPMs_summed_to_bins.Strict_bins.Subsampled_reads.All_mappings.tsv"
  while read -r line
  do
    bin_name="$line"
    bin_tpm_summed=$(awk -F "\t" -v bin="$bin_name" '$1 == bin {print $2}' "${updir}/${sampleID}.temp.bins_and_tpms.tsv" | paste -sd + | bc -l | awk '{printf "%f", $0}')
    printf "$bin_name\t$bin_tpm_summed\n"
  done < "$unique_bins_list" | sort -V -k1 >> "${updir}/${sampleID}.Salmon_TPMs_summed_to_bins.Strict_bins.Subsampled_reads.All_mappings.tsv"
  rm "${updir}/${sampleID}.temp.contigs_and_tpms.tsv"
  rm "${updir}/${sampleID}.temp.bins_and_tpms.tsv"
done

while read -r line
do
  contig_name="$line"
  cat strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_fold_changes_and_geometric_means_script_placeholder.txt | sed "s/PLACEHOLDER/${contig_name}/g" >> 2022_07_31_strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_fold_changes_and_geometric_means_EXECUTION_rscript.R
done < 2022-07-28_list_contigs_in_same_order.txt

sed -i -e '1270089d' 2022_07_29_strict_bin_contigs_salmon_tpms_GC_and_seq_bias_flags_on_subsampled_reads_only_paired_novogene_kruskal_test_EXECUTION_rscript.R

for f in *.Salmon_TPMs_summed_to_bins.Strict_bins.Subsampled_reads.All_mappings.tsv
do
  sampleID=$(basename "$f" | awk -F ".Sa" '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}.just_summed_TPMs.txt"
done
paste -d "\t" bins_list_in_order.txt *.just_summed_TPMs.txt > 2022-07-31_Salmon_TPMs_GC_and_seq_bias_flagged_summed_to_Bins_all_subsampled_reads_mapping_strict_bins.tsv
rm *.just_summed_TPMs.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/isolate_assemblies_and_200_references

find -maxdepth 1 -type f -name "*.fa" -not -name "*Bin*" -not -name "S12*" -not -name "*careful*" | xargs shuf -n99 -e >> TEMP_selected_files_list.txt
sbatch 2022-07-31_Jolytree_all_good_acomys_isolates_min_500_bp_contigs_and_179_reference_genomes.sh
Submitted batch job 49240539

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp

2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_phylum_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt
ids_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
while read -r line
do
  taxid="$line"
  taxname=$(awk -F "\t" -v taxid="$taxid" '$1 == taxid {print $0}' "$ids_file" | grep 'scientific' | awk -F "\t" '{print $3}')
  sed -i -e "s/$taxid/$taxname/g" 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_phylum_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt
done < 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_phylum_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt

ids_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
while read -r line
do
  taxid="$line"
  taxname=$(awk -F "\t" -v taxid="$taxid" '$1 == taxid {print $0}' "$ids_file" | grep 'scientific' | awk -F "\t" '{print $3}')
  sed -i -e "s/$taxid/$taxname/g" 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_family_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt
  printf "Switched $taxid for $taxname\n"
done < 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_family_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt

ids_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
while read -r line
do
  taxid="$line"
  taxname=$(awk -F "\t" -v taxid="$taxid" '$1 == taxid {print $0}' "$ids_file" | grep 'scientific' | awk -F "\t" '{print $3}')
  sed -i -e "s/$taxid/$taxname/g" 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_class_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt
  printf "Switched $taxid for $taxname\n"
done < 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_class_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt

ids_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
while read -r line
do
  taxid="$line"
  taxname=$(awk -F "\t" -v taxid="$taxid" '$1 == taxid {print $0}' "$ids_file" | grep 'scientific' | awk -F "\t" '{print $3}')
  sed -i -e "s/$taxid/$taxname/g" 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_order_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt
  printf "Switched $taxid for $taxname\n"
done < 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_order_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt

ids_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
while read -r line
do
  taxid="$line"
  taxname=$(awk -F "\t" -v taxid="$taxid" '$1 == taxid {print $0}' "$ids_file" | grep 'scientific' | awk -F "\t" '{print $3}')
  sed -i -e "s/$taxid/$taxname/g" 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_genus_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt
  printf "Switched $taxid for $taxname\n"
done < 2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_genus_level_results_all_potential_taxID_percentages_JUST_TAXIDS.txt

2022-08-01
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/isolate_assemblies_and_200_references
1578	|	Lactobacillus	|		|	scientific name	|

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files

for f in Bin_*.fa
do
  bin_filename=$(basename "$f")
  bin_identity=$(basename "$f" | awk -F ".f" '{print $1}')
  bin_length=$(grep '>' "$f" | awk -F "len=" '{print $2}' | paste -sd+ | bc -l)
  original_contigs=$(grep '>' "$f" | wc -l)
  non_zero_flags=$(grep '>' "$f" | awk -F "flag=" '{print $2}' | awk -F " " '{print $1}' | grep -vw "0" | wc -l)
  printf ">${bin_identity} flag=0 multi=0 len=${bin_length} original_contigs=${original_contigs} original_non_zero_flags=${non_zero_flags}\n" >> "${bin_filename}.merged_contigs.fa"
  grep -v ">" "$f" | tr -d "\n" >> "${bin_filename}.merged_contigs.fa"
  printf "Processed file:\t$f\n"
done

cat *.fa.merged_contigs.fa > 2022-08-01_all_strict_bins_contigs_merged_concatenated_bins_file.fa

sbatch --dependency=afterok:49245695 2022-08-01_Minimap2_subsampled_bins_mapping_strict_bins_single_contigs_concatenated_fasta-ARRAY.sh

2022-08-02
Name	Length	EffectiveLength	TPM	NumReads
Bin_c1000	2063924	2224328.332	790.388163	924.318
Bin_c1005	3278091	3182540.534	1447.688675	2422.319
Bin_c1007	2485380	2468229.337	3816.150019	4952.142
Bin_c101	3195942	3293567.234	794.039958	1374.963
Bin_c1023	2335158	2351479.453	556.374766	687.845
Bin_c1036	2155316	2301319.358	111.992856	135.503
Bin_c1043	4297264	4331107.683	3456.214498	7870.129
Bin_c1047	1915365	1433430.519	8797.756136	6630.263
Bin_c1052	2444419	2373012.681	3085.817710	3849.927

while read -r line
do
  order=$(echo "$line")
  search_term=";g__${order}"
  count=$(grep -c "$search_term" 2022-07-14_all_strict_bins_GTDB-TK_full_taxonomy_and_ACTUAL_family_or_genus.tsv)
  printf "$order\t$count\n"
done < genera_list.txt

2022-08-03
targets=$(find -maxdepth 3 -type f -name "*Subsampled_reads_Minimap2_mapping_strict_bins_concatenated_single_contig_entire_bin.Mapped.Sorted.bam.Salmon_quantification.sf")
for f in $targets
do
  cp "$f" /hpc-home/osbourne/good_salmon
  echo "Copied file $f"
done

for f in *Subsampled_reads_Minimap2_mapping_strict_bins_concatenated_single_contig_entire_bin.Mapped.Sorted.bam.Salmon_quantification.sf
do
  sampleID=$(basename "$f" | awk -F ".Sub" '{print $1}')
  printf "$sampleID\n" > "${sampleID}.just_tpms.txt"
  awk -F "\t" '{print $4}' "$f" | grep -v 'TPM' >> "${sampleID}.just_tpms.txt"
done

paste -d "\t" bins_list_in_order.txt *.just_tpms.txt > 2022_08_03_Salmon_TPMs_gc_and_seq_bias_flags_on_all_subsampled_reads_minimap2_mapped_concatenated_single_contig_per_bin_all_strict_bins.tsv


grep ';g__CAG-485' 2022-07-14_all_strict_bins_GTDB-TK_full_taxonomy_and_ACTUAL_family_or_genus.tsv
2022-07-14_all_strict_bins_GTDB-TK_full_taxonomy_and_ACTUAL_family_or_genus.tsv

2022-08-08
2022-07-29_melted_transposed_only_paired_novogene_Salmon_TPM_gc_and_seq_bias_correction.tsv

k141_13085355

grep 'k141_13085355' 2022-07-29_melted_transposed_only_paired_novogene_Salmon_TPM_gc_and_seq_bias_correction.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs
k141_6530735

while read -r line
do
  contig_name=$(echo "$line" |tr " " "_" | tr "|" "_")
  contig_content=$(grep -a1 "$line" ./*/*protein.faa | tail -1 | awk -F "-" '{print $3}')
  printf ">${contig_name}\n${contig_content}\n" >> 2022-08-08_hypothetical_proteins_strict_bins.faa
done < 2022_08_08_list_hypothetical_proteins.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/Strict_bins_hypothetical_proteins_DFAST_individual_fasta_faa_files

2022-08-09
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting

2022-08-10
./Bin_c448-DFAST_output/Bin_c448_protein.faa

trial_list_names.txt
MGA_2003|Bin_c448_locus-_18450 hypothetical protein

seqtk subseq Bin_c448_protein.faa trial_list_names.txt > single_extracted_hypothetical.faa

list_protein_faa_files.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs

source package a684a2ed-d23f-4025-aa81-b21e27e458df #Seqtk version 1.3-r106 from within the Snippy installation
updir=$(pwd)
while IFS= read -r line ;
do
  bin_path=$(echo "$line")
  printf "$bin_path\n"
  bin_name=$(basename "$bin_path" | awk -F "_protein" '{print $1}')
  printf "$bin_name\n"
  bin_directory=$(dirname "$bin_path")
  printf "$bin_directory\n"
  cd "$bin_directory"
  hereiam=$(pwd)
  printf "I am here:\t$hereiam\n"
  hypothetical_proteins=$(grep 'hypothetical' "${bin_name}_protein.faa" | tr -d ">")
  printf "$hypothetical_proteins\n"
  echo "$hypothetical_proteins" > "${updir}/${bin_name}.Hypothetical_protein_sequence_IDs.txt"
  seqtk subseq "${bin_name}_protein.faa" "${updir}/${bin_name}.Hypothetical_protein_sequence_IDs.txt" > "${updir}/${bin_name}.Hypothetical_proteins_Seqtk_extracted.faa"
  rm "${updir}/${bin_name}.Hypothetical_protein_sequence_IDs.txt"
  cd "$updir"
  mv "${updir}/${bin_name}.Hypothetical_proteins_Seqtk_extracted.faa" Per_strict_bin_all_hypothetical_proteins_single_amino_acid_fasta_files
  printf "Processed file:\t$bin_path\n"
done < list_protein_faa_files.txt

2022-08-11
k141_10193337
grep 'k141_10193337' ./concatenated_files/2022-04-20_concatenated_all_good_bins_DFAST_output_GFF_files.gff
awk -F "\t" '{print $1}' 2022_08_11_Salmon_TPMs_GC_and_seq_bias_flags_on_paired_novogene_only_individual_contigs_AR_only_contigs.tsv | sed 's/"//g' | grep -v 'Contig' > 2022_08_11_Salmon_TPMs_GC_and_seq_bias_flags_on_paired_novogene_only_individual_contigs_AR_only_contigs-Contig_names_only.txt

awk -F "\t" '{print $1}' 2022_08_11_Salmon_TPMs_GC_and_seq_bias_flags_on_paired_novogene_only_individual_contigs_AC_enriched_but_not_exclusive_contigs_corrected_pvalue_significant_and_log2_add_one_fold_change_over_pos_minus_one.tsv | sed 's/"//g' | grep -v 'Contig' > 2022_08_11_Salmon_TPMs_GC_and_seq_bias_flags_on_paired_novogene_only_individual_contigs_AC_enriched_but_not_exclusive_contigs_corrected_pvalue_significant_and_log2_add_one_fold_change_over_pos_minus_one-Contig_names_only.txt
awk -F "\t" '{print $1}' 2022_08_11_Salmon_TPMs_GC_and_seq_bias_flags_on_paired_novogene_only_individual_contigs_AR_enriched_but_not_exclusive_contigs_corrected_pvalue_significant_and_log2_add_one_fold_change_over_pos_minus_one.tsv | sed 's/"//g' | grep -v 'Contig' > 2022_08_11_Salmon_TPMs_GC_and_seq_bias_flags_on_paired_novogene_only_individual_contigs_AR_enriched_but_not_exclusive_contigs_corrected_pvalue_significant_and_log2_add_one_fold_change_over_pos_minus_one-Contig_names_only.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files
2022-04-20_Bin_m1202_all_contigs_all_products_bin_name_start_and_end_sites_as_well_as_product.tsv

awk -F "\t" -v contig="k141_8546110" '$2 == contig {print $0}' *all_contigs_all_products_bin_name_start_and_end_sites_as_well_as_product.tsv

k141_15749678
awk -F "\t" -v contig="k141_15749678" '$1 == contig {print $4"\t"$5}' 2022-07-30_Salmon_TPMs_GC_and_seq_bias_flagged_only_paired_novogene_contigs_geometric_means_all_values_different_things.tsv.COPY.tsv

home_dir=$(pwd)
other_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs/concatenated_files"
while IFS= read -r line
do
  contig="$line"
  AC_geometric_mean_and_log2fc_for_host=$(awk -F "\t" -v contig="$contig" '$1 == contig {print $4"\t"$5}' "${home_dir}/2022-07-30_Salmon_TPMs_GC_and_seq_bias_flagged_only_paired_novogene_contigs_geometric_means_all_values_different_things.tsv.COPY.tsv")
  all_details=$(awk -F "\t" -v contig="$contig" '$2 == contig {print $0}' ${other_dir}/*all_contigs_all_products_bin_name_start_and_end_sites_as_well_as_product.tsv)
  bin_ID=$(echo "$all_details" | awk -F "\t" '{print $1}' | sort | uniq)
  all_product_IDs=$(echo "$all_details" | awk -F "\t" '{print $5}' | sed 's/ID=//g' | tr "\n" "," | sed "s/,$//g")
  all_product_names=$(echo "$all_details" | awk -F "\t" '{print $6}' | sed 's/ID=//g' | tr "\n" "," | sed "s/,$//g")
  echo "$contig£$bin_ID£$all_product_IDs£$all_product_names£$AC_geometric_mean_and_log2fc_for_host" | sed "s/£/\\t/g"
done < "${home_dir}/2022_08_11_Salmon_TPMs_GC_and_seq_bias_flags_on_paired_novogene_only_individual_contigs_AC_only_contigs-Contig_names_only.txt"

2022-08-31
targets=$(find -maxdepth 2 -type f -name "*.tsv.gz")
for f in $targets
do
  cp "$f" /hpc-home/osbourne/InterProScan_all_strict_bins_tsv_outputs
  echo "Copied file $f"
done

source package 68248f11-d17e-4c01-a95d-47af6d05b765 #barrnap 0.9
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files

barrnap --quiet --kingdom bac --threads 2 Bin_m1093.fa
barrnap --kingdom bac --threads 2 --reject 0.1 Bin_m1093.fa

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/Barrnap_output

Bin_m1863.fa

2022-09-02
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kraken

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kraken2
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
awk -F "\t" -v taxid="4662" '$5 == taxid {print $6}' *report.txt | sort -h | uniq | xargs echo -n

095_all_unique_TaxIDs.txt

while IFS= read -r line
do
  taxid="$line"
  taxon=$(awk -F "\t" -v taxid="$taxid" '$5 == taxid {print $6}' *report.txt | sort -h | uniq | xargs echo -n)
  printf "$taxid\t$taxon\n"
done < 095_all_unique_TaxIDs.txt > 095_conf_all_taxids_and_their_taxons.tsv

while IFS= read -r line
do
  taxid="$line"
  taxon=$(awk -F "\t" -v taxid="$taxid" '$5 == taxid {print $6}' *report.txt | sort -h | uniq | xargs echo -n)
  printf "$taxid\t$taxon\n"
done < 050_all_unique_TaxIDs.txt > 050_conf_all_taxids_and_their_taxons.tsv

while IFS= read -r line
do
  taxid="$line"
  taxon=$(awk -F "\t" -v taxid="$taxid" '$5 == taxid {print $6}' *report.txt | sort -h | uniq | xargs echo -n)
  printf "$taxid\t$taxon\n"
done < 010_all_unique_TaxIDs.txt > 010_conf_all_taxids_and_their_taxons.tsv

mail -s '095_conf_all_taxids_and_their_taxons.tsv' -a 095_conf_all_taxids_and_their_taxons.tsv peter.osborne@earlham.ac.uk <<< "File 095_conf_all_taxids_and_their_taxons.tsv should be attached"
mail -s '050_conf_all_taxids_and_their_taxons.tsv' -a 050_conf_all_taxids_and_their_taxons.tsv peter.osborne@earlham.ac.uk <<< "File 050_conf_all_taxids_and_their_taxons.tsv should be attached"
mail -s '010_conf_all_taxids_and_their_taxons.tsv' -a 010_conf_all_taxids_and_their_taxons.tsv peter.osborne@earlham.ac.uk <<< "File 010_conf_all_taxids_and_their_taxons.tsv should be attached"

cd /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files/

Kaiju2table_0_errors_allowed-species_level_results.tsv

while IFS= read -r line
do
  taxid="$line"
  taxon=$(awk -F "\t" -v taxid="$taxid" '$4 == taxid {print $5;exit;}' *Kaiju2table_0_errors_allowed-species_level_results.tsv)
  printf "$taxid\t$taxon\n" >> all_0_errors_species_level_taxids_and_taxon_names.txt
done < list_all_taxids_species_level_0_errors.txt

2022-09-07
chap1: c33dfa31-8d66-4727-827b-ce9eb62d3237
chap2: c57d1fc8-8c7f-47d2-bd32-4e5250784e29
chap3: b881ad24-2c3c-4508-a6b2-b1c552453c24
chap4: 5306b670-79f8-438b-aa06-d6133e2c53a4

/ei/projects/c/c57d1fc8-8c7f-47d2-bd32-4e5250784e29
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237

2022-09-08
V2_2022-09-08_Kaiju_0_errors_species_level_all_possible_species_all_subsampled_read_files.tsv
2022-09-08_Kaiju_0_errors_species_level_all_possible_species_all_subsampled_read_files-STRINGS_about_metadata.tsv

paste -d "\t" V2_2022-09-08_Kaiju_0_errors_species_level_all_possible_species_all_subsampled_read_files.tsv 2022-09-08_Kaiju_0_errors_species_level_all_possible_species_all_subsampled_read_files-STRINGS_about_metadata.tsv > 2022-09-08_all_subsampled_reads_Kaiju_0_errors_all_possible_taxa_report_percentages_species_level_concatenated.tsv

2022-09-09
2022_09_09_list_strict_bins.tsv

while IFS= read -r line
do
  bin_name="$line"
  bin_file="${bin_name}.Barrnap.gff3"
  mv "$bin_file" strict_bins
  printf "Moved:\t$strict_bins\n"
done < 2022_09_09_list_strict_bins.tsv


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes

for f in NZ* ; do mv "$f" /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes && printf "Moved file:\t$f\n" ; done

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes

2022-09-15
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/genomes_from_Nancy_Teng_provided_by_Magda_Kujawska-2021-07-27/QIB-Nancy-Teng-210726
find -maxdepth 2 -type f -name "*S122*"
./PID-0678-978/PID-0678-978_S122_R1_001.fastq.gz
./PID-0678-978/PID-0678-978_S122_R2_001.fastq.gz
find -maxdepth 2 -type f -name "*S124*"
./PID-0678-774/PID-0678-774_S124_R1_001.fastq.gz
./PID-0678-774/PID-0678-774_S124_R2_001.fastq.gz
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/raw

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/data/raw


2022-09-18
/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting

/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/raw

https://ftp.ncbi.nlm.nih.gov/genomes/refseq/plant/Arabidopsis_thaliana/reference/GCF_000001735.4_TAIR10.1/GCF_000001735.4_TAIR10.1_genomic.fna.gz
https://ftp.ncbi.nlm.nih.gov/genomes/refseq/plant/Quercus_robur/representative/GCF_932294415.1_dhQueRobu3.1/GCF_932294415.1_dhQueRobu3.1_genomic.fna.gz

2022-09-19
find <directory> -type f -size +N<Unit Type>

find -maxdepth 1 -type f -size +10M

find -maxdepth 2 -type f -size +1c -execdir pigz '{}'.gz '{}' \;

sbatch 2022-09-19_metagenomic_workflow_trial.sh R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003_R1.fastq.gz R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003_R2.fastq.gz R0786-S0014_VWT819_A64352 /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/results

sbatch 2022-09-19_metagenomic_workflow_trial.sh SRR11852046_1.fastq.gz SRR11852046_2.fastq.gz SRR11852046-Capybara /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/results

source package f8bdba0d-9810-4f34-87fd-c71012f149e7
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes

R --vanilla
setrepo = getOption("repos")
setrepo["CRAN"] = "http://cran.uk.r-project.org"
options(repos = setrepo)
rm(setrepo)
install.packages("stringr")
q()
exit

install.packages("phyper")

for i in {1..120}
do
  mail -s "Hello" sathish.thiyagarajan@earlham.ac.uk <<< "YO SATHISH!"
  sleep 1s
done

2022-09-28
source package 14fbfadb-9fe7-419a-9f20-cd5f458c0fff #RepeatMasker 4.0.0_p2
RepeatMasker --help

source package cab8386a-c777-4936-8411-a6ed2b5e6a20 #BBmap - 38.79
bbmask.sh

#Using mostly default parameters but changing so kmer size range to sweep for exact repeats
#is 7-15, the entropy value to be used for the low complexity masking is 0.75 not 0.7
bbmask.sh in= out= threads=auto maskrepeats=t minkr=7 maxkr=15 minlen=40 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.75

java -ea -Xmx10g -Xms6g -cp /opt/software/conda_env/opt/bbmap-38.79-0/current/ jgi.BBMask -Xmx10g -Xms6g in=/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/Bin_m920.fa out=/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/BBMask_output/Bin_m920.fa.BBMasked.fa threads=auto maskrepeats=t minkr=7 maxkr=15 minlen=40 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.75
Executing jgi.BBMask [-Xmx10g, -Xms6g, in=/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/Bin_m920.fa, out=/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/BBMask_output/Bin_m920.fa.BBMasked.fa, threads=auto, maskrepeats=t, minkr=7, maxkr=15, minlen=40, mincount=4, masklowentropy=t, ke=5, window=80, entropy=0.75]

Set threads to 2
Loading input
Loading Time:                 	0.138 seconds.

Masking repeats (to disable, set 'mr=f')
Repeat Masking Time:          	0.279 seconds.
Ref Bases:                   1686845 	6.05m bases/sec
Repeat Bases Masked:               0

Masking low-entropy (to disable, set 'mle=f')
Low Complexity Masking Time:  	0.067 seconds.
Ref Bases:                   1686845 	25.02m bases/sec
Low Complexity Bases:            178

Converting masked bases to N
Done Masking
Conversion Time:              	0.022 seconds.

Writing output
Writing Time:                 	0.035 seconds.

Total Bases Masked:              178/1686845	0.011%
Total Time:                   	0.674 seconds.
java -ea -Xmx10g -Xms6g -cp /opt/software/conda_env/opt/bbmap-38.79-0/current/ jgi.BBMask -Xmx10g -Xms6g in=/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/ref_storage/NZ_CP076099.1_Latilactobacillus_curvatus_strain_SPC-SNU_70-3_chromosome_complete_genome.fa out=/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/BBMask_output/NZ_CP076099.1_Latilactobacillus_curvatus_strain_SPC-SNU_70-3_chromosome_complete_genome.fa.BBMasked.fa threads=auto maskrepeats=t minkr=7 maxkr=15 minlen=40 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.75
Executing jgi.BBMask [-Xmx10g, -Xms6g, in=/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/ref_storage/NZ_CP076099.1_Latilactobacillus_curvatus_strain_SPC-SNU_70-3_chromosome_complete_genome.fa, out=/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/BBMask_output/NZ_CP076099.1_Latilactobacillus_curvatus_strain_SPC-SNU_70-3_chromosome_complete_genome.fa.BBMasked.fa, threads=auto, maskrepeats=t, minkr=7, maxkr=15, minlen=40, mincount=4, masklowentropy=t, ke=5, window=80, entropy=0.75]

Set threads to 2
Loading input
Loading Time:                 	0.138 seconds.

Masking repeats (to disable, set 'mr=f')
Repeat Masking Time:          	0.571 seconds.
Ref Bases:                   1905983 	3.34m bases/sec
Repeat Bases Masked:              40

Masking low-entropy (to disable, set 'mle=f')
Low Complexity Masking Time:  	0.087 seconds.
Ref Bases:                   1905983 	22.00m bases/sec
Low Complexity Bases:              0

Converting masked bases to N
Done Masking
Conversion Time:              	0.031 seconds.

Writing output
Writing Time:                 	0.037 seconds.

Total Bases Masked:               40/1905983	0.002%
Total Time:                   	0.975 seconds.

grep --color=auto 'N\|$' Bin_m920.fa.BBMasked.fa

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/BBMask_output

#Additional reference genomes:
#Alistipes finegoldii - different phylum
#cellular organisms; Bacteria; FCB group; Bacteroidetes/Chlorobi group; Bacteroidetes; Bacteroidia; Bacteroidales; Rikenellaceae; Alistipes; Alistipes finegoldii
#https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/015/548/275/GCF_015548275.1_ASM1554827v1/GCF_015548275.1_ASM1554827v1_genomic.fna.gz

#Enterococcus faecalis 10244 - different family
#cellular organisms; Bacteria; Terrabacteria group; Firmicutes; Bacilli; Lactobacillales; Enterococcaceae; Enterococcus; Enterococcus faecalis
#https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/393/015/GCF_000393015.1_Ente_faec_T5_V1/GCF_000393015.1_Ente_faec_T5_V1_genomic.fna.gz

#Staphylococcus carnosus subsp. carnosus TM300 - different order
#cellular organisms; Bacteria; Terrabacteria group; Firmicutes; Bacilli; Bacillales; Staphylococcaceae; Staphylococcus; Staphylococcus carnosus
#https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/900/458/435/GCF_900458435.1_50279_A02/GCF_900458435.1_50279_A02_genomic.fna.gz

#Eubacterium barkeri - different class
#cellular organisms; Bacteria; Terrabacteria group; Firmicutes; Clostridia; Eubacteriales; Eubacteriaceae; Eubacterium
#https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/900/107/125/GCF_900107125.1_IMG-taxon_2642422543_annotated_assembly/GCF_900107125.1_IMG-taxon_2642422543_annotated_assembly_genomic.fna.gz

2022-09-29

Bootstrap: docker
From: nanozoo/maxbin2:2.2.7--b643a6b

sudo singularity build MaxBin2_v2_2_7-Nanozoo_docker_image.img maxbin2_nanozoo.def

singularity exec MaxBin2_v2_2_7-Nanozoo_docker_image.img

metabat_Metabat_on_dockerhub.def
Bootstrap: docker
From: metabat/metabat:latest

sudo singularity build Metabat_v2_15-5_MetaBat_docker_image.img metabat_Metabat_on_dockerhub.def
sudo singularity build Metabat_v2_15-5_MetaBat_docker_image.sif metabat_Metabat_on_dockerhub.def

singularity exec Metabat_v2_15-5_MetaBat_docker_image.sif metabat2 -i contigs.fa --seed 100 --verbose
singularity exec /hpc-home/osbourne/Metabat_v2_15-5_MetaBat_docker_image.sif metabat2 -i SRR11852046-Capybara-8e5f79c7_d5dc_4588_a44e_fe515b647fac_lnzwlDI0f9HYwTrR-Thu_29_Sep_2022.Single_line.metaSPADES_contigs.fa --seed 100 --verbose --outFile "metabat_out/testing_metabat2_image"

SRR11852046-Capybara-8e5f79c7_d5dc_4588_a44e_fe515b647fac_lnzwlDI0f9HYwTrR-Thu_29_Sep_2022.Single_line.metaSPADES_contigs.fa

2022-09-30
sbatch 2022-09-19_metagenomic_workflow_trial_mod.sh R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003_R1.fastq.gz R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003_R2.fastq.gz R0786-S0014_VWT819_A64352 /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/results
sbatch 2022-09-19_metagenomic_workflow_trial_mod.sh SRR11852046_1.fastq.gz SRR11852046_2.fastq.gz SRR11852046-Capybara /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/results

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files

for f in *.Kaiju_output_20_allowed_errors.Taxon_names_added.out
do
  nome=$(basename "$f" | awk -F "." '{print $1}')
  reads_mapped=$(awk -F "\t" -v status="C" '$1 == status {print $1}' "$f" | wc -l)
  printf "$nome\t$reads_mapped\n"
done

awk -F "\t" -v status="C" '$1 == status {print $1}' ERR3357615.Kaiju_output_20_allowed_errors.Taxon_names_added.out | wc -l

29454713
ERR3357615 - 83.524494382022472
3716840
4450000

for f in Classified_Kraken2_*-E3_R1.fq.010_conf_score_1.txt.gz
do
  nome=$(basename "$f" | awk -F "Classified_Kraken2_" '{print $2}' | awk -F "-E3_R1.fq.010_conf_score_1.txt.gz" '{print $1}')
  lines_in_file=$(zcat "$f" | wc -l)
  reads_mapped=$(echo "$lines_in_file / 4" | bc -l)
  printf "$nome\t$reads_mapped\n"
done

sbatch 2022-09-19_metagenomic_workflow_trial_mod.sh SRR11852046_1.fastq.gz SRR11852046_2.fastq.gz SRR11852046-Capybara /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/results
58cf0d3b_96ff_4f2b_9e15_5f831daedd4a_SdsZqhxZr6gpZL1O

2022-10-02
sbatch 2022-09-19_metagenomic_workflow_trial_mod.sh SRR11852046_1.fastq.gz SRR11852046_2.fastq.gz SRR11852046-Capybara /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/results
sbatch 2022-09-19_metagenomic_workflow_trial_mod.sh R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003_R1.fastq.gz R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003_R2.fastq.gz R0786-S0014_VWT819_A64352 /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/results

cat 994_LIB8395_LDI7034_NoIndex_L001_Kraken2-010_report.txt | awk -F "\t" '{print $5}' | grep -wc "1660"

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

readarray -t kraken_taxids_human < <(awk -F "," '{print $3}' 2022-01-31_Kaiju_and_kraken_taxIDs_for_mock_community_members.csv | grep -v 'tax')
echo "${kraken_taxids_human[@]}"

readarray -t kraken_taxids_human < <(cat 2022-03-02_exact_strain_taxIDs_only_not_species_or_any_other_strains.txt)

for i in "${kraken_taxids_human[@]}"
do
  taxid=$(echo "$i")
  printf "Searching for:\t$taxid\n"
  grep -q "$taxid" temp_unique_taxids.txt && printf "PRESENT\t$taxid\n" || printf "ABSENT\t$taxid\n"
done
Searching for:	400667
PRESENT	400667
Searching for:	411466
ABSENT	411466
Searching for:	222523
PRESENT	222523
Searching for:	435590
PRESENT	435590
Searching for:	290402
PRESENT	290402
Searching for:	243230
ABSENT	243230
Searching for:	474186
ABSENT	474186
Searching for:	511145
ABSENT	511145
Searching for:	85962
ABSENT	85962
Searching for:	324831
PRESENT	324831
Searching for:	169963
PRESENT	169963
Searching for:	122586
PRESENT	122586
Searching for:	267747
PRESENT	267747
Searching for:	208964
ABSENT	208964
Searching for:	272943
PRESENT	272943
Searching for:	451516
PRESENT	451516
Searching for:	176280
PRESENT	176280
Searching for:	208435
PRESENT	208435
Searching for:	210007
PRESENT	210007
Searching for:	170187
ABSENT	170187

2022-10-03
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMask_output

targets=$(find -maxdepth 1 -type f -name "*BBMasked.fa" -printf '%f\n')
outdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMask_output"
for f in $targets
do
  cp "$f" "$outdir"
  printf "Copied file:\t$f\n"
done

2022-10-06
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/2022-10-06_CORRECTLY_SUBSAMPLED_MUS_FILES

38945342649176909846192076801180 seed for redoing mus file subsampling
source package /tgac/software/testing/bin/seqtk-20150226
seqtk sample -s "$seqtk_random_seed" "$cleansed_qc_r1" "$desired_read_count" > "${FINAL_OUTDIR}/${cleansed_qc_r1}.Subsampled.fq"

for f in *fq.Cleansed.fq
do
  ran_seed="38945342649176909846192076801180"
  printf "Subsampling file:\t$f\n"
  seqtk sample -s "$ran_seed" "$f" 4450000 > "${f}.Subsampled.fq"
  read_depth=$(grep -c "@" "${f}.Subsampled.fq")
  printf "Subsampled file:\t$f\tNew read depth is: $read_depth\n"
done

for f in *QCed.fq.Cleansed.fq.Subsampled.fq
do
  nome=$(basename "$f")
  read_count=$(echo "$(wc -l "$f" | awk -F " " '{print $1}') / 4" | bc -l)
  printf "$nome\t$read_count\n"
done

echo "$(wc -l ERR3357615_R2.QCed.fq.Cleansed.fq.Subsampled.fq | awk -F " " '{print $1}') / 4" | bc -l

2022-10-06
Processing /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch/e678d9ab_43ae_472c_8d89_3df1d7f2a515_uFEC7uOTVTc7oRfh-Sun_2_Oct_2022-POSBORNE_NOT_COMPRESSED_PROJECT-WORKING-R0786-S0014_VWT819_A64352/Kaiju_output/R0786-S0014_VWT819_A64352-e678d9ab_43ae_472c_8d89_3df1d7f2a515_uFEC7uOTVTc7oRfh-Sun_2_Oct_2022-POSBORNE_NOT_COMPRESSED_PROJECT.Kaiju_output.Taxon_names_added.out...
slurmstepd: error: *** JOB 50916943 ON t512n2 CANCELLED AT 2022-10-06T10:48:21 DUE TO TIME LIMIT ***

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results
targets=$(find -maxdepth 2 -type f -name "*_BWA_against_concatenated_bins.sam.gz")
for f in $targets
do
  printf "2022-10-06 Removed file:\t$f" >> 2022_10_06_log_of_file_deletions.txt
  rm "$f"
done

find -maxdepth 3 -type f -size +10M -not -name "*bam*"

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mapping_to_concatenated_bins_results

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/fastp_outputs

targets=$(find -maxdepth 1 -type f -name "*QCed.R1.fq")
for f in $targets
do
  nome=$(basename "$f" | awk -F '[_-]' '{print $1}')
  nume=$(basename "$f")
  read_count=$(echo "$(wc -l $nume | awk -F " " '{print $1}') / 4" | bc -l)
  printf "$nome\t$read_count\n"
  printf "$nome\t$read_count\n" >> 2022_10_08_list_R1_read_counts_with_IDs.tsv
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/fastp_outputs

targets=$(find -maxdepth 1 -type f -name "*.QCed.Cleansed.R1.fq")
for f in $targets
do
  nome=$(basename "$f" | awk -F '[.]' '{print $1}')
  nume=$(basename "$f")
  read_count=$(echo "$(wc -l $nume | awk -F " " '{print $1}') / 4" | bc -l)
  printf "$nome\t$read_count\n"
  printf "$nome\t$read_count\n" >> 2022_10_08_list_R1_read_counts_with_IDs.tsv
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-10-09_list_paired_read_files__paths_and_sampleIDs.txt

for f in *E3_R1.fastq
do
  path_here=$(readlink -f "$f")
  r2_path=$(echo "$path_here" | sed "s/E3_R1.fastq/E3_R2.fastq/g")
  sampleID=$(basename "$f" | awk -F "-" '{print $4}')
  printf "$path_here\t$r2_path\t$sampleID\n" >> /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-10-09_list_paired_read_files__paths_and_sampleIDs.txt
done

for f in *_1.fq
do
  path_here=$(readlink -f "$f")
  r2_path=$(echo "$path_here" | sed "s/_1.fq/_2.fq/g")
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  printf "$path_here\t$r2_path\t$sampleID\n" >> /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-10-09_list_paired_read_files__paths_and_sampleIDs.txt
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/bbduk_outputs/cleansed_files

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/seqtk_outputs

targets=$(find -maxdepth 1 -type f -name "*_1.fq")
for f in $targets
do
  nome=$(basename "$f" | awk -F "_" '{print $1}')
  nume=$(basename "$f")
  read_count=$(echo "$(wc -l $nume | awk -F " " '{print $1}') / 4" | bc -l)
  printf "$nome\t$read_count\n"
  printf "$nome\t$read_count\n" >> "/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-10-09_raw_read_files_R1_read_counts.tsv"
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs

/hpc-home/osbourne/2022_10_10_within_AC_seasonal_change_bins_only_novogene_paired_samples.tsv
/hpc-home/osbourne/2022_10_10_within_AR_seasonal_change_bins_only_novogene_paired_samples.tsv
/hpc-home/osbourne/2022_10_10_host_significant_difference_and_greater_1_less_neg_1_fold_change_bins_only_novogene_paired_samples.tsv

2022-10-11
2022_10_11_bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change.tsv
list_families.txt

while IFS= read -r line
do
  thing=$(echo "$line")
  taxon=$(printf "$thing" | awk -F "\t" '{print $12}')
  family=$(printf "$taxon" | awk -F ";f__" '{print $2}' | awk -F ";g" '{print $1}')
  printf "$family\n" >> list_families.txt
done < 2022_10_11_bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change.tsv

2022_10_11_bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change_with_GTDB_TK_families_alone_in_last_field.tsv

2022-10-12
AC12J_Metaphlan2-output_abundance_and_read_counts.txt:#estimated_reads_mapped_to_known_clades:1278246
#estimated_reads_mapped_to_known_clades:977773

2022-10-16
2022_10_10_host_significant_difference_and_greater_1_less_neg_1_fold_change_bins_only_novogene_paired_samples.tsv
awk -F "\t" '$8 < 0.05 && $10 < 0 {print $1}' 2022_10_10_host_significant_difference_and_greater_1_less_neg_1_fold_change_bins_only_novogene_paired_samples.tsv
awk -F "\t" '$8 < 0.05 && $10 <= -1 {print $1}' 2022_10_10_host_significant_difference_and_greater_1_less_neg_1_fold_change_bins_only_novogene_paired_samples.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/dfast_outputs

2022-07-15_list_all_potential_products.txt

for f in Bin_*_simple_counts_unique_products.tsv
do
  bin_name=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  awk -F "\t" '{print $2}' "$f" > "${bin_name}.Just_unique_product_counts.txt"
done
paste -d "\t" 2022-07-15_list_all_potential_products.txt Bin*.Just_unique_product_counts.txt > "2022-10-16_combined_table_all_good_bins_all_unique_single_products_single_hypothetical_protein_simple_counts.tsv"
rm Bin*.Just_unique_product_counts.txt

2022_10_10_host_significant_difference_and_greater_1_less_neg_1_fold_change_bins_only_novogene_paired_samples.tsv

awk -F "\t" '$8 < 0.05 && $10 <= -1 {print $1}' 2022_10_10_host_significant_difference_and_greater_1_less_neg_1_fold_change_bins_only_novogene_paired_samples.tsv > 2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt
awk -F "\t" '$8 < 0.05 && $10 >= 1 {print $1}' 2022_10_10_host_significant_difference_and_greater_1_less_neg_1_fold_change_bins_only_novogene_paired_samples.tsv > 2022_10_10_AR_against_AC_enriched_1_or_greater_fold_change.Just_bin_names.txt

2022_10_10_within_AR_seasonal_change_bins_only_novogene_paired_samples.Just_bin_names.txt
2022_10_10_within_AC_seasonal_change_bins_only_novogene_paired_samples.Just_bin_names.txt
2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt
2022_10_10_AR_against_AC_enriched_1_or_greater_fold_change.Just_bin_names.txt

printf "Bin_status\n" >> 2022-07-15_list_all_potential_products.Copy.txt

export in_AR="/hpc-home/osbourne/2022_10_10_within_AR_seasonal_change_bins_only_novogene_paired_samples.Just_bin_names.txt"
export in_AC="/hpc-home/osbourne/2022_10_10_within_AC_seasonal_change_bins_only_novogene_paired_samples.Just_bin_names.txt"
export AC_rich="/hpc-home/osbourne/2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt"
export AR_rich="/hpc-home/osbourne/2022_10_10_AR_against_AC_enriched_1_or_greater_fold_change.Just_bin_names.txt"

for f in Bin_*_simple_counts_unique_products.tsv
do
  bin_name=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  awk -F "\t" '{print $2}' "$f" > "${bin_name}.Just_unique_product_counts.txt"
  grep -qw "$bin_name" "$in_AR" && status_of_bin="AR_internal" || status_of_bin="None"
  grep -qw "$bin_name" "$in_AC" && status_of_bin="AC_internal" || status_of_bin="None"
  grep -qw "$bin_name" "$AC_rich" && status_of_bin="AC_enriched" || status_of_bin="None"
  grep -qw "$bin_name" "$AR_rich" && status_of_bin="AR_enriched" || status_of_bin="None"
  printf "$status_of_bin" >> "${bin_name}.Just_unique_product_counts.txt"
done

paste -d "\t" 2022-07-15_list_all_potential_products.Copy.txt Bin*.Just_unique_product_counts.txt > "2022-10-16_combined_table_all_good_bins_all_unique_single_products_single_hypothetical_protein_simple_counts.tsv"
rm Bin*.Just_unique_product_counts.txt

in_AR_effect /hpc-home/osbourne/2022_10_10_within_AR_seasonal_change_bins_only_novogene_paired_samples.Just_bin_names.txt
in_AC_effect /hpc-home/osbourne/2022_10_10_within_AC_seasonal_change_bins_only_novogene_paired_samples.Just_bin_names.txt
AC_enriched_vs /hpc-home/osbourne/2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt
AR_enriched_vs /hpc-home/osbourne/2022_10_10_AR_against_AC_enriched_1_or_greater_fold_change.Just_bin_names.txt

for f in Bin_*_simple_counts_unique_products.tsv
do
  bin_name=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  awk -F "\t" '{print $2}' "$f" > "${bin_name}.Just_unique_product_counts.txt"
  grep -qw "$bin_name" /hpc-home/osbourne/2022_10_10_*Just_bin_names.txt && bin_detection="Y" || bin_detection="N"
  if [[ "$bin_detection" == "Y" ]]
  then
    file_found=$(grep -w "$bin_name" /hpc-home/osbourne/2022_10_10_*Just_bin_names.txt | tail -1 | awk -F ":" '{print $1}')
    export bin_status=$(awk -F " " -v whereitis="$file_found" '$2 == whereitis {print $1}' bin_name_list_files.txt)
  elif [[ "$bin_detection" == "N" ]]
  then
    export bin_status="None"
  else
    export bin_status="ERROR"
  fi
  printf "$bin_status" >> "${bin_name}.Just_unique_product_counts.txt"
done

paste -d "\t" 2022-07-15_list_all_potential_products.Copy.txt Bin*.Just_unique_product_counts.txt > "2022-10-16_combined_table_all_good_bins_all_unique_single_products_single_hypothetical_protein_simple_counts.tsv"
rm Bin*.Just_unique_product_counts.txt

Bin_m1093
grep 'Bin_c631' /hpc-home/osbourne/2022_10_10_*Just_bin_names.txt

AR48N
A00808:437:HHGCHDSXY:3:1101:11595:15781

#Figure TBD. QC results from analysis of generated bins using CheckM and Barrnap. A. Shows the completeness of all 503 bins measured by CheckM with line showing minimum completeness required for inclusion in subsequent analysis. B. Shows the contamination of all bins from CheckM with line showing maximum allowed contamination for use in subsequent analysis. C. Shows the range of completeness and contamination values in all bins measured by CheckM and highlights the 348 bins meeting the selection criteria. D. Barrnap results for analysis of the 348 selected bins, showing rRNA detections both complete and partial (bins could have multiple detection types, count is not exclusive or other detections in same bin).

2022-10-22
_Metaphlan2-output_abundance_and_read_counts.txt
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

readarray -t sampleID_array < <(find -maxdepth 1 -type f -name "*_Metaphlan2-output_abundance_and_read_counts.txt" -printf '%f\n' | awk -F "_" '{print $1}' | sort -V)

for sample in "${sampleID_array[@]}"
do
  sampleid="$sample"
  raw_read_count=$(grep -a1 'read1_before_filtering' ${sampleid}.fastp.json | tail -1 | awk -F ": " '{print $2}' | tr -d ",")
  printf "$sampleid\t$raw_read_count\n"
done | sort -h

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/RAW_read_run_results

AR27J 11055148

for sample in "${sampleID_array[@]}"
do
  sampleid="$sample"
  metaphlan_read_count=$(grep 'estimated_reads_mapped_to_known_clades' ${sampleid}_Metaphlan2-output_abundance_and_read_counts.txt | awk -F ":" '{print $2}')
  printf "$sampleid\t$metaphlan_read_count\n"
done | sort -h -k1

for sample in "${sampleID_array[@]}"
do
  sampleid="$sample"
  kaiju_read_count=$(awk -F "\t" -v stotus="C" '$1 == stotus {print $0}' ${sampleid}.Kaiju_output_20_allowed_errors.Taxon_names_added.out | wc -l)
  printf "$sampleid\t$kaiju_read_count\n"
done | sort -k1 -h

for sample in "${sampleID_array[@]}"
do
  sampleid="$sample"
  krak_file=$(find -maxdepth 1 -type f -name "Classified_Kraken2*${sampleid}*1.txt.gz")
  kraken_read_count=$(echo "$(zcat $krak_file | wc -l) / 4" | bc -l)
  printf "$sampleid\t$kraken_read_count\n"
done | sort -k1 -h

AR9N	641123.00000000000000000000
echo "$(wc -l ERR3357615_R2.QCed.fq.Cleansed.fq.Subsampled.fq | awk -F " " '{print $1}') / 4" | bc -l

#processed files
for sample in "${sampleID_array[@]}"
do
  sampleid="$sample"
  metaphlan_file=$(find -maxdepth 1 -type f -name "${sampleid}*Metaphlan2-output_abundance_and_read_counts.txt" -not -name "*pilot*")
  metaphlan_read_count=$(grep 'estimated_reads_mapped_to_known_clades' $metaphlan_file | awk -F ":" '{print $2}')
  printf "$sampleid\t$metaphlan_read_count\n"
done | sort -h -k1

for sample in "${sampleID_array[@]}"
do
  sampleid="$sample"
  kaiju_read_count=$(awk -F "\t" -v errors="20" '$2 == errors {print $0}' 2022_06_07-All_processed_samples_all_error_allowances_Kaiju_reads_classified_unclassified_percent_classified.tsv | grep "$sampleid" | awk -F "\t" '{print $3}' | head -1)
  printf "$sampleid\t$kaiju_read_count\n"
done | sort -k1 -h

for sample in "${sampleID_array[@]}"
do
  sampleid="$sample"
  krak_file=$(find -maxdepth 1 -type f -name "Classified_Kraken2*${sampleid}*010_conf_score_1.txt.gz")
  kraken_read_count=$(echo "$(zcat $krak_file | wc -l) / 4" | bc -l)
  printf "$sampleid\t$kraken_read_count\n"
done | sort -k1 -h

for sample in "${sampleID_array[@]}"
do
  sampleid="$sample"
  reads_file="2022-07-18_reads_in_R1_files.tsv"
  read_count=$(awk -F "\t" -v sampleid="$sampleid" '$1 == sampleid {print $2}' "$reads_file")
  printf "$sampleid\t$read_count\n"
done | sort -k1 -h


/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kraken

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files

2022-10-27
awk -F "\t" -v simples="AR34N" '{for (i=1;i<=NF;i++) { if ($i == simples) { print i } }}' 2022-09-11_0_allowed_errors_combined_results_all_processed_subsampled_files_species_level_results_all_potential_taxID_percentages.tsv
4954 is empty line AR34N field of big table
awk 'BEGIN { printf "Line numbers of empty lines in " ARGV[1] ": " } !NF { printf sep NR ; sep="," } END { printf "\n" }' file.txt

awk -F "\t" '{print $65}' 2022-09-11_0_allowed_errors_combined_results_all_processed_subsampled_files_species_level_results_all_potential_taxID_percentages.tsv | grep -E --line-number '^\s*$'

AC19J	Missing values
AC25J	Missing values
AC28J	Missing values
AC44N	Missing values
AC5J	Missing values
AC5N	Missing values
AC8J	Missing values
AR10J	Missing values
AR27J	Missing values
AR34N	Missing values
AR38J	Missing values

readarray -t sampleID_array < <(awk -F "\t" '$2 == "Missing values" {print $1}' 2022_09_11_0_errors_allowed_species_results_check_for_missing_percentages.txt | sort -V)
for sample in "${sampleID_array[@]}"
do
  sampleid="$sample"
  field_in_file=$(awk -F "\t" -v simples="$sampleid" '{for (i=1;i<=NF;i++) { if ($i == simples) { print i } }}' 2022-09-11_0_allowed_errors_combined_results_all_processed_subsampled_files_species_level_results_all_potential_taxID_percentages.tsv | tr -d ":")
  missing_line=$(awk -F "\t" -v fieldy="$field_in_file" '{print $fieldy}' 2022-09-11_0_allowed_errors_combined_results_all_processed_subsampled_files_species_level_results_all_potential_taxID_percentages.tsv | grep -E --line-number '^\s*$' | tr -d ":")
  printf "$sampleid\t$field_in_file\t$missing_line\n" >> 2022-10-27_samples_with_missing_values_colnums_in_big_file_and_row_with_missing_values.tsv
done

awk -F "\t" -v simples="AC5N" '{for (i=1;i<=NF;i++) { if ($i == simples) { print i } }}' 2022-09-11_0_allowed_errors_combined_results_all_processed_subsampled_files_species_level_results_all_potential_taxID_percentages.tsv
awk -F "\t" '{print $38}' 2022-09-11_0_allowed_errors_combined_results_all_processed_subsampled_files_species_level_results_all_potential_taxID_percentages.tsv | grep -E --line-number '^\s*$'
AC5N	38	5152

155322

awk -F "\t" -v thingy="155322" '$4 == thingy {print $0;}' AC5N.Kaiju2table_0_errors_allowed-species_level_results.tsv
AC11J

0.000487
awk -F "\t" -v thingy="155322" '$4 == thingy {print $0;}' AC11J.Kaiju2table_0_errors_allowed-species_level_results.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files

2022-11-01
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/metaphlan
awk -F "\t" '{print $1}' *Metaphlan2-output_abundance_and_read_counts.txt | sort -h | uniq | grep -v "#" > 2022-11-01_list_all_sample_files_all_unique_clade_names.txt

targets=$(find -maxdepth 1 -type f -name "A*.Metaphlan2-output_abundance_and_read_counts.txt" -not -name "*_pilot_sample*")
whereiam="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/metaphlan"
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  list_file="${whereiam}/2022-11-01_list_all_sample_files_all_unique_clade_names.txt"
  subject_file=$(basename "$f")
  printf "$sampleID\n" > "${whereiam}/${sampleID}.abundances.txt"
  while IFS= read -r line
  do
    taxon="$line"
    taxon_abundance_file=$(awk -F "\t" -v taxon="$taxon" '$1 == taxon {print $3}' "$subject_file" || echo "0")
    if [[ -z "$taxon_abundance_file" ]]
    then
      taxon_abundance="0"
      printf "$taxon_abundance\n" >> "${whereiam}/${sampleID}.abundances.txt"
    else
      taxon_abundance="$taxon_abundance_file"
      printf "$taxon_abundance\n" >> "${whereiam}/${sampleID}.abundances.txt"
    fi
  done < "$list_file"
  printf "Handled file:\t$subject_file\n"
done


while read -r line ; do printf "$line" | rev | cut -f1 -d "|" | rev ; done < 2022-11-01_list_all_sample_files_all_unique_clade_names.txt > shorter_clade_names.txt

printf "Clade\tTaxon.level\n" > 2022-11-01_clade_short_names_and_taxon_level.txt
while read -r line
do
  clade=$(echo "$line")
  small_clade=$(echo "$clade" | awk -F "__" '{print $2}' | tr "_" " ")
  tax_level=$(echo "$clade" | awk -F "__" '{print $1}')
  taxon=$(awk -F " " -v clade_level="$tax_level" '$1 == clade_level {print $2}' taxa_single_letter_to_level_file.txt)
  printf "$small_clade\t$taxon\n" >> 2022-11-01_clade_short_names_and_taxon_level.txt
done < shorter_clade_names.txt

paste -d "\t" 2022-11-01_clade_short_names_and_taxon_level.txt *.abundances.txt > 2022-11-01_all_subsampled_files_metaphlan_results_all_possible_clades_relative_abundance_percentages.tsv

c Class
f Family
g Genus
k Kingdom
o Order
p Phylum
s Species

2022-11-08
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files
2022-06-23_0_allowed_errors_combined_results_all_processed_subsampled_files_phylum_level_results_all_potential_taxID_percentages.tsv

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp

2022-11-08_Kaiju_phylum_0_errors_all_processed_COPY.tsv

while IFS= read -r line
do
  taxID=$(echo "$line" | awk -F "\t" '{print $1}')
  names_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
  taxon_name=$(awk -F "\t" -v taxid="$taxID" -v type_of_name="scientific name" '$1 == taxid && $7 == type_of_name {print $3;}' "$names_file")
  printf "$taxID\t$taxon_name\n" >> "Kaiju_0_errors_phylum_taxids_to_taxons_list_file.tsv"
done < 2022-11-08_Kaiju_phylum_0_errors_all_processed_COPY.tsv

2022_06_22_0_errors_allowed_class_results_all_unique_taxa.txt

while IFS= read -r line
do
  taxID=$(echo "$line")
  names_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
  taxon_name=$(awk -F "\t" -v taxid="$taxID" -v type_of_name="scientific name" '$1 == taxid && $7 == type_of_name {print $3;}' "$names_file")
  printf "$taxID\t$taxon_name\n" >> "Kaiju_0_errors_class_taxids_to_taxons_list_file.tsv"
done < 2022_06_22_0_errors_allowed_class_results_all_unique_taxa.txt && printf "Finished the class one\n"

while IFS= read -r line
do
  taxID=$(echo "$line")
  names_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
  taxon_name=$(awk -F "\t" -v taxid="$taxID" -v type_of_name="scientific name" '$1 == taxid && $7 == type_of_name {print $3;}' "$names_file")
  printf "$taxID\t$taxon_name\n" >> "Kaiju_0_errors_order_taxids_to_taxons_list_file.tsv"
done < 2022_06_22_0_errors_allowed_order_results_all_unique_taxa.txt && printf "Finished the order one\n"

while IFS= read -r line
do
  taxID=$(echo "$line")
  names_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
  taxon_name=$(awk -F "\t" -v taxid="$taxID" -v type_of_name="scientific name" '$1 == taxid && $7 == type_of_name {print $3;}' "$names_file")
  printf "$taxID\t$taxon_name\n" >> "Kaiju_0_errors_family_taxids_to_taxons_list_file.tsv"
done < 2022_06_22_0_errors_allowed_family_results_all_unique_taxa.txt && printf "Finished the family one\n"

while IFS= read -r line
do
  taxID=$(echo "$line")
  names_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
  taxon_name=$(awk -F "\t" -v taxid="$taxID" -v type_of_name="scientific name" '$1 == taxid && $7 == type_of_name {print $3;}' "$names_file")
  printf "$taxID\t$taxon_name\n" >> "Kaiju_0_errors_genus_taxids_to_taxons_list_file.tsv"
  line_number=$(grep -nw "$taxID" 2022_06_22_0_errors_allowed_genus_results_all_unique_taxa.txt | awk -F ":" '{print $1}')
  printf "Processed line:\t$line_number of 4570\n"
done < 2022_06_22_0_errors_allowed_genus_results_all_unique_taxa.txt && printf "Finished the genus one\n"

while IFS= read -r line
do
  taxID=$(echo "$line")
  names_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
  taxon_name=$(awk -F "\t" -v taxid="$taxID" -v type_of_name="scientific name" '$1 == taxid && $7 == type_of_name {print $3;exit;}' "$names_file")
  printf "$taxID\t$taxon_name\n" >> "Kaiju_0_errors_species_taxids_to_taxons_list_file.tsv"
  line_number=$(grep -nw "$taxID" 2022_06_22_0_errors_allowed_genus_results_all_unique_taxa.txt | awk -F ":" '{print $1}')
  printf "Processed line:\t$line_number of 4570\n"
done < 2022_06_22_0_errors_allowed_species_results_all_unique_taxa.txt && printf "Finished the species one\n"

awk -F ";p__" '{print $2}' 2022-11-08_strict_bins_GTDB-TK_full_name.txt | awk -F ";" '{print $1}' | sort -h | uniq | awk 'NF' > 2022_strict_bins_list_unique_phyla.txt

2022_strict_bins_list_unique_phyla.txt

awk -F ";p__" '{print $2}' 2022-11-08_strict_bins_GTDB-TK_full_name.txt | awk -F ";" '{print $1}' | sort -h | uniq | awk 'NF' > 2022_strict_bins_list_unique_phyla.txt
awk -F ";p__" '{print $2}' 2022-11-08_strict_bins_GTDB-TK_full_name.txt | awk -F ";" '{print $1}' | sort -h > temp_phyla_list.txt
while IFS= read -r line
do
  phylum="$line"
  line_occurence=$(grep -wc "$phylum" temp_phyla_list.txt)
  printf "$phylum\t$line_occurence\n"
done < 2022_strict_bins_list_unique_phyla.txt
rm temp_phyla_list.txt

awk -F ";f__" '{print $2}' 2022-11-08_strict_bins_GTDB-TK_full_name.txt | awk -F ";" '{print $1}' | sort -h | uniq | awk 'NF' > 2022_strict_bins_list_unique_family.txt
awk -F ";f__" '{print $2}' 2022-11-08_strict_bins_GTDB-TK_full_name.txt | awk -F ";" '{print $1}' | sort -h > temp_family_list.txt
while IFS= read -r line
do
  phylum="$line"
  line_occurence=$(grep -wc "$phylum" temp_family_list.txt)
  printf "$phylum\t$line_occurence\n"
done < 2022_strict_bins_list_unique_family.txt
rm temp_family_list.txt

awk -F ";g__" '{print $2}' 2022-11-08_strict_bins_GTDB-TK_full_name.txt | awk -F ";" '{print $1}' | sort -h | uniq | awk 'NF' > 2022_strict_bins_list_unique_family.txt

2814657

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp

2022-11-08_Kaiju_phylum_0_errors_all_processed_COPY.tsv
Kaiju_0_errors_phylum_taxids_to_taxons_list_file.tsv

2022-11-10
2022-11-08_strict_bins_GTDB-TK_full_name.txt
2022-11-10_strict_bins_tree_to_edit.nwk

2022-11-08_strict_bins_GTDB-TK_full_name.txt

while read -r line
do
  binname=$(printf "$line" | awk -F " " '{print $1}')
  family=$(printf "$line" | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}')
  genus=$(printf "$line" | awk -F ";g__" '{print $2}' | awk -F ";s__" '{print $1}')
  if [ -z "$genus" ]
  then
    printf "$binname\t$family\tFAMILY\n"
  elif [ ! -z "$genus" ]
  then
    printf "$binname\t$genus\tGENUS\n"
  else
    printf "Fucked up\n"
  fi
done < 2022-11-08_strict_bins_GTDB-TK_full_name.txt | grep -v "Bin.name" > 2022-11-10_strict_bins_genus_or_family_name_and_indicator.tsv

while read -r line
do
  binname=$(printf "$line" | awk -F " " '{print $1}')
  family=$(printf "$line" | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}')
  genus=$(printf "$line" | awk -F ";g__" '{print $2}' | awk -F ";s__" '{print $1}')
  if [ -z "$genus" ]
  then
    printf "$binname\t$family\tFAMILY\n"
  elif [ ! -z "$genus" ]
  then
    printf "$binname\t$family\tGENUS\n"
  else
    printf "Fucked up\n"
  fi
done < 2022-11-08_strict_bins_GTDB-TK_full_name.txt | grep -v "Bin.name" > 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv

while read -r line
do
  binname=$(printf "$line" | awk -F "\t" '{print $1}')
  family=$(printf "$line" | awk -F "\t" '{print $2}')
  sed -i -e "s/$binname/$family/g" 2022-11-10_strict_bins_tree_to_edit.nwk
  printf "Replaced $binname with $family in tree\n"
done < 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv

awk -F "\t" '{print $2}' 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv | sort -h | uniq -c | sort -bgr

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_subsampled_reads_merged_contigs_strict_bins_fasta
Subsampled_reads_Minimap2_mapping_strict_bins_concatenated_single_contig_entire_bin.bam

targets=$(find -maxdepth 2 -type f -name "*Subsampled_reads_Minimap2_mapping_strict_bins_concatenated_single_contig_entire_bin.bam")
for f in $targets
do
  sampleid=$(basename "$f" | awk -F "." '{print $1}')
  percent_mapped=$(samtools flagstat "$f" | grep "mapped" | head -1 | awk -F "(" '{print $2}' | awk -F " :" '{print $1}' | tr -d "%")
  printf "$sampleid\t$percent_mapped\n" >> 2022-11-10_samtools_flagstats_mapping_percentage_from_BAM_files_merged_contigs_subsampled_read_file_mapping.tsv
  printf "Processed sample $sampleid\n"
done

2022-11-12
grep -f <(tail -9 2022_10_10_within_AC_seasonal_change_bins_only_novogene_paired_samples.tsv | awk -F "\t" '{print $1}') AC_enriched_and_corrected_pvalue_bins.txt

grep -v -f <(cat 2022-02-02_detailed_name_taxids_human_mock_known_members.tsv | awk -F "\t" '{print $5}') ./2022-02-22_all_unique_taxids_species_level_and_below_human_mock_from_NCBI.txt

2022-11-13
for f in Bin_*.fa
do
  bin_filename=$(basename "$f")
  bin_identity=$(basename "$f" | awk -F ".f" '{print $1}')
  bin_length=$(grep '>' "$f" | awk -F "len=" '{print $2}' | paste -sd+ | bc -l)
  original_contigs=$(grep '>' "$f" | wc -l)
  non_zero_flags=$(grep '>' "$f" | awk -F "flag=" '{print $2}' | awk -F " " '{print $1}' | grep -vw "0" | wc -l)
  printf ">${bin_identity} flag=0 multi=0 len=${bin_length} original_contigs=${original_contigs} original_non_zero_flags=${non_zero_flags}\n" >> "${bin_filename}.merged_contigs.fa"
  grep -v ">" "$f" | tr -d "\n" >> "${bin_filename}.merged_contigs.fa"
  mv "${bin_filename}.merged_contigs.fa" Merged_contigs_version/
  printf "Processed file:\t$f\n"
done

cat *.fa.merged_contigs.fa > 2022-11-14_all_bins_contigs_merged_concatenated_bins_file.fa

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/RAW_read_run_results

*Kaiju_output_20_allowed_errors.Taxon_names_added.out

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/RAW_read_run_results
targets=$(find -maxdepth 1 -type f -name "*Kaiju_output_20_allowed_errors.Taxon_names_added.out")
for f in $targets
do
  sampleid=$(basename "$f" | awk -F "." '{print $1}')
  unclassified_reads=$(awk -F "\t" -v status="U" '$1 == status {print $2}' "$f" | sed "s/$/\t${sampleid}/g")
  printf "$unclassified_reads\n" >> "2022-11-14_all_unclassified_reads_from_all_RAW_files_Kaiju_20_errors_allowed.tsv"
  printf "Processed file:\t$f\n"
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju
targets=$(find -maxdepth 1 -type f -name "Unclassified_Kraken2_*.050_conf_score_1.txt")
for f in $targets
do
  sampleid=$(basename "$f" | awk -F "." '{print $1}')
  unclassified_reads=$(grep "@A0" "$f" | sed "s/$/\t${sampleid}/g")
  printf "$unclassified_reads\n" >> "2022-11-14_all_unclassified_reads_from_all_subsampled_files_Kraken_50_percent_min_conf_score.tsv"
  printf "Processed file:\t$f\n"
done

targets=$(find -maxdepth 1 -type f -name "*Kaiju_output_0_allowed_errors.Taxon_names_added.out.gz" -not -name "*_pilot_sample*")
for f in $targets
do
  sampleid=$(basename "$f" | awk -F "." '{print $1}')
  zipped_file=$(basename "$f")
  gunzip "$f"
  unzipped_file=$(echo "${zipped_file%.*}")
  unclassified_reads=$(awk -F "\t" -v status="U" '$1 == status {print $2}' "$f" | sed "s/$/\t${sampleid}/g")
  printf "$unclassified_reads\n" >> "2022-11-14_all_unclassified_reads_from_all_RAW_files_Kaiju_20_errors_allowed.tsv"
  gzip "$unzipped_file"
  printf "Processed file:\t$f\n"
done

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

samtools view -f 12 -@ 2 -b -u AC23J.Subsampled_reads_Minimap2_mapping_strict_bins_concatenated_single_contig_entire_bin.bam > AC23J.Subsampled_reads_Minimap2_mapping_strict_bins_concatenated_single_contig_entire_bin.Unmapped_reads.bam
samtools fastq AC23J.Subsampled_reads_Minimap2_mapping_strict_bins_concatenated_single_contig_entire_bin.Unmapped_reads.bam > AC23J.Unmapped_reads.fastq

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/mapping_subsampled_reads_merged_contigs_strict_bins_fasta/AC23J_Minimap2_and_Salmon_output

Bin_m1503.fa
k141_15349567 flag=1 multi=46.9467 len=26173
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files

cat AC23J_mapped_read.txt
19676682

samtools view -c AC23J.Subsampled_reads_Minimap2_mapping_strict_bins_concatenated_single_contig_entire_bin.Mapped.Sorted.bam
2284688

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kraken
[osbourne@EI-HPC interactive kraken]$ targets=$(find -maxdepth 1 -type f -name "Unclassified_Kraken2_*.050_conf_score_1.txt")
[osbourne@EI-HPC interactive kraken]$ for f in $targets
> do
>   sampleid=$(basename "$f" | awk -F "." '{print $1}')
>   unclassified_reads=$(grep "@A0" "$f" | sed "s/$/\t${sampleid}/g")
>   printf "$unclassified_reads\n" >> "2022-11-14_all_unclassified_reads_from_all_subsampled_files_Kraken_50_percent_min_conf_score.tsv"
>   printf "Processed file:\t$f\n"
> done

2022-11-17
grep -wcf <(awk -F "\t" -v family="Anaeroplasmataceae" '$2 == family {print $1}' 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv) 2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt

2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt

while read -r line
do
  binname="$line"
  genus=$(awk -F "\t" -v binname="$binname" '$1 == binname {print $2"\t"$3;exit;}' 2022-11-10_strict_bins_genus_or_family_name_and_indicator.tsv)
  printf "$binname\t$genus\n"
done < 2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt

2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv

while read -r line
do
  binname="$line"
  family=$(awk -F "\t" -v binname="$binname" '$1 == binname {print $2;exit;}' 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv)
  printf "$binname\t$family\n"
done < 2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt

grep 'Lachnospiraceae' <(while read -r line
do
  binname="$line"
  family=$(awk -F "\t" -v binname="$binname" '$1 == binname {print $2;exit;}' 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv)
  printf "$binname\t$family\n"
done < 2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt
) | awk -F "\t" '{print $1}'

grep -wf <(grep 'Lachnospiraceae' <(while read -r line
do
  binname="$line"
  family=$(awk -F "\t" -v binname="$binname" '$1 == binname {print $2;exit;}' 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv)
  printf "$binname\t$family\n"
done < 2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt
) | awk -F "\t" '{print $1}'
) 2022-11-10_strict_bins_genus_or_family_name_and_indicator.tsv | grep 'GENUS' | awk -F "\t" '{print $2}' | sort -h | uniq

grep -wf <(grep 'Lachnospiraceae' <(while read -r line
do
  binname="$line"
  family=$(awk -F "\t" -v binname="$binname" '$1 == binname {print $2;exit;}' 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv)
  printf "$binname\t$family\n"
done < 2022_10_10_AC_against_AR_enriched_1_or_greater_fold_change.Just_bin_names.txt
) | awk -F "\t" '{print $1}'
) 2022-11-10_strict_bins_genus_or_family_name_and_indicator.tsv | grep 'GENUS' | awk -F "\t" '{print $2}' | sort -h | uniq > tempar.txt

grep -wf <(cat AC_enriched_and_corrected_pvalue_bins.txt) 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv | grep 'Lachnospiraceae' | wc -l

grep -wf <(cat AR_enriched_and_corrected_pvalue_bins.txt) 2022-11-10_strict_bins_family_ONLY_name_and_indicator_of_if_genus_present.tsv | grep 'Lachnospiraceae' | wc -l

grep -wf <(cat AC_enriched_and_corrected_pvalue_bins.txt) 2022-11-10_strict_bins_genus_or_family_name_and_indicator.tsv | grep 'GENUS' | awk -F " " '{print $2}' | sort -h | uniq > tempar.txt
while read -r line
do
  genus="$line"
  occurrence=$(grep -wf <(cat AC_enriched_and_corrected_pvalue_bins.txt) 2022-11-10_strict_bins_genus_or_family_name_and_indicator.tsv | grep 'GENUS' | awk -F "\t" '{print $2}' | sort -h | grep -wc "$line")
  printf "$genus\t$occurrence\n"
done < tempar.txt | sort -k2 -V


grep -wf <(cat AR_enriched_and_corrected_pvalue_bins.txt) 2022-11-10_strict_bins_genus_or_family_name_and_indicator.tsv | grep 'GENUS' | awk -F " " '{print $2}' | sort -h | uniq > tempar.txt
while read -r line
do
  genus="$line"
  occurrence=$(grep -wf <(cat AR_enriched_and_corrected_pvalue_bins.txt) 2022-11-10_strict_bins_genus_or_family_name_and_indicator.tsv | grep 'GENUS' | awk -F "\t" '{print $2}' | sort -h | grep -wc "$line")
  printf "$genus\t$occurrence\n"
done < tempar.txt | sort -k2 -V

CAG-873

grep -wf <(cat AR_enriched_and_corrected_pvalue_bins.txt) 2022-11-10_strict_bins_genus_or_family_name_and_indicator.tsv | grep 'GENUS' | awk -F " " '{print $2}' | sort -h | uniq > tompar.txt

2022-11-23
The isolate assemblies below had been blocked from jolytree because they gave negative branch lengths

18A_S9-contigs.fasta.Contigs_min_length_500bp.fa.TEMP_BLOCK_Jolytree_gives_negative_branch_lengths
18E_S13-contigs.fasta.Contigs_min_length_500bp.fa.TEMP_BLOCK_Jolytree_gives_negative_branch_lengths

2022-11-24
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMask_output

target_files=$(find -maxdepth 1 -type f -name "*.fa")
for f in $target_files
do
  printf "Will gzip file:\t$f\n"
  gzip "$f"
  printf "Processed file:\t$f\n"
done

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes

13B_S2-contigs.fasta.Contigs_min_length_500bp.fa
39A_S14-contigs.fasta.Contigs_min_length_500bp.fa

source package eab121cb-2eb8-49c1-a9a5-a33754ea9fea #MUMmer - 4.0.0beta2

nucmer 13B_S2-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa 39A_S14-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa
show-coords -c out.delta > coords_test.coords

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/FastANI_output
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/GTDB-TK_output/classify_wf
awk -F "\t" '{print $2}' classify/gtdbtk.bac120.summary.tsv | awk -F ";g__" '{print $2}'

temp_thing=$(awk -F "\t" '{print $2}' classify/gtdbtk.bac120.summary.tsv | awk -F ";g__" '{print $2}')
while IFS= read -r line;
do
  genus_level=$(printf "$line" | awk -F ";s__" '{print $1}')
  species_level=$(printf "$line" | awk -F ";s__" '{print $2}')
  if [ -z "$species_level" ]
  then
    printf "$genus_level\n"
  elif [[ ! -z "$species_level" ]]
  then
    printf "$species_level\n"
  fi
done <<< "$temp_thing"

2022-11-26
13B_S2-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa
39A_S14-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa
72513D_S4-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes

source package 7d170f8e-6196-4ce5-81e9-a9800ab05137 #FastANI 1.3
fastANI -q 13D_S4-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa --rl list_of_bins.txt -o 13D_S4.500bp_min_contigs.BBMasked.txt
fastANI -q 16aA_S24-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa --rl list_of_bins.txt -o 16aA_S24.500bp_min_contigs.BBMasked.txt
16aD_S27-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa
fastANI -q 16aD_S27-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa --rl list_of_bins.txt -o 16aD_S27.500bp_min_contigs.BBMasked.txt

find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa" -printf '%f\n' > list_of_isolates.txt

while IFS= read -r line;
do
  isolate=$(printf "$line" | awk -F "-contigs.fasta.Co" '{print $1}')
  printf "Processing isolate:\t$isolate\n"
  fastANI -q "$line" --rl list_of_bins.txt -o "${isolate}.500bp_min_contigs.BBMasked.txt"
  printf "Finished processing isolate:\t$isolate\n"
done < list_of_isolates.txt

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/genomes_from_Nancy_Teng_and_David_Baker_Lactobacillus_culturing_from_pilot_samples/QIB-Nancy-Teng-210326/PID-0578-r-Neg
reformat.sh in=reads.fastq out=reads.fasta
gunzip PID-0578-r-Neg_S30_R2_001.fastq.gz
reformat.sh in=/hpc-home/osbourne/Lac_culturing_negative_control_reads_R1.fastq out=/hpc-home/osbourne/Lac_culturing_negative_control_reads_R1.fasta

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes

2022-11-27
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/GTDB-TK_output/classify_wf

classify/gtdbtk.bac120.summary.tsv

awk -F "\t" '{print $1"\t"$2}' classify/gtdbtk.bac120.summary.tsv

while IFS= read -r line;
do
  isolate=$(printf "$line" | awk -F "\t" '{print $1}' | awk -F "-contigs" '{print $1}')
  genus=$(printf "$line" | awk -F "\t" '{print $2}' | awk -F ";s__" '{print $1}' | awk -F ";g__" '{print $2}')
  printf "$isolate\t$genus\n"
done < <(awk -F "\t" '{print $1"\t"$2}' classify/gtdbtk.bac120.summary.tsv | grep -v "user\|16aC_26\|18E_S13\|S125") > 2022-11-27_genus_classification_unique_and_not_contaminated_isolates.tsv

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Barrnap_output
grep 'Name=16S_rRNA;product=16S ribosomal RNA' * | grep -v "16aC_26\|18E_S13\|S125\|partial"

grep 'Name=23S_rRNA;product=23S ribosomal RNA' *.gff3 | grep -v "partial" | wc -l
grep 'Name=5S_rRNA;product=5S ribosomal RNA' *.gff3 | grep -v "partial" | wc -l

grep 'Name=16S_rRNA;product=16S ribosomal RNA' * | grep -v 'partial'

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes

source package eab121cb-2eb8-49c1-a9a5-a33754ea9fea #MUMmer - 4.0.0beta2

nucmer 13B_S2-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa 39A_S14-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa
show-coords -c out.delta > coords_test.coords

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes

2022-11-28
ls -l *contigs*.fa | awk -F " " '{print $9}' > 2022-11-28_list_all_isolates_bbmasked_assembly_files_min_500bp_contig_size.txt
cat 2022-11-28_list_all_isolates_bbmasked_assembly_files_min_500bp_contig_size.txt | head -25 > 2022-11-28_list_Acomys_isolates_bbmasked_assembly_files_min_500bp_contig_size.txt

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/MUMmer_output
18A_S9-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1569.fa.BBMasked.fa	99.0785	505	720

S121-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c770.fa.BBMasked.fa	91.7693	557	720
S122-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c770.fa.BBMasked.fa	91.5678	553	746
S123-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c770.fa.BBMasked.fa	91.6704	566	749
S124-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c770.fa.BBMasked.fa	80.7602	322	644
S126-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c770.fa.BBMasked.fa	91.5843	568	704
S127-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c770.fa.BBMasked.fa	91.5291	552	720
S128-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c770.fa.BBMasked.fa	80.8304	344	670

grep -f <(cat /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/2022-11-28_list_Acomys_isolates_bbmasked_assembly_files_min_500bp_contig_size.txt) *FastANI_matches_over_99_percent.txt | grep -v 'Bin'

mummerplot --fat --png --large 16aF_S29_Nucmer_against_41B_S7.delta -p 16aF_S29_Nucmer_against_41B_S7_TRIAL
16aF_S29_Nucmer_against_41B_S7_TRIAL.rplot
cat 16aF_S29_Nucmer_against_41B_S7_TRIAL.fplot 16aF_S29_Nucmer_against_41B_S7_TRIAL.rplot | grep -v \# | sed 's/^$/NA NA NA/' > /hpc-home/osbourne/16aF_S29_Nucmer_against_41B_S7_TRIAL.coords.plot

18B_S10-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	13E_S5-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	99.163	635	732

18B_S10_Nucmer_against_13E_S5.delta
mummerplot --fat --png --large 18B_S10_Nucmer_against_13E_S5.delta -p 18B_S10_Nucmer_against_13E_S5_TRIAL
tail -n+2 18B_S10_Nucmer_against_13E_S5_TRIAL.fplot | awk 'NF' > /hpc-home/osbourne/trial_pt3.plot

cat 2022-11-28_all_over_99_percent_matches.txt | head -15 | grep -v 'Bin' > 2022-11-28_Acomys_vs_Acomys_over_99_percent_matches.txt

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Bins_FastANI_results/2022-11-28_Acomys_vs_Acomys_over_99_percent_matches.txt

source package eab121cb-2eb8-49c1-a9a5-a33754ea9fea #MUMmer - 4.0.0beta2
input_list="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Bins_FastANI_results/2022-11-28_Acomys_vs_Acomys_over_99_percent_matches.txt"
while IFS= read -r line
do
  isolate_1=$(printf "$line" | awk -F "\t" '{print $1}')
  isolate_2=$(printf "$line" | awk -F "\t" '{print $2}')
  isolate_1_ID=$(echo "$isolate_1" | awk -F "-" '{print $1}')
  isolate_2_ID=$(echo "$isolate_2" | awk -F "-" '{print $1}')
  combo_file=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta")
  printf "Making files for isolates $isolate_1_ID and $isolate_2_ID\n"
  mummerplot --fat --png --large "$combo_file" -p "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_deleteable"
  tail -n+2 "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_deleteable.fplot" | awk 'NF' > "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_forward_reads.plot"
  targets_to_delete=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_deleteable*")
  for f in $targets_to_delete
  do
    rm "$f"
    printf "Deleted file:\t$f\n"
  done
done < "$input_list"

NODE_10_length_60627_cov_42.881282 NODE_13_length_60502_cov_37.051698
reference query

input_list="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Bins_FastANI_results/2022-11-28_Acomys_vs_Acomys_over_99_percent_matches.txt"
while IFS= read -r line
do
  isolate_1=$(printf "$line" | awk -F "\t" '{print $1}')
  isolate_2=$(printf "$line" | awk -F "\t" '{print $2}')
  isolate_1_ID=$(echo "$isolate_1" | awk -F "-" '{print $1}')
  isolate_2_ID=$(echo "$isolate_2" | awk -F "-" '{print $1}')
  combo_file=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta")
  printf "Making files for isolates $isolate_1_ID and $isolate_2_ID\n"
  mummerplot --coverage --fat --png --large "$combo_file" -p "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_coverage_deleteable"
  tail -n+2 "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_coverage_deleteable.fplot" | awk 'NF' | sort -V -k1 > "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_forward_reads_coverage.plot"
  targets_to_delete=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_coverage_deleteable*")
  for f in $targets_to_delete
  do
    rm "$f"
    printf "Deleted file:\t$f\n"
  done
done < "$input_list"

query against reference
tail -n+2 coverage_trial.fplot | awk 'NF' | sort -V -k1 > testing.coverage.plot

2022-11-28_placeholder_Rscript_for_decent_ggplot_coverage_figures_ANI_similarities_acomys_isolates_over_99_point_9_percent.txt
2022-11-28_Rscript_for_decent_ggplot_coverage_figures_ANI_similarities_acomys_isolates_over_99_point_9_percent_rscript.R

input_list="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Bins_FastANI_results/2022-11-28_Acomys_vs_Acomys_over_99_percent_matches.txt"
while IFS= read -r line
do
  isolate_1=$(printf "$line" | awk -F "\t" '{print $1}')
  isolate_2=$(printf "$line" | awk -F "\t" '{print $2}')
  zukswang=$(echo "$isolate_1" | awk -F "-" '{print $1}')
  albatross=$(echo "$isolate_2" | awk -F "-" '{print $1}')
  cp 2022-11-28_placeholder_Rscript_for_decent_ggplot_coverage_figures_ANI_similarities_acomys_isolates_over_99_point_9_percent.txt temp_placeholder.txt
  sed -i -e "s/ZUKSWANG/$zukswang/g" temp_placeholder.txt
  sed -i -e "s/ALBATROSS/$albatross/g" temp_placeholder.txt
  cat temp_placeholder.txt >> 2022-11-28_Rscript_for_decent_ggplot_coverage_figures_ANI_similarities_acomys_isolates_over_99_point_9_percent_rscript.R
  rm temp_placeholder.txt
done < "$input_list"

delta-filter -r -q 39B_S15_Nucmer_against_18A_S9.delta > 39B_S15_Nucmer_against_18A_S9.filtered.delta
mummerplot --fat --png --large 39B_S15_Nucmer_against_18A_S9.filtered.delta -p this_shite
tail -n+2 this_shite.fplot | awk 'NF' | sort -V -k1 > this_shite.plot

input_list="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Bins_FastANI_results/2022-11-28_Acomys_vs_Acomys_over_99_percent_matches.txt"
while IFS= read -r line
do
  isolate_1=$(printf "$line" | awk -F "\t" '{print $1}')
  isolate_2=$(printf "$line" | awk -F "\t" '{print $2}')
  isolate_1_ID=$(echo "$isolate_1" | awk -F "-" '{print $1}')
  isolate_2_ID=$(echo "$isolate_2" | awk -F "-" '{print $1}')
  combo_file=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta")
  printf "Filtering ${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta\n"
  delta-filter -r -q "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta" > "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.filtered.delta"
  printf "Making files for isolates $isolate_1_ID and $isolate_2_ID\n"
  mummerplot --fat --png --large "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.filtered.delta" -p "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_delta_deleteable"
  tail -n+2 "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_delta_deleteable.fplot" | awk 'NF' | sort -V -k1 > "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_delta.plot"
  targets_to_delete=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_delta_deleteable*")
  for f in $targets_to_delete
  do
    rm "$f"
    printf "Deleted file:\t$f\n"
  done
  mummerplot --coverage --fat --png --large "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta" -p "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_coverage_deleteable"
  tail -n+2 "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_coverage_deleteable.fplot" | awk 'NF' | sort -V -k1 > "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_forward_reads_filtered_coverage.plot"
  targets_to_delete=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_coverage_deleteable*")
  for f in $targets_to_delete
  do
    rm "$f"
    printf "Deleted file:\t$f\n"
  done
done < "$input_list"

input_list="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Bins_FastANI_results/2022-11-28_Acomys_vs_Acomys_over_99_percent_matches.txt"
while IFS= read -r line
do
  isolate_1=$(printf "$line" | awk -F "\t" '{print $1}')
  isolate_2=$(printf "$line" | awk -F "\t" '{print $2}')
  zukswang=$(echo "$isolate_1" | awk -F "-" '{print $1}')
  albatross=$(echo "$isolate_2" | awk -F "-" '{print $1}')
  cp 2022-11-28_placeholder_Rscript_for_decent_ggplot_coverage_figures_ANI_similarities_acomys_isolates_over_99_point_9_percent.txt temp_placeholder.txt
  sed -i -e "s/ZUKSWANG/$zukswang/g" temp_placeholder.txt
  sed -i -e "s/ALBATROSS/$albatross/g" temp_placeholder.txt
  cat temp_placeholder.txt >> 2022-11-28_Rscript_for_decent_ggplot_coverage_figures_ANI_similarities_acomys_isolates_over_99_point_9_percent_rscript.R
  rm temp_placeholder.txt
done < "$input_list"

mummerplot --fat --png --large "13B_S2_Nucmer_against_39A_S14.filtered.delta" -p "13B_S2_Nucmer_against_39A_S14.filtered.delta_deleteable"
mummerplot --coverage --fat --png --large "13B_S2_Nucmer_against_39A_S14.filtered.delta" -p "13B_S2_Nucmer_against_39A_S14.filtered.delta_coverage_deleteable"

tail -n+2 13B_S2_Nucmer_against_39A_S14.filtered.delta_deleteable.fplot | awk 'NF' > /hpc-home/osbourne/13B_S2_Nucmer_against_39A_S14.filtered.delta_deleteable.fplot
tail -n+2 13B_S2_Nucmer_against_39A_S14.filtered.delta_deleteable.rplot | awk 'NF' > /hpc-home/osbourne/13B_S2_Nucmer_against_39A_S14.filtered.delta_deleteable.rplot

2022-11-29
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes

./all_contig_assemblies_contigs_under_500_bp_removed/BBMask_output/3_Oct_2022-All_BBMasked_processed_isolates_and_827_BBmasked_reference_genomes.nwk

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Mapping_output

targets=$(find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa")
for f in $targets
do
  sample_ID=$(basename "$f" | awk -F "-" '{print $1}')
  sample_file_name=$(basename "$f")
  total_length=$(grep '>' "$f" | awk -F "length_" '{print $2}' | awk -F "_cov_" '{print $1}' | paste -sd+ | bc -l)
  original_contigs=$(grep '>' "$f" | wc -l)
  total_coverage=$(grep '>' "$f" | awk -F "_cov_" '{print $2}' | paste -sd+ | bc -l)
  printf ">${sample_ID} total_length=${total_length} total_coverage=${total_coverage} number_original_contigs=${original_contigs}\n" > "${sample_ID}.BBMasked.min_500bp_contigs.All_contigs_merged.fa"
  genomic_content=$(grep -v ">" "$f" | tr -d "\n")
  printf "$genomic_content\n" >> "${sample_ID}.BBMasked.min_500bp_contigs.All_contigs_merged.fa"
  printf "Processed file:\t$f\n"
done

targets2=$(find -maxdepth 1 -type f -name "*BBMasked.min_500bp_contigs.All_contigs_merged.fa" -not -name "S12*")
for f in $targets2
do
  cat "$f" >> 2022-11-29_all_Acomys_isolates_BBMasked_min_contigs_500bp_concatenated_all_contigs_merged.fa
done

2022-11-29_all_Acomys_isolates_BBMasked_min_contigs_500bp_concatenated_all_contigs_merged.fa
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes
2022-11-29_list_read_IDs_novogene_paired_only.txt

2022-11-30
echo "$(wc -l AC33N.QCed.Cleansed.R1.fq | awk -F " " '{print $1}') / 4" | bc -l
salmon index -t 2022-11-29_all_Acomys_isolates_BBMasked_min_contigs_500bp_concatenated_all_contigs_merged.fa -i 2022-11-29_all_Acomys_isolates_BBMasked_min_contigs_500bp_concatenated_all_contigs_merged_Salmon_index -k 31

source package eab121cb-2eb8-49c1-a9a5-a33754ea9fea #MUMmer - 4.0.0beta2
input_list="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Bins_FastANI_results/2022-11-28_Acomys_vs_Acomys_over_99_percent_matches.txt"
while IFS= read -r line
do
  isolate_1=$(printf "$line" | awk -F "\t" '{print $1}')
  isolate_2=$(printf "$line" | awk -F "\t" '{print $2}')
  isolate_1_ID=$(echo "$isolate_1" | awk -F "-" '{print $1}')
  isolate_2_ID=$(echo "$isolate_2" | awk -F "-" '{print $1}')
  combo_file=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta")
  printf "Filtering ${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta\n"
  delta-filter -r -q "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta" > "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.filtered.delta"
  printf "Making files for isolates $isolate_1_ID and $isolate_2_ID\n"
  mummerplot --fat --png --large "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.filtered.delta" -p "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_delta_deleteable"
  tail -n+2 "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_delta_deleteable.fplot" | awk 'NF' | sort -V -k1 > "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_delta.plot"
  targets_to_delete=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_delta_deleteable*")
  for f in $targets_to_delete
  do
    rm "$f"
    printf "Deleted file:\t$f\n"
  done
  mummerplot --coverage --fat --png --large "${isolate_1_ID}_Nucmer_against_${isolate_2_ID}.delta" -p "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_coverage_deleteable"
  tail -n+2 "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_coverage_deleteable.fplot" | awk 'NF' | sort -V -k1 > "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_forward_reads_filtered_coverage.plot"
  targets_to_delete=$(find -maxdepth 1 -type f -name "${isolate_1_ID}_MUMmer_against_${isolate_2_ID}_filtered_coverage_deleteable*")
  for f in $targets_to_delete
  do
    rm "$f"
    printf "Deleted file:\t$f\n"
  done
done < "$input_list"

input_list="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Bins_FastANI_results/2022-11-28_Acomys_vs_Acomys_over_99_percent_matches.txt"
while IFS= read -r line
do
  isolate_1=$(printf "$line" | awk -F "\t" '{print $1}')
  isolate_2=$(printf "$line" | awk -F "\t" '{print $2}')
  zukswang=$(echo "$isolate_1" | awk -F "-" '{print $1}')
  albatross=$(echo "$isolate_2" | awk -F "-" '{print $1}')
  cp 2022-11-28_placeholder_Rscript_for_decent_ggplot_coverage_figures_ANI_similarities_acomys_isolates_over_99_point_9_percent.txt temp_placeholder.txt
  sed -i -e "s/ZUKSWANG/$zukswang/g" temp_placeholder.txt
  sed -i -e "s/ALBATROSS/$albatross/g" temp_placeholder.txt
  cat temp_placeholder.txt >> 2022-11-28_Rscript_for_decent_ggplot_coverage_figures_ANI_similarities_acomys_isolates_over_99_point_9_percent_rscript.R
  rm temp_placeholder.txt
done < "$input_list"

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Mapping_output/AC5J-Mapping_and_Salmon_output

2022-11-29_all_Acomys_isolates_BBMasked_min_contigs_500bp_concatenated_all_contigs_merged_Salmon_index

salmon quant -t /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/2022-11-29_all_Acomys_isolates_BBMasked_min_contigs_500bp_concatenated_all_contigs_merged.fa -l A -a AC11N.Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.Mapped.Sorted.bam --threads 2 --seqBias --gcBias --writeUnmappedNames --numBootstraps 10 --no-version-check -o trial_salmon

41B_S7-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	S121-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	96.7352	594	763
41B_S7-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	S126-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	96.6933	602	763
41B_S7-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	S127-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	96.4227	593	763
41B_S7-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	S123-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	96.2433	609	763
41B_S7-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	S122-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	96.1277	617	763
41B_S7-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	S128-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	81.6154	367	763
41B_S7-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	S124-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	81.3922	347	763

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Barrnap_output

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Mapping_output

*/*Cleansed_not_subsampled_reads.Minimap2_mapping.Samtools_flagstat_output.txt
*/*Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.Samtools_flag_stat_output.txt
*/*Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.Mapped.Sorted.bam.Salmon_quantification.sf

awk -F "\t" '{print $1}' AC11J.Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.Mapped.Sorted.bam.Salmon_quantification.sf > 2022-12-02_list_assemblies_in_same_order_as_mapping.txt
printf "Host\nMonth\nHost.x.month\n" >> 2022-12-02_list_assemblies_in_same_order_as_mapping.txt

for f in *Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.Mapped.Sorted.bam.Salmon_quantification.sf
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  host=$(echo "$sampleID" | tr -d "[[:digit:]]" | tr -d "J,N")
  sample_month=$(echo "$sampleID" | tr -d "[[:digit:]]" | tr -d "A,C,R")
  month_and_host=$(echo "$sampleID" | tr -d "[[:digit:]]")
  contents=$(awk -F "\t" '{print $4}' "$f" | grep -v "TPM")
  printf "$sampleID\n$contents\n$host\n$sample_month\n$month_and_host\n" > "${sampleID}.temp.just_rpm.txt"
done

paste -d "\t" 2022-12-02_list_assemblies_in_same_order_as_mapping.txt *.temp.just_rpm.txt > 2022-12-02_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies.tsv
rm *.temp.just_rpm.txt

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/DFAST_output
./*/*-contigs_statistics.txt
grep 'Number of CDSs' ./*/*-contigs_statistics.txt

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Barrnap_output
13E_S5, 16aA_S24 and 41B_S7

13A_S1-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1485.fa.BBMasked.fa	79.6478	103	724
13A_S1-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c1617.fa.BBMasked.fa	78.9525	175	724
16aB_S25-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1485.fa.BBMasked.fa	79.1882	108	737
16aB_S25-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c1617.fa.BBMasked.fa	79.0265	178	737
16bA_S19-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c1617.fa.BBMasked.fa	82.133	342	676
16bA_S19-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1485.fa.BBMasked.fa	78.9913	96	676
16bB_S20-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c1617.fa.BBMasked.fa	79.2053	165	735
16bB_S20-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1485.fa.BBMasked.fa	79.1418	117	735
18A_S9-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1569.fa.BBMasked.fa	99.0785	505	720
18D_S12-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c1617.fa.BBMasked.fa	79.013	171	774
18D_S12-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1485.fa.BBMasked.fa	78.8881	117	774
39B_S15-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1569.fa.BBMasked.fa	98.8057	512	722
39C_S16-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c1617.fa.BBMasked.fa	80.2586	198	814
39C_S16-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1485.fa.BBMasked.fa	78.2539	91	814
39D_S17-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c1617.fa.BBMasked.fa	80.1351	201	727
39D_S17-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_m1485.fa.BBMasked.fa	78.3456	93	727
41B_S7-contigs.fasta.Contigs_min_length_500bp.fa.BBMasked.fa	Bin_c770.fa.BBMasked.fa	91.3642	551	763

for f in *MUMmer_against*filtered_delta.plot
do
  comparison=$(basename "$f" | awk -F "_filtered" '{print $1}')
  filtered_forward_coverage
done

show-coords -r -c -l 39B_S15_Nucmer_against_18A_S9.filtered.delta

2022-12-04
hereiam=$(pwd)
targets=$(find -maxdepth 2 -type f -name "*Cleansed_not_subsampled_reads.Minimap2_mapping.Samtools_flagstat_output.txt")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  cleansed_percent_mapped=$(grep "mapped" "$f" | head -1 | awk -F "(" '{print $2}' | awk -F " :" '{print $1}' | tr -d "%")
  subsampled_mapped_file=$(find -maxdepth 2 -type f -name "${sampleID}".Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.Samtools_flag_stat_output.txt)
  for f in $subsampled_mapped_file
  do
    export subsampled_percent_mapped=$(grep "mapped" "$f" | head -1 | awk -F "(" '{print $2}' | awk -F " :" '{print $1}' | tr -d "%")
  done
  host=$(echo "$sampleID" | tr -d "[[:digit:]]" | tr -d "J,N")
  sample_month=$(echo "$sampleID" | tr -d "[[:digit:]]" | tr -d "A,C,R")
  month_and_host=$(echo "$sampleID" | tr -d "[[:digit:]]")
  printf "$sampleID\t$cleansed_percent_mapped\t$host\t$sample_month\t$month_and_host\n" >> "${hereiam}/2022-11-30_not_subsampled_mapping_percentages.txt"
  printf "$sampleID\t$subsampled_percent_mapped\t$host\t$sample_month\t$month_and_host\n" >> "${hereiam}/2022-11-30_subsampled_mapping_percentages.txt"
  printf "Processed sample:\t$sampleID\n"
done


/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/seqtk_outputs/

2022_12_04_minimap2_mapping_concatenated_single_contig_all_bins_subsampled_pilot_samples_used_for_culturing_reads_array_list_R1_paths.txt

ls -lhtr | grep "AR27\|AR29\|AC16\|AC18\|AC13" | grep -v 'R2.fq' | awk -F " " '{print $9}' | sort -h | sed 's/^/@ei@.project-scratch@c@c33dfa31-8d66-4727-827b-ce9eb62d3237@2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping@seqtk_outputs@/g' | tr "@" "/"

tail -n +6 18B_S10_Nucmer_against_41B_S7_co-ordinates.coords | tr " " "@" | tr -d "|" | sed 's/@\+/\t/g'

source package 8d5e6fe6-0b34-4ff4-a645-0fe3209c0f75 #circlator - 1.5.5

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/DFAST_output/16aF_S29-contigs-DFAST_output

printf "Isolate\tPartial_gene\tFrameshift_gene\tInternal_stop_codon\n" > 2022-12-04_single_classification_pseudogenes_all_good_isolates.tsv
targets=$(find -maxdepth 2 -type f -name "*-contigs_pseudogene_summary.tsv" | grep -v "16aC_S26\|18E_S13\|S125")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  number_partial_genes=$(awk -F "\t" -v deletion="partial" '$4 == deletion {print $0}' "$f" | wc -l)
  number_frameshift_genes=$(awk -F "\t" -v deletion="frameshift" '$4 == deletion {print $0}' "$f" | wc -l)
  number_internal_stops=$(awk -F "\t" -v deletion="internal_stop_codon" '$4 == deletion {print $0}' "$f" | wc -l)
  printf "$sampleID\t$number_partial_genes\t$number_frameshift_genes\t$number_internal_stops\n"
done | sort -h -k1 >> 2022-12-04_single_classification_pseudogenes_all_good_isolates.tsv

targets=$(find -maxdepth 2 -type f -name "*-contigs_protein.faa" | grep -v "16aC_S26\|18E_S13\|S125")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  number_proteins_detected=$(grep -c ">" "$f")
  printf "$sampleID\t$number_proteins_detected\n"
done | sort -h -k1

targets=$(find -maxdepth 2 -type f -name "*-contigs_cds.fna" | grep -v "16aC_S26\|18E_S13\|S125")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  number_cds_detected=$(grep -c ">" "$f")
  printf "$sampleID\t$number_cds_detected\n"
done | sort -h -k1

targets=$(find -maxdepth 2 -type f -name "*-contigs_protein.faa" | grep -v "16aC_S26\|18E_S13\|S125")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  unique_products=$(grep '>' "$f" | cut -d " " -f 2- | sort -h | uniq)
  printf "$unique_products\n"
done | sort -h | uniq >> 2022-12-04_list_all_good_isolates_unique_proteins_from_all_faa_files.txt

targets=$(find -maxdepth 2 -type f -name "*-contigs_protein.faa" | grep -v "16aC_S26\|18E_S13\|S125")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  printf "Protein\t$sampleID\n" > "${sampleID}.count_all_possible_unique_proteins.tsv"
  while IFS= read -r line
  do
    protein="$line"    
    occurrence_of_protein=$(awk -v protein_name="$protein" '$0 == protein_name {print $0}' < <(grep '>' "$f" | cut -d " " -f 2- | sort -h) | wc -l)
    printf "$protein\t$occurrence_of_protein\n" >> "${sampleID}.count_all_possible_unique_proteins.tsv"
  done < 2022-12-04_list_all_good_isolates_unique_proteins_from_all_faa_files.txt
done

awk -F "\t" '{print $1}' 16bA_S19.count_all_possible_unique_proteins.tsv > 2022-12-04_list_unique_proteins_from_faas_in_same_order.txt
for f in *count_all_possible_unique_proteins.tsv
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}.proteins.temp.txt"
done
paste -d "\t" 2022-12-04_list_unique_proteins_from_faas_in_same_order.txt *proteins.temp.txt > 2022-12-04_all_isolates_all_possible_unique_proteins_from_faas_counts.tsv
rm *.proteins.temp.txt

cat 16aE_S28.count_all_possible_unique_proteins.tsv | sort -V -t$'\t' -k2
cat 16aE_S28.count_all_possible_unique_proteins.tsv | sort -Vr -t$'\t' -k2 | head

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/Acomys_reads/PRESERVED_PILOT_RAW_READS
find -maxdepth 2 -type f -name "*.sf" -and -name "AC16J*" -or -name "AC16N*" -or -name "AC18J*" -or -name "AC18N*" -or -name "AR27J*" -or -name "AR27N*" -or -name "AR29*" -or -name "AR29N*"

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/Mapping_output


./all_contig_assemblies_contigs_under_500_bp_removed/LI_and_UK_cultures_with_some_reference_genomes/14_May_2022-cpG31D1MqqjVM7qh7jLA106UwgMVwmstUO9XroDl4kbMHeIa5Dnk3bRKvi1HgjhgyDp2N97JDY3yYb1PSIxfjobzSJtiiebJ5EVNOsj4jgN0aLqNFgOHfyWzjIviEdj7.nwk
./all_contig_assemblies_contigs_under_500_bp_removed/joly_tree_outputs/li_and_uk_samples/CACTUS_SAFE_VERSION-29_Apr_2022-x9MdSi8bmxvdV4wyY8tR3OMfe84Yi90WpOJwNybd9eqJQUMUqRI0eZBAezrya8KCoL46Wo93vWuUXGq202JsuAOVSku0XBQMlIHQcOeXF2MW0NExbXynpFqm8CXNdqgP.nwk
./all_contig_assemblies_contigs_under_500_bp_removed/joly_tree_outputs/li_and_uk_samples/29_Apr_2022-x9MdSi8bmxvdV4wyY8tR3OMfe84Yi90WpOJwNybd9eqJQUMUqRI0eZBAezrya8KCoL46Wo93vWuUXGq202JsuAOVSku0XBQMlIHQcOeXF2MW0NExbXynpFqm8CXNdqgP.nwk
./all_contig_assemblies_contigs_under_500_bp_removed/BBMask_output/3_Oct_2022-All_BBMasked_processed_isolates_and_827_BBmasked_reference_genomes.nwk
./all_contig_assemblies_contigs_under_500_bp_removed/all_assemblies_plus_reference_genomes/23_May_2022-lPwQm3CMG7x2Vat25m9dgnHsBegTd0IeFkcnye9uhp2iW1AfEDAQ9SRXEVj2uylI.nwk.Cactus_prepared_version.nwk
./all_contig_assemblies_contigs_under_500_bp_removed/all_assemblies_plus_reference_genomes/23_May_2022-lPwQm3CMG7x2Vat25m9dgnHsBegTd0IeFkcnye9uhp2iW1AfEDAQ9SRXEVj2uylI.nwk

#Just isolates - masked
./all_contig_assemblies_contigs_under_500_bp_removed/all_assemblies_plus_reference_genomes/23_Nov_2022-e9a72cfe_e9ea_479a_852f_55adf7a690a5_YSbNzTXQL5-TEMP_dir/23_Nov_2022-e9a72cfe_e9ea_479a_852f_55adf7a690a5_YSbNzTXQL5.nwk

#Isolates and some references - masked
./all_contig_assemblies_contigs_under_500_bp_removed/all_assemblies_plus_reference_genomes/23_Nov_2022-e9a72cfe_e9ea_479a_852f_55adf7a690a5_YSbNzTXQL5-TEMP_dir/23_Nov_2022-6ce42ff8_541c_41e7_804c_ea8d56f5f3e2_yqVyYqkyZM.nwk

NZ_CP029615.1_Limosilactobacillus_reuteri_strain_SKKU-OGDONS-01_chromosome_complete_genome.fa.BBMasked

#2022-12-08
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/DFAST_output
16bD_S22-contigs_cds.fna
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Mapping_subsampled_reads_to_DFAST_cds_fna_files_combined

cp /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/DFAST_output/*/*-contigs_cds.fna $(pwd)

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Mapping_subsampled_reads_to_DFAST_cds_fna_files_combined/2022-12-08_combined_not_masked_good_isolates_DFAST_cds_fasta_files.fa

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/seqtk_outputs
AR45J.QCed.Cleansed.Subsampled.R1.fq
AR45J.QCed.Cleansed.Subsampled.R2.fq

source package 222eac79-310f-4d4b-8e1c-0cece4150333 #Minimap2 version 2.24-41122
source package /tgac/software/testing/bin/samtools-1.10 #Samtools version 1.10
source package /tgac/software/testing/bin/salmon-0.13.1 #Salmon version 0.13.1

salmon index -t "$cds_ref" -i Mapping_subsampled_reads_to_DFAST_cds_fna_files_combined/2022-12-08_combined_not_masked_good_isolates_DFAST_cds_fasta_files.Salmon_index -k 31


inpf1="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/seqtk_outputs/AR45J.QCed.Cleansed.Subsampled.R1.fq"
inpf2="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/seqtk_outputs/AR45J.QCed.Cleansed.Subsampled.R2.fq"
sampleID="AR45J"
cds_ref="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Mapping_subsampled_reads_to_DFAST_cds_fna_files_combined/2022-12-08_combined_not_masked_good_isolates_DFAST_cds_fasta_files.fa"
outdir=$(pwd)

minimap2 -ax sr -t 2 "$cds_ref" "$inpf1" "$inpf2" > "${outdir}/${sampleID}.Subsampled_reads.Minimap_mapping_concatenated_isolates_DFAST_CDS_fna_files.sam"

samtools view -@ 2 -b -S "${outdir}/${sampleID}.Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.sam" > "${outdir}/${sampleID}.Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.bam"

samtools flagstat -@ 2 "${outdir}/${sampleID}.Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.bam" > "${outdir}/${sampleID}.Subsampled_reads.Minimap_mapping_concatenated_isolates_assemblies.Single_merged_contig_per_assembly.Samtools_flag_stat_output.txt"

./strictest_bins/9_Jul_2022-qAGSRBfuBmTHPOa2.nwk
./strictest_bins/fasta_files/7_Jul_2022-ggkWmfja4trlUzxMIGzr1EMVip8I0N0c8nRd19epNBxJatGehkldN3iuThIySvYM.nwk
./strictest_bins/fasta_files/isolate_assemblies_and_200_references/31_Jul_2022-poZC1Gjffqorh4oy.nwk
./strictest_bins/fasta_files/isolate_assemblies_and_200_references/1_Aug_2022-BpsKaqV53PC35tti.nwk
./strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/12_Sep_2022-faUH9aROSCOaOfJa.nwk

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

emapper.py

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Prokka_outdir

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/13A_S1.QCed.Cleansed

awk -F "\t" '{print $6}' 13A_S1.SPADES_assembly_min_500bp_contigs.tsv | awk 'NF' | sort -h | uniq

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Prokka_outdir

while IFS= read -r line;
do
  coggy=$(printf "$line")
  occurrence=$(awk -F "\t" -v coggles="$coggy" '$6 == coggles {print $6}' 13A_S1.SPADES_assembly_min_500bp_contigs.tsv | wc -l)
  printf "$coggy\t$occurrence\n"
done < <(awk -F "\t" '{print $6}' 13A_S1.SPADES_assembly_min_500bp_contigs.tsv | awk 'NF' | sort -h | uniq) | sort -k2 -V

13A_S1-scaffolds.fasta
13A_S1.QCed.Cleansed-Unicycler_output.assembly.Min_500bp_contigs.fasta
13A_S1.QCed.Cleansed-Unicycler_output.assembly.fasta

ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/007/ERR7198277/ERR7198277_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/007/ERR7198277/ERR7198277_2.fastq.gz

mv ERR7198277_1.fastq.gz PRJEB48359-SAMEA10534755-Steppe_polecat-ERR7198277_1.fastq.gz
mv ERR7198277_2.fastq.gz PRJEB48359-SAMEA10534755-Steppe_polecat-ERR7198277_2.fastq.gz

PRJEB48359-SAMEA10534755-Steppe_polecat-ERR7198277_1.fastq.gz
PRJEB48359-SAMEA10534755-Steppe_polecat-ERR7198277_2.fastq.gz

-printf '%f\n'

#From R. Shaw 2023-01-16
the highlighted samples in this table correspond to the reads that you have - the identifier starting from the 'VWT'. I've classified them into welsh, English and border - so the hypothesis being that the welsh polecats are more polecat like, the English ones the more ferret like'
###
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/005/ERR7198275/ERR7198275_1.fastq.gz
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/005/ERR7198275/ERR7198275_2.fastq.gz - Euro_polecat_ferret_hybrid

PRJEB48359-SAMEA10534753-Euro_polecat_ferret_hybrid-ERR7198275_1.fastq.gz
PRJEB48359-SAMEA10534753-Euro_polecat_ferret_hybrid-ERR7198275_2.fastq.gz

ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/007/ERR7198277/ERR7198277_1.fastq.gz - Least Weasel

PRJEB48359-SAMEA10534756-Steppe_polecat-ERR7198277_1.fastq.gz
PRJEB48359-SAMEA10534756-Steppe_polecat-ERR7198277_2.fastq.gz

/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/reference_genomes

2023-01-19

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/Unicycler_and_Prokka
zcat ./*/*/*-Unicycler_output.assembly.fasta.tsv.gz | awk -F "\t" '{print $6}' | awk 'NF' | sort -h | uniq > 2023-01-19_list_all_Unicycler_assemblies_no_min_contig_size_all_COGs_detected.tsv

13A_S1-Prokka_output-13A_S1-Unicycler_output.assembly.fasta.tsv.gz
locus_tag	ftype	length_bp	gene	EC_number	COG	product
LEKBHFGK_00001	CDS	615			COG0586	putative membrane protein

hereiam=$(pwd)
targets=$(find -maxdepth 4 -type f -name "*-Unicycler_output.assembly.fasta.tsv.gz")
for f in $targets
do
  subject_file="$f"
  isolate_ID=$(basename "$subject_file" | awk -F "-" '{print $1}')
  printf "COG_ID\t$isolate_ID\n" > "${hereiam}/${isolate_ID}.Unicycler_no_min_contig_size.All_possible_COGs_count.tsv"
  destination_file="${hereiam}/${isolate_ID}.Unicycler_no_min_contig_size.All_possible_COGs_count.tsv"
  while IFS= read -r line
  do
    cog_name="$line"
    count_of_cogs=$(zcat "$subject_file" | awk -F "\t" -v coggles="$cog_name" '$6 == coggles {print $6}' | wc -l)
    printf "$cog_name\t$count_of_cogs\n" >> "$destination_file"
  done < 2023-01-19_list_all_Unicycler_assemblies_no_min_contig_size_all_COGs_detected.tsv
done


awk -F "\t" '{print $1}' 16bB_S20.Unicycler_no_min_contig_size.All_possible_COGs_count.tsv > list_cogs_in_order.txt

for f in *.Unicycler_no_min_contig_size.All_possible_COGs_count.tsv
do
  awk -F "\t" '{print $2}' "$f" > "${f%}.TEMP.txt"
done

paste -d "\t" list_cogs_in_order.txt *.TEMP.txt > 2023-01-19_All_unicycler_assemblies_All_good_isolates_no_min_contig_size.All_possible_COGs_counts.tsv

rm *.TEMP.txt

2023-01-20
/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/raw

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/003/ERR7198273/ERR7198273_1.fastq.gz && wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/003/ERR7198273/ERR7198273_2.fastq.gz && wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/004/ERR7198274/ERR7198274_1.fastq.gz && wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/004/ERR7198274/ERR7198274_2.fastq.gz && wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/006/ERR7198276/ERR7198276_1.fastq.gz && wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/006/ERR7198276/ERR7198276_2.fastq.gz && wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/007/ERR7198277/ERR7198277_1.fastq.gz && wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/007/ERR7198277/ERR7198277_2.fastq.gz

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/008/ERR7198278/ERR7198278_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR719/008/ERR7198278/ERR7198278_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR725/008/ERR7256378/ERR7256378_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR725/008/ERR7256378/ERR7256378_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR725/009/ERR7256379/ERR7256379_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR725/009/ERR7256379/ERR7256379_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR725/000/ERR7256380/ERR7256380_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR725/000/ERR7256380/ERR7256380_2.fastq.gz

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done
/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting
find -maxdepth 5 -type f -name "*.MetaBat2_output.*.fa"

2023-01-21
target_files=$(find -maxdepth 5 -type f -name "*.MetaBat2_output.*.fa")
for f in $target_files
do
  cp "$f" 2023-01-21_produced_bin_files
  printf "Copied file:\t$f\n"
done

target_files=$(find -maxdepth 5 -type f -name "*.MetaBat2_output.*.fa.CheckM.tsv.gz")
for f in $target_files
do
  zcat "$f" 2023-01-21_produced_bin_files | grep 'MetaBat2' 
done | sort -h

sed 's@   *@\t@g'

/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch

mv iMGMC-758.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
mv iMGMC-68.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
mv iMGMC-808.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
mv iMGMC-732.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
mv iMGMC-25.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
mv iMGMC-585.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
mv iMGMC-211.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
mv iMGMC-930.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
mv iMGMC-77.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes
mv iMGMC-232.fa /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/2023-01-21_produced_bin_files/bins_at_least_50_percent_completeness_plus_some_reference_genomes

GCF_000240185.1_ASM24018v2_genomic.fna.gz Klebsiella pneumoniae subsp. pneumoniae HS11286
GCF_000005845.2_ASM584v2_genomic.fna.gz Escherichia coli str. K-12 substr. MG1655
GCF_015669135.1_ASM1566913v1_genomic.fna.gz Blautia luti
GCF_010509575.1_ASM1050957v1_genomic.fna.gz Faecalibacterium duncaniae
GCF_002998925.1_ASM299892v1_genomic.fna.gz Mogibacterium diversum
GCF_000723465.1_Rb803_genomic.fna.gz Ruminococcus bicirculans
GCF_001507385.1_ASM150738v1_genomic.fna.gz Christensenella hongkongensis
GCF_014323405.1_ASM1432340v1_genomic.fna.gz Romboutsia faecis
GCF_001703555.1_ASM170355v1_genomic.fna.gz Carnobacterium divergens
GCF_009933595.1_ASM993359v1_genomic.fna.gz Ligilactobacillus animalis
GCF_001434405.1_ASM143440v1_genomic.fna.gz Ligilactobacillus apodemi
GCF_003288115.1_ASM328811v1_genomic.fna.gz Ligilactobacillus murinus

for f in *.fna
do
  oldname=$(basename "$f")
  newname=$(awk -F "\t" -v nome="$oldname" '$1 == nome {print $2}' 2023-01-21_downloaded_refseq_genomes.txt)
  printf "Will rename $f to ${newname}.fna\n"
  mv "$f" "${newname}.fna"
done

2023-01-23
mkdir RShaw_cleansed_reads_all_samples
/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/RShaw_cleansed_reads_all_samples

.QCed.Cleansed.R1.fastq.gz
.QCed.Cleansed.R2.fastq.gz

target_files=$(find -maxdepth 4 -type f -name "*.QCed.Cleansed.R2.fastq.gz")
for f in $target_files
do
  cp "$f" /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/RShaw_cleansed_reads_all_samples
  printf "Copied file:\t$f\n"
done

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done


Bootstrap: docker
From: nanozoo/maxbin2:2.2.7--b643a6b

sudo singularity build MaxBin2_v2_2_7-Nanozoo_docker_image.img maxbin2_nanozoo.def

singularity exec MaxBin2_v2_2_7-Nanozoo_docker_image.img

metabat_Metabat_on_dockerhub.def
Bootstrap: docker
From: metabat/metabat:latest

sudo singularity build Metabat_v2_15-5_MetaBat_docker_image.img metabat_Metabat_on_dockerhub.def
sudo singularity build Metabat_v2_15-5_MetaBat_docker_image.sif metabat_Metabat_on_dockerhub.def

singularity exec Metabat_v2_15-5_MetaBat_docker_image.sif metabat2 -i contigs.fa --seed 100 --verbose
singularity exec /hpc-home/osbourne/Metabat_v2_15-5_MetaBat_docker_image.sif metabat2 -i SRR11852046-Capybara-8e5f79c7_d5dc_4588_a44e_fe515b647fac_lnzwlDI0f9HYwTrR-Thu_29_Sep_2022.Single_line.metaSPADES_contigs.fa --seed 100 --verbose --outFile "metabat_out/testing_metabat2_image"


Bootstrap: docker
From: vout/megahit:release-v1.2.9

%labels
  application Megahit
  applicationversion 1.2.9


sudo singularity build megahit_v1_2_9_docker_image.img megahit_v1_2_9_docker_definition.def

singularity exec megahit_v1_2_9_docker_image.img megahit --help



Bootstrap: docker
From: nanozoo/maxbin2:2.2.7--b643a6b

%labels
  application Maxbin2
  applicationversion 2.2.7


sudo singularity build maxbin2_v2_2_7_docker_image.img maxbin2_v2_2_7_docker_definition.def

singularity exec megahit_v1_2_9_docker_image.img megahit --help

/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/e7199858_b7f4_4319_b735_fae760f50479_HwrGl6_Coassembly_run-MEGAHIT_outputs/Megahit

2023-01-24

singularity exec maxbin2_v2_2_7_docker_image.img run_MaxBin.pl
for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

find ~+ -type f -name "*QCed.Cleansed.*fastq" -not -name "*PRJEB48359*" | sort -h

source package 5a1c6a9a-f666-4eaa-9409-3e7435d86406 #CheckM 1.2.0
/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/Maxbin_output/e7199858_b7f4_4319_b735_fae760f50479_HwrGl6_Coassembly_run-MaxBin2
#Writing the CheckM function
execute_checkm_bins () {
    bins_dir="$binning_outdir"
    input_bin="$1"
    bin_name=$(basename "$input_bin")
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_CheckM_output"
    export checkm_outdir="${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_CheckM_output"
    cp "$input_bin" "$checkm_outdir"
    cd "$checkm_outdir"
    bin_in_checkm_dir="${checkm_outdir}/${bin_name}"
    printf "Will run CheckM on the bin file:\t$input_bin\n"
    printf "Output will be written to directory:\t$checkm_outdir\n"
    #Running CheckM, a two stage process - note the -x flag here depends on the bins having the specific extension .fa
    checkm lineage_wf -t 2 -x fa "$binning_outdir" "$checkm_outdir"
    #Next steps
    target_lineage_file=$(find -maxdepth 1 -type f -name "*lineage*.ms" -printf '%f\n')
    qa_output_file_dir="$checkm_outdir"
    checkm qa -o 2 -f "${checkm_outdir}/${bin_name}.CheckM.tsv" "$target_lineage_file" "$qa_output_file_dir"
    printf "Ran CheckM on the bin file:\t$input_bin\n"
    printf "Output should be written in directory:\t$checkm_outdir\n"
    #Doing some tidying by removing the copied in bin file and gzipping everything
    rm "$bin_in_checkm_dir"
    targets_to_zip=$(find -maxdepth 1 -type f -not -name "*.gz")
    for f in $targets_to_zip
    do
        gzip "$f"
        printf "Gzipped file:\t$f\n" || printf "File $f not zipped, may no longer exist\n"
    done
}

Maxbin2_output.004
Maxbin2_output.013
Maxbin2_output.009

source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka 1.14.6

#Writing the Prokka annotation function
execute_prokka_bins_annotation () {
    input_bin="$1"
    bin_name=$(basename "$input_bin")
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_Prokka_output"
    export prokka_outdir="${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_Prokka_output"
    printf "Will run Prokka on the bin file:\t$input_bin\n"
    printf "Output will be written to directory:\t$prokka_outdir\n"
    prokka --outdir "$prokka_outdir" --force --prefix "$bin_name" --kingdom Bacteria "$input_bin"
    printf "Ran Prokka on the bin file:\t$input_bin\n"
    printf "Output should be written in directory:\t$prokka_outdir\n"
    #Doing some tidying by gzipping everything
    cd "$prokka_outdir"
    targets_to_zip=$(find -maxdepth 1 -type f -not -name "*.gz")
    for f in $targets_to_zip
    do
        gzip "$f"
        printf "Gzipped file:\t$f\n" || printf "File $f not zipped, may no longer exist\n"
    done
}

/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch/2023-01-27_files/Megahit_coassembly

MaxBin2_bins
Metabat2_bins
Assemblies
Extracted_reads
Megahit_coassembly

/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch/2023-01-27_files/Assemblies

find -maxdepth 2 -type d -name "Assembly_output"

target_dir=$(find -maxdepth 2 -type d -name "Assembly_output")
for thingy in $target_dir
do
  runID=$(echo "$thingy" | awk -F "/" '{print $2}')
  new_name=$(basename "$thingy" | sed "s/^/${runID}-/g")
  printf "Will copy directory $thingy to $new_name\n"
  cp -r "$thingy" "/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch/2023-01-27_files/Assemblies/${new_name}"
  printf "Did the copying\n"
done


target_dir=$(find -maxdepth 2 -type d -name "QC_and_cleansed_files")
for thingy in $target_dir
do
  runID=$(echo "$thingy" | awk -F "/" '{print $2}')
  new_name=$(basename "$thingy" | sed "s/^/${runID}-/g")
  printf "Will copy directory $thingy to $new_name\n"
  cp -r "$thingy" "/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch/2023-01-27_files/Read_processing_output/${new_name}"
  printf "Did the copying\n"
done

tar -zcvf 2023-01-27_files.tar.gz 2023-01-27_files

/ei/software/testing/kraken2/temp_osborne

2023-02-21
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Prokka_outdir

targets=$(find -maxdepth 2 -type f -name "*-min_contig_length_500bp.tsv")
for f in $targets
do
  awk -F "\t" '{print $6}' "$f" | awk 'NF' | tail -n +2 | sort -V | uniq >> "all_COGs_found.txt"
  printf "Processed file:\t$f\n"
done
cat all_COGs_found.txt | sort -h | uniq > 2023-02-21_Prokka_all_assemblies_ex_S125_all_unique_detected_COGs_list.txt
rm all_COGs_found.txt

targets=$(find -maxdepth 2 -type f -name "*-min_contig_length_500bp.tsv")
for f in $targets
do
  awk -F "\t" '{print $4}' "$f" | awk 'NF' | tail -n +2 | sort -V | uniq >> "all_genes_found.txt"
  printf "Processed file:\t$f\n"
done
cat all_genes_found.txt | sort -h | uniq > 2023-02-21_Prokka_all_assemblies_ex_S125_all_unique_detected_gene_names_list.txt
rm all_genes_found.txt

inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Prokka_outdir"
targets=$(find -maxdepth 2 -type f -name "*-min_contig_length_500bp.tsv")
cogs_list="${inpdir}/2023-02-21_Prokka_all_assemblies_ex_S125_all_unique_detected_COGs_list.txt"
for f in $targets
do
  nome=$(basename "$f" | awk -F "-" '{print $1}')
  printf "These are for $nome\n"
  printf "COG\t$nome\n" > "${nome}.COG_counts.tsv"
  while IFS= read -r line;
  do
    COG_name="$line"
    COG_count=$(awk -F "\t" -v coggles="$COG_name" '$6 == coggles {print $0}'  "$f" | wc -l)
    COG_count=${COG_count:="0"}
    printf "$COG_name\t$COG_count\n" >> "${nome}.COG_counts.tsv"
  done < "$cogs_list"
done

for f in *COG_counts.tsv
do
  nome=$(basename "$f" | awk -F "." '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "$nome.TEMP_COUNTS.txt"
done
paste -d "\t" cogs.txt *TEMP_COUNTS.txt > 2023-02-21_all_isolate_assemblies_exS125_all_possible_COGs_from_all_assemblies_counts_per_assembly.tsv
rm *TEMP_COUNTS.txt

inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/Prokka_outdir"
targets=$(find -maxdepth 2 -type f -name "*-min_contig_length_500bp.tsv")
genes_list="${inpdir}/2023-02-21_Prokka_all_assemblies_ex_S125_all_unique_detected_gene_names_list.txt"
for f in $targets
do
  nome=$(basename "$f" | awk -F "-" '{print $1}')
  printf "These are for $nome\n"
  printf "Gene\t$nome\n" > "${nome}.Gene_counts.tsv"
  while IFS= read -r line;
  do
    gene_name="$line"
    gene_count=$(awk -F "\t" -v genie="$gene_name" '$4 == genie {print $0}'  "$f" | wc -l)
    gene_count=${gene_count:="0"}
    printf "$gene_name\t$gene_count\n" >> "${nome}.Gene_counts.tsv"
  done < "$genes_list"
done

for f in *Gene_counts.tsv
do
  nome=$(basename "$f" | awk -F "." '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "$nome.TEMP_COUNTS.txt"
done
paste -d "\t" genes.txt *TEMP_COUNTS.txt > 2023-02-21_all_isolate_assemblies_exS125_all_possible_genes_from_all_assemblies_counts_per_assembly.tsv
rm *TEMP_COUNTS.txt


##Setting a thing for if a variable is empty without an if loop
${parameter:=word}
${parameter:="word"}
variable=$(doing whatever to get a string or integer)
variable=${variable:="whatever you want if the variable was empty, including an entire sentence or the like"}
##

source package 39fcd8ae-6f7f-47cb-a7a3-8d513c29b9d5 #DeepVirFinder - 6a823fb

#2023-03-16
source package 7a6ee408-8bf5-4cb5-9853-16d5ad415e8f #VirSorter2 v.2.1 - detect DNA and RNA viral genomes from sample
source package 583ccd01-1b80-4f0b-9027-b4abdd958a9d #CheckV v1.0.1 - assess Viral genomes
source package /tgac/software/testing/bin/bracken-2.6.0 #Bracken v2.6.0

#2023-03-18
16bA_S19-min_contig_length_500bp-final-viral-combined.fa

[[ -f 16bA_S19-min_contig_length_500bp-final-viral-combined.fa && -s 16bA_S19-min_contig_length_500bp-final-viral-combined.fa ]] && printf "Test 1" || printf "Test 2"
#Gives Test 1 when file exists
[[ -f nonsense.txt && -s nonsense.txt ]] && printf "Test 1" || printf "Test 2"
#Gives Test 2 when file does not exist
[[ -f nonsense.txt && -s nonsense.txt ]] && printf "Test 1" || printf "Test 2"
#Gives Test 2 when file exists but is empty
[[ -f nonsense.txt && -s nonsense.txt ]] && printf "Test 1" || printf "Test 2"
#Gives Test 1 when file exists and is not empty
if [[ -f nonsense.txt && -s nonsense.txt ]]
then
  echo "File exists and is not empty"
else
  echo "File does not exist or exists but is empty"
fi

#2023-03-19
https://portal.nersc.gov/CheckV/checkv-db-v1.5.tar.gz
/hpc-home/osbourne/CheckV_database_v1_5

/hpc-home/osbourne/CheckV_database_v1_5/checkv-db-v1.5/genome_db
source package dd43df1f-7eb2-4011-88fc-c457e801ddd0 #diamond 0.9.29 needed to make file checkv_reps.dmnd yourself
diamond makedb --in checkv_reps.faa --db checkv_reps

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database
https://sunagawalab.ethz.ch/share/MOTUS_DATA/motus_3.0.1/mOTUs.profiles.gz
https://sunagawalab.ethz.ch/share/MOTUS_DATA/motus_3.0.1/mOTUs.profiles_environments.gz
https://zenodo.org/record/5140350/files/db_mOTU_v3.0.1.tar.gz?download=1
https://zenodo.org/record/7146984/files/mOTUs3.genome_metadata.tsv.gz?download=1

Bootstrap: docker
From: quay.io/biocontainers/motus:3.0.3--pyhdfd78af_0

%labels
  application Motus
  applicationversion 3.0.3--pyhdfd78af_0

sudo singularity build motus_v3_0_3_1_docker_image.img motus_v3_0_3_1_docker_definition.def
singularity exec /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/motus_v3_0_3_1_docker_image.img motus profile -db /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/db_mOTU --help

/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database

awk -F "\t" '$4 > 0 {print $0}'

source package cfe4697f-e720-4a2b-a5a2-6fe645f39f34 #drep - 2.5.0
dRep compare --help

#2023-03-21
mOTUs_output.tsv
target_files=$(find -maxdepth 2 -type f -name "*mOTUs_output.tsv")
for f in $target_files
do
  cp "$f" all_profiles/
  printf "Copied file:\t$f\n"
done

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done


while IFS= read -r line
  do
    r1_read_count="10191353.00000000000000000000"
    contents=$(printf "$line" | awk -F "\t" '{print $1"\t"$2"\t"$3"\t"}')
    reads_raw=$(printf "$line" | awk -F "\t" '{print $4}')
    reads_percentage=$(echo "($reads_raw / $r1_read_count) * 100" | bc -l)
    printf "${contents}\t${reads_percentage}\n"
done < AC15J.mOTUs_output.Non_zero_abundances.tsv

#Mauve stuff
source package /tgac/software/testing/bin/mauve-2.4.0
mauveAligner

mauveAligner --output="${outdir}/${label}.phylip" --scratch-path="$scratch_dir_1" --scratch-path="$scratch_dir_2"

#Getting a mauve docker image
Bootstrap: docker
From: biocontainers/mauve-aligner:v2.4.04736-1-deb_cv1

%labels
  application Mauve aligner
  applicationversion 2.4.0


sudo singularity build mauve_aligner_v2_4_0_docker_image.img mauve_aligner_v2_4_0_docker_definition.def

singularity exec megahit_v1_2_9_docker_image.img megahit --help
/hpc-home/osbourne/Docker_images

singularity exec mauve_aligner_v2_4_0_docker_image.img mauveAligner --help


#2023-04-01
source package /tgac/software/testing/bin/mafft-7.271
mafft

NODE_61_length_1750_cov_232.180531
18B_S10-contigs.fasta.Contigs_min_length_500bp

grep 'NODE_61_length_1750_cov_232.180531' 18B_S10-contigs.fasta.Contigs_min_length_500bp.fa

printf "NODE_61_length_1750_cov_232.180531" > tempar.txt && seqtk subseq 18B_S10-contigs.fasta.Contigs_min_length_500bp.fa tempar.txt > 18B_S10.16S_sequence.fa && rm tempar.txt

#Sourcing Snippy 4.2.1 for a working version of Seqtk it includes
source package a684a2ed-d23f-4025-aa81-b21e27e458df

#Sourcing Seqkit
source package 46a62eca-4f8f-45aa-8cc2-d4efc99dd9c6 #Seqkit 0.12.0

inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed"
for f in *Barrnap.gff3
do
  nome=$(basename "$f")
  useful_name=$(echo "$nome" | sed 's/Barrnap.gff3/fa/g')
  assembly_file="${inpdir}/${useful_name}"
  lobel=$(echo "$nome" | sed 's/.Barrnap.gff3//g')
  complete_16s=$(grep 'Name=16S_rRNA;product=16S ribosomal RNA' "$f" | grep -v 'partial' | awk -F "\t" '{print $1}')
  export sixteen_S_nucleotides=$(grep 'Name=16S_rRNA;product=16S ribosomal RNA' "$f" | grep -v 'partial' | awk -F "\t" '{print $4":"$5}')
  printf "$complete_16s" > "${inpdir}/temp.${lobel}.16S.txt"
  grep 'Name=16S_rRNA;product=16S ribosomal RNA' "$f" | grep -v 'partial' | awk -F "\t" '{print $1}' > "${inpdir}/temp.${lobel}.16S.txt"
  seqtk subseq "$assembly_file" "${inpdir}/temp.${lobel}.16S.txt" > "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa"
  seqkit subseq -r "$sixteen_S_nucleotides" "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa" > "${inpdir}/${lobel}.16S_complete_from_Barrnap.fa"
  nume=$(basename "$f" | awk -F "-contigs" '{print $1"_complete_16S_containing_contig_"}')
  sed -i -e "s/>/>$nume/g" "${inpdir}/${lobel}.16S_complete_from_Barrnap.fa"
  cat "${inpdir}/${lobel}.16S_complete_from_Barrnap.fa" >> "${inpdir}/combined_16S_containing_contigs_isolates_with_complete_16S_detection_Barrnap.fa"
  rm "${inpdir}/temp.${lobel}.16S.txt"
  rm "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa"
  rm "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa.seqkit.fai"
  printf "Processed file:\t$f\n"
done

#Verrrry big 16S fasta - 39B_S15
#No complete 16S sequence - 13E_S5, 16aA_S24, 16bE_S23, 39C_S16, 41B_S7

#Try just aligning the 16S containing contigs using something other than mauve. If it works see about extracting just the 16S from the contigs and aligning those
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed
export target_assemblies=$(find -maxdepth 1 -type f -name "*16S_complete_from_Barrnap.fa" -not -size 0 -printf '%f\n' | tr "\n" " ")

#Sourcing muscle 3.8.1551
source package 37d8f236-f284-42fc-adfd-20a34f7d7b5c #muscle 3.8.1551

export target_assemblies=$(find -maxdepth 1 -type f -name "*16S_complete_from_Barrnap.fa" -not -size 0 -printf '%f\n' | tr "\n" " ")
for f in $target_assemblies
do
  nume=$(basename "$f" | awk -F "-contigs" '{print $1"_complete_16S_containing_contig_"}')
  cat "$f" > "${nume}.tempor.fa"
  sed -i -e "s/>/>$nume/g" "${nume}.tempor.fa"
  cat "${nume}.tempor.fa" >> combined_16S_containing_contigs_isolates_with_complete_16S_detection_Barrnap.fa
  rm "${nume}.tempor.fa"
done

muscle -in combined_16S_containing_contigs_isolates_with_complete_16S_detection_Barrnap.fa -out combined_16S_containing_contigs_isolates_with_complete_16S_detection_Barrnap.Muscle_output_trial

muscle -physout combined_16S_containing_contigs_isolates_with_complete_16S_detection_Barrnap.Muscle_output_trial.Sequential_phylip.phy -phyiout combined_16S_containing_contigs_isolates_with_complete_16S_detection_Barrnap.Muscle_output_trial.Interleaved_phylip.phy -in combined_16S_containing_contigs_isolates_with_complete_16S_detection_Barrnap.fa -fastaout combined_16S_containing_contigs_isolates_with_complete_16S_detection_Barrnap.Muscle_output_trial.Fasta_output.fa

#Sourcing fasttree 2.1.11
source package /tgac/software/testing/bin/fasttree-2.1.11

FastTree -gtr -nt zoot.fa > combined_16S_containing_contigs_isolates_with_complete_16S_detection_Barrnap.Muscle_output_trial.Sequential_phylip.TREE.nwk


#2023-04-03
#!/bin/bash -eE

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed"

for f in *Barrnap.gff3
do
  nome=$(basename "$f")
  useful_name=$(echo "$nome" | sed 's/Barrnap.gff3/fa/g')
  assembly_file="${inpdir}/${useful_name}"
  lobel=$(echo "$nome" | sed 's/.Barrnap.gff3//g')
  #Adding cleaning step
  rm "${inpdir}/temp.${lobel}.Incomplete_16S.txt" || echo ""
  rm "${inpdir}/temp.${lobel}.Incomplete_16S.txt" || echo ""
  rm "${lobel}.contig.fa" || echo ""
  rm "${lobel}.contig.fa.seqkit.fai" || echo ""
  rm "${inpdir}/temp.${lobel}.Complete_16S.txt" || echo ""
  rm "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa" || echo ""
  rm "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa.seqkit.fai" || echo ""
  rm "${lobel}.16S_complete_from_Barrnap.TEMP.fa.fai" || echo ""
  grep 'Name=16S_rRNA;product=16S ribosomal RNA' "$f" | grep -q 'partial' && echo "" || complete_present="Y"
  if [ -n "$complete_present" ] && [ "$complete_present" == "Y" ]
  then
    complete_16s=$(grep 'Name=16S_rRNA;product=16S ribosomal RNA' "$f" | grep -v 'partial' | awk -F "\t" '{print $1}' | head -1)
    #sixteen_S_nucleotides=$(grep 'Name=16S_rRNA;product=16S ribosomal RNA' "$f" | grep -v 'partial' | awk -F "\t" '{print $4":"$5}')
    sixteen_S_nucleotides=$(grep 'product=16S ribosomal RNA' "$f" | grep -v 'partial' | awk -F "\t" -v namber="$complete_16s" '$1 == namber {print $4":"$5}')
    printf "For entire 16S sequence $complete_16s from file $f the nucleotide range is\t$sixteen_S_nucleotides\n" && sleep 2s
    #printf "$complete_16s" > "${inpdir}/temp.${lobel}.Complete_16S.txt"
    grep 'Name=16S_rRNA;product=16S ribosomal RNA' "$f" | grep -v 'partial' | awk -F "\t" '{print $1}' > "${inpdir}/temp.${lobel}.Complete_16S.txt"
    seqtk subseq "$assembly_file" "${inpdir}/temp.${lobel}.Complete_16S.txt" > "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa"
    seqkit subseq -r "$sixteen_S_nucleotides" "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa" > "${inpdir}/${lobel}.16S_mixed_from_Barrnap.fa"
    nume=$(basename "$f" | awk -F "-contigs" '{print $1"_complete_16S_containing_contig_"}')
    sed -i -e "s/>/>$nume/g" "${inpdir}/${lobel}.16S_mixed_from_Barrnap.fa"
    cat "${inpdir}/${lobel}.16S_mixed_from_Barrnap.fa" >> "${inpdir}/combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.fa"
    rm "${inpdir}/temp.${lobel}.Incomplete_16S.txt" || echo ""
  elif [ -z "$complete_present" ]
  then
    alternate_16S_percent=$(grep 'product=16S ribosomal RNA' "$f" | grep -v 'aligned only 16 percent' | awk -F "only " '{print $2}' | awk -F " percent" '{print $1}' | sort -Vr | head -1)
    #complete_16s=$(awk -F "\t" -v ronge="$alternate_16S_percent" '$9 ~ ronge {print $1}' "$f")
    complete_16s=$(grep 'partial' "$f" | awk -F "\t" -v ronge="$alternate_16S_percent" '$9 ~ ronge {print $1}')
    sixteen_S_nucleotides=$(awk -F "\t" -v robe="$complete_16s" '$1 == robe {print $0}' "$f" | awk -F "\t" '{print $4":"$5}')
    printf "File is:\t$f\n"
    printf "Percentage is $alternate_16S_percent\n"
    printf "16S name is $complete_16s\n"
    printf "Nucleotide range is $sixteen_S_nucleotides\n"
    printf "$complete_16s" > "${inpdir}/temp.${lobel}.Incomplete_16S.txt"
    seqtk subseq "$assembly_file" "${inpdir}/temp.${lobel}.Incomplete_16S.txt" > "${lobel}.contig.fa"
    seqkit subseq -r "$sixteen_S_nucleotides" "${lobel}.contig.fa" > "${lobel}.16S_mixed_from_Barrnap.fa"
    nume=$(basename "$f" | awk -F "-contigs" '{print $1"_incomplete_16S_containing_contig_"}')
    sed -i -e "s/>/>$nume/g" "${lobel}.16S_mixed_from_Barrnap.fa"
    cat "${lobel}.16S_mixed_from_Barrnap.fa" >> "${inpdir}/combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.fa"
    mv "${lobel}.16S_mixed_from_Barrnap.fa" "$inpdir"
    rm "${inpdir}/temp.${lobel}.Incomplete_16S.txt" || echo ""
    rm "${lobel}.contig.fa" || echo ""
    rm "${lobel}.contig.fa.seqkit.fai" || echo ""
  else
    printf "File $f is messing up somehow\n"
  fi
  rm "${inpdir}/temp.${lobel}.Complete_16S.txt" || echo ""
  rm "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa" || echo ""
  rm "${inpdir}/${lobel}.16S_complete_from_Barrnap.TEMP.fa.seqkit.fai" || echo ""
  rm "${lobel}.16S_complete_from_Barrnap.TEMP.fa.fai" || echo ""
  printf "Processed file:\t$f\n"
  unset complete_present
done

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

muscle -physout combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.Muscle_output_trial.Sequential_phylip.phy -phyiout combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.Muscle_output_trial.Interleaved_phylip.phy -in combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.fa -fastaout combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.Muscle_output_trial.Fasta_output.fa

#Sourcing fasttree 2.1.11
source package /tgac/software/testing/bin/fasttree-2.1.11

FastTree -gtr -nt combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.Muscle_output_trial.Fasta_output.fa > combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.Muscle_output_trial.Sequential_phylip.TREE.nwk

#2023-04-04
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_for_cactus

destdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_for_cactus"
targets=$(find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-contigs" '{print $1}')
  cat "$f" | sed "s/>/>${sampleID}_/g" > "${destdir}/${sampleID}.fa"
  printf "Processed file:\t$f\n"
done

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_for_cactus

destdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_and_bins"
targets=$(find -maxdepth 1 -type f -name "Bin*.fa")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F ".f" '{print $1}')
  cat "$f" | sed "s/>/>${sampleID}_/g" > "${destdir}/${sampleID}.fa"
  printf "Processed file:\t$f\n"
done

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references

destdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references"
targets=$(find -maxdepth 1 -type f -name "iMGMC*.fa" | shuf -n 25)
for f in $targets
do
  sampleID=$(basename "$f" | awk -F ".f" '{print $1}' | tr "-" "_")
  cat "$f" | sed "s/>/>${sampleID}_/g" > "${destdir}/${sampleID}.fa"
  printf "Processed file:\t$f\n"
done

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/ref_storage

destdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references"
targets=$(find -maxdepth 1 -type f -name "NZ*.fa" | shuf -n 9)
for f in $targets
do
  cp "$f" "$destdir"
  printf "Processed file:\t$f\n"
done


#New alignment approach
#All assemblies
#All strict bins
#25 high quality iMGMC MAGs - chosen randomly from download
#9 LAB reference genomes - chosen randomly from NCBI download
#3 lactobacillus kefiranofaciens genomes from NCBI
#3 lactobacillus helveticus genomes from NCBI
#3 limosilactobacillus reuteri genomes from NCBI
#3 ligilactobacillus murins genomes from NCBI
#2 ligilactobacillus animalis genomes from NCBI
#80 reference genomes downloaded from NCBI based on mOTUs results
#45 reference genomes downloaded from NCBI based on findings in 5 species arid rodent paper 

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads/all_plain_profiles

for f in *.tsv
do
  awk -F "\t" '$2 > 0 {print $1}' "$f" | grep -v "consensus_taxonomy" | awk 'NF' | cut -d " " -f1-2
done | sort -V | uniq > 2023-04-04_all_unique_detections_at_least_one_read_one_sample.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/ref_storage

while IFS= read -r line
do
  go_get_em=$(echo "$line")
  wget "$go_get_em"
  echo "Downloaded $line"
done < 2023-04-04_list_mOTUs_and_5_species_paper_downloaded_genomes_or_assemblies.txt

#2023-04-07
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_for_cactus
sed 's/)*://g'
(Bin_c1492:0.280238911509,Bin_c82:0.197092558491)0.419:0.012846213713)0.215:0.029941237545)0.900:0.056178960295)0.964:0.063607043478,((41B_S7:0.016491489076,((S126:0.004517161207,S121:0.004776248793)0.920:0.004139807353,((S127:0.004249607027,S123:0.006616932973)0.681:0.002925418457,S122:0.007202711543)0.900:0.002582856397)0.480:0.005213615299)0.943:0.011670566482,Bin_c770:0.039135626018)0.974:0.054230664022)0.996:0.067500895509,S124:0.002218278044,S128:0.002484011956);
(Bin_c14920.280238911509,Bin_c820.197092558491)0.4190.012846213713)0.2150.029941237545)0.9000.056178960295)0.9640.063607043478,((41B_S70.016491489076,((S1260.004517161207,S1210.004776248793)0.9200.004139807353,((S1270.004249607027,S1230.006616932973)0.6810.002925418457,S1220.007202711543)0.9000.002582856397)0.4800.005213615299)0.9430.011670566482,Bin_c7700.039135626018)0.9740.054230664022)0.9960.067500895509,S1240.002218278044,S1280.002484011956);


#2023-04-10
top_diro="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs"
targets=$(find -maxdepth 2 -type f -name "*-PROCESSED.Non_zero_taxa.Read_counts_as_percentage_total_reads.tsv")
for f in $targets
do
  while IFS= read -r line
  do
    line_content=$(echo "$line")
    motu_ref=$(echo "$line_content" | awk -F "\t" -v filtor="#mOTU" '$1 != filtor {print $1}' | grep -v "unassigned")
    species_name=$(echo "$line_content" | awk -F "\t" -v filtor="#mOTU" '$1 != filtor {print $2}' | grep -v "unassigned" | awk -F "s__" '{print $2}')
    printf "${motu_ref}\t${species_name}\n"
  done < "$f"
done >> "${top_diro}/temporat.txt"
cat "${top_diro}/temporat.txt" | sort -h | uniq > "${top_diro}/2023-04-10_processed_files_all_detected_species_all_samples_min_1_read.txt"
rm "${top_diro}/temporat.txt"

top_diro="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs"
targets=$(find -maxdepth 2 -type f -name "*-RAW.Non_zero_taxa.Read_counts_as_percentage_total_reads.tsv")
for f in $targets
do
  while IFS= read -r line
  do
    line_content=$(echo "$line")
    motu_ref=$(echo "$line_content" | awk -F "\t" -v filtor="#mOTU" '$1 != filtor {print $1}' | grep -v "unassigned")
    species_name=$(echo "$line_content" | awk -F "\t" -v filtor="#mOTU" '$1 != filtor {print $2}' | grep -v "unassigned" | awk -F "s__" '{print $2}')
    printf "${motu_ref}\t${species_name}\n"
  done < "$f"
done >> "${top_diro}/temporat.txt"
cat "${top_diro}/temporat.txt" | sort -h | uniq > "${top_diro}/2023-04-10_raw_files_all_detected_species_all_samples_min_1_read.txt"
rm "${top_diro}/temporat.txt"


species_list_file="${top_diro}/2023-04-10_processed_files_all_detected_species_all_samples_min_1_read.txt"
targets=$(find -maxdepth 2 -type f -name "*-PROCESSED.Non_zero_taxa.Read_counts_as_percentage_total_reads.tsv")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  speciesID=$(basename "$f" | awk -F "-" '{print $2}')
  process_state=$(basename "$f" | awk -F "-" '{print $3}' | awk -F ".Non" '{print $1}')
  working_dir="${top_diro}/${sampleID}-${speciesID}-${process_state}-mOTUs_output"
  printf "mOTUs_ref\t${sampleID}\n" > "${working_dir}/${sampleID}-processed_all_possible_unique_species_detections.txt"
  while IFS= read -r line
  do
    motus_identity=$(echo "$line" | awk -F "\t" '{print $1}')
    percentage_reads=$(awk -F "\t" -v identity="$motus_identity" '$1 == identity {print $5}' "$f")
    percentage_reads=${percentage_reads:="0"}
    printf "${motus_identity}\t${percentage_reads}\n" >> "${working_dir}/${sampleID}-processed_all_possible_unique_species_detections.txt"
  done < "$species_list_file"
  printf "Host species\t${speciesID}\n" >> "${working_dir}/${sampleID}-processed_all_possible_unique_species_detections.txt"
  printf "File_status\t${process_state}\n" >> "${working_dir}/${sampleID}-processed_all_possible_unique_species_detections.txt"
done

species_list_file="${top_diro}/2023-04-10_raw_files_all_detected_species_all_samples_min_1_read.txt"
targets=$(find -maxdepth 2 -type f -name "*-RAW.Non_zero_taxa.Read_counts_as_percentage_total_reads.tsv")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  speciesID=$(basename "$f" | awk -F "-" '{print $2}')
  process_state=$(basename "$f" | awk -F "-" '{print $3}' | awk -F ".Non" '{print $1}')
  working_dir="${top_diro}/${sampleID}-${speciesID}-${process_state}-mOTUs_output"
  printf "mOTUs_ref\t${sampleID}\n" > "${working_dir}/${sampleID}-raw_all_possible_unique_species_detections.txt"
  while IFS= read -r line
  do
    motus_identity=$(echo "$line" | awk -F "\t" '{print $1}')
    percentage_reads=$(awk -F "\t" -v identity="$motus_identity" '$1 == identity {print $5}' "$f")
    percentage_reads=${percentage_reads:="0"}
    printf "${motus_identity}\t${percentage_reads}\n" >> "${working_dir}/${sampleID}-raw_all_possible_unique_species_detections.txt"
  done < "$species_list_file"
  printf "Host species\t${speciesID}\n" >> "${working_dir}/${sampleID}-raw_all_possible_unique_species_detections.txt"
  printf "File_status\t${process_state}\n" >> "${working_dir}/${sampleID}-raw_all_possible_unique_species_detections.txt"
done

top_diro="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs"
targets=$(find -maxdepth 2 -type f -name "*-processed_all_possible_unique_species_detections.txt")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${top_diro}/${sampleID}.processed.tempor.txt"
done
paste -d "\t" processed_motus_list.txt *.processed.tempor.txt > 2023-04-10_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples.tsv
rm *.processed.tempor.txt

top_diro="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs"
targets=$(find -maxdepth 2 -type f -name "*-raw_all_possible_unique_species_detections.txt")
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${top_diro}/${sampleID}.raw.tempor.txt"
done
paste -d "\t" raw_motus_list.txt *.raw.tempor.txt > 2023-04-10_all_pilot_raw_files_percent_reads_classified_any_detected_mOTUs_across_all_samples.tsv
rm *.raw.tempor.txt


top_diro="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs"
targets=$(find -maxdepth 2 -type f -name "*-PROCESSED.Percentages_of_total.txt")
for f in $targets
do
  sampleid=$(basename "$f" | awk -F "-" '{print $1}')
  host_species=$(basename "$f" | awk -F "-" '{print $2}')
  percent_assigned=$(awk -F "\t" '{print $2}' "$f" | tail -1)
  printf "${sampleid}\n${host_species}\n${percent_assigned}" > "${top_diro}/${sampleid}.temp.processed.txt"
done
printf "Sample\nHost.species\nPercent.reads.assigned" > processed.temport.txt
paste -d "\t" processed.temport.txt *.temp.processed.txt > "2023-04-10_all_processed_pilot_files_percent_reads_assigned_to_mOTUs_reference.tsv"
rm *.temp.processed.txt

top_diro="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs"
targets=$(find -maxdepth 2 -type f -name "*-RAW.Percentages_of_total.txt")
for f in $targets
do
  sampleid=$(basename "$f" | awk -F "-" '{print $1}')
  host_species=$(basename "$f" | awk -F "-" '{print $2}')
  percent_assigned=$(awk -F "\t" '{print $2}' "$f" | tail -1)
  printf "${sampleid}\n${host_species}\n${percent_assigned}" > "${top_diro}/${sampleid}.temp.raw.txt"
done
printf "Sample\nHost.species\nPercent.reads.assigned" > raw.temport.txt
paste -d "\t" raw.temport.txt *.temp.raw.txt > "2023-04-10_all_raw_pilot_files_percent_reads_assigned_to_mOTUs_reference.tsv"
rm *.temp.raw.txt

sampleid="ERR3357616"
target_processed=$(find -maxdepth 2 -type f -name "${sampleid}*-PROCESSED.Percentages_of_total.txt")
target_raw=$(find -maxdepth 2 -type f -name "${sampleid}*-RAW.Percentages_of_total.txt")
processed_percentage=$(awk -F "\t" '{print $2}' "$target_processed" | tail -1)
raw_percentage=$(awk -F "\t" '{print $2}' "$target_raw" | tail -1)
printf "${processed_percentage}\t${raw_percentage}\n"
echo ""

#2023-04-13
/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs/Human_mock-Human-PROCESSED-mOTUs_output

taxa_list="list_mock_human_species_names.txt"
while IFS= read -r line
do
  species=$(echo "$line")
  grep "$species" "$inpf"
done < "$taxa_list"

#2023-04-16
https://obj.umiacs.umd.edu/taxatarget/data.zip
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch/taxaTarget

source package /tgac/software/testing/bin/diamond-2.0.15 #Diamond 2.0.15

https://github.com/bioinformatics-centre/kaiju/archive/master.tar.gz

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

#2023-04-17
#Trying a different multiple sequence aligner now, Sibeliaz
source package 49b478df-13ab-4e82-bb29-f4d57dc3cd02 #Sibeliaz 1.0.0

sibeliaz -k 15 -b 200 -m 50 -a 300 -t 1 -f 128 <input FASTA files>
#Literally just takes each fasta file name as an argument
#Each file needs a unique header
#So should use the temp fasta files you create for MUSCLE and Mauve with it since they are single contig concatenated versions with unique headers

source package /tgac/software/testing/bin/fasttree-2.1.11

FastTree -gtr -nt combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.Muscle_output_trial.Fasta_output.fa > combined_16S_containing_contigs_isolates_with_mixed_16S_detection_Barrnap.Muscle_output_trial.Sequential_phylip.TREE.nwk

#Getting a Mugsy docker image
Bootstrap: docker
From: staphb/mugsy:1r2.3

%labels
  application Mugsy aligner
  applicationversion 1r2.3


sudo singularity build mugsy_aligner_v1r2_3_docker_image.img mugsy_aligner_v1r2_3_docker_definition.def

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/SibeliaZ_output

/hpc-home/osbourne/Docker_images/mugsy_aligner_v1r2_3_docker_image.img

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/SibeliaZ_output/sibeliaz_out

source package mafTools-0.1

maf_file="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/BBMasked_genomes/SibeliaZ_output/sibeliaz_out/alignment.maf"
input_fasta="SibeliaZ.all_hardmasked_isolates.Multifasta_for_alignment.fa"

mafToFastaStitcher

#2023-04-18
#Using galaxy on safari to convert maf to fasta, seems like need to use the single sequence per species option for FastTree to work
source package /tgac/software/testing/bin/fasttree-2.1.11
SibeliaZ_all_BBMasked_hardmasked_isolates_aligned.Galaxy_MAF_to_FASTA_single_sequence_per_species.fasta
FastTree -gtr -nt SibeliaZ_all_BBMasked_hardmasked_isolates_aligned.Galaxy_MAF_to_FASTA_single_sequence_per_species.fasta > SibeliaZ_all_BBMasked_hardmasked_isolates_aligned.Galaxy_MAF_to_FASTA_single_sequence_per_species.fasta.FastTree_newick.nwk

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/bbmasked_fasta_files

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch/taxaTarget

source /ei/software/staging/RCSUPPORT-1833/stagingloader #Kaiju 1.9.2
source package /tgac/software/testing/bin/diamond-2.0.15 #Diamond 2.0.15
source package 1413a4f0-44e3-4b9d-b6c6-0f5c0048df88 #Python 3.10.2

#kaiju-mkbwt -n 2 -o marker_geneDB.fasta.kaiju marker_geneDB.fasta
#kaiju-mkfmi marker_geneDB.fasta.kaiju
#rm marker_geneDB.fasta.kaiju.bwt marker_geneDB.fasta.kaiju.sa
#diamond makedb --in marker_geneDB.fasta --db marker_geneDB.fasta --threads 2

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch/taxaTarget/data
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/scratch/taxaTarget/taxaTarget-main/run_pipeline_scripts

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

#2023-04-29
#Making a file which has the mOTUs % reads classified for cleansed but not subsampled reads for all Acomys samples
top_outdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads"
target_files=$(find -maxdepth 2 -type f -name "*Percentages_of_total.txt")
printf "Sample.ID\tPercent.classified\tHost.species\tMonth\tHost.x.month\n" > "${top_outdir}/2023-04-29_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned.tsv"
output_file="${top_outdir}/2023-04-29_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned.tsv"
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  host=$(echo "$sampleID" | tr -d "JN0-9")
  season=$(echo "$sampleID" | tr -d "ARC0-9")
  host_by_season=$(echo "$sampleID" | tr -d "0-9")
  percent_classified=$(awk -F "\t" '{print $2}' "$f" | tail -1)
  printf "${sampleID}\t${percent_classified}\t${host}\t${season}\t${host_by_season}\n" >> "$output_file"
  echo "Processed file $sampleID"
done

top_outdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads/all_plain_profiles"
target_files=$(find -maxdepth 1 -type f -name "*.mOTUs_output.PLAIN.tsv")
printf "Sample.ID\tref-mOTU.min.1.read\tHost.species\tMonth\tHost.x.month\n" > "${top_outdir}/2023-04-29_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned.tsv"
output_file="${top_outdir}/2023-04-29_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance.tsv"
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  host=$(echo "$sampleID" | tr -d "JN0-9")
  season=$(echo "$sampleID" | tr -d "ARC0-9")
  host_by_season=$(echo "$sampleID" | tr -d "0-9")
  percent_classified=$(awk -F "\t" '$2 > 0 {print $0}' "$f" | grep -v -e "#consensus_taxonomy" -e "unassigned" | wc -l)
  printf "${sampleID}\t${percent_classified}\t${host}\t${season}\t${host_by_season}\n" >> "$output_file"
  echo "Processed file $sampleID"
done

target_files=$(find -maxdepth 1 -type f -name "*.mOTUs_output.PLAIN.tsv")
for f in $target_files
do
  awk -F "\t" '$2 > 0 {print $0}' "$f" | grep -v -e "#consensus_taxonomy" -e "unassigned" | awk -F "[" '{print $2}' | awk -F "]" '{print $1}'
done | sort -V | uniq > 2023-04-29_unique_ref_mOTUs_non_zero_min_one_sample.txt

#Getting the relative abundance in each sample for all reference mOTUs which had a non-zero relative abundance in at least one sample
target_files=$(find -maxdepth 1 -type f -name "*.mOTUs_output.PLAIN.tsv")
list_file="2023-04-29_unique_ref_mOTUs_non_zero_min_one_sample.txt"
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  printf "Reference\t$sampleID\n" > "${sampleID}.relative_abundances_all_possible.tsv"
  output_file="${sampleID}.relative_abundances_all_possible.tsv"
  while IFS= read -r line
  do
    ref_mOTUs=$(echo "$line")
    relative_abundance=$(grep "$ref_mOTUs" "$f" | awk -F "\t" '{print $2}' | sed 's/0.0000000000/0/g')
    printf "${ref_mOTUs}\t${relative_abundance}\n" >> "$output_file"
  done < "$list_file"
  host=$(echo "$sampleID" | tr -d "JN0-9")
  season=$(echo "$sampleID" | tr -d "ARC0-9")
  host_by_season=$(echo "$sampleID" | tr -d "0-9")
  printf "Host\t${host}\n" >> "$output_file"
  printf "Month\t${season}\n" >> "$output_file"
  printf "Host.x.season\t${host_by_season}\n" >> "$output_file"
  printf "Processed file:\t$f\n"
done
printf "Reference\n" > temp_list_file.txt
cat "$list_file" >> temp_list_file.txt
printf "Host\n" >> temp_list_file.txt
printf "Month\n" >> temp_list_file.txt
printf "Host.x.season\n" >> temp_list_file.txt
for f in *.relative_abundances_all_possible.tsv
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}.temp.motuses.txt"
done
paste -d "\t" temp_list_file.txt *.temp.motuses.txt > 2023-04-29_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible.tsv
rm temp_list_file.txt
rm *.temp.motuses.txt

#2023-04-30
#Making Kraken 2 genus level 50% min conf score results file for making stacked bar chart, need to get a tsv with the relevant information in it first
#List of all detected genera first
for f in *Kraken2-050_report.txt
do
  awk -F "\t" -v lobel="G" '$4==lobel {print $6}' "$f"
done | tr -d " " | sort -h | uniq > 2023-04-30_list_all_unique_detected_genera_050_min_conf_score.txt

Ureibacillus
AC22J_Kraken2-050_report.txt

target_files=$(find -maxdepth 1 -type f -name "*Kraken2-050_report.txt" -not -name "*_pilot_sample_*")
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  host=$(echo "$sampleID" | tr -d "JN0-9")
  season=$(echo "$sampleID" | tr -d "ARC0-9")
  host_by_season=$(echo "$sampleID" | tr -d "0-9")
  cat "$f" | sed 's/\t */\t/g' > "${sampleID}.temporary.txt" #Making a version which removes leading spaces but keeps tab delimiters and spaces within names
  printf "Genus\t${sampleID}\n" > "${sampleID}.Genera.txt"
  output_file="${sampleID}.Genera.txt"
  while IFS= read -r line
  do
    genus=$(echo "$line")
    rel_abun=$(awk -F "\t" -v lobel="$genus" '$6==lobel {print $1;exit}' "${sampleID}.temporary.txt" | tr -d " ")
    rel_abun=${rel_abun:="0"}
    printf "${genus}\t${rel_abun}\n" >> "${sampleID}.Genera.txt"
  done < "2023-04-30_list_all_unique_detected_genera_050_min_conf_score.txt"
  printf "Host\t${host}\n" >> "$output_file"
  printf "Month\t${season}\n" >> "$output_file"
  printf "Host.x.season\t${host_by_season}\n" >> "$output_file"
  printf "Processed file:\t$f\n"
  rm "${sampleID}.temporary.txt"
done
printf "Genera\n" > genus_list.txt
cat "2023-04-30_list_all_unique_detected_genera_050_min_conf_score.txt" >> genus_list.txt
printf "Host\nMonth\nHost.x.month\n" >> genus_list.txt
for f in *Genera.txt
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}.temporog.txt"
done
paste -d "\t" genus_list.txt *.temporog.txt > "2023-04-30_kraken2_all_possible_genera_relative_abundance_subsampled_reads.tsv"
rm genus_list.txt
rm *.temporog.txt
rm *.Genera.txt
printf "Finished now\n"

#Phylum level results as well
for f in *Kraken2-050_report.txt
do
  awk -F "\t" -v lobel="P" '$4==lobel {print $6}' "$f"
done | tr -d " " | sort -h | uniq > 2023-04-30_list_all_unique_detected_phyla_050_min_conf_score.txt

target_files=$(find -maxdepth 1 -type f -name "*Kraken2-050_report.txt" -not -name "*_pilot_sample_*")
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "_" '{print $1}')
  host=$(echo "$sampleID" | tr -d "JN0-9")
  season=$(echo "$sampleID" | tr -d "ARC0-9")
  host_by_season=$(echo "$sampleID" | tr -d "0-9")
  cat "$f" | sed 's/\t */\t/g' > "${sampleID}.temporary.txt" #Making a version which removes leading spaces but keeps tab delimiters and spaces within names
  printf "Phylum\t${sampleID}\n" > "${sampleID}.phyla.txt"
  output_file="${sampleID}.phyla.txt"
  while IFS= read -r line
  do
    phylum=$(echo "$line")
    rel_abun=$(awk -F "\t" -v lobel="$phylum" '$6==lobel {print $1;exit}' "${sampleID}.temporary.txt" | tr -d " ")
    rel_abun=${rel_abun:="0"}
    printf "${phylum}\t${rel_abun}\n" >> "${sampleID}.phyla.txt"
  done < "2023-04-30_list_all_unique_detected_phyla_050_min_conf_score.txt"
  printf "Host\t${host}\n" >> "$output_file"
  printf "Month\t${season}\n" >> "$output_file"
  printf "Host.x.season\t${host_by_season}\n" >> "$output_file"
  printf "Processed file:\t$f\n"
  rm "${sampleID}.temporary.txt"
done
printf "Phylum\n" > phylum_list.txt
cat "2023-04-30_list_all_unique_detected_phyla_050_min_conf_score.txt" >> phylum_list.txt
printf "Host\nMonth\nHost.x.month\n" >> phylum_list.txt
for f in *phyla.txt
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}.temporog.txt"
done
paste -d "\t" phylum_list.txt *.temporog.txt > "2023-04-30_kraken2_all_possible_phyla_relative_abundance_subsampled_reads.tsv"
rm phylum_list.txt
rm *.temporog.txt
rm *.phyla.txt
printf "Finished now\n"

#2023-05-01
top_outdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Classification_outputs/subsampled_cleansed_QCed_read_run_results/kaiju/kaiju_report_files"

AR48N.Kaiju2table_0_errors_allowed-phylum_level_results.tsv

for f in *Kaiju2table_0_errors_allowed-phylum_level_results.tsv
do
  awk -F "\t" '{print $5}' "$f" | grep -v -e "taxon_name" -e "unclassified" -e "cannot be assigned to a (non-viral) phylum"
done | sort -V | uniq > 2023-05-01_list_all_unique_phyla_detected.txt

target_files=$(find -maxdepth 1 -type f -name "*Kaiju2table_0_errors_allowed-phylum_level_results.tsv" -not -name "*_pilot_sample.*")
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  host=$(echo "$sampleID" | tr -d "JN0-9")
  season=$(echo "$sampleID" | tr -d "ARC0-9")
  host_by_season=$(echo "$sampleID" | tr -d "0-9")
  printf "Phylum\t${sampleID}\n" > "${sampleID}.phyla.txt"
  output_file="${sampleID}.phyla.txt"
  while IFS= read -r line
  do
    phylum=$(echo "$line")
    rel_abun=$(awk -F "\t" -v lobel="$phylum" '$5==lobel {print $2;exit}' "$f")
    rel_abun=${rel_abun:="0"}
    printf "${phylum}\t${rel_abun}\n" >> "${sampleID}.phyla.txt"
  done < "2023-05-01_list_all_unique_phyla_detected.txt"
  printf "Host\t${host}\n" >> "$output_file"
  printf "Month\t${season}\n" >> "$output_file"
  printf "Host.x.season\t${host_by_season}\n" >> "$output_file"
  printf "Processed file:\t$f\n"
done
printf "Phylum\n" > phylum_list.txt
cat "2023-05-01_list_all_unique_phyla_detected.txt" >> phylum_list.txt
printf "Host\nMonth\nHost.x.month\n" >> phylum_list.txt
for f in *phyla.txt
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}.temporog.txt"
done
paste -d "\t" phylum_list.txt *.temporog.txt > "2023-05-01_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads.tsv"
rm phylum_list.txt
rm *.temporog.txt
rm *.phyla.txt
printf "Finished now\n"

for f in *Kaiju2table_0_errors_allowed-genus_level_results.tsv
do
  awk -F "\t" '{print $5}' "$f" | grep -v -e "taxon_name" -e "unclassified" -e "cannot be assigned to a (non-viral) genus"
done | sort -V | uniq > 2023-05-01_list_all_unique_genera_detected.txt

for f in *Kaiju2table_0_errors_allowed-genus_level_results.tsv
do
  awk -F "\t" '{print $5}' "$f" | grep -v -e "taxon_name" -e "unclassified" -e "cannot be assigned to a (non-viral) genus"
done | sort -V | uniq | wc -l

target_files=$(find -maxdepth 1 -type f -name "*Kaiju2table_0_errors_allowed-genus_level_results.tsv" -not -name "*_pilot_sample.*")
for f in $target_files
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  host=$(echo "$sampleID" | tr -d "JN0-9")
  season=$(echo "$sampleID" | tr -d "ARC0-9")
  host_by_season=$(echo "$sampleID" | tr -d "0-9")
  printf "Genus\t${sampleID}\n" > "${sampleID}.phyla.txt"
  output_file="${sampleID}.phyla.txt"
  while IFS= read -r line
  do
    phylum=$(echo "$line")
    rel_abun=$(awk -F "\t" -v lobel="$phylum" '$5==lobel {print $2;exit}' "$f")
    rel_abun=${rel_abun:="0"}
    printf "${phylum}\t${rel_abun}\n" >> "${sampleID}.phyla.txt"
  done < "2023-05-01_list_all_unique_genera_detected.txt"
  printf "Host\t${host}\n" >> "$output_file"
  printf "Month\t${season}\n" >> "$output_file"
  printf "Host.x.season\t${host_by_season}\n" >> "$output_file"
  printf "Processed file:\t$f\n"
done
printf "Genus\n" > genus_list.txt
cat "2023-05-01_list_all_unique_genera_detected.txt" >> genus_list.txt
printf "Host\nMonth\nHost.x.month\n" >> genus_list.txt
for f in *phyla.txt
do
  sampleID=$(basename "$f" | awk -F "." '{print $1}')
  awk -F "\t" '{print $2}' "$f" > "${sampleID}.temporog.txt"
done
paste -d "\t" genus_list.txt *.temporog.txt > "2023-05-01_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads.tsv"
rm phylum_list.txt
rm *.temporog.txt
rm *.phyla.txt
printf "Finished now\n"

for i in {1..120} ; do printf "\nI am maintaining connection whilst working on a script locally\n" && for i in {1..240} ; do printf "$i\tI am maintaining connection whilst working on a script locally\n" && sleep 1s ; done && printf "\n-_-_-_-_-_-_-" ; done

#2023-05-03
source package fc91613f-1095-4f67-b5aa-b86d702b36da #Orthofinder 2.5.4

#Make a directory which contains only the amino acid fasta files, making sure they have the extension .fa, .faa or .fasta
#Run command orthofinder -f path to/whatever your directory is

/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/Prokka_outdir/amino_acid_files

target_files=$(find -maxdepth 2 -type f -name "Bin*.faa")

#It was whinging about not having FastME, despite sourcing a version on the cluster so will get a docker image for it from docker hub anyway and try it as well
#instead of just having orthofinder stop at a certain point by using the -og flag
Bootstrap: docker
From: evolbioinfo/fastme:v2.1.6.4

%labels
  application FastME - something about phylogenies using distance algorithms I just need it for orthofinder
  applicationversion 2.1.6.4


nano FastME_v2_1_6_4_docker_definition.def
sudo singularity build FastME_v2_1_6_4_docker_image.img FastME_v2_1_6_4_docker_definition.def
mv FastME_v2_1_6_4_docker_image.img /hpc-home/osbourne/Docker_images
rm FastME_v2_1_6_4_docker_definition.def

#2023-05-04
#Doing the processing for the prokka output of the strict bins
inpdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes/Prokka_outdir"
target_files=$(find -maxdepth 2 -type f -name "Bin*.tsv")
for f in $target_files
do
  bin_name=$(basename "$f" | awk -F ".t" '{print $1}')
  tail -n+2 "$f" > "${bin_name}.temparat.tsv"
done
for f in *.temparat.tsv
do
  awk -F "\t" '{print $6}' "$f" | awk 'NF'
done | sort -V | uniq > 2023-05-03_all_unique_COGs.txt
for f in *.temparat.tsv
do
  awk -F "\t" '{print $4}' "$f" | awk 'NF'
done | sort -V | uniq > 2023-05-03_all_unique_genes.txt
rm *temparat.tsv

#COG counts first
target_files=$(find -maxdepth 2 -type f -name "Bin*.tsv")
for f in $target_files
do
  bin_name=$(basename "$f" | awk -F ".t" '{print $1}')
  printf "COG\t$bin_name\n" > "${bin_name}.COG_counts.tsv"
  out_filer="${bin_name}.COG_counts.tsv"
  infile="${inpdir}/2023-05-03_all_unique_COGs.txt"
  while IFS= read -r line
  do
    cog_name=$(echo "$line")
    occurences=$(awk -F "\t" -v coggles="$cog_name" '$6==coggles {print $0}' "$f" | wc -l)
    occurences=${occurences:="0"}
    printf "${cog_name}\t${occurences}\n" >> "$out_filer"
  done < "$infile"
  printf "Processed file:\t$f\n"
done

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

#2023-05-10
#Getting the barrnap results for the bins both for figure making and writing about
inpdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/Barrnap_output"

printf "Bin\t16S complete\t5S complete\t23S complete\t16S partial\t5S partial\t23S partial\n" > "2023-05-10_rRNA_detections_all_bins.tsv"
output_file="2023-05-10_rRNA_detections_all_bins.tsv"
target_files=$(find -maxdepth 1 -type f -name "*.gff3")
for f in $target_files
do
  bin_name=$(basename "$f" | awk -F ".Ba" '{print $1}')
  sixteen_entire=$(awk -F "\t" -v searcher="Name=16S_rRNA;product=16S ribosomal RNA" '$9 == searcher {print $0}' "$f" | head -1 | wc -l)
  five_entire=$(awk -F "\t" -v searcher="Name=5S_rRNA;product=5S ribosomal RNA" '$9 == searcher {print $0}' "$f" | head -1 | wc -l)
  twenty_three_entire=$(awk -F "\t" -v searcher="Name=23S_rRNA;product=23S ribosomal RNA" '$9 == searcher {print $0}' "$f" | head -1 | wc -l)
  sixteen_partial=$(awk -F "\t" 'index($9, "percent of the 16S ribosomal RNA")' "$f" |  head -1 | wc -l)
  five_partial=$(awk -F "\t" 'index($9, "percent of the 5S ribosomal RNA")' "$f" |  head -1 | wc -l)
  twenty_three_partial=$(awk -F "\t" 'index($9, "percent of the 23S ribosomal RNA")' "$f" |  head -1 | wc -l)
  sixteen_entire=${sixteen_entire:="0"}
  five_entire=${five_entire:="0"}
  twenty_three_entire=${twenty_three_entire:="0"}
  sixteen_partial=${sixteen_partial:="0"}
  five_partial=${five_partial:="0"}
  twenty_three_partial=${twenty_three_partial:="0"}
  printf "${bin_name}\t${sixteen_entire}\t${five_entire}\t${twenty_three_entire}\t${sixteen_partial}\t${five_partial}\t${twenty_three_partial}\n" >> "$output_file"
  printf "Processed file:\t:$f\n"
done

source package /tgac/software/testing/bin/clustalw-2.1

 source package /tgac/software/testing/bin/mafft-7.271


#2023-05-13
#Seems like Mugsy isn't the solution either unfortunately, strict bins only failed after making a maf file for each bin even if it only had the header
#and end of file lines.
#Going to just try combining all the maf files and seeing if that can be turned into a fasta file on galaxy and then made into a tree by
#fasttree

printf "##maf version=1 scoring=single_cov2\n" > "2023-05-13_trial_manually_combined_Mugsy_MAF_files_strict_bins_only_failed_Mugsy_run.maf"
cat *.maf | grep -v -e "eof maf" -e "maf version=1" >> "2023-05-13_trial_manually_combined_Mugsy_MAF_files_strict_bins_only_failed_Mugsy_run.maf"
printf "\n##eof maf" >> "2023-05-13_trial_manually_combined_Mugsy_MAF_files_strict_bins_only_failed_Mugsy_run.maf"
#Didn't work in the end, fasttree needs the entire genome in the fasta file so can't just use this maf file as it only has the alignments in it.

#2023-05-15
working_dir="/ei/software/testing/kraken2/temp_osborne/2023-05-15_strict_bins_cactus_dir"

targets=$(find -maxdepth 1 -type f -name "*.BBMasked.fa")
for f in $targets
do
    nome=$(basename "$f" .BBMasked.fa | sed 's/$/.fa/g')
    cat "$f" > "${working_dir}/${nome}"
    printf "Processed file:\t$f prior to running Cactus\n"
done
tree_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_and_bins/JolyTree_output_assemblies_and_bins_only"
cactus_information_file="${working_dir}/Cactus_info_file_bins_and_assemblies.txt"
source package /tgac/software/testing/bin/newick_utils-1.5 #Newick Utilities v.1.5

sed -i -e 's@/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_and_bins/cactus_dir/@/ei/software/testing/kraken2/temp_osborne/2023-05-15_strict_bins_cactus_dir/@g' Cactus_info_file_bins_and_assemblies.txt

https://usegalaxy.org/api/datasets/f9cad7b01a4721355204c458845267d6/display?to_ext=fasta

#Need to get softmasked, unique header versions of bins and assemblies

destdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/softmasked_files"
source package cab8386a-c777-4936-8411-a6ed2b5e6a20 #BBmap - 38.79
source package 46a62eca-4f8f-45aa-8cc2-d4efc99dd9c6 #Seqkit 0.12.0

isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed"
cd "$isolates_dir"
targets=$(find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa")
for f in $targets ; do cp "$f" "${destdir}" && echo "Copied file: $f" ; done

bins_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes"
cd "$bins_dir"
targets=$(find -maxdepth 1 -type f -name "Bin*fa")
#For bins to remove small contigs
for f in $targets
do
  sampleID=$(basename "$f" | awk -F ".f" '{print $1}')
  seqkit seq -m 500 --quiet "$f" > "${destdir}/${sampleID}-temp.fa"
  printf "Processed file:\t$f\n"
done
cd "$destdir"
targets=$(find -maxdepth 1 -type f -name "*.fa")
#For both
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  srun bbmask.sh -Xmx6g -Xms3g in="$f" out="${sampleID}.fa" threads=auto maskrepeats=t minkr=5 maxkr=15 minlen=30 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.85 lowercase=t
  mv "$f" "${f}.deletable"
  printf "Processed file:\t$f\n"
done

#Remove spaces and make unique headers for all files
printf "Sample ID\tOld header\tNew header\n" > "2023-05-15_all_changed_headers.txt"
for f in *.fa
do
  sampleID=$(basename "$f" | awk -F ".f" '{print $1}')
  grep '>' "$f" > "${sampleID}.headers.txt"
  while IFS= read -r line
  do
    old_header=$(echo "$line")
    new_header=$(uuidgen | sed "s/$/-${sampleID}/g")
    sed -i -e "s/${old_header}/>${new_header}/g" "$f"
    printf "${sampleID}\t${old_header}\t>${new_header}\n" >> "2023-05-15_all_changed_headers.txt"
  done < "${sampleID}.headers.txt"
  printf "Processed file:\t$f\n"
done

sed -i -e 's@/softmasked_files@/softmasked_files/@g' Cactus_info_file_bins_and_assemblies.txt

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/Chris_Q-Seb_R-assemblies_and_co-assemblies/99aab1ea-af6a-4ad1-9e88-5e59e4a6815f/coassembly/binning/consensus

/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/Chris_Q-Seb_R-assemblies_and_co-assemblies/99aab1ea-af6a-4ad1-9e88-5e59e4a6815f/coassembly/binning/consensus/bins

/hpc-home/osbourne/2023-05-15_list_strict_bin_files.txt

destdir="/hpc-home/osbourne/bad_bins"
binsdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/Chris_Q-Seb_R-assemblies_and_co-assemblies/99aab1ea-af6a-4ad1-9e88-5e59e4a6815f/coassembly/binning/consensus/bins"
listfile="/hpc-home/osbourne/2023-05-15_list_strict_bin_files.txt"
while IFS= read -r line
do
  binname=$(echo "$line")
  rm "$binname"
  printf "Deleted file:\t$binname\n"
done < "$listfile"

Bin_m1714.fa

source package /tgac/software/testing/bin/CAT-2.2.1

/ei/software/testing/kraken2/temp_osborne/2023-05-15_strict_bins_cactus_dir

sed 's/d__Bacteria;p__Bacteroidota;c__Bacteroidia;o__Bacteroidales;f__//g' 2023-05-16_bad_bins_GTDB-Tk_classification_output.tsv | sed 's/d__Bacteria;p__Firmicutes_A;c__Clostridia;o__Lachnospirales;f__//g' | sed 's/d__Bacteria;p__Firmicutes_A;c__Clostridia_A;o__Christensenellales;f__//g' | sed 's/d__Bacteria;p__Patescibacteria;c__Saccharimonadia;o__Saccharimonadales;f__//g' | sed 's/d__Bacteria;p__Firmicutes_A;c__Clostridia;o__TANB77;f__//g'

awk -F "\t" '{print $2}' 2023-05-16_bad_bins_GTDB-Tk_classification_output.tsv | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | awk 'NF' | sort -V | uniq > list_unique_families.txt

while IFS= read -r line
do
  family=$(echo "$line")
  occurence=$(grep -c "$family" 2023-05-16_bad_bins_GTDB-Tk_classification_output.tsv)
  printf "$family\t$occurence\n"
done < list_unique_families.txt

awk -F "\t" '{print $2}' 2023-05-16_bad_bins_GTDB-Tk_classification_output.tsv | awk -F ";g__" '{print $2}' | awk -F ";s__" '{print $1}' | awk 'NF' | sort -V | uniq > list_unique_genera.txt
while IFS= read -r line
do
  family=$(echo "$line")
  occurence=$(grep -c "$family" 2023-05-16_bad_bins_GTDB-Tk_classification_output.tsv)
  printf "$family\t$occurence\n"
done < list_unique_genera.txt

gtdbtk.bac120.summary.tsv

awk -F "\t" '{print $2}' gtdbtk.bac120.summary.tsv | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}' | awk 'NF' | sort -V | uniq > /hpc-home/osbourne/bad_bins/list_unique_families_strict_bins.txt
awk -F "\t" '{print $2}' gtdbtk.bac120.summary.tsv | awk -F ";g__" '{print $2}' | awk -F ";s__" '{print $1}' | awk 'NF' | sort -V | uniq > /hpc-home/osbourne/bad_bins/list_unique_genera_strict_bins.txt

grep -v -f list_unique_families.txt list_unique_families_strict_bins.txt

grep -v -f list_unique_genera_strict_bins.txt list_unique_genera.txt

#strict bins dir below
top_outdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/GTDB-TK_outputs"

while IFS= read -r line
do
  family=$(echo "$line")
  occurence_strict=$(grep -c "$family" gtdbtk.bac120.summary.tsv)
  occurence_bad=$(grep -c "$family" /hpc-home/osbourne/bad_bins/GTDB-TK_output/classify_wf/classify/gtdbtk.bac120.summary.tsv)
  occurence_bad=${occurence_bad:="0"}
  printf "$family\t$occurence_strict\t$occurence_bad\n"
done < /hpc-home/osbourne/bad_bins/list_unique_families_strict_bins.txt

while IFS= read -r line
do
  family=$(echo "$line")
  occurence_strict=$(grep -c "$family" gtdbtk.bac120.summary.tsv)
  occurence_bad=$(grep -c "$family" /hpc-home/osbourne/bad_bins/GTDB-TK_output/classify_wf/classify/gtdbtk.bac120.summary.tsv)
  occurence_bad=${occurence_bad:="0"}
  printf "$family\t$occurence_strict\t$occurence_bad\n"
done < /hpc-home/osbourne/bad_bins/list_unique_genera_strict_bins.txt

/hpc-home/osbourne/mugsy_trial

#For bins to remove small contigs
for f in $targets
do
  sampleID=$(basename "$f" | awk -F ".f" '{print $1}')
  seqkit seq -m 500 --quiet "$f" > "${destdir}/${sampleID}-temp.fa"
  printf "Processed file:\t$f\n"
done
cd "$destdir"
targets=$(find -maxdepth 1 -type f -name "*.fa")

#For both
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  srun bbmask.sh -Xmx6g -Xms3g in="$f" out="${sampleID}.fa" threads=auto maskrepeats=t minkr=5 maxkr=15 minlen=30 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.85 lowercase=t
  mv "$f" "${f}.deletable"
  printf "Processed file:\t$f\n"
done

source package cab8386a-c777-4936-8411-a6ed2b5e6a20 #BBmap - 38.79
source package 46a62eca-4f8f-45aa-8cc2-d4efc99dd9c6 #Seqkit 0.12.0
for f in *.fa
do
  sampleID=$(basename "$f" | awk -F ".f" '{print $1}')
  seqkit seq -m 500 --quiet "$f" > "${sampleID}-contigs_trimmed.fa"
  printf "Processed file:\t$f\n"
done

for f in *-contigs_trimmed.fa
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  srun bbmask.sh -Xmx4g -Xms2g in="$f" out="${sampleID}.Softmasked.fa" threads=auto maskrepeats=t minkr=5 maxkr=15 minlen=30 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.85 lowercase=t
  srun bbmask.sh -Xmx4g -Xms2g in="$f" out="${sampleID}.Hardmasked.fa" threads=auto maskrepeats=t minkr=5 maxkr=15 minlen=30 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.85 lowercase=f
  mv "${sampleID}.Softmasked.fa" softmasked/
  mv "${sampleID}.Hardmasked.fa" hardmasked/
  printf "Processed file:\t$f\n"
done

#Get string random letters
cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-20} | head -n 1

nw_topology -I *.nwk

(((((41A_S6,41C_S8),(((Bin_m780,Bin_m1301),(((16aD_S27,16aA_S24),39E_S18),(16aF_S29,((13E_S5,(((((((39A_S14,13B_S2),16bE_S23),16aE_S28),16bC_S21),(18E_S13,18B_S10)),13D_S4),16aC_S26)),16bD_S22)))),((((18D_S12,16bB_S20),(16aB_S25,13A_S1)),((Bin_c1617,16bA_S19),(39D_S17,39C_S16))),(Bin_m1122,Bin_m1485)))),((((Bin_c112,((((Bin_c1526,((Bin_c52,Bin_m1657),(Bin_m1590,(Bin_c1256,Bin_m1500)))),Bin_m7),Bin_c1233),(18A_S9,(Bin_m1569,39B_S15)))),(Bin_c801,(((Bin_c17,((((Bin_m1549,Bin_c793),Bin_c1084),(Bin_m1448,((Bin_c827,Bin_c1412),Bin_c570))),Bin_c43)),Bin_c1328),Bin_c1415))),((((Bin_m334,Bin_m1135),Bin_m1093),(((Bin_c590,Bin_c1023),(((((((Bin_m293,(Bin_m1424,Bin_m737)),Bin_m228),(Bin_c1500,Bin_m935)),(((Bin_c1384,Bin_m1662),((Bin_c186,Bin_c583),(Bin_m583,Bin_m1226))),(((Bin_m1768,((Bin_c991,Bin_c765),(Bin_m1454,Bin_c752))),(Bin_m621,Bin_m1981)),((Bin_c1167,Bin_m1503),(Bin_m28,(Bin_c552,Bin_c174)))))),(((Bin_m1413,Bin_c94),Bin_c742),(((Bin_c1216,Bin_c72),Bin_c1488),(Bin_m522,(Bin_c1750,(Bin_m1202,((Bin_c1673,Bin_c819),Bin_m1040))))))),(((Bin_c1081,Bin_m1197),((Bin_c1052,Bin_c503),Bin_m586)),((((Bin_c719,Bin_c1562),(((Bin_m1631,((Bin_m811,Bin_c58),Bin_c912)),(((Bin_c1199,Bin_c998),(Bin_c1378,Bin_c168)),(((Bin_c674,Bin_c544),(Bin_m708,(Bin_c1687,Bin_m936))),(Bin_m1461,(Bin_c1036,Bin_c1531))))),(((Bin_c745,Bin_c1372),Bin_m127),(Bin_c153,(Bin_m1367,Bin_c1297))))),(Bin_m21,Bin_c299)),(((((Bin_c480,(Bin_c1245,(Bin_m1252,(Bin_c1496,(Bin_c1047,Bin_m494))))),(Bin_m1474,Bin_c976)),(((Bin_c1294,(Bin_c908,Bin_c215)),Bin_c813),Bin_c732)),((Bin_m569,Bin_c438),((Bin_c1401,(Bin_c554,Bin_c1138)),(Bin_c1070,Bin_c1188)))),((Bin_m957,Bin_m1941),Bin_m1432))))),((Bin_c1490,(Bin_c1165,Bin_m1075)),(((Bin_m1863,(Bin_c375,Bin_c860)),(Bin_c448,Bin_c354)),(Bin_m798,Bin_c524))))),Bin_c1007)),(((Bin_c825,Bin_c1272),Bin_c1268),(Bin_c712,(Bin_c497,Bin_c116))))),(((((Bin_m1275,Bin_c40),(Bin_m994,Bin_m544)),(((Bin_m920,(Bin_m454,Bin_c355)),(Bin_m1477,((Bin_c1606,Bin_c1638),Bin_m731))),(Bin_m761,Bin_c1693))),(((Bin_c1326,(((((Bin_c101,(Bin_m1133,(Bin_c762,(Bin_c1275,(Bin_c308,(Bin_m965,Bin_c622)))))),(((((Bin_m89,Bin_m725),Bin_m1215),Bin_m1711),Bin_c298),(Bin_c730,Bin_c806))),(((Bin_c539,Bin_c1108),(Bin_c279,Bin_c750)),(((((Bin_m527,Bin_c578),(Bin_m1813,Bin_m498)),(Bin_c227,Bin_c828)),(((Bin_c1570,(Bin_c1325,Bin_c1296)),((((Bin_m595,Bin_c1683),(((((((((Bin_c513,Bin_m158),(Bin_m980,Bin_c1516)),((Bin_c962,Bin_c943),(Bin_c1235,Bin_c352))),(((Bin_c90,Bin_c454),(Bin_m1009,(Bin_m216,Bin_c557))),Bin_c1243)),Bin_c409),(((Bin_c329,((Bin_m959,Bin_m419),Bin_c894)),(Bin_c475,((Bin_c1264,(Bin_c294,Bin_c1194)),((Bin_m1066,Bin_c55),Bin_c399)))),Bin_c981)),((Bin_c141,(Bin_c31,Bin_c735)),(Bin_m1062,(Bin_m851,Bin_m1648)))),(((Bin_c572,(Bin_m273,Bin_m49)),(Bin_m748,(Bin_c657,Bin_c1082))),(Bin_c1686,((Bin_c297,(Bin_m1794,Bin_c59)),Bin_c83)))),(((Bin_c493,(Bin_c41,Bin_c393)),(Bin_c473,((((Bin_c1000,Bin_c1225),((Bin_c380,Bin_c1555),Bin_c1226)),Bin_c720),Bin_c420))),((Bin_c688,(Bin_c1476,(Bin_c338,Bin_m142))),Bin_c14)))),((Bin_m1425,(Bin_m1739,Bin_c832)),(Bin_c499,(Bin_c78,Bin_c262)))),(Bin_c36,(Bin_c568,((Bin_c1640,(((((((Bin_c607,Bin_c1435),Bin_c1183),Bin_m870),Bin_m638),(Bin_c217,Bin_c156)),Bin_c248),Bin_c24)),(Bin_c300,Bin_c251)))))),(Bin_c1111,Bin_c1005))),(((((((Bin_c748,Bin_c211),((((Bin_c1379,Bin_m584),(Bin_c120,Bin_c571)),(Bin_c121,Bin_m1545)),((Bin_c890,(Bin_m1254,Bin_c610)),((Bin_c1337,Bin_c1043),(Bin_c422,(Bin_c1158,Bin_c113)))))),((((Bin_c774,Bin_c633),(((Bin_c897,Bin_c397),(Bin_c892,Bin_c228)),(Bin_m1179,Bin_c386))),((Bin_c918,Bin_c631),(Bin_m1952,Bin_c901))),(((Bin_c345,((Bin_c856,Bin_c1113),Bin_c370)),Bin_c1549),(Bin_m1752,(Bin_c341,Bin_c1281))))),(((Bin_c534,((Bin_c956,Bin_c1119),Bin_c159)),Bin_c771),(Bin_c932,Bin_c1431))),((Bin_c1055,(Bin_m1167,Bin_c1173)),(Bin_m766,Bin_c362))),((((Bin_c1229,Bin_m1099),(Bin_c498,(Bin_c723,Bin_m1269))),Bin_c1212),((((Bin_c689,Bin_c1391),Bin_c1309),Bin_c416),((Bin_c665,Bin_m530),Bin_c471)))),(((Bin_m691,Bin_c51),Bin_c1180),(((Bin_c617,Bin_c1357),Bin_m881),(Bin_m1597,Bin_m14))))))),((Bin_c99,Bin_c796),(Bin_c89,(Bin_c241,(Bin_c1148,Bin_c413))))),(Bin_c867,Bin_c115))),(Bin_m137,Bin_m1246)),(Bin_m1352,Bin_m1265))),(Bin_c1492,Bin_c82)))),((41B_S7,((S126,S121),((S127,S123),S122))),Bin_c770)),S124,S128);

binsdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/raw/Chris_Q-Seb_R-assemblies_and_co-assemblies/99aab1ea-af6a-4ad1-9e88-5e59e4a6815f/coassembly/binning/consensus/bins"

targets=$(find -maxdepth 1 -type f -name "Bin*" | shuf -n 20)
for f in $targets
do
  cp "$f" /hpc-home/osbourne/mugsy_trial/
done

grep 'rpoB' ./*/*.gff

top_dir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "Bin*.gff")
for f in $target_files
do
  bin_name=$(basename "$f" | awk -F "-" '{print $1}')
  amino_ID=$(grep 'rpoB' "$f" | awk -F "ID=" '{print $2}' | awk -F ";" '{print $1}')
  amino_acid_file=$(readlink -f "$f" | sed 's/.gff/.faa/g')
  full_sequence_name=$(printf ">${amino_ID} DNA-directed RNA polymerase subunit beta")
  containing_dir=$(dirname "$f")
  seqtk seq -l 0 "$amino_acid_file" > "${containing_dir}/${bin_name}.temp_single_line_fasta.faa"
  grep -A1 "$full_sequence_name" "${containing_dir}/${bin_name}.temp_single_line_fasta.faa" > "${top_dir}/${bin_name}.rpoB_amino_acids.faa"
  sed -i -e "s/>/>${bin_name}_/g" "${top_dir}/${bin_name}.rpoB_amino_acids.faa"
  rm "${containing_dir}/${bin_name}.temp_single_line_fasta.faa"
  rm "${containing_dir}/${bin_name}.gff.temp_amino_name.txt" || echo "Already gone"
  printf "Processed file:\t$f\n"
done
cat *.rpoB_amino_acids.faa > "2023-05-17_all_rpoB_AA_sequences.faa"
rm *rpoB_amino_acids.faa

HCBFGOHJ_00858 DNA-directed RNA polymerase subunit beta

for f in *.fa
do
    bin_file="$f"
    bin_name=$(printf "$bin_file" | awk -F ".BBMa" '{print $1}')
    #Need to make a version with contig headers of under 31 characters in length for Prokka and might as well make it a single line version at the same time
    seqtk seq -l 0 "$bin_file" > "${bin_name}.temp.fa"
    #Now will get all the headers, write these to a file and then replace the headers with new ones with the format >FileID_randomalphanumeric, 10 characters only
    #for the random alphanumeric
    grep '>' "${bin_name}.temp.fa" > "${bin_name}.old_headers.txt"
    cp "${bin_name}.temp.fa" "${bin_name}.fa" 
    while IFS= read -r line
    do
        old_header=$(echo "$line")
        new_header=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${1:-10} | head -n 1)
        sed -i -e "s/${old_header}/>${bin_name}_${new_header}/g" "${bin_name}.fa"
    done < "${bin_name}.old_headers.txt"
    rm "${bin_name}.temp.fa"
    mv "$f" "${f}.deleteable"
    printf "Processed file:\t$f\n"
done

source package c8a0203d-707a-44e8-acdd-2c6ec17f8d7d #Hal 2.2

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/softmasked_files

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references
/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references/softmasked_and_min_contig_files
2022_04_04_combined_barrnap_bbmask_array_files_list_basename.txt

#2023-05-19
for f in *.fna
do
  oldname=$(basename "$f")
  newname=$(echo "$oldname" | sed 's/.fna/.fa/g')
  mv "$f" "$newname"
done

/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/softmasked_files

source package c8a0203d-707a-44e8-acdd-2c6ec17f8d7d #HAL 2.2
halStats --tree Cactus_aln_isolates_and_bins.hal

while IFS= read -r line
do
  bin_name="$line"
  grep -q "$bin_name" AC_enriched_bins.txt && enrichment="AC"
  grep -q "$bin_name" AR_enriched_bins.txt && enrichment="AR"
  enrichment=${enrichment:="NA"}
  if [[ "$enrichment" == "AC" ]]
  then
    printf "${bin_name}\tlabel_background\t#b5f1f9\n"
    printf "${bin_name}\trange\t#b5f1f9\tAC_enriched_bin\n"
  elif [[ "$enrichment" == "AR" ]]
  then
    printf "${bin_name}\tlabel_background\t#f9bdb5\n"
    printf "${bin_name}\trange\t#f9bdb5\tAR_enriched_bin\n"
  elif [[ "$enrichment" == "NA" ]]
  then
    printf "${bin_name}\tlabel_background\t#c9cdd1\n"
    printf "${bin_name}\trange\t#c9cdd1\tBin\n"
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt

#AC enriched first
while IFS= read -r line
do
  bin_name="$line"
  grep -q "$bin_name" AC_enriched_bins.txt && enrichment="AC" || enrichment="FAILURE"
  if [[ "$enrichment" == "AC" ]]
  then
    printf "${bin_name}\tlabel_background\t#b5f1f9\n" >> ITOL_prep.tsv
    printf "${bin_name}\trange\t#b5f1f9\tAC_enriched_bin\n" >> ITOL_prep.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt

#AR enriched
while IFS= read -r line
do
  bin_name="$line"
  grep -q "$bin_name" AR_enriched_bins.txt && enrichment="AR" || enrichment="FAILURE"
  if [[ "$enrichment" == "AR" ]]
  then
    printf "${bin_name}\tlabel_background\t#f9bdb5\n" >> ITOL_prep.tsv
    printf "${bin_name}\trange\t#f9bdb5\tAR_enriched_bin\n" >> ITOL_prep.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt

#Lastly the none
while IFS= read -r line
do
  bin_name="$line"
  grep -q "$bin_name" ITOL_prep.tsv && enrichment="Present" || enrichment="None"
  if [[ "$enrichment" == "None" ]]
  then
    printf "${bin_name}\tlabel_background\t#c9cdd1\n" >> ITOL_prep.tsv
    printf "${bin_name}\trange\t#c9cdd1\tBin\n" >> ITOL_prep.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt

while IFS= read -r line
do
  bin_name="$line"
  family_classification=$(awk -F "\t" -v binner="$bin_name" '$1==binner {print $2}' 2023-05-19_all_bins_gtdbtk_classification_only.tsv | awk -F ";f__" '{print $2}' | awk -F ";g__" '{print $1}')
  printf "$bin_name\t$family_classification\n" >> 2023-05-19_strict_bins_and_families.tsv
done < list_strict_bins.txt

Ruminococcaceae
Desulfovibrionaceae
Muribaculaceae
Acutalibacteraceae
Lachnospiraceae

#Lachnospiraceae bins
while IFS= read -r line
do
  bin_name="$line"
  family=$(awk -F "\t" -v binner="$bin_name" '$1==binner {print $2}' 2023-05-19_strict_bins_and_families.tsv)
  if [[ "$family" == "Lachnospiraceae" ]]
  then
    printf "${bin_name}\tlabel_background\t#1e90ff\n" >> ITOL_prep_2.tsv
    printf "${bin_name}\trange\t#1e90ff\tLachnospiraceae\n" >> ITOL_prep_2.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt
#Muribaculaceae
while IFS= read -r line
do
  bin_name="$line"
  family=$(awk -F "\t" -v binner="$bin_name" '$1==binner {print $2}' 2023-05-19_strict_bins_and_families.tsv)
  if [[ "$family" == "Muribaculaceae" ]]
  then
    printf "${bin_name}\tlabel_background\t#ff8d1e\n" >> ITOL_prep_2.tsv
    printf "${bin_name}\trange\t#ff8d1e\tMuribaculaceae\n" >> ITOL_prep_2.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt
#Ruminococcaceae
while IFS= read -r line
do
  bin_name="$line"
  family=$(awk -F "\t" -v binner="$bin_name" '$1==binner {print $2}' 2023-05-19_strict_bins_and_families.tsv)
  if [[ "$family" == "Ruminococcaceae" ]]
  then
    printf "${bin_name}\tlabel_background\t#8d1eff\n" >> ITOL_prep_2.tsv
    printf "${bin_name}\trange\t#8d1eff\tRuminococcaceae\n" >> ITOL_prep_2.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt
#Acutalibacteraceae
while IFS= read -r line
do
  bin_name="$line"
  family=$(awk -F "\t" -v binner="$bin_name" '$1==binner {print $2}' 2023-05-19_strict_bins_and_families.tsv)
  if [[ "$family" == "Acutalibacteraceae" ]]
  then
    printf "${bin_name}\tlabel_background\t#eae900\n" >> ITOL_prep_2.tsv
    printf "${bin_name}\trange\t#eae900\tAcutalibacteraceae\n" >> ITOL_prep_2.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt
#Desulfovibrionaceae
while IFS= read -r line
do
  bin_name="$line"
  family=$(awk -F "\t" -v binner="$bin_name" '$1==binner {print $2}' 2023-05-19_strict_bins_and_families.tsv)
  if [[ "$family" == "Desulfovibrionaceae" ]]
  then
    printf "${bin_name}\tlabel_background\t#009e9d\n" >> ITOL_prep_2.tsv
    printf "${bin_name}\trange\t#009e9d\tDesulfovibrionaceae\n" >> ITOL_prep_2.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt

GCF_902374815.1_MGYG-HGUT-01422_genomic.fna

while IFS= read -r line
do
  subject_file="$line"
  if [[ "$subject_file" == *"temp"* ]]
  then
    printf "$subject_file was a bad file\n"
  else
    printf "I would copy $subject_file to $outdir\n"
  fi 
done < "$list_of_files_file" | wc -l

source package cab8386a-c777-4936-8411-a6ed2b5e6a20 #BBmap - 38.79
source package 46a62eca-4f8f-45aa-8cc2-d4efc99dd9c6 #Seqkit - 0.12.0

nome=$(basename NZ_CP035790.1_Limosilactobacillus_reuteri_strain_ATG-F4_chromosome_complete_genome.fa | awk -F "." '{print $1}')
cat NZ_CP035790.1_Limosilactobacillus_reuteri_strain_ATG-F4_chromosome_complete_genome.fa | sed 's@/@ @g' | sed 's@\\@ @g' | seqkit seq -m 500 --quiet | srun bbmask.sh -Xmx2g -Xms1g in=stdin.fa out="${nome}.trial.fa" threads=auto maskrepeats=t minkr=5 maxkr=15 minlen=30 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.85 lowercase=t

#2023-05-22
#Potentially the tree for the all vs all cactus run, would need newick utils processing though
(Bin_c248:0.059427940060,(((Bin_c1640:0.162167654577,Bin_c24:0.097840835423):0.063387135809,(((Bin_m870:0.105622830645,Bin_c156:0.048068249355):0.033625799381,(((Bin_c1693:0.113589351124,Bin_m1352:0.090945608876):0.086980311737,Bin_c1435:0.117508333263):0.079563278785,(((Bin_m216:0.096808976709,(GCF_018408575:0.029034828347,Bin_c513:0.126220741653):0.078178543291):0.050775996594,(((Bin_c454:0.040660316531,Bin_c557:0.091620383469):0.068730137247,(Bin_c90:0.090887052690,Bin_m1009:0.015585647310):0.048198062753):0.035648790508,((((Bin_c943:0.085130539693,(Bin_c962:0.067678755276,Bin_c1235:0.112947194724):0.055881785307):0.019118235328,iMGMC_694:0.082887927172):0.061941437748,(((iMGMC_297:0.144865335402,Bin_m980:0.044100354598):0.024717046366,Bin_c1516:0.094953103634):0.048708320560,(GCF_010508875:0.064494478878,(GCF_017811815:0.036696801014,GCF_000169255:0.049759868986):0.052811186122):0.030636176315):0.036685583815):0.009958314991,(Bin_c1243:0.117373833524,(GCF_000154385:0.081402850536,GCF_001244995:0.019419039464):0.082390296476):0.068779360791):0.026803208086):0.050563461413):0.024865340984,((((((iMGMC_804:0.018594436990,Bin_m1739:0.039861146990):0.132178380974,(Bin_m994:0.190423351212,(Bin_m595:0.068100122026,Bin_m544:0.127805207974):0.014506728788):0.026985731526):0.059267388000,(((Bin_m1275:0.090432069923,Bin_c40:0.069218980077):0.015687901592,GCF_001945525:0.072165763408):0.087948412785,GCF_001244495:0.065822512215):0.061315703250):0.030222763622,(((((((((GCF_025311515:0.064064456807,((16aD_S27:0.003896246326,39E_S18:0.011804723674):0.005533224882,16aA_S24:0.001316194882):0.055340743193):0.044193989737,((NZ_LN906634:0.005460552222,(NZ_CP035790:0.000127147408,(NZ_CP011024:0.002766647885,NZ_CP041676:0.023735017885):0.007145417408):0.049368867222):0.042887117919,((GCF_009428965:0.071295261045,16aF_S29:0.005097841045):0.046711005472,((18E_S13:0.010519695886,((16bD_S22:0.002976240918,((16aC_S26:0.000363902997,((((39A_S14:0.003591333903,13B_S2:0.002882233903):0.001557852235,16bE_S23:0.007539352765):0.003500539092,16aE_S28:0.007404080908):0.002778905560,(16bC_S21:0.004722231222,13D_S4:0.000379341222):0.003762455690):0.001255712997):0.003538661906,13E_S5:0.002491350968):0.005685982324):0.009480679937,18B_S10:0.003712156031):0.010798106862):0.052899934332,(Bin_m780:0.103964023252,Bin_m1301:0.003767756748):0.110838948178):0.014698305622):0.023800190437):0.015426412203):0.041399809083,(((((16bB_S20:0.001542456555,18D_S12:0.009625206555):0.031153088555,(16aB_S25:0.000620892946,13A_S1:0.008087307054):0.005258563945):0.034471923769,(((NZ_CP061341:0.001631654388,NZ_CP045033:0.008327014388):0.032385682507,((GCF_002160635:0.010392340915,GCF_000194115:0.026419639085):0.030896745713,(((NZ_CP045642:0.011658536961,NZ_CP045590:0.015492293039):0.017518567517,NZ_CP020029:0.016523602517):0.033633613995,(39D_S17:0.000768643182,39C_S16:0.016651766818):0.066024543505):0.000616022412):0.020457932805):0.012733619283,GCF_016647595:0.065968911029):0.009705634200):0.014441391775,((Bin_m1485:0.110764913911,GCF_000389675:0.005992853911):0.044610517737,(Bin_m1122:0.092296061969,Bin_c1617:0.051732188031):0.080348447263):0.022965108401):0.050088936820,((((GCF_017894345:0.007835277611,GCF_024397795:0.075212902389):0.024074613474,GCF_014841035:0.033172636526):0.042920250089,(GCF_008868535:0.031572344733,NZ_CP022109:0.116007925267):0.033520054911):0.011420155950,GCF_001434335:0.073003647800):0.004639974662):0.041021266403):0.020725467620,((GCF_003600795:0.103863008478,(NZ_CP066043:0.008468148807,41C_S8:0.019061418807):0.069917361522):0.041414108157,((NZ_CP029971:0.068743146660,(Bin_c890:0.106690105570,GCF_005601135:0.085280234430):0.031432523340):0.035536133606,(NZ_CP064314:0.026177109832,NZ_CP029546:0.011130429832):0.078818941394):0.017389027156):0.054944726493):0.010199250379,((S128:0.008935960737,S124:0.004350520737):0.070972354137,(((S126:0.001581012239,((S122:0.009235905456,S121:0.000001574544):0.002878081402,(S123:0.003050496310,S127:0.007174533690):0.003976023598):0.005159342239):0.004965242300,((41B_S7:0.003504007605,(NZ_CP023566:0.004543363066,NZ_CP023565:0.002007133066):0.006707867395):0.005094322249,NZ_CP040852:0.005216187751):0.006210993013):0.017198463496,((NZ_CP039849:0.004599382427,NZ_CP047141:0.017565857573):0.006656153681,Bin_c770:0.001176231319):0.032700600410):0.038876085550):0.081060722258):0.005859667417,(((GCF_009734005:0.094150957600,16bA_S19:0.070064962400):0.031201022185,(GCF_002813755:0.065772018481,((NZ_CP012275:0.059072513865,NZ_CP014924:0.065269356135):0.050796156411,41A_S6:0.058309513589):0.070798474019):0.043137202190):0.022333632807,((GCF_900459045:0.062313408438,GCF_001921845:0.005617691562):0.073694413023,(GCF_000826525:0.103489061886,NZ_CP042413:0.103036958114):0.017544834477):0.082985567975):0.006519619827):0.020599358377,((((GCF_900475405:0.089793091023,(((GCF_900113055:0.089697370024,GCF_000024925:0.045632719976):0.103170124099,(GCF_016127955:0.094344375295,GCF_014217215:0.075917504705):0.123867858401):0.004426586559,GCF_009193255:0.108663649691):0.022300030227):0.050577159262,(((Bin_c801:0.081681095987,(((Bin_m1448:0.020805726879,((Bin_c570:0.124572573372,Bin_c827:0.045070196628):0.043852646092,Bin_c1412:0.009198233908):0.077059228121):0.013789909908,(((Bin_m1549:0.104300852836,Bin_c793:0.076895537164):0.073073988866,Bin_c1084:0.083963146134):0.019635221483,(Bin_c1328:0.102868999973,Bin_c17:0.049855400027):0.055385767267):0.045995108373):0.071301418022,Bin_c1415:0.113975398775):0.066004311513):0.080102085115,(((GCF_018128425:0.049761831238,((GCF_016415705:0.013833155362,(GCF_000534275:0.064442945494,GCF_019048625:0.013687834506):0.056769994638):0.010363655627,((GCF_021278985:0.056862573547,GCF_020097475:0.024182506453):0.014587447151,(GCF_011605535:0.071386879440,GCF_000005845:0.013237820560):0.042744532849):0.014292786873):0.025237396262):0.048842146626,GCF_000240185:0.023841692124):0.069287061447,(GCF_002077695:0.082381812362,GCF_900108535:0.075124897638):0.038325553085):0.072131596990):0.063007200397,(((iMGMC_732:0.054912623073,Bin_c1256:0.090362816927):0.119248582119,(Bin_c1526:0.086220270212,(((Bin_c52:0.005244864370,Bin_m1657:0.126273195630):0.093664312886,(Bin_m7:0.082072015222,Bin_m1590:0.028363764778):0.014993737114):0.042048968201,(GCF_000478885:0.039044516804,Bin_m1500:0.052401473196):0.050841914299):0.033396766038):0.004715060069):0.088671468709,((((Bin_m1569:0.014137650340,(39B_S15:0.008732153233,GCF_002282915:0.030829876767):0.039162725340):0.041306784419,18A_S9:0.041004984419):0.095400646486,GCF_001281425:0.036300767264):0.086817414753,Bin_c1233:0.054152592122):0.015578774084):0.061007099251):0.009931571333):0.028373137204,(((GCF_000013425:0.057602765912,GCF_900106845:0.102873894088):0.036623356292,(GCF_016599875:0.119474469841,GCF_025558845:0.076283500159):0.051801828708):0.041885238314,((GCF_000063585:0.071317016051,GCF_002933735:0.132760453949):0.041469357649,GCF_002865995:0.055580767351):0.091395544186):0.007709858756):0.031853626379,((((((GCF_000016525:0.208548271505,GCA_008632635:0.076440278495):0.165190834906,(GCF_000393015:0.064138664771,Bin_c112:0.167892755229):0.031205497594):0.042135226937,(GCF_022394675:0.004524566474,GCF_002243645:0.073304816474):0.014838246813):0.085814599040,(((((GCF_008807735:0.011528935841,GCF_011040455:0.034541034159):0.036494675233,GCF_002220285:0.003286685233):0.015756749539,(GCF_001884235:0.058324905783,GCF_001884065:0.004595055783):0.029463792961):0.031440600205,GCF_001590835:0.046018516045):0.069486254274,(GCF_002200915:0.110745099611,(GCF_022559225:0.074629438423,((GCA_023614115:0.002270990657,GCF_002688605:0.021857010657):0.057802697071,GCF_009935415:0.020292852071):0.084566576577):0.045968221639):0.034836743109):0.022149688519):0.017657911307,(((GCF_014042035:0.002490749737,GCF_002074095:0.031405230263):0.060315584244,(GCF_001274775:0.035236991672,GCF_020002245:0.114111048328):0.046278368256):0.052201297520,(((GCF_023238325:0.029815887627,GCF_000009045:0.033790222373):0.016064109555,GCF_012225885:0.003355200445):0.070293165165,(GCF_019396925:0.007843453379,GCF_000769555:0.000983023379):0.072643268585):0.045003919042):0.012746897404):0.021606475343,(((((GCF_002209165:0.076051695718,GCF_007814115:0.023487054282):0.058056012475,GCF_020790155:0.065120742525):0.031869979973,(((GCF_900458705:0.057678240454,GCF_013046825:0.111718629546):0.029824785616,Bin_c82:0.080388474384):0.032998974485,GCF_000715205:0.074843560515):0.028607759402):0.023900029964,(GCF_025272815:0.056037829143,(GCF_003812505:0.042507656376,((GCF_012844185:0.073740902934,GCF_009731575:0.135842767066):0.057980530161,NZ_LT854705:0.021489294839):0.095385441124):0.027711900857):0.022815489840):0.045306696024,(((GCF_020138775:0.064236111700,GCF_000786195:0.104846688300):0.065223856961,GCF_007988965:0.053391148039):0.089664325373,(GCF_008244765:0.031659391332,GCF_001584325:0.078061148668):0.055584633377):0.026547255090):0.011753829147):0.011908198503):0.008582645213):0.041030999512,((((((GCF_900155865:0.013199683219,GCF_003865075:0.039953176781):0.048105636977,(((GCF_910575425:0.023823782806,GCF_900130125:0.011775397194):0.014448436337,GCF_001688725:0.044687178663):0.034069821089,(GCF_020091425:0.071624036796,Bin_c1070:0.098075653204):0.068532288911):0.022057698648):0.029696468806,(((GCF_020735865:0.035473262715,(GCF_000307345:0.005015039749,Bin_m1941:0.092262849749):0.016431977285):0.054526359519,GCF_018292165:0.058482327981):0.016036738278,((GCF_902374815:0.051385882836,GCF_020341675:0.081719547164):0.053720307549,(GCF_012273055:0.003351039057,Bin_m957:0.037776150943):0.031443847451):0.028050111097):0.040369832522):0.023269833133,((GCF_000154465:0.048233554666,((GCF_902387545:0.024014482662,GCF_013358205:0.035074877338):0.090187071619,GCF_015548275:0.026442498381):0.022766832834):0.021277994463,(((((Bin_c1496:0.044849390887,Bin_m1474:0.118953429113):0.023003493815,Bin_c1245:0.023022866185):0.064487463498,(Bin_c480:0.084084166972,(GCF_002504085:0.163160634662,GCF_014163495:0.066066925338):0.049022268028):0.059601797752):0.027500277230,(((GCF_900624755:0.035052313169,GCF_900107675:0.021089666831):0.039314304601,(Bin_m494:0.061999259353,Bin_m1252:0.064175140647):0.068374787899):0.023444533400,GCF_015558405:0.011158482850):0.021240510895):0.012464709421,((Bin_c1047:0.035449622141,(GCF_006542665:0.025878548883,Bin_c1138:0.090491271117):0.049139347859):0.050035622125,GCF_006542645:0.049309692875):0.020246441673):0.043991288311):0.018903457263):0.038075062180,((((((Bin_m1981:0.034436713001,(Bin_m1454:0.046968955866,Bin_c976:0.119105824134):0.069922901999):0.034709080452,(Bin_m334:0.081991628014,((GCF_000762845:0.123454062861,Bin_m1093:0.065820632861):0.150265198800,Bin_m1135:0.130624976200):0.067533284486):0.161511573610):0.066400132310,((Bin_m1662:0.094933987955,(Bin_c94:0.048810535255,Bin_c1750:0.089381534745):0.032844062045):0.023173421437,(Bin_c1488:0.089533620866,GCF_001688845:0.054135239134):0.032520416063):0.026076958706):0.001903250291,(((Bin_c503:0.085648126534,Bin_c168:0.080009643466):0.016707480636,(iMGMC_520:0.072811591876,(Bin_c752:0.094301829095,Bin_c1490:0.056370470905):0.017889948124):0.059274480614):0.024302977337,Bin_m737:0.080520389538):0.049447703693):0.014751410497,((((Bin_m936:0.058355825521,Bin_m28:0.072175094479):0.027196400040,((Bin_m127:0.076404390715,iMGMC_613:0.069540959285):0.006034190179,Bin_m935:0.083339489821):0.028564822460):0.049799890014,((((Bin_c1531:0.079686511327,Bin_m708:0.045366848673):0.022740615546,(Bin_c544:0.061392008336,(Bin_c998:0.086348655959,Bin_m583:0.060865534041):0.030911096664):0.024444441954):0.053231827294,((Bin_c912:0.064256404595,((Bin_c1687:0.051404405403,Bin_c745:0.071434944597):0.004939250666,(Bin_m1197:0.060269716630,Bin_c719:0.081884993370):0.024878661834):0.025986751655):0.041845150437,((Bin_c1165:0.052364528813,Bin_c732:0.141799701187):0.067897555513,Bin_m1631:0.019113499487):0.055181333001):0.005665802940):0.024298063714,(((Bin_m1432:0.074925911282,Bin_c1378:0.099159838718):0.030510745970,((Bin_m1503:0.068469407938,Bin_c1199:0.058032542062):0.020318276418,(Bin_c1372:0.043968178789,Bin_c58:0.089216601211):0.031051966082):0.027129696530):0.046585047413,(((Bin_m1461:0.038118254126,Bin_c1297:0.089794455874):0.038953159226,Bin_c153:0.085147070774):0.035160755275,((Bin_m1367:0.059569345689,Bin_c674:0.080951744311):0.011660146723,(Bin_m21:0.034793901332,(Bin_c1036:0.088158367927,Bin_m811:0.037361312073):0.063205723668):0.026926153277):0.038511286287):0.015189523524):0.012388192253):0.010234286612):0.016937003072,((((GCA_001689405:0.071711567456,Bin_m1413:0.026799582544):0.087701247601,Bin_c1052:0.065725277399):0.029027548449,(Bin_m586:0.081235975741,(Bin_m522:0.062643960615,Bin_c860:0.061855229385):0.025839814259):0.046819448426):0.035212602450,((((Bin_c552:0.065467724963,Bin_c1500:0.085523575037):0.028305576919,Bin_m1226:0.063706118081):0.059765142180,((((Bin_c991:0.029311438829,(Bin_c765:0.048435232819,Bin_c524:0.070326227181):0.023939776171):0.026116466394,Bin_c1167:0.055502086106):0.068271372910,(((Bin_c1216:0.068278445377,Bin_c742:0.069759524623):0.041872003500,(Bin_c1562:0.053491555019,(Bin_c1081:0.051467974270,(Bin_c1384:0.053473803546,Bin_m293:0.070618026454):0.042477085730):0.053962594981):0.018937657750):0.041927693897,Bin_c186:0.028240621728):0.012155995098):0.008545444332,(Bin_m1768:0.049874730890,(Bin_m621:0.028529706917,((Bin_c554:0.081669955681,(Bin_c1401:0.132004121912,Bin_c438:0.044445308088):0.028523524319):0.035106855871,Bin_c590:0.084371114129):0.036258910583):0.056645936610):0.035069017543):0.024347040096):0.006041643549,(((((Bin_m569:0.104047913698,Bin_c819:0.054677616302):0.056462674200,Bin_c375:0.038705565800):0.025328888746,(Bin_c1007:0.094331683080,Bin_c72:0.064777946920):0.029528630004):0.044315534733,((Bin_m1863:0.073074301107,Bin_c174:0.052868968893):0.035414371234,(Bin_m1075:0.043211257451,(Bin_c583:0.039614500069,(Bin_c1188:0.132673493156,Bin_m1202:0.067991046844):0.022919999931):0.041012067549):0.021052471266):0.039042263939):0.008865903024,((Bin_c1673:0.050851149225,(Bin_c448:0.062367452420,Bin_c1023:0.060495977580):0.041874660775):0.023409961586,(Bin_c354:0.060130503623,(Bin_m1424:0.064513089054,(Bin_m798:0.064458759556,(Bin_m1040:0.064889600312,Bin_m228:0.061711469688):0.006490120444):0.051233033446):0.020311841377):0.048145280914):0.027664146995):0.014102638061):0.003151412715):0.003046230708):0.019383408756):0.034086270256,(Bin_c299:0.077440480315,(((Bin_c813:0.128816938629,Bin_c908:0.027894441371):0.037357478715,Bin_c1294:0.059555401285):0.008970266594,Bin_c215:0.053526238406):0.077706577185):0.059818762843):0.026766734809):0.081287537011,((Bin_c1268:0.071946806123,Bin_c1272:0.114295643877):0.075122265850,(iMGMC_580:0.126734506028,(Bin_c825:0.098411314134,(Bin_c712:0.083779092875,(Bin_c497:0.046844254874,Bin_c116:0.036833185126):0.154050052125):0.096099423366):0.043451747722):0.060888667275):0.078506652916):0.054636039038):0.016473246658,((Bin_m1477:0.140307920114,(Bin_c1638:0.135958755983,Bin_c1606:0.008180774017):0.062271389886):0.046558703584,((Bin_m731:0.114551684030,(Bin_c355:0.017269924927,Bin_m761:0.139228855073):0.088811585970):0.045707454800,((Bin_m920:0.102634376898,Bin_m454:0.023544593102):0.077020651081,iMGMC_1015:0.074798828919):0.083769692700):0.013698998291):0.103046136765):0.032440753956):0.043368546837,(((Bin_m530:0.106200844576,(Bin_c796:0.077171469619,iMGMC_554:0.099156800381):0.013590040424):0.045880679817,(Bin_m1265:0.122948758862,iMGMC_64:0.083392511138):0.059261065183):0.044514684027,((((((((((Bin_m1597:0.086901721429,Bin_m881:0.065412588571):0.055399213692,(Bin_m1752:0.041748792660,Bin_c665:0.108843247340):0.033047011308):0.023350232681,Bin_c341:0.064912542319):0.052710881649,((Bin_c1275:0.098818264644,Bin_c1148:0.097204945356):0.020470840743,(Bin_c159:0.041139072460,(Bin_c1212:0.086264043099,Bin_c918:0.086870676901):0.049517752540):0.031916963007):0.032911533038):0.029203287195,(((Bin_c622:0.095582236344,(Bin_c420:0.061341905674,Bin_c828:0.111989344326):0.077692498656):0.044412283236,Bin_m965:0.078031409264):0.021373681116,(Bin_c856:0.060151756044,(Bin_c762:0.058930980937,Bin_c308:0.056582769063):0.045097543956):0.022664061071):0.076488368273):0.015999455273,((((Bin_c397:0.067872020858,((Bin_m1269:0.061281239544,iMGMC_386:0.056721980456):0.034735147797,(Bin_c534:0.077044272619,Bin_c498:0.058516477381):0.020595029703):0.083840967892):0.026542268455,((Bin_c617:0.056175898123,Bin_m1545:0.085365251877):0.021821352079,(iMGMC_232:0.085364712770,Bin_c1229:0.060052317230):0.044429462921):0.050744912795):0.027762194131,((iMGMC_87:0.060084963038,((Bin_c121:0.062826183160,Bin_m1813:0.101548036840):0.019716236140,Bin_c1337:0.054426853860):0.053714081962):0.020532702752,(Bin_c892:0.065758427115,Bin_c228:0.060599322885):0.047250780998):0.056512085244):0.004433666418,((((iMGMC_262:0.092838552853,Bin_c1158:0.085934687147):0.024795192900,Bin_c1549:0.088596597100):0.033736533259,(Bin_c1431:0.036322318934,((Bin_c633:0.081964378403,Bin_c1379:0.067825651597):0.044325768744,Bin_c932:0.050986081256):0.035634928566):0.058616790804):0.019901773190,(((Bin_c689:0.069381419486,Bin_c1309:0.069287250514):0.053684506170,(((Bin_c115:0.059600583174,Bin_c1570:0.117544016826):0.074737582613,Bin_c1111:0.049016412387):0.039256713583,(Bin_c51:0.044843050507,Bin_m691:0.076884279493):0.083702033917):0.049463941330):0.029798207408,(((iMGMC_66:0.060665903047,Bin_c1108:0.096761476953):0.069552732116,Bin_c806:0.077161622884):0.044656499428,Bin_c1357:0.084595698072):0.039798997280):0.020681120873):0.022489159065):0.003081953407):0.007145491551,((((Bin_m1952:0.039343843838,Bin_c370:0.110167686162):0.046744236961,Bin_c901:0.050067758039):0.024331969274,((Bin_m14:0.068315276653,Bin_m1167:0.081355383347):0.048629407460,Bin_c1113:0.045619352540):0.049852176976):0.031804775706,((Bin_c897:0.060594779511,((Bin_c578:0.042380380615,Bin_c832:0.117204899385):0.051497979565,Bin_c1173:0.048760585435):0.069353477989):0.025843433700,(Bin_c1281:0.101318853680,(Bin_c1005:0.059701184420,(iMGMC_177:0.022621137920,Bin_c631:0.047449192080):0.067719380580):0.025677248820):0.055981440675):0.016715194372):0.029177320107):0.003890735785,(((Bin_c345:0.074935089238,(Bin_c730:0.061454920691,Bin_c101:0.063028169309):0.050961965762):0.033219892948,(((Bin_m766:0.040448991528,Bin_c610:0.096393948472):0.033752250632,Bin_c362:0.063308939368):0.056965938185,(Bin_c1119:0.080719723535,GCF_025151995:0.115432166465):0.047505439315):0.028313803927):0.042063015635,(((Bin_c493:0.124802116653,iMGMC_444:0.063629963347):0.094887472672,Bin_c422:0.091406867328):0.053907956615,(((Bin_m89:0.061490323676,Bin_m1215:0.057804216324):0.086386848017,(Bin_m725:0.016031797272,Bin_m1711:0.091838962728):0.057742026983):0.050318467743,(((Bin_m584:0.042534096311,(Bin_m1246:0.044626669224,Bin_c867:0.123122710776):0.076873313689):0.052015293311,(Bin_c571:0.047048563614,(Bin_c771:0.061960004873,(Bin_c113:0.099576970492,Bin_c120:0.058944779508):0.052673710127):0.027254813886):0.061957432627):0.024379901332,Bin_c298:0.075679948824):0.025341513586):0.024296694401):0.028157556577):0.009607799046):0.009347339093,(((Bin_c416:0.066472132477,(Bin_c1055:0.087078249274,GCF_013304825:0.072681610726):0.043055872523):0.052035678710,(Bin_c750:0.053098238933,iMGMC_435:0.094678471067):0.055570093790):0.036400210411,((Bin_m527:0.062074591420,(((Bin_c1226:0.090461701785,Bin_c1180:0.097844958215):0.090789426585,Bin_c723:0.037650298415):0.054880395726,(Bin_m1254:0.068953256081,Bin_c1043:0.062097283919):0.036450460524):0.012944502955):0.053751005975,((Bin_c539:0.085610651380,Bin_m498:0.059251118620):0.044093491260,Bin_c748:0.062814493740):0.065002794338):0.033391543691):0.012892933593):0.006758458068,((((iMGMC_1047:0.206886472820,Bin_c774:0.035980087180):0.040393480969,Bin_m1099:0.080279289031):0.066586641212,(((Bin_c99:0.071085611326,(Bin_m1179:0.048096416265,(Bin_c386:0.046625533121,(Bin_m137:0.117610418314,Bin_m1133:0.089199221686):0.037270546879):0.065884491235):0.038383188674):0.053789465454,((Bin_c241:0.081499661430,(Bin_c413:0.043029212647,(Bin_c1325:0.099122983360,Bin_c1296:0.010998636640):0.078079807353):0.096348226070):0.048511546472,Bin_c89:0.033433298528):0.038726629819):0.034112381774,Bin_c279:0.074168537777):0.019477033202):0.023863266146,((Bin_c956:0.051815864703,Bin_c227:0.071034275297):0.013935099300,Bin_c1326:0.098597465700):0.082216767917):0.018216719662):0.016583938190):0.044524066977):0.018206486950,((((((Bin_c36:0.086067278988,Bin_c473:0.093284571012):0.041508306096,(Bin_c1686:0.083235177586,Bin_m748:0.084184162414):0.034759853904):0.057643686832,((Bin_c1225:0.063499396392,Bin_c1555:0.077728803608):0.055991968231,(Bin_c1000:0.033237663416,(Bin_c1492:0.124067202602,(Bin_c720:0.065184633983,iMGMC_413:0.128162986017):0.018290367398):0.123420071584):0.044329024894):0.048230398637):0.029023521936,(((((((Bin_m959:0.086565664999,((Bin_c211:0.100765339601,Bin_c1391:0.089126540399):0.005843315463,Bin_c471:0.061898904537):0.072099735001):0.033460873954,Bin_c981:0.062058394796):0.062276602873,(Bin_c894:0.061327354768,Bin_c329:0.056798665232):0.083668001502):0.031008766688,Bin_c1683:0.047988250812):0.036129759533,iMGMC_505:0.108346573280):0.068791668933,((iMGMC_715:0.045182827774,Bin_c1082:0.030260357774):0.112588212898,(Bin_c657:0.082071266336,Bin_m273:0.068593263664):0.070729064602):0.038385189622):0.029424817577,((((((Bin_c475:0.005354778589,(Bin_m1066:0.101490605258,Bin_c55:0.077167474742):0.018203036411):0.051331863723,((Bin_c1264:0.103251428706,Bin_c1194:0.012908718706):0.040508115212,Bin_c294:0.063435874788):0.051826326902):0.033757652622,Bin_c399:0.114751317065):0.050781993317,((Bin_c141:0.101437607599,Bin_c83:0.074838932401):0.042391927969,Bin_m1062:0.074316737031):0.026949419183):0.018132296448,(((Bin_c735:0.027399197896,Bin_m1648:0.080693402104):0.039565467175,Bin_m851:0.095058202825):0.051470525619,(Bin_c31:0.095790376488,Bin_m419:0.095954113512):0.019259891881):0.038020449841):0.039470367523,(((Bin_m49:0.107171761572,Bin_c78:0.091138368428):0.054980963163,Bin_c297:0.062375461837):0.045957426975,((Bin_c572:0.082964163093,((Bin_c41:0.056100604990,iMGMC_609:0.063604955010):0.086295364215,Bin_c393:0.079841610785):0.079403316907):0.023075049270,Bin_c59:0.045675968230):0.035827606306):0.034324266672):0.029123405852):0.010904939668):0.013815764597,((Bin_c568:0.238902934771,Bin_m158:0.061383945229):0.089514164647,Bin_m1794:0.022333940353):0.091987369882):0.016663524046,(((((Bin_m1425:0.063782782951,Bin_c262:0.097999227049):0.059707651803,Bin_c380:0.126614783197):0.052880735783,Bin_c688:0.028557539217):0.078730445599,(Bin_c499:0.123737393228,(Bin_c14:0.046765690911,(Bin_c409:0.070348942931,iMGMC_193:0.143155207069):0.065291889089):0.022432736772):0.064698694245):0.017393921916,((Bin_c338:0.094159792442,(GCF_001956035:0.127171336774,Bin_c352:0.056127343226):0.058233817558):0.051320699169,(Bin_c1476:0.094603528741,Bin_m142:0.067460901259):0.013572670831):0.090558163631):0.013583080175):0.016372094001):0.017379329621):0.026873042938):0.071334421176):0.066463832182,((Bin_c607:0.078952163381,Bin_c1183:0.087950896619):0.041884048055,(Bin_m638:0.104404510707,Bin_c43:0.152439229293):0.086192521945):0.036499723828):0.022571805547):0.019338401691,((Bin_c300:0.038591980070,Bin_c251:0.071772289930):0.026988808437,Bin_c217:0.143981401563):0.065088224331):0.089378134419,iMGMC_912:0.127389399940);

possible_cactus_info_file.txt
for f in *.fa
do
    input_name=$(basename "$f" | awk -F "[.]" '{print $1}')
    input_path=$(readlink -f "$f")
    printf "${input_name}\t${input_path}\n" >> "possible_cactus_info_file.txt"
    printf "Added details for file:\t$f to possible_cactus_info_file.txt\n"
done

#2023-05-24
#Processing the cactus output for the everything versus everything trees
CONTAINS==NZ
CONTAINS==NZ
CONTAINS==NZ
CONTAINS==GCF
CONTAINS==GCF
CONTAINS==GCF
CONTAINS==iMGMC
CONTAINS==iMGMC
CONTAINS==iMGMC

#AC enriched first
while IFS= read -r line
do
  bin_name="$line"
  grep -q "$bin_name" AC_enriched_bins.txt && enrichment="AC" || enrichment="FAILURE"
  if [[ "$enrichment" == "AC" ]]
  then
    printf "${bin_name}\tlabel_background\t#6db6ff\n" >> ITOL_prep.tsv
    printf "${bin_name}\trange\t#6db6ff\tAC enriched bin\n" >> ITOL_prep.tsv
    printf "${bin_name}\t#6db6ff\tAC enriched bin\n" >> ITOL_prep_datastrip.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt

#AR enriched
while IFS= read -r line
do
  bin_name="$line"
  grep -q "$bin_name" AR_enriched_bins.txt && enrichment="AR" || enrichment="FAILURE"
  if [[ "$enrichment" == "AR" ]]
  then
    printf "${bin_name}\tlabel_background\t#db6d00\n" >> ITOL_prep.tsv
    printf "${bin_name}\trange\t#db6d00\tAR enriched bin\n" >> ITOL_prep.tsv
    printf "${bin_name}\tlabel\t#ffffff\n" >> ITOL_prep.tsv
    printf "${bin_name}\t#db6d00\tAR enriched bin\n" >> ITOL_prep_datastrip.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt

#Lastly the none
while IFS= read -r line
do
  bin_name="$line"
  grep -q "$bin_name" ITOL_prep.tsv && enrichment="Present" || enrichment="None"
  if [[ "$enrichment" == "None" ]]
  then
    printf "${bin_name}\tlabel_background\t#ffff6d\n" >> ITOL_prep.tsv
    printf "${bin_name}\trange\t#ffff6d\tNot enriched\n" >> ITOL_prep.tsv
    printf "${bin_name}\t#ffff6d\tNot enriched\n" >> ITOL_prep_datastrip.tsv
  else
    printf "Failed with $bin_name\n"
  fi
done < list_strict_bins.txt


#2023-06-13
p__Spirochaetes

target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  awk -F "\t" '{print $2}' "$f" | grep '|p__' | awk -F "|p__" '{print $2}' | awk -F "|c__" '{print $1}' | tr -d "|" | sort -V | uniq
done | sort -V | uniq | wc -l

list_all_phyla_used_by_motus.txt

phyla_list="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs/list_all_phyla_used_by_motus.txt"

AC18N-AC-PROCESSED.mOTUs_output.tsv

while IFS= read -r line
do
  input_file="AC18N-AC-PROCESSED.mOTUs_output.tsv"
  phylum=$(echo "$line")
  summed_rel_abund=$(grep "$phylum" "$input_file" | awk -F "\t" '{print $4}' | paste -sd+ | bc -l)
  printf "${phylum}\t${summed_rel_abund}\n"
done < "$phyla_list"


outdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  nome=$(basename "$f")
  sampleid=$(echo "$nome" | awk -F "-" '{print $1}')
  host=$(echo "$nome" | awk -F "-" '{print $2}')
  status=$(echo "$nome" | awk -F "-" '{print $3}' | awk -F ".m" '{print $1}')
  printf "Summed relative abundance\t${sampleid}_${status}\n" > "${outdir}/${sampleid}_${status}.phylum.summed"
  summed_file="${outdir}/${sampleid}_${status}.phylum.summed"
  while IFS= read -r line
  do
    input_file="$f"
    phylum=$(echo "$line")
    summed_rel_abund=$(grep -w "$phylum" "$input_file" | awk -F "\t" '{print $4}' | paste -sd+ | bc -l)
    printf "${phylum}\t${summed_rel_abund}\n" >> "$summed_file"
  done < "$phyla_list"
  printf "Host\t${host}\n" >> "$summed_file"
  printf "Status\t${status}\n" >> "$summed_file"
  echo "Processed file $f"
done

printf "Phyla\n" | cat "$phyla_list"

outdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  nome=$(basename "$f")
  sampleid=$(echo "$nome" | awk -F "-" '{print $1}')
  host=$(echo "$nome" | awk -F "-" '{print $2}')
  status=$(echo "$nome" | awk -F "-" '{print $3}' | awk -F ".m" '{print $1}')
  printf "Summed relative abundance\t${sampleid}_${status}\n" > "${outdir}/${sampleid}_${status}.phylum.summed.tsv"
  summed_file="${outdir}/${sampleid}_${status}.phylum.summed.tsv"
  while IFS= read -r line
  do
    input_file="$f"
    phylum=$(echo "p__$line")
    neat_phylum=$(echo "$line")
    summed_rel_abund=$(grep "$phylum" "$input_file" | awk -F "\t" '{print $4}' | paste -sd+ | bc -l)
    summed_rel_abund=${summed_rel_abund:="0"}
    printf "${neat_phylum}\t${summed_rel_abund}\n" >> "$summed_file"
  done < "$phyla_list"
  printf "Host\t${host}\n" >> "$summed_file"
  printf "Status\t${status}\n" >> "$summed_file"
  echo "Processed file $f"
done

printf "Phyla\n" | cat "$phyla_list" > list_o_phyla.txt
printf "Host\n" >> list_o_phyla.txt
printf "Status\n" >> list_o_phyla.txt
for f in *.phylum.summed.tsv
do
  awk -F "\t" '{print $2}' "$f" > "temporat_${f%}.temporat"
done
paste -d "," list_o_phyla.txt temporat_*.temporat > 2023-06-14_summed_by_phyla_relative_abundances_mOTUs_pilot_samples.csv
rm temporat_*.temporat
rm list_o_phyla.txt

occurence_bad=${occurence_bad:="0"}

outdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  cp "$f" /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs/all_original_output
done

inpf="AC19N-AC-RAW.mOTUs_output.tsv"
while IFS= read -r line
do
  phylum=$(echo "$line")
  summed_rel_abund=$(awk -F "\t" -v phyla="$phylum" '(index($2, phyla) !=0) {print $4}' "$inpf" | paste -sd+ | bc -l)
  summed_rel_abund=${summed_rel_abund:="0"}
  printf "$phylum\t$summed_rel_abund\n"
done < "$phyla_list"

outdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  nome=$(basename "$f")
  sampleid=$(echo "$nome" | awk -F "-" '{print $1}')
  host=$(echo "$nome" | awk -F "-" '{print $2}')
  status=$(echo "$nome" | awk -F "-" '{print $3}' | awk -F ".m" '{print $1}')
  printf "refMOTUs\t${sampleid}_${status}\n" > "${outdir}/${sampleid}_${status}.relative_abundances_all_detected_refMOTUs.tsv"
  summed_file="${outdir}/${sampleid}_${status}.relative_abundances_all_detected_refMOTUs.tsv"
  while IFS= read -r line
  do
    input_file="$f"
    phylum=$(echo "$line")
    summed_rel_abund=$(awk -F "\t" -v phyla="$phylum" '$1 == phyla {print $4}' "$input_file")
    summed_rel_abund=${summed_rel_abund:="0"}
    printf "${phylum}\t${summed_rel_abund}\n" >> "$summed_file"
  done < processed_motusRefs_list.txt
  printf "Host\t${host}\n" >> "$summed_file"
  printf "Status\t${status}\n" >> "$summed_file"
  echo "Processed file $f"
done

inpf="AC16N-AC-PROCESSED.mOTUs_output.Read_counts.tsv"
while IFS= read -r line
do
  phylum=$(echo "$line")
  summed_read_counts=$(awk -F "\t" -v phyla="$phylum" '(index($2, phyla) !=0) {print $4}' "$inpf" | paste -sd+ | bc -l)
  summed_read_counts=${summed_read_counts:="0"}
  printf "$phylum\t$summed_read_counts\n"
done < "$phyla_list"

Firmicutes	.9602745013 - relative abundance
Firmicutes 625 - reads classified

total reads = 4,450,000
Read count as percentage of all reads - 0.014044943820225

phyla_list="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs/list_all_phyla_used_by_motus.txt"
outdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.Read_counts.tsv")
for f in $target_files
do
  nome=$(basename "$f")
  sampleid=$(echo "$nome" | awk -F "-" '{print $1}')
  host=$(echo "$nome" | awk -F "-" '{print $2}')
  status=$(echo "$nome" | awk -F "-" '{print $3}' | awk -F ".m" '{print $1}')
  printf "Summed reads classified into phylum\t${sampleid}_${status}\n" > "${outdir}/${sampleid}_${status}.phylum.summed_read_counts.tsv"
  summed_file="${outdir}/${sampleid}_${status}.phylum.summed_read_counts.tsv"
  while IFS= read -r line
  do
    input_file="$f"
    phylum=$(echo "$line")
    summed_read_counts=$(awk -F "\t" -v phyla="$phylum" '(index($2, phyla) !=0) {print $4}' "$input_file" | paste -sd+ | bc -l)
    summed_read_counts=${summed_read_counts:="0"}
    printf "${phylum}\t${summed_read_counts}\n" >> "$summed_file"
  done < "$phyla_list"
  printf "Host\t${host}\n" >> "$summed_file"
  printf "Status\t${status}\n" >> "$summed_file"
  echo "Processed file $f"
done

outdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  nome=$(basename "$f")
  sampleid=$(echo "$nome" | awk -F "-" '{print $1}')
  host=$(echo "$nome" | awk -F "-" '{print $2}')
  status=$(echo "$nome" | awk -F "-" '{print $3}' | awk -F ".m" '{print $1}')
  summed_relative_abundances_everything=$(awk -F "\t" '$4 != 0 {print $4}' "$f" | grep -v -e "A" -e "O" | awk 'NF' | paste -sd+ | bc -l)
  printf "${sampleid}\t${status}\t${summed_relative_abundances_everything}\n"
done


/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/db_mOTU/db_mOTU_taxonomy_ref-mOTUs.tsv | awk -F "\t" '{print $9}' | cut -d " " -f 2-

refs_file_1="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/db_mOTU/db_mOTU_taxonomy_ref-mOTUs.tsv"
refs_file_2="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/motus_database/db_mOTU/db_mOTU_taxonomy_meta-mOTUs.tsv"
cat "$refs_file_1" | cat "$refs_file_2" > list_motus_taxa.tsv

while IFS= read -r line
do
  reference=$(echo "$line")
  taxon=$(grep "$reference" list_motus_taxa.tsv | awk -F "\t" '{print $8}' | cut -d " " -f 2-)
  printf "$reference\t$taxon\n"
done < processed_motusRefs_list.txt

tempry_list.txt
for f in *.relative_abundances_all_detected_refMOTUs.tsv
do
  awk -F "\t" '{print $2}' "$f" > "${f%}.tempry.txt"
done
paste -d "," tempry_list.txt *.tempry.txt > 2023-06-13_relative_abundances_pilot_samples_non_zero_mOTUs.csv
rm *.tempry.txt

all_samples="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads"
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  awk -F "\t" '$4 != 0 {print $1}' "$f" | grep -v "#" | sort -h
done | sort -V | uniq > 2023-06-14_all_refs_non_zero_at_least_one_sample.txt

list_file="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads/2023-06-14_all_refs_non_zero_at_least_one_sample.txt"
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  nome=$(basename "$f")
  sampleid=$(echo "$nome" | awk -F "." '{print $1}')
  host=$(echo "$sampleid" | tr -d "0123456789" | tr -d "JN")
  season=$(echo "$sampleid" | tr -d "0123456789" | tr -d "ARC")
  host_and_season=$(echo "$sampleid" | tr -d "0123456789")
  printf "Reference\t${sampleid}\n" > "${all_samples}/${sampleid}.nonzero_motu_refs.tsv"
  while IFS= read -r line
  do
    thing=$(echo "$line")
    rel_abun=$(awk -F "\t" -v phyla="$thing" '$1 == phyla {print $4;exit;}' "$f")
    rel_abun=${rel_abun:="0"}
    printf "${thing}\t${rel_abun}\n" >> "${all_samples}/${sampleid}.nonzero_motu_refs.tsv"
  done < "$list_file"
  printf "Host\t${host}\n" >> "${all_samples}/${sampleid}.nonzero_motu_refs.tsv"
  printf "Season\t${season}\n" >> "${all_samples}/${sampleid}.nonzero_motu_refs.tsv"
  printf "Host_and_season\t${host_and_season}\n" >> "${all_samples}/${sampleid}.nonzero_motu_refs.tsv"
  printf "Processed file:\t$f\n"
done

tempry_list.txt
for f in *.relative_abundances_all_detected_refMOTUs.tsv
do
  awk -F "\t" '{print $2}' "$f" > "${f%}.tempry.txt"
done
paste -d "," tempry_list.txt *.tempry.txt > 2023-06-13_relative_abundances_pilot_samples_non_zero_mOTUs.csv
rm *.tempry.txt

phyla_list="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/classifier_outputs_raw_input_files/mOTUs/list_all_phyla_used_by_motus.txt"
outdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  nome=$(basename "$f")
  sampleid=$(echo "$nome" | awk -F "." '{print $1}' | tr -d "_")
  host=$(echo "$sampleid" | tr -d "0123456789" | tr -d "JN")
  season=$(echo "$sampleid" | tr -d "0123456789" | tr -d "ARC")
  host_and_season=$(echo "$sampleid" | tr -d "0123456789")
  printf "refMOTUs\t${sampleid}\n" > "${outdir}/${sampleid}.relative_abundances_phylum_summed.tsv"
  summed_file="${outdir}/${sampleid}.relative_abundances_phylum_summed.tsv"
  while IFS= read -r line
  do
    input_file="$f"
    phylum=$(echo "p__$line")
    neat_phylum=$(echo "$line")
    summed_rel_abund=$(grep "$phylum" "$input_file" | awk -F "\t" '{print $4}' | paste -sd+ | bc -l)
    summed_rel_abund=${summed_rel_abund:="0"}
    printf "${neat_phylum}\t${summed_rel_abund}\n" >> "$summed_file"
  done < "$phyla_list"
  printf "Host\t${host}\n" >> "$summed_file"
  printf "Season\t${season}\n" >> "$summed_file"
  printf "Host and season\t${host_and_season}\n" >> "$summed_file"
  echo "Processed file $f"
done

for f in *relative_abundances_phylum_summed.tsv
do
  awk -F "\t" '{print $2}' "$f" > "${f%}.temporrog"
done
paste -d "," phylum_and_variable_list.txt *.temporrog > "2023-06-14_summed_phylum_level_relative_abundances.csv"
rm *.temporrog


target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  awk -F "\t" '{print $2}' "$f" | grep '|g__' | awk -F "|g__" '{print $2}' | awk -F "|s__" '{print $1}' | tr -d "|" | sort -V | uniq
done | sort -V | uniq > "2023-06-14_list_unique_genera.txt"

genus_list="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads/2023-06-14_list_unique_genera.txt"
outdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  nome=$(basename "$f")
  sampleid=$(echo "$nome" | awk -F "." '{print $1}' | tr -d "_")
  host=$(echo "$sampleid" | tr -d "0123456789" | tr -d "JN")
  season=$(echo "$sampleid" | tr -d "0123456789" | tr -d "ARC")
  host_and_season=$(echo "$sampleid" | tr -d "0123456789")
  printf "refMOTUs\t${sampleid}\n" > "${outdir}/${sampleid}.relative_abundances_genus_summed.tsv"
  summed_file="${outdir}/${sampleid}.relative_abundances_genus_summed.tsv"
  while IFS= read -r line
  do
    input_file="$f"
    phylum=$(echo "g__$line")
    neat_phylum=$(echo "$line")
    summed_rel_abund=$(grep "$phylum" "$input_file" | awk -F "\t" '{print $4}' | paste -sd+ | bc -l)
    summed_rel_abund=${summed_rel_abund:="0"}
    printf "${neat_phylum}\t${summed_rel_abund}\n" >> "$summed_file"
  done < "$genus_list"
  printf "Host\t${host}\n" >> "$summed_file"
  printf "Season\t${season}\n" >> "$summed_file"
  printf "Host and season\t${host_and_season}\n" >> "$summed_file"
  echo "Processed file $f"
done

#pilot files
genus_list="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/mOTUs_on_cleansed_acomys_reads/2023-06-14_list_unique_genera.txt"
outdir=$(pwd)
target_files=$(find -maxdepth 2 -type f -name "*.mOTUs_output.tsv")
for f in $target_files
do
  nome=$(basename "$f")
  sampleid=$(echo "$nome" | awk -F "-" '{print $1}')
  host=$(echo "$nome" | awk -F "-" '{print $2}')
  status=$(echo "$nome" | awk -F "-" '{print $3}' | awk -F ".m" '{print $1}')
  printf "Summed reads classified into genus\t${sampleid}_${status}\n" > "${outdir}/${sampleid}_${status}.genus.summed_read_counts.tsv"
  summed_file="${outdir}/${sampleid}_${status}.genus.summed_read_counts.tsv"
  while IFS= read -r line
  do
    input_file="$f"
    phylum=$(echo "$line")
    summed_read_counts=$(awk -F "\t" -v phyla="$phylum" '(index($2, phyla) !=0) {print $4}' "$input_file" | paste -sd+ | bc -l)
    summed_read_counts=${summed_read_counts:="0"}
    printf "${phylum}\t${summed_read_counts}\n" >> "$summed_file"
  done < "$genus_list"
  printf "Host\t${host}\n" >> "$summed_file"
  printf "Status\t${status}\n" >> "$summed_file"
  echo "Processed file $f"
done

printf "Sample ID\n" > temping.txt
cat "$genus_list" >> temping.txt
printf "Host\nSeason\nHost and season\n" >> temping.txt

for f in *.relative_abundances_genus_summed.tsv
do
  awk -F "\t" '{print $2}' "$f" > "${f%}.tempry.txt"
done
paste -d "," temping.txt *.tempry.txt > "2023-06-14_relative_abundances_all_processed_Acomys_summed_genus_relative_abundance_mOTUs.csv"
rm *.tempry.txt
