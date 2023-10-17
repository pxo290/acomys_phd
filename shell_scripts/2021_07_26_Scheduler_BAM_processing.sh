#!/bin/bash -eE
#SBATCH -t 00-01:50
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J Scheduler_BAM_processing
#SBATCH --mem=4gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#2021-07-26
#Just submits each of the mapped bam files mapping the name filter in the find
#command to scripts which filter, sort, index and then get the stats for them.

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

target=$(find -maxdepth 1 -type f -name "*_Mapped.bam")
for f in $target
do
  subject=$(basename "$f")
  job_name=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ; echo '' | sed 's/$/-BAM_processing/g')
  label=$(basename "$f" | awk -F ".ba" '{print $1}')
  sbatch --job-name="$job_name" 2021-07-26_Process_mapped_BAM_files.sh "$subject" "$label"
  printf "\nSubmitted file:\t$subject\n"
  sleep 3s
done
