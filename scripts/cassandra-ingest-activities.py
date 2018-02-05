import os
import sys
import json
from cassandra.cluster import Cluster

userId = sys.argv[1]
fileList = os.listdir("../datasets/activities/" + userId)

cluster = Cluster()
session = cluster.connect()

for activitiesFile in fileList:
     activitiesJson = json.loads(open("../datasets/activities/" + userId + "/" + activitiesFile).read())
     for activityJson in activitiesJson:
         insertStatement = "insert into bikeup.strava_activities json '%s'" % json.dumps(activityJson)
         session.execute(insertStatement)
cluster.shutdown()
