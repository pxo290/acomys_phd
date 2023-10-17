#!/bin/bash -eE
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J Prokka_Cultures
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing Prodigal
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka version 1.14.6

#Making mutable variables
export UIE=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 18)
export lobel=$(date | awk -F " " '{print $6"_"$3"_"$2}')
export LABEL=$(printf "${UIE}_${lobel}-")
export LOCALE=$(pwd)

#Defining Prokka function
run_prokka () {
  inpf=$1
  lobel=$2
  label=$(basename "$inpf" | awk -F ".fa" '{print $1}' | sed "s/^/${lobel}-Prokka-/g")
  printf "\nWill run Prokka on input file:\t$inpf\n"
  mkdir "${label}_output"
  prokka --outdir "${label}_output" --force --prefix "$label" --addgenes --kingdom Bacteria --cpus 2 "$inpf"
  printf "\nRan file: $inpf through Prokka. Output files should be in ${label}_output\n"
}

#Collecting up the files to be used
targets=$(find -maxdepth 1 -type f -name "*.fa")

#Making the loop to get it going
for f in $targets
do
  INPF=$(basename "$f")
  run_prokka "$INPF" "$LABEL"
  sleep 1m
done
