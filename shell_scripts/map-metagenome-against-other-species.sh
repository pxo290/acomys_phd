#!/bin/bash
#SBATCH -t 3-23:35
#SBATCH -c 1
#SBATCH --mem=350000
#SBATCH -J against-all
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This is going to run some of the metagenomes against their host using BBMap
#and Minimap2 and then run the same against human, other acomys species and
#wheat along with mus musculus and potentially another rodent

#First things is to source the necessary tools
source package /tgac/software/testing/bin/minimap2-r922
source package /tgac/software/testing/bin/bbmap-38.06

#Then go to our working directory
cd $1

#You should have the necessary genomes stored here, so copies of the QC'ed
#metagenomes along with the reference genomes which should have gone through
#FastP as well

#Make our groups to work on
acocahfiles=$(find . -maxdepth 1 \( -type f -name "AC*" -name "*_qceed.fastq" -not -name "AR*" \))
acorusfiles=$(find . -maxdepth 1 \( -type f -name "AR*" -name "*_qceed.fastq" -not -name "AC*" \))

#Let's run through them in order, doing all the BBMap work first then the minimap
for f in $acocahfiles
do
  echo "Running BBMap on '$f' now."
  srun bbmap.sh -Xmx255g in=$f out=${f%}-BBMapped.sam ref=
  echo "Ran BBMap on '$f' by the way."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran BBMap with other genomes on '$f' so you know."
done
for f in $acorusfiles
do
  echo "Running BBMap on '$f' now."
  srun bbmap.sh -Xmx255g in=$f out=${f%}-BBMapped.sam ref=
  echo "Ran BBMap on '$f' by the way."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran BBMap with other genomes on '$f' so you know."
done

#Now to run Minimap2 on the files
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
