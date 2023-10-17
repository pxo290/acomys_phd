#!/bin/bash -e
#SBATCH -t 15-23:35
#SBATCH -p ei-largemem
#SBATCH -c 10
#SBATCH --mem=850000
#SBATCH -J V2eggnog_mapper
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --constraint=intel

#17/02/20
#This is a modified version of your eggnog-mapper script which should be less
#strenuous and not only find ATPases and the like

# This script will go to the user input directory and will put all the fasta
# files it finds there into a variable. It will make a directory called
# 'nest' in which it will store the results of running eggnog-mapper on the
# files in the variable. Eggnog-mapper will be running in diamond mode and uses
# a downloaded diamond database in your personal scratch directory at the moment

#Go where we are going and say where this is
cd $1
echo "We are going to the directory '$1' to run eggnog-mapper on the files there."
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We are bound for '$1' there to run eggnog-mapper on the fasta files therein."

#Make our directory to store the output in
mkdir -p burrow

#Make our variable in which to store the fasta files we are going to work on
basket_of_files=$(find . -maxdepth 1 \( -type f -name "*.fasta" -not -name "*.daa" -not -name "*.sam" -not -name "*.fastq" -not -name "*eggnog_mapper*" \))

#For posterity list the files which will be worked on
echo "The files which will be worked on in '$1' are as follows: '$basket_of_files'"

#Now make the loop to do the work and record the success of each file
for f in $basket_of_files
do
  clock_check=$(date)
  echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We begin work on '$f' at '$clock_check'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We begin work on '$f'"
  python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 10 -i $f --output ${f%}-eggnog_mapper-output.fasta --output_dir burrow/ -m diamond --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data/eggnog_proteins.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.0001 --seed_ortholog_score 30 --query-cover 10 --subject-cover 0 --override && echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper finishing at '$clock_check'" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper, finishing at '$clock_check'"
done
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "-/-/-/ SCRIPT UPDATE: V2eggnog-mapper_fasta_loop_in_user_input_directory.sh has run over all the fasta files in directory '$f' \-\-\-"

##18/02/20 - Made the corrections from the other version of the script so it no
##longer defaults to the test set database

#The changes made in this V2 are:
# removed -d bact
# removed --tax_scope 2
# changed --seed_ortholog_evalue 0.001 to 0.0001
# changed --seed_ortholog_score 60 to 30
# changed --query-cover 20 to 10
#Might be worth in the future considering increasing --subject-cover 0 if this
#modified version is too noisy

##18/02/20 - Going to test this on a subsampled read file, the same one you used
##to get the orirginal script working so you can compare the differences between
##the two. Also will run it on a full sample read file to see how long it takes
