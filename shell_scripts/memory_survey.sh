#!/bin/bash -e
#SBATCH -t 01-23:59
#SBATCH -c 30
#SBATCH -J memory_scanner
#SBATCH --mem=60gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

echo "Will get the memory usage from '$1', write it to two files named <>_du_sh_memory_log_output.txt and <>_df_h_memory_log_output.txt, then email this file to yourself and to '$2'."
cd $1
locale=$(pwd) && echo $locale
otheruser=$2
du -h >> ${locale}/du_sh_memory_log_output.txt
df -h >> ${locale}/df_h_memory_log_output.txt
memorylogs=$(find "$(pwd)" . -maxdepth 1 \( -type f -name "*h_memory_log_output.txt" \))
for f in $memorylogs
do
  echo "This is the content of '$f'"
  cat $f
  mail -s "Memory usage" peter.osborne@earlham.ac.uk <<< "Memory use update. Measuring of '$1' has been completed and will be emailed in two files."
  mail -s "Memory usage" peter.osborne@earlham.ac.uk < $f
  mail -s "Memory usage in '$locale'" $2 <<< "Hello, here is one of two files indicating the memory usage in directory: '$1'" && mail -s "Memory usage" $2 < $f
done
