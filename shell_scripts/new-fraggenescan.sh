#!/bin/bash -e
#SBATCH -t 0-20:01
#SBATCH -c 8
#SBATCH --mem=256000
#SBATCH -J FragGeneScan
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Note for context
echo "You are running the new FragGeneScan on the .fa files found in '$1' using the script new-fraggenescan.sh found in your scratch script directory"

#Remember that you should have it email you what it is doing and what it is acting on both when starting each file and when finishing

#Sourcing the do-er
source package /nbi/software/testing/bin/fraggenescan-1.30

#Sourcing the thinker
source package /nbi/software/testing/bin/perl-5.22.1

#Make it so
cd $1
desiredfiles=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*$2" -not -name "*$3*" -not -name "*$4*" \))
workingdirectory=$PWD
echo $workingdirectory
for f in $desiredfiles
do
  #Use first command for assembled genomes and/or complete genomic sequences
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the new-fraggenescan.sh script has started running on '$f' now'
  perl /nbi/software/testing/fraggenescan/1.30/src/FragGeneScan1.30/run_FragGeneScan.pl -genome=$f -o=${f%}-fraggenescan-output -complete=1 -train=illumina_5 -thread=8 && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the new-fraggenescan.sh script has finished running on '$f' now'
  #Use second command for short sequence reads
  #mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the new-fraggenescan.sh script has started running on '$f' now'
  #perl /nbi/software/testing/fraggenescan/1.30/src/FragGeneScan1.30/run_FragGeneScan.pl -s $f -o ${f%}-fraggenescan-output -w 0 -t illumina_5 && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the new-fraggenescan.sh script has finished running on '$f' now'
done
