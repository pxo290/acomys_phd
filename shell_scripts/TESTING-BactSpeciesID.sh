#!/bin/bash -e
#SBATCH -t 00-12:00
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J BactSpecID
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
#Sourcing dependent software
source package 5ee17ce0-f5c5-424b-b161-62aef5dc4b22 #Abricate 0.9.8
source package 68248f11-d17e-4c01-a95d-47af6d05b765 #Barrnap 0.9
source package 6394519c-541f-479c-b064-dd0b912eac04 #Bedtools 2.29.2
source package 758be80b-33cc-495a-9adc-11882ab145b1 #Samtools 1.10

#Storing useful things in variables
export INPF=$1
export UIE=$2
export DatBas=SILVA-16S
vanish=$(basename $1)
export label=${vanish:0:10}

#Making a function to run the script
run_bactspeciesID () {
  inpf=$1
  uie=$2
  DBB=$3
  lbl=$4
  printf "\n Will run BactSpeciesID with the default values given in the help on input file $inpf \n"
  srun /ei/scratch/osbourne/blast_DB/bactspeciesID.sh -i 99 -c 50 -d $DBB $inpf #> ${lbl}_BactSpeciesID_output.fna.species
  mail -s "Progress Monitoring 85763000" $uie <<< "Ran Raymond's script BactSpeciesID on the input file $inpf and put the output into the file ${lbl}_BactSpeciesID_output.fna.species"
  printf "\n Ran BactSpeciesID on input file $inpf using the default values for parameters provided \n"
}

run_bactspeciesID $INPF $UIE $DatBas $label
###NOTES###
