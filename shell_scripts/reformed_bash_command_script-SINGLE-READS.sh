#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 0-23:35
#SBATCH -c 12
#SBATCH --mem=750000
#SBATCH -J ref-unpaired_works
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

echo "++++++++STARTING REFORMED BASH SINGLE READ COMMAND SCRIPT++++++++"
echo "You will be working on directories within: "$1""
cd $1
raw_input_directories=$(find . -maxdepth 1 \( -type d -name "*SINGLE*" \))
export raw_input_directories
echo "These are the directories to be worked on: "$raw_input_directories""
echo "Sourcing software to be used by process scripts"
source fastp-20190305 && echo "±±±±± Sourced fastp-20190305"
source bbmap-38.06 && echo "±±±±± Sourced bbmap-38.06"
source gcc-5.3.0 && echo "±±±±± Sourced gcc-5.3.0"
source blast-2.6.0 && echo "±±±±± Sourced blast-2.6.0"
source bowtie-2.2.6 && echo "±±±±± Sourced bowtie-2.2.6"
source blast+-2.7.1 && echo "±±±±± Sourced blast+-2.7.1"
source python-3.5.1 && echo "±±±±± Sourced python-3.5.1"
source python-3.5.1_mb && echo "±±±±± Sourced python-3.5.1_mb"
source python_anaconda-5.3.0_py3_cs && echo "±±±±± Sourced python_anaconda-5.3.0_py3_cs"
source bioperl-1.6.1 && echo "±±±±± Sourced bioperl-1.6.1"
source perl_activeperl-5.16.3.1603 && echo "±±±±± Sourced perl_activeperl-5.16.3.1603"
source python-2.7.9 && echo "±±±±± Sourced python-2.7.9"
source numpy-1.7.0 && echo "±±±±± Sourced numpy-1.7.0"
source biopython-1.66 && echo "±±±±± Sourced biopython-1.66"
source scipy-1.0.0 && echo "±±±±± Sourced scipy-1.0.0"
cd /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases
export PATH='pwd':$PATH
export mpa_dir='pwd'
cd $1
source numpy-1.7.0 && echo "±±±±± Sourced numpy-1.7.0"
source gcc-5.3.0 && echo "±±±±± Sourced gcc-5.3.0"
source biopython-1.66 && echo "±±±±± Sourced biopython-1.66"
source python-3.5.1 && echo "±±±±± Sourced python-3.5.1"
source python-2.7.9 && echo "±±±±± Sourced python-2.7.9"
source scipy-1.0.0 && echo "±±±±± Sourced scipy-1.0.0"
source metaphlan-2f1b17a1f4e9 && echo "±±±±± Sourced metaphlan-2f1b17a1f4e9"
source kraken2-2.0.7 && echo "±±±±± Sourced kraken2-2.0.7"
source blast+-2.7.1 && echo "±±±±± Sourced blast+-2.7.1"

for d in $raw_input_directories
do
  cd "$d"
  echo "±±±±±Starting the file distinguishing step."
  raw_input_fasta_files=$(find . -maxdepth 1 \( -type f -name "*.fa" -o -name "*.fasta" -o -name "*.fna" \))
  raw_input_fastq_files=$(find . -maxdepth 1 \( -type f -name "*.fastq" -o -name "*.fq" \))
  export raw_input_fasta_files
  export raw_input_fastq_files
  if [ -z "$raw_input_fasta_files" ] ; then
     echo "±±±±±These are the relevant files to work on, "$raw_input_fastq_files""
     export raw_input_fastq_files
     #echo "++++++++++++++++STARTING THE FASTQ SCRIPTS+++++++++++++++++++++++"
     #source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_1.sh
     #echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
     #source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_2.sh
     #echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
     #source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_3.sh
     #echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
     #source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_4.sh
     #echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
     source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_5.sh
     echo "++++++++++++++++++BREAK BETWEEN SCRIPTS+++++++++++++++++++++++++"
     source /hpc-home/osbourne/quick-test-of-scripts/single-fastq-script_6.sh
     echo "++++++++++++++++++FASTQ SCRIPTS ENDED++++++++++++++++++++++++++"
     mkdir -p Out_files
     mv *.out Out_files/
     echo "+++++++++++++++++TIDYING OF OUT FILES COMPLETE+++++++++++++++++"
     cd ..
  elif [ -z "$raw_input_fastq_files" ]; then
    echo "±±±±±These are the relevant files to work on, "$raw_input_fasta_files""
    export raw_input_fasta_files
    echo "++++++++++++++++++STARTING THE FASTA SCRIPTS++++++++++++++++++++++"
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
    mkdir -p Out_files
    mv *.out Out_files/
    echo "+++++++++++++++++TIDYING OF OUT FILES COMPLETE+++++++++++++++++"
    cd ..
  else
    echo "+++++THERE ARE NO FASTA OR FASTQ FILES IN THE DIRECTORIES+++++"
  fi
done
