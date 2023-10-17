#!/bin/bash -e
#SBATCH -t 00-00:44
#SBATCH -p ei-short
#SBATCH -c 1
#SBATCH -J Merge
#SBATCH --mem=28gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

printf "\n Starting script \n"
printf "\n ------------------------------ \n"

printf "\n Sourcing FLASH \n"
source package /nbi/software/production/bin/flash-1.2.7

printf "\n Putting input into descriptive variables \n"
read_file_1=$1
read_file_2=$2
nomdeguerre=$3
provided_email=$4

printf "\n Making short name variables from descriptive ones \n"
export RF1=$read_file_1
export RF2=$read_file_2
export NDG=$nomdeguerre
export PRE=$provided_email

printf "\n Defining function for running FLASH"
flash_merge () {
  printf "\n The first read file is: $1 \n"
  printf "\n The second read file is: $2 \n"
  printf "\n The name -provided by the user- which will be used for the merged read file, and everything made from it is: $NDG \n"
  printf "\n The email provided by the user for correspondence is: $3 \n"
  printf "\n Now merging read files $1 and $2 to make file called $4.fastq \n"
  flash --min-overlap=5 --max-overlap=300 --threads=1 --interleaved-output $1 $2
  printf "\n Renaming merged output to match user desired name \n" && mv out.extendedFrags.fastq ${4}_merged.fastq
  printf "\n Renaming unmerged output to match user desired name \n" && mv out.notCombined.fastq ${4}_Unmerged_interleaved.fastq
  printf "\n Removing all the other files produced which start with 'out' and match wildcard \n" && rm out*
  mail -s "Progress Monitoring 85763000" "$3" <<< "Read files $RF1 and $RF2 have been merged."
}

flash_merge $RF1 $RF2 $PRE $NDG

printf "\n End of script \n"
printf "\n------------------------------\n"
