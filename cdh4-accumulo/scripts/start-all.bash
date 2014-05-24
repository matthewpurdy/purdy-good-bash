#!/bin/bash

./start-zookeeper.bash $1
./start-hadoop.bash $1
./start-accumulo.bash $1

