#!/bin/bash
set -e
set -x

DOCKER_USER="your_dockerhub_username"
IMAGE_NAME="tole-payment-app"
IMAGE_TAG="1.0"

echo "Building Docker image: $DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG"

docker build -t $DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG .

echo "Logging in to Docker Hub..."
docker login -u $DOCKER_USER

echo "Pushing image to Docker Hub..."
docker push $DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG

echo "Build and push complete."