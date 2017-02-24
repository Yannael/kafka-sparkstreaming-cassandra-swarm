## Service management

This directory contains scripts to start Kakfa, Spark and Cassandra services. 

* `start-kafka-service.sh` : Starts a service running a Zookeeper server and a Kafka server, with one replica constrained tu run on the master node.
* `start-spark-services.sh` : Starts (i) a service running the master role for Spark standalone cluster, with one replica constrained tu run on the master node and (ii) a service running the worker roles for Spark standalone cluster, with two replicas constrained tu run on the worker nodes.
* `start-cassandra-services.sh` : Starts three services running the Cassandra, with one replica each, and constrained to run on each node (master, worker-1 and worker-2). The service running on the master node is configured to be the seed node for the Cassandra ring. 

All services may be started or stopped using the `start-all-services.sh` and `stop-all-services.sh`, respectively.

See [How services work](https://docs.docker.com/engine/swarm/how-swarm-mode-works/services/) and [Docker service create](https://docs.docker.com/engine/reference/commandline/service_create/) on Docker website for further information on options available (such as limiting CPU and memory usage, sharing volumes, etc, ...).

