#!/bin/bash -e
#SBATCH -t 04-12:30
#SBATCH -p ei-largemem
#SBATCH -c 10
#SBATCH -J RareKrak
#SBATCH --mem=830gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script will subsample the cleansed and QC'ed fastq files to a number of
#different depths and then run Kraken2 on them. After this it will count the
#number of species detected at each sequencing depth and so get the numbers to
#make the rarefraction curves for the sample

#Setting variables
export locale=$(pwd)
export INPF1=$1
export INPDIR=$2
export CARGOHOLD="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/"
export ENDDIR="/ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/OUTPUTS"
export IDENT=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')

#Sourcing software
source package /tgac/software/testing/bin/kraken2-2.0.8.r7127273  #Kraken2
source package /tgac/software/testing/bin/gnuplot-4.6.3 #GNUPlot
source package /tgac/software/testing/bin/seqtk-20150226  #Seqtk

#Making working directory, copying and unzipping the cleansed read files to it
cd $INPDIR
export inpf1=$(readlink -f $INPF1)
export inpf2=$(echo $inpf1 | sed 's/cleansed_1.fastq.gz/cleansed_2.fastq.gz/g')
export sample_id=$(echo $inpf1 | awk -F "/" '{print $10}' | awk -F "-" '{print $2}')
cd $CARGOHOLD
mkdir -p ${IDENT}-$sample_id
cd ${IDENT}-$sample_id
export WORKDIR=$(pwd)
cd $ENDDIR
mkdir -p ${sample_id}-rarefraction_kraken_numbers
cd ${sample_id}-rarefraction_kraken_numbers
export ULTIMATE_DESTINATION=$(pwd)
cd $WORKDIR
scp $inpf1 $WORKDIR
scp $inpf2 $WORKDIR
gunzip *.gz
export baseline1=$(find -maxdepth 1 -type f -name "*cleansed_1.fastq")
export baseline2=$(find -maxdepth 1 -type f -name "*cleansed_2.fastq")

#Making combined function
rarefy_it () {
  thing1=$1
  thing2=S
  marker=$3
  seed=$(echo $RANDOM)
  location=$(pwd)
  database="/ei/public/databases/kraken/2.0.7_refseq-201910/"
  confscore="0.10"
  CS="$confscore"
  log_file=$marker-read_depth_species_count.dat
  seqtk sample -s${seed} $thing1 100 > $marker-100_R1.fastq
  seqtk sample -s${seed} $thing2 100 > $marker-100_R2.fastq
  shrthnd1=$marker-100_R1.fastq
  shrthnd2=$marker-100_R2.fastq
  kraken2 --paired --db $database --threads 10 --use-names --confidence $confscore --unclassified-out $marker-Kraken2-Unclassified_confidence_score_${CS}_#.txt --classified-out $marker-Kraken2-Classified_confidence_score_${CS}_#.txt $shrthnd1 $shrthnd2 --report $marker-Kraken2-confidence_score_${CS}_report.txt
  rm $marker-100_R1.fastq
  rm $marker-100_R1.fastq
  rm *__1.txt
  rm *__2.txt
  species_count=$(cat $marker-Kraken2-confidence_score_${CS}_report.txt | awk -F " " '{print $4}' | grep -wc "S")
  printf "\n100\t$species_count" >> $log_file
  seqtk sample -s${seed} $thing1 1000 > $marker-1000_R1.fastq
  seqtk sample -s${seed} $thing2 1000 > $marker-1000_R2.fastq
  shrthnd1=$marker-1000_R1.fastq
  shrthnd2=$marker-1000_R2.fastq
  kraken2 --paired --db $database --threads 10 --use-names --confidence $confscore --unclassified-out $marker-Kraken2-Unclassified_confidence_score_${CS}_#.txt --classified-out $marker-Kraken2-Classified_confidence_score_${CS}_#.txt $shrthnd1 $shrthnd2 --report $marker-Kraken2-confidence_score_${CS}_report.txt
  rm $marker-1000_R1.fastq
  rm $marker-1000_R1.fastq
  rm *__1.txt
  rm *__2.txt
  species_count=$(cat $marker-Kraken2-confidence_score_${CS}_report.txt | awk -F " " '{print $4}' | grep -wc "S")
  printf "\n1000\t$species_count" >> $log_file
  seqtk sample -s${seed} $thing1 10000 > $marker-10000_R1.fastq
  seqtk sample -s${seed} $thing2 10000 > $marker-10000_R2.fastq
  shrthnd1=$marker-10000_R1.fastq
  shrthnd2=$marker-10000_R2.fastq
  kraken2 --paired --db $database --threads 10 --use-names --confidence $confscore --unclassified-out $marker-Kraken2-Unclassified_confidence_score_${CS}_#.txt --classified-out $marker-Kraken2-Classified_confidence_score_${CS}_#.txt $shrthnd1 $shrthnd2 --report $marker-Kraken2-confidence_score_${CS}_report.txt
  rm $marker-10000_R1.fastq
  rm $marker-10000_R1.fastq
  rm *__1.txt
  rm *__2.txt
  species_count=$(cat $marker-Kraken2-confidence_score_${CS}_report.txt | awk -F " " '{print $4}' | grep -wc "S")
  printf "\n10000\t$species_count" >> $log_file
  seqtk sample -s${seed} $thing1 100000 > $marker-100000_R1.fastq
  seqtk sample -s${seed} $thing2 100000 > $marker-100000_R2.fastq
  shrthnd1=$marker-100000_R1.fastq
  shrthnd2=$marker-100000_R2.fastq
  kraken2 --paired --db $database --threads 10 --use-names --confidence $confscore --unclassified-out $marker-Kraken2-Unclassified_confidence_score_${CS}_#.txt --classified-out $marker-Kraken2-Classified_confidence_score_${CS}_#.txt $shrthnd1 $shrthnd2 --report $marker-Kraken2-confidence_score_${CS}_report.txt
  rm $marker-100000_R1.fastq
  rm $marker-100000_R1.fastq
  rm *__1.txt
  rm *__2.txt
  species_count=$(cat $marker-Kraken2-confidence_score_${CS}_report.txt | awk -F " " '{print $4}' | grep -wc "S")
  printf "\n100000\t$species_count" >> $log_file
  seqtk sample -s${seed} $thing1 1000000 > $marker-1000000_R1.fastq
  seqtk sample -s${seed} $thing2 1000000 > $marker-1000000_R2.fastq
  shrthnd1=$marker-1000000_R1.fastq
  shrthnd2=$marker-1000000_R2.fastq
  kraken2 --paired --db $database --threads 10 --use-names --confidence $confscore --unclassified-out $marker-Kraken2-Unclassified_confidence_score_${CS}_#.txt --classified-out $marker-Kraken2-Classified_confidence_score_${CS}_#.txt $shrthnd1 $shrthnd2 --report $marker-Kraken2-confidence_score_${CS}_report.txt
  rm $marker-1000000_R1.fastq
  rm $marker-1000000_R1.fastq
  rm *__1.txt
  rm *__2.txt
  species_count=$(cat $marker-Kraken2-confidence_score_${CS}_report.txt | awk -F " " '{print $4}' | grep -wc "S")
  printf "\n1000000\t$species_count" >> $log_file
  seqtk sample -s${seed} $thing1 2500000 > $marker-2500000_R1.fastq
  seqtk sample -s${seed} $thing2 2500000 > $marker-2500000_R2.fastq
  shrthnd1=$marker-2500000_R1.fastq
  shrthnd2=$marker-2500000_R2.fastq
  kraken2 --paired --db $database --threads 10 --use-names --confidence $confscore --unclassified-out $marker-Kraken2-Unclassified_confidence_score_${CS}_#.txt --classified-out $marker-Kraken2-Classified_confidence_score_${CS}_#.txt $shrthnd1 $shrthnd2 --report $marker-Kraken2-confidence_score_${CS}_report.txt
  rm $marker-2500000_R1.fastq
  rm $marker-2500000_R1.fastq
  rm *__1.txt
  rm *__2.txt
  species_count=$(cat $marker-Kraken2-confidence_score_${CS}_report.txt | awk -F " " '{print $4}' | grep -wc "S")
  printf "\n2500000\t$species_count" >> $log_file
  seqtk sample -s${seed} $thing1 5000000 > $marker-5000000_R1.fastq
  seqtk sample -s${seed} $thing2 5000000 > $marker-5000000_R2.fastq
  shrthnd1=$marker-5000000_R1.fastq
  shrthnd2=$marker-5000000_R2.fastq
  kraken2 --paired --db $database --threads 10 --use-names --confidence $confscore --unclassified-out $marker-Kraken2-Unclassified_confidence_score_${CS}_#.txt --classified-out $marker-Kraken2-Classified_confidence_score_${CS}_#.txt $shrthnd1 $shrthnd2 --report $marker-Kraken2-confidence_score_${CS}_report.txt
  rm $marker-5000000_R1.fastq
  rm $marker-5000000_R1.fastq
  rm *__1.txt
  rm *__2.txt
  species_count=$(cat $marker-Kraken2-confidence_score_${CS}_report.txt | awk -F " " '{print $4}' | grep -wc "S")
  printf "\n5000000\t$species_count" >> $log_file
  seqtk sample -s${seed} $thing1 7500000 > $marker-7500000_R1.fastq
  seqtk sample -s${seed} $thing2 7500000 > $marker-7500000_R2.fastq
  shrthnd1=$marker-7500000_R1.fastq
  shrthnd2=$marker-7500000_R2.fastq
  kraken2 --paired --db $database --threads 10 --use-names --confidence $confscore --unclassified-out $marker-Kraken2-Unclassified_confidence_score_${CS}_#.txt --classified-out $marker-Kraken2-Classified_confidence_score_${CS}_#.txt $shrthnd1 $shrthnd2 --report $marker-Kraken2-confidence_score_${CS}_report.txt
  rm $marker-7500000_R1.fastq
  rm $marker-7500000_R1.fastq
  rm *__1.txt
  rm *__2.txt
  species_count=$(cat $marker-Kraken2-confidence_score_${CS}_report.txt | awk -F " " '{print $4}' | grep -wc "S")
  printf "\n7500000\t$species_count" >> $log_file
  seqtk sample -s${seed} $thing1 9500000 > $marker-9500000_R1.fastq
  seqtk sample -s${seed} $thing2 9500000 > $marker-9500000_R2.fastq
  shrthnd1=$marker-9500000_R1.fastq
  shrthnd2=$marker-9500000_R2.fastq
  kraken2 --paired --db $database --threads 10 --use-names --confidence $confscore --unclassified-out $marker-Kraken2-Unclassified_confidence_score_${CS}_#.txt --classified-out $marker-Kraken2-Classified_confidence_score_${CS}_#.txt $shrthnd1 $shrthnd2 --report $marker-Kraken2-confidence_score_${CS}_report.txt
  rm $marker-9500000_R1.fastq
  rm $marker-9500000_R1.fastq
  rm *__1.txt
  rm *__2.txt
  species_count=$(cat $marker-Kraken2-confidence_score_${CS}_report.txt | awk -F " " '{print $4}' | grep -wc "S")
  printf "\n9500000\t$species_count" >> $log_file
}

#Prior steps before running function
export quick_label="$IDENT-$sample_id"
touch $quick_label-read_depth_species_count.dat

#Running the function
rarefy_it $baseline1 $baseline2 $quick_label

#Tidying up
rm *.txt
mv $quick_label-read_depth_species_count.dat $ULTIMATE_DESTINATION
cd $CARGHOLD
rm -r $WORKDIR
