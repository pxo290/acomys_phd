#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 10-20:01
#SBATCH -c 3
#SBATCH --mem=999000
#SBATCH -J 17-11-19_full_run_interspersed
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#To be neat and tidy
IAMHERE=$(pwd)

#Alright, first thing is to source the fastp we need
#source package /tgac/software/testing/bin/fastp-20190305
#Now make a function with what we need
#QC_fastp () {
  #echo "This function will run fastp-20190305 on whatever files are assigned to it"
  #for f in *.fastq
  #do
    #echo "The files which will be worked on are: '$f'"
    #fastp -i "$f" -o ${f%}_qceed.fastq -h ${f%}_qceed.html -j ${f%}_qceed.json && echo "FastP has been run on '$f'"
    #mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that FastP QC of '$f' has been executed.'
    #mkdir -p fastp-outputs
    #mv -- *{.html,.json} fastp-outputs/
  #done
#}

#Now run the function
#QC_fastp

#Okay, now on to the next step. Host, human and wheat removal. Wheat removal since there was a lot of wheat found the first few times the kraken, centrifuge (though I'm not using it anymore) and megan analysis was done
#First, we get the tool we need
#source package /tgac/software/testing/bin/bbmap-38.06

#Here we will need to be a bit more fiddly, since we have two host species and want to make sure we use the right host genomes to clean them against.
#So we can break them into two groups, store these in variables and then run them against the three right genomes for each group
#acocah=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*AC*" -name "*qceed.fastq" -not -name "*cleansed" -not -name "*contaminated" \))
#acorus=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*AR*" -name "*qceed.fastq" -not -name "*cleansed" -not -name "*contaminated" \))
#BBDuk can take a comma delimited list of references files, so why not stick them all into one list in the commands for each species

#Trying all references in one go with the Aco Cah files
## N.B - After trying this bit you need to give it more java memory, failed at Xmx128g so will increase it to 255g since it is running all files against 3 whole genomes.
### N.B - After a couple more trials and changes I'm adding the -overwrite flag to the bbduk commands, since it seems to be having issues with something alreday existing. Why it either thinks this or is correct about duplicately named files I'm not sure
#for f in $acocah
#do
  #echo "Host, human and wheat removal on '$f' is commencing. This is happening in '$IAMHERE'."
  #mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk will remove host, human and wheat from '$f' now. This is happening in '$IAMHERE''
  #srun bbduk.sh -Xmx255g -prealloc in=$f ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_cah/mAcoCah1.curated_primary.20181127.fa,/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa,/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa outm=${f%}_contaminated out=${f%}_all_cleansed.fastq overwrite=t
  #mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk removed host, human and wheat from '$f'. The file was in '$IAMHERE'.'
  #echo "Host, human and wheat removal of an AcoCah sample has been completed on '$f' using BBDuk. The file was in '$IAMHERE'." &
#done
#wait

#Trying all references in one go with the Aco Rus files
#for f in $acorus
#do
  #echo "Host, human and wheat removal on '$f' is commencing. This is happening in '$IAMHERE'."
  #mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk will remove host, human and wheat from '$f' now.'
  #srun bbduk.sh -Xmx255g -prealloc in=$f ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_russ/mAcoRus1.curated_primary.1811.fa,/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa,/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa outm=${f%}_contaminated out=${f%}_all_cleansed.fastq overwrite=t
  #mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk removed host, human and wheat from '$f' now.'
  #echo "Host, human and wheat removal of an AcoRus sample has been completed on '$f' using BBDuk. The file was in '$IAMHERE'." &
#done
#wait
#I probably could have made this into a function as well, but I'm too lazy to change what was already working as two loops across the different variables

#Now to be safe we make a variable which contains only our cleansed files so we can always use it in the future
cleansed_files=$(find . -maxdepth 1 \( -type f -name "*_all_cleansed.fastq" -not -name "*contaminated*" -not -name "*qceed*"  \))
export cleansed_files
#For the taxnomic analysis, Metaphlan 2 will be run first and within this script - since it is the quickest of the three classifiers.
#So get the metaphlan2 you need
source package /tgac/software/testing/bin/metaphlan-2f1b17a1f4e9

#Why don't we make this a function as well? Easier at least to hash stuff out when it is
run_metaphlan2 () {
  echo "Metaphlan2 will begin running. This is happening in '$IAMHERE'."
  srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $f --mpa_pkl /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/workarea/group-dt/groupUsers/posborne/Project_1/Software/metaphlan_databases/mpa_v20_m200 --input_type fastq > ${f%}_metaphlan-output.txt && echo "Metaphlan2 analysis of '$f' has been accomplished." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "This is to say that Metaphlan2 has run on '$1'."
  mkdir -p metaphlan2-output
  metahphlan2_output=$(find . -maxdepth 1 \( -type f -name "*_metaphlan-output.txt" -not -name "*kraken*" \))
  for f in $metahphlan2_output
  do
    mv $f metaphlan2-output/
  done
}

#Kraken function below, first get the version of kraken you need
source package /tgac/software/testing/bin/kraken2-2.0.7
#Now the function itself
run_kraken2 () {
  echo "Kraken2 will begin running. This is happening in '$IAMHERE'" && kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 2 "$f" --classified-out ${f%}_kraken-classified.out --report ${f%}_kraken-report.out > ${f%}_kraken_output.txt \
  && echo "Kraken2 analysis of '$f' has been completed." && mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that Kraken2 has run on '$f'.'
  mkdir -p kraken2-output
  kraken2output=$(find . -maxdepth 1 \( -type f -name "*_kraken-classified.out" -not -name "*metaphlan*" \))
  for f in $kraken2output
  do
    cat $f > ${f%}_text.txt
  done
  mv *_text.txt kraken2-output
}

#Neat, alright now try and make a Diamond and Megan function
#First you need the right software for it
# source package /tgac/software/production/bin/blast+-2.7.1
# source package /tgac/software/testing/bin/diamond-0.9.24
# source package /tgac/software/testing/bin/MEGAN-6.3.7
# #Okay, now to try and build the function. It might be necessary to have two functions, the Diamond and then the Megan otherwise it could take too long
# TEMPBLOCKrun_diamond_blastx () {
#   echo "Diamond will begin running, using the BlastX feature. This is happening in '$IAMHERE'" && diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $f -a ${f%}-diamond-output.daa && echo \
#   "The Diamond blastx run on $f has been completed."
#   mkdir -p diamond-output
#   for i in *.daa
#   do
#     echo "This is what this stage, the meganising stage, will work on: "$i""
#     srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa-meganizer -i $i -class -fun KEGG -a2t /hpc-home/osbourne/Scratch/MEGAN-references/prot_acc2tax-Nov2018X1.abin -tn true -a2kegg /hpc-home/osbourne/Scratch/MEGAN-references/acc2kegg-Dec2017X1-ue.abin -v -o ${i%}-meganized \
#     && echo "The 'Meganisation' of $i has been completed."
#     for file in *.daa
#     do
#       srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa2rma -i $file
#       mv $file diamond-output/
#     done
#   done
# }

#You know what, just to be safe why don't we make the Diamond and Megan as separate scripts that the function calls instead?
run_diamond_blastx () {
  source /ei/scratch/osbourne/RAW-READS/merged/diamond_to_megan.sh
}

#Actually, why don't we try and turn all the classification steps into functions and then run them on the files in our cleansed_files variable simultaneously?
for f in $cleansed_files
do
  run_metaphlan2 $f
  run_kraken2 $f
  run_diamond_blastx
done

#Okay, now the annotation with Prokka - you could add FragGene but it is less user-friendly in terms of output so perhaps skip it for now.
##Again, make a function which will be used in a for loop
###First get the stuff you need
source package /tgac/software/testing/bin/prokka-1.7.2
#Most contemporary version on the cluster as of 08/10/19
source package /tgac/software/testing/bin/tbl2asn-x_rl
#Working version on the cluster as of 08/10/19
