#!/bin/bash
#SBATCH -t 21-23:35
#SBATCH -c 1
#SBATCH --mem=540
#SBATCH -J onlydiamond
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source blast+-2.7.1
source diamond-0.9.24
source MEGAN-6.3.7
source package /tgac/software/testing/bin/gcc-5.3.0
source package /tgac/software/testing/bin/gcc-6.2.0

sbatch worker-diamond.sh $1
