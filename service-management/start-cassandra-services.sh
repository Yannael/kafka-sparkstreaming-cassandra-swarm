docker service create \
--name cassandra-seed \
--constraint node.hostname==master \
--network cluster-network \
cassandra:3.9 

#Need to sleep a bit so IP can be retrieved below
while [[ -z $(docker service ls |grep cassandra-seed| grep 1/1) ]]; do 
	Echo Waiting for Cassandra seed service to start...
	sleep 5 
	done;

export CASSANDRA_SEED=`docker-machine ssh master \
"docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
$(docker ps |grep cassandra|cut -d ' ' -f 1)"`

docker service create \
--name cassandra-node1 \
--constraint node.hostname==worker-1 \
--network cluster-network \
--env CASSANDRA_SEEDS=$CASSANDRA_SEED \
cassandra:3.9 

docker service create \
--name cassandra-node2 \
--constraint node.hostname==worker-2 \
--network cluster-network \
--env CASSANDRA_SEEDS=$CASSANDRA_SEED \
cassandra:3.9 


