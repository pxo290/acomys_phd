#!/bin/bash -e
#SBATCH -t 0-23:35
#SBATCH -c 2
#SBATCH --mem=45000
#SBATCH -J krak2

#Kraken2 manual - https://ccb.jhu.edu/software/kraken2/index.shtml?t=manual
#Sourcing the version of kraken2
source package /tgac/software/testing/bin/kraken-2.0.7_beta

#Running Kraken2 basic - if you don't rename the output files it will overwrite
#them each time with 'report' and 'output'
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 <file> --classified-out <file>.out --report <file>_kraken-report.out > <file>_kraken_output.txt
#I use interleaved files so don't use the --paired flag
#I also am happy with it being able to detect file type so don't use the
#different flags for that, --fastq-input, --bzip-compressed, --gzip-compressed
#It expects fasta files by default

#Running it with the internal confidence scoring system, which is difficult to
#explain but goes through it on the site. I don't think you would need it really
#in your case but thought I'd include it anyway
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 <file> --confidence <integer between 1 and 20> --classified-out <file>.out --report <file>_kraken-report.out > <file>_kraken_output.txt

#Running it sending classified and unclassified sequences to specific files
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 <file> --confidence <integer between 1 and 20> --classified-out <file>.out --unclassified-out <file>.out --report <file>_kraken-report.out > <file>_kraken_output.txt
