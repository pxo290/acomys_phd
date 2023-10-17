#!/bin/bash
#SBATCH -t 4-23:35
#SBATCH -c 1
#SBATCH --mem=18000
#SBATCH -J obt_gen
#SBATCH --nice 250
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

cd /ei/workarea/group-dt/groupData/Primary_data/Genome/Private
acomysdirectories=$(find . -maxdepth 1 \( -type d -name "Acomys*" \))
echo "This script should copy the listed directories to somewhere safe on your scratch - '$f'"
scp /ei/workarea/group-dt/groupData/Primary_data/Genome/Private/Acomys_cahirinus_mAcoCah1_REL_1905 /ei/scratch/osbourne/genomes_from_dt_work-acomys_species
scp /ei/workarea/group-dt/groupData/Primary_data/Genome/Private/Acomys_kempi_mAcoKem2_REL_1905 /ei/scratch/osbourne/genomes_from_dt_work-acomys_species
scp /ei/workarea/group-dt/groupData/Primary_data/Genome/Private/Acomys_percivali_mAcoPer2_REL_1905 /ei/scratch/osbourne/genomes_from_dt_work-acomys_species
scp /ei/workarea/group-dt/groupData/Primary_data/Genome/Private/Acomys_russatus_mAcoRus1_REL_1905 /ei/scratch/osbourne/genomes_from_dt_work-acomys_species
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "All Acomys species directories, 4 in total, should have been moved to your scratch."
