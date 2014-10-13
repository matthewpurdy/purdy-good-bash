#!/bin/bash

sleep_time=${1:-15}
script_path=$(dirname $(readlink -f $0))
source $script_path/base-run.bash

start_service accumulo-master $sleep_time 
start_service accumulo-monitor $sleep_time
start_service accumulo-gc $sleep_time
start_service accumulo-tracer $sleep_time
start_service accumulo-tserver $sleep_time

