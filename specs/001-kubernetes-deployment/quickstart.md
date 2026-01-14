# Quickstart: Local Kubernetes Deployment for Todo AI Chatbot

## Prerequisites

- Docker
- Kubernetes cluster (minikube, kind, or k3s)
- Helm 3
- kubectl

## Quick Deployment

### 1. Clone and Navigate to Repository
```bash
cd hackathon2_todo_phase2/todo_phase4
```

### 2. Build Docker Images
```bash
# Build backend image
cd backend
docker build -t todo-backend:latest .
cd ..

# Build frontend image
cd frontend
docker build -t todo-frontend:latest .
cd ..
```

### 3. Deploy with Helm
```bash
# Navigate to helm directory
cd helm

# Install the chart (replace with your actual encoded values)
helm install todo-ai-chatbot todo-ai-chatbot \
  --set database.url="your_base64_encoded_database_url" \
  --set apiKeys.openaiApiKey="your_base64_encoded_openai_key" \
  --set apiKeys.jwtSecretKey="your_base64_encoded_jwt_secret"
```

### 4. Verify Deployment
```bash
# Check pods
kubectl get pods

# Check services
kubectl get services

# Check deployments
kubectl get deployments
```

### 5. Access the Application
```bash
# Get frontend service details
kubectl get service todo-ai-chatbot-frontend-service

# If using minikube, access directly
minikube service todo-ai-chatbot-frontend-service
```

## Alternative: Deploy with Raw Kubernetes Manifests

```bash
# Apply all manifests
kubectl apply -f k8s/
```

## Useful Commands

```bash
# Check application logs
kubectl logs -l app=backend
kubectl logs -l app=frontend

# Scale deployments
kubectl scale deployment todo-ai-chatbot-backend --replicas=3
kubectl scale deployment todo-ai-chatbot-frontend --replicas=3

# Update deployment with new image
helm upgrade todo-ai-chatbot todo-ai-chatbot [your_values]

# Uninstall
helm uninstall todo-ai-chatbot
```