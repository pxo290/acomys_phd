#!/bin/bash
#SBATCH -t 00-00:41
#SBATCH -c 2
#SBATCH -J EggMapCC
#SBATCH --mem=12000
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

######NOTES######
#12/05/20
#You wrote the base version of this earlier, after lots of faffing and failures
#trying to get the thing working. You ran into the limits of your bash skills
#so this crude script is the result. It identifies the first eggnog annotation
#file and makes a version of it so that it can do the different sed -i commands
#to remove the header text you don't need but keep the column titles. It makes
#a concatenation text file which the first file is read into via the modified
#(deleted extraneous headers and trailing text) version. It also makes two
#directories, moving the ortholog output files into the appropriately named
#orthologs directory. It also makes an annotations directory, which will have
#preserved copies of the annotation files moved into it later. It loops through
#all the remaining annotation files, making and moving the preserved copies into
#the annotations directory. Then it carries out the sed commands, removing 4
#lines of headers this time since they are identical to the ones left in the
#first file when it was 'cat-ed' into the concatenation text file. After doing
#this it cat appends the files into the concatenated text file and deletes
#the modified annotations file, since a clean copy is saved in the annotations
#subdirectory.

######SCRIPT######
cd $1
mkdir -p orthologs
mkdir -p annotations
mv *.emapper.seed_orthologs orthologs/
export first_file=$(find . -maxdepth 1 -type f -name "*.part_001.fasta*")
export first_base=$(basename $first_file)
export sampleID=${first_base:0:5}
scp *part_001.fasta-eggnog_mapper-output.emapper.annotations first_file.txt
sed -i '1,1d' first_file.txt
sed -i '1,1d' first_file.txt
sed -i '1,1d' first_file.txt
sed -i '$ d' first_file.txt
sed -i '$ d' first_file.txt
sed -i '$ d' first_file.txt
cat first_file.txt > "$sampleID"_eggnog_concatenated.txt
mv *part_001.fasta-eggnog_mapper-output.emapper.annotations annotations/
rm first_file.txt
for f in *fasta-eggnog_mapper-output.emapper.annotations
do
  scp $f annotations/
  sed -i '1,1d' $f
  sed -i '1,1d' $f
  sed -i '1,1d' $f
  sed -i '1,1d' $f
  sed -i '$ d' $f
  sed -i '$ d' $f
  sed -i '$ d' $f
  cat $f >> "$sampleID"_eggnog_concatenated.txt
  rm $f
done
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ EGGNOG-MAPPERV2 /-/-/ Concatenation and tidying up of the eggnog-mapper output for files in "$1" has been completed."
