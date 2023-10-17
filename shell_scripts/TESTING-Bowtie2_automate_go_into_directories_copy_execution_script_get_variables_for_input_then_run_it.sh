#!/bin/bash -e
#SBATCH -t 00-08:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J TiedBow
#SBATCH --mem=8gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This script exists to copy the Bowtie2 align fastq PE files to combined
#bacterial genomes reference script into all directories matching a pattern
#and then run the bowtie2 execution script on the apppropriate file in that
#directory and get the label which is needed as the user input.

#For sake of simplicity it is worth using a function here and then having it go
#over two 'for' loops, directories with '-AC' and those with '-AR'

#Setting hard variables
export BOWTIE2_SCRIPT='/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/results/OUTPUTS/Subsampling_for_analysis/UNFINISHED-TESTING_Bowtie2_alignment_against_combined_bacterial_multi_genome_fasta.sh'
export RESIDENCE=$(pwd)

#Defining function
copy_and_run () {
  #bowtie2_script=$1
  #location=$2
  label=$1
  #cp $bowtie2_script $location
  local_script=$(find -maxdepth 1 -type f -name "*Bowtie2_alignment_against_combined_bacterial_multi_genome_fasta.sh")
  sbatch $local_script $label
  printf "\nExecuted $local_script\n"
}

#Making the 'for' loops
target_directories=$(find -maxdepth 1 -type d -name "*-AR*")
for d in $target_directories
do
  cd $d
  cd Subsampled_output
  locale=$(pwd)
  SCRIPTCHECK=$(find -maxdepth 1 -type f -name "*Bowtie2_alignment_against_combined_bacterial_multi_genome_fasta.sh")
  if [[ -z "$SCRIPTCHECK" ]]
  then
    cp $BOWTIE2_SCRIPT $locale
  else
    printf "\nThere was a version of the script already here\n"
  fi
  LABEL=$(pwd | awk -F "/" '{print $10}' | awk -F "-" '{print $2}')
  if [[ ! -z "$LABEL" ]]
  then
    printf "\nWill execute the Bowtie2 script with the label $LABEL\n"
    copy_and_run $LABEL
  else
    printf "\nThe label could not be generated for some reason\n"
  fi
  cd $RESIDENCE
done

torget_directories=$(find -maxdepth 1 -type d -name "*-AC*")
for d in $torget_directories
do
  cd $d
  cd Subsampled_output
  locale=$(pwd)
  cp $BOWTIE2_SCRIPT $locale
  LABEL=$(pwd | awk -F "/" '{print $10}' | awk -F "-" '{print $2}')
  if [[ ! -z "$LABEL" ]]
  then
    printf "\nWill execute the Bowtie2 script with the label $LABEL\n"
    copy_and_run $LABEL
  else
    printf "\nThe label could not be generated for some reason\n"
  fi
  cd $RESIDENCE
done

#target=$(pwd | awk -F "/" '{print $10}' | awk -F "-" '{print $2}') && printf "\n$target\n" && if [[ ! -z "target" ]]; then printf "\nThe variable is not empty\n" || printf "\nVariable is empty\n" ; fi
