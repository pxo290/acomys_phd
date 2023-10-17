#!/bin/bash -e
#SBATCH -t 00-03:35
#SBATCH -c 6
#SBATCH --mem=24000
#SBATCH -J tax_count
#SBATCH --mail-type=begin end fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk

#17/02/20
#This script should go through all the annotations.txt files in the same
#directory and count the occurences of all the taxons in the list below for
#StringVal. These were obtained by taking all the taxon classifications from
#the first run through of the qceed interleaved fasta files and using excel
#to  I think  get all the unique values - so presumably all the individual
#classifications from the list

# StringVal="Acidithiobacillales  Acidobacteriia  Actinobacteria  Actinopolysporales  Aerococcaceae  Aeromonadales  Alcaligenaceae  Alicyclobacillaceae  Alloprevotella  Alphaproteobacteria  Alteromonadaceae  Alteromonadales genera incertae sedis  Anoxybacillus  Aquificae  Archaea  asterids  Bacillales incertae sedis  Bacilli  Bacillus  Bacteria  Bacteroidaceae  Bacteroidetes  Bacteroidia  Bdellovibrionales  Beijerinckiaceae  Betaproteobacteria  Bifidobacteriales  Blautia  Bradyrhizobiaceae  Brassicales  Brevibacteriaceae  Burkholderiaceae  Butyrivibrio  Capnocytophaga  Carnobacteriaceae  Caulobacterales  Cellulomonadaceae  Chlamydiae  Chlorobi  Chloroflexi  Chlorophyta  Chromatiales  Chryseobacterium  Clostridia  Clostridiaceae  Clostridiales incertae sedis  Comamonadaceae  Coriobacteriia  Corynebacteriaceae  Cryomorphaceae  Cyanobacteria  Cyanothece  Cytophagia  Deferribacteres  Deinococcus-Thermus  Dermabacteraceae  Dermacoccaceae  Dermatophilaceae  Desulfobacterales  Desulfovibrionales  Dokdonia  Dorea  Elizabethkingia  Enterococcaceae  Epsilonproteobacteria  Erysipelotrichia  Eubacteriaceae  Eukaryota  fabids  Firmicutes  Flavobacteriia  Flavobacterium  Frankiales  Fungi  Fusobacteria  Gammaproteobacteria  Gemmatimonadetes  Geobacillus  Gillisia  Glycomycetales  Gordoniaceae  Gracilibacillus  Halanaerobiales  Halobacillus  Hydrogenophilales  Hyphomicrobiaceae  Hyphomonadaceae  Idiomarinaceae  Intrasporangiaceae  Lachnoanaerobaculum  Lachnoclostridium  Lactobacillaceae  Leeuwenhoekiella  Legionellales  Leuconostocaceae  Listeriaceae  Lysinibacillus  Maribacter  Marinilabiliaceae  Metazoa  Methanobacteria  Methylococcales  Methylocystaceae  Microbacteriaceae  Micrococcaceae  Micromonosporales  Mycobacteriaceae  Myxococcales  Negativicutes  Neisseriales  Nematocera  Nitrosomonadales  Nocardiaceae  Nonlabens  Nostocales  Oceanicola  Oceanospirillales  Opitutae  Oribacterium  Oscillatoriales  Oscillospiraceae  Oxalobacteraceae  Paenibacillaceae  Paracoccus  Pasteurellales  Peptococcaceae  Peptoniphilaceae  Peptostreptococcaceae  Peronosporales  Planctomycetes  Planococcaceae  Pleurocapsales  Poales  Polaribacter  Pontibacillus  Porphyromonadaceae  Promicromonosporaceae  Propionibacteriales  Pseudoalteromonadaceae  Pseudobutyrivibrio  Pseudomonas aeruginosa group  Pseudomonas putida group  Pseudomonas stutzeri group  Pseudonocardiales  Psychroflexus  Rhizobiaceae  Rhodobacter  Rhodocyclales  Rhodospirillales  Rickettsiales  Rikenellaceae  Rodentia  Rubrobacteria  Ruminococcaceae  Sarcocystidae  Sphingobacteriia  Sphingomonadales  Spirochaetes  Sporolactobacillaceae  Staphylococcaceae  Stigonemataceae  Streptacidiphilus  Streptococcus anginosus group  Streptococcus mitis  Streptococcus sanguinis  Streptococcus suis  Streptophyta  Streptosporangiales  Synechococcus  Synechocystis  Synergistetes  Syntrophomonadaceae  Tenericutes  Thermoactinomycetaceae  Thermoanaerobacterales  Thermotogae  Thioclava  Thiotrichales  unclassified Actinobacteria (class)  unclassified Alphaproteobacteria  unclassified Bacteria  unclassified Clostridiales  unclassified Flavobacteriaceae  unclassified Gammaproteobacteria  unclassified Lachnospiraceae  unclassified Verrucomicrobia  Verrucomicrobiae  Vibrionales  Virgibacillus  Xanthomonadales"

StringVal="Acidithiobacillales  Acidobacteriia Actinobacteria Actinopolysporales Aerococcaceae Aeromonadales Alcaligenaceae Alicyclobacillaceae Alloprevotella Alphaproteobacteria Alteromonadaceae Alteromonadales Anoxybacillus Aquificae Archaea asterids Bacillales Bacilli Bacillus Bacteria Bacteroidaceae Bacteroidetes Bacteroidia Bdellovibrionales Beijerinckiaceae Betaproteobacteria Bifidobacteriales Blautia Bradyrhizobiaceae Brassicales Brevibacteriaceae Burkholderiaceae Butyrivibrio Capnocytophaga Carnobacteriaceae Caulobacterales Cellulomonadaceae Chlamydiae Chlorobi Chloroflexi Chlorophyta Chromatiales Chryseobacterium Clostridia Clostridiaceae Clostridiales Comamonadaceae Coriobacteriia Corynebacteriaceae Cryomorphaceae Cyanobacteria Cyanothece Cytophagia Deferribacteres Deinococcus-Thermus Dermabacteraceae Dermacoccaceae Dermatophilaceae Desulfobacterales Desulfovibrionales Dokdonia Dorea Elizabethkingia emapper Enterococcaceae Epsilonproteobacteria Erysipelotrichia Eubacteriaceae Eukaryota fabids Firmicutes Flavobacteriia Flavobacterium Frankiales Fungi Fusobacteria Gammaproteobacteria Gemmatimonadetes Geobacillus Gillisia Glycomycetales Gordoniaceae Gracilibacillus Halanaerobiales Halobacillus Hydrogenophilales Hyphomicrobiaceae Hyphomonadaceae Idiomarinaceae Intrasporangiaceae Lachnoanaerobaculum Lachnoclostridium Lactobacillaceae Leeuwenhoekiella Legionellales Leuconostocaceae Listeriaceae Lysinibacillus Maribacter Marinilabiliaceae Metazoa Methanobacteria Methylococcales Methylocystaceae Microbacteriaceae Micrococcaceae Micromonosporales Mycobacteriaceae Myxococcales Negativicutes Neisseriales Nematocera Nitrosomonadales Nocardiaceae Nonlabens Nostocales Oceanicola Oceanospirillales Opitutae Oribacterium Oscillatoriales Oscillospiraceae Oxalobacteraceae Paenibacillaceae Paracoccus Pasteurellales Peptococcaceae Peptoniphilaceae Peptostreptococcaceae Peronosporales Planctomycetes Planococcaceae Pleurocapsales Poales Polaribacter Pontibacillus Porphyromonadaceae Promicromonosporaceae Propionibacteriales Pseudoalteromonadaceae Pseudobutyrivibrio Pseudomonas Pseudonocardiales Psychroflexus Rhizobiaceae Rhodobacter Rhodocyclales Rhodospirillales Rickettsiales Rikenellaceae Rodentia Rubrobacteria Ruminococcaceae Sarcocystidae Sphingobacteriia Sphingomonadales Spirochaetes Sporolactobacillaceae Staphylococcaceae Stigonemataceae Streptacidiphilus Streptococcus Streptophyta Streptosporangiales Synechococcus Synechocystis Synergistetes Syntrophomonadaceae Tenericutes Thermoactinomycetaceae Thermoanaerobacterales Thermotogae Thioclava Thiotrichales unclassified Verrucomicrobiae Vibrionales Virgibacillus Xanthomonadales"
for val in $StringVal ; do echo "-/\/\/\/\/\/\/\/\/\/\/\/-" && echo "$val" ; done

annotation_files=$(find . -maxdepth 1 \( -type f -name "*.annotations" -not -name "*ortholog*" -not -name "*.sh" -not -name "*.txt" \))
for f in $annotation_files
do
  echo "Working on file '$f'"
  for val in $StringVal
  do
    #echo "File is: '$f'" >> counting.txt
    #echo "Will be looking for occurences of '$val'"
    echo "'$val'-----:" >> counting.txt && grep -o -i "$val" "$f" | wc -l >> counting.txt
    #echo "'$val':" >> ${f%}-taxon-count.txt && grep -o -i "$val" "$f" | wc -l >> ${f%}-taxon-count.txt
    #echo "File was: '$f'" >> counting.txt
    #echo "Looked for occurences of '$val'"
  done
  echo "Worked through file '$f'"
done
