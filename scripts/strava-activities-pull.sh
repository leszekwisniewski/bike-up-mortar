#!/bin/sh

USER_ID=$1
ACCESS_TOKEN=$2

PAGE=0
mkdir -p ../datasets/activities/$USER_ID
while
    PAGE=$((PAGE + 1))
    HTTP_RESPONSE_CONTENT=`curl -X GET https://www.strava.com/api/v3/athlete/activities?page=$PAGE \
      -H "Authorization: Bearer $ACCESS_TOKEN" | python -m json.tool`
    echo "$HTTP_RESPONSE_CONTENT" | sed '/"summary_polyline"/s/\\/\\\\/g' > ../datasets/activities/$USER_ID/$PAGE.json
  [ "$HTTP_RESPONSE_CONTENT" != "[]" ]
do :; done
