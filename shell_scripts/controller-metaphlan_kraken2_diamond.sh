#!/bin/bash
#SBATCH -t 7-23:35
#SBATCH -c 1
#SBATCH --mem=540
#SBATCH -J tax-f42
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package /tgac/software/testing/bin/kraken-2.0.7_beta
source package /tgac/software/testing/bin/centrifuge-1.0.3
source package /tgac/software/testing/bin/metaphlan-2f1b17a1f4e9
source blast+-2.7.1
source diamond-0.9.24
source MEGAN-6.3.7
source package /tgac/software/testing/bin/gcc-5.3.0
source package /tgac/software/testing/bin/gcc-6.2.0


mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "Scripts running Diamond, Metaphlan and Kraken2 will run on fastq files in '$1'"
sbatch worker-metaphlan.sh $1 && sbatch worker-kraken2.sh $1 && sbatch worker-diamond.sh $1
