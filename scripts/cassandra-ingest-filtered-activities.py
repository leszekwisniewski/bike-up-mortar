import os
import sys
import json
from cassandra.cluster import Cluster

userId = sys.argv[1]
fileList = os.listdir("../datasets/activities/" + userId)

cluster = Cluster()
session = cluster.connect()

jsonFilter = ['distance', 'elapsed_time', 'id', 'max_speed',
              'moving_time', 'name', 'start_date', 'start_date_local', 'start_latitude', 'start_latlng', 'start_longitude', 'timezone',
              'total_elevation_gain']

for activitiesFile in fileList:
     activitiesJson = json.loads(open("../datasets/activities/" + userId + "/" + activitiesFile).read())
     for activityJson in activitiesJson:
         filteredJson = {}
         for jsonAttr in jsonFilter:

             filteredJson[jsonAttr] = activityJson[jsonAttr]
         #
         # insertStatement = "insert into bikeup.strava_activities json '%s'" % json.dumps(activityJson)
         # session.execute(insertStatement)

print(filteredJson)
cluster.shutdown()
