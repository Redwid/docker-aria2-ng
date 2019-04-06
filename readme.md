build:
docker build -t redwid/aria2-ng .

remove all:
docker system prune -a

run:
docker run -d -p 80:6800 redwid/aria2-ng

list all:
docker container ls --all

bash for container:
docker exec -it {container_id} /bin/bash

container logs:
docker logs {container_id}

list ports:
sudo lsof -n -i -P | grep ':80'
