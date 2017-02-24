## Cluster management

Two scripts are provided, to create a cluster of 3 nodes either locally, with virtual machines, or on AWS. The scripts require either VirtualBox to be installed (VMs), or to have an account on Amazon (AWS). 

See

* [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads) for VirtualBox installation
* [https://aws.amazon.com/getting-started/](https://aws.amazon.com/getting-started/) to get started with AWS.

The scripts mostly follow instructions given on the [https://docs.docker.com/engine/swarm/swarm-tutorial/](Docker Swarm tutorial), to create a manager node and two worker nodes, and from [this blog post](https://medium.com/@aoc/running-spark-on-docker-swarm-777b87b5aa3#.4ahmoqvsf) for creating an AWS docker cluster  

The master node is first created, and its swarm token tag retrieved. Worker nodes are then created and connected to the master node through the token tag.  

### Creation of a cluster of local virtual machines

Use 

```
start-cluster-local.sh
```

to start the cluster. It takes about 5 minutes. 

### Creation of a cluster of AWS instances

Note: Your account on Amazon must be created, your credentials stored in ~/.aws/credentials. See for example [there](https://gist.github.com/ghoranyi/f2970d6ab2408a8a37dbe8d42af4f0a5) for details. 

Use 

```
start-cluster-aws.sh
```

to start the cluster. It takes about 15 minutes. 

