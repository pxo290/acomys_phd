#!/bin/bash -e
#SBATCH -t 00-04:35
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J CopPrep
#SBATCH --mem=132gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export inf1=$1
echo $inf1
export inpf1=$(readlink -f $inf1)
echo $inpf1
export inpf2=$(echo $inpf1 | sed 's/1.fq/2.fq/g')
echo $inpf2
export SPECIES_CHECK=$(echo $inpf1 | awk -F "/" '{print $10}' | awk -F "_" '{print $1}' | cut -c 1,2)
echo $SPECIES_CHECK
export label=$(echo $inpf1 | awk -F "/" '{print $10}' | awk -F "_" '{print $1}' | cut -c 1,2,3,4,5 | sed 's/_//g')
echo $label
export locale=$(pwd)
export destiny="/ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/INPUTS/for_Seb"
export HUMAN_GENOME="/hpc-home/osbourne/REFERENCE_GENOMES/GRCh38_latest_genomic.fa"
if [ "$SPECIES_CHECK" = "AC" ]
then
  export HOST_SPECIES="/hpc-home/osbourne/REFERENCE_GENOMES/mAcoCah1.curated_primary.20181127.fa"
  printf "\n Host species check indicates the host species is $HOST_SPECIES and the relevant host genome file should have been chosen \n"
elif [ "$SPECIES_CHECK" = "AR" ]
then
  export HOST_SPECIES="/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa"
  printf "\n Host species check indicates the host species is $HOST_SPECIES and the relevant host genome file should have been chosen \n"
else
  printf "\n You need to enter either AC or AR depending on which the host species is \n"
fi

#Sourcing
source package /tgac/software/testing/bin/fastp-20190305
source package /tgac/software/testing/bin/bbmap-38.06

#Executing assuming files are in this directory and are not originals
fastp -i $inpf1 -I $inpf2 -o ${label}-R1.fastq -O ${label}-R2.fastq -h ${label}_FastP.html -j ${label}_FastP.json

QCED1=$(find -maxdepth 1 -type f -name "*$label*" -name "*-R1.fastq") && echo $QCED1
QCED2=$(find -maxdepth 1 -type f -name "*$label*" -name "*-R2.fastq") && echo $QCED2
qced1=$(readlink -f $QCED1) && echo $qced1
qced2=$(readlink -f $QCED2) && echo $qced2

srun bbduk.sh -Xmx128g -Xms64g -prealloc in=$qced1 in2=$qced2 ref=$HOST_SPECIES,$HUMAN_GENOME outm=${label}-host_or_human_matching.fastq out=${label}-cleansed_1.fastq out2=${label}-cleansed_2.fastq overwrite=t stats=${label}_host_comparison_stats.txt

rm $qced1
rm $qced2
rm ${label}_host_comparison_stats.txt
rm ${label}_host_or_human_matching.fastq

mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Deletion of files $inpf1 and $inpf2 will occur in 15 minutes if this job is not cancelled. They should no longer be necessary."
sleep 15m && rm $inpf1 && rm $inpf2
