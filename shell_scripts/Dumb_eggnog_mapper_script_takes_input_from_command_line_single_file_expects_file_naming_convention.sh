#!/bin/bash -eE
#SBATCH -t 07-24:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J OverEasy
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
source package /tgac/software/testing/bin/diamond-0.9.24

#Trying to source python in case that is an binned_fastas_Kaiju_Species
source package 4493852d-9831-4b90-a949-b7ea7039ce16

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
  printf "\nWill run file:\t$INPF1\nThrough EggnogMapper\n"
  python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 2 -i "$INPF1" --output "${LABEL}_eggnog_mapper_output" -m diamond -d none --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data/eggnog_proteins.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override || printf "\nHad an issue running the eggnog mapping command\n"
  cd "$LOCALE"
done
