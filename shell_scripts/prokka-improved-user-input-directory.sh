#!/bin/bash -e
#SBATCH -p ei-largemem
#SBATCH -t 24-23:59
#SBATCH -c 12
#SBATCH --mem=850000
#SBATCH -J ModImpProkSol
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk


#This job requests to use the large memory queue, 12 cores, 850GB of memory and run for 24 days 23 hours and 59 minutes at maximum

source package /tgac/software/testing/bin/prokka-1.7.2
#Most contemporary version on the cluster as of 08/10/19

source package /tgac/software/testing/bin/tbl2asn-x_rl
#Working version on the cluster as of 08/10/19

#This should show you all the three directories to be worked on
echo "+_+_+_+_+_+_+_+_+_+_+"
echo "The directory to be used is listed below:"
echo "$1"
echo "The directory to be used is listed above"
echo "+_+_+_+_+_+_+_+_+_+_+"

echo "The script being run is prokka-improved.sh found in your scratch scripts directory"

cd $1
for f in *.{fasta,fa}
do
	mail -v -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< 'This is to say that the prokka-improved.sh script has started running on '$f' now'
	#prokka $f prokka-results --force --prefix ${f%}-prokka-results && echo "Prokka has run on $f" && mail -v -s "Progress Monitoring - Prokka on '$f'" peter.osborne@earlham.ac.uk <<< 'This is to say that Prokka has run on '$f' using the script prokka-improved.sh'
	prokka $f prokka-results --cpus 0 --force --prefix ${f%}-modified-prokka-results --metagenome --norrna --notrna --addgenes  && echo "Modified Prokka has run on $f" && mail -v -s "Progress Monitoring - Modified Prokka on '$f'" peter.osborne@earlham.ac.uk <<< 'This is to say that Modified Prokka has run on '$f' using the script prokka-improved.sh'
done
