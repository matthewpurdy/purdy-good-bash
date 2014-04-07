#!/bin/bash

function start_service {
	echo -n "### starting $1 ..."
	service $1 start
	echo " $1 started"
	echo -n "sleeping for $2 seconds..."
	sleep $2
	echo " waking up"
	echo $(service $1 status)
}

start_service hadoop-hdfs-namenode 15
start_service hadoop-hdfs-secondarynamenode 15
start_service hadoop-hdfs-datanode 15
start_service hadoop-0.20-mapreduce-jobtracker 15
start_service hadoop-0.20-mapreduce-tasktracker 15

