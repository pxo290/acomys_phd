#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 3-23:35
#SBATCH -c 2
#SBATCH --mem=650000
#SBATCH -J normalising_meta
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


#Sourcing the bbmap suite which includes the tools you will be using
source package /tgac/software/testing/bin/bbmap-38.06

#Going where we need to go
cd $1

#Make our groups to work on
acocahfiles=$(find . -maxdepth 1 \( -type f -name "AC*" -name "*_qceed.fastq" -not -name "AR*" \))
acorusfiles=$(find . -maxdepth 1 \( -type f -name "AR*" -name "*_qceed.fastq" -not -name "AC*" \))

# #Doing work using reformat from BBTools to subsample
# #Here you will be looking at the first 5,000,000 bases in each fastq file and
# #subsampling from them at a rate of 75% so all files should end up containing
# #3,750,000 bases
# for f in $acocahfiles
# do
#   echo "Using reformat.sh to get 75% of the first 5,000,000 bases of '$f'"
#   reformat.sh in=$f out=${f%}-reformat-subsampled-75pc-5000000-bases.fastq reads=5000000 samplerate=0.75 int=t
#   echo "Used reformat.sh to get 75% of the first 5,000,000 bases of '$f'"
#   mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Used reformat.sh to get 75% of the first 5,000,000 bases of '$f' so you know."
# done
# for f in $acorusfiles
# do
#   echo "Using reformat.sh to get 75% of the first 5,000,000 bases of '$f'"
#   reformat.sh in=$f out=${f%}-reformat-subsampled-75pc-5000000-bases.fastq reads=5000000 samplerate=0.75 int=t
#   echo "Used reformat.sh to get 75% of the first 5,000,000 bases of '$f'"
#   mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Used reformat.sh to get 75% of the first 5,000,000 bases of '$f' so you know."
# done

#Doing work using bbnorm for normalisation
for f in $acocahfiles
do
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "---...---A.T.T.E.N.T.I.O.N---...---Will be running bbnorm on '$f' ---...---A.T.T.E.N.T.I.O.N---...---"
  srun bbnorm.sh in=$f out=${f%}-normalised.fastq target=5 min=1 && echo "Normalisation using BBNorm has occured on '$f' by the way." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Normalisation of file '$f' has been completed."
  srun bbnorm.sh in=$f out=${f%}-normalised_v2.fastq target=10 min=5 && echo "Normalisation using BBNorm has occured on '$f' by the way." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "2nd normalisation of file '$f' has been completed."
  srun bbnorm.sh in=$f out=${f%}-normalised_v3.fastq target=25 min=10 && echo "Normalisation using BBNorm has occured on '$f' by the way." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "3rd normalisation of file '$f' has been completed."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "---...---A.T.T.E.N.T.I.O.N---...---Ran bbnorm on '$f' ---...---A.T.T.E.N.T.I.O.N---...---"
done
for f in $acorusfiles
do
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "---...---A.T.T.E.N.T.I.O.N---...---Will be running bbnorm on '$f' ---...---A.T.T.E.N.T.I.O.N---...---"
  srun bbnorm.sh in=$f out=${f%}-normalised.fastq target=5 min=1 && echo "Normalisation using BBNorm has occured on '$f' by the way." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Normalisation of file '$f' has been completed."
  srun bbnorm.sh in=$f out=${f%}-normalised_v2.fastq target=10 min=5 && echo "Normalisation using BBNorm has occured on '$f' by the way." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "2nd normalisation of file '$f' has been completed."
  srun bbnorm.sh in=$f out=${f%}-normalised_v3.fastq target=25 min=10 && echo "Normalisation using BBNorm has occured on '$f' by the way." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "3rd normalisation of file '$f' has been completed."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "---...---A.T.T.E.N.T.I.O.N---...---Ran bbnorm on '$f' ---...---A.T.T.E.N.T.I.O.N---...---"
done
