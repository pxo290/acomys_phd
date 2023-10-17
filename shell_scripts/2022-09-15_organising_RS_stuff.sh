#!/bin/bash -eE
#SBATCH -t 00-03:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2022-09-15_organising_RS_stuff
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/slurm_outputs/2022-09-15_organising_RS_stuff-%A.out
#SBATCH -e /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/slurm_outputs/2022-09-15_organising_RS_stuff-%A.err

#Written on 2022-09-15
#Written by Peter Osborne

#Quick and simple script to organise the RS stuff now it has been moved into the
#specific directory on the HPC. Basically, moving all the read files to the raw
#data directory and zipping them up if they aren't zipped.

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variable
inpdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting"
export outdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/raw"

#Going to input directory
cd "$inpdir"

#First, moving the already zipped files
targets=$(find -maxdepth 1 -type f -name "*.fastq.gz")
for f in $targets
do
  printf "Will move file:\t$f\tto:\t$outdir\n"
  mv "$f" "$outdir"
  printf "Moved file:\t$f\tto:\t$outdir\n"
done

#Now zipping the unzipped ones and then moving them
targets=$(find -maxdepth 1 -type f -name "*.fastq")
for f in $targets
do
  printf "Will gzip file:\t$f\n"
  gzip "$f"
  printf "Will move gzipped file:\t${f}.gz\n"
  mv "${f}.gz" "$outdir"
  printf "Moved gzipped file:\t${f}.gz\n"
done
