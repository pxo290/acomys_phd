#!/bin/bash -e
#SBATCH -t 02-24:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J GoldPipe
#SBATCH --mem=4gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Setting overall variables
export INPF1=$1 #Input file 1 if paired
export INPF2=$2 #Input file 2 if paired
export LABEL=$3 #Label which will be used in naming diretories and output files
export INPDIR="/ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/INPUTS"  #Path to directory which contains the input file
export DESTINATION="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/" #Path to scratch directory where you want work to take place
#Potentially might have to switch scratch to /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch
export ULTIMATE_DESTINATION="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/data/results/OUTPUTS/Subsampling_for_analysis" #Path to data directory where the final outputs are to be stored
#Check what the final data storage location will be and that it matches above
export SPECIES_CHECK=$4 #Either AC or AR so it can pick the host genome later on
export UIE="peter.osborne@earlham.ac.uk" #The email address to send things to
export SCRIPTS_DIR="/ei/projects/f/fe7caa26-baae-4863-8203-db2cf272f8fb/groupUsers/osborne/Scripts" #The directory in which all the bronze scripts are to be copied from for local running
export HUMAN_GENOME="/hpc-home/osbourne/REFERENCE_GENOMES/GRCh38_latest_genomic.fa" #Path to human reference genome
export COMMAND_LINE_MAIL="COMMAND_SUBMISSION_PO" #Use this as the subject for command line script submission emails

#Setting mutuable variables
export LINKINPF1=$(readlink -f $INPF1)  #Path to input file 1
export LINKINPF2=$(readlink -f $INPF2) #Path to input file 2
export RUN_CHECK=$(echo $RANDOM)  #A random number to distinguish between different runs of the same file through pipeline
printf "\n The run marker, which is added to outputs to link together the products of a specific run of the script is: $RUN_CHECK \n"

#Sourcing programmes so they can be used by the called Bronze scripts
#source package /tgac/software/testing/bin/fastp-20190305  #FastP
source package /tgac/software/testing/bin/bbmap-38.06 #BBMap (for use of BBDuk and BBTools)
#source package /tgac/software/testing/bin/metaphlan-2.0 #Metaphlan
#source package /tgac/software/testing/bin/kraken2-2.0.8.r7127273  #Kraken2
#source package /tgac/software/testing/bin/centrifuge-1.0.3_dm #Centrifuge
source package 78cb9518-255c-4d1c-9fb1-99a61123483c #Metaprob
source package /tgac/software/testing/bin/seqtk-20150226  #Seqtk

#Making directories and setting them as appropriate variables
cd $INPDIR
export DEPARTURES=$(pwd)
cd $DESTINATION
mkdir ${LABEL}_run_${RUN_CHECK}
cd ${LABEL}_run_${RUN_CHECK}/
export ARRIVALS=$(pwd)
scp $LINKINPF1 $ARRIVALS
scp $LINKINPF2 $ARRIVALS

#Copying the bronze scripts over for local execution
cd $SCRIPTS_DIR
export BRONZE_SCRIPTS=$((find -maxdepth 1 -type f -name "*BRONZE*" -name "*.sh") | sed 's#./##g')
for f in $BRONZE_SCRIPTS
do
  printf "\n Copying script file $f to $ARRIVALS and labelling the new version with the run marker $RUN_CHECK \n"
  scp $f $ARRIVALS/$RUN_CHECK-$f
done
cd $ARRIVALS

#Giving each of the Bronze scripts which need it a unique name so the jobID can be found later on for slurm dependencies
export BRONZE_QC_JOB_NAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
printf "\n The variable which should replace the placeholder in the script $RUN_CHECK-BRONZE-QC_script.sh is $BRONZE_QC_JOB_NAME \n"
sed -i -e "s/£PLACEHOLDER£/"$BRONZE_QC_JOB_NAME"/g" $RUN_CHECK-BRONZE-QC_script.sh

export BRONZE_CLEANSE_JOB_NAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
printf "\n The variable which should replace the placeholder in the script $RUN_CHECK-BRONZE-Cleansed_script.sh is $BRONZE_CLEANSE_JOB_NAME \n"
sed -i -e "s/£PLACEHOLDER£/"$BRONZE_CLEANSE_JOB_NAME"/g" $RUN_CHECK-BRONZE-Cleansed_script.sh

export BRONZE_SUBSAMPLE_JOB_NAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
printf "\n The variable which should replace the placeholder in the script $RUN_CHECK-BRONZE-Subsample_script.sh is $BRONZE_SUBSAMPLE_JOB_NAME \n"
sed -i -e "s/£PLACEHOLDER£/"$BRONZE_SUBSAMPLE_JOB_NAME"/g" $RUN_CHECK-BRONZE-Subsample_script.sh

export BRONZE_METAPROB_JOB_NAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
printf "\n The variable which should replace the placeholder in the script $RUN_CHECK-BRONZE-Metaprob_binning_script.sh is $BRONZE_METAPROB_JOB_NAME \n"
sed -i -e "s/£PLACEHOLDER£/"$BRONZE_METAPROB_JOB_NAME"/g" $RUN_CHECK-BRONZE-Metaprob_binning_script.sh

export BRONZE_TAXONOMY_JOB_NAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
printf "\n The variable which should replace the placeholder in the script $RUN_CHECK-BRONZE-Taxonomy_script.sh is $BRONZE_TAXONOMY_JOB_NAME \n"
sed -i -e "s/£PLACEHOLDER£/"$BRONZE_TAXONOMY_JOB_NAME"/g" $RUN_CHECK-BRONZE-Taxonomy_script.sh

export BRONZE_MEGAHIT_JOB_NAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
printf "\n The variable which should replace the placeholder in the script $RUN_CHECK-BRONZE-Megahit_assembly_script.sh is $BRONZE_MEGAHIT_JOB_NAME \n"
sed -i -e "s/£PLACEHOLDER£/"$BRONZE_MEGAHIT_JOB_NAME"/g" $RUN_CHECK-BRONZE-Megahit_assembly_script.sh

export BRONZE_TIDYING_JOB_NAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
printf "\n The variable which should replace the placeholder in the script $RUN_CHECK-BRONZE-TIDYING_script.sh is $BRONZE_TIDYING_JOB_NAME \n"
sed -i -e "s/£PLACEHOLDER£/"$BRONZE_TIDYING_JOB_NAME"/g" $RUN_CHECK-BRONZE-TIDYING_script.sh

#Setting the copied over raw files which will be used as the working files
export WORKF_INPF1=$(find -maxdepth 1 -type f -name "$INPF1")
export WORKF_INPF2=$(find -maxdepth 1 -type f -name "$INPF2")

#Making the label which combines the run number and the user input label so all the other scripts have access to it
export LBEL="$RUN_CHECK-$LABEL"

#Checking what the host genome is then altering the variable to match as appropriate
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
#Running the scripts in the correct order
printf "\n Will now run the QC script on the input files \n"
sbatch $RUN_CHECK-BRONZE-QC_script.sh $INPF1 $INPF2 $LBEL $UIE $ARRIVALS
export BRONZE_QC_JOB_ID=$(squeue -u osbourne | grep "$BRONZE_QC_JOB_NAME" | awk -F " " '{print $1}')

##A short wait after the script finishes and noting the time
sleep 5m && printf "\n Whilst I wait 30 seconds to check the QC script has been submitted, the time now is: " && date

##Setting the variables for the QC'ed files to use in the next step
export qced1=${LBEL}_Qced_1.fastq && printf "\n The QC'ed read file 1 is $qced1 \n"
export qced2=${LBEL}_Qced_2.fastq && printf "\n The QC'ed read file 2 is $qced2 \n"

export QCED1=$(readlink -f $qced1)
export QCED2=$(readlink -f $qced2)

##Making the variable to get the jobID of the bronze QC script so it can be used to chain the cleansing script
##so it only starts after the QC script has completed

sbatch --dependency=afterok:"$BRONZE_QC_JOB_ID" $RUN_CHECK-BRONZE-Cleansed_script.sh $QCED1 $QCED2 $HOST_SPECIES $HUMAN_GENOME $UIE $LBEL $ARRIVALS
export BRONZE_CLEANSE_JOB_ID=$(squeue -u osbourne | grep "$BRONZE_CLEANSE_JOB_NAME" | awk -F " " '{print $1}') && printf "\nThe bronze cleanse jobid is:\t$BRONZE_CLEANSE_JOB_ID\n"
export emergency_bronze_cleanse_job_id=$(squeue -u osbourne | grep "$BRONZE_CLEANSE_JOB_NAME" | awk -F " " '{print $1}')

##A short wait after the script finishes and noting the time
sleep 5m && printf "\n Whilst I wait 30 seconds to check the Cleansing script has been submitted, the time now is: " && date

##Setting the variables for the QC'ed and cleansed files to be used hereafter
export clean1=${LBEL}-cleansed_1.fastq && printf "\n The QC'ed and cleansed read file 1 is $clean1 \n"
export clean2=${LBEL}-cleansed_2.fastq && printf "\n The QC'ed and cleansed read file 2 is $clean2 \n"

export CLEAN1=$(readlink -f $clean1)
export CLEAN2=$(readlink -f $clean2)

cd $ARRIVALS

printf "\n Submitting Subsampling job which will be called $BRONZE_SUBSAMPLE_JOB_NAME \n"
sleep 5m && sbatch --dependency=afterok:"$BRONZE_CLEANSE_JOB_ID" $RUN_CHECK-BRONZE-Subsample_script.sh $CLEAN1 $CLEAN2 $ARRIVALS $LBEL || sbatch --dependency=afterany:"$emergency_bronze_cleanse_job_id" $RUN_CHECK-BRONZE-Subsample_script.sh $CLEAN1 $CLEAN2 $ARRIVALS $LBEL
export backup_BRONZE_SUBSAMPLE_JOB_ID=$(squeue -u osbourne | grep "$BRONZE_SUBSAMPLE_JOB_NAME" | awk -F " " '{print $1}') && printf "\nThe backup bronze subsample jobid is:\t$backup_BRONZE_SUBAMPLE_JOB_ID\n"
export BRONZE_SUBAMPLE_JOB_ID=$(squeue -u osbourne | grep "$BRONZE_SUBSAMPLE_JOB_NAME" | awk -F " " '{print $1}') && printf "\nThe bronze subsample jobid is:\t$BRONZE_SUBAMPLE_JOB_ID\n"

export SUBBED1=${LBEL}_Subsampled_R1.fastq
export SUBBED2=${LBEL}_Subsampled_R2.fastq
export subbed1=$(readlink -f $SUBBED1)
export subbed2=$(readlink -f $SUBBED2)

printf "\n The subsampled files to be used hereon out are: $subbed1 and $subbed2\n"

touch $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt
printf "Note that the analysis of the taxonomy, the binning and the assembly will all be carried out on the subsampled read files; NOT THE ORIGINALS!!\n" >> $ARRIVALS/NOTE.txt

printf "\n Submitting Taxonomy job which will be called $BRONZE_TAXONOMY_JOB_NAME \n"
sleep 5m && sbatch --dependency=afterany:"$BRONZE_SUBSAMPLE_JOB_ID" $RUN_CHECK-BRONZE-Taxonomy_script.sh $subbed1 $subbed2 $LBEL $ARRIVALS $UIE || sbatch --dependency=afterok:"$backup_BRONZE_SUBSAMPLE_JOB_ID" $RUN_CHECK-BRONZE-Taxonomy_script.sh $subbed1 $subbed2 $LBEL $ARRIVALS $UIE

sleep 120 && printf "\n Whilst I wait 30 seconds to check the Taxonomy script has been submitted, the time now is: " && date
export BRONZE_TAXONOMY_JOB_ID=$(squeue -u osbourne | grep "$BRONZE_TAXONOMY_JOB_NAME" | awk -F " " '{print $1}')

printf "\n Submitting Megahit assembly job which will be called $BRONZE_MEGAHIT_JOB_NAME \n"
sleep 5m && sbatch --dependency=afterany:"$backup_BRONZE_SUBSAMPLE_JOB_ID" $RUN_CHECK-BRONZE-Megahit_assembly_script.sh $CLEAN1 $CLEAN2 $ARRIVALS $UIE $LBEL
export BRONZE_MEGAHIT_JOB_ID=$(squeue -u osbourne | grep "$BRONZE_MEGAHIT_JOB_NAME" | awk -F " " '{print $1}')
sleep 5m && printf "\n The Megahit job ID is: $BRONZE_MEGAHIT_JOB_ID obtained from the job itself which is called $BRONZE_MEGAHIT_JOB_NAME\n"

#printf "\n Submitting Metaprob binning job which will be called $BRONZE_METAPROB_JOB_NAME \n"
#sleep 5m && sbatch --dependency=afterany:"$BRONZE_MEGAHIT_JOB_ID" $RUN_CHECK-BRONZE-Metaprob_binning_script.sh $ARRIVALS $UIE $LBEL

#export BRONZE_METAPROB_JOB_ID=$(squeue -u osbourne | grep "$BRONZE_METAPROB_JOB_NAME" | awk -F " " '{print $1}')
#sleep 5m && printf "\n The Metaprob Job ID is: $BRONZE_METAPROB_JOB_ID obtained from the job itself which is called $BRONZE_METAPROB_JOB_NAME\n"

#export BRONZE_METAPROB_JOB_STATE=$(squeue -u osbourne | grep "$BRONZE_METAPROB_JOB_ID" | awk -F " " '{print $5}')
#printf "\n The metaprob job state is: $BRONZE_METAPROB_JOB_STATE\n"
#export backup_BRONZE_METAPROB_JOB_ID=$(squeue -u osbourne | grep "$BRONZE_METAPROB_JOB_NAME" | awk -F " " '{print $1}')

printf "\n Will use the following jobid as the dependency for the tidying up script: $BRONZE_MEGAHIT_JOB_ID\n"
sleep 12h && sbatch --dependency=afterok:"$BRONZE_MEGAHIT_JOB_ID" $RUN_CHECK-BRONZE-TIDYING_script.sh $ARRIVALS $INPF1 $INPF2 $LBEL $ULTIMATE_DESTINATION $BRONZE_TIDYING_JOB_NAME || sleep 6h && sbatch --dependency=afterany:"$BRONZE_MEGAHIT_JOB_ID" $RUN_CHECK-BRONZE-TIDYING_script.sh $ARRIVALS $INPF1 $INPF2 $LBEL $ULTIMATE_DESTINATION $BRONZE_TIDYING_JOB_NAME
