#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 12
#SBATCH --mem=750000
#SBATCH -J Prokka-runs
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package /tgac/software/testing/bin/prokka-1.7.2
#Most contemporary version on the cluster as of 08/10/19

source package /tgac/software/testing/bin/tbl2asn-x_rl
#Working version on the cluster as of 08/10/19

#This should show you all the three directories to be worked on
echo "$1"
echo "+_+_+_+_+_+_+_+_+_+_+"
echo "$2"
echo "+_+_+_+_+_+_+_+_+_+_+"
echo "$3"
echo "+_+_+_+_+_+_+_+_+_+_+"
echo "Those were the user input directories"

#Directory 1 must contain files with the .fa extension
echo "Directory 1 must contain files with the .fa extension"
cd $1
for f in *.fa
do
  prokka $f --outdir prokka-results --force --prefix ${f%}-prokka-results
done
#This should work

#Directory 2 must contain files with the .fa extension
echo "Directory 2 must contain files with the .fasta extension"
cd $2
for f in *.fasta
do
  prokka $f --outdir prokka-results --force --prefix ${f%}-prokka-results
done
#This should work


cd $3
for f in *.fasta
do
  prokka $f --outdir prokka-results --force --prefix ${f%}-prokka-results
done
#This should work
