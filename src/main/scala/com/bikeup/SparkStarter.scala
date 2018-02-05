package com.bikeup

import com.datastax.spark.connector._
import org.apache.spark.{SparkConf, SparkContext}

object SparkStarter extends App {

  val conf = new SparkConf(true)
    .set("spark.cassandra.connection.host", "127.0.0.1")
    .setMaster("local")
    .setAppName("bike-up-mortar")

  val sc = new SparkContext(conf)

  val table = sc.cassandraTable("bikeup", "strava_activities")

  private val athlete = "athlete = { id: 2777656, resource_state: 1 }"
  private val max: Long = table.select("distance")
    .where(athlete)
    .map(_.get[Long](0))
    .max()

  private val count: Long = table.count()


  private val avg: Double = table.select("distance").where(athlete)
    .map(_.get[Long](0))
    .sum() / count


  println("max: " + max)
  println("avg: " + avg)
}
