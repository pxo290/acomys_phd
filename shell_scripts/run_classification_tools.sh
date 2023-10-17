#!/bin/bash
#SBATCH -p ei-largemem
#SBATCH -t 3-23:35
#SBATCH -c 2
#SBATCH --mem=650000
#SBATCH -J taxonomic_classifiers
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Sourcing in the attic
source package /tgac/software/testing/bin/kraken-2.0.7_beta
source package /tgac/software/testing/bin/centrifuge-1.0.3
source package /tgac/software/testing/bin/metaphlan-2f1b17a1f4e9
source blast+-2.7.1
source diamond-0.9.24
source MEGAN-6.3.7
source package /tgac/software/testing/bin/gcc-5.3.0
source package /tgac/software/testing/bin/gcc-6.2.0


#Taking the stairs to our destination
cd $1

#Make our groups to work on
subsampledacocahfiles=$(find . -maxdepth 1 \( -type f -name "AC*" -name "*_qceed*" -name "*subsampled-75pc-5000000-bases.fastq" -not -name "AR*" -not -name "*normalised*" \))
subsampledacorusfiles=$(find . -maxdepth 1 \( -type f -name "AR*" -name "*_qceed*" -name "*subsampled-75pc-5000000-bases.fastq" -not -name "AC*" -not -name "*normalised*" \))
normalisedacocahfiles=$(find . -maxdepth 1 \( -type f -name "AC*" -name "*_qceed*" -name "*normalised*" -not -name "AR*" -not -name "*subsampled-75pc-5000000-bases.fastq" \))
normalisedacorusfiles=$(find . -maxdepth 1 \( -type f -name "AR*" -name "*_qceed*" -name "*normalised*" -not -name "AC*" -not -name "*subsampled-75pc-5000000-bases.fastq" \))

Metaphlan first
for f in $subsampledacocahfiles
do
  echo "Running Metaphlan2 on '$f'"
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${f%}_metaphlan-output.txt && echo "Metaphlan2 analysis of '$f' has been accomplished." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that Metaphlan2 has run on '$f'"
  echo "Ran Metaphlan2 on '$f'"
done
for f in $subsampledacorusfiles
do
  echo "Running Metaphlan2 on '$f'"
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${f%}_metaphlan-output.txt && echo "Metaphlan2 analysis of '$f' has been accomplished." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that Metaphlan2 has run on '$f'"
  echo "Ran Metaphlan2 on '$f'"
done
for f in $normalisedacocahfiles
do
  echo "Running Metaphlan2 on '$f'"
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${f%}_metaphlan-output.txt && echo "Metaphlan2 analysis of '$f' has been accomplished." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that Metaphlan2 has run on '$f'"
  echo "Ran Metaphlan2 on '$f'"
done
for f in $normalisedacorusfiles
do
  echo "Running Metaphlan2 on '$f'"
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${f%}_metaphlan-output.txt && echo "Metaphlan2 analysis of '$f' has been accomplished." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that Metaphlan2 has run on '$f'"
  echo "Ran Metaphlan2 on '$f'"
done
mkdir -p Metaphlan2_outputs

#Now Kraken2
mkdir -p Kraken_outputs
for f in $subsampledacocahfiles
do
  echo "Running Kraken2 on '$f'"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 "$f" --classified-out ${f%}_kraken-classified.out --report ${f%}_kraken-report.out > ${f%}_kraken_output.txt \
  echo "Kraken2 analysis of '$f' has been completed."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Kraken2 has run on '$f'.'
done
for f in $subsampledacorusfiles
do
  echo "Running Kraken2 on '$f'"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 "$f" --classified-out ${f%}_kraken-classified.out --report ${f%}_kraken-report.out > ${f%}_kraken_output.txt \
  echo "Kraken2 analysis of '$f' has been completed."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Kraken2 has run on '$f'.'
done
for f in $normalisedacocahfiles
do
  echo "Running Kraken2 on '$f'"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 "$f" --classified-out ${f%}_kraken-classified.out --report ${f%}_kraken-report.out > ${f%}_kraken_output.txt \
  echo "Kraken2 analysis of '$f' has been completed."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Kraken2 has run on '$f'.'
done
for f in $normalisedacorusfiles
do
  echo "Running Kraken2 on '$f'"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 "$f" --classified-out ${f%}_kraken-classified.out --report ${f%}_kraken-report.out > ${f%}_kraken_output.txt \
  echo "Kraken2 analysis of '$f' has been completed."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Kraken2 has run on '$f'.'
done

#Now Diamond and Megan
for f in $subsampledacocahfiles
do
  echo "Running Diamond on '$f'"
  diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $f -a ${f%}-diamond-output.daa
  echo "Diamond ran on '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Diamond has run on '$f'.'
done
for f in $subsampledacorusfiles
do
  echo "Running Diamond on '$f'"
  diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $f -a ${f%}-diamond-output.daa
  echo "Diamond ran on '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Diamond has run on '$f'.'
done
for f in $normalisedacocahfiles
do
  echo "Running Diamond on '$f'"
  diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $f -a ${f%}-diamond-output.daa
  echo "Diamond ran on '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Diamond has run on '$f'.'
done
for f in $normalisedacorusfiles
do
  echo "Running Diamond on '$f'"
  diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $f -a ${f%}-diamond-output.daa
  echo "Diamond ran on '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Diamond has run on '$f'.'
done

#Also need to make a group and then run on the original files so you can compare
#the differences
originalfiles=$(find . -maxdepth 1 \( -type f -name "*.fastq_qceed.fastq" -not -name "*normalised*" -not -name "*subsampled*")
##Metaphlan
for f in $originalfiles
do
  echo "Running Metaphlan2 on '$f'"
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${f%}_metaphlan-output.txt && echo "Metaphlan2 analysis of '$f' has been accomplished." && mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that Metaphlan2 has run on '$f'"
  echo "Ran Metaphlan2 on '$f'"
done
##Kraken2
for f in $originalfiles
do
  echo "Running Kraken2 on '$f'"
  kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 "$f" --classified-out ${f%}_kraken-classified.out --report ${f%}_kraken-report.out > ${f%}_kraken_output.txt \
  echo "Kraken2 analysis of '$f' has been completed."
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Kraken2 has run on '$f'.'
done
##Diamond
for f in $originalfiles
do
  echo "Running Diamond on '$f'"
  diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $f -a ${f%}-diamond-output.daa
  echo "Diamond ran on '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Diamond has run on '$f'.'
done

##Need to make a group for the diamond outputs
diamondoutputs=$(find . -maxdepth 1 \( -type f -name "*diamond-output.daa" \))
for f in $diamondoutputs
do
  echo "MEGAN will run on '$f'"
  srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa-meganizer -i $f -class -fun KEGG -a2t /hpc-home/osbourne/Scratch/MEGAN-references/prot_acc2tax-Nov2018X1.abin -tn true -a2kegg /hpc-home/osbourne/Scratch/MEGAN-references/acc2kegg-Dec2017X1-ue.abin -v -o ${f%}-meganized.daa
  echo "MEGAN will run on '$f'"
  mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that MEGAN has run on '$f'.'
done
