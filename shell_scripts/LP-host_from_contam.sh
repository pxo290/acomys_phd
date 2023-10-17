#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 3
#SBATCH --mem=800000
#SBATCH -J PL-host_from_contam
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Since merging the reads doesn't really work it is now necessary to actually use
#the individual paired read files

#First thing is to source all the software you will be using up here
source package /tgac/software/testing/bin/samtools-1.9
source package /tgac/software/testing/bin/fastp-20190305
source package /tgac/software/testing/bin/minimap2-r922
source package /tgac/software/testing/bin/bbmap-38.06
source package /tgac/software/testing/bin/kraken-2.0.7_beta
source package /tgac/software/testing/bin/centrifuge-1.0.3

#Going to the directory
cd /ei/scratch/osbourne/host-finding

#Making some safe working copies
echo "Making working copies of raw read files for these stages."
scp DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq DT043-AR34N-in_use-R1.fastq
scp DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq DT043-AR34N-in_use-R2.fastq

#Now running fastp on the raw read files
for f in *in_use*
do
  fastp -i $f -o ${f%}-qced.fastq -h ${f%}-qced.html -j ${f%}-qced.json && echo "FastP has run on '$f' just so you know." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "FastP has run on '$f' just so you know."
done

#Now for some work with the safe copies
echo "Extracting host from raw reads using BBDuk."
srun bbduk.sh -Xmx255g -prealloc in=DT043-AR34N-in_use-R1.fastq-qced.fastq ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa outm=DT043-AR34N-in_use-R1-BBDUK-host_matching.fastq out=DT043-AR34N-in_use-R1-BBDUK-host_unmatching.fastq overwrite=t
srun bbduk.sh -Xmx255g -prealloc in=DT043-AR34N-in_use-R2.fastq-qced.fastq ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa outm=DT043-AR34N-in_use-R2-BBDUK-host_matching.fastq out=DT043-AR34N-in_use-R2-BBDUK-host_unmatching.fastq overwrite=t
echo "Running BBMap on raw reads against host genome."
srun bbmap.sh -Xmx255g in=DT043-AR34N-in_use-R1.fastq-qced.fastq out=DT043-AR34N-in_use-R1-BBMap.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa
srun bbmap.sh -Xmx255g in=DT043-AR34N-in_use-R2.fastq-qced.fastq out=DT043-AR34N-in_use-R2-BBMap.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa
echo "Running BBMap on raw reads against human, wheat and other Acomys genome."
srun bbmap.sh -Xmx255g in=DT043-AR34N-in_use-R1.fastq-qced.fastq out=DT043-AR34N-in_use-R1-BBMap.sam ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_cah/mAcoCah1.curated_primary.20181127.fa,/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa,/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa
srun bbmap.sh -Xmx255g in=DT043-AR34N-in_use-R2.fastq-qced.fastq out=DT043-AR34N-in_use-R2-BBMap.sam ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_cah/mAcoCah1.curated_primary.20181127.fa,/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa,/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa
echo "Running MiniMap2 on raw reads against host genome."
minimap2 -N 0 -a DT043-AR34N-in_use-R1.fastq-qced.fastq /hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa > DT043-AR34N-in_use-R1-MiniMap2.sam
minimap2 -N 0 -a DT043-AR34N-in_use-R2.fastq-qced.fastq /hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa > DT043-AR34N-in_use-R2-MiniMap2.sam
echo "Running Kraken2 against raw reads to see whether it picks up any eukarotic reads."
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 DT043-AR34N-in_use-R1.fastq-qced.fastq --classified-out DT043-AR34N-in_use-R1_kraken-classified-output.out --report DT043-AR34N-in_use-R1_kraken-classified-report.out && mv DT043-AR34N-in_use-R1_kraken-classified-report.out DT043-AR34N-in_use-R1_kraken-classified-report.txt && echo "Kraken 2 has run on DT043-AR34N-in_use-R1.fastq-qced.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on DT043-AR34N-in_use-R1.fastq-qced.fastq.'
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 DT043-AR34N-in_use-R2.fastq-qced.fastq --classified-out DT043-AR34N-in_use-R2_kraken-classified-output.out --report DT043-AR34N-in_use-R2_kraken-classified-report.out && mv DT043-AR34N-in_use-R2_kraken-classified-report.out DT043-AR34N-in_use-R2_kraken-classified-report.txt && echo "Kraken 2 has run on DT043-AR34N-in_use-R2.fastq-qced.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on DT043-AR34N-in_use-R2.fastq-qced.fastq.'
echo "Running Centrifuge against raw reads to see whether it picks up any eukaryotic reads."
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --host-taxids 10067 --min-hitlen 29 --reorder -s DT043-AR34N-in_use-R1.fastq-qced.fastq-centrifuge_solo_scoring.out -S DT043-AR34N-in_use-R1.fastq-qced.fastq-centrifuge_solo_scoring-classified.out -U DT043-AR34N-in_use-R1.fastq-qced.fastq && mv *.tsv DT043-AR34N-in_use-R1.fastq-qced.fastq-centrifuge-report.txt
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --host-taxids 10067 --min-hitlen 29 --reorder -s DT043-AR34N-in_use-R2.fastq-qced.fastq-centrifuge_solo_scoring.out -S DT043-AR34N-in_use-R2.fastq-qced.fastq-centrifuge_solo_scoring-classified.out -U DT043-AR34N-in_use-R2.fastq-qced.fastq && mv *.tsv DT043-AR34N-in_use-R2.fastq-qced.fastq-centrifuge-report.txt
