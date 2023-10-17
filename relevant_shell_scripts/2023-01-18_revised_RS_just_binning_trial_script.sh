#!/bin/bash -eE
#SBATCH -t 2-12:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2023-01-18_revised_RS_just_binning_trial_script.sh
#SBATCH --mem=256gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-18_revised_RS_just_binning_trial_script.sh-%A.out
#SBATCH -e /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2023-01-18_revised_RS_just_binning_trial_script.sh-%A.err

#Modified on 2022-01-18
#Modification is to do all the work in the scratch directory and then move out the main output directory after everything has been zipped at the end to the RS_experimenting
#directory.

#Written by Peter Osborne - post EI studentship
#Written on 2022-01-13
#Written to run on the NBI HPC

#Script can be found here on the HPC: /ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/scripts/2023-01-18_revised_RS_just_binning_trial_script.sh

#Script is a trial script which will process read files assigned to it, not metagenomic reads specifically but standard short read files.
#Idea is to try and obtain MAGs from the read files.

#Software used includes:
#FastP, BBTools, SPAdes, MetaBAT, CheckM, GTDB-TK, Minimap2, SAMTools, Salmon, Prokka and KAT

#Intended operation is:
#   1. QC the reads with FastP
#   2. Filter out the bacterial/non-host reads using BBDuk, presumes you also have a reference genome(s) to use for this
#   3. Assembles the bacterial reads using the metaSPAdes feature with SPAdes
#   4. Bin the assembly(ies) using MetaBAT - note that to do this you need to map the read files to the assembly and sort the bam files
#   5. Assess the bin quality using CheckM
#   6. Taxonomically profile the bins using GTDB-TK - CURRENTLY NOT POSSIBLE UNTIL GETTING A WORKING VERSION OF THE DATABASE ON THE CLUSTER
#   7. Annotate the bin(s) using Prokka
#   8. Map the bacterial reads to the bin using Minimap2
#   9. Process the mapping data using SAMTools and Salmon
#   10. Use KAT to analyse the produced bin(s)

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
source package 7f4fb852-f5c2-4e4b-b9a6-e648176d5543 #KAT 2.4.2

#Setting variables provided on the command line, the two raw read files - specifically their basenames
input_read_1="$1"
input_read_2="$2"

#Setting fixed variables - note this assumes your input files are gzipped, paired-end short read files with a fairly consistent naming scheme
#Also would need to edit both the host genome and the other references if using them
export inpdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/data/raw"
export top_outdir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting"
export scratch_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch"
export run_ID=$(( uuidgen ; head /dev/urandom | tr -dc A-Za-z0-9 | head -c 6 ) | tr "\n" "_" | tr "-" "_")

export raw_inpf1="${inpdir}/${input_read_1}"
export raw_inpf2="${inpdir}/${input_read_2}"
export sampleID=$(basename "$raw_inpf1" | awk -F "_.*1.fa" '{print $1}')
export reference_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/reference_genomes"
export host_genome="${reference_dir}/European_Polecat_RefSeq_representative-GCF_011764305.1_ASM1176430v1.1_genomic.fna" #European Polecat
export other_reference_1="${reference_dir}/Human_NCBI_represenative_GCF_000001405.40_GRCh38.p14_genomic.fna" #Human
export other_reference_2="${reference_dir}/Rattus_rattus_GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fna" #Rat
export other_reference_3="${reference_dir}/Domestica_ferret_GenBank_assembly_GCA_000215625.1_MusPutFur1.0_genomic.fa" #Domestic ferret
export other_reference_4="${reference_dir}/European_frog_GCF_905171775.1_aRanTem1.1_genomic.fa" #European frog
export other_reference_5="${reference_dir}/Wild_strawberry_GCF_000184155.1_FraVesHawaii_1.0_genomic.fna" #Wild Strawberry
export other_reference_6="${reference_dir}/Malassezia_pachydermatis_NCBI_representative_GCF_001278385.1_MalaPachy_genomic.fna" #Malassezia pachydermatis (a zoophilic yeast)
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
    export QC_outdir="${scratch_dir}/${run_ID}-${sampleID}/QC_and_cleansed_files"
    printf "QC'ing the files:\t$input_1 and $input_2\n"
    fastp --in1 "$input_1" --in2 "$input_2" --out1 "${QC_outdir}/${run_ID}-${sampleID}.QCed.R1.fastq" --out2 "${QC_outdir}/${run_ID}-${sampleID}.QCed.R2.fastq" --json "${QC_outdir}/${run_ID}-${sampleID}.QCed.json" --html "${QC_outdir}/${run_ID}-${sampleID}.QCed.html" --verbose --report_title "${run_ID}-${sampleID}-report"
    export QCed_R1="${QC_outdir}/${run_ID}-${sampleID}.QCed.R1.fastq"
    export QCed_R2="${QC_outdir}/${run_ID}-${sampleID}.QCed.R2.fastq"
    printf "QC'ed the files:\t$input_1 and $input_2\n"
    #Don't need the copied in read files any more so removing them
    rm "$input_1"
    rm "$input_2"
}

#Exporting the QC function
export -f execute_QC

#Writing the eukaryote/prokaryote read filtering function
execute_bbduk () {
    input_1="$1"
    input_2="$2"
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/QC_and_cleansed_files"
    export BBDUK_outdir="${scratch_dir}/${run_ID}-${sampleID}/QC_and_cleansed_files"
    printf "Will run BBDuk on the files:\t$input_1 and $input_2\n"
    printf "Will use the reference genomes:\n$host_genome, $other_reference_1\n$other_reference_2, $other_reference_3\n$other_reference_4, $other_reference_5 and $other_reference_6\n"
    srun bbduk.sh -threads=2 -Xmx236g -Xms16g prealloc=t in="$input_1" in2="$input_2" ref="$host_genome","$other_reference_1","$other_reference_2","$other_reference_3","$other_reference_4","$other_reference_5","$other_reference_6" out="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R1.fastq" out2="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R2.fastq" overwrite=t stats="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.BBDuk_stats.txt"
    export prokaryotic_R1="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R1.fastq"
    export prokaryotic_R2="${BBDUK_outdir}/${run_ID}-${sampleID}.QCed.Cleansed.R2.fastq"
    printf "Ran BBDuk on the files:\t$input_1 and $input_2\n"
    printf "Used the reference genomes:\n$host_genome, $other_reference_1\n$other_reference_2, $other_reference_3\n$other_reference_4, $other_reference_5 and $other_reference_6\n"
    #Don't need the QC'ed reads prior to prokaryote extraction any more so removing them
    rm "$input_1"
    rm "$input_2"
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
    #The bit below is nice for tracking things but unfortunately Prokka can't handle contig names over
    #37 characters, the original contig names themselves are already 33 characters so will hash out the
    #bit below
    #printf "Will add the run and sample IDs to the fasta headers in the scaffolds file\n"
    #sed -i -e "s/>/>${run_ID}-${sampleID}-/g" "$assembly_scaffolds_file"
    cd "$scratch_dir"
    printf "Used metaSPAdes to assemble the read files:\t$input_1 and $input_2\n"
}

#Exporting the SPAdes function
export -f execute_SPAdes

#Writing the MetaBat 2 binning function
#Remember that the QC'ed and likely prokaryotic read files need to be mapped to the assembly and then the resultant BAM file sorted before using MetaBat 2
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
    export binning_outdir="${scratch_dir}/${run_ID}-${sampleID}/Binning_output"
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
    #Putting any bin fasta files produced into a variable
    cd "$binning_outdir"
    export bin_fasta_files=$(find ~+ -maxdepth 1 -type f -name "*.fa")
}

#Exporting the binning function
export -f execute_metabat2_after_mapping

#Writing the CheckM function
execute_checkm_bins () {
    bins_dir="$binning_outdir"
    input_bin="$1"
    bin_name=$(basename "$input_bin")
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_CheckM_output"
    export checkm_outdir="${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_CheckM_output"
    cp "$input_bin" "$checkm_outdir"
    cd "$checkm_outdir"
    bin_in_checkm_dir="${checkm_outdir}/${bin_name}"
    printf "Will run CheckM on the bin file:\t$input_bin\n"
    printf "Output will be written to directory:\t$checkm_outdir\n"
    #Running CheckM, a two stage process - note the -x flag here depends on the bins having the specific extension .fa
    checkm lineage_wf -t 2 -x fa "$binning_outdir" "$checkm_outdir"
    #Next steps
    target_lineage_file=$(find -maxdepth 1 -type f -name "*lineage*.ms" -printf '%f\n')
    qa_output_file_dir="$checkm_outdir"
    checkm qa -o 2 -f "${checkm_outdir}/${bin_name}.CheckM.tsv" "$target_lineage_file" "$qa_output_file_dir"
    printf "Ran CheckM on the bin file:\t$input_bin\n"
    printf "Output should be written in directory:\t$checkm_outdir\n"
    #Doing some tidying by removing the copied in bin file and gzipping everything
    rm "$bin_in_checkm_dir"
    targets_to_zip=$(find -maxdepth 1 -type f -not -name "*.gz")
    for f in $targets_to_zip
    do
        gzip "$f"
        printf "Gzipped file:\t$f\n" || printf "File $f not zipped, may no longer exist\n"
    done
}

#Exporting CheckM on bin(s) function
export -f execute_checkm_bins

#Writing the Prokka annotation function
execute_prokka_bins_annotation () {
    input_bin="$1"
    bin_name=$(basename "$input_bin")
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_Prokka_output"
    export prokka_outdir="${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_Prokka_output"
    printf "Will run Prokka on the bin file:\t$input_bin\n"
    printf "Output will be written to directory:\t$prokka_outdir\n"
    prokka --outdir "$prokka_outdir" --force --prefix "$bin_name" --kingdom Bacteria "$input_bin"
    printf "Ran Prokka on the bin file:\t$input_bin\n"
    printf "Output should be written in directory:\t$prokka_outdir\n"
    #Doing some tidying by gzipping everything
    cd "$prokka_outdir"
    targets_to_zip=$(find -maxdepth 1 -type f -not -name "*.gz")
    for f in $targets_to_zip
    do
        gzip "$f"
        printf "Gzipped file:\t$f\n" || printf "File $f not zipped, may no longer exist\n"
    done
}

#Exporting Prokka on bin(s) function
export -f execute_prokka_bins_annotation

#Writing the QC'ed and prokaryotic extracted reads mapping to the bin(s) and Salmon analysis function
execute_mapping_reads_to_bin () {
    input_bin="$1"
    inpf_1="$2"
    inpf_2="$3"
    bin_name=$(basename "$input_bin")
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_Minimap_and_Salmon_output"
    export mapping_outdir="${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_Minimap_and_Salmon_output"
    #Running Minimap2
    printf "Will map the read files:\t$inpf_1 and $inpf_2 to Bin fasta file:\t$input_bin\n"
    minimap2 -ax sr -t 2 "$input_bin" "$inpf_1" "$inpf_2" > "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.sam"
    #Converting SAM to BAM then removing the SAM
    samtools view -@ 2 -b -S "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.sam" > "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.bam"
    rm "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.sam"
    #Getting the flagstat output
    samtools flagstat -@ 2 "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.bam" > "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.Samtools_flagstat.txt"
    #Now making a version of the bam file containing only the mate-paired reads then removing the original
    samtools view -F 12 -@ 2 -b -u "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.bam" > "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.Mapped.bam"
    rm "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.bam"
    #Sorting the BAM file containing only the mate-paired reads and removing the unsorted one
    samtools sort -n -@ 2 -l 0 -m 12G -O BAM "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.Mapped.bam" > "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.Mapped.Sorted.bam"
    rm "${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.Mapped.bam"
    export sorted_bin_bam_file="${mapping_outdir}/${bin_name}.Minimap2_mapping_processed_reads_to_bin.Mapped.Sorted.bam"
    #Running Salmon, first need to index the Bin file after copying the bin into the directory to use
    cp "$input_bin" "$mapping_outdir"
    cd "$mapping_outdir"
    salmon_indexing_bin="${mapping_outdir}/${bin_name}"
    #Note here the -k value I am using is the one used in the tutorial at: https://salmon.readthedocs.io/en/latest/salmon.html#:~:text=If%20you%20are%20not,txt%20%2Dk%2031
    printf "Will use Salmon to index the Bin file:\t$salmon_indexing_bin\n"
    salmon_index_name=$(echo "${salmon_indexing_bin%.*}")
    salmon index -t "$salmon_indexing_bin" -i "$salmon_index_name" -k 31
    #Now running the Salmon quantification step after making an output directory to put the stuff into
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_Minimap_and_Salmon_output/Salmon_output"
    export salmon_outdir="${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_Minimap_and_Salmon_output/Salmon_output"
    #The upper command here generated some errors which seemed to cause Salmon to fail without failing the job, so added the command below with the --noErrorModel flag added
    #Error was CIGAR string for read [A00478:208:HY5VJDSX2:3:2676:20627:13823] seems inconsistent. It refers to non-existant positions in the read!
    #The error above was an example, there were multiple reads giving that error
    #salmon quant -t "$salmon_indexing_bin" -l A -a "$sorted_bin_bam_file" --threads 2 --seqBias --gcBias --writeUnmappedNames --numBootstraps 100 --no-version-check -o "$salmon_outdir"
    salmon quant -t "$salmon_indexing_bin" -l A -a "$sorted_bin_bam_file" --noErrorModel --threads 2 --seqBias --gcBias --writeUnmappedNames --numBootstraps 100 --no-version-check -o "$salmon_outdir"
    #Need to go to the Salmon outdir and rename the .sf file created to have useful information in the filename
    cd "$salmon_outdir"
    mv *.sf "${bin_name}.Minimap2_mapping_QCed_likely_prokaryotic_reads.Salmon_gc_and_seq_bias_flagged_quantification_output.sf"
    printf "Mapped the read files:\t$inpf_1 and $inpf_2 to Bin fasta file:\t$input_bin\nThen analysed the output with Salmon, Salmon output should be in directory:\t$salmon_outdir\n"
}

#Exporting the mapping and salmon combined function
export -f execute_mapping_reads_to_bin

#Writing the KAT kmer based analysis of the bin(s) using the reads originally used to produce the assembly
execute_KAT_bin_analysis () {
    input_bin="$1"
    inpf_1="$2"
    inpf_2="$3"
    inpf_modified_name=$(basename "$inpf_1" | sed "s/Cleansed.R1.fastq/Cleansed.R\*\.fastq/g" | sed "s#^#${QC_outdir}/#g")
    bin_name=$(basename "$input_bin")
    mkdir -m 755 -p "${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_KAT_output"
    export kat_outdir="${scratch_dir}/${run_ID}-${sampleID}/Binning_output/${bin_name}_KAT_output"
    #Running KAT analysis of the bin
    printf "Will use KAT to analyse the bin file:\t$input_bin using read files:\t$inpf_1 and $inpf_2\nOutput will be written to the directory:\t$kat_outdir\n"
    kat comp -o "${kat_outdir}/${bin_name}.KAT_output" -t 2 -v -m 31 "$inpf_modified_name" "$input_bin"
    printf "Used KAT to analyse the bin file:\t$input_bin using read files:\t$inpf_1 and $inpf_2\nOutput should be written in the directory:\t$kat_outdir\n"
    #Now tidying up by finding and gzipping all files in the different directories
    cd "$mapping_outdir"
    targets_to_zip=$(find -maxdepth 1 -type f -not -name "*.gz")
    for f in $targets_to_zip
    do
        gzip "$f"
        printf "Gzipped file:\t$f\n" || printf "File $f not zipped, may no longer exist\n"
    done
}

#Going to the top output directory for convenience
cd "$scratch_dir"

#Running the functions sequentially
execute_QC "$inpf1" "$inpf2"
execute_bbduk "$QCed_R1" "$QCed_R2"
execute_SPAdes "$prokaryotic_R1" "$prokaryotic_R2"
#Not that this previously was using "$QCed_R1" "$QCed_R2" which might have been wrong
execute_metabat2_after_mapping "$prokaryotic_R1" "$prokaryotic_R2"
for f in $bin_fasta_files
do
    bin_target_file="$f"
    execute_checkm_bins "$bin_target_file"
    execute_prokka_bins_annotation "$bin_target_file"
    execute_mapping_reads_to_bin "$bin_target_file" "$prokaryotic_R1" "$prokaryotic_R2"
    execute_KAT_bin_analysis "$bin_target_file" "$prokaryotic_R1" "$prokaryotic_R2"
done

#Tidying up by gzipping things
cd "$QC_outdir"
targets_to_zip=$(find -maxdepth 1 -type f -not -name "*.gz")
for f in $targets_to_zip
do
    gzip "$f"
    printf "Gzipped file:\t$f\n"
done

#Moving the output directory from scratch
mv "${scratch_dir}/${run_ID}-${sampleID}" "$top_outdir"
