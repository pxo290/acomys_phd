#!/bin/bash -e
#SBATCH -t 00-00:35
#SBATCH -c 12
#SBATCH -J MetaPhlan2
#SBATCH --mem=122000
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######SCRIPT######
source package /tgac/software/testing/bin/metaphlan-2f1b17a1f4e9
export fastq_directory=$1
export fasta_directory=$1/Megahit-output
cd $fastq_directory
for f in *.fastq
do
  metaphlan_identifier=${f:0:7}
  mkdir $metaphlan_identifier-FASTQ_metahphlan2_results
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type fastq > $metaphlan_identifier-FASTQ_metahphlan2_results/${f%}-metaphlan-output.txt
  mail -s "Progress Monitoring 85763000" -A $metaphlan_identifier-FASTQ_metahphlan2_results/${f%}-metaphlan-output.txt peter.osborne@earlham.ac.uk <<< "\-\-\ METAPHLAN2 /-/-/ A file was processed through Kraken2, the file being "$f""
done
cd $fasta_directory
for f in *.fasta
do
  metaphlan_identifier=${f:0:7}
  mkdir $metaphlan_identifier-FASTA_metahphlan2_results
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type fasta > $metaphlan_identifier-FASTA_metahphlan2_results/${f%}-metaphlan-output.txt
  mail -s "Progress Monitoring 85763000" -A $metaphlan_identifier-FASTQ_metahphlan2_results/${f%}-metaphlan-output.txt peter.osborne@earlham.ac.uk <<< "\-\-\ METAPHLAN2 /-/-/ A file was processed through Kraken2, the file being "$f""
done
####Output Handling####
metaphlan_output_processing () {
  printf "\nThis function will process Metaphlan2 outputs, creating files ready for joining or other analysis.\n"
  export working_file=$1
  export taxon_level=$2
  export anti_taxon_level=$3
  export metaphlan_identifier=${working_file:0:7}
  awk '!/'"$anti_taxon_level"'__/ && /'"$taxon_level"'__/' $working_file > MET-$taxon_level-TEMP-FILE1.txt
  sed -n -e 's/.*'"$taxon_level"'__//p' MET-$taxon_level-TEMP-FILE1.txt > MET-$taxon_level-TEMP-FILE2.txt
  sort -k 1b,1 MET-$taxon_level-TEMP-FILE2.txt > $working_file-$taxon_level-only_sorted.txt
  rm MET-$taxon_level-TEMP-FILE1.txt && rm MET-$taxon_level-TEMP-FILE2.txt
  printf "\nResults files arranged for joining of the two season samples were prepared from the Metaphlan output file '$working_file'\n"
  mail -s "Progress Monitoring 85763000" -A $working_file-$taxon_level-only_sorted.txt peter.osborne@earlham.ac.uk <<< "\-\-\ METAPHLAN2 /-/-/ Here are processed Metaphlan2 output files:"$working_file-$taxon_level-only_sorted.txt""
}
cd $fastq_directory
export metaphlan_output_file=$(find . -type f -name "*-metaphlan-output.txt")
for f in $metaphlan_output_file
do
  printf "\nWill run metaphlan_output_processing function on Metaphlan2 output file $f\n"
  metaphlan_output_processing $f s t
  metaphlan_output_processing $f g s
  metaphlan_output_processing $f f g
  metaphlan_output_processing $f o f
  metaphlan_output_processing $f c o
  metaphlan_output_processing $f p c
  printf "\nWill run metaphlan_output_processing function on Metaphlan2 output file $f\n"
done
cd $fasta_directory
export metaphlan_output_file=$(find . -type f -name "*-metaphlan-output.txt")
for f in $metaphlan_output_file
do
  printf "\nWill run metaphlan_output_processing function on Metaphlan2 output file $f\n"
  metaphlan_output_processing $f s t
  metaphlan_output_processing $f g s
  metaphlan_output_processing $f f g
  metaphlan_output_processing $f o f
  metaphlan_output_processing $f c o
  metaphlan_output_processing $f p c
  printf "\nWill run metaphlan_output_processing function on Metaphlan2 output file $f\n"
done
######NOTES######
#22/05/20
#This script assumes you have a directory which contains FASTQ files, and one
#which has FASTA files in it - you give them both to the script, the FASTQ
#directory being the first argument and the FASTA directory being the second.
#It does the same thing in each of these directories using for loops, so I'll
#just describe it once:
# 1. Gets, hopefully, the first 5 characters of the filename for each one - why
#    this is done by positions 0-7 I don't know.
# 2. It makes a directory which has this string at the start and also includes
#    the relevant filetype in it as well
# 3. It runs Metaphlan2 on the files in the $1 (and later $2) directories, the
#    only difference in these commands being it set to either FASTA or FASTQ
# 4. After both user provided directories have had all the FASTQ/FASTA files
#    processed it switches into handling the generated output files, the point
#    of which is to make files suitable for joining and use in GNUplot
# 5. It will go through each output text file and produce another directory
#    which should also get the name with species, individual number and season
#    though no file type since it isn't necessary here
# 6. Then it will hopefully produce 6 text files for each Metaphlan 2 output,
#    these files will give the relative abundance calculated by the programme
#    for all the hits at that taxonomic level. The end result will be a file of
#    two columns, taxon in the left and value in the right. There must be no
#    spaces within a column, otherwise later joining won't work
# 25/05/20 - Having just done it with the Kraken one, you should consider tidying
# this up using a conserved function and running it in a for loop on each file
# with the different taxonomic level letter codes
#26/05/20 - Now is a function, after testing on the cluster with old version
#failed
