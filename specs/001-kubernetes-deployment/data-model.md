# Data Model: Local Kubernetes Deployment for Todo AI Chatbot

## Kubernetes Resources

### Backend Deployment
- **name**: Unique identifier for the deployment
- **replicas**: Number of pod replicas (default: 2)
- **image**: Container image reference
- **ports**: Container port mapping (8000 for backend)
- **env**: Environment variables from secrets and configmaps
- **resources**: CPU and memory requests/limits
- **livenessProbe**: Health check configuration
- **readinessProbe**: Readiness check configuration

### Frontend Deployment
- **name**: Unique identifier for the deployment
- **replicas**: Number of pod replicas (default: 2)
- **image**: Container image reference
- **ports**: Container port mapping (3000 for frontend)
- **env**: Environment variables from configmaps
- **resources**: CPU and memory requests/limits
- **livenessProbe**: Health check configuration
- **readinessProbe**: Readiness check configuration

### Backend Service
- **name**: Service identifier
- **selector**: Labels to match backend pods
- **ports**: Service port configuration (port: 80, targetPort: 8000)
- **type**: Service type (ClusterIP)

### Frontend Service
- **name**: Service identifier
- **selector**: Labels to match frontend pods
- **ports**: Service port configuration (port: 80, targetPort: 3000)
- **type**: Service type (NodePort for external access)

### ConfigMap
- **name**: Configuration map identifier
- **data**: Key-value pairs of configuration data
- **backend-config**: Allowed origins, environment settings
- **frontend-config**: API URL configuration

### Secret
- **name**: Secret identifier
- **data**: Base64 encoded sensitive data
- **database-secret**: Database connection string
- **api-keys-secret**: API keys (OpenAI, etc.)
- **auth-secret**: Authentication secrets (JWT)

## Helm Chart Values

### Backend Configuration
- **image.repository**: Backend image repository
- **image.tag**: Backend image tag
- **image.pullPolicy**: Image pull policy
- **replicaCount**: Number of backend replicas
- **service.port**: Service port
- **service.targetPort**: Target port in container
- **service.type**: Service type
- **resources**: Resource requests and limits
- **config**: Backend-specific configuration

### Frontend Configuration
- **image.repository**: Frontend image repository
- **image.tag**: Frontend image tag
- **image.pullPolicy**: Image pull policy
- **replicaCount**: Number of frontend replicas
- **service.port**: Service port
- **service.targetPort**: Target port in container
- **service.type**: Service type
- **resources**: Resource requests and limits
- **config**: Frontend-specific configuration

### External Dependencies
- **database.url**: Database connection string
- **apiKeys.openaiApiKey**: OpenAI API key
- **apiKeys.jwtSecretKey**: JWT secret key
- **ingress**: Ingress configuration (optional)