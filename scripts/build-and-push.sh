#!/bin/bash

# Build and push Docker image
IMAGE_NAME="maheshdk4/portfolio"
TAG=${1:-latest}

echo "Building Docker image: ${IMAGE_NAME}:${TAG}"
docker build -t ${IMAGE_NAME}:${TAG} .

echo "Pushing to Docker Hub..."
docker push ${IMAGE_NAME}:${TAG}

echo "Image pushed successfully: ${IMAGE_NAME}:${TAG}"