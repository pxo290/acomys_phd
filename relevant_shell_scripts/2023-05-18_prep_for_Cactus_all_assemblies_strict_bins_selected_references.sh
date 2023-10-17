#!/bin/bash -eE
#SBATCH -p ei-long
#SBATCH -J 2023-05-18_prep_for_Cactus_all_assemblies_strict_bins_selected_references
#SBATCH -c 1
#SBATCH --mem=96gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-18_prep_for_Cactus_all_assemblies_strict_bins_selected_references-%A.out
#SBATCH -e /ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/slurm_outputs/2023-05-18_prep_for_Cactus_all_assemblies_strict_bins_selected_references-%A.err

#Written on 2023-05-18
#Written by Peter Osborne
#Written to be run on the NBI HPC

#This script will process files ready for use with Cactus. This will involve running Seqtk to remove contigs under 500bp in size
#soft-masking the contigs and altering the headers. Then it will run JolyTree to produce a newick tree which Cactus needs, process
#the newick tree to make it suitable and prepare the cactus information file.

#This script can be found on the hpc at: /hpc-home/osbourne/Post-EI_scripts/2023-05-18_prep_for_Cactus_all_assemblies_strict_bins_selected_references.sh

#Tweaked failure catch function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "Job was a run of script:\t/hpc-home/osbourne/Post-EI_scripts/2023-04-18_FastTree_BBMask_hardmasked_isolates_only.sh\nIt started around:\t${script_start_time}\n"
  printf "\nFailed at:\t$lineno\t$msg\n"

}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
export script_start_time=$(date)
export inpdir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24/culture_isolates/assemblies/all_contig_assemblies_contigs_under_500_bp_removed/assemblies_bins_iMGMC_MAGs_and_some_references"
export outdir="${inpdir}/softmasked_and_min_contig_files"
export list_of_files_file="${inpdir}/2022_04_04_combined_barrnap_bbmask_array_files_list_basename.txt"
export jolyTree_script="/hpc-home/osbourne/Jolytree_home/JolyTree-master/JolyTree_modify_this_version-V3.sh"
export jolyTree_dir="/hpc-home/osbourne/Jolytree_home/JolyTree-master"

#Making the directory to write the old and new header files to
mkdir -m 755 -p "${outdir}/changed_headers_files"
export headers_dir="${outdir}/changed_headers_files"

#Sourcing all the software
source package cab8386a-c777-4936-8411-a6ed2b5e6a20 #BBmap - 38.79
source package 46a62eca-4f8f-45aa-8cc2-d4efc99dd9c6 #Seqkit - 0.12.0
source package /tgac/software/testing/bin/newick_utils-1.5 #Newick Utilities - 1.5
source package /tgac/software/testing/bin/mash-2.2 #Mash v. 2.2
source package /tgac/software/testing/bin/fastme-2.1.5 #Fastme v. 2.1.5
source package /tgac/software/testing/bin/jdk-9.0.4 #JDK v. 9.0.4

#Writing the function to do all the processing
# execute_preprocess () {
#     input_file="$1"
#     if [[ "$input_file" == "./.fa" ]]
#     then
#         printf "Bad file:\t$input_file\n"
#     else
#         input_name=$(basename "$input_file" | awk -F "." '{print $1}')
#         output_dir="$2"
#         #First will change the file name to start with
#         mv "$input_file" "${input_name}.start.fa"
#         #Before finding all the existing fasta headers, turns out some of the old ones have forward and backward slashes in them so need to remove those here otherwise
#         #sed when doing the header changes breaks
#         sed -i -e 's@/@ @g' "${input_name}.start.fa"
#         sed -i -e 's@\\@ @g' "${input_name}.start.fa"
#         #Contig level filtering, removing any under 500bp in length
#         seqkit seq -m 500 --quiet "${input_name}.start.fa" > "${output_dir}/${input_name}.temp1.fa"
#         #Now the softmasking since Cactus can't handle the hardmasked
#         srun bbmask.sh -Xmx6g -Xms4g in="${output_dir}/${input_name}.temp1.fa" out="${output_dir}/${input_name}.temp2.fa" threads=auto maskrepeats=t minkr=5 maxkr=15 minlen=30 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.85 lowercase=t
#         #Now finding all the existing fasta headers
#         grep '>' "${output_dir}/${input_name}.temp2.fa" > "${headers_dir}/${input_name}.old_headers.txt"
#         #Now replacing them in the file
#         while IFS= read -r line
#         do
#             old_header=$(echo "$line")
#             new_header=$(head /dev/urandom | tr -dc '[:alpha:]' | head -c 10)
#             sed -i -e "s/${old_header}/>${input_name}_${new_header}/g" "${output_dir}/${input_name}.temp2.fa"
#             printf "${old_header}\t>${input_name}_${new_header}\n" >> "${headers_dir}/${input_name}.old_and_new_headers.tsv"
#         done < "${headers_dir}/${input_name}.old_headers.txt"
#         #Moving the modified fasta file to a better named one
#         mv "${output_dir}/${input_name}.temp2.fa" "${output_dir}/${input_name}.fa"
#         #Getting rid of the temporary files
#         rm "${output_dir}/${input_name}.temp1.fa"
#         rm "${headers_dir}/${input_name}.old_headers.txt"
#         #Printing the file processed and finishing the function
#         printf "Processed file:\t$input_file\n"
#     fi
# }

execute_preprocess_2 () {
    input_thing="$1"
    output_dir="$2"
    input_name=$(echo "$input_thing" | awk -F "." '{print $1}')
    #Combining with pipes the removal of slashes from headers, removing contigs under 500bp in size and the softmasking and directing the output to the output directory
    cat "$input_thing" | sed 's@/@ @g' | sed 's@\\@ @g' | seqkit seq -m 500 --quiet | srun bbmask.sh -Xmx4g -Xms2g in=stdin.fa out="${output_dir}/${input_name}.old_headers.fa" threads=auto maskrepeats=t minkr=5 maxkr=15 minlen=30 mincount=4 masklowentropy=t ke=5 window=80 entropy=0.85 lowercase=t
    cd "$output_dir"
    #Now finding all the existing fasta headers
    grep '>' "${output_dir}/${input_name}.old_headers.fa" > "${headers_dir}/${input_name}.old_headers.txt"
    #Prepping the old and new headers text file
    printf "Old header\tNew header\n" > "${headers_dir}/${input_name}.old_and_new_headers.tsv"
    #Now replacing them in the file
    while IFS= read -r line
    do
        old_header=$(echo "$line")
        new_header=$(head /dev/urandom | tr -dc '[:alpha:]' | head -c 10)
        sed -i -e "s/${old_header}/>${input_name}_${new_header}/g" "${output_dir}/${input_name}.old_headers.fa"
        printf "${old_header}\t>${input_name}_${new_header}\n" >> "${headers_dir}/${input_name}.old_and_new_headers.tsv"
    done < "${headers_dir}/${input_name}.old_headers.txt"
    #Renaming it now the headers have been changed
    mv "${output_dir}/${input_name}.old_headers.fa" "${output_dir}/${input_name}.fa"
    #Removing the old headers list text file
    rm "${headers_dir}/${input_name}.old_headers.txt"
    #Printing the file processed and finishing the function
    printf "Processed file:\t$input_thing\n"
    cd "$inpdir"
}

#Exporting the function, though this is not really necessary
#export -f execute_preprocess
export -f execute_preprocess_2

#Going to the input directory
cd "$inpdir"

#Running the second process function version
while IFS= read -r line
do
    subject_file="$line"
    printf "Will process file:\t$subject_file\n"
    if [[ "$subject_file" != *"temp"* ]]
    then
        execute_preprocess_2 "$subject_file" "$outdir"
    else
        printf "$subject_file was a bad file\n"
    fi
done < "$list_of_files_file"

#Copying the files into the output/working directory
# while IFS= read -r line
# do
#   subject_file="$line"
#   printf "Will process file:\t$subject_file\n"
#   if [[ "$subject_file" == *"temp"* ]]
#   then
#     printf "$subject_file was a bad file\n"
#   else
#     cp "$subject_file" "$outdir"
#   fi 
# done < "$list_of_files_file"

# #Going to the output directory
# cd "$outdir"

# #Running the function on each of the files 
# target_files=$(find -maxdepth 1 -type f -name "*.f*" -not -name "*temp*")
# for f in $target_files
# do
#     printf "Will run function to preprocess files for Cactus on file:\t$f\n"
#     execute_preprocess "$f" "$outdir"
# done

#Now that the fasta files are all hopefully processed will set JolyTree running, first getting a UUID to put in the outputs from it to be able to find it
newick_name_marker=$(uuidgen)

#Running JolyTree
srun "$jolyTree_script" -i "$outdir" -s 0.99 -c 0.25 -a 1.5 -b "$newick_name_marker" -t 1 -r 30 #Setting r to 30 here since the tree is just for Cactus to use as a guide

#Going to the JolyTree script directory which will contain the output files
cd "$jolyTree_dir"

#Finding the output files using the label made earlier
output_files=$(find -maxdepth 1 -type f -name "*$newick_name_marker*" -printf '%f\n')

#Moving them to the output directory
for f in $output_files
do
  printf "Moving file:\t$f to directory:\t${outdir}\n"
  mv "$f" "$outdir"
done

#Finding the Newick Tree
cd "$outdir"

#Making a version of it which can be used for Cactus
tree_target=$(find -maxdepth 1 -type f -name "*$newick_name_marker*" -and -name "*.nwk")
nw_topology -I "$tree_target" > "${outdir}/Cactus_safe_tree_${newick_name_marker}.nwk"

#Making the cactus information file
cat "${outdir}/Cactus_safe_tree_${newick_name_marker}.nwk" > "${outdir}/2023_05_18_cactus_info_file.txt"
for f in *.fa
do
    input_name=$(basename "$f" | awk -F "[.]" '{print $1}')
    input_path=$(readlink -f "$f")
    printf "${input_name}\t${input_path}\n" >> "${outdir}/2023_05_18_cactus_info_file.txt"
    printf "Added details for file:\t$f to ${outdir}/2023_05_18_cactus_info_file.txt\n"
done