#!/bin/bash -e
#SBATCH -t 0-00:25
#SBATCH -c 1
#SBATCH --mem=15000
#SBATCH -J LIBRA-test
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

cd /hpc-home/osbourne/Scratch/LIBRA
JAVA_OPTS="-XX:+UseSerialGC"
java jar libra-all.jar preprocess -k 20 -t 8 -o /hpc-home/osbourne/Scratch/LIBRA/trial-output /hpc-home/osbourne/Scratch/testing-2/hullo-SINGLE
