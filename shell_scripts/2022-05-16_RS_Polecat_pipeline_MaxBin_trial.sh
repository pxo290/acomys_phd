#!/bin/bash -eE
#SBATCH -t 00-12:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J 2022-05-16_MaxBin_trial
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-05-16_MaxBin_trial-%A.out
#SBATCH -e /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-05-16_MaxBin_trial-%A.err

#Written on 2022-05-16
#Written by Peter Osborne

#Script is a test script to see whether your shoddy and amateur installation of
#MaxBin2 has worked. You need this as it turns out there is no actual binning
#software installed on the HPC and when you tried picking bins manually using VizBin
#you picked absolute shite.

#Sourcing the software MaxBin needs
source package /tgac/software/testing/bin/perl-5.22.1
source package 29a74b59-88fc-4453-a30b-1310b34910b9 #Bowtie2 version 2.4.1
source package cd746169-51ea-44e5-b34c-4f9e80cbc470 #Hmmer version 3.3
source package /tgac/software/testing/bin/idba-1.1.2 #Hopefully IDBA-UD version 1.1.2
source package /tgac/software/testing/bin/FragGeneScanPlus-git20191213 #FragGeneScanPlus, unknown version

#Setting some fixed variables
maxbin_dir="/hpc-home/osbourne/MaxBin2_installation/MaxBin-2.2.7/run_MaxBin.pl"
input_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/Assembly_output/Polecat_R0786-S0015_VWT837_A64353_MEGAHIT_assembly/Polecat_R0786-S0015_VWT837_A64353.contigs.fa"
