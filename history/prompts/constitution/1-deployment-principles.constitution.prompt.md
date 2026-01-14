---
id: 1
title: deployment-principles
stage: constitution
date: 2026-01-05
surface: agent
model: claude-sonnet-4-5-20250929
feature: none
branch: 003-multi-user-todo
user: WWW.SZLAIWIIT.COM
command: sp.constitution
labels: [constitution, deployment, kubernetes]
links:
  spec: null
  ticket: null
  adr: null
  pr: null
files:
 - .specify/memory/constitution.md
tests:
 - none
---

## Prompt

Create Phase IV deployment principles focused on:
1. Container best practices - minimal image sizes, security scanning, multi-stage builds
2. Kubernetes standards - proper resource limits, health checks, rolling updates
3. Environment parity - containers must match local Python 3.11.9 and Node 20 environments
4. Secrets management - never hardcode credentials, use K8s secrets and configmaps
5. Observability - containers must log to stdout/stderr for K8s log aggregation
6. Stateless design - backend must remain stateless, all state in Neon DB
7. Network security - proper service-to-service communication within cluster

## Response snapshot

I have successfully updated the constitution file with Phase IV deployment principles focused on the specific requirements you mentioned. The updated constitution now includes:

1. **Container Best Practices**: All container images must follow security and efficiency best practices: use minimal base images (python:3.11.9-slim, node:20-alpine), implement multi-stage builds to reduce attack surface, include security scanning in CI/CD pipelines, and maintain minimal package installations to reduce vulnerabilities.

2. **Kubernetes Standards**: All Kubernetes deployments must adhere to platform standards: define proper resource limits and requests, implement health checks (liveness and readiness probes), configure rolling updates for zero-downtime deployments, and follow proper labeling conventions for observability.

3. **Environment Parity**: Containerized environments must exactly match local development environments: Python 3.11.9 for backend services and Node 20 for frontend services, identical dependency versions, and consistent runtime configurations across all environments to eliminate "works on my machine" issues.

4. **Secrets Management**: Sensitive data must never be hardcoded in containers or configuration files: use Kubernetes secrets for API keys and database credentials, implement proper secret injection mechanisms, utilize ConfigMaps for non-sensitive configuration, and ensure no credentials are stored in container images.

5. **Observability**: All containers must output logs to stdout/stderr for Kubernetes native log aggregation: structured logging format with appropriate log levels, proper error reporting, metrics collection endpoints, and integration with cluster monitoring systems for effective troubleshooting.

6. **Stateless Design**: All backend services must remain stateless with all persistent state stored in Neon PostgreSQL database: no local file storage, session data stored in database or external cache, horizontal scaling capability without data affinity, and proper initialization on container startup.

7. **Network Security**: All service-to-service communication must occur within the Kubernetes cluster using internal service discovery: secure internal networking, proper service isolation, encrypted communication where required, and minimal network policies for enhanced security.

## Outcome

- ✅ Impact: Updated constitution with 7 specific deployment principles for Phase IV
- 🧪 Tests: No tests required for constitution update
- 📁 Files: Updated .specify/memory/constitution.md with new deployment principles
- 🔁 Next prompts: Ready for Phase IV implementation following these principles
- 🧠 Reflection: Constitution now properly defines the standards for Kubernetes deployment

## Evaluation notes (flywheel)

- Failure modes observed: None
- Graders run and results (PASS/FAIL): PASS - All principles properly implemented
- Prompt variant (if applicable): Standard constitution update
- Next experiment (smallest change to try): Implement Phase IV following these principles