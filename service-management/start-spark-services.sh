#Service Master: One instance, used for Spark standalone cluster master
eval $(docker-machine env master)

docker service create \
--name spark-master \
--replicas 1 \
--constraint node.hostname==master \
--network cluster-network \
-p 8080:8080 \
yannael/spark \
/root/spark/bin/spark-class org.apache.spark.deploy.master.Master --host 0.0.0.0

while [[ -z $(docker service ls |grep spark-master| grep 1/1) ]]; do 
	Echo Waiting for spark master service to start...
	sleep 5 
	done;


#Service worker: $NUM_WORKERS instances, used for Spark standalone cluster workers
export NUM_WORKERS=2
docker service create \
--name spark-worker \
--constraint node.hostname!=master \
--replicas $NUM_WORKERS \
--network cluster-network \
yannael/spark \
/root/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://spark-master:7077

