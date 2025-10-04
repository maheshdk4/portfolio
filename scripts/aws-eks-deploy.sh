#!/bin/bash

set -e

echo "🚀 AWS EKS Portfolio Deployment"

# Deploy EKS cluster
echo "1. Creating EKS cluster..."
cd terraform/aws
terraform init
terraform apply -auto-approve

# Update kubeconfig
echo "2. Updating kubeconfig..."
aws eks update-kubeconfig --region us-west-2 --name portfolio-cluster

# Deploy application
echo "3. Deploying portfolio application..."
cd ../
terraform init
terraform apply -auto-approve

echo "✅ EKS deployment complete!"
echo "Cluster: $(terraform -chdir=aws output -raw cluster_name)"
echo "Endpoint: $(terraform -chdir=aws output -raw cluster_endpoint)"