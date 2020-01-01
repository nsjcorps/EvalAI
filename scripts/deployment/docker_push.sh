#!/bin/bash
export COMMIT_ID=$(git rev-parse HEAD)

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker pull ubuntu
docker pull ndujay/evalai-image
docker images
docker build -t ndujay/evalai-image:${COMMIT_ID} .
docker push nsjcorps/test-lamp-server