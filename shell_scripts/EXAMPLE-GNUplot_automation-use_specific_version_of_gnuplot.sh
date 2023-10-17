#!/bin/bash -e
#SBATCH -t 00-00:15
#SBATCH -p ei-short
#SBATCH -c 1
#SBATCH -J gnu_ing
#SBATCH --mem=4gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

export inpf1="/hpc-home/osbourne/figures/trials/combined.txt"

source package /tgac/software/testing/bin/gnuplot-4.6.3
touch gnuplot.in
for f in *.in
do
  echo "set term svg size 2040, 1080 font '/hpc-home/osbourne/fonts/sfd/FreeSans.ttf,24'" >> gnuplot.in
  echo "set output 'automation_test.svg'" >> gnuplot.in
  echo "set border lw 4" >> gnuplot.in
  echo "set key outside" >> gnuplot.in
  echo "set xlabel 'Acomys cahirinus variable 1 count'" >> gnuplot.in
  echo "set ylabel 'Acomys russatus variable 1 count'" >> gnuplot.in
  echo "set grid" >> gnuplot.in
  echo "plot \"$inpf1\" title \"Automation test\" linetype 4 linecolor 1 pointtype 7 pointsize 5 " >> gnuplot.in
done
gnuplot gnuplot.in
