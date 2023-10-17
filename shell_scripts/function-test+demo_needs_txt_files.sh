#!/bin/bash -e

hereiam=$(pwd)
thetextfiles=$(find . -maxdepth 1 \( -type f -name "*.txt" \))

function_test () {
  echo "I am here: $hereiam and I have found this file: $i"
}

export function_test

for i in $thetextfiles
do
  function_test $i
done
