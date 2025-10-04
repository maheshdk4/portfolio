# Terraform Infrastructure as Code

This project now includes complete Terraform configurations for deploying the portfolio on Kubernetes with cloud infrastructure.

## 🏗️ Architecture

**Terraform Modules:**
- `main.tf` - Provider configuration
- `namespace.tf` - Kubernetes namespace
- `deployment.tf` - Application deployment
- `service.tf` - Load balancer service
- `hpa.tf` - Auto-scaling configuration
- `ingress.tf` - SSL termination & routing
- `network-policy.tf` - Security policies
- `aws/eks.tf` - AWS EKS cluster (optional)

## 🚀 Quick Deploy

### Option 1: Existing Kubernetes Cluster
```bash
# Configure variables
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
# Edit terraform.tfvars with your values

# Deploy
./scripts/terraform-deploy.sh apply
```

### Option 2: AWS EKS (Full Infrastructure)
```bash
# Deploy EKS + Application
./scripts/aws-eks-deploy.sh
```

## 📋 Prerequisites

**Required Tools:**
- Terraform >= 1.0
- kubectl
- Docker
- AWS CLI (for EKS)

**Required Access:**
- Kubernetes cluster or AWS account
- Docker registry access
- Domain name (optional)

## 🔧 Configuration

### terraform.tfvars
```hcl
kubeconfig_path = "~/.kube/config"
domain_name     = "portfolio.yourdomain.com"
image_tag       = "latest"
aws_region      = "us-west-2"
cluster_name    = "portfolio-cluster"
```

## 📊 Resources Created

**Kubernetes Resources:**
- Namespace: `portfolio`
- Deployment: 3 replicas with security hardening
- Service: LoadBalancer type
- HPA: Auto-scaling 3-10 pods
- Ingress: SSL termination
- NetworkPolicy: Security isolation
- ConfigMap: Nginx configuration

**AWS Resources (EKS option):**
- VPC with public/private subnets
- EKS cluster v1.28
- Managed node group (t3.small)
- Security groups & IAM roles

## 💰 Cost Estimation

**Kubernetes Only:** $0 (existing cluster)
**AWS EKS:** ~$75/month
- EKS cluster: $73/month
- t3.small nodes: $15/month each
- Load balancer: $18/month

## 🛠️ Management Commands

```bash
# Plan changes
./scripts/terraform-deploy.sh plan

# Apply changes
./scripts/terraform-deploy.sh apply

# Destroy resources
./scripts/terraform-deploy.sh destroy

# Check status
kubectl get all -n portfolio
```

## 🔒 Security Features

- Non-root containers
- Read-only filesystem
- Network policies
- Security contexts
- Resource limits
- SSL/TLS termination

## 📈 Monitoring

```bash
# View resources
terraform output

# Check pods
kubectl get pods -n portfolio

# View logs
kubectl logs -f deployment/portfolio-app -n portfolio

# Scale manually
terraform apply -var="replicas=5"
```

This Terraform configuration demonstrates enterprise-grade Infrastructure as Code practices for Kubernetes deployments!