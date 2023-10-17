#!/bin/bash -e
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

human_cleansed_files=$(find . -maxdepth 1 \( -type f -name "*_human_cleansed.fa" \))
echo "±±±±±"
echo $human_cleansed_files
echo "±±±±±"
echo "±±±±±Starting the Metaphlan2 run on the files."
export human_cleansed_files
for i in $human_cleansed_files
do
  echo "±±±±±This is what this stage will work on: "$i""
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py "$i" --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fasta > ${i%}_metaphlan-output.txt && echo "±±±±±Metaphlan2 analysis of $i has been accomplished." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Metaphlan2 has run on '$i' .'
  mkdir -p metaphlan2-output
  for f in *.txt
  do
    mv $f metaphlan2-output/
  done
done
echo "±±±±±The third step, the Metaphlan2 taxonomic analysis has concluded one way or another."
