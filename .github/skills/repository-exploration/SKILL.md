---
name: repository-exploration
description: Maps an unfamiliar software repository before deeper application discovery. Use to identify applications, modules, technologies, APIs, databases, messaging, infrastructure, configuration, and tests.
---

# Repository Exploration

Build a high-value repository map before detailed reasoning.

## Analyze first

- top-level directories
- applications
- services
- modules
- libraries
- database directories
- infrastructure
- deployment
- documentation

## Inspect build metadata

Search for:
- pom.xml
- build.gradle
- package.json
- requirements.txt
- pyproject.toml
- go.mod
- *.csproj
- Cargo.toml

Determine languages, frameworks, major dependencies, and build systems.

## Inspect application structure

Find:
- entry points
- startup/bootstrap classes
- controllers/routes
- handlers
- jobs
- schedulers
- consumers/producers

## Inspect configuration

Find:
- application.yml
- application.yaml
- application.properties
- configuration classes
- environment configuration
- deployment configuration

Do not copy secret values.

## Inspect APIs

Find:
- OpenAPI/Swagger
- controllers
- routes
- GraphQL schemas
- WSDL

## Inspect data

Find:
- migrations
- CREATE TABLE
- ORM entities
- Liquibase
- Flyway
- views
- procedures
- triggers

## Inspect messaging

Find:
- Kafka
- RabbitMQ
- JMS
- MQ
- topic names
- queue names
- event producers
- event consumers

## Inspect infrastructure

Find:
- Dockerfile
- docker-compose
- Kubernetes
- Helm
- Terraform
- CloudFormation

## Inspect tests

Identify:
- unit tests
- integration tests
- contract tests
- end-to-end tests

## Output

Create an internal map containing:

- applications
- services
- modules
- languages
- frameworks
- databases
- messaging
- APIs
- infrastructure
- deployment
- tests
- high-value artifacts
- areas requiring deeper analysis

Do not infer business domains from directory names alone.
