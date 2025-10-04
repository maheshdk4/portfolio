#!/bin/bash

# Deploy to Kubernetes
echo "Deploying portfolio to Kubernetes..."

kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/hpa.yaml
kubectl apply -f k8s/networkpolicy.yaml

echo "Checking deployment status..."
kubectl rollout status deployment/portfolio-app

echo "Getting service info..."
kubectl get services portfolio-service