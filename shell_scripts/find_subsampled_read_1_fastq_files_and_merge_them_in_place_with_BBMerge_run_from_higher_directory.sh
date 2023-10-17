#!/bin/bash -e
#SBATCH -t 00-01:15
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J MergeChk
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#03/12/20
#This script goes through the subdirectories of the directory it is in and will
#do a few things. It also sets a function up top which it uses in a for loop.
#All this assumes the files in the right format from when you made them.
#Specifically they are the subsampled fastq files
# 1. It will get the directory where the file is and store it in a variable
# 2. It gets the name of the file without all the directories ahead of it
# 3. It gets the name of the other read file from the first one
# 4. It gets the label from the filename
# 5. It edits the script it will call in a for loop, putting the label obtained
#    from the filename in the sbatch header for the job name
# 6. It runs the function defined earlier, which just calls the BBMerge script
#    on the two files it has picked up and associated together from the initial
#    find command
# 7. After submitting the batch job it changes the jobname sbatch header in the
#    BBMege execution script back to the placeholder text so the next iteration
#    of the loop can put in the right label

set_to_run () {
  destiny=$1
  inpf1=$2
  inpf2=$3
  label=$4
  scripty=$5
  sbatch $scripty $destiny $inpf1 $inpf2 $label
}

export subject_script='execute_bbmerge.sh'
target=$(find -maxdepth 3 -type f -name "*_Subsampled_R1.fastq")
for f in $target
do
  situate=$(readlink -f $f)
  whereist=$(echo $situate | awk -F "/" '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}' | sed 's@ @/@g')
  read1=$(echo $f | awk -F "/" '{print $4}')
  read2=$(echo $read1 | sed 's/R1/R2/g')
  lobel=$(echo $read1 | awk -F "_" '{print $1}' | awk -F "-" '{print $2}')
  printf "\n$read1\n$read2\n$whereist\n$lobel\n"
  sed -i -e "s/@PLACEHOLDER@/$lobel/g" $subject_script && sleep 10s
  set_to_run $whereist $read1 $read2 $lobel $subject_script && sleep 25s && printf "\nI have submitted a BBMege script which will merge the files:\t$read1\t$read2\nWhich are found in directory:\t$whereist\n"
  sed -i -e "s/$lobel/@PLACEHOLDER@/g" $subject_script && sleep 10s
  sleep 10s
done
