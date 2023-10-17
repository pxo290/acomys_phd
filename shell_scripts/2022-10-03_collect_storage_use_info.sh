#!/bin/bash -e
#SBATCH -t 03-12:00
#SBATCH -p ei-medium
#SBATCH -c 1
#SBATCH -J 2022-10-03_collect_storage_use_info
#SBATCH --mem=32gb
#SBATCH --mail-type=begin,end,fail
#SBATCH --mail-user=peter.osborne@earlham.ac.uk
#SBATCH -o /hpc-home/osbourne/2022-10-03_collect_storage_use_info-%A.out
#SBATCH -e /hpc-home/osbourne/2022-10-03_collect_storage_use_info-%A.err

#Written on 2022-10-03
#Written by Peter Osborne

#Script will go to all chapter directories, along with your home directory and
#get the storage usage for all top level directories then write these to files
#in your home directory. After that it will then do the same again but will get
#the usage for all files and in bytes so it can be put into files for plotting.

#Error detection and logging function
failure_catch() {
  local lineno=$1
  local msg=$2
  printf "\nFailed at:\t$lineno\t$msg\n"
}
trap 'failure_catch ${LINENO} "$BASH_COMMAND"' ERR

#Setting fixed variables
home_dir="/hpc-home/osbourne"
chap1_dir="/ei/projects/c/c33dfa31-8d66-4727-827b-ce9eb62d3237"
chap2_dir="/ei/projects/c/c57d1fc8-8c7f-47d2-bd32-4e5250784e29"
chap3_dir="/ei/projects/b/b881ad24-2c3c-4508-a6b2-b1c552453c24"
chap4_dir="/ei/projects/5/5306b670-79f8-438b-aa06-d6133e2c53a4"

#Writing top level storage function
execute_top_level_usage () {
  destination_dir="$1"
  outdir="$2"
  chapter_name="$3"
  cd "$destination_dir"
  du -h -d3 | sort -k1 -h > "${outdir}/${chapter_name}.Sorted_top_level_dir_usage.txt"
}

#Writing all levels, results in bytes format function
execute_all_level_byte_usage () {
  destination_dir="$1"
  outdir="$2"
  chapter_name="$3"
  cd "$destination_dir"
  touch "${outdir}/${chapter_name}.Sorted_all_level_byte_usage.txt"
  printf "Size\tFile_path" > "${outdir}/${chapter_name}.Sorted_all_level_byte_usage.txt"
  du -hab | sort -k1 -V >> "${outdir}/${chapter_name}.Sorted_all_level_byte_usage.txt"
}

#Writing the scratch directory versions
#Writing top level storage function for the scratch directory
execute_top_level_usage_scratch () {
  destination_dir="$1"
  scratch_dir=$(echo "$destination_dir" | sed "s@projects@.project-scratch@g")
  outdir="$2"
  chapter_name="$3"
  cd "$scratch_dir"
  du -h -d3 | sort -k1 -h > "${outdir}/${chapter_name}.Scratch.Sorted_top_level_dir_usage.txt"
}

#Writing all levels, results in bytes format function for the scratch directory
execute_all_level_byte_usage_scratch () {
  destination_dir="$1"
  scratch_dir=$(echo "$destination_dir" | sed "s@projects@.project-scratch@g")
  outdir="$2"
  chapter_name="$3"
  cd "$scratch_dir"
  touch "${outdir}/${chapter_name}.Scratch.Sorted_all_level_byte_usage.txt"
  printf "Size\tFile_path" > "${outdir}/${chapter_name}.Sorted_all_level_byte_usage.txt"
  du -hab | sort -k1 -V >> "${outdir}/${chapter_name}.Sorted_all_level_byte_usage.txt"
}

#Exporting the functions
export -f execute_top_level_usage
export -f execute_all_level_byte_usage
export -f execute_top_level_usage_scratch
export -f execute_all_level_byte_usage_scratch


#Running through the top level usage function, chapter directories first then the
#home directory
execute_top_level_usage "$chap1_dir" "$home_dir" "Chapter_1"
execute_top_level_usage "$chap2_dir" "$home_dir" "Chapter_2"
execute_top_level_usage "$chap3_dir" "$home_dir" "Chapter_3"
execute_top_level_usage "$chap4_dir" "$home_dir" "Chapter_4"
execute_top_level_usage "$home_dir" "$home_dir" "Home_dir"

#Now running the all files function in the same order
execute_all_level_byte_usage "$chap1_dir" "$home_dir" "Chapter_1"
execute_all_level_byte_usage "$chap2_dir" "$home_dir" "Chapter_2"
execute_all_level_byte_usage "$chap3_dir" "$home_dir" "Chapter_3"
execute_all_level_byte_usage "$chap4_dir" "$home_dir" "Chapter_4"
execute_all_level_byte_usage "$home_dir" "$home_dir" "Home_dir"

#Running the scratch higher level directories storage function
execute_top_level_usage_scratch "$chap1_dir" "$home_dir" "Chapter_1"
execute_top_level_usage_scratch "$chap2_dir" "$home_dir" "Chapter_2"
execute_top_level_usage_scratch "$chap3_dir" "$home_dir" "Chapter_3"
execute_top_level_usage_scratch "$chap4_dir" "$home_dir" "Chapter_4"
execute_top_level_usage_scratch "$home_dir" "$home_dir" "Home_dir"

#Now running the all files function in the same order for the scratch directories
execute_all_level_byte_usage_scratch "$chap1_dir" "$home_dir" "Chapter_1"
execute_all_level_byte_usage_scratch "$chap2_dir" "$home_dir" "Chapter_2"
execute_all_level_byte_usage_scratch "$chap3_dir" "$home_dir" "Chapter_3"
execute_all_level_byte_usage_scratch "$chap4_dir" "$home_dir" "Chapter_4"
execute_all_level_byte_usage_scratch "$home_dir" "$home_dir" "Home_dir"
