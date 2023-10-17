#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 3-23:35
#SBATCH -c 2
#SBATCH --mem=650000
#SBATCH -J map-host
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Get mapping software
source package /tgac/software/testing/bin/minimap2-r922
source package /tgac/software/testing/bin/bbmap-38.06

#Go where you are needed
cd $1

#Make our groups to work on
acocahfiles=$(find . -maxdepth 1 \( -type f -name "AC*" -name "*_qceed.fastq" -not -name "AR*" \))
acorusfiles=$(find . -maxdepth 1 \( -type f -name "AR*" -name "*_qceed.fastq" -not -name "AC*" \))

#Run Minimap2 on the files
for f in $acocahfiles
do
  echo "Running Minimap2 on '$f' now."
  minimap2 -N 5 --secondary=no -a $f /hpc-home/osbourne/REFERENCE_GENOMES/mAcoCah1.curated_primary.20181127.fa > ${f%}-Minimap2.sam
  echo "Ran Minimap2 on '$f' by the way."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran Minimap2 on '$f' so you know."
done
for f in $acorusfiles
do
  echo "Running Minimap2 on '$f' now."
  minimap2 -N 5 --secondary=no -a $f /hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa > ${f%}-Minimap2.sam
  echo "Ran Minimap2 on '$f' by the way."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran Minimap2 on '$f' so you know."
done

#Run BBMap on the files
for f in $acocahfiles
do
  echo "Running BBMap on '$f' now."
  srun bbmap.sh -Xmx255g in=$f out=${f%}-BBMapped.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoCah1.curated_primary.20181127.fa
  echo "Ran BBMap on '$f' by the way."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran BBMap on '$f' so you know."
done
for f in $acorusfiles
do
  echo "Running BBMap on '$f' now."
  srun bbmap.sh -Xmx255g in=$f out=${f%}-BBMapped.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa
  echo "Ran BBMap on '$f' by the way."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran BBMap on '$f' so you know."
done
