#!/bin/bash -e
#SBATCH -t 03-23:55
#SBATCH -c 15
#SBATCH --mem=123gb
#SBATCH --array=1-PLACEHOLDER%50
#SBATCH -p ei-medium
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o PLACEHOLDER/eggnog-mapper_%A_%a.out
#SBATCH -o PLACEHOLDER/eggnog-mapper_%A_%a.err
#SBATCH --constraint=intel
#SBATCH --profile=all
#SBATCH --nice=250

######NOTES######
#01/05/20
#So it turns out that the placeholder in the output directory section wasn't
#being changed; that'll need to be fixed. Whilst doing some edits you also have
#changed the partition to ei-medium and cut the max run time to 3 days, 23 hours
#and 55 minutes so that it will be able to queue on the ei-medium queue.

#28/04/20
#Made small change from looking at the output of snoderes on the cluster, the
#majority of the ei-medium nodes seem to have max memory allocations of 123GB,
#So I've changed #SBATCH --mem=125gb to 123gb

#18/04/20 17:15
#Made a large number of changes, so make sure that the planner script has all
#the locations where it should be running 'sed' corrected as well
# 1) Added the sbatch header/flag --profile which should help with getting nice
#    stats on resource usage by the job
# 2) Added the sbatch header/flag --nice which should mean people complain less
#    about your usage of the cluster
# 3) Major change is making the array include a testing if-then-else component
#    which if it works will help make things more efficient by not overwriting
#    an output file and running the job again if the correctly completed output
#    is already there

#14/04/20
#This is a copy over of most the script from array_eggnog-mapperV2_blank-Version.sh
#with some edits made after the other version failed due to run time being
#exceeded in some of the files. See the Marque3 planner script for the changes
#made in that file and explanation of the changes in general. In this script the
#changes are:
# 1) Reduced memory request - from 700GB to 125GB
# 2) Increased max simultaneous job number -  from 25 to 50
# 3) Changing from the ei-largemem queue to the ei-long queue
# 4) Changing the max run time from 23 hours and 55 minutes to 14 days
# 5) Altering the names in this script as necessary to point to the right place

#27/03/20
#See array_eggnog-mapperV2_planner.sh for the explanation of the process in that
#script. This is the array component of it. This script itself should never run,
#but instead be used by the planner script to make a new version (through a few
#intermediaries) which has all the 'PLACEHOLDER's replaced with values from
#variables made in the planner script.

######SCRIPT######
######NONE-IF-ELSE-VERSION-DOES-WORK######
# printf "\n This script will run on $filename, if there has not been a successfully completed run through it already"
# echo "We are headed for '$destination' there to run eggnog-mapperV2 on fasta files in an array"
# cd $destination
# locale=$(pwd) && echo $locale
# start_time=$(date) && printf "The time now is: $start_time"
# echo "This script is starting at: $start_time"
# filename=$(ls *.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')
# python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 15 -i $locale/$filename --output $filename-eggnog_mapper-output --output_dir PLACEHOLDER -m diamond -d none --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data/eggnog_proteins.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "I ran $locale/$filename through eggnog-mapperV2 as part of an array." && printf "\nThe file which ran through eggnog-mapperV2 was: $locale/$filename" >> $egg_outputs/${trimmed_destination}-output_log.txt

######SCRIPT######
######IF-ELSE-VERSION######
cd $egg_outputs
subject="$egg_outputs/$filename-eggnog_mapper-output.emapper.annotations"
if [ -f $subject ]
then
  if fgrep -q "Total time (seconds)" "$subject"
  then
    printf "\nThe file already exists and was made completely"
    mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPERV2 /-/-/ A file has already been successfully processed through Eggnon-mapperV2, this file being $subject"
  else
    cd $egg_outputs
    printf "\n The file already exists, but may not have been made correctly. It will be renamed to $filename-OLD and the eggnog-mapperV2 array script will run again on the fasta file."
    mv "$subject" $subject-OLD
    cd $destination
    locale=$(pwd) && echo $locale
    start_time=$(date) && printf "The time now is: $start_time"
    echo "This script is starting at: $start_time"
    filename=$(ls *.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')
    python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 15 -i $locale/$filename --output $filename-eggnog_mapper-output --output_dir PLACEHOLDER -m diamond -d none --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data/eggnog_proteins.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "I ran $locale/$filename through eggnog-mapperV2 as part of an array." && printf "\nThe file which ran through eggnog-mapperV2 was: $locale/$filename" >> $egg_outputs/${trimmed_destination}-output_log.txt
    mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPERV2 /-/-/ A file was processed through Eggnon-mapperV2, the file being $locale/$filename"
  fi
else
  printf "\n The file $locale/$filename will be run through the eggnog-mapperV2 array as now prior correct output file could be found."
  echo "We are headed for '$destination' there to run eggnog-mapperV2 on fasta files in an array"
  cd $destination
  locale=$(pwd) && echo $locale
  start_time=$(date) && printf "The time now is: $start_time"
  echo "This script is starting at: $start_time"
  filename=$(ls *.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')
  python /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/emapper.py --cpu 15 -i $locale/$filename --output $filename-eggnog_mapper-output --output_dir PLACEHOLDER -m diamond -d none --dmnd_db /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data/eggnog_proteins.dmnd --translate --data_dir /ei/scratch/osbourne/eggnog-mapper-2.0.1/eggnog-mapper-master/data --override --tax_scope 2 --go_evidence non-electronic --target_orthologs all --seed_ortholog_evalue 0.001 --seed_ortholog_score 60 --query-cover 20 --subject-cover 0 --override && echo "I ran $locale/$filename through eggnog-mapperV2 as part of an array." && printf "\nThe file which ran through eggnog-mapperV2 was: $locale/$filename" >> $egg_outputs/${trimmed_destination}-output_log.txt
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPERV2 /-/-/ A file was processed through Eggnon-mapperV2, the file being $locale/$filename"
fi
