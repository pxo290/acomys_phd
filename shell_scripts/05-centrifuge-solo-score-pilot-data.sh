#!/bin/bash
#SBATCH -p ei-largemem
#SBATCH -t 0-18:35
#SBATCH -c 8
#SBATCH --mem=750000
#SBATCH -J cent-solo_pilot-data
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
source centrifuge-1.0.3

cd /hpc-home/osbourne/Testing/Inputs/your_real_data
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 --exclude-taxids 33208 —reorder -s DT032-centrifuge-solo-score.out -1 DT032-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863964-E3-R1.fastq -2 DT032-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863964-E3-R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT032-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 --exclude-taxids 33208  —reorder -s DT033-centrifuge-solo-score.out -1 DT033-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863970-E3-R1.fastq -2 DT033-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863970-E3-R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT033-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT034-centrifuge-solo-score.out -1 DT034-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863965-E3-R1.fastq -2 DT034-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863965-E3-R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT034-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT035-centrifuge-solo-score.out -1 DT035-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863971-E3-R1.fastq -2 DT035-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863971-E3-R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT035-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT036-centrifuge-solo-score.out -1 DT036-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863966-E3_R1.fastq -2 DT036-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863966-E3_R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT036-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT037-centrifuge-solo-score.out -1 DT037-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863972-E3_R1.fastq -2 DT037-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863972-E3_R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT037-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT038-centrifuge-solo-score.out -1 DT038-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863967-E3_R1.fastq -2 DT038-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863967-E3_R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT038-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT039-centrifuge-solo-score.out -1 DT039-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863973-E3_R1.fastq -2 DT039-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863973-E3_R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT039-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT040-centrifuge-solo-score.out -1 DT040-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863968-E3_R1.fastq -2 DT040-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863968-E3_R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT040-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT041-centrifuge-solo-score.out -1 DT041-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863974-E3_R1.fastq -2 DT041-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863974-E3_R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT041-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT042-centrifuge-solo-score.out -1 DT042-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863969-E3_R1.fastq -2 DT042-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863969-E3_R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT042-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
centrifuge -p8 -x /ei/references/databases/centrifuge/nt -q -k 1 --exclude-taxids 33208 —reorder -s DT043-centrifuge-solo-score.out -1 DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq -2 DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq && mv *.tsv /hpc-home/osbourne/Scripts/Outputs/DT043-centrifuge-solo-score.tsv && mv *.out /hpc-home/osbourne/Scripts/Outputs
