#!/bin/bash -e

locale=$(pwd)
touch $locale/kraken_all_unique_species.txt
subjects=$(find -maxdepth 3 -type f -name "*_Kraken2-confidence_score_0.10_report.txt-S-and_unclassified_sorted.txt" -not -name "*read*") && for f in $subjects ; do printf "\n$f\n" ; done
for f in $subjects
do
  cat $f | awk -F " " '{print $1}' >> $locale/fleeting.txt
done
cat $locale/fleeting.txt |sort -V | uniq >> $locale/kraken_all_unique_species.txt
rm $locale/fleeting.txt

for f in $subjects
do
  sample_name=$(basename $f | awk -F "-" '{print $2}' | awk -F "_" '{print $1}')
  touch $locale/${sample_name}_kraken_species_count.txt
  printf "\t$sample_name\n" > $locale/${sample_name}_kraken_species_count.txt
  while IFS= read -r line ; do
  nomber=$(grep "$line" $f | awk -F " " '{print $2}')
  grep -q "$line" $f && printf "$line\t$nomber\n" >> $locale/${sample_name}_kraken_species_count.txt || printf "$line\t0\n" >> $locale/${sample_name}_kraken_species_count.txt
  done < $locale/kraken_all_unique_species.txt
done
touch $locale/fleeting1.txt
printf "Bacterial species\n" > $locale/fleeting1.txt
cat $locale/kraken_all_unique_species.txt >> $locale/fleeting1.txt
targets=$(find -maxdepth 1 -type f -name "*_kraken_species_count.txt")
for f in $targets
do
  cut -f2 $f >> ${f%}_kraken_temporary.txt
done
paste $locale/fleeting1.txt *_kraken_temporary.txt >> kraken_all_unique_species_all_samples_species_counts.txt
rm *_kraken_temporary.txt
rm *_kraken_species_count.txt
rm $locale/kraken_all_unique_species.txt
rm $locale/fleeting1.txt
