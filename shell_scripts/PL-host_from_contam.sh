#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 3
#SBATCH --mem=800000
#SBATCH -J PL-host_from_contam
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#This is a trial run making a script to get as much host genome as possible
#from an intestinal faecal sample from an Acomys russatus (in this particular
#case)
#Since it is meant as a proof of concept it uses direct links and other bad
#habits.

#This combined script should do a few things
#It will merge the two read files, remove the host, map the removed against
#the reference
######Potentially it will also use multiple different mapping softwares
#It will also follow an alternative path where by no host is removed from the
#reads but instead will do classification and then you can see about getting
#out anything it classes as eukaryotic and mapping that to the reference

#Sourcing what you need
source package /tgac/software/testing/bin/samtools-1.9
source package /tgac/software/testing/bin/fastp-20190305
source package /tgac/software/testing/bin/minimap2-r922
source package /tgac/software/testing/bin/bbmap-38.06
source package /tgac/software/testing/bin/kraken-2.0.7_beta
source package /tgac/software/testing/bin/centrifuge-1.0.3

cd /ei/scratch/osbourne/host-finding

#Step 0.5, doing all the analysis steps to the raw read files instead of Merging
#them for a change.
echo "Making working copies of raw read files for these stages."
scp DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq DT043-AR34N-in_use-R1.fastq
scp DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq DT043-AR34N-in_use-R2.fastq
echo "Extracting host from raw reads using BBDuk."
srun bbduk.sh -Xmx255g -prealloc in=DT043-AR34N-in_use-R1.fastq ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa outm=DT043-AR34N-in_use-R1-BBDUK-host_matching.fastq out=DT043-AR34N-in_use-R1-BBDUK-host_unmatching.fastq overwrite=t
srun bbduk.sh -Xmx255g -prealloc in=DT043-AR34N-in_use-R2.fastq ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa outm=DT043-AR34N-in_use-R2-BBDUK-host_matching.fastq out=DT043-AR34N-in_use-R2-BBDUK-host_unmatching.fastq overwrite=t
echo "Running BBMap on raw reads against host genome."
srun bbmap.sh -Xmx255g in=DT043-AR34N-in_use-R1.fastq out=DT043-AR34N-in_use-R1-BBMap.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa
srun bbmap.sh -Xmx255g in=DT043-AR34N-in_use-R2.fastq out=DT043-AR34N-in_use-R2-BBMap.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa
echo "Running BBMap on raw reads against human, wheat and other Acomys genome."
srun bbmap.sh -Xmx255g in=DT043-AR34N-in_use-R1.fastq out=DT043-AR34N-in_use-R1-BBMap.sam ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_cah/mAcoCah1.curated_primary.20181127.fa,/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa,/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa
srun bbmap.sh -Xmx255g in=DT043-AR34N-in_use-R2.fastq out=DT043-AR34N-in_use-R2-BBMap.sam ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_cah/mAcoCah1.curated_primary.20181127.fa,/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa,/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa
echo "Running MiniMap2 on raw reads against host genome."
minimap2 -N 0 -a DT043-AR34N-in_use-R1.fastq /hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa > DT043-AR34N-in_use-R1-MiniMap2.sam
minimap2 -N 0 -a DT043-AR34N-in_use-R2.fastq /hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa > DT043-AR34N-in_use-R2-MiniMap2.sam
echo "Running Kraken2 against raw reads to see whether it picks up any eukarotic reads."
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 DT043-AR34N-in_use-R1.fastq --classified-out DT043-AR34N-in_use-R1_kraken-classified-output.out --report DT043-AR34N-in_use-R1_kraken-classified-report.out && mv DT043-AR34N-in_use-R1_kraken-classified-report.out DT043-AR34N-in_use-R1_kraken-classified-report.txt && echo "Kraken 2 has run on DT043-AR34N-in_use-R1.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on DT043-AR34N-in_use-R1.fastq.'
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 DT043-AR34N-in_use-R2.fastq --classified-out DT043-AR34N-in_use-R2_kraken-classified-output.out --report DT043-AR34N-in_use-R2_kraken-classified-report.out && mv DT043-AR34N-in_use-R2_kraken-classified-report.out DT043-AR34N-in_use-R2_kraken-classified-report.txt && echo "Kraken 2 has run on DT043-AR34N-in_use-R2.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on DT043-AR34N-in_use-R2.fastq.'
echo "Running Centrifuge against raw reads to see whether it picks up any eukaryotic reads."
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --host-taxids 10067 --min-hitlen 29 --reorder -s DT043-AR34N-in_use-R1.fastq-centrifuge_solo_scoring.out -S DT043-AR34N-in_use-R1.fastq-centrifuge_solo_scoring-classified.out -U DT043-AR34N-in_use-R1.fastq && mv *.tsv DT043-AR34N-in_use-R1.fastq-centrifuge-report.txt
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --host-taxids 10067 --min-hitlen 29 --reorder -s DT043-AR34N-in_use-R2.fastq-centrifuge_solo_scoring.out -S DT043-AR34N-in_use-R2.fastq-centrifuge_solo_scoring-classified.out -U DT043-AR34N-in_use-R2.fastq && mv *.tsv DT043-AR34N-in_use-R2.fastq-centrifuge-report.txt

#Step 1, go to the place and merge the read files
cd /ei/scratch/osbourne/host-finding
echo "The merging of the two read files will commence."
bbmerge.sh in1=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq in2=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq out=DT043-AR34N-merged.fastq outu=UNMERGED-DT043-AR34N.fastq
echo "Merging of the two read files is complete" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the two AR34N read files have been merged.'

#Note that since the default BBMerge setting only merged 5% or so of the reads
#it might be a good idea to try a less strict setting for the merging
echo "Now carrying out less strict merging using BBMerge, assigning strictness level of loose, vloose, uloose and xloose."
echo "Using 'loose' flag."
bbmerge.sh loose=t in1=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq in2=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq out=DT043-AR34N-merged-BBMerge-loose.fastq outu=UNMERGED-DT043-AR34N-BBMerge-loose.fastq && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the two AR34N read files have been merged using the loose strictness macro.'
echo "Using 'very loose' flag."
bbmerge.sh veryloose=t in1=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq in2=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq out=DT043-AR34N-merged-BBMerge-veryloose.fastq outu=UNMERGED-DT043-AR34N-BBMerge-veryloose.fastq && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the two AR34N read files have been merged using the very loose strictness macro.'
echo "Using 'ultra loose' flag."
bbmerge.sh ultraloose=t in1=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq in2=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq out=DT043-AR34N-merged-BBMerge-ultraloose.fastq outu=UNMERGED-DT043-AR34N-BBMerge-ultraloose.fastq && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the two AR34N read files have been merged using the ultra loose strictness macro.'
echo "Using 'max loose' flag."
bbmerge.sh maxloose=t in1=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq in2=/ei/scratch/osbourne/host-finding/DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq out=DT043-AR34N-merged-BBMerge-maxloose.fastq outu=UNMERGED-DT043-AR34N-BBMerge-maxloose.fastq && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the two AR34N read files have been merged using the max loose strictness macro.'

#Step 2, do QC on the file
echo "The file names you have input to be used are as follows: For the file being QC'ed - '$3' For the file produced of QC'ed reads - '$5' and the two other files "
fastp -i DT043-AR34N-merged.fastq -o DT043-AR34N-merged-QC.fastq -h DT043-AR34N-merged-QC.html -j DT043-AR34N-merged-QC.json
echo "FastP has been run on the merged AR34N read file" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the FastP has been run on the merged AR34N read file.'

#Step 3, first just try mapping the QC'ed file to the host genome
echo "The mapping of the merged read file to the reference genome by Minimap2 will begin."
minimap2 -N 0 -a DT043-AR34N-merged-QC.fastq /hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa > DT043-AR34N-merged-QC-minimap_to_host.sam
echo "Mapping the merged AR34N read file to the reference using Minimap2 is complete." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that merged AR34N read file has been mapped to the reference using Minimap2.'
echo "The mapping of the merged read file to the reference genome by BBMap will begin."
srun bbmap.sh -Xmx255g in=DT043-AR34N-merged-QC.fastq out=DT043-AR34N-merged-QC-BBmap.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa
echo "Mapping the merged AR34N read file to the reference using BBMap is complete" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that merged AR34N read file has been mapped to the reference using BBMap.'
echo "Mapping the max-loose merged read file to the host reference genome using BBMap2."
srun bbmap.sh -Xmx255g in=DT043-AR34N-merged-BBMerge-maxloose.fastq out=DT043-AR34N-merged-BBMerge-maxloose-BBMap.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa
echo "Mapping the max-loose unmerged read file to the host reference genome using BBMap2."
srun bbmap.sh -Xmx255g in=UNMERGED-DT043-AR34N-BBMerge-maxloose.fastq out=UNMERGED-DT043-AR34N-BBMerge-maxloose.fastq-BBmap.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa


#Step 3.5 - running the mapping tools on the stuff which didn't merge out of the two paired end read files
# Also running the raw read files themselves against the host reference
echo "The mapping of the unable to merge reads to the reference genome by Minimap2 will begin."
minimap2 -N 0 -a UNMERGED-DT043-AR34N.fastq /hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa > DT043-AR34N-NOT_merged-QC-minimap_to_host.sam && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the reads unable to merge from DT043-AR34N have been mapped to the reference using MiniMap2.'
echo "Mapping of the unable to merge reads to the reference by MiniMap2 has been completed."
echo "The mapping of the merged read file to the reference genome by BBMap will begin."
srun bbmap.sh -Xmx255g in=UNMERGED-DT043-AR34N.fastq out=DT043-AR34N-NOT_merged-QC-BBmap.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa
echo "Mapping the merged AR34N read file to the reference using BBMap is complete" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the reads unable to merge from DT043-AR34N have been mapped to the reference using BBMap.'

echo "Making a copy of the merged and QC'ed read file for use with BBDuk" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Made a copy of the merged and QCed read file for use with BBDuk.'
scp DT043-AR34N-merged-QC.fastq working_DT043-AR34N-merged-QC.fastq

#Step 4, Removing host only from the merged read files
echo "Now host will be removed from the merged read file using BBDuk, this might be useful later."
srun bbduk.sh -Xmx255g -prealloc in=working_DT043-AR34N-merged-QC.fastq ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa outm=host_matching_bbduk-DT043-AR34N-merged-QC.fastq out=host_removed_bbduk-DT043-AR34N-merged-QC.fastq overwrite=t
echo "Host matching has been completed on working_DT043-AR34N-merged-QC.fast using BBDuk." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Host matching removal using BBDuk has been completed.'

#Step 5, Removing human and other Acomys species matching from merged read files
echo "Now human, wheat and other Acomys species will be removed from the merged read file which has already had the host removed."
srun  bbduk.sh -Xmx255g -prealloc in=host_removed_bbduk-DT043-AR34N-merged-QC.fastq ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_cah/mAcoCah1.curated_primary.20181127.fa,/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa,/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa outm=human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq out=human_wheat_other-acomys_host_removed_bbduk-DT043-AR34N-merged-QC.fastq overwrite=t
echo "Removal of human, wheat and other Acomys species from the already host removed merged read file has been completed." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that merged AR34N read file has had human, wheat and other Acomys contaminants removed.'

#Step 6, running Centrifuge and Kraken2 on the different files. First on the original, then different varieties of host and other genome removed versions along with the 'contaminants' from those removals.
echo "Kraken 2 will run on a number of files."
echo "Running Kraken2 on the first file."
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 DT043-AR34N-merged.fastq --classified-out DT043-AR34N-merged_kraken-classified-output.out --report DT043-AR34N-merged_kraken-classified-report.out && mv DT043-AR34N-merged_kraken-classified-report.out DT043-AR34N-merged_kraken-classified-report.txt && echo "Kraken 2 has run on DT043-AR34N-merged.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on DT043-AR34N-merged.fastq .'
echo "Running Kraken2 on the second file."
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 DT043-AR34N-merged-QC.fastq --classified-out DT043-AR34N-merged-QC.fastq_kraken-classified-output.out --report DT043-AR34N-merged-QC.fastq_kraken-classified-report.out && mv DT043-AR34N-merged-QC.fastq_kraken-classified-report.out DT043-AR34N-merged-QC.fastq_kraken-classified-report.txt && echo "Kraken 2 has run on DT043-AR34N-merged-QC.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on DT043-AR34N-merged-QC.fastq .'
echo "Running Kraken2 on the third file."
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 host_matching_bbduk-DT043-AR34N-merged-QC.fastq --classified-out host_matching_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-output.out --report host_matching_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.out && mv host_matching_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.out host_matching_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.txt && echo "Kraken 2 has run on host_matching_bbduk-DT043-AR34N-merged-QC.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on host_matching_bbduk-DT043-AR34N-merged-QC.fastq .'
echo "Running Kraken2 on the fourth file."
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 host_removed_bbduk-DT043-AR34N-merged-QC.fastq --classified-out host_removed_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-output.out --report host_removed_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.out && mv host_removed_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.out host_removed_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.txt && echo "Kraken 2 has run on host_removed_bbduk-DT043-AR34N-merged-QC.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on host_removed_bbduk-DT043-AR34N-merged-QC.fastq .'
echo "Running Kraken 2 on the fifth file."
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq --classified-out human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-output.out --report human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.out && mv human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.out human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.txt && echo "Kraken 2 has run on human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq .'
echo "Running Kraken 2 on the sixth file."
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 3 human_wheat_other-acomys_host_removed_bbduk-DT043-AR34N-merged-QC.fastq --classified-out human_wheat_other-acomys_host_removed_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-output.out --report human_wheat_other-acomys_host_removed_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.out && mv human_wheat_other-acomys_host_removed_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.out human_wheat_other-acomys_host_removed_bbduk-DT043-AR34N-merged-QC.fastq_kraken-classified-report.txt && echo "Kraken 2 has run on human_wheat_other-acomys_host_removed_bbduk-DT043-AR34N-merged-QC.fastq" && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Kraken 2 ran on human_wheat_other-acomys_host_removed_bbduk-DT043-AR34N-merged-QC.fastq .'

#Step 7, running the mapping software on some of the files produced by BBDuk. Seeing how they map to the host reference genome.
echo "Mapping the human, wheat and other acomys matching extracted material to the host reference using BBMap."
srun bbmap.sh -Xmx255g in=human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq out=human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC-BBMap.sam ref=/hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'Host reference genome mapping has been carried out on human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq.'
echo "Mapping the human, wheat and other acomys matching extracted material to the host reference using MiniMap2."
minimap2 -N 0 -a human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq /hpc-home/osbourne/REFERENCE_GENOMES/mAcoRus1.curated_primary.1811.fa > human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC-MiniMap2.sam && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that human_wheat_other-acomys_host_matching_bbduk-DT043-AR34N-merged-QC.fastq has been mapped to the host reference using MiniMap2.'
