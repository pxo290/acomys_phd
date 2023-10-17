#!/bin/bash -eE
#SBATCH -t 02-18:30
#SBATCH -p ei-medium
#SBATCH -c 2
#SBATCH -J 2023-03-21_megahit_cleansed_reads_trial
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/slurm_outputs/2023-03-21_megahit_cleansed_reads_trial-%A.out
#SBATCH -e /ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/slurm_outputs/2023-03-21_megahit_cleansed_reads_trial-%A.err

#Written on 2023-03-21
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Trial script to use the cleansed but not subsampled Acomys read files, assemble them individually with Megahit and then bin them with MetaBat2.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-03-21_megahit_cleansed_reads_trial.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Failed running Megahit trial function on hard-coded AR38J cleansed\n"
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export input_dir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/bbduk_outputs/cleansed_files"
export top_outdir="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/Acomys_cleansed_reads_individual_assemblies_and_bins"
export top_scratch_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/scratch"
export megahit_docker_image="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4/2022-04-05_Extra_or_side_stuff/RS_experimenting/Docker_images/megahit_v1_2_9_docker_image.img" #Megahit v.1.2.9

#Sourcing software
source package 5a1c6a9a-f666-4eaa-9409-3e7435d86406 #CheckM 1.2.0
source package 0a2dffce-c151-4379-abe9-866414c91cd7 #MetaBAT 2.15
source package 222eac79-310f-4d4b-8e1c-0cece4150333 #Minimap2 2.23-41122
source package 758be80b-33cc-495a-9adc-11882ab145b1 #Samtools 1.10
source package /tgac/software/testing/bin/seqtk-1.0 #Seqtk 1.0

#Writing function to assemble and then bin reads
execute_assemble_and_bin () {
    inpf1="$1"
    inpf2="$2"
    label="$3"
    #Since Megahit will not allow the overwriting of the output directory, as a precaution I will add in two lines here to try and remove the temp and output directories
    temp_dir="${top_scratch_dir}/${label}_working_dir"
    #rm -r "$temp_dir" || printf "Working directory did not already exist\n"
    mkdir -m 755 -p "$temp_dir"
    assembly_outdir="${top_outdir}/${label}/Megahit_output"
    #rm -r "$assembly_outdir" || printf "Output directory did not already exist\n"
    mkdir -m755 -p "${top_outdir}/${label}"
    #First the assembly with Megahit
    printf "Will assemble read files:\t$inpf1 and $inpf2 with Megahit\nOutput will be written to:\t$assembly_outdir\nOutput will be labelled with:\t$label\nWorking directory will be:\t$temp_dir\n"
    #Explaining flags
    #   --memory    Setting max memory to use as proportion
    #   --num-cpu-threads   Setting max cpu threads to use
    #   --out-dir    Output directory
    #   --out-prefix    Output file prefix
    #   --tmp-dir Temporary directory, remember to have a line later deleting this
    #   --k-list    List of kmer sizes, comma separated. Most are taken from https://peerj.com/articles/13084/#materials|methods
    #   -1 & -2 Gives the R1 and R2 files
    singularity exec "$megahit_docker_image" megahit --memory 0.75 --num-cpu-threads 2 --out-dir "$assembly_outdir" --out-prefix "${label}.Megahit_output" --tmp-dir "$temp_dir" --k-list 25,43,67,87,101,127,145,173 -1 "$inpf1" -2 "$inpf2"
    printf "Should have assembled read files:\t$inpf1 and $inpf2 with Megahit\nOutput should be written to:\t$assembly_outdir\nOutput should be labelled with:\t$label\nWorking directory was:\t$temp_dir\n"
    #Next up, in order to bin with metabat we need to map the reads used to make the assembly to it.
    #Will use Minimap2 in order to do this - will also use this to only bin with contigs which have at least 1,000bp mapping - following https://peerj.com/articles/13084/#materials|methods again
    assembly_contigs="${assembly_outdir}/${label}.Megahit_output.contigs.fa"
    assembly_scaffold="$assembly_contigs" #For now anyway doing this
    #Running Minimap2
    printf "Mapping input read files:\t$inpf1 and $inpf2 to the created assembly scaffold file:\t\n"
    #Explaining flags
    #   -ax Setting preset to short read
    #   -t  Setting number of threads
    minimap2 -ax sr -t 2 "$assembly_scaffold" "$inpf1" "$inpf2" > "${temp_dir}/${label}.Minimap2_mapping.sam"
    #Will turn the sam file into a bam file and delete the sam file to save space
    assembly_mapping_sam="${temp_dir}/${label}.Minimap2_mapping.sam"
    printf "Now will turn the generated sam file $assembly_mapping_sam into a BAM file then delete the SAM file\n"
    #Explaining flags
    #   -@  Setting number of threads to 2
    #   -b  Setting desired output to .bam
    #   -S  Setting input file type to .sam
    samtools view -@ 2 -b -S "$assembly_mapping_sam" > "${temp_dir}/${label}.Minimap2_mapping.bam"
    rm "$assembly_mapping_sam"
    #Will get the mapping coverage before any filtering as a baseline
    printf "Will get the mapping coverage for reads $inpf1 and $inpf2 from ${temp_dir}/${label}.Minimap2_mapping.bam\n"
    samtools flagstat -@ 2 "${temp_dir}/${label}.Minimap2_mapping.bam" > "${assembly_outdir}/${label}.Minimap2.Samtools_flagstat_output.txt"
    #Now need to sort then index the bam file to get the mapping counts per contig using samtools idxstats
    #Explaining flags which differ from the other samtools commands
    #   -l  Setting compression level of output to 0
    #   -m  Setting allowed memory to 8G at most
    #   -O Setting output file type to .bam
    samtools sort -@ 2 -l 0 -m 4G -O BAM "${temp_dir}/${label}.Minimap2_mapping.bam" > "${temp_dir}/${label}.Minimap2_mapping.Sorted.bam"
    #Explaining flags which differ from the other samtools commands
    #   -b Set output to be .bai files, is default
    samtools index -b -@ 2 "${temp_dir}/${label}.Minimap2_mapping.Sorted.bam"
    #Now the idxstats bit
    samtools idxstats -@ 2 "${temp_dir}/${label}.Minimap2_mapping.Sorted.bam" > "${assembly_outdir}/${label}.Minimap2.Samtools.Sorted.idxstats_output.txt"
    #Now will use samtools coverage to get the contigs with at least 1,000 bases mapping to them (note bases not read counts) into a list
    samtools coverage "${temp_dir}/${label}.Minimap2_mapping.Sorted.bam" > "${tempdir}/${label}.Minimap2_mapping.Sorted_bam.Samtools_coverage_output.tsv"
    awk -F "\t" '$5 >= 1000 {print $1}' "${tempdir}/${label}.Minimap2_mapping.Sorted_bam.Samtools_coverage_output.tsv" | grep -v "#" > "${tempdir}/${label}.Minimap2_mapping.Sorted_bam.Samtools_coverage.Contigs_min_1000bp_coverage.txt"
    #Now moving the made text files into the assembly outdir
    mv "${tempdir}/${label}.Minimap2_mapping.Sorted_bam.Samtools_coverage_output.tsv" "$assembly_outdir"
    mv "${tempdir}/${label}.Minimap2_mapping.Sorted_bam.Samtools_coverage.Contigs_min_1000bp_coverage.txt" "$assembly_outdir"
    #Now getting the contigs out of the assembly according to the list just made using Seqtk
    seqtk subseq "${assembly_outdir}/${label}.Minimap2_mapping.Sorted_bam.Samtools_coverage.Contigs_min_1000bp_coverage.txt" "$assembly_contigs" > "${assembly_outdir}/${label}.Megahit_output.min_1kbp_mapped.contigs.fa"
    #Now zipping the sorted bam file to save space
    gzip "${temp_dir}/${label}.Minimap2_mapping.Sorted.bam"
    #Now moving the zipped and sorted bam file and index file to the assembly outdir
    mv "${temp_dir}/${label}.Minimap2_mapping.Sorted.bam.gz" "$assembly_outdir"
    mv "${temp_dir}/${label}.Minimap2_mapping.Sorted.bam.bai" "$assembly_outdir" || printf "Moving index file ${temp_dir}/${label}.Minimap2_mapping.Sorted.bam.bai failed\n"

    #Removing the temporary work directory
    rm -r "$temp_dir" || printf "Temporary directory $temp_dir was already deleted\n"
}

#Exporting function
export -f execute_assemble_and_bin

#Running function using fixed values for the trial
execute_assemble_and_bin "${input_dir}/AR38J.QCed.Cleansed.R1.fq" "${input_dir}/AR38J.QCed.Cleansed.R2.fq" AR38J.cleansed || printf "Failed running Megahit trial function on hard-coded AR38J cleansed\n"
