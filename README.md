# Todo AI Chatbot - Kubernetes Deployment

This project includes Dockerfiles and Kubernetes manifests for deploying the Todo AI Chatbot application with local Kubernetes.

## Prerequisites

- Docker
- Kubernetes cluster (e.g., minikube, kind, or k3s)
- Helm 3

## Build Docker Images

First, build the Docker images for both applications:

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

If using a local Kubernetes cluster like minikube, load the images into the cluster:

```bash
# For minikube
minikube image load todo-backend:latest
minikube image load todo-frontend:latest
```

## Deploy with Helm

1. Navigate to the helm directory:
```bash
cd helm
```

2. Install the chart with your configuration:
```bash
helm install todo-ai-chatbot todo-ai-chatbot \
  --set database.url="your_encoded_database_url_here" \
  --set apiKeys.openaiApiKey="your_encoded_openai_api_key_here" \
  --set apiKeys.jwtSecretKey="your_encoded_jwt_secret_key_here"
```

Alternatively, create a custom values file:
```bash
# Create custom-values.yaml
helm install todo-ai-chatbot todo-ai-chatbot -f custom-values.yaml
```

## Deploy with Raw Kubernetes Manifests

If you prefer to use raw Kubernetes manifests instead of Helm:

1. Encode your secrets in base64:
```bash
echo -n "your_database_url_here" | base64
echo -n "your_openai_api_key_here" | base64
echo -n "your_jwt_secret_key_here" | base64
```

2. Update the `k8s/configmaps-secrets.yaml` file with your base64-encoded values.

3. Apply the manifests:
```bash
kubectl apply -f k8s/
```

## Access the Application

- If using NodePort: Find the NodePort assigned to the frontend service:
```bash
kubectl get service todo-ai-chatbot-frontend-service
```

- If using a local cluster like minikube, you can access the service directly:
```bash
minikube service todo-ai-chatbot-frontend-service
```

## Useful Commands

- Check deployment status:
```bash
kubectl get pods
kubectl get services
kubectl get deployments
```

- View logs:
```bash
kubectl logs -l app=backend
kubectl logs -l app=frontend
```

- Update deployment with new image:
```bash
# After building new image
helm upgrade todo-ai-chatbot todo-ai-chatbot [your_values]
```

## Configuration

The application can be configured through the Helm values.yaml file or by setting environment variables directly in the Kubernetes manifests.

## Security Notes

- Never commit actual secrets to version control
- Use Kubernetes secrets for sensitive data like API keys and database URLs
- Ensure proper RBAC policies are in place in production