#!/bin/bash -e
#SBATCH -t 00-23:55
#SBATCH -c 15
#SBATCH --mem=700gb
#SBATCH --array=1-PLACEHOLDER%25
#SBATCH -p ei-largemem
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o PLACEHOLDER/eggnog-mapper_%A_%a.out
#SBATCH -o PLACEHOLDER/eggnog-mapper_%A_%a.err
#SBATCH --constraint=intel

######NOTES######
#27/03/20
#See array_eggnog-mapperV2_planner.sh for the explanation of the process in that
#script. This is the array component of it. This script itself should never run,
#but instead be used by the planner script to make a new version (through a few
#intermediaries) which has all the 'PLACEHOLDER's replaced with values from
#variables made in the planner script.

######SCRIPT######
echo "We are headed for '$destination' there to run eggnog-mapperV2 on fasta files in an array"
cd $destination
locale=$(pwd) && echo $locale
start_time=$(date)
echo "This script is starting at: $clock_check"
filename=$(ls *.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')
python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 15 -i $locale/$filename --output $filename-eggnog_mapper-output.fasta --output_dir PLACEHOLDER -m diamond -d none --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data/eggnog_proteins.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "I ran a file through eggnog-mapperV2 as part of an array."
