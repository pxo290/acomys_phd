#!/bin/bash -eE
#SBATCH -t 00-23:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J Te_BUSCO
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

source package /tgac/software/testing/bin/busco-5.0.0

export ERROR_TEXT_BREAK=$(cat /hpc-home/osbourne/error_message_text_break_computer_report_ascii.txt)

run_busco () {
  inpf1=$1
  nome=$2
  #working_dir=$3
  #cd "$working_dir"
  locale=$(pwd)
  printf "\nWill run input file:\t$inpf1\tThrough BUSCO\n"
  busco -i "$inpf1" --auto-lineage-prok -o "${nome}_BUSCO_output.txt" --out_path "BUSCO_output_${nome}" -m geno -c 2 --force --offline --download_path /ei/public/databases/BUSCO/20200225/v4/data && printf "\nRan input file:\t$inpf1\tThrough BUSCO\n" || printf "\n$ERROR_TEXT_BREAK\nSomething went wrong and file:\t$inpf1\tWas not processed through BUSCO\n"
}

export HOMEBASE=$(pwd)

target=$(find -maxdepth 2 -type f -name "*R1_001_megahit_assembly.fa")
for f in $target
  do NOME=$(basename "$f" | awk -F "_" '{print $1"_"$2}')
  #lowest_name=$(basename "$f")
  #LOCATION=$(realpath "$f" | sed "s/$lowest_name//g" | sed 's/.$//')
  export INPF1="$f"
  printf "\nFile:\t$f\tWill be processed\n"
  run_busco "$INPF1" "$NOME" || printf "\nFile:\t$f\tFailed for some reason. Moving on\n"
  #cd "$HOMEBASE" || printf "\nWas already in:\t$HOMEBASE\n"
done
