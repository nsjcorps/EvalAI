#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker pull ubuntu
docker run --name evalai-image -it ubuntu:latest bash
apt-get install lamp-server
exit
docker ps -a