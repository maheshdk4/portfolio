#!/bin/bash

set -e

TERRAFORM_DIR="terraform"
ACTION=${1:-apply}

echo "🚀 Terraform Portfolio Deployment"
echo "Action: $ACTION"

cd $TERRAFORM_DIR

case $ACTION in
  "init")
    echo "Initializing Terraform..."
    terraform init
    ;;
  "plan")
    echo "Planning Terraform deployment..."
    terraform plan
    ;;
  "apply")
    echo "Applying Terraform configuration..."
    terraform init -upgrade
    terraform plan
    terraform apply -auto-approve
    echo "✅ Deployment complete!"
    terraform output
    ;;
  "destroy")
    echo "Destroying Terraform resources..."
    terraform destroy -auto-approve
    echo "✅ Resources destroyed!"
    ;;
  *)
    echo "Usage: $0 [init|plan|apply|destroy]"
    exit 1
    ;;
esac