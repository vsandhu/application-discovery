---
name: technology-discovery
description: Extracts the application's technology stack, dependencies, versions, infrastructure, build systems, deployment technologies, messaging, databases, and observability technologies from repository evidence.
---

# Technology Discovery

## Primary evidence

Use:
- dependency manifests
- lock files
- build files
- Dockerfiles
- deployment manifests
- infrastructure definitions
- configuration

## Identify

### Languages
- Java
- C#
- JavaScript/TypeScript
- Python
- Go
- C/C++
- SQL
- other languages

### Frameworks
Identify framework and version only when supported.

### Libraries
Prioritize significant runtime and integration libraries.

### Data
Identify database technologies and drivers.

### Messaging
Identify Kafka, RabbitMQ, JMS, MQ, etc.

### Infrastructure
Identify containers, Kubernetes, cloud services, VMs, serverless, etc.

### Build and delivery
Identify Maven, Gradle, npm, CI/CD, etc.

### Observability
Identify logging, metrics, tracing, monitoring.

## Rules

Never invent a version.

If version cannot be established:

`Version: Not determinable from repository`

Do not treat an unused dependency as proof of runtime usage without corroborating evidence.
