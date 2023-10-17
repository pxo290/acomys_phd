for f in *-BBMap-interleaved.fastq_qceed.fastq-reformat-subsampled-75pc-5000000-bases.fastq-metaphlan-output.txt ; do printf "$f\n" && awk '!/t__/ && (/s__/)' $f | wc -l ; done
