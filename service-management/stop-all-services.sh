docker service ls | grep "spark" | cut -d\  -f1 | xargs docker service rm 
docker service rm kafka
docker service ls | grep "cassandra" | cut -d\  -f1 | xargs docker service rm 
