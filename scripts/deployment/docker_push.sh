#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker pull ubuntu
docker run --name test-lamp-server -it ubuntu:latest bash
apt-get update
exit
docker ps -a
docker commit -m "Added LAMP Server" -a "NAME" test-lamp-server nsjcorps/test-lamp-server:latest
docker push nsjcorps/test-lamp-server