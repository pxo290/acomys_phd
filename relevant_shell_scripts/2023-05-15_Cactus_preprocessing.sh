#!/bin/bash -eE
#SBATCH -p ei-medium
#SBATCH -J 2023-05-15_Cactus_preprocessing
#SBATCH -c 1
#SBATCH --mem=24gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-15_Cactus_preprocessing-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-15_Cactus_preprocessing-%A.err

#Written on 2023-03-22
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Script to preprocess files for Cactus after advice from R. Shaw, runs on the strict bins and isolate assemblies.
#Untidy and inefficient script, just tired of disconnecting when interactive

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-05-15_Cactus_preprocessing.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-05-15_Cactus_preprocessing.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

destdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/softmasked_files"
source package cab8386a-c777-4936-8411-a6ed2b5e6a20 #BBmap - 38.79
source package 46a62eca-4f8f-45aa-8cc2-d4efc99dd9c6 #Seqkit 0.12.0

rm -r "$destdir" || printf "$destdir did not already exist"
mkdir -p -m 755 "$destdir"

isolates_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed"
cd "$isolates_dir"
targets=$(find -maxdepth 1 -type f -name "*-contigs.fasta.Contigs_min_length_500bp.fa")
for f in $targets ; do cp "$f" "${destdir}" && echo "Copied file: $f" ; done

bins_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/strictest_bins/fasta_files/all_strict_bins_isolate_assemblies_min_500bp_contigs_and_some_reference_genomes"
cd "$bins_dir"
targets=$(find -maxdepth 1 -type f -name "Bin*fa")
#For bins to remove small contigs
for f in $targets
do
  sampleID=$(basename "$f" | awk -F ".f" '{print $1}')
  seqkit seq -m 500 --quiet "$f" > "${destdir}/${sampleID}-temp.fa"
  printf "Processed file:\t$f\n"
done
cd "$destdir"
targets=$(find -maxdepth 1 -type f -name "*.fa")
#For both
for f in $targets
do
  sampleID=$(basename "$f" | awk -F "-" '{print $1}')
  srun bbmask.sh -Xmx6g -Xms3g in="$f" out="${sampleID}.fa" threads=auto maskrepeats=t minkr=5 maxkr=15 minlen=30 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.85 lowercase=t
  mv "$f" "${f}.deletable"
  printf "Processed file:\t$f\n"
done

rm *.deletable

#Remove spaces and make unique headers for all files
printf "Sample ID\tOld header\tNew header\n" > "2023-05-15_all_changed_headers.txt"
for f in *.fa
do
  sampleID=$(basename "$f" | awk -F ".f" '{print $1}')
  grep '>' "$f" > "${sampleID}.headers.txt"
  while IFS= read -r line
  do
    old_header=$(echo "$line")
    new_header=$(uuidgen | sed "s/$/-${sampleID}/g")
    sed -i -e "s/${old_header}/>${new_header}/g" "$f"
    printf "${sampleID}\t${old_header}\t>${new_header}\n" >> "2023-05-15_all_changed_headers.txt"
  done < "${sampleID}.headers.txt"
  printf "Processed file:\t$f\n"
done