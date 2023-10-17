#!/bin/bash
#SBATCH -p ei-largemem
#SBATCH -t 2-23:59
#SBATCH -c 2
#SBATCH --mem=850000
#SBATCH -J diamond_megan
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

source package /tgac/software/production/bin/blast+-2.7.1
source package /tgac/software/testing/bin/diamond-0.9.24
source package /tgac/software/testing/bin/MEGAN-6.3.7
cd $1
cleansed_files=$(find . -maxdepth 1 \( -type f -name "*_all_cleansed.fastq" -not -name "*contaminated*" -not -name "*qceed*" -not -name "*.txt" -not -name "*metaphlan*" -not -name "*kraken*" \))
echo "Starting the diamond blastx analysis of the files"
for f in $cleansed_files
do
  echo "This is what this stage will work on: "$f""
  diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $f -a ${f%}-diamond-output.daa && echo \
  "The Diamond blastx run on $f has been completed."
  mkdir -p diamond-output
done &&
diamond_output=$(find . -maxdepth 1 \( -type f -name "*.daa" \))
for f in $diamond_output
 do
   echo "This is what this stage, the meganising stage, will work on: "$f""
   srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa-meganizer -i $f -class -fun KEGG -a2t /hpc-home/osbourne/Scratch/MEGAN-references/prot_acc2tax-Nov2018X1.abin -tn true -a2kegg /hpc-home/osbourne/Scratch/MEGAN-references/acc2kegg-Dec2017X1-ue.abin -v -o ${f%}-meganized \
   && echo "The 'Meganisation' of $f has been completed."
   for f in *.daa
   do
     #You need to work out a way of turning the meganised .daa file into an rma file so it can actually be loaded locally in reasonable time
     srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa2rma -i $f
     mv $f diamond-output/
   done
done
