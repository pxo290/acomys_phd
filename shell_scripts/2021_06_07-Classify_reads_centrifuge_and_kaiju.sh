#!/bin/bash -e
#SBATCH -t 02-23:00
#SBATCH -p ei-largemem
#SBATCH -c 10
#SBATCH -J SilConTax
#SBATCH --mem=825gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=silvia.ogbeide@earlham.ac.uk

#Error trap, end the script if something breaks and say where it stopped in the
#script.
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Sourcing software
source package /tgac/software/testing/bin/centrifuge-1.0.3_dm
source package /tgac/software/testing/bin/kaiju-1.7.3

#Setting fixed variables
#Centrifuge
export centrefdir="/ei/references/databases/centrifuge/nt"
#Kaiju
export refnodes="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/nodes.dmp"
export refdbnames="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/names.dmp"
export refdbfile="/tgac/software/testing/kaiju/1.7.3/kaiju_db_nr_euk/kaiju_db_nr_euk.fmi"

#Defining functions
run_centrifuge() {
  inpf1=$1
  inpf2=$2
  outdir=$3
  #Making a unique sixteen character string to identify the output files
  exeID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ; echo '')
  label=$(basename "$inpf1" | sed "s/$/.Centrifuge_output_$exeID/g")
  printf "\nWill run Centrifuge on input files:\t$inpf1\n$inpf2\nOutput will be put in directory:\t$outdir\n"
  centrifuge -q -x "$centrefdir" -k 1 --threads 10 --time --reorder -s "$label" -S "${label}.classified.out" --report-file "${label}.report_file.out" -1 "$inpf1" -2 "$inpf2" || printf "\nFailed to run Centrifuge\n"
  #Grouping the output files together
  centrifuge_outputs=$(find -maxdepth 1 -type f -name "*$exeID*")
  #Moving the output files to their final directory
  for f in $centrifuge_outputs ; do printf "\nMoving file:\t$f\tTo directory:\t$outdir\n" && mv "$f" "$outdir" ; done
}

run_Kaiju() {
  inpf1=$1
  inpf2=$2
  outdir=$3
  #Making a unique sixteen character string to identify the output files
  exeID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16 ; echo '')
  label=$(basename "$inpf1" | sed "s/$/.Kaiju_output_$exeID/g")
  printf "\nWill run Kaiju on input files:\t$inpf1\n$inpf2\nOutput will be put in directory:\t$outdir\n"
  #Note the command below has two distinct steps, the first runs Kaiju and produces the read based classification/unknown to the Taxonomy ID database, the second section actually uses the reference database names file to put names to the classified TaxIDs
  kaiju -t "$refnodes" -f "$refdbfile" -i "$inpf1" -j "$inpf2" -o "$label.out" -v && kaiju-addTaxonNames -t "$refnodes" -n "$refdbnames" -i "$label.out" -p -o "$label.Taxa_added.out" -v || printf "\nFailed to run Kaiju\n"
  #Grouping the output files together
  kaiju_outputs=$(find -maxdepth 1 -type f -name "*$exeID*")
  #Moving the output files to their final directory
  for f in $kaiju_outputs ; do printf "\nMoving file:\t$f\tTo directory:\t$outdir\n" && mv "$f" "$outdir" ; done
}

#Putting things in order and running the functions
export INPF1=$1
export INPF2=$2
export LOCALE=$(pwd)
export SILVLAB=$3
mkdir "${SILVLAB}_contam_classification"
cd "${SILVLAB}_contam_classification"
mkdir Centrifuge_run
cd Centrifuge_run
export CENTDEST=$(pwd)
cd ..
mkdir Kaiju_run
cd Kaiju_run
export KAIJUDEST=$(pwd)
cd "$LOCALE"
run_centrifuge "$INPF1" "$INPF2" "$CENTDEST"
run_Kaiju "$INPF1" "$INPF2" "$KAIJUDEST"
