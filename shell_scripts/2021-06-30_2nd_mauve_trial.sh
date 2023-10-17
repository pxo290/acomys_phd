#!/bin/bash -eE
#SBATCH -t 10-20:30
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
export mauve_outdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/Mauve_outputs_careful_scaffolds"
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
progressiveMauve --output="${LABEL}_Mauve_output.xmfa" --seed-weight=15 --backbone-output="${LABEL}_Mauve_backbone" --scratch-path-1="$mauve_scratch" --scratch-path-2="$mauve_scratch" --output-guide-tree="${LABEL}_Mauve_guide_tree" 13A_S1_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 13B_S2_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 13D_S4_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16aA_S24_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16aB_S25_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16aC_S26_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16aD_S27_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16aE_S28_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16aF_S29_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16bA_S19_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16bB_S20_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16bC_S21_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16bD_S22_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 16bE_S23_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 18A_S9_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 18B_S10_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 18D_S12_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 18E_S13_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 39A_S14_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 39B_S15_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 39C_S16_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 39D_S17_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 39E_S18_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 41A_S6_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 41B_S7_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa 41C_S8_SPADES_careful_assembly-scaffolds-Single_line-Over_500bp_only.fa GCF_000014505_1_ASM1450v1_genomic-Single_line.fa GCF_000178475_1_ASM17847v1_genomic-Single_line.fa GCF_000615685_1_ASM61568v1_genomic-Single_line.fa GCF_000771145_1_DSM-20092_genomic-Single_line.fa GCF_001434195_1_ASM143419v1_genomic-Single_line.fa GCF_001434975_1_ASM143497v1_genomic-Single_line.fa GCF_001435345_1_ASM143534v1_genomic-Single_line.fa GCF_001435915_1_ASM143591v1_genomic-Single_line.fa GCF_001436015_1_ASM143601v1_genomic-Single_line.fa GCF_001436805_1_ASM143680v1_genomic-Single_line.fa GCF_001437205_1_ASM143720v1_genomic-Single_line.fa GCF_001591685_1_ASM159168v1_genomic-Single_line.fa GCF_002160635_1_ASM216063v1_genomic-Single_line.fa GCF_002282915_1_ASM228291v1_genomic-Single_line.fa GCF_003999355_1_ASM399935v1_genomic-Single_line.fa GCF_009362935_1_ASM936293v1_genomic-Single_line.fa GCF_009428965_1_ASM942896v1_genomic-Single_line.fa GCF_014635905_1_ASM1463590v1_genomic-Single_line.fa GCF_014656585_1_ASM1465658v1_genomic-Single_line.fa GCF_014838745_1_ASM1483874v1_genomic-Single_line.fa GCF_016127775_1_ASM1612777v1_genomic-Single_line.fa GCF_900103655_1_IMG-taxon_2597490363_annotated_assembly_genomic-Single_line.fa
