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

start_service zookeeper-server 15

