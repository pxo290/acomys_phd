for i in ./*.fastq ; do d=$(basename "$i" .fastq) && mkdir "$d" && mv "$i" "$d" ; done
