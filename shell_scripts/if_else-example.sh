#!/bin/bash -e

subject=$1
if [ -f "$subject" ]
then
  printf "\n$subject does in fact exist"
else
  printf "\n$subject does in fact not exist"
  sleep 30s
  printf "\nI slept for 30 seconds because $subject does in fact not exist"
fi
