#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 12
#SBATCH --mem=750000
#SBATCH -J unpaired_scripted
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

cd $1
echo "You are working in the following overarching directory: ""$1"
raw_input_directories=$(find . -maxdepth 1 \( -type d -name "*SINGLE*" \))
export raw_input_directories
echo "_+_+_+_These are the directories to be worked on "$raw_input_directories""
source fastp-20190305
source bbmap-38.06
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
cd $1
export raw_input_directories
source numpy-1.7.0
source gcc-5.3.0
source biopython-1.66
source python-3.5.1
source python-2.7.9
source scipy-1.0.0
source metaphlan-2f1b17a1f4e9
source kraken2-2.0.7
source megahit-1.0.2
source blast+-2.7.1
source diamond-0.9.24
source MEGAN-6.3.7

for d in $raw_input_directories
do
  cd "$d"
  echo "_+_+_+_Starting the file distinguishing step."
  raw_input_fasta_files=$(find . -maxdepth 1 \( -type f -name "*.fa" -o -name "*.fasta" -o -name "*.fna" \))
  raw_input_fastq_files=$(find . -maxdepth 1 \( -type f -name "*.fastq" -o -name "*.fq" \))
  export raw_input_fasta_files
  export raw_input_fastq_files
  if [ -z "$raw_input_fasta_files" ]; then
    echo "_+_+_+_These are the relevant files to work on, "$raw_input_fastq_files""
    export raw_input_fastq_files
    source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_1.sh
    echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
    source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_2.sh
    echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
    source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_3.sh
    echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
    source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_4.sh
    echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
    source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_5.sh
    echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
    source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_6.sh
    echo "++++++++++++++++++FASTQ SCRIPTS ENDED++++++++++++++++++++++++++"
    cd "$d"
  elif [ -z "$raw_input_fastq_files" ]; then
    echo "_+_+_+_These are the relevant files to work on, "$raw_input_fasta_files""
    export raw_input_fasta_files
    source /hpc-home/osbourne/quick-test-of-scripts/single-fasta-script_2.sh
    echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
    source /hpc-home/osbourne/quick-test-of-scripts/single-fasta-script_3.sh
    echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
    source /hpc-home/osbourne/quick-test-of-scripts/single-fasta-script_4.sh
    echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
    source /hpc-home/osbourne/quick-test-of-scripts/single-fasta-script_5.sh
    echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
    source /hpc-home/osbourne/quick-test-of-scripts/single-fasta-script_6.sh
    echo "++++++++++++++++++FASTA SCRIPTS ENDED++++++++++++++++++++++++++"
    cd "$d"
  fi
  cd ..
done
