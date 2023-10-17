#!/bin/bash -e

######SCRIPT######
work_file1=$1
work_file2=$2
locale=$(pwd)
printf "\nYou\nare\njoing\nthese\nfiles:\n"$work_file1"\nand\n"$work_file2""
#This next bit assumes you are keeping with the file naming convention you have
#had of a four character identifer giving species, individual and season of the
#sample. Therefore since you are joining the two seasonal samples you want the
#4 character identifier for species and individual identity. If the naming form
#changes you would change the value in the first name variable you make.
first_name=${work_file1:0:4}
join $work_file1 $work_file2 > HOLDING-joined.txt
mv HOLDING-joined.txt $first_name-joined.txt
printf "\nYou\njoined\nthese\nfiles:\n"$work_file1"\nand\n"$work_file2"\nand\nmade:\n"
