#!/bin/bash -eE
#SBATCH -t 07-23:30
#SBATCH -p ei-long
#SBATCH -c 2
#SBATCH -J 2022-09-07_tidying_and_exporting
#SBATCH --mem=64gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /hpc-home/osbourne/2022-09-07_tidying_and_exporting-%A.out
#SBATCH -e /hpc-home/osbourne/2022-09-07_tidying_and_exporting-%A.err

#Written on 2022-09-07
#Written by Peter Osborne

#Dirty and crude script to first get the total usage of everything currently in
#the Chapter 1 scratch and then start moving stuff to the right chapter directories
#to be sorted out later on.

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
inpdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch"
top_inpdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237"
#chap2_dir="/ei/projects/c/c57d1fc8-8c7f-47d2-bd32-4e5250784e29/scratch"
chap3_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24"
chap4_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4"
your_dir="/hpc-home/osbourne"

#Sourcing rsync version 3.1.2
source package 0701d226-7b2e-48c3-b6de-80f1ef1830ce

#Doing the usage stuff
cd "$top_inpdir"
du -h | sort -k1 -h > "${your_dir}/2022_09_07_chapter_1_directory_total_usage_before_moving_things.txt"

#Moving the directory containing all the stuff from scripts run for Chapter 3 work
#to the 3rd chapter directory
cd "$inpdir"
cd 2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping
mv DFAST_isolate_output "$chap3_dir"
mv culture_isolates "$chap3_dir"

#Going back up so you can move the 2nd directory stuff
cd "$inpdir"

#Moving the directory containing all the stuff from scripts run for Chapter 2 work
#to the 2nd chapter directory
#mv 2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping "$chap2_dir" && printf "Moved 2nd chapter stuff directory to $chap2_dir\n"

#Moving the directory containing all the stuff from scripts run for Chapter 4 work
#to the 4th chapter directory
mv 2022-04-05_Extra_or_side_stuff "$chap4_dir"
