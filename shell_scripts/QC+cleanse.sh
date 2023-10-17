#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 2-20:01
#SBATCH -c 8
#SBATCH --mem=856000
#SBATCH -J QC+Cleanse
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Going to the input directory
## N.B Worth having the working directory printed in all monitoring outputs like echoes and emails to help you with debugging
cd $1
echo "You are working on files in '$1'"
IAMHERE=$(pwd)

#Unzipping anything which might be zipped, gzipped or bzipped

#Taking either .fa, .fasta, .fastq or .fq from the user as the input file type by using it as a condition in find
desiredfiles=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*$2" -not -name "*cleansed" -not -name "*contaminated" \))
echo "You will be working on these files: '$desiredfiles'"

#Sourcing the QC software
source package /tgac/software/testing/bin/fastp-20190305
#Then running it
for f in $desiredfiles
do
  echo $IAMHERE
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'FastP will do QC on '$f' now, using the QC+cleanse.sh script from your scratch directory. This is happening in '$IAMHERE''
  fastp -i $f -o ${i%}_qceed -h ${i%}_qceed.html -j ${i%}.json
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'FastP did QC on '$f', using the QC+cleanse.sh script from your scratch directory. The file was in '$IAMHERE'.'
  echo "FastP was run on '$f' by the script QC+cleanse.sh in your scratch directory."
done

#Now we need to account for the fact that there are two different species here when we do the host removal
## N.B Adding the filters of -not cleansed and -not contaminated to see if this helps with it failing a couple of times
acocah=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*Acah*" -not -name "*cleansed" -not -name "*contaminated" \))
acorus=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*Arus*" -not -name "*cleansed" -not -name "*contaminated" \))
#Ought to do the trick

#Now to get the thing for doing host and human removal, doing host first since the human can all be done together
source package /tgac/software/testing/bin/bbmap-38.06


#Actually, let us try doing all the filtering for each species in one step. BBDuk can take a comma delimited list of references files, so why not stick them all into one list in the commands for each species

#Trying all references in one go with the Aco Cah files
## N.B - After trying this bit you need to give it more java memory, failed at Xmx128g so will increase it to 255g since it is running all files against 3 whole genomes.
### N.B - After a couple more trials and changes I'm adding the -overwrite flag to the bbduk commands, since it seems to be having issues with something alreday existing. Why it either thinks this or is correct about duplicately named files I'm not sure
for f in $acocah
do
  echo "_+_+_+_+_+_Host, human and wheat removal on '$f' is commencing. This is happening in '$IAMHERE'."
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk will remove host, human and wheat from '$f' now, using the QC+cleanse.sh script from your scratch directory. This is happening in '$IAMHERE''
  srun bbduk.sh -Xmx255g -prealloc in=$f ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_cah/mAcoCah1.curated_primary.20181127.fa,/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa,/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa outm=${f%}_contaminated out=${f%}_all_cleansed overwrite=t
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk removed host, human and wheat from '$f', using the QC+cleanse.sh script from your scratch directory. The file was in '$IAMHERE'.'
  echo "_+_+_+_+_+_Host, human and wheat removal of an AcoCah sample has been completed on '$f' using BBDuk by the script QC+cleanse.sh in your scratch directory. The file was in '$IAMHERE'."
done

#Trying all references in one go with the Aco Rus files
for f in $acorus
do
  echo "_+_+_+_+_+_Host, human and wheat removal on '$f' is commencing. This is happening in '$IAMHERE'."
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk will remove host, human and wheat from '$f' now, using the QC+cleanse.sh script from your scratch directory'
  srun bbduk.sh -Xmx255g -prealloc in=$f ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_russ/mAcoRus1.curated_primary.1811.fa,/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa,/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa outm=${f%}_contaminated out=${f%}_all_cleansed overwrite=t
  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk removed host, human and wheat from '$f', using the QC+cleanse.sh script from your scratch directory'
  echo "_+_+_+_+_+_Host, human and wheat removal of an AcoRus sample has been completed on '$f' using BBDuk by the script QC+cleanse.sh in your scratch directory. The file was in '$IAMHERE'."
done

## N.B Remember you will need to add all the IAMHERE pwd stuff to the echoes and emails in these commands if you end up using them
#First host removal, AcoCah
#for f in $acocah
#do
#  echo "_+_+_+_+_+_Host removal on '$f' is commencing"
#  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk will remove AcoCah from '$f' now, using the QC+cleanse.sh script from your scratch directory'
#  srun bbduk.sh -Xmx128g -prealloc in=$f ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_cah/mAcoCah1.curated_primary.20181127.fa outm=${f%}_contaminated out=${f%}_host_cleansed
#  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk removed AcoCah from '$f', using the QC+cleanse.sh script from your scratch directory'
#  echo "Host removal of an AcoCah sample has been completed on '$f' using BBDuk by the script QC+cleanse.sh in your scratch directory"
#done

#Now for the other host species, AcoRus
#for f in $acorus
#do
#  echo "_+_+_+_+_+_Host removal on '$f' is commencing"
#  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk will remove AcoRus from '$f' now, using the QC+cleanse.sh script from your scratch directory'
#  srun bbduk.sh -Xmx128g -prealloc in=$f ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/aco_russ/mAcoRus1.curated_primary.1811.fa outm=${f%}_contaminated out=${f%}_host_cleansed
#  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk removed AcoCah from '$f', using the QC+cleanse.sh script from your scratch directory'
#  echo "Host removal of an AcoRus sample has been completed on '$f' using BBDuk by the script QC+cleanse.sh in your scratch directory"
#done

#Now to remove any human left
#First make a new group comprised of host-cleansed files
#cleansed_files=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*cleansed*" \))
#Now do the same as above but with the human reference you've got
#for f in $cleansed_files
#do
#  echo "_+_+_+_+_+_Human removal on '$f' is commencing"
#  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk will remove human-matching kmers from '$f' now, using the QC+cleanse.sh script from your scratch directory'
#  srun bbduk.sh -Xmx128g -prealloc in=$f ref=/ei/workarea/group-dt/groupUsers/posborne/Project_1/Inputs/genome_downloads/human_reference/GRCh38_latest_genomic.fa outm=${f%}_human_contaminated out=${f%}_complete_clean
#  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk removed human-matching kmers from '$f', using the QC+cleanse.sh script from your scratch directory'
#  echo "Removal of human kmers from the sample has been completed on '$f' using BBDuk by the script QC+cleanse.sh in your scratch directory"
#done

#Optional step - given that Gareth mentioned wheat contamination, why not add that in here
#Getting the human and host cleansed files
#wheatseek=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*complete_clean*" \))
#for f in $wheatseek
#do
#  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk will remove wheat-matching kmers from '$f' now, using the QC+cleanse.sh script from your scratch directory'
#  srun bbduk.sh -Xmx128g -prealloc in=$f ref=/hpc-home/osbourne/REFERENCE_GENOMES/Triticum_aestivum.IWGSC.dna.toplevel.fa outm=${f%}_wheat_contaminated out=${f%}_complete_clean_without_wheat
#  mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'BBDuk removed wheat-matching kmers from '$f', using the QC+cleanse.sh script from your scratch directory'
#  echo "Removal of wheat kmers from the sample has been completed on '$f' using BBDuk by the script QC+cleanse.sh in your scratch directory"
#done
