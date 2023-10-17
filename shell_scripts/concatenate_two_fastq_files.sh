#!/bin/bash -e
#SBATCH -t 00-10:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J CatemAll
#SBATCH --mem=12gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export inpf1=$1
export inpf2=$2
inpdir='/ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/INPUTS/'
outdir='/ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/INPUTS/concatenated_two_lane_samples'
label=$3

locale=$(pwd)
concated_log='/ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/Scripts/concatenated_read_files.txt'

cd $inpdir
printf "\nWill concatenate the two fastq files: $inpf1\t$inpf2 which should be the two R1s or R2s for the two sequencing runs of the same sample\n"
printf "\nThe input files can be found in the directory: $inpdir\n"

concat_em_all () {
  IN1=$1
  IN2=$2
  IND=$3
  LBL=$4
  OUD=$5
  printf "\nInput file 1 is $IN1\n"
  printf "\nInput file 2 is $IN2\n"
  printf "\nInput directory is $IND\n"
  printf "\nLabel for output file is $LBL\n"
  printf "\nOutput directory is $OUD\n"
  cd $IND
  touch ${LBL}.fq
  cat $IN1 >> ${LBL}.fq
  sleep 30s && printf "\n I am waiting for 30 seconds after the first cat'ing of input file 1 into a newly made .fq file.\n"
  cat $IN2 >> ${LBL}.fq
  sleep 30s && printf "\n I am waiting for 30 seconds after cat appending input file 2 into the recently made .fq file.\n"
  mv ${LBL}.fq $OUD
}

concat_em_all $inpf1 $inpf2 $inpdir $label $outdir
printf "\nConcatenation of files $inpf1\t$inpf2\thas been completed\n" >> $concated_log


#sbatch concatenate_two_fastq_files.sh /ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/INPUTS/AC14N_FDSW202491273-1r_HHGCHDSXY_L3_1.fq /ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/INPUTS/AC14N_FDSW202491273-1r_HCHTTDSXY_L4_1.fq AC14N_R1
#sbatch concatenate_two_fastq_files.sh /ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/INPUTS/AC14N_FDSW202491273-1r_HHGCHDSXY_L3_2.fq /ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/INPUTS/AC14N_FDSW202491273-1r_HCHTTDSXY_L4_2.fq AC14N_R2
