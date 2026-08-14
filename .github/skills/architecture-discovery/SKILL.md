---
name: architecture-discovery
description: Reconstructs application architecture, components, interactions, runtime flows, deployment topology, and architectural characteristics from repository evidence.
---

# Architecture Discovery

## Objective

Build an evidence-backed architectural view.

## Analyze

- entry points
- APIs
- application services
- domain services
- repositories
- persistence
- messaging
- external clients
- schedulers
- batch processes
- shared libraries
- infrastructure
- deployment descriptors

## Determine

- architectural style
- major components
- component responsibilities
- dependencies
- synchronous flows
- asynchronous flows
- data flows
- runtime topology
- deployment topology where supported

## Distinguish

Observed architecture:
Directly established.

Inferred architecture:
Strongly supported interpretation.

Unknown:
Not determinable from repository.

## Diagrams

Use Mermaid where useful.

Recommended:
- system context
- container/component view
- major runtime flow
- integration landscape

Do not create diagrams that contain unsupported components.

## Output

For each component record:
- name
- responsibility
- technology
- dependencies
- communication
- evidence
- confidence

Include architecture open questions.
