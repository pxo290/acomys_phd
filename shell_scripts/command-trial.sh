#!/bin/bash
#SBATCH -p ei-largemem
#SBATCH -t 7-23:35
#SBATCH -c 12
#SBATCH --mem=750000
#SBATCH -J unpaired_works
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Functions up here

function fasta_workflow() {
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fasta-script_1.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fasta-script_2.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fasta-script_3.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fasta-script_4.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fasta-script_5.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fasta-script_6.sh
}

function fastq_workflow() {
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fastq-script_1.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fastq-script_2.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fastq-script_3.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fastq-script_4.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fastq-script_5.sh
  source /hpc-home/osbourne/Scratch/Scratch-scripts/single-read-stuff/single-fastq-script_6.sh
}

cd $1
echo "$1"
raw_input_directories=$(find . -maxdepth 1 \( -type d -name "*SINGLE*" \))
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
source numpy-1.7.0
source biopython-1.66
source scipy-1.0.0
cd /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases
export PATH='pwd':$PATH
export mpa_dir='pwd'
cd $1
export raw_input_directories
source metaphlan-2f1b17a1f4e9
source kraken2-2.0.7
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
     fastq_workflow $raw_input_fastq_files
  elif [ -z "$raw_input_fastq_files" ]; then
    echo "_+_+_+_These are the relevant files to work on, "$raw_input_fasta_files""
    fasta_workflow $raw_input_fasta_files
  fi
  cd ..
done

