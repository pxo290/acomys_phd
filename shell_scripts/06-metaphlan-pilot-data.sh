#!/bin/bash
#SBATCH -p ei-largemem
#SBATCH -t 0-18:35
#SBATCH -c 8
#SBATCH --mem=1000000
#SBATCH -J metaphlan-pilot-data
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

cd /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases
export PATH='pwd':$PATH
export mpa_dir='pwd'

source gcc-5.3.0
source blast-2.6.0
source bowtie-2.2.6
source biopython-1.66
source python-3.5.1
source numpy-1.9.2
source python-2.7.9
source scipy-1.0.0

source metaphlan-2f1b17a1f4e9

cd /hpc-home/osbourne/Testing/Inputs/your_real_data
for f in *.fastq ; do srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq --nproc 6 > ${f%}_metaphlan_classification.txt ; done
mv *metaphlan_classification.txt /hpc-home/osbourne/Scripts/Outputs  


