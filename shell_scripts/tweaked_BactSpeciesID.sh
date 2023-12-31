#!/bin/bash

###Modified 27/07/20 by Peter Osborne

#print the options
usage () {
  echo ""
  echo "This script identifies bacterial species using genome assemblies"
  echo ""
  echo "Usage: $0 [options] FASTA"
  echo "Option:"
  echo " -i BLASTn identity (default:99)"
  echo " -c BLASTn coverage (default:50)"
  echo " -d ABRicate database (default:SILVA-16S)"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.1 (2020)"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk"
  echo "";
}
version () { echo "version 1.1 (2020)";}
author () { echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk";}

#dafault value for BLAST identity and database for ABRicate

IDENTITY=99
COVERAGE=50
DATABASE=/ei/scratch/osbourne/BactspeciesID/SILVA-16S

# parse the options
while getopts 'i:c:d:hav' opt;do
  case $opt in
    i) IDENTITY=$OPTARG ;;
    c) COVERAGE=$OPTARG ;;
    d) DATABASE=$OPTARG ;;
    h) usage; exit;;
    a) author; exit;;
    v) version; exit;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
    :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
   esac
done

# skip over the processed options
shift $((OPTIND-1))

# check for mandatory positional parameters, only 1 positional argument will be checked
if [ $# -lt 1 ]; then
   echo "Usage: $0 [options] FASTA"
   echo "Option: -i BLASTn identity (default:$IDENTITY)"
   echo "Option: -c BLASTn coverage (default:$COVERAGE)"
   echo "Option: -d ABRicate database (default:$DATABASE)"
   echo ""
   exit 1
fi

fasta=$1

echo "will identify with BLASTn identity $IDENTITY% and BLASTn coverage $COVERAGE% with ABRicate database $DATABASE"
echo "identifying 16S rRNA genes from genome assembly $fasta ..."
barrnap --quiet $1 > $fasta-gff
echo "16S rRNA genes have now been identified"
echo "extracting 16S rRNA gene from $fasta ..."

grep '16S' $fasta-gff > $fasta-16S.gff;
bedtools getfasta -fi $fasta -bed $fasta-16S.gff -fo $fasta-16S-fasta.fna;

echo "....still extracting..."

grep -m 1 ">" $fasta-16S-fasta.fna|sed 's/>//g' > $fasta-16S-id.txt;
xargs samtools faidx $fasta-16S-fasta.fna < $fasta-16S-id.txt > $fasta-16S.fna

echo "16S rRNA gene is now extracted"
echo "removing intermediary files..."

# rm $fasta-gff
# rm $fasta-16S.gff
# rm $fasta-16S-fasta.fna
# rm $fasta.fai
# rm $fasta-16S-fasta.fna.fai
# rm $fasta-16S-id.txt

echo "16S rRNA gene sequence is now stored in $fasta-16S.fna"
echo "identifying species using ABRicate $DATABASE database at identity >$IDENTITY%..."
abricate --quiet --datadir /ei/scratch/osbourne/blast_DB --db /ei/scratch/osbourne/blast_DB/SILVA-16S --mincov=$COVERAGE --minid=$IDENTITY $fasta-16S.fna|grep -v "#FILE" | awk '{print $13" "$14}' > $fasta.species

echo "Species identified is now stored in $fasta.species"
echo "Removing intermediary file..."
rm $fasta-16S.fna

echo "Programme will now exit"

echo "The species identified for genome assembly $fasta is "
cat $fasta.species

exit 0;
