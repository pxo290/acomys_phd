#!/bin/bash -e
#SBATCH -t 04-12:30
#SBATCH -p ei-largemem
#SBATCH -c 10
#SBATCH -J RarerKrak
#SBATCH --mem=830gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Setting variables and doing prep work
export DESTINATION=$1
cd $DESTINATION
rm *all_seeds_classified_percentage.dat || printf "\nThere were no pre-existing .dat files to delete\n"
rm *all_seeds_species_count.dat || printf "\nThere were no pre-existing .dat files to delete\n"
gunzip *.gz && sleep 5m || sleep 1m && printf "\n No zipped file was present\n"
export INPF1=$2
export LOCALE=$(pwd)
export INPF2=$(echo $2 | sed 's/_1.fastq/_2.fastq/g')
export LBEL=$3
export shield=$(printf "SHIELD")
export org_read_no=$(grep -c "@" $INPF1)
export orrn=$(echo $org_read_no)

#New feature to hopefully keep a better record of what is happening, where and when
captains_log () {
  wobist=$(pwd)
  tick=$(date)
  export short_term_appelation=$(echo $RANDOM)
  touch $short_term_appelation-WORKING_LOG.txt
  printf "\nI am a:\tRarefaction and Kraken2 job.\nI am running at:\t$tick\nI will work on the input files:\t$INPF1\t$INPF2\nI am running in the directory:\t$wobist\nI request the resources:\t04-12:30 on EI-LARGEMEM\t10 cores\t830GB\n" >> $short_term_appelation-WORKING_LOG.txt
  mail -s "JOB DETAIL NOTIFICATION - YOU FROM THE PAST" -a $short_term_appelation-WORKING_LOG.txt peter.osborne@earlham.ac.uk <<< "I am a:Rarefaction and Kraken2 job. I am running at: "$tick" I will work on the input files $inpf1 $inpf2 I am running in the directory: $wobist I request the resources: 04-12:30 on EI-LARGEMEM 10 cores 830GB"
}

captains_log && source package /tgac/software/testing/bin/kraken2-2.0.8.r7127273
source package /tgac/software/testing/bin/seqtk-20150226  #Seqtk

touch $LBEL-all_seeds_species_count.dat
touch $LBEL-all_seeds_classified_percentage.dat
touch $LBEL-all_seeds_genus_count.dat
touch $LBEL-all_seeds_family_count.dat
touch $LBEL-all_seeds_order_count.dat

printf "\nDefining the universal Kraken function up here\n"
run_krak2 () {
  set +e
  inpf1=$1 && printf "\ninpf1 is:\t$infp1"
  inpf2=$2 && printf "\ninpf2 is:\t$infp2"
  label=$3 && printf "\nlabel is:\t$label"
  species_note_file=$LBEL-all_seeds_species_count.dat
  classified_note_file=$LBEL-all_seeds_classified_percentage.dat
  divisor=$4 && printf "\ndivisor is:\t$divisor"
  read_no=$(echo "$orrn * $divisor" | bc | sed 's/\..*$//') && printf "\nread number is:\t$read_no"
  seed=$5 && printf "\nseed is:\t$seed"
  genus_note_file=$LBEL-all_seeds_genus_count.dat
  family_note_file=$LBEL-all_seeds_family_count.dat
  order_note_file=$LBEL-all_seeds_order_count.dat
  database="/ei/public/databases/kraken/2.0.7_refseq-201910/"
  seqtk sample -s $seed $inpf1 $read_no > $seed_$read_no-$inpf1
  seqtk sample -s $seed $inpf2 $read_no > $seed_$read_no-$inpf2
  work1=$seed_$read_no-$inpf1
  work2=$seed_$read_no-$inpf2
  kraken2 --paired --db $database --threads 10 --use-names --confidence 0.10 $work1 $work2 --report $label-Kraken2-confidence_score_010_report.txt
  species_count=$(cat $label-Kraken2-confidence_score_010_report.txt | awk -F " " '{print $4}' | grep -wc "S") && printf "\nThe number of species detected is:\t$species_count\n"
  genus_count=$(cat $label-Kraken2-confidence_score_010_report.txt | awk -F " " '{print $4}' | grep -wc "G") && printf "\nThe number of species detected is:\t$species_count\n"
  family_count=$(cat $label-Kraken2-confidence_score_010_report.txt | awk -F " " '{print $4}' | grep -wc "F") && printf "\nThe number of species detected is:\t$species_count\n"
  order_count=$(cat $label-Kraken2-confidence_score_010_report.txt | awk -F " " '{print $4}' | grep -wc "O") && printf "\nThe number of species detected is:\t$species_count\n"
  printf "\n$read_no $species_count" >> $species_note_file
  printf "\n$read_no $genus_count" >> $genus_note_file
  printf "\n$read_no $family_count" >> $family_note_file
  printf "\n$read_no $order_count" >> $order_note_file
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

#Running the rarefaction and kraken function
run_krak2 $INPF1 $INPF2 $LBEL 0.001 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 0.001 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 0.001 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 0.01 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 0.01 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 0.01 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 0.05 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 0.05 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 0.05 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 0.1 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 0.1 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 0.1 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 0.25 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 0.25 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 0.25 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 0.5 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 0.5 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 0.5 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 0.75 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 0.75 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 0.75 $seed3
run_krak2 $INPF1 $INPF2 $LBEL 0.90 $seed1
run_krak2 $INPF1 $INPF2 $LBEL 0.90 $seed2
run_krak2 $INPF1 $INPF2 $LBEL 0.90 $seed3

#Now working on the original read to get the results for the entire read count
kraken2 --paired --db /ei/public/databases/kraken/2.0.7_refseq-201910/ --threads 10 --use-names --confidence 0.10 $INPF1 $INPF2 --report Original-Kraken2-confidence_score_010_report.txt
export spec_count=$(cat Original-Kraken2-confidence_score_010_report.txt | awk -F " " '{print $4}' | grep -wc "S")
export uncl_percent=$(grep "unclassified" Original-Kraken2-confidence_score_010_report.txt | head -1 | awk -F " " '{print $1}')
declare -i holdallpercent=100
export cl_percent=$(echo "$holdallpercent - $uncl_percent" | bc)
printf "\n$orrn $spec_count" >> $LBEL-all_seeds_species_count.dat
printf "\n$orrn $cl_percent" >> $LBEL-all_seeds_classified_percentage.dat

#Tidying up
set +e
rm *.txt
mv $INPF1 $INPF1.$SHIELD
mv $INPF2 $INPF2.$SHIELD
waste=$(find -maxdepth 1 -type f -name "*.fastq" -not -name "$shield")
for f in $waste ; do printf "\nFile is:\t$f and will be removed\n" && rm $f ; done
mv $INPF1.$SHIELD $INPF1
mv $INPF2.$SHIELD $INPF2
sleep 30m && rm $short_term_appelation-WORKING_LOG.txt
