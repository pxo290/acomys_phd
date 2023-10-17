#!/bin/bash -eE
#SBATCH -t 04-20:30
#SBATCH -p ei-largemem
#SBATCH -c 1
#SBATCH -J Culture_and_MIGA_alignments
#SBATCH --mem=725gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing MAUVE
source package /tgac/software/testing/bin/mauve-2.4.0

#Set fixed variable
export mauve_scratch="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Mauve_temp_dir"
export mauve_outdir="/hpc-home/osbourne/Jolytree_home/JolyTree-master/Culture_SPADES_assembly_scaffolds_and_MIGA_closest_hits/Mauve_outputs"
export UIE=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 18)
export lobel=$(date | awk -F " " '{print $6"_"$3"_"$2}')
export LABEL=$(printf "${UIE}_${lobel}")

#Set mutuable variable
inpdir=$1
cd "$inpdir" && export INPDIR=$(pwd)

#Get the list of files to run
targets=$(ls -l *.fa | awk -F " " '{print $9}' | tr "\n" " ")

#Run the command
#progressiveMauve --output=TESTING_Mauve.xmfa --seed-weight=15 13A_S1_SCAFFOLDS.fa 13B_S2_SCAFFOLDS.fa 13D_S4_SCAFFOLDS.fa 13E_S5_SCAFFOLDS.fa GCF_000178475.1_ASM17847v1_genomic.fa GCF_001434975.1_ASM143497v1_genomic.fa
##Above command works as of 2021-06-25
#progressiveMauve --output="${LABEL}_Mauve_output.xmfa" --seed-weight=15 --backbone-output="${LABEL}_Mauve_backbone" --scratch-path-1="$mauve_scratch" --scratch-path-2="$mauve_scratch" --output-guide-tree="${LABEL}_Mauve_guide_tree" "$targets"
progressiveMauve --output="${LABEL}_Mauve_output.xmfa" --seed-weight=15 --backbone-output="${LABEL}_Mauve_backbone" --scratch-path-1="$mauve_scratch" --scratch-path-2="$mauve_scratch" --output-guide-tree="${LABEL}_Mauve_guide_tree" 13A_S1_SCAFFOLDS.fa 13B_S2_SCAFFOLDS.fa 13D_S4_SCAFFOLDS.fa 13E_S5_SCAFFOLDS.fa 16aA_S24_SCAFFOLDS.fa 16aB_S25_SCAFFOLDS.fa 16aC_S26_SCAFFOLDS.fa 16aD_S27_SCAFFOLDS.fa 16aE_S28_SCAFFOLDS.fa 16aF_S29_SCAFFOLDS.fa 16bA_S19_SCAFFOLDS.fa 16bB_S20_SCAFFOLDS.fa 16bC_S21_SCAFFOLDS.fa 16bD_S22_SCAFFOLDS.fa 16bE_S23_SCAFFOLDS.fa 18A_S9_SCAFFOLDS.fa 18B_S10_SCAFFOLDS.fa 18C_S11_SCAFFOLDS.fa 18D_S12_SCAFFOLDS.fa 18E_S13_SCAFFOLDS.fa 39A_S14_SCAFFOLDS.fa 39B_S15_SCAFFOLDS.fa 39C_S16_SCAFFOLDS.fa 39D_S17_SCAFFOLDS.fa 39E_S18_SCAFFOLDS.fa 41A_S6_SCAFFOLDS.fa 41B_S7_SCAFFOLDS.fa 41C_S8_SCAFFOLDS.fa GCF_000014505.1_ASM1450v1_genomic.fa GCF_000178475.1_ASM17847v1_genomic.fa GCF_000615685.1_ASM61568v1_genomic.fa GCF_000771145.1_DSM-20092_genomic.fa GCF_001434195.1_ASM143419v1_genomic.fa GCF_001434975.1_ASM143497v1_genomic.fa GCF_001435345.1_ASM143534v1_genomic.fa GCF_001435915.1_ASM143591v1_genomic.fa GCF_001436015.1_ASM143601v1_genomic.fa GCF_001436805.1_ASM143680v1_genomic.fa GCF_001437205.1_ASM143720v1_genomic.fa GCF_001591685.1_ASM159168v1_genomic.fa GCF_002160635.1_ASM216063v1_genomic.fa GCF_002282915.1_ASM228291v1_genomic.fa GCF_003999355.1_ASM399935v1_genomic.fa GCF_009362935.1_ASM936293v1_genomic.fa GCF_009428965.1_ASM942896v1_genomic.fa GCF_014635905.1_ASM1463590v1_genomic.fa GCF_014656585.1_ASM1465658v1_genomic.fa GCF_014838745.1_ASM1483874v1_genomic.fa GCF_016127775.1_ASM1612777v1_genomic.fa GCF_900103655.1_IMG-taxon_2597490363_annotated_assembly_genomic.fa
