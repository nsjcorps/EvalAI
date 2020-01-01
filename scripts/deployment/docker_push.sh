#!/bin/bash
export COMMIT_ID=$(git rev-parse HEAD)

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker images
docker-compose -f docker-compose-$1.yml build
docker-compose -f docker-compose-$1.yml push

# Get already built docker images
images=$(cat docker-compose-$1.yml | grep 'image: ' | cut -d':' -f 2 | tr -d '"')

# Tag & push images with latest tag
for image in $images
do
    eval image=${image}
    docker tag ${image}:${COMMIT_ID} ${image}:latest
    docker push ${image}:latest
done