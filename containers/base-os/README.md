## base-os 

The container is a basis for all other containers. It is a centos7 container to which were added

* Java 1.8
* Some basic packages which I find useful (nano, nettools, ssh, ...)
* a password for root user

Built with

```
docker build -t yannael/base-os .
```

Available on Dockerhub at https://hub.docker.com/r/yannael/base-os/

```
docker pull yannael/base-os
```

Size: 863MB.

