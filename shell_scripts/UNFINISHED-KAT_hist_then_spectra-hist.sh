#!/bin/bash -e
#SBATCH -t 00-03:30
#SBATCH -p ei-medium
#SBATCH -c 16
#SBATCH -J TestKAT
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package /tgac/software/testing/bin/kat-2.3.4

export DESTINY='/hpc-home/osbourne/KAT-plot_comparing_reads'
export LOCALE=$(pwd)

target_directories=$(find -maxdepth 1 -type d -name "*-AR*")
for d in $target_directories
do
  cd $d
  cd Subsampled_output
  LOBEL=$(pwd | awk -F "/" '{print $10}' | awk -F "-" '{print $2}')
  LABEL="${LOBEL}_KAT_output"
  locale=$(pwd)
  mkdir -p ${LABEL}_KAT_plot_results
  cd ${LABEL}_KAT_plot_results
  destination=$(pwd)
  cd $locale
  INPF1=$(ls -d -1 $PWD/** | grep "_R1.fastq")
  INPF2=$(printf "$INPF1" | sed 's/_R1/_R2/g')
  kat hist $INPF1 $INPF2 -o ${LABEL}-histogram.hist && mv ${LABEL}-histogram.hist $destination
  sleep 30s
  #cd $destination
  #kat plot spectra-hist -o ${LABEL}_spectra_plot.svg
  cp -r $destination $DESTINY
  cd $LOCALE
done

torget_directories=$(find -maxdepth 1 -type d -name "*-AR*")
for d in $torget_directories
do
  cd $d
  cd Subsampled_output
  LOBEL=$(pwd | awk -F "/" '{print $10}' | awk -F "-" '{print $2}')
  LABEL="${LOBEL}_KAT_output"
  locale=$(pwd)
  mkdir -p ${LABEL}_KAT_plot_results
  cd ${LABEL}_KAT_plot_results
  destination=$(pwd)
  cd $locale
  INPF1=$(ls -d -1 $PWD/** | grep "_R1.fastq")
  INPF2=$(printf "$INPF1" | sed 's/_R1/_R2/g')
  kat hist $INPF1 $INPF2 -o ${LABEL}-histogram.hist && mv ${LABEL}-histogram.hist $destination
  sleep 30s
  #cd $destination
  #kat plot spectra-hist -o ${LABEL}_spectra_plot.svg
  cp -r $destination $DESTINY
  cd $LOCALE
done
