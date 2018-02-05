#!/bin/sh

USER_ID=$1
ACCESS_TOKEN=$2

rm -rf ../datasets/detailed-activities/$USER_ID
mkdir -p ../datasets/detailed-activities/$USER_ID

REQ_CNT=0
for filename in ../datasets/activities/$USER_ID/*.json
do
  ACTIVITY_IDS=`jq '.[].id' $filename`
  for id in $ACTIVITY_IDS
  do
    # echo $id
    if [ $REQ_CNT -ne 600 ]
    then
      HTTP_RESPONSE_CONTENT=`curl -X GET https://www.strava.com/api/v3/activities/$id \
        -H "Authorization: Bearer $ACCESS_TOKEN" | python -m json.tool`
      echo "$HTTP_RESPONSE_CONTENT" > ../datasets/detailed-activities/$USER_ID/$id.json
    else
      # wait 10 mins
      sleep 600
    fi
    REQ_CNT=$((REQ_CNT + 1))
  done

done
