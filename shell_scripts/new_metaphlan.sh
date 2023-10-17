#!/bin/bash
#SBATCH -t 0-23:35
#SBATCH -c 6
#SBATCH --mem=256000
#SBATCH -J metaphlan2-nova_cleanse
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

cd $1
echo "You are working here '$1'" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that Metaphlan2 will be running here '$1'."
desiredfiles=$(find . -maxdepth 1 \( -type f -name "*$2*" \))
for f in $desiredfiles
do
  echo "This is the new_metaphlan.sh script running on '$f' found in the directory '$1' ."
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${f%}_metaphlan-output.txt && echo "±±±±±Metaphlan2 analysis of '$f' has been accomplished." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that Metaphlan2 has run on '$f'."
  mkdir -p metaphlan2-output
  for f in *.txt
  do
    mv $f metaphlan2-output/
  done
done
