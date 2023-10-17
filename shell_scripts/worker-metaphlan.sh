#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 2
#SBATCH --mem=750000
#SBATCH -J go_met

cd $1
for f in *.fastq
do
  echo "Running Metaphlan2 on '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "-|-|-\\\ METAPHLAN UPDATE \\\ Metaphlan2 will run on '$f'"
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${f%}_metaphlan-output.txt && echo "Metaphlan2 analysis of '$f' has been accomplished." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that Metaphlan2 has run on '$f'"
  echo "Ran Metaphlan2 on '$f'"
done
