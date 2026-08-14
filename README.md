# Application Discovery Agent for GitHub Copilot

This repository contains a reusable GitHub Copilot custom-agent scaffold for reverse engineering an existing application.

## What it produces

The agent creates evidence-backed Markdown covering:

1. Application overview
2. Business domains and capabilities
3. High-level architecture
4. Technology stack
5. Non-functional characteristics
6. Database structures
7. External integrations
8. Evidence index

## Design principles

The agent follows:

`Repository -> Evidence -> Findings -> Classification -> Confidence -> Documentation`

It distinguishes:

- Observed
- Inferred
- Unknown
- Conflicting

and confidence:

- High
- Medium
- Low
- Unknown

## Installation

Copy the `.github`, `scripts`, and `discovery` directories into the target application repository.

Ensure the validation script is executable:

```bash
chmod +x scripts/validate-discovery.sh
```

## First invocation

In GitHub Copilot, invoke the `application-discovery` agent and start with:

```text
Use the application-discovery agent.

Perform Phase 1 only.

Analyze this repository and create a repository map.

Do not create the final discovery documentation yet.

Identify:
- applications
- services
- modules
- languages
- frameworks
- build systems
- databases
- messaging
- APIs
- external integrations
- deployment/infrastructure
- important configuration
- important tests

For every major finding provide evidence using repository-relative paths.

Do not infer business capabilities yet.

At the end, provide:
1. repository map
2. high-value artifacts identified
3. areas requiring deeper analysis
4. unknowns
5. conflicting evidence
```

## Recommended evolution

The next version should add a machine-readable discovery evidence model so that business, architecture, database, integration, and NFR discovery all contribute to a shared intermediate representation.

That model can later become the foundation for a larger modernization pipeline:

`Legacy Application -> Discovery -> Business Model -> Target Architecture -> Reimagined Application`
