#!/bin/bash

$HOME/kafka/bin/zookeeper-server-start.sh $HOME/kafka/config/zookeeper.properties  > $HOME/zookeeper.log 2>&1 &
$HOME/kafka/bin/kafka-server-start.sh $HOME/kafka/config/server.properties > $HOME/kafka.log 2>&1


