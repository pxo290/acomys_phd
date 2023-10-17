#!/bin/bash -e
#SBATCH -t 00-12:35
#SBATCH -c 20
#SBATCH --mem=475gb
#SBATCH --array=1-37%6
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/meganised_diamonds/meganised_%A_%a.out
#SBATCH -o /ei/scratch/osbourne/interleaved-pilot-fastqs/meganised_diamonds/meganised_%A_%a.err
#SBATCH --constraint=intel

#02/03/20
#Hopefully this will actually make meganiser work on diamond files after running
#diamond on them. This is based on a script from Jose sent to you by Nasmille,
#so both would need crediting/thanking.
#It is also again an array job based on the script Dave sent you, so bear that
#in mind as well

#It uses a max of 37 jobs, since this should be the most diamond files you have
#in any directory at the moment

#First things then, where are we going and what are going to do
echo "We are headed for '$1' there to Meganise diamond files in an array"
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "\-\-\ MEGANISER UPDATE /-/-/ We are bound for '$1' to meganise (in an array) the diamond files."
cd $1

#Array needs the whole path before the $filename in the array input, so let's
#make a variable to store this in
locale=$(pwd) && echo $locale

#Note the time for posterity
clock_check=$(date)
echo "The time is: $clock_check"

#The meganiser here needs to use a specific version of Diamond, 0.9.10. This
#means you need to run it in particular and make sure that the database Diamond
#runs to begin with uses this diamond version.
#Below, hashed out, is the script Nasmille sent you as the exemplar
##source diamond-0.9.10;
##diamond blastp -p 8 -d /tgac/workarea/group-cg/nr_20200220_v0_9_10 -q S28_unmapped_pairs_concatenated.fastq.fasta.output.faa -o S28_1.daa -f 100
