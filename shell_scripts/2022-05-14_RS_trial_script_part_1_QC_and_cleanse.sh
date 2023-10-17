#!/bin/bash -eE
#SBATCH -t 07-12:30
#SBATCH -p ei-largemem
#SBATCH -c 1
#SBATCH -J 2022-05-14_RS_trial_script_part_1_QC_and_cleanse
#SBATCH --mem=625gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-05-14_RS_trial_script_part_1_QC_and_cleanse-%A.out
#SBATCH -e /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-05-14_RS_trial_script_part_1_QC_and_cleanse-%A.err

#Script overall started writing on 2022-05-14
#Written by Peter Osborne
#Written to test how much can be done metagenomically speaking with data provided
#by Rebecca Shaw of read files from mustelid sequencing - any genomes other than
#the mustelid itself are contaminants and are what I will attempt to pull out and
#examine.

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Part 1 of the script will be QC'ing the read files and removing host and human
#contamination.

#Sourcing software
source package /tgac/software/testing/bin/fastp-20190305 #FastP for QC
source package /tgac/software/testing/bin/bbmap-38.06 #BBMap to use BBTools for
#cleansing

#Setting fixed input variables for part 1 of the script
raw_inpf1="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R1.fastq"
raw_inpf2="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R2.fastq"
inpdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting"

#Writing the function to execute the QC and host plus human cleanse
execute_QC_and_cleanse () {
  cd "$inpdir"
  #Making a working and output directory
  mkdir -p "QC_and_cleansed_files"
  cd "QC_and_cleansed_files"
  outdir=$(pwd)
  cd "$inpdir"
  #Getting the original raw input files
  func_inpf1="$1"
  func_inpf2="$2"
  sampleID=$(basename "$func_inpf1" | awk -F "_" '{print $1"_"$2"_"$3}')
  #Will make copies of the input files to avoid altering the originals
  cp "$func_inpf1" "${outdir}/Polecat_${sampleID}_R1.fastq"
  cp "$func_inpf2" "${outdir}/Polecat_${sampleID}_R2.fastq"
  #First up will do QC using FastP
  cd "$outdir"
  fastp --in1 "${outdir}/Polecat_${sampleID}_R1.fastq" --in2 "${outdir}/Polecat_${sampleID}_R2.fastq" --out1 "${outdir}/Polecat_${sampleID}_R1.QCed.fastq" --out2 "${outdir}/Polecat_${sampleID}_R2.QCed.fastq" --json "${outdir}/Polecat_${sampleID}.QCed.json" --html "${outdir}/Polecat_${sampleID}.QCed.html" --verbose --report_title "Polecat_${sampleID}-report"
  #Setting reference genome variables for the host and for humans
  euro_polecat_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/European_Polecat_RefSeq_representative-GCF_011764305.1_ASM1176430v1.1_genomic.fna"
  human_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/GRCh38_latest_genomic.fna"
  #Using BBTools from BBMap to simultaneously remove host and human matching reads
  #which in this case will be the overwhelming majority of them
  srun bbduk.sh -Xmx256g -Xms128g -prealloc in="Polecat_${sampleID}_R1.QCed.fastq" in2="Polecat_${sampleID}_R2.QCed.fastq" ref="$euro_polecat_genome","$human_genome" outm="${outdir}/Polecat_${sampleID}.QCed.Host_or_human_matching.fastq" out="Polecat_${sampleID}_R1.QCed.Cleansed.fastq" out2="Polecat_${sampleID}_R2.QCed.Cleansed.fastq" overwrite=t stats="${outdir}/Polecat_${sampleID}-BBDuk_stats.txt"
  #Now will note how many reads were in the original files, the QC'ed files and
  #the cleansed files - change this if the formatting of the fastq file headers
  #means they don't start with '@A0'
  printf "File\tRaw read count\tQC'ed read count\tCleansed read count\n" > "${outdir}/Polecat_${sampleID}_read_numbers_different_files.tsv"
  raw_inpf1_read_count=$(grep -c "@A0" "${outdir}/Polecat_${sampleID}_R1.fastq")
  QCed_inpf1_read_count=$(grep -c "@A0" "${outdir}/Polecat_${sampleID}_R1.QCed.fastq")
  cleansed_inpf1_read_count=$(grep -c "@A0" "${outdir}/Polecat_${sampleID}_R1.QCed.Cleansed.fastq")
  raw_inpf2_read_count=$(grep -c "@A0" "${outdir}/Polecat_${sampleID}_R2.fastq")
  QCed_inpf2_read_count=$(grep -c "@A0" "${outdir}/Polecat_${sampleID}_R2.QCed.fastq")
  cleansed_inpf2_read_count=$(grep -c "@A0" "${outdir}/Polecat_${sampleID}_R2.QCed.Cleansed.fastq")
  printf "$func_inpf1\t$raw_inpf1_read_count\t$QCed_inpf1_read_count\t$cleansed_inpf1_read_count\n" >> "${outdir}/Polecat_${sampleID}_read_numbers_different_files.tsv"
  printf "$func_inpf2\t$raw_inpf2_read_count\t$QCed_inpf2_read_count\t$cleansed_inpf2_read_count\n" >> "${outdir}/Polecat_${sampleID}_read_numbers_different_files.tsv"
  #Now to tidy up a bit by removing the raw input file copies made and zipping
  #up the QC'ed fastq files. Could also zip up the cleansed files but for now
  #won't as they will be used in the next steps and shouldn't be all that large.
  rm "${outdir}/Polecat_${sampleID}_R1.fastq"
  rm "${outdir}/Polecat_${sampleID}_R2.fastq"
  gzip "${outdir}/Polecat_${sampleID}_R1.QCed.fastq"
  gzip "${outdir}/Polecat_${sampleID}_R2.QCed.fastq"
  #Noting that the function finished
  printf "\nCompleted a QC and cleanse function execution on input files:\t$func_inpf1 and $func_inpf2"
  printf "\nUsed the following genomes for cleansing:\t$euro_polecat_genome and $human_genome\n"
}

#Exporting the QC and cleanse function
export -f execute_QC_and_cleanse

#Running the QC and cleanse function on the two unzipped trial files
execute_QC_and_cleanse "$raw_inpf1" "$raw_inpf2"
