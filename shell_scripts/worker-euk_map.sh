#!/bin/bash -e
#SBATCH -t 14-23:35
#SBATCH -c 1
#SBATCH --mem=356000
#SBATCH -J euk-map
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Going to the directory from the controller script which is originally supplied
#by the user on the command line
cd $1

#Making the variable which stores all the fastq files which are to be analysed
allacofiles=$(find . -maxdepth 1 \( -type f -name "*_qceed.fastq" -not -name "*diamond*" \))

for f in $allacofiles
do
  echo "-/-/-/-/-/-/-/Running BBMap with non-Acomys genomes on '$f' now."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Will run BBMap with non-host genomes on '$f'."
  srun bbmap.sh -Xmx255g in=$f out=${f%}-BBMapped-against_other_eukaryote_genomes.sam ref=/ei/scratch/osbourne/against-all/GRCh38_latest_genomic_human_reference.fa,/ei/scratch/osbourne/against-all/Mus_musculus-GCF_000001635.26_GRCm38.p6_genomic.fna,/ei/scratch/osbourne/against-all/Peromyscus_maniculatus_bairdii-Prairie_deer_mouse-GCA_003704035.1_HU_Pman_2.1_genomic.fna,/ei/scratch/osbourne/against-all/Rattus_norvegicus.Rnor_6.0.dna_sm.toplevel.fa,/ei/scratch/osbourne/against-all/Triticum_aestivum.IWGSC.dna.toplevel.fa
  echo "-/-/-/-/-/-/-/Ran BBMap with non-Acomys genomes on '$f' now."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran BBMap with non-host genomes on '$f'."
done
