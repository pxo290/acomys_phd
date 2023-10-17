#!/bin/bash -e
#SBATCH -t 0-15:35
#SBATCH -c 2
#SBATCH --mem=64000
#SBATCH -J Prokka-solo
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


source package /tgac/software/testing/bin/prokka-1.7.2
#Most contemporary version on the cluster as of 08/10/19

source package /tgac/software/testing/bin/tbl2asn-x_rl
#Working version on the cluster as of 08/10/19

echo "The file you are working on is printed below"
echo $1
echo "The file you are working on is printed above"

prokka $1 --outdir prokka-results --force --prefix ${1%}-prokka-results
