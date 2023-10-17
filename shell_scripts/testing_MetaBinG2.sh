#!/bin/bash -e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -p ei-gpu
#SBATCH -J MetaBinG2
#SBATCH --mem=40G
#SBATCH -t 1-00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --gres=gpu:titan:1

printf "\nStarting script\n"
export read_file=$1
export user_input_mail=$2
export HomeD=$(pwd)

printf "\n For the log the read file is: $read_file_1"
printf "\n For the log the user-provided email is: $user_input_mail"


printf "\n Sourcing MetaBinG2 \n"
source /ei/software/staging/CISSUPPORT-11321/stagingloader

printf "\n Running MetaBinG2 on file $read_file"
mail  -s "Progress Monitoring 85763000" "$user_input_mail" <<< "Starting MetaBinG2 run on $read_file "
runMetaBinG2 -i $read_file -o ${read_file}.out -d /ei/scratch/osbourne/MetaBinG2/db_micro_euk
stats.all.pl ${read_file}.out.stats ${read_file}_visualisation -p

printf "\n Ran MetaBinG2 on file $read_file"
