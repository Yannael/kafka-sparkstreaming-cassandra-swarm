docker-machine ls | grep "^master" | cut -d\  -f1 | xargs docker-machine rm --force
docker-machine ls | grep "^worker" | cut -d\  -f1 | xargs docker-machine rm --force

