#!/bin/bash -e
#SBATCH -t 00-23:00
#SBATCH -p ei-largemem
#SBATCH -c 4
#SBATCH -J ProkRefMap
#SBATCH --mem=610gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

###SCRIPT###
export ref_store=$(pwd)
export workdir=$(pwd)
export UIE=$1

printf "\n Reference storage directory is: $ref_store \n"
printf "\n Working directory which will contain the outputs is: $workdir \n"
printf "\n User input email for messaging is: $UIE \n"
printf "\n KMER length in indexing and mapping will be: 15 \n"

source package /tgac/software/testing/bin/bbmap-38.06

##INDEXING STAGE
##First run is actually the bit to build indexes of the reference genomes so
##this should only be run the once if it works properly for given set of
##reference genomes
printf "\n Defining a function to run the BBMAP indexing \n"
bbmap_indexing () {
  FTBI=$1
  dest=$2
  printf "\n The file which will be indexed is: $FTBI \n"
  printf "\n The destination for the indexed files will be in: $dest \n"
  bbmap.sh ref=$FTBI k=15 slow=t threads=4 -Xmx605g -Xms435g path="$dest" build=
  printf "\n Indexed the file: $FTBI \n"
}

printf "\n Will now index the desired reference genomes \n"
#cd $ref_store
export subj_files=$(find -maxdepth 1 -type f -name "*.fna")
export file_count=$(ls -l *.fna | awk -F ' ' '{print $9}' | wc -l)
mkdir $ref_store/multi_reference_container
cd $ref_store/multi_reference_container
export multi_store=$(pwd)
cd ..
for f in $subj_files
do
  printf "\n One of the reference files to be indexed is: $f \n"
  mkdir $multi_store/${f%}_INDEXED
  cd $multi_store/${f%}_INDEXED
  export target=$(pwd)
  cd ..
  bbmap_indexing $f $target
  mail -s "Progress Monitoring 85763000" $UIE <<< "Indexing by BBMAP of reference genome $f has been completed"
  printf "\n Renaming the files \n"
  cd $multi_store/${f%}_INDEXED/ref/genome/1
  mv *.chrom.gz ${f%}.chrom.gz
  mv info.txt ${f%}.info.txt
  mv scaffolds.txt.gz ${f%}_scaffolds.txt.gz
  mv summary.txt ${f%}_summary.txt
  cd ..
  cd ..
  cd index
  cd 1
  oldname1=$(find -maxdepth 1 -type f -name "*.block")
  oldname2=$(find -maxdepth 1 -type f -name "*.block2.gz")
  for i in $oldname1
  do
    mv $i ${f%}_${i}
  done
  for i in $oldname2
  do
    mv $i ${f%}_${i}
  done
  printf "\n The output files from the indexing should now be renamed to match the original genomes \n"
###NOTES###
#14/07/20
##Update 1
##Immediate failure with Exception in thread "main" java.lang.NumberFormatException: null
##Will try adding double quotes around the kmerlen in the function
##Failed with:
#Exception in thread "main" java.lang.NumberFormatException: For input string: "/./GCA_000403335.2_Lach_bact_COE1_V1_genomic.fna_indexed"
# at java.lang.NumberFormatException.forInputString(NumberFormatException.java:65)
# at java.lang.Integer.parseInt(Integer.java:569)
# at java.lang.Integer.parseInt(Integer.java:615)
# at align2.AbstractMapper.parse(AbstractMapper.java:423)
# at align2.AbstractMapper.<init>(AbstractMapper.java:55)
# at align2.BBMap.<init>(BBMap.java:43)
# at align2.BBMap.main(BBMap.java:31)
##Also note that it didn't pick up the destination directory, probably because your script put the $KML as the second variable for the function rather than the destination - you got them the wrong way round
##Will change this and also, since it took a day to even start due to ei-medium demand, will increase memory request to 610GB and use the largemem queue - cutting the time request to 23 hours as well
##Kmer length in these tests is 15
#13/07/20 - started dating these again to make things easier in the future
##Having downloaded a few of the most abundant (according to Kraken2 with new
##database) bacterial genomes from the sample AR27N I am going to try mapping
##the reads to these genomes. Ideally this script will attempt to map the read
##files to these reference genomes
