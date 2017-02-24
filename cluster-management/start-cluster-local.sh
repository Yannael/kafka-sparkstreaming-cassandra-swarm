
#Create master node (named master)
export MASTER_MACHINE_NAME=master
docker-machine create --driver virtualbox $MASTER_MACHINE_NAME 

# Make the node the Swarm master, and gives it master label
export MASTER_IP=$(docker-machine ip $MASTER_MACHINE_NAME)
docker-machine ssh $MASTER_MACHINE_NAME docker swarm init --advertise-addr $MASTER_IP
docker-machine ssh $MASTER_MACHINE_NAME docker node update --label-add role=master master

# get token that we will use to add workers to the Swarm
export TOKEN=$(docker-machine ssh $MASTER_MACHINE_NAME docker swarm join-token worker -q)

#Create worker nodes (named them worker-x) and gives them worker label
export NUM_WORKERS=2
export WORKER_MACHINE_NAME=worker-
for INDEX in $(seq $NUM_WORKERS)
do
    (
        docker-machine create --driver virtualbox $WORKER_MACHINE_NAME$INDEX
        docker-machine ssh $WORKER_MACHINE_NAME$INDEX docker swarm join --token $TOKEN $MASTER_IP:2377
        docker-machine ssh $MASTER_MACHINE_NAME docker node update --label-add role=worker $WORKER_MACHINE_NAME$INDEX
    ) &
done
wait

#Create overlay network
docker-machine ssh $MASTER_MACHINE_NAME docker network create --attachable --driver overlay cluster-network
