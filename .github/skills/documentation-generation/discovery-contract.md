# Application Discovery Contract

## Purpose

The Discovery Agent reverse engineers an existing software application and produces an evidence-backed representation of its purpose, business capabilities, architecture, technology stack, non-functional characteristics, data structures, and external integrations.

## Evidence classification

### Observed
Directly supported by source code, configuration, schema, infrastructure, tests, or dependency metadata.

### Inferred
Not explicitly documented but strongly supported by multiple artifacts.

### Unknown
Insufficient repository evidence exists.

### Conflicting
Multiple artifacts provide contradictory evidence.

## Confidence

- High: directly observed.
- Medium: strong inference from multiple artifacts.
- Low: plausible interpretation with limited evidence.
- Unknown: insufficient evidence.

## Rules

1. Never invent facts.
2. Every important conclusion must have evidence.
3. Never infer a business capability from package naming alone.
4. Never infer a database relationship from column names alone.
5. Do not treat configuration as proof of an active integration without code correlation.
6. Never infer an NFR guarantee without evidence.
7. Never copy secrets.
8. Preserve application source.

## Required finding shape

Each important finding should contain:

- Finding
- Classification
- Confidence
- Evidence
- Rationale where inferred
- Open question where unresolved

## Required documents

- `01-application-overview.md`
- `02-business-domains.md`
- `03-architecture.md`
- `04-technology-stack.md`
- `05-non-functional-characteristics.md`
- `06-database.md`
- `07-external-integrations.md`
- `08-evidence-index.md`
