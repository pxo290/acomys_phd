#!/bin/bash -e
#SBATCH -p ei-medium
#SBATCH -t 0-05:00
#SBATCH -c 8
#SBATCH --mem=12000
#SBATCH -J prokka-test
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package /tgac/software/testing/bin/tbl2asn-24.9
source package /tgac/software/testing/bin/prokka-1.7.2

cd /ei/scratch/osbourne/software
export PATH='pwd':$PATH
export tbl2asn='pwd'
cd /ei/software/testing/tbl2asn/24.9/x86_64/bin
export PATH=$PATH:/ei/software/testing/tbl2asn/24.9/x86_64/bin/tbl2asn
export PATH='pwd':$PATH
cd /hpc-home/osbourne

prokka $1 --outdir Prokka-result --force --prefix ${1%}- link --overwrite tbl2asn
