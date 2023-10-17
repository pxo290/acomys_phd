#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 14-23:35
#SBATCH -c 1
#SBATCH --mem=856000
#SBATCH -J met-map
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Going to the directory from the controller script which is originally supplied
#by the user on the command line
cd $1

#Making the variable which stores all the fastq files which are to be analysed
allacofiles=$(find . -maxdepth 1 \( -type f -name "*_qceed.fastq" -not -name "*diamond*" \))

for f in $allacofiles
do
  echo "-/-/-/-/-/-/-/Running BBMap with other metagenomes on '$f' now."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Will run BBMap with non-host genomes on '$f'."
  srun bbmap.sh -Xmx255g in=$f out=${f%}-BBMapped-against_metagenomes.sam ref=/ei/scratch/osbourne/against-all/ENA_Study_PRJEB6946-Sample_ERR576948-Camel-gut-metagenome.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA176586-Run_accession_SRR579541-Camel_forestomach_fluid_metagenome.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA176586-Run_accession_SRR606389-Camel_forestomach_fluid_metagenome.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA229525-Namib_Hypolith_Desert_Metagenome-Interleaved_read_files.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA366188-Sample_SAMNO6268421-Polar_soil_metagenome_antarctic_dry_valleys-UQ493-Interleaved_read_files.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA429148-Run_accession_SRR6461105-Atacama_desert_rhizosphere_metagenome.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA442914-Sample_accession_SAMN08778197-Anza_Borrego_desert_soil_metagenome-Interleaved_read_files.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA450868-Polar_soil_metagenomes-Run_accession_SRR7058388_subreads.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA450868-Polar_soil_metagenomes-Run_accession_SRR7058389_subreads.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA450868-Polar_soil_metagenomes-Run_accession_SRR7058390_subreads.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA450868-Polar_soil_metagenomes-Run_accession_SRR7058391_subreads.fastq,/ei/scratch/osbourne/against-all/ENA_Study_PRJNA450868-Polar_soil_metagenomes-Run_accession_SRR7058392_subreads.fastq
  echo "-/-/-/-/-/-/-/Ran BBMap with other metagenomes on '$f' now."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran BBMap with non-host genomes on '$f'."
done
