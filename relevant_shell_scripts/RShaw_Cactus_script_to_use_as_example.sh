#!/bin/bash -e
#SBATCH -p ei-largemem # partition (queue) 
#SBATCH --nodelist=n83032 #this version of cactus should run on this node
#SBATCH -N 1 # number of nodes
#SBATCH -c 64 # number of cores
#SBATCH --mem 1024G # memory pool for all cores
#SBATCH -J branchlength_cactus
#SBATCH -o slurm.%j.out # STDOUT
#SBATCH -e slurm.%j.err # STDERR
#SBATCH --mail-type=END,FAIL,TIME_LIMIT_75 # notifications for job done & fail
#SBATCH --mail-user=rebecca.shaw@earlham.ac.uk# send-to address
​
​
#source package d49b4bb8-8d3c-4e68-90b4-3a76159c19eb
​
​
## This run took 3 weeks and 6 days. This was a new run of cactus and also was used with a branch length newick tree as input. 
source package afc1a9d3-4ba8-4261-b4b3-e0153b069bf1 #running Cactus later install
​
TARGET=/scratch/${USER} #set target directory #current directory
SCRATCH=/ei/projects/6/61ea8b33-6b11-4e22-8ca7-67abbd719d07/scratch/mustelids/masked_cactus_genomes #current directory
​
echo $TARGET
cd ${TARGET}/cactus3 #move into target directory. use a new folder each run of cactus and move genomes into this folder. 
​
srun cp ${SCRATCH}/cactus_GCF_011100685.1_UU_Cfam_GSD_1.0_genomic_nm.fna.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_Felis_catus.Felis_catus_9.0.dna_toplevel.fa.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_GCA_902655055_Lutra_lutra_LutLut1.2.fasta.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_GCF_009829155.1_mMusErm1.Pri_genomic_nm.fna.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_Homo_sapiens.GRCh38.dna_primary_assembly.fa.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_M_eversmanii_1.0.fasta.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_mfoi.min_150.pseudohap2.1_HiC.fasta.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_Mnivalis-assembly-pseudohap1_primary.fasta.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_MusPutFur1.0_bionano_nm.fasta.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_mustela_nigripes.v2.smithsonian.fasta.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/cactus_Mustela_putorius_v1.0.fa.masked ${TARGET}/cactus3/
srun cp ${SCRATCH}/evolverMammals2.txt ${TARGET}/cactus3/
​
#evolverMammals2.txt contains the genome information and also the branch length tree
#branchlength_cactus_aln.hal is the output file
​
cactus --binariesMode local  --cleanWorkDir never --noLinkImports --noMoveExports --maxCores 128 --defaultMemory 2G --maxMemory 1024G --defaultDisk 64G --maxDisk 5120G --workDir ./ ./jobstore3 evolverMammals2.txt ./branchlength_cactus_aln.hal
​
 mv -v ${TARGET}/cactus3/branchlength_cactus_aln.hal ${SCRATCH}