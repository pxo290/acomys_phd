#!/bin/bash -eE
#SBATCH -t 10-10:30
#SBATCH -p ei-largemem
#SBATCH -c 4
#SBATCH -J 2022-06-24_RS_trial_workflow
#SBATCH --mem=725gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-06-24_RS_trial_workflow-%A.out
#SBATCH -e /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-06-24_RS_trial_workflow-%A.err

#Modified on 2022-06-24
#Modifications are to remove hard coded filenames from the ones used for the initial
#testing and instead just use the files provided as arguments to the script so
#it can be used with multiple samples.

#Script overall started writing on 2022-05-14
#Written by Peter Osborne
#Written to test how much can be done metagenomically speaking with data provided
#by Rebecca Shaw of read files from mustelid sequencing - any genomes other than
#the mustelid itself are contaminants and are what I will attempt to pull out and
#examine. A number of eukaryotic genomes are used for BBDuk cleansing, mostly to
#try and remove any reads which aren't bacterial. In the future you might also
#include a fungus as well to cover that kingdom. Note also that all directories
#are made with the permission 755 since these need to be shared so I'm putting
#that option in now to hopefully make it easier in the future.

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
source package /tgac/software/production/bin/pigz-2.3.3 #Pigz version 2.3.3 for
#zipping some larger files we produce

#Setting fixed input variables for part 1 of the script
raw_inpf1=$(basename "$1")
raw_inpf2=$(basename "$2")
inpdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting"
base_sample_name=$(basename "$raw_inpf1" | awk -F "_" '{print $1"_"$2"_"$3}')

#Writing the function to execute the QC and host plus human cleanse
execute_QC_and_cleanse () {
  cd "$inpdir"
  #Getting the original raw input files
  func_inpf1="$1"
  func_inpf2="$2"
  sampleID=$(basename "$func_inpf1" | awk -F "_" '{print $1"_"$2"_"$3}')
  #Making a working and output directory
  mkdir -m 755 -p "QC_and_cleansed_files"
  cd "QC_and_cleansed_files"
  mkdir -m 755 -p "${sampleID}_QC_and_cleanse_file_outputs"
  cd "${sampleID}_QC_and_cleanse_file_outputs"
  outdir=$(pwd)
  cd "$inpdir"
  #Will make copies of the input files to avoid altering the originals
  cp "$func_inpf1" "${outdir}/Polecat_${sampleID}_R1.fastq"
  cp "$func_inpf2" "${outdir}/Polecat_${sampleID}_R2.fastq"
  #First up will do QC using FastP
  cd "$outdir"
  fastp --in1 "${outdir}/Polecat_${sampleID}_R1.fastq" --in2 "${outdir}/Polecat_${sampleID}_R2.fastq" --out1 "${outdir}/Polecat_${sampleID}_R1.QCed.fastq" --out2 "${outdir}/Polecat_${sampleID}_R2.QCed.fastq" --json "${outdir}/Polecat_${sampleID}.QCed.json" --html "${outdir}/Polecat_${sampleID}.QCed.html" --verbose --report_title "Polecat_${sampleID}-report"
  #Setting reference genome variables for the host, humans and other possible eukaryotes
  euro_polecat_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/European_Polecat_RefSeq_representative-GCF_011764305.1_ASM1176430v1.1_genomic.fna"
  domestic_ferret_assembly="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes/Domestica_ferret_GenBank_assembly_GCA_000215625.1_MusPutFur1.0_genomic.fa"
  human_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/GRCh38_latest_genomic.fna"
  mus_musculus_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/GCF_000001635.27_GRCm39_genomic.Mus_musculus.fna"
  euro_rabbit_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes/European_rabbit_GCF_000003625.3_OryCun2.0_genomic.fna"
  rock_pigeon_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes/Rock_pigeon_GCF_000337935.1_Cliv_1.0_genomic.fna"
  common_shrew_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes/Common_shrew_GCF_000181275.1_SorAra2.0_genomic.fna"
  rattus_rattus_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes/Rattus_rattus_GCF_011064425.1_Rrattus_CSIRO_v1_genomic.fna"
  chicken_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes/Chicken_GCF_016699485.2_bGalGal1.mat.broiler.GRCg7b_genomic.fna"
  euro_frog_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes/European_frog_GCF_905171775.1_aRanTem1.1_genomic.fa"
  common_wheat_genome="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/extra_ref_genomes/Common_wheat_GCF_018294505.1_IWGSC_CS_RefSeq_v2.1_genomic.fna"
  #Using BBTools from BBMap to simultaneously remove host and human matching reads
  #which in this case will be the overwhelming majority of them
  srun bbduk.sh -Xmx650g -Xms64g -prealloc in="Polecat_${sampleID}_R1.QCed.fastq" in2="Polecat_${sampleID}_R2.QCed.fastq" ref="$euro_polecat_genome","$human_genome","$mus_musculus_genome","$euro_rabbit_genome","$rock_pigeon_genome","$common_shrew_genome","$rattus_rattus_genome","$chicken_genome","$euro_frog_genome","$common_wheat_genome" outm="${outdir}/Polecat_${sampleID}.QCed.Host_or_human_matching.fastq" out="Polecat_${sampleID}_R1.QCed.Cleansed.fastq" out2="Polecat_${sampleID}_R2.QCed.Cleansed.fastq" overwrite=t stats="${outdir}/Polecat_${sampleID}-BBDuk_stats.txt"
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
  pigz -9 -p 4 "${outdir}/Polecat_${sampleID}_R1.QCed.fastq"
  pigz -9 -p 4 "${outdir}/Polecat_${sampleID}_R2.QCed.fastq"
  #Also really need to zip up the host/eukaryote matching reads fastq since it can
  #get really, really big
  pigz -9 -p 4 "${outdir}/Polecat_${sampleID}.QCed.Host_or_human_matching.fastq"
  #Noting that the function finished
  printf "\nCompleted a QC and cleanse function execution on input files:\t$func_inpf1 and $func_inpf2"
  printf "\nUsed the following genomes for cleansing:\t$euro_polecat_genome, $human_genome ,$mus_musculus_genome ,$euro_rabbit_genome ,$rock_pigeon_genome ,$common_shrew_genome ,$rattus_rattus_genome ,$chicken_genome and $common_wheat_genome\n"
}

#Exporting the QC and cleanse function
export -f execute_QC_and_cleanse

#Running the QC and cleanse function on the two unzipped trial files
execute_QC_and_cleanse "$raw_inpf1" "$raw_inpf2"

#Part 2 of the script will run Metaphlan, Kraken and Kaiju on the QC'ed and
#cleansed input read files

#Sourcing the classifiers
source package /tgac/software/testing/bin/kaiju-1.7.3 #Kaiju 1.7.3
source package 9020df39-c4ad-402b-b299-896159114bd7 #MetaPhlAn 3.0.10
source package /tgac/software/testing/bin/kraken2-2.0.8.r7127273 #Kraken2 2.0.8
source package /tgac/software/testing/bin/krona-2.7 #Krona 2.7 (to make nice plots from the results)

#Setting the fixed variables for input files and directory - this would need
#automation if being done again later on upon multiple sets of files rather
#than just giving the QC'ed and cleansed file names here
qced_cleansed_inpdir="${inpdir}/QC_and_cleansed_files/${sampleID}_QC_and_cleanse_file_outputs"
qced_cleansed_inpf1="${qced_cleansed_inpdir}/Polecat_${base_sample_name}_R1.QCed.Cleansed.fastq"
qced_cleansed_inpf2="${qced_cleansed_inpdir}/Polecat_${base_sample_name}_R2.QCed.Cleansed.fastq"
sample_ID=$(basename "$qced_cleansed_inpf1" | awk -F "_" '{print $1"_"$2"_"$3"_"$4}')

#Making the output directory
cd "$inpdir"
mkdir -m 755 -p "Taxonomic_classifier_output"
mkdir -m 755 -p "${inpdir}/Taxonomic_classifier_output/${sample_ID}_Taxonomic_classification_files"
cd "${inpdir}/Taxonomic_classifier_output/${sample_ID}_Taxonomic_classification_files"
classifier_outdir=$(pwd)
cd "$inpdir"

#Writing Metaphlan function
execute_metaphlan () {
  #As with the global fixed variables, here I am setting some hard-coded variables
  #for the sake of making the actual command neater
  metaphlan2_database_directory="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/metaphlan3"
  metaphlan2_pkl_file="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/metaphlan3/mpa_v30_CHOCOPhlAn_201901.pkl"
  metaphlan2_database_filename_string="mpa_v30_CHOCOPhlAn_201901"
  read1file="$1"
  read2file="$2"
  read1name=$(basename "$read1file" .fastq)
  read2name=$(basename "$read2file" .fastq)
  metaphlan2outdir="$3"
  samplename="$4"
  printf "\nWill now run Metaphlan3 on the paired-end fastq files:\t$read1file and $read2file\n"
  printf "\nWill use this Metaphlan3 database directory:\t$metaphlan2_database_directory\n"
  metaphlan --input_type fastq -x "$metaphlan2_database_filename_string" -t rel_ab_w_read_stats "$read1file","$read2file" --bowtie2out "HOLDINGBOWTIE2_${read1name}_and_${read2name}.txt" --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db "$metaphlan2_database_directory" --nproc 4 > "${metaphlan2outdir}/${samplename}_Metaphlan2-output_abundance_and_read_counts.txt"
  #Removing the Bowtie2 mapping file to save space, though this means it will
  #need to be recreated again with each run so comment out following command if
  #you would prefer to keep it
  rm "HOLDINGBOWTIE2_${read1name}_and_${read2name}.txt"
}

#Exporting the Metaphlan function
export -f execute_metaphlan

#Writing the Kaiju function
execute_kaiju () {
  #As with the global fixed variables, here I am setting some hard-coded variables
  #for the sake of making the actual command neater
  kaiju_database_directory="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju"
  kaiju_nodes="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/nodes.dmp"
  kaijudbfile="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/kaiju_db_nr_euk.fmi"
  kaiju_names="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kaiju/names.dmp"
  read1file="$1"
  read2file="$2"
  read1name=$(basename "$read1file" .fastq)
  read2name=$(basename "$read2file" .fastq)
  kaijuoutdir="$3"
  samplename="$4"
  errors_allowed="1"
  export kaiju_taxa_array=("phylum" "class" "order" "family" "genus" "species")
  kaiju_report_outdir="$kaijuoutdir"
  printf "\nWill now run Kaiju on the paired-end fastq files:\t$read1file and $read2file\n"
  printf "\nWill use this nodes file:\t$kaiju_nodes\n"
  printf "\nWill use this names file:\t$kaiju_names\n"
  printf "\nWill use this Kaiju database file:\t$kaijudbfile\n"
  kaiju -t "$kaiju_nodes" -f "$kaijudbfile" -i "$read1file" -j "$read2file" -e "$errors_allowed" -x -v -z 4 -o "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.out"
  printf "\nNow will use the Kaiju-addTaxonNames feature to add taxon names to the ends of the classified read results\n"
  kaiju-addTaxonNames -t "$kaiju_nodes" -n "$kaiju_names" -p -i "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.out" -o "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.Taxon_names_added.out"
  printf "\nNow will use the Kaiju2table feature from Kaiju to get an output file which has the actual taxon names in it\n"
  export input_kaiju_file="${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.Taxon_names_added.out"
  for i in "${kaiju_taxa_array[@]}"
  do
    taxon_level="$i"
    printf "\nWill use kaiju2table on input file: $input_kaiju_file\twith taxonomic level: $taxon_level\n"
    kaiju2table -t "$kaiju_nodes" -n "$kaiju_names" -v -r "$taxon_level" -o "${kaiju_report_outdir}/${samplename}-Kaiju2table_${errors_allowed}_errors_allowed-${taxon_level}_level_results.tsv" "$input_kaiju_file"
    printf "\nRan kaiju2table on input file: $input_kaiju_file\twith taxonomic level: $taxon_level\n"
  done
  #Now will use Krona to make some interactive html plots in a two step process
  printf "\nRunning Kaiju2krona to produce a text file for import to Krona\n"
  kaiju2krona -t "$kaiju_nodes" -n "$kaiju_names" -i "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.out" -o "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.krona"
  #Having made the converted version of the Kaiju output we now use Krona to make
  #the html file
  printf "\nWill now use Krona to produce an interactive html file from the Kaiju output\n"
  ktImportText -o "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.Krona_version.html" "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.krona"
  #Zipping up the Kaiju outputs, and Krona version, to save some space
  printf "\nWill gzip the Kaiju output files which only have the taxonIDs in it to save a little bit of space\n"
  gzip "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.out"
  gzip "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.krona"
}

#Exporting the Kaiju function
export -f execute_kaiju

#Writing the Kraken function
execute_kraken () {
  #As with the global fixed variables, here I am setting some hard-coded variables
  #for the sake of making the actual command neater
  krakendir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2021_12_31_Paper_1-Chapter_1_Benchmarking_and_pilot_files/reference_genomes/classifier_databases/kraken2"
  read1file="$1"
  read2file="$2"
  read1name=$(basename "$read1file" .fastq)
  read2name=$(basename "$read2file" .fastq)
  krakenoutdir="$3"
  samplename="$4"
  confidence_score="0.75"
  confidence_score_without_period=$(echo "$confidence_score" | tr -d ".")
  printf "\nWill now run Kraken2 on the paired-end fastq files:\t$read1file and $read2file\n"
  printf "\nWill use this Kraken2 database directory:\t$krakendir\n"
  printf "\nWill use $confidence_score as the confidence score threshold for Kraken2\n"
  kraken2 --paired --db "$krakendir" --threads 4 --use-names --confidence "$confidence_score" --unclassified-out "${krakenoutdir}/Unclassified_Kraken2_${read1name}.${confidence_score_without_period}_conf_score#.txt" --classified-out "${krakenoutdir}/Classified_Kraken2_${read1name}.${confidence_score_without_period}_conf_score#.txt" "$read1file" "$read2file" --report "${krakenoutdir}/${samplename}_Kraken2-${confidence_score_without_period}_report.txt"
  #Will now zip the classifed and unclassified raw outputs since they can take up a fair bit of space sometimes
  gzip "${krakenoutdir}/Unclassified_Kraken2_${read1name}.${confidence_score_without_period}_conf_score_1.txt"
  gzip "${krakenoutdir}/Unclassified_Kraken2_${read1name}.${confidence_score_without_period}_conf_score_2.txt"
  gzip "${krakenoutdir}/Classified_Kraken2_${read1name}.${confidence_score_without_period}_conf_score_1.txt"
  gzip "${krakenoutdir}/Classified_Kraken2_${read1name}.${confidence_score_without_period}_conf_score_2.txt"
  #Will now use Krona to make a nice, interactive html version of the Kraken report
  printf "\nWill now use Krona to produce an interactive html file from the Kraken report output\n"
  ktImportTaxonomy -m 3 -t 5 "${krakenoutdir}/${samplename}_Kraken2-${confidence_score_without_period}_report.txt" -o "${krakenoutdir}/${samplename}_Kraken2-${confidence_score_without_period}_report.Krona_version.html"
}

#Exporting Kraken function
export -f execute_kraken

#Will run the classifier functions sequentially, Metaphlan then Kaiju and finally
#Kraken
execute_metaphlan "$qced_cleansed_inpf1" "$qced_cleansed_inpf2" "$classifier_outdir" "$sample_ID"
printf "\nRan the Metaphlan function\n"
execute_kaiju "$qced_cleansed_inpf1" "$qced_cleansed_inpf2" "$classifier_outdir" "$sample_ID"
printf "\nRan the Kaiju function\n"
execute_kraken "$qced_cleansed_inpf1" "$qced_cleansed_inpf2" "$classifier_outdir" "$sample_ID"
printf "\nRan the Kraken function\n"

#Part 3 of the script will use metaSPADES to produce assemblies from the reads left
#over after QC and host/human cleansing,then it will use BBTools from BBMap to
#remove contigs below 500bp in size before (hopefully) something can be found to
#bin them in the future. Seqtk will then be used to make the assembly file a single
#line fasta file rather than multi-line one.

#Sourcing software
source package 3a579940-1cba-4d60-86ef-43b8705935fb # SPADES version 3.13.1
source package /tgac/software/testing/bin/bbmap-38.06 #Same as above, version
# 38.06
source package seqtk-git20160921 #Version 1.2-r95-dirty

#Writing the metaSPADES function
execute_metaSPADES () {
  assembly_inpf1="$1"
  assembly_inpf2="$2"
  assembly_label="$3"
  assembly_output_dir="$4"
  #First the assembly step
  printf "\nWill use metaSPADES v 3.13.1 to produce an assembly from processed PE read files:\t$assembly_inpf1 and $assembly_inpf2\n"
  spades.py --meta --threads 4 --memory 500 -o "$assembly_output_dir" -1 "$assembly_inpf1" -2 "$assembly_inpf2"
  printf "\nUsed metaSPADES v 3.13.1 to produce an assembly from processed PE read files:\t$assembly_inpf1 and $assembly_inpf2\n"
  #Now to make a version of the assemly with only contigs over 500kb in length,
  #will be using the contig fasta file rather than the scaffold one thought
  cd "$assembly_output_dir"
  target_min_contig_size="500"
  contig_assembly_file="${assembly_output_dir}/contigs.fasta"
  printf "\nWill now use BBTools to remove contigs below $target_min_contig_size bp in length from file:\t$contig_assembly_file\n"
  printf "\nWill also take the chance to add the sampleID to the output file, namely:\t$assembly_label\n"
  reformat.sh in="$contig_assembly_file" out="${contig_assembly_file}.Contigs_${target_min_contig_size}bp.fa" minlength="$target_min_contig_size"
  #Making the a version of the contig assembly file which is single line
  printf "\nUsing Seqtk to make a single line version of file:\t${contig_assembly_file}.Contigs_${target_min_contig_size}bp.fa which will be called:\t${assembly_label}_Contigs_${target_min_contig_size}bp.single_line.fa\n"
  seqtk seq -l0 "${contig_assembly_file}.Contigs_${target_min_contig_size}bp.fa" > "${assembly_output_dir}/${assembly_label}_Contigs_${target_min_contig_size}bp.single_line.fa"
  printf "\nWill save a little bit of space by zipping up all the fasta files produced by SPADES excluding the one we just made which has contigs of at least 500bp in length\n"
  find -maxdepth 2 -type f -name "*.fasta" -not -name "*${assembly_label}*" -exec gzip {} \;
  #Making a variable which will be exported containing the name of the single
  #line, minimum size contig file
  export fetch_assembly_single_line_min_contig_size="${assembly_output_dir}/${assembly_label}_Contigs_${target_min_contig_size}bp.single_line.fa"
  #Will add in a check here which will end the script if there was no assembly
  #file single line version which actually contains content
  if [ -s "$fetch_assembly_single_line_min_contig_size" ]
  then
    printf "Single line assembly file containing content exists, called:\t$fetch_assembly_single_line_min_contig_size\n"
  else
    printf "No single line assembly file containing content exists\nThere may be a file called $fetch_assembly_single_line_min_contig_size but it does not contain anything\nThis may, or may not be an error\nWill now end the script\n"
    sleep 2m
    exit 0
  fi
}

#Exporting the metaSPADES function
export -f execute_metaSPADES

#Making the assembly output directory
mkdir -m 755 -p "${inpdir}/Assembly_output/${sample_ID}"
assembly_outdir="${inpdir}/Assembly_output/${sample_ID}"

#Running the metaSPADES function
execute_metaSPADES "$qced_cleansed_inpf1" "$qced_cleansed_inpf2" "$sample_ID" "$assembly_outdir"

#Part 3.5 of the script will use a downloaded docker image containing MaxBin2
#version 2.2.4 from https://hub.docker.com/r/pegi3s/maxbin2
#Their citation is below for any time it is appropriate
#"The authors wish to thank to the Bioinformatics Docker Images Project (https://pegi3s.github.io/dockerfiles/) and to the BioData.pt Project (https://biodata.pt)".
#H. López-Fernández; P. Ferreira; M. Reboiro-Jato; C.P. Vieira; J. Vieira (2021) The pegi3s Bioinformatics Docker Images Project. 15th International Conference on Practical Applications of Computational Biology & Bioinformatics: PACBB 2021. Salamanca, Spain. 6 - October DOI

#Setting the docker image path
maxbin2_directory="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/maxbin2_docker_analysis_and_image"
docker_2_image_path="${maxbin2_directory}/2022-07-08_MaxBin2_from_pegi3s_dockerhub.img"

#Making an output directory for the MaxBin2 output
mkdir -m 755 -p "$maxbin2_directory/${sample_ID}_MaxBin2_output"
#Making a temporary directory containing the QCed read files and assembly made
#from it (the single line, minimum contig size version anyway)
mkdir -m 755 -p "$maxbin2_directory/${sample_ID}_MaxBin2_tempdir"

#Copying in the files so we can work on them without worry
cp "$fetch_assembly_single_line_min_contig_size" "$maxbin2_directory/${sample_ID}_MaxBin2_tempdir"
cp "$qced_cleansed_inpf1" "$maxbin2_directory/${sample_ID}_MaxBin2_tempdir"
cp "$qced_cleansed_inpf2" "$maxbin2_directory/${sample_ID}_MaxBin2_tempdir"

#Setting the variables to be used with the MaxBin2 function - this is a risky and
#lazy bit of code below, only works provided all the sample IDs are unique so it
#can just use a wildcard in the appropriate directory
cd "$maxbin2_directory/${sample_ID}_MaxBin2_tempdir"
bin_work_dir=$(pwd)
bin_contig_file=$(find -maxdepth 1 -type f -name "$sample_ID*Contigs_*bp.single_line.fa" -printf '%f\n')
bin_inpf1=$(find -maxdepth 1 -type f -name "$sample_ID*R1.QCed.Cleansed.fastq" -printf '%f\n')
bin_inpf2=$(find -maxdepth 1 -type f -name "$sample_ID*R2.QCed.Cleansed.fastq" -printf '%f\n')

#Writing the MaxBin2 docker function
execute_maxbin2_docker_version () {
  maxbin2_docker_image="$1"
  contig_file="$2"
  read_file_1="$3"
  read_file_2="$4"
  input_directory="$5"
  sampleID="$6"
  output_directory="$7"
  printf "\Will use the docker image containing MaxBin2: $maxbin2_docker_image to bin the contigs file: $contig_file with read files: $read_file_1 and $read_file_2 from the input directory: $input_directory and writing output to: $output_directory\n"
  #Note the min contig length flag is set here to the default, 1000bp but that
  #would be what I would be wanting anyway. You could have done this with the
  #seqtk step in the assembly function but either way this will mean the bin(s)
  #should only contain contigs which are at least 1000bp long
  singularity exec "$maxbin2_docker_image" run_MaxBin.pl -contig "$contig_file" -reads "$read_file_1" -reads2 "$read_file_2" -min_contig_length 1000 -out "${output_directory}/${sampleID}.MaxBin2_output"
  printf "\nUsed the docker image containing MaxBin2: $maxbin2_docker_image to bin the contigs file: $contig_file with read files: $read_file_1 and $read_file_2 from the input directory:\t$input_directory and wrote output to:\t$output_directory\n"
  #Amongst the files MaxBin2 produces are .fasta files of the bins, but these are
  #multi-line fastas rather than single line ones. So again we will need to make
  #single line versions of them and zip the multi-line ones. Since you don't know
  #how many bins will be produced I will use a find to get them all and then just
  #a for loop over them to do the single-line and zipping
  cd "$output_directory"
  target_bin_files=$(find -maxdepth 1 -type f -name "$sampleID*MaxBin2_output*.fasta" -printf '%f\n')
  for f in $target_bin_files
  do
    printf "\nWill turn input file:\t$f into a single line fasta file then gzip the original file to save some space\n"
    bin_single_line_fasta_conversion_loop_input="$f"
    bin_single_line_fasta_convesion_loop_file_name=$(basename "$f")
    seqtk seq -l0 "$bin_single_line_fasta_conversion_loop_input" > "${bin_single_line_fasta_convesion_loop_file_name}.single_line.fasta"
    pigz -9 -p 4 "$bin_single_line_fasta_conversion_loop_input"
  done
  cd "$output_directory"
  #Below will be used afterwards, outside the function to see if there are any
  #fasta bins produced and decide whether or not to run the bin QC functions
  bin_check_count=$(find -maxdepth 1 -type f -name "*$sampleID*.single_line.fasta" | wc -l)
}

#Exporting the MaxBin2 docker function
export -f execute_maxbin2_docker_version

#Turns out that MaxBin2 can fail to bin the assembly, which is understandable
#since there might only have been a few thousands of reads which weren't host
#or contaminant left after BBDuk cleansing. As such we need to change the script
#so that it will produce a variable if the binning step fails and then will only
#carry out the bin check functions if that variable does not exist

#Running the MaxBin2 docker function
execute_maxbin2_docker_version "$docker_2_image_path" "$bin_contig_file" "$bin_inpf1" "$bin_inpf2" "$bin_work_dir" "$sample_ID" "$maxbin2_directory/${sample_ID}_MaxBin2_output" || printf "Binning MAY have failed for some reason, potentially a valid one due to the assemblies being too small from a very limited number of non-eukaryotic reads\n"

#Checking if the binning worked by looking at the bin check count variable, if it
#is zero then binning failed (or the single line conversion). If it is not zero
#then binning and single line conversion worked.
if [[ "$bin_check_count" -eq 0 ]]
then
  printf "Either binning FAILED on files:\t$bin_contig_file, $bin_inpf1 and $bin_inpf2\nOR the single line fasta conversion failed on any bins it did generate\nThere may be scientifically legitimate reasons for binning failure, such as there being too few non-eukaryotic reads to begin with anyway. Will end script now\n"
  sleep 2m
  cd "$inpdir"
  rm -r "$bin_work_dir"
  exit 0
else
  printf "Binning succeeded on files:\t$bin_contig_file, $bin_inpf1 and $bin_inpf2\nProceeding with the bin check steps\n"
fi

#Removing the maxbin temporary directory
cd "$inpdir"
rm -r "$bin_work_dir"

#Part 4 of the script will run CheckM and GTDB-TK on the bins produced by MaxBin2
#running from a docker image - though it does some checks itself and reports these

#Sourcing software
source package 4041d3fc-f42e-48e0-afce-7314f4c87de6 #GTDB-TK 2.0.0
source package bceb1286-ad72-4764-aaf7-111f51a37080 #CheckM 1.1.2

#Making an output directory
cd "$inpdir"
mkdir -m 755 -p "Bin_checks_output"
cd "Bin_checks_output"
bin_checks_outdir="${sample_ID}_bin_checks_outputs"
mkdir -m 755 -p "$bin_checks_outdir"
cd "${sample_ID}_bin_checks_outputs"
bin_checks_outdir=$(pwd)

#Getting the input files and directory
cd "$maxbin2_directory/${sample_ID}_MaxBin2_output"
bin_check_input_dir=$(pwd)
bin_check_input_files=$(find -maxdepth 1 -type f -name "$sample_ID*.single_line.fasta" -not -name "*.gz")

#Writing a function to run CheckM
execute_checkM () {
  checkM_inpdir="$1"
  checkM_label="$2"
  checkM_outdir="${3}/${checkM_label}_CheckM_output"
  #Note that CheckM by default assumes your files are .fna files, so you need to
  #use the -x flag to give the .fasta extension since the MaxBin2 output files
  #have that extension, as do the multi-line versions used made.
  #Running the CheckM taxonomy step first, to produce the files needed for the QA
  #step
  printf "\nStarting the CheckM lineage_wf execution on all MaxBin2 .fasta bin files from directory:\t$checkM_inpdir\n"
  checkm lineage_wf -t 2 -x fasta "$checkM_inpdir" "$checkM_outdir"
  #Now will run the CheckM QA step
  cd "$checkM_outdir"
  #Finding the lineage file - which should just be called lineage.ms since we don't
  #re-name it in the script so far
  target_lineage_file=$(find -maxdepth 1 -type f -name "*lineage*.ms" -printf '%f\n')
  #Setting the output directory for the QA step, and making it if it doesn't already exist
  qa_output_file_dir="$checkM_outdir"
  #Now running the QA step
  printf "\nStarting the CheckM QA step\n"
  checkm qa -o 2 -f "${checkM_outdir}/${sample_ID}_CheckM_QA_check_all_MaxBin2_bins.out" "$target_lineage_file" "$qa_output_file_dir"
  printf "\nCompleted CheckM execution on all MaxBin2 .fasta bin files from directory:\t$checkM_inpdir\n"
}

#Exporting the CheckM function
export -f execute_checkM

#Writing a function to run GTDB-TK
execute_GTDBTK () {
  #Setting an environmental variable that it needs, which is the location of the
  #downloaded and unpacked database files
  export GTDBTK_DATA_PATH="/ei/.project-scratch/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/2022-02-12_Paper_2-Chapter_2_Actual_taxonomy_and_function_as_well_as_mapping/gtdb_tk_database/release202"
  GTDBTK_inpdir="$1"
  GTDBTK_label="$2"
  GTDBTK_outdir="${3}/${GTDBTK_label}_GTDB-TK_output"
  top_tempdir="$4"
  #Running the classify_wf workflow
  printf "\nStarting a classify_wf workflow with GTDB-TK on all MaxBin2 .fasta bin files from directory:\t$GTDBTK_inpdir"
  #gtdbtk classify_wf --genome_dir "$GTDBTK_inpdir" --out_dir "${GTDBTK_outdir}/GTDB-TK_classify_wf_output" --cpus 4 -x fasta --min_perc_aa 10 --min_af 0.65 --tmpdir "$top_tempdir" --scratch_dir "$top_tempdir"
  gtdbtk classify_wf --genome_dir "$GTDBTK_inpdir" --out_dir "${GTDBTK_outdir}/GTDB-TK_classify_wf_output" --cpus 4 -x fasta --min_perc_aa 10 --min_af 0.65
  printf "\nFinished a classify_wf workflow with GTDB-TK on all MaxBin2 .fasta bin files from directory:\t$GTDBTK_inpdir"
}

#Exporting the GTDB-TK function
export -f execute_GTDBTK

#Running the CheckM function, then the GTDB-TK function
execute_checkM "$bin_check_input_dir" "$sample_ID" "$bin_checks_outdir"
execute_GTDBTK "$bin_check_input_dir" "$sample_ID" "$bin_checks_outdir" "$inpdir"

#As of the time of writing, 2022-06-24, GTDB-TK on the cluster seems to have
#stopped working for some reason; files aren't found in the database which it
#claims to need even though I've not myself knowingly deleted any
