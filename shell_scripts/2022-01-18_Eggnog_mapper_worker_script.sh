#!/bin/bash -e
#SBATCH -t 05-12:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Script written by Peter Osborne
#Written on 2022-01-17
#Written for use with the Earlham Institute Slurm architecture

#This is a worker script which takes a number of input variables from a command
#script, including input fasta files, then runs EggnogMapper version 2.1.6 on
#them

#Error catching
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
