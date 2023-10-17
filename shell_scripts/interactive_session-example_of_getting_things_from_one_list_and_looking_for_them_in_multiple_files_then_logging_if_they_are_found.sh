#!/bin/bash -e

touch all_species_all_samples.txt
for f in *.species
do
  cat $f | sed 's/[][]//g' >> all_species_all_samples.txt
done
touch all_unique_species_all_samples.txt
cat all_species_all_samples.txt | sort -n | uniq >> all_unique_species_all_samples.txt
rm all_species_all_samples.txt
touch pres-abs_matrix.txt
printf "BactSpeciesID 97%% classification\n" > pres-abs_matrix.txt
cat all_unique_species_all_samples.txt >> pres-abs_matrix.txt
for f in *.species
do
  sample_id=$(echo $f | awk -F "-" '{print $2}')
  distinguisher=$(echo $RANDOM)
  cp $f $distinguisher-HOLDING_copy.txt
  sed -i -e 's/[][]//g' $distinguisher-HOLDING_copy.txt
  touch $sample_id-presence_absence_log.txt
  printf "$sample_id" >> $sample_id-presence_absence_log.txt
  while IFS= read -r line; do
    grep -q "$line" $distinguisher-HOLDING_copy.txt && export presence="1" || export presence="0" </dev/null
    printf "\n$presence" >> $sample_id-holding.txt < /dev/null
  done < all_unique_species_all_samples.txt
  cat $sample_id-holding.txt >> $sample_id-presence_absence_log.txt
  rm $sample_id-holding.txt
  rm $distinguisher-HOLDING_copy.txt
  sleep 1s
done
sleep 30s
paste -d "\t" pres-abs_matrix.txt *-presence_absence_log.txt > presence_absence_matrix.txt
