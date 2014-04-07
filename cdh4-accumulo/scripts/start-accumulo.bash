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

start_service accumulo-master 15
start_service accumulo-monitor 15
start_service accumulo-gc 15
start_service accumulo-tracer 15
start_service accumulo-tserver 15
start_service accumulo-logger 15

