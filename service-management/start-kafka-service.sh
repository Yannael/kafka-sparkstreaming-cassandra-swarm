#Service kafka: one instance, used for Kafka server
docker service create \
--name kafka \
--constraint node.hostname==master \
--replicas 1 \
--network cluster-network \
yannael/kafka \
/usr/bin/startup_script.sh
