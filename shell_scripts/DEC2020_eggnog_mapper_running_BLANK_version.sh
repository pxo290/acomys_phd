#!/bin/bash -e
#SBATCH -t 03-23:55
#SBATCH -c 15
#SBATCH --mem=123gb
#SBATCH --array=1-PLACEHOLDER1%50
#SBATCH -p ei-medium
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o PLACEHOLDER/eggnog-mapper_%A_%a.out
#SBATCH -o PLACEHOLDER/eggnog-mapper_%A_%a.err
#SBATCH --constraint=intel
#SBATCH --profile=all
#SBATCH --nice=250

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
