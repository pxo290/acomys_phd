#!/bin/bash -e

# settle=$(date --utc --date='30 seconds') && date --utc && echo $settle
#
# until [ "$time_now" == "$settle" ]
# do
#   time_now=$(date --utc)
#   echo "It is now: $time_now"
#   echo "We are waiting until: $settle"
#   sleep 1
# done
# mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "TIME TEST BOIIIIII. I started at $time_now and finished at $settle "
#
# time_present=$(date +%m%d%H%M%Y.%S) && echo $time_present
#
# planned_time=$(date --utc --date='20 seconds' +%m%d%H%M%Y.%S) && echo $planned_time
# echo "It is: $time_present and we are waiting until: $planned_time"

planned_time=$(date --utc --date='1 minute' +%m%d%H%M%Y.%S) && echo $planned_time
until [ "$time_present" == "$planned_time" ]
do
  time_present=$(date +%m%d%H%M%Y.%S) && echo $time_present
  echo "It is: $time_present and we are waiting until: $planned_time"
  sleep 1
done
mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "TIME TEST BOIIIIII. I finished at $planned_time "

# planned_time=$(date --utc --date='1 minute')
# time_present=$(date) && if [ "$time_present" == "$planned_time" ]
# then
#   echo "The time has come..."
#   mail -s "Progress Monitoring 85763000" peter.osborne@earlham.ac.uk <<< "TIME TEST BOIIIIII. I finished at $planned_time "
# else
#   echo "The time now is $time_present"
#   sleep 1
# fi
