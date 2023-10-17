#!/bin/bash -e
#SBATCH -t 02-12:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J 2022-05-16_JORG_trial_on_RS_sourced_MAG
#SBATCH --mem=128gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-05-16_JORG_trial_RS_sourced_MAG-%A.out
#SBATCH -e /ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/slurm_outputs/2022-05-16_JORG_trial_RS_sourced_MAG-%A.err

#Script written on 2022-06-08
#Written by Peter Osborne

#This script is meant to test the JORG program, this time using actual MAGs made
#from assembly and then binning of reads provided by Rebecca Shaw. The reads were
#assembled using metaSPADES and then binned using MaxBin. The hope here is that
#JORG will have a better time using actual MAGs than the isolate testing being
#done previously.

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing JORG in the CIS testing staging
source /ei/software/staging/RCSUPPORT-430/stagingloader

#Setting some fixed variables
trial_assembly="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/maxbin2_docker_analysis_and_image/Polecat_R0786-S0015_VWT837_A64353_MaxBin2_output/Polecat_R0786-S0015_VWT837_A64353.MaxBin2_output.001.fasta"
#This assembly has 59 contigs at the moment
read_file_1="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/QC_and_cleansed_files/Polecat_R0786-S0015_VWT837_A64353_R1.QCed.Cleansed.fastq"
read_file_2="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/QC_and_cleansed_files/Polecat_R0786-S0015_VWT837_A64353_R2.QCed.Cleansed.fastq"
outdir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237/scratch/2022-04-05_Extra_or_side_stuff/RS_experimenting/JORG"
samplename="Polecat_R0786-S0015_VWT837_A64353"
#trial_assembly=$(echo "${proto_trial_assembly%.*}")
#You would need to automate the sample name getting in the future

#2022-06-08
#New error from trying this, 'Std exception caught. Message: locale::facet::_S_create_c_locale name not valid'
#Trying this to fix it:
export LC_ALL=C

#Writing a function to run JORG
execute_jorg () {
  input_assembly_file="$1"
  input_reads_file1="$2"
  input_reads_file2="$3"
  sampleID="$4"
  jorg_outdir="$5"
  #It turns out that JORG creates a log file itself and names it
  #just using the name of the assembly input - which in your case was a path.
  #This means you will need to copy the input files into the working/output
  #directory and get them into new variables using just their names
  #Also seems that it literally cannot handle .fq as the extension, it needs .fastq
  #though this could be zipped
  cp "$input_assembly_file" "$jorg_outdir"
  cp "$input_reads_file1" "$jorg_outdir"
  cp "$input_reads_file2" "$jorg_outdir"
  cd "$jorg_outdir"
  proto_assembly_file=$(basename "$input_assembly_file")
  mv "$proto_assembly_file" "${jorg_outdir}/${sampleID}_bin_01.fasta"
  assembly_file=$(basename "${jorg_outdir}/${sampleID}_bin_01.fasta")
  proto_reads_file1=$(basename "$input_reads_file1")
  proto_reads_file2=$(basename "$input_reads_file2")
  new_r1_name="$proto_reads_file1"
  new_r2_name="$proto_reads_file2"
  #You apparently need to produce a MIRA manifest file yourself, as despite the
  #github page indicating that the script should do this, it doesn't.
  printf "project = $sampleID\n" > "${jorg_outdir}/manifest_template.conf"
  printf "job = genome,denovo,accurate\n" >> "${jorg_outdir}/manifest_template.conf" #Note that I am getting these from http://mira-assembler.sourceforge.net/docs/DefinitiveGuideToMIRA.html#sect_dn_ge_writing_a_simple_manifest_file so might be wrong for JORG
  printf "parameters = -CO:fnic=yes\n" >> "${jorg_outdir}/manifest_template.conf"
  printf "parameters = -AS:nop=6:sdlpo=no\n" >> "${jorg_outdir}/manifest_template.conf"
  printf "parameters = -OUT:rtd=yes\n" >> "${jorg_outdir}/manifest_template.conf"
  printf "readgroup = ${sampleID}_QCed_PE_reads\n" >> "${jorg_outdir}/manifest_template.conf"
  printf "data = $new_r1_name $new_r2_name\n" >> "${jorg_outdir}/manifest_template.conf"
  printf "autopairing\n" >> "${jorg_outdir}/manifest_template.conf"
  printf "technology = solexa\n" >> "${jorg_outdir}/manifest_template.conf"
  printf "parameters = -NAG_AND_WARN:cnfs=no\n" >> "${jorg_outdir}/manifest_template.conf"
  printf "parameters = -NAG_AND_WARN:cmrnl=no\n" >> "${jorg_outdir}/manifest_template.conf"
  printf "parameters = -NAG_AND_WARN:cac=no\n" >> "${jorg_outdir}/manifest_template.conf"
  #Now the program itself
  printf "Will run JORG on input assembly:\t$assembly_file\nUsing input read files:\t$new_r1_name and $new_r2_name\n"
  #jorg -b "$assembly_file" --forward "$new_r1_name" --reverse "$new_r2_name" -k 33 -c 50 -i 5 --high_contig_num no
  jorg -b "$assembly_file" --forward "$new_r1_name" --reverse "$new_r2_name" -k 33 -c 50 -i 5 --high_contig_num no
  #The numbers there are the default values for those flags
  #Now will need to remove the copied in assembly and read files
  #cd "$jorg_outdir" #Should be there anyway but better safe I guess
  #rm "$assembly_file"
  #rm "$reads_file1"
  #rm "$reads_file2"
}

#Exporting the function
export -f execute_jorg

#Going to the output directory so hopefully the files will be written to it
cd "$outdir"

#Running the JORG function
execute_jorg "$trial_assembly" "$read_file_1" "$read_file_2" "$samplename" "$outdir"
