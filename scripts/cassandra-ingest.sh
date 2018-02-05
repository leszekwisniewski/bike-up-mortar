#!/bin/sh

USER_ID=$1

CNT=0
for activity in ../datasets/detailed-activities/$USER_ID/*.json
do
  echo "Starting insert for $activity"
  CASSANDRA_INSERT_BATCH="insert into bikeup.strava_detailed_activities JSON '$(sed '/\(summary_\)*polyline/s/\\/\\\\/g' $activity)';"
  echo "Inserting through cqlsh"
  cqlsh -e "$(echo "$CASSANDRA_INSERT_BATCH" | sed '/\(summary_\)*polyline/s/\\/\\\\/g')"
  echo "Inserted successfully file $activity"
  CNT=$((CNT + 1))
done

echo "Inserted successfully $CNT rows."
