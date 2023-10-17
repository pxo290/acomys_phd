#!/bin/bash -e

# touch clocker.txt
# time_now=$(date --utc +%y%m%d%h%s)
# planned_time=$(date --utc --date='30 seconds')

time_now=$(date --utc +%N)
endtime=$(date --utc --date='30 seconds')

if [[ "$endtime" -le "$time_now" ]]
then
  echo "I am complete"
else
  time_now=$(date --utc +%N)
  echo "The time currently is: $time_now"
  echo "Sleeping for 5 seconds"
  sleep 5
fi
