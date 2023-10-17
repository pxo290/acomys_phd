#!/bin/bash
#SBATCH -t 0-15:35
#SBATCH -c 1
#SBATCH --mem=24000
#SBATCH -J unzipper
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

cd $1

echo "This script will to directory '$1' and unzip files it finds there."
for f in *.gz
do
  gunzip $f
  echo "Files have been unzipped"
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'File unzipping has been carried out in '$1' on '$f' now'
done
