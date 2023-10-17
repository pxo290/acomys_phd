#!/bin/bash -eE
#SBATCH -t 00-06:30
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J 2023-01-15_Unicycler_improved_culture_isolate_assembly_trial
#SBATCH --mem=72gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-01-15_Unicycler_improved_culture_isolate_assembly_trial-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-01-15_Unicycler_improved_culture_isolate_assembly_trial-%A.err

#Written on 2023-01-15
#Written by Peter Osborne
#Written to be run on the NBI HPC

#Trial script to see if I can produce an assembly using Unicycler, which I can then compare to the assembly made just using SPADEs for the same isolate
#reads and see if/how they differ

#This script can be found on the hpc at:/hpc-home/osbourne/Post-EI_scripts/2023-01-15_Unicycler_improved_culture_isolate_assembly_trial.sh

#Failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/cleansed_acomys_isolates"
top_outdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates"
inpf1="${inpdir}/13A_S1.QCed.Cleansed.R1.fq"
inpf2="${inpdir}/13A_S1.QCed.Cleansed.R2.fq"
isolate_ID="13A_S1.QCed.Cleansed"
#Note that the SPADEs assembly below is the scaffold output file, it has not had contigs under 500bp removed again by BBTools or whatever it was you used to make sure.
#The SPADES command to make it should have set it to require 500bp as the minimum contig size anyway
spades_assembly="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/13A_S1/13A_S1-scaffolds.fasta"

#Sourcing tools
source package 0869fa97-4854-4287-9b69-145d1e0ec6c4 #Unicycler 0.49
source package 5a1c6a9a-f666-4eaa-9409-3e7435d86406 #CheckM 1.2.0
source package /tgac/software/testing/bin/bbmap-38.06 #BBMap 38.06
source package 4e99f6f0-3ba1-4757-9962-ba3faa24d885 #Prokka 1.14.6

#Going to top output directory
cd "$top_outdir"

#Making an output and working directory
mkdir -m 755 -p "${top_outdir}/${isolate_ID}"
unicycler_dir="${top_outdir}/${isolate_ID}"

#Running Unicycler
printf "Will run Unicycler using input read files:\t$inpf1 and $inpf2\n"
unicycler -1 "$inpf1" -2 "$inpf2" -o "$unicycler_dir" --threads 1 --mode normal --verbosity 2

#Going to Unicycler output directory and adding a useful prefix to the file names
cd "$unicycler_dir"
for f in *
do
    mv "$f" "${isolate_ID}-Unicycler_output.${f%}"
    printf "Renamed file:\t$f to ${isolate_ID}-Unicycler_output.${f%}\n"
done

#Adding useful information to the Unicycler assembly fasta file
sed -i -e "s/>/>${isolate_ID} Contig /g" "${isolate_ID}-Unicycler_output.assembly.fasta"

#Running CheckM on the original SPADES assembly to get the results for it in the Unicycler directory
cp "$spades_assembly" "$unicycler_dir"
checkm lineage_wf -t 2 -x fasta "$unicycler_dir" "$unicycler_dir"
cd "$unicycler_dir"
target_lineage_file=$(find -maxdepth 1 -type f -name "*lineage*.ms" -printf '%f\n')
qa_output_file_dir="$unicycler_dir"
checkm qa -o 2 -f "${unicycler_dir}/${isolate_ID}.SPADES_original_assembly.CheckM.out" "$target_lineage_file" "$qa_output_file_dir"