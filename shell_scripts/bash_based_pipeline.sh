#!/bin/bash
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 12
#SBATCH --mem=750000
#SBATCH -J crossing_rhine
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


#####!!!!!!Consider adding some kind of email update at each successful stage completion

#Get the files to the 'lounge' directory in Scratch
#source /hpc-home/osbourne/Scratch/Scratch-scripts/get-raw_subscript_for_execution_by_other_script.sh
#echo "########################### The script to get the raw files has been executed."

#---Step 0.5
##########################################################################
#Making them interleaved fastq files rather than two paired end read files
#####################

#source bbmap-38.06
#!!!! Try and come up with a way to automate this later
#reformat.sh in1=DT032-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863964-E3_R1.fastq	in2=DT032-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863964-E3_R2.fastq	out=DT032-AC16J.fastq
#reformat.sh in1=DT033-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863970-E3_R1.fastq	in2=DT033-MB_GS_FAECAL-SAMPLE-AC16-Acah-3258STDY6863970-E3_R2.fastq	out=DT033-AC16N.fastq
#reformat.sh in1=DT034-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863965-E3_R1.fastq	in2=DT034-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863965-E3_R2.fastq	out=DT034-AC18J.fastq
#reformat.sh in1=DT035-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863971-E3_R1.fastq	in2=DT035-MB_GS_FAECAL-SAMPLE-AC18-Acah-3258STDY6863971-E3_R2.fastq	out=DT035-AC18N.fastq
#reformat.sh in1=DT036-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863966-E3_R1.fastq	in2=DT036-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863966-E3_R2.fastq	out=DT036-AC19J.fastq
#reformat.sh in1=DT037-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863972-E3_R1.fastq	in2=DT037-MB_GS_FAECAL-SAMPLE-AC19-Acah-3258STDY6863972-E3_R2.fastq	out=DT037-AC19N.fastq
#reformat.sh in1=DT038-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863967-E3_R1.fastq	in2=DT038-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863967-E3_R2.fastq	out=DT038-AR27J.fastq
#reformat.sh in1=DT039-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863973-E3_R1.fastq	in2=DT039-MB_GS_FAECAL-SAMPLE-AR27-Arus-3258STDY6863973-E3_R2.fastq	out=DT039-AR27N.fastq
#reformat.sh in1=DT040-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863968-E3_R1.fastq	in2=DT040-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863968-E3_R2.fastq	out=DT040-AR29J.fastq
#reformat.sh in1=DT041-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863974-E3_R1.fastq	in2=DT041-MB_GS_FAECAL-SAMPLE-AR29-Arus-3258STDY6863974-E3_R2.fastq	out=DT041-AR29N.fastq
#reformat.sh in1=DT042-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863969-E3_R1.fastq	in2=DT042-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863969-E3_R2.fastq	out=DT042-AR34J.fastq
#reformat.sh in1=DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R1.fastq	in2=DT043-MB_GS_FAECAL-SAMPLE-AR34-Arus-3258STDY6863975-E3_R2.fastq	out=DT043-AR34N.fastq
#rm *R1.fastq && rm *R2.fastq

#---Step 1
###################################
#Running them through QC with FASTP
###################
#source fastp-20190305

#for f in *.fastq
#do
#fastp -i "$f" -o "${f%}"-qceed.fastq -h ${f%}-qceed.html -j ${f%}-qceed.json && echo "FastP has been run on "$f""
#done
#mkdir fastp-outputs
#mv *{.html,.json} fastp-outputs/


#echo ""########################### The first step, the FastP based QC has been completed."
#############################################################


#---Step 2
##########################################
#Using BBDuk to remove human contamination
###############
#source bbmap-38.06

#ar_qceed=$(find . -maxdepth 1 \( -type f -name "*AR*" -name "*qceed*" \))
#ac_qceed=$(find . -maxdepth 1 \( -type f -name "*AC*" -name "*qceed*" \))

#for f in *.fastq
#	do
#	bbduk.sh -Xmx64g -prealloc -interleaved in=$f ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa \
#	outm=${f%}_contaminated.fastq out=${f%}_human_cleansed.fastq && echo "Human contamination removal on "$f" was successful."
#	done
#for i in "$ar_qceed" ; do srun bbduk.sh -Xmx64g -prealloc -interleaved in=“$i” ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa \
#outm=${i%}_contaminated.fastq out=${i%}_human_cleansed.fastq && echo "########################### Human contamination removal on "$f" was successful."
#done
#for i in "$ac_qceed" ; do srun bbduk.sh -Xmx64g -prealloc -interleaved in=“$i” ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa \
#outm=${i%}_contaminated.fastq out=${i%}_human_cleansed.fastq && echo "########################### Human contamination removal on "$f" was successful."
#done
#rm *contaminated.fastq

#echo "The second step, the BBDuk based human contamination removal has been completed."
#---Step 3
######################################################
#Using BBDuk to remove the relevant host contamination
####################

#ac_human_cleansed=$(find . -maxdepth 1 \( -type f -name "*AC*" -name "*human_cleansed*" \))
#ar_human_cleansed=$(find . -maxdepth 1 \( -type f -name "*AR*" -name "*human_cleansed*" \))

#echo "_____________________"
#echo $ac_human_cleansed
#echo "---------------------"
#echo $ar_human_cleansed

#for i in "$ac_human_cleansed" ; do srun bbduk.sh -Xmx64g -prealloc -interleaved in=“$i” ref=/ei/workarea/group-dt/groupData/Primary_data/Genome/Private/Acomys_cahirinus_mAcoCah1_REL_1905/mAcoCah1_REL_1905.fa outm=${i%}_host_contaminated.fastq out=${i%}_host_cleansed.fastq && echo "########################### Host contaminant removal has been carried out on "$i" successfully." ; done

#for i in "$ar_human_cleansed" ; do srun bbduk.sh -Xmx64g -prealloc -interleaved in=“$i” ref=/ei/workarea/group-dt/groupData/Primary_data/Genome/Private/Acomys_russatus_mAcoRus1_REL_1905/mAcoRus1_REL_1905.fa outm=${i%}_host_contaminated.fastq out=${i%}_host_cleansed.fastq && echo "########################### Host contaminant removal has been carried out on "$i" successfully." ; done

#Spot of tidying up
#mkdir -p AC_host_contaminated_reads
#mkdir -p AR_host_contaminated_reads
#AC_host_contaminated_read_files=$(find . -maxdepth 1 \( -type f -name "*AC*" -name "*host_contaminated*" \))
#AR_host_contaminated_read_files=$(find . -maxdepth 1 \( -type f -name "*AR*" -name "*host_contaminated*" \))

#for f in "$AC_host_contaminated_read_files" ; do mv $f AC_host_contaminated_reads ; done
#for f in "$AR_host_contaminated_read_files" ; do mv $f AR_host_contaminated_reads ; done

#echo "The third step, the BBDuk based host contamination removal has been completed "
#---Step 4
#######################################################
#Running the QC'ed and cleansed files through Metaphlan
################
#Sourcing all the stuff first
#source gcc-5.3.0
#source blast-2.6.0
#source bowtie-2.2.6
#source blast+-2.7.1
#source python-3.5.1
#source python-3.5.1_mb
#source python_anaconda-5.3.0_py3_cs
#source perl-5.16.2
#source bioperl-1.6.1
#source perl_activeperl-5.16.3.1603
#source python-2.7.9
#source biopython-1.60

#cd /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases
#export PATH='pwd':$PATH
#export mpa_dir='pwd'
#cd /hpc-home/osbourne/Scratch/lounge
#source numpy-1.7.0
#source gcc-5.3.0
#source biopython-1.66
#source python-3.5.1
#source python-2.7.9
#source scipy-1.0.0
#source metaphlan-2f1b17a1f4e9

#for f in *_host_cleansed.fastq ; do srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${f%}_metaphlan-output.txt  && echo #"########################### Metaphlan2 analysis of "$f" has been accomplished." ; done
#mkdir metaphlan2-output
#mv *.txt metaphlan2-output/

#echo "########################### The fourth step, the Metaphlan2 analysis of the cleansed files has been completed."

#---Step 5
#####################################################
#Running the QC'ed and cleansed files through Kraken2
###############
#source kraken2-2.0.7
#for f in *_host_cleansed.fastq ; do kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 12 $f --classified-out ${f%}_kraken-classified.out --report ${f%}_kraken-report.out && echo "########################### Kraken2 analysis of "$f" has been completed." ; done
#for f in *kraken-classified.out ; do mv $f ${f%}.txt ; done
#for f in *kraken-report.out ; do mv $f ${f%}.txt ; done
#mkdir kraken-output
#mv *.txt kraken-output/

#echo "########################### The fifth step, the Kraken2 analysis of the cleansed files has been completed."

#---Step 6
#################################################################################################
#Running the QC'ed and cleansed files through Diamond, then 'Meganizing' them for use with MEGAN6
######################

source switch-institute nbi
source blast+-2.7.1
source diamond-0.7.12

ac_host_cleansed2=$(find . -maxdepth 1 \( -type f -name "*AC*" -name "*host_cleansed*" \))
ar_host_cleansed2=$(find . -maxdepth 1 \( -type f -name "*AR*" -name "*host_cleansed*" \))

echo "------------------------------"
echo $ac_host_cleansed2
echo "------------------------------"
echo $ar_host_cleansed2
echo "------------------------------"
###!!!!!This function doesn't seem to be working at the minute
#diamond_blast () {
  #diamond blastx -d /ei/scratch/osbourne/Nr_database/nr -q "$1" -a "${1%}"-diamond-output && echo "########################### The Diamond BLASTX run on "$1" has been completed."
#}
#diamond_blast ac_host_cleansed
#diamond_blast ar_host_cleansed

###!!!!This way isn't working either, since it seems to do this diamond needs the absolute path to the files which is not in the variable at the minute
#for i in "$ac_host_cleansed2" ; do diamond blastx -d /ei/scratch/osbourne/Nr_database/nr -q "$i" -a "${1%}"-diamond-output && echo "########################### The Diamond blastx run on "$i" has been completed." ; done
#for i in "$ar_host_cleansed2" ; do diamond blastx -d /ei/scratch/osbourne/Nr_database/nr -q "$i" -a "${1%}"-diamond-output && echo "########################### The Diamond blastx run on "$i" has been completed." ; done

for f in *_host_cleansed.fastq ; do diamond blastx -d /ei/scratch/osbourne/Nr_database/nr -q $f -a ${f%}-diamond-output.daa && echo "################### The Diamond blastx run on "$f" has been completed." ;done
echo "########################### Diamond based BLASTX has been completed. Starting the Meganizing process"

mkdir -p diamond-output
mv *.daa diamond-output/
cd diamond-output
source switch-institute ei
source MEGAN-6.3.7
for f in *.daa ; do srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa-meganizer -i $f -class -fun KEGG -a2t /hpc-home/osbourne/Scratch/MEGAN-references/prot_acc2tax-Nov2018X1.abin -tn true -a2kegg /hpc-home/osbourne/Scratch/MEGAN-references/acc2kegg-Dec2017X1-ue.abin -v && echo "########################### The 'Meganisation' of "$f" has been completed." ; done

echo "########################### The Meganisation of the Diamond files is complete."
cd /hpc-home/osbourne/Scratch/lounge
#find -maxdepth 1 -type f ! -name "*_host_cleansed*" -exec rm {} +

mkdir megahit-output
source megahit-1.0.2
ac_host_cleansed3=$(find . -maxdepth 1 \( -type f -name "*AC*" -name "*host_cleansed*" \))
ar_host_cleansed3=$(find . -maxdepth 1 \( -type f -name "*AR*" -name "*host_cleansed*" \))
for i in "$ac_host_cleansed3" ; do megahit --12 “$i” -o /hpc-home/osbourne/Scratch/lounge/megahit-output/"${i%}" ; done
for i in "$ac_host_cleansed3" ; do megahit --12 “$i” -o /hpc-home/osbourne/Scratch/lounge/megahit-output/"${i%}" ; done
