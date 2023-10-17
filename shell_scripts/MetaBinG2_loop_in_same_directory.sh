#!/bin/bash -e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -p ei-gpu
#SBATCH -J MetaBinG2
#SBATCH --mem=60G
#SBATCH -t 1-00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH --gres=gpu:titan:1

export UPE=$2
export central=$(pwd)
cd $1
source package 207986d3-29f6-4daf-87c1-2fec05b74742
for f in *.fa
do
  runMetaBinG2 -i $f -o ${f%}.out -d /$central/db_micro_euk
  printf "\n Ran on $f \n"
done
touch outList.txt
for f in *.out.stats
do
  echo $f >> outList.txt
done
stats.all.pl outList.txt all.stats p && mail -s "Progress Monitoring 85763000" -a visualization.tar.gz "$UPE" <<< "Attached is the compressed file containing the visualisation output for MetaBinG2 run on all fasta files in: $1"
