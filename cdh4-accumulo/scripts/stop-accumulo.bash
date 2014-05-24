#!/bin/bash

sleep_time=${1:-15}
script_path=$(dirname $(readlink -f $0))
source $script_path/base-run.bash

stop_service accumulo-logger $sleep_time
stop_service accumulo-tserver $sleep_time
stop_service accumulo-tracer $sleep_time
stop_service accumulo-gc $sleep_time
stop_service accumulo-monitor $sleep_time
stop_service accumulo-master $sleep_time 
