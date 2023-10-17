#!/bin/bash -e
#SBATCH -t 14-12:30
#SBATCH -c 20
#SBATCH --array=1-PLACEHOLDER%12
#SBATCH -p ei-largemem
#SBATCH --mem=850gb
#SBATCH -J TaxArray
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/scratch/osbourne/Validation-Run/taxonomic-classification_%A_%a.out
#SBATCH -o /ei/scratch/osbourne/Validation-Run/taxonomic-classification_%A_%a.err
#SBATCH --constraint=intel


######NOTES######
#18/03/20 12:44
#This is the third and final script which should be run by the overall taxonomic
#profiling pipeline. It started with the TaxKing.sh script, which did some prep
#work before it then called the TaxPlan.sh script. This gets the value to put
#in place up above where it currently says PLACEHOLDER. Then it runs this array
#script.

######SCRIPT######
echo "We are heading to: '$working_directory'"
echo "This script itself is located in: '$home_base'"
filename=$(ls *_qceed.fastq | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')
echo "The files we will work on are: '$filename'"

#Metaphlan2 runs
srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $working_directory/$filename --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type fastq > ${filename%}-metaphlan-output.txt && echo "Metaphlan2 ran on'$filename'" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ TAXONOMIC CLASSIFICATION /-/-/ Metaphlan2 run has been completed on $filename"

#Kraken2 runs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 10 $working_directory/$filename --confidence 0.75 --classified-out ${filename%}_kraken-classified.out --report ${filename%}_kraken-report.out > ${filename%}_kraken_output.txt && echo "Kraken2 has run" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ TAXONOMIC CLASSIFICATION /-/-/ Kraken2 run has been completed on $filename"

#Diamond runs
diamond blastx -p 20 -d /ei/scratch/osbourne/RETRO-DIAMOND/nr.dmnd -q $working_directory/$filename -o ${filename%}-diamond-output.daa -f 100 && echo "Diamond has run on '$filename'!" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ TAXONOMIC CLASSIFICATION /-/-/ Diamond run has been completed on '$filename' You will need to Meganise it later with a different script."

#Centrifuge2 runs
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --exclude-taxids 33208,33090,554915 --threads 20 --min-hitlen 29 --time --reorder -s ${filename%}-centrifuge_solo_scoring.out -S ${filename%}-centrifuge_solo_scoring-classified.out --report-file ${filename%}-centrifuge_solo_scoring_report.tsv -U $working_directory/$filename && echo "Centrifuge 2 has run on '$filename'" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ TAXONOMIC CLASSIFICATION /-/-/ Centrifuge2 run has been completed on: '$filename'"
