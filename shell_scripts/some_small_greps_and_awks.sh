for f in *annotations.txt ; do echo "\-\-\ FILE IS : '$f' /-/-/" >> hit_count.txt && grep -o "HS31*" $f | wc -l >> hit_count.txt && echo "\-\-\ FILE WAS : '$f' /-/-/" >> hit_count.txt ; done

for f in *.fastq ; do echo "\-\-\ FILE IS : '$f' /-/-/" >> read_count.txt && grep -o "HS31*" $f | wc -l >> read_count.txt && echo "\-\-\ FILE WAS : '$f' /-/-/" >> read_count.txt ; done

for f in *.csv ; do echo "\-\-\ File is : '$f' /-/-/" >> taxons.txt && cut -d, -f5 --complement $f >> taxons.txt && echo "\-\-\ FILE WAS: '$f' /-/-/" >> taxons.txt ; done

for f in *annotations.txt ; do echo "\-\-\ FILE IS: '$f' /-/-/" >> summarised.txt && cut -d -f1,4-6,22 $f >> summarised.txt && echo "\-\-\ FILE WAS: '$f' /-/-/" >> summarised.txt ; done
