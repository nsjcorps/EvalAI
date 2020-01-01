#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker tag local-image:evalai-image evalai-image:evalai-image
docker push ndujay/evalai-image:evalai-image