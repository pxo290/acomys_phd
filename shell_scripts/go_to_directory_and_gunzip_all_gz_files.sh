#!/bin/bash -e
#SBATCH -t 00-24:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J MovingIn
#SBATCH --mem=24gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

move_and_unpack () {
  destination=$1
  cd $destination
  boxed_stuff=$(find -maxdepth 1 -type f -name "*.gz")
  for f in $boxed_stuff
  do
    printf "\n I'll unpack the following item: $f \n By which I mean gunzip it \n"
    gunzip $f
    printf "\n I unpacked the following item : $f \n So it should have been gunzipped' \n"
  done
}

move_and_unpack $1
