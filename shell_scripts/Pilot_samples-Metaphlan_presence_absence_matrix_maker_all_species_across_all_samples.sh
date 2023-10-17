#!/bin/bash -e

locale=$(pwd)
touch $locale/metaphlan_all_unique_species.txt
subjects=$(find -maxdepth 4 -type f -name "*Metaphlan2-output.txt-s-only_sorted.txt")
for f in $subjects
do
  cat $f | awk -F " " '{print $1}' >> $locale/temp.txt
done
cat $locale/temp.txt |sort -V | uniq >> $locale/metaphlan_all_unique_species.txt
rm $locale/temp.txt

for f in $subjects
do
  sample_name=$(basename $f | awk -F "_" '{print $1}')
  touch $locale/${sample_name}_species_yes-no.txt
  printf "\t$sample_name\n" > $locale/${sample_name}_species_yes-no.txt
  while IFS= read -r line ; do
  grep -q "$line" $f && printf "$line\t1\n" >> $locale/${sample_name}_species_yes-no.txt || printf "$line\t0\n" >> $locale/${sample_name}_species_yes-no.txt
  done < $locale/metaphlan_all_unique_species.txt
done
touch $locale/temp4.txt
printf "Bacterial species\n" > $locale/temp4.txt
cat $locale/metaphlan_all_unique_species.txt >> $locale/temp4.txt
targets=$(find -maxdepth 1 -type f -name "*_species_yes-no.txt")
for f in $targets
do
  cut -f2 $f >> ${f%}_temporary.txt
done
paste $locale/temp4.txt *_temporary.txt >> metaphlan_all_unique_species_all_samples_presence_absence.txt
rm *_temporary.txt
rm *yes*
rm $locale/metaphlan_all_unique_species.txt
rm $locale/temp4.txt
#subjects=$(find -maxdepth 4 -type f -name "*Metaphlan2-output.txt-s-only_sorted.txt") && for f in $subjects ; do while IFS= read -r line ; do basename $f | awk -F "_" '{print $1}' && printf "\n$line\t" && grep -c "$line" $f ; done < temp2.txt ; done
