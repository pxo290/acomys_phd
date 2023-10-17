#!/bin/bash -eE
#SBATCH -t 2-20:30
#SBATCH -p ei-largemem
#SBATCH -c 1
#SBATCH -J Classifier_comp_run
#SBATCH --mem=725gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#2021-07-14
#This script will run through the 4 metagenomic taxonomy classification tools,
#though since it uses 2 different databases for both Centrifuge and Metaphlan it
#will actually do more runs then this. Prior to submitting the files it will put
#them through FastP and BBDUk, which will do QC and remove host and human mapping
#reads respectively

#Sourcing all the required tools
source package /tgac/software/testing/bin/fastp-20190305 #FastP version 0.19.7
source package /tgac/software/testing/bin/bbmap-38.06 #BBMap version 38.06
#BBMap contains BBDuk
source package /tgac/software/testing/bin/kraken2-2.0.7 #Kraken2 version 2.0.7-beta
source package /tgac/software/testing/bin/centrifuge-1.0.3_dm #Centrifuge2 version 1.0.3-beta
source package /tgac/software/testing/bin/metaphlan2-2.96.1 #MetaPhlAn version 2.96.1
source package /tgac/software/testing/bin/kaiju-1.7.3 #Kaiju version 1.7.3

#The workflow here will be:
# 1) Make a copy of the input file to work on
# 2) Making a directory to contain the output and working files
# 3) Run FastP on the copied files to get the QC'ed versions
# 4) Run BBDuk on the QC'ed files with the relevant host and human genomes to
#    get the cleansed versions
# 5) Since it takes the longest and the most memory, run Centrifuge on the files
# 6) Run Kraken2 on the files
# 7) Run Metaphlan on the files
# 8) Run Kaiju on the files

#Setting fixed variables
export INPDIR=$(pwd)
export OUTDIR_HUB="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Classifier_runs_for_paper"
export ORG_INPF1=$1
#Quick immediate sanity check
basename "$ORG_INPF1" | grep -q "E3_R1.fq" && export SAN_CHECK1="Y" || export SAN_CHECK1="N"
if [ "$SAN_CHECK1" = "Y" ]
then
  printf "\nAll is well\n"
elif [ "$SAN_CHECK1" = "N" ]
then
  printf "\nProblem, first read file doesn't have the expected name pattern\n"
  exit 1
else
  printf "\nSome other error occured, so the script will stop to be safe anyway\n"
  exit 1
fi
#End of immediate sanity check
export ORG_INPF2=$(basename "$ORG_INPF1" | sed 's/-E3_R1/-E3_R2/g')
export ORG_INPF_NAME_CATCH=$(basename "$f" | awk -F "-" '{print $1"-"$2"-"$3}')
export SAMPLEID=$(basename "$ORG_INPF1" | awk -F "-" '{print $1}')
export UID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
export HUMAN_REFERENCE="/hpc-home/osbourne/REFERENCE_GENOMES/GRCh38_latest_genomic.fa"

#Setting the host genome variable based on input file
basename "$ORG_INPF1" | grep -q "Acah" && export HOST="/hpc-home/osbourne/REFERENCE_GENOMES/mAcoCah1.curated_primary.20181127" || export HOST="/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa" && printf "\nThe host reference which will be used is:\t$HOST\n"

#Copying over the input files
cp "$ORG_INPF1" "$OUTDIR_HUB"
cp "$ORG_INPF2" "$OUTDIR_HUB"

#Moving to the directory and making a directory to put the working and output
#files into. Then going into it and making the directories for each classifer
cd "$OUTDIR_HUB"
mkdir "${UID}_$ORG_INPF_NAME_CATCH"
SUBJECT_FILES=$(find -maxdepth 1 -type f -name "$ORG_INPF_NAME_CATCH" -name "*.fq")
for f in $SUBJECT_FILES
do
  mv "$f" "${UID}_$ORG_INPF_NAME_CATCH"
  printf "\Moved file:\t$f\tto directory:\t$${UID}_$ORG_INPF_NAME_CATCH\n"
done
cd "${UID}_$ORG_INPF_NAME_CATCH"
mkdir "${UID}_FastP"
mkdir "${UID}_BBDuk"
mkdir "${UID}_Centrifuge"
mkdir "${UID}_Kraken"
mkdir "${UID}_Metaphlan"
mkdir "${UID}_Kaiju"

#Defining the functions which will run
run_FastP() {
  inpf1=$1
  inpf2=$2
  outdir=$3
  sampleid=$4
  uid=$5
  printf "\nRunning FASTP for QC on input files:\t$inpf1 and $inpf2\n"
  fastp -i "$inpf1" -I "$inpf2" -o "${uid}_${sampleid}_FastP_QC_R1.fastq" -O "${uid}_${sampleid}_FastP_QC_R2.fastq" -h "${uid}_${sampleid}_FastP.html" -j "${uid}_${sampleid}_FastP.json"
  targets=$(find -maxdepth 1 -type f -name "${uid}_${sampleid}_FastP*")
  for f in $targets ; do mv "$f" "$outdir" ; done
}

run_BBDuk() {
  inpf1=$1
  inpf2=$2
  outdir=$3
  sampleid=$4
  uid=$5
  human_reference=$6
  host_reference=$7
  outdir="${UID}_BBDuk"
  printf "\nRunning BBDuk to remove host and human contaminated reads from the fastq files\n"
  srun bbduk.sh -Xmx120g -Xms55g -prealloc in="$inpf1" in2="$inpf2" ref="$host_reference","$human_reference" outm="${uid}_${sampleid}_BBDuk_host_or_human_contaminants.fastq" out="${uid}_${sampleid}_BBDuk_Cleansed_FastP_QC_R1.fastq" out2="${uid}_${sampleid}_BBDuk_Cleansed_FastP_QC_R2.fastq" overwrite=t stats="${uid}_${sampleid}_BBDuk_host_and_human_contaminant_stats.txt"
  targets=$(find -maxdepth 1 -type f -name "${uid}_${sampleid}_BBDuk*")
  for f in $targets ; do mv "$f" "$outdir" ; done
}

run_Centrifuge() {

}
