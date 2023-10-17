#!/bin/bash -e
#SBATCH -t 08-23:35
#SBATCH -c 10
#SBATCH --mem=456000
#SBATCH -J egng-m-tst
#SBATCH --nice 750
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Going to the directory where the test file is stored
cd $1
#Sourcing python since it seems to need it - note you're using a version
#of Python 3 from the NBI catalogue
source package /nbi/software/production/bin/python-3.7.2

#Since you aren't going to give the full path to the file being analysed you
#will instead need to give the full path to the script itself
#To make this a bit more of a useful test use $2 for second user input rather
#than a direct path to the particular file you're using for the test
echo "-/-/-/-/-/-/-/Will run eggnog mapper on '$2' now."
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Will run eggnog mapper on '$2' now."
python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py -i $2 --output ${2%}-eggnog_mapper-test -m diamond && echo "-/-/-/-/-/-/-/Ran eggnog mapper on '$2' now." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran eggnog mapper on '$2' now."

#The test should be run with a fastq and fasta version of the file to see how
#it copes with either type


#This is the script listed on the online version which it ran on your synthetic test genome fasta file
#emapper.py --cpu 10 -i /data/shared/emapper_jobs/user_data/MM_9f95wwcc/query_seqs.fa --output query_seqs.fa --output_dir /data/shared/emapper_jobs/user_data/MM_9f95wwcc -m diamond -d none --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override --temp_dir /data/shared/emapper_jobs/user_data/MM_9f95wwcc

# This didn't work on the pretend fasta either - 11/02/20
# source package /tgac/software/production/bin/python-2.7.3
# python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 4 -i PRETEND-synthetic-metaegnome-for-testing.fasta --output eggnog-mapper-pretend-metagenome_with-online-script.fa --output_dir transit/ -m diamond -d none --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override
