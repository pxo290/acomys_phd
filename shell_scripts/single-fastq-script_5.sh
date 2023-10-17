source blast+-2.7.1
source diamond-0.9.24
source MEGAN-6.3.7


export human_cleansed_files
echo "±±±±±Starting the diamond blastx analysis of the files"
for f in *_human_cleansed.fq
do
  echo "This is what this stage will work on: "$f""
  diamond blastx -d /ei/scratch/osbourne/2nd_Nr_database/nr -q $f -a ${f%}-diamond-output.daa && echo \
  "±±±±±The Diamond blastx run on $f has been completed."
  mkdir -p diamond-output
  for f in *.daa
  do
    echo "±±±±±This is what this stage, the meganising stage, will work on: "$f""
    srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa-meganizer -i $f -class -fun KEGG -a2t /hpc-home/osbourne/Scratch/MEGAN-references/prot_acc2tax-Nov2018X1.abin -tn true -a2kegg /hpc-home/osbourne/Scratch/MEGAN-references/acc2kegg-Dec2017X1-ue.abin -v -o ${f%}-meganized \
    && echo "±±±±±The 'Meganisation' of $f has been completed."
    for f in *.daa
    do
      #You need to work out a way of turning the meganised .daa file into an rma file so it can actually be loaded locally in reasonable time
      srun /tgac/software/testing/MEGAN/6.3.7/x86_64/bin/tools/daa2rma -i $f
      mv $f diamond-output/
    done
  done
done
echo "±±±±±The fifth step, the diamond blastx scan and then meganization has concluded one way or another."
