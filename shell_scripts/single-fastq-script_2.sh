#!/bin/bash -e
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source bbmap-38.06

echo "±±±±±Starting the second step, removing human contamination."
QCeed_files=$(find . -maxdepth 1 \( -type f -name "*_qceed.fq" \))
echo "±±±±±This is what you will be working on: "
echo $QCeed_files
export QCeed_files
for i in $QCeed_files
do
  echo "±±±±±This is what this stage will work on: $i"
  srun bbduk.sh -Xmx128g -prealloc in="$i" ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa \
  outm=${i%}_contaminated.fq out=${i%}_human_cleansed.fq overwrite=t && echo "±±±±±Human contamination removal on $i was successful." \
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that human contamination removal of $i has been executed."
  mkdir -p human_contaminated
  for f in *_contaminated.fq
  do
    mv $f human_contaminated/$f
  done
done
echo "±±±±±The second step, the human contaminant removal with BBDuk has concluded one way or another"
