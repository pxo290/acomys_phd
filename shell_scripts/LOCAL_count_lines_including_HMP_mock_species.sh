#!/bin/bash -e

######SCRIPT######
export subject_file=$1
grep -c "Acinetobacter_baumannii\|Actinomyces_odontolyticus\|Bacillus_cereus\|Bacteroides_vulgatus\|Clostridium_beijerinckii\|Deinococcus_radiodurans\|Enterococcus_faecalis\|Escherichia_coli\|Helicobacter_pylori\|Lactobacillus_gasseri\|Listeria_monocytogenes\|Neisseria_meningitidis\|Propionibacterium_acnes\|Pseudomonas_aeruginosa\|Rhodobacter_sphaeroides\|Staphylococcus_aureus\|Staphylococcus_epidermidis\|Streptococcus_agalactiae\|Streptococcus_mutans\|Streptococcus_pneumoniae" $subject_file

grep "Acinetobacter_baumannii\|Actinomyces_odontolyticus\|Bacillus_cereus\|Bacteroides_vulgatus\|Clostridium_beijerinckii\|Deinococcus_radiodurans\|Enterococcus_faecalis\|Escherichia_coli\|Helicobacter_pylori\|Lactobacillus_gasseri\|Listeria_monocytogenes\|Neisseria_meningitidis\|Propionibacterium_acnes\|Pseudomonas_aeruginosa\|Rhodobacter_sphaeroides\|Staphylococcus_aureus\|Staphylococcus_epidermidis\|Streptococcus_agalactiae\|Streptococcus_mutans\|Streptococcus_pneumoniae"
