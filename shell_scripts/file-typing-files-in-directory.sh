#!/bin/bash -e
#SBATCH -t 0-00:02
#SBATCH -c 1
#SBATCH --mem=16

#This can be edited a lot to basically go into all the directories within a larger directory, run the file command on all files within them fitting a pattern and then print this so it will be in the slurm output. Though it will be anyway without the storing in a varable and then printing it
cd $1
for d in $PWD/*FAECAL-SAMPLE*/
do
  cd $d
  for f in *DT0*
  do
    file $f
    status_of_file=$(file $f)
    echo $status_of_file
  done
done
