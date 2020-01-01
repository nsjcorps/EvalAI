#!/bin/bash
export COMMIT_ID=$(git rev-parse HEAD)

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker pull ubuntu
docker images
docker build -t ndujay/evalai-image:${COMMIT_ID} .
docker tag ndujay/evalai-image:${COMMIT_ID} ndujay/evalai-image:latest
docker push nsjcorps/evalai-image