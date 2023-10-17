#!/bin/bash -eE
#SBATCH -t 03-12:30
#SBATCH -p ei-largemem
#SBATCH -c 4
#SBATCH -J 2022-05-14_RS_trial_script_part_2_Taxonomic_classifiers
#SBATCH --mem=625gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-05-14_RS_trial_script_part_2_Taxonomic_classifiers-%A.out
#SBATCH -e /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-05-14_RS_trial_script_part_2_Taxonomic_classifiers-%A.err

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
#source package /tgac/software/testing/bin/fastp-20190305 #FastP for QC
#source package /tgac/software/testing/bin/bbmap-38.06 #BBMap to use BBTools for
#cleansing

#Setting fixed input variables for part 1 of the script
#raw_inpf1="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R1.fastq"
#raw_inpf2="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/R0786-S0015_VWT837_A64353_1_HY5VJDSX2_TAACGAAGT-TAACGAAGT_L003_R2.fastq"
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
#export -f execute_QC_and_cleanse

#Running the QC and cleanse function on the two unzipped trial files
#execute_QC_and_cleanse "$raw_inpf1" "$raw_inpf2"

#Part 2 of the script will run Metaphlan, Kraken and Kaiju on the QC'ed and
#cleansed input read files

#Sourcing the classifiers
source package /tgac/software/testing/bin/kaiju-1.7.3 #Kaiju 1.7.3
source package 9020df39-c4ad-402b-b299-896159114bd7 #MetaPhlAn 3.0.10
source package /tgac/software/testing/bin/kraken2-2.0.8.r7127273 #Kraken2 2.0.8

#Setting the fixed variables for input files and directory - this would need
#automation if being done again later on upon multiple sets of files rather
#than just giving the QC'ed and cleansed file names here
qced_cleansed_inpdir="${inpdir}/QC_and_cleansed_files"
qced_cleansed_inpf1="${qced_cleansed_inpdir}/Polecat_R0786-S0015_VWT837_A64353_R1.QCed.Cleansed.fastq"
qced_cleansed_inpf2="${qced_cleansed_inpdir}/Polecat_R0786-S0015_VWT837_A64353_R2.QCed.Cleansed.fastq"
sample_ID=$(basename "$qced_cleansed_inpf1" | awk -F "_" '{print $1"_"$2"_"$3"_"$4}')

#Making the output directory
cd "$inpdir"
mkdir -p "Taxonomic_classifier_output"
cd "Taxonomic_classifier_output"
classifier_outdir=$(pwd)

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
  printf "\nWill gzip the Kaiju output which only has the taxonIDs in it to save a little bit of space\n"
  gzip "${kaijuoutdir}/${samplename}.Kaiju_output_${errors_allowed}_allowed_errors.out"
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
