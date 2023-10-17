#!/bin/bash -eE
#SBATCH -t 2-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J modified_2023-01-13_revised_RS_just_binning_trial_script.sh
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/modified_2023-01-13_revised_RS_just_binning_trial_script.sh-%A.out
#SBATCH -e /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/modified_2023-01-13_revised_RS_just_binning_trial_script.sh-%A.err


#Written by Peter Osborne - post EI studentship
#Written on 2022-01-13
#Written to run on the NBI HPC

#Script can be found here on the HPC: /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/scripts

#Script is a trial script which will process read files assigned to it, not metagenomic reads specifically but standard short read files.
#Idea is to try and obtain MAGs from the read files.

#Software used includes:
#FastP, BBTools, SPAdes, MetaBAT, CheckM, GTDB-TK, Minimap2, SAMTools, Salmon and Prokka

#Intended operation is:
#   1. QC the reads with FastP
#   2. Filter out the bacterial/non-host reads using BBDuk, presumes you also have a reference genome(s) to use for this
#   3. Assembles the bacterial reads using the metaSPAdes feature with SPAdes
#   4. Bin the assembly(ies) using MetaBAT - note that to do this you need to map the read files to the assembly and sort the bam files
#   5. Assess the bin quality using CheckM
#   6. Taxonomically profile the bins using GTDB-TK
#   7. Map the bacterial reads to the bin using Minimap2
#   8. Process the mapping data using SAMTools and Salmon
#   9. Annotate the bin(s) using Prokka

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software - using the packages where possible
source package 7b4623ee-93ca-4c66-b740-361a5e43c0e4 #FastP 0.23.1
source package /tgac/software/testing/bin/bbmap-38.06 #BBMap 38.06
source package 3a579940-1cba-4d60-86ef-43b8705935fb #SPAdes 3.13.1
source package 5a1c6a9a-f666-4eaa-9409-3e7435d86406 #CheckM 1.2.0
source package 0a2dffce-c151-4379-abe9-866414c91cd7 #MetaBAT 2.15
source package 4041d3fc-f42e-48e0-afce-7314f4c87de6 #GTDB-TK 2.0.0
source package 222eac79-310f-4d4b-8e1c-0cece4150333 #Minimap2 2.23-41122
#source package 638df626-d658-40aa-80e5-14a275b7464b #Samtools 1.15
source package /tgac/software/testing/bin/samtools-1.10 #Samtools 1.10
source package /tgac/software/testing/bin/salmon-0.13.1 #Salmon 0.13.1
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka 1.14.6

#Setting fixed variables - note this assumes your input files are gzipped, paired-end short read files with a fairly consistent naming scheme
#Also would need to edit both the host genome and the other references if using them
export inpdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/raw"
export top_outdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting"
export run_ID=$(( uuidgen ; head /dev/urandom | tr -dc A-Za-z0-9 | head -c 6 ) | tr "\n" "_" | tr "-" "_")
export raw_inpf1="${inpdir}/PRJEB48359-SAMEA10534755-Steppe_polecat-ERR7198277_1.fastq.gz"
export raw_inpf2="${inpdir}/PRJEB48359-SAMEA10534755-Steppe_polecat-ERR7198277_2.fastq.gz"
export sampleID=$(basename "$raw_inpf1" | awk -F "_1.fastq" '{print $1}')
export reference_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/reference_genomes"
export host_genome="${reference_dir}/European_Polecat_RefSeq_representative-GCF_011764305.1_ASM1176430v1.1_genomic.fna"
export other_reference_1="${reference_dir}/Human_NCBI_represenative_GCF_000001405.40_GRCh38.p14_genomic.fna"
export other_reference_2="${reference_dir}/Rattus_rattus_GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fna"
export other_reference_3="${reference_dir}/Domestica_ferret_GenBank_assembly_GCA_000215625.1_MusPutFur1.0_genomic.fa"
export other_reference_4="${reference_dir}/European_frog_GCF_905171775.1_aRanTem1.1_genomic.fa"
export scratch_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch"

#First up, making copies of the input files
gunzip -c "$raw_inpf1" > "${scratch_dir}/${run_ID}-${sampleID}.R1.fastq"
gunzip -c "$raw_inpf2" > "${scratch_dir}/${run_ID}-${sampleID}.R2.fastq"
cd "$scratch_dir"
inpf1="${scratch_dir}/${run_ID}-${sampleID}.R1.fastq"
inpf2="${scratch_dir}/${run_ID}-${sampleID}.R2.fastq"

#Next writing the QC function
execute_QC () {
    input_1="$1"
    input_2="$2"
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/QC_and_cleansed_files"
    QC_outdir="${scratch_dir}/${run_ID}-${sampleID}/QC_and_cleansed_files"
    printf "QC'ing the files:\t$input_1 and $input_2\n"
    fastp --in1 "$input_1" --in2 "$input_2" --out1 "${QC_outdir}/${run_ID}-${sampleID}.QCed.R1.fastq" --out2 "${QC_outdir}/${run_ID}-${sampleID}.QCed.R2.fastq" --json "${QC_outdir}/${run_ID}-${sampleID}.QCed.json" --html "${QC_outdir}/${run_ID}-${sampleID}.QCed.html" --verbose --report_title "${run_ID}-${sampleID}-report"
    export QCed_R1="${QC_outdir}/${run_ID}-${sampleID}.QCed.R1.fastq"
    export QCed_R2="${QC_outdir}/${run_ID}-${sampleID}.QCed.R2.fastq"
    printf "QC'ed the files:\t$input_1 and $input_2\n"
}

#Exporting the QC function
export -f execute_QC

#Writing the eukaryote/prokaryote read filtering function
execute_bbduk () {
    input_1="$1"
    input_2="$2"
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/QC_and_cleansed_files"
    BBDUK_outdir="${scratch_dir}/${run_ID}-${sampleID}/QC_and_cleansed_files"
    printf "Will run BBDuk on the files:\t$input_1 and $input_2\n"
    printf "Will use the reference genomes:\n$host_genome, $other_reference_1\n$other_reference_2, $other_reference_3\n$other_reference_4\n"
    #srun bbduk.sh -Xmx236g -Xms16g -prealloc in="$input_1" in2="$input_2" ref="$host_genome","$other_reference_1","$other_reference_2","$other_reference_3","$other_reference_4" outm="${BBDUK_outdir}/${run_ID}-${sampleID}.Eukaryotic_matching.fastq" out="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R1.fastq" out2="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R2.fastq" overwrite=t stats="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.BBDuk_stats.txt"
    srun bbduk.sh -threads=2 -Xmx236g -Xms16g prealloc=t in="$input_1" in2="$input_2" ref="$host_genome","$other_reference_1","$other_reference_2","$other_reference_3","$other_reference_4" out="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R1.fastq" out2="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R2.fastq" overwrite=t stats="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.BBDuk_stats.txt"
    export prokaryotic_R1="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R1.fastq"
    export prokaryotic_R2="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R2.fastq"
    printf "Ran BBDuk on the files:\t$input_1 and $input_2\n"
    printf "Used the reference genomes:\n$host_genome, $other_reference_1\n$other_reference_2, $other_reference_3\n$other_reference_4\n"
}

#Exporting the BBDuk function
export -f execute_bbduk

#Writing the SPAdes function
execute_SPAdes () {
    input_1="$1"
    input_2="$2"
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/Assembly_output"
    export assembly_outdir="${scratch_dir}/${run_ID}-${sampleID}/Assembly_output"
    printf "Will use metaSPAdes to assemble the read files:\t$input_1 and $input_2\n"
    spades.py -o "$assembly_outdir" --meta -1 "$input_1" -2 "$input_2" --threads 2 --memory 96
    cd "$assembly_outdir"
    printf "Adding the run ID and sample ID to the filenames of everything generated by metaSPAdes\n"
    for f in *
    do
        mv "$f" "${run_ID}-${sampleID}.${f%}"
        printf "Renamed file:\t$f to ${run_ID}-${sampleID}.${f%}\n"
    done
    export assembly_scaffolds_file="${assembly_outdir}/${run_ID}-${sampleID}.scaffolds.fasta"
    printf "Will add the run and sample IDs to the fasta headers in the scaffolds file\n"
    sed -i -e "s/>/>${run_ID}-${sampleID}-/g" "$assembly_scaffolds_file"
    cd "$scratch_dir"
    printf "Used metaSPAdes to assemble the read files:\t$input_1 and $input_2\n"
}

#Exporting the SPAdes function
export -f execute_SPAdes

#Writing the MetaBat 2 binning function
#Remember that the QC'ed read files need to be mapped to the assembly and then the resultant BAM file sorted before using MetaBat 2
execute_metabat2_after_mapping () {
    input_1="$1"
    input_2="$2"
    inp_assembly="$assembly_scaffolds_file"
    work_dir="$assembly_outdir"
    printf "Will first map the QC'ed read files to the assembly, as MetaBat 2 requires this before running\n"
    printf "Will map QC'ed read files:\t$input_1 and $input_2 to assembly file:\t$inp_assembly\n"
    minimap2 -ax sr -t 2 "$inp_assembly" "$input_1" "$input_2" > "${work_dir}/${run_ID}-${sampleID}.Mapping_for_MetaBat2_binning.sam"
    assembly_mapping_sam="${work_dir}/${run_ID}-${sampleID}.Mapping_for_MetaBat2_binning.sam"
    printf "Now will turn the generated sam file $assembly_mapping_sam into a BAM file then delete the SAM file\n"
    samtools view -@ 2 -b -S "$assembly_mapping_sam" > "${work_dir}/${run_ID}-${sampleID}.Mapping_for_MetaBat2_binning.bam"
    rm "$assembly_mapping_sam"
    printf "Now will sort the BAM file and delete the unsorted one\n"
    samtools sort -@ 2 -l 0 -m 24G -O BAM "${work_dir}/${run_ID}-${sampleID}.Mapping_for_MetaBat2_binning.bam" > "${work_dir}/${run_ID}-${sampleID}.Mapping_for_MetaBat2_binning.Sorted.bam"
    rm "${work_dir}/${run_ID}-${sampleID}.Mapping_for_MetaBat2_binning.bam"
    assembly_sorted_mapping_bam="${work_dir}/${run_ID}-${sampleID}.Mapping_for_MetaBat2_binning.Sorted.bam"
    printf "Will now run MetaBat 2 using the assembly file:\t$inp_assembly and the sorted BAM file:\t$assembly_sorted_mapping_bam\n"
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/Binning_output"
    binning_outdir="${scratch_dir}/${run_ID}-${sampleID}/Binning_output"
    cd "$binning_outdir"
    #I think MetaBat2 needs the assembly to be gzipped, so will do that now here as well
    gzip "$assembly_scaffolds_file"
    gzipped_assembly_file=$(echo "${assembly_scaffolds_file}.gz")
    #runMetaBat.sh -t 2 "$assembly_scaffolds_file" "$assembly_sorted_mapping_bam"
    ##Below is the other multiple step process for running MetaBat2 I am trying##
    jgi_summarize_bam_contig_depths --outputDepth "${binning_outdir}/${run_ID}-${sampleID}.Mapping_for_MetaBat2_binning.Sorted_BAM_file.Depths.txt" "$assembly_sorted_mapping_bam"
    depth_file="${binning_outdir}/${run_ID}-${sampleID}.Mapping_for_MetaBat2_binning.Sorted_BAM_file.Depths.txt"
    #runMetaBat.sh -t 2 --inFile "$gzipped_assembly_file" --abdFile "$depth_file" -o "$binning_outdir"
    metabat2 --abdFile "$depth_file" --inFile "$gzipped_assembly_file" --outFile "${binning_outdir}/${run_ID}-${sampleID}.MetaBat2_output"
    ####
    printf "Will gzip the sorted BAM file since we don't need it any more\n"
    gzip "$assembly_sorted_mapping_bam"
    printf "Binned assembly file:\t$inp_assembly\n"
}

#Exporting the binning function
export -f execute_metabat2_after_mapping

#Going to the top output directory for convenience
cd "$scratch_dir"

#Running the functions sequentially
execute_QC "$inpf1" "$inpf2"
execute_bbduk "$QCed_R1" "$QCed_R2"
execute_SPAdes "$prokaryotic_R1" "$prokaryotic_R2"
execute_metabat2_after_mapping "$QCed_R1" "$QCed_R2"

#Adding in a little bit here to email yourself and show the contents of the assembly output directory to check what, if anything, was made
cd "${scratch_dir}/${run_ID}-${sampleID}/Assembly_output"
ls -lhtr > dir_contents.txt
mail -s "RS revised trial assembly output directory contents list" -a dir_contents.txt peter.osborne@earlham.ac.uk <<< "File dir_contents.txt should be attached"
rm dir_contents.txt