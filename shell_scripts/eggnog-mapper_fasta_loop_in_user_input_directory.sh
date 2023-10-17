#!/bin/bash -e
#SBATCH -t 07-23:35
#SBATCH -c 10
#SBATCH --mem=425000
#SBATCH -J eggnog_mapper
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --constraint=intel

#This script will go to the user input directory and will put all the fasta
#files it finds there into a variable. It will make a directory called
# 'nest' in which it will store the results of running eggnog-mapper on the
#files in the variable. Eggnog-mapper will be running in diamond mode and uses
#a downloaded diamond database in your personal scratch directory at the moment

#Go where we are going and say where this is
cd $1
echo "We are going to the directory '$1' to run eggnog-mapper on the files there."
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We are bound for '$1' to run eggnog-mapper on the fasta files therein."

#Make our directory to store the output in
mkdir -p nest

#Make our variable in which to store the fasta files we are going to work on
basket_of_files=$(find . -maxdepth 1 \( -type f -name "*.fasta" -not -name "*.daa" -not -name "*.sam" -not -name "*.fastq" -not -name "*eggnog_mapper*" \))

#For posterity list the files which will be worked on
echo "The files which will be worked on in '$1' are as follows: '$basket_of_files'"

#Now make the loop to do the work and record the success of each file
# for f in $basket_of_files
# do
#   clock_check=$(date)
#   echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We begin work on '$f' at '$clock_check'"
#   mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We begin work on '$f'"
#   python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 10 -i $f --output ${f%}-eggnog_mapper-output.fasta --output_dir nest/ -m diamond -d bact --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/test/test_db.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper finishing at '$clock_check'" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper, finishing at '$clock_check'"
# done

#17/02/20
#After very limited results I'm going to try setting the -d to 'none' instead of
#'bact' to see if that helps
#Also for this run on a small single file I'm going to get it out of the longmem
#queue on the HPC and give it a much shorter run time
# for f in $basket_of_files
# do
#   clock_check=$(date)
#   echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We begin work on '$f' at '$clock_check'"
#   mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We begin work on '$f'"
#   python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 10 -i $f --output ${f%}-eggnog_mapper-output.fasta --output_dir nest/ -m diamond -d none --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/test/test_db.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper finishing at '$clock_check'" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper, finishing at '$clock_check'"
# done
# It worked, but only scanned 3 queries to the 1021 that the online one scanned

#17/02/20 20:15
#Possible solution, NOT HAVING THE TEST DATABASE PATH PETER YOU FUCKING IDIOT
##So it does specifically need a .dmnd file, you can't give it the path to
##the eggnog.db file only. I'll try with the eggnog_proteins.dmnd file since it
##is the only actual diamond file I have in the data directory. I might need to
##see about making a database from the eggnog.db file using diamond here on the
##HPC
for f in $basket_of_files
do
  clock_check=$(date)
  echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We begin work on '$f' at '$clock_check'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ We begin work on '$f'"
  python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 10 -i $f --output ${f%}-eggnog_mapper-output.fasta --output_dir nest/ -m diamond -d none --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data/eggnog_proteins.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper finishing at '$clock_check'" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper, finishing at '$clock_check'"
done
clock_check=$(date)
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "/\/\/\ SCRIPT HAS ENDED - eggnog-mapper_fasta_loop_in_user_input_directory.sh ran in '$1' and finshed around '$clock_check'"
#18/02/20
#It, the bit above, does seem to work now that it isn't using the test data set
#for the database anymore. Note though that it did take 5 hours to do 1000 reads
#so it might be case of having to actually split the main file anyway and figure
#out a way to nicely concatenate them all back together afterwards. For now
#though I'm going to try it with just one qceed sample read file and see how
#long that takes.
#In expectation that the full sample file will take more memory and time I've
#made some changes to the sBATCH instructions. These are:
#Changed time to 07-23:35 from 00-01:35
#Changed mem from 125000 to 425000
