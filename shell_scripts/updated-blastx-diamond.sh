#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 0-23:35
#SBATCH -c 12
#SBATCH --mem=750000
#SBATCH -J temp-diamond
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


cd /ei/scratch/osbourne/lounge

source /nbi/software/production/bin/blast+-2.7.1
source package /tgac/software/testing/bin/diamond-0.9.24
source package /tgac/software/testing/bin/MEGAN_Community-6.8.18

for f in *.fastq_human_cleansed.fastq
do
  diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr --sensitive -q $f -o ${f%}-diamond-output -f 100 --salltitles -b 750 -c 1 && echo "±±±±±The Diamond blastx run on $f has been completed."
  mv *.daa /ei/scratch/osbourne/lounge/diamond-output
done

cd /ei/scratch/osbourne/lounge/diamond-output
