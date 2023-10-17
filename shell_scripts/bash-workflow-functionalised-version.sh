#!/bin/bash
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Presume that the loop in the controlling script is working to send you into each directory so
#just need to get the actual files themselves

#Do all the different steps as functions, then have two ultimate functions which
#combine them and finally have the main function actually run on
#the choice results from the testing of the above find variables storing
#anything or not

#Function 1, fastp based QC
function fasta_fastp_do() {
  source fastp-20190305
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the QC steps."
  for i in $raw_input_fasta_files
  do
    echo "This is what this stage will work on: "$i""
    fastp -i "$i" -o ${i%}_qceed.fa -h ${i%}_qceed.html -j ${i%}.json && echo "<><><><><><><><><><><>FastP has been run on $i"
    mkdir -p fastp-outputs
    mv -- *{.html,.json} fastp-outputs/
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The first step, the QC with fastp has concluded one way or another"
}

qceed_files=$(fasta_fastp_do)

function fastq_fastp_do() {
  source fastp-20190305
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the QC steps."
  for i in $raw_input_fasta_files
  do
    echo "This is what this stage will work on: "$i""
    fastp -i "$i" -o ${i%}_qceed.fq -h ${i%}_qceed.html -j ${i%}.json && echo "<><><><><><><><><><><>FastP has been run on $i"
    mkdir -p fastp-outputs
    mv -- *{.html,.json} fastp-outputs/
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The first step, the QC with fastp has concluded one way or another"
}

#Function 2, bbduk to remove human contamination
function fasta_human_cleanse_do() {
  source bbmap-38.06
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the second step, removing human contamination."
  QCeed_files=$(find . -maxdepth 1 \( -type f -name "*_qceed.fa" \))
  echo "----------------"
  echo "This is what you will be working on: "
  echo $QCeed_files
  echo "________________"
  for i in $QCeed_files
  do
    echo "This is what this stage will work on: "$i""
    srun bbduk.sh -Xmx128g -prealloc in="$i" ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa \
    outm=${i%}_contaminated.out out=${i%}_human_cleansed.fa && echo "<><><><><><><><><><><>Human contamination removal on $i was successful." \
    && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that work on "$i" has been executed.'
    mkdir -p human_contaminated
    for f in -- *.out
    do
      mv $f human_contaminated/${f%}.out
    done
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The second step, the human contaminant removal with BBDuk has concluded one way or another"
}

function fastq_human_cleanse_do() {
  source bbmap-38.06
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the second step, removing human contamination."
  QCeed_files=$(find . -maxdepth 1 \( -type f -name "*_qceed.fq" \))
  echo "----------------"
  echo "This is what you will be working on: "
  echo $QCeed_files
  echo "________________"
  for i in $QCeed_files
  do
    echo "This is what this stage will work on: "$i""
    srun bbduk.sh -Xmx128g -prealloc in="$i" ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa \
    outm=${i%}_contaminated.out out=${i%}_human_cleansed.fq && echo "<><><><><><><><><><><>Human contamination removal on $i was successful." \
    && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that work on "$i" has been executed.'
    mkdir -p human_contaminated
    for f in -- *.out
    do
      mv $f human_contaminated/${f%}.out
    done
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The second step, the human contaminant removal with BBDuk has concluded one way or another"
}

#Function 3 - running through metaphlan2 on the files
function fasta_metaphlan2_do() {
  human_cleansed_files=$(find . -maxdepth 1 \( -type f -name "*_human_cleansed.fa" \))
  echo "--------------------"
  echo $human_cleansed_files
  echo "--------------------"
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the Metaphlan2 run on the files."
  source gcc-5.3.0
  source blast-2.6.0
  source bowtie-2.2.6
  source blast+-2.7.1
  source python-3.5.1
  source python-3.5.1_mb
  source python_anaconda-5.3.0_py3_cs
  source bioperl-1.6.1
  source perl_activeperl-5.16.3.1603
  source python-2.7.9
  source numpy-1.7.0
  source biopython-1.66
  source scipy-1.0.0
  cd /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases
  export PATH='pwd':$PATH
  export mpa_dir='pwd'
  cd "$OLDPWD"
  source metaphlan-2f1b17a1f4e9
  mkdir metaphlan2-output
  for i in $human_cleansed_files
  do
    echo "This is what this stage will work on: "$i""
    srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $i --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fasta > ${i%}_metaphlan-output.txt && echo "<><><><><><><><><><><> Metaphlan2 analysis of $i has been accomplished." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that work on '$i' has been executed.'
    mkdir -p metaphlan2-output
    for f in -- *.txt
    do
      mv $f metaphlan2-output/
    done
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The third step, the Metaphlan2 taxonomic analysis has concluded one way or another."
}

function fastq_metaphlan2_do() {
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the Metaphlan2 run on the files."
  source gcc-5.3.0
  source blast-2.6.0
  source bowtie-2.2.6
  source blast+-2.7.1
  source python-3.5.1
  source python-3.5.1_mb
  source python_anaconda-5.3.0_py3_cs
  source bioperl-1.6.1
  source perl_activeperl-5.16.3.1603
  source python-2.7.9
  source numpy-1.7.0
  source biopython-1.66
  source scipy-1.0.0
  cd /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases
  export PATH='pwd':$PATH
  export mpa_dir='pwd'
  cd "$OLDPWD"
  source metaphlan-2f1b17a1f4e9
  mkdir metaphlan2-output
  for i in $human_cleansed_files
  do
    echo "This is what this stage will work on: "$i""
    srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $i --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${i%}_metaphlan-output.txt && echo "<><><><><><><><><><><> Metaphlan2 analysis of $i has been accomplished." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that work on '$i' has been executed.'
    mkdir -p metaphlan2-output
    for f in -- *.txt
    do
      mv $f metaphlan2-output/
    done
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The third step, the Metaphlan2 taxonomic analysis has concluded one way or another."
}

#Function 4, the kraken2 run on the files
function fasta_kraken2_do() {
  source kraken2-2.0.7
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the Kraken2 run on the files."
  for i in $human_cleansed_files
  do
    echo "This is what this stage will work on: "$i""
    kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 6 $i --classified-out ${i%}_kraken-classified.out --report ${i%}_kraken-report.out \
    && echo "<><><><><><><><><><><>Kraken2 analysis of '$i' has been completed." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that work on '$i' has been executed.'
    mkdir -p kraken2-output
    kraken2output=$(find . -maxdepth 1 \(type f -name "*kraken*" -name "*.out" \))
    for i in $kraken2output
    do
      mv $i kraken2-output/
    done
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The fourth step, the Kraken2 taxonomic analysis has concluded one way or another."
}

function fastq_kraken2_do() {
  source kraken2-2.0.7
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the Kraken2 run on the files."
  for i in $human_cleansed_files
  do
    echo "This is what this stage will work on: "$i""
    kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 6 $i --classified-out ${i%}_kraken-classified.out --report ${i%}_kraken-report.out \
    && echo "<><><><><><><><><><><>Kraken2 analysis of '$i' has been completed." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that work on '$i' has been executed.'
    mkdir -p kraken2-output
    kraken2output=$(find . -maxdepth 1 \(type f -name "*kraken*" -name "*.out" \))
    for i in $kraken2output
    do
      mv $i kraken2-output/
    done
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The fourth step, the Kraken2 taxonomic analysis has concluded one way or another."
}

#Function 5, Diamond and Megan work on the files
function fasta_diamond_and_megan_do() {
  source switch-institute nbi
  source blast+-2.7.1
  source diamond-0.7.12
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the diamond blastx analysis of the files"
  for f in -- *_human_cleansed.fa
  do
    echo "This is what this stage will work on: "$f""
    diamond blastx -d /ei/scratch/osbourne/Nr_database/nr -q $f -a ${f%}-diamond-output.daa && echo \
    "<><><><><><><><><><><>The Diamond blastx run on $f has been completed." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that work on '$f' has been executed.'
    mkdir -p diamond-output
    for f in -- *.daa
    do
      echo "This is what this stage, the meganising stage, will work on: "$f""
      source switch-institute ei
      source MEGAN-6.3.7
      srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa-meganizer -i $f -class -fun KEGG -a2t /hpc-home/osbourne/Scratch/MEGAN-references/prot_acc2tax-Nov2018X1.abin -tn true -a2kegg /hpc-home/osbourne/Scratch/MEGAN-references/acc2kegg-Dec2017X1-ue.abin -v \
      && echo "<><><><><><><><><><><>The 'Meganisation' of $f has been completed."
    done
    for f in -- *.daa
    do
      mv $f diamond-output/
    done
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The fifth step, the diamond blastx scan and then meganization has concluded one way or another."
}

function fastq_diamond_and_megan_do() {
  source switch-institute nbi
  source blast+-2.7.1
  source diamond-0.7.12
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the diamond blastx analysis of the files"
  for f in -- *_human_cleansed.fq
  do
    echo "This is what this stage will work on: "$f""
    diamond blastx -d /ei/scratch/osbourne/Nr_database/nr -q $f -a ${f%}-diamond-output.daa && echo \
    "<><><><><><><><><><><>The Diamond blastx run on $f has been completed." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that work on '$f' has been executed.'
    mkdir -p diamond-output
    for f in -- *.daa
    do
      echo "This is what this stage, the meganising stage, will work on: "$f""
      source switch-institute ei
      source MEGAN-6.3.7
      srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa-meganizer -i $f -class -fun KEGG -a2t /hpc-home/osbourne/Scratch/MEGAN-references/prot_acc2tax-Nov2018X1.abin -tn true -a2kegg /hpc-home/osbourne/Scratch/MEGAN-references/acc2kegg-Dec2017X1-ue.abin -v \
      && echo "<><><><><><><><><><><>The 'Meganisation' of $f has been completed."
    done
    for f in -- *.daa
    do
      mv $f diamond-output/
    done
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The fifth step, the diamond blastx scan and then meganization has concluded one way or another."
}

#Function 6, megahit run on the files
function fasta_megahit_do() {
  source switch-institute ei
  source megahit-1.0.2
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the Megahit assembly of the files."
  for f in -- *_human_cleansed.fa
  do
    echo "This is what this stage will work on: "$f""
    mkdir -p megahit-outputs
    megahit --6 $f -o $PWD/megahit-outputs/${f%}-megahitted && echo \
    "<><><><><><><><><><><>The megahit assembly of $f has been completed."
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The sixth step, the megahit assembly of the cleansed reads, has concluded one way or another."
}

function fastq_megahit_do() {
  source switch-institute ei
  source megahit-1.0.2
  echo "|\/\/\/\/\/\/\/\/\/\/\|Starting the Megahit assembly of the files."
  for f in -- *_human_cleansed.fq
  do
    echo "This is what this stage will work on: "$f""
    mkdir -p megahit-outputs
    megahit --6 $f -o $PWD/megahit-outputs/${f%}-megahitted && echo \
    "<><><><><><><><><><><>The megahit assembly of $f has been completed."
  done
  echo "|\/\/\/\/\/\/\/\/\/\/\|The sixth step, the megahit assembly of the cleansed reads, has concluded one way or another."
}

#Ultimate functions
function fasta_workflow_do() {
  fasta_fastp_do $raw_input_fasta_files
  fasta_human_cleanse_do $QCeed_files
  fasta_metaphlan2_do $human_cleansed_files
  fasta_kraken2_do $human_cleansed_files
  fasta_diamond_and_megan_do $human_cleansed_files
  fasta_megahit_do $human_cleansed_files
}

function fastq_worfklow_do() {
  fastq_fastp_do $raw_input_fastq_files
  fastq_human_cleanse_do $QCeed_files
  fastq_metaphlan2_do $human_cleansed_files
  fastq_kraken2_do $human_cleansed_files
  fastq_diamond_and_megan_do $human_cleansed_files
  fastq_megahit_do $human_cleansed_files
}

#Main function and the test to decide which path to take
function get_to_work() {
  echo "|\/\/\/\/\/\/\/\/\/\/\| Starting the file distinguishing step."
  raw_input_fasta_files=$(find . -maxdepth 1 \( -type f -name "*.fa" -o -name "*.fasta" -o -name "*.fna" \))
  raw_input_fastq_files=$(find . -maxdepth 1 \( -type f -name "*.fastq" -o -name "*.fq" \))
  if [ -z "$raw_input_fasta_files" ]
  then
    echo "<><><><><><><><><><><>There are no fasta files."
  else
    echo "<><><><><><><><><><><>These are the files which will be worked on, "$raw_input_fasta_files""
    fasta_workflow_do
  fi
  if [ -z "$raw_input_fastq_files" ]
  then
    echo "<><><><><><><><><><><>There are no fastq files."
  else
    echo "<><><><><><><><><><><>These are the files which will be worked on, "$raw_input_fastq_files""
    fastq_workflow_do
  fi
}

get_to_work $raw_input_directories
