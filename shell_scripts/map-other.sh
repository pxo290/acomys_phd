#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 14-23:35
#SBATCH -c 2
#SBATCH --mem=575000
#SBATCH -J map-tother
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


###31/01/20 - Minimap2 is probably not the right tool to use for this kind of
###mapping so I'm going to hash it out from the scripts, but keep the original
###code in here so that I can re-use it elsewhere if needed in the future

#Get mapping software
#source package /tgac/software/testing/bin/minimap2-r922
source package /tgac/software/testing/bin/bbmap-38.06

#Go where you are needed
cd $1

#Make our groups to work on
acocahfiles=$(find . -maxdepth 1 \( -type f -name "AC*" -name "*_qceed.fastq" -not -name "AR*" -not -name "*.daa" \))
acorusfiles=$(find . -maxdepth 1 \( -type f -name "AR*" -name "*_qceed.fastq" -not -name "AC*" -not -name "*.daa" \))

#First thing is to run the pilot samples against the other acomys species from
#themselves with Minimap2
# for f in $acocahfiles
# do
#   echo "Running Minimap2 with other Acomys species genome on '$f' now."
#   minimap2 -N 5 --secondary=no -a $f /hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa > ${f%}-Minimap2.sam
#   echo "Ran Minimap2 on '$f' by the way."
#   mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran Minimap2 with other Acomys species genome on '$f' so you know."
# done
# for f in $acorusfiles
# do
#   echo "Running Minimap2 with other Acomys species genome on '$f' now."
#   minimap2 -N 5 --secondary=no -a $f /hpc-home/osbourne/REFERENCE_GENOMES/mAcoCah1.curated_primary.20181127.fa > ${f%}-Minimap2.sam
#   echo "Ran Minimap2 on '$f' by the way."
#   mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran Minimap2 with other Acomys species genome on '$f' so you know."
# done

#Now you need to do the same but with BBMap
for f in $acocahfiles
do
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Will run BBMap with other genomes on '$f' so you know."
  echo "Running BBMap with other Acomys species genome on '$f' now."
  srun bbmap.sh -Xmx255g in=$f out=${f%}-BBMapped.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa
  echo "Ran BBMap on '$f' by the way."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran BBMap with other genomes on '$f' so you know."
done
for f in $acorusfiles
do
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Will run BBMap with other genomes on '$f' so you know."
  echo "Running BBMap with other Acomys species genome on '$f' now."
  srun bbmap.sh -Xmx255g in=$f out=${f%}-BBMapped.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoCah1.curated_primary.20181127.fa
  echo "Ran BBMap on '$f' by the way."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Ran BBMap with other genomes on '$f' so you know."
done

#Alright, the next thing is to run them against the metagenomes you've
#downloaded. Bear in mind that they are very different sizes and that one of the
#mapping softwares can't handle multiple reference genomes
#So I think the smart thing to do is to make some worker scripts which will run
#each of the metagenomes against the files individually, using both tools in
#each script

sbatch /ei/scratch/osbourne/interleaved-pilot-fastqs/scripts/worker-euk_map.sh $1 && sbatch /ei/scratch/osbourne/interleaved-pilot-fastqs/scripts/worker-met_map.sh $1
