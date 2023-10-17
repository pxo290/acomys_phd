#!/bin/bash
#SBATCH -t 2-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2023-01-16_MetaBat2_trial_only
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-16_MetaBat2_trial_only-%A.out
#SBATCH -e /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-16_MetaBat2_trial_only-%A.err

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

source package 0a2dffce-c151-4379-abe9-866414c91cd7 #MetaBAT 2.15

depths_file="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/c335e0dc_9e98_4d37_8a9e_1bf4f15ae019_f7UTG3-R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003/Binning_output/c335e0dc_9e98_4d37_8a9e_1bf4f15ae019_f7UTG3-R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003.Mapping_for_MetaBat2_binning.Sorted_BAM_file.Depths.txt"
zipped_scaffold_file="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/c335e0dc_9e98_4d37_8a9e_1bf4f15ae019_f7UTG3-R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003/Assembly_output/c335e0dc_9e98_4d37_8a9e_1bf4f15ae019_f7UTG3-R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003.scaffolds.fasta.gz"
sorted_bam_file="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/c335e0dc_9e98_4d37_8a9e_1bf4f15ae019_f7UTG3-R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003/Assembly_output/c335e0dc_9e98_4d37_8a9e_1bf4f15ae019_f7UTG3-R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003.Mapping_for_MetaBat2_binning.Sorted.bam"
outdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/c335e0dc_9e98_4d37_8a9e_1bf4f15ae019_f7UTG3-R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003/Binning_output"

#Version 1
mkdir -m 755 -p "${outdir}/Version_1"
cd "${outdir}/Version_1"
runMetaBat.sh -t 2 "$zipped_scaffold_file" "$sorted_bam_file" || printf "Failed version 1\n"

#Version 2
mkdir -m 755 -p "${outdir}/Version_2"
cd "${outdir}/Version_2"
runMetaBat.sh -t 2 --inFile "$zipped_scaffold_file" --abdFile "$depths_file" -o "${outdir}/Version_2/Version_2_file" || printf "Failed version 2\n"

#Version 3
mkdir -m 755 -p "${outdir}/Version_3"
cd "${outdir}/Version_3"
metabat2 --abdFile "$depths_file" --inFile "$zipped_scaffold_file" --outFile "${outdir}/Version_3/Version_3_file" || printf "Failed version 3\n"



c335e0dc_9e98_4d37_8a9e_1bf4f15ae019_f7UTG3-R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003-NODE_1_length_36153_cov_20.888443
c335e0dc_9e98_4d37_8a9e_1bf4f15ae019_f7UTG3-R0786-S0002_VWT3_A64340_1_HY5VJDSX2_ACTTCGGTT-ACTTCGGTT_L003-NODE_1_length_36153_cov_20.888443