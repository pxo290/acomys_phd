#!/bin/bash
#SBATCH -p ei-largemem
#SBATCH -t 0-18:35
#SBATCH -c 8
#SBATCH --mem=700000
#SBATCH -J krak-pilot-data
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


source gcc-5.3.0
source blast-2.6.0
source bowtie-2.2.6
source blast+-2.7.1
source python-3.5.1
source python-3.5.1_mb
source python_anaconda-5.3.0_py3_cs
source perl-5.16.2
source bioperl-1.6.1
source perl_activeperl-5.16.3.1603
source python-2.7.9
source biopython-1.60
source kraken2-2.0.7

cd /hpc-home/osbourne/Testing/Inputs/your_real_data
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT032_#.out DT032-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863964-E3-R1.fastq DT032-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863964-E3-R2.fastq --report DT032_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT033_#.out DT033-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863970-E3-R1.fastq DT033-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863970-E3-R2.fastq --report DT033_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT034_#.out DT034-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863965-E3-R1.fastq DT034-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863965-E3-R2.fastq --report DT034_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT035_#.out DT035-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863971-E3-R1.fastq DT035-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863971-E3-R2.fastq --report DT035_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT036_#.out DT036-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863966-E3_R1.fastq DT036-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863966-E3_R2.fastq --report DT036_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT037_#.out DT037-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863972-E3_R1.fastq DT037-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863972-E3_R2.fastq --report DT037_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT038_#.out DT038-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863967-E3_R1.fastq DT038-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863967-E3_R2.fastq --report DT038_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT039_#.out DT039-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863973-E3_R1.fastq DT039-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863973-E3_R2.fastq --report DT039_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT040_#.out DT040-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863968-E3_R1.fastq DT040-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863968-E3_R2.fastq --report DT040_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT041_#.out DT041-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863974-E3_R1.fastq DT041-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863974-E3_R2.fastq --report DT041_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT042_#.out DT042-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863969-E3_R1.fastq DT042-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863969-E3_R2.fastq --report DT042_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 8 --paired --classified-out DT043_#.out DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq --report DT043_report.out && mv *report.out /hpc-home/osbourne/Scripts/Outputs
cd /hpc-home/osbourne/Scripts/Outputs
for f in *.out ; do mv $f ${f}.txt ; done
