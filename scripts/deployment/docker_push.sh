#!/bin/bash
export COMMIT_ID=$(git rev-parse HEAD)

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker images
aws configure set default.region us-east-1
eval $(aws ecr get-login --no-include-email)
echo "Pulling ssl certificates and nginx configuration..."
aws s3 cp s3://cloudcv-secrets/evalai/staging/ssl/ ./ssl/ --recursive
aws s3 cp s3://cloudcv-secrets/evalai/staging/nginx_staging.conf ./docker/prod/nodejs/nginx_staging.conf
echo "Pulled ssl certificates and nginx configuration successfully"
docker-compose -f docker-compose-staging.yml build
docker-compose -f docker-compose-staging.yml push

# Get already built docker images
images=$(cat docker-compose-staging.yml | grep 'image: ' | cut -d':' -f 2 | tr -d '"')

# Tag & push images with latest tag
for image in $images
do
    eval image=${image}
    docker tag ${image}:${COMMIT_ID} ${image}:latest
    docker push ${image}:latest
done