#!/bin/bash
# test-deployment.sh - Script to test the Kubernetes deployment locally

set -e

echo "Starting local Kubernetes deployment test..."

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "kubectl is required but not installed. Please install kubectl and try again."
    exit 1
fi

# Check if Helm is available
if ! command -v helm &> /dev/null; then
    echo "Helm is required but not installed. Please install Helm 3 and try again."
    exit 1
fi

echo "Checking for local Kubernetes cluster..."
kubectl cluster-info

echo "Creating a namespace for the deployment..."
kubectl create namespace todo-ai-chatbot --dry-run=client -o yaml | kubectl apply -f -

echo "Deploying the Todo AI Chatbot application..."

# Build Docker images (assuming Docker is available)
echo "Building Docker images..."
cd backend
docker build -t todo-backend:latest . || { echo "Failed to build backend image"; exit 1; }
cd ..

cd frontend
docker build -t todo-frontend:latest . || { echo "Failed to build frontend image"; exit 1; }
cd ..

echo "Installing Helm chart..."
helm install todo-ai-chatbot ./helm/todo-ai-chatbot \
  --namespace todo-ai-chatbot \
  --set backend.image.tag=latest \
  --set frontend.image.tag=latest \
  --set database.url=$(echo -n "postgresql://user:password@neon-db-host:5432/todo_db" | base64 -w 0) \
  --set apiKeys.openaiApiKey=$(echo -n "your-test-openai-key" | base64 -w 0) \
  --set apiKeys.jwtSecretKey=$(echo -n "your-test-jwt-secret" | base64 -w 0)

echo "Waiting for deployments to be ready..."
kubectl wait --for=condition=ready pod -l app=backend -n todo-ai-chatbot --timeout=300s
kubectl wait --for=condition=ready pod -l app=frontend -n todo-ai-chatbot --timeout=300s

echo "Deployment completed! Checking services..."
kubectl get services -n todo-ai-chatbot

echo "Checking pods..."
kubectl get pods -n todo-ai-chatbot

echo "To access the application, run:"
echo "kubectl get service todo-ai-chatbot-frontend-service -n todo-ai-chatbot"

echo "Deployment test completed successfully!"