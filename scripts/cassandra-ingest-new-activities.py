import requests
import sys
import json
import datetime

from cassandra.cluster import Cluster

epoch = datetime.datetime.utcfromtimestamp(0)

userId = sys.argv[1]
userToken = sys.argv[2]

cluster = Cluster()
session = cluster.connect()

latestActivity = session.execute(f"select MAX(start_date) from bikeup.strava_activities where athlete={{id:{userId}, resource_state: 1}}")[0][0]

if latestActivity == None:
    latestMillis = 0
else:
    latestMillis = latestActivity.timestamp()

header = {'Authorization':f'Bearer {userToken}'}
requestUrl = f"https://www.strava.com/api/v3/athlete/activities?after={latestMillis}"
response = requests.get(requestUrl, headers=header)

activities = response.json()

for activity in activities:
    insertStatement = f"insert into bikeup.strava_activities json '{json.dumps(activity)}'"
    session.execute(insertStatement)

cluster.shutdown()
