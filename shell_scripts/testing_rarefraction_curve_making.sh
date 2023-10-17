#!/bin/bash -e
#SBATCH -t 04-12:30
#SBATCH -p ei-largemem
#SBATCH -c 10
#SBATCH -J RareKrak
#SBATCH --mem=830gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export DESTINATION=$1
cd $DESTINATION
rm *all_seeds_classified_percentage.dat && rm *all_seeds_species_count.dat || printf "\nThere were no pre-existing .dat files to delete\n"
#gunzip *.gz && sleep 5m || sleep 1m && printf "\n No zipped file was present\n"
export INPF1=$2
export LOCALE=$(pwd)
export INPF2=$(echo $2 | sed 's/_1.fastq/_2.fastq/g')
export LBEL=$3
export shield=$(printf "SHIELD")

source package /tgac/software/testing/bin/kraken2-2.0.8.r7127273
source package /tgac/software/testing/bin/seqtk-20150226  #Seqtk

touch $LBEL-all_seeds_species_count.dat
touch $LBEL-all_seeds_classified_percentage.dat

printf "\nDefining the universal Kraken function up here\n"
run_krak2 () {
  set +e
  inpf1=$1
  inpf2=$2
  label=$3
  species_note_file=$LBEL-all_seeds_species_count.dat
  classified_note_file=$LBEL-all_seeds_classified_percentage.dat
  read_no=$4
  seed=$5
  database="/ei/public/databases/kraken/2.0.7_refseq-201910/"
  seqtk sample -s $seed $inpf1 $read_no > $seed_$read_no-$inpf1
  seqtk sample -s $seed $inpf2 $read_no > $seed_$read_no-$inpf2
  work1=$seed_$read_no-$inpf1
  work2=$seed_$read_no-$inpf2
  kraken2 --paired --db $database --threads 10 --use-names --confidence 0.10 $work1 $work2 --report $label-Kraken2-confidence_score_010_report.txt
  species_count=$(cat $label-Kraken2-confidence_score_010_report.txt | awk -F " " '{print $4}' | grep -wc "S") && printf "\nThe number of species detected is:\t$species_count\n"
  printf "\n$read_no $species_count" >> $species_note_file
  unclassified_count=$(grep "unclassified" $label-Kraken2-confidence_score_010_report.txt | head -1 | awk -F " " '{print $1}') && printf "\nThe unclassified percentage is:\t$unclassified_count\n"
  declare -i tempallpercent=100 && printf "\nNumber after the colon should be one hundred:\t$tempallpercent\n"
  classified_count=$(echo "$tempallpercent - $unclassified_count" | bc) && printf "\nThe percentage of species classified is:\t$classified_count\n"
  printf "\n$read_no $classified_count" >> $classified_note_file
  rm $label-Kraken2-confidence_score_010_report.txt
  rm $read_no-$inpf1
  rm $read_no-$inpf2
  disposal=$(find -maxdepth 1 -type f -name "$label" -name "*.fastq")
  for f in $disposal ; do printf "\nWill remove file:\t$f\n" && rm $f ; done
  printf "\nThere should be no files made by Kraken in this run left; it should only have made the report file anyway\n"
  set -e
  sleep 60s
}
export seed1=$(echo $RANDOM)
export seed2=$(echo $RANDOM)
export seed3=$(echo $RANDOM)

run_krak2 $INPF1 $INPF2 $LBEL 100 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 100 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 100 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 1000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 1000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 1000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 10000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 10000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 10000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 100000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 100000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 100000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 250000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 250000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 250000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 500000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 500000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 500000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 750000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 750000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 750000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 1000000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 1000000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 1000000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 2500000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 2500000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 2500000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 5000000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 5000000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 5000000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 7500000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 7500000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 7500000 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 9000000 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 9000000 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 9000000 $seed3

export org_read_no=$(grep -c "@" $INPF1)
export orrn=$(echo $org_read_no)
kraken2 --paired --db /ei/public/databases/kraken/2.0.7_refseq-201910/ --threads 10 --use-names --confidence 0.10 $INPF1 $INPF2 --report Original-Kraken2-confidence_score_010_report.txt
export spec_count=$(cat Original-Kraken2-confidence_score_010_report.txt | awk -F " " '{print $4}' | grep -wc "S")
export uncl_percent=$(grep "unclassified" Original-Kraken2-confidence_score_010_report.txt | head -1 | awk -F " " '{print $1}')
declare -i holdallpercent=100
export cl_percent=$(echo "$holdallpercent - $uncl_percent" | bc)
printf "\n$orrn $spec_count" >> $LBEL-all_seeds_species_count.dat
printf "\n$orrn $cl_percent" >> $LBEL-all_seeds_classified_percentage.dat
set +e
rm *.txt
mv $INPF1 $INPF1.$SHIELD
mv $INPF2 $INPF2.$SHIELD
waste=$(find -maxdepth 1 -type f -name "*.fastq" -not -name "$shield")
for f in $waste ; do printf "\nFile is:\t$f and will be removed\n" && rm $f ; done
mv $INPF1.$SHIELD $INPF1
mv $INPF2.$SHIELD $INPF2
