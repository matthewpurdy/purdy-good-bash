#!/bin/bash

script_path=$(dirname $(readlink -f $0))

$script_path/start-zookeeper.bash $1
$script_path/start-hadoop.bash $1
$script_path/start-accumulo.bash $1

