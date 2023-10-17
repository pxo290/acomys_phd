#!/bin/bash
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 2
#SBATCH --mem=850000
#SBATCH -J tidying
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This is meant as a single use script to tidy up what didn't finish from the
#normalisation and taxonomic classification scripts being run on the interleaved
#fastq files in late Jan 2020.

#Sourcing up in the attic
source package /tgac/software/testing/bin/bbmap-38.06

#Doing the normalisation bit first
cd /ei/scratch/osbourne/interleaved-pilot-fastqs/qceed-fastqs
subjectfiles=$(find . -maxdepth 1 -type f -name 'AR*' -not -name 'AR29N*' ) && echo "Here are the files '$subjectfiles'"
for f in $subjectfiles
do
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "---...---A.T.T.E.N.T.I.O.N---...---Will be running bbnorm on '$f' ---...---A.T.T.E.N.T.I.O.N---...---"
  srun bbnorm.sh in=$f out=${f%}-normalised.fastq target=5 min=1 && echo "Normalisation using BBNorm has occured on '$f' by the way." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Normalisation of file '$f' has been completed."
  srun bbnorm.sh in=$f out=${f%}-normalised_v2.fastq target=10 min=5 && echo "Normalisation using BBNorm has occured on '$f' by the way." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "2nd normalisation of file '$f' has been completed."
  srun bbnorm.sh in=$f out=${f%}-normalised_v3.fastq target=25 min=10 && echo "Normalisation using BBNorm has occured on '$f' by the way." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "3rd normalisation of file '$f' has been completed."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "---...---A.T.T.E.N.T.I.O.N---...---Ran bbnorm on '$f' ---...---A.T.T.E.N.T.I.O.N---...---"
done
mv *normalised* /ei/scratch/osbourne/interleaved-pilot-fastqs/normalised-fastqs

#Next taxonomic classification
