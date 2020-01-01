#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker pull ubuntu
docker pull ndujay/evalai-image
docker images
docker push nsjcorps/test-lamp-server