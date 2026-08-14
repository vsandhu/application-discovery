---
name: integration-discovery
description: Identifies external APIs, messaging systems, file exchanges, webhooks, external databases, authentication providers, and other integrations using configuration and application-code evidence.
---

# Integration Discovery

## Identify

- REST
- SOAP
- GraphQL
- Kafka
- RabbitMQ
- JMS
- MQ
- SFTP/FTP
- file exchange
- webhooks
- external databases
- external identity providers
- external platforms

## Evidence

Look for:
- client classes
- HTTP clients
- URLs
- endpoint definitions
- OpenAPI/WSDL
- producer/consumer configuration
- topic/queue names
- scheduled transfers
- file paths
- authentication configuration

## Correlation rule

Configuration alone does not prove active integration.

Classify as:

- Active usage confirmed
- Configured but usage not confirmed
- Historical/unused suspected
- Unknown

## For each integration

Record:
- system
- purpose
- direction
- protocol
- authentication mechanism without exposing secrets
- data exchanged
- invocation mechanism
- error handling
- evidence
- confidence

Never copy secret values.
