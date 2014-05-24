#!/bin/bash

sleep_time=${1:-15}
script_path=$(dirname $(readlink -f $0))
source $script_path/base-run.bash

stop_service hadoop-0.20-mapreduce-tasktracker $start_time
stop_service hadoop-0.20-mapreduce-jobtracker $start_time
stop_service hadoop-hdfs-datanode $start_time
stop_service hadoop-hdfs-secondarynamenode $start_time
stop_service hadoop-hdfs-namenode $start_time 
