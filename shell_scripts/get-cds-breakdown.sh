desireddirectories=$(find . -maxdepth 1 \( -type d -name "*modified-prokka-results*" \))
for d in $desireddirectories
do
  cd $d
  for f in *.gff
  do
    echo "This is looking at file '$f' _+_+_+_+_+_+_+_"
    echo "The hypotheical protein count is: " && grep -c 'product=hypothetical protein'
    echo "The uniprot detected count is: " && grep -c 'similar to AA sequence:UniProtKB'
    echo "That was looking at file '$f'"
  done
  cd ..
done 
