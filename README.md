# Mahesh D K - Portfolio Website

A modern, responsive portfolio website showcasing cloud and DevOps expertise, containerized and ready for Kubernetes deployment.

## Features

- **Responsive Design**: Works perfectly on desktop, tablet, and mobile devices
- **Modern UI**: Clean, professional design with smooth animations
- **Containerized**: Docker-ready with optimized nginx configuration
- **Kubernetes Ready**: Complete K8s manifests with auto-scaling and health checks
- **Production Ready**: Load balancer, ingress, and SSL termination support

## Technologies Used

- HTML5, CSS3, Vanilla JavaScript
- Docker & nginx
- Kubernetes (Deployment, Service, Ingress, HPA)
- Font Awesome Icons

## Quick Start

### Local Development
```bash
# Run locally
open index.html

# Or with Docker
docker-compose up
# Visit: http://localhost:8080
```

### Docker Build & Run
```bash
# Build image
docker build -t maheshdk4/portfolio .

# Run container
docker run -p 8080:80 maheshdk4/portfolio
```

### Kubernetes Deployment
```bash
# Build and push image
./scripts/build-and-push.sh

# Deploy to Kubernetes
./scripts/deploy.sh

# Check status
kubectl get pods,svc,hpa
```

## Kubernetes Resources

- **Deployment**: 3 replicas with health checks and resource limits
- **Service**: LoadBalancer for external access
- **HPA**: Auto-scaling (3-10 pods) based on CPU/memory
- **Ingress**: SSL termination and custom domain support

## File Structure
```
portfolio/
├── index.html              # Main website
├── styles.css              # Styling
├── script.js               # JavaScript
├── Dockerfile              # Container definition
├── nginx.conf              # Nginx configuration
├── docker-compose.yml      # Local development
├── k8s/                    # Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   └── hpa.yaml
└── scripts/                # Deployment scripts
    ├── build-and-push.sh
    └── deploy.sh
```

## Deployment Options

- **Local**: Open index.html or use docker-compose
- **Docker**: Any container platform (Docker Hub, ECR, ACR)
- **Kubernetes**: EKS, AKS, GKE, or any K8s cluster
- **Cloud**: AWS ECS, Azure Container Instances, Google Cloud Run

## Customization

- Update contact info in `index.html`
- Modify `k8s/ingress.yaml` for your domain
- Adjust resource limits in `k8s/deployment.yaml`
- Change image name in scripts and manifests