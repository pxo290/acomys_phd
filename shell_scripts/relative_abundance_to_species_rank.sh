#!/bin/bash -e
#SBATCH -t 00-00:15
#SBATCH -p ei-short
#SBATCH -c 1
#SBATCH -J gnu_ing
#SBATCH --mem=256mb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#Making file which has sample name in quote marks, then the fragment counts for all species in the sample and their rank by using reverse sort and line number bash tool
#Importantly, the loop ouputs a file which has spaces at the start of the line and no first quote mark on the sample name for some reason even when it was in the printf command
locale=$(pwd)
export this_fig_lbel=$(echo $RANDOM)
touch $this_fig_lbel-outcome.dat
subject=$(find -maxdepth 4 -type f -name "*_Kraken2-confidence_score_0.10_report.txt-S-and_unclassified_sorted.txt")
for f in $subject
do
  label=$(printf "\n$f" | awk -F "/" '{print $2}' | awk -F "-" '{print $2}')
  content=$(cat $f | awk -F " " '{print $2}' | sort -nr | nl --number-width=9 | sed 's/ //g' | sed 's@\t@,@g' | awk ' { t = $1; $1 = $2; $2 = t; print; } ')
  printf "$label'\n$content\n\n" >> $locale/$this_fig_lbel-outcome.dat
done
sed -i -e 's/ //g' $locale/$this_fig_lbel-outcome.dat
sed -i -e "s/A/'A/g" $locale/$this_fig_lbel-outcome.dat
sed -i -e 's/,/ /g' $locale/$this_fig_lbel-outcome.dat
#Making the figure
source package /tgac/software/testing/bin/gnuplot-4.6.3
export inpf1="$locale/$this_fig_lbel-outcome.dat"
export uprange=$(cat $locale/$this_fig_lbel-outcome.dat | sort -n -k1 | tail -1 | awk -F " " '{print $1}')
export placeholder="50"
export upperrange=$((uprange+placeholder))
touch $this_fig_lbel-gnuplot.in
export object=$(find -maxdepth 1 -type f -name "$this_fig_lbel*.in")
export num_samples=$(grep -c "A" $locale/$this_fig_lbel-outcome.dat)
for f in $object
do
  echo "set term svg size 2040, 1080 font '/hpc-home/osbourne/fonts/sfd/FreeSans.ttf,18'" >> $locale/$this_fig_lbel-gnuplot.in
  echo "set output '$this_fig_lbel-Kraken2_10%_conf_score-relative_abundance_species_rank.svg'" >> $locale/$this_fig_lbel-gnuplot.in
  #echo "set border lw 4" >> $locale/$this_fig_lbel-gnuplot.in
  echo "set key outside" >> $locale/$this_fig_lbel-gnuplot.in
  echo "set xrange [0:$upperrange]" >> $locale/$this_fig_lbel-gnuplot.in
  echo "set xlabel 'Species rank'" >> $locale/$this_fig_lbel-gnuplot.in
  echo "set ylabel 'Fragment count'" >> $locale/$this_fig_lbel-gnuplot.in
  echo "set logscale y" >> $locale/$this_fig_lbel-gnuplot.in
  echo "set grid" >> $locale/$this_fig_lbel-gnuplot.in
  echo "plot for [IDX=0:$num_samples] '$locale/$this_fig_lbel-outcome.dat' i IDX u 1:2 w lines title columnheader(1) lw 5" >> $locale/$this_fig_lbel-gnuplot.in
done
gnuplot $this_fig_lbel-gnuplot.in

#Clearing up afterwards
mail -s 'GNUplot figure for fragment count to species rank' -a $this_fig_lbel-Kraken2_10%_conf_score-relative_abundance_species_rank.svg peter.osborne@earlham.ac.uk <<< "Attached as indicated"
sleep 45s && rm *"$this_fig_lbel"*
