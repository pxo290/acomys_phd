#!/bin/bash -e
#SBATCH -t 14-12:30
#SBATCH -c 10
#SBATCH -p ei-largemem
#SBATCH --mem=650gb
#SBATCH -J tax-APPRENTICE
#SBATCH --array=1-PLACEHOLDER%12
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/scratch/osbourne/ei/scratch/osbourne/Validation-Run/taxonomic-classification_%A_%a.out
#SBATCH -o /ei/scratch/osbourne/ei/scratch/osbourne/Validation-Run/taxonomic-classification_%A_%a.err

#27/02/20
#This script is built using the framework from your eggnog-mapperV2 array script
#which is itself based on an array script Dave W sent you. It will hopefully
#run Centrifuge2, Kraken2, Metaphlan2 and Diamond on all the fastq files in a
#user-specifed input directory as a large array.

#It should only allow a maximum of 10 jobs/subprocesses to be run at once, which
#hopefully will keep it from completely destroying your priority.

#Also it has a pirate theme, yar!

##17/03/20
#The two versions of diamond databases have been set up so now the script can be
#finished and run. This will be the array script which will follow the same set
#up as the other array scripts, so will be called by a planner script which will
#fill in the

#First up is vittling
source package /tgac/software/testing/bin/kraken-2.0.7_beta
source package /tgac/software/testing/bin/metaphlan-2f1b17a1f4e9
source blast+-2.7.1
source diamond-0.9.24
source MEGAN-6.3.7
source package /tgac/software/testing/bin/gcc-5.3.0
source package /tgac/software/testing/bin/gcc-6.2.0
source package /tgac/software/testing/bin/centrifuge-1.0.4_6cc874e

#Mark the date and destination in the ship's log
echo "We are bound for '$1' to sail the Spanish main and execute different taxonomic classification software on the fastq files therein."
clock_check=$(date) && echo "The time is: $clock_check"

#Weigh anchor!
cd $1

#Avast! What lies off the starboard bow?
for f in *.fastq
do
  echo "Hark! File '$f' has been sighted. Surely we will plunder it."
done

#Our array of carronades need to be loaded, best prepare the powder and note our
#bearings
locale=$(pwd) && echo "We are west-south-west of Port Royal, 4 miles off '$locale' island"

#Prepare for battle
filename=$(ls *.fastq | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/U+200B//g')
echo "Ahoy there '$filename' ! Heave to and prepare to be boarded!"

#Fire the first broadside! Load Metaphlan in the breaches!
srun /ei/software/testing/metaphlan/2.0/src/biobakery-metaphlan2-5424bb911dfc/metaphlan2.py $locale/$filename --mpa_pkl /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200.pkl --bowtie2_exe /ei/software/testing/bowtie/2.3.4/src/bowtie2-2.3.4-linux-x86_64/bowtie2 --bowtie2db /ei/software/testing/metaphlan/2.0/mpa-temp_osbourne/mpa_v20_m200 --input_type fastq > ${filename%}-metaphlan-output.txt && echo "Reporting back a direct hit on '$filename' with our first barrage of Metaphlan2!"

#We're getting closer now, time for chainshot! Load the Kraken!
kraken2 --db /ei/public/databases/kraken/2.0.7_std --threads 10 $locale/$filename --classified-out ${filename%}_kraken-classified.out --report ${filename%}_kraken-report.out > ${filename%}_kraken_output.txt && echo "Cap'n, the lookouts report that the Kraken has decimated '$filename' !"

#Prepare for boarding! Load chainshot and fire the DIAMOND!
diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $locale/$filename -a ${filename%}-diamond-output.daa && echo "We've swept the deck of scurvy dogs, Diamond has done great damage to '$filename' !"

#Draw in close to them, we'll board and finish them off with the Centrifuge!
centrifuge -q -x /ei/references/databases/centrifuge/nt -k 1 --min-hitlen 29 --reorder -s ${filename%}-centrifuge_solo_scoring.out -S ${filename%}-centrifuge_solo_scoring-classified.out -U $locale/$filename && mv *.tsv /ei/scratch/osbourne/ei/scratch/osbourne/Validation-Run/centrifuge-reports && echo "The ship is yours cap'n; we've captured '$filename' using Centrifuge to finish off the crew!"

#Send glad tidings back to port, we return rich in plunder and classifications!
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ TAXONOMIC CLASSIFICATION /-/-/ Word has come from the swarthy seadogs in port, the infamous script array_tax_classification.sh has run '$filename' in '$locale' through the wringer. It has subjected them to METAPHLAN2, bombarded them with KRAKEN2, blasted them with DIAMOND and even boarded to capture it with CENTRIFUGE. The ill-gotten gains from this outrage can be found in the taverns and brothels of /ei/scratch/osbourne/ei/scratch/osbourne/Validation-Run/ where chaos has resulted from this influx of doubloons and data"
