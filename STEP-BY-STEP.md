# Step-by-Step Tutorial: From Zero to Production

## 🎯 Goal
Deploy your portfolio website to the cloud using modern DevOps practices.

## Phase 1: Understanding What You Have (30 minutes)

### Step 1: Explore Your Files
```bash
# Navigate to your project
cd /Users/maheshdk/Desktop/portfolio

# See all files
ls -la

# Look at the structure
tree . (or use 'find . -type f' if tree isn't installed)
```

**What each file does:**
- `index.html` - Your website (open in browser to see)
- `styles.css` - Makes it look pretty
- `script.js` - Interactive features
- `Dockerfile` - Recipe to package your app
- `k8s/` - Kubernetes deployment files
- `terraform/` - Infrastructure automation

### Step 2: View Your Website Locally
```bash
# Simple way - just open in browser
open index.html

# Or start a simple web server
python3 -m http.server 8000
# Visit: http://localhost:8000
```

## Phase 2: Docker Basics (1 hour)

### Step 3: Install Docker
1. Download Docker Desktop from docker.com
2. Install and start it
3. Verify installation:
```bash
docker --version
docker run hello-world
```

### Step 4: Build Your Container
```bash
# Build your portfolio as a Docker image
docker build -t my-portfolio .

# See your image
docker images

# Run your container
docker run -p 8080:80 my-portfolio

# Visit: http://localhost:8080
# Press Ctrl+C to stop
```

**What happened?**
- Docker read your `Dockerfile`
- Created a container with nginx web server
- Copied your website files into it
- Started the web server on port 80
- Mapped it to your computer's port 8080

### Step 5: Use Docker Compose (Easier)
```bash
# Start with one command
docker-compose up

# Stop with Ctrl+C, or in another terminal:
docker-compose down
```

## Phase 3: Push to Docker Hub (30 minutes)

### Step 6: Create Docker Hub Account
1. Go to hub.docker.com
2. Create free account
3. Create repository named "portfolio"

### Step 7: Push Your Image
```bash
# Login to Docker Hub
docker login

# Tag your image (replace 'yourusername')
docker tag my-portfolio yourusername/portfolio:latest

# Push to Docker Hub
docker push yourusername/portfolio:latest

# Update the image name in k8s/deployment.yaml and terraform files
```

## Phase 4: Local Kubernetes (2 hours)

### Step 8: Enable Kubernetes in Docker Desktop
1. Open Docker Desktop settings
2. Go to Kubernetes tab
3. Check "Enable Kubernetes"
4. Click "Apply & Restart"

### Step 9: Deploy to Local Kubernetes
```bash
# Check kubectl works
kubectl get nodes

# Deploy your app
kubectl apply -f k8s/

# Check status
kubectl get all -n portfolio

# Get service URL (for LoadBalancer, might be localhost)
kubectl get svc -n portfolio
```

### Step 10: Access Your App
```bash
# If using LoadBalancer locally, try:
kubectl port-forward svc/portfolio-service 8080:80 -n portfolio

# Visit: http://localhost:8080
```

## Phase 5: Cloud Deployment (3 hours)

### Step 11: Choose Your Cloud
**Option A: AWS (Most Popular)**
- Create AWS free tier account
- Install AWS CLI: `brew install awscli`
- Configure: `aws configure`

**Option B: Google Cloud (Easiest)**
- Create GCP free tier account
- Install gcloud CLI
- Enable GKE API

**Option C: Azure (Enterprise)**
- Create Azure free account
- Install Azure CLI
- Enable AKS

### Step 12: Create Kubernetes Cluster

**AWS EKS:**
```bash
# Using our Terraform (easiest)
cd terraform/aws
terraform init
terraform apply

# Update kubeconfig
aws eks update-kubeconfig --region us-west-2 --name portfolio-cluster
```

**Google GKE (Alternative):**
```bash
# Create cluster
gcloud container clusters create portfolio-cluster \
  --zone us-central1-a \
  --num-nodes 2 \
  --machine-type e2-small

# Get credentials
gcloud container clusters get-credentials portfolio-cluster --zone us-central1-a
```

### Step 13: Deploy with Terraform
```bash
# Go back to main terraform directory
cd ../

# Copy example variables
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
nano terraform.tfvars

# Deploy
terraform init
terraform apply
```

### Step 14: Get Your Website URL
```bash
# Check ingress (might take 5-10 minutes)
kubectl get ingress -n portfolio

# Or get LoadBalancer IP
kubectl get svc -n portfolio

# Your website should be accessible at the external IP
```

## Phase 6: Custom Domain (Optional - 1 hour)

### Step 15: Buy Domain
- Use Namecheap, GoDaddy, or Route53
- Cost: ~$12/year

### Step 16: Configure DNS
```bash
# Get your LoadBalancer IP
kubectl get svc -n portfolio

# In your domain registrar:
# Create A record: portfolio.yourdomain.com -> YOUR_IP
```

### Step 17: Enable SSL
```bash
# Install cert-manager (for free SSL certificates)
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml

# Update terraform.tfvars with your domain
# Re-run terraform apply
```

## 🎉 Congratulations!

You now have:
- ✅ Professional portfolio website
- ✅ Containerized with Docker
- ✅ Running on Kubernetes
- ✅ Auto-scaling and load balanced
- ✅ SSL certificate
- ✅ Infrastructure as Code

## 🔧 Daily Operations

### Check Status
```bash
kubectl get all -n portfolio
```

### View Logs
```bash
kubectl logs -f deployment/portfolio-app -n portfolio
```

### Update Website
```bash
# 1. Update your HTML/CSS files
# 2. Build new image
docker build -t yourusername/portfolio:v2 .
docker push yourusername/portfolio:v2

# 3. Update Kubernetes
kubectl set image deployment/portfolio-app portfolio=yourusername/portfolio:v2 -n portfolio
```

### Scale Up/Down
```bash
kubectl scale deployment portfolio-app --replicas=5 -n portfolio
```

## 💰 Cost Management

### Monitor Costs
- AWS: CloudWatch billing alerts
- GCP: Billing budgets
- Azure: Cost management

### Optimize
```bash
# Scale down when not needed
kubectl scale deployment portfolio-app --replicas=1 -n portfolio

# Or destroy everything
terraform destroy
```

## 🚨 Troubleshooting

### Common Issues
1. **Pods not starting**: Check `kubectl describe pod <pod-name> -n portfolio`
2. **Can't access website**: Check `kubectl get svc -n portfolio`
3. **SSL not working**: Wait 10-15 minutes for certificate
4. **High costs**: Check resource requests in deployment.yaml

### Get Help
```bash
# Describe resources for details
kubectl describe deployment portfolio-app -n portfolio
kubectl describe pod <pod-name> -n portfolio

# Check events
kubectl get events -n portfolio --sort-by='.lastTimestamp'
```

This step-by-step guide takes you from beginner to having a production-ready cloud application! 🚀