# Production Deployment Guide

## Prerequisites

### Cloud Platforms
- **AWS EKS**: Managed Kubernetes service
- **Azure AKS**: Azure Kubernetes Service  
- **Google GKE**: Google Kubernetes Engine
- **DigitalOcean**: Managed Kubernetes

### Required Components
- Kubernetes cluster (1.20+)
- nginx-ingress-controller
- cert-manager (for SSL)
- Docker registry access

## Production Features

✅ **Security Hardened**
- Non-root containers
- Read-only filesystem
- Security contexts
- Network policies
- Security headers

✅ **High Availability**
- 3 replica minimum
- Auto-scaling (3-10 pods)
- Health checks
- Resource limits

✅ **Production Ready**
- Namespace isolation
- SSL termination
- Load balancing
- Monitoring ready

## Deployment Steps

### 1. Build & Push Image
```bash
# Login to Docker Hub
docker login

# Build and push
./scripts/build-and-push.sh
```

### 2. Deploy to Kubernetes
```bash
# Deploy all resources
./scripts/deploy.sh

# Check status
kubectl get all -n portfolio
```

### 3. Configure Domain (Optional)
```bash
# Update ingress with your domain
kubectl edit ingress portfolio-ingress -n portfolio

# Get external IP
kubectl get svc -n ingress-nginx
```

## Monitoring & Maintenance

```bash
# Check pods
kubectl get pods -n portfolio

# View logs
kubectl logs -f deployment/portfolio-app -n portfolio

# Scale manually
kubectl scale deployment portfolio-app --replicas=5 -n portfolio

# Update image
kubectl set image deployment/portfolio-app portfolio=maheshdk4/portfolio:v2 -n portfolio
```

## Cost Optimization

- **Resource Requests**: 50m CPU, 64Mi RAM per pod
- **Auto-scaling**: Scales down to 3 pods when idle
- **Static Content**: Cached for 1 year
- **Lightweight**: nginx alpine base (5MB image)

## Security Best Practices

- Containers run as non-root user
- Network policies restrict traffic
- Security headers enabled
- SSL/TLS termination
- Regular image updates