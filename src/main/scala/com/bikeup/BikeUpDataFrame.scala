package com.bikeup


import org.apache.spark.mllib.linalg
import org.apache.spark.sql.cassandra._
import org.apache.spark.sql.{DataFrame, Row, SparkSession}
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.mllib.linalg.Vectors
import org.apache.spark.mllib.stat.{MultivariateStatisticalSummary, Statistics}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types.{IntegerType, StructField, StructType}

object BikeUpDataFrame extends App {

  private case class Athlete(id: Int, resource_state: Int)

  val conf = new SparkConf(true)
    .set("spark.cassandra.connection.host", "127.0.0.1")
    .setMaster("local")
    .setAppName("bike-up-mortar")

  val sc = new SparkContext(conf)

  private val session: SparkSession = SparkSession.builder().config(conf).getOrCreate()

  private val df: DataFrame = session.read
    .cassandraFormat("strava_activities", "bikeup")
    .load()

  private val vectors: Seq[linalg.Vector] = df.filter(col("`athlete`") === StructType(2777656, 1)).select("distance").collect.map(distance => {
    val fl = distance.getAs[Float](0)
    val d = fl.toDouble
    Vectors.dense(d)
  })

  val observations = sc.parallelize(vectors)

  val summary: MultivariateStatisticalSummary = Statistics.colStats(observations)
  println(summary.mean)
  println(summary.variance)
  println(summary.numNonzeros)
}
