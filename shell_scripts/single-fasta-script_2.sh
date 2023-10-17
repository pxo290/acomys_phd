#!/bin/bash -e
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source switch-institute ei
source bbmap-38.06
echo "±±±±±Starting the second step, removing human contamination."
echo "±±±±±This is what you will be working on: "
echo $raw_input_fasta_files
export raw_input_fasta_files
echo "±±±±±"
for i in $raw_input_fasta_files
do
  echo "±±±±±This is what this stage will work on: "$i""
  srun bbduk.sh -Xmx128g -prealloc in="$i" ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa \
  outm=${i%}_contaminated.fa out=${i%}_human_cleansed.fa overwrite=t && echo "±±±±±Human contamination removal on $i was successful." \
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that human contamination removal of $i has been executed."
  mkdir -p human_contaminated
  for f in *_contaminated.fa
  do
    mv $f human_contaminated/$f
  done
done
echo "±±±±±The second step, the human contaminant removal with BBDuk has concluded one way or another"
