#!/bin/bash -e
#SBATCH -t 0-23:35
#SBATCH -c 2
#SBATCH --mem=45000
#SBATCH -J metaphlan2

#Metaphlan2 manual - https://bitbucket.org/biobakery/metaphlan2/src/default/

#Sourcing the Metahplan2 on the cluster
source package /tgac/software/testing/bin/metaphlan-2f1b17a1f4e9

#Running Metaphlan2
#After some iffy stuff at the start I always redirect the output of Metaphlan2
#to a specific text file but this isn't strictly necessary
srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py <file> --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type <fasta or fastq> > <file_name>-metaphlan_output.txt
