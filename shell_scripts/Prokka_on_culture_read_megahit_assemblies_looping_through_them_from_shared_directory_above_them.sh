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
