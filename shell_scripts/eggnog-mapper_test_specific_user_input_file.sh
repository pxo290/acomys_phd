#!/bin/bash -e
#SBATCH -t 20-23:35
#SBATCH -p ei-largemem
#SBATCH -c 10
#SBATCH --mem=850000
#SBATCH -J noggenfogger
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Sourcing in the attic
##Including the version of diamond on the HPC closest to the one it seems to
##use itself internally, though hashed out for now. Could try adding it as
##active if this fails again
#source package /tgac/software/testing/bin/diamond-0.9.24
##Also sourcing python 2 since it might be only written for python 2 going by
##comments on the github page
source package /tgac/software/production/bin/python-2.7.9

#Tell us what we will be working on
# echo "The file to be worked on is '$f'"
# mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "The second, single specific file eggnog-mapper test script will run on file:'$1'"

#Making a directory to put the files in
mkdir -p beaten_eggs

#Now to actually do the work
#This uses the default values from the online tool version save that it restricts
#the ortholog search to bacterial orthologs
# python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 10 -i $1 --output ${1%}-eggnog_mapper-output.fa --output_dir beaten_eggs/ -m diamond -d none --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper"

#13/02/20 14:38
#Tried adding -d bact instead of -d none but it didn't change the not actually
#processing any queries

# python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 10 -i $1 --output ${1%}-eggnog_mapper-output.fa --output_dir beaten_eggs/ -m diamond -d bact --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper"

#13/02/20 19:30
#I cancelled the job and removed the --nice flag and switched it to use the
#large-mem queue since it was taking forever to start. It got going and failed
#this time. An actual error for a change. The error was:
#Error: Error reading file /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data
#I'm going to try then putting the path to the .dmnd file for the --dmnd_db

python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 10 -i $1 --output ${1%}-eggnog_mapper-output.fa --output_dir beaten_eggs/ -m diamond -d bact --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/test/test_db.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper" && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPER UPDATE /-/-/ The file '$f' has been run through eggnog-mapper"

#13/02/20 19:40
#SHE WORKS!!!!! Still says no sequences scanned in the pretend synthetic metagenome
#but it worked fine on the split fasta file you gave it
#So now let us make it a proper thing, cd'ing to the directory we give it and
#storing all the fasta files to be worked on in a variable before looping through
#them
