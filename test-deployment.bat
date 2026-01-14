@echo off
REM test-deployment.bat - Script to test the Kubernetes deployment locally on Windows

echo Starting local Kubernetes deployment test...

REM Check if kubectl is available
kubectl version >nul 2>&1
if %errorlevel% neq 0 (
    echo kubectl is required but not installed. Please install kubectl and try again.
    exit /b 1
)

REM Check if Helm is available
helm version >nul 2>&1
if %errorlevel% neq 0 (
    echo Helm is required but not installed. Please install Helm 3 and try again.
    exit /b 1
)

echo Checking for local Kubernetes cluster...
kubectl cluster-info

echo Creating a namespace for the deployment...
kubectl create namespace todo-ai-chatbot --dry-run=client -o yaml ^| kubectl apply -f -

echo Deploying the Todo AI Chatbot application...

REM Build Docker images
echo Building Docker images...
cd backend
docker build -t todo-backend:latest .
if %errorlevel% neq 0 (
    echo Failed to build backend image
    exit /b 1
)
cd ..

cd frontend
docker build -t todo-frontend:latest .
if %errorlevel% neq 0 (
    echo Failed to build frontend image
    exit /b 1
)
cd ..

echo Installing Helm chart...
helm install todo-ai-chatbot ./helm/todo-ai-chatbot ^
  --namespace todo-ai-chatbot ^
  --set backend.image.tag=latest ^
  --set frontend.image.tag=latest ^
  --set database.url=%BASE64_ENCODED_DB_URL% ^
  --set apiKeys.openaiApiKey=%BASE64_ENCODED_OPENAI_KEY% ^
  --set apiKeys.jwtSecretKey=%BASE64_ENCODED_JWT_SECRET%

echo Waiting for deployments to be ready...
kubectl wait --for=condition=ready pod -l app=backend -n todo-ai-chatbot --timeout=300s
kubectl wait --for=condition=ready pod -l app=frontend -n todo-ai-chatbot --timeout=300s

echo Deployment completed! Checking services...
kubectl get services -n todo-ai-chatbot

echo Checking pods...
kubectl get pods -n todo-ai-chatbot

echo To access the application, run:
echo kubectl get service todo-ai-chatbot-frontend-service -n todo-ai-chatbot

echo Deployment test completed successfully!