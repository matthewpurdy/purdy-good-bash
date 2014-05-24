#!/bin/bash

sleep_time=${1:-15}
script_path=$(dirname $(readlink -f $0))
source $script_path/base-run.bash

stop_service hadoop-0.20-mapreduce-tasktracker $sleep_time
stop_service hadoop-0.20-mapreduce-jobtracker $sleep_time
stop_service hadoop-hdfs-datanode $sleep_time
stop_service hadoop-hdfs-secondarynamenode $sleep_time
stop_service hadoop-hdfs-namenode $sleep_time 
