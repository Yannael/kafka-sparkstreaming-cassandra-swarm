#Start master

export REGION=eu-west-1 
export ZONE=c 
export MASTER_TYPE=m3.medium
export AMI=ami-3ffca759 #Ubuntu 14.04 official

export DRIVER_OPTIONS="\
--driver amazonec2 \
--amazonec2-ami $AMI \
--amazonec2-security-group=default \
--amazonec2-zone $ZONE \
--amazonec2-region $REGION"

export MASTER_OPTIONS="$DRIVER_OPTIONS \
--amazonec2-instance-type=$MASTER_TYPE"

export MACHINE_NAME=master
docker-machine create $MASTER_OPTIONS $MACHINE_NAME

eval $(docker-machine env master)

# get private ip of the master machine, you need a jq utility json parser
export MASTER_IP=$(aws ec2 describe-instances --output json | jq -r  ".Reservations[].Instances[] | select(.KeyName==\"$MACHINE_NAME\" and .State.Name==\"running\") | .PrivateIpAddress")
# init the Swarm master
docker-machine ssh $MACHINE_NAME sudo gpasswd -a ubuntu docker

docker-machine ssh $MACHINE_NAME sudo service docker restart

docker-machine ssh $MACHINE_NAME docker swarm init --advertise-addr $MASTER_IP

docker-machine ssh $MACHINE_NAME docker node update --label-add role=master $MACHINE_NAME
# get token that we will use to add workers to the Swarm

export TOKEN=$(docker-machine ssh $MACHINE_NAME sudo docker swarm join-token worker -q)

#Start workers

export WORKER_TYPE=m3.medium
export SPOT_PRICE=0.067
export NUM_WORKERS=2
export WORKER_OPTIONS="$DRIVER_OPTIONS \
--amazonec2-request-spot-instance \
--amazonec2-spot-price=$SPOT_PRICE \
--amazonec2-instance-type=$WORKER_TYPE"
export MACHINE_NAME=worker-

for INDEX in $(seq $NUM_WORKERS)
do
    (
        docker-machine create $WORKER_OPTIONS $MACHINE_NAME$INDEX
        docker-machine ssh $MACHINE_NAME$INDEX  sudo gpasswd -a ubuntu docker 
        docker-machine ssh $MACHINE_NAME$INDEX  sudo service docker restart
        docker-machine ssh $MACHINE_NAME$INDEX docker swarm join --token $TOKEN $MASTER_IP:2377
        docker-machine ssh master  docker node update --label-add role=worker $MACHINE_NAME$INDEX
    ) &
done
wait

#Create overlay network
docker-machine ssh master docker network create --attachable --driver overlay cluster-network

