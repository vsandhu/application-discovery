---
name: nfr-discovery
description: Infers non-functional characteristics such as scalability, availability, resilience, performance, security, reliability, observability, maintainability, and recoverability from repository evidence.
---

# Non-Functional Characteristics Discovery

## Objective

Identify implementation evidence that indicates how the application behaves operationally.

## Analyze

### Scalability
Look for:
- stateless services
- replicas
- autoscaling
- partitioning
- asynchronous processing
- load balancing

### Availability
Look for:
- replicas
- health checks
- readiness/liveness
- failover
- multi-zone deployment

### Resilience
Look for:
- retry
- timeout
- circuit breaker
- bulkhead
- fallback
- dead-letter handling
- idempotency

### Performance
Look for:
- caching
- batching
- pagination
- async processing
- connection pooling
- database indexes
- parallel processing

### Security
Look for:
- authentication
- authorization
- OAuth2/OIDC
- JWT
- mTLS
- encryption
- secret management
- input validation
- audit logging

### Observability
Look for:
- structured logging
- metrics
- tracing
- correlation IDs
- health endpoints
- monitoring configuration

### Recoverability
Look for:
- backups
- restore procedures
- replay
- recovery jobs
- persistence guarantees

## Language rules

Prefer:

`Repository evidence suggests...`

over:

`The application guarantees...`

unless a documented guarantee exists.

Every NFR finding requires:
- characteristic
- evidence
- classification
- confidence
- limitations
